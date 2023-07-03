-- Add this to qb-weapons/client/main.lua at line 132 - Only add the code under this comment, the next comment tells you where to add more code.

function getAmmoType(AmmoTypeCaps)
    if AmmoTypeCaps == "AMMO_FLARE" or AmmoTypeCaps == "AMMO_BALL" or AmmoTypeCaps == "AMMO_MINIGUN" or AmmoTypeCaps == "AMMO_STINGER" or AmmoTypeCaps == "AMMO_GRENADELAUNCHER" or AmmoTypeCaps == "AMMO_RPG" or AmmoTypeCaps == "AMMO_SNIPER_REMOTE" or AmmoTypeCaps == "AMMO_STUNGUN" or AmmoTypeCaps == nil then
        return "ReloadError"
    end
    if AmmoTypeCaps == "AMMO_PISTOL" then
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

RegisterCommand('reloadWeapon', function()
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local ammoTypeCaps = QBCore.Shared.Weapons[weapon]["ammotype"]
    local ammoType = getAmmoType(ammoTypeCaps)
    local ammoItem = QBCore.Shared.Items[ammoType]
    -- print(ammoType) -- Debug print
    -- print(json.encode(ammoItem)) -- Debug print
    if ammoType == "ReloadError" then
        return
    end
    if ammoType == "pistol_ammo" then
        print("pistol")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "smg_ammo" then
        print("smg")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "shotgun_ammo" then
        print("shotgun")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "rifle_ammo" then
        print("rifle")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "mg_ammo" then
        print("mg")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "snp_ammo" then
        print("sniper")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
    if ammoType == "emp_ammo" then
        print("emp")
        TriggerServerEvent('weapons:server:useAmmo', ammoType, ammoItem)
    end
end)

-- Add this to qb-weapons/client/main.lua at line 212 under the Threads comment


CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        local ammo = GetAmmoInPedWeapon(ped, weapon)
        local bool, ammoInClip = GetAmmoInClip(ped, weapon)
        -- print(ammo) -- Debug print
        -- print(bool) -- Debug print
        -- print(ammoInClip) -- Debug print
        if ammoInClip == 0 then
            if ammo == 0 then
                ExecuteCommand('reloadWeapon')
                Citizen.Wait(Config.ReloadTime)
            end
        end
        Citizen.Wait(1)
    end
end)

Hold = 2

CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local weapon = GetSelectedPedWeapon(ped)
        local ammo = GetAmmoInPedWeapon(ped, weapon)
        local bool, ammoInClip = GetAmmoInClip(ped, weapon)
        if IsControlPressed(0, 45) and Hold <= 0 then
            -- print(Hold) -- Debug print
            ExecuteCommand('reloadWeapon')
            Citizen.Wait(Config.ReloadTime)
            Hold = 2
            -- print(Hold) -- Debug print
        end
        if IsControlPressed(0, 45) then
            if Hold - 1 >= 0 then
                -- print(Hold) -- Debug print
                Hold = Hold - 1
            else
                -- print(Hold) -- Debug print
                Hold = 0
                -- print(Hold) -- Debug print
            end
        end
        if IsControlReleased(0, 45) then
            Hold = 1
        end
        Citizen.Wait(0)
    end
end)
