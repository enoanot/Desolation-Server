params["_pts"];
private["_value"];
// get total points and add to it and reset it
_value = player getVariable ["PVAR_DS_Progression_Pts",0];
_value = _value + _pts;
player setVariable ["PVAR_DS_Progression_Pts",_value,true];