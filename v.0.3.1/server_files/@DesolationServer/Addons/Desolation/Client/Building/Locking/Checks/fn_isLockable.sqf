params ["_object"];

(count(_object getVariable ["APMS_UnlockCode",""]) != 0 && ((locked _object == -1 && _object getVariable ["bis_disabled_Door_1",0] == 0) || (locked _object > 0 && locked _object < 2)))