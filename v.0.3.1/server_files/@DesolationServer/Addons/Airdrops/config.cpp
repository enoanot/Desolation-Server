class CfgPatches
{
	class Airdrops {
		units[] = {};
	};
};

class Plugins
{
	class Airdrops
	{
		name = "Airdrops";
		desc = "Adds airdrops to your server";
		version = 0.1;
		tag = "AIRD";
	};
};

class CfgFunctions
{
	class AIRD
	{
		class Server
		{
			file = "Airdrops\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Airdrops {
			file = "Airdrops\Server\Airdrops";
			isserver = 1;
			class addCrateItems {};
			class initAirdrops {};
			class crateAnim {};
			class spawnAirdrop {};
			class spawnCrate {};
			class spawnManager {};
		}
	};
};



class CfgAirdropSpawns {
	class Settings {
		MaxTimeBetweenDrops = 45; // In minutes
		MinTimeBetweenDrops = 20;
		NumberOfDropsToSpawn = 5;
	};
	class AirdropTypes {
		class MedicDrop_0 {
			Name = "Medical Drop";
			PlaneClass = "DSR_C130J_F";
			FlyingAltitude = 500;
			FlyingSpeed = 400;

			class Crates {
				// There can be as many crate classes for eachairdrop as you want.
				class Crate_0 {
					CrateClass = "DSR_Crate_Airdrop_F";
					MaxZombiesAroundCrate = 3;
					MinZombiesAroundCrate = 2;

					Weapons[] = {

					};
					Items[] = {
						{"DSR_item_Bandage",4},
						{"DSR_Item_Bloodbag_Full",2},
						{"DSR_Item_MRE",7},
						{"DSR_Item_Spirit",10},
						{"DSR_Item_Painkillers",3}
					};
					Backpacks[] = {
						{"DSR_Civil_Assault_Backpack",1}
					};
				};
				class Crate_1 {
					CrateClass = "DSR_Crate_Airdrop_F";
					MaxZombiesAroundCrate = 3;
					MinZombiesAroundCrate = 2;

					Weapons[] = {

					};
					Items[] = {
						{"DSR_item_Bandage",10},
						{"DSR_Item_Bloodbag_Full",6},
						{"DSR_Item_MRE",2},
						{"DSR_Item_Spirit",4},
						{"DSR_Item_Painkillers",5}
					};
					Backpacks[] = {
						{"tacs_Backpack_Carryall_DarkBlack",1}
					};
				};
			};
		};

		class AmmoDrop_0 {
			Name = "Ammunition Drop";
			PlaneClass = "DSR_C130J_F";
			FlyingAltitude = 500;
			FlyingSpeed = 400;

			class Crates {
				class Crate_0 {
					CrateClass = "DSR_Crate_Airdrop_F";
					MaxZombiesAroundCrate = 3;
					MinZombiesAroundCrate = 2;

					Weapons[] = {

					};
					Items[] = {
						{"7Rnd_308win_mag",3},
						{"6Rnd_12g_Buck",5},
						{"6Rnd_44_Mag",7},
						{"32Rnd_9x19mm_Mag",5},
						{"30Rnd_545x39_Mag_F",6},
						{"30Rnd_9x21_Mag",5},
						{"20Rnd_762x51_Mag",3}
					};
					Backpacks[] = {
						{"tacs_Backpack_Carryall_DarkBlack",1}
					};
				};
			};
		};

		class FoodDrop_0 {
			Name = "Food Supplies Drop";
			PlaneClass = "DSR_C130J_F";
			FlyingAltitude = 500;
			FlyingSpeed = 400;

			class Crates {
				class Crate_0 {
					CrateClass = "DSR_Crate_Airdrop_F";
					MaxZombiesAroundCrate = 3;
					MinZombiesAroundCrate = 2;

					Weapons[] = {

					};
					Items[] = {
						{"DSR_Item_Beans",5},
						{"DSR_Item_Bacon",5},
						{"DSR_Item_Rice",3},
						{"DSR_Item_Waterbottle_Full",10},
						{"DSR_Item_Spirit",5},
						{"DSR_Item_Franta",5},
						{"DSR_Item_Can_Opener",2},
						{"DSR_Item_Vitamins",3}
					};
					Backpacks[] = {
						{"tacs_Backpack_Carryall_DarkBlack",1}
					};
				};
			};
		};
		class BuildingDrop_0 {
			Name = "Building Supplies Drop";
			PlaneClass = "DSR_C130J_F";
			FlyingAltitude = 500;
			FlyingSpeed = 400;

			class Crates {
				class Crate_0 {
					CrateClass = "DSR_Crate_Airdrop_F";
					MaxZombiesAroundCrate = 3;
					MinZombiesAroundCrate = 2;

					Weapons[] = {
						{"DSR_Melee_Axe",2},
						{"DSR_Melee_Pickaxe",1}
					};
					Items[] = {
						{"DSR_Item_Bricks",3},
						{"DSR_Item_Toolbox",1},
						{"DSR_Item_Saw",1},
						{"DSR_Item_Hardware",5},
						{"DSR_Item_Scrap_Metal",3},
						{"DSR_Item_Padlock",1},
						{"DSR_Item_Tarp",2},
						{"DSR_Item_Duct_Tape",5},
						{"DSR_Item_Fabric_Scraps",3},
						{"DSR_Item_Electrical_Comp",2}
					};
					Backpacks[] = {
						{"tacs_Backpack_Carryall_DarkBlack",2}
					};
				};
			};
		};
	};
};