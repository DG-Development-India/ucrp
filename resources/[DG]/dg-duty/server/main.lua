DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('duty:police')
AddEventHandler('duty:police', function(job)

        local _source = source
        local xPlayer = DGCore.GetPlayerFromId(_source)

    if xPlayer.job.name == 'police' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offpolice', 0)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offpolice', 1)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offpolice', 2)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offpolice', 3)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 4 then
        xPlayer.setJob('offpolice', 4)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 5 then
        xPlayer.setJob('offpolice', 5)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 6 then
        xPlayer.setJob('offpolice', 6)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 7 then
        xPlayer.setJob('offpolice', 7)
    elseif xPlayer.job.name == 'police' and xPlayer.job.grade == 8 then
        xPlayer.setJob('offpolice', 8)
    end

    if xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 0 then
        xPlayer.setJob('police', 0)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 1 then
        xPlayer.setJob('police', 1)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 2 then
        xPlayer.setJob('police', 2)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 3 then
        xPlayer.setJob('police', 3)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 4 then
        xPlayer.setJob('police', 4)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 5 then
        xPlayer.setJob('police', 5)
      elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 6 then
        xPlayer.setJob('police', 6)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 7 then
        xPlayer.setJob('police', 7)
    elseif xPlayer.job.name == 'offpolice' and xPlayer.job.grade == 8 then
        xPlayer.setJob('police', 8)
    end
end)

RegisterServerEvent('duty:ambulance')
AddEventHandler('duty:ambulance', function(job)

        local _source = source
        local xPlayer = DGCore.GetPlayerFromId(_source)

    if xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offambulance', 0)
    elseif xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offambulance', 1)
    elseif xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offambulance', 2)
    elseif xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offambulance', 3)
    elseif xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 4 then
        xPlayer.setJob('offambulance', 4)
    elseif xPlayer.job.name == 'ambulance' and xPlayer.job.grade == 5 then
        xPlayer.setJob('offambulance', 5)
    end

    if xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 0 then
        xPlayer.setJob('ambulance', 0)
    elseif xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 1 then
        xPlayer.setJob('ambulance', 1)
    elseif xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 2 then
        xPlayer.setJob('ambulance', 2)
    elseif xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 3 then
        xPlayer.setJob('ambulance', 3)
    elseif xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 4 then
        xPlayer.setJob('ambulance', 4)
    elseif xPlayer.job.name == 'offambulance' and xPlayer.job.grade == 5 then
        xPlayer.setJob('ambulance', 5)
    end
end)

RegisterServerEvent('duty:doj')
AddEventHandler('duty:doj', function(job)

        local _source = source
        local xPlayer = DGCore.GetPlayerFromId(_source)

    if xPlayer.job.name == 'doj' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offdoj', 0)
    elseif xPlayer.job.name == 'doj' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offdoj', 1)
    elseif xPlayer.job.name == 'doj' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offdoj', 2)
    elseif xPlayer.job.name == 'doj' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offdoj', 3)
    end

    if xPlayer.job.name == 'offdoj' and xPlayer.job.grade == 0 then
        xPlayer.setJob('doj', 0)
    elseif xPlayer.job.name == 'offdoj' and xPlayer.job.grade == 1 then
        xPlayer.setJob('doj', 1)
    elseif xPlayer.job.name == 'offdoj' and xPlayer.job.grade == 2 then
        xPlayer.setJob('doj', 2)
    elseif xPlayer.job.name == 'offdoj' and xPlayer.job.grade == 3 then
        xPlayer.setJob('doj', 3)
    end
end)

RegisterServerEvent('duty:pdm')
AddEventHandler('duty:pdm', function(job)

        local _source = source
        local xPlayer = DGCore.GetPlayerFromId(_source)

    if xPlayer.job.name == 'pdm' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offpdm', 0)
    elseif xPlayer.job.name == 'pdm' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offpdm', 1)
    elseif xPlayer.job.name == 'pdm' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offpdm', 2)
    elseif xPlayer.job.name == 'pdm' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offpdm', 3)
    end

    if xPlayer.job.name == 'offpdm' and xPlayer.job.grade == 0 then
        xPlayer.setJob('pdm', 0)
    elseif xPlayer.job.name == 'offpdm' and xPlayer.job.grade == 1 then
        xPlayer.setJob('pdm', 1)
    elseif xPlayer.job.name == 'offpdm' and xPlayer.job.grade == 2 then
        xPlayer.setJob('pdm', 2)
    elseif xPlayer.job.name == 'offpdm' and xPlayer.job.grade == 3 then
        xPlayer.setJob('pdm', 3)
    end
end)

RegisterServerEvent('duty:mechanic')
AddEventHandler('duty:mechanic', function(job)

        local _source = source
        local xPlayer = DGCore.GetPlayerFromId(_source)

    if xPlayer.job.name == 'mechanic' and xPlayer.job.grade == 0 then
        xPlayer.setJob('offmechanic', 0)
    elseif xPlayer.job.name == 'mechanic' and xPlayer.job.grade == 1 then
        xPlayer.setJob('offmechanic', 1)
    elseif xPlayer.job.name == 'mechanic' and xPlayer.job.grade == 2 then
        xPlayer.setJob('offmechanic', 2)
    elseif xPlayer.job.name == 'mechanic' and xPlayer.job.grade == 3 then
        xPlayer.setJob('offmechanic', 3)
    end

    if xPlayer.job.name == 'offmechanic' and xPlayer.job.grade == 0 then
        xPlayer.setJob('mechanic', 0)
    elseif xPlayer.job.name == 'offmechanic' and xPlayer.job.grade == 1 then
        xPlayer.setJob('mechanic', 1)
    elseif xPlayer.job.name == 'offmechanic' and xPlayer.job.grade == 2 then
        xPlayer.setJob('mechanic', 2)
    elseif xPlayer.job.name == 'offmechanic' and xPlayer.job.grade == 3 then
        xPlayer.setJob('mechanic', 3)
    end
end)