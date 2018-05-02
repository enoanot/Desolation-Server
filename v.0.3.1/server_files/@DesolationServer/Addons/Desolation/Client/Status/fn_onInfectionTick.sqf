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

//runs every second
disableserialization;
if(DS_var_InfectionDOT > 0) then {

	//-- show infection icon
	_ctrl = uiNamespace getVariable ["INFECTION_ICON",controlNull];
	if(!isNull _ctrl) then {
		if (!ctrlShown _ctrl) then {
			_ctrl ctrlShow true;
		};
	};

	//--- create the ppeffect
	if (isNil "DS_var_InfectionEffect") then
	{
		DS_var_InfectionEffect = ppEffectCreate ["ChromAberration", 1000];
		DS_var_InfectionEffect ppEffectEnable true;
	};
	
	//--- if immune adjust the ppeffect
	if (DS_var_Immune) then
	{
		DS_var_InfectionEffect ppEffectAdjust [0, 0, false]; 
		DS_var_InfectionEffect ppEffectCommit 2;
	} else {
		//--- calculate damage from infection
		_infectionDamage = (["InfectionDamage"] call DS_fnc_getCfgValue);
		_damage = (DS_var_InfectionDOT / ( 1 / _infectionDamage));
		if (_damage > 0) then
		{
			DS_var_Blood = DS_var_Blood - (_damage * 20000);
		};
		
		//--- apply visual effect
		switch true do
		{
			case (DS_var_InfectionDOT < 0.15):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.005, 0.005, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};

			case ((DS_var_InfectionDOT >= 0.15) && (DS_var_InfectionDOT < 0.25)):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.01, 0.01, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};

			case ((DS_var_InfectionDOT >= 0.25) && (DS_var_InfectionDOT < 0.45)):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.015, 0.015, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};

			case ((DS_var_InfectionDOT >= 0.45) && (DS_var_InfectionDOT < 0.65)):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.02, 0.02, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};

			case ((DS_var_InfectionDOT >= 0.65) && (DS_var_InfectionDOT < 0.75)):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.025, 0.025, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};

			case (DS_var_InfectionDOT >= 0.75):
			{
				DS_var_InfectionEffect ppEffectAdjust [0.04, 0.3, false];
				DS_var_InfectionEffect ppEffectCommit 3;
			};
		};
	};
} else {
	if !(isNil "DS_var_InfectionEffect") then
	{
		//-- hide infection icon
		_ctrl = uiNamespace getVariable ["INFECTION_ICON",controlNull];
		if(!isNull _ctrl) then {
			if (ctrlShown _ctrl) then {
				_ctrl ctrlShow false;
			};
		};
		
		ppEffectDestroy DS_var_InfectionEffect;
		DS_var_InfectionEffect = nil;
	};
};

//--- check immunity timeout
DS_var_lastImmune = DS_var_lastImmune + 1;
if ((DS_var_lastImmune >= 600) && DS_var_Immune) then
{
	DS_var_lastImmune = 0;
	DS_var_Immune = false;
};










