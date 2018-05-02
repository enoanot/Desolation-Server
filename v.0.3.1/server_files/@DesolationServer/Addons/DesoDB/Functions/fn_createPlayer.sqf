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
 
 /// used in Desolation createPlayer request

#include "\DesoDB\constants.hpp" 

params["_playerObj"];

_playeruuid = "";
_i = 0;

while {(_playeruuid == "") && (_i < 10)} do
{
	_playeruuid = _playerObj getVariable ["pUUID",""];
	if(_playeruuid != "") then { 
		
		/* create new character in database and set the returned uuid to the character */
		_serializedData = [_playerObj] call DB_fnc_serializePlayer;
		if ((_serializedData select 1) == _playeruuid) then {
			_request = [PROTOCOL_DBCALL_FUNCTION_CREATE_CHAR,_serializedData];
			_response = [_request] call DB_fnc_sendRequest;
			
			_playerObj setVariable ["cUUID",_response];
			
			/* load new character in case there are linked variables from other characters */
			_request = [PROTOCOL_DBCALL_FUNCTION_LOAD_CHAR,[PROTOCOL_DBCALL_ARGUMENT_PLAYER_UUID,_playeruuid]];
			_data = [_request] call DB_fnc_sendRequest;
			
			_nonpersvars = _data select 9;
			_persvars = _data select 14;
			
			/* object the player should be teleported into */
			_objectuuid = _data select 16;
			
			{
				_playerObj setVariable [_x select 0,_x select 1,true];
				diag_log ("SETTING VARIABLE: " + str(_x select 0) + " VALUE: " + str(_x select 1));
			} forEach _nonpersvars;
			
			{
				_playerObj setVariable [_x select 0,_x select 1,true];
				diag_log ("SETTING PERSISTANT VARIABLE: " + str(_x select 0) + " VALUE: " + str(_x select 1));
			} forEach _persvars;
			
			/* TODO: if _objectuuid != 0 search vehicle and port character into this vehicle */
		} else {
			diag_log format ["UUID of Player: %1 did not match the uuid in the object: %2", _playeruuid, _serializedData select 1];
			_playeruuid = "";
		}
	};
	_i = _i + 1;
};

if(_playeruuid == "") then {
	diag_log "INTERNAL ERROR | FATAL > PlayerUUID not on the targeted unit when creating! - was not able to create the players character in the database!";
};