params["_unit","_anim"]; 
if(_anim find "ladder" != -1) then {
	player setAnimSpeedCoef 1.8; //ladder speed boost
} else {
	_action = _anim select [1,3];
	if(_action in ["ssw","swm","bsw"]) then {
		player setAnimSpeedCoef 2; //swim speed boost
	} else {
		_currentLevel = player getVariable ["PVAR_DS_Progression_Stamina_Level",0];
		_adder = (_currentLevel min 4)*0.0125;
		player setAnimSpeedCoef (1+_adder);
	};
};