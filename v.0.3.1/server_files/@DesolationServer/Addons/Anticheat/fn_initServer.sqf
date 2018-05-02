//protect variables
{
	if(_x find "_lys" != -1) then {
		_value = bis_functions_mainscope getVariable _x;
		
		//format admin list so it can be compiled
		if(_x == "admins_lys") then {
			_parts = _value splitString ",";
			_value = _parts joinString "','";
			_value = "['" + _value + "']";
		};
		if(_x == "servercommandpassword_lys") then {
			_value = "'" + _value + "'";
		};
		
		_value = compileFinal _value;
		
		uiNamespace setVariable [_x,_value]; // set the variable somewhere it cant be scanned
		
		bis_functions_mainscope setVariable [_x,nil,true]; // wipe it from the master object
	};
} forEach allVariables bis_functions_mainscope;

//todo randomize variables
//todo compilefinal all functions

LYS_fnc_addToLogs = {
	params["_log"];
	_logs = uiNamespace getVariable ["ServerLogs",[]];
	_logs pushback _log;
	uiNamespace setVariable ["ServerLogs",_logs];
};

LYS_fnc_getCfgValue = {
	params["_tag"];
	call (uiNamespace getVariable (toLower(_tag) + "_lys"));
};


_genString = {
	_arr = toArray "lys_";
	_min = (toArray "A") select 0;
	_max = (toArray "Z") select 0;
	for "_i" from 1 to 16 do {
		_arr pushBack (_min + floor(random(_max-_min)));
	};
	(toString _arr);
};


// setup main anticheat network system
_requestvar = call _genString;
_randomkey = call _genString;


_requestvar addPublicVariableEventHandler {
	(_this select 1) params["_key","_uid","_value"];
	_scp = ["ServerCommandPassword"] call LYS_fnc_getCfgValue;
	
	_getownerfromuid = {
		params["_uid"];
		_owner = -100;
		{
			if(getplayeruid _x == _uid) exitWith {_owner = owner _x;};
		} forEach allPlayers;
		_owner;
	};
	
	if(_key == "ban") then {
		["Ban | " + _uid + " | " + _value] call LYS_fnc_addToLogs;
		
		_scp serverCommand ("#exec ban " + str([_uid] call _getownerfromuid));
	};
	if(_key == "log") then {
		[(_value select 0) + " | " + _uid + " | " + (_value select 1)] call LYS_fnc_addToLogs;
		
	};
	if(_key == "kick") then {
		["Kick | " + _uid + " | " + _value] call LYS_fnc_addToLogs;
		_scp serverCommand ("#exec kick " + str([_uid] call _getownerfromuid));
	};
	if(_key == "runfunc") then {
		if(_uid in (["Admins"] call LYS_fnc_getCfgValue)) then {
			_params = _value select 0;
			_funcName = _value select 1;
			_code = _funcName;
			if(_funcName isEqualType "") then {
				_code = missionNamespace getVariable [_funcName,{}];
			};
			_params spawn _code;
		};
	};
	if(_key == "runfunctarg") then {
		if(_uid in (["Admins"] call LYS_fnc_getCfgValue)) then {
			_target = _value select 0;
			_params = _value select 1;
			_code = _value select 2;
			
			if(_code isEqualType "") then {
				_params remoteExec [_code,_target];
			} else {
				[_params,_code] remoteExec ["call",_target];
			};
		};
	};
	missionNamespace setvariable [_this select 0,nil];
    	publicVariable (_this select 0);
};

uiNamespace setVariable ["RequestVar",_requestvar];
uiNamespace setVariable ["RandomKey",_randomkey];


// anticheat payload 
if(["Anticheat"] call LYS_fnc_getCfgValue) then {
	
	diag_Log "<Anticheat>: Initializing Client Payload System";
	_client_payload = {
		params ["_UID","_PVVar","_randomkey"];
		
		_sendRequest = compile ("
			params['_key','_value'];
			" + _PVVar + " = [_key,'" + _uid + "',_value];
			publicVariable '" + _PVVar + "';
		");
		
		_ban = compile ("
			params['_reason'];
			['ban',_reason] call " + str(_sendRequest) + ";
		");
		
		_kick = compile ("
			params['_reason'];
			['kick',_reason] call " + str(_sendRequest) + ";
		");
		
		_log = compile ("
			params['_severity','_info'];
			['log',[_severity,_info]] call " + str(_sendRequest) + ";
		");
		
		_thread = uiNamespace getVariable [_randomkey,objNull];
		if(isNull _thread) then {
			if !(_thread isEqualType objNull) then {
				["Severe","Anticheat Restarting on " + name player + " | He may have terminated it | ServerTime: " + str(serverTime)] call _log;
			};
			_thread = [_ban,_kick,_log] spawn {
				params["_ban","_kick","_log"];
				
				//client loadin processing delay
				waitUntil{(player getVariable ["pUUID",""]) != ""};
				waitUntil{isDamageAllowed player};
				uiSleep 10; 
				
				["Info","Anticheat Started on " + name player + " | ServerTime: " + str(serverTime)] call _log;
				
				while{1==1} do {
					_recoilValue = (["Recoil","RSM"] call BASE_fnc_getCfgValue);
					if(!isNil "_recoilValue") then { 
						_recoil = call compile _recoilValue;
						if(unitRecoilCoefficient player != _recoil && unitRecoilCoefficient player != 1) then {
							["Unit Recoil Changed! " + str(unitRecoilCoefficient player) + " Should Be " + _recoilValue + " | Recoil Cheat"] call _ban;
						};
					};
					if(!isDamageAllowed player) then {
						["allowDamage set to false! | GodMode Cheat"] call _ban;
					};
					if(getTerrainGrid >= 50) then {
						["TerrainGrid >= 50! | Grass Cheat"] call _ban;
					};
					if(getCustomAimCoef player == 0) then {
						["Weapon Sway Disabled! | No Sway Cheat"] call _ban;
					};
					if(vehicle player != player) then {
						if(local (vehicle player)) then {
							_vehWeps = getArray(configFile >> "cfgVehicles" >> typeof (vehicle player) >> "weapons");
							_hasWeps = (weapons (vehicle player));
							if !(_vehWeps isEqualTo _hasWeps) then {
								deleteVehicle (vehicle player);
								["Vehicle has: (" + str(_hasWeps) + ") Should have: (" + str(_vehWeps) + ") | Vehicle Weapon Hack"] call _ban;
							};
						};
					};
					
					uiSleep random[0.5,1,1.5];
				};
			};
			uiNamespace setVariable [_randomkey,_thread];
		};
	};
	uiNamespace setVariable ["ClientPayload",_client_payload];
} else {
	uiNamespace setVariable ["ClientPayload",compileFinal ''];
};

// admin mainloop
if(["AdminTool"] call LYS_fnc_getCfgValue) then {
	diag_Log "<Anticheat>: Starting Admin Payload System";

	_admin_payload = {
		params ["_AdminList","_PVVar","_randomkey"];
		
		if(!isNil "LYS_var_RandomKey") exitWith {};
		
		LYS_var_AdminList = _AdminList;
		LYS_var_PVVAR = _PVVar;
		LYS_var_RandomKey = _randomkey;

		LYS_var_TitleColor = [0.8,0.86,0.22,1];
		LYS_var_NoToggleColor = [1,1,1,1];
		LYS_var_ToggleOnColor = [0.29,0.68,0.31,1];
		LYS_var_ToggleOffColor = [0,0.47,0.41,1];
		
		Player_Menu_Toggle = false;
		God_Mode_Toggle = false;
		Vehicle_Menu_Toggle = false;
		Weapon_Menu_Toggle = false;
		Crate_Menu_Toggle = false;
		Hack_Log_Toggle = false;
		Map_Toggle = false;
		MAP_TP_Toggle = false;
		Player_Icons_Toggle = false;
		Render_Bones_Toggle = false;
		Vehicle_Icons_Toggle = false;
		Zombie_Icons_Toggle = false;
		
		LYS_var_MapSingleClickCode = "if(_alt && MAP_TP_Toggle) then {(vehicle player) setpos _pos;};";
		
		onMapSingleClick LYS_var_MapSingleClickCode;
		
		
		LYS_fnc_DrawMarkers = {
			disableserialization;
			params["_ctrl"];
			
			if(Player_Markers_Toggle) then {
				{
					_ctrl drawIcon [
						'iconMan',
						[1,0,1,1],
						getPos _x,
						24,
						24,
						getDir _x,
						name _x,
						1,
						0.03,
						'TahomaB',
						'right'
					];
					false;
				} count allPlayers;
			};
			if(Vehicle_Markers_Toggle) then {
				{
					if(_x isKindOf "LandVehicle" || _x isKindOf "Air" || _x isKindOf "Ship") then {
						_ctrl drawIcon [
							getText(configFile >> "CfgVehicles" >> typeof _x >> "icon"),
							[1,1,1,1],
							getPos _x,
							24,
							24,
							getDir _x,
							getText(configFile >> "CfgVehicles" >> typeof _x >> "DisplayName"),
							1,
							0.03,
							'TahomaB',
							'right'
						];
					};
					false;
				} count vehicles;
			};
			if(Zombie_Markers_Toggle) then {
				{
					if(_x isKindOf "DSR_Zombie_Base") then {
						_ctrl drawIcon [
							'iconMan',
							[1,0,0,1],
							getPos _x,
							24,
							24,
							getDir _x,
							"Zombie",
							1,
							0.03,
							'TahomaB',
							'right'
						];
					};
					false;
				} count (allUnits-AllPlayers);
			};
			if(AI_Markers_Toggle) then {
				{
					if!(_x isKindOf "DSR_Zombie_Base") then {
						_ctrl drawIcon [
							'iconMan',
							[1,1,0,1],
							getPos _x,
							24,
							24,
							getDir _x,
							"AI",
							1,
							0.03,
							'TahomaB',
							'right'
						];
					};
				} count (allUnits-AllPlayers);
			};
			if(Helicrash_Markers_Toggle) then {
				{
					_ctrl drawIcon [
						'iconObject_circle',
						[0,0,1,1],
						getPos _x,
						24,
						24,
						getDir _x,
						"Helicrash",
						1,
						0.03,
						'TahomaB',
						'right'
					];
					false;
				} count (allMissionObjects "test_EmptyObjectForSmoke");
			};
			if(Airdrop_Markers_Toggle) then {
				{
					_ctrl drawIcon [
						'iconObject_circle',
						[0,1,0,1],
						getPos _x,
						24,
						24,
						getDir _x,
						"Airdrop",
						1,
						0.03,
						'TahomaB',
						'right'
					];
					false;
				} count (allMissionObjects "DSR_Crate_Airdrop_F");
			};
			
		};
		
		findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw", LYS_fnc_DrawMarkers];
		
		addMissionEventHandler ["Draw3D",{
			_render_points = [
				["spine3","rightshoulder"],
				["spine3","leftshoulder"],
				["pelvis","spine3"],
				["leftupleg","pelvis"],
				["rightupleg","pelvis"],
				["leftleg","leftupleg"],
				["rightleg","rightupleg"],
				["leftfoot","leftleg"],
				["rightfoot","rightleg"],
				["rightarm","rightshoulder"],
				["leftarm","leftshoulder"],
				["lefthand","leftarm"],
				["righthand","rightarm"]
			];
			_get_color = {
				params["_entity"];
				private["_return","_visibility"];
				_pos = (getposasl _entity) vectorAdd [0,0,1];
				if(_entity isKindOf "Man") then {
					_pos = eyepos _entity;
				};
				_visibility = [_entity, "VIEW",player] checkVisibility [eyePos player,_pos];
				
				_return = [0.77,0.11,0.11,1];
				if(_visibility > 0.8) then {
					_return = [0.11,0.77,0.11,1];
				};
				_return;
			};
			_draw_icon = {
				params["_posAGL1","_text",["_color",[1,1,1,1]]];
				
				_scaleSub = (_x distance player)/(getObjectViewDistance select 0);
				
				
				_pos1 = _posAGL1 vectorAdd [0,0,0.5];
				
				drawIcon3D [
					"#(argb,8,8,3)color(0,0,0,0)",
					_color,
					_pos1,
					1,
					1,
					0,
					_text,
					0,
					0.035 - (0.03*_scaleSub),
					"EtelkaMonospaceProBold",
					"Center"
				];
			};
			_draw_line = {
				params["_posAGL1","_posAGL2",["_color",[1,1,1,1]]];
				private["_sPos1","_sPos2","_pos1","_pos2","_icon"];
				_sPos1 = worldToScreen _posAGL1;
				_sPos2 = worldToScreen _posAGL2;
				
				if(count(_sPos1) == 0) exitWith {};
				if(count(_sPos2) == 0) exitWith {};

				_pos1 = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld _sPos1;
				_pos2 = ((findDisplay 12) displayCtrl 51) ctrlMapScreenToWorld _sPos2;
				
				((findDisplay 12) displayCtrl 51) drawLine [_pos1,_pos2,_color];
				
				_icon = getText(configFile >> "CfgVehicles" >> typeof player >> "Icon");
				((findDisplay 12) displayCtrl 51) drawIcon [
					_icon,
					_color,
					_pos1,
					1,
					1,
					0,
					".",
					0,
					0.01,
					"TahomaB",
					"Center"
				];
				((findDisplay 12) displayCtrl 51) drawIcon [
					_icon,
					_color,
					_pos2,
					1,
					1,
					0,
					".",
					0,
					0.01,
					"TahomaB",
					"Center"
				];
			};
			
			if(Player_Icons_Toggle) then {
				{
					if(_x distance player < ((getObjectViewDistance select 0))) then {
						_color = [_x] call _get_color;
						[ASLtoAGL eyepos _x,name _x,_color] call _draw_icon;
						if(Render_Bones_Toggle) then {
							_target = _x;
							{
								_i1 = _x select 0;
								_i2 = _x select 1;
								
								_model1 = _target selectionPosition _i1;
								_model2 = _target selectionPosition _i2;
								
								_w1 = _target modelToWorld _model1;
								_w2 = _target modelToWorld _model2;
								
								[_w1,_w2,_color] call _draw_line;
								
								true
							} count _render_points;
							
							
							_model1 = _target selectionPosition "spine3";
							
							_w1 = _target modelToWorld _model1;
							_w2 = ASLtoAGL eyepos _target;
							
							[_w1,_w2,_color] call _draw_line;
						};
					};
				} forEach allPlayers;
			};
			if(Vehicle_Icons_Toggle) then {
				{
					if(_x distance player < ((getObjectViewDistance select 0))) then {
						_color = [_x] call _get_color;
						[(ASLtoAGL getposasl _x) vectorAdd [0,0,1],getText(configFile >> "CfgVehicles" >> typeof _x >> "DisplayName"),_color] call _draw_icon;
					};
				} forEach vehicles;
			};
			if(Zombie_Icons_Toggle) then {
				{
					if(_x distance player < ((getObjectViewDistance select 0))) then {
						_color = [_x] call _get_color;
						[ASLtoAGL eyepos _x,"Zombie",[1,1,0.1,1]] call _draw_icon;
					};
				} forEach (allUnits-allPlayers);
			};
		
		}];
		
		
		_godmode = {
			params["_toggle"];
			player allowDamage !_toggle;
			while{God_Mode_Toggle} do {
				resetCamShake;
				player setDamage 0;
				DS_var_Blood = 27500;
				call DS_fnc_stopBleeding;
				UiSleep 0.1;
			};
		};
		_norecoil = {
			params["_toggle"];
			_recoil = unitRecoilCoefficient player;
			_sway = getCustomAimCoef player; 
			player setUnitRecoilCoefficient (if(_toggle) then {LYS_var_OldRecoil = _recoil;0} else {LYS_var_OldRecoil});
			player setCustomAimCoef (if(_toggle) then {LYS_var_OldSway = _sway;0} else {LYS_var_OldSway});
		};
		_infammo = {
			if(Infinte_Ammo_Toggle) then {
				while{Infinte_Ammo_Toggle} do {
					(vehicle player) setVehicleAmmo 1;
					UiSleep 0.1;
				};
			};
		};
		_fastfire = {
			if(Fast_Fire_Toggle) then {
				while{Fast_Fire_Toggle} do {
					(vehicle player) setWeaponReloadingTime [gunner (vehicle player), currentMuzzle (gunner (vehicle player)), 0];
					UiSleep 0.001;
				};
			};
		};
		_nograss = {
			params["_toggle"];
			setTerrainGrid (if(_toggle) then {50} else {25});
		};
		_arsenal = {
			closeDialog 0;
			["Open",true] spawn bis_fnc_arsenal;
		};
		_repair = {
			if(vehicle player != player) then {vehicle player setDamage 0;};
		};
		_heal = {
			resetCamShake;
			DS_var_Blood = 27500;
			player setDamage 0;
			call DS_fnc_stopBleeding;
		};
		_repaircurs = {
			cursorTarget setDamage 0;
		};
		_deletecurs = {
			_object = cursorTarget;
			[{
				params["_object"];
				[_object,objNull] call DB_fnc_killObject;
				deleteVehicle _object;
			},[_object]] call LYS_fnc_RunOnServer;
		};
		_toggle_players = {
			disableserialization;
			params["_toggle"];
			((findDisplay 1776) displayCtrl 1778) ctrlShow _toggle;
		};
		_toggle_logs = {
			disableserialization;
			params["_toggle"];
			((findDisplay 1776) displayCtrl 1781) ctrlShow _toggle;
		};
		_toggle_weaponMenu = {
			disableserialization;
			params["_toggle"];
			_display = findDisplay 1776;
			_objs = _display displayctrl 1780;
			
			_mainList = _display displayCtrl 1776;
			
			lbClear _objs;
			if(_toggle) then {
				[_objs,1] call LYS_fnc_UpdateObjList;
				if(ctrlShown _objs) then {
					Vehicle_Menu_Toggle = false;
					Crate_Menu_Toggle = false;
					for "_i" from 0 to (lbSize _mainList)-1 do {
						_index = _mainList lbData _i;
						if(_index != "") then {
							_j = parseNumber _index;
							_funcData = LYS_var_Functions select _j;
							_text = _funcData select 0;
							if(_text == "Vehicle Menu" || _text == "Supply Crate(s)") then {
								_mainList lbSetColor [_i,LYS_var_ToggleOffColor];
							};
						};
					};
				} else {
					_objs ctrlShow true;
				};
			} else {
				_objs ctrlShow false;
			};
		};
		_toggle_vehicleMenu = {
			disableserialization;
			params["_toggle"];
			_display = findDisplay 1776;
			_objs = _display displayctrl 1780;
			
			_mainList = _display displayCtrl 1776;
			
			
			lbClear _objs;
			if(_toggle) then {
				[_objs,0] call LYS_fnc_UpdateObjList;
				if(ctrlShown _objs) then {
					Weapon_Menu_Toggle = false;
					Crate_Menu_Toggle = false;
					for "_i" from 0 to (lbSize _mainList)-1 do {
						_index = _mainList lbData _i;
						if(_index != "") then {
							_j = parseNumber _index;
							_funcData = LYS_var_Functions select _j;
							_text = _funcData select 0;
							if(_text == "Weapon Menu" || _text == "Supply Crate(s)") then {
								_mainList lbSetColor [_i,LYS_var_ToggleOffColor];
							};
						};
					};
				} else {
					_objs ctrlShow true;
				};
			} else {
				_objs ctrlShow false;
			};
		};
		_toggle_supplies = {
			disableserialization;
			params["_toggle"];

			_display = findDisplay 1776;
			_objs = _display displayctrl 1780;
			_mainList = _display displayCtrl 1776;
			
			
			lbClear _objs;
			if(_toggle) then {
				[_objs,2] call LYS_fnc_UpdateObjList;
				if(ctrlShown _objs) then {
					Weapon_Menu_Toggle = false;
					Vehicle_Menu_Toggle = false;
					for "_i" from 0 to (lbSize _mainList)-1 do {
						_index = _mainList lbData _i;
						if(_index != "") then {
							_j = parseNumber _index;
							_funcData = LYS_var_Functions select _j;
							_text = _funcData select 0;
							if(_text == "Weapon Menu" || _text == "Vehicle Menu") then {
								_mainList lbSetColor [_i,LYS_var_ToggleOffColor];
							};
						};
					};
				} else {
					_objs ctrlShow true;
				};
			} else {
				_objs ctrlShow false;
			};
		};
		_toggle_map = {
			disableserialization;
			params["_toggle"];
			((findDisplay 1776) displayCtrl 1779) ctrlShow _toggle;
		};
		_vehgod = {
			if(Veh_God_Toggle) then {
				while{Veh_God_Toggle} do {
					waitUntil{vehicle player != player || !Veh_God_Toggle};
					_veh = vehicle player;
					_veh allowDamage false;
					waitUntil{vehicle player == player || !Veh_God_Toggle};
					_veh allowDamage true;
				};
			};
		};
		_vehboost = {
			if(Veh_Boost_Toggle) then {
				while{Veh_Boost_Toggle} do {
					if(vehicle player != player) then {
						if(inputAction "carFastForward" > 0) then {
							_veh = velocity (vehicle player);
							_veh = _veh vectorAdd (vectorNormalized _veh);
							(vehicle player) setVelocity _veh;
						};
					};
					uiSleep 0.1;
				};
			};
		};
		_freecam = {
			
			closeDialog 0;
			call BIS_fnc_Camera;
			
		};
		_viewSteamInfo = {
			_target = call LYS_fnc_getSelectedTarget;

			_uid = (getplayeruid _target);
			if!(isNil "_uid") then {
				_name = (name _target);
				if!(isNil "_name") then {
					hint format ["%1's UID: %2 \n---------------------------------------------------",_name,_uid];
				} else {
					hint format ["UID: %1 \n---------------------------------------------------",_uid];
				};
			};
		};
		_buildcurs = {
			_cType = typeof(cursorTarget);
			if(toLower(_cType) find "_preview2" != -1) then {
				[cursorTarget] call DS_fnc_onCrateFilled;
			};
		};
		_spectate = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			
			closeDialog 0;		
			if(!isNil "LYS_var_SpectateEvent") then {
				(findDisplay 46) displayRemoveEventHandler ["KeyDown",LYS_var_SpectateEvent];
			};
			
			_target switchCamera "EXTERNAL";
			LYS_var_SpectateEvent = (findDisplay 46) displayAddEventHandler ["KeyDown",{
				params["_display","_key"];
				if(_key == 0x01) exitWith {
					player switchCamera "EXTERNAL";
					(findDisplay 46) displayRemoveEventHandler ["KeyDown",LYS_var_SpectateEvent];
					LYS_var_SpectateEvent = nil;
					true;
				};
				false;
			}];
			
		};
		_messageall = {
			_input = call LYS_fnc_getStringInput;
			if(_input == "") exitWith {};
			
			["Admin Message\n\n" + _input] remoteExec ["hint",0];
		};
		_messagetarget = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			_input = call LYS_fnc_getStringInput;
			if(_input == "") exitWith {};
			
			["Admin Message\n\n" + _input] remoteExec ["hint",_target];
		};
		_tphere = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};

			if((vehicle player) != player) then {
				_freeSpace = {(vehicle _target) emptyPositions _x} forEach ["Commander","Driver","Gunner","Cargo"];
				if(_freeSpace > 0) then {
					_target moveInAny (vehicle player);
				} else {
					_pos = getPos (vehicle player);
					_target setPos [_pos select 0,_pos select 1,0];
				};
			} else {
				_target setPosATL (getPosATL player);
			};
		};
		_tpto = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};

			if((vehicle _target) != _target) then {
				_freeSpace = {(vehicle player) emptyPositions _x} forEach ["Commander","Driver","Gunner","Cargo"];
				if(_freeSpace > 0) then {
					player moveInAny (vehicle _target);
				} else {
					_pos = getPos (vehicle _target);
					player setPos [_pos select 0,_pos select 1,0];
				};
			} else {
				player setPosATL (getPosATL _target);
			};
		};
		_viewinventory = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			closeDialog 0;
			createGearDialog [_target,"RscDisplayInventory"];
		};
		_helicrash = {
			_pos = call LYS_fnc_GetPosFromMap;
			if(_pos isEqualTo [0,0,0]) exitWith {};
			
			[{
				params["_crashPos"];

				[_crashPos] spawn HLCR_fnc_spawnHeliCrash;

			},[_pos]] call LYS_fnc_RunOnServer;
		};
		_airdrop = {
			_pos = call LYS_fnc_GetPosFromMap;
			if(_pos isEqualTo [0,0,0]) exitWith {};
			
			
			[{
				params ["_location"];

				[_location] spawn AIRD_fnc_spawnAirdrop;

			},[[_pos select 0,_pos select 1]]] call LYS_fnc_RunOnServer;
			
		};
		_zombie = {
			_pos = call LYS_fnc_GetPosFromMap;
			if(_pos isEqualTo [0,0,0]) exitWith {};
			_pos set[2,0];
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
		};
		_horde = {
			_pos = call LYS_fnc_GetPosFromMap;
			if(_pos isEqualTo [0,0,0]) exitWith {};
			_pos set[2,0];
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
			["DSZ_fnc_insertZombie",[_pos,100]] call LYS_fnc_RunOnServer;
		};
		_bantarget = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			_reason = call LYS_fnc_getStringInput;
			if(_reason == "") then {};
			missionNamespace setVariable [LYS_var_PVVAR,["ban",getplayeruid _target,_reason]];
			publicVariable LYS_var_PVVAR;
		};
		_kicktarget = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			_reason = call LYS_fnc_getStringInput;
			if(_reason == "") then {};
			missionNamespace setVariable [LYS_var_PVVAR,["kick",getplayeruid _target,_reason]];
			publicVariable LYS_var_PVVAR;
		};
		_invisible = {
			params["_toggle"];
			[{
				params["_unit","_toggle"];
				_unit hideObjectGlobal _toggle;
			},[player,_toggle]] call LYS_fnc_RunOnServer;
		};
		_lockserv = {
			[{
				_scp = ["ServerCommandPassword"] call LYS_fnc_getCfgValue;
				_scp serverCommand "#lock";
			}] call LYS_fnc_RunOnServer;
			hint "Server Locked!";
		};
		_unlockserv = {
			[{
				_scp = ["ServerCommandPassword"] call LYS_fnc_getCfgValue;
				_scp serverCommand "#unlock";
			}] call LYS_fnc_RunOnServer;
			hint "Server Unlocked!";
		};
		_restart = {
			[{
				_scp = ["ServerCommandPassword"] call LYS_fnc_getCfgValue;
				diag_log  "Shutdown > Locking Server";
				_scp serverCommand "#lock";
				uiSleep 1;
				diag_log  "Shutdown > Kicking Players";
				{
					_scp serverCommand ("#exec kick " + str(owner(_x)));
				} forEach allPlayers;
				uiSleep 1;
				diag_log  "Shutdown > Saving Objects";
				DB_var_runObjectMon = false;
				waitUntil{!DB_var_savingObjects};
				_scp serverCommand "#shutdown";
			}] call LYS_fnc_RunOnServer;
		};
		_healtarg = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				resetCamShake;
				DS_var_Blood = 27500;
				player setDamage 0;
				call DS_fnc_stopBleeding;
			}] call LYS_fnc_RunOnTarget;
		};
		_repairtarg = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				if(vehicle player != player) then {vehicle player setDamage 0;};
			}] call LYS_fnc_RunOnTarget;
		};
		_blackscreen = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				1776 cutText ["","BLACK FADED"];
			}] call LYS_fnc_RunOnTarget;
		};
		_clearscreen = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				1776 cutText ["","PLAIN"];
			}] call LYS_fnc_RunOnTarget;
		};
		_lockinput = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				disableUserInput true;
			}] call LYS_fnc_RunOnTarget;
		};
		_unlockinput = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				disableUserInput false;
			}] call LYS_fnc_RunOnTarget;
		};
		_killtarg = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				player setDamage 1;
			}] call LYS_fnc_RunOnTarget;
		};
		_breaklegs = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				player setHitPointDamage ["HitLegs",1];
			}] call LYS_fnc_RunOnTarget;
		};
		_knockout = {
			_target = call LYS_fnc_getSelectedTarget;
			if(isNull _target) exitWith {};
			[_target,{
				[30] call DS_fnc_knockOut;
			}] call LYS_fnc_RunOnTarget;
		};
		
		LYS_var_Functions = [
				["        Main",0],
			["God Mode",1,_godmode,"God_Mode_Toggle"],
			["Infinite Ammo",1,_infammo,"Infinte_Ammo_Toggle"],
			["No Recoil / No Sway",1,_norecoil,"No_Recoil_Toggle"],
			["Fast Fire",1,_fastfire,"Fast_Fire_Toggle"],
			["No Grass",1,_nograss,"No_Grass_Toggle"],
			["Arsenal",2,_arsenal],
			["Heal",2,_heal],
			["Repair Cursor",2,_repaircurs],
			["Delete Cursor",2,_deletecurs],
			
				["        Icons",0],
			["Player Icons",1,{},"Player_Icons_Toggle"],
			["Vehicle Icons",1,{},"Vehicle_Icons_Toggle"],
			["Zombie Icons",1,{},"Zombie_Icons_Toggle"],
			["Render Bones",1,{},"Render_Bones_Toggle"],
			
				["        Map",0],
			["Show Map",1,_toggle_map,"Map_Toggle"],
			["Alt+Click TP",1,{},"MAP_TP_Toggle"],
			["Player Markers",1,{},"Player_Markers_Toggle"],
			["Vehicle Markers",1,{},"Vehicle_Markers_Toggle"],
			["Zombie Markers",1,{},"Zombie_Markers_Toggle"],
			["AI Markers",1,{},"AI_Markers_Toggle"],
			["Helicrash Markers",1,{},"Helicrash_Markers_Toggle"],
			["Airdrop Markers",1,{},"Airdrop_Markers_Toggle"],
			
				["        Vehicle",0],
			["God Mode",1,_vehgod,"Veh_God_Toggle"],
			["Boost",1,_vehboost,"Veh_Boost_Toggle"],
			["Repair",2,_repair],
			
				["        Recon",0],
			["Show Logs",1,_toggle_logs,"Hack_Log_Toggle"],
			["Invisibility",1,_invisible,"Invisible_Toggle"],
			["FreeCam",2,_freecam],
			["View Steam Info",2,_viewSteamInfo],
			["Spectate",2,_spectate],
			["View Inventory",2,_viewinventory],
			
				["        Players",0],
			["Show Players",1,_toggle_players,"Player_Menu_Toggle"],
			["Ban",2,_bantarget],
			["Kick",2,_kicktarget],
			["Knockout",2,_knockout],
			["Break Legs",2,_breaklegs],
			["Kill",2,_killtarg],
			["Lock Input",2,_lockinput],
			["Unlock Input",2,_unlockinput],
			["Black Screen",2,_blackscreen],
			["Clear Screen",2,_clearscreen],
			["TP Here",2,_tphere],
			["TP To",2,_tpto],
			["Message",2,_messagetarget],
			["Repair",2,_repairtarg],
			["Heal",2,_healtarg],
			
				["        Building",0],
			["Build CursorTarget",2,_buildcurs],
			
				["        Spawning",0],
			["Vehicle Menu",1,_toggle_vehicleMenu,"Vehicle_Menu_Toggle"],
			["Weapon Menu",1,_toggle_weaponMenu,"Weapon_Menu_Toggle"],
			["Supply Crate(s)",1,_toggle_supplies,"Crate_Menu_Toggle"],
			["Helicrash",2,_helicrash],
			["Airdrop",2,_airdrop],
			["Zombie",2,_zombie],
			["Zombie Horde",2,_horde],
			
				["        Server",0],
			["Restart",2,_restart],
			["Lock",2,_lockserv],
			["Unlock",2,_unlockserv],
			["Mass Message",2,_messageall],
			
				["        Premium Features",0]
		
		];
		
		LYS_fnc_OnDoubleClickObjects = {
			disableserialization;
			params["_ctrl","_lbIndex"];
			
			_classname = _ctrl lbData _lbIndex;
			
			if(Vehicle_Menu_Toggle) then {
				_distance = if(vehicle player == player) then {7} else {14};
				_position = (getposatl (vehicle player)) vectorAdd ((vectorDir (vehicle player)) vectorMultiply _distance);
				_direction = getdir vehicle player;
				
				[{
					params["_classname","_position","_direction"];
					
					_vehicle = _classname createVehicle [0,0,0];
					_vehicle setPosATL _position;
					_vehicle setDir _direction;
					clearWeaponCargoGlobal _vehicle;
					clearMagazineCargoGlobal _vehicle;
					clearItemCargoGlobal _vehicle;
				
					[_vehicle] call DB_fnc_spawnObject;
				
				},[_classname,_position,_direction]] call LYS_fnc_RunOnServer;				
			};
			if(Weapon_Menu_Toggle) then {
				_object = "groundweaponholder" createVehicle [0,0,0];
				_object setposatl getposatl player;
				
				_item = _classname;
				
				if(isClass (configFile >> "CfgWeapons" >> _item)) then {
					if((toLower(_item) find "tacs_" == 0) || (toLower(_item) find "item" == 0) || (toLower(_item) find "h_" == 0) || (toLower(_item) find "u_" == 0) || (toLower(_item) find "v_" == 0) || (toLower(_item) find "minedetector" == 0) || (toLower(_item) find "binocular" == 0) || (toLower(_item) find "rangefinder" == 0) || (toLower(_item) find "NVGoggles" == 0) || (toLower(_item) find "laserdesignator" == 0) || (toLower(_item) find "firstaidkit" == 0) || (toLower(_item) find "medkit" == 0) || (toLower(_item) find "toolkit" == 0) || (toLower(_item) find "muzzle_" == 0) || (toLower(_item) find "optic_" == 0) || (toLower(_item) find "acc_" == 0) || (toLower(_item) find "bipod_" == 0)) then {
						_object addItemCargoGlobal [_item,1];
					} else {
						_object addWeaponCargoGlobal [_item,1];
						_mags = getArray(configFile >> "CfgWeapons" >> _item >> "Magazines");
						if(count(_mags) > 0) then {
							_mag = _mags select floor(random(count(_mags)));
							_maxAmmo = getNumber(configFile >> "CfgMagazines" >> _mag >> "count");
							_object addMagazineAmmoCargo [_mag,3,_maxAmmo];
						};
					};
				};
			};
			if(Crate_Menu_Toggle) then {
				_position = (vehicle player) modelToWorld [0,3,0];
				_direction = getDir vehicle player;
				systemchat "Crates will be deleted after restart!";

				[{
					params["_classname","_position","_direction"];

					_crateClass = getText(configFile >> "CfgCrates" >> _classname >> "CrateClass");
					_items = getArray(configFile >> "CfgCrates" >> _classname >> "Items");

					_crate = createVehicle [_crateClass, _position, [], 0.5, "NONE"];
					_crate setDir _direction;

					{
						_crate addItemCargoGlobal _x;
					} forEach _items;

				},[_classname,_position,_direction]] call LYS_fnc_RunOnServer;				
			};
		};
		
		LYS_fnc_RunOnTarget = {
			params["_target","_func",["_params",[]]];
			missionNamespace setVariable [LYS_var_PVVAR,["runfunctarg",getplayeruid player,[_target,_params,_func]]];
			publicVariable LYS_var_PVVAR;
		};
		
		LYS_fnc_RunOnServer = {
			params["_func",["_params",[]]];
			missionNamespace setVariable [LYS_var_PVVAR,["runfunc",getplayeruid player,[_params,_func]]];
			publicVariable LYS_var_PVVAR;
		};
		
		LYS_fnc_GetPosFromMap = {
			player linkitem 'itemMap';
			closeDialog 0;
			openMap true;
			if(!isNil "LYS_var_MapPos") then {
				LYS_var_MapPos = [0,0,0];
			};
			
			LYS_var_MapPos = [];
			
			onMapSingleClick "
				openMap false;
				[] spawn LYS_fnc_OpenMenu;
				LYS_var_MapPos = _pos;
				onMapSingleClick LYS_var_MapSingleClickCode;
			";
			
			waitUntil{!(LYS_var_MapPos isEqualTo [])};
			_pos = LYS_var_MapPos;
			LYS_var_MapPos = nil;
			_pos;
		};
		
		LYS_fnc_getStringInput = {
			disableserialization;
			if(!isNil "LYS_var_InputKeyEvent") exitWith {};
			
			_display = findDisplay 1776;
			
			_ctrl = _display ctrlCreate ["RscEdit",-1];
			_ctrl ctrlSetPosition [0,0.475,1,0.05];
			_ctrl ctrlSetBackgroundColor [0.10,0.10,0.10,1];
			_ctrl ctrlSetText "Enter Message Here & Press Enter";
			_ctrl ctrlCommit 0;
			uiNamespace setVariable ["InputCtrlLys",_ctrl];
			
			LYS_var_SubmittedEntry = false;
			LYS_var_SubmittedText = "";
			LYS_var_InputKeyEvent = _display displayAddEventHandler ["KeyDown",{
				params["_display","_key"];
				
				if(_key == 0x1C) exitWith {
					_display displayRemoveEventHandler ["KeyDown",LYS_var_InputKeyEvent];
					LYS_var_InputKeyEvent = nil;
					_ctrl = uiNamespace getVariable "InputCtrlLys";
					
					
					LYS_var_SubmittedText = ctrlText _ctrl;
					LYS_var_SubmittedEntry = true;
					ctrlDelete _ctrl;
					true;
				};
				false;
			}];
			
			waitUntil{LYS_var_SubmittedEntry || isNull _display};
			if(isNull _display) exitWith {
				LYS_var_SubmittedEntry = nil;
				LYS_var_InputKeyEvent = nil;
				LYS_var_SubmittedText = nil;
				"";
			};
			_text = LYS_var_SubmittedText;
			LYS_var_SubmittedText = nil;
			LYS_var_SubmittedEntry = nil;
			_text;
		};
		
		LYS_fnc_getSelectedTarget = {
			disableserialization;
			_display = findDisplay 1776;
			_ctrl = _display displayctrl 1778;
			
			_sel = lbCurSel _ctrl;
			if(_sel < 0) exitWith {objNull};
			
			_uid = _ctrl lbData _sel;
			_target = objNull;
			{
				if(getplayeruid _x == _uid) exitWith {_target = _x;};
			} forEach allPlayers;
			_target;
		};
		
		LYS_fnc_OnDoubleClick = {
			disableserialization;
			params["_ctrl","_lbIndex"];
			
			_data = _ctrl lbData _lbIndex;
			if(_data == "") exitWith {};
			
			
			
			
			_index = parseNumber(_data);
			_funcData = LYS_var_Functions select _index;
			_type = _funcData select 1;
			
			if(_type != 1 && _type != 2) exitWith {};
			
			_code = _funcData select 2;
			if(_type == 1) then {
				_toggleVar = _funcData select 3;
				
				_value = missionNamespace getVariable[_toggleVar,false];
				_value = !_value;
				missionNamespace setVariable[_toggleVar,_value];
				
				if(_value) then {
					_ctrl lbSetColor [_lbIndex,LYS_var_ToggleOnColor];
				} else {
					_ctrl lbSetColor [_lbIndex,LYS_var_ToggleOffColor];
				};
				
				[_value] spawn _code;
				
			} else {
				[] spawn _code;
			};
			
		};
		
		LYS_fnc_UpdateLogList = {
			disableSerialization;
			params["_ctrl"];
			
			_index = _ctrl lbAdd "        Log List";
			_ctrl lbSetColor[_index,LYS_var_TitleColor];
		};
		
		LYS_fnc_UpdateObjList = {
			disableSerialization;
			params["_ctrl","_type"];
			
			if(_type == 2) then {

				uiNamespace setVariable ["LYS_var_listCtrl",_ctrl];
				_id = netId player;

				LYS_fnc_CrateButtons = {
					disableSerialization;
					params["_displayName","_class"];

					_ctrl = uiNamespace getVariable "LYS_var_listCtrl";
					_index = _ctrl lbAdd _displayName;
					_ctrl lbSetData [_index,_class];
					_ctrl lbSetColor [_index,LYS_var_NoToggleColor];

				};
				[{
					params ["_id"];

					_cfg = configFile >> "CfgCrates";
					for "_i" from 0 to (count(_cfg))-1 do {
						_entry = _cfg select _i;
						if(isClass _entry) then {
							_class = configName _entry;
							_displayName = getText(_entry >> "DisplayName");

							[_displayName,_class] remoteExec ["LYS_fnc_CrateButtons", -2, _id];
						};
					};
				},[_id]] spawn LYS_fnc_RunOnServer;

			} else {

				_cfg = if(_type == 0) then {configFile >> "CfgVehicles"} else {configFile >> "CfgWeapons"};
				for "_i" from 0 to count(_cfg)-1 do {
					_entry = _cfg select _i;
					if(isClass _entry) then {
						if(getNumber(_entry >> "scope") == 2) then {
							if(getText(_entry >> "Picture") != "") then {
								_class = configName _entry;
								if(_type != 0 || _class isKindOf "LandVehicle" || _class isKindOf "Air" || _class isKindOf "Ship") then {
									
									_pic = getText(_entry >> "Picture");
									_displayName = getText(_entry >> "DisplayName");
								
									_index = _ctrl lbAdd _displayName;
									_ctrl lbSetData [_index,_class];
									_ctrl lbSetColor [_index,LYS_var_NoToggleColor];
									_ctrl lbSetPicture [_index,_pic];
								};
							};
						};
					};
				};
			};
		};
		LYS_fnc_UpdatePlrList = {
			disableserialization;
			params["_ctrl"];
			{
				_veh = vehicle _x;
				_name = name _x;
				_uid = getplayeruid _x;
				
				_icon = getText(configFile >> "CfgVehicles" >> typeof _veh >> "Picture");
				
				_type = if(_uid in LYS_var_AdminList) then {"Admin"} else {"Player"};
				
				_index = _ctrl lbAdd (_name + " | " + _uid + " | " + _type);
				_ctrl lbSetData [_index,_uid];
				if(_type == "Admin") then {
					_ctrl lbSetColor [_index,LYS_var_ToggleOffColor];
				} else {
					_ctrl lbSetColor [_index,LYS_var_NoToggleColor];
				};
				
				_ctrl lbSetPicture [_index,_icon];
			} forEach allPlayers;
		};
		LYS_fnc_InitMainList = {
			disableserialization;
			params["_ctrl"];
			
			{
				_text = _x select 0;
				_type = _x select 1;
				if(_forEachIndex != 0) then {
					if(_type == 0) then {
						_ctrl lbAdd "";
					};
				};
				_index = _ctrl lbAdd _text;
				_ctrl lbSetData [_index,str(_forEachIndex)];
				if(_type == 0) then {
					_ctrl lbSetColor [_index,LYS_var_TitleColor];
				};
				if(_type == 1) then {
					_variable = _x select 3;
					_value = missionNamespace getVariable [_variable,false];
					if(_value) then {
						_ctrl lbSetColor [_index,LYS_var_ToggleOnColor];
					} else {
						_ctrl lbSetColor [_index,LYS_var_ToggleOffColor];
					};
				};
				if(_type == 2) then {
					_ctrl lbSetColor [_index,LYS_var_NoToggleColor];
				};
			} forEach LYS_var_Functions;
			_ctrl ctrlAddEventHandler ["LBDblClick",LYS_fnc_OnDoubleClick];
		};
		LYS_fnc_OpenMenu = {
			disableserialization;
			createDialog "RscDisplayAdminMenu";
			_display = findDisplay 1776;
			
			_main = _display displayctrl 1776;
			[_main] call LYS_fnc_InitMainList;
			_title = _display displayctrl 1777;
			
			_plrs = _display displayctrl 1778;
			_plrs ctrlShow Player_Menu_Toggle;
			[_plrs] call LYS_fnc_UpdatePlrList;
			
			
			_map = _display displayctrl 1779;
			_map ctrlShow Map_Toggle;
			_map ctrlAddEventHandler ["Draw", LYS_fnc_DrawMarkers];
			
			_objs = _display displayctrl 1780;
			_objs ctrlShow (Weapon_Menu_Toggle || Vehicle_Menu_Toggle || Crate_Menu_Toggle);
			_objs ctrlAddEventHandler ["LBDblClick",LYS_fnc_OnDoubleClickObjects];
			if(Weapon_Menu_Toggle) then {
				[_objs,1] call LYS_fnc_UpdateObjList;
			} else {
				if(Vehicle_Menu_Toggle) then {
					[_objs,0] call LYS_fnc_UpdateObjList;
				} else {
					if(Crate_Menu_Toggle) then {
						[_objs,2] call LYS_fnc_UpdateObjList;
					};
				};
			};
			
			_log = _display displayctrl 1781;
			_log ctrlShow Hack_Log_Toggle;
			[_log] call LYS_fnc_UpdateLogList;
		};
		
		
		
		
		
		
		
		
		systemchat "Anticheat > Admin Tool Initialized. Press INSERT To Open the Menu";
		
		
		
		
		
		
		(findDisplay 46) displayAddEventHandler ["KeyDown",{
			params["_display","_key"];
			if(_key == 0xD2) exitWith {
				[] spawn LYS_fnc_OpenMenu;
				true;
			};
			false;
		}];
	};
	uiNamespace setVariable ["AdminPayload",_admin_payload];
} else {
	uiNamespace setVariable ["AdminPayload",compileFinal ''];
};

[] spawn {
	//heartbeat code
	while{true} do {
		uiSleep (random[10,30,60]);
		{
			_uid = getplayeruid _x;		
			if(["Anticheat"] call LYS_fnc_getCfgValue) then {
				if !(_uid in (["Admins"] call LYS_fnc_getCfgValue)) then {
					[[getplayeruid _x,uiNamespace getVariable "RequestVar",uiNamespace getVariable "RandomKey"],uiNamespace getVariable "ClientPayload"] remoteExec ["call",owner _x];
				};
			};
			if(["AdminTool"] call LYS_fnc_getCfgValue) then {
				if (_uid in (["Admins"] call LYS_fnc_getCfgValue)) then {
					[[["Admins"] call LYS_fnc_getCfgValue,uiNamespace getVariable "RequestVar",uiNamespace getVariable "RandomKey"],uiNamespace getVariable "AdminPayload"] remoteExec ["call",owner _x];
				};;
			};
		} forEach allPlayers;
	};
};
