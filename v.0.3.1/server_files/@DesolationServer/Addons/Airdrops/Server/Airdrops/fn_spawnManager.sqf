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

_numberOfDrops = getNumber (configFile >> "CfgAirdropSpawns" >> "Settings" >> "NumberOfDropsToSpawn");
_maxTime = getNumber (configFile >> "CfgAirdropSpawns" >> "Settings" >> "MaxTimeBetweenDrops");
_minTime = getNumber (configFile >> "CfgAirdropSpawns" >> "Settings" >> "MinTimeBetweenDrops");

for "_i" from 0 to ((_numberOfDrops) - 1) do {

	// Generate location
	_location = [0,0];
	while {true} do {
		_x = random(worldSize);
		_y = random(worldSize);
		_location = [_x,_y];
		_height = getTerrainHeightASL _location;
		if(_height > 10) exitWith {};
	};

	// Spawn Airdrop
	[_location] call AIRD_fnc_spawnAirdrop;

	// if(no crashes more to spawn) exitWith {};
	_waitTime = random _maxTime;
	if(_waitTime < _minTime) then {_waitTime = _minTime + (random (_maxTime - _minTime));};
	_waitTime = (ceil(_waitTime) * 60);
	uiSleep _waitTime; 
};

true;