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

#include "..\constants.hpp"

params["_request",["_isScheduled",true]];
private["_response","_compiledResponse","_uuid", "_finalResponse","_return","_doswitchloop","_innerdoloop"];

_originalrequest = _request;
_response = ("libredex" callExtension _request) select 0;
_compiledResponse = call compile _response;

_doswitchloop = true;
_return = _response; //fix if result does not contain a msg type header
// do loop because there seems to be no "fall throu"
while{_doswitchloop} do {
    _doswitchloop = false;

    switch (_compiledResponse select 0) do
    {
       /*
        * TODO: handle async stuff
        * case PROTOCOL_MESSAGE_TYPE_ASYNC 
        * save uuid from select 1
        * if UUID == emptystring exit script (will be an async request without response)
        * loop callExtension with PROTOCOL_LIBARY_FUNCTION_CHECK_MESSAGE_STATE with UUID until _response != PROTOCOL_MESSAGE_NOT_EXISTING
        * loop callExtension with PROTOCOL_LIBARY_FUNCTION_RECEIVE_MESSAGE with UUID until _response == PROTOCOL_MESSAGE_TRANSMIT_FINISHED_MSG and sumup strings in _finalResponse
        * _compiledResponse =  call compile _finalResponse;
        * continue as usual if it where no async string
        * _doswitchloop = true;
        */ 
        case PROTOCOL_MESSAGE_TYPE_ASYNC: {
            _uuid = _compiledResponse select 1;
            _return = "";

            /* empty uuid means function call without retuning data e.g. updates */
            if (_uuid != "") then {
                _request = [PROTOCOL_DBCALL_FUNCTION_RETURN_ASYNC_MSG,  ["msguuid", _uuid]];

                _innerdoloop = true;
                while{_innerdoloop} do {
                    _response = ("libredex" callExtension _request) select 0;

                    if(_response == PROTOCOL_MESSAGE_NOT_EXISTING) then {
                    	if (canSuspend) then {
                    		uiSleep 0.5;
                    	} else {
                    		diag_log "cannot sleep in context of";
                    		diag_log _originalrequest;
                    	};
                    } else {
                        _innerdoloop = false;
                    };
                };
                
                _compiledResponse = call compile _response;
                
                _doswitchloop = true;
            };
        };
        
        case PROTOCOL_MESSAGE_TYPE_MESSAGE: {
            _return = _compiledResponse select 1;
        };
        
        case PROTOCOL_MESSAGE_TYPE_MULTIPART: {
            _uuid = _compiledResponse select 1;
            _finalResponse = _compiledResponse select 2;
            
            _request = [PROTOCOL_LIBARY_FUNCTION_RECEIVE_MESSAGE, ["msguuid", _uuid]];
			
            _innerdoloop = true;
            while{_innerdoloop} do {
                _response = ("libredex" callExtension _request) select 0;

                if(_response != PROTOCOL_MESSAGE_TRANSMIT_FINISHED_MSG) then {
                    _finalResponse = _finalResponse + _response;
                } else {
                    _innerdoloop = false;
                };
            };
            
            _compiledResponse = call compile _finalResponse;
            _doswitchloop = true;
        };

        case PROTOCOL_MESSAGE_TYPE_ERROR: {
            // log error
            diag_log (_compiledResponse select 1);
            
            // handle error, do something terrible like set the server on fire

            // return some information
            _return = "error";
        };
    };
};

if(isNil {_return}) exitWith {
	diag_log ("DB RESPONSE > NIL RETURN");
	"";
};
_return;