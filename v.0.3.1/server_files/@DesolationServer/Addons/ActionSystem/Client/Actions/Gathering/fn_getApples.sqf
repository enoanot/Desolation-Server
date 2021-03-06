/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */

// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)
 
params["_cursor"];

if ([1] call ACT_fnc_doAnimation) then {
	if (random(1) <= 0.2) then {
		systemChat "Apple found";
		[_cursor, player, "Search Apples",4] remoteExec ["ACT_fnc_gather", 2];
	} else {
		systemChat "No apples found";
	};
};

true