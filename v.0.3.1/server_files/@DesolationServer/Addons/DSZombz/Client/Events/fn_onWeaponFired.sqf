params["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];

_badWeapons = ["Throw","Put"];

if !(_weapon in _badWeapons) then {
	_unit setVariable ["DSZ_var_lastSound",diag_tickTime];
};