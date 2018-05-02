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
params["_client","_location"];
private["_uid","_playerObj"];

_uid = getplayeruid _client;

_playerObj = (createGroup CIVILIAN) createUnit [typeof _client, _location, [],0, "NONE"];
_playerObj hideObjectGlobal true;
[_playerObj, false] remoteExec ["allowDamage", -2]; // _playerObj allowDamage false doesent work!

_playerObj setVariable ["pUUID",_client getVariable "pUUID",true];

_playerObj addMPEventHandler ["MPKilled", DS_fnc_onPlayerKilled];
[_playerObj] call DS_fnc_setupLoadout;

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

_goggles = (["Goggles","DS"] call BASE_fnc_getCfgValue) splitString ",";
if !(_goggles isEqualTo []) then {
    _goggles = selectRandom _goggles;
};

[_playerObj,_goggles] remoteExecCall ["DS_fnc_finishSpawn", _client];

waitUntil{getPlayerUID _playerObj == _uid};
deleteVehicle _client;
//--- add default values to non-presistant vars here

[_playerObj] call DB_fnc_createPlayer; //--- create fresh player in DB
