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
private["_buildingTypes","_MinPiles","_DoRespawn","_RespawnTimeS","_Config_Options","_lChance","_sChance","_tChance","_gChance","_data","_all_buildings","_cfg","_name","_buildingsToSpawn","_buildingsToDespawn","_buildingsNotToDespawn","_houses","_nearest_building","_nearest_building_type","_last_nearest","_hasVar","_isSpawned","_savedLoot","_spawnTime","_doFreshSpawn","_x"];

//--- Parse config entries
_buildingTypes = getArray(configFile >> "CfgItemSpawns" >> "buildingTypes");
//--- Parse User Defined Config Entries
_MinPiles = ["MinPiles","LSYS"] call BASE_fnc_getCfgNumber;
_MaxPiles = ["MaxPiles","LSYS"] call BASE_fnc_getCfgNumber;

_DoRespawn = call compile (["RespawnLoot","LSYS"] call BASE_fnc_getCfgValue);
_RespawnTimeS = (["RespawnTime","LSYS"] call BASE_fnc_getCfgNumber)*60;


_Config_Options = [];
{
	_lChance = call compile ([_x + "_lootChance","LSYS"] call BASE_fnc_getCfgValue);
	_sChance = call compile ([_x + "_spawnChance","LSYS"] call BASE_fnc_getCfgValue);
	_tChance = call compile ([_x + "_typeChance","LSYS"] call BASE_fnc_getCfgValue);
	_gChance = call compile ([_x + "_gearChance","LSYS"] call BASE_fnc_getCfgValue);
	_data = [_lChance,_sChance,_tChance,_gChance];
	_Config_Options pushBack _data;
} forEach _buildingTypes;


_all_buildings = [];
for "_i" from 0 to count(configFile >> "CfgItemSpawns" >> "Buildings")-1 do {
	_cfg = (configFile >> "CfgItemSpawns" >> "Buildings") select _i;
	if(isClass _cfg) then {
		_name = toLower(configName _cfg);
		_all_buildings pushBack _name;
	};
};
LSYS_var_finishedLoot = true;
call DS_fnc_checkServerLock;


[[_buildingTypes,_MinPiles,_MaxPiles,_DoRespawn,_RespawnTimeS,_Config_Options,_all_buildings],{
	private["_buildingTypes","_MinPiles","_MaxPiles","_DoRespawn","_RespawnTimeS","_Config_Options","_lChance","_sChance","_tChance","_gChance","_data","_all_buildings","_cfg","_name","_buildingsToSpawn","_buildingsToDespawn","_buildingsNotToDespawn","_houses","_nearest_building","_nearest_building_type","_last_nearest","_hasVar","_isSpawned","_savedLoot","_spawnTime","_doFreshSpawn","_x"];
	params["_buildingTypes","_MinPiles","_MaxPiles","_DoRespawn","_RespawnTimeS","_Config_Options","_all_buildings"];
	
	_buildingsToSpawn = [];
	_buildingsToDespawn = [];
	_buildingsNotToDespawn = [];

	{
		_inVehicle = (vehicle _x != _x);
	
	
		if(alive _x) then {
			//--- get house im standing on, fixes bug with some houses despawning loot when im in them
			_houses = lineIntersectsObjs [(AGLtoASL (_x modelToWorld [0,0,0])),(AGLtoASL(_x modelToWorld [0,0,-0.5])),objNull,_x,true];
			_nearest_building = objNull;
			
			
			{
				if(toLower(typeof(_x)) in _all_buildings) exitWith {
					_nearest_building = _x;
				};
			} forEach _houses;
			
			if(count(_houses) > 0 && isNull _nearest_building) then {
				_nearest_building = _houses select (count(_houses)-1);
			};
			
			if !(toLower(typeof(_nearest_building)) in _all_buildings) then {
				_houses = nearestObjects [_x,_all_buildings,50];
				_nearest_building = objNull;
				{
					if(isNull _nearest_building) then {
						_nearest_building = _x;
					} else {
						if((player distance _x) < (player distance _nearest_building)) then {
							_nearest_building = _x;
						};
					};
				} forEach _houses;
			};
			//--- near building check (fixes bug with lamps being called "houses" rofl)
			if !(toLower(typeof(_nearest_building)) in _all_buildings) then {
				_nearest_building = nearestBuilding _x;
			};
			
			
			if(!isNull _nearest_building && !isObjectHidden _nearest_building) then { /// near a building
				
				if(!_inVehicle) then {
					_buildingsNotToDespawn pushBack _nearest_building; /// mark this building as not despawnable
				};
				if !(_nearest_building in _buildingsToSpawn) then {
					
					_nearest_building_type = toLower(typeof _nearest_building);

					_last_nearest = _x getVariable ["LastNearestBuilding",objNull];
					if((_last_nearest != _nearest_building) || _inVehicle) then { /// nearest building has changed OR you are in a vehicle
					
						if(!isNull _last_nearest) then {
							if(_last_nearest getVariable ["SpawnedLoot",false]) then {
								if !(_last_nearest in _buildingsToDespawn) then {
									_buildingsToDespawn pushback _last_nearest; /// if we were at a previous building, mark it as despawnable
								};
							};
						};
						
						if(_inVehicle) then {
							_nearest_building = objNull;
							_nearest_building_type = "IN_A_VEHICLE";
						};
						_x setVariable ["LastNearestBuilding",_nearest_building]; /// update our previous building to this new one

						if(_nearest_building_type in _all_buildings) then { /// if this building can contain loot
							
							_buildingsToSpawn pushBack _nearest_building; /// mark this building as "Spawn loot here"

						};
					};
				};
			};
		};
	} forEach allPlayers;

	{

		_hasVar = _x getVariable ["SpawnedLoot",false];
		_isSpawned = _x getVariable ["IsSpawnedLoot",false];
		_savedLoot = _x getVariable ["SavedLoot",[]];
		_spawnTime = _x getVariable ["SpawnedTime",0];
		_lootPiles = _x getVariable ["LOOT_PILES",[]];

		_doFreshSpawn = false;

		if !(_hasVar) then {
			_doFreshSpawn = true;
		} else {
			if(_DoRespawn) then {
				if ((diag_tickTime - _spawnTime) >= _RespawnTimeS) then {
					_doFreshSpawn = true;
				};
			};
		};
		
		if(count(_lootPiles) == 0) then {
			if(_doFreshSpawn) then {
				_x setVariable ["SpawnedLoot",true];
				_x setVariable ["SpawnedTime",diag_tickTime];
				_x setVariable ["SavedLoot",[]];
				_x setVariable ["IsSpawnedLoot",true];
				
				[_x,_MinPiles,_MaxPiles,_buildingTypes,_Config_Options,["FRESH LOOT"]]  call LSYS_fnc_spawnLoot; //remoteExecCall ["LSYS_fnc_spawnLoot",2];
			} else {
				if(!_isSpawned) then {
					[_x,_MinPiles,_MaxPiles,_buildingTypes,_Config_Options,_savedLoot] call LSYS_fnc_spawnLoot; //remoteExecCall ["LSYS_fnc_spawnLoot",2];
				};
			};
		};
	} forEach _buildingsToSpawn;
	{
		if !(_x in _buildingsNotToDespawn) then {
			[_x] call LSYS_fnc_despawnLoot;
			_x setVariable ["IsSpawnedLoot",false];
		};
	} forEach _buildingsToDespawn;
	
},false,1,0] call DS_fnc_registerTickFunc; //wrong function
