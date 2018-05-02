params["_animalIndex","_position"];

_animalHolder = "DSR_Object_Blank_Cube" createVehicle [0,0,0];
_animalHolder enableSimulationGlobal false;
_animalHolder hideObjectGlobal true;
_animalHolder setVariable ["animalGroupIndex",_animalIndex];
_animalHolder setVariable ["isSpawnedAnimalGroup",false];
_animalHolder setPosATL _position;

_animalHolder;