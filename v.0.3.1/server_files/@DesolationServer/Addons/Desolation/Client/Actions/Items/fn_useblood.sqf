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

params["_classname",["_target",""]];
_animation = "Medic";
if(_target isEqualType "") then {
	_success = {
		[15000] call DS_fnc_onBloodReceive;
		[1] call DS_fnc_addPoints;
		["DS_var_selfBloodbagCallbackFnc",["bloodbag_self",[]]] call DS_fnc_handleCallback;
	};
	_failure = {
		private["_type"];
		_type = _this select 0;
		if(_type != "Player Moved") then {
			systemchat _type;
		};
	};

	[_classname,_animation,true,_success,_failure,"dsr_item_bloodbag_empty"] call DS_fnc_useItem;
	
} else {

	if(isNull _target) exitWith {};
	
	_success = {
		params["_target"];
		[1] call DS_fnc_addPoints;
		[15000] remoteExecCall ["DS_fnc_onBloodReceive",_target];
		["DS_var_otherBloodbagCallbackFnc",["bloodbag_others",[]]] call DS_fnc_handleCallback;
	};
	_failure = {
		private["_type"];
		_type = _this select 0;
		if(_type != "Player Moved") then {
			systemchat _type;
		};
	};
	
	[_classname,_target,_animation,true,_success,_failure,"dsr_item_bloodbag_empty"] call DS_fnc_useItemTarget;

};
 
 
 
 
 
 
