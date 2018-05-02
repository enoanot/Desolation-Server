/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 - 2018 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */
 
// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)

params ["_object","_player","_class","_group"];
private["_actionInfo","_actionGroup","_returned","_required","_haveRequiredItems","_object","_player","_displayName","_distance","_newItem","_item","_itemClass","_count","_newCount","_parts"];

if ((damage _object) == 0) then {

	// get parameters
	_actionGroup = ACT_var_ACTIONS select _group;
	_actionInfo = _actionGroup select 2;
	_actionInfo = +(_actionGroup select 2);

    _required = [];
	_returned = [];
	{
		_aCondition = _x select 0;
		_aText = _x select 1;
		_aCode = _x select 2;
		_aParameters = _x select 3;
		if (_class == _aText && (!isNil "_aParameters")) exitWith {
			_required = _aParameters select 0;
			_returned = _aParameters select 1;
		};
	} forEach _actionInfo;


	// check if player has required items
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


	// if object is building get returned items
	if !(_object isKindOf "AllVehicles") then {

		//get returned items if object is building (divide returned items with 2)
		_parts = _object getVariable ["SVAR_Parts",[]];
		if !(_parts isEqualTo []) then {
			for "_i" from 0 to (count(_parts) - 1) do {

				_item = _parts select _i;
				_itemClass = _item select 0;
				_count = _item select 1;

				_newCount = round((_count) / 2);
				_newItem = [_itemClass,_newCount];

				_returned pushBack _newItem;
			};
		} else {
			if((_object isKindOf "DSR_Tent_A_F") || (_object isKindOf "DSR_Tent_Dome_F")) then {
				if(_object isKindOf "DSR_Tent_A_F") then {
					_returned pushBack ["DSR_Item_Tent_A_Packed",1];
				} else {
					_returned pushBack ["DSR_Item_Tent_Dome_Packed",1];
				};
			};
		};
	};


	// If returned is [] don't create holder
	if!(_returned isEqualTo []) then {

		// check if loot holder already nearby
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
		if (isNull _lootHolder) then {
			_lootHolder = createVehicle ["GroundWeaponHolder", _player modelToWorld [0,0.8,0], [], 0.5, "CAN_COLLIDE"];
			_lootHolder setDir floor (random 360);
			_lootHolder setDir (random 360);
		};

		// place items to lootholder
		if (count _returned != 0) then {
			{
				_lootHolder addItemCargoGlobal _x;
			} forEach _returned;
			_player reveal _lootHolder;
		};
	};
	
	
	// delete object
	[_object,objNull] call DB_fnc_killObject;
	deleteVehicle _object;
	
	[("Object disassembled successfully")] remoteExec ["systemChat",_player];
} else {
    [("Object is too damaged")] remoteExec ["systemChat",_player];
};

true