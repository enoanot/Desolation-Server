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
_this spawn {
	params["_reason"];
	[parseText ("You have been kicked<br/>Reason: " + _reason), "Desolation Redux", true, false] call BIS_fnc_guiMessage;
	(findDisplay 46) closeDisplay 0; 
};