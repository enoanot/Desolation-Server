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
_classname = "dsr_item_handwarmer";
_animation = "Medic";
_success = {
	[1] call DS_fnc_addPoints;
	Systemchat "TODO: Action";
};
_failure = {
	private["_type"];
	_type = _this select 0;
	if(_type != "Player Moved") then {
		systemchat _type;
	};
};

[_classname,_animation,true,_success,_failure] call DS_fnc_useItem;
