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

#include "\DesoDB\constants.hpp"

_request = [PROTOCOL_LIBARY_FUNCTION_TERMINATE_ALL,[]];
[_request] call DB_fnc_sendRequest;
true