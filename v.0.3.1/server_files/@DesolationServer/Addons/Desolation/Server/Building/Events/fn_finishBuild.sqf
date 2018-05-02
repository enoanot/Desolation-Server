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
params["_crate"];

_owner = _crate getVariable ["oOWNER",""];

_entry = _crate getVariable "SVAR_buildParams";
_items = _entry select 0;
_model = _entry select 2;

_array = [];
{
	_mag = _x select 0;
	_count = _x select 1;
	for "_i" from 1 to _count do {
		_array pushback toLower(_mag);
	};
} forEach _items;
_ammo = magazinesAmmoCargo _crate;
_newammo = [];
clearMagazineCargoGlobal _crate;
{
	_mag = toLower(_x select 0);
	_count = _x select 1;
	 
	_index = _array find _mag;
	if(_index != -1) then {
		_array deleteAt _index;
	} else {
		_newammo pushback (_x + [1]);
	};
	 
} forEach _ammo;	
{
	_crate addMagazineAmmoCargo _x
} forEach _newammo;

_loot = [_crate] call BASE_fnc_getAllCargo;

_holder = "groundWeaponHolder" createVehicle (position _crate);
[_holder,_loot] call BASE_fnc_setAllCargo;

_pos = getposatl _crate;
_dir = getdir _crate;
_vectorUp = vectorUp _crate;

deleteVehicle _crate;


_obj = _model createVehicle [0,0,0];
_obj setdir _dir;
_obj setposatl _pos;
_obj setVectorUp _vectorUp;

_obj setVariable ["SVAR_Parts",_items];
_obj setVariable ["oOWNER",_owner,true];


[_obj, 2, 1001] call DB_fnc_spawnObject;

