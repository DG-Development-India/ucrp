DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

DGCore.RegisterServerCallback('dg-carwash:canAfford', function(source, cb)
	local xPlayer = DGCore.GetPlayerFromId(source)

	if Config.EnablePrice then
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)
			cb(true)
		else
			cb(false)
		end
	else
		cb(true)
	end
end)