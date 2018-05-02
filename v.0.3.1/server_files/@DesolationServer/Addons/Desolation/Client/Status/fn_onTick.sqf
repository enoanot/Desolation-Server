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

_sourcesinfo = player getVariable ["DS_var_BleedSourcesInfo",[]];
if(count(_sourcesinfo) > 0) then {
	if !(DS_var_isBleeding) then {
		DS_var_isBleeding = true;
	};
} else {
	if (DS_var_isBleeding) then {
		DS_var_isBleeding = false;
	};
};
[_sourcesinfo] call ds_fnc_onBleedTick;

if(rating player < 0) then {
	player addRating 9999999;
};

call ds_fnc_onInfectionTick;
call ds_fnc_onHungerTick;
call ds_fnc_onThirstTick;
call ds_fnc_onEffectTick;
call ds_fnc_onUpdateTick;


if(call DS_fnc_isBatteryInUse) then {
	call DS_fnc_usePowerCell;
};

if((DS_var_LastVitaminTime + (15*60)) < diag_tickTime) then {
	player enableFatigue false;
} else {
	player enableFatigue true;
};



_ctrl = uiNamespace getVariable ["TEMP_ICON",controlNull];
if((getTerrainHeightASL (position player)) > 500) then {
	_ctrl ctrlSetText "dsr_ui\Assets\hud\STATIC\TEMP\cold.paa";
} else {
	_ctrl ctrlSetText "dsr_ui\Assets\hud\STATIC\TEMP\hot.paa";
};



if((player getHitPointDamage 'HitLegs') > 0) then {
	//-- show bone icon
	_ctrl = uiNamespace getVariable ["BONE_ICON",controlNull];
	if(!isNull _ctrl) then {
		if (!ctrlShown _ctrl) then {
			_ctrl ctrlShow true;
		};
	};
} else {
	//-- hide bone icon
	_ctrl = uiNamespace getVariable ["BONE_ICON",controlNull];
	if(!isNull _ctrl) then {
		if (ctrlShown _ctrl) then {
			_ctrl ctrlShow false;
		};
	};
};