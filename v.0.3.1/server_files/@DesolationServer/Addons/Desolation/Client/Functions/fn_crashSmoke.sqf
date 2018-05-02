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
private ["_obj","_Smoke","_smoke2"];
params ["_obj","_size","_smokePos","_isWreck"];


_smoke = "#particlesource" createVehicleLocal getpos _obj;
_smoke attachto [_obj, _smokePos];
_smoke setParticleCircle [0, [0, 0, 0]];
_smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
_smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size,2*_size], [[0.9, 0.2, 0.51, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "",objNull];
_smoke setDropInterval 0.005;
if (_isWreck) exitWith {};
waitUntil {!alive _obj};
deleteVehicle _smoke;
true
