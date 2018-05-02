class CfgPatches
{
	class LootSystem {
		units[] = {};
	};
};

class Plugins
{
	class LootSystem
	{
		name = "LootSystem";
		desc = "Adds loot to your server";
		version = 0.1;
		tag = "LSYS";
	};
};

class CfgFunctions
{
	class LSYS
	{
		class Server
		{
			file = "LootSystem\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Loot
		{
			file = "LootSystem\Server\Loot";
			isserver = 1;
			class lootManager {};
			class spawnLoot {};
			class despawnLoot {};
		};
	};
};


class CfgItemSpawns {
	buildingTypes[] = {"Military","Civilian","Industrial","Commercial","Medical","Mechanical"};
	lootRarity[] = {"rare","semirare","average","semicommon","common"};
	lootTypes[] = {"Weapon","Handgun","Magazine","Food","Drink","Medical","Junk","Backpack","Uniform","Vest","Helmet","Cosmetic","GeneralItem","Construction","Book","Electronic","CarPart","Attachment"};

	#include "Configs\LootTables\DesolationLoot.hpp"
	// Add you'r custom loot table files here
	
	
	class Buildings {
		
		#include "Configs\LootPositions\Buildings.hpp"
		#include "Configs\LootPositions\CUPBuildings.hpp"
		#include "Configs\LootPositions\AltisBuildings.hpp"
		// Add you'r custom loot position files here
		
	};
};