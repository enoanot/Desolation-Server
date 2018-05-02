
_animals = [];

_cfg = configFile >> "CfgAnimals";
for "_i" from 0 to (count(_cfg) - 1) do {
	_class = _cfg select _i;
	if (isClass _class) then {
		_animalClassName = configName _class;

		_maxGroupSize = getNumber (_class >> "MaxGroupSize");
		if(isNil "_maxGroupSize") then {
			_maxGroupSize = round(random(3));
			diag_log format ["ANIMALS > Error, no MaxGroupSize defined! Reseted to: %1",_maxGroupSize];
		};
		_minGroupSize = getNumber (_class >> "MinGroupSize");
		if(isNil "_minGroupSize") then {
			_minGroupSize = 0;
			diag_log format ["ANIMALS > Error, no MinGroupSize defined! Reseted to: %1",_minGroupSize];
		};
		
		_groupSize = (random _maxGroupSize);
		if (_groupSize < _minGroupSize) then {_groupSize = _minGroupSize + (random (_maxGroupSize - _minGroupSize));};
		_groupSize = ceil(_groupSize);
		//TODO: more settings?
			
		_animals pushBack [_animalClassName,_groupSize];
	};
};
_animals;