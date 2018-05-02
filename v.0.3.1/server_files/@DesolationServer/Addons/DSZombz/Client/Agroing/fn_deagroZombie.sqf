params["_zed"];



if(!alive _zed || isNull _zed) exitWith {};

_zed enableCollisionWith player;

//reallow walking
_zed removeEventHandler ["AnimChanged",_zed getVariable ["animEVH",-1]];

_zed forceSpeed (_zed getSpeed "SLOW");
_zed setVariable ["agroed",false,true];


// restart roaming AI
_zInformation = _zed getVariable ["zInformation",[]];
if(count(_zInformation) == 0) exitWith {diag_log "ERROR: wtf no data index?";};
[_zInformation select 1,_zInformation select 2,group _zed] call DSZ_fnc_initRoaming;