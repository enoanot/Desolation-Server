
params["_container"];

_weapons = (weaponsItemsCargo _container);
if(isNil "_weapons") then {_weapons = [];};

_output = [];
{
	// check if the weapon has an launcher so that the fifth element is an array containing the launcher ammunition
	if(count _x > 6) then {
		_output pushBack _x;
	} else {
		// add empty launcher ammo even if there is no launcher
		_output pushBack [_x select 0,_x select 1,_x select 2,_x select 3,_x select 4,[],_x select 5];
	};

} forEach _weapons;

_output;