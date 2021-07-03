DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

---------- Pawn Shop --------------

RegisterServerEvent('dg_pawnshop:givemoney')
AddEventHandler('dg_pawnshop:givemoney', function(name, amount)
	local _source,_name,_amount = source, name, amount
	local price = tonumber(amount * config.items[name].price)
	local label = config.items[name].label
	local xPlayer = DGCore.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		xPlayer.addMoney(price)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'success', text = 'You sold '.. amount ..'x '.. label .. ' for $'.. price ..' to the pawn shop' , length = 2500 })
		TriggerEvent('pawn:logs',_source,amount,label,price)
	end
end)