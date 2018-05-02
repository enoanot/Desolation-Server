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
params["_data","_client"];
private["_charuuid","_charshareuuid","_persuuid","_objectuuid","_playerObj","_anim","_dir","_positiontype","_positionx","_positiony","_positionz","_classname","_hitpoints","_nonpersvars","_persvars","_textures","_goggles","_currentWeapon","_loadout","_name","_damage"];

_uid = getPlayerUID _client;


_anim = _data deleteAt 0;
_dir = _data deleteAt 0;
_positiontype = _data deleteAt 0;
_positionx = _data deleteAt 0;
_positiony = _data deleteAt 0;
_positionz = _data deleteAt 0;
_charuuid = _data deleteAt 0;

_classname = _data deleteAt 0;
_hitpoints = _data deleteAt 0;
_nonpersvars = _data deleteAt 0;
_textures = _data deleteAt 0;
_loadout = _data deleteAt 0;
_goggles = _loadout select 7;
_currentWeapon = _data deleteAt 0;
_charshareuuid = _data deleteAt 0;

_persvars = _data deleteAt 0;
_persuuid = _data deleteAt 0;

_objectuuid = _data deleteAt 0;

_playerObj = (createGroup CIVILIAN) createUnit [_classname, [_positionx,_positiony,_positionz], [],0, "NONE"];
_playerObj hideObjectGlobal true;
[_playerObj, false] remoteExec ["allowDamage", -2]; // _playerObj allowDamage false doesent work!

{
	_playerObj setVariable [_x select 0,_x select 1,true];
} forEach _nonpersvars;
{
	_playerObj setVariable [_x select 0,_x select 1,true];
} forEach _persvars;


_playerObj setVariable ["pUUID",_client getVariable "pUUID",true];
_playerObj setVariable ["cUUID",_charuuid];

_playerObj setDir _dir;
_playerObj setPosATL [_positionx,_positiony,_positionz]; 

[_playerObj,_anim] remoteExecCall ["switchMove",0];

{
	_name = _x;
	_damage = (_hitpoints select 2) select _forEachIndex;
	_playerObj setHitPointDamage [_name,_damage];
} forEach (_hitpoints select 0);

_playerObj addMPEventHandler ["MPKilled", DS_fnc_onPlayerKilled];
[_playerObj,_loadout] call DS_fnc_setupLoadout;

{
	_playerObj setObjectTextureGlobal [_forEachIndex,_x];
} forEach _textures;

// Temp workaround for shotguns until config is fixed
_playerObj addEventHandler ["Fired",{
    params["_playerObj","_weapon","_muzzle","_mod","_ammo","_magazine","_projectile"];
    if(!isNull _projectile) then {
        if(_ammo == "12Guage_Buck" && _weapon == "dsr_sgun_m500") then {
            _velocity = velocity _projectile;
            
            _magnatude = vectorMagnitude _velocity;
            _velocityNormal = vectorNormalized  _velocity;
            
            _dir = acos(_velocityNormal select 1);
            
            
            for "_i" from 1 to 9 do {
            
                _dX = (_velocityNormal select 0) + (random(0.0335213*2)-0.0335213); 
                _dY = (_velocityNormal select 1) + (random(0.0335213*2)-0.0335213); 
                _dZ = (_velocityNormal select 2) + (random(0.0335213*2)-0.0335213);
                
                
                _bVel = (vectorNormalized [_dX,_dY,_dZ]) vectorMultiply _magnatude;
                
                _bullet = "12Guage_Slug" createVehicle [0,0,1000];
                _bullet setShotParents [vehicle _playerObj,_playerObj];
                _bullet setVelocity _bVel;
                _bullet setposatl getposatl _projectile;
                
            };     
        };
    };
}];

[_playerObj,_goggles] remoteExecCall ["DS_fnc_finishSpawn", _client];

waitUntil{getPlayerUID _playerObj == _uid};
deleteVehicle _client;