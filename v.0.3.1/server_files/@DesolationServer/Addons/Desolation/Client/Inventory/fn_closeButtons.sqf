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
_buttons = uiNamespace getVariable ["ds_var_itemButtons",[]];
{
	if(!isNull _x) then {
		ctrlDelete _x;
	};
} forEach _buttons;
uiNamespace setVariable ["ds_var_itemButtons",[]];