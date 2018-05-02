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

if(isNil 'RUN_var_isAutoRun') then {RUN_var_isAutoRun = false;};

_found = false;
if(toLower(["Enabled","RUN"] call BASE_fnc_getCfgValue) == "true") then {
	_found = true;

	if (RUN_var_isAutoRun) then {
		RUN_var_isAutoRun = false;
		player switchMove "";
	} else {
		if (call RUN_fnc_canAutoRun) then {
			RUN_var_isAutoRun = true;
			[] spawn {
				RUN_var_3DDrawEvent = addMissionEventHandler ["Draw3D", {commy_lastDrawFrame = diag_frameNo;}];
				RUN_var_EachFrameEH = addMissionEventHandler ["EachFrame", {commy_lastSimulFrame = diag_frameNo;}];
				while {RUN_var_isAutoRun} do {
					_gradient = [getPos player, getDir player] call BIS_fnc_terrainGradAngle;
					if(_gradient <= 15 && _gradient >= -15) then {
						player playAction "FastF";
						sleep 0.523;
					} else {
						if(_gradient >= 40 || _gradient <= -40) then {
							player playAction "WalkF";
							sleep 2.847;
						} else {
							player playAction "SlowF";
							sleep 0.79;
						};
					};
					_interuptAutoRun = (inputAction "LeanLeft")+(inputAction "LeanRight")+(inputAction "MoveLeft")+(inputAction "MoveRight")+(inputAction "Stand")+(inputAction "Crouch")+(inputAction "Prone")+(inputAction "Salute")+(inputAction "SitDown")+(inputAction "MoveUp")+(inputAction "MoveDown")+(inputAction "AdjustUp")+(inputAction "AdjustDown")+(inputAction "AdjustRight")+(inputAction "AdjustLeft")+(inputAction "TactTemp")+(inputAction "TactToggle")+(inputAction "TactShort");
					if (_interuptAutoRun > 0 || !call RUN_fnc_canAutoRun || abs(commy_lastDrawFrame - commy_lastSimulFrame) > 1) exitWith {
						removeMissionEventHandler ["Draw3D",RUN_var_3DDrawEvent];
						removeMissionEventHandler ["EachFrame",RUN_var_EachFrameEH];
						RUN_var_isAutoRun = false;
					};
				};
			};
		};
	};
};
_found