DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('thermite:StartFireAtLocation')
AddEventHandler('thermite:StartFireAtLocation', function(x,y,z,arg1,arg2)
    local source = source
    TriggerClientEvent('thermite:StartClientFires', -1, x,y,z,arg1,arg2)
end)

RegisterServerEvent('thermite:StopFires')
AddEventHandler('thermite:StopFires', function(x,y,z)
    local source = source
    TriggerClientEvent('thermite:StopFiresClient', -1, x,y,z)
end)