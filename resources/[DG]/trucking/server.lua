DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

for k, v in pairs(Config.Jobs) do
    v['taken'] = false
end

RegisterServerEvent('dg_ets:startJob')
AddEventHandler('dg_ets:startJob', function(id)
    local xPlayer, hasJob = DGCore.GetPlayerFromId(source), true
    if Config.Job['jobRequired'] then
        if xPlayer.job.name == Config.Job['jobName'] then
            hasJob = true
        else
            hasJob = false
        end
    end
    if hasJob then
        if not Config.Jobs[id]['taken'] then
            Config.Jobs[id]['taken'] = true
            TriggerClientEvent('dg_ets:start', xPlayer.source, Config.Jobs[id], id)
        else
            TriggerClientEvent('dg:showNotification', xPlayer.source, Strings['somebody_doing'])
			
        end
    else
        TriggerClientEvent('dg:showNotification', xPlayer.source, Strings['not_job'])
    end
end)

RegisterServerEvent('dg_ets:jobMenu')
AddEventHandler('dg_ets:jobMenu', function()
    local elements, xPlayer = {}, DGCore.GetPlayerFromId(source)
    for k, v in pairs(Config.Jobs) do
        if not v['taken'] then
            table.insert(elements, {label = v.title, value = k})
        end
    end
    TriggerClientEvent('dg_ets:menu', xPlayer.source, elements)
end)

RegisterServerEvent('dg_ets:jobFinished')
AddEventHandler('dg_ets:jobFinished', function(id, damages)
    local xPlayer = DGCore.GetPlayerFromId(source)
    if Config.Jobs[id]['taken'] then
        local price, health = Config.Jobs[id].payment, (damages['body_health'] + damages['engine_health']) / 2
        for k, v in pairs(damages['windows']) do health = health - 30 end
        for k, v in pairs(damages['tires']) do health = health - 35 end
        for k, v in pairs(damages['doors']) do health = health - 40 end
        if health <= 900 and health > 800 then price = price - 50 elseif health <= 800 and health > 700 then price = price - 75 elseif health <= 700 and health > 600 then price = price - 100 elseif health <= 600 and health > 300 then price = price - 150 elseif health <= 300 then price = price - 350 end
        if price >= 0 then
            xPlayer.addMoney(price)
            TriggerClientEvent('dg:showNotification', xPlayer.source, (Strings['reward']):format(price))
			
        else
            xPlayer.removeMoney(price)
            TriggerClientEvent('dg:showNotification', xPlayer.source, (Strings['paid_damages']):format(price))
        end
        Wait(Config.ReAdd * 1000)
        Config.Jobs[id]['taken'] = false
    end
end)

