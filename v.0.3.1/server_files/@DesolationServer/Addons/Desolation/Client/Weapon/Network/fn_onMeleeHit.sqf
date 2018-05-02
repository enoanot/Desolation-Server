params["_damagedBy","_type"];


//high initial damage, low bleed
// axe | pickaxe
if(_type == 1) then {
	DS_var_blood = DS_var_blood - (1000 + random(2500));
	DS_var_damagedBy pushBack _damagedBy;
	_selections = ["spine3","leftforearm","rightforearm","lefthand","righthand","leftupleg","rightupleg","leftleg","rightleg","leftfoot","rightfoot","head","pelvis"];
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
};
//low initial damage, very high bleed
//katana
if(_type == 2) then {
	DS_var_blood = DS_var_blood - (500 + random(1000));
	DS_var_damagedBy pushBack _damagedBy;
	_selections = ["spine3","leftforearm","rightforearm","lefthand","righthand","leftupleg","rightupleg","leftleg","rightleg","leftfoot","rightfoot","head","pelvis"];
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
};
//low initial damage, no bleed, high knockout chance
//norm bat
if(_type == 3) then {
	DS_var_blood = DS_var_blood - (100 + random(900));
	
	// knock out
	
	if(random(1) < 0.45) then {
		[floor(10 + random(20))] spawn ds_fnc_knockOut;
	};
};
//low initial damage, high bleed, low knockout chance
//nail bat
if(_type == 4) then {
	DS_var_blood = DS_var_blood - (250 + random(750));
	DS_var_damagedBy pushBack _damagedBy;
	_selections = ["spine3","leftforearm","rightforearm","lefthand","righthand","leftupleg","rightupleg","leftleg","rightleg","leftfoot","rightfoot","head","pelvis"];
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	
	// knock out
	if(random(1) < 0.10) then {
		[floor(10 + random(20))] spawn ds_fnc_knockOut;
	};
};

//low initial damage, medium bleed, medium knockout chance
//barb bat
if(_type == 5) then {
	DS_var_blood = DS_var_blood - (250 + random(750));
	DS_var_damagedBy pushBack _damagedBy;
	_selections = ["spine3","leftforearm","rightforearm","lefthand","righthand","leftupleg","rightupleg","leftleg","rightleg","leftfoot","rightfoot","head","pelvis"];
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	[_damagedBy,selectRandom _selections] call DS_fnc_onHitPartReceived;
	
	// knock out
	if(random(1) < 0.20) then {
		[floor(10 + random(20))] spawn ds_fnc_knockOut;
	};
};