
{
	_name = _x select 0;
	_title = _x select 1;
	_description = _x select 2;
	_points = _x select 3;
	_tasks = _x select 4;
	
	_isCompleted = player getVariable ["PVAR_DSA_Ach_" + _name,false];
	if(!_isCompleted) then {
		_hasCompleted = true;
		{
			_task = _x select 0;
			_minPts = _x select 1;
			
			_taskPts = player getVariable ["PVAR_DSA_Task_" + _task,0];
			if(_taskPts < _minPts) exitWith {
				_hasCompleted = false;
			};
		} forEach _tasks;
		
		if(_hasCompleted) then {
			[_x] call DSA_fnc_onAchievementCompleted;
		};
	};
} forEach ACH_DATA;