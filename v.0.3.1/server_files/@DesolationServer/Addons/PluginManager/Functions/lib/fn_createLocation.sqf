params["_type","_name","_pos","_size"];

_location = createLocation [ _type , _pos, _size select 0, _size select 1];
_location setText _name;