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
params["_building"];
private["_LootPiles","_savedLoot","_data"];

_LootPiles = (_building getVariable ["LOOT_PILES",[]]) - [objNull]; //--- get all remaining loot piles

_savedLoot = [];
// Layout: LOCATION, [ CONTAINER DATA , MAGAZINE DATA, ITEM DATA, WEAPON DATA, BACKPACK DATA]
// CONTAINER DATA: [ [CONTAINER TYPE, CONTAINER LOOT] , ... ]
{
	//--- TEMPORARY
	_data = [getPosATL _x,[_x] call BASE_fnc_getAllCargo];
	_savedLoot pushBack _data;
	deleteVehicle _x;
} forEach _LootPiles;

_building setVariable ["SavedLoot",_savedLoot];
_building setVariable ["LOOT_PILES",[]];
