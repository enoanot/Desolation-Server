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
 
 /// used in Desolation spawnPlayer request
 
#include "\DesoDB\constants.hpp" 

_request = [PROTOCOL_DBCALL_FUNCTION_DUMP_OBJECTS,[]];
_dbSpawnData = [_request] call DB_fnc_sendRequest;
_returnData = [];

if !(_dbSpawnData isEqualType []) then {diag_log str(_dbSpawnData); _dbSpawnData = [];};

diag_log "Spawning DB objects";
{
	_classname = _x select 0;
	_priority = _x select 1;
	_objectType = _x select 2;
	_accesscode = _x select 3;
	_locked = _x select 4;
	_player_uuid = _x select 5;
	_hitpoints = _x select 6;
	_damage = _x select 7;
	_fuel = _x select 8;
	_fuelcargo = _x select 9;
	_repaircargo = _x select 10;
	_items = _x select 11;
	_magazinesturret = _x select 12;
	_variables = _x select 13;
	_animation_sources = _x select 14;
	_textures = _x select 15;
	_direction = _x select 16;
	_positiontype = _x select 17;
	_positionx = _x select 18;
	_positiony = _x select 19;
	_positionz = _x select 20;
	_positionadvanced = _x select 21;
	_reservedone = _x select 22;
	_reservedtwo = _x select 23;
	_object_uuid = _x select 24;
	_parent = _x select 25;
	_clan_uuid = _x select 26;

	
	/* _objectType:
	 * 0 -> Hidden Object
	 * 1 -> Simple Object
	 * 2 -> Building
	 * 3 -> Vehicle
	 * 4 -> Ai (not supported)
	 */
	
	/* TODO: 
	 * if (_parent != "") {
	 *    Search Parent
	 * }
	 */
	
	/* TODO: 
	 * if(_objectType == 0) then {
	 * take Parent and add Objectdata to an Variable of this Object to Spawn it later
	 * }
	 */
	
	/* TODO: 
	 * if(_objectType == 1) then {
	 * spawn SimpleObject
	 * }
	 */
	
	if(_classname != "") then {
		 _object = objNull;
		 
		if (_objectType > 1) then { // its an building, vehicle or ai - all use createVehicle
			_position = [_positionx,_positiony,_positionz];
			_object = _classname createVehicle _position;
			
			clearItemCargoGlobal _object;
			clearMagazineCargoGlobal _object;
			clearWeaponCargoGlobal _object;
			clearBackpackCargoGlobal _object;
			
			_object lock _locked;
			_object allowDamage false;
			_object setVariable ["oUUID",_object_uuid];
			
			_object setVariable ["DSR_objectType", _objectType];
			if(_priority > 0) then {
				_object setVariable ["DSR_priority", _priority];
			};
			
			{
				//  todo
			} forEach _animation_sources;
			
			
			{
				_object setObjectTextureGlobal [_forEachIndex,_x];
			} forEach _textures;
			
			if(_player_uuid != "") then {
				_object setVariable ["oOWNER",_player_uuid,true];
				_object setVariable ["clanUUID",_clan_uuid];
			};
			if!(_accesscode isEqualTo []) then {
				_object setVariable ["APMS_UnlockCode",_accesscode,true];
			};
			
			[_object,_items] call BASE_fnc_setAllCargo;
			
			{
				_object setVariable [_x select 0,_x select 1,true];
			} foreach _variables;
			
			
			_object setDir _direction;
			if(_positiontype == 1) then {
				_object setPosATL _position;
			} else {
				_object setPosASL _position;
			};

			_amountOfPositionInformation = count _positionadvanced;
			if (_amountOfPositionInformation > 0) then {
				_hpVectorUp = call compile ((_positionadvanced select 0) select 1);
				
				if (_amountOfPositionInformation > 2) then {
					_hpVectorDir = call compile ((_positionadvanced select 1) select 1);
					_hpPosition = call compile ((_positionadvanced select 2) select 1);
		
					_object setVectorDirAndUp [_hpVectorDir,_hpVectorUp];
		
					if(_positiontype == 1) then {
						_object setPosATL _hpPosition;
					} else {
						_object setPosASL _hpPosition;
					};
		
					_object setVariable ["DSR_positionAdvanced",_positionadvanced];
				} else {
					_object setVectorUp (_hpVectorUp);
				};
			};
		
			_object allowDamage true;

			if(_objectType == 2) then {  // if building	

				if(_locked != 0 && !(_accesscode isEqualTo [])) then {
					for "_i" from 1 to 5 do {
						_object setVariable ["bis_disabled_Door_" + str(_i),1,true];
					};
				};
			};
		
			if(_objectType == 3) then { // vehicle
				_object setFuel _fuel;
				
				if(_fuelcargo isEqualType 1.0) then {
					_object setFuelCargo _fuelcargo;
				};
				
				if(_repaircargo isEqualType 1.0) then {
					_object setRepairCargo _repaircargo;
				};
				

				_object setVariable ["isCar",true];
				
				{
					_object setHitPointDamage _x;
				} forEach _hitpoints;
			};
			
			if(_objectType == 4) then { // ai
				diag_log("sorry ai is not supported");
			};
		
			DB_var_Objects pushback _object;
			DB_var_ObjectUUIDS pushback _object_uuid;
			_returnData pushback [_object,_objectType,_object_uuid];
		};
	};
} forEach _dbSpawnData;

diag_log "DONE";

[] spawn DB_fnc_objectMonitor;

_returnData;
