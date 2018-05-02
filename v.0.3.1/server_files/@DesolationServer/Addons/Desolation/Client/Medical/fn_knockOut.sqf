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
params["_time",["_tickCallback",{false}],["_tickCallbackParams",[]]];
player setUnconscious true;
10481 cutText ["","BLACK OUT",3];
uiSleep 3;
10481 cutText ["You are unconscious.","BLACK FADED",20];
scopeName "exitKo";
for "_i" from 1 to _time do {
	_response = [_tickCallbackParams,_i,_time] call _tickCallback;
	if(!isNil {_response}) then {
		if(typename _response == typename true) then {
			if(_response) then {breakTo "exitKo";};
		};
		if(typename _response == typename 0) then {
			_time = _response;
		};
	};

	if(player getVariable ["DS_var_Defibbed",false]) then {
		player setVariable ["DS_var_Defibbed",nil,true];
		breakTo "exitKo";
	};
	if(!alive player) exitWith {};
	uiSleep 1;
};
10481 cutText ["","BLACK IN",5];
DS_var_lastKnockout = diag_tickTime;
player setUnconscious false;
if(!alive player) exitWith {};

if (!isNil {player getVariable "SVAR_DS_var_isZiptied"}) then {
	player switchMove "Acts_AidlPsitMstpSsurWnonDnon_loop";
} else {
	player switchMove "unconsciousoutprone";
};
//--- TODO: sync the switchmove