class CfgPatches
{
	class DSAchievements {units[] = {};};
};

class Plugins
{
	class DSAchievements
	{
		name = "Achievement System for Redux";
		desc = "Adds basic achievements that tie into the player progression system.";
		tag = "DSA";
	};
};

class CfgFunctions
{
	class DSA
	{
		class Client_GUI 
		{
			file = "DSAchievements\Client\GUI";
			isclient = 1;
			class showNotification {};
		};
		class Client {
			file = "DSAchievements\Client";
			isclient = 1;
			class initClient {};
		};
		class Client_Achievements
		{
			file = "DSAchievements\Client\Achievements";
			isclient = 1;
			class checkAchievements {};
			class onAchievementCompleted {};
		};
		class Client_Callbacks
		{
			file = "DSAchievements\Client\Callbacks";
			isclient = 1;
			class handleCallback {};
			class registerCallbackType {};
		};
		class Client_Tasks
		{
			file = "DSAchievements\Client\Tasks";
			isclient = 1;
			class IncrementTask {};
			class defaultTaskHandler {};
		};
		
		class Server {
			file = "DSAchievements\Server";
			isserver = 1;
			class initServer {};
		};
	};
};

//all tasks. this can be used as a base class 
class All_Tasks {
	rocks_mined = 0;
	trees_chopped = 0;
	objects_built = 0;
	items_crafted = 0;
	mags_combined = 0;
	num_drinks = 0;
	num_eats = 0;
	fires_lit = 0;
	bandage_self = 0;
	bandage_others = 0;
	bloodbag_others = 0;
	bloodbag_self = 0;
	splint_self = 0;
	splint_others = 0;
};

// server sided config
class CfgDSRAchievements {
	
	
	class RocksMined1 {
		title = "Mine 10 rocks";
		description = "I mined a rock!";
		points = 10;
		
		class Tasks : All_Tasks {
			rocks_mined = 10;
		};
	};
	class RocksMined2 {
		title = "Mine 50 rocks";
		description = "Miner, not minor jackass!";
		points = 10;
		
		class Tasks : All_Tasks {
			rocks_mined = 50;
		};
	};
	class RocksMined3 {
		title = "Mine 100 rocks";
		description = "I got ROCKS for sale.";
		points = 20;
		
		class Tasks : All_Tasks {
			rocks_mined = 100;
		};
	};
	class RocksMined4 {
		title = "Mine 500 rocks";
		description = "Miner miner 49er!";
		points = 50;
		
		class Tasks : All_Tasks {
			rocks_mined = 500;
		};
	};
	class RocksMined5 {
		title = "Mine 1000 rocks";
		description = "I don't do much else with my life.";
		points = 100;
		
		class Tasks : All_Tasks {
			rocks_mined = 1000;
		};
	};
	
	
	class TreeChop1 {
		title = "Chop 10 trees";
		description = "I chopped a tree!";
		points = 10;
		
		class Tasks : All_Tasks {
			trees_chopped = 10;
		};
	};
	class TreeChop2 {
		title = "Chop 50 trees";
		description = "Lumberjack!";
		points = 10;
		
		class Tasks : All_Tasks {
			trees_chopped = 50;
		};
	};
	class TreeChop3 {
		title = "Chop 100 trees";
		description = "Soo many trees.";
		points = 10;
		
		class Tasks : All_Tasks {
			trees_chopped = 100;
		};
	};
	class TreeChop4 {
		title = "Chop 500 trees";
		description = "Master of the forest!";
		points = 50;
		
		class Tasks : All_Tasks {
			trees_chopped = 500;
		};
	};
	class TreeChop5 {
		title = "Chop 1000 trees";
		description = "Fern Gulley asshole.";
		points = 100;
		
		class Tasks : All_Tasks {
			trees_chopped = 1000;
		};
	};
	
	
	class BandageOthers1 {
		title = "Bandage 5 other players";
		description = "First Aid Badge.";
		points = 20;
		
		class Tasks : All_Tasks {
			bandage_others = 5;
		};
	};
	class BandageOthers2 {
		title = "Bandage 20 other players";
		description = "Advanced First Aid Badge.";
		points = 100;
		
		class Tasks : All_Tasks {
			bandage_others = 20;
		};
	};
	class BloodbagOthers1 {
		title = "Bloodbag 1 other player";
		description = "Lifesaver.";
		points = 10;
		
		class Tasks : All_Tasks {
			bloodbag_others = 1;
		};
	};
	class BloodbagOthers2 {
		title = "Bloodbag 10 other players";
		description = "Mr Red Cross.";
		points = 200;
		
		class Tasks : All_Tasks {
			bloodbag_others = 10;
		};
	};
	
	
	class CraftAny1 {
		title = "Craft something";
		description = "Well look at you.";
		points = 10;
		
		class Tasks : All_Tasks {
			items_crafted = 1;
		};
	};
	
	
	class BuildAny1 {
		title = "Build something";
		description = "A regular работник.";
		points = 10;
		
		class Tasks : All_Tasks {
			objects_built = 1;
		};
	};
};
