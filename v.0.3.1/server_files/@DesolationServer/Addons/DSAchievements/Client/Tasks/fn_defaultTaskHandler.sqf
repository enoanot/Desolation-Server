params["_task","_data"];

// check data for specifics
// for example:
/// Say you wanted to have a task increment only when you run over a player with a car, this could be checked through (if vehicle player == player) or through the data field (isInCar)

// no checks | any kill counts
[_task] call DSA_fnc_IncrementTask;
[] call DSA_fnc_checkAchievements;