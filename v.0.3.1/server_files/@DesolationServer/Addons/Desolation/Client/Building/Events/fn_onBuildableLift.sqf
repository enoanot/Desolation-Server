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

 
/// This function is called when the dynamic preview object is being moved 
  
params["_crate"];


player reveal [_crate, 4];

[_crate,player] remoteExec ["DS_fnc_buildableLifted",2]; 
