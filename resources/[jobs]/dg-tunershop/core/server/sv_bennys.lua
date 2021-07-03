DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('dg_tunershop:attemptPurchase')
AddEventHandler('dg_tunershop:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local xPlayer = DGCore.GetPlayerFromId(source)
    if type == "repair" then
        
    elseif type == "performance" then
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('dg_tunershop:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('dg_tunershop:purchaseFailed', source)
        end
    else
        if xPlayer.getMoney() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('dg_tunershop:purchaseSuccessful', source)
            xPlayer.removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('dg_tunershop:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(myCar)
    MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)