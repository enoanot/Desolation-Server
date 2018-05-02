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

params["_heliCrashPos","_crashName"];


_cfg = (configFile >> "CfgHeliCrashes" >> "CrashTypes" >> _crashName >> "Loot" >> "Crates");
for "_i" from 0 to (count(_cfg))-1 do {
	_entry = _cfg select _i;
	if(isClass _entry) then {

		_crateClass = getText(_entry >> "CrateClass");

		// Get Items
		_items = getArray (_entry >> "Items");
		_weapons = getArray (_entry >> "Weapons");
		_backpacks = getArray (_entry >> "Backpacks");
			

		// Create crate
		_cratePos = _heliCrashPos vectorAdd [round(random 1)*random [1,2,3],round(random 1)*random [1,2,3],0];
		_crate = _crateClass createVehicle _cratePos;
		_crate allowDamage false;
		_crate setDir (random 360);


		// Remove existing items
		clearItemCargoGlobal _crate;
		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;
		

		// Add items
		{
			_crate addItemCargoGlobal [_x select 0,_x select 1];
		} forEach _items;

		// Add Weapons
		{
			_crate addWeaponCargoGlobal [_x select 0,_x select 1];
		} forEach _weapons;

		// Add backpacks
		{
			_crate addBackpackCargoGlobal [_x select 0,_x select 1];
		} forEach _backpacks;

	};
};

true;