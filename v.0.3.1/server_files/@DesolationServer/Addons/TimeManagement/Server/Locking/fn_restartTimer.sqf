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

params["_password","_callback"];

diag_log "TimeManagement > INFO: restartTimer started";

// Uptime based restarts
_uptime = parseNumber (["Uptime","TM"] call BASE_fnc_getCfgValue);
_endTime = (_uptime*3600);

_useScheduledRestarts = parseNumber (["UseScheduledRestarts","TM"] call BASE_fnc_getCfgValue);
_RestartMessageTimers = (["RestartMessageTimers","TM"] call BASE_fnc_getCfgValue) splitString ",";

_Notifications = [];
{
    _Notifications pushBack (parseNumber _x);
} forEach _RestartMessageTimers;

if (_Notifications find 0 == -1) then {_Notifications pushBack 0; };

// Schedule based restarts (Overrides Uptime based)
if (_useScheduledRestarts >= 1) then
{
    _restartTimes = (["RestartTimes","TM"] call BASE_fnc_getCfgValue) splitString ",";

    _startTime = call DB_fnc_getServerTime;
    _startTime params [
        ['_startYear',1],
        ['_startMonth',1],
        ['_startDay',1],
        ['_startHour',0],
        ['_startMinute',0],
        ['_startSecond',0]
    ];

    _startHourInMin = if(_startHour > 0)then{_startHour * 60}else{ 0 };
    _minNow = _startHourInMin + _startMinute;
    _last=0;
    {
        _curRestartTime = parseNumber(_x);
        if (_last <= _startHour) then
        {
            if (_curRestartTime > _last) then
            {
                if (_startHour >= parseNumber(_restartTimes select (count _restartTimes - 1))) then
                {
                    _curRestartTime = 0;
                };
                _last = _curRestartTime;
            };
        };
    } forEach _restartTimes;
    _nextRestartHourInMin = if(_last > 0)then{_last * 60}else{24 * 60};
    _minsUntilNextRestart = (_nextRestartHourInMin - _minNow);
    _endTime = (_minsUntilNextRestart*60)-_startSecond;
};

diag_log  format["TimeManagement > INFO: Seconds until shutdown - %1", _endTime];

// Compensate for existing server run-time
// Then shut down 1 minute before the alotted time to ensure server saves
_endTime = (_endTime+diag_tickTime)-120;

{
    waitUntil{uiSleep 10;diag_tickTime >= (_endTime-(_x*60))};
    if (_x != 0) then {
        ["SERVER RESTARTING IN " + str(_x) + " " + (if(_x > 1) then {"MINUTES"} else {"MINUTE"}) + (if(_x < 16) then {", PLEASE LOGOUT"} else {""})] call TM_fnc_notify;
    };
} forEach _Notifications;

diag_log  "TimeManagement > Locking Server";
_password serverCommand "#lock";

diag_log  "TimeManagement > Kicking Players";
{
    _password serverCommand ("#kick " + str(owner _x));
} forEach allPlayers;
uiSleep 10;

diag_log  "TimeManagement > Processing Callback";
call _callback;

// Shut down DesoDB
call DB_fnc_shutdown;

// Wait until 20s left then trigger shutdown.
waitUntil{uiSleep 5;diag_tickTime >= (_endTime+100)};

diag_log  "TimeManagement > Shutting Down Server";
_password serverCommand "#shutdown";
