class CfgPatches
{
	class Animals {units[] = {};};
};

class Plugins
{
	class Animals
	{
		name = "Animals";
		desc = "Animals";
		tag = "ANIM";
	};
};

class CfgFunctions
{
	class ANIM
	{
		// SERVER CODE
		class Server 
		{
			file = "Animals\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Events 
		{
			file = "Animals\Server\Events";
			isserver = 1;
			class killAnimal {};
		};
		class Server_Spawning
		{
			file = "Animals\Server\Spawning";
			isserver = 1;
			class spawnAnimalGroup {};
			class insertAnimalGroup {};
			class spawnManager {};
			class createHolder {};
			class despawnAnimalGroup {};
		};
		class Server_Initialization
		{
			file = "Animals\Server\Initialization";
			isserver = 1;
			class readConfig {};
			class selectLocations {};
		};


		// BOTH CODE
		class Both 
		{
			file = "Animals\Both";
			isclient = 1;
			class isPlayerNear {};
		};
	};
};

class CfgAnimals
{
	class Rabbit_F {
		MaxGroupSize = 1;
		MinGroupSize = 1;
	}; 

	class Hen_random_F {
		MaxGroupSize = 4;
		MinGroupSize = 1;
	}; 

	class Cock_random_F {
		MaxGroupSize = 4;
		MinGroupSize = 1;
	}; 

	class Goat_random_F {
		MaxGroupSize = 3;
		MinGroupSize = 2;
	}; 
	
	class Sheep_random_F {
		MaxGroupSize = 4;
		MinGroupSize = 1;
	}; 
};