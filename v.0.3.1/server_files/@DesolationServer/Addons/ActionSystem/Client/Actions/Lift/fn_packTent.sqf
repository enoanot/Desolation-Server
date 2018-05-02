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

// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)
 
params["_cursor"];

if ([0] call ACT_fnc_doAnimation) then {
	if((magazineCargo _cursor isEqualTo []) && (itemCargo _cursor isEqualTo []) && (weaponCargo _cursor isEqualTo []) && (backpackCargo _cursor isEqualTo [])) then {
		[_cursor, player, "Unpack",1]  remoteExec ["ACT_fnc_disassembleObject", 2];
	} else {
		systemChat "Tent needs to be empty, before you can unpack it.";
	};
};

true