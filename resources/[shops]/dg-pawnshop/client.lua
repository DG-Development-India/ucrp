local shopCoords  =     config.pawncoords
local fishCoords =  {x = -1037.97, y = -1397.07 , z = 5.55 }
local items      =     config.items

DGCore = nil
Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    for k,v  in pairs(shopCoords) do
      local distance = Vdist(pCoords, v.x, v.y, v.z, false)
      if distance < 2.0 then
        DrawText3D(v.x, v.y, v.z, '[~g~E~s~] - Sell', 1.0)
        if distance < 1.5 then
          if IsControlJustPressed(0,46) then
            OpenShop(k)
          end
        end
      end
    end
  end
end)

function OpenShop(shop)
  local elements = {}
  for k,v in pairs(items) do 
    if v.shop == shop then
      table.insert(elements, {label = ''.. v.label .. '- $'..v.price, value = k }) 
    end
  end
  
  DGCore.UI.Menu.CloseAll()
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'pawnshop', {
		title    = 'Pawn Shop',
		align    = 'top-right',
		elements = elements
  }, function(data, menu)
    menu.close()
    DGCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'itemsell', {
      title = 'How many to sell?'
    }, function(data2, menu2)
      menu2.close()
      local amount = tonumber(data2.value)
      if tonumber(data2.value) ~= nil then
        print(data.current.value, amount)
        if exports['dg-inventory']:hasEnoughOfItem(data.current.value, amount) then
          TriggerEvent('inventory:removeItem', data.current.value, amount)
          TriggerServerEvent('dg_pawnshop:givemoney',data.current.value, amount)
        else
          exports['mythic_notify']:SendAlert('error', 'You don\'t have these many items to sell')
        end
      else
        exports['mythic_notify']:SendAlert('error', 'We asked for the numbers you dumbfuck!')
      end  
    end, function(data2, menu2)
      menu2.close()
    end)
  end, function(data, menu)
    menu.close()
  end)
end

function DrawText3D(x, y, z, text, scale)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


--- Fish shop 

Citizen.CreateThread(function()
  wait = 100
  while true do
    Citizen.Wait(wait)
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local distance = Vdist(pCoords, fishCoords.x, fishCoords.y, fishCoords.z, false)
    if distance < 10.0 then
      wait = 0 
      if distance < 2.0 then
        DrawText3D(fishCoords.x, fishCoords.y, fishCoords.z, '[~g~E~s~] - Sell Fish', 1.0)
        if distance < 1.5 then
          if IsControlJustPressed(0,46) then
            OpenFishShop()
          end
        end
      end
    else
      wait = 100
    end
  end
end)


function OpenFishShop()
  
  local elements = {}
  
  for k,v in pairs(config.fishes) do 
    table.insert(elements, {label = ''.. v.label .. '- $'..v.price, value = k }) 
  end
  
  DGCore.UI.Menu.CloseAll()
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'fishshop', {
		title    = 'Fish Shop',
		align    = 'top-right',
		elements = elements
  }, function(data, menu)
    menu.close()
    DGCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'fishsell', {
      title = 'How many to sell?'
    }, function(data2, menu2)
      menu2.close()
      local amount = tonumber(data2.value)
      if tonumber(data2.value) ~= nil then
        if exports['dg-inventory']:hasEnoughOfItem(data.current.value, amount) then
          TriggerEvent('inventory:removeItem', data.current.value, amount)
          TriggerServerEvent("dg-base:addmoney", config.fishes[data.current.value].price*amount, "Sold ".. amount .. "x ".. data.current.value )
        else
          exports['mythic_notify']:SendAlert('error', 'You don\'t have these many fishes to sell')
        end
      else
        exports['mythic_notify']:SendAlert('error', 'We asked for the numbers you dumbfuck!')
      end  
    end, function(data2, menu2)
      menu2.close()
    end)
  end, function(data, menu)
    menu.close()
  end)

end

-- Valuable goods Shop

local paletoShopCoords = { x = -111.57, y = 6471.67, z = 31.63 , h = 136.11 }

function isNight()
  local hour = GetClockHours()
  if hour > 18 or hour < 6 then
    return true
  end
end

function CreatePawnMerchant()

  local hashKey = `ig_jewelass`
  local pedType = 4
  RequestModel(hashKey)
  while not HasModelLoaded(hashKey) do
      RequestModel(hashKey)
      Citizen.Wait(100)
  end

  merchantPed = CreatePed(pedType, hashKey, paletoShopCoords.x, paletoShopCoords.y, paletoShopCoords.z-1, paletoShopCoords.h, 0, 0)
  ClearPedTasks(merchantPed)
  ClearPedSecondaryTask(merchantPed)
  TaskSetBlockingOfNonTemporaryEvents(merchantPed, true)
  SetPedFleeAttributes(merchantPed, 0, 0)
  SetPedCombatAttributes(merchantPed, 17, 1)
  SetPedSeeingRange(merchantPed, 0.0)
  SetPedHearingRange(merchantPed, 0.0)
  SetPedAlertness(merchantPed, 0)
  SetPedKeepTask(merchantPed, true)
  SetEntityInvincible(merchantPed, true)
  FreezeEntityPosition(merchantPed, true)

end

local pressed = false

Citizen.CreateThread(function ()
  CreatePawnMerchant()
  while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local distance = Vdist(pCoords, paletoShopCoords.x, paletoShopCoords.y, paletoShopCoords.z, false)
    if distance < 2.0 then
      DrawText3D(paletoShopCoords.x, paletoShopCoords.y, paletoShopCoords.z, '[~g~E~s~] - Sell', 1.0)
      if distance < 1.5 then
        if IsControlJustPressed(0,46) then
          if isNight() then
            if not pressed then
              pressed = true
              ValuableShop()
            else
              exports['mythic_notify']:SendAlert('inform', 'Babe! Count the money first what I gave.')
            end
          else
            exports['mythic_notify']:SendAlert('inform', 'Honey! I am in middle of my shift.')
          end
        end
      end
    end
  end
end)

function ValuableShop()
  local elements = {}
  
  for k,v in pairs(config.valuables) do 
    table.insert(elements, {label = ''.. v.label .. '- $'..v.price, value = k }) 
  end
  
  DGCore.UI.Menu.CloseAll()
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'valuableshop', {
		title    = 'Valuable Shop',
		align    = 'top-right',
		elements = elements
  }, function(data, menu)
    menu.close()
    DGCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'valuablesell', {
      title = 'How many to sell?'
    }, function(data2, menu2)
      menu2.close()
      local amount = tonumber(data2.value)
      if tonumber(data2.value) ~= nil then
        if exports['dg-inventory']:hasEnoughOfItem(data.current.value, amount) then
          TriggerEvent('inventory:removeItem', data.current.value, amount)
          TriggerEvent("ndrp_emotes:playthisemote", 'parkingmeter')
          FreezeEntityPosition(PlayerPedId(), true)
          exports["dg-taskbar"]:taskBar(120*1000, "Completing Transaction")
          TriggerEvent("ndrp_emotes:playthisemote", 'c')
          FreezeEntityPosition(PlayerPedId(), false)
          if (data.current.value == 'rolexwatch') then
            TriggerEvent('player:receiveItem', 'cashroll', amount)
            TriggerServerEvent("dg-base:addmoney", 250*amount, "Some extra cash for you honey!")
          elseif (data.current.value == 'goldbar') then
            TriggerEvent('player:receiveItem', 'cashstack', amount)
          else
            TriggerServerEvent("dg-base:addmoney", config.valuables[data.current.value].price*amount, "Sold ".. amount .. "x ".. data.current.value )
          end
          
        else
          exports['mythic_notify']:SendAlert('error', 'You don\'t have these many items to sell')
        end
      else
        exports['mythic_notify']:SendAlert('error', 'We asked for the numbers you dumbfuck!')
      end
      pressed = false
    end, function(data2, menu2)
      menu2.close()
      pressed = false
    end)
  end, function(data, menu)
    menu.close()
    pressed = false
  end)
  
end


local picture_ped
Citizen.CreateThread(function()

    local hashkey = GetHashKey("csb_oscar")

	RequestModel(hashkey)
	while not HasModelLoaded(hashkey) do Wait(1) end

	picture_ped = CreatePed(1, hashkey, 1538.62, 3595.707, 38.76654, 209.16586303711, false, true)
	SetBlockingOfNonTemporaryEvents(picture_ped, true)
	SetPedDiesWhenInjured(picture_ped, false)
	SetPedCanPlayAmbientAnims(picture_ped, true)
	SetPedCanRagdollFromPlayerImpact(picture_ped, false)
	SetEntityInvincible(picture_ped, true)
	FreezeEntityPosition(picture_ped, true)
  --TaskStartScenarioInPlace(picture_ped, 'weed', 0, true);

end)