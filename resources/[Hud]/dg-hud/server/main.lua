DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj)
    DGCore = obj
end)

RegisterServerEvent('baseevents:enteringVehicle')
AddEventHandler('baseevents:enteringVehicle', function(currentVehicle, currentSeat, displayname, netId)
    TriggerClientEvent('disc-hud:EnteringVehicle', source, currentVehicle, currentSeat, displayname, netId)
end)

RegisterServerEvent('baseevents:enteringAborted')
AddEventHandler('baseevents:enteringAborted', function()
    TriggerClientEvent('disc-hud:EnteringVehicleAborted', source)
end)

RegisterServerEvent('baseevents:enteredVehicle')
AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, displayname)
    TriggerClientEvent('disc-hud:EnteredVehicle', source, currentVehicle, currentSeat, displayname)
end)

RegisterServerEvent('baseevents:leftVehicle')
AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat, displayname)
    TriggerClientEvent('disc-hud:LeftVehicle', source, currentVehicle, currentSeat, displayname)
end)

DGCore.RegisterServerCallback('disc-hud:getMoney', function(source, cb)
    local player = DGCore.GetPlayerFromId(source)
    cb({
        cash = player.getMoney(),
        bank = player.getAccount('bank').money
    })
end)