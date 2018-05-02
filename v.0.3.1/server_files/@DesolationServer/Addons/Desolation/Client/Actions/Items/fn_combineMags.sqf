//fn_mergeMagazines 

params["_classname"];
_ammoCount = getNumber(configFile >> "CfgMagazines" >> _classname >> "count");
_totalAmmo = 0;
{
	_class = _x select 0;
	_count = _x select 1;
	if(_class == _classname) then {
		_totalAmmo = _totalAmmo + _count;
		player removeMagazine _class;
	};
} forEach (magazinesAmmo player);


_magMass = getNumber(configFile >> "CfgMagazines" >> _classname >> "mass");


_numMags = ceil(_totalAmmo/_ammoCount);
for "_i" from 1 to _numMags do {
	_container = uniformContainer player;
	_totalMass = getContainerMaxLoad (uniform player);
	_usedMass = (loadUniform player)*_totalMass;
	_remainingMass = _totalMass - _usedMass;
	
	if(_remainingMass > _magMass) then {
		_container addMagazineAmmoCargo [_classname,1,_ammoCount min _totalAmmo];
	} else {
		_container = vestContainer player;
		_totalMass = getContainerMaxLoad (vest player);
		_usedMass = (loadVest player)*_totalMass;
		_remainingMass = _totalMass - _usedMass;
		
		if(_remainingMass > _magMass) then {
			_container addMagazineAmmoCargo [_classname,1,_ammoCount min _totalAmmo];
		} else {
			_container = backpackContainer player;
			_container addMagazineAmmoCargo [_classname,1,_ammoCount min _totalAmmo];
		};
	};
	_totalAmmo = _totalAmmo - _ammoCount;
};

["DS_var_magsCombinedCallbackFnc",["mags_combined",[_classname]]] call DS_fnc_handleCallback;