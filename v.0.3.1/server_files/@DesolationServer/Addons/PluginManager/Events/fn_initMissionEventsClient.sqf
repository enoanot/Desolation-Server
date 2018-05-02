

_data = BASE_var_missionEventsClient select 1;

{
	addMissionEventHandler [(_x select 0),missionNamespace getVariable [(_x select 1),{}]];
} forEach _data;

// render custom map edits | edit: this will be added once i figure out how to fix performance issues (70fps - 5fps when map open)
/* 
((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
	{
		_size = boundingBoxReal _x;
		_dX = abs((_size select 0) select 0);
		_dY = abs((_size select 0) select 1);

		_pos = (_this select 0) ctrlMapWorldToScreen (getposatl _x);
		if((_pos select 0) > safeZoneX && (_pos select 0) < (safeZoneX + safeZoneW)) then {
			if((_pos select 1) > safeZoneY && (_pos select 1) < (safeZoneY + safeZoneH)) then {
				(_this select 0) drawRectangle [_x,_dX,_dY,getdir _x,[0.71,0.71,0.71,1],"#(rgb,8,8,3)color(0.71,0.71,0.71,1)"];
			};
		};
		true;
	} count(BASE_var_cObjectsToRender);
}];
*/