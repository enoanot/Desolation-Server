
private ["_uniformObj","_vestObj","_backpackObj","_uniformClass","_vestClass","_backpackClass","_headgearClass","_gogglesClass","_unitWeapons","_assignedItems","_gearUniform","_gearVest","_gearBackPack","_unitLoadout"];

_uniformObj = uniformContainer _this;
_vestObj = vestContainer _this;
_backpackObj = Unitbackpack _this;

_uniformClass = uniform _this;
_vestClass = vest _this;
_backpackClass = backpack _this;
_headgearClass = headgear _this;
_gogglesClass = goggles _this;

_assignedItems = assignedItems _this;

_unitWeapons = (weaponsItems _this);
_unitBackpackWeapons = (weaponsItemsCargo(backpackContainer _this));

if !(isNil "_unitBackpackWeapons") then {
	if !(_unitWeapons isEqualTo []) then {
		_unitWeapons = (_unitWeapons) - (_unitBackpackWeapons);
	};
};


_gearUniform =  _uniformObj call BASE_fnc_getAllCargo;
_gearVest =  _vestObj call BASE_fnc_getAllCargo;
_gearBackPack =  _backpackObj call BASE_fnc_getAllCargo;


_unitLoadout = [_uniformClass,_vestClass,_backpackClass,_headgearClass,_gogglesClass,_unitWeapons,_assignedItems,_gearUniform,_gearVest,_gearBackPack];
_unitLoadout