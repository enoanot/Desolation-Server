class CfgPatches
{
	class Jump {units[] = {};};
};

class Plugins
{
	class Jump
	{
		name = "Jump";
		desc = "Allows players to jump while sprinting";
		version = 0.1;
		tag = "JMP";
	};
};

class CfgFunctions
{
	class JMP
	{
		class Client 
		{
			file = "Jump\Client";
			isclient = 1;
			class keyDown {};
		};
	};
};