function sendHttpRequest(webhookURL, data)
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

---------------------------------
-- Player Connecting
---------------------------------
AddEventHandler('playerConnecting', function()
    if Config.AttemptConnect then
        local webhookURL = Config.JoinWebhook
        local name = GetPlayerName(source)
        local discord = "Unknown"

        for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, 8) == "discord:" then
                discord = string.gsub(v, "discord:", "")
                break
            end
        end

        local embedData = {
            {
                ["color"] = 15277667, 
                ["title"] = "Player Attempting To Connect",
                ["description"] = "**Player Name**: " .. name .. " \n**Discord**: <@" .. discord .. ">",
                ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
            }
        }
        sendHttpRequest(webhookURL, {embeds = embedData})
    end
end)

---------------------------------
-- Player Joined
---------------------------------
AddEventHandler('playerJoining', function()
    local webhookURL = Config.JoinWebhook
    local playerid = source
    local name = GetPlayerName(source)
    local discord = "Unknown"

    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 8) == "discord:" then
            discord = string.gsub(v, "discord:", "")
            break
        end
    end

    local embedData = {
        {
            ["color"] = 5763719, 
            ["title"] = "Player Joined",
            ["description"] = "**Player Name**: " .. name .. " \n**Player ID**: " .. playerid .. " \n**Discord**: <@" .. discord .. ">",
            ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
        }
    }
    sendHttpRequest(webhookURL, {embeds = embedData})
end)

---------------------------------
-- Player Left
---------------------------------
AddEventHandler('playerDropped', function(reason)
    local webhookURL = Config.LeaveWebhook
    local playerid = source
    local name = GetPlayerName(source)
    local discord = "Unknown"

    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 8) == "discord:" then
            discord = string.gsub(v, "discord:", "")
            break
        end
    end

    local embedData = {
        {
            ["color"] = 15548997, 
            ["title"] = "Player Left",
            ["description"] = "**Player Name**: " .. name .. " \n**Player ID**: " .. playerid .. " \n**Discord**: <@" .. discord .. "> \n**Reason**: " .. reason,
            ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
        }
    }
    sendHttpRequest(webhookURL, {embeds = embedData})
end)

---------------------------------
-- Player Death Logging
---------------------------------
RegisterServerEvent('playerDied')
AddEventHandler('playerDied', function(deathReason)
    local webhookURL = Config.DeathWebhook
    local player = GetPlayerName(source)
    local id = source
    local discord = "Unknown"

    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, 8) == "discord:" then
            discord = string.gsub(v, "discord:", "")
            break
        end
    end

    local embedData = {
        {
            ["color"] = 15548997, 
            ["title"] = "Player Death",
            ["description"] = "**IGN**: " .. player .. " \n**Player ID**: " .. id .. " \n**Discord**: <@" .. discord .. "> \n**Cause**: " .. deathReason,
            ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
        }
    }
    sendHttpRequest(webhookURL, {embeds = embedData})
end)

---------------------------------
-- Resource Logging
---------------------------------
AddEventHandler('onResourceStart', function(resourceName)
    Wait(100)
    local webhookURL = Config.ResourceWebhook
    local embedData = {
        {
            ["color"] = 3426654, 
            ["title"] = "Resource Started",
            ["description"] = "**Resource**: " .. resourceName,
            ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
        }
    }
    sendHttpRequest(webhookURL, {embeds = embedData})
end)

AddEventHandler('onResourceStop', function(resourceName)
    local webhookURL = Config.ResourceWebhook
    local embedData = {
        {
            ["color"] = 15548997, 
            ["title"] = "Resource Stopped",
            ["description"] = "**Resource**: " .. resourceName,
            ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
        }
    }
    sendHttpRequest(webhookURL, {embeds = embedData})
end)

---------------------------------
-- vMenu Logs
---------------------------------
RegisterNetEvent('vMenu:ClearArea', function()
    if Config.vMenuActive then
        local webhookURL = Config.vMenuWebhook
        local sourceID = source
        local discord = "Unknown"

        for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, 8) == "discord:" then
                discord = string.gsub(v, "discord:", "")
                break
            end
        end  

        local embedData = {
            {
                ["color"] = 3447003, 
                ["title"] = "vMenu Event: Clear Area",
                ["description"] = "**ID**: " .. sourceID .. " \n**Staff**: <@" .. discord .. "> \n**Action**: Cleared the area",
                ["footer"] = { ["text"] = "AtlasDevLabs - 2024" },
            }
        }
        sendHttpRequest(webhookURL, {embeds = embedData})
    end
end)

RegisterNetEvent('vMenu:UpdateServerWeather', function(result)
    if Config.vMenuActive then
    local webhookURL = Config.vMenuWebhook
    local sourceID = source
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "vMenu Event: Server Weather",
            ["description"] = "\n**ID**: "..sourceID.." \n **Staff**: <@"..discord.."> \n**Action**: has updated the weather to \n**".. result .."**",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {embeds = embedData})
    else
        return
    end
end)

RegisterNetEvent('vMenu:UpdateServerTime', function(result)
    if Config.vMenuActive then
    local webhookURL = Config.vMenuWebhook
    local sourceID = source
    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = string.gsub(v, "discord:", "")
        end
    end  
    local embedData = {
        {
            ["color"] = 3447003, 
            ["title"] = "vMenu Event: Server Time",
            ["description"] = "\n**ID**: "..sourceID.." \n**Staff**: <@"..discord.."> \n**Action**: has updated the time to \n**".. result ..":00**",
            ["footer"] = {
                ["text"] = "AtlasDevLabs - 2024",
            },
        },
    }	
    sendHttpRequest(webhookURL, {embeds = embedData})
    else
        return
    end
end)
