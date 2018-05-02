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

DS_var_finishedObjects = false;
DS_var_unlocked = false;

// if the variable is undefined, define it (This is temporary until the new zombie system is in place)
if(isNil "SM_var_finishedZombies") then {
	SM_var_finishedZombies = false;
};

_password = bis_functions_mainscope getVariable ["ServerCommandPassword_DS", ""];
if(!isNil "TM_fnc_lock") then {
	[_password] call TM_fnc_lock;
} else {
	_password serverCommand "#lock";
	diag_log "SERVER LOCKING > LOCKED";
};
