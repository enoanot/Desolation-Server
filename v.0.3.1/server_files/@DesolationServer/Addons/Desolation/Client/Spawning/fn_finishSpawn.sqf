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

params["_unit","_goggles"];

selectPlayer _unit;

if !((_goggles isEqualTo []) || (_goggles isEqualTo "")) then {
	_goggles spawn {
		uiSleep 2;
		removeGoggles player;
		player addGoggles _this;
	};
};

[player] remoteExec ["DS_fnc_requestOwned",2];

player addRating 9999999;

[] spawn {
	if !(isTouchingGround player) then {
		waitUntil {isTouchingGround player};

		uiSleep 3;
		player playAction "PlayerStand";
		uiSleep 2;
	};

	[player, false] remoteExec ["hideObjectGlobal", 2];
	[player, true] remoteExec ["allowDamage", -2];

	//--- fade into the game
	1 fadeSound 2;
	1 fadeMusic 2;
	0 cutText ["","BLACK IN",3];
	//--- show region
	[] spawn DS_fnc_showRegionNotification;

	player setVariable ["DS_var_isPlaying", true, true];
};

//--- setup melee weapons
call DS_fnc_swingEvent;

// starting health systems
call ds_fnc_initHealthSys;
[] spawn DS_fnc_initStatusSys;
call DS_fnc_initBleedingSystem;


call DS_fnc_registerPlayer;

//--- init removable plugins
if(!isNil "RSM_fnc_initRealism") then {
	[player] call RSM_fnc_initRealism;
};

//--- init plugin events
call BASE_fnc_initPlayerEvents;
call BASE_fnc_initMissionEventsClient;