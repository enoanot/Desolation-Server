
params ["_container","_items"];

{
	_container addItemCargoGlobal [_x,1];
} forEach _items;

true;