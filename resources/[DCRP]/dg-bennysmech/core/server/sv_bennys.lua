DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
local chicken = vehicleBaseRepairCost

RegisterServerEvent('dg-bennysmech:attemptPurchase')
AddEventHandler('dg-bennysmech:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local xPlayer = DGCore.GetPlayerFromId(source)
    if type == "repair" then
        if xPlayer.getMoney() >= chicken then
            xPlayer.removeMoney(chicken)
            TriggerClientEvent('dg-bennysmech:purchaseSuccessful', source)
        else
            TriggerClientEvent('dg-bennysmech:purchaseFailed', source)
        end
    elseif type == "performance" then
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('dg-bennysmech:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('dg-bennysmech:purchaseFailed', source)
        end
    else
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('dg-bennysmech:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('dg-bennysmech:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('dg-bennysmech:updateRepairCost')
AddEventHandler('dg-bennysmech:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent('dg-bennysmech:updateVehicle')
AddEventHandler('dg-bennysmech:updateVehicle', function(myCar)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)