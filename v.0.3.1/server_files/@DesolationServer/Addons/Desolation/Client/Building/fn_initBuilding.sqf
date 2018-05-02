DS_Var_valid3DBuildIcons = [];
 
 
addMissionEventHandler["Draw3D",{
	{
		_text = _x select 0;
		_pos = _x select 1;
		_remaining = _x select 2;
		_object = _x select 3;
		drawIcon3D
		[
			"",
			[1 - _remaining, _remaining, 0, 1],
			_pos,
			1*1.5,
			1*1.5,
			0,
			_text,
			2,
			0.05 * (sqrt((2 / (player distance _object))) min 1),
			"LauHoWi_a"
		];
	} count DS_Var_valid3DBuildIcons;
}];
 
while{true} do {
	_crate = cursorTarget;
	if ((player distance _crate) < 10) then
	{
		_data = _crate getVariable ["SVAR_buildParams", [[]]];
		_requirements = _data select 0;
		 
		_crateMags = getMagazineCargo _crate;
		_crateItems = call compile tolower(str(_crateMags select 0));
		_crateCounts = _crateMags select 1;
		_cratePos = getPosATL _crate;
		 
		_validIcons = [];
		_i = 1;
		
		{
			_class = toLower(_x select 0);
			_maxAmount = _x select 1;
			
			_itemCount = 0;
			
			_index = _crateItems find _class;
			if(_index != -1) then {
				_itemCount = _crateCounts select _index;
			};
			
			_pos = +_cratePos;
			_pos set [2, (_pos select 2) + (_i / 5)];
			_text = getText(configFile >> "CfgMagazines" >> _class >> "displayName");
			if(_text == "") then {
				_text = _class;
			};
			_text = _text + " ( " + str(_itemCount) + " / " + str(_maxAmount) + " )";
			
			
			_validIcons pushBack [_text, _pos, (_itemCount / _maxAmount),_crate];
			
			_i = _i + 1;
			
			true
		} count _requirements;
		
		if !(_validIcons isEqualTo DS_Var_valid3DBuildIcons) then
		{
			DS_Var_valid3DBuildIcons = _validIcons;
		};
	} else {
		DS_Var_valid3DBuildIcons = [];
	};
	uiSleep 0.1;
};