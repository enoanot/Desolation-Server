params["_zed"];

_maxVisionDistance = 70;
_maxVisibleAngle = 45;

_return = false;

//Check if player is in light. TODO: Optimize
if(sunOrMoon == 0) then {
	_maxVisibleAngle = 15;
	_maxVisionDistance = 30;
	_lamp = (player nearObjects ["Lamps_base_F", 14]);
	if!(count _lamp isEqualTo 0) then {	
		_hitpoints = {(getAllHitPointsDamage _x) select 2} forEach _lamp;
		if!(_hitpoints - [1] isEqualTo []) then {	
			_maxVisibleAngle = 30;
			_maxVisionDistance = 55;
		};
	};
};

_fog = fog;
_fogAltidude = ((fogParams) select 2);
if (_fog > 0 && ((getPosASL player) select 2) < _fogAltidude) then {
	_fog = _fog * 35;
	_maxVisibleAngle = _maxVisibleAngle - _fog;
	_maxVisionDistance = _maxVisionDistance - _fog;
};
_overcast = overcast;
if (_overcast > 0) then  {
	_overcast = _overcast * 8;
	_maxVisibleAngle = _maxVisibleAngle - _overcast;
	_maxVisionDistance = _maxVisionDistance - _overcast;
};


_isWearingGhillie = false;
_isLayingDown = false;
_surfaceIsGrass = false;

// if wearing ghillie and in correct position, reduce vision by 3x (both distance and angle)
if(_isWearingGhillie && _isLayingDown && _surfaceIsGrass) then {
	_maxVisibleAngle = _maxVisibleAngle / 3;
	_maxVisionDistance = _maxVisionDistance / 3;
};



// Make sure values stay positive
if (_maxVisibleAngle < 5) then {
	_maxVisibleAngle = 5;
};
if (_maxVisionDistance < 10) then {
	_maxVisionDistance = 10;
};



if((player distance _zed) <= _maxVisionDistance) then {

	//get vectors
	_zDir = vectorDir _zed;
	_dirTo = (getposAtl _zed) vectorFromTo (getposatl (vehicle player));
	//create 2d vectors (ignore param index 2)
	_zDir set [2,0];
	_dirTo set [2,0];

	_dot = _zDir vectorDotProduct _dirTo; 
	//magnatude of both is 1, ignore divisor
	_angle = acos(_dot);
	if(abs(_angle) <= _maxVisibleAngle) then {
		// player within view matrix
		_visibility = [(vehicle player), "VIEW",_zed] checkVisibility [eyePos _zed, eyePos player];
		if(_visibility >= 0.9) then {
			_return = true;
		};
	};
};

_return;