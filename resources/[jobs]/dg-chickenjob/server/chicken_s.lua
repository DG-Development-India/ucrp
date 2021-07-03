DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj)
	DGCore = obj
end)

RegisterServerEvent('chickenpayment:pay')
AddEventHandler('chickenpayment:pay', function(quantity)
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)
	local price = quantity * math.random(200,350)
	xPlayer.addMoney(price)
end)