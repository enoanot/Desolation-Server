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

params["_cursor"];


// lift based on object type (*_preview2 is a buildable, requires more calculations done in desolation plugin)
// also checks if desolation plugin exists
if(!(isNil "DS_fnc_onBuildableLift") && (toLower(typeof(_cursor)) find "_preview2" != -1)) then {
	[_cursor] spawn DS_fnc_onBuildableLift;
} else {
	if(!isNil "DS_fnc_onBuildableLift") then {
		[_cursor] spawn OM_fnc_liftObject; 
	} else {
		systemchat "No Lift Plugin Implemented, cannot lift";
	};
};