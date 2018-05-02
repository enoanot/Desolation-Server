call DS_fnc_stopBleeding;
player setVariable ["DS_var_isPlaying", nil, true];
player setVariable ["DS_var_inCombat", nil, true];
0 cutText ["You are dead\n\nReturn to lobby to respawn","BLACK FADED",10000];