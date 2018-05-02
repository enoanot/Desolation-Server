params["_group"];


if(isNull _group) exitWith {diag_log "ANIMALS > Can't despawn unknown animal!";};


_animalIndex = _group getVariable ["animalGroupIndex",-1];

// update group position in spawnData
_animalData = ANIM_var_spawnData select _animalIndex;
_animalData set [2,getPosATL (leader _group)];
ANIM_var_spawnData set [_animalIndex,_animalData];


// Update spawned groups
ANIM_var_spawnedGroups deleteAt (ANIM_var_spawnedGroups find _group);


//update holder
_holder = _animalData select 3;
_holder setPosATL (_animalData select 2);
_holder setVariable ["isSpawnedAnimalGroup",false];

{
	deleteVehicle _x;
} forEach (units _group);
	
true;