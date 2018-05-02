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
CFG_BUILDABLE_GROUPS = [];
CFG_BUILDABLE_DATA = [];


_config = configFile >> "CfgBuildables";
for "_i" from 0 to count(_config)-1 do {
	_groupEntry = _config select _i;
	if(isClass _groupEntry) then {
		_className = configName _groupEntry;
		_condition = getText(_groupEntry >> "condition");
		_name = getText(_groupEntry >> "name");
		_preview = getText(_groupEntry >> "preview");
		CFG_BUILDABLE_GROUPS pushBack [
			_className,
			_name,
			_condition,
			_preview
		];
		_bDataGroup = [];
		_buildableData = _groupEntry >> "Buildables";
		for "_j" from 0 to count(_buildableData)-1 do {
			
			_buildable = _buildableData select _j;
			if(isClass _buildable) then {
				
				_bParts = getArray(_buildable >> "parts");
				_bName = getText(_buildable >> "name");
				_bModel = getText(_buildable >> "model");
				_bDesc = getText(_buildable >> "description");
				_bPreview = getText(_buildable >> "preview");
				_bCondition = getText(_buildable >> "condition");
				_bCrateModel = getText(_buildable >> "crateObject");
				
				_bDataGroup pushBack [
					_bParts,
					_bName,
					_bModel,
					_bDesc,
					_bPreview,
					_bCondition,
					_bCrateModel
				];
			};
		};
		CFG_BUILDABLE_DATA pushBack _bDataGroup;
	};
};

publicVariable "CFG_BUILDABLE_GROUPS";
publicVariable "CFG_BUILDABLE_DATA";
