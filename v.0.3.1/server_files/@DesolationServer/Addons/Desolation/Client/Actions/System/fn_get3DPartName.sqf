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

_return = [configNull, -1];
_cfg = "true" configClasses (configFile >> "Cfg3DActions");
_k = 0;
{
	if ((_this find (configName _x)) != -1) exitWith { _return = [_x, _k]; };
	_k = _k + 1;
} count _cfg;
_return