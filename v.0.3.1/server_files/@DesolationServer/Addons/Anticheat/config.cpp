class CfgPatches
{
	class Anticheat {units[] = {};};
};

class Plugins
{
	class Anticheat
	{
		name = "Lystic Anticheat";
		desc = "Anticheat & Admin Tool for Redux By Lystic";
		version = 0.1;
		tag = "LYS";
	};
};

class CfgFunctions
{
	class LYS
	{
		class Server 
		{
			file = "Anticheat";
			isserver = 1;
			class initServer {};
		};
	};
};

class CfgCrates {
	class SupplyCrate_0 {
		DisplayName = "Empty Crate";
		CrateClass = "DSR_Crate_Airdrop_F";

		Items[] = {};
	};
	class SupplyCrate_1 {
		DisplayName = "Building Supplies";
		CrateClass = "DSR_Crate_Airdrop_F";

		Items[] = {
			{"DSR_Item_Scrap_Metal",20},
			{"DSR_Item_Logs", 30},
			{"DSR_Item_Hardware",25},
			{"DSR_Item_Plastic_Drum",1},
			{"DSR_Item_Tarp",3},
			{"DSR_Item_Lumber",50},
			{"DSR_Item_Plywood",10},
			{"DSR_Item_Padlock",1}
		};
	};
	class SupplyCrate_2 {
		DisplayName = "Food Supplies";
		CrateClass = "DSR_Crate_Airdrop_F";

		Items[] = {
			{"DSR_Item_Tuna_Opened",3},
			{"DSR_Item_MRE",3},
			{"DSR_Item_Beans_Opened",3},
			{"DSR_Item_Bacon_Opened",3},
			{"DSR_Item_Waterbottle_Full",5},
			{"DSR_Item_Spirit",5},
			{"DSR_Item_Franta",5},
			{"DSR_Item_Canteen_Full",2}
		};
	};
	class SupplyCrate_3 {
		DisplayName = "Medical Supplies";
		CrateClass = "DSR_Crate_Airdrop_F";

		Items[] = {
			{"DSR_Item_Splint",2},
			{"DSR_Item_Bandage",10},
			{"DSR_Item_Painkillers",5},
			{"DSR_Item_Bloodbag_Full",3},
			{"DSR_Item_Antibiotic",3},
			{"DSR_Item_Morphine",3}
		};
	};
};