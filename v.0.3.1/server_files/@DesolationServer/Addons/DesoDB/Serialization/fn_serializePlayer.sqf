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
_posATL = getPosATL _playerObj;
_loadout = getUnitLoadout _playerObj;
_vars = allVariables _playerObj;
_textures = getObjectTextures _playerObj;
_nonpersvars = [];
_persvars = [];
{
	if(toLower(_x) find "svar_" == 0) then {
		_nonpersvars pushback [_x,_playerObj getVariable [_x,""]];
	};
	if(tolower(_x) find "pvar_" == 0) then {
		_persvars pushback [_x,_playerObj getVariable [_x,""]];
	};
} forEach _vars;


_anim = animationState _playerObj;
if(vehicle _playerObj != _playerObj) then {
	_anim = "";
};


[
	PROTOCOL_DBCALL_ARGUMENT_PLAYER_UUID,_playeruuid,
	PROTOCOL_DBCALL_ARGUMENT_CHARUUID,_charuuid,
	PROTOCOL_DBCALL_ARGUMENT_ANIMATIONSTATE,_anim,
	PROTOCOL_DBCALL_ARGUMENT_DIRECTION, getdir _playerObj,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONTYPE, 1,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONX,_posATL select 0,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONY,_posATL select 1,
	PROTOCOL_DBCALL_ARGUMENT_POSITIONZ,_posATL select 2,
	PROTOCOL_DBCALL_ARGUMENT_CLASSNAME,typeof _playerObj,
	PROTOCOL_DBCALL_ARGUMENT_HITPOINTS,getAllHitPointsDamage _playerObj,
	PROTOCOL_DBCALL_ARGUMENT_VARIABLES,_nonpersvars,
	PROTOCOL_DBCALL_ARGUMENT_PERSISTENTVARIABLES,_persvars,
	PROTOCOL_DBCALL_ARGUMENT_TEXTURES,_textures,
  	PROTOCOL_DBCALL_ARGUMENT_GEAR, _loadout,
	PROTOCOL_DBCALL_ARGUMENT_CURRENTWEAPON, currentWeapon _playerObj
];
