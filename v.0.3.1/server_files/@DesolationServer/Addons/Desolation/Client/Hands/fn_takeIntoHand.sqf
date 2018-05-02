params["_item_classname",["_modelIndex",0]];
private["_config","_models","_model","_hand"];

if(!isNull DS_var_ItemInHands) then {
	deleteVehicle DS_var_ItemInHands;
};


_config = configFile >> "CfgHoldables" >> _item_classname;
_models = getArray(_config >> "Models");
_hand = getText(_config >> "Hand");


if(count(_models) == 0) exitWith {};
if(count(_models) <= _modelIndex) exitWith {};
if(_hand == "") then {_hand = "right";};


_model = _models select _modelIndex;


DS_var_ItemInHands = [_model,_hand,{
	params["_obj"];
	private["_delete"];
	
	_delete = (currentWeapon player != "");
	_delete = _delete || (vehicle player != player);
	_delete = _delete || (!alive player);
	
	
	if(_delete) then {
		deleteVehicle _obj;
	};
	

}] call BASE_fnc_attachToHand;