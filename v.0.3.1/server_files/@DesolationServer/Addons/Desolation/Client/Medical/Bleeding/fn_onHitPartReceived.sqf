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
params["_shooter","_selection"];
if(_shooter in DS_var_damagedBy) then {

	//--- selection replacements
	_master = [
		["spine3",[
			"spine",
			"spine1",
			"spine2"
		]],
		["leftforearm",[
			"leftarm",
			"leftarmroll"
		]],	
		["rightforearm",[
			"rightarm",
			"rightarmroll"
		]],
		["lefthand",[
			"lefthandindex1",
			"lefthandindex2",
			"lefthandindex3",
			"lefthandmiddle2",
			"lefthandmiddle3",
			"lefthandring",
			"lefthandpinky1",
			"lefthandpinky2",
			"lefthandpinky3",
			"lefthandring1",
			"lefthandring2",
			"lefthandring3",
			"lefthandthumb1",
			"lefthandthumb2",
			"lefthandthumb3"
		]],
		["righthand",[
			"injury_hands",
			"righthandindex1",
			"righthandindex2",
			"righthandindex3",
			"righthandmiddle2",
			"righthandmiddle3",
			"righthandring",
			"righthandpinky1",
			"righthandpinky2",
			"righthandpinky3",
			"righthandring1",
			"righthandring2",
			"righthandring3",
			"righthandthumb1",
			"righthandthumb2",
			"righthandthumb3"
		]],
		["leftupleg",[
			"leftuplegroll"
		]],
		["rightupleg",[
			"rightuplegroll"
		]],
		["leftleg",[
			"injury_legs",
			"leftlegroll"
		]],	
		["rightleg",[
			"rightlegroll"
		]],	
		["leftfoot",[
			"lefttoebase"
		]],
		["rightfoot",[
			"righttoebase"
		]],
		["head",[
			"nvg",
			"head_proxy"
		]],
		["pelvis",[
			"body_proxy",
			"injury_body"
		]]
	];
	
	{
		_replace = _x select 0;
		_badlist = _x select 1;
		if(_selection in _badlist) exitWith {
			_selection = _replace;
		};
	} forEach _master;


	_sources = player getVariable ["DS_var_BleedSources",[]];
	
	_i = _sources find _selection;
	if(_i != -1) then {
		//--- increase bleed level & broadcast
		if(random(100) < 50) then {
			_sourcesinfo = player getVariable ["DS_var_BleedSourcesInfo",[]];
			
			_bleeddata = _sourcesinfo select _i;
			
			_lvl = _bleeddata select 0;
			
			_newlvl = (_lvl + 1) min 10;
			
			
			[player,_selection,_newlvl] remoteExec ["DS_fnc_updateBleedSource",-2];
		};
	} else {
		//--- create the bleed source
		[player,1,_selection,[0,0,0]] remoteExec ["DS_fnc_createBleedSource",-2];
	};
	DS_var_damagedBy = DS_var_damagedBy - [_shooter];
};