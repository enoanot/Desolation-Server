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

params ["_hitPoint","_object","_player","_class","_group"];


_currentLevel = _player getVariable ["PVAR_DS_Progression_Mechanical_Level",0];
_luckChance = (_object getHitPointDamage _hitPoint) - ((_currentLevel) * (0.07));
_luck = random 1;

if (_luck > _luckChance) then {

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
			_returned = _aParameters select 1;
		};	
	} forEach _actionInfo;


	_haveRequiredItems = true;
	{
		_item = _x select 0;
		_count = _x select 1;
		if (({tolower(_x) == tolower(_item)} count (magazines _player)) < _count) exitWith {
			_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName");
			[("Item(s) missing: " + _displayName + ", count: " + str(_count))] remoteExec ["systemChat",_player];
			_haveRequiredItems = false;
		};
  	  true
	} count _required;
	if !(_haveRequiredItems) exitWith {};

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
	};

	if (count _returned != 0) then {
		{
			_lootHolder addItemCargoGlobal _x;
		} forEach _returned;
	};
	_player reveal _lootHolder;
	
	[("Part removed successfully")] remoteExec ["systemChat",_player];
	[_object, [_hitPoint, 1]] remoteExec ["setHitPointDamage", 0];
} else {
	[("Part broke when trying to remove it")] remoteExec ["systemChat",_player];
	[_object, [_hitPoint, 1]] remoteExec ["setHitPointDamage", 0];
};

true