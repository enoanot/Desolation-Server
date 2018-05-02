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

 if(random(1) < 0.5) then {
	[player,["DSR_Voice_Laugh",100,call VE_fnc_getPitch]] remoteExec ["say3D",allPlayers];
} else {
	[player,["DSR_Voice_Laugh2",100,call VE_fnc_getPitch]] remoteExec ["say3D",allPlayers];
};
false;