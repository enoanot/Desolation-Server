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

params["_object"];
_mass = getMass _object;
_type = typeof _object;

if ((_type isKindOf "land_portablelight_single_f") || (_type isKindOf "land_portablelight_double_f")) exitwith {true};

(!(_type isKindOf "Static") && !(_type isKindOf "Man") && ((_mass > 0) || !(_type find "Preview2" == -1)) && (_mass <= (call compile (["maxMass","OM"] call BASE_fnc_getCfgValue))));
