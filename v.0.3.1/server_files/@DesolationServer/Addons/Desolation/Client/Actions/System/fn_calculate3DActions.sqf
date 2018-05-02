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

private ["_obj","_validActions","_dif0","_dif1","_distance","_hitpoints","_i","_partName","_pos","_position","_data","_txt","_icon"];
if (isNil "DS_var_valid3DActions") then
{
	DS_var_valid3DActions = [];
};

if !(canSuspend) exitWith { _this spawn DS_fnc_calculate3DActions; };

while {DS_var_3DActionsEnabled} do
{
	_obj = cursorTarget;
	_validActions = [];
	if (isNull _obj) then
	{
		_obj = cursorObject;
	};
	if (!(isNull _obj) && (vehicle player == player)) then 
	{
		_dif0 = (boundingBoxReal _obj) select 0;
		_dif1 = (boundingBoxReal _obj) select 1;
		_distance = (_dif0 distance _dif1) + 4;

		if ((_obj distance player) > (_distance / 2)) exitWith 
		{
			DS_var_3DPartName = nil;
			DS_var_3DActionData = nil;
			DS_var_valid3DActionsCode = nil;
			DS_var_valid3DActionCodeSelected = nil;
			DS_var_valid3DActions = [];

			false
		};

		if ((_obj isKindOf "landVehicle") || (_obj isKindOf "air") || (_obj isKindOf "ship")) exitWith
		{
			if ((_obj isKindOf "House") || (_obj isKindOf "Building")) exitWith { DS_var_valid3DActions = []; }; 
			_hitpoints = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _obj >> "Hitpoints");

			if ((count _hitpoints) == 0) exitWith { false };

			_i = 0;
			_validActions = [];
			{
				_partName = configName (_hitpoints select _i);
				_pos = _obj selectionPosition [getText((_hitpoints select _i) >> "name"), "HitPoints"];
				_position = _obj modelToWorldVisual _pos;
				_damage = _obj getHitPointDamage _partName;
				if !((player distance _position) > 5) then
				{
					_partElement = (tolower _partName) call DS_fnc_get3DPartName;
					_data = _partElement select 0;
					if (isNull _data) exitWith {};
					_txt = getText (_data >> "Name");
					_icon = getText (_data >> "Icon");
					_validActions pushBack [_icon, _damage, _position, _txt, _partName];
				};
				_i = _i + 1;
				true
			} count _hitpoints;
		};
		if ((_obj isKindOf "Man") || (_obj isKindOf "DSR_Crate_Base") || (_obj isKindOf "DSR_objects_base") || (_obj isKindOf "GroundWeaponHolder") || (toLower(str _obj) find 'water' != -1) || (_obj isKindOf "Land_Pallets_stack_F")) exitWith
		{
			_pos = _obj modelToWorld [0,0,0];
			if !((player distance _pos) > 5) then
			{
				_data = ("action" call DS_fnc_get3DPartName) select 0;
				_icon = getText (_data >> "Icon");
				_validActions pushBack [_icon, 0, _pos, "", "Action"];
			};
		};
		DS_var_valid3DActions = [];
	}
	else
	{
		DS_var_valid3DActions = [];
	};

	if (!((count _validActions) < 1) && !(_validActions isEqualTo DS_var_valid3DActions)) then
	{
		DS_var_valid3DActions = +_validActions;
	};
	uiSleep 0.1;
	true
};

true
