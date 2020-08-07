--[[
bootstrap.lua
Date: 05.08.2020
User: Maik-Schulze

Program to download multiple programs in the Minecraft Mod ComputerCraft at once.

Usage:
	> pastebin get prsnEEAi bootstrap
--]]

--if the executing device is 'turtle' download the program belonging to a turtle.
if turtle then
	http_runs = {
		["pastebin"] = {
			--github loader
			["zvx63NNF"] = "github",
		},
		["github"] = {
			["Maik-Schulze/CCScripts/master/turtleBootstrap.lua"] = "turtleBootstrap",
		},
	}
--if not download the program belonging to a computer.
else
	http_runs = {
		["pastebin"] = {
			--github loader
			["zvx63NNF"] = "github",
		},
		["github"] = {
			["Maik-Schulze/CCScripts/master/computerBootstrap.lua"] = "computerBootstrap",
		},
	}
end	

for service, list in pairs(http_runs) do
	for id, program in pairs(list) do
		print("Downloading "..program.." from "..service)
		shell.run(service, "get", id, program)
	end
end

--executes the downloaded programs to download programs specific to the device.
if turtle then
	shell.run("turtleBootstrap")
else
	shell.run("computerBootstrap")
end
