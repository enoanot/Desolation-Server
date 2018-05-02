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
params["_location"];

if!(canSuspend) exitWith {
	[] spawn HLCR_fnc_spawnHeliCrash;
};

if(isNil "_location") exitWith {diag_log "<AIRDROPS>: Error no location defined!";};

_airdropType = selectRandom AIRD_Airdrop_CrateTypes; // TODO add ability to select drop type
_planeType = getText(configFile >> "CfgAirdropSpawns" >> "AirdropTypes">> _airdropType >> "PlaneClass");
if (_planeType isEqualTo "") exitWith {diag_log "<AIRDROPS>: Error no PlaneClass defined!"};
_flyingAlt = getNumber(configFile >> "CfgAirdropSpawns" >> "AirdropTypes">> _airdropType >> "FlyingAltitude");
_flyingSpeed = getNumber(configFile >> "CfgAirdropSpawns" >> "AirdropTypes">> _airdropType >> "FlyingSpeed");
_dropName = getText(configFile >> "CfgAirdropSpawns" >> "AirdropTypes">> _airdropType >> "Name");


diag_log "<AIRDROPS>: Spawning airdrop.";

// Create plane flying path
_angle = random(360); 
_xChange = worldSize*sin(_angle);
_yChange = worldSize*cos(_angle);
_spawnPos = [(_location select 0) + _xChange,(_location select 1) + _yChange,500];
_finishPos = [(_location select 0) - _xChange,(_location select 1) - _yChange,500];


// Create Plane
_plane = createVehicle [_planeType,_spawnPos,[],0,"FLY"];
_plane setVariable ["sim_manager_ignore",true,true];
createVehicleCrew _plane;
{_x allowDamage false;} forEach (crew _plane);


// ???
if(getTerrainHeightASL _spawnPos < 0) then {
	_plane setPosASl _spawnPos;
} else {
	_plane setPosATL _spawnPos;
};


// Set Plane Flying Altitude And Speed
_plane setDir (_angle+180);
_plane flyInHeight _flyingAlt;
_plane flyInHeightASL  [_flyingAlt,_flyingAlt,_flyingAlt];
_plane forceSpeed _flyingSpeed;


// Set Plane Lights On
_pilot = driver _plane;
_pilot action ["CollisionLightOn", _plane];
_plane setCollisionLight  true;


// Create Waypoint And Set Behaviour
_location set [2,500];
(group _plane) move _location;
(group _plane) setBehaviour "CARELESS";


// Send Message To All Players About crate
_listeners = [];
{
	if("ItemRadio" in (assignedItems _x)) then {
		_listeners pushBack _x;
	};
} forEach allPlayers;
_gridRef = mapGridPosition getPos _plane;
_callsign = ("UN Flight #" + str(floor(random(9000)+1000)));
_windSpeed = str(parseNumber ((vectorMagnitude wind) toFixed 1));
_windDir = str(round(windDir));
[netID _pilot,_callsign,["A crate is being dropped!","Grid: "+_gridRef,"Type: " + _dropName,"Wind: " + _windDir + ", " + _windSpeed + " m/s"]] remoteExec ["DS_fnc_receiveTransmition",_listeners];


waitUntil{(_plane distance2D _location) < 500};

// ["DropTheLoad","MUSIC"] call DS_fnc_playOverRadio; // wait until new audio effects are done

waitUntil{(_plane distance2D _location) < 200}; //--- sometimes the plane misses this distance ???
_pos = getPosATL _plane;
_pos = _pos vectorAdd [0,0,-10]; // Spawn Crate Below The Plane

[_pos,_airdropType] spawn AIRD_fnc_spawnCrate;

(group _plane) move _finishPos;

// Delete Group When At Finish Position
waitUntil{(_plane distance2D _finishPos) < 500};
{deleteVehicle _x;} forEach (crew _plane);
deleteVehicle _plane;

true;