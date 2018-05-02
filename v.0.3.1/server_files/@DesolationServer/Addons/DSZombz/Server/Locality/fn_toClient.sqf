params["_client","_zed"];

_cOwner = owner _client;

if(groupOwner (group _zed) == _cOwner) exitWith {diag_log "DSZOMBZ > ERROR: ZOMBIE ALREADY LOCAL TO CLIENT fn_toClient.sqf"};

(group _zed) setGroupOwner _cOwner;