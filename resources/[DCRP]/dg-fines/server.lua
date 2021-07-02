DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterCommand('fine', function(source, args, raw)
    local src = source
    local me = DGCore.GetPlayerFromId(src)
    local myPed = GetPlayerPed(src)
    local myPos = GetEntityCoords(myPed)
    local players = DGCore.GetPlayers()

    for k, v in ipairs(players) do
        if v ~= src then
            local xTarget = GetPlayerPed(v)
            local xPlayer = DGCore.GetPlayerFromId(v)
            local tPos = GetEntityCoords(xTarget)
            local dist = #(vector3(tPos.x, tPos.y, tPos.z) - myPos)
            local xSource = DGCore.GetPlayerFromId(source)
        
            if dist < 1 and xSource.job.name == 'police' then
                if tonumber(args[1]) ~= nil then
                    TriggerClientEvent('DoLongHudText',  source, 'You have fined ID - [' .. v .. '] for $' .. tonumber(args[1]) .. '.', 1)
                    TriggerClientEvent('DoLongHudText',  v, 'You have been sent a Fine for $' .. tonumber(args[1]) .. '.', 1)
                    TriggerClientEvent('dg-fines:Anim', source)
                    xPlayer.removeAccountMoney('bank', tonumber(args[1]))
                    me.addAccountMoney('bank', tonumber(args[1]))
                end
            end
        end
    end
end)