DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  	return
	end

	local players = DGCore.GetPlayers()

	for _,playerId in ipairs(players) do
		local xPlayer = DGCore.GetPlayerFromId(playerId)

		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local data = {}

			if result[1].status then
				data = json.decode(result[1].status)
			end

			xPlayer.set('status', data)
			TriggerClientEvent('dg_status:load', playerId, data)
		end)
	end
end)

AddEventHandler('dg:playerLoaded', function(playerId, xPlayer)
	MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {}

		if result[1].status then
			data = json.decode(result[1].status)
		end

		xPlayer.set('status', data)
		TriggerClientEvent('dg_status:load', playerId, data)
	end)
end)

AddEventHandler('dg:playerDropped', function(playerId, reason)
	local xPlayer = DGCore.GetPlayerFromId(playerId)
	local status = xPlayer.get('status')

	MySQL.Async.execute('UPDATE users SET status = @status WHERE identifier = @identifier', {
		['@status']     = json.encode(status),
		['@identifier'] = xPlayer.identifier
	})
end)

AddEventHandler('dg_status:getStatus', function(playerId, statusName, cb)
	local xPlayer = DGCore.GetPlayerFromId(playerId)
	local status  = xPlayer.get('status')

	for i=1, #status, 1 do
		if status[i].name == statusName then
			cb(status[i])
			break
		end
	end
end)

RegisterServerEvent('dg_status:update')
AddEventHandler('dg_status:update', function(status)
	local xPlayer = DGCore.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('status', status)
	end
end)

Citizen.CreateThread(function()
	while(true) do
		Citizen.Wait(10 * 60 * 1000)
		
		SaveData()

	end

end)

function SaveData()
	local xPlayers = DGCore.GetPlayers()

	-- Example of a bulk update statement that we are building below
	--[[
	UPDATE users
    SET status = (case when identifier = 'license:123' then '{hunger:45, thirst:23}'
                         when identifier = 'license:456' then '{hunger:1000, thirst:1000}'
                         when identifier = 'license:789' then '{hunger:1000, thirst:1000}'
                    end)
    WHERE identifier in ('license:123', 'license:456', 'license:789')

	]]
	local updateStatement = 'UPDATE users SET status = (case %s end) where identifier in (%s)'
	local whenList = ''
	local whereList = ''
	local firstItem = true
	local playerCount = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = DGCore.GetPlayerFromId(xPlayers[i])
		local status  = xPlayer.get('status')

		whenList = whenList .. string.format('when identifier = \'%s\' then \'%s\' ', xPlayer.identifier, json.encode(status))

		if firstItem == false then
			whereList = whereList .. ', '
		end
		whereList = whereList .. string.format('\'%s\'', xPlayer.identifier)

		firstItem = false
		playerCount = playerCount + 1
	end

	if playerCount > 0 then
		local sql = string.format(updateStatement, whenList, whereList)

		MySQL.Async.execute(sql)

	end

end
