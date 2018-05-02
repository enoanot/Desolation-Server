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
params["_unit","_level","_selection","_offset"];

private["_dropinterval","_point","_source","_GLOBAL_BLEEDDATA","_sources","_sourcesinfo","_bleedsourcedata"];

if(_level == 0) exitWith {[objNull,objNull]};
_dropinterval = 1 / (_level / 0.1);

//--- TEMP (eventually these will be local and only visible to near entities)
_point = "Logic" createVehicleLocal getPosATL _unit;
_source = "#particlesource" createVehicleLocal getPosATL _unit;
_source setParticleParams
		[["\A3\data_f\ParticleEffects\Universal\Universal", 16, 13, 1],"",	
		"Billboard",
		1,
		0.2,
		[0,0,0],
		[0,0,0.5],
		1,0.4,0.1,0.05,	
		[0.1,0.25],
		[[0.2,0.1,0.1,1],[0.4,0.01,0.01,0]],
		[0.1],
		0,
		0,
		"",
		"",
		_point];
_source setParticleRandom [2, [0.001, 0.001, 0.001], [0.0, 0.0, 0.1], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
_source setDropInterval _dropinterval;
_point attachTo [_unit,_offset,_selection];

if(_unit == player) then {
	_GLOBAL_BLEEDDATA = player getVariable ["BLEED_SOURCES",[]];
	_GLOBAL_BLEEDDATA pushBack [_selection,_level,_offset];
	 player setVariable ["BLEED_SOURCES",_GLOBAL_BLEEDDATA,true];
};
//--- add source to list
_sources = _unit getVariable ["DS_var_BleedSources",[]];
_sources pushBack _selection;
_unit setVariable ["DS_var_BleedSources",_sources];

//--- add source info to list
_sourcesinfo = _unit getVariable ["DS_var_BleedSourcesInfo",[]];
_sourcesinfo pushBack [_level,_offset];
_unit setVariable ["DS_var_BleedSourcesInfo",_sourcesinfo];

//--- add source objects to list
_bleedsourcedata = _unit getVariable ["DS_var_BleedSourceData",[]];
_bleedsourcedata pushBack [_point,_source];
 _unit setVariable ["DS_var_BleedSourceData",_bleedsourcedata];
