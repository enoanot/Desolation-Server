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
  
params["_object", ["_objectType", 3], ["_priority", 10001]];

if (_objectType < 0) then {
	_objectType = _object getVariable ["DSR_objectType", 3];
};

if (_priority < 0) then {
	_priority = _object getVariable ["DSR_priority", 10001];
};

// vehicles are the object type of 3 with default spawn priority of 10001
// their priority should never be higher then the priority of buildings
if ((_objectType == 3) && (_priority < 10000)) then {
	_priority = 10001;
};

// buildings are the object type of 2 with default spawn priority of 1001
// their priority should never be lower then the priority of vehicles
if ((_objectType == 2) && (_priority > 10000)) then {
	_priority = 1001;
};

// type
_className = typeof _object;

// owner and unlock code
// TODO REMOVE IN NEXT UPDATE!
_oldAccescode = _object getVariable ["SVAR_UnlockCode",[]];
if!(_oldAccescode isEqualTo []) then {
	_object setVariable ["APMS_UnlockCode",_oldAccescode,true];
};
_accesscode = _object getVariable ["APMS_UnlockCode",[]];
_locked = locked _object;
_player_uuid = _object getVariable ["oOWNER",""];

_hitpoints = [];
_temp = getAllHitPointsDamage _object;
if(count(_temp) > 2) then {
	{
		if(_x != "") then {
			_vArray = _temp select 2;
			if(count(_vArray) > _forEachIndex) then {
				_value = (_temp select 2) select _forEachIndex;
				_hitpoints pushback [_x,_value];
			};
		};
	} forEach (_temp select 0);
};
_damage = damage _object;
_fuel = fuel _object;

_fuelcargo = getFuelCargo _object;
if (isNil "_fuelcargo" || { !(finite _fuelcargo) }) then {
	_fuelcargo = 0;
};

_repaircargo = getRepairCargo _object;
if (isNil "_repaircargo" || { !(finite _repaircargo) } ) then {
	_repaircargo = 0;
};

// container items
_items = ([_object] call BASE_fnc_getAllCargo); // gets loot contained within object if it is a container
_reservedone = []; // todo
_reservedtwo = []; // todo
_magazinesturrent = []; // todo

// get server owner custom variables
_variables = [];
{
	if(toLower(_x) find "svar_" == 0) then {
		_variables pushback [_x,_object getVariable [_x,""]];
	};
} forEach (allVariables _object);

// animations and textures
_animation_sources = [];
_textures = getObjectTextures _object;

// position stuff
_direction = getDir _object;
_positionType = 1;
_position = getPosATL _object;
_positionadvanced = [["DSR_vectorUp",str(vectorUp _object)]]; 
if (_objectType == 2) then {
	_positionadvanced = _object getVariable ["DSR_positionAdvanced", [
		["DSR_vectorUp",str(vectorUp _object)], //high precision vectorup
		["DSR_vectorDir",str(vectorDir _object)], //high precision vectordir
		["DSR_position",(getPosATL _object) call DB_fnc_hpFloatArray] //high precision position
	]]; 
};

// support to add objects that already have an uuid - in case i fuck up again (Legodev)
_object_uuid = _object getVariable ["oUUID",""];

if (_object_uuid == "") then {
	_request = [PROTOCOL_DBCALL_FUNCTION_RETURN_UUID,[]];
	_object_uuid = [_request] call DB_fnc_sendRequest;
	_object setVariable ["oUUID",_object_uuid];
};

[
	PROTOCOL_DBCALL_ARGUMENT_OBJECTUUID,_object_uuid,
	PROTOCOL_DBCALL_ARGUMENT_CLASSNAME,_className,
	PROTOCOL_DBCALL_ARGUMENT_PRIORITY,_priority,
	PROTOCOL_DBCALL_ARGUMENT_OBJECTTYPE,_objectType,
	PROTOCOL_DBCALL_ARGUMENT_ACCESSCODE, _accesscode,
	PROTOCOL_DBCALL_ARGUMENT_LOCKED,_locked,
	PROTOCOL_DBCALL_ARGUMENT_PLAYER_UUID,_player_uuid,
	PROTOCOL_DBCALL_ARGUMENT_HITPOINTS,_hitpoints,
	PROTOCOL_DBCALL_ARGUMENT_DAMAGE,_damage,
	PROTOCOL_DBCALL_ARGUMENT_FUEL,_fuel,
	PROTOCOL_DBCALL_ARGUMENT_FUELCARGO,_fuelcargo,
	PROTOCOL_DBCALL_ARGUMENT_REPAIRCARGO,_repaircargo,
	PROTOCOL_DBCALL_ARGUMENT_ITEMS,_items,
	PROTOCOL_DBCALL_ARGUMENT_MAGAZINESTURRET, _magazinesturrent,
	PROTOCOL_DBCALL_ARGUMENT_VARIABLES, _variables,
	PROTOCOL_DBCALL_ARGUMENT_ANIMATIONSTATE, _animation_sources,
	PROTOCOL_DBCALL_ARGUMENT_TEXTURES, _textures,
	PROTOCOL_DBCALL_ARGUMENT_DIRECTION, _direction,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONTYPE, _positionType,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONX, _position select 0,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONY, _position select 1,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONZ, _position select 2,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONADVANCED,_positionadvanced,
	PROTOCOL_DBCALL_ARGUMENT_RESERVEDONE, _reservedone,
	PROTOCOL_DBCALL_ARGUMENT_RESERVEDTWO, _reservedtwo
];
