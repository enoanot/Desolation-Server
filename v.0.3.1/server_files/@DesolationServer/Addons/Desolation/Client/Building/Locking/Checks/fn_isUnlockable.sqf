params ["_object"];

(count(_object getVariable ["APMS_UnlockCode",""]) != 0 && ((locked _object == -1 && _object getVariable ["bis_disabled_Door_1",1] != 0) || (locked _object > 1)))