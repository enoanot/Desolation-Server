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

if(isServer) exitWith {diag_log "FATAL ERROR: CLIENT CODE STARTING ON SERVER";};
 
_enabled = call compile (["Enabled","DS"] call BASE_fnc_getCfgValue);
if(!_enabled) exitWith {diag_log "DESOLATION IS NOT ENABLED, THE PLUGIN WILL NOT RUN";};

0 cutRsc ["background","PLAIN",0];
0 fadeSound 0;
0 fadeMusic 0;

if(worldName == "Chernarus") then {
	"ColorCorrections" ppEffectEnable true; 
	"ColorCorrections" ppEffectAdjust [0.95, 0.8, -0.001, [-0.5, -0.5, -0.5, 0], [0.15, 0.15, 0.15, 0.89], [-0.4, 0.1, 0.5, -0.5]]; 
	"ColorCorrections" ppEffectCommit 0;
};

//antiGammaCheat
DS_AntiGammaFilter = ppEffectCreate ["FilmGrain",2000];
DS_AntiGammaFilter ppEffectEnable false;
DS_AntiGammaFilter ppEffectAdjust [0.02,0.75,2.95,1.66,2,true];
DS_AntiGammaFilter ppEffectCommit 0;


//	Disable automatic refueling from gas pumps
_mapCenter = [worldSize / 2, worldsize / 2, 0];
{_x setFuelCargo 0;} forEach (nearestTerrainObjects [_mapCenter, ["FUELSTATION"], worldSize]);

{
	_x call BASE_fnc_createLocation;
} forEach BASE_var_Locations;


call ds_fnc_initHud;
call ds_fnc_initInvHandler;
call ds_fnc_initHoldables;
[] spawn DS_fnc_initBuilding;
[] spawn DS_fnc_initNVGs;

enableEnvironment [false, true]; // Disables client sided animals

// request spawn
[player] remoteExec ["DS_fnc_requestSpawn", 2];
