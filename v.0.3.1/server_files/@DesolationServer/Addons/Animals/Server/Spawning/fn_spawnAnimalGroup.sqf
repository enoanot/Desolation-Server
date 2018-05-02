params ["_animalHolder"];

_animalIndex = _animalHolder getVariable ["animalGroupIndex",-1];
if ((_animalIndex < 0) || (_animalIndex >= count (ANIM_var_spawnData))) exitWith {};
_animalHolder setVariable ["isSpawnedAnimalGroup",true];

_animalData = ANIM_var_spawnData select _animalIndex;

if (count(_animalData) == 0) exitWith {diag_log "ANIMALS > Error: Attempted to spawn dead animal";}; 

_class = _animalData select 0;
_groupSize = _animalData select 1;
_pos = _animalData select 2;

_group = createGroup civilian;
if (isNull _group) exitWith {
	"ANIMALS > FATAL ERROR: NOT ENOUGH GROUPS FOR ANIMALS (CIVILIAN)";
};

_group setVariable ["animalGroupIndex",_animalIndex];

for "_i" from 0 to ((_groupSize) - 1) do {
	_animal = _group createUnit [_class,_pos,[],4,"FORM"];
	_animal spawn BIS_fnc_animalRandomization;
	_animal disableConversation true;
	[_animal, "NoVoice"] remoteExecCall ["setSpeaker", 0, true];

	_animal addMPEventHandler ["MPKilled",{
		params["_animal","_killer"];
		if (local _killer) then {
			if (!isNil "DS_fnc_addPoints") then {
				[1] call DS_fnc_addPoints;
			};
		};
		if (isServer) then {
			[_group] spawn ANIM_fnc_killAnimal;
		};
	}];
};

ANIM_var_spawnedGroups pushback _group;

_group;