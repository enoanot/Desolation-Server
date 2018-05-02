

BASE_var_playerEvents = []; // format: [true/false (is this overriden and manually executed), [array_of_events]]
BASE_var_missionEventsClient = [];
BASE_var_missionEventsServer = [];

_cfg = configFile >> "CfgPluginEvents";

_plrEvents = _cfg >> "PlayerEvents";
_cmEvents = _cfg >> "MissionEventsClient";
_smEvents = _cfg >> "MissionEventsServer";

BASE_var_playerEvents pushBack (getNumber(_plrEvents >> "overrides") == 1);
BASE_var_missionEventsClient pushBack (getNumber(_cmEvents >> "overrides") == 1);
BASE_var_missionEventsServer pushBack (getNumber(_smEvents >> "overrides") == 1);


_config = _plrEvents >> "Events";
_data = [];
for "_i" from 0 to count(_config)-1 do {
	_entry = _config select _i;
	if(isClass _entry) then {
		_data pushback [getText(_entry >> "type"),getText(_entry >> "function")];
	};	
};
BASE_var_playerEvents pushBack _data;


_config = _cmEvents >> "Events";
_data = [];
for "_i" from 0 to count(_config)-1 do {
	_entry = _config select _i;
	if(isClass _entry) then {
		_data pushback [getText(_entry >> "type"),getText(_entry >> "function")];
	};	
};
BASE_var_missionEventsClient pushBack _data;


_config = _smEvents >> "Events";
_data = [];
for "_i" from 0 to count(_config)-1 do {
	_entry = _config select _i;
	if(isClass _entry) then {
		_data pushback [getText(_entry >> "type"),getText(_entry >> "function")];
	};	
};
BASE_var_missionEventsServer pushBack _data;




//broadcast event values to clients
publicVariable "BASE_var_playerEvents";
publicVariable "BASE_var_missionEventsClient";