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
 
_enabled = (toLower(["Enabled","HLCR"] call BASE_fnc_getCfgValue) == "true");
if(!_enabled) exitWith {diag_log "<HELI CRASHES>: Heli Crashes turned off!";};

waitUntil{BASE_var_MapEditsDone}; // wait for map to finish loading

call HLCR_fnc_initHeliCrashes;
[] spawn HLCR_fnc_spawnManager;