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
	adds an event handler to the base stack
*/
params["_type","_code"];

_value = missionNamespace getVariable ["BASE_var_" + _type,[]];
_key = str(floor(random(1000000)));

_value pushBack [_code,_key];
missionNamespace setVariable ["BASE_var_" + _type,_value];

_key;