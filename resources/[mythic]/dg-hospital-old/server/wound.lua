local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('dg-hospital:server:SyncInjuries')
AddEventHandler('dg-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)