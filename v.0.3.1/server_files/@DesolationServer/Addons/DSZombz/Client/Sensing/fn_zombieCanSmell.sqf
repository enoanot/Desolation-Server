params["_zed"];

_smellDistance = 10;

_rain = rain;
if (_rain > 0) then {
	_rain = _rain * 6;
	_smellDistance = _smellDistance - _rain;
};

_wind = windstr;
if (_wind > 0) then {
	_wind = _wind * 8;
	_smellDistance = _smellDistance - _wind;
};


// Make sure values stay positive
if (_smellDistance < 3) then {
	_smellDistance = 3;
};


_return = false;
if(_zed distance player < _smellDistance) then { 
	_return = true;
};
_return;