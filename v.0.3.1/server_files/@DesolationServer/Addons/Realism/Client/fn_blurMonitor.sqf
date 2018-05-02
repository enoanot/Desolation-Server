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

while{true} do {
	waitUntil{LAST_SHOT > -1};
	waitUntil{diag_tickTime > (LAST_SHOT + 2)};
	ppEffectDestroy SHOT_EFFECT;
	SHOT_EFFECT = nil;
	LAST_SHOT = -1;
	NUM_SHOTS = 0;
};