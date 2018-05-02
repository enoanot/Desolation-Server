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

/// Define needed variables for the system

//3d stuff
ACT_var_Render3DActions = false;
ACT_var_3DIconData = [];
ACT_var_Active3DIcon = -1;

//2d stuff
ACT_var_Render2DActions = false;
ACT_var_2DActionIndex = -1;
ACT_var_Selected2DAction = -1;
ACT_var_Rendered2DActionData = [];
ACT_var_2DActionParameters = [];
ACT_var_2DActionLayers = [];

// add main draw thread
addMissionEventHandler ["Draw3D",{
	{
		_x cutText ["","plain"];
	} forEach ACT_var_2DActionLayers;
	ACT_var_2DActionLayers = [];

	if(ACT_var_Render3DActions) then {
		
		_active3dIcon = -1;
		if(count(ACT_var_3DIconData) > 0) then {
			_actionIndex = ACT_var_3DIconData select 0;
			_iconInfo = ACT_var_3DIconData select 1;
			_cursorObject = ACT_var_3DIconData select 2;
			
			{	
				_selection = toLower(_x select 0);
				_location = _x select 1;
				_3dpartdata = _x select 2;
				_selectionIndex = _x select 3;
				
				_name = _3dpartdata select 0;
				_icon = _3dpartdata select 1;
				
				if(count(ACT_var_2DActionParameters) > 0) then {
					_oldObj = ACT_var_2DActionParameters select 0;
					if(_cursorObject != _oldObj && ACT_var_Render2DActions) then {
						ACT_var_Render2DActions = false;
					};
				};
				
				//ACT_var_2DActionParameters = [_cursorObject,_selectionIndex,_selection];
				
				if(!ACT_var_Render2DActions || _forEachIndex == ACT_var_2DActionIndex) then {
				
					_onScreen = true;
					
					_dist = [_location] call ACT_fnc_isPosTarget;
					
					_lookingAt = (_dist == 0);
					
					_spos = worldToScreen _location;
					
					if(_spos isEqualTo []) then {
						_onScreen = false;
					};
					
					if(_onScreen) then {
						_damage = _cursorObject getHitPointDamage _selection;
						
						_color = [0,1,0,1];
						if(!isNil {_damage}) then {
							_color = [_damage min 1,(1-_damage) max 0,0,1];
						};
						
						_scale = 0.04;
						if(_lookingAt || (ACT_var_Render2DActions &&  _forEachIndex == ACT_var_2DActionIndex)) then {
							_scale = 0.08;
							_active3dIcon = _forEachIndex;
							ACT_var_2DActionParameters = [_cursorObject,_selectionIndex,_selection];
						};
					
						//drawIcon3D [_icon, _color, _location, 1, 1, 45, str(_damage), 1, _scale, "TahomaB"];
						drawIcon3D [_icon, _color, _location, 1, 1, 45, _name, 1, _scale, "TahomaB"];
					
						
						if(ACT_var_Render2DActions && _forEachIndex == ACT_var_2DActionIndex) then {
							
							if(_dist > 0.5) then {
								ACT_var_Render2DActions = false;
							};
							
							_actionNames = [];
							_rendered2dactiondata = [];
							_actionInfo = ACT_var_ACTIONS select _actionIndex;
							_actionList = _actionInfo select 2; 
							{
								_aCondition = _x select 0;
								_aText = _x select 1;
								_aCode = _x select 2;
								_aReturned = _x select 3;
								_cursor = ACT_var_2DActionParameters select 0;
								
								//systemchat _selection;
								//systemchat _aCondition;
								//systemchat str(call compile _aCondition);
								
								if(call compile _aCondition) then {
									_actionNames pushback _aText;
									_rendered2dactiondata pushBack [_aCondition,_aCode,_aReturned];
								};
								if(count(_actionNames) == 4) exitWith {};
								
							} forEach _actionList;
							ACT_var_Rendered2DActionData = _rendered2dactiondata; 
							
							
							_cpos = [0.5,0.5];
							_submenu = 1;
							
							_dX = (_spos select 0) - (_cpos select 0);
							_dY = (_spos select 1) - (_cpos select 1);
							_h = sqrt(_dX^2 + _dY^2);
							
							_angle = abs(asin(_dY/_h));
							
							if(_angle <= 45) then {
								if(_dX <= 0) then {
									_submenu = 2;
								} else {
									_submenu = 4;
								};
							} else {
								if(_dY <= 0) then {
									_submenu = 3;
								} else {
									_submenu = 1;
								};
							};
							
							ACT_var_Selected2DAction = _submenu;
							ACT_var_2DActionLayers = ([_spos,_actionNames,_submenu] call ACT_fnc_display2DMenu);
						};
					};
				};
			} forEach _iconInfo;
		};
		ACT_var_Active3DIcon = _active3dIcon;
	};
}];
