class CfgPatches
{
	class SpookyWeather {units[] = {};};
};

class Plugins
{
	class SpookyWeather
	{
		name = "Spooky Weather";
		desc = "Increases server fog & creates a spooky environment";
		tag = "SW";
	};
};

class CfgFunctions
{
	class SW
	{
		class Server 
		{
			file = "SpookyWeather\Server";
			isserver = 1;
			class initServer {};
		};
	};
};