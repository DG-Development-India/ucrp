DGCore               = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

----
DGCore.RegisterUsableItem('gauze', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('gauze', 1)

	TriggerClientEvent('dg-hospital:items:gauze', source)
end)

DGCore.RegisterUsableItem('bandaids', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bandaids', 1)

	TriggerClientEvent('dg-hospital:items:bandage', source)
end)

DGCore.RegisterUsableItem('firstaid', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('firstaid', 1)

	TriggerClientEvent('dg-hospital:items:firstaid', source)
end)

DGCore.RegisterUsableItem('vicodin', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vicodin', 1)

	TriggerClientEvent('dg-hospital:items:vicodin', source)
end)

DGCore.RegisterUsableItem('ifak', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ifak', 1)

	TriggerClientEvent('dg-hospital:items:ifak', source)
end)

DGCore.RegisterUsableItem('hydrocodone', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('hydrocodone', 1)

	TriggerClientEvent('dg-hospital:items:hydrocodone', source)
end)

DGCore.RegisterUsableItem('morphine', function(source)
	local xPlayer = DGCore.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('morphine', 1)

	TriggerClientEvent('dg-hospital:items:morphine', source)
end)
