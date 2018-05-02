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

params["_classname",["_animation",""],["_removeItem",true],["_oncomplete",{}],["_onfailure",{}],["_replacement",""],["_param",""]];

if(({toLower(_x) == toLower(_classname)} count (magazines player)) > 0) then {
	if([_animation] call ds_fnc_doAction) then {
		if(({toLower(_x) == toLower(_classname)} count (magazines player)) > 0) then {
			
			if(_removeItem) then {
				player removeMagazine _classname;
			};
			
			_param call _oncomplete;
			
			if(_replacement != "") then {
				player addMagazine _replacement;
			};
			
		} else {
			["Item Does Not Exist"] call _onfailure;
		};
	} else {
		["Player Moved"] call _onfailure;
	};
} else {
	["Item Does Not Exist"] call _onfailure;
};
