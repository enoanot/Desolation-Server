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
 
params["_password",["_callback",{}]];
_password = bis_functions_mainscope getVariable ["ServerCommandPassword_DS", ""];

// add these toggles so TimeManagement can be used without SM_Zombz or Desolation plugins
if(isNil "DS_var_finishedObjects") then {
	DS_var_finishedObjects = true;
};
if(isNil "LSYS_var_finishedLoot") then {
	LSYS_var_finishedLoot = true;
};
if(isNil "SM_var_finishedZombies") then {
	SM_var_finishedZombies = true;
};
_success = false;
if(DS_var_finishedObjects && LSYS_var_finishedLoot && SM_var_finishedZombies) then {
	_password serverCommand "#unlock";
	diag_log "TimeManagement > Server Unlocked";
	
	[_password,_callback] spawn TM_fnc_restartTimer;
	_success = true;
};
_success;