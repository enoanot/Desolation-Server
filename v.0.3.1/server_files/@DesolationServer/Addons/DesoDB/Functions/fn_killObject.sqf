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
 
#include "\DesoDB\constants.hpp" 
 
params["_object_uuid","_killerObj"];

_killerUUID = "";
_type = "Unknown";
_weapon = "";
_distance = 0;

// if _object_uuid is an object not an uuid, get the uuid!
if (typeName _object_uuid != "STRING") then {
	_object = _object_uuid;
	_object_uuid = _object getVariable ["oUUID",""];

	// fallback in case the object has no oUUID, for example because its already dead
	if (_object_uuid == "") then {
		_pos = DB_var_Objects find _object;
		if (_pos >= 0) then {
			_object_uuid = DB_var_ObjectUUIDS select _pos;
		};
	};
};

// now _object_uuid should 
if (_object_uuid != "") then {
	// find the object uuid in the object uuid 
	_pos = DB_var_ObjectUUIDS find _object_uuid;
	
	// if object uuid was found, delete the object reference as well the object uuid
	if (_pos >= 0) then {
		DB_var_Objects deleteAt _pos;
		DB_var_ObjectUUIDS deleteAt _pos;
	};
	
	/*
	if(!isNull _killerObj && isPlayer _killerObj) then {
		_killerUUID = _killerObj getVariable ["cUUID",""];
		_weapon = "TODO: get weapon"; 
		_distance = _killerObj distance _playerObj;
		_type = "Killed";
	};
	*/

	_request = [PROTOCOL_DBCALL_FUNCTION_DECLARE_OBJECT_DEATH,[
		PROTOCOL_DBCALL_ARGUMENT_OBJECTUUID,_object_uuid,
		PROTOCOL_DBCALL_ARGUMENT_ATTACKER,_killerUUID,
		PROTOCOL_DBCALL_ARGUMENT_TYPE,_type,
		PROTOCOL_DBCALL_ARGUMENT_WEAPON,_weapon,
		PROTOCOL_DBCALL_ARGUMENT_DISTANCE,_distance
	]];
	[_request] call DB_fnc_sendRequest;
};
