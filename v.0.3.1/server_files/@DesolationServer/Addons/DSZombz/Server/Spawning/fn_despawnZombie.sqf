params["_zed"];

if(isNull _zed) exitWith {diag_log "DSZOMBZ > Can't despawn unknown zombie!";}; // zombie didnt exist, wtf?

_zIndex = _zed getVariable ["zIndex",-1];

if !([getpos _zed] call DSZ_fnc_isPlayerNear) then {
	
	// update zombie position in spawnData
	_zData = DSZ_var_spawnData select _zIndex;
	_zData set[1,getposatl _zed];
	DSZ_var_spawnData set[_zIndex,_zData];

	//transfer locality if not local
	if(!local (group _zed)) then {[_zed] call DSZ_fnc_fromClient;};
	
	
	//update holder
	_holder = _zData select (count(_zData)-1);
	_holder setposatl (_zData select 1);
	_holder setVariable ["isSpawned",false];
	
	_group = group _zed;
	deleteGroup _group;
	deleteVehicle _zed;
	
} else {
	_near = [getpos _zed] call DSZ_fnc_getNearPlayers;
	if(count(_near) > 0) then {
		// transfer zombie locality to new near player
		_plr = _near select 0;
		[_plr,_zed] call DSZ_fnc_toClient;
	} else {
		diag_log "DSZOMBZ > ERROR: Player near but not found when despawning";
	};
};