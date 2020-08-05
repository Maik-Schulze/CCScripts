local distance = 15
local branchLenght = 8
local rootLenght = 3
local torchSlot = 1
local chestSlot = 2
local fuelSlot = 3
local buildingSlot = 4
local err = false

local function check()
	local torch = turtle.getItemCount(1)
	if torch == 0 then
		print("There are no torches in slot 1 the turtle.")
		err = true
	else
		print("There are", torch, "torches in the turtle.")
	end
	
	local chest = turtle.getItemCount(2)
	if chest == 0 then
		print("There are no chests in slot 2 the turtle.")
		err = true
	else
		print("There are", chest, "chests in the turtle.")
	end
	
	local fuel = turtle.getItemCount(3)
	local fuelLevel = turtle.getFuelLevel()
	if fuel == 0 and fuelLevel == 0 then
		print("There are no fuel and fuel items in slot 3 in the turtle.")
		err = true
	else
		print("There are", fuel, "fuel items and", fuelLevel, "fuel in the turtle.")
	end
	
	local building = turtle.getItemCount(4)
	if building == 0 then
		print("There are no building blocks in slot 4 the turtle.")
		err = true
	else
		print("There are", building, "building blocks in the turtle.")
	end
	
	if turtle.getItemCount(16) > 0 then
		turtle.select(chestSlot)
		turtle.digDown()
		turtle.placeDown()
		for slot = 5, 16, 1 do
			turtle.select(slot)
			turtle.dropDown()
			sleep(1.5)
		end
		turtle.select(5)
	end
end

local function refuel()
	local fuel = turtle.getFuelLevel()
	while (turtle.getItemCount(fuelSlot) > 0) and (turtle.getFuelLevel() < 100) do
		turtle.select(fuelSlot)
		turtle.refuel(1)
		fuel = fuel - 1
	end
end

local function placeTorch()
	turtle.up()
	turtle.turnLeft()
	if turtle.detect() == false then
		turtle.select(buildingSlot)
		turtle.place()
	end
	turtle.turnRight()
	turtle.down()
	turtle.select(torchSlot)
	turtle.placeUp()
end

local function dMove()
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
		dMove()
	end
	
	turtle.back()
	placeTorch()
	turtle.forward()
	turtle.turnLeft()
	
	for i = 1, branchLenght, 1 do
		dMove()
	end
	
	placeTorch()
	
	turnAround()
	
	for i = 1, branchLenght * 2, 1 do
		dMove()
	end
	
	placeTorch()
	
	turnAround()
	
	for i = 1, branchLenght, 1 do
		dMove()
	end
	
	turtle.turnRight()
end

for i = 1, distance, 1 do
	refuel()
	check()
	if Error == 1 then 
		print("Not enough resources, need a refill.")
		repeat
			sleep(10)
			Recheck()
			Check()
		until Error == 0
	end
	mine()
end