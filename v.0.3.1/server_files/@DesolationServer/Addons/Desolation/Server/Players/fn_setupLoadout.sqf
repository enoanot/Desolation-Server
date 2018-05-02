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
params["_unit",["_equipmentArray",false]];

removeHeadgear _unit;
removeVest _unit;
removeBackpack _unit;
removeUniform _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

if !(_equipmentArray isEqualTo false) then {
	
	//--- load the chosen loadout	
	sleep 2;
	_unit setUnitLoadout _equipmentArray;
	_loadout = getunitloadout _unit;

	if !(_loadout isEqualTo _equipmentArray) then {
		_cycles = 3;
		while {_cycles > 0} do {
			_unit setUnitLoadout _equipmentArray;
			sleep 2;
			if (_loadout isEqualTo _equipmentArray) exitWith {};

			_cycles = _cycles - 1;
		};
	};
} else {

	_uniform = (["Uniform","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_headgear = (["Headgear","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_vest = (["Vest","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_backpack = (["Backpack","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_HandgunWpn = (["HandgunWpn","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_PrimaryWpn = (["PrimaryWpn","DS"] call BASE_fnc_getCfgValue) splitString ",";

	_Items = (["Items","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_linked = (["Linked","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_PrimaryWpnAttachments = (["PrimaryWpnAttachments","DS"] call BASE_fnc_getCfgValue) splitString ",";
	_HandgunWpnAttachments = (["HandgunWpnAttachments","DS"] call BASE_fnc_getCfgValue) splitString ",";


	//--- load fresh loadout
	if !(_uniform isEqualTo []) then {
		_uniform = selectRandom _uniform;
		_unit forceAddUniform _uniform;
		sleep 1;
		if (uniform _unit == "") then {_unit addWeapon _HandgunWpn;};
	};
	
	if !(_headgear isEqualTo []) then {
		_headgear = selectRandom _headgear;
		_unit addHeadgear _headgear;
		sleep 1;
		if (headgear _unit == "") then {_unit addWeapon _HandgunWpn;};
	};
	
	if !(_vest isEqualTo []) then {
		_vest = selectRandom _vest;
		_unit addVest _vest;
		sleep 1;
		if (vest _unit == "") then {_unit addWeapon _HandgunWpn;};
	};
	
	if !(_backpack isEqualTo []) then {
		_backpack = selectRandom _backpack;
		_unit addBackpack _backpack;
		sleep 1;
		if (backpack _unit == "") then {_unit addWeapon _HandgunWpn;};
	};
	
	if !(_HandgunWpn isEqualTo []) then {
		_HandgunWpn = selectRandom _HandgunWpn;
		_unit addWeapon _HandgunWpn;
		sleep 1;
		if (secondaryweapon _unit == "") then {_unit addWeapon _HandgunWpn;};
		{
			_unit addHandgunItem _x;
		} forEach _HandgunWpnAttachments;
	};
	
	if !(_PrimaryWpn isEqualTo []) then {
		_PrimaryWpn = selectRandom _PrimaryWpn;
		_unit addWeapon _PrimaryWpn;
		sleep 1;
		if (primaryweapon _unit == "") then {_unit addWeapon _HandgunWpn;};
		{
			_unit addPrimaryWeaponItem _x;
		} forEach _PrimaryWpnAttachments;
	};
	
	

	{
		_unit addItem _x;
	} forEach _Items;
	
	{
		_unit linkItem _x;
	} forEach _linked;
};