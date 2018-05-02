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

params["_classname",["_target",objNull]];

_animation = "MedicOther";


if (isNull _target) then {

	if !(_classname in magazines player) exitWith {systemChat "Item(s) missing: All Purpose Knife";};
	
	player PlayMoveNow "Acts_AidlPsitMstpSsurWnonDnon_out";
	player setVariable ["SVAR_DS_var_isZiptied",nil,true];

	[1] call DS_fnc_addPoints;
	
} else {

	_success = {
		params["_target"];
		
		[_target, "Acts_AidlPsitMstpSsurWnonDnon_out"] remoteExecCall ["PlayMoveNow", -2]; // playmovenow because others wont work (release from ziptie animation back to normal)
		_target setVariable ["SVAR_DS_var_isZiptied",nil,true];
		
		[1] call DS_fnc_addPoints;
		
	};
	_failure = {
		private["_type"];
		_type = _this select 0;
		systemchat _type;
	};
	
	[_classname,_target,_animation,false,_success,_failure] call DS_fnc_useItemTarget;
};
 
 
 
 
