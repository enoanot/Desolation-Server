params["_item","_object","_player"];


_posASL = AGLtoASL (_player modelToWorld [0,3,0]);

_obj = _object createVehicle [0,0,0];
_obj setPosASL _posASL;

// register building in building DB
[_obj, 2, 1001] call DB_fnc_spawnObject;

[_obj,_item] remoteExec ["DS_fnc_onPlacableLift",_player];
