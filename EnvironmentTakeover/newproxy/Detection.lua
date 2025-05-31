local Scan = true;
local Env  = {};

local FakeRemote = Instance.new("RemoteEvent");
local Proxy      = newproxy(true);

getmetatable(Proxy).__tostring = function()
	for Level = 1, 20 do
		local Success, Result = pcall(getfenv, Level);
		if Success and Result and Result.getgenv then
			for Index, Value in Result.getgenv() do
				Env[Index] = Value;
			end;

			Scan = false;
		end;
	end;

	return "";
end;
while Scan do
	FakeRemote:FireServer({
		[Proxy] = {};
	});
	task.wait(0);
end;

Env.setthreadidentity(8);
warn(Env)
table.foreach(Env, print)
