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
 
 /// used in Desolation savePlayer request

#include "\DesoDB\constants.hpp" 
 
 
params["_playerObj"];
_playeruuid = _playerObj getVariable ["pUUID",""];
_charuuid = _playerObj getVariable ["cUUID",""];
if(_playeruuid == "") exitWith {
	diag_log "WARNING: PlayerUUID not on the targeted unit!";
	diag_log "As long as this only occurs once when an player joined, there might be no problem!";
	diag_log "Only start worrying when this occurs on mass!";
};

if(_charuuid == "") exitWith {
	diag_log "WARNING: CharUUID not on the targeted unit!";
	diag_log "As long as this only occurs once when an player joined, there might be no problem!";
	diag_log "Only start worrying when this occurs on mass!";
};

_serializedData = [_playerObj] call DB_fnc_serializePlayer;
_request = [PROTOCOL_DBCALL_FUNCTION_QUIET_UPDATE_CHAR,_serializedData];
[_request] call DB_fnc_sendRequest;
