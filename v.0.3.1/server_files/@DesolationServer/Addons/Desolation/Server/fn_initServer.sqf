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

_enabled = call compile (["Enabled","DS"] call BASE_fnc_getCfgValue);
if(!_enabled) exitWith {diag_log "DESOLATION IS NOT ENABLED, THE PLUGIN WILL NOT RUN";};

_debug = call compile (["DebugMode","DS"] call BASE_fnc_getCfgValue);

if !(_debug) then {
	{
		_x setMarkerAlpha 0;
	} forEach allMapMarkers;
};

addMissionEventHandler ["PlayerDisconnected", DS_fnc_playerDisconnected];
addMissionEventHandler ["HandleDisconnect", DS_fnc_handleDisconnect];

civilian setFriend [sideEnemy, 1];

call DS_fnc_initServerLock; // lock the server

waitUntil{BASE_var_MapEditsDone}; // wait for map to finish loading

if(!isNil "DS_fnc_initServerTick") then {
	diag_log "Desolation > Starting server tick manager";
	[] spawn DS_fnc_initServerTick; // Start server tick manager (from client files)
};

// start vehicle & object spawns
[] spawn DS_fnc_spawnObjects;


// start the building & crafting systems
call DS_fnc_initBuildingSys;
call DS_fnc_initCraftingSys;



// start the crafting system (not implemented)
// [] spawn DS_fnc_initCraftingSys;

//--- start subsystems
[] spawn DS_fnc_simManager;

DS_var_startTime = diag_tickTime;

//--- TEMP (group system manager)
[] spawn {
	while{true} do {
		{ 
			if ((count units _x) == 0) then 
			{
				_x remoteExecCall ["deleteGroup",groupOwner _x]; //delete group where it is local
			};
		} forEach allGroups;
		uiSleep 20;
	};
};
//--- TEMP: move this to its own function
DeleteEmptyHolder = 
{
    // This file does not need to be optimized, it's litreally just doing something very basic.
    // Security
    params["_netIdConatiner","_netIdPlayer"];
    private _container = objectFromNetId _netIdConatiner;
    private _player = objectFromNetId _netIdPlayer;
    if !(isNull _container) then
    {
        // Also secuirty
        if ((typeOf _container) == "GroundWeaponHolder") then
        {
            deleteVehicle _container;
        };
    };
    true
};


//--- DEBUG (monitor thread counts)
[] spawn {
	uiSleep 300;
	while{true} do {
		_threads = Diag_activeScripts;
		NUM_THREADS = (_threads select 0) + (_threads select 1) - 1;
		
		if(diag_fps < 15) then {
			diag_log ("WARNING: CANT KEEP UP! Thread Count: " + str(Diag_activeScripts) + " - FPS: " + str(diag_fps));
		} else {
			if(NUM_THREADS > 15 && diag_fps < 40) then {
				diag_log ("WARNING: CANT KEEP UP! To many threads running on the server - " + str(NUM_THREADS) + " - FPS: " + str(diag_fps));
			};
		};
		
		uiSleep 1;
	};
};
