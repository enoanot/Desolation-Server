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

params[["_action",0]];

_actions = ["Acts_CarFixingWheel","Medic"];

if(!isNil 'act_var_doingAction') then {
	if(act_var_doingAction) exitWith {systemchat "You are already doing something!";false};
};
act_var_cancelAction = false;
act_var_doingAction = true;
_event = (findDisplay 46) displayAddEventHandler ["KeyDown",{
	_key = _this select 1;
	if((_key in (actionKeys "MoveForward")) || (_key in (actionKeys "MoveBack")) || (_key == 30) || (_key == 32) || !(player == vehicle player)) then {
		act_var_cancelAction = true;
	};
	false;
}];
_time = diag_tickTime + 15;
if(_action == 1) then {
	_time = diag_tickTime + 6;
	player playActionNow (_actions select _action);
} else {
	player playMoveNow (_actions select _action);
};
waitUntil{diag_tickTime >= _time || act_var_cancelAction};
[player,"amovpknlmstpsraswrfldnon"] remoteExecCall ["switchMove",-2];
(findDisplay 46) displayRemoveEventHandler ["KeyDown",_event];
act_var_doingAction = false;
if(act_var_cancelAction) exitWith {false};

true;
