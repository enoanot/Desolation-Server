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
params["_unit","_selection","_level"];
private["_dropinterval","_bleedsourcedata","_sources","_i","_GLOBAL_BLEEDDATA","_Gselect","_Glevel","_Goffset","_data","_bleedsourceinfo"];

_bleedsourcedata = _unit getVariable ["DS_var_BleedSourceData",[]];
_bleedsourceinfo = _unit getVariable ["DS_var_BleedSourcesInfo",[]];;
_sources = _unit getVariable ["DS_var_BleedSources",[]];

_i = _sources find _selection;
if(_i != -1) then {
	_source = (_bleedSourceData select _i) select 1;
	_dropinterval = 1 / (_level / 0.1);
	_source setDropInterval _dropinterval;
	
	_data = _bleedsourceinfo select _i;
	_data set[0,_level];
	_bleedsourceinfo set[_i,_data];
	_unit setVariable ["DS_var_BleedSourcesInfo",_bleedsourceinfo];
	
	
	if(_unit == player) then {
		//--- update my global bleed data (for new connected clients to use on JIP)
		_GLOBAL_BLEEDDATA = player getVariable ["BLEED_SOURCES",[]];
		{
			_Gselect = _x select 0;
			_Glevel = _x select 1;
			_Goffset = _x select 2;
			if(_Gselect == _selection) exitWith {
				_GLOBAL_BLEEDDATA set[_forEachIndex,[_Gselect,_level,_Goffset]];
				player setVariable ["BLEED_SOURCES",_GLOBAL_BLEEDDATA,true];
			};
		} foreach _GLOBAL_BLEEDDATA;
	};
} else {
	[_unit,_level,_selection,[0,0,0]] call DS_fnc_createBleedSource; //--- source doesnt exist but we are supposed to update it? create the source
};