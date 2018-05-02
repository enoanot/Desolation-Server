params["_pos"];
private["_near"];
_near = _pos nearEntities ["Man",250];
{
	_near = _near + (crew _x);
} forEach (nearestObjects [_pos,["LandVehicle","Air","Ship"],250]);
_near;