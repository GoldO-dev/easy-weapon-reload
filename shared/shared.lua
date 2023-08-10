-- Make a new folder called shared
-- Make a new file called shared.lua in the shared folder

-- Add this to the shared.lua file
function Split(inputstr, sep) -- Creates a function called Split
    if sep == nil then -- Cheks if the sep parameter is nil
        sep = "%s" -- Sets the sep parameter to %s
    end -- Ends the if statement
    local t = {} -- Creates a table called t
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do -- Creates a for loop that loops every bit of the string given that is seperated by the thing given in the sep parameter
        table.insert(t, str) -- Adds the splitted string to a table
    end -- Ends the for loop
    return t -- returns the table with all the splitted string in
end -- Ends the function

function Testing(AmmoTypeCaps) -- Creates a function (Dont change the name unless you change it to the new name in every file)
    local lowerCase = string.lower(AmmoTypeCaps) -- Creates a value that sets the given string to lowercase letters only
    local test = Split(tostring(lowerCase), "_") -- Creates a table with the lowercase letters only string splitted by _
    local Tester = test[2].."_"..test[1] -- Changes the given string so it will be the name of the item to reload the players weapon
    return Tester -- Returns the name of the item needed to reload the players weapon
end -- Ends the function
