

params["_crate"]; 


systemchat "Preview objects are not saved. After restart they will be deleted.";
systemchat "Press ESCAPE to cancel building.";

player reveal [_crate, 4]; 

[_crate] spawn OM_fnc_liftObject;
waitUntil{!isNull OM_var_lifted};

_event = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	_key = _this select 1;
	_block = false;
	if(_key == 0x01) then {
		deleteVehicle OM_var_lifted;
		_block = true;
	};
	_block;
}];

waitUntil{isNull OM_var_lifted};

(findDisplay 46) displayRemoveEventHandler ["KeyDown",_event];(findDisplay 46) displayRemoveEventHandler ["KeyDown",_event];

if(isNull _crate) exitWith {};

[_crate] remoteExec ["DS_fnc_buildableDropped",2];

