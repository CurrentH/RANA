local publicClass={};

local var1 = 1
local var2 = 1

function publicClass.printVar()
    l_debug(var1.." "..var2)
end;

function publicClass.incrementValue()
    var1 = var1+1
end

return publicClass;
