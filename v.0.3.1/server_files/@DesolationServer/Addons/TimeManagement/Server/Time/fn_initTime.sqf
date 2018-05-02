/*
 * Desolation Redux
 * http://desolationredux.com/
 * © 2016 - 2018 Desolation Dev Team
 * 
 * This work is licensed under the Arma Public License Share Alike (APL-SA) + Bohemia monetization rights.
 * To view a copy of this license, visit:
 * https://www.bistudio.com/community/licenses/arma-public-license-share-alike/
 * https://www.bistudio.com/monetization/
 */

_StartTime = parseNumber (["StartTime","TM"] call BASE_fnc_getCfgValue);
_TimeSpread = parseNumber (["TimeSpread","TM"] call BASE_fnc_getCfgValue);

_dayMult = parseNumber (["DayMultiplier","TM"] call BASE_fnc_getCfgValue);
_dayStart = parseNumber (["DayTimeStart","TM"] call BASE_fnc_getCfgValue);
_nightMult = parseNumber (["NightMultiplier","TM"] call BASE_fnc_getCfgValue);
_nightStart = parseNumber (["NightTimeStart","TM"] call BASE_fnc_getCfgValue); 
 
if(_StartTime > 23) then {
	diag_log "TimeManagement > ERROR: StartTime > 23, Defaulting to 12";
	_StartTime = 12;
};	
if((_StartTime + _TimeSpread) > 23) then {
	diag_log "TimeManagement > ERROR: TimeSpread to large, Reducing to max possible spread";
	_TimeSpread = 23 - _StartTime;
	if((_StartTime - _TimeSpread) < 0) then {
		_TimeSpread = _StartTime;
	};
};
if((_StartTime - _TimeSpread) < 0) then {
	diag_log "TimeManagement > ERROR: TimeSpread to large, Reducing to max possible spread";
	_TimeSpread = _StartTime;
	if((_StartTime + _TimeSpread) > 23) then {
		_TimeSpread = 23 - _StartTime;
	};
};

_startHour = floor random [_StartTime - _TimeSpread, _StartTime, _StartTime + _TimeSpread];

diag_log format ["TimeManagement > INFO: Start Hour = %1", _startHour];

setDate [2017,6,10,_startHour,0];

diag_log format ["TimeManagement > INFO: Date = %1", date];


if(daytime > _nightStart || daytime < _dayStart) then {
	setTimeMultiplier _nightMult;
	//[DS_AntiGammaFilter,true] remoteExec ["ppEffectEnable", -2, true];
} else {
	setTimeMultiplier _dayMult;
	//[DS_AntiGammaFilter,false] remoteExec ["ppEffectEnable", -2, true];
};

while{true} do {
	waitUntil{uiSleep 30; (daytime > _nightStart || daytime < _dayStart)};
	setTimeMultiplier _nightMult;
	waitUntil{uiSleep 30; !(daytime > _nightStart || daytime < _dayStart) };
	waitUntil{uiSleep 30; !(daytime > _nightStart || daytime < _dayStart)};
	setTimeMultiplier _dayMult;
};