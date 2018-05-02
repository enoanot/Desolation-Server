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

// last parameter is _group (0 = vehicles, 1 = Liftables, 2 = Players, 3 = Non-Liftables, 4 = Gathering)
 
params["_cursor"];

_oldpos = ASLtoATL eyepos player;
_newpos = getPosATL _cursor;

player switchMove "Crew";
player setPosATL _newpos;
player setDir ((getDir _cursor) - 180);

stand = player addAction ["Stand Up", "call ACT_fnc_stand"];

if(!isNil "GLP_fnc_checkGlitch") then {
	[_oldpos,_newpos,{
		params["_oldpos","_nil"];
		
		player setposatl _oldpos;
		call ACT_fnc_stand;
		
	},[_cursor,player]] call GLP_fnc_checkGlitch;
	
};

//player attachTo [_cursor,[0.00244141,-0.0419922,-0.416863]];
//player switchMove "crew";
//player setDir ((getdir _cursor)-180);

true