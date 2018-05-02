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

//this is so broken

/*
if(!isClass (configFile >> "CfgPatches" >> "dsr_ui")) then {

	BASE_fnc_dikToHuman = {
		params["_dik"];
		_lookupTable = [
			["F1",0x3B],
			["F2",0x3C],
			["F3",0x3D],
			["F4",0x3E],
			["F5",0x3F],
			["F6",0x40],
			["F7",0x41],
			["F8",0x42],
			["F9",0x43],
			["F10",0x44],
			["F11",0x57],
			["F12",0x58],
			["0",0x0B],
			["1",0x02],
			["2",0x03],
			["3",0x04],
			["4",0x05],
			["5",0x06],
			["6",0x07],
			["7",0x08],
			["8",0x09],
			["9",0x0A],
			["NUMPAD0",0x52],
			["NUMPAD1",0x4F],
			["NUMPAD2",0x50],
			["NUMPAD3",0x51],
			["NUMPAD4",0x4B],
			["NUMPAD5",0x4C],
			["NUMPAD6",0x4D],
			["NUMPAD7",0x47],
			["NUMPAD8",0x48],
			["NUMPAD9",0x49],
			["A",0x1E],
			["B",0x30],
			["C",0x2E],
			["D",0x20],
			["E",0x12],
			["F",0x21],
			["G",0x22],
			["H",0x23],
			["I",0x17],
			["J",0x24],
			["K",0x25],
			["L",0x26],
			["M",0x32],
			["N",0x31],
			["O",0x18],
			["P",0x19],
			["Q",0x10],
			["R",0x13],
			["S",0x1F],
			["T",0x14],
			["U",0x16],
			["V",0x2F],
			["W",0x11],
			["X",0x2D],
			["Y",0x15],
			["Z",0x2C],
			["ESCAPE",0x01],
			["TAB",0x0F],
			["BACKSPACE",0x0E],
			["ENTER",0x1C],
			["SPACE",0x39],
			["Prim. Mouse Btn.",-1],
			["Sec. Mouse Btn.",-2]
		];

		_return = "";

		{
			if((_x select 1) == _dik) exitWith {
				_return = _x select 0;
			};
		} forEach _lookupTable;


		_return;
	};
	
	BASE_fnc_getDSC = {
		disableserialization;
		_display = _this;
		_uiVar = uiNamespace getVariable ["BASE_DSC",controlNull];
		if(isNull _uiVar) then {
			_uiVar = _display ctrlCreate ["RscListNBox",202];
			_uiVar ctrlSetPosition [
				0.5 * (((safezoneW / safezoneH) min 1.2) / 40),
				3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25),
				25 * (((safezoneW / safezoneH) min 1.2) / 40),
				15.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			];
			_uiVar ctrlCommit 0;
			uiNamespace setVariable ["BASE_DSC",_uiVar];
		};
		_uiVar;
	};

	BASE_fnc_RscDisplayConfigure = {
		disableserialization;
		params["_data","_mode"];
		_display = _data select 0;

		//--- for every variable to update, move its uiNamespace value into the profile
		if(_mode == "onexit") then {
			{
				profileNamespace setVariable [_x,uiNamespace getVariable [_x,[]]];
			} forEach (uiNamespace getVariable ["VARS_TO_UPDATE",[]]);
			
			saveProfileNamespace;
		};

		//--- reload control lnbList with values stored in the UINamespace
		if(_mode == "reload") then {
			_dsc = _display call BASE_fnc_getDSC;;
			
			lnbClear _dsc;
						
			{
				_displayName = _x select 0;
				_pluginPrefix = _x select 1;
				_varSuffix = _x select 2;
				_defaultKeys = _x select 3;
				
				_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
				_defaultKey = uiNamespace getVariable [_variable,_defaultKeys];
				
				_keyText = "";
				{
					_dik = _x select 0;
					_extra = _x select 1; //Shift+ or Ctrl+ or Alt+ (0,1,2,3)
					
					
					
					//config extra to human-readable
					_prefix = switch(_extra) do {
						case 1: {"Shift+"};
						case 2: {"Ctrl+"};
						case 3: {"Alt+"};
						case 4: {"Ctrl+Shift+"};
						default {""};
					};
					//--- TODO convert _dik from DIK to human-readable key
					_text = _prefix + ([_dik] call BASE_fnc_dikToHuman);
					
					// add "" around key ("X", "Shift+X", ect...)
					if(_text != "") then {
						_keyText = _keyText + ", " + str(_text);
					};
				} forEach _defaultKey;
				
				if(_keyText != "") then {
					_keyText = _keyText select[2];
				};
				
				_rowIndex = _dsc lnbAddRow [_displayName,_keyText];
				_dsc lnbSetData [[_rowIndex,0],_variable];
			} forEach (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]);
		};

		//--- On Display Open
		if(_mode == "onload") then {
			//--- setup some variables
			uiNamespace setVariable ["DS_PLUGIN_CONTROLS_CURINDEX",nil];
			uiNamespace setVariable ["VARS_TO_UPDATE",[]];
			
			_missionvalue = missionNamespace getVariable ["KEYBIND_DATA",[]];
			if(count(_missionvalue) > 0) then {
				uiNamespace setVariable ["DS_PLUGIN_CONTROLS",missionNamespace getVariable "KEYBIND_DATA"];
			} else {
				uiNamespace setVariable ["DS_PLUGIN_CONTROLS", [
					[
						"Example Keybind", //Display Name
						"DS", //Plugin Prefix
						"EXMAPLE_KEYBIND", //Storage Variable
						[[0x06,0],[0x0F,0]], //Default Keys
						"This is for testing purposes", //Tooltip
						"true" //code to run on exec (unused)
					]
				]];
			};
			//--- hide custom lnb
			_dsc = _display call BASE_fnc_getDSC;
			_dsc ctrlShow false;
			
			//--- setup cancel button to prevent saving
			_cancel = _display displayCtrl 2;
			_cancel buttonSetAction "uiNamespace setVariable ['VARS_TO_UPDATE',[]];";
			
			//--- start delayed setup (this is to fix some weird bug)
			[] spawn {
				disableserialization;
				waitUntil{!isNull (findDisplay 4)};
				_display = findDisplay 4;
				
				//--- update combo box with Desolation Controls group
				_combo = _display displayCtrl 108;
				_combo lbAdd "Desolation Controls";
				
				//--- setup event when the desolation controls group is switched too
				_combo ctrlAddEventHandler ["LBSelChanged",{
					disableserialization;
					params["_ctrl","_index"];
					_display = ctrlParent _ctrl;
					_list = _display displayCtrl 102;
					_dsc = _display call BASE_fnc_getDSC;
					if((_ctrl lbText _index) == "Desolation Controls") then {
						//Opening desolation controls, hide default list and show the lnbList
						_list ctrlShow false;
						_dsc ctrlShow true;
					} else {
						//Closing, show default list and hide lnbList
						_list ctrlShow true;
						_dsc ctrlShow false;
					};
				}];
				
				//--- Setup events for lnbList (for setting up custom actions)
				_dsc = _display call BASE_fnc_getDSC;
				_dsc ctrlAddEventHandler ["LBSelChanged",{
					disableserialization;
					params["_ctrl","_index"];
					// the lnbList was just clicked, so we need to configure some controls
					
					//--- set the current key index from the lnbList for later use
					uiNamespace setVariable ["DS_PLUGIN_CONTROLS_CURINDEX",_index];
					
					//--- load the keybind options
					_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
					_displayName = _controlData select 0;
					_pluginPrefix = _controlData select 1;
					_varSuffix = _controlData select 2;
					_defaultKeys = _controlData select 3;
					
					//--- get the key data from the uinamespace
					_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
					_defaultKey = uiNamespace getVariable [_variable,+_defaultKeys];
					
					uiNamespace setVariable [_variable + "_ORIG",_defaultKey];
					
					//--- open the configuration display
					_configuractiondisplay = (ctrlParent _ctrl) createDisplay "RscDisplayConfigureAction"; //idd 131
					
					//--- setup keybind event for adding keys
					_configuractiondisplay displayAddEventHandler ["KeyDown",{
						disableserialization;
						params["_display","_dik","_shift","_ctrl","_alt"];
						
						if(([_dik] call BASE_fnc_dikToHuman) == "") exitWith {false};
						
						//--- get current keybind options item index
						_index = uiNamespace getVariable ["DS_PLUGIN_CONTROLS_CURINDEX",0];
						
						//--- load the keybind options
						_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
						_displayName = _controlData select 0;
						_pluginPrefix = _controlData select 1;
						_varSuffix = _controlData select 2;
						_defaultKeys = _controlData select 3;
						
						//--- get the key data from the uinamespace
						_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
						_defaultKey = uiNamespace getVariable [_variable,+_defaultKeys];
						
						//--- calculate "extra"
						_extra = 0;
						if(_shift) then {
							_extra = 1;
						};
						if(_ctrl) then {
							_extra = 2;
						};
						if(_ctrl && _shift) then {
							_extra = 4;
						};
						if(_alt) then {
							_extra = 3;
						};
						
						//--- setup data array to be added to the variable
						_finalData = [_dik,_extra];
						
						//--- check if data array is already in the variable
						_alreadyExists = false;
						{
							if(_x isEqualTo _finalData) exitWith {
								_alreadyExists = true;
							};
						} forEach _defaultKey;
						
						//--- if it does not exist, add it and update UI
						if(!_alreadyExists) then {
							
							_defaultKey pushback _finalData;
							uiNamespace setVariable [_variable,_defaultKey];
							
							_ctrlKeyList = _display displayCtrl 102;
							
							lbClear _ctrlKeyList;
							
							{
								_dik = _x select 0;
								_extra = _x select 1; //Shift+ or Ctrl+ or Alt+ (0,1,2,3)
								
								
								
								//config extra to human-readable
								_prefix = switch(_extra) do {
									case 1: {"Shift+"};
									case 2: {"Ctrl+"};
									case 3: {"Alt+"};
									case 4: {"Ctrl+Shift+"};
									default {""};
								};
								//--- TODO convert _dik from DIK to human-readable key
								_displayText = _prefix + ([_dik] call BASE_fnc_dikToHuman);
								
								_index = _ctrlKeyList lbAdd _displayText;
								_ctrlKeyList lbSetData [_index,str(_x)];
								
							} forEach _defaultKey;
						};
						true;
					}];
					
					//--- setup the action name
					_ctrlActionName = _configuractiondisplay displayCtrl 101;
					_ctrlActionName ctrlSetText _displayName;
					
					//--- disable prev and next buttons (we wont be using these because fuck that)
					_ctrlPrev = _configuractiondisplay displayCtrl 108;
					_ctrlPrev ctrlEnable false;
					_ctrlNext = _configuractiondisplay displayCtrl 109;
					_ctrlNext ctrlEnable false;
					
					//--- add special keys to the special key list
					_ctrlSpecialKeyList = _configuractiondisplay displayCtrl 103;
					_ctrlSpecialKeyList lbAdd "Prim. Mouse Btn.";
					_ctrlSpecialKeyList lbAdd "Sec. Mouse Btn.";
					
					//--- setup the cancel button to wipe the variable so changes are not updated
					_ctrlCancel = _configuractiondisplay displayCtrl 107;
					_ctrlCancel buttonSetAction "uiNamespace setVariable ['" + _variable + "',uiNamespace getVariable ['" + _variable + "_ORIG',nil]];(findDisplay 131) closeDisplay 0;";
					
					//--- load data into the listbox of keys
					_ctrlKeyList = _configuractiondisplay displayCtrl 102; //listbox of keys
					
					{
						_dik = _x select 0;
						_extra = _x select 1; //Shift+ or Ctrl+ or Alt+ (0,1,2,3)
						
						
						
						//config extra to human-readable
						_prefix = switch(_extra) do {
							case 1: {"Shift+"};
							case 2: {"Ctrl+"};
							case 3: {"Alt+"};
							case 4: {"Ctrl+Shift+"};
							default {""};
						};
						//--- TODO convert _dik from DIK to human-readable key
						_displayText = _prefix + ([_dik] call BASE_fnc_dikToHuman);
						
						_index = _ctrlKeyList lbAdd _displayText;
						_ctrlKeyList lbSetData [_index,str(_x)];
						
					} forEach _defaultKey;
					
					
					//--- setup the deletekey action
					_ctrlDeleteKey = _configuractiondisplay displayCtrl 104; //delete selected key
					_ctrlDeleteKey buttonSetAction "[[(findDisplay 131)],'deletekey'] call BASE_fnc_RscDisplayConfigure";
					
					//--- change the undo button into a clear button because fuck undoing
					_ctrlClearKey = _configuractiondisplay displayCtrl 106; //delete all keys
					_ctrlClearKey ctrlSetText "Clear";
					_ctrlClearKey buttonSetAction "[[(findDisplay 131)],'clearkey'] call BASE_fnc_RscDisplayConfigure";
					
					//--- setup the default action
					_ctrlDefault = _configuractiondisplay displayCtrl 105; //load default keys
					_ctrlDefault buttonSetAction "[[(findDisplay 131)],'loaddefaults'] call BASE_fnc_RscDisplayConfigure";

					//--- start thread that waits for the UI to exit and looks to see if we are updating it
					[_this,_configuractiondisplay] spawn {
						disableserialization;
						params["_data","_display"];
						_ctrl = _data select 0;
						_index = _data select 1;
						
						//--- load the keybind options
						_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
						_displayName = _controlData select 0;
						_pluginPrefix = _controlData select 1;
						_varSuffix = _controlData select 2;
						_defaultKeys = _controlData select 3;
						
						//--- get the key data from the uinamespace
						_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
						
						waituntil{isNull _display};
						
						
						if(!isNil {uiNamespace getVariable _variable}) then {
						
							_toUpdate = uiNamespace getVariable ["VARS_TO_UPDATE",[]];
							if !(_variable in _toUpdate) then {
								_toUpdate pushBack _variable;
								uiNamespace setVariable ["VARS_TO_UPDATE",_toUpdate];
							};
							
							[[(findDisplay 4)],'reload'] call BASE_fnc_RscDisplayConfigure;
						};
					};
				}];
				
				//--- load listbox with items from profile
				{
					//--- get keybind options
					_displayName = _x select 0;
					_pluginPrefix = _x select 1;
					_varSuffix = _x select 2;
					_defaultKeys = _x select 3;
					_tooltip = _x select 4;
					
					//--- define storage variable name
					_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
					
					//--- get value from profile and save it to the uiNamespace
					_defaultKey = profileNamespace getVariable [_variable,+_defaultKeys];
					uiNamespace setVariable [_variable,+_defaultKey];
					//--- build text for the lnbList row
					_keyText = "";
					{
						_dik = _x select 0;
						_extra = _x select 1; //Shift+ or Ctrl+ or Alt+ (0,1,2,3)
						
						//config extra to human-readable
						_prefix = switch(_extra) do {
							case 1: {"Shift+"};
							case 2: {"Ctrl+"};
							case 3: {"Alt+"};
							case 4: {"Ctrl+Shift+"};
							default {""};
						};
						//--- TODO convert _dik from DIK to human-readable key
						_text = _prefix + ([_dik] call BASE_fnc_dikToHuman);
						
						// add "" around key ("X", "Shift+X", ect...)
						if(_text != "") then {
							_keyText = _keyText + ", " + str(_text);
						};
					} forEach _defaultKey;
					
					if(_keyText != "") then {
						_keyText = _keyText select[2];
					};
					
					//--- add text to row and stor lnbData
					_dsc lnbAddRow [_displayName,_keyText];
					_dsc lbSetToolTip [((lnbSize _dsc) select 0),_tooltip];
				} forEach (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]);
				
			};
		};

		//--- deleting a keybind in the ConfigureAction UI
		if(_mode == "deletekey") then {

			//--- get the index for the keybind options for this setting
			_index = uiNamespace getVariable ["DS_PLUGIN_CONTROLS_CURINDEX",0];
			//--- get the keybind options from the master list
			_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
			
			_displayName = _controlData select 0;
			_pluginPrefix = _controlData select 1;
			_varSuffix = _controlData select 2;
			_defaultKeys = _controlData select 3;
			
			//--- get keybind value from uiNamespace 
			_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
			_defaultKey = uiNamespace getVariable [_variable,+_defaultKeys];
			
			//--- if we are deleting a proper item, delete it and update the uiNamespace variable
			_ctrlKeyList = _display displayCtrl 102;
			_keyIndex = lbCurSel _ctrlKeyList;
			if(_keyIndex >= 0) then {
				_defaultKey deleteAt _keyIndex;
				_ctrlKeyList lbDelete _keyIndex;
				uiNamespace setVariable [_variable,_defaultKey];
			};
		};
		if(_mode == "clearkey") then {
			//--- get the index for the keybind options for this setting
			_index = uiNamespace getVariable ["DS_PLUGIN_CONTROLS_CURINDEX",0];
			//--- get the keybind options from the master list
			_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
			
			_displayName = _controlData select 0;
			_pluginPrefix = _controlData select 1;
			_varSuffix = _controlData select 2;
			_defaultKeys = _controlData select 3;
			
			//--- get the variable name to wipe
			_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
			
			//--- clear the keylist and clear the uiNamespace variable
			_ctrlKeyList = _display displayCtrl 102;
			lbClear _ctrlKeyList;
			uiNamespace setVariable [_variable,[]];
		};
		if(_mode == "loaddefaults") then {
			//--- get the index for the keybind options for this setting
			_index = uiNamespace getVariable ["DS_PLUGIN_CONTROLS_CURINDEX",0];
			//--- get the keybind options from the master list
			_controlData = (uiNamespace getVariable ["DS_PLUGIN_CONTROLS",[]]) select _index;
			
			_displayName = _controlData select 0;
			_pluginPrefix = _controlData select 1;
			_varSuffix = _controlData select 2;
			_defaultKeys = _controlData select 3;
			
			//--- get the variable name to reset
			_variable = _pluginPrefix + "_KEYBIND_" + _varSuffix;
			
			//--- clear the listbox, update the variable, and update the listbox with the default keys
			_ctrlKeyList = _display displayCtrl 102;
			lbClear _ctrlKeyList;
			uiNamespace setVariable [_variable,+_defaultKeys];
			
			{
				_dik = _x select 0;
				_extra = _x select 1; //Shift+ or Ctrl+ or Alt+ (0,1,2,3)
				
				
				
				//config extra to human-readable
				_prefix = switch(_extra) do {
					case 1: {"Shift+"};
					case 2: {"Ctrl+"};
					case 3: {"Alt+"};
					case 4: {"Ctrl+Shift+"};
					default {""};
				};
				//--- TODO convert _dik from DIK to human-readable key
				_displayText = _prefix + ([_dik] call BASE_fnc_dikToHuman);
				
				_index = _ctrlKeyList lbAdd _displayText;
				_ctrlKeyList lbSetData [_index,str(_x)];
				
			} forEach _defaultKeys;
		};
	
	};


	disableserialization;
	while{true} do {
		waitUntil{!isNull (findDisplay 4)};
		[[(findDisplay 4)],'onload'] call BASE_fnc_RscDisplayConfigure;
		waitUntil{isNull (findDisplay 4)};
		[[(findDisplay 4)],'onexit'] call BASE_fnc_RscDisplayConfigure;
	};
};

*/