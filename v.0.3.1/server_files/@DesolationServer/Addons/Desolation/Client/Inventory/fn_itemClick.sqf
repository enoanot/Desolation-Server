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

_BUTTON_W = 0.25;
 
disableSerialization;
params["_params"];
call ds_fnc_closebuttons;
_display = findDisplay 602;
if(isNull _display) exitWith {systemchat "ERROR: displayNull";};

_buttonY = safeZoneY + (safeZoneH/2) - (385*pixelH*pixelGridBase/18);
_buttonX = safeZoneX + (safeZoneW/2) + (395*pixelW*pixelGridBase/18);

_ctrl = _params select 0;
_item = _params select 1;
if(isNull _ctrl) exitWith {systemchat "ERROR: ctrlNull 2";};


_classname = _ctrl lbData _item;
_itemtext = _ctrl lbText _item;
_cursor = typeof cursorObject;
_cursorStr = str cursorObject;

_actions = configFile >> "CfgMagazines" >> _classname >> "Actions";
_bIndex = 0;
_buttons = [];

_replace = {
	params["_string","_search","_replace"];
	private["_index","_sub1","_sub2","_nString"];
	_index = _string find _search;
	if(_index == -1) exitWith {_string};
	_sub1 = _string select [0,_index];
	_sub2 = _string select [_index+count(_search)];
	_nString = _sub1 + _replace + _sub2;
	_nString;
};


_ammoCount = getNumber(configFile >> "CfgMagazines" >> _classname >> "count");
if(_ammoCount > 1) then {
	_numMags = ({_x == _classname} count (magazines player));
	if(_numMags > 1) then {
		_bY = _buttonY + (0.042*_bIndex);
		_bH = 0.04;
		_bW = _BUTTON_W;
		_bX = _buttonX;
		_bIndex = _bIndex + 1;
		_ctrl = _display ctrlCreate ["RscButton",-1];
		_ctrl ctrlSetPosition [_bX,_bY,_bW,_bH];
		_ctrl ctrlSetText "Combine Mags";
		_ctrl buttonSetAction ("[] spawn ds_fnc_closebuttons;_classname = """ + _classname + """; [_classname] call DS_fnc_CombineMags");
		_ctrl ctrlCommit 0;
		
		_buttons pushBack _ctrl;
	};
};

if(isClass _actions) then {
	for "_i" from 0 to count(_actions)-1 do {
		_action = _actions select _i;
		if(isClass _action) then {
			_aText = getText(_action >> "text");
			_aText = [_aText,"%itemname%",_itemtext] call _replace;
			_aText = [_aText,"%targetname%",name cursorObject] call _replace;
			
			_condition = getText(_action >> "condition");
			_action = getText(_action >> "action");
			if(call compile _condition) then {
				_bY = _buttonY + (0.042*_bIndex);
				_bH = 0.04;
				_bW = _BUTTON_W;
				_bX = _buttonX;
				_bIndex = _bIndex + 1;
				_ctrl = _display ctrlCreate ["RscButton",-1];
				_ctrl ctrlSetPosition [_bX,_bY,_bW,_bH];
				_ctrl ctrlSetText _aText;
				_ctrl buttonSetAction ("[] spawn ds_fnc_closebuttons;_classname = """ + _classname + """; " + _action);
				_ctrl ctrlCommit 0;
				
				_buttons pushBack _ctrl;
			};
		};
	};
};
_bY = _buttonY + (0.042*_bIndex);
_bH = 0.04;
_bW = _BUTTON_W;
_bX = _buttonX;
_bIndex = _bIndex + 1;
_ctrl = _display ctrlCreate ["RscButton",-1];
_ctrl ctrlSetPosition [_bX,_bY,_bW,_bH];
_ctrl ctrlSetText "Exit";
_ctrl buttonSetAction ("[] spawn ds_fnc_closebuttons;");
_ctrl ctrlCommit 0;
_buttons pushBack _ctrl;
uinamespace setVariable ["ds_var_itemButtons",_buttons];