class CfgPatches
{
	class Realism {units[] = {};};
};

class Plugins
{
	class Realism
	{
		name = "Improved Realism";
		desc = "Makes the game feel more realistic. Adds sound effects and makes the player feel less military trained.";
		version = 0.1;
		tag = "RSM";
	};
};

class CfgFunctions
{
	class RSM
	{
		class Client 
		{
			file = "Realism\Client";
			isclient = 1;
			class initRealism {};
			class blurMonitor {};
		};
		class Server
		{
			file = "Realism\Server";
			isserver = 1;
			class initServer {};
		};
	};
};