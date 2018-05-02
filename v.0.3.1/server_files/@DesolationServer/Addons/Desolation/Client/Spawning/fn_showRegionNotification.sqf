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

uiSleep 2; //--- wait for blackscreen to exit
_locationChecks = ["NameVillage","NameCity","NameCityCapital"];
_distance = 9999999;
_location = locationNull;
{
	_loc = nearestLocation [getpos player,_x];
	
	if(!isNull _loc) then {
		_dist = (getpos player) distance _loc;
		if(_dist < _distance) then {
			_location = _loc;
			_distance = _dist;
		};
	};
} forEach _locationChecks;

if(!isNull _location) then {
	_name = text _location;
	[profileName , _name, str(date select 1) + "/" + str(date select 2) + "/" + str(date select 0)] spawn DS_fnc_infoText;
};

