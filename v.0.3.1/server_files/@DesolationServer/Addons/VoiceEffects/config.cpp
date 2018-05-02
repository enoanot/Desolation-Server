class CfgPatches
{
	class VoiceEffects {units[] = {};};
};

class Plugins
{
	class VoiceEffects
	{
		name = "Voice Effects";
		desc = "Adds Keybinds for player voice audio effects";
		version = 0.1;
		tag = "VE";
	};
};

class CfgPluginKeybinds {
	class Voice1 {
		displayName = "Voice: Yes";
		tooltip = "The player says 'Yes'";
		tag = "VE";
		variable = "Voice1";
		defaultKeys[] = {{0x3B,0}};
		code = "call VE_fnc_Voice1;";
	};
	class Voice2 {
		displayName = "Voice: No";
		tooltip = "The player says 'Ha Ha ha ha'";
		tag = "VE";
		variable = "Voice2";
		defaultKeys[] = {{0x3C,0}};
		code = "call VE_fnc_Voice2;";
	};
	class Voice3 {
		displayName = "Voice: Team Up";
		tooltip = "The player says 'You want to team up?'";
		tag = "VE";
		variable = "Voice3";
		defaultKeys[] = {{0x3D,0}};
		code = "call VE_fnc_Voice3;";
	};
	class Voice4 {
		displayName = "Voice: Friendly";
		tooltip = "The player says 'Friendly?'";
		tag = "VE";
		variable = "Voice4";
		defaultKeys[] = {{0x3E,0}};
		code = "call VE_fnc_Voice4;";
	};
	class Voice5 {
		displayName = "Voice: I need water";
		tooltip = "The player says 'I need water'";
		tag = "VE";
		variable = "Voice5";
		defaultKeys[] = {{0x3F,0}};
		code = "call VE_fnc_Voice5;";
	};
	class Voice6 {
		displayName = "Voice: I need meds";
		tooltip = "The player says 'I need meds'";
		tag = "VE";
		variable = "Voice6";
		defaultKeys[] = {{0x40,0}};
		code = "call VE_fnc_Voice6;";
	};
	class Voice7 {
		displayName = "Voice: I need food";
		tooltip = "The player says 'I need food'";
		tag = "VE";
		variable = "Voice7";
		defaultKeys[] = {{0x41,0}};
		code = "call VE_fnc_Voice7;";
	};
	class Voice8 {
		displayName = "Voice: Hello";
		tooltip = "The player says 'Hello'";
		tag = "VE";
		variable = "Voice8";
		defaultKeys[] = {{0x42,0}};
		code = "call VE_fnc_Voice8;";
	};
	class Voice9 {
		displayName = "Voice: Goodbye";
		tooltip = "The player says 'Goodbye'";
		tag = "VE";
		variable = "Voice9";
		defaultKeys[] = {{0x43,0}};
		code = "call VE_fnc_Voice9;";
	};
	class Voice10 {
		displayName = "Voice: Laugh";
		tooltip = "The player says 'Ha ha ha ha!'";
		tag = "VE";
		variable = "Voice10";
		defaultKeys[] = {{0x44,0}};
		code = "call VE_fnc_Voice10;";
	};
	class Voice11 {
		displayName = "Voice: Drop your weapon";
		tooltip = "The player says 'Drop your weapon!'";
		tag = "VE";
		variable = "Voice11";
		defaultKeys[] = {{0x57,0}};
		code = "call VE_fnc_Voice11;";
	};
	class Voice12 {
		displayName = "Voice: Dont move";
		tooltip = "The player says 'Dont move!'";
		tag = "VE";
		variable = "Voice12";
		defaultKeys[] = {{0x58,0}};
		code = "call VE_fnc_Voice12;";
	};
};

class CfgFunctions
{
	class VE
	{
		class Client 
		{
			file = "VoiceEffects\Client";
			isclient = 1;
			class Voice1 {};
			class Voice2 {};
			class Voice3 {};
			class Voice4 {};
			class Voice5 {};
			class Voice6 {};
			class Voice7 {};
			class Voice8 {};
			class Voice9 {};
			class Voice10 {};
			class Voice11 {};
			class Voice12 {};
			class getPitch {};
		};
	};
};