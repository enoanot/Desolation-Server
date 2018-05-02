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
 
 
CFG_CRAFTABLE_GROUPS = [];
CFG_CRAFTABLE_DATA = [];

_config = configFile >> "CfgCraftables";
for "_i" from 0 to count(_config)-1 do {
	_groupEntry = _config select _i;
	if(isClass _groupEntry) then {
		_className = configName _groupEntry;
		_condition = getText(_groupEntry >> "condition");
		_name = getText(_groupEntry >> "name");
		_preview = getText(_groupEntry >> "preview");
		CFG_CRAFTABLE_GROUPS pushBack [
			_className,
			_name,
			_condition,
			_preview
		];
		_cDataGroup = [];
		_craftableData = _groupEntry >> "Craftables";
		for "_j" from 0 to count(_craftableData)-1 do {
			
			_craftable = _craftableData select _j;
			if(isClass _craftable) then {
				
				_cInput = getArray(_craftable >> "input");
				_cOutput = getArray(_craftable >> "output");
				_cRequiredBuildings = getArray(_craftable >> "requiredBuildings");
				_cName = getText(_craftable >> "name");
				_cDesc = getText(_craftable >> "description");
				_cPreview = getText(_craftable >> "preview");
				_cCondition = getText(_craftable >> "condition");
				
				_cDataGroup pushBack [
					_cInput,
					_cOutput,
					_cRequiredBuildings,
					_cName,
					_cDesc,
					_cPreview,
					_cCondition
				];
			};
		};
		CFG_CRAFTABLE_DATA pushBack _cDataGroup;
	};
};

publicVariable "CFG_CRAFTABLE_GROUPS";
publicVariable "CFG_CRAFTABLE_DATA";