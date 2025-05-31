-- Bypass code of the protected newproxy detection version

local OldPcall
OldPcall = hookfunction(getrenv().pcall, function(Function, Level, ...)
    if Function == getfenv then
        if Level >= 5 then
            return true, select(2, OldPcall(Function, Level, ...))
        end
        return false, select(2, OldPcall(Function, Level, ...))
    end
    return OldPcall(Function, ...)
end)
