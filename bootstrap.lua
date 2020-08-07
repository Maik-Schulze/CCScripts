--[[
bootstrap.lua
Date: 05.08.2020
User: Maik-Schulze

Program to download multiple programs in the Minecraft Mod ComputerCraft at once.

Usage:
	> pastebin get prsnEEAi bootstrap
	> bootstrap <DEVICE-TYPE>
--]]

--get the parameters as a table and its lenght.
local argt = { ... }
local argc = #argt

--if the parameter table has more than 1 entry give out an error message and quit.
if (argc ~= 1) then
	print("Syntax Error.")
	print("For tips on correct usage type 'bootstrap help'.")
	return
end

--extract the first parameter.
local first = string.lower(argt[1])

--if the first parameter is 'help' print out some info on how to use this.
if (first == "help") then
	print("bootstrap <DEVICE-TYPE>")
	print("Only <DEVICE-TYPE> and 'help' are valid parameters")
	print("<DEVICE-TYPE> \t has to be either 'turtle' or 'computer'.")
	return
--if the first parameter is 'turtle' download the program belonging to a turtle.
elseif (first == "turtle") then
	http_runs = {
		["pastebin"] = {
			--github loader
			["zvx63NNF"] = "github",
		},
		["github"] = {
			["Maik-Schulze/CCScripts/master/turtleBootstrap.lua"] = "turtleBootstrap",
		},
	}
--if the first parameter is 'computer' download the program belonging to a computer.
elseif (first == "computer") then
	http_runs = {
		["pastebin"] = {
			--github loader
			["zvx63NNF"] = "github",
		},
		["github"] = {
			["Maik-Schulze/CCScripts/master/computerBootstrap.lua"] = "computerBootstrap",
		},
	}
--if the first parameter isn't 'turtle' or 'computer' give out an error message and quit.
else
	print("Syntax Error.")
	print("For tips on correct usage type 'bootstrap help'.")
	return
end

for service, list in pairs(http_runs) do
	for id, program in pairs(list) do
		print("Downloading "..program.." from "..service)
		shell.run(service, "get", id, program)
	end
end

--executes the downloaded programs to download programs specific to the device.
if (first == "turtle") then
	shell.run("turtleBootstrap")
else
	shell.run("computerBootstrap")
end
