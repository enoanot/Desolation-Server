
params["_player"];



_pUUID = _player getVariable ["pUUID",""];
if(_pUUID == "") exitWith {"INTERNAL ERROR > Player UUID Not Set When Requesting Owned Buildings";};


_owned = [];
{
	_owner = _x getVariable ["oOWNER",""];
	if(_owner == _pUUID) then {
		_owned pushback _x;
	};
} forEach DB_var_Objects;
