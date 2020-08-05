--[[
github.lua
Date: 05.08.2020
User: Maik-Schulze
 
Program to be able to download programs on GitHub in the Minecraft Mod ComputerCraft.
 
Usage:
    > pastebin get zvx63NNF github
    > github get <GITHUB-PATH> <PROGRAM-NAME>
--]]
 
--get the parameters as a table and its lenght.
local argt = { ... }
local argc = #argt
 
--extract the first parameter.
local first = argt[1]
 
--if the first parameter isn't supported give out an error message and quit.
if ((first ~= "get") and (first ~= "help")) then
    print("Syntax Error.")
    print("For tips on correct usage type 'github help'.")
    return
end
 
--if the first parameter is 'help' print out some info on how to use this.
if (first == "help") then
    print("github get <GITHUB-PATH> <PROGRAM-NAME>")
    print("Only 'get' and 'help' are valid first parameters")
    print("get \t\t is used to download a program from github and save it as a local program.")
    print("<GITHUB-PATH> \t has to be a valid github path.")
    print("<PROGRAM-NAME> \t cannot be the name of an existing program.")
    return
end
 
--if the parameter table has more or less entries than 3 give out an error message and quit.
if (argc ~= 3) then
    print("Syntax Error.")
    print("For tips on correct usage type 'github help'.")
    return
end
 
--extract the third parameter.
local program_name = argt[3]
 
--if a file with the chosen program name already exits give out an error message and quit.
if (fs.exists(program_name)) then
    print("File "..program_name.." already exists.")
    return
end
 
--extract the second parameter and construct the raw GitHub url.
local github_url = "https://raw.githubusercontent.com/"..argt[2]
 
--send out a request and read the program in. The request gets closed after that.
local request = http.get(github_url)
local response = request.readAll()
request.close()
 
--open a new file under the chosen program name and paste the GitHub program into it. The file gets closed after that.
local file = fs.open(program_name, "w")
file.write(response)
file.close()
