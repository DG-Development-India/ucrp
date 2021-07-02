DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj)
    DGCore = obj
end)

RegisterCommand('id', function(source, args, raw)
    local player = DGCore.GetPlayerFromId(source)
    if Config.AdminOnly then
        if player.getGroup() == 'user' then
            return
        end
    end
    TriggerClientEvent('disc-showid:id', source)
end)