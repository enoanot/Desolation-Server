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

// _iconPos = icon world position

params["_iconPos"];
private["_camDir", "_diff", "_camPos", "_dirToIcon"];


_camDir = [0,0,0];
_camPos = [0,0,0];
_dirToIcon = [0,0,0]; 


_camDir = getCameraViewDirection player;
_camPos = positionCameraToWorld [0,0,0];

_dirToIcon = _camPos vectorFromTo _iconPos;


_diff = _camDir vectorDistance _dirToIcon;

//if within range, mark it as selected
if (_diff < 0.05) then
{
	_diff = 0;
};

_diff;