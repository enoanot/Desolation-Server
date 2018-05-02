/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 - 2018 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */

if !(DS_var_3DActionsEnabled) exitWith { false };
if (isNil "DS_var_valid3DActions") then
{
	DS_var_valid3DActions = [];
};
if (isNil "DS_var_valid3DActionsCode") then
{
	DS_var_valid3DActionsCode = [];
};

if (((count DS_var_valid3DActions) == 0) || (vehicle player != player)) exitWith { false };

_obj = cursorTarget;
if (isNull _obj) then
{
	_obj = cursorObject;
};
if (isNull _obj) exitWith { false };
(boundingBoxReal _obj) params ["_dif0","_dif1"];
_distance = (_dif0 distance _dif1) + 4;
_visPos = ASLToATL(AGLToASL positionCameraToWorld [0,0,5.5]);
_camPos = ASLToATL(AGLToASL positionCameraToWorld [0,0,0]);
_vecFT = _camPos vectorFromTo _visPos;
if ((count DS_var_valid3DActionsCode) < 1) then
{
	_alreadyHasValidAction = false;

	{
		_x params ["_icon","_damage","_pos","_txt","_partName"];

		_valid = false;
		for "_j" from 1 to _distance do 
		{
			_vChange = _vecFT vectorMultiply (((_camPos distance _visPos) / 20)*_j);
			_checkPos = _camPos vectorAdd _vChange;
			if((_checkPos distance _pos) <= 0.1) exitWith 
			{
				_valid = true;
			};
		};

		_size = (7 - (player distance _pos)) / 5;
		if (_valid) then
		{
			if !(_alreadyHasValidAction) then
			{
				_size = (7 - (player distance _pos)) / 3;
				_alreadyHasValidAction = true;
				DS_var_3DActionData = [_partName,_damage,_x];
			};
		};

		drawIcon3D [_icon, [_damage, 1 - _damage, 0, 1], _pos, _size, _size, 0, (_txt + " " + str ((1 - _damage) * 100) + "%"), 2, _size / 20, "PuristaBold"];

		true
	} count DS_var_valid3DActions;

	if !(_alreadyHasValidAction) then
	{
		DS_var_3DPartName = nil;
	};
}
else
{
	{
		_x params ["_icon","_damage","_pos","_txt","_partName"];
		_size = (7 - (player distance _pos)) / 5;
		if (_x isEqualTo (DS_var_3DActionData select 2)) then
		{
			_size = (7 - (player distance _pos)) / 3;
		};

		drawIcon3D [_icon, [_damage, 1 - _damage, 0, 1], _pos, _size, _size, 0, (_txt + " " + str ((1 - _damage) * 100) + "%"), 2, _size / 20, "PuristaBold"];
		true
	} count DS_var_valid3DActions;

	_alreadyHasValidAction = false;
	_pos = (DS_var_3DActionData select 2) select 2;
	_circleMultiplyer = 1;
	_circleCount = count DS_var_valid3DActionsCode;
	_k = 0;

	for[{_i = 0}, {_i < _circleCount * 65}, {_i = _i + 65}] do
	{
		(DS_var_valid3DActionsCode select _k) params ["_code","_txt"];
		_iconPos = [(_pos select 0) + (0.15 * sin(_i)), (_pos select 1) + (0.15 * cos(_i)), _pos select 2];

		_valid = false;
		for "_j" from 1 to _distance do 
		{
			_vChange = _vecFT vectorMultiply (((_camPos distance _visPos) / 20)*_j);
			_checkPos = _camPos vectorAdd _vChange;
			_valid = false;
			if((_checkPos distance _iconPos) <= 0.1) exitWith 
			{
				_valid = true;
			};
		};
		
		_size = (7 - (player distance _pos)) / 5;
		if (_valid) then
		{
			if !(_alreadyHasValidAction) then
			{
				_size = (7 - (player distance _pos)) / 3;
				_alreadyHasValidAction = true;
				if (isNil "DS_var_valid3DActionCodeSelected") then
				{
					DS_var_valid3DActionCodeSelected = -1;
				};
				if (DS_var_valid3DActionCodeSelected != _k) then
				{
					DS_var_valid3DActionCodeSelected = _k;
				};
			};
		};

		drawIcon3D ["\a3\ui_f\data\igui\cfg\weaponcursors\gl_gs.paa", [0.3, 0.3, 1, 1], _iconPos, _size, _size, 0, _txt, 2, _size / 20, "PuristaBold"];

		if !(_alreadyHasValidAction) then
		{
			DS_var_valid3DActionCodeSelected = -1;
		};
		_k = _k + 1;
	};
};

true