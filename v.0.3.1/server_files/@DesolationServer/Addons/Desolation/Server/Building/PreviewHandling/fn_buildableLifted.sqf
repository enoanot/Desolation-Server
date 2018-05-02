params["_buildable","_clientObj"];

_typename = typeof(_buildable);
_typename = _typename select [0,count(_typename)-1];

_loot = [_buildable] call BASE_fnc_getAllCargo;
_dir = getdir _buildable;
_pos = getposatl _buildable;
_vars = [];
{
	_vars pushback [_x,_buildable getVariable _x,true];
} forEach allVariables _buildable;


_newBuildable = _typename createVehicle [0,0,0];

_newBuildable setDir _dir;
{
	_newBuildable setVariable _x;
} forEach _vars;
[_newBuildable,_loot] call BASE_fnc_setAllCargo;
_newBuildable setVectorUp [0,0,1];

deleteVehicle _buildable;
_newBuildable setPosATL _pos;

[_newBuildable] remoteExec ["DS_fnc_liftBuildable",_clientObj]; 