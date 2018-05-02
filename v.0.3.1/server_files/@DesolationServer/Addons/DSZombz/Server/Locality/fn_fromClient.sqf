params["_zed"];

if(local (group _zed)) exitWith {diag_log "DSZOMBZ > ERROR: ZOMBIE ALREADY LOCAL TO SERVER fn_fromClient.sqf"};

(group _zed) setGroupOwner clientOwner; 