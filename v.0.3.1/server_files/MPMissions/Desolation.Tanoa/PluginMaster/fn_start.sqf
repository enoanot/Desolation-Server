/*
	fn_start
	
	Desolation Redux
	2016 Desolation Dev Team
	
	License info here and copyright symbol above
*/
disableUserInput false;

call BASE_fnc_initEventHandlers;

{
	_isStartClient = [_x,"initClient"] call BASE_fnc_hasSuffix;
	if(_isStartClient) then {
		[] spawn (missionNamespace getVariable [_x,{DIAG_LOG "FAILED TO FIND FUNCTION";}]);
	};
} forEach BASE_var_Files;

[] spawn BASE_fnc_startActionManager; //--- start action management
[] spawn BASE_fnc_initKeybindUI; //--- start unmodded custom controls ui thread (this doesnt work as far as I know (rofl))

// initialize player events and mission events

//not sure if i can waituntil in this scope
waitUntil{!isNil "BASE_var_playerEvents"};
waitUntil{!isNil "BASE_var_missionEventsClient"};

//if not overriden | init events
_override = BASE_var_playerEvents select 0;
if(!_override) then {
	call BASE_fnc_initPlayerEvents;
};

_override = BASE_var_missionEventsClient select 0;
if(!_override) then {
	call BASE_fnc_initMissionEventsClient;
};


0 cutRsc ["background","PLAIN",0];
//10000 cutText ["","BLACK IN",1];
