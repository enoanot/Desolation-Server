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

params["_centerPos","_radius"];
private["_randomDir","_xChange","_yChange","_add"];
_randomDir = random(360);
_xChange = random(_radius) * sin(_randomDir);
_yChange = random(_radius) * cos(_randomDir);
_add = [_xChange,_yChange];
if(count(_centerPos) > 2) then {
	_add pushback 0;
};
_pos = _centerPos vectorAdd _add;

