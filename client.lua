

-- Add this to qb-weapons/client/main.lua at line 131 - Only add the code under this comment, the next comment tells you where to add more code.

local hold = Config.HoldToReload -- Creates a local value called hold that looks at the HoldToReload value in the qb-weapons/config.lua
local isReloading = false -- Creates a boolean that tells if the player is reloading or not
local isLoadedIn = false -- Creates a boolean that tells if the player is loaded into the server or not

function hasForbiddenType(weapon) -- Creates a global function called hasForbiddenType
    for k, v in pairs(Config.forbiddenTypes) do -- Creates a for loop that loops all forbiddenTypes set in the qb-weapons/config.lua through
        if tostring(QBCore.Shared.Weapons[weapon]["ammotype"]) == v then -- Checks if the weapon the player has equipped is one of the forbiddenTypes set in the qb-weapons/config.lua through
            return true -- If the weapon the player has equipped is one of the forbiddenTypes returns true
        end -- Ends the if statement
    end -- Ends the for loop
end -- Ends the function

AddEventHandler('QBCore:Client:OnPlayerLoaded', function() --Listens for the 'QBCore:Client:OnPlayerLoaded' event
    isLoadedIn = true -- Sets the isLoadedIn boolean to true meaning that the player is loaded into the server
end)

RegisterCommand('reloadWeapon', function() -- Creates a command
    local ped = PlayerPedId() -- Gets the players ped
    local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
    if isLoadedIn and weapon ~= nil then -- Checks if the player is loaded into the server and if the weapon the player has equipped isn't nil
        if hasForbiddenType(weapon) then return end -- Checks if the hasForbiddenType function returns true (the player has a weapon with a forbidden type) if it returns true then returns/stops the funciton / 2. if statement
        
        Wait(5) -- Waits 5 miliseconds 
    
        local ammoTypeCaps = QBCore.Shared.Weapons[weapon]["ammotype"] -- Gets the native ammotype of the players weapon
        local ammoType = Testing(ammoTypeCaps) -- Returns the name of the item used to reload the players weapon
        local ammoItem = QBCore.Shared.Items[tostring(ammoType)] -- Gets the table with the info on the item used to reload the players weapon
        if QBCore.Functions.HasItem(tostring(ammoItem.name)) then -- Checks if the player has the item needed to reload the weapon
            isReloading = true -- Sets the isReloading boolean to true meaning that the player is reloading its weapon
            TriggerServerEvent('weapons:server:useAmmo', tostring(ammoType), ammoTypeCaps, ammoItem) -- Triggers the server event that should do the reloading
            Wait(Config.ReloadTime+5) -- Waits the time it takes to reload the weapon + 5 miliseconds
            isReloading = false -- Sets the isReloading boolean to false meaning that the player is done reloading its weapon
        else
            --QBCore.Functions.Notify(Lang:t('error.no_ammo'), "error") -- Tells the player that it dont have the item needed to reload the weapon
            return -- Stops the function
        end -- Ends the has item check (the 3. if statement)
    else 
        return -- Stops the function
    end -- Ends the 1. if statement
end)

-- Add this to qb-weapons/client/main.lua at line 177 under the Threads comment

CreateThread(function() -- Creates a thread
    while true do -- Creates a loop
        local ped = PlayerPedId() -- Gets the players ped
        local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
        if isLoadedIn and weapon ~= nil then  -- Checks if the player is loaded into the server and if the weapon the player has equipped isn't nil
            if not hasForbiddenType(weapon) and not isReloading then -- Checks if the hasForbiddenType function returns true (the player has a weapon with a forbidden type) and if the player isn't reloading 
                Wait(1000) -- Waits 1000 miliseconds (1 second)
                if IsControlPressed(0, 45) and hold <= 0 then -- Checks if the player has hold R down in the time set in qb-weapons/config.lua
                    ExecuteCommand('reloadWeapon') -- Runs the command that does the reloading
                    hold = Config.HoldToReload -- Resets the hold value
                    Wait(Config.ReloadTime+50) -- Waits the time it takes to reload the weapon + 50 miliseconds
                end -- Ends the 3. if statement
                if IsControlPressed(0, 45) then -- Chels of the player is holding R down
                    if hold - 1 >= 0 then -- Checks if hold is - 1 is larger or equals to 0
                        hold = hold - 1 -- Removes 1 from second from the hold value
                    else
                        hold = 0 -- Sets the hold value to 0
                    end -- Ends the 5. if statement
                end -- Ends the 4. if statement
                if IsControlReleased(0, 45) then -- Checks if the player stopped holding R down
                    hold = Config.HoldToReload -- Resets the hold value
                end -- Ends the 6. if statement
            end -- Ends the 2. if statement
            Wait(20) -- Waits 20 miliseconds 
        end -- Ends the 1. if statement
        Wait(1200) -- Waits 1200 miliseconds (1 second and 200 miliseconds)
    end -- Ends the loop
end) -- Ends the thread

CreateThread(function() -- Creates a thread 
    while true do -- Creates a loop
        local ped = PlayerPedId() -- Gets the players ped
        local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
        local ammoInWeapon = GetAmmoInPedWeapon(ped, weapon) -- Gets the ammo in the players current weapon
        local bool, ammoInClip = GetAmmoInClip(ped, weapon) -- Gets the ammo in the clip of the players current weapon
        if isLoadedIn and weapon ~= nil and weapon ~= 0 then -- Checks if the player is loaded into the server and if the weapon the player has equipped isn't nil
            if not hasForbiddenType(weapon) and not isReloading then -- Checks if the hasForbiddenType function returns true (the player has a weapon with a forbidden type) and if the player isn't reloading 
                if ammoInWeapon == 0 and ammoInClip == 0 then -- Cheks if the weapon have 0 ammo
                    Wait(10) -- Waits 10 miliseconds 
                    ExecuteCommand('reloadWeapon') -- Runs the command that does the reloading
                    Wait(Config.ReloadTime+250) -- Waits the time it takes to reload the weapon + 250 miliseconds
                end -- Ends the 3. if statement
            end -- Ends the 2. if statement
            Wait(200) -- Waits 200 miliseconds 
        end -- Ends the 1. if statement
        Wait(1200) -- Waits 1200 miliseconds (1 second and 200 miliseconds)
    end -- Ends the loop
end) -- Ends the thread
