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

#include "constants.hpp"

_requiredVersion = [1,0,3,3];
_request = [PROTOCOL_LIBARY_FUNCTION_CHECK_VERSION,[]];
_version = [_request] call DB_fnc_sendRequest;
if !(_version select 0 == _requiredVersion select 0 && _version select 1 == _requiredVersion select 1 && _version select 2 >= _requiredVersion select 2 && _version select 3 >= _requiredVersion select 3) exitWith {
	[_requiredVersion] spawn {
		params["_requiredVersion"];
		for "_i" from 0 to 10 do {
			diag_log format ["Use the latest version of libredex, with an version of at least %1,%2,%3,%4 !!",_requiredVersion select 0,_requiredVersion select 1,_requiredVersion select 2,_requiredVersion select 3];
			sleep 0.5;
		};
	};
};


_worldUUID = call DB_fnc_getWorldUUID;
if(_worldUUID == "") then {
	diag_log "WARNING: WORLD IDENTIFICATION IS NOT SET, YOU WILL NOT BE ABLE TO RUN MULTIPLE INSTANCES ON THE SAME DATABASE TABLES!";
	_worldUUID = "11e7e743268ea08ca7207085c256cbec";
};


diag_log ("DesoDB > World UUID: " + _worldUUID);

_request = ["initdb",["worlduuid",_worldUUID]];
[_request] call DB_fnc_sendRequest;
