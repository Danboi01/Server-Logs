Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            local ped = PlayerPedId()
            local killer = GetPedKiller(ped)
            local weaponHash = GetPedCauseOfDeath(ped)
            local deathReason = "Died from Natural Causes"

            if killer ~= 0 then
                if IsPedAPlayer(killer) then
                    local killerId = NetworkGetPlayerIndexFromPed(killer)
                    deathReason = "Killed by Player (" .. GetPlayerName(killerId) .. ") using " .. GetWeaponName(weaponHash)
                else
                    deathReason = "Killed by NPC using " .. GetWeaponName(weaponHash)
                end
            elseif weaponHash then 
                deathReason = GetEnvironmentDeathReason(weaponHash)
            else
                deathReason = "Died from Natural Causes"
            end

            TriggerServerEvent('playerDied', deathReason)

            while IsEntityDead(ped) do
                Citizen.Wait(0)
            end
        end
    end
end)


function GetWeaponName(hash)
    local weaponNames = {
        [GetHashKey("WEAPON_UNARMED")] = "Fists",
        [GetHashKey("WEAPON_KNIFE")] = "Knife",
        [GetHashKey("WEAPON_NIGHTSTICK")] = "Nightstick",
        [GetHashKey("WEAPON_HAMMER")] = "Hammer",
        [GetHashKey("WEAPON_BAT")] = "Baseball Bat",
        [GetHashKey("WEAPON_CROWBAR")] = "Crowbar",
        [GetHashKey("WEAPON_GOLFCLUB")] = "Golf Club",
        [GetHashKey("WEAPON_PISTOL")] = "Pistol",
        [GetHashKey("WEAPON_COMBATPISTOL")] = "Combat Pistol",
        [GetHashKey("WEAPON_APPISTOL")] = "AP Pistol",
        [GetHashKey("WEAPON_SMG")] = "SMG",
        [GetHashKey("WEAPON_ASSAULTRIFLE")] = "Assault Rifle",
        [GetHashKey("WEAPON_CARBINERIFLE")] = "Carbine Rifle",
        [GetHashKey("WEAPON_SNIPERRIFLE")] = "Sniper Rifle",
        [GetHashKey("WEAPON_FIREEXTINGUISHER")] = "Fire Extinguisher",
        [GetHashKey("WEAPON_MOLOTOV")] = "Molotov Cocktail",
        [GetHashKey("WEAPON_GRENADE")] = "Grenade",
        [GetHashKey("WEAPON_RPG")] = "RPG",
        [GetHashKey("WEAPON_FIREWORK")] = "Firework Launcher",
        [GetHashKey("WEAPON_FLARE")] = "Flare",
        [GetHashKey("WEAPON_RUN_OVER")] = "Run Over by Vehicle",
        [GetHashKey("WEAPON_WATER")] = "Drowned",
        [GetHashKey("WEAPON_FALL")] = "Fell from a Height",
        [GetHashKey("WEAPON_FIRE")] = "Burned to Death",
        [GetHashKey("WEAPON_ELECTRIC")] = "Electrocuted"
    }
    return weaponNames[hash] or "Unknown Weapon"
end

function GetEnvironmentDeathReason(hash)
    local envDeathReasons = {
        [GetHashKey("WEAPON_WATER")] = "Drowned",
        [GetHashKey("WEAPON_FALL")] = "Fell from a Height",
        [GetHashKey("WEAPON_FIRE")] = "Burned to Death",
        [GetHashKey("WEAPON_ELECTRIC")] = "Electrocuted",
        [GetHashKey("WEAPON_RUN_OVER")] = "Run Over by a Vehicle",
        [GetHashKey("WEAPON_EXHAUSTION")] = "Died from Exhaustion",
        [GetHashKey("WEAPON_DROWNING")] = "Drowned",
        [GetHashKey("WEAPON_DROWNING_IN_VEHICLE")] = "Drowned in a Vehicle",
        [GetHashKey("WEAPON_EXPLOSION")] = "Killed by Explosion",
        [GetHashKey("WEAPON_BARBED_WIRE")] = "Killed by Barbed Wire",
        [GetHashKey("WEAPON_VEHICLE_ROCKET")] = "Blown up by Vehicle Rocket",
        [GetHashKey("WEAPON_RAMMED_BY_CAR")] = "Rammed by a Vehicle",
        [GetHashKey("WEAPON_AIRSTRIKE_ROCKET")] = "Killed in an Airstrike",
        [GetHashKey("WEAPON_FIREWORK")] = "Blown up by Firework",
        [GetHashKey("WEAPON_HIT_BY_WATER_CANNON")] = "Hit by Water Cannon",
        [GetHashKey("WEAPON_ANIMAL")] = "Killed by an Animal",
    }

    return envDeathReasons[hash] or "Died from Natural Causes"
end

