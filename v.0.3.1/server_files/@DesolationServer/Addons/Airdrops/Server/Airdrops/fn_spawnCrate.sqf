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
params["_pos","_airdropType"];


_cfg = (configFile >> "CfgAirdropSpawns" >> "AirdropTypes" >> _airdropType >> "Crates");
for "_i" from 0 to (count(_cfg))-1 do {
	_entry = _cfg select _i;
	if(isClass _entry) then {

		[_pos,_entry] spawn AIRD_fnc_crateAnim;

		if(count (_cfg) > 1) then {
			uiSleep 10; // Wait 10 seconds before creating second crate
		};
	};
};