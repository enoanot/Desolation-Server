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

disableserialization;
0 cutRsc ["background","PLAIN",0];
createDialog "DS_spawnSelection";

_display = findDisplay 4000;

_northBTN = _display displayCtrl 1600;
_eastBTN = _display displayCtrl 1602;
_southBTN = _display displayCtrl 1601;

_northText = ["Zone1Button","DS"] call BASE_fnc_getCfgValue;
_southText = ["Zone2Button","DS"] call BASE_fnc_getCfgValue;
_eastText = ["Zone3Button","DS"] call BASE_fnc_getCfgValue;

_southBTN ctrlSetText _southText;
_northBTN ctrlSetText _northText;
_eastBTN ctrlSetText _eastText;