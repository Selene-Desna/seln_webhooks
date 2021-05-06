
local webhook = {
			log = "https://...",
			police = "https://...",

}

local image = {
			log = "https://...",
			police = "https://...",

} 

-- Connexion Deconnexion
AddEventHandler('playerConnecting', function()  LogDiscord("log", "Connexion", "**"..GetPlayerName(source).."**", 65280) end)
AddEventHandler('playerDropped', function(reason) LogDiscord("log", "Deconnexion", "**"..GetPlayerName(source).."** *( " .. reason.." )*", 16711680) end)


RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(message) LogDiscord("log", "Mort", message, 16711680) end)

function GetIDFromSource(Type, ID)
   	local IDs = GetPlayerIdentifiers(ID)
    	for k, CurrentID in pairs(IDs) do
        	local ID = stringsplit(CurrentID, ':')
        	if (ID[1]:lower() == string.lower(Type)) then return ID[2]:lower() end
    	end
    	return nil
end

function stringsplit(input, seperator)
	if seperator == nil then seperator = '%s' end 
	local t={} ; i=1
	for str in string.gmatch(input, '([^'..seperator..']+)') do t[i] = str i = i + 1 end
	return t
end

function LogDiscord(wbhk, name, message, color)
	local connect = { { ["color"] = color, ["title"] = "**"..name.."** - "..message, } }

  	print('^4[Webhook '..wbhk..'] : '..name.." - "..message)
  	PerformHttpRequest(webhook[wbhk], function(err, text, headers) end, 'POST', json.encode({username = "Holliday\'s", embeds = connect, avatar_url = image[wbhk]}), { ['Content-Type'] = 'application/json' })
end

-- Activation du webhooks
LogDiscord("log", "Reboot", "Serveur ON", 65280)

-- Exportation du webhook pour etre utilisable dans d'autre script
exports("LogDiscord", LogDiscord)

RegisterServerEvent('LogDiscordSRV')
AddEventHandler('LogDiscordSRV',function(wbhk, name, message, color) LogDiscord(wbhk, name, message, color) end)
