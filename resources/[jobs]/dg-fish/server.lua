DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

-- RegisterServerEvent('dg-fish:payShit')
-- AddEventHandler('dg-fish:payShit', function(money)
--     local source = source
--     local xPlayer  = DGCore.GetPlayerFromId(source)
--     if money ~= nil then
--         xPlayer.addMoney(money)
--     end
-- end)

RegisterServerEvent('fish:checkAndTakeDepo')
AddEventHandler('fish:checkAndTakeDepo', function()
local source = source
local xPlayer  = DGCore.GetPlayerFromId(source)
    xPlayer.removeMoney(500)
end)

RegisterServerEvent('fish:returnDepo')
AddEventHandler('fish:returnDepo', function()
local source = source
local xPlayer  = DGCore.GetPlayerFromId(source)
    xPlayer.addMoney(500)
end)

RegisterServerEvent('dg-fish:getFish')
AddEventHandler('dg-fish:getFish', function()
local source = source
    TriggerClientEvent('player:receiveItem', source, "fish", math.random(1,2))
end)