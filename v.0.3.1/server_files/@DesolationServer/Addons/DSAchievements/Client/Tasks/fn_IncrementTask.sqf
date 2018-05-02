params["_task",["_amount",1]];

_taskpts = player getVariable ["PVAR_DSA_Task_" + _task,0];
_taskpts = _taskpts + _amount;
player setVariable ["PVAR_DSA_Task_" + _task,_taskpts,true];
