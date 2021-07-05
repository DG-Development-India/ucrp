local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('dg-hospital:server:SyncInjuries')
AddEventHandler('dg-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)

RegisterServerEvent('dg-hospital:getInjuries')
AddEventHandler('dg-hospital:getInjuries', function(playerID)
    if playerInjury[playerID] ~= nil then
        TriggerClientEvent('dg-hospital:getInjuries',source,playerID,playerInjury[playerID])
    end
end)