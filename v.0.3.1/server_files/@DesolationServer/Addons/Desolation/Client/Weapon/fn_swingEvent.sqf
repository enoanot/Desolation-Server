/*
	Credits: Killzone Kid, original author of the code this is based on.
	Source: http://killzonekid.com/arma-scripting-tutorials-how-to-override-lmb/
*/

DSR_isSwinging = false;

DSR_swingActions = [];
DSR_swingWeapons = [];

player addAction ["",{
	
	_weapon = currentWeapon player;
	_index = DSR_swingWeapons find _weapon;
	_data = DSR_swingActions select _index;
	
	_animation = _data select 0;
	_functionData = _data select 1;
	_delay1 = _data select 2;
	_delay2 = _data select 3;
	
	
	if(!DSR_isSwinging) then { 
		DSR_isSwinging = true; 
		player playActionNow _animation; 
		[_delay1,_functionData,_delay2,_weapon] spawn DS_fnc_onSwing;
	};
	
}, "", -100, false, true, "DefaultAction", "currentWeapon player in DSR_swingWeapons"];

["DSR_Melee_Axe","dsr_AxeSlashGst",[true,false,1,1,1]] call DS_fnc_registerMeleeAction;
["DSR_Melee_Fire_Axe","dsr_AxeSlashGst",[true,false,1,1,1]] call DS_fnc_registerMeleeAction;

["DSR_Melee_Katana","dsr_KatanaSlashGst",[false,false,2,1,1],1,1] call DS_fnc_registerMeleeAction;

["DSR_Melee_Bat_Norm","dsr_BatSlashGst",[false,false,3,1,1],0.75,0.5] call DS_fnc_registerMeleeAction;
["DSR_Melee_Bat_Nails","dsr_BatSlashGst",[false,false,4,1,1],0.75,1.25] call DS_fnc_registerMeleeAction;
["DSR_Melee_Bat_Barb","dsr_BatSlashGst",[false,false,5,1,1],0.75,1.25] call DS_fnc_registerMeleeAction;

["DSR_Melee_Pickaxe","dsr_PickaxeSlashGst",[false,true,1,1,1],1.5,1.25] call DS_fnc_registerMeleeAction;


["DSR_Melee_Fishingrod","dsr_Fishing_Idle",[false,false,1,1,1],2,2] call DS_fnc_registerMeleeAction;

/*
	_canHitTrees = _functionData select 0;
	_canHitRocks = _functionData select 1;
	_playerDamageType = _functionData select 2; (1|axe 2|katana 3|batnorm 4|batnail 5|batbarb)
	_vehicleDamage = _functionData select 3;
	_zombieDamage = _functionData select 4;
*/
















