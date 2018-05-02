params["_buildable"];

_typename = typeof(_buildable) + "2"; 

_loot = [_buildable] call BASE_fnc_getAllCargo;
_dir = getdir _buildable;
_vectorUp = vectorUp _buildable;
_pos = getposatl _buildable; 

_vars = [];
{
	_vars pushback [_x,_buildable getVariable _x,true];
} forEach allVariables _buildable;

deleteVehicle _buildable;

_newBuildable = _typename createVehicle [0,0,0];

_newBuildable setDir _dir;
_newBuildable setPosATL _pos;

{
	_newBuildable setVariable _x;
} forEach _vars;

[_newBuildable,_loot] call BASE_fnc_setAllCargo;


_newBuildable setVectorUp _vectorUp;

[_newBuildable] remoteExec ["DS_fnc_registerDropped",-2];