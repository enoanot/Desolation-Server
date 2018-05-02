
params["_config"];




_DSZ_fnc_FindSafePos = {
	params["_posATL","_radius","_onFailATL"];
	
	_x = _posATL select 0;
	_y = _posATL select 1;
	
	_newPos = [0,0];
	_found = false;
	for "_i" from 1 to 3000 do {
		_nX = _x + (_radius - (random (_radius * 2)));
		_nY = _y + (_radius - (random (_radius * 2)));
		
		_newPos = [_nX,_nY,0];
		_result = _newPos isFlatEmpty [1];
		if(count(_result) > 0) exitWith {
			_found = true;
		};
	};
	
	if(!_found) then {
		diag_log "DSZombz: (FATAL ERROR) Failed to find a valid spawn location for zombie, default used";
		_newPos = _onFailATL;
	};
	_newPos;
};



_Random_Zombies = call compile (["Random_Zombies","DSZ"] call BASE_fnc_getCfgValue);


_locations = ["Airport","NameCityCapital","NameCity","NameVillage","NameLocal"]; //,"NameMarine" removed because it was spawning zombies on beaches
_zombieData = [];

{
	_allLocations = nearestLocations [[worldSize/2,worldSize/2,0], [_x], worldSize];
	_NumZombies = call compile (["Zombies_" + _x,"DSZ"] call BASE_fnc_getCfgValue);
	//_SpawnRadius = call compile (["Radius_" + _x,"DSZ"] call BASE_fnc_getCfgValue); // spawn radius no longer used, location size determines it
	
	{
		_position = locationPosition _x;
		_size = ((size _x select 0) max (size _x select 1))*1.5; //multiply by 1.5 to solve small location sizes
		
		if !(_position isEqualTo []) then {
			if !(_position isEqualto [0,0,0]) then {
				_roads = _position nearRoads _size;
				_posOnFail = _position;
				
				for "_i" from 1 to _NumZombies do {
					if(count(_roads) > 0) then {
						_road = selectRandom _roads;
						_posOnFail = getPosATL _road;
					};
					
					
					_zedPosition = [_position,_size,_posOnFail] call _DSZ_fnc_FindSafePos;
					
					_zType = selectRandom _config;
					_zombieData pushback [_zType select 0,_zedPosition,_zType select 1,_position,_size];
				};
			};	
		};
		true
	} count _allLocations;
	true
} count _locations;


// Random zombie locations (in jungle)
for "_i" from 1 to _Random_Zombies do {
	_pos = [0,0,0];
	while{true} do {
		_pos = [random(worldSize),random(worldSize),0];
		if !(surfaceIsWater _pos) exitWith {
			_zType = selectRandom _config;
			_zombieData pushback [_zType select 0,_pos,_zType select 1,_pos,100];
		};
	};
};


DSZ_var_spawnData = _zombieData;

//create holder objects
{
	_holder = [_forEachIndex,(_x select 1)] call DSZ_fnc_createHolder;
	_newArray = +_x;
	_newArray pushBack _holder;
	DSZ_var_spawnData set[_forEachIndex,_newArray];
} forEach DSZ_var_spawnData;

DSZ_var_doneSpawning = true;











