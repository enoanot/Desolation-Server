
private["_fnc"];
params["_callback_variable","_parameters"];

_fnc = missionNamespace getVariable [_callback_variable,""];
if(_fnc != "") then {
	 _parameters call (missionNamespace getVariable [_fnc,{}]);
};