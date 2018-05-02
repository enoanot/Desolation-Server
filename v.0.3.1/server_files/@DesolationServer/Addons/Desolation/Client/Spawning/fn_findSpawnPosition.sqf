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


params["_marker","_spawnType"];
private["_markerPos","_markerSize","_spawnPos","_ClosestObject","_blacklist"];


_spawnPos = [];
_markerPos = getmarkerPos _marker;
_markerSize = getmarkerSize _marker;
_maxIncl = 0;//maximum gradient for to spawn
_ClosestObject = 5; //closest object to position
_blacklist = [];

_spawnZoneSize = (_markerSize select 1);
if ((_markerSize select 0) > (_markerSize select 1)) then{_spawnZoneSize = (_markerSize select 0);};

_spawnPos = [_markerPos, 0, _spawnZoneSize, _ClosestObject, 0, _maxIncl, _spawnType, _blacklist, [0,0,0]] call BIS_fnc_findSafePos;



_spawnPos;