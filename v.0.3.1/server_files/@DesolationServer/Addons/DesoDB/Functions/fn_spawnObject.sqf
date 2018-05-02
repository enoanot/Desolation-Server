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

_object setVariable ["DSR_objectType", _objectType];
_object setVariable ["DSR_priority", _priority];
if (_objectType == 2) then {
	_object setVariable ["DSR_positionAdvanced", [
							["DSR_vectorUp",str(vectorUp _object)], //high precision vectorup
							["DSR_vectorDir",str(vectorDir _object)], //high precision vectordir
							["DSR_position",(getPosATL _object) call DB_fnc_hpFloatArray] //high precision position
						]];
};

_serializedData = [_object, _objectType, _priority] call DB_fnc_serializeObject;
_request = [PROTOCOL_DBCALL_FUNCTION_QUIET_CREATE_OBJECT,_serializedData];
[_request] call DB_fnc_sendRequest;

_object_uuid = _serializedData select 1;
DB_var_Objects pushback _object;
DB_var_ObjectUUIDS pushback _object_uuid;
