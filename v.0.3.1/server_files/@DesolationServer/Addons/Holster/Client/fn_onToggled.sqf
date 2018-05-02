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

_found = false;
if(toLower(["Enabled","HOL"] call BASE_fnc_getCfgValue) == "true") then {
	if(vehicle player == player && alive player) then {
		if(((currentWeapon player) find "DSR_Melee_" != -1) && (speed player > 0)) then {
			player playMoveNow "AmovPercMstpSrasWlnrDnon_AmovPercMstpSnonWnonDnon";
		};
		player action ["SwitchWeapon",player,player,-1];
		if(!isNull DS_var_ItemInHands) then {
			deleteVehicle DS_var_ItemInHands; //remove holdable from hand
		};
		_found = true;
	};
};
_found;