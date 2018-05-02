params["_classname","_newItem",["_tool",""]];

_animation = "Medic";
if((_tool != "") && (({_x == _tool} count(magazines player)) == 0)) exitWith {
	systemchat ("Oh No! You need: " + _tool)
};

_failure = {
	private["_type"];
	_type = _this select 0;
	if(_type != "Player Moved") then {
		systemchat _type;
	};
};
_success = {
	params["_newItem"];
	player addItem _newItem;
	systemchat "Crafted";
};

[_classname,_animation,true,_success,_failure,"",[_newItem]] call DS_fnc_useItem;
