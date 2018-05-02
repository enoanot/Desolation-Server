// Credits: KillZoneKid
// http://killzonekid.com/arma-scripting-tutorials-float-to-string-position-to-string/
//
private "_fnc"; 
_fnc = { 
	if (_this < 0) then { 
		str ceil _this + (str (_this - ceil _this) select [2]) 
	} else { 
		str floor _this + (str (_this - floor _this) select [1]) 
	}; 
}; 
format [ 
	"[%1,%2,%3]", 
	_this select 0 call _fnc, 
	_this select 1 call _fnc, 
	_this select 2 call _fnc 
] 