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

params["_playerObj"];

_playerObj hideObjectGlobal true;
_playerObj allowDamage false;

_response = [_playerObj] call DB_fnc_loadPlayer;

if (_response isEqualTo []) then { // fresh spawn
    [] remoteExec ["DS_fnc_freshSpawn",_playerObj];
} else { // load spawn
    [_response,_playerObj] call DS_fnc_requestLoadSpawn;
};
