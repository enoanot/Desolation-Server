/*
 * Desolation Redux
 * http://desolationredux.com/
 * � 2016 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */
	 
_requiredItems = [
	["DSR_Item_Bike_Frame",1],
	["DSR_Item_Bike_Wheel",2],
	["DSR_Item_Bike_Chain",1]
];

if (player != vehicle player) exitWith {systemchat "Can't craft bike while in vehicle!"};
if !(nearestObjects [player, ["LandVehicle","Air","Ship"], 12] isEqualTo []) exitWith {systemchat "There is other vehicle too near!"};

_anim = "Acts_CarFixingWheel";
if ([_anim] call ds_fnc_doAction) then {
	
	if !("DSR_Item_Toolbox" in magazines player) exitWith {systemchat "Items(s) missing: Toolbox"};
	_hasRequirements = true;
	{
		_item = _x select 0;
		_itemCount = _x select 1;
		if( ({tolower(_x) == tolower(_item)} count (magazines player)) < _itemCount) exitWith {
			_displayName = getText (configfile >> "CfgMagazines" >> _item >> "displayName");
			systemchat ("Item(s) missing: " + _displayName + " count: " + str(_itemCount));
			_hasRequirements = false;
		};
		true
	} count _requiredItems;
	if !(_hasRequirements) exitWith {systemchat "You do not have the items required to craft this!"};
	
	{
		for "_i" from 1 to (_x select 1) do {
			player removeMagazine (_x select 0);
		};
		true
	} count _requiredItems;
	
	[player] remoteExec ["DS_fnc_createBike",0];
	
	systemchat "Bike Crafted";
	[1] call DS_fnc_addPoints;
} else {
	systemchat "Player Moved";
};
