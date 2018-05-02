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

disableserialization;
params["_display"];

_lastTime = missionNamespace getVariable ["DS_var_escapeTimer",diag_tickTime];
if(diag_tickTime >= _lastTime) then {
	missionNamespace setVariable ["DS_var_escapeTimer",diag_tickTime+60];
	call ds_fnc_saveData;
};

if((isNull _display) || (isNil "_display")) exitWith {systemchat "ESCAPE DISPLAY NIL";};


// RESPAWN BUTTON
_ctrl = _display displayCtrl 103;
_ctrl buttonSetAction "DS_var_Blood = -1000;";
_ctrl ctrlSetText "Suicide";
[_ctrl] spawn {
	disableserialization;
	params["_ctrl"];
	if (!isNil {player getVariable "DS_var_isPlaying"}) then {_ctrl ctrlEnable true;} else {_ctrl ctrlEnable false;};
};
_ctrl = _display displayCtrl 1002;
_ctrl ctrlEnable false;
_ctrl = _display displayCtrl 1010;
_ctrl ctrlEnable false;



// ABORT BUTTON
_abortBtn = _display displayCtrl 104;
_abortBtn ctrlEnable false;

[_abortBtn] spawn {
	disableserialization;
	params["_abortBtn"];

	_time = 10;
	if !(isNil {player getVariable "DS_var_inCombat"}) then {_time = 30;};

	while {alive player && _time > 0} do {
		_abortBtn ctrlSetText format ["Please wait: %1", _time];
		_abortBtn ctrlEnable false;
		
		_time = _time - 1;
		sleep 1;
	};
	
	if !(isNil {player getVariable "DS_var_inCombat"}) then {player setVariable ["DS_var_inCombat", nil, true];}; // Make sure player is not in combat when logging out
	_abortBtn ctrlEnable true;
	_abortBtn ctrlSetText "Abort";
};