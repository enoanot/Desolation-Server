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


_cfg = (configFile >> "CfgHeliCrashes" >> "CrashTypes" >> _crashName >> "Loot" >> "Bodies");
if(count (_cfg) > 0) then {

	// Create group
	_group = createGroup West;
	if(isNull _group) then {
		_group = createGroup East;
	};
	if(isNull _group) then {
		_group = createGroup independent;
	};
	if(isNull _group) then {
		_group = createGroup civilian;
	};
	if(isNull _group) exitwith {};

	for "_i" from 0 to (count(_cfg))-1 do {
		_entry = _cfg select _i;
		if(isClass _entry) then {

			// Get Configs
			_unitClass = getText(_entry >> "UnitClass");
			_uniformLoot = getArray (_entry>> "Uniforms");
			_vestLoot = getArray (_entry >> "Vests");
			_backpackLoot = getArray (_entry >> "Backpacks");
			_headgearLoot = getArray (_entry >> "Headgears");
			_weaponLoot = getArray (_entry >> "Weapons");
			_sidearmLoot = getArray (_entry >> "Handguns");
			_itemLoot = getArray (_entry >> "Items");
			_linkedLoot = getArray (_entry >> "Linkeditems");
			

			// Create Body
			_bodyPos = _heliCrashPos vectorAdd [round(random 1)*random [1,2,3],round(random 1)*random [1,2,3],0];
			_body = _group createUnit [_unitClass,_bodyPos,[],0,"NONE"];
			_body hideObjectGlobal true;
			_body setDir (random 360);
			removeFromRemainsCollector [_body];


			// Remove Existing Items
			removeGoggles _body;
			removeAllWeapons _body;
			removeVest _body;
			removeUniform _body;
			removeHeadgear _body;
			removeBackpack _body;
			removeAllAssignedItems _body;
			removeallitems _body;


			// Add Outfits
			if !(_uniformLoot isEqualTo []) then {
				_uniform = selectRandom _uniformLoot;
				_body forceAddUniform _uniform;
			};

			if !(_vestLoot isEqualTo []) then {
				_vest = selectRandom _vestLoot;
				_body addVest _vest;
			};

			if !(_backpackLoot isEqualTo []) then {
				_backpack = selectRandom _backpackLoot;
				_body addbackpack _backpack;
			};

			if !(_headgearLoot isEqualTo []) then {
				_headgear = selectRandom _headgearLoot;
				_body addHeadgear _headgear;
			};


			// Add Weapons
			_maxMags = (getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashName >> "loot" >> "LootSettings" >> "BodySettings" >> "MaxMagAmountWithWeapon"));
			_minMags = (getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashName >> "loot" >> "LootSettings" >> "BodySettings" >>  "MinMagAmountWithWeapon"));
			_maxBullets = (getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashName >> "loot" >> "LootSettings" >> "BodySettings" >> "MaxBulletCountInMagazine") / 100);
			_minBullets = (getNumber (configFile >> "CfgHeliCrashes" >> "CrashTypes">> _crashName >> "loot" >> "LootSettings" >> "BodySettings" >>  "MinBulletCountInMagazine") / 100);
			{
				if(_x isEqualTo []) exitwith {};
				_weapon = selectRandom _x;
				_body addWeapon _weapon;

				// Get Magazine Count
				if(_maxMags == 0) exitWith {};
				_magCount = random _maxMags;
				if (_magCount < _minMags) then {_magCount = _minMags + (random(_maxMags - _minMags));};
				_magCount = ceil(_magCount);

				// Get Magazine Type
				_magazines = getArray(configFile >> "CfgWeapons" >> _weapon >> "Magazines");
				_magazine = _magazines select (floor(random(count(_magazines))));

				// Get Bullet Count
				_maxAmmo = getNumber(configFile >> "CfgMagazines" >> _magazine >> "count");
				_bulletCount = ceil(random _maxAmmo * (_maxBullets - _minBullets)) + _maxAmmo * _minBullets;

				// Insert One Magazine Into Weapon
				_body addWeaponItem [_weapon,[_magazine,_bulletCount]];
				_magCount = _magCount - 1;

				// TODO Add weapon attachments

				// Add Rest Of The Magazines
				for "_m" from 0 to (ceil(_magCount) - 1) do {
					_bulletCount = ceil(random _maxAmmo * (_maxBullets - _minBullets)) + _maxAmmo * _minBullets; // Get new random count for bullets
					_body addMagazine [_magazine,_bulletCount]; // TODO Add magazines to random container (Uniform,Vest,Backpack)
				};

			} forEach [_weaponLoot,_sidearmLoot];
			

			// Add Items
			if !(_itemLoot isEqualTo []) then {
				{
					_body addItem _x; // TODO Add items to random container (Uniform,Vest,Backpack)
				} forEach _itemLoot;
			};

			if !(_linkedLoot isEqualTo []) then {
				{
					_body linkItem _x;
				} forEach _linkedLoot;
			};

			_body setDamage 1;
			waitUntil {speed _body < 1};
			sleep 1; // Make sure body is still
			_body hideObjectGlobal false;

		};
	};
	deleteGroup _group;
};

true;