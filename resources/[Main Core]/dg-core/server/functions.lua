DGCore.Trace = function(str)
	if Config.EnableDebug then
		print('DGCore> ' .. str)
	end
end

DGCore.SetTimeout = function(msec, cb)
	local id = DGCore.TimeoutCount + 1

	SetTimeout(msec, function()
		if DGCore.CancelledTimeouts[id] then
			DGCore.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	DGCore.TimeoutCount = id

	return id
end

DGCore.ClearTimeout = function(id)
	DGCore.CancelledTimeouts[id] = true
end

DGCore.RegisterServerCallback = function(name, cb)
	DGCore.ServerCallbacks[name] = cb
end

DGCore.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if DGCore.ServerCallbacks[name] ~= nil then
		DGCore.ServerCallbacks[name](source, cb, ...)
	else
		print('dg-core: TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

DGCore.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}
	xPlayer.setLastPosition(xPlayer.getCoords())

	-- User accounts
	for i=1, #xPlayer.accounts, 1 do
		if DGCore.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] ~= xPlayer.accounts[i].money then
			table.insert(asyncTasks, function(cb)
				MySQL.Async.execute('UPDATE user_accounts SET money = @money WHERE identifier = @identifier AND name = @name', {
					['@money']      = xPlayer.accounts[i].money,
					['@identifier'] = xPlayer.identifier,
					['@name']       = xPlayer.accounts[i].name
				}, function(rowsChanged)
					cb()
				end)
			end)
			local data2 = xPlayer.accounts[i].money
			TriggerEvent("dg:money", data2, xPlayer)
			DGCore.LastPlayerData[xPlayer.source].accounts[xPlayer.accounts[i].name] = xPlayer.accounts[i].money
		end
	end
	
	-- Job, loadout and position
	table.insert(asyncTasks, function(cb)
		MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade, loadout = @loadout, position = @position WHERE identifier = @identifier', {
			['@job']        = xPlayer.job.name,
			['@job_grade']  = xPlayer.job.grade,
			['@loadout']    = json.encode(xPlayer.getLoadout()),
			['@position']   = json.encode(xPlayer.getLastPosition()),
			['@identifier'] = xPlayer.identifier
		}, function(rowsChanged)
			cb()
		end)
	end)

	Async.parallel(asyncTasks, function(results)
		RconPrint('\27[32m[dg-core] [Saving Player]\27[0m ' .. xPlayer.name .. "^7\n")

		if cb ~= nil then
			cb()
		end
	end)
end

DGCore.SavePlayers = function(cb)
	local asyncTasks = {}
	local xPlayers   = DGCore.GetPlayers()

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb)
			local xPlayer = DGCore.GetPlayerFromId(xPlayers[i])
			DGCore.SavePlayer(xPlayer, cb)
		end)
	end

	Async.parallelLimit(asyncTasks, 8, function(results)
		RconPrint('\27[32m[dg-core] [Saving All Players]\27[0m' .. "\n")

		if cb ~= nil then
			cb()
		end
	end)
end

DGCore.StartDBSync = function()
	function saveData()
		DGCore.SavePlayers()
		SetTimeout(10 * 60 * 1000, saveData)
	end

	SetTimeout(10 * 60 * 1000, saveData)
end

DGCore.GetPlayers = function()
	local sources = {}

	for k,v in pairs(DGCore.Players) do
		table.insert(sources, k)
	end

	return sources
end


DGCore.GetPlayerFromId = function(source)
	return DGCore.Players[tonumber(source)]
end

DGCore.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(DGCore.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

DGCore.RegisterUsableItem = function(item, cb)
	DGCore.UsableItemsCallbacks[item] = cb
end

DGCore.UseItem = function(source, item)
	DGCore.UsableItemsCallbacks[item](source)
end

DGCore.GetItemLabel = function(item)
	if DGCore.Items[item] ~= nil then
		return DGCore.Items[item].label
	end
end

DGCore.CreatePickup = function(type, name, count, label, player)
	local pickupId = (DGCore.PickupId == 65635 and 0 or DGCore.PickupId + 1)

	DGCore.Pickups[pickupId] = {
		type  = type,
		name  = name,
		count = count
	}

	TriggerClientEvent('dg:pickup', -1, pickupId, label, player)
	DGCore.PickupId = pickupId
end

DGCore.DoesJobExist = function(job, grade)
	grade = tostring(grade)

	if job and grade then
		if DGCore.Jobs[job] and DGCore.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end