

ANIM_var_spawnedGroups = []; // all alive animal groups
ANIM_var_spawnData = []; // information on all animal spawns


ANIM_var_finished = true;

// ANIM_fnc_spawnAnimalFnc = ANIM_fnc_insertAnimal; // overridable function for animal spawns in desolation

// wait for map edits to finish loading
waitUntil {BASE_var_MapEditsDone};

ANIM_var_config = call ANIM_fnc_readConfig;
[ANIM_var_config] call ANIM_fnc_selectLocations;

[] spawn ANIM_fnc_spawnManager;