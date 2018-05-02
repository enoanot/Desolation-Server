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

/*
	Automatically swap people talking in side chat into direct chat
*/
_enabled = (["Enabled","ASC"] call BASE_fnc_getCfgValue);
if(toLower(_enabled) != "true") exitWith {};

while{true} do {
	waitUntil{getPlayerChannel player < 3 && getPlayerChannel player > -1};
	setCurrentChannel 5;
};