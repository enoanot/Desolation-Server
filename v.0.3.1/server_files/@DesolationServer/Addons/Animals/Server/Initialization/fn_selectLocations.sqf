params ["_config"];

ANIM_var_spawnData = [];

_NumAnimalGroups = (["AmountOfGroups","ANIM"] call BASE_fnc_getCfgNumber);
_index = 0;

while {_NumAnimalGroups > 0} do {
	_position = [random(worldSize),random(worldSize),0];
	if !(surfaceIsWater _position) then {
		_animalType = selectRandom _config;

		_holder = [_index,_position] call ANIM_fnc_createHolder;
		ANIM_var_spawnData pushback [_animalType select 0,_animalType select 1,_position,_holder];

		_NumAnimalGroups = _NumAnimalGroups - 1;
		_index = _index + 1;
	};
};

ANIM_var_doneSpawning = true;