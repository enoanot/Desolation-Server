params [["_player", objNull],["_container", objNull]];

[player,["BagClose",50]] remoteExec ["say3D",allPlayers];

DS_var_OpenedContainer = [];

//--- used for container cleanup
if ((typeOf _container) == "GroundWeaponHolder") then
{
	_inv = [];
	_inv append ((getMagazineCargo _container) select 0);
	_inv append ((getItemCargo _container) select 0);
	_inv append ((getWeaponCargo _container) select 0);
	_inv append ((getBackpackCargo _container) select 0);
	if ((count _inv) == 0) then
	{
		[(netId _container), (netId _player)] remoteExecCall ["DeleteEmptyHolder", 2];
	};
};

_cType = typeof(_container);

//--- used for building
if(toLower(_cType) find "_preview2" != -1) then {
	_data = _container getVariable "SVAR_buildParams";
	if(isNil {_data}) exitWith {systemchat "DEBUG: not a buildable, exiting"}; //if no build params then wtf happened?
	_items = _data select 0;
	_magData = getMagazineCargo _container;
	_magItems = call compile tolower(str(_magData select 0));
	_magCount = _magData select 1;
	
	_full = true;
	{
		_itemType = tolower(_x select 0);
		_count = _x select 1;
			
		_index = _magItems find _itemType;
		if(_index == -1) exitWith {_full = false;};
		_mCount = _magCount select _index;
		if(_mCount < _count) exitWith {_full = false;};
	} forEach _items;
	
	if(_full) then {
		[_container] call DS_fnc_onCrateFilled;
	};
};

//-- used for item actions
DS_var_InvOpen = false;
false;