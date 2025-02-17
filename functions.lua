function sendHttpRequest(url, data)
    PerformHttpRequest(url, function(err, text, headers)
        if err then
            return
        end
    end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
