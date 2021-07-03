local DGCore = nil

--[[chance = 1 is very common, the higher the value the less the chance]]--

TriggerEvent('dg:getSharedObject', function(obj)
 DGCore = obj
end)

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
  local source = tonumber(source)
  local xPlayer = DGCore.GetPlayerFromId(source)
  TriggerClientEvent('inventory:removeItem', source, 'advlockpick', 1)
  TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
  local source = tonumber(source)
  local xPlayer = DGCore.GetPlayerFromId(source)
  local cash = math.random(50, 300)
  xPlayer.addMoney(cash)
  TriggerClientEvent('DoLongHudText',  source, 'You found $'..cash , 1)
end)