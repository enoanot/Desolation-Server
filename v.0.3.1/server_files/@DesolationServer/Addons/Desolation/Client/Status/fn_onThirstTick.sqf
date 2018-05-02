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


_dThirst = 1/18; //--- (100 total thirst) (30 min till dehyration)

DS_var_lastDrank = DS_var_lastDrank + 1;


if(DS_var_lastDrank > 3600) then { // 1 hour grace period
	DS_var_Thirst = (DS_var_Thirst - _dThirst) max 0;
	if(!DS_var_isDehydrating) then {
		DS_var_isDehydrating = true;
	};
} else {
	if(DS_var_isDehydrating) then {
		DS_var_isDehydrating = false;
	};
};

_ctrl = uiNamespace getVariable ["THIRST_ICON",controlNull];

_level = DS_var_Thirst;

_path = if(DS_var_isDehydrating) then {"DECREASING"} else {"STATIC"};

_0 = abs(_level - 0);
_1 = abs(_level - 50);
_2 = abs(_level - 100);

_min = ((_0 min _1) min _2);
if(_min == _0) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\THIRST\0.paa");
};
if(_min == _1) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\THIRST\50.paa");
};
if(_min == _2) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\THIRST\100.paa");
};