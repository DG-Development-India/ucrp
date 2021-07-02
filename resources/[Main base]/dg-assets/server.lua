DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('CrashTackle')
AddEventHandler('CrashTackle', function(target)
	TriggerClientEvent("playerTackled", target)
end)

--TPM

DGCore.RegisterServerCallback("tpm:fetchUserRank", function(source, cb)
    local player = DGCore.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

---/job server files
RegisterNetEvent("dg_base:showjob")
AddEventHandler("dg_base:showjob", function()
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local job = xPlayer.job.label
		local jobgrade = xPlayer.job.grade_label
		if job == 'unemployed' then
			TriggerClientEvent('dg:showNotification', source, 'You don\'t have a job')
		else
			TriggerClientEvent('dg:showNotification', source, 'Job: '.. job ..' | Grade: '..jobgrade)
		end
	end
end)

--- SUPTIME ---

-- Citizen.CreateThread(function()
-- 	local starttick = GetGameTimer()
-- 	while true do
-- 		Citizen.Wait(15000) -- check all 15 seconds
-- 		local tick = GetGameTimer()
-- 		local uptimeDay = math.floor((tick-starttick)/86400000)
--         local uptimeHour = math.floor((tick-starttick)/3600000) % 24
-- 		local uptimeMinute = math.floor((tick-starttick)/60000) % 60
-- 		local uptimeSecond = math.floor((tick-starttick)/1000) % 60
-- 		ExecuteCommand(string.format("sets Uptime \"%2d Days %2d Hours %2d Minutes %2d Seconds\"", uptimeDay, uptimeHour, uptimeMinute, uptimeSecond))
-- 	end
-- end)


RegisterServerEvent('removecash:checkmoney')
AddEventHandler('removecash:checkmoney', function(money)
    local source = source
    local xPlayer  = DGCore.GetPlayerFromId(source)
    if money ~= nil then
        xPlayer.removeMoney(money)
    end
end)

RegisterServerEvent("heli:spotlight")
AddEventHandler(
	"heli:spotlight",
	function(state)
		local serverID = source
		TriggerClientEvent("heli:spotlight", -1, serverID, state)
	end
)

-- Add Money

RegisterNetEvent('dg-base:addmoney')
AddEventHandler('dg-base:addmoney', function(amount,reason)
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer ~= nil then
		xPlayer.addMoney(tonumber(amount))
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Received $'.. amount .. ' | Reason: '..reason , length = 2500, style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } })
	end
end)

-- Remove Money

RegisterNetEvent('dg-base:removeMoney')
AddEventHandler('dg-base:removeMoney', function(amount,reason)
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer ~= nil then
		xPlayer.removeMoney(tonumber(amount))
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Removed $'.. amount .. ' | Reason: '..reason , length = 4000 })
	end
end)

--issue licenses
RegisterServerEvent('dg_issueLicense')
AddEventHandler('dg_issueLicense', function(plyID)
	TriggerClientEvent('dg_buyLicense',plyID)
end)