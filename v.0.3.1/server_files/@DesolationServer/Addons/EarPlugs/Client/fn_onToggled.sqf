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

/*
	Ear plugs: on key pressed event
*/

if(isNil 'EP_var_curVal') then {EP_var_curVal = 0;};

_found = false;
if(toLower(["Enabled","EP"] call BASE_fnc_getCfgValue) == "true") then {
	_found = true;
	EP_var_curVal = EP_var_curVal + 1;
	if(EP_var_curVal == 4) then {EP_var_curVal = 0;};
	
	switch(EP_var_curVal) do {
		case 0: {
			1 fadeSound 1;
			1 fadeMusic 1;
			1 fadeRadio 1;
			systemchat "Earplugs removed";
		};
		case 1: {
			1 fadeSound .75;
			1 fadeMusic .75;
			1 fadeRadio .75;
			systemchat "Earplugs level 1";
		};
		case 2: {
			1 fadeSound .50;
			1 fadeMusic .50;
			1 fadeRadio .50;
			systemchat "Earplugs level 2";
		};
		case 3: {
			1 fadeSound .25;
			1 fadeMusic .25;
			systemchat "Earplugs level 3";
		};
	};
};
_found;