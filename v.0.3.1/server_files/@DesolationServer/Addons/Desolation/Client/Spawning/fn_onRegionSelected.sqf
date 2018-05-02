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


params["_regionNum"];

0 cutRsc ["background","PLAIN",0];
_SpawnMode = -1;

_region = switch(_regionNum) do {
	case 0: 
	{
		_SpawnModeCFG = ["Zone1ShoreMode","DS"] call BASE_fnc_getCfgValue;
		switch (toLower _SpawnModeCFG) do 
		{
			case "true":{_SpawnMode = 1;};
			case "false":{_SpawnMode = 0;};
			default {diag_log "Desolation > ERROR: Zone 1 Spawntype not set, Defaulting to false";_SpawnMode = 0;};
		};
		(["Zone1Marker","DS"] call BASE_fnc_getCfgValue);
	};
		
	case 1: 
	{
		_SpawnModeCFG = ["Zone2ShoreMode","DS"] call BASE_fnc_getCfgValue;
		switch (toLower _SpawnModeCFG) do 
		{
			case "true":{_SpawnMode = 1;};
			case "false":{_SpawnMode = 0;};
			default {diag_log "Desolation > ERROR: Zone 2 Spawntype not set, Defaulting to false";_SpawnMode = 0;};
		};
		(["Zone2Marker","DS"] call BASE_fnc_getCfgValue);
	};
		
	case 2: 
	{
		_SpawnModeCFG = ["Zone3ShoreMode","DS"] call BASE_fnc_getCfgValue;
		switch (toLower _SpawnModeCFG) do 
		{
			case "true":{_SpawnMode = 1;};
			case "false":{_SpawnMode = 0;};
			default {diag_log "Desolation > ERROR: Zone 3 Spawntype not set, Defaulting to false";_SpawnMode = 0;};
		};
		(["Zone3Marker","DS"] call BASE_fnc_getCfgValue);
	};
};

if (_SpawnMode == -1) then 
{
	diag_log "Desolation > ERROR: ZoneShoreModes not defined in CFG! Defaulting to false";
	_SpawnMode = 0;
};

_spawnPos = [_region,_SpawnMode] call DS_fnc_findSpawnPosition;
player setVariable ["ReadyToSpawn",true,true];
[player,_spawnPos] remoteExec ["DS_fnc_requestFreshSpawn",2];
0 cutRsc ["background","PLAIN",0];