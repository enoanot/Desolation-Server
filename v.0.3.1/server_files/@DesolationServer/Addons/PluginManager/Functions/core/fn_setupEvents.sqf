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

private["_code"];
params["_fnclist"];

diag_log "<PluginManager>: Initializing server events";

{
	_isHandleDisconnect = [_x,"handleDisconnect"] call BASE_fnc_hasSuffix;
	_isOnEachFrame = [_x,"onEachFrame"] call BASE_fnc_hasSuffix;
	
	if(_isHandleDisconnect) then {
		_code = missionNamespace getVariable [_x,{}];
		
		
	};
	if(_isOnEachFrame) then {
		_code = missionNamespace getVariable [_x,{}];
		
		
	};
	
} forEach _fnclist;