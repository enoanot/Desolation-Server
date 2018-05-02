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

_enabled = (toLower(["Enabled","AIRD"] call BASE_fnc_getCfgValue) == "true");
if(!_enabled) exitWith {diag_log "<AIRDROPS>: Airdrops turned off!";};

waitUntil{BASE_var_MapEditsDone}; // wait for map to finish loading


call AIRD_fnc_initAirdrops;
[] spawn AIRD_fnc_spawnManager;