
params ["_container","_weapons"];

[_container,_weapons] spawn {
	params ["_container","_weapons"];

	{
		_weaponClass = [_x select 0] call BIS_fnc_baseWeapon;
		if(isNil "_weaponClass") then {_weaponClass = _x select 0;};

		_muzzle = _x select 1;
		_side = _x select 2;
		_optic = _x select 3;
		_magInfo = _x select 4;
		_launch = _x select 5;
		_bipod = _x select 6;

		_dummyGroup = createGroup civilian;
		if(isNull _dummyGroup) then {
			_dummyGroup = createGroup east;
		};
		if(isNull _dummyGroup) then {
			_dummyGroup = createGroup west;
		};
		if(isNull _dummyGroup) then {
			_dummyGroup = createGroup independent;
		};


		_dummyUnit = _dummyGroup createUnit ["C_Soldier_vr_f", [0,0,0], [], 0, "NONE"];
		_dummyUnit allowDamage false;
		_dummyGroup setBehaviour "CARELESS";
		hideObjectGlobal _dummyUnit;
		_dummyUnit addWeapon _weaponClass;

		_attachments = [_muzzle,_side,_optic,_magInfo,_launch,_bipod];
		{
			_dummyUnit addWeaponItem [_weaponClass,_x];
		} foreach _attachments;

		[_dummyUnit,_container,_weaponClass,_dummyGroup] spawn {
			params ["_dummyUnit","_container","_weaponClass","_dummyGroup"];

			_loops = 20;
			while {!((weapons _dummyUnit) isEqualTo []) && (_loops > 0)} do {
				_dummyUnit action ["DropWeapon",_container,_weaponClass];
				sleep 1;
				_loops = _loops - 1;
			};
			deleteVehicle _dummyUnit;
			deleteGroup _dummyGroup;
		};

	sleep 0.01; // Wait before spawning next unit

	} forEach _weapons;

	true;
};