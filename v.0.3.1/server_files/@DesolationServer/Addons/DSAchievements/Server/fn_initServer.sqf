

_cfg = configFile >> "CfgDSRAchievements";
ACH_DATA = [];
for "_i" from 0 to count(_cfg)-1 do {
	_entry = _cfg select _i;
	if(isClass _entry) then {
		_name = configName _entry;
		_title = getText(_entry >> "title");
		_description = getText(_entry >> "description");
		_points = getNumber(_entry >> "points");
		_tasks = [];
		
		
		_cfg2 = _entry >> "Tasks";
		for "_j" from 0 to count(_cfg2)-1 do {
			_task = configname (_cfg2 select _j);
			_data = getNumber(_cfg2 select _j);
			_tasks pushback [_task,_data];
		
		};
		
		ACH_DATA pushBack [_name,_title,_description,_points,_tasks];
	};
};

publicVariable "ACH_DATA";