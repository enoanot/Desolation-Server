
params ["_unit","_loadout"];
_loadout params ["_uniformClass","_vestClass","_backpackClass","_headgearClass","_gogglesClass","_unitWeapons","_assignedItems","_gearUniform","_gearVest","_gearBackPack"];


//removes binocular from assigned items (it gets spawned with weapons)
_binoPos = _assignedItems find (binocular _unit);
if (_binoPos >= 0) then {_assignedItems deleteat _binoPos;};

removeAllContainers _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

if (_uniformClass != "") then {_unit addUniform _uniformClass;};
if (_vestClass != "") then {_unit addVest _vestClass;};
if (_backpackClass != "") then {_unit addBackpackGlobal _backpackClass;};
if (_headgearClass != "") then {_unit addHeadgear _headgearClass;};
if (_gogglesClass != "") then {_unit addGoggles _gogglesClass;};


if ((count _unitWeapons) > 0) then {
	{
		_x params ["_classname","_muzzle","_side","_optics","_magArr","_bipod"];
		
		_attachments = [_muzzle,_side,_optics,_magArr,_bipod];
		_unit addWeapon _classname;
		if !(_magArr isEqualTo []) then {_unit setAmmo [_classname,0];};
		{
			_attachment = _x; 
			ScopeName "attachmentLoop";
			switch (_attachment) do {
				case "":{breakTo "attachmentLoop";};
				case []:{breakTo "attachmentLoop";};
				default {_unit addWeaponItem [_classname,_attachment];};
			};
		} foreach _attachments;
	} foreach _unitWeapons;
};

if ((count _assignedItems) > 0) then {
	{_unit linkItem _x} foreach _assignedItems;
};

[(uniformContainer _unit),_gearUniform] call Base_fnc_setAllCargo;
[(vestContainer _unit),_gearVest] call Base_fnc_setAllCargo;
[(backpackContainer _unit),_gearBackPack] call Base_fnc_setAllCargo;