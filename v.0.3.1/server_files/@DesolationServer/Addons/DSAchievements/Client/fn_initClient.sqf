

DSA_var_callBackTypes = [];
["items_crafted","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["objects_built","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["mags_combined","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["num_drinks","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["num_eats","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["fires_lit","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["bandage_self","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["bandage_others","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["bloodbag_others","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["bloodbag_self","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["splint_self","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["splint_others","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
["trees_chopped","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType;
["rocks_mined","DSA_fnc_defaultTaskHandler"] call DSA_fnc_registerCallbackType; 
waitUntil{!isNil "ACH_DATA"};


// register callbacks
DS_var_treeChoppedCallbackFnc = "DSA_fnc_handleCallback";
DS_var_rocksMinedCallbackFnc = "DSA_fnc_handleCallback";