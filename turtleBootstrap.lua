--[[
turtleBootstrap.lua
Date: 05.08.2020
User: Maik-Schulze

This is effectively a copy of 'bootstrap.lua'
that downloads more programs for the turtle
in the Minecraft Mod ComputerCraft.

Usage:
  > github get Maik-Schulze/CCScripts/master/turtleBootstrap.lua turtleBootstrap
  > turtleBootstrap
--]]

http_runs = {
	["github"] = {
		["Maik-Schulze/CCScripts/master/strip.lua"] = "strip",
		["Maik-Schulze/CCScripts/master/format.lua"] = "format",
	},
}

for service, list in pairs(http_runs) do
	for id, program in pairs(list) do
		print("Downloading "..program.." from "..service)
		shell.run(service, "get", id, program)
	end
end
