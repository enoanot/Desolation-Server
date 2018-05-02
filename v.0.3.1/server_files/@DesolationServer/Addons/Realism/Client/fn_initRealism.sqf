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

params["_player"];

_player setUnitRecoilCoefficient (call compile (["Recoil","RSM"] call BASE_fnc_getCfgValue));
_player setCustomAimCoef (call compile (["Sway_Multiplier","RSM"] call BASE_fnc_getCfgValue));

_blur_enabled = (call compile (["Enable_Blur","RSM"] call BASE_fnc_getCfgValue));
if(_blur_enabled) then {
	LAST_SHOT = -1;
	NUM_SHOTS = 0;

	[] spawn RSM_fnc_blurMonitor;
	
	_player addEventHandler ["Fired",{
		NUM_SHOTS = NUM_SHOTS + 1;
		LAST_SHOT = diag_tickTime;
		
		if(isNil "SHOT_EFFECT") then {
			_priority = 400;
			while {
				SHOT_EFFECT = ppEffectCreate ["DynamicBlur", _priority];
				SHOT_EFFECT < 0
			} do {
				_priority = _priority + 1;
			};
			SHOT_EFFECT ppEffectEnable true;
		};
		SHOT_EFFECT ppEffectAdjust [(call compile (["Blur_Coefficient","RSM"] call BASE_fnc_getCfgValue))*NUM_SHOTS];
		SHOT_EFFECT ppEffectCommit 0;
		SHOT_EFFECT ppEffectAdjust [0];
		SHOT_EFFECT ppEffectCommit 2;
	}];
};



