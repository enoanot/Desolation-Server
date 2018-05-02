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

params["_bloodChange"];

_currentLevel = player getVariable ["PVAR_DS_Progression_Medical_Level",0];
if(_currentLevel >= 1) then {
	_bloodChange = _bloodChange + 2500;
};

DS_var_Blood = (DS_var_Blood + _bloodChange) min 27500;