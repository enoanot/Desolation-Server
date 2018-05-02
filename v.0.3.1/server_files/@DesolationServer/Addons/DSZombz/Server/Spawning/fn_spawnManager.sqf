

//[[],{
while{true} do {
	_aliveZombieIndexes = [];
	_zedsToSpawn = [];
	
	_lastNum = -1;
	DSZ_var_spawnedZeds = DSZ_var_spawnedZeds - [objNull];
	{
		if(!isNull _x) then {
			_zIndex = _x getVariable ["zIndex",-1]; //get zombie index information
			if !([getposatl _x] call DSZ_fnc_isPlayerNear) then { 
				if(alive _x) then {
					[_x] call DSZ_fnc_despawnZombie; // if no player is near, despawn
				};
			} else {
				_aliveZombieIndexes pushback _zIndex; // mark that index as a spawned zombie
				_nearPlayers = [getposatl _x] call DSZ_fnc_getNearPlayers;
				
				if(local group _x && count(_nearPlayers) > 0) then {
					//-- transfer locality to nearest man
					_plr = _nearPlayers select 0;
					
					
					[_plr,_x] call DSZ_fnc_toClient;
				};
				
				// play zombie moan if random time delay is triggered
				if !(_x getVariable ["agroed",false]) then {
					_moanDelay = _x getVariable ["MoanDelay",diag_tickTime + (5 + random(5))];
					if(diag_tickTime >= _moanDelay) then {
						
						_sNumber = _lastNum;
						while{_sNumber == _lastNum} do {
							_sNumber = ceil(random(36));
						};
						_lastNum = _sNumber;
						
						[_x,"DSR_Zombz_Idle" + str(_sNumber)] remoteExec ["say3D",_nearPlayers];
						_x setVariable ["MoanDelay",diag_tickTime + (5 + random(5))];
					};
				};
				
			};
		};
	} forEach DSZ_var_spawnedZeds;
	uiSleep 0.5;
	
	{
		_player = _x;	
		if(alive _player) then {
			_nearAI = _player nearObjects ["DSR_Object_Blank_Cube",250];
			{
				_zedHolder = _x;
				if !(_zedHolder getVariable["isSpawned",false]) then {
					[_zedHolder,_player] call DSZ_fnc_spawnZombie;
				};
			} forEach _nearAI;
		};
	} forEach allPlayers;
	uiSleep 0.5;
};
//},false,1,0] call DS_fnc_registerTickFunc;