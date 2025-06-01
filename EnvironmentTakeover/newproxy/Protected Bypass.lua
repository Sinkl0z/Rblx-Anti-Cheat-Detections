-- Bypass code of the protected newproxy detection version

local OldPcall
OldPcall = hookfunction(getrenv().pcall, function(Function, Level, ...)
    if Function == getfenv then
        if Level <= 5 then
            return true, getfenv(Function)
        end
        return false, [[invalid argument #1 to 'getfenv' (invalid level)]]
    end
    return OldPcall(Function, ...)  
end)
