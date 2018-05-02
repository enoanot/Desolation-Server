class CfgPatches
{
	class HeliCrashes {
		units[] = {};
	};
};

class Plugins
{
	class HeliCrashes
	{
		name = "Heli Crashes";
		desc = "Adds advanced heli crashes to server with customizable loot";
		version = 0.1;
		tag = "HLCR";
	};
};

class CfgFunctions
{
	class HLCR
	{
		class Server
		{
			file = "HeliCrashes\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Crashes {
			file = "HeliCrashes\Server\Crashes";
			isserver = 1;
			class spawnManager {};
			class spawnHeliCrash {};
			class initHeliCrashes {};
			class heliCrashAnim {};
		};
		class Server_CrashesLoot {
			file = "HeliCrashes\Server\Crashes\Loot";
			isserver = 1;
			class spawnCrashBodies {};
			class spawnCrashCrates {};
		};
	};
};



class CfgHeliCrashes {
	class Settings {
		MinTimeBetweenCrashes = 5;
		MaxTimeBetweenCrashes = 20;
		NumberOfCrashesToSpawn = 5;
		MaxSearchDistance = 5000;
	};
	class CrashTypes {
		class Military_0 {
			HeliClass = "DSR_UH1H_F";
			WreckClass = "DSR_Object_Wreck4";
			WreckSmoke = 1;
			SpawnAltitude = 600;
			SmokePos[] = {0,0,0};
			SmokeSize = 7;
			MaxZombieCount = 3;
			MinZombieCount = 2;
			Locations[] =
			{
				{4060.2971,2753.147},
				{3014.8438,12482.121},
				{7501.166,9649.7529},
				{10790.136,4316.1323}
			};
			
			class Loot {
				class LootSettings {
					class BodySettings {
						EnableBodies = "true";

						MaxMagAmountWithWeapon = 4;
						MinMagAmountWithWeapon = 1;
						
						MaxBulletCountInMagazine = 100; // % (Works only for magazines that spawn with weapons!)
						MinBulletCountInMagazine = 20;  // %
					};
					class CrateSettings {
						EnableCrates = "true";
					};
				};
				class Bodies {
					// There can be as many body classes for each heli crash as you want.
					class Body_0 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_BG_Guerilla3_1",
                			"U_OG_Guerilla1_1"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_TacVest_camo"
						};
						Backpacks[] = {
							"DSR_Coyote_Backpack",
							"DSR_Alice_Backpack"
						};
						Headgears[] = {
							"H_Booniehat_dgtl",
							"H_HelmetB_light"
						};
						Weapons[] = {
							"DSR_SGun_M500",
							"DSR_srifle_ENFIELD_F",
							"DSR_SMG_MP40",
							"SMG_01_F"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_ziptie",
							"DSR_item_Bandage",
							"DSR_Item_MRE",
							"DSR_Item_MRE",
							"DSR_Item_MRE",
							"DSR_Item_Spirit",
							"DSR_Item_Spirit",
							"DSR_Item_Spirit",
							"DSR_Item_Spirit"
						};
						Linkeditems[] = {
							"ItemMap",
							"ItemWatch"
						};
					};

					class Body_1 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_BG_Guerilla3_1",
                			"U_OG_Guerilla1_1"
                		};
						Vests[] ={
							"V_TacVest_blk"
						};
						Backpacks[] = {
							"DSR_Alice_Backpack"
						};
						Headgears[] = {
							"H_HelmetB_light"
						};
						Weapons[] = {
							"DSR_arifle_FNFAL_F",
							"DSR_srifle_cz550_f"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_ziptie",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_Item_MRE"
						};
						Linkeditems[] = {
							"ItemMap"
						};
					};

					class Body_3 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_BG_Guerilla3_1",
                			"U_OG_Guerilla1_1"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_TacVest_camo"
						};
						Backpacks[] = {
							"DSR_Coyote_Backpack",
							"DSR_Alice_Backpack"
						};
						Headgears[] = {
							"H_Booniehat_dgtl",
							"H_HelmetB_light"
						};
						Weapons[] = {
							"DSR_SMG_MP40",
							"SMG_01_F"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_Bandage",
							"DSR_Item_MRE"
						};
						Linkeditems[] = {
							"ItemWatch"
						};
					};
					class Body_4 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_BG_Guerilla3_1",
                			"U_OG_Guerilla1_1"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_TacVest_camo"
						};
						Backpacks[] = {
							"DSR_Coyote_Backpack",
							"DSR_Alice_Backpack"
						};
						Headgears[] = {
							"H_Booniehat_dgtl",
							"H_HelmetB_light"
						};
						Weapons[] = {
							"DSR_SMG_MP40",
							"SMG_01_F"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_Bandage",
							"DSR_Item_MRE"
						};
						Linkeditems[] = {
							"ItemWatch"
						};
					};
                };

				class Crates {
					// There can be as many crate classes for each heli crash as you want.
					class Crate_0 {
						CrateClass = "Box_NATO_Wps_F";

						Backpacks[] = {
							{"DSR_Coyote_Backpack",1},
							{"DSR_Assaultpack_Grey",1},
							{"DSR_Tactical_Blue",1},
							{"DSR_Rpg_Backpack",1},
						};
						Weapons[] = {
							{"DSR_srifle_ENFIELD_F",1},
							{"DSR_SGun_M500",1},
							{"hgun_pistol_01_f",2}
						};
						Items[] = {
							// Vests
							{"V_TacVest_blk",1},
							{"V_BandollierB_blk",2},

							// Uniforms
							{"U_BG_Guerilla3_1",2},
							{"U_OG_Guerilla1_1",2},

							// Headgears
							{"H_Booniehat_dgtl",2},
							{"H_HelmetB_light",1},

							// Items
							{"DSR_item_Bandage",5},
							{"DSR_Item_MRE",2},
							{"DSR_Item_Spirit",4},

							// Magazines
							{"10Rnd_303_Mag",5},
							{"6Rnd_12g_Slug",3},
							{"6Rnd_12g_Buck",2},
							{"10Rnd_9x21_Mag",5},

							// Linked
							{"ItemMap",1},
							{"ItemWatch",3},
							{"ItemRadio",1}
						};
					};
				};
			};
		};





		class Military_1 {
			HeliClass = "DSR_UH1H_F";
			WreckClass = "DSR_Object_Wreck4";
			WreckSmoke = 1;
			SpawnAltitude = 600;
			SmokePos[] = {0,0,0};
			SmokeSize = 7;
			MaxZombieCount = 3;
			MinZombieCount = 2;
			Locations[] =
			{
				{4060.2971,2753.147},
				{3014.8438,12482.121},
				{7501.166,9649.7529},
				{10790.136,4316.1323}
			};
			
			class Loot {
				class LootSettings {
					class BodySettings {
						EnableBodies = "true";

						MaxMagAmountWithWeapon = 4;
						MinMagAmountWithWeapon = 1;
						
						MaxBulletCountInMagazine = 100; // % (Works only for magazines that spawn with weapons!)
						MinBulletCountInMagazine = 20;  // %
					};
					class CrateSettings {
						EnableCrates = "false";
					};
				};
				class Bodies {
					// There can be as many body classes for each heli crash as you want.
					class Body_0 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_B_CombatUniform_mcam_vest",
							"U_B_CombatUniform_mcam_worn",
							"U_B_CombatUniform_mcam"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_TacVest_camo",
							"V_PlateCarrier1_blk"
						};
						Backpacks[] = {
							"DSR_Coyote_Backpack",
							"DSR_Alice_Backpack",
							"tacs_Backpack_AssaultExpanded_Black"
						};
						Headgears[] = {
							"H_Booniehat_dgtl",
							"H_HelmetB_light",
							"H_HelmetB_snakeskin"
						};
						Weapons[] = {
							"DSR_srifle_M110_F",
							"DSR_Arifle_M4_300"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_ziptie",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_Item_MRE",
							"DSR_Item_Spirit"
						};
						Linkeditems[] = {
							"ItemMap",
							"ItemGPS",
							"ItemWatch"
						};
					};

					class Body_1 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                			"U_B_CombatUniform_mcam_vest",
							"U_B_CombatUniform_mcam_worn",
							"U_B_CombatUniform_mcam"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_PlateCarrier1_blk"
						};
						Backpacks[] = {
							"DSR_Alice_Backpack",
							"tacs_Backpack_AssaultExpanded_Black"
						};
						Headgears[] = {
							"H_HelmetB_light",
							"H_HelmetB_snakeskin"
						};
						Weapons[] = {
							"DSR_arifle_FNFAL_F",
							"DSR_Arifle_M16A2"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_ziptie",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_Item_MRE"
						};
						Linkeditems[] = {
							"ItemMap"
						};
					};

					class Body_3 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
							"U_B_CombatUniform_mcam_vest",
							"U_B_CombatUniform_mcam_worn",
							"U_B_CombatUniform_mcam"
                		};
						Vests[] ={
							"V_TacVest_blk",
							"V_TacVest_camo"
						};
						Backpacks[] = {
							"DSR_Coyote_Backpack",
							"DSR_Alice_Backpack"
						};
						Headgears[] = {
							"H_Booniehat_dgtl",
							"H_HelmetB_light"
						};
						Weapons[] = {
							"DSR_SMG_MP40",
							"SMG_01_F"
						};
						Handguns[] = {
							"hgun_pistol_01_f",
							"hgun_acpc2_f"
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_item_Bandage",
							"DSR_Item_MRE",
							"DSR_Item_MRE",
							"DSR_Item_Spirit",
							"DSR_Item_Spirit"
						};
						Linkeditems[] = {
							"ItemWatch"
						};
					};
                };

				class Crates {
					// There can be as many crate classes for each heli crash as you want.
					class Crate_0 {
						CrateClass = "Box_NATO_Wps_F";

						Backpacks[] = {

						};
						Weapons[] = {

						};
						Items[] = {

						};
					};
				};
			};
		};





		class Medical_0 {
			HeliClass = "DSR_UH1H_F";
			WreckClass = "DSR_Object_Wreck4";
			WreckSmoke = 1;
			SpawnAltitude = 600;
			SmokePos[] = {0,0,0};
			SmokeSize = 7;
			MaxZombieCount = 3;
			MinZombieCount = 2;
			Locations[] =
			{
				{4060.2971,2753.147},
				{3014.8438,12482.121},
				{7501.166,9649.7529},
				{10790.136,4316.1323}
			};
			
			class Loot {
				class LootSettings {
					class BodySettings {
						EnableBodies = "false";

						MaxMagAmountWithWeapon = 4;
						MinMagAmountWithWeapon = 1;
						
						MaxBulletCountInMagazine = 100; // % (Works only for magazines that spawn with weapons!)
						MinBulletCountInMagazine = 20;  // %
					};
					class CrateSettings {
						EnableCrates = "true";
					};
				};
				class Bodies {
					// There can be as many body classes for each heli crash as you want.
					class Body_0 {
						UnitClass = "B_Soldier_F";

						// Multiple items means that random will get selected.
        				Uniforms[] = {
                		};
						Vests[] ={
						};
						Backpacks[] = {
						};
						Headgears[] = {
						};
						Weapons[] = {
						};
						Handguns[] = {
						};

						// All items and linked items are going to be added to body inventory.
						Items[] = {
						};
						Linkeditems[] = {
						};
					};
                };

				class Crates {
					// There can be as many crate classes for each heli crash as you want.
					class Crate_0 {
						CrateClass = "Box_NATO_Wps_F";

						Backpacks[] = {
							{"DSR_Alice_Backpack",2},
							{"tacs_Backpack_AssaultExpanded_Black",2}
						};
						Weapons[] = {

						};
						Items[] = {
							{"DSR_item_Bandage",15},
							{"DSR_Item_Bloodbag_Full",5},
							{"DSR_Item_MRE",7},
							{"DSR_Item_Spirit",10},
							{"DSR_Item_Painkillers",5}
						};
					};
				};
			};
		};
	};
};