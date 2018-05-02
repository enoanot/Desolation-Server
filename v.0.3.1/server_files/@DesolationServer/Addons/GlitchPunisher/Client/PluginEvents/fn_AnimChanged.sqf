

params["_unit","_anim"];
if(_anim find "aovr" == 0) then {
	if(cursorTarget getVariable ["oOWNER",""] != "") then {
		if(cursorTarget distance2D player < 5) then {
			_unit switchMove "";
			systemchat "<AntiGlitch> Wall Glitch Detected";
		};
	};
};
if(_anim find "amovppne" == 0) then {
	_pos1 = getposasl player;
	_pos2 = eyepos player;
	[ASLtoATL _pos1,ASLtoATL _pos2, {
		_dir = (vectorDir player) vectorMultiply 0.5;
		_pos = getposatl player;
		_newpos = _pos vectorAdd _dir;
		player setposatl _pos;
		systemchat "<AntiGlitch> Wall Glitch Detected";
	},[player]] call GLP_fnc_checkGlitch;
};