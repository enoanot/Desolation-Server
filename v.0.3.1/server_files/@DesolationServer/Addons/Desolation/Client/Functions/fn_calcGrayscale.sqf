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

params["_ratio"];
private["_contrastSwap","_effectValue"];
_contrastSwap = (_ratio^2) * 0.75;
_effectValue = [
	1,
	0.25 + _contrastSwap,
	0,
	0, 0, 0, 0,
	1, 1, 1, _ratio,
	1, 1, 1, 0
];
_effectValue;