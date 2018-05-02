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

params["_objectID","_objectName","_messages"];
_object = objectFromNetID _objectID;
if(!isNull _object) then {
	_object setName _objectName;
	{
		_object commandChat _x;
	} forEach _messages;
} else {
	systemchat "THIS IS AN ERROR: REPORT TO DEVS";
	{
		systemchat ("RADIO - " + _objectName + ": " + _x);
	} forEach _messages;
};