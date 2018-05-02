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
 
params["_selection"];

_data = ["Error","#(argb,8,8,3)color(0,0,0,0)"];
{
	_cfgName = _x select 0;
	_name = _x select 1;
	_icon = _x select 2;
	
	if((tolower(_selection) find "proxy" == -1) && (toLower(_selection) find toLower(_cfgName) != -1)) exitWith {
		_data = [_name,_icon];
	};
} forEach ACT_var_ICONS;
_data;