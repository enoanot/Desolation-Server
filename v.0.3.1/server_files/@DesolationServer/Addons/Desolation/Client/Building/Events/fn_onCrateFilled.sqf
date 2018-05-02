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
params["_crate"];
[1] call DS_fnc_addPoints;
["DS_var_constructionDoneCallbackFnc",["objects_built",[_crate]]] call DS_fnc_handleCallback;
[_crate] remoteExec ["DS_fnc_finishBuild",2];
