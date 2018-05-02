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
params["_playerObj",["_respond",true]];

[_playerObj] call DB_fnc_savePlayer;

if(_respond) then {
	"Data saved" remoteExec ["systemChat",_playerObj];
} else {
	deleteVehicle _playerObj;
};
