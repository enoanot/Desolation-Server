params["_object"];
_owner = _object getVariable ["oOWNER",""];
if(_owner == "") exitWith {false};

_player = player getVariable ["pUUID",""];
(_player == _owner);