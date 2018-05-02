
while{true} do {
	waitUntil{currentVisionMode player == 1};
	if !(call DS_fnc_canPowerNVG) then {
		titleCut ["No power source","BLACK IN", 10e10];
		waitUntil{currentVisionMode player == 0 || call DS_fnc_canPowerNVG};
		_mode = if(call DS_fnc_canPowerNVG) then {"BLACK IN"} else {"PLAIN"};
		titleCut ["",_mode, 0.1];
	};
	uiSleep 0.001;
};