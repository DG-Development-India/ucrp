DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

DGCore.RegisterUsableItem('bread', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)
	TriggerClientEvent('dg_status:add', source, 'hunger', 300000)
	TriggerClientEvent('dg_basicneeds:onEat', source)
end)

DGCore.RegisterUsableItem('sandwich', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sandwich', 1)
	TriggerClientEvent('dg_status:add', source, 'hunger', 500000)
	TriggerClientEvent('dg_basicneeds:onEatSW', source)
end)

DGCore.RegisterUsableItem('donut', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('donut', 1)
	TriggerClientEvent('dg_status:add', source, 'hunger', 200000)
	TriggerClientEvent('dg_basicneeds:onEatPZ', source)
end)

DGCore.RegisterUsableItem('greenapple', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('greenapple', 1)
	TriggerClientEvent('dg_status:add', source, 'thirst', 400000)
	TriggerClientEvent('dg_basicneeds:onDrinkGA', source)
end)

DGCore.RegisterUsableItem('water', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	TriggerClientEvent('dg_status:add', source, 'thirst', 200000)
	TriggerClientEvent('dg_basicneeds:onDrink', source)
end)


TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('dg_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('dg_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('dg_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('dg_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})