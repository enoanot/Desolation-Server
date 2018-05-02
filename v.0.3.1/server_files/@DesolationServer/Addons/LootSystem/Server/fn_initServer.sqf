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

_enabled = (toLower(["SpawnLoot","LSYS"] call BASE_fnc_getCfgValue) == "true");
if(!_enabled) exitWith {diag_log "<Loot System>: Loot spawning turned off";};

LSYS_var_finishedLoot = false;

// start item spawns
[] spawn LSYS_fnc_lootManager;