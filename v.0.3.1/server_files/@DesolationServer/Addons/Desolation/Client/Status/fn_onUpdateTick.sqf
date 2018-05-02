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
 
//--- notify server of variables (both persistant and non-persistant)

if(player getVariable ["SVAR_DS_var_Blood",0] != DS_var_Blood) then {
	player setVariable ["SVAR_DS_var_Blood",DS_var_Blood,true];
};
if(player getVariable ["SVAR_DS_var_Thirst",0] != DS_var_Thirst) then {
	player setVariable ["SVAR_DS_var_Thirst",DS_var_Thirst,true];
};
if(player getVariable ["SVAR_DS_var_Hunger",0] != DS_var_Hunger) then {
	player setVariable ["SVAR_DS_var_Hunger",DS_var_Hunger,true];
};
if(player getVariable ["SVAR_DS_var_InfectionDOT",0] != SM_infectionDOT) then {
	player setVariable ["SVAR_DS_var_InfectionDOT",SM_infectionDOT,true];
};
// save bleed source data without causing issues with JIP
if !((player getVariable ["SVAR_BleedData",[]]) isEqualTo (player getVariable ["BLEED_SOURCES",[]])) then {
	player setVariable ["SVAR_BleedData",(player getVariable ["BLEED_SOURCES",[]]),true];
};

player setVariable ["SVAR_TimedStates",[DS_var_lastAte,DS_var_lastDrank,DS_var_lastImmune],true];

