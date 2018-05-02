/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */

// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)
 
params["_object","_player"];

_running = !(isNil {_object getVariable "DS_var_isRunning"});

if !(_running) then {
	[("Generator is now running")] remoteExec ["systemChat",_player];
	{_x setDamage 0} forEach (_object nearObjects ["Lamps_base_F", 16]);

	_sound = createSoundSource ["DSR_Sound_Generator", getposATL _object, [], 0];
	_object setVariable ["Sound", _sound];
	_object setVariable ["DS_var_isRunning", true, true];

} else {
	
	[("Generator is no longer running")] remoteExec ["systemChat",_player];
	{_x setDamage 0.95} forEach (_object nearObjects ["Lamps_base_F", 16]);

	_sound = _object getVariable ["Sound", objNull];
	deleteVehicle _sound;
	
	_object setVariable ["Sound", nil];
	_object setVariable ["DS_var_isRunning", nil, true];
};

true