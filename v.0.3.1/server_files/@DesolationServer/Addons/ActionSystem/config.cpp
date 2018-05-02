class CfgPatches
{
	class ActionSystem {units[] = {};};
};

class Plugins
{
	class ActionSystem
	{
		name = "Action System";
		desc = "Allows players to perform various actions to vehicles, objects or other players";
		version = 0.1;
		tag = "ACT";
	};
};

class CfgPluginKeybinds {
	class Toggle3DAction 
	{
		displayName = "Toggle 3D Actions";
		tooltip = "Toggle 3D actions to be able to easily use any actions in 3D";
		tag = "ACT";
		variable = "Toggle3DAction";
		defaultKeys[] = {{0x0F,0}};
		code = "call ACT_fnc_toggleActions;";
	};
	class do3DAction
	{
		displayName = "Use 3D Action";
		tooltip = "Allows you to use the highlighted action";
		tag = "ACT";
		variable = "do3DAction";
		defaultKeys[] = {{0x39,0}};
		code = "call ACT_fnc_doSelectedAction";
	};
};

class CfgFunctions
{
	class ACT
	{
		// client functions
		class Client 
		{
			file = "ActionSystem\Client";
			isclient = 1;
			class initClient {};
		};
		class Client_Actions_Vehicles {
			file = "ActionSystem\Client\Actions\Vehicles";
			isclient = 1;
			class removeHRotor {};
			class removeVRotor {};
			class replaceVRotor {};
			class replaceHRotor {};
			class repairAvionics {};
			class repairElevator {};
			class repairRotor {};
			class repairVRotor {};
			class repairHRotor {};
			class repairHull {};
			class repairBody {};
			class repairEngine {};
			class repairFueltank {};
			class repairGlass {};
			class repairWheel {};
			class removeEngine {};
			class removeFueltank {};
			class removeGlass {};
			class removeWheel {};
			class replaceEngine {};
			class replaceFueltank {};
			class replaceGlass {};
			class replaceWheel {};
			class refuelFueltank {};
			class flipVehicle {};
			class disassembleBike {};
		};
		class Client_Actions_Players {
			file = "ActionSystem\Client\Actions\Players";
			isclient = 1;
			class release {};
			class ziptie {};
			class bandage {};
			class giveBlood {};
			class applySplint {};
		};
		class Client_Keybinds {
			file = "ActionSystem\Client\Keybinds";
			isclient = 1;
			class toggleActions {};
			class doSelectedAction {};
		};
		class Client_Actions_Lift {
			file = "ActionSystem\Client\Actions\Lift";
			isclient = 1;
			class liftObject {};
			class toggleGenerator {};
			class packTent {};
		};
		class Client_Actions_NonLift {
			file = "ActionSystem\Client\Actions\NonLift";
			isclient = 1;
			class getFuel {};
			class getWater {};
			class deconstruct {};
		};
		class Client_Actions_Sit {
			file = "ActionSystem\Client\Actions\Sit";
			isclient = 1;
			class canSit {};
			class sit {};
			class stand {};
		};
		class Client_System {
			file = "ActionSystem\Client\System";
			isclient = 1;
			class isPosTarget {};
			class get3DPartName {};
			class calculationThread {};
			class display2DMenu {};
			class doAnimation {};
		};
		class Client_Actions_Gathering {
			file = "ActionSystem\Client\Actions\Gathering";
			isclient = 1;
			class getApples {};
			class gutAnimal {};
		};
		
		
		// server functions
		class Server {
			file = "ActionSystem\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Actions {
			file = "ActionSystem\Server\Actions";
			isserver = 1;
			class removePartReq {};
			class repairPartReq {};
			class replacePartReq {};
			class refuelReq {};
			class flipObject {};
			class itemFill {};
			class gather {};
			class useGenerator {};
			class gut {};
			class disassembleObject {};
		};
	};
};

class Cfg3DActions {
	
	class Vehicles {
		condition = "_cursor isKindOf 'allVehicles' && ((_cursor isKindOf 'landVehicle') || (_cursor isKindOf 'air') || (_cursor isKindOf 'ship'))"; //condition  on what cursor object to use these actions for
		
		renderType = 0; //0 = hitpoints / 1 = model center
		
		class Actions {
			
			// heli & planes
			class RepairHull {
				condition = "_selection find 'hull' != -1";
				text = "Repair Hull";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 20}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairHull;";
			};
			class RepairHRotor {
				condition = "_selection find 'hrotor' != -1";
				text = "Repair Rotor";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 15}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairHRotor;";
			};
			class RepairVRotor {
				condition = "_selection find 'vrotor' != -1";
				text = "Repair Tail";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 10}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairVRotor;";
			};
			class RepairRotor {
				condition = "(_selection find 'rotor' != -1) && (_selection find 'vrotor' == -1) && (_selection find 'hrotor' == -1)";
				text = "Repair Propeller";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 15}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairRotor;";
			};
			class RepairAvionics {
				condition = "_selection find 'avionics' != -1";
				text = "Repair Avionics";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Electrical_Comp", 5}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairAvionics;";
			};
			class RepairElevators {
				condition = "_selection find 'elevator' != -1";
				text = "Repair Elevator";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Electrical_Comp", 1},
						{"DSR_Item_Scrap_Metal", 5}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairElevator;";
			};
			class ReplaceHRotor {
				condition = "_selection find 'hrotor' != -1";
				text = "Replace Rotor";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Main_Rotor", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceHRotor;";
			};
			class ReplaceVRotor {
				condition = "_selection find 'vrotor' != -1";
				text = "Replace Tail";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Tail_Rotor", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceVRotor;";
			};
			class RemoveVRotor {
				condition = "_selection find 'vrotor' != -1";
				text = "Remove Tail";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Tail_Rotor", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeVRotor;";	
			};
			class RemoveHRotor {
				condition = "_selection find 'hrotor' != -1";
				text = "Remove Rotor";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Main_Rotor", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeHRotor;";	
			};
			
			
			//vehicles
			class RepairWheel {
				condition = "_selection find 'wheel' != -1";
				text = "Repair Wheel";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Tire_RepairKit", 4}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairWheel;";
			};
			class RepairGlass {
				condition = "_selection find 'glass' != -1";
				text = "Repair Glass";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Glass_Part", 4}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairGlass;";
			};
			class RepairEngine {
				condition = "_selection find 'engine' != -1";
				text = "Repair Engine";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 10}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairEngine;";
			};
			class RepairFueltank {
				condition = "_selection find 'fuel' != -1";
				text = "Repair Fuel Tank";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 4}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairFueltank;";
			};
			class RepairBody {
				condition = "_selection find 'body' != -1";
				text = "Repair Body";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1},
						{"DSR_Item_Scrap_Metal", 20}
					};
					returnedItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_repairBody;";
			};
			class RemoveWheel {
				condition = "_selection find 'wheel' != -1";
				text = "Remove Wheel";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Tire", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeWheel;";
			};
			class RemoveGlass {
				condition = "_selection find 'glass' != -1";
				text = "Remove Glass";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Glass_Part", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeGlass;";
			};
			class RemoveEngine {
				condition = "_selection find 'engine' != -1";
				text = "Remove Engine";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Engine_Block", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeEngine;";
			};
			class RemoveFueltank {
				condition = "_selection find 'fuel' != -1";
				text = "Remove Fuel Tank";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Gas_Tank", 1}
					};
				};
				action = "[_cursor,_selection] call ACT_fnc_removeFueltank;";
			};
			class ReplaceWheel {
				condition = "_selection find 'wheel' != -1";
				text = "Replace Wheel";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Tire", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceWheel;";
			};
			class ReplaceGlass {
				condition = "_selection find 'glass' != -1";
				text = "Replace Glass";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Glass_Part", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceGlass;";
			};
			class ReplaceEngine {
				condition = "_selection find 'engine' != -1";
				text = "Replace Engine";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Engine_Block", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceEngine;";
			};
			class ReplaceFueltank {
				condition = "_selection find 'fuel' != -1";
				text = "Replace Fuel Tank";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Gas_Tank", 1}
					};
				};
				action = "[_cursor,_index,_selection] call ACT_fnc_replaceFueltank;";
			};

			// Other
			class RefuelFueltank {
				condition = "_selection find 'fuel' != -1";
				text = "Refuel Fuel Tank";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Fuelcan_Full", 20},			// 20 litres
						{"DSR_Item_Gascan_Large_Full", 20},		// 20 litres
						{"DSR_Item_Gascan_Small_Full", 10}		// 10 litres
					};
					returnedItems[] = {
						{"DSR_Item_Fuelcan_Empty", 1},
						{"DSR_Item_Gascan_Large_Empty", 1},
						{"DSR_Item_Gascan_Small_Empty", 1}
					};
				};
				action = "[_cursor] call ACT_fnc_refuelFueltank;";
			};
			class FlipVehicle {
				condition = "_selection find 'body' != -1";
				text = "Flip Vehicle";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Scissor_Jack", 1}
					};
				};
				action = "[_cursor] call ACT_fnc_flipVehicle;";
			};
			class DisassembleBike {
				condition = "_selection find 'body' != -1 && ((_cursor isKindOf 'DSR_Bike_Green_F') || (_cursor isKindOf 'DSR_Bike_White_F'))";
				text = "Disassemble";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox",1}
					};
					returnedItems[] = {
					    {"DSR_Item_Bike_Frame",1},
					    {"DSR_Item_Bike_Wheel",2},
					    {"DSR_Item_Bike_Chain",1}
					};
				};
				action = "[_cursor] call ACT_fnc_disassembleBike;";
			};
		};
	};
	class Liftables {
		condition = "!(isNil 'OM_fnc_canLift') && ([_cursor] call OM_fnc_canLift)"; //nil check added incase ObjectMovement was removed
		
		renderType = 1;
	
		class Actions {
			
			class Lift {
				condition = "(typeof _cursor find 'DSR_Object_Storage_' == -1)";
				text = "Lift";
				class Parameters {};
				action = "[_cursor] call ACT_fnc_liftObject;"; // our custom lift function will redirect the object to the correct lift system (building / item)
			};
			class LiftCrate {
				condition = "!(typeof _cursor find 'DSR_Object_Storage_' == -1) && ([_cursor] call DS_fnc_isBuildingOwner)";
				text = "Lift";
				class Parameters {};
				action = "[_cursor] call ACT_fnc_liftObject;";
			};
			class Delete {
				condition = "!(typeof _cursor find 'Preview2' == -1)";
				text = "Delete";
				class Parameters {};
				action = "deleteVehicle _cursor;";
			};
			class Sit {
				condition = "[_cursor] call ACT_fnc_canSit";
				text = "Sit";
				class Parameters {};
				action = "[_cursor] call ACT_fnc_sit;";
			};
			class ToggleGenerator {
				condition = "(_cursor isKindOf 'Land_Portable_generator_F')";
				text = "Toggle ON/OFF";
				class parameters {};
				action = "[_cursor] spawn ACT_fnc_toggleGenerator;";
			};
			class PackTent {
				condition = "(typeOf(_cursor) find 'DSR_Tent_' != -1)";
				text = "Pack";
				class parameters {};
				action = "[_cursor] spawn ACT_fnc_packTent;";
			};
		};
	};
	class Players {
		condition = "_cursor in allPlayers && player == vehicle player";
		
		renderType = 0;
		
		class Actions {
			
			class Release {
				condition = "(_selection find 'body' != -1) && (animationState _cursor == 'acts_aidlpsitmstpssurwnondnon_loop')"; // (if player is ziptied)
				text = "Cut Zip Tie";
				class Parameters {};
				action = "[_cursor] call ACT_fnc_release;";
			};
			class OpenInventory {
				condition = "(_selection find 'body' != -1) && (animationState _cursor == 'acts_aidlpsitmstpssurwnondnon_loop')"; // (if player is ziptied)
				text = "Open Inventory";
				class Parameters {};
				action = "player action ['Gear',_cursor];";
			};
			class Ziptie {
				condition = "(_selection find 'body' != -1) && (animationState _cursor == 'amovpercmstpssurwnondnon')"; // (if player has hands up)
				text = "Add Zip Tie";
				class Parameters {};
				action = "[_cursor] call ACT_fnc_ziptie;";
			};
			class Bandage {
				condition = "(_selection find 'body' != -1)"; //todo cursor is bleeding check
				text = "Bandage";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Bandage", 4}
					};
				};
				action = "[_cursor,_index] call ACT_fnc_bandage;";
			};
			class Bloodbag {
				condition = "(_selection find 'body' != -1)"; //todo blood value check
				text = "Give Blood";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Bloodbag_Full", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Bloodbag_Empty", 1}
					};
				};
				action = "[_cursor,_index] call ACT_fnc_giveBlood;";
			};
			class Splint {
				condition = "(_selection find 'body' != -1) && (animationState _cursor != 'acts_aidlpsitmstpssurwnondnon_loop')"; //todo broken leg check (remove splint usage is for more space in 3d menu!)
				text = "Apply Splint";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Splint", 1}
					};
				};
				action = "[_cursor,_index] call ACT_fnc_applySplint;";
			};
		};
	};
	class NonLiftables {
		condition = "(str(_cursor) find 'misc_waterstation' == -1) && (str(_cursor) find 'misc_trunk_water' == -1) && (player == vehicle player) && (	(!(str(_cursor) find 'water' == -1) || !(str(_cursor) find 'pump' == -1) || !(str(_cursor) find 'feed' == -1) || !(str(_cursor) find 'fuelstation' == -1) && !(str(_cursor) find 'pump' == -1)	) || (	(str(_cursor) find 'stockade' != -1) && ([_cursor] call DS_fnc_isBuildingOwner)	) )";
		
		renderType = 1;
	
		class Actions {
			
			class GetWater {
				condition = "!(str(_cursor) find 'water' == -1) || !(str(_cursor) find 'pump' == -1)";
				text = "Get Water";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Waterbottle_Empty", 1},
						{"DSR_Item_Canteen_Empty", 1},
						{"DSR_Item_Watercan_Empty", 1},
						{"DSR_Item_Bucket_Empty", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Waterbottle_Full", 1},
						{"DSR_Item_Canteen_Full", 1},
						{"DSR_Item_Watercan_Full", 1},
						{"DSR_Item_Bucket_Full", 1}
					};
				};
				action = "[_cursor] call ACT_fnc_getWater;";
			};
			class GetFuel {
				condition = "!(str(_cursor) find 'feed' == -1) || (!(str(_cursor) find 'fuelstation' == -1) && !(str(_cursor) find 'pump' == -1))";
				text = "Get Fuel";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Fuelcan_Empty", 1},
						{"DSR_Item_Gascan_Large_Empty", 1},
						{"DSR_Item_Gascan_Small_Empty", 1}
					};
					returnedItems[] = {
						{"DSR_Item_Fuelcan_Full", 20},			// 20 litres
						{"DSR_Item_Gascan_Large_Full", 20},		// 20 litres
						{"DSR_Item_Gascan_Small_Full", 10}		// 10 liters
					};
				};
				action = "[_cursor] call ACT_fnc_getFuel;";
			};
			class Deconstruct {
				condition = "(str(_cursor) find 'stockade' != -1) && ([_cursor] call DS_fnc_isBuildingOwner)";
				text = "Deconstruct";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_Toolbox",1}
					};
				};
				action = "[_cursor] call ACT_fnc_deconstruct;";
			};
		};
	};
	class Gathering {
		condition = "player == vehicle player && ((_cursor isKindOf 'Animal_Base_F' && !alive _cursor) || !(str(_cursor) find 't_malus1s' == -1))";
		
		renderType = 1;
		
		class Actions {
			
			class GatherApple {
				condition = "!(str(_cursor) find 't_malus1s' == -1)";
				text = "Search Apples";
				class Parameters {
					requiredItems[] = {};
					returnedItems[] = {
						{"DSR_Item_redApple",1}
					};
				};
				action = "[_cursor] call ACT_fnc_getApples;";
			};
			class GatherAnimal {
				condition = "!alive _cursor";
				text = "Gut";
				class Parameters {
					requiredItems[] = {
						{"DSR_Item_knife", 1}
					};
				};
				action = "[_cursor] call ACT_fnc_gutAnimal;";
			};
		};
	};
};

class Cfg3DIcons {
	class action {
		name = "Actions";
		icon = "\a3\ui_f\data\igui\cfg\weaponcursors\gl_gs.paa";
	};
	class missiles {
		name = "Missiles";
		icon = "\dsr_ui\Assets\actions\Missiles.paa";
	};
	class glass {
		name = "Glass";
		icon = "\dsr_ui\Assets\actions\glass.paa";
	};
	class wheel {
		name = "Wheel";
		icon = "\dsr_ui\Assets\actions\wheel.paa";
	};
	class engine {
		name = "Engine";
		icon = "\dsr_ui\Assets\actions\engine.paa";
	};
	class fuel {
		name = "Fuel";
		icon = "\dsr_ui\Assets\actions\fuel.paa";
	};
	class body {
		name = "Body";
		icon = "\dsr_ui\Assets\actions\body.paa";
	};
	class avionics {
		name = "Avionics";
		icon = "\dsr_ui\Assets\actions\avionics.paa";
	};
	class gear {
		name = "Gear";
		icon = "\dsr_ui\Assets\actions\gear.paa";
	};
	class winch {
		name = "Winch";
		icon = "\dsr_ui\Assets\actions\winch.paa";
	};
	class hull {
		name = "Hull";
		icon = "\dsr_ui\Assets\actions\hull.paa";
	};
	class turret {
		name = "Turret";
		icon = "\dsr_ui\Assets\actions\turret.paa";
	};
	class gun {
		name = "Gun";
		icon = "\dsr_ui\Assets\actions\gun.paa";
	};
	class transmission {
		name = "Transmission";
		icon = "\dsr_ui\Assets\actions\transmission.paa";
	};
	class stabilizer {
		name = "Stabilizer";
		icon = "\dsr_ui\Assets\actions\stabilizer.paa";
	};
	class tail { //idk?
		name = "Tail";
		icon = "\dsr_ui\Assets\actions\tail.paa";
	};
	class vrotor { //heli tail rotor
		name = "Tail Rotor";
		icon = "\dsr_ui\Assets\actions\tail.paa";
	};
	class hrotor { //heli main rotor
		name = "Main Rotor";
		icon = "\dsr_ui\Assets\actions\stabilizer.paa";
	};
	class rotor {
		name = "Rotor";
		icon = "\dsr_ui\Assets\actions\stabilizer.paa";
	};

	class track {
		name = "Track";
		icon = "\dsr_ui\Assets\actions\track.paa";
	};
	class port {
		name = "Port";
		icon = "\dsr_ui\Assets\actions\port.paa";
	};
	class blade {
		name = "Blade";
		icon = "\dsr_ui\Assets\actions\blade.paa";
	};
	class starter {
		name = "Starter";
		icon = "\dsr_ui\Assets\actions\starter.paa";
	};
	class door {
		name = "Door";
		icon = "\dsr_ui\Assets\actions\door.paa";
	};
	class elevator {
		name = "Elevator";
		icon = "\dsr_ui\Assets\actions\elevator.paa";
	};
	class light {
		name = "Light";
		icon = "\dsr_ui\Assets\actions\light.paa";
	};
	class flap {
		name = "Flap";
		icon = "\dsr_ui\Assets\actions\flap.paa";
	};
	class hatch {
		name = "Hatch";
		icon = "\dsr_ui\Assets\actions\hatch.paa";
	};
	class ramp {
		name = "Ramp";
		icon = "\dsr_ui\Assets\actions\ramp.paa";
	};
};

