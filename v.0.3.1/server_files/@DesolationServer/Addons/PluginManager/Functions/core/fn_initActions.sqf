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

_config = configFile >> "CfgPluginActions";

_USER_ACTIONS = [];
for "_i" from 0 to count(_config)-1 do {
	
	_ACTION_GROUP = [];

	_entry = _config select _i;
	_actions = _entry >> "Actions";
	_menuName = getText(_entry >> "Text");
	_conditional = "params['_player','_vehiclePlayer','_cursor'];" + getText(_entry >> "Condition");
	
	_ACTION_GROUP pushBack _menuName;
	_ACTION_GROUP pushBack compile _conditional;
	
	_ACTION_GROUP_ACTIONS = [];
	for "_j" from 0 to count(_actions)-1 do {
		_action = _actions select _j;
		
		_text = getText(_action >> "text");
		_condition = "[player,vehicle player,cursorObject] call {params['_player','_vehiclePlayer','_cursor'];" + getText(_action >> "condition") + "};";
		_aCode = getText(_action >> "action");
		
		_ACTION_GROUP_ACTIONS pushBack [_text,_condition,_aCode];
	};
	_ACTION_GROUP pushBack _ACTION_GROUP_ACTIONS; 
	_USER_ACTIONS pushBack _ACTION_GROUP;
};
BASE_VAR_ACTIONS = compileFinal str(_USER_ACTIONS);
publicVariable "BASE_VAR_ACTIONS";