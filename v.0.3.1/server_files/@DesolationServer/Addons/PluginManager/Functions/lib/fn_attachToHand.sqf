params["_classname",["_hand","right"],["_update_callback_code",{}]];

_obj = _classname createVehicle [0,0,0];

_shift = 0.05;
if(_hand == "right") then {_shift = -0.05;};

_obj attachTo [player,[_shift,0,0],(_hand + "handmiddle1")];


[_obj,_hand,_update_callback_code] spawn {
	params["_obj","_hand","_update_callback_code"];
	while{!isNull _obj} do {
	
		_upperarm = player selectionPosition (_hand + "forearm");
		_lowerarm = player selectionPosition (_hand + "forearmroll");

		_vectorFromUpToLower = vectorNormalized(_lowerarm vectorDiff _upperarm);
		
		_rotated = [(_vectorFromUpToLower select 0),-1*(_vectorFromUpToLower select 2),(_vectorFromUpToLower select 1)];


		_obj setVectorUp _rotated;
		
		[_obj] call _update_callback_code;
		
		uiSleep 0.001;
	};
};
_obj;