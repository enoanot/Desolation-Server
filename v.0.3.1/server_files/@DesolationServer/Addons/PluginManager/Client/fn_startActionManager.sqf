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

waitUntil{!isnil "BASE_VAR_ACTIONS"};
_groups = call BASE_VAR_ACTIONS;
while{true} do {
	{
		_INDEX_NUM = _forEachIndex;
		_text = _x select 0;
		_condition = _x select 1;
		_actions = _x select 2;
		if([player,vehicle player,cursorObject] call _condition) then {
			_uActions = missionNamespace getVariable ["ACTIONS_" + str _INDEX_NUM,[]];
			if(_uActions isEqualTo []) then {
				{
					_aText  = _x select 0;
					_aCondition = _x select 1;
					_aAction = _x select 2;
					_uActions pushback (player addAction [_aText,_aAction,[],0,false,true,"",_aCondition,2]);
				} forEach _actions;
				missionNamespace setVariable ["ACTIONS_" + str _INDEX_NUM,_uActions];
			};
		} else {
			_uActions = missionNamespace getVariable ["ACTIONS_" + str _INDEX_NUM,[]];
			if !(_uActions isEqualTo []) then {
				{
					player removeAction _x;
				} forEach _uActions;
				missionNamespace setVariable ["ACTIONS_" + str _INDEX_NUM,[]];
			};
		};
	} forEach _groups;
	uiSleep 0.01;
};