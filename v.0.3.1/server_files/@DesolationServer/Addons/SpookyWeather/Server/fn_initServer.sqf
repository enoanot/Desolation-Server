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

/*
	Weather Init
*/

/// start of server values
_startingFogHeight = random(80);
_startingFog = (random 0.1) max 0.005;
_startingFogDensity = (random 0.01) max 0.005;  

_startingOverCast = random(1) max 0.1;
_startingRain = random(1) max 0.1;
_startingWindStrength = random(1);
_startingWindForce = random(1);
_startingWindDir = random(360);
_startingWindGusts = random(1);


0 setFog [_startingFog,_startingFogDensity,_startingFogHeight];
0 setOvercast _startingOverCast;
0 setRain _startingRain;
setWind [random(15),random(15)];
0 setWindStr _startingWindStrength;
0 setWindDir _startingWindDir;
0 setWindForce _startingWindForce;	
0 setGusts _startingWindGusts;

forceWeatherChange;
/// end of server values

_endingFogHeight = random(200);
_endingFog = (random 0.1) max 0.005;
_endingFogDensity = (random 0.01) max 0.005;  


_endingOverCast = random(1) max 0.1;
_endingRain = random(1) max 0.1;
_endingWindStrength = random(1);
_endingWindForce = random(1);
_endingWindDir = random(360);
_endingWindGusts = random(1);

14400 setOvercast _endingOverCast;
14400 setRain _endingRain;
14400 setWindStr _endingWindStrength;
14400 setWindDir _endingWindDir;
14400 setWindForce _endingWindForce;	
14400 setGusts _endingWindGusts;
14400 setFog [_endingFog,_endingFogDensity,_endingFogHeight];

