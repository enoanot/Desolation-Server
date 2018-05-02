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

params["_heli","_wreckType","_smokesize","_smokePos","_wreckSmoke","_maxZombies","_minZombies"];

_pilot = driver _heli;

_heli setHitPointDamage ["HitVRotor", 1];
_smoke = "test_EmptyObjectForSmoke" createVehicle (getPosATL _heli);
_smoke attachTo [_heli,_smokePos];


_listeners = [];
{
	if("ItemRadio" in (assignedItems _x)) then {
		_listeners pushBack _x;
	};
} forEach allPlayers;

_callsignList = ["Charle 1-1","Misfit 1-1","Burglar 1-1","Foxhound 1-1"];
_callsign = selectRandom _callsignList;
_gridRef = mapGridPosition getPos _heli;
[netID _pilot,_callsign,["Mayday Mayday "+ _callsign + " is hit! We have lost engine power and are going down in GRID "+ _gridRef +" Requesting Immediate Assistance! Over"]] remoteExec ["DS_fnc_receiveTransmition",_listeners];


uiSleep 3;
_heli setHitPointDamage ["HitHRotor", 1];
_heli setHitPointDamage ["HitEngine", 1];
waitUntil {isTouchingGround _heli};

{deleteVehicle _x} forEach (crew _heli);
deleteVehicle _smoke;


uiSleep 3;
deleteVehicle _heli;
_heli setDamage 1;
_wreckPos = getposATL _heli;
_wreckDir = vectorDir _heli;
_vector = surfaceNormal position _heli;
_wreckPos set [2,0];

deleteVehicle _heli;
_wreck = _wreckType createVehicle _wreckPos;
_wreck enableSimulationGlobal false;
_wreck setposATL _wreckPos;
_wreck setVectorDir _wreckDir;
_wreck setVectorUp _vector;

if!((isNil "DSZ_fnc_spawnManager") && (isNil "DS_fnc_spawnZombieFnc")) then {
	_zombieCount = random _maxZombies;
	if(_zombieCount < _minZombies) then {_zombieCount = _minZombies + (random (_maxZombies - _minZombies));};
	for "_i" from 0 to (ceil(_zombieCount) - 1) do {
		_zPos = _wreckPos vectorAdd [round(random 1)*random [1,2,3],round(random 1)*random [1,2,3],0];
		[_zPos,10] call (missionNamespace getVariable ["DS_fnc_spawnZombieFnc",{}]);
	};
};

diag_log ("<HELI CRASHES>: Created heli crash at: " + str(_wreckPos));

if (_wreckSmoke > 0) then {
	_smoke = "test_EmptyObjectForSmoke" createVehicle _wreckPos;
	//_smoke enableDynamicSimulation true; //TODO: increase simulation distance on this and renable
	_smoke setPosATL getPosATL _wreck;
};

_wreckPos;