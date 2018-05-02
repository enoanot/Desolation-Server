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
params["_parameter","_type"];
private["_send"];

if(_type == "MUSIC") then {
	_send = [];
	{
		if("ItemRadio" in (assignedItems _x)) then {
			_send pushBack _x;
		};
	} forEach allPlayers;

	if !(_send isEqualTo []) then {
		_parameter remoteExec["playMusic",_send];
	};
};
if(_type == "OGG") then {
	{
		if("ItemRadio" in (assignedItems _x)) then {
			playSound3D [_parameter, _x];
		};
	} forEach allPlayers;	
};
