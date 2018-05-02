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

/// broadcast config data

diag_log "<ActionSystem>: Begin Collecting Config Data";

ACT_var_ACTIONS = [];
ACT_var_ICONS = [];

_cfg = configFile >> "Cfg3DActions";
for "_i" from 0 to count(_cfg)-1 do {
	
	_group = _cfg select _i;
	
	if(isClass _group) then {
		_condition = getText(_group >> "condition");
		_type = getNumber(_group >> "renderType");
		
		_actions = _group >> "Actions";
		
		_actionData = [];
		for "_j" from 0 to count(_actions)-1 do {
			_action = _actions select _j;
			
			if(isClass _action) then {
				
				_aCondition = getText(_action >> "condition");
				_aText = getText(_action >> "text");
				_aCode = getText(_action >> "action");
				_aParametersClass = _action >> "Parameters";
				_aParameters = [];
				_aRequiredItems = [];
				_aReturnedItems = [];
				_aRequiredItems = getArray(_aParametersClass >> "requiredItems");
				_aReturnedItems = getArray(_aParametersClass >> "returnedItems");
				
				_aParameters = [_aRequiredItems,_aReturnedItems];
				
				//diag_log format ["<ActionSystem>: (Debug) _aParameters = %1", _aParameters];
										
				_actionData pushBack [_aCondition,_aText,_aCode,_aParameters];
			};
		};
		ACT_var_ACTIONS pushBack [_condition,_type,_actionData];
	};
};

diag_log "<ActionSystem>: Finished Collecting Action Data";

_cfg = configFile >> "Cfg3DIcons";
for "_i" from 0 to count(_cfg)-1 do {
	
	_group = _cfg select _i;
	
	if(isClass _group) then {
		
		_name = getText(_group >> "name");
		_icon = getText(_group >> "icon");
		ACT_var_ICONS pushBack [configName _group,_name,_icon];
	};
};

diag_log "<ActionSystem>: Finished Collecting Icon Data";

publicVariable "ACT_var_ACTIONS";
publicVariable "ACT_var_ICONS";
