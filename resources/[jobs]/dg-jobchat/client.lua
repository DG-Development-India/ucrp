DGCore = nil
local nine = false
local three = false
local code = false
local BlipExist911 = false
local BlipExist311 = false
local Blip911 = {}
local Blip311 = {}
local Blipcode3p = {}
local emsr = false
local pdr = false

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(0)
        TriggerServerEvent("playerSpawned")
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	DGCore.PlayerData = DGCore.GetPlayerData()
end)


RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = DGCore.GetPlayerData()
	end
end)

RegisterCommand('911', function(source, args, rawCommand)
	
	if not nine then 
		nine = true
		TriggerEvent("dg-emotes:playthisemote", 'phonecall')
		TriggerServerEvent('3dme:shareDisplay', 'Dialing 911')
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
		local msg = rawCommand:sub(5)
		TriggerServerEvent('dg_emHelp:911',playerCoords, msg, streetName)
		Citizen.Wait(5000)
		TriggerEvent("dg-emotes:playthisemote", 'c')
		Citizen.Wait(5*60*1000)
		nine = false
	else
		exports['mythic_notify']:SendAlert('error', 'You have already called 911. Wait for them to respond')
	end

end, false)

RegisterCommand('311', function(source, args, rawCommand)
	
	if not three then 
		three = true
		TriggerEvent("dg-emotes:playthisemote", 'phonecall')
		TriggerServerEvent('3dme:shareDisplay', 'Dialing 311')
		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
		local msg = rawCommand:sub(5)
		TriggerServerEvent('dg_emHelp:311',playerCoords, msg, streetName)
		Citizen.Wait(5000)
		TriggerEvent("dg-emotes:playthisemote", 'c')
		Citizen.Wait(5*60*1000)
		three = false
	else
		exports['mythic_notify']:SendAlert('error', 'You have already called 311. Wait for them to respond')
	end

end, false)

RegisterCommand('code3p', function(source, args, rawCommand)
	if exports["isPed"]:isPed("myjob") == 'triad' then
		if not code then 
			code = true
			--TriggerEvent("dg-emotes:playthisemote", 'phonecall')
			--TriggerServerEvent('3dme:shareDisplay', 'Dialing 911')
			local playerCoords = GetEntityCoords(PlayerPedId())
			streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
			streetName = GetStreetNameFromHashKey(streetName)
			local msg = rawCommand:sub(5)
			TriggerServerEvent('dg_trHelp:code3p',playerCoords, msg, streetName)
			Citizen.Wait(5000)
			--TriggerEvent("dg-emotes:playthisemote", 'c')
			Citizen.Wait(5*60*1000)
			code = false
		else
			exports['mythic_notify']:SendAlert('error', 'You called police. Wait for them to respond')
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You are not the right man')
	end

end, false)

RegisterCommand('311r', function(source, args, rawCommand)
	if args[1] ~= nil then
		local target = tonumber(args[1])
		if target ~= nil then

			--if exports["isPed"]:isPed("myjob") == 'ems' then
			if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'ambulance') then 
				local msg = table.concat(args, ' ')
				local msg1 = msg:gsub('[0-9]', '')
				TriggerServerEvent('dg_emHelp:respond', 311, target,msg1)
			end

		end
	end
end, false)

RegisterCommand('911r', function(source, args, rawCommand)
	if args[1] ~= nil then
		local target = tonumber(args[1])
		if target ~= nil then
			--if exports["isPed"]:isPed("myjob") == 'police' then
			if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then     
				local msg = table.concat(args, ' ')
				local msg1 = msg:gsub('[0-9]', '')
				TriggerServerEvent('dg_emHelp:respond', 911, target,msg1)
			end
		end
	end
end, false)

RegisterNetEvent('dg_emHelp:show911')
AddEventHandler('dg_emHelp:show911', function(target,msg,streetName,coords)
	local _target,_msg,_streetName,_coords = target,msg,streetName,coords
	--if exports["isPed"]:isPed("myjob") == 'police' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then 
		TriggerEvent('InteractSound_CL:PlayOnOne', 'dispatch', 0.4)
		
		-- TriggerEvent('chat:addMessage', {
		-- 	templateId = 'admindm',
		-- 	args = {"911 Call from ".._target, "Area: ".. _streetName .. " | msg: ".._msg }
		-- })
		TriggerEvent('chatMessagess', '', 1, ' 911 Call from ' .. target .. '  Area:  ' .. streetName .. ' | message: ' .._msg )

		Blip911[target] = AddBlipForCoord(_coords)
		SetBlipSprite (Blip911[target], 58)
		SetBlipColour (Blip911[target], 38)
		SetBlipScale (Blip911[target], 0.8)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Emergency Assistance '.._target)
		EndTextCommandSetBlipName(Blip911[target])

	end
end)

RegisterNetEvent('dg_emHelp:show311')
AddEventHandler('dg_emHelp:show311', function(target,msg,streetName,coords)
	local _target,_msg,_streetName,_coords = target,msg,streetName,coords

	--if exports["isPed"]:isPed("myjob") == 'ems' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'ambulance') then 
		TriggerEvent('InteractSound_CL:PlayOnOne', 'dispatch', 0.4)
		
		-- TriggerEvent('chat:addMessage', {
		-- 	templateId = 'broadcast',
		-- 	args = {"311 Call from ".._target, "Area: ".. _streetName .. " | msg: ".._msg }
		-- })

		TriggerEvent('chatMessagess', '', 1, ' 311 Call from ' .. target .. '  Area:  ' .. streetName .. ' | message: ' .._msg )

		Blip311[target] = AddBlipForCoord(_coords)
		SetBlipSprite (Blip311[target], 153)
		SetBlipColour (Blip311[target], 27)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Medical Assistance '.._target)
		EndTextCommandSetBlipName(Blip311[target]) 
	end

end)

RegisterNetEvent('dg_trHelp:showcode3p')
AddEventHandler('dg_trHelp:showcode3p', function(target,msg,streetName,coords)
	local _target,_msg,_streetName,_coords = target,msg,streetName,coords
	--if exports["isPed"]:isPed("myjob") == 'police' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then 
		
		-- TriggerEvent('chat:addMessage', {
		-- 	templateId = 'admindm',
		-- 	args = {"Suspicious Activity In The Vicinity. Units Roll Out Code3 ", "Area: ".. _streetName}
		-- })

		TriggerEvent('chatMessagess', '', 1, ' Suspicious Activity In The Vicinity. Units Roll Out Code3 ', '  Area:  ' .. streetName )

		Blipcode3p[target] = AddBlipForCoord(_coords)
		SetBlipSprite (Blipcode3p[target], 303)
		SetBlipColour (Blipcode3p[target], 1)
		SetBlipScale (Blipcode3p[target], 1.0)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Suspicious Activity')
		EndTextCommandSetBlipName(Blipcode3p[target])

	end
end)

RegisterNetEvent('dg_emHelp:showResponser')
AddEventHandler('dg_emHelp:showResponser', function(to, from, callType,msg)
	local _to, _from = to , from
	if callType == 311 then
		--if exports["isPed"]:isPed("myjob") == 'ems' then
		if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'ambulance') then 
			-- TriggerEvent('chat:addMessage', {
			-- 	templateId = 'broadcast',
			-- 	args = {"311 Response By ".. from .. " to " ..to, msg }
			-- })
			TriggerEvent('chatMessagess', '', 1, ' 311 Response By ' .. from .. ' to ' .. to .. ' message: ' ..msg )
		end
	else
		--if exports["isPed"]:isPed("myjob") == 'police' then
		if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then 
			-- TriggerEvent('chat:addMessage', {
			-- 	templateId = 'admindm',
			-- 	args = {"311 Response By ".. from .. " to " ..to, msg }
			-- })
			TriggerEvent('chatMessagess', '', 1, ' 911 Response By ' .. from .. ' to ' .. to .. ' message: ' .. msg )
		end
	end
end)

RegisterNetEvent('dg_emHelp:showResponse')
AddEventHandler('dg_emHelp:showResponse', function(callType,msg)
	if callType == 311 then
		if not emsr then
			emsr = true
			-- TriggerEvent('chat:addMessage', {
			-- 	templateId = 'broadcast',
			-- 	args = {"311 Response", msg }
			-- })
			TriggerEvent('chatMessagess', '', 1, ' 311 Response By: ' .. msg )
			Citizen.Wait(2*60*1000)
			emsr = false
		end
	else
		if not pdr then
			pdr = true
			-- TriggerEvent('chat:addMessage', {
			-- 	templateId = 'admindm',
			-- 	args = {"911 Response", msg }
			-- })
			TriggerEvent('chatMessagess', '', 1, ' 911 Response: ' .. msg )
			Citizen.Wait(2*60*1000)
			pdr = false
		end
	end
end)

RegisterCommand('clear311', function()
	--if exports["isPed"]:isPed("myjob") == 'ems' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'ambulance') then 
		if Blip311 ~= nil then
			for k,v in pairs(Blip311) do
				RemoveBlip(v)
				exports['mythic_notify']:SendAlert('error', 'You removes all location from the map ')
			end
		end
	end
end)

RegisterCommand('clear911', function()
	--if exports["isPed"]:isPed("myjob") == 'police' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then
		if Blip911 ~= nil then
			for k,v in pairs(Blip911) do
				RemoveBlip(v)
				exports['mythic_notify']:SendAlert('error', 'You removes all location from the map ')
			end
		end
	end
end)

RegisterCommand('clearcode3', function()
	--if exports["isPed"]:isPed("myjob") == 'police' then
	if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then
		if Blipcode3p ~= nil then
			for k,v in pairs(Blipcode3p) do
				RemoveBlip(v)
				exports['mythic_notify']:SendAlert('error', 'You removes all location from the map ')
			end
		end
	end
end)

TriggerEvent('chat:addSuggestion', '/clear311', 'Remove 311 Blips (EMS)')
TriggerEvent('chat:addSuggestion', '/clear911', 'Remove 911 Blips (Police)')
TriggerEvent('chat:addSuggestion', '/311', 'send emergency message to the ems', {{name = "message", help = "local report"}})
TriggerEvent('chat:addSuggestion', '/911', 'send message to the police', {{name = "message", help = "police report"}})
TriggerEvent('chat:addSuggestion', '/311r', 'respond to 311 message (For EMS)', {{name = "id", help = "Id of caller"}, {name = "message", help = "reply"}})
TriggerEvent('chat:addSuggestion', '/911r', 'respond to 911 message (For Cops)', {{name = "id", help = "Id of caller"}, {name = "message", help = "reply"}})