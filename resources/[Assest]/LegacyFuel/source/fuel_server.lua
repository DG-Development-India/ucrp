DGCore = nil

if Config.UseDGCore then
	TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = DGCore.GetPlayerFromId(source)
		local amount = DGCore.Math.Round(price)

		if price > 0 then
			xPlayer.removeMoney(amount)
		end
	end)
end
