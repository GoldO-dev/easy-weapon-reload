-- Add this to qb-weapons/server/main.lua at line 790

function getAmmoType(AmmoTypeCaps)
    if AmmoTypeCaps == "AMMO_FLARE" or AmmoTypeCaps == "AMMO_BALL" or AmmoTypeCaps == "AMMO_MINIGUN" or AmmoTypeCaps == "AMMO_STINGER" or AmmoTypeCaps == "AMMO_GRENADELAUNCHER" or AmmoTypeCaps == "AMMO_RPG" or AmmoTypeCaps == "AMMO_SNIPER_REMOTE" or AmmoTypeCaps == "AMMO_STUNGUN" or AmmoTypeCaps == nil then
        return
    elseif AmmoTypeCaps == "AMMO_PISTOL" then
        return "pistol_ammo"
    elseif AmmoTypeCaps == "AMMO_SMG" then
        return "smg_ammo"
    elseif AmmoTypeCaps == "AMMO_SHOTGUN" then
        return "shotgun_ammo"
    elseif AmmoTypeCaps == "AMMO_RIFLE" then
        return "rifle_ammo"
    elseif AmmoTypeCaps == "AMMO_MG" then
        return "mg_ammo"
    elseif AmmoTypeCaps == "AMMO_SNIPER" then
        return "snp_ammo"
    elseif AmmoTypeCaps == "AMMO_EMPLAUNCHER" then
        return "emp_ammo"
    end
end
RegisterNetEvent('weapons:server:useAmmo', function(type, item)
    local Player = QBCore.Functions.GetPlayer(source)
    -- print(type) -- Debug print
    -- print(item) -- Debug print
    if type == "pistol_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_PISTOL', 12, item)
    end
    if type == "rifle_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_RIFLE', 30, item)
    end
    if type == "smg_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SMG', 20, item)
    end
    if type == "shotgun_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SHOTGUN', 10, item)
    end
    if type == "snp_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SNIPER', 10, item)
    end
    if type == "mg_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_MG', 30, item)
    end
    if type == "emp_ammo" then
        TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_EMPLAUNCHER', 10, item)
    end
end)
