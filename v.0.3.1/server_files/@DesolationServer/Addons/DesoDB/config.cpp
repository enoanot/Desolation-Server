#include "constants.hpp"

class CfgPatches
{
	class DesoDB {units[] = {};};

};

class Plugins
{
	class DesoDB
	{
		name = "DesoDB";
		desc = "Desolation Redux's custom Database connection plugin";
		tag = "DB";
	};
};

class CfgFunctions
{
	class DB
	{
		class Core
		{
			file = "DesoDB";
			isserver = 1;
			class initServer {};
		};
		class Monitor {
			file = "DesoDB\Monitor";
			isserver = 1;
			class objectMonitor {};
		};
		class Functions
		{
			file = "DesoDB\Functions";
			isserver = 1;
			class sendRequest {};

			class getWorldUUID {};
			class hpFloatArray {};

			class restoreObjects {};
			class spawnObject {};
			class updateObject {};
			class killObject {};

			class createPlayer {};
			class killPlayer {};
			class loadPlayer {};
			class savePlayer {};
			class getServerTime {};
			class shutdown {};
		};
		class Serialization
		{
			file = "DesoDB\Serialization";
			isserver = 1;

			class serializeObject {};
			class serializePlayer {};
		};
	};
};