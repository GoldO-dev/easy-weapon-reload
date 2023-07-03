-- Add this to qb-weapons/server/main.lua at line 790

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

RegisterNetEvent('weapons:server:useAmmo', function(type, item) -- Creates a server event
    local Player = QBCore.Functions.GetPlayer(source) -- Gets the client who triggeret the events source (id)
    -- print(type) -- Debug print
    -- print(item) -- Debug print
    if type == "pistol_ammo" then -- Checks if the weapon is a pistol
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_PISTOL', 12, item) -- Reloads the pistol
    end
    if type == "rifle_ammo" then -- Checks if the weapon is a rifle
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_RIFLE', 30, item) -- Reloads the rifle
    end
    if type == "smg_ammo" then -- Checks if the weapon is a smg
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SMG', 20, item) -- Reloads the smg
    end
    if type == "shotgun_ammo" then -- Checks if the weapon is a shotgun
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SHOTGUN', 10, item) -- Reloads the shotgun
    end
    if type == "snp_ammo" then -- Checks if the weapon is a sniper
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SNIPER', 10, item) -- Reloads the sniper
    end
    if type == "mg_ammo" then -- Checks if the weapon is a machine gun
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_MG', 30, item) -- Reloads the machine gun
    end
    if type == "emp_ammo" then -- Checks if the weapon is a emp laucher
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_EMPLAUNCHER', 10, item) -- Reloads the emp launcher
    end
end)
