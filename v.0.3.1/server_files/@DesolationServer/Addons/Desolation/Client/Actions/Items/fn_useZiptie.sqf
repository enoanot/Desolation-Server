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

params["_classname","_target"];
_animation = "Medic";

	
if(isNull _target) exitWith {};

_success = {
	params["_target"];
	
	[_target, "Acts_AidlPsitMstpSsurWnonDnon_loop"] remoteExecCall ["switchMove", -2];
	
	_target setVariable ["SVAR_DS_var_isZiptied",true,true];
		
};
_failure = {
	private["_type"];
	_type = _this select 0;
	systemchat _type;
};
	
[_classname,_target,_animation,true,_success,_failure] call DS_fnc_useItemTarget;
 
 
 
 
 
 
