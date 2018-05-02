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

params["_unit"];


_unit addEventHandler ["HitPart",{
	(_this select 0) call {
		params["_target","_shooter","_bullet","_position","_velocity","_selections","_ammo","_direction","_radius","_surface","_direct"];
		if(count(_selections) > 0) then {
			[_shooter,_selections select 0] remoteExecCall ["DS_fnc_onHitPartReceived",_target];
		};
	};
}];