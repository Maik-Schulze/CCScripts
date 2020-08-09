--Slot Settings
local torchSlot = 1
local chestSlot = 2
local coalSlot = 3
local buildingSlot = 4
--Mine Settings
local branchAmount = 15
local branchLenght = 8
local rootLenght = 3


local err = false
local fuelUsage = (rootLenght + (branchLenght * 4) + 9) * branchAmount

local function refuel()
	if (turtle.getFuelLevel() < (fuelUsage + 1)) then
		turtle.select(coalSlot)
		turtle.refuel(fuelUsage / 80)
	end
end

local function check()
	local torch = turtle.getItemDetail(torchSlot)
	if ((torch.name ~= "minecraft:torch") or (torch.count == 0)) then 
		print("No torches in slot "..torchSlot.."!")
		err = true
	else
		print("There are "..torch.count.." torches in slot "..torchSlot.."!")
	end
	
	local chest = turtle.getItemDetail(chestSlot)
	if ((chest.name ~= "minecraft:chest") or (chest.count == 0)) then 
		print("No chests in slot "..chestSlot.."!")
		err = true 
	else
		print("There are "..chest.count.." chests in slot "..chestSlot.."!")
	end
	
	local coal = turtle.getItemDetail(coalSlot)
	if ((coal.name ~= "minecraft:coal") or (coal.count <= (fuelUsage / 80)) or (turtle.getFuelLevel() == 0)) then 
		print("No coal in turtle or slot "..coalSlot.."!")
		err = true
	else
		print("There are "..coal.count.." pieces of coal in slot "..coalSlot.." and the fuel level is "..turtle.getFuelLevel().."!")
	end
	
	local building = turtle.getItemDetail(buildingSlot)
	if ((building.name ~= "minecraft:cobblestone") or (building.count == 0)) then 
		print("No cobblestone in slot "..buildingSlot.."!")
		err = true 
	else
		print("There are "..building.count.." cobblestone in slot "..buildingSlot.."!")
	end
	
	if (err == true) then
		print("An Error occurred.")
	end
end

local function stashItems()
	if turtle.getItemCount(16) > 0 then
		turtle.select(chestSlot)
		turtle.digDown()
		turtle.placeDown()
		for slot = 5, 16, 1 do
			turtle.select(slot)
			turtle.dropDown()
			sleep(0.5)
		end
		turtle.select(5)
	end
end

local function placeTorch()
	turtle.up()
	turtle.turnLeft()
	if (turtle.detect() == false) then
		turtle.select(buildingSlot)
		turtle.place()
	end
	turtle.turnRight()
	turtle.down()
	turtle.select(torchSlot)
	turtle.placeUp()
end

local function digAndMove()
	repeat
		turtle.dig()
	until turtle.detect() == false
	
	turtle.forward()
	
	if turtle.detectDown() == false then
		turtle.select(buildingSlot)
		turtle.placeDown()
	end
	
	repeat
		turtle.digUp()
	until turtle.detectUp() == false
end

local function turnAround()
	turtle.turnLeft()
	turtle.turnLeft()
end

local function mine()
	for i = 0, rootLenght, 1 do
		digAndMove()
	end
	
	turtle.back()
	placeTorch()
	turtle.forward()
	turtle.turnLeft()
	
	for i = 1, branchLenght, 1 do
		digAndMove()
	end
	
	placeTorch()
	
	turnAround()
	
	for i = 1, branchLenght * 2, 1 do
		digAndMove()
	end
	
	placeTorch()
	
	turnAround()
	
	for i = 1, branchLenght, 1 do
		digAndMove()
	end
	
	turtle.turnRight()
end

for i = 1, branchAmount do
	term.clear()
	refuel()
	stashItems()
	check()
	if (err == true) then
		repeat
			sleep(10)
			term.clear()
			refuel()
			check()
		until err == 0
	end
	mine()
end
