

_data = BASE_var_playerEvents select 1;

{
	player addEventHandler [(_x select 0),missionNamespace getVariable [(_x select 1),{}]];
} forEach _data;