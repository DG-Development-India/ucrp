DGCore                      = {}
DGCore.Players              = {}
DGCore.UsableItemsCallbacks = {}
DGCore.Items                = {}
DGCore.ServerCallbacks      = {}
DGCore.TimeoutCount         = -1
DGCore.CancelledTimeouts    = {}
DGCore.LastPlayerData       = {}
DGCore.Pickups              = {}
DGCore.PickupId             = 0
DGCore.Jobs                 = {}

AddEventHandler('dg:getSharedObject', function(cb)
	cb(DGCore)
end)

function getSharedObject()
	return DGCore
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for i=1, #result, 1 do
			DGCore.Items[result[i].name] = {
				label     = result[i].label,
				limit     = result[i].limit,
				rare      = (result[i].rare       == 1 and true or false),
				canRemove = (result[i].can_remove == 1 and true or false),
			}
		end
	end)

	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=1, #result do
		DGCore.Jobs[result[i].name] = result[i]
		DGCore.Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=1, #result2 do
		if DGCore.Jobs[result2[i].job_name] then
			DGCore.Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
		else
			print(('dg-core: invalid job "%s" from table job_grades ignored!'):format(result2[i].job_name))
		end
	end

	for k,v in pairs(DGCore.Jobs) do
		if next(v.grades) == nil then
			DGCore.Jobs[v.name] = nil
			print(('dg-core: ignoring job "%s" due to missing job grades!'):format(v.name))
		end
	end
end)

AddEventHandler('dg:playerLoaded', function(source)
	local xPlayer         = DGCore.GetPlayerFromId(source)
	local accounts        = {}
	local items           = {}
	local xPlayerAccounts = xPlayer.getAccounts()

	for i=1, #xPlayerAccounts, 1 do
		accounts[xPlayerAccounts[i].name] = xPlayerAccounts[i].money
	end

	DGCore.LastPlayerData[source] = {
		accounts = accounts,
		items    = items
	}
end)

RegisterServerEvent('dg:clientLog')
AddEventHandler('dg:clientLog', function(msg)
	RconPrint(msg .. "\n")
end)

RegisterServerEvent('dg:triggerServerCallback')
AddEventHandler('dg:triggerServerCallback', function(name, requestId, ...)
	local _source = source

	DGCore.TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent('dg:serverCallback', _source, requestId, ...)
	end, ...)
end)
