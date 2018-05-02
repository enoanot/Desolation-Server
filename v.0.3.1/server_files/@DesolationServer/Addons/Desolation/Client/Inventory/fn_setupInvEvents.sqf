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

disableSerialization;
waitUntil{!isNull findDisplay 602 || !DS_var_InvOpen};

_display = findDisplay 602;
if(isNull _display) exitWith {systemchat "ERROR: event displayNull";};
_listboxes = [633,638,619];
{
	_ctrl = (_display displayCtrl _x);
	if(isNull _ctrl) exitWith {systemchat "ERROR: event ctrlNull";};
	_ctrl ctrlAddEventHandler ["LbDblClick",{[_this] spawn ds_fnc_itemClick}];
} forEach _listboxes;