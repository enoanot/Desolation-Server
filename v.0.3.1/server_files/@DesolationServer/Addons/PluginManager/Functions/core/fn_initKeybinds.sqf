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

KEYBIND_DATA = [];
 
_config = configFile >> "CfgPluginKeybinds";
for "_i" from 0 to count(_config)-1 do {
	_entry = _config select _i;
	
	if(isClass _entry) then {
		_arrayData = getArray(_entry >> "defaultKeys");
		
		{
			_number = _x select 0;
			if(_number isEqualType "") then {
				_number = call compile _number;
			};
			_x set[0,_number];
			_arrayData set[_forEachIndex,_x];
		} forEach _arrayData;
		
		KEYBIND_DATA pushback [
			getText(_entry >> "displayName"),
			getText(_entry >> "tag"),
			getText(_entry >> "variable"),
			_arrayData,
			getText(_entry >> "tooltip"),
			getText(_entry >> "code")
			
		];
	};
};

publicvariable "KEYBIND_DATA";