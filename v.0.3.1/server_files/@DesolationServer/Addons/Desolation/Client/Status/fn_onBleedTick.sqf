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

params["_sourcesinfo"];
// each bleed source / level increases loss by 5 per second

_bleeding = false;

if(count(_sourcesinfo) > 0) then {
	
	_numLevels = 0;

	{
		_lvl = _x select 0;
		_numLevels = _numLevels + _lvl;
	} forEach _sourcesinfo;

	_tickLoss = (_numLevels^2) * 5;
	DS_var_Blood = DS_var_Blood - _tickLoss;
	_bleeding = true;
	
};

if(DS_var_Blood != 27500) then {
	if (isNil "DS_var_bloodEffect") then
	{
		DS_var_bloodEffect = ppEffectCreate ["ColorCorrections", 1500];
		DS_var_bloodEffect ppEffectEnable true;
		
		DS_var_bEffectSaturation = 1;
	};
	
	
	_newSaturation = DS_var_Blood / 27500;
	if(DS_var_bEffectSaturation != _newSaturation) then {
		DS_var_bEffectSaturation = _newSaturation;
		DS_var_bloodEffect ppEffectAdjust ([_newSaturation] call DS_fnc_calcGrayscale); 
		DS_var_bloodEffect ppEffectCommit 3;
	};
} else {
	if(!isNil "DS_var_bloodEffect") then {
		ppEffectDestroy DS_var_bloodEffect;
		DS_var_bloodEffect = nil;
	};
};

_ctrl = uiNamespace getVariable ["BLOOD_ICON",controlNull];

_level = (DS_var_Blood / 27500)*100;
_path = if(_bleeding) then {"DECREASING"} else {"STATIC"};
if(_path == "STATIC") then {
	if(DS_var_Hunger > 75 && DS_var_Thirst > 75 && !DS_var_isBleeding && (DS_var_Blood != 27500) && DS_var_InfectionDOT == 0) then {
		_path = "INCREASING";
	};
};


_0 = abs(_level - 0);
_1 = abs(_level - 25);
_2 = abs(_level - 50);
_3 = abs(_level - 75);
_4 = abs(_level - 100);

_min = (((_0 min _1) min _2) min _3) min _4;
if(_min == _0) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\BLOOD\0.paa");
};
if(_min == _1) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\BLOOD\25.paa");
};
if(_min == _2) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\BLOOD\50.paa");
};
if(_min == _3) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\BLOOD\75.paa");
};
if(_min == _4) then {
	_ctrl ctrlSetText ("dsr_ui\Assets\hud\" +_path + "\BLOOD\100.paa");
};

// 5.5L of blood in the body
// 20% = feels weak (can't run, may stumble)
// 35% = falling unconscious
// 50% = death
// so players can lose 2.75L of blood till they die
// so the logical standpoint is to have their blood be 27500 and when it reaches 0 they die