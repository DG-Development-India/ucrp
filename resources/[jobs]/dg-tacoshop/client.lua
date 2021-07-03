DGCore = nil

local PlayerData              = {}

Citizen.CreateThread(function ()
    while DGCore == nil do
        TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(1)
    end

    while DGCore.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = DGCore.GetPlayerData()
end) 

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- current selling value depending on amount of people selling.
local value = 0.4

-- amount of weed4g's needed to start.
local weedcost = 5

-- are we already running a looperino?
local ActiveRun = false

-- Current step of procedure, 0 nothing, 1 moving to location
local CurrentStep = 0

-- 1 in X chance of getting rep, higher = less obviously.
local repChance = 5

-- counter +0.1 chance per drop off, 1 in X
local CounterIncreaseChance = 22

-- chance for call in on sale
local PoliceCallChance = 5

-- run length
local DropOffCount = 0

-- our current drop point
local DropOffLocation =  { ['x'] = -10.81,['y'] = -1828.68,['z'] = 25.4,['h'] = 301.59, ['info'] = ' Grove shop' }

-- loop waiting period, changes to 1 for draw text options.
local waittime = 1000

local WeedVehicle = 0

-- drop marker
local CurrentMarker = 0

-- How many active deliveries we have, if this is 2 we dont require cooking
local DeliveryCounter = 0

-- What item is required to be cooked
local CurrentCookItem = 1

-- milliseconds to swap from cook to delivery
local GracePeriod = 0

local DropOffMax = 12

local lastDelivery = GetGameTimer() - GracePeriod

local lastCook = GetGameTimer() - GracePeriod

local SaleReputation = 0

local cashstackprice = math.random(2500, 4000)
local cashrollprice = math.random(800, 850)

local inkedmoneybagprice = math.random(35000, 50000)
local markedbillsprice = math.random(300, 400)

local cashstackcount = 1
local cashrollcount = 1

local FoodTable = {
    --[1] = { ["id"] = "coffee", ["name"] = "Coffee" },
    [1] = { ["id"] = "taco", ["name"] = "Veg Taco" },
    [2] = { ["id"] = "chickentaco", ["name"] = "Chicken Taco" },
    [3] = { ["id"] = "fishtaco", ["name"] = "Fish Taco" },
    --[5] = { ["id"] = "water", ["name"] = "Water" },
    [4] = { ["id"] = "prawntaco", ["name"] = "Prawn Taco" },
    [5] = { ["id"] = "chocotaco", ["name"] = "Choco Taco" },
    [6] = { ["id"] = "icetaco", ["name"] = "Icecream Taco" },
    [7] = { ["id"] = "burrito", ["name"] = "Burrito" },
    [8] = { ["id"] = "eggsbacon", ["name"] = "Eggs and Bacon" },
    --[9] = { ["id"] = "hotdog", ["name"] = "Hotdog" },
    --[10] = { ["id"] = "mshake", ["name"] = "Milk Shake" },
    --[10] = { ["id"] = "burrito", ["name"] = "Burrito" },
    --[11] = { ["id"] = "greencow", ["name"] = "Lemoned" },
}

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
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

--[4] = { ['x'] = 4.13,['y'] = -1605.47,['z'] = 29.29,['h'] = 278.54, ['info'] = 'weed run' },
--[5] = { ['x'] = 6.45,['y'] = -1608.4,['z'] = 29.3,['h'] = 323.79, ['info'] = 'convert cash' },
--[1] =  { ['x'] = 7.61,['y'] = -1599.54,['z'] = 29.3,['h'] = 135.61, ['info'] = ' cancel' },
--[2] =  { ['x'] = 9.24,['y'] = -1604.11,['z'] = 29.38,['h'] = 232.33, ['info'] = ' Food Required' },
--[1] =  { ['x'] = 145.14,['y'] = -2203.4,['z'] = 4.69,['h'] = 181.07, ['info'] = ' Word on the streets' },


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId())
        local dist = Vdist(19.68, -1602.41, 29.38, plyCoords)
        if dist > 120.0 then
            Wait(1000)
        else
            local dist2 = Vdist(11.32, -1605.93, 29.4, plyCoords) 
            local dist3 = Vdist(7.61, -1599.54, 29.3,plyCoords)
            local dist4 = Vdist(15.47, -1598.78, 29.38,plyCoords)
            local dist5 = Vdist(9.24,-1604.11, 29.38,plyCoords)


            if dist < 1.5 and not ActiveRun then
                DrawText3Ds(20.05069, -1602.163, -10.62204, "Press E to deliver Green Tacos @ " .. value .. "%")
                if IsControlJustReleased(1,38) then
                    local lPed = PlayerPedId()
                    RequestAnimDict("mini@repair")
                    Wait(1000)
                    if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
                        ClearPedSecondaryTask(lPed)
                        TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
                    end
                    exports["dg-taskbar"]:taskBar(5000, "Packaging Tacos")                   
                      CheckWeedRun()
                      ClearPedTasks(lPed)
                end
            elseif dist2 < 1.5 and not ActiveRun then
                if DeliveryCounter > 0 then
                    DrawText3Ds(11.32, -1605.93, 29.4, "Press E to deliver food.")
                    if IsControlJustReleased(1,38) then

                        if lastCook+GracePeriod < GetGameTimer() then
                            lastDelivery = GetGameTimer()
                            TriggerServerEvent("TacoShop:reputations")
                            TriggerEvent("taco:successStart")
                            TriggerServerEvent("delivery:status",-1)
                            Wait(1000)
                        else
                            TriggerEvent("DoLongHudText","You must wait to swap to deliveries! (" .. (lastCook+GracePeriod-GetGameTimer())/0 .." seconds)", 2)
                        end

                    end
                else
                    DrawText3Ds(11.32, -1605.93, 29.4, "No food required for delivery")
                end
            elseif dist3 < 1.5 then
                DrawText3Ds(7.61, -1599.54, 29.3, "Press E to cancel deliveries")
                if IsControlJustReleased(1,38) then
                    TriggerEvent("DoLongHudText","Runs reset")
                    EndRuns()
                    Wait(1000)
                end
            elseif dist5 < 1.5 and not ActiveRun then
                if DeliveryCounter == 2 then
                    DrawText3Ds(9.24,-1604.11, 29.38, "We require food to be delivered")
                else
                    DrawText3Ds(9.24,-1604.11, 29.38, "[E] We require a " .. FoodTable[CurrentCookItem]["name"] .. " to be delivered.")
                    if IsControlJustReleased(1,38) then
                        if lastDelivery+GracePeriod < GetGameTimer() then
                            lastCook = GetGameTimer()
                            SetDelivery(FoodTable[CurrentCookItem]["id"])
                            Wait(1000)
                        else
                            TriggerEvent("DoLongHudText","You must wait to start prepping food (" .. (lastDelivery+GracePeriod-GetGameTimer())/1000 .." seconds)")
                        end                        
                    end
                end  
            end
        end
    end
end)

function SetDelivery(foodReq)
    if DeliveryCounter ~= 2 then
        -- if exports["dg-inventory"]:hasEnoughOfItem(foodReq,1) then
        --     TriggerEvent("inventory:removeItem",foodReq, 1)
        --     TriggerServerEvent('mission:finished', math.random(10,110))
        --     TriggerServerEvent("delivery:status",1)
        -- else
        --     TriggerEvent("DoLongHudText","You dont have the required food for the delivery!", 2)
        -- end
        if exports["dg-inventory"]:hasEnoughOfItem(foodReq,1) then
            exports['mythic_progbar']:Progress({
                name = "tacopackagingweed",
                duration = 15000,
                label = 'Packaging Tacos',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = true,
                },
                animation = {
                    animDict = "mini@repair",
                    anim = "fixing_a_player",
                    flags = 49,
                }
            }, function(cancelled)
                if not cancelled then
                    if exports["dg-inventory"]:hasEnoughOfItem(foodReq,1) then
                        TriggerEvent("inventory:removeItem",foodReq, 1)
                        --TriggerServerEvent('mission:finished', math.random(10,110))
                        TriggerServerEvent("delivery:status",1)
                    else
                        TriggerEvent("DoLongHudText","You dont have the required food for the delivery!", 2)
                    end
                end
            end)
        else
            TriggerEvent("DoLongHudText","You dont have the required food for the delivery!", 2) 
        end
    end
    Wait(1000)
end

function CheckWeedRun()
if exports["dg-inventory"]:hasEnoughOfItem("weedq", 5) then 
    TriggerServerEvent("weed:checkmoney")
else
    TriggerEvent('DoLongHudText', "The taco did not seem dank enough.", 2)
    end
end


RegisterNetEvent("TacoShop:reputation")
AddEventHandler("TacoShop:reputation", function(rep)
    SaleReputation = rep
end)

RegisterNetEvent("delivery:deliverables")
AddEventHandler("delivery:deliverables", function(newCounter,nextItem)
    DeliveryCounter = newCounter
    CurrentCookItem = nextItem
end)

-- exports["dg-inventory"]:hasEnoughOfItem("band",150)

RegisterNetEvent("taco:successStart")
AddEventHandler("taco:successStart", function()
    EndRuns()
    ActiveRun = true
    local toolong = 0

    TriggerEvent("player:receiveItem","weedtaco", 1)
    while ActiveRun do
        Wait(1)
        if CurrentStep == 0 then
            DropOffLocation = DropOffsClose[math.random(#DropOffsClose)]
            BlipCreation()
            CurrentStep = 1
        end
        local plyCoords = GetEntityCoords(PlayerPedId())
        local inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        local distance = Vdist(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],plyCoords)
        if distance < 45.0 and not inVehicle then
            waittime = 1
            DrawText3Ds(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],"Press E to drop off package.")
            if IsControlJustReleased(1,38) and ActiveRun and distance < 1.5 then
                AttemptDropOffTaco()
                EndRuns()
            end
        end
        toolong = toolong + 1
        if toolong > 180000 then
            TriggerEvent("DoLongHudText","Taco Run timed out!")
            EndRuns()
        end
    end

end)

function AttemptDropOffTaco()
    if exports["dg-inventory"]:hasEnoughOfItem("weedtaco",1) then
    exports['mythic_progbar']:Progress({
        name = "tacopackagingweed",
        duration = 15000,
        label = 'Delivering Taco',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,
        },
        animation = {
            animDict = "timetable@jimmy@doorknock@",
            anim = "knockdoor_idle",
            flags = 49,
        }
    }, function(cancelled)
        if not cancelled then
            --TriggerEvent("ogrp-chickentaco")
            if exports["dg-inventory"]:hasEnoughOfItem("weedtaco",1) then
                TriggerEvent("inventory:removeItem","weedtaco", 1)
        
                TriggerEvent("attachItemDrugs","cashcase01")
                TriggerEvent("Evidence:StateSet",4,1600)
        
                if math.random(CounterIncreaseChance) == CounterIncreaseChance then
                    TriggerServerEvent("TacoShop:IncreaseCounter")
                end
        
                local payment = math.random(300,350)
                -- if exports["dg-inventory"]:hasEnoughOfItem("cashstack",cashstackprice) then     
                --     TriggerEvent("inventory:removeItem","cashstack", cashstackprice)   
                --     payment = payment + ( cashstackprice + math.ceil(cashstackprice * SaleReputation/100) )            
                --     TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
                -- elseif exports["dg-inventory"]:hasEnoughOfItem("markedbills",1) then     
                --     TriggerEvent("inventory:removeItem","markedbills", 1)   
                --     payment = payment + ( markedbillsprice + math.ceil(markedbillsprice * SaleReputation/100) )            
                --     TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
                -- elseif exports["dg-inventory"]:hasEnoughOfItem("rollcash",rollcount) then     
                --     TriggerEvent("inventory:removeItem","rollcash", rollcount)   
                --     payment = payment + ( rollcashprice + math.ceil(rollcashprice * SaleReputation/100) )              
                --     TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
                if exports["dg-inventory"]:hasEnoughOfItem("cashroll",cashrollcount) then     
                    TriggerEvent("inventory:removeItem","cashroll", cashrollcount)   
                    payment = payment + ( cashrollprice + math.ceil(cashrollprice * SaleReputation/100) )              
                    TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
                else
                    TriggerEvent("DoLongHudText","Thanks, no extra sauce though?!")
                end
                TriggerServerEvent('mission:finished', payment)
            end
        end
    end)
    -- if exports["dg-inventory"]:hasEnoughOfItem("weedtaco",1) then
    --     TriggerEvent("inventory:removeItem","weedtaco", 1)

    --     TriggerEvent("attachItemDrugs","cashcase01")
    --     TriggerEvent("Evidence:StateSet",4,1600)

    --     if math.random(CounterIncreaseChance) == CounterIncreaseChance then
    --         TriggerServerEvent("TacoShop:IncreaseCounter")
    --     end

    --     local payment = math.random(10,110)
    --     if exports["dg-inventory"]:hasEnoughOfItem("cashstack",cashstackprice) then     
    --         TriggerEvent("inventory:removeItem","cashstack", cashstackprice)   
    --         payment = payment + ( cashstackprice + math.ceil(cashstackprice * SaleReputation/100) )            
    --         TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
    --     -- elseif exports["dg-inventory"]:hasEnoughOfItem("markedbills",1) then     
    --     --     TriggerEvent("inventory:removeItem","markedbills", 1)   
    --     --     payment = payment + ( markedbillsprice + math.ceil(markedbillsprice * SaleReputation/100) )            
    --     --     TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
    --     -- elseif exports["dg-inventory"]:hasEnoughOfItem("rollcash",rollcount) then     
    --     --     TriggerEvent("inventory:removeItem","rollcash", rollcount)   
    --     --     payment = payment + ( rollcashprice + math.ceil(rollcashprice * SaleReputation/100) )              
    --     --     TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
    --     elseif exports["dg-inventory"]:hasEnoughOfItem("cashroll",cashrollcount) then     
    --         TriggerEvent("inventory:removeItem","band", cashrollcount)   
    --         payment = payment + ( cashrollprice + math.ceil(cashrollprice * SaleReputation/100) )              
    --         TriggerEvent("DoLongHudText","Thanks for the extra sauce!")
    --     else
    --         TriggerEvent("DoLongHudText","Thanks, no extra sauce though?!")
    --     end
    --     TriggerServerEvent('mission:finished', payment)
    -- end
    end
end

RegisterNetEvent("weed:values")
AddEventHandler("weed:values", function(newValue)
    value = newValue
end)

function CreateWeedVehicle()

    if DoesEntityExist(WeedVehicle) then

        SetVehicleHasBeenOwnedByPlayer(WeedVehicle,false)
        SetEntityAsNoLongerNeeded(WeedVehicle)
        DeleteEntity(WeedVehicle)
    end

    local car = GetHashKey(carpick[math.random(#carpick)])
    RequestModel(car)
    while not HasModelLoaded(car) do
        Citizen.Wait(0)
    end

    local spawnpoint = 1
    for i = 1, #carspawns do
        local caisseo = GetClosestVehicle(carspawns[i]["x"], carspawns[i]["y"], carspawns[i]["z"], 3.500, 0, 70)
        if not DoesEntityExist(caisseo) then
            spawnpoint = i
        end
    end

    WeedVehicle = CreateVehicle(car, carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], carspawns[spawnpoint]["h"], true, false)
    local plt = GetVehicleNumberPlateText(WeedVehicle)
    SetVehicleHasBeenOwnedByPlayer(WeedVehicle,true)
    SetModelAsNoLongerNeeded(car)
    TriggerServerEvent('garage:addKeys', plt)

    while true do
        Citizen.Wait(1)
        DrawText3Ds(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"], "Your Delivery Car (Stolen).")
        if #(GetEntityCoords(PlayerPedId()) - vector3(carspawns[spawnpoint]["x"], carspawns[spawnpoint]["y"], carspawns[spawnpoint]["z"])) < 8.0 then
            return
        end
    end

end

RegisterNetEvent("weed:successStart")
AddEventHandler("weed:successStart", function()

    if not exports["dg-inventory"]:hasEnoughOfItem("weedq",weedcost) then
        TriggerEvent("DoLongHudText","You dont have enough weed")
        return
    end

    StartWeedRun()
    CreateWeedVehicle()
    local toolong = 0
    while ActiveRun do
        Wait(waittime)
        if CurrentStep == 0 then

            if DropOffCount == DropOffMax or not DoesEntityExist(WeedVehicle) then
                EndRuns()
            end

            local veh = GetVehiclePedIsIn(PlayerPedId(),false)
            if WeedVehicle == veh then
                CurrentStep = 1
                waittime = 1000
                if math.random(50) < 25 then
                    DropOffLocation = DropOffs[math.random(#DropOffs)]
                else
                    DropOffLocation = DropOffsClose[math.random(#DropOffsClose)]
                end                
                BlipCreation()
            else
                TriggerEvent("DoLongHudText","Either return to your drop off vehicle or end your run if you have lost it.")
                Wait(10000)
            end

        elseif CurrentStep == 1 then
            local plyCoords = GetEntityCoords(PlayerPedId())
            local inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
            local distance = Vdist(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],plyCoords)
            if distance < 30.0 and not inVehicle then
                waittime = 1
                DrawText3Ds(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"],"Press E to drop off package.")
                if IsControlJustReleased(1,38) and ActiveRun and distance < 1.5 then
                    AttemptDropOff()
                end
            else
                waittime = 1000
            end
        else
            waittime = 1000
        end

        toolong = toolong + 1
        if toolong > 360000 then
            WeedTacoTooLong()
        end
    end
end)

function ClearBlips()
    RemoveBlip(CurrentMarker)
    CurrentMarker = 0
end

function BlipCreation()
    ClearBlips()
    CurrentMarker = AddBlipForCoord(DropOffLocation["x"],DropOffLocation["y"],DropOffLocation["z"])
    SetBlipSprite(CurrentMarker, 514)
    SetBlipScale(CurrentMarker, 1.0)
    SetBlipAsShortRange(CurrentMarker, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(CurrentMarker)
end

function StartWeedRun()
    TriggerEvent("inventory:removeItem","weedq", weedcost)
    TriggerEvent("player:receiveItem","weed12oz",1)
    ActiveRun = true
end

function EndRuns()
    ClearBlips()
    SetVehicleHasBeenOwnedByPlayer(WeedVehicle,false)
    SetEntityAsNoLongerNeeded(WeedVehicle)

    ActiveRun = false
    waittime = 1000
    CurrentStep = 0
    DropOffCount = 0
    DropOffLocation =  { ['x'] = -10.81,['y'] = -1828.68,['z'] = 25.4,['h'] = 301.59, ['info'] = ' Grove shop' }
    Wait(1000)
    ClearBlips()
end

function WeedTacoTooLong()
    if exports["dg-inventory"]:hasEnoughOfItem("weed12oz",1) then
        ClearBlips()
        Wait(60000)
        -- new run
        TriggerEvent("DoLongHudText","You took too long!", 2)
        DropOffCount = DropOffCount + 1
        CurrentStep = 0        
    else
        TriggerEvent("DoLongHudText","Run ended as your box is gone!", 2)
        EndRuns()
    end
end

function AttemptDropOff()
    if exports["dg-inventory"]:hasEnoughOfItem("weed12oz",1) then
        if math.random(PoliceCallChance) == PoliceCallChance then
            TriggerEvent("civilian:alertPolice",15.0,"Suspicious",0)
        end
        TriggerEvent("DoLongHudText","Drop off success!")
        TriggerEvent("player:receiveItem","band",math.ceil(10*value))
        TriggerEvent("inventory:removeItem","weed12oz",1)
        ClearBlips()
        TriggerEvent("attachItemDrugs","drugpackage01")
        TriggerEvent("Evidence:StateSet",4,600)
        Wait(180000)
        -- new run
        DropOffCount = DropOffCount + 1
        CurrentStep = 0        
    else
        TriggerEvent("DoLongHudText","Run ended as your box is gone!")
        EndRuns()
    end
end

-----Processing------

EtPisir = {vector3(11.70593,-1599.591,29.37576)}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        for k,v in pairs(EtPisir) do
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 5)  then
                DrawMarker(2, v.x, v.y, v.z-0.10, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
                if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2)  then
                    DrawText3Ds(v.x, v.y, v.z+0.15, '~g~E~w~ - start cooking')
                    if IsControlJustReleased(0, 38) then
                        prepareTacoChunkMenu()
                    end
                end
            end
        end
    end
end)

-- function prepareTacoChunkMenu()
--     DGCore.UI.Menu.CloseAll()
  
--     DGCore.UI.Menu.Open(
--         'default', GetCurrentResourceName(), 'ventacyc',
--         {
--             title    = 'What you want to fry?',
--             align    = 'top-right',
--             elements = {
--                 { label = 'Fried Prawn', value = 'prawnchucks'},
--                 { label = 'Fried Chicken', value = 'chickenchunks'},
--                 { label = 'Fried Fish', value = 'fishchunks'},
--                 { label = 'Fried Vagetables', value = 'vegchunks'},
--             }
--         },
--         function(data, menu)
--             if data.current.value == 'prawnchucks' then 
--                 menu.close()
--                 TriggerEvent("dg-prawnchucks")
--             elseif data.current.value == 'chickenchunks' then
--                 menu.close()
--                 TriggerEvent("dg-chickenchunks")
--             elseif data.current.value == 'fishchunks' then
--                 menu.close()
--                 TriggerEvent("dg-fishchunks")
--             elseif data.current.value == 'vegchunks' then
--                 menu.close()
--                 TriggerEvent("dg-vegchunks")  
--             end
--         end,
--         function(data, menu)
--             menu.close()
--         end
--     )
--   end

function prepareTacoChunkMenu()
	local elements ={  
        { label = 'Fried Prawn', value = 'prawnchucks'},
        { label = 'Fried Chicken', value = 'chickenchunks'},
        { label = 'Fried Fish', value = 'fishchunks'},
        { label = 'Fried Vagetables', value = 'vegchunks'},
	}
	
	DGCore.UI.Menu.CloseAll() 
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(),'ventacyc',{
		title = 'What you want to fry?', 
		align = 'top-right',
		elements = elements  
	
	}, function(data, menu)
	
                if data.current.value == 'prawnchucks' then 
                    menu.close()
                    TriggerEvent("dg-prawnchucks")
                elseif data.current.value == 'chickenchunks' then
                    menu.close()
                    TriggerEvent("dg-chickenchunks")
                elseif data.current.value == 'fishchunks' then
                    menu.close()
                    TriggerEvent("dg-fishchunks")
                elseif data.current.value == 'vegchunks' then
                    menu.close()
                    TriggerEvent("dg-vegchunks")  
                end
            end,function(data, menu)
            menu.close()
        --end
    end)
end

RegisterNetEvent('dg-prawnchucks')
AddEventHandler('dg-prawnchucks', function()
    local playerPed = PlayerPedId()
        if exports['dg-inventory']:hasEnoughOfItem('packagedprawn', 1) then
            TriggerEvent("dg-emotes:playthisemote", 'bbq')
            exports['mythic_progbar']:Progress({
                name = "prawnchunks",
                duration = 10000,
                label = 'making Prawn Chunks',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('packagedprawn', 1) then
                        TriggerEvent('inv:remove','packagedprawn',1)
                        TriggerEvent('player:receiveItem', 'prawnchunk', 10)
                        TriggerEvent("dg-emotes:playthisemote", 'c')
                        exports['mythic_notify']:SendAlert('success', 'You fried 10 Prawn chunks!')
                    else
                    exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
        end
end)

RegisterNetEvent('dg-chickenchunks')
AddEventHandler('dg-chickenchunks', function()
    local playerPed = PlayerPedId()
        if exports['dg-inventory']:hasEnoughOfItem('pchicken', 1) then
            TriggerEvent("dg-emotes:playthisemote", 'bbq')
            exports['mythic_progbar']:Progress({
                name = "chickenchunks",
                duration = 10000,
                label = 'making Chicken Chunks',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('pchicken', 1) then
                        TriggerEvent('inv:remove','pchicken',1)
                        TriggerEvent('player:receiveItem', 'chickenchunk', 10)
                        TriggerEvent("dg-emotes:playthisemote", 'c')
                        exports['mythic_notify']:SendAlert('success', 'You fried 10 Chicken chunks!')
                    else
                    exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
        end
end)

RegisterNetEvent('dg-fishchunks')
AddEventHandler('dg-fishchunks', function()
    local playerPed = PlayerPedId()
        if exports['dg-inventory']:hasEnoughOfItem('hilsa', 1) or exports['dg-inventory']:hasEnoughOfItem('freshwatereel', 1) then
            TriggerEvent("dg-emotes:playthisemote", 'bbq')
            exports['mythic_progbar']:Progress({
                name = "fishchunks",
                duration = 10000,
                label = 'making Fish Chunks',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('hilsa', 1) then
                        TriggerEvent('inv:remove','hilsa',1)
                        TriggerEvent('player:receiveItem', 'fishchunk', 10)
                        TriggerEvent("dg-emotes:playthisemote", 'c')
                        exports['mythic_notify']:SendAlert('success', 'You fried 10 Fish chunks!')
                    elseif exports['dg-inventory']:hasEnoughOfItem('freshwatereel', 1) then
                        TriggerEvent('inv:remove','freshwatereel',1)
                        TriggerEvent('player:receiveItem', 'fishchunk', 10)
                        TriggerEvent("dg-emotes:playthisemote", 'c')
                        exports['mythic_notify']:SendAlert('success', 'You fried 10 Fish chunks!')
                    else
                    exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
        end
end)

RegisterNetEvent('dg-vegchunks')
AddEventHandler('dg-vegchunks', function()
    local playerPed = PlayerPedId()
        if exports['dg-inventory']:hasEnoughOfItem('mixedvegpack', 1) then
            TriggerEvent("dg-emotes:playthisemote", 'bbq')
            exports['mythic_progbar']:Progress({
                name = "vegchunks",
                duration = 10000,
                label = 'making Vegetable Chunks',
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        }, function(cancelled)
                if not cancelled then
                    if exports['dg-inventory']:hasEnoughOfItem('mixedvegpack', 1) then
                        TriggerEvent('inv:remove','mixedvegpack',1)
                        TriggerEvent('player:receiveItem', 'friedveg', 5)
                        TriggerEvent("dg-emotes:playthisemote", 'c')
                        exports['mythic_notify']:SendAlert('success', 'You fried 10 Veg chunks!')
                    else
                    exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
                    end
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasks(PlayerPedId())
                end
            end)
        else
            exports['mythic_notify']:SendAlert('error', 'Not enough item!')  
        end
end)