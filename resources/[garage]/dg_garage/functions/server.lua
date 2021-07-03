
DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) 
    DGCore = obj 
end)

GetMoney = function(src)
    local xPlayer = DGCore['GetPlayerFromId'](src)
    local money = {}
    money['cash'] = xPlayer['getMoney']()
    money['bank'] = xPlayer['getAccount']('bank')['money']
    return money
end

RemoveMoney = function(src, type, amount)
    local xPlayer = DGCore['GetPlayerFromId'](src) 
    if type == 'cash' then
        xPlayer['removeMoney'](amount)
    elseif type == 'bank' then
        xPlayer['removeAccountMoney']('bank', amount)
    end
end

Notify = function(src, message, messagetype, messagetimeout)
    TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = message })
end