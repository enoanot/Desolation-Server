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
private["_canAutoRun"];
if ((vehicle player) == player && !underwater player && !surfaceIsWater (getPos player) && (stance player) == "STAND" && ((player getHitPointDamage 'HitLegs') <= 0) && currentWeapon player == "") then {
	_canAutoRun = true;
} else {
	_canAutoRun = false;
};
_canAutoRun