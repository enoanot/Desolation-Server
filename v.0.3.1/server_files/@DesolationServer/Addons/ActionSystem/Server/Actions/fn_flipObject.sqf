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

// Get parameters
_actionGroup = ACT_var_ACTIONS select _group;
_actionInfo = _actionGroup select 2;
_required = [];
{
	_aCondition = _x select 0;
	_aText = _x select 1;
	_aCode = _x select 2;
	_aParameters = _x select 3;
		
	if (_class == _aText) exitWith {
		_required = _aParameters select 0;
	};
		
} forEach _actionInfo;


// Check required items
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
if !(_haveRequiredItems) exitwith {};


// Flip vehicle
_mass = getMass _object;
if ((_mass < 400) && (alive _object)) then {	// don't flip destroyed vehicles
	_object setPosATL [(getPosATL _object) select 0, (getPosATL _object) select 1, ((getPosATL _object) select 2) + 0.1];

	if (abs(getTerrainHeightASL (position _object)) - ((getPosASL _object) select 2) < 1) then {
		_object setVectorUp (surfaceNormal [(getPosATL _object) select 0, (getPosATL _object) select 1]);
		_object setPosATL [(getPosATL _object) select 0, (getPosATL _object) select 1, 0];
	} else {
		_object setVectorUp [0,0,1];
		_object setPosATL [(getPosATL _object) select 0, (getPosATL _object) select 1, ((getPosATL _object) select 2)];
	};

	[("Object flipped successfully")] remoteExec ["systemChat",_player];
} else {
	[("Object is too heavy or its destroyed")] remoteExec ["systemChat",_player];
};

true;