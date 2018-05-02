params["_unit","_selectionName","_damage","_shooter","_projectile","_hitPartIndex"];

if(!alive _unit) exitWith {false};

_allowDamage = false;
_allowArmaDamage = true;

if(_damage > 0.1) then {
	_allowDamage = true;
	
	if(!isNull _shooter) then {
		if(toLower(_projectile) find "b_" == 0) then {
			
			// on shot visual effects
			addCamShake [5, 1, 50];
			addCamShake [0.45, 500, 6];
			["DynamicBlur", 400, [2]] spawn {
				params ["_name", "_priority", "_effect", "_handle"];
				while {
					_handle = ppEffectCreate [_name, _priority];
					_handle < 0
				} do {
					_priority = _priority + 1;
				};
				_handle ppEffectEnable true;
				_handle ppEffectAdjust _effect;
				_handle ppEffectCommit 0.1;
				waitUntil {ppEffectCommitted _handle};
				
				_handle ppEffectAdjust [0];
				_handle ppEffectCommit 0.5;
				waitUntil {ppEffectCommitted _handle};
				
				_handle ppEffectEnable false;
				ppEffectDestroy _handle;
			};
			
			// bullet damage
			_allowArmaDamage = false;
			if !(_shooter in DS_var_damagedBy) then {
				DS_var_damagedBy pushBack _shooter;
				
				_bloodLoss = _damage * 27500;
				if(_selectionName != "head") then {
					_bloodLoss = _bloodLoss / 1.1; //reduced from 1.25 (25% reduction from base arma damage) 
				};
				DS_var_Blood = DS_var_Blood - _bloodLoss;
				if(_bloodLoss > 10000 || DS_var_Blood < 4000) then {
					[floor(5 + random(10))] spawn ds_fnc_knockOut;
				};
			};
		} else {
			if(_shooter isKindOf "LandVehicle") then {
				addCamShake [0.5, 900, 8];
				_bloodLoss = _damage * 825;
				DS_var_Blood = DS_var_Blood - _bloodLoss;
			} else {
				_fallSpeed = (velocity _unit) select 2;
				if(_fallSpeed < -2) then {
					addCamShake [0.3, 300, 5.5];
					_bloodLoss = _damage * 750;
					DS_var_Blood = DS_var_Blood - _bloodLoss;
				} else {
					addCamShake [0.4, 700, 7];
					_bloodLoss = _damage * 4500;
					DS_var_Blood = DS_var_Blood - _bloodLoss;
				};
			};
		};
	} else {
		_bloodLoss = _damage * 1000;
		DS_var_Blood = DS_var_Blood - _bloodLoss;
	};
	if(_selectionName == "legs") then {
		addCamShake [0.4, 500, 6.5];
		if(!isNil {_damage}) then {
			if(_damage > 0.3) then {
				[_unit] spawn {
					params["_unit"];
					_unit setHitPointDamage ["HitLegs",1];
				};
			};
		};
	};
	if(_selectionName == "head") then {
		addCamShake [0.5, 1300, 8];
		if(lifeState _unit != "INCAPACITATED") then {
			[floor(5 + random(15))] spawn ds_fnc_knockOut;
		};
	};
};
((_damage >= 1) && _allowArmaDamage && _allowDamage);