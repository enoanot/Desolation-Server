params["_group"];

if(isNil "_group") exitWith {};
_animalIndex = _group getVariable ["animalGroupIndex",-1];
if(_animalIndex == -1) exitWith {};

_animalData = (ANIM_var_spawnData select _animalIndex);
_groupSize = (_animalData select 1); // Get Current Group Size

if (_groupSize > 1) then {
	
	_groupSize = _groupSize - 1;
	_animalData set [1,_groupSize]; // Update Group Size
	ANIM_var_spawnData set [_animalIndex,_animalData]; // Update Animal Spawn Data

} else {

	// set data to empty array to represent a dead animals & to not compromise other animalIndex's on animals
	ANIM_var_spawnData set [_animalIndex,[]]; 

	// delete group from spawnedAnimals array
	_index = (ANIM_var_spawnedGroups find _group);
	if (_index > -1) then {
		ANIM_var_spawnedGroups deleteAt _index;
	};

	deleteGroup _group;
};

true;