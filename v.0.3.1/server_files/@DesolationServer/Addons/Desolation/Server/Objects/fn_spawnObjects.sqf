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
private["_types","_data","_config","_cfg","_locations","_directions","_type","_houses","_index","_hData","_vehicles","_bikeLimit","_housesOrdered","_houses","_lIndex","_v","_vDir","_posagl","_posasl","_tv","_hitpoints","_value"];

DB_var_Objects = [];
DB_var_ObjectUUIDS = [];
DB_var_restoreObjectInProgress = true;

_numVtoSpawn = (["NumVehicles"] call DS_fnc_getCfgValue);

_bikeLimit = (["MaxBikes","DS"] call DS_fnc_getCfgValue);
_heliLimit = (["MaxHelis","DS"] call DS_fnc_getCfgValue);
_planeLimit = (["MaxPlanes","DS"] call DS_fnc_getCfgValue);
_carLimit = (["MaxCars","DS"] call DS_fnc_getCfgValue);
_boatLimit = (["MaxBoats","DS"] call DS_fnc_getCfgValue);
_maxDamage = ((["MaxDamage","DS"] call DS_fnc_getCfgValue));
_midDamage = ((["MidDamage","DS"] call DS_fnc_getCfgValue));
_minDamage = ((["MinDamage","DS"] call DS_fnc_getCfgValue));

_damageError = false;
if ((floor _minDamage) <= 1 && (floor _midDamage) <= 1 && (floor _maxDamage)  <= 1) then {
	diag_log("ERROR: check your Desolation config, the damage value should be in percent meaning in the range of 0 and 90 not between 0.0 and 0.9!");
	_damageError = true;
};

if (_minDamage < 0 || _midDamage < 0 || _maxDamage < 0) then {
	diag_log("ERROR: check your Desolation config, the damage value should not be negative!");
	_damageError = true;
};

if (_minDamage > 95 || _midDamage > 95 || _maxDamage > 95) then {
	diag_log("ERROR: check your Desolation config, the damage value should not be larger then 95 to prevent random explosions!");
	_damageError = true;
};

if (_damageError) then {
	diag_log("your settings got defaulted to 0, 40, 80");
	_minDamage = 0;
	_midDamage = 40;
	_maxDamage = 80;
};

_maxFuel = ((["MaxFuel","DS"] call DS_fnc_getCfgValue));
_minFuel = ((["MinFuel","DS"] call DS_fnc_getCfgValue));

_fuelError = false;
if ((floor _maxFuel)  <= 1 || _minFuel > 100 || _maxFuel > 100) then {
	diag_log("ERROR: check your Desolation config, the fuel value should be in percent meaning in the range of 0 and 100 not between 0.0 and 1.0!");
	_fuelError = true;
};

if (_minFuel < 0 || _maxFuel < 0) then {
	diag_log("ERROR: check your Desolation config, the fuel value should not be negative!");
	_fuelError = true;
};

if (_maxFuel < _minFuel) then {
	diag_log("ERROR: check your Desolation config, the fuel minimum value should be smaller then the maximum value!");
	_fuelError = true;
};

if (_fuelError) then {
	diag_log("your settings got defaulted to 0, 100");
	_minFuel = 0;
	_maxFuel = 100;
};

_tvs = [];

if (isNil "DB_fnc_restoreObjects") then {
	diag_log "Warning: Seems like there is no Databasemodul?!";
} else {
	_dbSpawnObjects = call DB_fnc_restoreObjects;
	{
		_data = _x;
		if(count(_data) > 0) then {
			_object = _data select 0;
			_tvs pushBack _object;
			_objectType = _data select 1;
			_object_uuid = _data select 2;
			
			/* TODO: expant this to support all objectTypes */
			if(_objectType == 3) then {
				_numVtoSpawn = _numVtoSpawn - 1;

				if(_object isKindOf "Bicycle") exitWith {_bikeLimit = _bikeLimit - 1;};
				if(_object isKindOf "Helicopter") exitWith {_heliLimit = _heliLimit - 1;};
				if(_object isKindOf "Plane") exitWith {_planeLimit = _planeLimit - 1;};
				if(_object isKindOf "Car") exitWith {_carLimit = _carLimit - 1;};
				if(_object isKindOf "Ship") exitWith {_boatLimit = _boatLimit - 1;};
			};
		};
	} forEach _dbSpawnObjects;
};

if(_numVtoSpawn <= 0) exitWith {
	diag_log "No more vehicles need to be spawned";
	uiSleep 3;
	{	
		if(_x getVariable ["isCar",false]) then {
			_x enableSimulationGlobal false;
		};
	} forEach _tvs;
	diag_log "Done spawning vehicles";
	DB_var_restoreObjectInProgress = false;
	DS_var_finishedObjects = true;
	call DS_fnc_checkServerLock;
};


_types = [];
_data = [];

diag_log "Scanning for house data";

_config = configFile >> "CfgVehicleSpawns" >> "Buildings";
for "_i" from 0 to count(_config)-1 do {
	_cfg = _config select _i;
	if(isClass _cfg) then {
		_locations = getArray(_cfg >> "locations");
		_directions = getArray(_cfg >> "directions");
		_type = configName _cfg;
		_types pushBack tolower _type;
		_data pushBack [_locations,_directions,[]];

	};
};
diag_log format["found %1 types of houses", count(_types)];


diag_log "Scanning for vehicle data";

_heliList = [];
_planeList = [];
_carList = [];
_boatList = [];

_config = configFile >> "CfgVehicleSpawns" >> "Vehicles";
for "_i" from 0 to count(_config)-1 do {
	_cfg = _config select _i;
	if(isClass _cfg) then {
		
		_spawnData = [];
		_entry = _cfg >> "Spawns";
		for "_i" from 0 to count(_entry)-1 do {
			_spawnData pushBack configName (_entry select _i);
		};
		
		_type = configName _cfg;

		{
			_index = _types find tolower _x;
			if(_index != -1) then {
				_hData = _data select _index;
				_vehicles = _hData select 2;
				_vehicles pushBack _type;
				_hData set[2,_vehicles];
				_data set[_index,_hData];

				if (_type isKindOf "Car") exitWith {_carList pushBack _type;};
				if (_type isKindOf "Ship") exitWith {_boatList pushBack _type;};
				if (_type isKindOf "Helicopter") exitWith {_heliList pushBack _type;};
				if (_type isKindOf "Plane") exitWith {_planeList pushBack _type;};
			};
		} forEach _spawnData;
	};
};


diag_log format["Getting all houses on map (%1)",diag_tickTime];
//--- get all houses on the map that can spawn vehicles in them
_housesOrdered = [];
for "_x" from 0 to ceil(worldsize/5000) do {
	for "_y" from 0 to ceil(worldsize/5000) do {
		_housesOrdered = _housesOrdered + (nearestObjects [[_x*5000,_y*5000],_types,6000]);
	};
};
_houses = [_housesOrdered] call BASE_fnc_shuffleArray; //--- randomize the order of which houses are spawned (effectively randomizes vehicle spawning locations)
diag_log format["Got all houses (%1)",diag_tickTime];


diag_log format["Spawning vehicles @ %1 houses",count(_houses)];
diag_log format["# Helipads: %1",{_x isKindOf "HeliH"} count(_houses)];
{
	if !(_x getVariable ["SpawnedV",false]) then {
		_x setVariable ["SpawnedV",true];
		if(_numVtoSpawn <= 0) exitWith {};
		_type = tolower typeof _x;
		_index = _types find _type;
		if(_index != -1) then {
			_hData = _data select _index;
			_locations = _hData select 0;
			_directions = _hData select 1;
			_vehicles = _hData select 2;

			if(_bikeLimit <= 0) then {_vehicles = _vehicles - ["DSR_Bike_Green_F","DSR_Bike_White_F"];}; //---vehicles is case sensitive
			if(_heliLimit <= 0) then {_vehicles = _vehicles - _heliList;};
			if(_planeLimit <= 0) then {_vehicles = _vehicles - _planeList;};
			if(_carLimit <= 0) then {_vehicles = _vehicles - _carList;};
			if(_boatLimit <= 0) then {_vehicles = _vehicles - _boatList;};
			
			_lIndex = floor(random(count(_locations))); //--- get location index

			_v = _vehicles select floor(random(count(_vehicles))); //--- get vehicle type we are spawning
			if(!isNil "_v") then {

				_location = _locations select _lIndex; //--- get offset of the spawn position
				_direction = _directions select _lIndex; //--- get vehicle direction additive

				_vDir = (getdir _x) + _direction;

				_posagl = _x modelToWorld _location;
				_posasl = AGLtoASL _posagl;
				
				// prevent vehicles from spawning where a DB vehicle spawned at
				_nearVehicles = nearestObjects [_posagl,["LandVehicle","Air","Ship"],5];
				if(count(_nearVehicles) == 0) then {
					
					_tv = _v createVehicle _posagl;
					
					// network sync textures
					{
						_tv setObjectTextureGlobal [_forEachIndex,_x];
					} foreach (getObjectTextures _tv);
					
					clearItemCargoGlobal _tv;
					clearMagazineCargoGlobal _tv;
					clearWeaponCargoGlobal _tv;
					clearBackpackCargoGlobal _tv;
					
					_pointdata = getAllHitPointsDamage _tv;
					if(count(_pointdata) > 1) then {
						_hitpoints = _pointdata select 0;
						{
							// no additional check needed since the check is done after reading the value from the config file
							_damage = random [_minDamage,_midDamage,_maxDamage];
							// convert percentage to value between 0 and 1
							_tv setHitPointDamage [_x, _damage/100];
						} forEach _hitpoints;
					};

					_fuel = _minFuel + (random (_maxFuel - _minFuel));
					_tv setFuel (_fuel / 100);

					_tv setdir _vDir;
					_tv setposasl _posasl;
					
					_tvs pushBack _tv;
					[_tv] call DB_fnc_spawnObject;

					_numVtoSpawn = _numVtoSpawn - 1;
					if(_v isKindOf "Car") exitWith {_carLimit = _carLimit - 1;};
					if(_v isKindOf "Bicycle") exitWith {_bikeLimit = _bikeLimit - 1;};
					if(_v isKindOf "Ship") exitWith {_boatLimit = _boatLimit - 1;};
					if(_v isKindOf "Helicopter") exitWith {_heliLimit = _heliLimit - 1;};
					if(_v isKindOf "Plane") exitWith {_planeLimit = _planeLimit - 1;};
				};
			};
		};
	};
} forEach _houses;
diag_log ("Spawned " + str(count(_tvs)) + " vehicle(s)");
uiSleep 3;
{	
	if(_x getVariable ["isCar",false]) then {
		_x enableSimulationGlobal false;
	};
} forEach _tvs;
diag_log "Done spawning vehicles";
DB_var_restoreObjectInProgress = false;
DS_var_finishedObjects = true;
call DS_fnc_checkServerLock;
