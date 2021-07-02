DGCore               = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

DGCore.RegisterUsableItem('binoculars', function(source)
    local xPlayer = DGCore.GetPlayerFromId(source)
    local drill = xPlayer.getInventoryItem('binoculars')

    TriggerClientEvent('binoculars:Activate', source)
end)