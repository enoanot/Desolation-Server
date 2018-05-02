


params["_callbackType",["_extraData",[]]];

{
	_type = _x select 0;
	_fnc = _x select 1;
	if(_type == _callbackType) exitWith {
		[_type,_extraData] call (missionNamespace getVariable [_fnc,{}]);
	};
} forEach DSA_var_callBackTypes;