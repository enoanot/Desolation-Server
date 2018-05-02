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

 // on craft button click
 // check requirements
 // close dialog
 // play stopable crafting animation
 // remove requirements
 // add item

[] spawn {
	 
	_groupIndex = missionNamespace getVariable["CURRENT_GROUP_INDEX",0];
	_currentIndex = missionNamespace getVariable["CURRENT_INDEX",0];

	_craftableData = missionNamespace getVariable ["CFG_CRAFTABLE_DATA",[]];
	_craftableGroups = missionNamespace getVariable ["CFG_CRAFTABLE_GROUPS",[]];

	_craftables = _craftableData select _groupIndex;

	_entry = _craftables select _currentIndex;
	_cInput = _entry select 0;
	_cOutput = _entry select 1;
	_cRequiredBuildings = _entry select 2;
	_cName = _entry select 3;
	_cDesc = _entry select 4;
	_cPreview = _entry select 5;
	_cCondition = _entry select 5;

	_hasRequirements = true;
	{
		_item = _x select 0;
		_count = _x select 1;
		if( ({tolower(_x) == tolower(_item)} count (magazines player)) < _count) exitWith {
			systemchat ("Does not have: " + _item + " @ count: " + str(_count));
			_hasRequirements = false;
		};
		true
	} count _cInput;
	if(!_hasRequirements) exitWith {systemchat "You do not have the items required to craft this!"};

	_objects = nearestObjects [player, _cRequiredBuildings, 5];

	_bTemp = +_cRequiredBuildings;
	{
		if(count(_bTemp) == 0) exitWith {};
		_class = typeof _x;
		if(_class in _bTemp) then {
			_bTemp = _bTemp - [_class];
		};
		true;
	} count _objects;

	if(count(_bTemp) > 0) exitWith {systemchat "You are not near the buildings required to craft this!"};

	if(isNil 'ds_var_doingCraft') then {
		ds_var_doingCraft = false;
	};
	if(ds_var_doingCraft) exitWith {systemchat "You are already crafting something!";false};
	
	ds_var_cancelCraft = false;
	ds_var_doingCraft = true;
	_event = (findDisplay 46) displayAddEventHandler ["KeyDown",{
		_key = _this select 1;
		if((_key in (actionKeys "MoveForward")) || (_key in (actionKeys "MoveBack")) || (_key == 30) || (_key == 32) || !(player == vehicle player)) then {
			ds_var_cancelCraft = true;
		};
		false;
	}];
	_time = diag_tickTime + 3;
	player playActionNow "Medic";
	waitUntil{diag_tickTime >= _time || ds_var_cancelCraft};
	[player,"amovpknlmstpsraswrfldnon"] remoteExecCall ["switchMove",-2];
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_event];
	ds_var_doingCraft = false;
	if(ds_var_cancelCraft) exitWith {systemchat "DEBUG: canceled crafting";false};

	{
		for "_i" from 1 to (_x select 1) do {
			player removeMagazine (_x select 0);
		};
		true
	} count _cInput;
	{
		for "_i" from 1 to (_x select 1) do {
			player addMagazine (_x select 0);
		};
		true
	} count _cOutput;
	[1] call DS_fnc_addPoints;
	["DS_var_craftDoneCallbackFnc",["items_crafted",[_cName]]] call DS_fnc_handleCallback;
	systemchat ("Crafted: " + _cName);
};
