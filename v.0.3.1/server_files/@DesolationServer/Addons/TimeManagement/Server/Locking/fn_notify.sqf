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
 
params["_text"];
[
	[
		[_text,"align = 'left' shadow = '1' size = '0.9' font='PuristaBold'"]
	], 0, 0, true
] remoteExec  ["BIS_fnc_typeText2", -2];
diag_log format ["TimeManagement > INFO: %1", _text];