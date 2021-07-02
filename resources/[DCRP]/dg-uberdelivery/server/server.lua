DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('dg-uberkdshfksksdhfskdjjob:pay')
AddEventHandler('dg-uberkdshfksksdhfskdjjob:pay', function(amount)
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount))
	TriggerClientEvent('chatMessagess', _source, '', 4, 'You got payed $' .. amount)
end)
