-- More advanced newproxy detection with more checks & tamper protection

local Scan = true;
local Env  = {};

local FakeRemote = Instance.new("RemoteEvent");
local Proxy      = newproxy(true);

getmetatable(Proxy).__tostring = function()
	for Level = 1, 20 do
		local Success, Result = pcall(getfenv, Level);
		
		if Level <= 5 then
			if not Success then 
				warn(Success, Result, Level, " Level/Hooked 1")
			end
		end
		
		if Success and Result ~= getfenv() then
			warn(Success, Result, Result == getfenv(), " Environment/Hooked 2")
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
	
	warn(Env)
	table.foreach(Env, print)
end;
