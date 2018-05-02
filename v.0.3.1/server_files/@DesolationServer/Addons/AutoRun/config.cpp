class CfgPatches
{
	class AutoRun {units[] = {};};
};
class Plugins
{
	class AutoRun
	{
		name = "Auto Run";
		desc = "Automatically runs for you.";
		tag = "RUN";
	};
};

class CfgPluginKeybinds {
	class AutoRun {
		displayName = "Auto Run";
		tooltip = "Automatically runs for you.";
		tag = "RUN";
		variable = "AutoRun";
		defaultKeys[] = {{0x0B,0}};
		code = "call RUN_fnc_onToggled;";
	};
};

class CfgFunctions
{
	class RUN
	{
		class Client 
		{
			file = "AutoRun\Client";
			isclient = 1;
			class onToggled {};
			class canAutoRun {};
		};
	};
};