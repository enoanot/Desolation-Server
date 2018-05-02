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

_airdropClasses = "true" configClasses (configFile >> "CfgAirdropSpawns" >> "AirdropTypes");
AIRD_Airdrop_CrateTypes = [];
{
	_airdropClass = configName _x;
	AIRD_Airdrop_CrateTypes pushback _airdropClass;
} foreach _airdropClasses;

true;
