
params["_achData"];


_name = _achData select 0;
_title = _achData select 1;
_description = _achData select 2;
_points = _achData select 3;

player setVariable ["PVAR_DSA_Ach_" + _name,true,true];

[[_title,_description + " +" + str(_points) + " Pts."]] call DSA_fnc_showNotification;
systemchat ("Achievement Completed: " + _title);
[_points] call DS_fnc_addPoints;