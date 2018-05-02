params["_player","_container"];
_override = false;

[player,["BagOpen",50]] remoteExec ["say3D",allPlayers];

if(locked _container > 1 || (locked _container == -1 && _container getVariable ["bis_disabled_Door_1",1] != 0)) then { //If container is locked

	/*[] spawn {
		waituntil {!(isNull findDisplay 602)};
		closeDialog 0;
		systemChat "Access denied";
	};*/

};

DS_var_OpenedContainer = _container;
DS_var_InvOpen = true;
[] spawn ds_fnc_setupInvEvents;
_override;