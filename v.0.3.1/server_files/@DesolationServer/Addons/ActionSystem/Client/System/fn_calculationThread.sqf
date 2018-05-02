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

while{ACT_var_Render3DActions} do {

	scopeName "calc_main";

	_3D_ICON_DATA = [];
	
	
	_cursor = cursorTarget;
	if(isNull _cursor) then {
		_cursor = cursorObject;
	};
	if(!isNull _cursor) then {
		if(player distance _cursor <= 7) then {
			_actionIndex = -1;
			_renderType = -1;
			{
				_condition = _x select 0;
				if(call compile _condition) exitWith {
					_actionIndex = _forEachIndex;
					_renderType = _x select 1;
				};
			} forEach ACT_var_ACTIONS;
			
			if(_actionIndex != -1) then { 
				_iconInfo = [];
				
				_existingPositions = [];
				
				if(_renderType == 0) then {
				
					_hitpoints = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _cursor >> "Hitpoints");
					
					if(count(_hitpoints) <= 0) then { breakTo "calc_main"; };
					
					
					for "_i" from 0 to count(_hitpoints)-1 do {
						_partName = configName (_hitpoints select _i);
						_pos = _cursor selectionPosition [getText((_hitpoints select _i) >> "name"), "HitPoints"];
						if(_pos isEqualTo [0,0,0]) then {
							_buttomPos = _cursor worldToModel (ASLtoAGL getPosASL _cursor);
							_renderCenter = _buttomPos vectorAdd ([0,0,(((boundingBox _cursor) select 1) select 2)/2]);
							_pos = _renderCenter;
						};
						_position = _cursor modelToWorldVisual _pos;
						
						
						
						_3dpartdata = [_partName] call ACT_fnc_get3DPartName;
						if((_3dpartdata select 0) != "Error") then {
						
							//prevent multiple icons at same position;
							while{_position in _existingPositions} do {
								_position set[2,(_position select 2) + 0.4];
							};
						
						
							_iconInfo pushback [_partName, _position,_3dpartdata,_i];
							
							_existingPositions pushBack _position;
							
						};
					};
				} else {
					_iconPos = [0,0,0];
					/*if (_cursor in allUnits) then {
						_iconPos = _cursor selectionPosition "body";
					};*/
					_iconInfo pushBack ["no_selection",_cursor modelToWorld _iconPos,["action"] call ACT_fnc_get3DPartName,0];
				};
				
				_3D_ICON_DATA pushBack _actionIndex;
				_3D_ICON_DATA pushBack _iconInfo;
				_3D_ICON_DATA pushBack _cursor;
			};	
		};
	};
	
	ACT_var_3DIconData = _3D_ICON_DATA; 
	uiSleep 0.001;
};