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

DB_var_runObjectMon = true;

waitUntil{!DB_var_restoreObjectInProgress};

DB_var_savingObjects = true;

DB_var_nextSync = diag_tickTime + (60*30);

while{true} do {
	waitUntil{diag_tickTime >= DB_var_nextSync || !DB_var_runObjectMon};

	_newArray1 = [];
	_newArray2 = [];
	{
		_uuid = DB_var_ObjectUUIDS select _forEachIndex;

		_cleanup = false;
		_pos = getPosASL _x;
		if((_pos select 2) < 0 && !(_x isKindOf "Ship")) then {
			_cleanup = true;
		};

		if (isNull _x || !(alive _x) || _cleanup) then {
			[_uuid,objNull] call DB_fnc_killObject;
			if(!isNull _x) then {
				detach _x;
				deleteVehicle _x;
			};
		} else {
			[_x] call DB_fnc_updateObject;
			_newArray1 pushBack _x;
			_newArray2 pushBack _uuid;
		};
	} forEach (DB_var_Objects);
	DB_var_Objects = _newArray1;
	DB_var_ObjectUUIDS = _newArray2;
	DB_var_nextSync = diag_tickTime + (60*30);
	if(!DB_var_runObjectMon) exitWith {};
};
DB_var_savingObjects = false;
