disableSerialization;
_display = findDisplay 4003;

_ctrl = _display displayCtrl 2400;
_ctrl buttonSetAction "call DS_fnc_reset";
_ctrl ctrlSetText "Reset";