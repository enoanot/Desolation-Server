class CfgPatches
{
	class TimeManagement {units[] = {};};
};

class Plugins
{
	class TimeManagement
	{
		name = "Time Management";
		desc = "Modify time speed and manage lock/unlock and shutdown (with notifications)";
		version = 0.1;
		tag = "TM";
	};
};

class CfgFunctions
{
	class TM
	{
		class Server
		{
			file = "TimeManagement\Server";
			isserver = 1;
			class initServer {};
		};
		class Server_Locking
		{
			file = "TimeManagement\Server\Locking";
			isserver = 1;
			class checkLock {};
			class lock {};
			class notify {};
			class restartTimer {};
		};
		class Server_Time
		{
			file = "TimeManagement\Server\Time";
			isserver = 1;
			class initTime {};
		};
	};
};