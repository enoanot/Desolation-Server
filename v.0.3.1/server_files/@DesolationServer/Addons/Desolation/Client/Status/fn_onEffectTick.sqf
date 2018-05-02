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

_maxFatigue = 0;
 
if(DS_var_Blood <= 0) then {
	player setDamage 1;
} else {

	_bloodPercent = 50 + (DS_var_Blood / 550);
	if(_bloodPercent < 50) then {
		
	} else {
		if(_bloodPercent < 65) then {
			if(random(100) < 1 && (lifeState player != "INCAPACITATED") && ((diag_tickTime - DS_var_lastKnockout) > 5)) then {
				_lvl = 65 - _bloodPercent;
				_timer = 10 + 2*(_lvl);
				[_timer] spawn ds_fnc_knockOut;					
			};
			
		} else {
			if(_bloodPercent < 80) then {
				if(random(100) < 10) then {
					// feels week
					
				};
			};
		};
	};	
};

//--- regen blood
if(DS_var_Hunger > 75 && DS_var_Thirst > 75 && !DS_var_isBleeding && (DS_var_Blood != 27500) && DS_var_InfectionDOT == 0) then {
	_currentLevel = player getVariable ["PVAR_DS_Progression_Medical_Level",0];
	
	
	_regenStationary = 1375/36;
	_regenMoving = 725 / 144;
	
	if(_currentLevel >= 2) then {
		_regenMoving = _regenMoving * 1.5;
	};
	if(_currentLevel >= 3) then {
		_regenStationary = _regenStationary * 1.5;
	};
	
	_regen = _regenMoving;
	if((vehicle player) != player) then {
		_regen = _regenStationary;
	} else {
		if(speed player == 0) then {
			_regen = _regenStationary;
		};
	};
	DS_var_Blood = (DS_var_Blood + _regen) min 25000;
};


//--- starving effects
if(DS_var_Hunger <= 0) then {
	DS_var_Blood = DS_var_Blood - 100;
};
if(DS_var_isStarving) then {
	_maxFatigue = (1 - (DS_var_Hunger / 100)) max _maxFatigue;
};
//--- dehydrated effects
if(DS_var_Thirst <= 0) then {
	DS_var_Blood = DS_var_Blood - 100;
};
if(DS_var_isDehydrating) then {
	_maxFatigue = (1 - (DS_var_Thirst / 100)) max _maxFatigue;
};
if(_maxFatigue != 0) then {
	if(getFatigue player < _maxFatigue) then {
		player setFatigue _maxFatigue;
	};
};