params["_zed"];

_standardDamage = {
	params["_damagedBy"];
	DS_var_blood = DS_var_blood - (1000 + random(1500));
	
	if(random(1) <= 0.15) then {
		DS_var_damagedBy pushBack _damagedBy;
		_selections = ["spine3","leftforearm","rightforearm","lefthand","righthand","leftupleg","rightupleg","leftleg","rightleg","leftfoot","rightfoot","head","pelvis"];
		[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	};
	addCamShake [5, 1, 50];
	if (random(1) <= 0.3) then {
		addCamShake [0.47, 600, 6.2];
	};
	["DynamicBlur", 400, [2]] spawn {
		params ["_name", "_priority", "_effect", "_handle"];
		while {
			_handle = ppEffectCreate [_name, _priority];
			_handle < 0
		} do {
			_priority = _priority + 1;
		};
		_handle ppEffectEnable true;
		_handle ppEffectAdjust _effect;
		_handle ppEffectCommit 0.1;
		waitUntil {ppEffectCommitted _handle};
		
		_handle ppEffectAdjust [0];
		_handle ppEffectCommit 0.5;
		waitUntil {ppEffectCommitted _handle};
		
		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
	};
};

if(isNil "DSZ_var_zombieAttackOverride") then {
	playSound3D ["a3\sounds_f\characters\human-sfx\P01\Low_hit_" + str(ceil(random(6))) + ".wss",player,false,getPosASL player,1,1,50];
	[_zed] call _standardDamage;
} else {
	[_zed] call (missionNamespace getVariable [DSZ_var_zombieAttackOverride,_standardDamage]);
};