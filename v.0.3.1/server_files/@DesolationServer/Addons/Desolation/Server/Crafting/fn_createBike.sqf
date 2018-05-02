/*
 * Desolation Redux
 * http://desolationredux.com/
 * � 2016 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */

params["_player"];

_bike = createVehicle ["DSR_Bike_White_F", _player modelToWorld [0,2.7,0], [], 0.5, "NONE"];
_bike setDir (getDir _player);
_player reveal _bike;

[_bike] call DB_fnc_spawnObject;