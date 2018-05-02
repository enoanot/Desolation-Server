class CfgPatches
{
	class EarPlugs {units[] = {};};
};

class Plugins
{
	class EarPlugs
	{
		name = "Ear Plugs";
		desc = "Allows players to use earplugs to lower the sounds in game";
		version = 0.1;
		tag = "EP";
	};
};

class CfgPluginKeybinds {
	class EarPlugs {
		displayName = "Change Earplugs";
		tooltip = "Earplugs lower the ingame volume to make it easier to use external VOIP software such as Teamspeak";
		tag = "EP";
		variable = "Earplugs";
		defaultKeys[] = {{0x16,0}};
		code = "call EP_fnc_onToggled;";
	};
};

class CfgFunctions
{
	class EP
	{
		class Client 
		{
			file = "EarPlugs\Client";
			isclient = 1;
			class onToggled {};
		};
	};
};