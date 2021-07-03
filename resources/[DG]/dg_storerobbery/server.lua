DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('notifyCops')
AddEventHandler('notifyCops', function(type, location, sprite, dispatch)
	TriggerClientEvent('notifyCops',-1,type,location,sprite, dispatch)
end)

-- Global Cooldown For Illegal Activities

local time = 0
local time2 = 0
local cooldown = 0
local cooldown2 = 0

-- Cooldown Set

RegisterNetEvent('startCooldown')
AddEventHandler('startCooldown', function(cd)
	local _source = source
	local timeNow = os.time()
	time = timeNow
    cooldown = cd
end)

RegisterNetEvent('startCooldown2')
AddEventHandler('startCooldown2', function(cd)
	local _source = source
	local timeNow = os.time()
	time2 = timeNow
    cooldown2 = cd
end)

-- Cooldown Check

DGCore.RegisterServerCallback('checkCooldown', function(source, cb)
	local timeNow = os.time()
	if timeNow - time > cooldown*60 then
		cb(true)
		return
	end
	cb(false)
end)

DGCore.RegisterServerCallback('checkCooldown2', function(source, cb)
	local timeNow = os.time()
	if timeNow - time2 > cooldown2*60 then
		cb(true)
		return
	end
	cb(false)
end)

-- check cops

DGCore.RegisterServerCallback('checkCops', function(source, cb)
	local cops = 0
    local xPlayers = DGCore.GetPlayers()
	for i=1, #xPlayers, 1 do
        local xPlayer = DGCore.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    cb(cops)
end)