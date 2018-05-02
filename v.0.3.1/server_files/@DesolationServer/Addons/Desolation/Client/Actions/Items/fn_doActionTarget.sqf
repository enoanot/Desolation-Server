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

params[["_action",0],["_target",objNull]];
if(isNull _target) exitWith {};

_actions = ["Medic","MedicOther","MedicStart"];

if(!isNil 'ds_var_doingAction') then {
	if(ds_var_doingAction) exitWith {systemchat "You are already doing something!";false};
};
ds_var_cancelAction = false;
ds_var_doingAction = true;
_event = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	_key = _this select 1;
	if((_key in (actionKeys "MoveForward")) || (_key in (actionKeys "MoveBack")) || (_key == 30) || (_key == 32) || !(player == vehicle player)) then {
		ds_var_cancelAction = true;
	};
	false;
}];
_time = diag_tickTime + 6;
player playActionNow (_actions select _action);
_pos = getposatl _target;
waitUntil{diag_tickTime >= _time || ds_var_cancelAction || (_target distance _pos > 0.1)};
if(_target distance _pos > 0.1) then {
	ds_var_cancelAction = true;
};
[player,"amovpknlmstpsraswrfldnon"] remoteExecCall ["switchMove",-2];
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_event];
ds_var_doingAction = false;
if(ds_var_cancelAction) exitWith {false};

true;
