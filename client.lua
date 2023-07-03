-- Add this to qb-weapons/client/main.lua at line 132 - Only add the code under this comment, the next comment tells you where to add more code.

function getAmmoType(AmmoTypeCaps) -- Creates a function
    if AmmoTypeCaps == "AMMO_FLARE" or AmmoTypeCaps == "AMMO_BALL" or AmmoTypeCaps == "AMMO_MINIGUN" or AmmoTypeCaps == "AMMO_STINGER" or AmmoTypeCaps == "AMMO_GRENADELAUNCHER" or AmmoTypeCaps == "AMMO_RPG" or AmmoTypeCaps == "AMMO_SNIPER_REMOTE" or AmmoTypeCaps == "AMMO_STUNGUN" or AmmoTypeCaps == nil then -- Check if weapon uses/needs ammo
        return "ReloadError" -- Weapon don't use ammo, or can't be used with ammo items
    end
    if AmmoTypeCaps == "AMMO_PISTOL" then -- Checks if the weapon is a pistol, and uses pistol ammo
        return "pistol_ammo" -- Returns pistol_ammo (the name of the item used to reload pistols)
    elseif AmmoTypeCaps == "AMMO_SMG" then -- Checks if the weapon is a smg, and uses smg ammo
        return "smg_ammo" -- Returns smg_ammo (the name of the item used to reload smgs)
    elseif AmmoTypeCaps == "AMMO_SHOTGUN" then -- Checks if the weapon is a shotgun, and uses shotgun ammo
        return "shotgun_ammo" -- Returns shotgun_ammo (the name of the item used to reload shotguns)
    elseif AmmoTypeCaps == "AMMO_RIFLE" then -- Checks if the weapon is a rifle, and uses rifle ammo
        return "rifle_ammo" -- Returns rifle_ammo (the name of the item used to reload rifles)
    elseif AmmoTypeCaps == "AMMO_MG" then -- Checks if the weapon is a machine gun, and uses machine gun ammo
        return "mg_ammo" -- Returns mg_ammo (the name of the item used to reload machine guns)
    elseif AmmoTypeCaps == "AMMO_SNIPER" then -- Checks if the weapon is a sniper, and uses sniper ammo
        return "snp_ammo" -- Returns snp_ammo (the name of the item used to reload snipers)
    elseif AmmoTypeCaps == "AMMO_EMPLAUNCHER" then -- Checks if the weapon is a emp launcher, and uses emp ammo
        return "emp_ammo" -- Returns emp_ammo (the name of the item used to reload emp lauchers)
    end
end

RegisterCommand('reloadWeapon', function() -- Creates a command
    local ped = PlayerPedId() -- Gets the players ped
    local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
    local ammoTypeCaps = QBCore.Shared.Weapons[weapon]["ammotype"] -- Gets the native ammotype of the players weapon
    local ammoType = getAmmoType(ammoTypeCaps) -- Gets the name of the item used to realod the players weapon
    local ammoItem = QBCore.Shared.Items[ammoType] -- Gets the item used to reload the players weapon
    -- print(ammoType) -- Debug print
    -- print(json.encode(ammoItem)) -- Debug print
    if ammoType == "ReloadError" then -- Checks if the weapon can be reloaded
        return -- Returns, because there is no point in going further if the weapon can't be reloaded
    end
    if ammoType == "pistol_ammo" then -- Checks if the weapon is a pistol
        -- print("pistol") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the pistol
    end
    if ammoType == "smg_ammo" then -- Checks if the weapon is a smg
        -- print("smg") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the smg
    end
    if ammoType == "shotgun_ammo" then -- Checks if the weapon is a shotgun
        -- print("shotgun") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the shotgun
    end
    if ammoType == "rifle_ammo" then -- Checks if the weapon is a rifle
        -- print("rifle") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)  -- Reloads the rifle
    end
    if ammoType == "mg_ammo" then -- Checks if the weapon is a machine gun
        -- print("mg") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the machine gun
    end
    if ammoType == "snp_ammo" then  -- Checks if the weapon is a sniper
        -- print("sniper") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the sniper
    end
    if ammoType == "emp_ammo" then -- Checks if the weapon is a emp launcher
        -- print("emp") -- Debug print
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem) -- Reloads the emp launcher
    end
end)

-- Add this to qb-weapons/client/main.lua at line 212 under the Threads comment


CreateThread(function() -- Creathes a thread
    while true do -- Repeats the thread until the end of the universe (forever)
        local ped = PlayerPedId() -- Gets the players ped
        local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
        local ammo = GetAmmoInPedWeapon(ped, weapon) -- Gets the total amount of ammo in the players weapon
        local bool, ammoInClip = GetAmmoInClip(ped, weapon) -- Gets the amount of ammo in the players weapons clip
        -- print(ammo) -- Debug print
        -- print(bool) -- Debug print
        -- print(ammoInClip) -- Debug print
        if ammoInClip == 0 then -- Checks if the amount of ammo the the weapons clip is 0
            if ammo == 0 then -- Checks if the total ammount of ammo in the players weapon is 0
                ExecuteCommand('reloadWeapon') -- Reloads the players weapon
                Citizen.Wait(Config.ReloadTime) -- Waits until the reload is done, so the reload isn't triggert 1000 times, and spams the players screen with a notification saying "You are already doing something"
            end
        end
        Citizen.Wait(1) -- Waits so the server isn't getting spammed
    end
end)

Hold = 2 -- Sets the amount of seconds you need to hold down R for your weapon to reload -- Defalt 2 (If you change this value you also need to change the Hold value to this value, where there is a comment saying "Change me if first Hold value is changed")

CreateThread(function() -- Creathes a thread
    while true do -- Repeats the thread until the end of the universe (forever)
        Wait(1000) -- Waits 1 second
        local ped = PlayerPedId() -- Gets the players ped
        local weapon = GetSelectedPedWeapon(ped) -- Gets the players current weapon
        local ammo = GetAmmoInPedWeapon(ped, weapon) -- Gets the total amount of ammo in the players weapon
        local bool, ammoInClip = GetAmmoInClip(ped, weapon) -- Gets the amount of ammo in the players weapons clip
        if IsControlPressed(0, 45) and Hold <= 0 then -- Checks if R is pressed, and if it has been pressed down for 2 seconds (the time set in the Hold value)
            -- print(Hold) -- Debug print
            ExecuteCommand('reloadWeapon') -- Reloads the players weapon
            Citizen.Wait(Config.ReloadTime) -- Waits until the reload is done, so the reload isn't triggert 1000 times, and spams the players screen with a notification saying "You are already doing something"
            Hold = 2 -- Resets the hold value (Change me if first hold value is changed)
            -- print(Hold) -- Debug print
        end
        if IsControlPressed(0, 45) then -- Checks if R is pressed
            if Hold - 1 >= 0 then -- If R is pressed down, check if Hold - 1 is higher then 0
                -- print(Hold) -- Debug print
                Hold = Hold - 1 -- Removes 1 from the Hold value
            else -- If Hold - 1 isn't higher then 0 then Hold is equl to 1 
                -- print(Hold) -- Debug print
                Hold = 0 -- Sets Hold to 0 meaning that R has been hold down for 2 seconds (more if the default value has been changed)
                -- print(Hold) -- Debug print
            end
        end
        if IsControlReleased(0, 45) then -- Checks if R has been released
            Hold = 2 -- Resets the hold value (Change me if first hold value is changed)
        end
        Citizen.Wait(0) -- Waits so the server isn't getting spammed
    end
end)
