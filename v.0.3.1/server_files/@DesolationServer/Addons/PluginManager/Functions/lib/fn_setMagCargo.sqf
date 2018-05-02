
params ["_container","_magazines"];

{
	if(count(_x) > 1) then {
		_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
	} else {
		_container addMagazineAmmoCargo [_x select 0, 1, 1];
	};
} forEach _magazines;

true;