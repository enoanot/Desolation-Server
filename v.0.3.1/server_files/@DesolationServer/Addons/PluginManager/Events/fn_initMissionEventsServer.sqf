


_data = BASE_var_missionEventsServer select 1;

{
	addMissionEventHandler [(_x select 0),missionNamespace getVariable [(_x select 1),{}]];
} forEach _data;