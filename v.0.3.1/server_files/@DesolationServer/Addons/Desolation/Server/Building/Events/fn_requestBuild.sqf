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
params["_entry","_player"];





_crate = (_entry select 6) createVehicle [0,0,0];

_crate setVariable ["oOWNER",_player getVariable ["pUUID",""],true];

_box = boundingBox _crate;
_w = abs(((_box select 1) select 1) - ((_box select 0) select 1));

_posATL = ASLtoATL (AGLtoASL (_player modelToWorld [0,3+_w,0]));
_posATL set[2,0];
_vectorUp = surfaceNormal _posATL;

_crate setDir getDir _player;
_crate setVectorUp _vectorUp;
_crate setPosATL _posATL;
_crate setVariable ["SVAR_buildParams",_entry,true];

_box = boundingBox _crate;
_w = abs(((_box select 1) select 1) - ((_box select 0) select 1));

_crate setVariable ["oWidth",_w,true];

[_crate] remoteExec ["DS_fnc_onBuildableLift",_player]; 
