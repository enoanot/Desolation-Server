
_zombies = [];

_cfg = configFile >> "CfgZombies";
for "_i" from 0 to count(_cfg)-1 do {
	_class = _cfg select _i;
	if(isClass _class) then {
		_zedClassName = configName _class;
		_agroMode = getText(_class >> "AgroMode");
		//TODO: more settings?
			
		_zombies pushBack [_zedClassName,_agroMode];
	};
};
_zombies;