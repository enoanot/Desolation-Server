private["_value"];
_value = player getVariable ["SVAR_VoiceEffects_Pitch",-1];
if(_value < 0) then {
	_value = 0.9 + random(0.3);
	player setVariable ["SVAR_VoiceEffects_Pitch",_value,true];
};
_value