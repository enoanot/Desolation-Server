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

if(toLower(["Enabled","ACT"] call BASE_fnc_getCfgValue) == "true") then {
	ACT_var_Render3DActions = !ACT_var_Render3DActions; // toggle the rendering system
	ACT_var_Render2DActions = false;
	if(ACT_var_Render3DActions) then {
		
		[] spawn ACT_fnc_calculationThread; // start 3d icon calculation thread
	};
};
true