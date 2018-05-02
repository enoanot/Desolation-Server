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

_crashTypesClasses = "true" configClasses (configFile >> "CfgHeliCrashes" >> "CrashTypes");
HLCR_HeliCrash_CrashTypes = [];
{
	_crashName = configName _x;
	HLCR_HeliCrash_CrashTypes pushback _crashName;
} foreach _crashTypesClasses;

true;