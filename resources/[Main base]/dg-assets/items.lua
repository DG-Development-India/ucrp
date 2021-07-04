local canBeUsed = true
local alive = true
local cuffed = false

local UsingAnyItem = false
local increaseStamina = false
local onEnergyDrink = false
local onO2tank = false
local onAlcohol = false
local drugEffect = false

--------------------------------
---------Food Items-------------
--------------------------------

-- Shop items

RegisterNetEvent('food:burger')
AddEventHandler('food:burger', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'hamburger', 1)
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Eating a burger')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 100000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:sandwich')
AddEventHandler('food:sandwich', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'sandwich', 1)
        TriggerEvent("dg-emotes:playthisemote",'sandwich')
        local eating = exports["dg-taskbar"]:taskBar(9000,'Eating a sandwich')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 150000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:donut')
AddEventHandler('food:donut', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'donut', 1)
        TriggerEvent("dg-emotes:playthisemote",'donut')
        local eating = exports["dg-taskbar"]:taskBar(5000,'Eating a donut')

        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Better than Nothing')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- McDonald's Stuff

-- McDonald's Stuff

RegisterNetEvent('food:salad')
AddEventHandler('food:salad', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Having Salad')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 200000)
        exports['mythic_notify']:SendAlert('inform', 'You feel healthy')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:fries')
AddEventHandler('food:fries', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Eating Fries')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 300000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcaloo')
AddEventHandler('food:mcaloo', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Eating Aloo Tikki')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 300000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcveggie')
AddEventHandler('food:mcveggie', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Veg Burger')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 750000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcpaneerwrap')
AddEventHandler('food:mcpaneerwrap', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Panner Wrap')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 750000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcsignaturewrap')
AddEventHandler('food:mcsignaturewrap', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Signature Wrap')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 500000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcnugget')
AddEventHandler('food:mcnugget', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Nuggets')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 300000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcchicken')
AddEventHandler('food:mcchicken', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Chicken Burger')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 750000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcchickenwrap')
AddEventHandler('food:mcchickenwrap', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Chicken Wrap')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 500000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcmaharaja')
AddEventHandler('food:mcmaharaja', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'burger')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Eating Maharaja Burger')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 1000000)
        TriggerEvent('dg_status:remove', 'thirst', 100000)
        exports['mythic_notify']:SendAlert('inform', 'You are full')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcchocolatefrappe')
AddEventHandler('food:mcchocolatefrappe', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'drink')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Drinking Chocolate Frappe')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 150000)
        TriggerEvent('dg_status:add', 'thirst', 750000)
        exports['mythic_notify']:SendAlert('inform', 'You are full')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcdietcoke')
AddEventHandler('food:mcdietcoke', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'drink')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Drinking Cococola')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'thirst', 750000)
        exports['mythic_notify']:SendAlert('inform', 'You are full')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mcfanta')
AddEventHandler('food:mcfanta', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("dg-emotes:playthisemote",'drink')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Drinking Fanta')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'thirst', 750000)
        exports['mythic_notify']:SendAlert('inform', 'You are full')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mealbox1')
AddEventHandler('food:mealbox1', function()
    local player = GetPlayerPed(-1)
    if canBeUsed then
        UsingAnyItem = true
        if exports['dg-inventory']:hasEnoughOfItem('mealbox1', 1) then
           -- FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "Veg Mealbox",
                duration = 3000,
                label = 'Opening Veg MealBox',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('mealbox1', 1) then
                        --TriggerEvent("ogrp-chickentaco")
                        --TriggerServerEvent('coke:processed')
                        TriggerEvent('inv:remove','mealbox1',1)
                        TriggerEvent('player:receiveItem', 'mcpaneerwrap', 1)
                        TriggerEvent('player:receiveItem', 'alootikki', 1)
                        TriggerEvent('player:receiveItem', 'mcfries', 1)
                        TriggerEvent('player:receiveItem', 'mcfanta', 1)
                        UsingAnyItem = false
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'Do you really have Mealbox') 
                end
               -- FreezeEntityPosition(player, false)
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Do you really have Mealbox') 
        end
    end
end)

RegisterNetEvent('food:mealbox2')
AddEventHandler('food:mealbox2', function()
    local player = GetPlayerPed(-1)
    if canBeUsed then
        UsingAnyItem = true
        if exports['dg-inventory']:hasEnoughOfItem('mealbox2', 1) then
           -- FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "NonVeg Mealbox",
                duration = 3000,
                label = 'Opening NonVeg MealBox',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('mealbox2', 1) then
                        --TriggerEvent("ogrp-chickentaco")
                        --TriggerServerEvent('coke:processed')
                        TriggerEvent('inv:remove','mealbox2',1)
                        TriggerEvent('player:receiveItem', 'mcchicken', 1)
                        TriggerEvent('player:receiveItem', 'mcnugget', 1)
                        TriggerEvent('player:receiveItem', 'mcfries', 1)
                        TriggerEvent('player:receiveItem', 'mcdietcoke', 1)
                        UsingAnyItem = false
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'Do you really have Mealbox') 
                end
               -- FreezeEntityPosition(player, false)
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Do you really have Mealbox') 
        end
    end
end)

-- Mimi'S burger Stuff

RegisterNetEvent('food:vburger')
AddEventHandler('food:vburger', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'vburger', 1)
        TriggerEvent('dg-emotes:playthisemote', 'burger')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Eating a veg burger')

        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 400000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased greatly')
        exports['mythic_notify']:SendAlert('inform', 'Thrist increased slightly')
        UsingAnyItem = false
        
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:cburger')
AddEventHandler('food:cburger', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'cburger', 1)
        TriggerEvent('dg-emotes:playthisemote', 'burger')
        local eating = exports["dg-taskbar"]:taskBar(17000,'Eating a chicken burger')

        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 600000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased greatly')
        exports['mythic_notify']:SendAlert('inform', 'Thrist increased slightly')
        UsingAnyItem = false
    
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:mimiburger')
AddEventHandler('food:mimiburger', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'mimiburger', 1)
        TriggerEvent('dg-emotes:playthisemote', 'burger')
        local eating = exports["dg-taskbar"]:taskBar(20000,'Eating the Mimi\'s Special burger')

        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 1000000)
        TriggerEvent('dg_status:remove', 'thirst', 100000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry anymore')
        exports['mythic_notify']:SendAlert('inform', 'Thrist increased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Beanmachine stuff

RegisterNetEvent('food:cookie')
AddEventHandler('food:cookie', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'cookie', 1)
        TriggerEvent("dg-emotes:playthisemote",'eat')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Eating cookies')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 150000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:pizza')
AddEventHandler('food:pizza', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'pizza', 1)
        TriggerEvent("dg-emotes:playthisemote",'eat')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Pizza Slice')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 200000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:maccheese')
AddEventHandler('food:maccheese', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'maccheese', 1)
        TriggerEvent("dg-emotes:playthisemote",'eat')
        local eating = exports["dg-taskbar"]:taskBar(10000,'Eating Mac n cheese')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 500000)
        TriggerEvent('dg_status:remove', 'thirst', 50000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:pancakes')
AddEventHandler('food:pancakes', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'pancakes', 1)
        TriggerEvent("dg-emotes:playthisemote",'eat')
        local eating = exports["dg-taskbar"]:taskBar(12000,'Eating Pancakes')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 500000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel hungry')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:spaghetti')
AddEventHandler('food:spaghetti', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'spaghetti', 1)
        TriggerEvent("dg-emotes:playthisemote",'eat')
        local eating = exports["dg-taskbar"]:taskBar(15000,'Eating spaghetti')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 1000000)
        TriggerEvent('dg_status:remove', 'thirst', 100000)
        exports['mythic_notify']:SendAlert('inform', 'You are full')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:chocobar')
AddEventHandler('food:chocobar', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'chocobar', 1)
        TriggerEvent('dg-emotes:playthisemote', 'egobar')
        local eating = exports["dg-taskbar"]:taskBar(5000,'Eating chocolate')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger', 100000)
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent('food:energybar')
AddEventHandler('food:energybar', function()
    if canBeUsed and not onEnergyDrink then
        onEnergyDrink = true
        TriggerEvent("inventory:removeItem",'energybar', 1)
        increaseStamina = true
        TriggerEvent('dg-emotes:playthisemote', 'egobar')
        local eating = exports["dg-taskbar"]:taskBar(5000,'Eating energybar')
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'hunger',50000)
        exports['mythic_notify']:SendAlert('inform', 'Stamina increased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger decreased slightly')
        increaseStamina = false
        Citizen.Wait(100)
        RestorePlayerStamina(PlayerId(), 0.7)
        Citizen.Wait(18000)
        onEnergyDrink = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

---------------------------------
---------Drink Items-------------
---------------------------------

-- Drink

RegisterNetEvent('drink:water')
AddEventHandler('drink:water', function()
    if canBeUsed then
        UsingAnyItem = true
        
        TriggerEvent("inventory:removeItem",'water', 1)
        
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local prop = CreateObject(GetHashKey('prop_ld_flow_bottle'), coords.x, coords.y, coords.z, true, true, true)
        local boneIndex = GetPedBoneIndex(playerPed, 18905)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
        TriggerEvent("dg-emotes:playthisemote",'drink')

        local drinking = exports["dg-taskbar"]:taskBar(5000,'Drinking Water')

		DeleteObject(prop)
		TriggerEvent('dg_status:add', 'thirst',200000)
        TriggerEvent("dg-emotes:playthisemote",'c')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        UsingAnyItem = false

    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Sprunk 

RegisterNetEvent('drink:sprunk')
AddEventHandler('drink:sprunk', function()
    if canBeUsed and not onEnergyDrink then
        onEnergyDrink = true
        TriggerEvent("inventory:removeItem",'sprunk', 1)
        increaseStamina = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local prop = CreateObject(GetHashKey('ng_proc_sodacan_01b'), coords.x, coords.y, coords.z, true, true, true)
        local boneIndex = GetPedBoneIndex(playerPed, 18905)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
        TriggerEvent("dg-emotes:playthisemote",'drink')
        local drinking = exports["dg-taskbar"]:taskBar(3000,'Drinking Sprunk')
        DeleteObject(prop)
        TriggerEvent("dg-emotes:playthisemote",'c')
        TriggerEvent('dg_status:add', 'thirst',50000)
        exports['mythic_notify']:SendAlert('inform', 'Stamina increased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        increaseStamina = false
        Citizen.Wait(100)
        RestorePlayerStamina(PlayerId(), 0.7)
        Citizen.Wait(18000)
        onEnergyDrink = false
    
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Coffee
RegisterNetEvent('drink:mccafe')
AddEventHandler('drink:mccafe', function()
    if canBeUsed then
        UsingAnyItem = true
		TriggerEvent('dg-emotes:playthisemote', 'coffee')
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Cold Coffee')

        TriggerEvent('dg_status:add', 'thirst', 500000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved slightly')
        exports['mythic_notify']:SendAlert('inform', 'You are high on caffeine')
        UsingAnyItem = false
        
	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- RegisterNetEvent('drink:coffee')
-- AddEventHandler('drink:coffee', function()
--     if canBeUsed then
--         UsingAnyItem = true
--         TriggerEvent("inventory:removeItem",'coffee', 1)
-- 		TriggerEvent('dg-emotes:playthisemote', 'coffee')
--         local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Coffee')

--         TriggerEvent('dg_status:remove', 'thirst', 50000)
-- 		TriggerEvent('dg_status:remove', 'stress', 100000)
--         exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
--         exports['mythic_notify']:SendAlert('inform', 'You are high on caffeine')
--         UsingAnyItem = false
        
-- 	else
-- 		exports['mythic_notify']:SendAlert('error', 'Slow Down')
-- 	end
-- end)

-- Cola

RegisterNetEvent('drink:cola')
AddEventHandler('drink:cola', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'cola', 1)
		TriggerEvent('dg-emotes:playthisemote', 'soda')
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Cola')

        TriggerEvent('dg_status:add', 'thirst', 500000)
        exports['mythic_notify']:SendAlert('inform', 'You don\'t feel thirsty anymore')
        UsingAnyItem = false

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- Ice Tea

RegisterNetEvent('drink:icetea')
AddEventHandler('drink:icetea', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'icetea', 1)
		TriggerEvent('dg-emotes:playthisemote', 'cup')
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Ice Tea')

        TriggerEvent('dg_status:add', 'thirst', 40000)
        TriggerEvent('dg_status:remove', 'stress', 40000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        UsingAnyItem = false

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- Beer

RegisterNetEvent('drink:beer')
AddEventHandler('drink:beer', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'beer', 1)
		TriggerEvent('dg-emotes:playthisemote', 'beer')
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Beer')

        TriggerEvent('dg_status:remove', 'hunger', 50000)
        TriggerEvent('dg_status:add', 'thirst', 100000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger increased slightly')
        UsingAnyItem = false

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- Vodka

RegisterNetEvent('drink:vodka')
AddEventHandler('drink:vodka', function()
    if canBeUsed and not onAlcohol then
        onAlcohol = true
        TriggerEvent("inventory:removeItem",'vodka', 1)
        TriggerEvent('dg-emotes:playthisemote', 'whiskey')
        SetPedMotionBlur(PlayerPedId(), true)
        SetPedMovementClipset(PlayerPedId(), "move_m@drunk@moderatedrunk", true)
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Vodka')

        TriggerEvent('dg_status:remove', 'hunger', 50000)
        TriggerEvent('dg_status:add', 'thirst', 150000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger increased slightly')
        Citizen.Wait(10000)
        onAlcohol = false
        Citizen.Wait(100)
        SetPedIsDrunk(PlayerPedId(),false)
        SetPedMotionBlur(PlayerPedId(), false)

        
        if not drugEffect then
            exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
            drugEffect = true
            SetTimecycleModifier("spectator5")
            Citizen.Wait(25*1000)
            ClearTimecycleModifier()
            ResetPedMovementClipset(playerPed,0.0)
            drugEffect = false
        end

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- Whiskey

RegisterNetEvent('drink:whisky')
AddEventHandler('drink:whisky', function()
    if canBeUsed and not onAlcohol then
        onAlcohol = true
        TriggerEvent("inventory:removeItem",'whisky', 1)
        TriggerEvent('dg-emotes:playthisemote', 'whiskey')
        SetPedMovementClipset(PlayerPedId(), "move_m@drunk@moderatedrunk", true)
        SetPedMotionBlur(PlayerPedId(), true)
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Whiskey')

        TriggerEvent('dg_status:remove', 'hunger', 50000)
        TriggerEvent('dg_status:add', 'thirst', 150000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger increased slightly')
        Citizen.Wait(10000)
        onAlcohol = false
        Citizen.Wait(100)
        SetPedIsDrunk(PlayerPedId(),false)
        SetPedMotionBlur(PlayerPedId(), false)

        
        if not drugEffect then
            exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
            drugEffect = true
            SetTimecycleModifier("spectator5")
            Citizen.Wait(25*1000)
            ClearTimecycleModifier()
            ResetPedMovementClipset(playerPed,0.0)
            drugEffect = false
        end

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

-- Wine

RegisterNetEvent('drink:wine')
AddEventHandler('drink:wine', function()
    if canBeUsed and not onAlcohol then
        onAlcohol = true
        TriggerEvent("inventory:removeItem",'wine', 1)
        TriggerEvent('dg-emotes:playthisemote', 'wine')
        SetPedMovementClipset(PlayerPedId(), "move_m@drunk@moderatedrunk", true)
        SetPedMotionBlur(PlayerPedId(), true)
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Wine')

        TriggerEvent('dg_status:remove', 'hunger', 50000)
        TriggerEvent('dg_status:add', 'thirst', 150000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger increased slightly')
        Citizen.Wait(10000)
        onAlcohol = false
        Citizen.Wait(100)
        SetPedIsDrunk(PlayerPedId(),false)
        SetPedMotionBlur(PlayerPedId(), false)
        
        
        if not drugEffect then
            exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
            drugEffect = true
            SetTimecycleModifier("spectator5")
            Citizen.Wait(25*1000)
            ClearTimecycleModifier()
            ResetPedMovementClipset(playerPed,0.0)
            drugEffect = false
        end

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)


-- Tequila

RegisterNetEvent('drink:tequila')
AddEventHandler('drink:tequila', function()
    if canBeUsed and not onAlcohol then
        onAlcohol = true
        TriggerEvent("inventory:removeItem",'tequila', 1)
        TriggerEvent('dg-emotes:playthisemote', 'whiskey')
        SetPedMotionBlur(PlayerPedId(), true)
        SetPedMovementClipset(PlayerPedId(), "move_m@drunk@moderatedrunk", true)
        local drinking = exports["dg-taskbar"]:taskBar(10000,'Drinking Tequila')

        TriggerEvent('dg_status:remove', 'hunger', 50000)
        TriggerEvent('dg_status:add', 'thirst', 150000)
		TriggerEvent('dg_status:remove', 'stress', 50000)
        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved')
        exports['mythic_notify']:SendAlert('inform', 'Thrist decreased slightly')
        exports['mythic_notify']:SendAlert('inform', 'Hunger increased slightly')
        Citizen.Wait(10000)
        onAlcohol = false
        Citizen.Wait(100)
        SetPedIsDrunk(PlayerPedId(),false)
        SetPedMotionBlur(PlayerPedId(), false)

        if not drugEffect then
            exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
            drugEffect = true
            SetTimecycleModifier("spectator5")
            Citizen.Wait(25*1000)
            ClearTimecycleModifier()
            ResetPedMovementClipset(playerPed,0.0)
            drugEffect = false
        end

	else
		exports['mythic_notify']:SendAlert('error', 'Slow Down')
	end
end)

---------------------------------
---------Smoke Items-------------
---------------------------------
local onCocaine = false
-- Cocaine

RegisterNetEvent('smoke:cocaine')
AddEventHandler('smoke:cocaine', function()
    if canBeUsed then
        if not onCocaine then
            onCocaine = true
            UsingAnyItem = true
            if exports['dg-inventory']:hasEnoughOfItem('cocaine', 1) then
                TriggerEvent("inventory:removeItem",'cocaine', 1)
                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    playAnim("anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 10000)
                    --TriggerEvent('dg-emotes:playthisemote','fallover3')
                    if not exports["dg-taskbar"]:taskBar(10000,'Snorting cocaine') then
                        --TriggerEvent('dg-emotes:playthisemote','c')
                        exports['mythic_notify']:SendAlert('error', 'Already doing an action!',5000)
                    else
                        TriggerEvent('dg-emotes:playthisemote','c')
                        exports['mythic_notify']:SendAlert('inform', 'You are getting stressed!',5000)
                        UsingAnyItem = false
                        if not drugEffect then
                            exports['mythic_notify']:SendAlert('inform', 'Your eyes are red!',5000)
                            exports['mythic_notify']:SendAlert('error', 'Nasheeeee!',10000)
                            drugEffect = true
                            -- TriggerEvent("ogrp_states:stateSet",3,300)
                            -- TriggerEvent("ogrp_states:stateSet",4,300)
                            SetTimecycleModifier("spectator5")
                            TriggerEvent('dg_status:add', 'stress', 100000)
                            for i = 1, 10 , 1 do
                                RestorePlayerStamina(PlayerId(), 1.0)
                                local armour = GetPedArmour(PlayerPedId())
                                if armour < 100 then
                                    AddArmourToPed(PlayerPedId(), 5)
                                    Citizen.Wait(2000)
                                else
                                    break
                                end
                            end
                            TriggerEvent('dg-emotes:playthisemote','c')
                            Citizen.Wait(20000)
                            ClearTimecycleModifier()
                            exports['mythic_notify']:SendAlert('inform', 'You slowly getting grip!',5000)
                            drugEffect = false
                            Citizen.Wait(10000)
                            exports['mythic_notify']:SendAlert('inform', 'Your eyes are normal now!',5000)
                            onCocaine = false
                        end
                    end
                end)
            else
                UsingAnyItem = false
                exports['mythic_notify']:SendAlert('error', 'Stop using butter fingers!')
            end
        else
            exports['mythic_notify']:SendAlert('error', 'Your eyes are still Red!',5000)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

---crack---

RegisterNetEvent('smoke:crack')
AddEventHandler('smoke:crack', function()
    if canBeUsed then
        if exports['dg-inventory']:hasEnoughOfItem('crackpipe', 1) then
            if math.random(1,50) == 1 then
                TriggerEvent("inventory:removeItem",'crackpipe', 1)
                exports['mythic_notify']:SendAlert('error', 'crackpipe ran out')
            end
                if not onEnergyDrink then
                onEnergyDrink = true
                UsingAnyItem = true
                    TriggerEvent("inventory:removeItem",'1gcrack', 1)
                    increaseStamina = true
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local prop = CreateObject(GetHashKey('prop_cs_crackpipe'), coords.x, coords.y, coords.z, true, true, true)
                    --local boneIndex = GetPedBoneIndex(playerPed, 58866)
                    local boneIndex = GetPedBoneIndex(playerPed, 58866)
                    --local boneIndex = GetEntityBoneIndexByName(playerPed, 'SKEL_R_Finger02')
                    AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
                    --TriggerEvent("dg-emotes:playthisemote",'drink')
                    playAnim("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 5000)
                    local cracking = exports["dg-taskbar"]:taskBar(5000,'Smoking crack')
                    UsingAnyItem = false
                    DeleteObject(prop)
                    SetTimecycleModifier("spectator5")
                    --TriggerEvent("dg-emotes:playthisemote",'c')
                    --TriggerEvent('dg_status:add', 'thirst',50000)
                    exports['mythic_notify']:SendAlert('inform', 'Stamina increased slightly')
                    --exports['mythic_notify']:SendAlert('inform', 'Thrist increased slightly')
                    increaseStamina = false
                    Citizen.Wait(100)
                    RestorePlayerStamina(PlayerId(), 0.3)
                    SetPedMovementClipset(playerPed, "MOVE_M@QUICK", true)
                    SetPedMoveRateOverride(PlayerId(),10.0)
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.49)
                    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
                    Citizen.Wait(30000)
                -- after wait stop all 
                    SetPedMoveRateOverride(PlayerId(),1.0)
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                    SetPedIsDrunk(GetPlayerPed(-1), false)		
                    SetPedMotionBlur(playerPed, false)
                    ResetPedMovementClipset(GetPlayerPed(-1))
                    AnimpostfxStopAll()
                    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    SetTimecycleModifierStrength(0.0)
                    ClearTimecycleModifier()
                    --UsingAnyItem = true
                    exports['mythic_notify']:SendAlert('inform', 'You slowly getting grip!',5000)
                    Citizen.Wait(20000)
                    exports['mythic_notify']:SendAlert('inform', 'Your eyes are normal now!',5000)
                    onEnergyDrink = false
                else
                    exports['mythic_notify']:SendAlert('error', 'Your eyes are still Red!',5000)
                end 
        else
            exports['mythic_notify']:SendAlert('error', 'You need a Crack Pipe')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Meth

RegisterNetEvent('smoke:meth')
AddEventHandler('smoke:meth', function()
    if canBeUsed then
        if not onCocaine then
            onCocaine = true
            UsingAnyItem = true
            if exports['dg-inventory']:hasEnoughOfItem('meth', 1) then
                TriggerEvent("inventory:removeItem",'meth', 1)
                Citizen.CreateThread(function()
                    local playerPed = PlayerPedId()
                    TriggerEvent('dg-emotes:playthisemote','stumble')
                    if not exports["dg-taskbar"]:taskBar(10000,'Smoking meth') then
                        TriggerEvent('dg-emotes:playthisemote','c')
                        exports['mythic_notify']:SendAlert('error', 'Already doing an action!',5000)
                    else
                        TriggerEvent('dg-emotes:playthisemote','c')
                        exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved!',5000)
                        UsingAnyItem = false
                        if not drugEffect then
                            exports['mythic_notify']:SendAlert('inform', 'You are getting buzzed!',5000)
                            drugEffect = true
                            -- TriggerEvent("ogrp_states:stateSet",3,300)
                            -- TriggerEvent("ogrp_states:stateSet",4,300)
                            SetTimecycleModifier("spectator5")
                            TriggerEvent('dg_status:remove', 'stress', 250000)
                            for i = 1, 10 , 1 do
                                RestorePlayerStamina(PlayerId(), 1.0)
                                local armour = GetPedArmour(PlayerPedId())
                                if armour < 100 then
                                    AddArmourToPed(PlayerPedId(), 2)
                                    Citizen.Wait(2000)
                                else
                                    break
                                end
                            end
                            TriggerEvent('dg-emotes:playthisemote','c')
                            Citizen.Wait(20000)
                            ClearTimecycleModifier()
                            exports['mythic_notify']:SendAlert('inform', 'You slowly getting grip!',5000)
                            drugEffect = false
                            Citizen.Wait(10000)
                            exports['mythic_notify']:SendAlert('inform', 'Your eyes are normal now!',5000)
                            onCocaine = false
                        end
                    end
                end)
            else
                UsingAnyItem = false
                exports['mythic_notify']:SendAlert('error', 'Stop using butter fingers!')
            end
        else
            exports['mythic_notify']:SendAlert('error', 'You still feel buzzed out!',5000)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You are already buzzed !')
    end
end)

-- Blunt

RegisterNetEvent('smoke:blunt')
AddEventHandler('smoke:blunt', function()
    if canBeUsed then
        if exports['dg-inventory']:hasEnoughOfItem('lighter', 1) then
            UsingAnyItem = true
            if math.random(1,50) == 1 then
                TriggerEvent("inventory:removeItem",'lighter', 1)
                exports['mythic_notify']:SendAlert('error', 'Lighter ran out of Butane')
            end
            
            if IsPedInAnyVehicle(PlayerPedId(),false) then
                UsingAnyItem = false
                exports['mythic_notify']:SendAlert('inform', 'You can\'t do that in car!')
            else
                if exports['dg-inventory']:hasEnoughOfItem('blunt', 1) then
                    TriggerEvent("inventory:removeItem",'blunt', 1)
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
                        if not exports["dg-taskbar"]:taskBar(15000,'Smoking a Blunt') then
                            UsingAnyItem = false
                            exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
                        else
                            if not drugEffect then
                                UsingAnyItem = false
                                exports['mythic_notify']:SendAlert('success', 'Stress is getting relieved slowly!')
                            
                                exports['mythic_notify']:SendAlert('inform', 'You feel high')
                                drugEffect = true
                                -- TriggerEvent("ogrp_states:stateSet",3,300)
                                -- TriggerEvent("ogrp_states:stateSet",4,300)
                                SetTimecycleModifier("spectator5")
                                UsingAnyItem = false
                                for i = 1, 5 , 1 do 
                                    local armour = GetPedArmour(PlayerPedId())
                                    if armour < 100 then
                                        AddArmourToPed(PlayerPedId(), 5)
                                        Citizen.Wait(1000)
                                    else
                                        break
                                    end
                                end
                                TriggerEvent('dg_status:remove', 'stress', 250000)
                                Citizen.Wait(15000)
                                ClearTimecycleModifier()
                                exports['mythic_notify']:SendAlert('inform', 'You feel normal')
                                
                                drugEffect = false
                            else
                                UsingAnyItem = false
                                exports['mythic_notify']:SendAlert('error', 'Slow Down')
                            end
                        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'Stop using your butter fingers!')
                end
            end
        else
            exports['mythic_notify']:SendAlert('error', 'You need a lighter')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)


-- Joint

RegisterNetEvent('smoke:joint')
AddEventHandler('smoke:joint', function(item)
    if canBeUsed then
        if exports['dg-inventory']:hasEnoughOfItem('lighter', 1) then
            UsingAnyItem = true
            if exports['dg-inventory']:hasEnoughOfItem(item, 1) then
                TriggerEvent("inventory:removeItem",item, 1)
            
                if math.random(1,20) == 1 then
                    TriggerEvent("inventory:removeItem",'lighter', 1)
                    exports['mythic_notify']:SendAlert('error', 'Lighter ran out of Butane')
                end
                
                if IsPedInAnyVehicle(PlayerPedId(),false) then
                    local playerPed = PlayerPedId()
                    local smoke = exports["dg-taskbar"]:taskBar(15000,'Smoking a Joint')
                    UsingAnyItem = false
                    exports['mythic_notify']:SendAlert('success', 'Stressed Relieved')
                    if not drugEffect then
                        exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
                        drugEffect = true
                        TriggerEvent("ogrp_states:stateSet",3,300)
                        TriggerEvent("ogrp_states:stateSet",4,300)
                        SetTimecycleModifier("spectator5")
                        if item == 'joint' then
                            TriggerEvent('dg_status:remove', 'stress', 100000)
                            AddArmourToPed(playerPed,10)
                        elseif item == 'bjoint' or item == 'yjoint' then
                            TriggerEvent('dg_status:remove', 'stress', 125000)
                            AddArmourToPed(playerPed,13)
                        elseif item == 'pjoint' or item == 'rjoint' then
                            TriggerEvent('dg_status:remove', 'stress', 170000)
                            AddArmourToPed(playerPed,17)
                        end
                        Citizen.Wait(10000)
                        ClearTimecycleModifier()
                        exports['mythic_notify']:SendAlert('inform', 'You feel normal')
                        drugEffect = false
                    end
                else
                    Citizen.CreateThread(function()
                        local playerPed = PlayerPedId()
                        --TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
                        TriggerEvent('dg-emotes:playthisemote','smokeweed')
                        local smoke = exports["dg-taskbar"]:taskBar(15000,'Smoking a Joint')
                        UsingAnyItem = false
                        exports['mythic_notify']:SendAlert('success', 'Stressed Relieved')
                        if not drugEffect then
                            exports['mythic_notify']:SendAlert('inform', 'You feel a bit high')
                            drugEffect = true
                            TriggerEvent("ogrp_states:stateSet",3,300)
                            TriggerEvent("ogrp_states:stateSet",4,300)
                            SetTimecycleModifier("spectator5")
                            if item == 'joint' then
                                TriggerEvent('dg_status:remove', 'stress', 100000)
                                AddArmourToPed(playerPed,10)
                            elseif item == 'bjoint' or item == 'yjoint' then
                                TriggerEvent('dg_status:remove', 'stress', 125000)
                                AddArmourToPed(playerPed,13)
                            elseif item == 'pjoint' or item == 'rjoint' then
                                TriggerEvent('dg_status:remove', 'stress', 170000)
                                AddArmourToPed(playerPed,17)
                            end
                            Citizen.Wait(10000)
                            ClearTimecycleModifier()
                            exports['mythic_notify']:SendAlert('inform', 'You feel normal')
                            drugEffect = false
                        end
                    end)
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Stop using your butter fingers!')
            end
        else
            exports['mythic_notify']:SendAlert('error', 'You need a lighter')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Cigarette

RegisterNetEvent('smoke:ciggy')
AddEventHandler('smoke:ciggy', function()
    if canBeUsed then
        if exports['dg-inventory']:hasEnoughOfItem('lighter', 1) then
            UsingAnyItem = true
            TriggerEvent("inventory:removeItem",'ciggy', 1)
            if math.random(1,50) == 1 then
                TriggerEvent("inventory:removeItem",'lighter', 1)
                exports['mythic_notify']:SendAlert('error', 'Lighter ran out of Butane')
            end
            TriggerEvent('dg-emotes:playthisemote','smoke')
            local smoke = exports["dg-taskbar"]:taskBar(15000,'Smoking a Cigarette')

		    TriggerEvent('dg_status:remove', 'stress', 50000)
		    exports['mythic_notify']:SendAlert('inform', 'Stressed Relieved Slightly')
		    UsingAnyItem = false
	    else
		    exports['mythic_notify']:SendAlert('error', 'You need a lighter')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

---------------------------------
---------Tool items-------------
---------------------------------

-- Armour Stuff

RegisterNetEvent('tool:armour')
AddEventHandler('tool:armour', function()
    if canBeUsed then
        UsingAnyItem = true
        --RemoveAllPedWeapons(PlayerPedId(),true)
        TriggerEvent("inventory:removeItem",'bulletproof', 1)
        TriggerEvent('InteractSound_CL:PlayOnOne', 'clothe', 0.4)
        TriggerEvent('dg-emotes:playthisemote', 'adjust')
        local tool = exports["dg-taskbar"]:taskBar(5000,'Wearing an armour')
        AddArmourToPed(PlayerPedId(), 100)
	    SetPedArmour(PlayerPedId(), 100)
        exports['mythic_notify']:SendAlert('success', 'Protection Increased')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)


-- Armour Stuff

RegisterNetEvent('tool:armour2')
AddEventHandler('tool:armour2', function()
    if canBeUsed then
        UsingAnyItem = true
        --RemoveAllPedWeapons(PlayerPedId(),true)
        TriggerEvent("inventory:removeItem",'pdarmour', 1)
        TriggerEvent('InteractSound_CL:PlayOnOne', 'clothe', 0.4)
        TriggerEvent('dg-emotes:playthisemote', 'adjust')
        local tool = exports["dg-taskbar"]:taskBar(5000,'Wearing an armour')
        AddArmourToPed(PlayerPedId(), 100)
	    SetPedArmour(PlayerPedId(), 100)
        exports['mythic_notify']:SendAlert('success', 'Protection Increased')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)


--Oxygen Tank

RegisterNetEvent('tool:otank')
AddEventHandler('tool:otank', function()
    if canBeUsed and not onO2tank then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'oxygentank', 1)
        TriggerEvent('InteractSound_CL:PlayOnOne', 'clothe', 0.4)
        TriggerEvent('dg-emotes:playthisemote', 'adjust')
        local tool = exports["dg-taskbar"]:taskBar(5000,'Putting on oxygen tank')
        
        local playerPed  = GetPlayerPed(-1)
		local coords     = GetEntityCoords(playerPed)
		local boneIndex  = GetPedBoneIndex(playerPed, 12844)
		local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
		object = CreateObject(136880302, coords.x, coords.y, coords.z - 3,true,true,false)
		object2 = CreateObject(1593773001, coords.x, coords.y, coords.z - 3,true,true,false)
		AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
        AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
        onO2tank = true
        exports['mythic_notify']:SendAlert('inform', 'You Put Oxygen Tank On. Capacity: 15 Minutes')
        UsingAnyItem = false
        Citizen.Wait(15*60*1000)
        onO2tank = false
        Citizen.Wait(50)
        SetPedDiesInWater(PlayerPedId(), true)
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

--- kits ---

RegisterNetEvent('tool:enginekit')
AddEventHandler('tool:enginekit', function()
    if canBeUsed then
        UsingAnyItem = true
        
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then
                TriggerEvent("inventory:removeItem",'enginekit', 1)
                TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                FreezeEntityPosition(PlayerPedId(), true)
                local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                if repair1 == 100 then
                    local repair2 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair2 == 100 then
                        local repair3 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                        if repair3 == 100 then
                            
					        SetVehicleEngineHealth(vehicle, 1000.0)
                    
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)

                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end

        UsingAnyItem = false
    end
end)


RegisterNetEvent('tool:bodykit')
AddEventHandler('tool:bodykit', function()
    if canBeUsed then
        UsingAnyItem = true
        
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then
                TriggerEvent("inventory:removeItem",'bodykit', 1)
                TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                FreezeEntityPosition(PlayerPedId(), true)
                local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                if repair1 == 100 then
                    local repair2 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair2 == 100 then
                        local repair3 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                        if repair3 == 100 then
                            
                            local enginehealth1 = GetVehicleEngineHealth(vehicle)
					        SetVehicleFixed(vehicle)
					        SetVehicleEngineHealth(vehicle, enginehealth1)
                    
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)

                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end

        UsingAnyItem = false
    end
end)

RegisterNetEvent('tool:windowkit')
AddEventHandler('tool:windowkit', function()
    if canBeUsed then
        UsingAnyItem = true
        
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then
                TriggerEvent("inventory:removeItem",'windowkit', 1)
                TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                FreezeEntityPosition(PlayerPedId(), true)
                local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                if repair1 == 100 then
                    local repair2 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair2 == 100 then
                        local repair3 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                        if repair3 == 100 then
                            
                            local i = 0
					        while i<14 do
						        FixVehicleWindow(vehicle,i)
						        i = i+1
					        end
                    
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)

                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end

        UsingAnyItem = false
    end
end)

RegisterNetEvent('tool:tirekit')
AddEventHandler('tool:tirekit', function()
    if canBeUsed then
        UsingAnyItem = true
        
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then
                TriggerEvent("inventory:removeItem",'tirekit', 1)
                TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                FreezeEntityPosition(PlayerPedId(), true)
                local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                if repair1 == 100 then
                    local repair2 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair2 == 100 then
                        local repair3 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                        if repair3 == 100 then
                            
                            for i = 0 , 5, 1 do
                                SetVehicleTyreFixed(vehicle, i)
                            end
                    
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)

                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end

        UsingAnyItem = false
    end
end)

RegisterNetEvent('tool:repairkit')
AddEventHandler('tool:repairkit', function()
    if canBeUsed then
        UsingAnyItem = true
        
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then
                local engine = GetVehicleEngineHealth(vehicle)
                TriggerEvent("inventory:removeItem",'repairkit', 1)
                TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                FreezeEntityPosition(PlayerPedId(), true)
                local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                if repair1 == 100 then
                    local repair2 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair2 == 100 then
                        local repair3 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                        if repair3 == 100 then
                            
                            for i = 0 , 5, 1 do
                                SetVehicleTyreFixed(vehicle, i)
                            end
                            
                            if engine < 500.0 then
                                SetVehicleEngineHealth(vehicle,500.0)
                            end
                    
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)

                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end
        end

        UsingAnyItem = false
    end
end)

RegisterNetEvent('tool:advrepairkit')
AddEventHandler('tool:advrepairkit', function()
    if canBeUsed then
        UsingAnyItem = true
        if not IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0, 0, 71)
            if DoesEntityExist(vehicle) then

                local boneIndex = GetEntityBoneIndexByName(vehicle, 'engine')
                local vehicleCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)

                if distance <= 1.5 then
                    local engine = GetVehicleEngineHealth(vehicle)
                    TriggerEvent('dg-emotes:playthisemote', 'mechanic')
                    FreezeEntityPosition(PlayerPedId(), true)
                    local repair1 = exports["dg-taskbarskill"]:taskBar(4000,math.random(10,14))
                    if repair1 == 100 then
                        local repair2 = exports["dg-taskbarskill"]:taskBar(3000,math.random(10,14))
                        if repair2 == 100 then
                            local repair3 = exports["dg-taskbarskill"]:taskBar(2000,math.random(10,14))
                            if repair3 == 100 then
                                for i = 0 , 5, 1 do
                                    SetVehicleTyreFixed(vehicle, i)
                                end
                                SetVehicleEngineHealth(vehicle,1000.0)
                                ClearPedTasks(PlayerPedId())
                                FreezeEntityPosition(PlayerPedId(), false)
                                TriggerEvent("inventory:removeItem",'advrepairkit', 1)
                            else
                                FreezeEntityPosition(PlayerPedId(), false)
                                ClearPedTasks(PlayerPedId())
                            end
                        else
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                        end
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                        ClearPedTasks(PlayerPedId())
                    end
                end
            end
        end
        UsingAnyItem = false
    end
end)

-- Parachute

RegisterNetEvent('tool:parachute')
AddEventHandler('tool:parachute', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'parachute', 1)
        TriggerEvent('InteractSound_CL:PlayOnOne', 'clothe', 0.4)
        TriggerEvent('dg-emotes:playthisemote', 'adjust')
        local tool = exports["dg-taskbar"]:taskBar(5000,'Putting on Parachute')
	    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), true)
        exports['mythic_notify']:SendAlert('success', 'You\'ve used a parachute')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- BoomBox

RegisterNetEvent('tool:boombox')
AddEventHandler('tool:boombox', function()
    if canBeUsed then
        UsingAnyItem = true
        TriggerEvent('esx_hifi:place_hifi')
        local tool = exports["dg-taskbar"]:taskBar(2000,'Placing Boombox on the ground')
        exports['mythic_notify']:SendAlert('success', 'Some songs can\'t be played due to copyright')
        UsingAnyItem = false
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Cuffs

RegisterNetEvent('tool:cuffs')
AddEventHandler('tool:cuffs', function(type)
    if canBeUsed then
        local player, distance = DGCore.Game.GetClosestPlayer()
	    local playerheading = GetEntityHeading(GetPlayerPed(-1))
	    local playerlocation = GetEntityForwardVector(PlayerPedId())
	    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	    local target_id = GetPlayerServerId(player)
        if distance~=-1 and distance<=2.0 then
            UsingAnyItem = true
            DGCore.TriggerServerCallback("dg-policejob:isCuffed",function(cuffed)
                if not cuffed then
                    TriggerEvent('dg-policejob:checkCuff', false, true)
                    TriggerEvent("inventory:removeItem",type, 1)
                    local tool = exports["dg-taskbar"]:taskBar(2000,'Cuffing')
                else
                    exports['mythic_notify']:SendAlert('error', 'The player is cuffed already')
                end
            end,GetPlayerServerId(player))
            UsingAnyItem = false
        else
            exports['mythic_notify']:SendAlert('error', 'No one is nearby')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- H Cuffs

RegisterNetEvent('tool:hcuffs')
AddEventHandler('tool:hcuffs', function()
    if canBeUsed then
        local player, distance = DGCore.Game.GetClosestPlayer()
	    local playerheading = GetEntityHeading(GetPlayerPed(-1))
	    local playerlocation = GetEntityForwardVector(PlayerPedId())
	    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	    local target_id = GetPlayerServerId(player)
        if distance~=-1 and distance<=2.0 then
            UsingAnyItem = true
            DGCore.TriggerServerCallback("dg-policejob:isCuffed",function(cuffed)
                if not cuffed then
                    TriggerEvent('dg-policejob:checkCuff', true, true)
                    TriggerEvent("inventory:removeItem",'cuffs', 1)
                    local tool = exports["dg-taskbar"]:taskBar(2000,'Cuffing')
                else
                    exports['mythic_notify']:SendAlert('error', 'The player is cuffed already')
                end
            end,GetPlayerServerId(player))
            UsingAnyItem = false
        else
            exports['mythic_notify']:SendAlert('error', 'No one is nearby')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Boltcutter

RegisterNetEvent('tool:cutter')
AddEventHandler('tool:cutter', function()
    if canBeUsed then
        local player, distance = DGCore.Game.GetClosestPlayer()
	    local playerheading = GetEntityHeading(GetPlayerPed(-1))
	    local playerlocation = GetEntityForwardVector(PlayerPedId())
	    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	    local target_id = GetPlayerServerId(player)
        if distance~=-1 and distance<=3.0 then
            
            UsingAnyItem = true
            if math.random(1,10) == 10 then
                TriggerEvent("inventory:removeItem",'cutter', 1)
                exports['mythic_notify']:SendAlert('error', 'You broke the cutter')
            end
       
            DGCore.TriggerServerCallback("dg-policejob:isCuffed",function(cuffed)
			    if not cuffed then
				    exports['mythic_notify']:SendAlert('error', 'The player is not cuffed')
			    else
                    TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 0, 0, 0, 0, 0)
                    TriggerServerEvent("dg-policejob:handcuff",target_id,false,false,playerheading,playerCoords,playerlocation)
                    
                end
            end,GetPlayerServerId(player))
            UsingAnyItem = false

        else
		    exports['mythic_notify']:SendAlert('error', 'No one is nearby')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

-- Cuff keys

RegisterNetEvent('tool:cuff_keys')
AddEventHandler('tool:cuff_keys', function()
    if canBeUsed then
        local player, distance = DGCore.Game.GetClosestPlayer()
	    local playerheading = GetEntityHeading(GetPlayerPed(-1))
	    local playerlocation = GetEntityForwardVector(PlayerPedId())
	    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	    local target_id = GetPlayerServerId(player)
        if distance~=-1 and distance<=3.0 then
            
            UsingAnyItem = true
            if math.random(1,10) == 10 then
                TriggerEvent("inventory:removeItem",'cuff_keys', 1)
                exports['mythic_notify']:SendAlert('error', 'You broke the key')
            end
       
            DGCore.TriggerServerCallback("dg-policejob:isCuffed",function(cuffed)
			    if not cuffed then
				    exports['mythic_notify']:SendAlert('error', 'The player is not cuffed')
			    else
                    TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 0, 0, 0, 0, 0)
                    TriggerServerEvent("dg-policejob:handcuff",target_id,false,false,playerheading,playerCoords,playerlocation)
                    TriggerEvent('player:receiveItem', 'cuffs', 1)
                end
            end,GetPlayerServerId(player))
            UsingAnyItem = false

        else
		    exports['mythic_notify']:SendAlert('error', 'No one is nearby')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)



--------------------------------
---------Reload Stuff-----------
--------------------------------

local usingWeapon = 0

RegisterNetEvent('updateWeapon')
AddEventHandler('updateWeapon', function(whash)
    usingWeapon = whash
end)

-- Pistol

RegisterNetEvent('ammo:pistol')
AddEventHandler('ammo:pistol', function()
    if not UsingAnyItem then
        UsingAnyItem = true
        local playerPed = GetPlayerPed(-1)
        local weapon

        if usingWeapon ~= 0 then
            print(usingWeapon)
            for k, v in pairs(config.Ammo['pistolammo']) do
                if usingWeapon == v then
                    weapon = v
                    break
                end
            end

            if weapon ~= nil then
                
                local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
                if pedAmmo < 150 then

                    TriggerEvent("inventory:removeItem",'pistolammo', 1)
                    
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "Reloading the pistol",
                        duration = 5000,
                        label = "Reloading the pistol",
                        useWhileDead = false,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }
                    }, function(status)
                        if not status then
                            TriggerEvent("actionbar:ammo",1950175060,30,true)
                            if not IsPedInAnyVehicle(playerPed, false) then
                                TaskReloadWeapon(playerPed)
                            end
                            exports['mythic_notify']:SendAlert('success', 'Reloaded')
                        end
                    end)

                else
                    exports['mythic_notify']:SendAlert('error', 'Max Ammo')
                end
            end
        end
        Citizen.Wait(5000)
        UsingAnyItem = false
    end
end)



-- SMG

RegisterNetEvent('ammo:smg')
AddEventHandler('ammo:smg', function()
    if not UsingAnyItem then
        UsingAnyItem = true
        local playerPed = GetPlayerPed(-1)
        local weapon

        local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
        if found then
            for k, v in pairs(config.Ammo['subammo']) do
                if currentWeapon == v then
                    weapon = v
                    break
                end
            end
            if weapon ~= nil then
                
                local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
                if pedAmmo < 150 then
                    TriggerEvent("inventory:removeItem",'subammo', 1)
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "Reloading the SMG",
                        duration = 5000,
                        label = "Reloading the SMG",
                        useWhileDead = false,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }
                    }, function(status)
                        if not status then
                            TriggerEvent("actionbar:ammo",1820140472,30,true)
                            if not IsPedInAnyVehicle(playerPed, false) then
                                TaskReloadWeapon(playerPed)
                            end
                            exports['mythic_notify']:SendAlert('success', 'Reloaded')
                        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'Max Ammo')
                end

            end
        end
        Citizen.Wait(5000)
        UsingAnyItem = false
    end
end)

-- Rifle

RegisterNetEvent('ammo:rifle')
AddEventHandler('ammo:rifle', function()
    if not UsingAnyItem then
        UsingAnyItem = true
        local playerPed = GetPlayerPed(-1)
        local weapon

        local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
        if found then
            for k, v in pairs(config.Ammo['rifleammo']) do
                if currentWeapon == v then
                    weapon = v
                    break
                end
            end
            if weapon ~= nil then
                local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
                if pedAmmo < 150 then
                    TriggerEvent("inventory:removeItem",'rifleammo', 1)
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "Reloading the rifle",
                        duration = 5000,
                        label = "Reloading the rifle",
                        useWhileDead = false,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        }
                    }, function(status)
                        if not status then
                            TriggerEvent("actionbar:ammo",218444191,50,true)
                            if not IsPedInAnyVehicle(playerPed, false) then
                                TaskReloadWeapon(playerPed)
                            end
                            exports['mythic_notify']:SendAlert('success', 'Reloaded')
                        end
                    end)

                else
                    exports['mythic_notify']:SendAlert('error', 'Max Ammo')
                end
            end
        end
        Citizen.Wait(5000)
        UsingAnyItem = false
    end

end)


-- Shotgun

RegisterNetEvent('ammo:shotgun')
AddEventHandler('ammo:shotgun', function()
    if not UsingAnyItem then
        UsingAnyItem = true
        local playerPed = GetPlayerPed(-1)
        local weapon

        local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
        if found then
            for k, v in pairs(config.Ammo['shotgunammo']) do
                if currentWeapon == v then
                    weapon = v
                    break
                end
            end
            if weapon ~= nil then
                TriggerEvent("inventory:removeItem",'shotgunammo', 1)
                local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
                if pedAmmo < 150 then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "Reloading the shotgun",
                        duration = 5000,
                        label = "Reloading the shotgun",
                        useWhileDead = false,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = false,
                            disableCarMovement = false,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    }, function(status)
                        if not status then
                            TriggerEvent("actionbar:ammo",-1878508229,15,true)
                            if not IsPedInAnyVehicle(playerPed, false) then
                                TaskReloadWeapon(playerPed)
                            end
                            exports['mythic_notify']:SendAlert('success', 'Reloaded')
                        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'Max Ammo')
                end
            end
        end
        Citizen.Wait(5000)
        UsingAnyItem = false
    end
end)

--------------------------------
---------Drug Items-------------
--------------------------------
-- RegisterNetEvent('drug:cannabis')
-- AddEventHandler('drug:cannabis', function()
--     if canBeUsed then
--         UsingAnyItem = true
--         TriggerEvent("dg-emotes:playthisemote",'uncuff')
--         if exports['dg-inventory']:hasEnoughOfItem('cannabis', 1) then
--             TriggerEvent('inv:remove','cannabis',1)
--             if not exports["dg-taskbar"]:taskBar(3000,'Trimming weed') then
--                 exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
--             else
--                 TriggerEvent('player:receiveItem', 'trimmedweed', 1)
--             end
--             TriggerEvent("dg-emotes:playthisemote",'c')
--         else
--             exports['mythic_notify']:SendAlert('error', 'Stop using butter fingers!')
--         end
--         UsingAnyItem = false
--     else
--         exports['mythic_notify']:SendAlert('error', 'Slow Down')
--     end
-- end)

-- RegisterNetEvent('drug:blunt')
-- AddEventHandler('drug:blunt', function(item)
--     if canBeUsed then
--         UsingAnyItem = true
--         TriggerEvent("dg-emotes:playthisemote",'uncuff')
--         if exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) then
--             if exports['dg-inventory']:hasEnoughOfItem(item, 1) then
--                 TriggerEvent('inv:remove',item,1)
--                 TriggerEvent('inv:remove','rollingpaper',1)
--                 if not exports["dg-taskbar"]:taskBar(3000,'Rolling joint') then
--                     exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
--                 else
--                     if item == 'trimmedweed' then
--                         TriggerEvent('player:receiveItem', 'blunt', 1)
--                     elseif item == 'pkhush' then
--                         TriggerEvent('player:receiveItem', 'pjoint', 1)
--                     elseif item == 'bkhush' then
--                         TriggerEvent('player:receiveItem', 'bjoint', 1)
--                     elseif item == 'ykhush' then
--                         TriggerEvent('player:receiveItem', 'yjoint', 1)
--                     elseif item == 'rkhush' then
--                         TriggerEvent('player:receiveItem', 'rjoint', 1)
--                     elseif item == 'khush' then
--                         TriggerEvent('player:receiveItem', 'joint', 1)   
--                     end
--                 end
--             else
--                 exports['mythic_notify']:SendAlert('error', 'Stop using your butter fingers!')
--             end
--         else
--             ClearPedTasksImmediately(PlayerPedId())
--             exports['mythic_notify']:SendAlert('inform', 'You need a rolling paper!')
--             UsingAnyItem = false
--         end
--         TriggerEvent("dg-emotes:playthisemote",'c')
--         UsingAnyItem = false
--     else
--         exports['mythic_notify']:SendAlert('error', 'Slow Down')
--     end
-- end)

RegisterNetEvent('drug:cannabis')
AddEventHandler('drug:cannabis', function()
    local player = GetPlayerPed(-1)
    -- if canBeUsed then
    --     UsingAnyItem = true
    --     TriggerEvent("dg-emotes:playthisemote",'uncuff')
    --     if not exports["dg-taskbar"]:taskBar(3000,'Trimming weed') then
    --         exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
    --     else
    --         TriggerEvent('inv:remove','cannabis',1)
    --         TriggerEvent('player:receiveItem', 'trimmedweed', 1)
    --     end
    --     TriggerEvent("dg-emotes:playthisemote",'c')
    --     UsingAnyItem = false
    -- else
    --     exports['mythic_notify']:SendAlert('error', 'Slow Down')
    -- end
    if canBeUsed then
        UsingAnyItem = true
            FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "chicken_taco",
                duration = 3000,
                label = 'Trimming weed',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    --TriggerEvent("ogrp-chickentaco")
                    --TriggerServerEvent('coke:processed')
                    TriggerEvent('inv:remove','cannabis',1)
                     TriggerEvent('player:receiveItem', 'trimmedweed', 1)
                     UsingAnyItem = false
                else
                    exports['mythic_notify']:SendAlert('error', 'Not Enough items') 
                end
                FreezeEntityPosition(player, false)
            end)
    end
end)

RegisterNetEvent('drug:blunt')
AddEventHandler('drug:blunt', function(item)
    local player = GetPlayerPed(-1)
    -- if canBeUsed then
    --     UsingAnyItem = true
    --     TriggerEvent("dg-emotes:playthisemote",'uncuff')
    --     if exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) or exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) or exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
    --         if not exports["dg-taskbar"]:taskBar(3000,'Rolling joint') then
    --             exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
    --         else
    --             if exports['dg-inventory']:hasEnoughOfItem(item, 1) and exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) then
    --                 TriggerEvent('inv:remove',item,1)
    --                 TriggerEvent('inv:remove','rollingpaper',1)
    --                 if item == 'trimmedweed' then
    --                     TriggerEvent('player:receiveItem', 'blunt', 1)
    --                 elseif item == 'pkhush' then
    --                     TriggerEvent('player:receiveItem', 'pjoint', 1)
    --                 elseif item == 'bkhush' then
    --                     TriggerEvent('player:receiveItem', 'bjoint', 1)
    --                 elseif item == 'ykhush' then
    --                     TriggerEvent('player:receiveItem', 'yjoint', 1)
    --                 elseif item == 'rkhush' then
    --                     TriggerEvent('player:receiveItem', 'rjoint', 1)
    --                 elseif item == 'khush' then
    --                     TriggerEvent('player:receiveItem', 'joint', 1)
    --                 end
    --             end
    --         end
    --     else
    --         ClearPedTasksImmediately(PlayerPedId())
    --         exports['mythic_notify']:SendAlert('inform', 'You need a rolling paper!')
    --         UsingAnyItem = false
    --     end
    --     TriggerEvent("dg-emotes:playthisemote",'c')
    --     UsingAnyItem = false
    -- else
    --     exports['mythic_notify']:SendAlert('error', 'Slow Down')
    -- end
    if canBeUsed then
        UsingAnyItem = true
        if  exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) or exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) or exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
            FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "chicken_taco",
                duration = 3000,
                label = 'Rolling joint',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = false,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    --TriggerEvent("ogrp-chickentaco")
                    if  exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) or exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) or exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
                        if exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","rollingpaper", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","bspapers", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","vpapers", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","gsfpapers", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","lostpapers", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","lspapers", 1)
                            TriggerEvent('player:receiveItem', "blunt", 1)
                            UsingAnyItem = false
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Not Enough items')
                    --TriggerServerEvent('coke:processed')
                    end
                    FreezeEntityPosition(player, false)
                end
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'You need a Rolling Paper')
            UsingAnyItem = false
        end
    end
end)

--weedoz

RegisterNetEvent('drug:weedoz')
AddEventHandler('drug:weedoz', function(item)
    local player = GetPlayerPed(-1)
    if canBeUsed then
        UsingAnyItem = true
        if  exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) or exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) or exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
            FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "chicken_taco",
                duration = 3000,
                label = 'Rolling joint',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = false,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    --TriggerEvent("ogrp-chickentaco")
                    if  exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) or exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) or exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) or exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
                        if exports['dg-inventory']:hasEnoughOfItem('rollingpaper', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","rollingpaper", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('bspapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","bspapers", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('vpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","vpapers", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('gsfpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","gsfpapers", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('lostpapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","lostpapers", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        elseif exports['dg-inventory']:hasEnoughOfItem('lspapers', 1) then
                            TriggerEvent("inventory:removeItem",item, 1)
                            TriggerEvent("inventory:removeItem","lspapers", 1)
                            TriggerEvent('player:receiveItem', "joint", 3)
                            UsingAnyItem = false
                        end
                    else
                        exports['mythic_notify']:SendAlert('error', 'Not Enough items')
                    end
                    FreezeEntityPosition(player, false)
                end
            end)
        else
            UsingAnyItem = false
            exports['mythic_notify']:SendAlert('error', 'You need a Rolling Paper')
        end
    end
end)

-- 1gcrack --

RegisterNetEvent('drug:cpowder')
AddEventHandler('drug:cpowder', function()
    local player = GetPlayerPed(-1)
    -- if canBeUsed then
    --     UsingAnyItem = true
    --     TriggerEvent("dg-emotes:playthisemote",'uncuff')
    --     if not exports["dg-taskbar"]:taskBar(3000,'Trimming weed') then
    --         exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
    --     else
    --         TriggerEvent('inv:remove','cannabis',1)
    --         TriggerEvent('player:receiveItem', 'trimmedweed', 1)
    --     end
    --     TriggerEvent("dg-emotes:playthisemote",'c')
    --     UsingAnyItem = false
    -- else
    --     exports['mythic_notify']:SendAlert('error', 'Slow Down')
    -- end
    if canBeUsed then
        UsingAnyItem = true
        if exports['dg-inventory']:hasEnoughOfItem('emptybaggies', 1) and exports['dg-inventory']:hasEnoughOfItem('bsalts', 1) then
            FreezeEntityPosition(player, true)
            exports['mythic_progbar']:Progress({
                name = "chicken_taco",
                duration = 3000,
                label = 'making crack',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mp_arresting",
                    anim = "a_uncuff",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('emptybaggies', 1) and exports['dg-inventory']:hasEnoughOfItem('cpowder', 1) and exports['dg-inventory']:hasEnoughOfItem('bsalts', 1) then
                        --TriggerEvent("ogrp-chickentaco")
                        --TriggerServerEvent('coke:processed')
                        TriggerEvent('inv:remove','emptybaggies',1)
                        TriggerEvent('inv:remove','cpowder',1)
                        TriggerEvent('inv:remove','bsalts',1)
                        TriggerEvent('player:receiveItem', '1gcrack', 5)
                        UsingAnyItem = false
                    end
                else
                    exports['mythic_notify']:SendAlert('error', 'Not Enough items') 
                end
                FreezeEntityPosition(player, false)
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Not Enough items') 
        end
    end
end)

--------------------------------
---------Medic Items-------------
--------------------------------



RegisterNetEvent("medic:gauze")
AddEventHandler("medic:gauze", function()
    
    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'gauze', 1)

        exports['mythic_progbar']:Progress({
            name = "firstaid_action",
            duration = 1500,
            label = "Packing Wounds...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@idle_a",
                anim = "idle_a",
                flags = 49,
            },
            prop = {
                model = "prop_paper_bag_small",
            } 
        }, function(cancelled)
            if not cancelled then
                TriggerEvent('dg-hospital:client:FieldTreatBleed')
                UsingAnyItem = false
            else
                TriggerEvent('player:receiveItem', 'gauze', 1)
                UsingAnyItem = false
            end
        end)
    
    end
    
end)

RegisterNetEvent("medic:bandage")
AddEventHandler("medic:bandage", function()

    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'bandage', 1)

        exports['mythic_progbar']:Progress({
            name = "firstaid_action",
            duration = 5000,
            label = "Using Bandage...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@world_human_clipboard@male@idle_a",
                anim = "idle_c",
                flags = 49,
            }

        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
		        local health = GetEntityHealth(PlayerPedId())
		        local newHealth = math.min(200, math.floor(health + 200 / 16))
		        SetEntityHealth(PlayerPedId(), newHealth)
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'bandage', 1)
            end
        end)

    end
end)

RegisterNetEvent("medic:firstaidkit")
AddEventHandler("medic:firstaidkit", function()
    
    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'firstaidkit', 1)

        exports['mythic_progbar']:Progress({
            name = "firstaid_action",
            duration = 10000,
            label = "Using First Aid...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "missheistdockssetup1clipboard@idle_a",
                anim = "idle_a",
                flags = 49,
            },
            prop = {
                model = "prop_ld_health_pack"
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
		        SetEntityHealth(PlayerPedId(), 200)
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'firstaidkit', 1)
            end
        end)

    end
end)

RegisterNetEvent("medic:ifak")
AddEventHandler("medic:ifak", function()
    if canBeUsed then
        UsingAnyItem = true

        TriggerEvent("inventory:removeItem",'ifak', 1)
        
        exports['mythic_progbar']:Progress({
            name = "ifak_action",
            duration = 5000,
            label = "Using IFAK...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "amb@world_human_clipboard@male@idle_a",
                anim = "idle_c",
                flags = 49,
            }
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
                TriggerEvent('dg-hospital:client:ResetLimbs')
                TriggerEvent('dg-hospital:client:RemoveBleed')
                for i = 1, 5 , 1 do 
                    local health = GetEntityHealth(PlayerPedId())
                    if health < 200 then
                        SetEntityHealth(PlayerPedId(), health+10)
                        Citizen.Wait(5000)
                    else
                        return
                    end
                end
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'ifak', 1)
            end
        end)
    end
end)

RegisterNetEvent("medic:oxy")
AddEventHandler("medic:oxy", function()
    if canBeUsed then
        UsingAnyItem = true

        TriggerEvent("inventory:removeItem",'oxy', 1)
        
        exports['mythic_progbar']:Progress({
            name = "oxy_action",
            duration = 1500,
            label = "Taking OXY Pills",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
                flags = 49,
            },
           prop = {
                model = "prop_cs_pills",
                bone = 58866,
                coords = { x = 0.1, y = 0.0, z = 0.001 },
                rotation = { x = -60.0, y = 0.0, z = 0.0 },
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
                TriggerEvent('dg-hospital:client:ResetLimbs')
                TriggerEvent('dg-hospital:client:RemoveBleed')
                exports['mythic_notify']:SendAlert('inform', 'You have been relieved from all your injuries')
                for i = 1, 5 , 1 do 
                    local health = GetEntityHealth(PlayerPedId())
                    if health < 200 then
                        SetEntityHealth(PlayerPedId(), health+10)
                        Citizen.Wait(5000)
                    else
                        return
                    end
                end
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'oxy', 1)
            end
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Slow Down')
    end
end)

RegisterNetEvent("medic:aspirin")
AddEventHandler("medic:aspirin", function()
    if canBeUsed then
        UsingAnyItem = true

        TriggerEvent("inventory:removeItem",'aspirin', 1)
        
        exports['mythic_progbar']:Progress({
            name = "oxy_action",
            duration = 1500,
            label = "Taking Aspirin",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
                flags = 49,
            },
           prop = {
                model = "prop_cs_pills",
                bone = 58866,
                coords = { x = 0.1, y = 0.0, z = 0.001 },
                rotation = { x = -60.0, y = 0.0, z = 0.0 },
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
                TriggerEvent('dg_status:remove', 'stress', 50000)
                exports['mythic_notify']:SendAlert('success', 'Stressed Relieved')
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'aspirin', 1)
            end
        end)
    end
end)

RegisterNetEvent("medic:vicodin")
AddEventHandler("medic:vicodin", function()
    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'vicodin', 1)

        exports['mythic_progbar']:Progress({
            name = "firstaid_action",
            duration = 1000,
            label = "Taking Vicodin",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
                flags = 49,
            },
           prop = {
                model = "prop_cs_pills",
                bone = 58866,
                coords = { x = 0.1, y = 0.0, z = 0.001 },
                rotation = { x = -60.0, y = 0.0, z = 0.0 },
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
	    		local health = GetEntityHealth(PlayerPedId())
	    		local newHealth = math.min(200, math.floor(health + 200 / 8))
	    		SetEntityHealth(PlayerPedId(), newHealth)
	    		TriggerEvent('dg-hospital:client:UsePainKiller', 2)
            
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'vicodin', 1)
            end
                
        end)
    end
end)

RegisterNetEvent("medic:hydrocodone")
AddEventHandler("medic:hydrocodone", function()
    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'hydrocodone', 1)

        exports['mythic_progbar']:Progress({
            name = "firstaid_action",
            duration = 1000,
            label = "Taking hydrocodone",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
                flags = 49,
            },
            prop = {
                model = "prop_cs_pills",
                bone = 58866,
                coords = { x = 0.1, y = 0.0, z = 0.001 },
                rotation = { x = -60.0, y = 0.0, z = 0.0 },
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
	    		local health = GetEntityHealth(PlayerPedId())
	    		local newHealth = math.min(200, math.floor(health + 200 / 4))
	    		SetEntityHealth(PlayerPedId(), newHealth)
	    		TriggerEvent('dg-hospital:client:UsePainKiller', 3)
            
            else
                medic = false
                TriggerEvent('player:receiveItem', 'hydrocodone', 1)
            end
        end)
    end
end)

RegisterNetEvent("medic:adrenaline")
AddEventHandler("medic:adrenaline", function()
    if canBeUsed then
        
        UsingAnyItem = true
        TriggerEvent("inventory:removeItem",'adrenaline', 1)

        exports['mythic_progbar']:Progress({
            name = "adrenaline_action",
            duration = 2000,
            label = "Taking Adrenaline...",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "mp_suicide",
                anim = "pill",
                flags = 49,
            },
            prop = {
                model = "prop_cs_pills",
                bone = 58866,
                coords = { x = 0.1, y = 0.0, z = 0.001 },
                rotation = { x = -60.0, y = 0.0, z = 0.0 },
            }, 
        }, function(cancelled)
            if not cancelled then
                UsingAnyItem = false
                TriggerEvent('dg-hospital:client:UseAdrenaline', 4)
            else
                UsingAnyItem = false
                TriggerEvent('player:receiveItem', 'adrenaline', 1)
            end
        end)
    end
end)

-- A thread that increase stamina

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if increaseStamina then
			RestorePlayerStamina(PlayerId(), 1.0)
		end
	end
end)

-- A thread that gives alcohol effect

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if onAlcohol then
			SetPedIsDrunk(PlayerPedId(),true)
		end
	end
end)


-- Thread that check if no item in use 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if not UsingAnyItem then
            if alive and not cuffed then
                canBeUsed = true
            else
                canBeUsed = false
                DisablePlayerFiring(PlayerPedId(),true)
            end
        else
            DisablePlayerFiring(PlayerPedId(),true)
            canBeUsed = false
		end
	end
end)

local underwaterTime = 900

-- Thread that don't let person die underwater

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        if onO2tank then
            underwaterTime = underwaterTime - 1
            SetPedDiesInWater(PlayerPedId(), false)
        else
            underwaterTime = 900
        end
	end
end)

-- Draw Text

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if onO2tank then
            drawTxt('Oxygen Remaining: '..underwaterTime)
        end
	end
end)

-- Draw Text on screen

function drawTxt(content)
    SetTextFont(4)
    SetTextScale(0.3, 0.3)
    SetTextColour(255,255,255, 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(0.88,0.90)
end

---

Citizen.CreateThread(function()
	while true do
        local objFound = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()),3.0,1116369239, 0, 0, 0)
        if DoesEntityExist(objFound) then
            TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
        end
        Wait(100)
    end
end)

-- Check if guy is alive

RegisterNetEvent('check:alive')
AddEventHandler('check:alive', function(status)
    if status then
        alive = true
        TriggerEvent('check2:alive', false)
    else
        alive  = false
        TriggerEvent('check2:alive', true)
    end
end)

-- check if guy is cuffed

RegisterNetEvent('check:cuff')
AddEventHandler('check:cuff', function(status)
    if status then
        cuffed = true
    else
        cuffed = false
    end
end)


-- Command for removing oxygen tank

 RegisterCommand('oxyoff', function()
     onO2tank =false
     DeleteObject(object)
     DeleteObject(object2)
     SetPedDiesInWater(PlayerPedId(), true)
 end)


 function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end
