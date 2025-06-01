local Scan = true;
local Env  = {};

local FakeRemote = Instance.new("RemoteEvent");
local Proxy      = newproxy(true);

getmetatable(Proxy).__tostring = function()
	for Level = 1, 20 do
		local Success, Result = pcall(getfenv, Level);
		
		if Level <= 5 and not Success then
			warn(Success, Result, Level, " Level/Hooked 1")
		end
		
		if Success and Result ~= getfenv() then
			warn(Success, Result, getfenv(), Result == getfenv(), " Environment/Hooked 2")
		end
	
		if not Success and Result ~= "invalid argument #1 to 'getfenv' (invalid level)" then
			warn(Success, Result, " Protected Call/Hooked 3")
		end
	
		if Success and Result and Result.getgenv then
			for Index, Value in Result.getgenv() do
				Env[Index] = Value;
			end;

			Scan = false;
		end;
	end;

	return "";
end;
while task.wait(1) do
	FakeRemote:FireServer({
		[Proxy] = {};
	});
	
	--warn(Env)
	--print(#Env)
	--table.foreach(Env, print)
end;
