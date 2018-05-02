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
params["_unit"];
private["_bleedsourcedata","_sources","_bsourcesinfo","_i"];

_bleedsourcedata = _unit getVariable ["DS_var_BleedSourceData",[]];
_sources = _unit getVariable ["DS_var_BleedSources",[]];
_bsourcesinfo = _unit getVariable["DS_var_BleedSourcesInfo",[]];


for "_i" from 0 to count(_bsourcesinfo)-1 do {
	_bsourcesinfo deleteAt 0;
};
for "_i" from 0 to count(_bleedSourceData)-1 do {
	_info = _bleedsourcedata deleteAt 0;
	deleteVehicle (_info select 0);
	deleteVehicle (_info select 1);
};
for "_i" from 0 to count(_sources)-1 do {
	_sources deleteAt 0;
};

_unit setVariable ["DS_var_BleedSourceData",[]];
_unit setVariable ["DS_var_BleedSources",[]];
_unit setVariable ["DS_var_BleedSourcesInfo",[]];
