_magsAmmo = magazinesAmmo player;
_canPower = false;
{
	_class = _x select 0;
	_count = _x select 1;
	if(_class == "DSR_Item_Battery_Charged" && _count > 0) exitWith {_canPower = true;};
} forEach magazinesAmmo player;
_canPower;