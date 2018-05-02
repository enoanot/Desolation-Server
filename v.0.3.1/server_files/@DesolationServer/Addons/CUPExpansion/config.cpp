class CfgPatches
{
	class CUPExpansion {
		requiredAddons[] = {"Desolation"};
		units[] = {};
	};
};

class Plugins
{
	class CUPExpansion
	{
		name = "CUPExpansion";
		desc = "Expands vehicle and loot config for CUP - Maps support";
		tag = "CUPE";
	};
};

class CfgVehicleSpawns {
	class Buildings {	
		//air
		class Land_Ss_hangard {locations[] = {{0.605835,-4.5835,-5.91507}};directions[] = {182.505};};
		class Land_Ss_hangar {locations[] = {{0.0341797,-6.04883,-5.91507}};directions[] = {182.505};};
		class WarfareBAirport {locations[] = {{-0.204224,-0.669434,-5.91507}};directions[] = {182.505};};
		class Land_Mil_hangar_EP1 {locations[] = {{0.543823,-0.458984,-5.42382}};directions[] = {182.505};};

		//class Land_A_Hospital {locations[] = {{4.33032,-4.32495,3.2904}};directions[] = {98.3031};};
		class Land_A_Hospital {locations[] = {{-12.8926,1.15503,3.2904}};directions[] = {127.971};};
		class HeliH {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class HeliHCivil {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Heli_H_Civil {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class Heli_H_Rescue {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};
		class HeliHRescue {
			locations[] = {{0,0,0}};
			directions[] = {0};
		};

		//water
		class Land_Nav_Boathouse {locations[] = {{2.77588,1.64014,2.87225},{-2.92737,-1.27783,2.87226}};directions[] = {183.33,183.33};};

		//bike
		class Land_A_Villa_dam_EP1 {locations[] = {{1.68018,-4.86719,-5.5403}};directions[] = {-82.6785};};
		class Land_A_BuildingWIP {locations[] = {{7.49622,8.90771,-6.39662}};directions[] = {55.0266};};
		class Land_House_C_10_dam_EP1 {locations[] = {{-1.32324,3.52832,-2.21058}};directions[] = {-89.0262};};
		class Land_House_C_4_EP1 {locations[] = {{-2.84558,-4.96045,-4.05999}};directions[] = {266.003};};
		class Land_House_C_10_EP1 {locations[] = {{-2.33752,3.36572,-4.17852}};directions[] = {266.003};};
		class Land_A_BuildingWIP_EP1 {locations[] = {{-14.834,-14.0762,-6.50464}};directions[] = {81.7221};};
		class Land_Dum_istan4_big {locations[] = {{-0.84082,5.79785,-10.29}};directions[] = {78.0132};};
		class Land_Dum_istan4 {locations[] = {{-0.756226,6.13281,-7.2938}};directions[] = {77.5515};};
		class Land_House_C_2_DAM_EP1 {locations[] = {{4.32861,-3.77246,-1.8373}};directions[] = {266.003};};
		class Land_House_C_2_EP1 {locations[] = {{5.10828,-3.7832,-2.43191}};directions[] = {266.003};};
		class Land_House_C_1_v2_dam_EP1 {locations[] = {{-0.833618,-0.900879,-1.44163}};directions[] = {0};};
		class Land_House_C_1_EP1 {locations[] = {{-1.02222,-0.535645,-1.02564}};directions[] = {0};};

		//small car
		class Land_Benzina_schnell {locations[] = {{-0.163086,-0.973083,-2.28967},{-0.362305,-6.73993,-2.28967}};directions[] = {82.1838,-91.3002};};
		class Land_Kasarna_prujezd {locations[] = {{0.0734863,-0.756836,-8.73949}};directions[] = {179.713};};
		class Land_HouseBlock_A1_1 {locations[] = {{-4.1897,-2.60547,-4.72375}};directions[] = {179.713};};
		class Land_HouseBlock_A1 {locations[] = {{-4.18091,-2.50195,-8.8069}};directions[] = {179.713};};
		class Land_HouseBlock_A3 {locations[] = {{0.00952148,-1.41016,-5.44316}};directions[] = {179.713};};
		class Land_HouseBlock_B6 {locations[] = {{-4.0896,-1.52197,-7.62031}};directions[] = {178.602};};
		class Land_Barn_W_01 {locations[] = {{2.57849,-1.63721,-2.63476}};directions[] = {185.234};};
		class Land_Barn_W_02 {locations[] = {{2.1134,2.39746,-2.31528}};directions[] = {185.234};};
		class Land_Barn_W_01_dam {locations[] = {{2.46631,-5.99512,-2.63399}};directions[] = {185.234};};

		//large car
		class Land_FuelStation_Shed_PMC {locations[] = {{-3.70422,-0.61084,-3.03309},{3.4884,-0.416992,-3.03309}};directions[] = {179.713,2.22761};};
		class Land_A_FuelStation_Shed {locations[] = {{-3.44031,-0.324219,-3.17141},{3.45264,-0.713379,-3.17141}};directions[] = {179.713,3.19362};};
		class Land_Ind_FuelStation_Shed_EP1 {locations[] = {{-3.24402,-1.00879,-3.03309},{3.03516,-0.0151367,-3.03309}};directions[] = {179.713,355.358};};
		class Land_Hangar_2 {locations[] = {{9.83496,2.92285,-2.56463},{-7.33044,4.56055,-2.56463}};directions[] = {199.768,161.957};};
		class Land_A_Stationhouse_ep1 {locations[] = {{3.82056,-0.645996,-9.47203},{10.0288,-0.380371,-9.47203},{15.7979,0.135742,-9.47203}};directions[] = {179.713,179.713,179.713};};
		class Land_a_stationhouse {locations[] = {{3.70081,-0.908691,-9.47203},{9.73267,-0.664063,-9.47203},{16.1388,-0.929688,-9.47203}};directions[] = {179.713,179.713,179.713};};
		class Land_Ind_Vysypka {locations[] = {{2.48682,17.3027,-4.97203}};directions[] = {49.982};};
	};
	class Vehicles {
		//--- zamaks
		class C_Truck_02_box_F {
			class Spawns {
				
			};
		};
		class C_Truck_02_covered_F {
			class Spawns {
				
			};
		};
		class C_Truck_02_transport_F {
			class Spawns {
				
			};
		};
		class C_Truck_02_fuel_F {
			class Spawns {
				
			};
		};
		//--- industrial
		class C_Van_01_box_F {
			class Spawns {
				class Land_FuelStation_Shed_PMC {};
				class Land_A_FuelStation_Shed {};
				class Land_Ind_FuelStation_Shed_EP1 {};
				class Land_Hangar_2 {};
				class Land_A_Stationhouse_ep1 {};
				class Land_a_stationhouse {};
				class Land_Ind_Vysypka {};
			};
		};
		class C_Van_01_transport_F {
			class Spawns {
				class Land_FuelStation_Shed_PMC {};
				class Land_A_FuelStation_Shed {};
				class Land_Ind_FuelStation_Shed_EP1 {};
				class Land_Hangar_2 {};
				class Land_A_Stationhouse_ep1 {};
				class Land_a_stationhouse {};
				class Land_Ind_Vysypka {};
			};
		};
		class C_Van_01_fuel_F {
			class Spawns {
				class Land_FuelStation_Shed_PMC {};
				class Land_A_FuelStation_Shed {};
				class Land_Ind_FuelStation_Shed_EP1 {};
				class Land_Hangar_2 {};
				class Land_A_Stationhouse_ep1 {};
				class Land_a_stationhouse {};
				class Land_Ind_Vysypka {};
			};
		};

		//--- military
		class B_LSV_01_unarmed_F {
			class Spawns {
				
			};
		};

		//--- civ
		class DSR_SUV_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_SUV_BlueWhite_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_SUV_Camo_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class 	DSR_SUV_Green_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_SUV_Orange_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class 	DSR_SUV_Pink_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_SUV_Red_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_4_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_3A_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_3_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_2_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Open_1_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hilux_Covered_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class C_Offroad_02_unarmed_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hatchback_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hatchback_Black_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hatchback_Blue_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hatchback_Green_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class DSR_Hatchback_Silver_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class C_SUV_01_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		class C_Offroad_01_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};
		//--- quads
		class C_Quadbike_01_F {
			class Spawns {
				class Land_Benzina_schnell {};
				class Land_Kasarna_prujezd {};
				class Land_HouseBlock_A1_1 {};
				class Land_HouseBlock_A1 {};
				class Land_HouseBlock_A3 {};
				class Land_HouseBlock_B6 {};
				class Land_Barn_W_01 {};
				class Land_Barn_W_02 {};
				class Land_Barn_W_01_dam {};
			};
		};

		//--- bikes
		class DSR_Bike_White_F {
			class Spawns {
				class Land_A_Villa_dam_EP1 {};
				class Land_A_BuildingWIP {};
				class Land_House_C_10_dam_EP1 {};
				class Land_House_C_4_EP1 {};
				class Land_House_C_10_EP1 {};
				class Land_A_BuildingWIP_EP1 {};
				class Land_Dum_istan4_big {};
				class Land_Dum_istan4 {};
				class Land_House_C_2_DAM_EP1 {};
				class Land_House_C_2_EP1 {};
				class Land_House_C_1_v2_dam_EP1 {};
				class Land_House_C_1_EP1 {};
			};
		};
		class DSR_Bike_Green_F {
			class Spawns {
				class Land_A_Villa_dam_EP1 {};
				class Land_A_BuildingWIP {};
				class Land_House_C_10_dam_EP1 {};
				class Land_House_C_4_EP1 {};
				class Land_House_C_10_EP1 {};
				class Land_A_BuildingWIP_EP1 {};
				class Land_Dum_istan4_big {};
				class Land_Dum_istan4 {};
				class Land_House_C_2_DAM_EP1 {};
				class Land_House_C_2_EP1 {};
				class Land_House_C_1_v2_dam_EP1 {};
				class Land_House_C_1_EP1 {};
			};
		};
		
		//--- plans
		class C_Plane_Civil_01_F {
			class Spawns {
				class Land_Ss_hangard {};
				class Land_Ss_hangar {};
				class WarfareBAirport {};
				class Land_Mil_hangar_EP1 {};
			};
		};
		class C_Plane_Civil_01_racing_F {
			class Spawns {
				class Land_Ss_hangard {};
				class Land_Ss_hangar {};
				class WarfareBAirport {};
				class Land_Mil_hangar_EP1 {};
			};
		};
		class DSR_AN2_F {
			class Spawns {
				class Land_Ss_hangard {};
				class Land_Ss_hangar {};
				class WarfareBAirport {};
				class Land_Mil_hangar_EP1 {};
			};
		};

		//--- jelli's
		class C_Heli_Light_01_civil_F {
			class Spawns {
				class HeliH { };
				class HeliHCivil { };
				class Heli_H_Civil { };
				class Heli_H_Rescue { };
				class HeliHRescue { };
				class Land_A_Hospital { };
			};
		};
		class DSR_UH1H_F {
			class Spawns {
				class HeliH { };
				class HeliHCivil { };
				class Heli_H_Civil { };
				class Heli_H_Rescue { };
				class HeliHRescue { };
				class Land_A_Hospital { };
			};
		};
		class DSR_UH1H_camo_F {
			class Spawns {
				class HeliH { };
				class HeliHCivil { };
				class Heli_H_Civil { };
				class Heli_H_Rescue { };
				class HeliHRescue { };
			};
		};
		class DSR_UH1H_tka_F {
			class Spawns {
				class HeliH { };
				class HeliHCivil { };
				class Heli_H_Civil { };
				class Heli_H_Rescue { };
				class HeliHRescue { };
			};
		};
		
		//--- boats
		class DSR_FishingBoat_F {
			class Spawns {
				
			};
		};
		class DSR_Dingy_F {
			class Spawns {
				class Land_Nav_Boathouse {};
			};
		};
		class DSR_Raft_F {
			class Spawns {
				class Land_Nav_Boathouse {};
			};
		};
		class C_Boat_Civil_01_F {
			class Spawns {
				
			};
		};
		class C_Boat_Civil_01_police_F {
			class Spawns {
				
			};
		};
		class C_Rubberboat {
			class Spawns {
				class Land_Nav_Boathouse {};
			};
		};
		class C_Boat_Transport_02_F {
			class Spawns {
				
			};
		};
		class C_Scooter_Transport_01_F {
			class Spawns {
				class Land_Nav_Boathouse {};
			};
		};
		class O_Lifeboat {
			class Spawns {
				class Land_Nav_Boathouse {};
			};
		};
		class I_Boat_Transport_01_F {
			class Spawns {
				
			};
		};
	};

};