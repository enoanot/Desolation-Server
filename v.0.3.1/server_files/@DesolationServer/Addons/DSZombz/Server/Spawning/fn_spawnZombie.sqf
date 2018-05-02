params["_zHolder","_owner"];

_zIndex = _zHolder getVariable ["zIndex",-1];
if((_zIndex < 0) || (_zIndex >= count(DSZ_var_spawnData))) exitWith {};
_zHolder setVariable ["isSpawned",true];

_zData = DSZ_var_spawnData select _zIndex;

if(count(_zData) == 0) exitWith {diag_log "DSZOMBZ > Error: Attempted to spawn dead zombie";}; 

_class = _zData select 0;
_pos = _zData select 1;
_agroType = _zData select 2;
_locationpos = _zData select 3;
_roamDist = _zData select 4;







_group = createGroup west;
if(isNull _group) then {
	_group = createGroup east;
};
if(isNull _group) then {
	_group = createGroup independent;
};
if(isNull _group) exitWith {
	"DSZOMBZ > FATAL ERROR: NOT ENOUGH GROUPS FOR ZOMBIES";
};

_zombie = _group createUnit [_class, _pos, [], 0, "NONE"];
_zombie enableFatigue false;
_zombie disableAI "TARGET";
_zombie disableAI "AUTOTARGET";
_zombie disableAI "COVER";
_zombie disableAI "AUTOCOMBAT";
[_zombie, "NoVoice"] remoteExecCall ["setSpeaker", 0, true];

_face = face _zombie;
if(_face find "DSR" != 0) then {
	_num = ceil(random(22));
	_face = ("DSR_Face_Zombie_" + (if(_num < 10) then {"0"} else {""}) + str(_num));
};
[_zombie, _face] remoteExec ["setFace", 0, _zombie];

_group setBehaviour "CARELESS";
_group setCombatMode "BLUE";
_zombie forceSpeed (_zombie getSpeed "SLOW");
_zombie setVariable ["MoanDelay",diag_tickTime + (3 + random(3))];


_zombie addMPEventHandler ["MPKilled",{
	params["_zed","_killer"];
	if(local _killer) then {
		if(!isNil "DS_fnc_addPoints") then {
			[1] call DS_fnc_addPoints;
		};
	};
	if(isServer) then {
		_zIndex = _zed getVariable ["zIndex",-1];
		[_zed,_zIndex] spawn DSZ_fnc_killZombie;
	};
}];

_zombie setVariable ["zIndex",_zIndex]; //todo: cehck to see if this is used by clients
_zombie setVariable ["zInformation",[_agroType,_locationpos,_roamDist],true];
DSZ_var_spawnedZeds pushback _zombie;

[_owner,_zombie] call DSZ_fnc_toClient;
[_locationpos,_roamDist,group _zombie] call DSZ_fnc_initRoaming;
