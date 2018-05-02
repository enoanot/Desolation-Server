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
params ["_Water","_Ground"];

_blackList = ["out"];
if (_Water) then {_blackList pushBack "water"};
if (_Ground) then {_blackList pushBack "ground"};
_randomLocation = [0,0];
while {_randomLocation isEqualTo [0,0]} do 
{
	//TODO Rewrite RandomPos function to not be shit
	_randomLocation = [[call BIS_fnc_worldArea],_blackList] call BIS_fnc_randomPos;
};
_randomLocation;