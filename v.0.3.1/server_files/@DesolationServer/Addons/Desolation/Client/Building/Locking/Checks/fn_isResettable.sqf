params ["_object"];


_blocked = ["DSR_Object_Stockade_Wall","DSR_Object_Stockade_Tower","DSR_Object_Stockade_Rampart_2","DSR_Object_Stockade_Rampart"];
_allowed = false;
if (locked _object == -1) then { // if building
	if !((typeOf _object) in (_blocked)) then { // If object is not on blocked list
		if ([_object] call DS_fnc_isBuildingOwner && _object getVariable ["bis_disabled_Door_1",0] == 0) then {
			_allowed = true;
		};
	};
} else {
	if (locked _object > 0 && locked _object < 2) then { // if vehicle
		_allowed = true;
	};
};
_allowed;