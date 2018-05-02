
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

_object setVariable ["APMS_UnlockCode",_code,true];

for "_i" from 1 to 5 do {
	_object setVariable ["bis_disabled_Door_" + str(_i),0,true]; // enable door access
};
_object lock false;

systemchat "Lock Changed!";

closeDialog 0;