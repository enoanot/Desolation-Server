class CfgPatches
{
	class Desolation {units[] = {};};
};
class Plugins
{
	class Desolation
	{
		name = "Desolation Redux";
		desc = "ArmA 3 Zombie Survival Mod";
		version = 0.1;
		tag = "DS";
	};
};


class CfgPluginActions {
	class Padlocks {
        text = "Padlocks";
        condition = "_player distance _cursor < 8 && !(_cursor isKindOf 'allVehicles')";
		class Actions {
            class ResetLock {
				text = "Reset lock";
				condition = "[_cursor] call DS_fnc_isResettable";
				action = "createDialog 'DS_Padlock'; call DS_fnc_initReset;";
			};
			class Lock {
                text = "Lock";
                condition = "[_cursor] call DS_fnc_isLockable";
				action = "createDialog 'DS_Padlock'; call DS_fnc_initLock;";
            };
			class Unlock {
				text = "Unlock";
				condition = "[_cursor] call DS_fnc_isUnlockable";
				action = "createDialog 'DS_Padlock'; call DS_fnc_initUnlock;";
			};
		};
	};
};

class CfgPluginEvents {
	class PlayerEvents {
		overrides = 1;
		class Events {
			class DS_InvTake {
				type = "Take";
				function = "DS_fnc_InvTake";
			};
			class DS_InvPut {
				type = "Put";
				function = "DS_fnc_InvPut";
			};
			class DS_AnimChanged {
				type = "AnimChanged";
				function = "DS_fnc_AnimChanged";
			};
			class DS_InventoryClosed {
				type = "InventoryClosed";
				function = "DS_fnc_InventoryClosed";
			};
			class DS_InventoryOpened {
				type = "InventoryOpened";
				function = "DS_fnc_InventoryOpened";
			};
			class DS_HandleDamage {
				type = "HandleDamage";
				function = "DS_fnc_HandleDamage";
			};
			class DS_Killed {
				type = "Killed";
				function = "DS_fnc_Killed";
			};
			class DS_FiredNear {
				type = "FiredNear";
				function = "DS_fnc_FiredNear";
			};
		};
	};
	class MissionEventsServer {
		overrides = 0;
		class Events {
			
		};
	};
	class MissionEventsClient {
		overrides = 1;
		class Events {
			class DS_Draw3D {
				type = "Draw3D";
				function = "DS_fnc_Draw3D";
			};
		};
	};
};

class CfgPluginKeybinds 
{
	class OpenJournalIndex 
	{
		displayName = "Open Building Journal";
		tooltip = "Open the journal containing buildables";
		tag = "DS";
		variable = "OpenBuildingJournal";
		defaultKeys[] = {{0x24,0}};
		code = "call DS_fnc_openJournal;";
	};
	class ToggleLight 
	{
		displayName = "Toggle Light";
		tooltip = "Turn camping light in hands on/off";
		tag = "DS";
		variable = "ToggleLight";
		defaultKeys[] = {{0x26,0}};
		code = "call DS_fnc_toggleLight;";
	};
};

class CfgFunctions
{
	class DS
	{
		class Client_Electric_Batteries {
			file = "Desolation\Client\Electric\Batteries";
			isclient = 1;
			class isBatteryInUse {};
			class usePowerCell {};
		};
		class Client_Electric_NVGoggles {
			file = "Desolation\Client\Electric\NVGoggles";
			isclient = 1;
			class initNVGs {};
			class canPowerNVG {};
		};
		class Client_Hands {
			file = "Desolation\Client\Hands";
			isclient = 1;
			class initHoldables {};
			class toggleLight {};
			class takeIntoHand {};
		};
		class Client_Progression {
			file = "Desolation\Client\Progression";
			isclient = 1;
			class addPoints {};
		};
		class Client_PluginEvents {
			file = "Desolation\Client\PluginEvents";
			isclient = 1;
			class Draw3D {};
			class InvTake {};
			class InvPut {};
			class AnimChanged {};
			class InventoryClosed {};
			class InventoryOpened {};
			class Killed {};
			class HandleDamage {};
			class FiredNear {};
		};
		class Client_Weapon {
			file = "Desolation\Client\Weapon";
			isclient = 1;
			class swingEvent {};
			class registerMeleeAction {};
		};
		class Client_Weapon_Events {
			file = "Desolation\Client\Weapon\Events";
			isclient = 1;
			class onSwing {};
		};
		class Client_Weapon_Network {
			file = "Desolation\Client\Weapon\Network";
			isclient = 1;
			class onMeleeHit {};
		};
		class Client_Crafting {
			file = "Desolation\Client\Crafting";
			isclient = 1;
			class onCraftClick {};
			class craftBike {};
		};
		class Client_Building_Events {
			file = "Desolation\Client\Building\Events";
			isclient = 1;
			class onBuildClick {};
			class onBuildableLift {};
			class onPlacableLift {};
			class onCrateFilled {};
		};
		class Client_Building_PreviewHandling {
			file = "Desolation\Client\Building\PreviewHandling";
			isclient = 1;
			class liftBuildable {};
			class registerDropped {};
		};
		class Client_Building {
			file = "Desolation\Client\Building";
			isclient = 1;
			class initBuilding {};
		};
		class Client_Building_Locking {
			file = "Desolation\Client\Building\Locking";
			isclient = 1;
            class initLock {};
			class initReset {};
            class initUnlock {};
            class lock {};
			class reset {};
			class unlock {};
		};
		class Client_Building_Locking_Checks {
			file = "Desolation\Client\Building\Locking\Checks";
			isclient = 1;
			class isBuildingOwner {};
            class isResettable {};
			class isUnlockable {};
            class isLockable {};
		};
		class Client_Spawning {
			file = "Desolation\Client\Spawning";
			isclient = 1;
			class findSpawnPosition {};
			class onRegionSelected {};
			class freshSpawn {};
			class finishSpawn {};
			class showRegionNotification {};
		};
		class Client_Events {
			file = "Desolation\Client\Events";
			isclient = 1;
			class registerPlayer {};
			class registerNewPlayer {};
		};
		class Client_Functions {
			file = "Desolation\Client\Functions";
			isclient = 1;
			class infoText {};
			class notWhitelisted {};
			class crashSmoke {};
			class receiveTransmition {};
			class calcGrayscale {};
			class getCfgValue {};
			class handleCallback {};
			class genRandMapPos {};
		};
		class Client_Actions_System {
			file = "Desolation\Client\Actions\System";
			isclient = 1;
			class toggleActions {};
			class draw3DActions {};
			class get3DPartName {};
			class calculate3DActions {};
			class do3DAction {};
		};
		class Client_Actions_Items {
			file = "Desolation\Client\Actions\Items";
			isclient = 1;
			class doAction {};
			class convertAssign {};
			class convertItem {};
			class doActionTarget {};
			class combineMags {};
			class useItem {};
			class useItemTarget {};
			class drink {};
			class eat {};
			class fillblood {};
			class fillhcarbon {};
			class fillwater {};
			class lightfire {};
			class useantibiotic {};
			class usebandage {};
			class useblood {};
			class usedefib {};
			class usedisinfectant {};
			class usehandwarmer {};
			class usepainkillers {};
			class usevitamins {};
			class usewpt {};
			class usesplint {};
			class useCure {};
			class useImmune {};
			class useZiptie {};
			class openZiptie {};
			class openCan {};
			class cutWire {};
		};
		class Client_Interface {
			file = "Desolation\Client\Interface";
			isclient = 1;
			class onEscape {};
			class initHud {};
			class openJournal {};
		};
		class Client {
			file = "Desolation\Client";
			isclient = 1;
			class initClient {};
		};
		class Client_Status {
			file = "Desolation\Client\Status";
			isclient = 1;
			class initHealthSys {};
			class onBleedTick {};
			class onBloodReceive {};
			class onDrink {};
			class onEat {};
			class onEffectTick {};
			class onInfectionTick {};
			class onHungerTick {};
			class onThirstTick {};
			class onUpdateTick {};
			class onTick {};
		};
		class Client_Medical {
			file = "Desolation\Client\Medical";
			isclient = 1;
			class knockOut {};
			class stopBleeding {};
		};
		class Client_Medical_Bleeding {
			file = "Desolation\Client\Medical\Bleeding";
			isclient = 1;
			class createBleedSource {};
			class initBleedingSystem {};
			class onHitPartReceived {};
			class removeAllBleedSources {};
			class updateBleedSource {};
		};
		class Client_Inventory {
			file = "Desolation\Client\Inventory";
			isclient = 1;
			class closeButtons {};
			class saveData {};
			class initInvHandler {};
			class itemClick {};
			class setupInvEvents {};
		};
		class Server_Events {
			file = "Desolation\Server\Events";
			isserver = 1;
			class onPlayerKilled {};
			class handleDisconnect {};
			class playerDisconnected {};
		};
		class Server_Players {
			file = "Desolation\Server\Players";
			isserver = 1;
			class requestLoadSpawn {};
			class requestFreshSpawn {};
			class requestSpawn {};
			class requestSave {};
			class setupLoadout {};
		};
		class Server_Audio {
			file = "Desolation\Server\Audio";
			isserver = 1;
			class playOverRadio {};
		};
		class Server_Vehicles {
			file = "Desolation\Server\Objects";
			isserver = 1;
			class spawnObjects {};
			class simManager {};
		};
		class Server_Crafting {
			file = "Desolation\Server\Crafting";
			isserver = 1;
			class initCraftingSys {};
			class createBike {};
		};
		class Server_Building_Events {
			file = "Desolation\Server\Building\Events";
			isserver = 1;
			class requestBuild {};
			class requestItemPlace {};
			class finishBuild {};
		};
		class Server_Building_PreviewHandling {
			file = "Desolation\Server\Building\PreviewHandling";
			isserver = 1;
			class buildableDropped {};
			class buildableLifted {};
		};
		class Server_Building {
			file = "Desolation\Server\Building";
			isserver = 1;
			class requestOwned {};
			class initBuildingSys {};
		};
		class Server_Locking {
			file = "Desolation\Server\Locking";
			isserver = 1;
			class checkServerLock {};
			class initServerLock {};
		};
		class Server {
			file = "Desolation\Server";
			isserver = 1;
			class initServer {};
		};
	};
};



class CfgVehicleSpawns {
	class Buildings {
		class Land_GarageShelter_01_F {
			locations[] = {{2.60669,0.034668,-1.25005}
			};
			directions[] = {180};
		};
		class Land_House_Big_03_F {
			locations[] = {{6.77026,-3.16113,-3.38936}
			};
			directions[] = {90.9637};
		};
		class Land_House_Small_04_F {
			locations[] = {{-1.33447,-5.72168,-1.05337}
			};
			directions[] = {251.81};
		};
		class Land_House_Small_05_F {
			locations[] = {{-2.72168,-1.87256,-1.23374}
			};
			directions[] = {261.001};
		};
		class Land_School_01_F {
			locations[] = {{0.00146484,-4.24023,-1.57045},{6.99841,-3.93652,-1.57045},{13.7524,-3.68555,-1.61162},{-13.9556,-3.69434,-1.57045}
			};
			directions[] = {124.82,124.82,103.163,258.837};
		};
		class Land_House_Small_06_F {
			locations[] = {{3.64514,3.64111,-1.39313}
			};
			directions[] = {74.936};
		};
		class Land_Shed_06_F {
			locations[] = {{2.33594,-1.5708,-1.215},{0.574951,3.30811,-1.215}
			};
			directions[] = {240.455,305.884};
		};
		class Land_Shed_07_F {
			locations[] = {{3.24463,0.289063,-1.19334}
			};
			directions[] = {272.99};
		};
		class Land_Addon_03_F {
			locations[] = {{-2.08667,2.85498,-1.37288}
			};
			directions[] = {0};
		};
		class Land_Addon_04_F {
			locations[] = {{2.33545,5.64941,-3.09596}
			};
			directions[] = {81.9683};
		};
		class Land_FuelStation_01_workshop_F {
			locations[] = {{-3.58813,-1.25781,-2.53379},{2.52588,-1.18896,-2.53379}
			};
			directions[] = {143.066,180.008};
		};
		class Land_FuelStation_01_roof_F {
			locations[] = {{0.929199,-4.22705,-2.96874},{0.552246,4.25635,-2.8793}
			};
			directions[] = {88.727,272.412};
		};
		class Land_FuelStation_02_workshop_F {
			locations[] = {{-2.76379,2.68311,-1.36458}
			};
			directions[] = {178.493};
		};
		class Land_MetalShelter_02_F {
			locations[] = {{-3.0094,6.31982,-2.53849},{-7.5896,4.13184,-2.58269}
			};
			directions[] = {359.991,178.967};
		};
		class Land_FuelStation_02_roof_F {
			locations[] = {{-6.66699,2.45654,-2.40688},{-5.28308,6.86328,-2.44445}
			};
			directions[] = {269.099,91.9652};
		};
		class Land_MetalShelter_01_F {
			locations[] = {{4.56799,-5.29004,-1.56836},{4.73572,-2.22607,-1.56836},{4.77979,1.12451,-1.56836},{4.92883,4.04102,-1.56836}
			};
			directions[] = {87.6316,48.0039,113.241,270.58};
		};
		class Land_Hotel_01_F {
			locations[] = {{-7.40234,-1.85645,-5.50127}
			};
			directions[] = {0};
		};
		class Land_MultistoryBuilding_01_F {
			locations[] = {{13.4235,-11.8364,-20.8827},{12.6835,2.3208,-20.9196},{12.5496,-3.13721,-20.9196},{12.3575,-7.44141,-20.9196}
			};
			directions[] = {90.781,129.967,90.733,90.733};
		};
		class Land_MultistoryBuilding_03_F {
			locations[] = {{-8.17847,1.75049,-25.8977},{-9.08691,1.72754,-25.8977}
			};
			directions[] = {352.662,352.662};
		};
		class Land_Shop_City_03_F {
			locations[] = {{5.67883,-2.56006,-5.107},{4.36108,-0.0917969,-5.10371},{0.976074,5.04053,-5.10353},{1.17896,-5.74658,-5.10401}
			};
			directions[] = {235.877,182.882,176.143,182.882};
		};
		class Land_Shop_City_02_F {
			locations[] = {{1.24805,-10.1792,-4.38337},{2.22461,-10.3315,-4.42472},{3.02271,-10.3169,-4.46243},{3.79883,-10.2437,-4.41579}
			};
			directions[] = {105.568,110.874,109.866,113.647};
		};
		class Land_WoodenShelter_01_F {
			locations[] = {{-0.422852,0.0537109,-1.11249}
			};
			directions[] = {176.774};
		};
		class Land_Shop_City_01_F {
			locations[] = {{-2.70569,-3.08887,-5.17591}
			};
			directions[] = {89.0095};
		};
		class Land_Shop_City_06_F {
			locations[] = {{-6.39063,0.680664,-4.38325}
			};
			directions[] = {160.655};
		};
		class Land_MultistoryBuilding_04_F {
			locations[] = {{-13.0975,6.24316,-36.7282},{-13.3356,-0.482422,-36.7282}
			};
			directions[] = {298.955,298.955};
		};
		class Land_Shop_City_05_F {
			locations[] = {{-9.073,-36.6758,-7.46471},{1.22034,-11.5459,-7.46157}
			};
			directions[] = {252.344,183.441};
		};
		class Land_Shop_City_07_F {
			locations[] = {{0.416138,2.33691,-3.30909},{0.440308,5.61621,-3.30862}
			};
			directions[] = {1.38711,1.38811};
		};
		class Land_Warehouse_03_F {
			locations[] = {{8.05029,-0.370117,-2.40732}
			};
			directions[] = {359.972};
		};
		class Land_Warehouse_02_F {
			locations[] = {{0.86377,-17.8154,-5.21577},{11.4291,-17.7988,-5.21577}
			};
			directions[] = {180.796,180.796};
		};
		class Land_WarehouseShelter_01_F {
			locations[] = {{3.39453,-4.16992,-2.85872},{-3.43152,-4.43555,-2.85872}
			};
			directions[] = {181.698,360};
		};
		class Land_SCF_01_crystallizer_F {
			locations[] = {{-5.53345,2.90527,-9.01621},{5.87866,2.62793,-9.01621}
			};
			directions[] = {269.076,90.0837};
		};
		class Land_SCF_01_shed_F {
			locations[] = {{6.4209,-14.1689,-7.21736},{-6.74841,9.47168,-7.21736},{-1.7666,-0.806641,-7.22136},{0.930054,-2.94141,-7.22136}
			};
			directions[] = {0.012765,181.84,26.8011,206.934};
		};
		class Land_SM_01_shed_F {
			locations[] = {{10.884,6.22168,-1.46795},{-0.851929,5.87891,-1.46795}
			};
			directions[] = {268.495,268.495};
		};
		class Land_SM_01_shed_unfinished_F {
			locations[] = {{8.71277,2.2627,-1.51584}
			};
			directions[] = {285.81};
		};
		class Land_SM_01_shelter_wide_F {
			locations[] = {{5.31702,-8.24023,-3.57053},{-5.41321,4.35547,-3.57053}
			};
			directions[] = {1.90951,181.259};
		};
		class Land_SM_01_shelter_narrow_F {
			locations[] = {{0.432373,-7.63574,-2.1163},{0.480225,0.078125,-2.1163}
			};
			directions[] = {104.319,359.576};
		};
		class Land_Airport_01_terminal_F {
			locations[] = {{-1.7406,6.71484,-4.2641},{1.72998,7.27832,-4.26409},{5.48486,8.80859,-4.24886}
			};
			directions[] = {0.802014,180.148,275.272};
		};
		class Land_HelipadEmpty_F {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Land_HelipadCircle_F {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Land_HelipadCivil_F {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Land_HelipadRescue_F {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Land_HelipadSquare_F {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Land_Airport_01_hangar_F {
			locations[] = {{8.36755,7.4707,-2.70845},{-7.8866,6.66309,-2.70776}
			};
			directions[] = {194.775,160.588};
		};
		class Land_Airport_02_hangar_right_F {
			locations[] = {{-3.37866,-5.04492,-7.71338}
			};
			directions[] = {186.313};
		};
		class Land_Airport_02_hangar_left_F {
			locations[] = {{7.65942,-8.44434,-7.72021}
			};
			directions[] = {180.777};
		};
		class Land_Airport_02_terminal_F {
			locations[] = {{-2.01501,9.99609,-1.49814}
			};
			directions[] = {300.168};
		};
		class Land_Cargo_Tower_V4_F {
			locations[] = {{3.18994,0.212891,-12.8885}
			};
			directions[] = {251.457};
		};
		class Land_PierWooden_01_ladder_F {
			locations[] = {{-0.116943,5.49609,17.7449}
			};
			directions[] = {0};
		};
		class Land_PierWooden_01_dock_F {
			locations[] = {{-0.219727,1.1084,16.9505}
			};
			directions[] = {0};
		};
		class Land_PierWooden_02_ladder_F {
			locations[] = {{0.832275,4.97949,18.4322}
			};
			directions[] = {65.557};
		};
		class Land_PierWooden_02_hut_F {
			locations[] = {{-7.90356,-1.03809,17.3928}
			};
			directions[] = {320.569};
		};
		class Land_PierWooden_03_F {
			locations[] = {
				{-0.210693,13.5029,18.7532}
			};
			directions[] = {322.913};
		};
		class Land_PierWooden_02_barrel_F {
			locations[] = {
				{0.31543,1.93018,21.1919}
			};
			directions[] = {-94.5725};
		};
		class Land_PierConcrete_01_4m_ladders_F {
			locations[] = {
				{7.16699,-0.768555,10.8084}
			};
			directions[] = {-179.47};
		};
	};
	class Vehicles {
		class C_Truck_02_box_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_SM_01_shelter_wide_F {};
				class Land_SCF_01_shed_F {};
				class Land_SCF_01_crystallizer_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
			};
		};
		class C_Truck_02_covered_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_SM_01_shelter_wide_F {};
				class Land_SM_01_shed_unfinished_F {};
				class Land_SM_01_shed_F {};
				class Land_SCF_01_shed_F {};
				class Land_SCF_01_crystallizer_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_i_Shed_Ind_F {};
			};
		};
		class C_Truck_02_transport_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_SM_01_shelter_wide_F {};
				class Land_SM_01_shed_unfinished_F {};
				class Land_SM_01_shed_F {};
				class Land_SCF_01_shed_F {};
				class Land_SCF_01_crystallizer_F {};
				class Land_WarehouseShelter_01_F {};
				class Land_Warehouse_02_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_i_Shed_Ind_F {};
				
			};
		};
		class C_Truck_02_fuel_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_SM_01_shelter_wide_F {};
				class Land_SCF_01_shed_F {};
				class Land_SCF_01_crystallizer_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_i_Shed_Ind_F {};
				
			};
		};
		class C_Van_01_box_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_WarehouseShelter_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
			};
		};
		class C_Van_01_transport_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_WarehouseShelter_01_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_02_roof_F {};
			};
		};
		class C_Van_01_fuel_F {
			class Spawns {
				class Land_SM_01_shelter_narrow_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_01_roof_F {};
			};
		};
		class B_LSV_01_unarmed_F {
			class Spawns {
				class Land_Cargo_Tower_V4_F {};
			};
		};
		class DSR_Hatchback_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class DSR_Hatchback_Black_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class DSR_Hatchback_Blue_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class DSR_Hatchback_Green_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class DSR_Hatchback_Silver_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_Offroad_02_unarmed_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_SUV_01_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_Hatchback_01_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class DSR_SUV_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_SM_01_shelter_narrow_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_Offroad_01_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_SM_01_shelter_narrow_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_Hatchback_01_sport_F {
			class Spawns {
				class Land_Airport_01_terminal_F {};
				class Land_MultistoryBuilding_01_F {};
				class Land_FuelStation_02_roof_F {};
				class Land_FuelStation_02_workshop_F {};
				class Land_FuelStation_01_roof_F {};
				class Land_FuelStation_01_workshop_F {};
				class Land_House_Big_03_F {};
				class Land_GarageShelter_01_F {};
			};
		};
		class C_Quadbike_01_F {
			class Spawns {
				class Land_Shed_07_F {};
			};
		};
		class DSR_Bike_White_F {
			class Spawns {
				class Land_Airport_02_terminal_F {};
				class Land_Warehouse_03_F {};
				class Land_Shop_City_07_F {};
				class Land_Shop_City_05_F {};
				class Land_MultistoryBuilding_04_F {};
				class Land_Shop_City_06_F {};
				class Land_Shop_City_01_F {};
				class Land_Shop_City_02_F {};
				class Land_Shop_City_03_F {};
				class Land_MultistoryBuilding_03_F {};
				class Land_Hotel_01_F {};
				class Land_Addon_04_F {};
				class Land_Addon_03_F {};
				class Land_House_Small_04_F {};
				class Land_House_Small_05_F {};
				class Land_School_01_F {};
				class Land_House_Small_06_F {};
			};
		};

		class DSR_Bike_Green_F {
			class Spawns {
				class Land_Airport_02_terminal_F {};
				class Land_Warehouse_03_F {};
				class Land_Shop_City_07_F {};
				class Land_Shop_City_05_F {};
				class Land_MultistoryBuilding_04_F {};
				class Land_Shop_City_06_F {};
				class Land_Shop_City_01_F {};
				class Land_Shop_City_02_F {};
				class Land_Shop_City_03_F {};
				class Land_MultistoryBuilding_03_F {};
				class Land_Hotel_01_F {};
				class Land_Addon_04_F {};
				class Land_Addon_03_F {};
				class Land_House_Small_04_F {};
				class Land_House_Small_05_F {};
				class Land_School_01_F {};
				class Land_House_Small_06_F {};
			};
		};
		class C_Plane_Civil_01_F {
			class Spawns {
				class Land_Airport_02_hangar_left_F {};
				class Land_Airport_02_hangar_right_F {};
				class Land_Airport_01_hangar_F {};
			};
		};
		class C_Plane_Civil_01_racing_F {
			class Spawns {
				class Land_Airport_02_hangar_left_F {};
				class Land_Airport_02_hangar_right_F {};
				class Land_Airport_01_hangar_F {};
			};
		};
		class DSR_AN2_F {
			class Spawns {
				class Land_Airport_02_hangar_left_F {};
				class Land_Airport_02_hangar_right_F {};
				class Land_Airport_01_hangar_F {};
			};
		};
		class C_Heli_Light_01_civil_F {
			class Spawns {
				class Land_HelipadCircle_F { };
				class Land_HelipadCivil_F { };
				class Land_HelipadRescue_F { };
				class Land_HelipadSquare_F { };
				class Land_HelipadEmpty_F { };
			};
		};
		class DSR_UH1H_F {
			class Spawns {
				class Land_HelipadCircle_F { };
				class Land_HelipadCivil_F { };
				class Land_HelipadRescue_F { };
				class Land_HelipadSquare_F { };
				class Land_HelipadEmpty_F { };
			};
		};
		class DSR_UH1H_camo_F {
			class Spawns {
				class Land_HelipadCircle_F { };
				class Land_HelipadCivil_F { };
				class Land_HelipadRescue_F { };
				class Land_HelipadSquare_F { };
				class Land_HelipadEmpty_F { };
			};
		};
		class DSR_UH1H_tka_F {
			class Spawns {
				class Land_HelipadCircle_F { };
				class Land_HelipadCivil_F { };
				class Land_HelipadRescue_F { };
				class Land_HelipadSquare_F { };
				class Land_HelipadEmpty_F { };
			};
		};
		class DSR_FishingBoat_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class DSR_Dingy_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class DSR_Raft_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class C_Boat_Civil_01_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class C_Boat_Civil_01_police_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class C_Rubberboat {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class C_Boat_Transport_02_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class C_Scooter_Transport_01_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class O_Lifeboat {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
		class I_Boat_Transport_01_F {
			class Spawns {
				class Land_PierWooden_02_barrel_F {};
				class Land_PierConcrete_01_4m_ladders_F {};
				class Land_PierWooden_01_ladder_F {};
				class Land_PierWooden_02_ladder_F {};
				class Land_PierWooden_02_hut_F {};
				class Land_PierWooden_03_F {};
				class Land_PierWooden_01_dock_F {};
			};
		};
	};
};

class CfgBuildables {
    class Houses {
		condition = "true"; 
		preview = "\dsr_ui\Assets\object_previews\preview_house_lv1.paa";  
		name = "Type 1 Houses"; 
		class Buildables {
			class DSR_Object_House_Lv1 {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Lumber",30},
					{"DSR_Item_Plywood",7},
					{"DSR_Item_Hardware",5},
					{"DSR_Item_Logs",15}
				};
				name = "Lvl 1 House V1";
				model = "DSR_Object_House_Lv1";
				crateObject = "DSR_Object_House_Lv1_Preview2";
				description = "The small shack is small... and a shack... a good starting house for losers.";
				preview = "\dsr_ui\Assets\object_previews\preview_house_lv1.paa";
				condition = "true";
			};
			class DSR_Object_House_Lv1_2 {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Tarp",1},
					{"DSR_Item_Bricks",3},
					{"DSR_Item_Lumber",30},
					{"DSR_Item_Plywood",7},
					{"DSR_Item_Hardware",5},
					{"DSR_Item_Logs",15}
				};
				name = "Lvl 1 House V2";
				model = "DSR_Object_House_Lv1_2";
				crateObject = "DSR_Object_House_Lv1_2_Preview2";
				description = "The small shack is small... and a shack... a good starting house for losers.";
				preview = "\dsr_ui\Assets\object_previews\preview_house_lv1_2.paa";
				condition = "true";
			};
			class DSR_Object_House_Lv2 {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Lumber",60},
					{"DSR_Item_Plywood",14},
					{"DSR_Item_Hardware",10},
					{"DSR_Item_Logs",45}
				};
				name = "Lvl 2 House V1";
				model = "DSR_Object_House_Lv2";
				crateObject = "DSR_Object_House_Lv2_Preview2";
				description = "Large wood shack.";
				preview = "\dsr_ui\Assets\object_previews\preview_house_lv2.paa";
				condition = "(player getVariable ['PVAR_DS_Progression_Building_Level',0]) > 0";
			};
			class DSR_Object_House_Lv3 {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Lumber",120},
					{"DSR_Item_Plywood",34},
					{"DSR_Item_Hardware",20},
					{"DSR_Item_Scrap_Metal",2},
					{"DSR_Item_Logs",85}
				};
				name = "Lvl 3 House V1";
				model = "DSR_Object_House_Lv3";
				crateObject = "DSR_Object_House_Lv3_Preview2";
				description = "A small Wood Cabin.";
				preview = "\dsr_ui\Assets\object_previews\preview_house_lv3.paa";
				condition = "(player getVariable ['PVAR_DS_Progression_Building_Level',0]) > 1";
			};
		};
	};
	class Stockade {
		condition = "true"; 
		preview = "\dsr_ui\Assets\object_previews\preview_stockade_rampart.paa";  
		name = "Stockade Items";  
		class Buildables {
			class DSR_Object_Stockade_Wall {
				parts[] = {
					{"DSR_Item_Lumber",23},
					{"DSR_Item_Hardware",4}
				};
				name = "Stockade Wall";
				model = "DSR_Object_Stockade_Wall";
				crateObject = "DSR_Object_Stockade_Wall_Preview2";
				description = "Basic stockade wall piece";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_wall.paa";
				condition = "true";
			};
			class DSR_Object_Stockade_Wall_Window {
				parts[] = {
					{"DSR_Item_Lumber",23},
					{"DSR_Item_Hardware",6},
					{"DSR_Item_Scrap_Metal",1}
				};
				name = "Stockade Wall (Window)";
				model = "DSR_Object_Stockade_Wall_Window";
				crateObject = "DSR_Object_Stockade_Wall_Window_Preview2";
				description = "Basic stockade wall piece";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_window.paa";
				condition = "true";
			};
			class DSR_Object_Stockade_Rampart {
				parts[] = {
					{"DSR_Item_Lumber",45},
					{"DSR_Item_Hardware",6}
				};
				name = "Stockade Wall (Ramp)";
				model = "DSR_Object_Stockade_Rampart";
				crateObject = "DSR_Object_Stockade_Rampart_Preview2";
				description = "Stockade Wall with Rampart and Ramp";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_rampart.paa";
				condition = "true";
			};
			class DSR_Object_Stockade_Rampart_2 {
				parts[] = {
					{"DSR_Item_Lumber",38},
					{"DSR_Item_Hardware",5}
				};
				name = "Stockade Wall (Walkway)";
				model = "DSR_Object_Stockade_Rampart_2";
				crateObject = "DSR_Object_Stockade_Rampart_2_Preview2";
				description = "Stockade Wall with Rampart";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_rampart_2.paa";
				condition = "true";
			};
			class DSR_Object_Stockade_Gate {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Lumber",30},
					{"DSR_Item_Hardware",4},
					{"DSR_Item_Scrap_Metal",2},
					{"DSR_Item_Logs",2}
				};
				name = "Stockade Gate";
				model = "DSR_Object_Stockade_Gate";
				crateObject = "DSR_Object_Stockade_Gate_Preview2";
				description = "Stockade Wall with Rampart";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_gate.paa";
				condition = "true";
			};
			class DSR_Object_Stockade_Tower {
				parts[] = {
					{"DSR_Item_Lumber",40},
					{"DSR_Item_Hardware",10},
					{"DSR_Item_Scrap_Metal",4},
					{"DSR_Item_Logs",10}
				};
				name = "Stockade Guard Tower";
				model = "DSR_Object_Stockade_Tower";
				crateObject = "DSR_Object_Stockade_Tower_Preview2";
				description = "Stockade Guard Tower";
				preview = "\dsr_ui\Assets\object_previews\preview_stockade_tower.paa";
				condition = "true";
			};
		};
	};
	class Misc {
		condition = "true"; 
		preview = "\dsr_ui\Assets\object_previews\preview_water_catch.paa";  
		name = "Miscellaneous";  
		class Buildables {
			
			class DSR_Object_Storage_Small {
				parts[] = {
					{"DSR_Item_Lumber",4},
					{"DSR_Item_Hardware",1},
					{"DSR_Item_Scrap_Metal",1}
				};
				name = "Small Crate";
				model = "DSR_Object_Storage_Small";
				description = "A small storage container";
				preview = "\dsr_ui\Assets\object_previews\preview_storage_small.paa";
				crateObject = "DSR_Object_Storage_Small_Preview2";
				condition = "true";
			};
			class DSR_Object_Storage_Large {
				parts[] = {
					{"DSR_Item_Lumber",6},
					{"DSR_Item_Hardware",2},
					{"DSR_Item_Scrap_Metal",2}
				};
				name = "Large Crate";
				model = "DSR_Object_Storage_Large";
				description = "A large storage container";
				preview = "\dsr_ui\Assets\object_previews\preview_storage_large.paa";
				crateObject = "DSR_Object_Storage_Large_Preview2";
				condition = "true";
			};
			class Land_FirePlace_F {
				parts[] = {
					{"DSR_Item_Logs",4}
				};
				name = "Campfire";
				model = "Land_FirePlace_F";
				description = "A Simple Campfire";
				preview = "\dsr_ui\Assets\object_previews\preview_campfire.paa";
				crateObject = "DSR_Object_Storage_Small_Preview2";
				condition = "true";
			};
			class DSR_Object_Campfire_Tripod {
				parts[] = {
					{"DSR_Item_Logs",4},
					{"DSR_Item_Scrap_Metal",2}
				};
				name = "Campfire w/ Tripod";
				model = "DSR_Object_Campfire_Tripod";
				description = "A Survival Campfire";
				preview = "\dsr_ui\Assets\object_previews\preview_campfire_tripod.paa";
				crateObject = "DSR_Object_Storage_Small_Preview2";
				condition = "true";
			};
			class DSR_Object_Workbench {
				parts[] = {
					{"DSR_Item_Lumber",10},
					{"DSR_Item_Hardware",1},
					{"DSR_Item_Scrap_Metal",1}
				};
				name = "Workbench";
				model = "DSR_Object_Workbench";
				crateObject = "DSR_Object_Workbench_Preview2";
				description = "Crafting Workbench";
				preview = "\dsr_ui\Assets\object_previews\preview_workbench.paa";
				condition = "true";
			};
			class DSR_Object_Water_Catchment {
				parts[] = {
					{"DSR_Item_Logs",6},
					{"DSR_Item_Duct_Tape",1},
					{"DSR_Item_Tarp",1},
					{"DSR_Item_Plastic_Drum",1}
				};
				name = "Water Catch";
				model = "DSR_Object_Water_Catchment";
				crateObject = "DSR_Object_Water_Catchment_Preview2";
				description = "System for catching rain water";
				preview = "\dsr_ui\Assets\object_previews\preview_water_catch.paa";
				condition = "true";
			};
			class DSR_Object_Storage_Shed {
				parts[] = {
					{"DSR_Item_Padlock",1},
					{"DSR_Item_Lumber",50},
					{"DSR_Item_Plywood",6},
					{"DSR_Item_Hardware",10},
					{"DSR_Item_Scrap_Metal",10},
					{"DSR_Item_Logs",20}
				};
				name = "Storage Shed";
				model = "DSR_Object_Storage_Shed";
				crateObject = "DSR_Object_Storageshed_Preview2";
				description = "A place to store stuff.";
				preview = "\dsr_ui\Assets\object_previews\preview_storage_shed.paa";
				condition = "true";
			};
			class DSR_Object_Cot_Preview {
				parts[] = {
					{"DSR_Item_Scrap_Metal",4},
					{"DSR_Item_Tarp",1}
				};
				name = "Sleeping Cot";
				model = "DSR_Object_Cot";
				crateObject = "DSR_Object_Cot_Preview";
				description = "A place to sleep, when implemented.";
				preview = "\dsr_ui\Assets\object_previews\preview_cot.paa";
				condition = "true";
			};
			class DSR_Object_Anvil_Log {
				parts[] = {
					{"DSR_Item_Logs",1},
					{"DSR_Item_Scrap_Metal",10}
				};
				name = "Smithing Anvil";
				model = "DSR_Object_Anvil_Log";
				crateObject = "DSR_Object_Anvil_Log_Preview";
				description = "A place to metalwork, once implemented.";
				preview = "\dsr_ui\Assets\object_previews\preview_anvil&log.paa";
				condition = "true";
			};
			class DSR_Object_Woodplot_Small {
				parts[] = {
					{"DSR_Item_Plywood",4},
					{"DSR_Item_Hardware",3},
					{"DSR_Item_Fertilizer",2}
				};
				name = "Farming Plot (Small)";
				model = "DSR_Object_Woodplot_Small";
				crateObject = "DSR_Object_Woodplot_Small_Preview";
				description = "A place to farm, once implemented.";
				preview = "\dsr_ui\Assets\object_previews\preview_farmplot_small.paa";
				condition = "true";
			};
			class DSR_Object_Woodplot_Med {
				parts[] = {
					{"DSR_Item_Plywood",8},
					{"DSR_Item_Hardware",6},
					{"DSR_Item_Fertilizer",4}
				};
				name = "Farming Plot (Medium)";
				model = "DSR_Object_Woodplot_Med";
				crateObject = "DSR_Object_Woodplot_Med_Preview";
				description = "A place to farm, once implemented.";
				preview = "\dsr_ui\Assets\object_previews\preview_farmplot_med.paa";
				condition = "true";
			};
			class DSR_Object_Woodplot_Large {
				parts[] = {
					{"DSR_Item_Plywood",12},
					{"DSR_Item_Hardware",9},
					{"DSR_Item_Fertilizer",6}
				};
				name = "Farming Plot (Large)";
				model = "DSR_Object_Woodplot_Large";
				crateObject = "DSR_Object_Woodplot_Large_Preview";
				description = "A place to farm, once implemented.";
				preview = "\dsr_ui\Assets\object_previews\preview_farmplot_large.paa";
				condition = "true";
			};
		};
	};
};
class CfgCraftables {
	class Materials {
		condition = "true"; 
		preview = "\dsr_items\icons\dsr_item_hardware.paa";
		name = "Materials"; 
		class Craftables {
			class Lumber {
				input[] = {
					{"DSR_Item_Logs",1},
					{"DSR_Item_Saw",1}
				};
				output[] = {
					{"DSR_Item_Lumber",1},
					{"DSR_Item_Saw",1}
				};
				requiredBuildings[] = {};
				
				name = "Lumber";
				description = "General Purpose Lumber.";
				preview = "\dsr_items\icons\dsr_item_lumber.paa";
				condition = "true";
			};
			class Plywood {
				input[] = {
					{"DSR_Item_Lumber",4},
					{"DSR_Item_Saw",1},
					{"DSR_Item_Toolbox",1}
				};
				output[] = {
					{"DSR_Item_Plywood",1},
					{"DSR_Item_Saw",1},
					{"DSR_Item_Toolbox",1}
				};
				requiredBuildings[] = {"DSR_Object_Workbench"};
				
				name = "Plywood";
				description = "General Purpose Plywood.";
				preview = "\dsr_items\icons\dsr_item_plywood.paa";
				condition = "true";
			};
			class ScrapMetal {
				input[] = {
					{"DSR_Item_Crushed_Can",6},
					{"DSR_Item_Butane_Torch",1}
				};
				output[] = {
					{"DSR_Item_Scrap_Metal",1},
					{"DSR_Item_Butane_Torch",1}
				};
				requiredBuildings[] = {"DSR_Object_Anvil_Log"};
				
				name = "Scrap Metal";
				description = "General Purpose Scrap Metal.";
				preview = "\dsr_items\icons\dsr_item_scrap_metal.paa";	
				condition = "true";
			};
		};
	};
	class Tools {
		condition = "true"; 
		preview = "\dsr_items\icons\dsr_item_toolbox.paa";
		name = "Tools"; 
		class Craftables {
			class FishingRod {
				input[] = {
					{"DSR_Item_Fishingrod_Broken",1},
					{"DSR_Item_Duct_Tape",1}
				};
				output[] = {
					{"DSR_Melee_Fishingrod",1}
				};
				requiredBuildings[] = {};
				
				name = "Fishing Rod";
				description = "Great for catching small fishies.";
				preview = "\dsr_ui\Assets\houseLvl1Preview_ca.paa";
				condition = "true";
			};
		};
	};
	class Food {
		condition = "false"; 
		preview = "\dsr_items\icons\dsr_item_tuna.paa";	
		name = "Food"; 
		class Craftables {
			
		};
	};
	class Gear {
		condition = "false";
		preview = "\dsr_ui\Assets\houseLvl1Preview_ca.paa"; 
		name = "Gear";
		class Craftables {
			
		};
	};
	class Weapons {
		condition = "false"; 
		preview = "\dsr_weapons\smg\mp5a5\data\ui\w_hkm5_a5_ca.paa"; 
		name = "Weapons"; 
		class Craftables {
			
		};
	};
	class Medical {
		condition = "true"; 
		preview = "\dsr_items\icons\dsr_item_antibiotics.paa";
		name = "Medical"; 
		class Craftables {
			class Splint {
				input[] = {
					{"dsr_item_Lumber",1},
					{"DSR_Item_Bandage",2}
				};
				output[] = {
					{"DSR_Item_Splint",1}
				};
				requiredBuildings[] = {};
				
				name = "Splint";
				description = "Fixes broken legs.";
				preview = "\dsr_items\icons\dsr_item_splint.paa";
				condition = "true";
			};
			class Bandage {
				input[] = {
					{"DSR_Item_Fabric_Scraps",2},
					{"DSR_Item_Duct_Tape",1}
				};
				output[] = {
					{"DSR_Item_Makeshift_Bandage",1}
				};
				requiredBuildings[] = {};
				
				name = "Makeshift Bandage";
				description = "Stops bleeding wounds.";
				preview = "\dsr_items\icons\dsr_item_makeshift_bandage.paa";
				condition = "true";
			};
		};
	};
};
