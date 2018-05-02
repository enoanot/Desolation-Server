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

_actionGroup = ACT_var_ACTIONS select _group;
_actionInfo = _actionGroup select 2;

_required = [];
_returned = [];
_can = [];
_canNo = 0;

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


_haveRequiredItems = false;
_tmpCanNo = 0;
{
	_item = _x select 0;
	if (({tolower(_x) == tolower(_item)} count (magazines _player)) > 0) exitWith {
		_can = _item;
		_canNo = _tmpCanNo;
		_haveRequiredItems = true;
	};
	_tmpCanNo = _tmpCanNo + 1;
    true
} count _required;
if !(_haveRequiredItems) exitWith {[("You don't have the required Items")] remoteExec ["systemChat",_player];};


_player removeItem _can;
_tmpCanNo = 0;
{
	if (_tmpCanNo == _canNo) exitWith {
		_player addItem (_x select 0);
	};
	_tmpCanNo = _tmpCanNo + 1;
	true
} count _returned;
[("Item filled successfully")] remoteExec ["systemChat",_player];

true
