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

params ["_hitPoint","_object","_index","_player","_class","_group"];

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
	if (({tolower(_x) == tolower(_item)} count (magazines _player)) < 1) exitWith {
		_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName");
		[("Item(s) missing: " + _displayName + ", count: " + str(_count))] remoteExec ["systemChat",_player];
		_haveRequiredItems = false;
	};
    true
} count _required;
if !(_haveRequiredItems) exitWith {};
	
_currentDamage = _object getHitPointDamage _hitPoint;

if (_currentDamage > 0) then {
	{
		_requiredItem = _x;
		_dpp = (1 / (_requiredItem select 1));
		if (_dpp < 1) then {	// is it a tool (better check?)
			for "_i" from 1 to (_requiredItem select 1) do {
				_player removeItem (_requiredItem select 0);	// remove part from player
				_currentDamage = _currentDamage - _dpp;	// calculate new damage
				if (_currentDamage < 0) exitWith {	// check if fully repaired
					_currentDamage = 0;
					[_object, [_hitPoint, 0]] remoteExec ["setHitPointDamage", 0];
				};
				[_object, [_hitPoint, _currentDamage]] remoteExec ["setHitPointDamage", 0];
			};
		} else {
			_player removeItem (_requiredItem select 0);	
		};
	} foreach _required;

	{
		_player addItem (_x select 0);
	} forEach _returned;

	[("Part repaired successfully")] remoteExec ["systemChat",_player];
} else {
    [("Part is already fully repaired")] remoteExec ["systemChat",_player];
};

true