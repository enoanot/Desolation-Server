params["_zed","_zIndex"];

if(alive _zed) exitWith {};

// set data to empty array to represent a dead zombie & to not compromise other zIndex's on zombies
DSZ_var_spawnData set[_zIndex,[]]; 

// delete dead body from spawnedZeds array
_index = (DSZ_var_spawnedZeds find _zed);
if(_index > -1) then {
	DSZ_var_spawnedZeds deleteAt _index;
};
_zed setVariable ["diedAt",diag_tickTime]; //mark zombie for cleanup

[_zed] spawn {
	params ["_zed"];

	waitUntil{(toLower (animationState _zed)) isEqualTo "dsr_zomb_die"};
	sleep 2;
	removeUniform _zed;
	
	_zedType = typeOf _zed;
	_data = (_zedType splitString "_");
	_newUniform = "dsr_uniform_"+ toLower(_data select 2) + "_" + (_data select 3);
	/*_zed forceAddUniform _newUniform;


	_cfg = (configFile >> "CfgZombies" >> (typeOf _zed) >> "Loot");
	_maxItems = getNumber(_cfg >> "MaxItems");
	_minItems = getNumber(_cfg >> "MinItems");
	_items = getArray(_cfg >> "Items");
	if(_maxItems > 0) then {
		_itemCount = random(_maxItems);
		if(_maxItems < _minItems) then {_itemCount = _minItems + (random(_maxItems - _minItems));};

		for "_i" from 0 to ((round (_itemCount)) - 1) do {
			if(_items isEqualTo []) exitWith {};

			_item = selectRandom _items;
			_zed addItem _item;
			_items = _items - [_item];
		};
	} else {
		{
			_zed addItem _x;
		} forEach _items;
	};*/
};