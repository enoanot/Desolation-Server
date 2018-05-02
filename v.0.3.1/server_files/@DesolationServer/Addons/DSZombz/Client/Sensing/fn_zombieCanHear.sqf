params["_zed"];
private["_maxSoundDistance","_animState","_stance","_move","_mode","_return"];

_maxSoundDistance = 20;
_weaponSoundDistance = 80;

_chance = abs(speed player) / 23;

_friction = getNumber(configFile >> "CfgSurfaces" >> ((surfaceType (position player)) select [1]) >> "surfaceFriction");
if(_friction == 0) then {
	_friction = 2;
};
_multiplier = _friction - 1;
_maxSoundDistance = _maxSoundDistance * _multiplier;

_houses = lineIntersectsSurfaces [getPosWorld player,getPosWorld player vectorAdd [0, 0, 50],player, objNull, true, 1, "GEOM", "NONE"];
if(count(_houses) > 0) then {
	_house = (_houses select 0) select 3;
	if (_house isKindOf "House") then {
		_maxSoundDistance = _maxSoundDistance / 3; // inside house, make it quieter
	};
};


_return = false;
_soundDist = _maxSoundDistance * _chance;
if((player distance _zed) <= _soundDist) then {
	_return = true;
};

if (!_return) then {
	_lastSound = player getVariable ["DSZ_var_lastSound",diag_tickTime - 3];
	if((_lastSound + 1) >= diag_tickTime) then {
		//check weapon suppression
		if(currentWeapon player == handgunWeapon player) then {
			_suppressed = (handgunItems player) select 0;
			if(_suppressed != "") then {
				_weaponSoundDistance = 10;
			};
		};
		if(currentWeapon player == primaryWeapon player) then {
			_suppressed = (primaryWeaponItems player) select 0;
			if(_suppressed != "") then {
				_weaponSoundDistance = 10;
			};
		};
		
		//check if zombie heard
		if((player distance _zed) <= _weaponSoundDistance) then {
			_return = true;
		};
	};
};


_return;