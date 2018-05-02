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
 
// _worldPos = position of the icon in world space
// _menuList = array of available menu actions
// _selected = number of action selected (if any)

params["_screenPos", "_menuList", "_selected"];
private ["_ctrlDisplay", "_menuSize", "_txtOffset", "_menuPos", "_txtPos", "_maxMenuItems", "_menuColor", "_assetPath"];

_menuSize = 300;
_txtOffset = 150;
_maxMenuItems = 4;
_ctrlDisplay = ((findDisplay 12) displayCtrl 51);
_menuPos = _ctrlDisplay ctrlMapScreenToWorld _screenPos;
_newTextPos = [
	[
		(_screenPos select 0) - (70*pixelW*(pixelGridBase/18)), 
		(_screenPos select 1) - (165*pixelH*(pixelGridBase/18)),
		150*pixelW*(pixelGridBase/18),
		100*pixelH*(pixelGridBase/18)
	],
	[
		(_screenPos select 0) + (90*pixelW*(pixelGridBase/18)), 
		(_screenPos select 1) - (40*pixelH*(pixelGridBase/18)),
		100*pixelW*(pixelGridBase/18),
		150*pixelH*(pixelGridBase/18)
	],
	[
		(_screenPos select 0) - (70*pixelW*(pixelGridBase/18)), 
		(_screenPos select 1) + (115*pixelH*(pixelGridBase/18)),
		150*pixelW*(pixelGridBase/18),
		100*pixelH*(pixelGridBase/18)
	],
	[
		(_screenPos select 0) - (185*pixelW*(pixelGridBase/18)), 
		(_screenPos select 1) - (40*pixelH*(pixelGridBase/18)),
		100*pixelW*(pixelGridBase/18),
		150*pixelH*(pixelGridBase/18)
	]
];



_menuColor = [0.6627, 0.6627, 0.6627, 1];

_ctrlDisplay drawIcon ['\dsr_ui\Assets\repair\menu.paa', _menuColor, _menuPos, _menuSize, _menuSize, 0, "", 0, 0.01, 'TahomaB', 'Center'];


for "_i" from 0 to (_maxMenuItems - 1) do {
	_color = [0.5607, 0.7372, 0.5607, 0.9];
	if (_i < count(_menuList)) then {
		if (_selected == (_i + 1)) then {
			_color = [0.2, 0.9725, 0.8627, 1];
		};
	};
	_assetPath = format [ '\dsr_ui\Assets\repair\opt%1.paa', (_i + 1) ];
	_ctrlDisplay drawIcon [_assetPath, _color, _menuPos, _menuSize, _menuSize, 0, '', 0, 0.04, 'TahomaB', 'Center'];
};


_renderText = {
	disableserialization;
	params["_text","_pos","_layer"];
	private["_display","_control"];
	 _layer cutrsc["rscDynamicText", "plain"];
	
    _display = uinamespace getvariable "BIS_dynamicText";
    _control = _display displayctrl 9999;
    _control ctrlsetposition _pos;
	_control ctrlsetstructuredtext parseText ("<t shadow='0' align='center' size='0.7' color='#000000'>" + _text + "</t>");
	_control ctrlcommit 0;
};

_layers = [];
for "_i" from 0 to count(_menuList)-1 do
{
	_menuString = (_menuList select _i);
	_layers pushBack (7000+_i);
	[_menuString,_newTextPos select _i,7000+_i] call _renderText;
};

_layers;