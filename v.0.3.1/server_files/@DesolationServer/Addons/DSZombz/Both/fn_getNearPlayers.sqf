params["_pos"];
private["_men","_plrs"];
_men = [_pos] call DSZ_fnc_getNearMen;
_plrs = [];
{
	if(isPlayer _x && alive _x) then {
		_plrs pushback _x;
	};
	true
} count _men;
_plrs;