DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent("dg_fleeca:startcheck")
AddEventHandler("dg_fleeca:startcheck", function(bank)
    local _source = source
    local xPlayer = DGCore.GetPlayerFromId(_source)
    if not fleeca.Banks[bank].onaction == true then
        if (os.time() - fleeca.cooldown) > fleeca.Banks[bank].lastrobbed then
            fleeca.Banks[bank].onaction = true
            TriggerClientEvent("dg_fleeca:outcome", _source, true, bank)
            TriggerClientEvent('dg_dispatch:bankrobbery', -1)
            return
        else
            TriggerClientEvent("dg_fleeca:outcome", _source, false, "This bank recently robbed. You need to wait "..math.floor((fleeca.cooldown - (os.time() - fleeca.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((fleeca.cooldown - (os.time() - fleeca.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("dg_fleeca:outcome", _source, false, "This bank is currently being robbed.")
    end
end)

RegisterServerEvent("dg_fleeca:lootup")
AddEventHandler("dg_fleeca:lootup", function(var, var2)
    TriggerClientEvent("dg_fleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("dg_fleeca:openDoor")
AddEventHandler("dg_fleeca:openDoor", function(coords, method,type)
    TriggerClientEvent("dg_fleeca:openDoor_c", -1, coords, method,type)
end)

RegisterServerEvent("dg_fleeca:startLoot")
AddEventHandler("dg_fleeca:startLoot", function(data, name, players)
    local _source = source

    for i = 1, #players, 1 do
        TriggerClientEvent("dg_fleeca:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("dg_fleeca:startLoot_c", _source, data, name)
end)

RegisterServerEvent("dg_fleeca:stopHeist")
AddEventHandler("dg_fleeca:stopHeist", function(name)
    TriggerClientEvent("dg_fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("dg_fleeca:setCooldown")
AddEventHandler("dg_fleeca:setCooldown", function(name)
    fleeca.Banks[name].lastrobbed = os.time()
    fleeca.Banks[name].onaction = false
    TriggerClientEvent("dg_fleeca:resetDoorState", -1, name)
end)

DGCore.RegisterServerCallback("dg_fleeca:getBanks", function(source, cb)
    cb(fleeca.Banks)
end)