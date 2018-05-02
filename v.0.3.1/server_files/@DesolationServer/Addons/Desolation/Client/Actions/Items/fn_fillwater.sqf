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

params["_classname"];

_class = toLower(_classname);
_animation = "Medic";

if (_class find "_empty" == -1) exitWith {};
_data = (toLower(_class) splitString "_");
_data deleteAt (count(_data)-1);
_data pushBack "dirty";
_newItem = _data joinString "_";

_success = {
	[1] call DS_fnc_addPoints;
	systemchat "Filled with water";
};
_failure = {
	private["_type"];
	_type = _this select 0;
	if(_type != "Player Moved") then {
		systemchat _type;
	};
};
[_classname,_animation,true,_success,_failure,_newItem] call DS_fnc_useItem;
