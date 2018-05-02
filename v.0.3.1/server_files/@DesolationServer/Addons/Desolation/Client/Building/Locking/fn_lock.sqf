
disableSerialization;
_display = findDisplay 4003;

_code = [];
for "_i" from 0 to 4 do {
	_ctrl = _display displayCtrl (2100+_i);
	_index = lbCurSel _ctrl;
	if(_index == -1) then {
		_code pushBack -1;
	} else {
		_code pushBack parseNumber(_ctrl lbText _index);
	};
};


_object = cursorObject;
if(isNull _object) then {
	_object = cursorTarget;
};

_lock = _object getVariable ["APMS_UnlockCode",[]];
if(_code isEqualTo _lock) then {
	for "_i" from 1 to 5 do {
		_object setVariable ["bis_disabled_Door_" + str(_i),1,true]; // disable door access
	};

	_object lock true;
	Systemchat "Locked";
} else {
	Systemchat "Wrong Code!";
};

closeDialog 0;
