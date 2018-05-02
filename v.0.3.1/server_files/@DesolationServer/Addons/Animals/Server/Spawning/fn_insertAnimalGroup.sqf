params["_location","_class","_groupSize"];

_animalType = selectRandom ANIM_var_config;
if(isNil "_class") then {_class = _animalType select 0;};
if(isNil "_groupSize") then {_groupSize = _animalType select 1;};

_animalIndex = count (ANIM_var_spawnData);
_holder = [_animalIndex,_location] call ANIM_fnc_createHolder;
ANIM_var_spawnData pushback [_class,_groupSize,_location,_holder];

[_class,_groupSize,_location,_holder];