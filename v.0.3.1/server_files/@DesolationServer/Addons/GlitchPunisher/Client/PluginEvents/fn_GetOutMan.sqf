

_this spawn {
	params["_unit","_position","_vehicle","_turret"];
	
	waitUntil{vehicle _unit != _vehicle};
	
	_oldPos = getposatl _vehicle;
	_newpos = getposatl _unit;

	[_oldPos,_newpos,{
		params["_oldPos","_params"];
		_position = _params select 0;
		_vehicle = _params select 1;
		
		if(_position == "driver") exitWith {
			player moveInDriver _vehicle;
		};
		if(_position == "gunner") exitWith {
			player moveInGunner _vehicle;
		};
		if(_position == "cargo") exitWith {
			player moveInCargo _vehicle;
		};
		
		player moveInAny _vehicle;
		
	},[_vehicle,player],[_position,_vehicle]] call GLP_fnc_checkGlitch;

};