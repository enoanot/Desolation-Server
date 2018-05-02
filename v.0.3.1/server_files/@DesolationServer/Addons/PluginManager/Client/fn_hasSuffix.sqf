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
 
params["_string","_suffix"];
private["_i","_return"];
_return = false;
_i = toLower(_string) find tolower(_suffix);
if(_i != -1) then {
	if(count(_string) == ((_i + count(_suffix)))) then {
		_return = true;
	};
};
_return;