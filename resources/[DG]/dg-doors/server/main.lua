DGCore = nil
local doorInfo = {}

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('dg_doorlock:updateState')
AddEventHandler('dg_doorlock:updateState', function(doorID, state)
	local xPlayer = DGCore.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('dg_doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if type(state) ~= 'boolean' then
		print(('dg_doorlock: %s attempted to update invalid state!'):format(xPlayer.identifier))
		return
	end

	if not Config.DoorList[doorID] then
		print(('dg_doorlock: %s attempted to update invalid door!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('dg_doorlock: %s was not authorized to open a locked door!'):format(xPlayer.identifier))
		return
	end

	doorInfo[doorID] = state

	TriggerClientEvent('dg_doorlock:setState', -1, doorID, state)
end)

DGCore.RegisterServerCallback('dg_doorlock:getDoorInfo', function(source, cb)
	cb(doorInfo)
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		if job == jobName then
			return true
		end
	end

	return false
end