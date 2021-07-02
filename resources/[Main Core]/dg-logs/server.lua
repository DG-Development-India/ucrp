DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

-- Made by Tazio

local DISCORD_CHAT_WEBHOOK = "https://discord.com/api/webhooks/855819013065146369/FBUhzNQamabrUPFSDFuikl1fr-wi-W3s_HEu-Lp7zHw_eWBrA6Woge2mh5rWY3zix5H7"
local DISCORD_KILLED_BY_WEBHOOK = "https://discord.com/api/webhooks/855819151709044766/X8Mmyao9tycC9tcDjLjW-3E1fqyibFsWvMG_ke-CFCrz1tNyoMyuYQmhYZ9wRVCh85GP"
local DISCORD_CONNECTING_WEBHOOK = "https://discord.com/api/webhooks/855819258260357120/0GCNdWZSedNEjO7J3pEPBdBWBwgKznId8AIRZD4Iq0fkXrYwBUf9ffZr2MI4d-1Qymod"
local DISCORD_DISCONNECTED_WEBHOOKS = "https://discord.com/api/webhooks/855819412564082709/kuDfoYJ_unCtY8ZkiPxkFvjQMmxk3yYGyLgTNKla2Z-Dv0QfrDPFYyfamAucsvVRizS5"
local DISCORD_ME_WEBHOOK = "https://discord.com/api/webhooks/855819571785105438/sP-q8kTK1nsEIO5qM3ZJdscPRML7MiPmJ4XOxvjjfmg6U9gjj5JWW_kr30ZkZz1yDSIA"
local DISCORD_OOC_WEBHOOK = "https://discord.com/api/webhooks/855819693600669737/3o0szNnAysQgXe2eSQWKonqUcw4FyzuiiTT4Xh52AtgpwZZgBr5yagTN7ka95xDavcOr"
local DISCORD_NAME = "dg Logs"
local STEAM_KEY = "879616E21745B287EC66C67F1827D2D9"
local DISCORD_IMAGE = "" -- default is FiveM logo

local DISCORD_PF_WEBHOOK = "https://discord.com/api/webhooks/855820510092197938/6W4opGofcSE8wK1NIw0o8tsmC0YH5K7hWb5ICbJgOcONXw6uaYBV4u32wEYqiTjhod8n"
local DISCORD_PS_WEBHOOK = "https://discord.com/api/webhooks/855820696499781642/1tY5b872EcPAiAU8U-JneEhNPjTH76HZAgC-M-EXmtoPvEADQbaeEMzA3YkhKMZZWS-I"
local DISCORD_PDM_WEBHOOK = "https://discord.com/api/webhooks/855820898190622730/lzitlkjDQQvoJYb8niwzGS9laR1fOgt_cJDaaCmhP9qq0UcvKtQ_OCacsjMmqpD_1yWx"
--local DISCORD_COCAINE_WEBHOOK = "https://discord.com/api/webhooks/834010902230728755/-q26KGQcHzrb0CFUco0GNnCLggPk4sYFqGFVUb5YBkWK8yvgL1nATOplLSLsV4ywceiC"
--local DISCORD_EDM_WEBHOOK = "https://discord.com/api/webhooks/835140664353751070/teN8Awc4qPaUBRc4IHeQbNjgOXCtLQgV0rsmWZGjkGlD3yPhve1TCtspISImzI1dAMt3"
--local DISCORD_DRUG_RUN_WEBHOOK = "https://discord.com/api/webhooks/836489496932515840/mderKFwWLT7XrjUSFlLhDzreRvc2P5T18Kcgb3f6NmaDFHgSDVfAdBWoWDw6Cg3ZeD20"
--local DISCORD_REPORT_WEBHOOK = "https://discord.com/api/webhooks/844609292648054804/oJu0utvVUVmPvHb4d4SlGS0pDQhV7Tj_MM2Rm4PhT38Thtqk2OKAL_yldjr_jQcrARVN"
--DON'T EDIT BELOW THIS

AddEventHandler('chatMessage', function(source, name, message) 

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end

	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_CHAT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_CHAT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. message .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('me:logging')
AddEventHandler('me:logging', function(source, name, message)

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
    if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_ME_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/me " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_ME_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = '```/me ' .. message .. '```', avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('report:logging')
AddEventHandler('report:logging', function(source, name, message)

	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
    if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_REPORT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/report " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_REPORT_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = '```/report ' .. message .. '```', avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('ooc:logging')
AddEventHandler('ooc:logging', function(source, name, message)
	print(name,message)
	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_OOC_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_OOC_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)


RegisterServerEvent('police:fine')
AddEventHandler('police:fine', function(source, name, amount, message, culprit)
	if string.match(message, "@everyone") then
		message = message:gsub("@everyone", "`@everyone`")
	end
	if string.match(message, "@here") then
		message = message:gsub("@here", "`@here`")
	end
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_PF_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_PF_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. name .. " fined $" .. amount .. " from " .. culprit .. ". Reason: " .. message .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('police:stash')
AddEventHandler('police:stash', function(source, name, item, count)
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_PS_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_PS_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. name .. " withdrew " .. count .. "x " .. item .. " from police stash```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

--- GARBAGE JOB LOGS START

local garbagePayhook = "https://discord.com/api/webhooks/855822174002872321/DJ_R99OYrMmyulk7X15WSjFiFSEdrngDeNeg_ahR_BPzYAKsCdBcOpNgf1S_eTzzmjNw"
local garbageRewhook = "https://discord.com/api/webhooks/855822174002872321/DJ_R99OYrMmyulk7X15WSjFiFSEdrngDeNeg_ahR_BPzYAKsCdBcOpNgf1S_eTzzmjNw"

RegisterServerEvent('garbagePay:logs')
AddEventHandler('garbagePay:logs', function(source, name, money)
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(garbagePayhook, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(garbagePayhook, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. name .. " got $" .. money .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('garbageRew:logs')
AddEventHandler('garbageRew:logs', function(source, name, item)
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(garbageRewhook, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(garbageRewhook, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. name .. " found " .. item .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

---- GARBAGE JOB LOG STOP

RegisterServerEvent('edm:buy')
AddEventHandler('edm:buy', function(source, model, money, plate)
	print(source, model, money, plate)
	local player = DGCore.GetPlayerFromId(source)
	local name = player.getName()
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_EDM_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_EDM_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. name .. " bought " .. model .. " with " .. plate .." from EDM for $" .. money .. " ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

RegisterServerEvent('pdm:buy')
AddEventHandler('pdm:buy', function(source, sellerid, buyername, plate , model , amount , commission)
	local sellername = "PDM Local"
	if sellerid then
		local seller = DGCore.GetPlayerFromId(sellerid)
		sellername = seller.getName()
	end
	if STEAM_KEY == '' or STEAM_KEY == nil then
		PerformHttpRequest(DISCORD_PDM_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
			local image = string.match(text, '"avatarfull":"(.-)","')
			PerformHttpRequest(DISCORD_PDM_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = buyername .. " [" .. source .. "]", content = "```" .. buyername .. " bought " .. model .. " with plate: " .. plate .. " from " .. sellername .. " for $" .. amount .." [" .. commission .. "% Commission]```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
		end)
	end
end)

-- Cocaine Logs

-- RegisterServerEvent('logs:cocainecollect')
-- AddEventHandler('logs:cocainecollect', function(source, identifier)
-- 	local _source = tonumber(source)
-- 	local player = DGCore.GetPlayerFromId(_source)
-- 	if player ~= nil then
-- 		local name = player.getName()
-- 		if STEAM_KEY == '' or STEAM_KEY == nil then
-- 			PerformHttpRequest(DISCORD_COCAINE_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
-- 		else
-- 			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
-- 				local image = string.match(text, '"avatarfull":"(.-)","')
-- 				PerformHttpRequest(DISCORD_COCAINE_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```" .. name .. " - " .. identifier .. " collected the airdrop and returning it ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
-- 			end)
-- 		end
-- 	end
-- end)

-- RegisterServerEvent('logs:cocaine')
-- AddEventHandler('logs:cocaine', function(source, identifier)
-- 	local _source = tonumber(source)
-- 	local player = DGCore.GetPlayerFromId(_source)
-- 	if player ~= nil then
-- 		local name = player.getName()
-- 		if STEAM_KEY == '' or STEAM_KEY == nil then
-- 			PerformHttpRequest(DISCORD_COCAINE_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
-- 		else
-- 			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
-- 				local image = string.match(text, '"avatarfull":"(.-)","')
-- 				PerformHttpRequest(DISCORD_COCAINE_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```" .. name .. " - " .. identifier .. " returned the plane and received 1x Cocaine Brick ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
-- 			end)
-- 		end
-- 	end
-- end)

-- Drug Runs

-- RegisterServerEvent('logs:start-drugrun')
-- AddEventHandler('logs:start-drugrun', function(source, identifier, drugType)
-- 	local _source = tonumber(source)
-- 	local player = DGCore.GetPlayerFromId(_source)
-- 	if player ~= nil then
-- 		local name = player.getName()
-- 		if STEAM_KEY == '' or STEAM_KEY == nil then
-- 			PerformHttpRequest(DISCORD_DRUG_RUN_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
-- 		else
-- 			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
-- 				local image = string.match(text, '"avatarfull":"(.-)","')
-- 				PerformHttpRequest(DISCORD_DRUG_RUN_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```" .. name .. " - " .. identifier .. " started Drug Run for "..drugType.." ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
-- 			end)
-- 		end
-- 	end
-- end)

-- RegisterServerEvent('logs:end-drugrun')
-- AddEventHandler('logs:end-drugrun', function(source, identifier, drugType)
-- 	local _source = tonumber(source)
-- 	local player = DGCore.GetPlayerFromId(_source)
-- 	if player ~= nil then
-- 		local name = player.getName()
-- 		if STEAM_KEY == '' or STEAM_KEY == nil then
-- 			PerformHttpRequest(DISCORD_DRUG_RUN_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
-- 		else
-- 			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
-- 				local image = string.match(text, '"avatarfull":"(.-)","')
-- 				PerformHttpRequest(DISCORD_DRUG_RUN_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```" .. name .. " - " .. identifier .. " delivered the van and received 1x "..drugType.." ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
-- 			end)
-- 		end
-- 	end
-- end)

-- INVENTORY logs

local INV_LOGS = 'https://discord.com/api/webhooks/855821298780471346/r1NMo2tNsAmC9DGFKNz96xipb5H6GH-mIptUGHj00PB_9BbnbOIsYcIDo9D-9OVK6qDW'

RegisterServerEvent('motel:logs')
AddEventHandler('motel:logs', function(amount,item,action,sname,sslot,tname,tslot)
	local player = DGCore.GetPlayerFromId(source)
	if player ~= nil then
		local name = player.getName()
		if STEAM_KEY == '' or STEAM_KEY == nil then
			PerformHttpRequest(INV_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
		else
			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
				local image = string.match(text, '"avatarfull":"(.-)","')
				PerformHttpRequest(INV_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```" .. amount .. "x " .. item .. " " .. action .. " " .. sname .. " [" .. sslot .. "] to " .. tname .. " [" .. tslot .. "]  ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
			end)
		end
	end
end)

RegisterServerEvent('swap:logs')
AddEventHandler('swap:logs', function(sname,sslot,tname,tslot)
	local player = DGCore.GetPlayerFromId(source)
	if player ~= nil then
		local name = player.getName()
		if STEAM_KEY == '' or STEAM_KEY == nil then
			PerformHttpRequest(INV_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
		else
			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', source), 16), function(err, text, headers)
				local image = string.match(text, '"avatarfull":"(.-)","')
				PerformHttpRequest(INV_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = "```Item swapped from " .. sname .. " [" .. sslot .. "] to " .. tname .. " [" .. tslot .. "]  ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
			end)
		end
	end
end)

-- Duty Logs
local DUTY_LOGS = 'https://discord.com/api/webhooks/855821450514923550/YEm6piUUXgvDU8JOSg7dIAn-jMnEK97viLGKIv-yMEb1dSg73-tL4et-YdVtDJWc6ItU'

RegisterServerEvent('duty:logs')
AddEventHandler('duty:logs', function(source, name, duty_text, code)
	local _source = tonumber(source)
	local player = DGCore.GetPlayerFromId(_source)
	if player ~= nil then
		local name = player.getName()
		if STEAM_KEY == '' or STEAM_KEY == nil then
			PerformHttpRequest(DUTY_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
		else
			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
				local image = string.match(text, '"avatarfull":"(.-)","')
				PerformHttpRequest(DUTY_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```Dispatch: " .. name .. " " .. duty_text .. " DUTY! Showing " .. name .. " " .. code .. " at " .. os.date('%d-%b-%Y %H:%M:%S', os.time() + 19800) .. "```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
			end)
		end
	end
end)

-- PAWN logs

local PAWN_LOGS = 'https://discord.com/api/webhooks/855821568198049814/WJmVzH1C91WXaM7phKXySTdZBEfxcGe985fsUn79HosYOaDQAMLeagBOJCx1wH1NBhu-'

RegisterServerEvent('pawn:logs')
AddEventHandler('pawn:logs', function(source,amount,label,price)
	local _source = tonumber(source)
	local player = DGCore.GetPlayerFromId(_source)
	if player ~= nil then
		local name = player.getName()
		if STEAM_KEY == '' or STEAM_KEY == nil then
			PerformHttpRequest(PAWN_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```/ooc " .. message .. "```", tts = false}), { ['Content-Type'] = 'application/json' })
		else
			PerformHttpRequest('https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=' .. STEAM_KEY .. '&steamids=' .. tonumber(GetIDFromSource('steam', _source), 16), function(err, text, headers)
				local image = string.match(text, '"avatarfull":"(.-)","')
				PerformHttpRequest(PAWN_LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. _source .. "]", content = "```" .. name .. " sold " .. amount .. " x " .. label .. " for $" .. price .. " ```", avatar_url = image, tts = false}), { ['Content-Type'] = 'application/json' })
			end)
		end
	end
end)

AddEventHandler('playerConnecting', function() 
    sendToDiscord(DISCORD_CONNECTING_WEBHOOK, "Player Connecting", "**" .. GetPlayerName(source) .. "** is connecting to the server.", 65280)
end)

AddEventHandler('playerDropped', function(reason) 
	local color = 16711680
	if string.match(reason, "Kicked") or string.match(reason, "Banned") then
		color = 16007897
	end
  sendToDiscord(DISCORD_DISCONNECTED_WEBHOOKS, "Player Dropped", "**" .. GetPlayerName(source) .. "** has left the server. \n**Reason:** " .. reason, color)
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(message)
    sendToDiscord(DISCORD_KILLED_BY_WEBHOOK, "Death log", message, 16711680)
end)

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(hook, name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
  PerformHttpRequest(hook, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end