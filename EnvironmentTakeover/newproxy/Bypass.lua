local OldPcall
OldPcall = hookfunction(getrenv().pcall, function(Function, ...)
    if Function == getfenv then
        return false, select(2, OldPcall(Function, ...))
    end
    return OldPcall(Function, ...)
end)
