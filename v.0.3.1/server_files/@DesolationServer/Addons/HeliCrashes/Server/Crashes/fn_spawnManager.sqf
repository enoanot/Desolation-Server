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

_numberOfCrashes = getNumber (configFile >> "CfgHeliCrashes" >> "Settings" >> "NumberOfCrashesToSpawn");
_maxTime = getNumber (configFile >> "CfgHeliCrashes" >> "Settings" >> "MaxTimeBetweenCrashes");
_minTime = getNumber (configFile >> "CfgHeliCrashes" >> "Settings" >> "MinTimeBetweenCrashes");

for "_i" from 0 to ((_numberOfCrashes) - 1) do {

	[] call HLCR_fnc_spawnHeliCrash;

	_waitTime = random _maxTime;
	if(_waitTime < _minTime) then {_waitTime = _minTime + (random (_maxTime - _minTime));};
	_waitTime = (ceil(_waitTime) * 60);
	uiSleep _waitTime; 
};

true