/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 - 2018 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */
 
 // this starts the server side of the plugin manager
_this spawn {
	_server_functions = _this select 2;
	
	waitUntil {!isNil "BASE_var_INITORDER"};
	
	diag_log "<PluginManager>: Starting server";
	
	_fnclist = [];
	_plugins = [];
	_cfg = configFile >> "Plugins";
	{
		_cfgEntry = _cfg >> _x;
		if(isClass _cfgEntry) then {
			_plugin = configName _cfgEntry;
			_tag = (GetText(_cfgEntry >> "tag")) + "_";
			if(_tag != "_") then {
				{
					if( (tolower(_x) find tolower(_tag)) == 0) then {
						if !(_x in _fnclist) then {
							_fnclist pushBack _x;
							_plugins pushBack _plugin;
						};
					};
				} forEach _server_functions;
			};
		};
	} forEach BASE_var_INITORDER;
	
	[_fnclist] call BASE_fnc_setupEvents;
	
	[] call BASE_fnc_initKeybinds;
	
	BASE_var_MapEditsDone = false;
	[] spawn BASE_fnc_spawnMapEdits;
	
	diag_log "<PluginManager>: Starting plugins...";
	{	
		_isStartServer = [_x,"initServer"] call BASE_fnc_hasSuffix;
		
		if(_isStartServer) then {
			diag_log ((_plugins select _forEachIndex) + " > Init Server");
			[] spawn (missionNamespace getVariable [_x,{DIAG_LOG "FAILED TO FIND FUNCTION";}]);
		};
	} forEach _fnclist;
	
	call BASE_fnc_initActions;
	
	diag_log "<PluginManager>: Initializing events...";
	call BASE_fnc_broadcastEvents;
	
	_override = BASE_var_missionEventsServer select 0;
	if(!_override) then {
		call BASE_fnc_initMissionEventsServer;
	};
	
};