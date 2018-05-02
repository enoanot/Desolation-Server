
params["_container"];
private["_data","_iContainData","_insideContainers","_loot","_mags","_items","_weps","_backpacks"];

if(isNull _container) exitWith {[[],[],[],[],[]]};

_data = [];

//--- Recursively get all data from inside containers
_iContainData = [];
_insideContainers = everyContainer _container;
{
	_loot = ([_x select 1] call BASE_fnc_getAllCargo);
	_iContainData pushBack [_x select 0,_loot];
} forEach _insideContainers;
_data pushBack _iContainData;


//--- Get non-container data
_mags = [_container] call BASE_fnc_getMagCargo;
_data pushBack _mags;

_items = [_container] call BASE_fnc_getItemCargo;
_data pushBack _items;

_weps = [_container] call BASE_fnc_getWepCargo;
_data pushBack _weps;

_backpacks = [_container] call BASE_fnc_getBackpackCargo;
_data pushBack _backpacks;

_data;