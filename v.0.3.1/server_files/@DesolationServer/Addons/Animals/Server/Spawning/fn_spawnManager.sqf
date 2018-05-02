
while {true} do {

	{
		_animalIndex = _x getVariable ["animalGroupIndex",-1];
		if !([_x] call ANIM_fnc_isPlayerNear) then {
			_holder = ((ANIM_var_spawnData select _animalIndex) select 3);
			if(_holder getVariable ["isSpawnedAnimalGroup",false]) then { // if animal is not despawned
				[_x] call ANIM_fnc_despawnAnimalGroup; // if no player is near, despawn
			};
		};
	} forEach ANIM_var_spawnedGroups;
	uiSleep 1;
	
	
	{
		_player = _x;
		if (alive _player) then {
			_nearAnimalHolders = _player nearObjects ["DSR_Object_Blank_Cube",250];
			{
				_animalHolder = _x;
				if !(_animalHolder getVariable ["isSpawnedAnimalGroup",false]) then {
					[_animalHolder] call ANIM_fnc_spawnAnimalGroup;
				};
			} forEach _nearAnimalHolders;
		};
	} forEach allPlayers;
	uiSleep 1;
};