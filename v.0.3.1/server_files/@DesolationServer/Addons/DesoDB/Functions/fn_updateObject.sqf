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

params["_object", ["_objectType", -1], ["_priority", -1]];

_serializedData = [_object, _objectType, _priority] call DB_fnc_serializeObject;
_request = [PROTOCOL_DBCALL_FUNCTION_QUIET_UPDATE_OBJECT,_serializedData];
[_request] call DB_fnc_sendRequest;
