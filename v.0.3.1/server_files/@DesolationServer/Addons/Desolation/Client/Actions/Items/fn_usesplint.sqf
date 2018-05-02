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

// Kegan made me syntax
params["_classname",["_target",""]];

_animation = "Medic";
if(_target isEqualType "") then {

	_success = {
		player setHitPointDamage ["HitLegs",0];
		[1] call DS_fnc_addPoints;
		systemchat "My legs feel better";
		["DS_var_selfSplintCallbackFnc",["splint_self",[]]] call DS_fnc_handleCallback;
	};
	_failure = {
		private["_type"];
		_type = _this select 0;
		if(_type != "Player Moved") then {
			systemchat _type;
		};
	};
	[_classname,_animation,true,_success,_failure] call DS_fnc_useItem;
	
} else {

	if(isNull _target) exitWith {};
	
	_success = {
		params["_target"];
		[1] call DS_fnc_addPoints;
		{
			player setHitPointDamage ["HitLegs",0];
		} remoteExecCall ["call",_target];
		["DS_var_otherSplintCallbackFnc",["splint_others",[]]] call DS_fnc_handleCallback;
	};
	_failure = {
		private["_type"];
		_type = _this select 0;
		if(_type != "Player Moved") then {
			systemchat _type;
		};
	};
	[_classname,_target,_animation,true,_success,_failure] call DS_fnc_useItemTarget;

};
