
params["_array"];

private ["_newArray"];
_newArray = [];
while{count(_array) > 0} do {
	_newArray pushBack (_array deleteAt floor(random(count(_array))));
};

_newArray;