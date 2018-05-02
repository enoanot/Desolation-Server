/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */
 
// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)

params ["_object","_player","_class","_group"];

// get parameters
_actionGroup = ACT_var_ACTIONS select _group;
_actionInfo = _actionGroup select 2;
_required = [];
_returned = [];
{
	_aCondition = _x select 0;
	_aText = _x select 1;
	_aCode = _x select 2;
	_aParameters = _x select 3;
		
	if (_class == _aText) exitWith {
		_required = _aParameters select 0;
	};
} forEach _actionInfo;


// Check for required items
_haveRequiredItems = true;
{
	_item = _x select 0;
	_count = _x select 1;

	if( ({tolower(_x) == tolower(_item)} count (magazines _player)) < 1) exitWith {
		_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName");
		[("Item(s) missing: " + _displayName + ", count: " + str(_count))] remoteExec ["systemChat",_player];
		_haveRequiredItems = false;
	};
true
} count _required;
if !(_haveRequiredItems) exitWith {};


// Get returned items
_type = typeOf _object;
if (_type isEqualTo "Rabbit_F") then {
	_returned = [["DSR_Item_Beef",2], ["DSR_Item_Leather",1]];
} else {
	if ((_type isEqualTo "Hen_random_F") || (_type isEqualTo "Cock_random_F") || (_type isEqualTo "Cock_white_F")) then {
		_returned = [["DSR_Item_Beef",2], ["dsr_item_feathers",5]];
	} else {
		if (_type isEqualTo "Cow") then {
			_returned =  [["DSR_Item_Beef",5], ["DSR_Item_Leather",5]];
		} else {
			if ((_type isEqualTo "Sheep_random_F") || (_type isEqualTo "Goat_random_F")) then {
				_returned = [["DSR_Item_Beef",4], ["DSR_Item_Leather",3]];
			} else {
				_returned = [["DSR_Item_Beef",3], ["DSR_Item_Leather",3]];
			};
		};
	};
};


// Check for nearby loot holders
_lootHolder = objNull;
_nearLootHolders = _player nearObjects ["GroundWeaponHolder", 5];
if ((count _nearLootHolders) != 0) then {
	_distance = 5;
	{
		_tmpDist = _player distance _x;
		if (_tmpDist < _distance) then
		{
			_lootHolder = _x;
			_distance = _tmpDist;
		};
		true
	} count _nearLootHolders;
};

// Create new loot holder
if (isNull _lootHolder) then {
	_lootHolder = createVehicle ["GroundWeaponHolder", _object modelToWorld [0,0.8,0], [], 0.5, "CAN_COLLIDE"];
	_lootHolder setDir (random 360);	
};


// Add items to loot holder
if (count _returned != 0) then {
	{
		_lootHolder addItemCargoGlobal _x;
	} forEach _returned;
};
_player reveal _lootHolder;

_object remoteExecCall ["deleteVehicle", -2, _player];
deleteVehicle _object;

true