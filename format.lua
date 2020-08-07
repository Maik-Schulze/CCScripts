--[[
format.lua
Date: 07.08.2020
User: Maik-Schulze
 
Program to be able to format a computer or turtle in the Minecraft Mod ComputerCraft.

Usage:
	> format
--]]

for _, f in pairs(fs.list("/")) do
	if not ((fs.isReadOnly(f)) or (f == "startup.lua")) then
		fs.delete(f)
	end
end
