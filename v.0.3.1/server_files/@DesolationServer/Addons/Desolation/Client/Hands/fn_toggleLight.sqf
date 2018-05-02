if(typeof DS_var_ItemInHands == 'Land_Camping_Light_F') exitWith {
	["DSR_Item_Camping_Light",0] call DS_fnc_TakeIntoHand;
	true
};
if(typeof DS_var_ItemInHands == 'Land_Camping_Light_off_F') exitWith {
	["DSR_Item_Camping_Light",1] call DS_fnc_TakeIntoHand;
	true
};
false;