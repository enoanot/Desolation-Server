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

_animation = "Medic";

wires = [];
{ 
    if !(str(_x) find "wire" == -1) then { 
     	wires pushBack _x;
 	}; 
} forEach nearestObjects [player, [], 2.8];

if (wires isEqualTo []) exitWith {systemChat "No razor wires nearby"};

_success = {
	[1] call DS_fnc_addPoints;

	{
		if !(str(_x) find "NOID" == -1) then {
			deleteVehicle _x;
		} else {
			_x setDamage 1;
		};
	} forEach wires;
};

_failure = {
	private["_type"];
	_type = _this select 0;
	if(_type != "Player Moved") then {
		systemchat _type;
	};
};

[_classname,_animation,false,_success,_failure] spawn DS_fnc_useItem;