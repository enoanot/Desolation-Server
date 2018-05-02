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

if (isNil "DS_var_3DActionsEnabled") then
{
	DS_var_3DActionsEnabled = false;
};

if !(DS_var_3DActionsEnabled) then
{
	systemChat "Enabled";
	DS_var_3DActionsEnabled = true;
	DS_var_3DDrawEvent = addMissionEventHandler ["Draw3D",{ [] call DS_fnc_draw3DActions; }];
	[] spawn DS_fnc_calculate3DActions;
}
else
{
	systemChat "Disabled";
	DS_var_3DActionsEnabled = false;
	if (isNil "DS_var_3DDrawEvent") exitWith { false };
	removeMissionEventHandler ["Draw3D", DS_var_3DDrawEvent];
	DS_var_3DDrawEvent = nil;
	DS_var_3DPartName = nil;
	DS_var_3DActionData = nil;
	DS_var_valid3DActionsCode = nil;
	DS_var_valid3DActionCodeSelected = nil;
};

true