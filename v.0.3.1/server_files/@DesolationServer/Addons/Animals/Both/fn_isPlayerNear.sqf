params["_group"];
_pos = getPosATL (leader _group);

_count = 0;

_count = {isPlayer _x && alive _x} count (_pos nearEntities ["Man",250]);
if(_count > 0) exitWith {true};

{
	_count = {isPlayer _x && alive _x} count (crew _x);
	if(_count > 0) exitWith {};
} forEach (nearestObjects [_pos,["LandVehicle","Air","Ship"],250]);
if(_count > 0) exitWith {true};

false;