
params["_container","_loot",["_removeOldItems",false]];
private["_containerdata","_magazines","_items","_weapons","_backpacks","_alreadySpawnedContainers","_cType","_cLoot"];

_containerdata = _loot select 0;
_magazines = _loot select 1;
_items = _loot select 2;
_weapons = _loot select 3;
_backpacks = _loot select 4;

if(_removeOldItems) then {
	clearMagazineCargoGlobal _container;
	clearWeaponCargoGlobal _container;
	clearBackpackCargoGlobal _container;
	clearItemCargoGlobal _container;
};

// Magazines
[_container,_magazines] call BASE_fnc_setMagCargo;

// Items
[_container,_items] call BASE_fnc_setItemCargo;

// Weapons
[_container,_weapons] call BASE_fnc_setWepCargo;

// Backpacks
[_container,_backpacks] call BASE_fnc_setBackpackCargo;

// Container Data
_alreadySpawnedContainers = [];
{
	_cType = _x select 0;
	_cLoot = _x select 1;

	{
		if((_x select 0) == _cType) then {
			if !((_x select 1) in _alreadySpawnedContainers) then {
				_alreadySpawnedContainers pushBack (_x select 1);
				if(count(_cLoot) > 0) then { //this should never trigger tho... (this does trigger when everyContainer is an empty [])
					[_x select 1,_cLoot] call BASE_fnc_setAllCargo;
				} else {
					systemchat "SET LOOT ERROR: empty container loot array, wtf?";
				};
			};
		};
	} forEach (everyContainer _container);

} forEach _containerdata;

true;