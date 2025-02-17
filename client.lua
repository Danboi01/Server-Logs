Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsEntityDead(PlayerPedId()) then
            local killer = GetPedKiller(PlayerPedId())
            local deathReason = "Player Died"
            if killer ~= 0 then
                if IsPedAPlayer(killer) then
                    deathReason = "Killed by another player"
                else
                    deathReason = "Killed by NPC"
                end
            else
                if IsEntityDead(GetPlayerPed(-1)) then
                    deathReason = "Died from Natural Causes"
                else
                    deathReason = "Player Died"
                end
            end
            TriggerServerEvent('playerDied', deathReason) 
            while IsEntityDead(PlayerPedId()) do
                Citizen.Wait(0)
            end
        end
    end
end)
