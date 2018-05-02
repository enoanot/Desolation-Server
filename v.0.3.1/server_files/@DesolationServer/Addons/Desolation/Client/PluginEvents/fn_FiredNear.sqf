params["_player","_unit","_distance","_weapon","_muzzle","_mode","_ammo","_gunner"];

if !(alive _player) exitWith {};

[_player] spawn {
	params["_player"];
	_player setVariable ["DS_var_inCombat", true, true];
	sleep 30;
	_player setVariable ["DS_var_inCombat", nil, true];
};


// USAGE: if !(isNil {player getVariable "DS_var_inCombat"}) then {_inCombat = true;};