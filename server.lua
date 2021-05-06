
local webhook = {
			log = "https://discord.com/api/webhooks/814961385317990421/_8-L9KlJPLXdLL3jqtAdNbrwa4AxKR0LbCTAzgEcQXKGBXdnsHCVDnNglRsyx3qjqngO",
			police = "https://discord.com/api/webhooks/814962171489288197/HP9ARYsDpQ2qgZ9id-ZYh669ybuXRsn6w3_1HkLloCTo-dLMnb93zQIyDedrOmyRG_g_",
			annonce =  "https://discord.com/api/webhooks/814961536346488854/zTVyfOcw_b-9qMN6UF7R1H_Z0Gi5ZUnwvLUKKt_RqKR-kvWkaExBiSe2rMuirwxPXz80",

}

local image = {
			log = "https://cdn.discordapp.com/attachments/759297745839718420/769289275904229406/Logo.png",
			police = "https://cdn.discordapp.com/attachments/759297745839718420/777092048976085012/latest.png",
			annonce = "https://cdn.discordapp.com/attachments/759297745839718420/769289275904229406/Logo.png",

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
