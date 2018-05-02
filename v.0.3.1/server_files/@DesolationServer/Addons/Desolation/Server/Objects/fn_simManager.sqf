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
private["_ignore","_toLock","_toLockNIDS","_toUnlock","_toUnlockNIDS","_inLockRange","_inUnlockRange","_nid","_i","_redamage"];

_ignore = ["DSR_C130J_F","O_PARACHUTE_02_F","DSR_CRATE_AIRDROP_F"];
while{true} do {
	_toLock = [];
	_toLockNIDS = [];
	_toUnlock = [];
	_toUnlockNIDS = [];
	
	{
		_inLockRange = nearestObjects  [_x, ["LandVehicle","Ship","Air"], 300];
		_inUnlockRange = nearestObjects  [_x, ["LandVehicle","Ship","Air"], 100];
		
		//--- remove vehicles to unlock from lock list
		_inLockRange = _inLockRange - _inUnlockRange;
		
		{
			if !(toUpper(typeof _x) in _ignore) then {  
				_nid = netid _x;
				_i = _toLockNIDS find _nid;
				if(_i != -1) then {
					_toLock deleteAt _i;
					_toLockNIDS deleteAt _i;
				};
				if !(_nid in _toUnlockNIDS) then {
					_toUnlockNIDS pushBack _nid;
					_toUnlock pushBack _x;
				};
			};
		} forEach _inUnlockRange;
		{
			if !(toUpper(typeof _x) in _ignore) then {  
				if !(_x getVariable ["sim_manager_ignore",false]) then {
					_nid = netid _x;
					if !(_nid in _toUnlockNIDS) then {
						if(isTouchingGround _x || ((speed _x) < 0.01)) then {
							_toLock pushBack _x;
							_toLockNIDS pushBack _nid;
						};
					};
				};
			};
		} forEach _inLockRange;
	} forEach allPlayers;
	
	{
		if (simulationEnabled _x) then {
			_x enableSimulationGlobal false;
			
		};
	} forEach _tolock;
	_redamage = [];
	{
		if !(simulationEnabled _x) then {
			_x allowDamage false; //--- exploding vehicle fix
			_x enableSimulationGlobal true;
			_redamage pushBack _x;
		};
	} forEach _tounlock;
	uiSleep 1;
	{
		_x allowDamage true;
	} forEach _redamage;
};