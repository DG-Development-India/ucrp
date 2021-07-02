DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj)
    DGCore = obj
end)

RegisterServerEvent('dg-interactions:putInVehicle')
AddEventHandler('dg-interactions:putInVehicle', function(target)
    TriggerClientEvent('dg-interactions:putInVehicle', target)
end)

RegisterServerEvent('dg-interactions:outOfVehicle')
AddEventHandler('dg-interactions:outOfVehicle', function(target)
    TriggerClientEvent('dg-interactions:outOfVehicle', target)
end)
