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
 

params["_crashPos","_crashType"];

if!(canSuspend) exitWith {
	[] spawn HLCR_fnc_spawnHeliCrash;
};

if(isNil "_crashType") then {
	_crashType = selectRandom HLCR_HeliCrash_CrashTypes;
};

_heliType = getText (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "HeliClass");
if (_heliType isEqualTo "") exitWith {diag_log "<HELI CRASHES>: Error no HeliClass defined!"};
_wreckClass = getText (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "WreckClass");
if (_wreckClass isEqualTo "") exitWith {diag_log "<HELI CRASHES>: Error no WreckClass defined!"};

_wreckSmoke = getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "WreckSmoke");
_smokepos = getArray (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "SmokePos");
_spawnAlt = getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "SpawnAltitude");
_smokeSize = getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "SmokeSize");
_maxZombies = getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "MaxZombieCount");
_minZombies = getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "MinZombieCount");

if(isNil "_crashPos") then {
	_crashPos = ([[], 0, -1, 0, 0, 0, 0] call BIS_fnc_findSafePos);
};
	
_spawnDirection = random 360;
_spawnPos = [(_crashPos select 0) + sin(_spawnDirection) * worldSize, (_crashPos select 1) + cos(_spawnDirection) * worldSize, _spawnAlt];
_timeout = diag_ticktime + 20;

	
diag_log "<HELI CRASHES>: Spawning heli crash.";

_heli = _heliType createVehicle [0,0,500];
_heli setVariable ["sim_manager_ignore",true,true];
	
createVehicleCrew _heli;
{_x allowDamage false;} forEach (crew _heli);
_heli engineOn true;
	
_heli setPosATL _spawnPos;
(group _heli) move _crashPos;
(group _heli) setBehaviour "CARELESS";
(group _heli) setSpeedMode "full";

while {(_timeout - diag_tickTime) >= 0} do {
	_heli setVelocity [0,0,0];
	uiSleep 0.5;
};
waituntil {(_heli distance2D _crashPos) < 400};

_wreckPos = [_heli,_wreckClass,_smokeSize,_smokepos,_wreckSmoke,_maxZombies,_minZombies] call HLCR_fnc_heliCrashAnim;

_enableBodies = getText (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "Loot" >> "LootSettings" >> "BodySettings" >> "EnableBodies");
if(_enableBodies isEqualTo "true") then {
	[_wreckPos,_crashType] call HLCR_fnc_spawnCrashBodies;
};
_enableCrates = getText (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashType >> "Loot" >> "LootSettings" >> "CrateSettings" >> "EnableCrates");
if(_enableCrates isEqualTo "true") then {
	[_wreckPos,_crashType] call HLCR_fnc_spawnCrashCrates;
};

true;