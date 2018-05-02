class CfgPatches
{
	class DSZombz {units[] = {};};
};

class Plugins
{
	class DSZombz
	{
		name = "DSZombz";
		desc = "Recoded SM_Zombz AI";
		tag = "DSZ";
	};
};
class CfgPluginEvents {
	class PlayerEvents {
		overrides = 0;
		class Events {
			class DSZ_Fired {
				type = "Fired";
				function = "DSZ_fnc_onWeaponFired";
			};
		};
	};
};
class CfgFunctions
{
	class DSZ
	{
		// CLIENT CODE
		class Client 
		{
			file = "DSZombz\Client";
			isclient = 1;
			class initClient {};
		};
		class Client_Events
		{
			file = "DSZombz\Client\Events";
			isclient = 1;
			class onWeaponFired {};
		};
		class Client_Sensing
		{
			file = "DSZombz\Client\Sensing";
			isclient = 1;
			class zombieCanSee {};
			class zombieCanHear {};
			class zombieCanSmell {};
		};
		class Client_Agroing
		{
			file = "DSZombz\Client\Agroing";
			isclient = 1;
			class agroCheck {};
			class agroZombie {};
			class deagroZombie {};
		};
		class Client_Actions
		{
			file = "DSZombz\Client\Actions";
			isclient = 1;
			class zombieAttack {};
		};
		// SERVER CODE
		class Server 
		{
			file = "DSZombz\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Events 
		{
			file = "DSZombz\Server\Events";
			isserver = 1;
			class killZombie {};
		};
		class Server_Spawning
		{
			file = "DSZombz\Server\Spawning";
			isserver = 1;
			class spawnZombie {};
			class insertZombie {};
			class spawnManager {};
			class createHolder {};
			class despawnZombie {};
		};
		class Server_Locality
		{
			file = "DSZombz\Server\Locality";
			isserver = 1;
			class fromClient {};
			class toClient {};
		};
		class Server_Initialization
		{
			file = "DSZombz\Server\Initialization";
			isserver = 1;
			class readConfig {};
			class selectLocations {};
		};
		
		// BOTH CODE
		class Both 
		{
			file = "DSZombz\Both";
			isclient = 1;
			class getNearMen {};
			class getNearPlayers {};
			class isPlayerNear {};
			class initRoaming {};
		};
	};
};

class CfgZombies 
{

	//Citizens
	class DSR_Zombie_Citizen_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Spirit",
				"DSR_Item_Bandage",
				"DSR_Item_Bandage",
				"DSR_Item_Pen_Black",
				"DSR_Item_Can_Opener",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	class DSR_Zombie_Citizen_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 0; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Spirit",
				"DSR_Item_Bandage"
			};
		};
	}; 
	class DSR_Zombie_Citizen_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 1; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Spirit",
				"DSR_Item_Bandage",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	class DSR_Zombie_Citizen_4 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Bandage",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Matches"
			};
		};
	}; 
	
	






	//Workers
	class DSR_Zombie_Worker_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Bandage",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Hammer",
				"DSR_Item_Matches"
			};
		};
	}; 
	class DSR_Zombie_Worker_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 1; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Extension_Cord",
				"DSR_Item_Hardware",
				"DSR_Item_Camping_Light",
				"DSR_Item_Duct_Tape"
			};
		};
	}; 
	class DSR_Zombie_Worker_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Drill",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Tape_Measure",
				"DSR_Item_Tarp",
				"DSR_Item_Hammer",
				"DSR_Item_Matches"
			};
		};
	}; 
	class DSR_Zombie_Worker_4 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Wrench",
				"DSR_Item_Pliers",
				"DSR_Item_Screw_Driver_Phillips",
				"DSR_Item_Metal_Wire",
				"DSR_Item_Battery_Charged",
				"DSR_Item_Matches"
			};
		};
	};
	






	
	//Profiteers
	class DSR_Zombie_Profiteer_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 1; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Cereal",
				"DSR_Item_Can_Chicken",
				"DSR_Item_Beans",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Pillow",
				"DSR_Item_Handwarmer",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Water_Purification_Tablets"
			};
		};
	}; 
	class DSR_Zombie_Profiteer_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Cereal",
				"DSR_Item_Can_Chicken",
				"DSR_Item_Beans",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Pillow",
				"DSR_Item_Handwarmer",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	class DSR_Zombie_Profiteer_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Cereal",
				"DSR_Item_Can_Chicken",
				"DSR_Item_Beans",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Pillow",
				"DSR_Item_Handwarmer",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	class DSR_Zombie_Profiteer_4 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Cereal",
				"DSR_Item_Can_Chicken",
				"DSR_Item_Beans",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Pillow",
				"DSR_Item_Handwarmer",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Water_Purification_Tablets",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	






	
	//Woodlanders
	class DSR_Zombie_Woodlander_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 1; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Seeds_Potato",
				"DSR_Item_Seeds_Tomato",
				"DSR_Item_Seeds_Peas",
				"DSR_Item_Seeds_Lettuce",
				"DSR_Item_Seeds_Corn",
				"DSR_Item_Seeds_Watermelon",
				"DSR_Item_Fishingrod_Broken",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Nail_File"
			};
		};
	}; 
	class DSR_Zombie_Woodlander_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Seeds_Potato",
				"DSR_Item_Seeds_Tomato",
				"DSR_Item_Seeds_Peas",
				"DSR_Item_Seeds_Lettuce",
				"DSR_Item_Seeds_Corn",
				"DSR_Item_Seeds_Watermelon",
				"DSR_Item_Fishingrod_Broken",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Nail_File"
			};
		};
	}; 
	class DSR_Zombie_Woodlander_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Seeds_Potato",
				"DSR_Item_Seeds_Tomato",
				"DSR_Item_Seeds_Peas",
				"DSR_Item_Seeds_Lettuce",
				"DSR_Item_Seeds_Corn",
				"DSR_Item_Seeds_Watermelon",
				"DSR_Item_Fishingrod_Broken",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Nail_File"
			};
		};
	}; 
	class DSR_Zombie_Woodlander_4 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Seeds_Potato",
				"DSR_Item_Seeds_Tomato",
				"DSR_Item_Seeds_Peas",
				"DSR_Item_Seeds_Lettuce",
				"DSR_Item_Seeds_Corn",
				"DSR_Item_Seeds_Watermelon",
				"DSR_Item_Fishingrod_Broken",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fertilizer",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Nail_File"
			};
		};
	}; 
	





	
	//Functionaries
	class DSR_Zombie_Functionary_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 1; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Padlock",
				"DSR_Item_Lighter",
				"DSR_Item_Electrical_Comp",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Battery_Charged",
				"DSR_Item_Notepad",
				"DSR_Item_Pencil_Blue",
				"DSR_Item_Suitcase",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	class DSR_Zombie_Functionary_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Padlock",
				"DSR_Item_Lighter",
				"DSR_Item_Electrical_Comp",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Battery_Charged",
				"DSR_Item_Notepad",
				"DSR_Item_Pencil_Blue",
				"DSR_Item_Suitcase",
				"DSR_Item_Crushed_Can"
			};
		};
	}; 
	
	







	//Villagers
	class DSR_Zombie_Villager_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Camera",
				"DSR_Item_Battery_Charged",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Nail_File",
				"DSR_Item_Suitcase",
				"DSR_Item_Fishingrod_Broken",
				"DSR_Item_Phoneold",
				"DSR_Item_Phoneold",
				"DSR_Item_Phonesmart",
				"DSR_Item_Pillow",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Spanner",
				"DSR_Item_Spirit",
				"DSR_Item_Rusty_Spirit",
				"DSR_Item_Cereal",
				"DSR_Item_Beans",
				"DSR_Item_Can_Chicken"
			};
		};
	}; 
	class DSR_Zombie_Villager_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 1;
			Items[] = {
				"DSR_Item_Camera",
				"DSR_Item_Pencil_Blue",
				"DSR_Item_Pencil_Green",
				"DSR_Item_Pencil_Red",
				"DSR_Item_Pencil_Yellow",
				"DSR_Item_Shears",
				"DSR_Item_Shears",
				"DSR_Item_Lighter",
				"DSR_Item_Lighter",
				"DSR_Item_Matches",
				"DSR_Item_Photos",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Franta",
				"DSR_Item_Spirit",
				"DSR_Item_Cereal"
			};
		};
	}; 
	class DSR_Zombie_Villager_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Watercan_full",
				"DSR_Item_Watercan_Empty",
				"DSR_Item_Watercan_Empty",
				"DSR_Item_Franta",
				"DSR_Item_Franta",
				"DSR_Item_Spirit",
				"DSR_Item_Spirit",
				"DSR_Item_Rusty_Spirit",
				"DSR_Item_Cereal",
				"DSR_Item_Beans",
				"DSR_Item_Can_Chicken",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Pencil_Red"
			};
		};
	}; 
	class DSR_Zombie_Villager_4 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Camera",
				"DSR_Item_Pencil_Blue",
				"DSR_Item_Pencil_Green",
				"DSR_Item_Pencil_Red",
				"DSR_Item_Pencil_Yellow",
				"DSR_Item_Shears",
				"DSR_Item_Shears",
				"DSR_Item_Lighter",
				"DSR_Item_Lighter",
				"DSR_Item_Matches",
				"DSR_Item_Photos",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Duct_Tape",
				"DSR_Item_Franta",
				"DSR_Item_Spirit",
				"DSR_Item_Cereal"
			};
		};
	}; 
	
	






	//Misc
	class DSR_Zombie_Priest_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Pen_Black",
				"DSR_Item_Pen_Red",
				"DSR_Item_Fabric_Scraps",
				"DSR_Item_Crushed_Can",
				"DSR_Item_Deviled_Ham",
				"DSR_Item_Deviled_Ham"
			};
		};
	};  
	class DSR_Zombie_Policeman_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Ziptie",
				"DSR_Item_Ziptie",
				"DSR_Item_Lighter",
				"DSR_Item_Tin_Container",
				"DSR_Item_Handwarmer",
				"DSR_Item_Canteen_Full",
				"DSR_Item_Waterbottle_Empty",
				"DSR_Item_Instant_Coffee"
			};
		};
	};  
	
	






	//Doctors
	class DSR_Zombie_Doctor_1 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Full",
				"DSR_Item_Bloodbag_Full",
				"DSR_Item_Handwarmer",
				"DSR_Item_Handwarmer",
				"DSR_Item_Painkillers",
				"DSR_Item_Painkillers",
				"DSR_Item_Vitamins",
				"DSR_Item_Vitamins",
				"DSR_Item_Syringe",
				"DSR_Item_Syringe",
				"DSR_Item_Morphine",
				"DSR_Item_Antibiotic",
				"DSR_Item_Antibiotic",
				"DSR_Item_Bandage",
				"DSR_Item_Bandage",
				"DSR_Item_Bandage"
			};
		};
	};  
	class DSR_Zombie_Doctor_2 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 3; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Painkillers",
				"DSR_Item_Painkillers",
				"DSR_Item_Vitamins",
				"DSR_Item_Vitamins",
				"DSR_Item_Syringe",
				"DSR_Item_Syringe",
				"DSR_Item_Antibiotic",
				"DSR_Item_Bandage",
				"DSR_Item_Bandage"
			};
		};
	};  
	class DSR_Zombie_Doctor_3 {
		AgroMode = "PASSIVE"; //agro mode (AGRESSIVE / NORMAL / PASSIVE)
		class Loot {
			MaxItems = 2; // Set this to 0 if you want to add all listed items
			MinItems = 0;
			Items[] = {
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Bloodbag_Empty",
				"DSR_Item_Handwarmer",
				"DSR_Item_Handwarmer",
				"DSR_Item_Painkillers",
				"DSR_Item_Vitamins",
				"DSR_Item_Syringe",
				"DSR_Item_Morphine",
				"DSR_Item_Antibiotic",
				"DSR_Item_Bandage",
				"DSR_Item_Bandage"
			};
		};
	};
};