-- Replace the weapons:server:removeWeaponAmmoItem event at line 286 in qb-weapons/server/main.lua with this
RegisterNetEvent('weapons:server:removeWeaponAmmoItem', function(item)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player or type(item) ~= 'table' or not item.name then return end

    Player.Functions.RemoveItem(item.name, 1)
end)

-- Replace the things in qb-weapons/server/main.lua at line 305 in between the AMMO comment and the TINTS comment

QBCore.Functions.CreateUseableItem('pistol_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_PISTOL', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('rifle_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_RIFLE', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('smg_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SMG', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('shotgun_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SHOTGUN', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('mg_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_MG', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('snp_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_SNIPER', Config.AmmoAmmount[item.name], item)
end)

QBCore.Functions.CreateUseableItem('emp_ammo', function(source, item)
    TriggerClientEvent('weapons:client:AddAmmo', source, 'AMMO_EMPLAUNCHER', Config.AmmoAmmount[item.name], item)
end)

-- Add this to qb-weapons/server/main.lua at line 790

RegisterNetEvent('weapons:server:useAmmo', function(type, caps, item) -- Creates a server event
    local Player = QBCore.Functions.GetPlayer(source) -- Gets the client who triggeret the event from the source (id)
    if QBCore.Functions.CanUseItem(tostring(item.name)) then  -- Cheks if the player can use the item required to reload the wepaon
        TriggerClientEvent('weapons:client:AddAmmo', source, tostring(caps), Config.AmmoAmmount[item.name], item) -- Reloads the weapon
    else
        print("Player cant use the itemn ( "..item.label.." )") -- Prints that the player cant use it to the server console
    end -- Ends the if statement
end) -- Ends the event
