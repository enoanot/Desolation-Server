class CfgPatches
{
	class Surrender {units[] = {};};
};

class Plugins
{
	class Surrender
	{
		name = "Surrender";
		desc = "Allows players to put hands up and surrender";
		version = 0.1;
		tag = "SUR";
	};
};

class CfgPluginKeybinds {
	class Surrender {
		displayName = "Surrender";
		tooltip = "Puts hands up";
		tag = "SUR";
		variable = "Surrender";
		defaultKeys[] = {{0x06,0}};
		code = "call SUR_fnc_onToggled;";
	};
};

class CfgFunctions
{
	class SUR
	{
		class Client 
		{
			file = "Surrender\Client";
			isclient = 1;
			class onToggled {};
		};
	};
};