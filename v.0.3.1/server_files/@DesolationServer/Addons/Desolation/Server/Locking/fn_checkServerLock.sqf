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

if(DS_var_unlocked) exitWith {}; // already unlocked, dont start threads again

if(DS_var_finishedObjects && LSYS_var_finishedLoot && SM_var_finishedZombies) then {
	DS_var_unlocked = true;
};
 
 _password = bis_functions_mainscope getVariable ["ServerCommandPassword_DS", ""];
 if(!isNil "TM_fnc_checkLock") then {
	_shutdownFunction = {
		// save objects
		diag_log  "Shutdown > Waiting for object monitor to exit";
		DB_var_runObjectMon = false;
		waitUntil{!DB_var_savingObjects};
	};
 
 
	if([_password,_shutdownFunction] call TM_fnc_checkLock) then {
		bis_functions_mainscope setVariable ["ServerCommandPassword_DS",nil,true]; //--- wipe security vulnerability 
	};
 } else {
	if(DS_var_finishedObjects && LSYS_var_finishedLoot && SM_var_finishedZombies) then {
		bis_functions_mainscope setVariable ["ServerCommandPassword_DS",nil,true]; //--- wipe security vulnerability 
		_password serverCommand "#unlock";
		diag_log "SERVER LOCKING > UNLOCKED";
		
		safeshutdown = compileFinal ('
			params["_password"];
			
			diag_log  "Shutdown > Locking Server";
			_password serverCommand "#lock";
			diag_log  "Shutdown > Kicking Players";
			{
				_password serverCommand ("#kick " + str(owner _x));
			} forEach allPlayers;
			uiSleep 10; 
			diag_log  "Shutdown > Waiting for object monitor to exit";
			DB_var_runObjectMon = false;
			waitUntil{!DB_var_savingObjects};
			diag_log  "Shutdown > Done";
			_password serverCommand "#shutdown";
		');
		_password spawn {
			params["_password"];
			
			uiSleep ((3600*4)-(60*5)); //4 hours - 5 min
			[
				[
					["SERVER SHUTTING DOWN IN 5 MINUTES, LOGOUT","align = 'left' shadow = '1' size = '0.9' font='PuristaBold'"]
				], 0, 0, true
			] remoteExec  ["BIS_fnc_typeText2", -2];
			uiSleep (60*4); //4 min (5 till restart)
			[
				[
					["SERVER SHUTTING DOWN NOW, LOGOUT","align = 'left' shadow = '1' size = '0.9' font='PuristaBold'"]
				], 0, 0, true
			] remoteExec  ["BIS_fnc_typeText2", -2];
			uiSleep 60; //1 min (1 till restart)
			
			// prevent new players from connecting
			diag_log  "Shutdown > Locking Server";
			_password serverCommand "#lock";
			
			// kick existing players
			diag_log  "Shutdown > Kicking Players";
			{
				_password serverCommand ("#kick " + str(owner _x));
			} forEach allPlayers;
			
			// wait for all disconnects to process
			uiSleep 10; 
			
			// save objects
			diag_log  "Shutdown > Waiting for object monitor to exit";
			DB_var_runObjectMon = false;
			waitUntil{!DB_var_savingObjects};
			
			
			diag_log  "Shutdown > Done";
			_password serverCommand "#shutdown";
			
		};
	};
};