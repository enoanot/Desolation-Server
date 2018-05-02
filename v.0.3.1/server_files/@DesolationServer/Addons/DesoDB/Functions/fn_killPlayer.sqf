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
 
 /// used in Desolation killPlayer request
 
#include "\DesoDB\constants.hpp" 

params["_playerObj","_killerObj"];

_killType = 0;
if(!isNull _killerObj && isPlayer _killerObj && _killerObj != _playerObj) then {
	_killType = 1;
};
if(!isNull _killerObj && isPlayer _killerObj && _killerObj == _playerObj) then {
	_killType = 2;
};

_deadCharUUID = _playerObj getVariable ["cUUID",""];
_killerPlayerUUID = "";
_type = "Unknown";
_weapon = "";
_distance = 0;


switch(_killType) do {
	case 1: {
		_config = "CfgWeapons";
		_class = currentWeapon _killerObj;	
		if (vehicle _killerObj != _killerObj) then {
			_config = "CfgVehicles";
			_class = typeOf vehicle _killerObj;
		};
		_currentWeapon = getText (configfile >> _config >> _class >> "displayName");

		_killerPlayerUUID = _killerObj getVariable ["pUUID",""];
		_weapon = _currentWeapon; 
		_distance = _killerObj distance _playerObj;
		_type = "Killed";
	};
	case 2: {
		_type = "Suicide";
	};
};
_request = [PROTOCOL_DBCALL_FUNCTION_DECLARE_CHAR_DEATH,[
	PROTOCOL_DBCALL_ARGUMENT_CHARUUID,_deadCharUUID,
	PROTOCOL_DBCALL_ARGUMENT_ATTACKER,_killerPlayerUUID,
	PROTOCOL_DBCALL_ARGUMENT_TYPE,_type,
	PROTOCOL_DBCALL_ARGUMENT_WEAPON,_weapon,
	PROTOCOL_DBCALL_ARGUMENT_DISTANCE,_distance
]];
[_request] call DB_fnc_sendRequest;
