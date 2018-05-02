//reduces total battery cells by one (total ammo of lipo batteries)


_classname = "DSR_Item_Battery_Charged";


_totalAmmo = 0;
{
	_class = _x select 0;
	_count = _x select 1;
	if(_class == _classname) then {
		_totalAmmo = _totalAmmo + _count;
	};
} forEach (magazinesAmmo player);

if(_totalAmmo == 0) exitWith {};

player removeMagazine _classname;


_newAmmo = 0;
{
	_class = _x select 0;
	_count = _x select 1;
	if(_class == _classname) then {
		_newAmmo = _newAmmo + _count;
	};
} forEach (magazinesAmmo player);


_ammoToAdd = _totalAmmo - _newAmmo - 1;

if(_ammoToAdd <= 0) exitWith {};

_ammoCount = getNumber(configFile >> "CfgMagazines" >> _classname >> "count");
_magMass = getNumber(configFile >> "CfgMagazines" >> _classname >> "mass");


if(_ammoToAdd > _ammoCount) then {
	_ammoToAdd = _ammoCount;
};

_container = uniformContainer player;
_totalMass = getContainerMaxLoad (uniform player);
_usedMass = (loadUniform player)*_totalMass;
_remainingMass = _totalMass - _usedMass;

if(_remainingMass > _magMass) then {
	_container addMagazineAmmoCargo [_classname,1,_ammoToAdd];
} else {
	_container = vestContainer player;
	_totalMass = getContainerMaxLoad (vest player);
	_usedMass = (loadVest player)*_totalMass;
	_remainingMass = _totalMass - _usedMass;
	
	if(_remainingMass > _magMass) then {
		_container addMagazineAmmoCargo [_classname,1,_ammoToAdd];
	} else {
		_container = backpackContainer player;
		_container addMagazineAmmoCargo [_classname,1,_ammoToAdd];
	};
};