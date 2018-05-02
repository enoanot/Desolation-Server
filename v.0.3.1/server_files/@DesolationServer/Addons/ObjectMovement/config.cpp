class CfgPatches
{
	class ObjectMovement {units[] = {};};
};

class Plugins
{
	class ObjectMovement
	{
		name = "Object Movement";
		desc = "JMaster's Object Movement System - Recoded By Lysdick";
		version = 0.1;
		tag = "OM";
	};
};
class CfgPluginKeybinds {
	class ReleaseObject {
		displayName = "Release Object";
		tooltip = "Drops the object currently being moved";
		tag = "OM";
		variable = "DropObject";
		defaultKeys[] = {{0x39,0}};
		code = "call OM_fnc_dropObject;";
	};
};
class CfgFunctions
{
	class OM
	{
		class Client 
		{
			file = "ObjectMovement\Client";
			isclient = 1;
			class initClient {};
		};
		class Client_Movement
		{
			file = "ObjectMovement\Client\Movement";
			isclient = 1;
			class canLift {};
			class dropObject {};
			class liftObject {};
		};
		class Server
		{
			file = "ObjectMovement\Server";
			isserver = 1;
			class serverLift {};
			class serverDrop {};
		};
	};
};
