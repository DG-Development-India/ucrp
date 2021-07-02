DGCore = nil
local Licenses = {}

-----------attachments-----------

local weapons = {
    [GetHashKey('WEAPON_PISTOL')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_PISTOL_MK2')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_PISTOL50')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_COMBATPISTOL')] = { suppressor = GetHashKey('COMPONENT_AT_PI_SUPP'), flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = nil },
    [GetHashKey('WEAPON_APPISTOL')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_HEAVYPISTOL')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_VINTAGEPISTOL')] = { suppressor = nil, flashlight = nil, grip = nil, skin = nil, scope = nil },
    [GetHashKey('WEAPON_SMG')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_SMG_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_MICROSMG')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_PI_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_ASSAULTSMG')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil, scope = nil },
    [GetHashKey('WEAPON_ASSAULTRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_CARBINERIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE'), scope = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
    [GetHashKey('WEAPON_ADVANCEDRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE'), scope = nil },
    [GetHashKey('WEAPON_SPECIALCARBINE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil },
    [GetHashKey('WEAPON_BULLPUPRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
    [GetHashKey('WEAPON_ASSAULTSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil },
    [GetHashKey('WEAPON_HEAVYSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil },
    [GetHashKey('WEAPON_BULLPUPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil },
    [GetHashKey('WEAPON_PUMPSHOTGUN')] = { suppressor = GetHashKey('COMPONENT_AT_SR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = nil, skin = nil, scope = nil },
    [GetHashKey('WEAPON_MARKSMANRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP'), flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil },
    [GetHashKey('WEAPON_SNIPERRIFLE')] = { suppressor = GetHashKey('COMPONENT_AT_AR_SUPP_02'), flashlight = nil, grip = nil, skin = nil, scope = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
    [GetHashKey('WEAPON_HEAVYSNIPER')] = { suppressor = nil, flashlight = nil, grip = nil, skin = nil, scope = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
    [GetHashKey('WEAPON_COMBATPDW')] = { suppressor = nil, flashlight = GetHashKey('COMPONENT_AT_AR_FLSH'), grip = GetHashKey('COMPONENT_AT_AR_AFGRIP'), skin = nil, scope = nil }
}

---------------------------------
Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(0)
        TriggerServerEvent("playerSpawned")
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	DGCore.PlayerData = DGCore.GetPlayerData()
    TriggerEvent('updateInv')
end)

Citizen.CreateThread(function()
    while DGCore == nil or DGCore.PlayerData == nil or DGCore.PlayerData.job == nil do
        Citizen.Wait(1)
    end
end)

local BodyParts = {
	[1] = {item = "car_door", prop = "prop_car_door_01", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[2] = {item = "carhood", prop = "prop_car_bonnet_01", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[3] = {item = "car_trunk", prop = "prop_car_bonnet_02", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[4] = {item = "tire", prop = "prop_wheel_03", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
}

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

local fixingvehicle = false
local justUsed = false
local retardCounter = 0
local lastCounter = 0 
local HeadBone = 0x796e;
local dead = false
local opened = false

local validWaterItem = {
    ["oxygentank"] = true,
}

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if IsControlJustPressed(0, 311) then
            if not dead and not opened then
                opened = true
                TriggerEvent("OpenInv")
                Citizen.Wait(500)
                opened = false
            end
        end
    end
end)

RegisterNetEvent('eden_accesories:use')
AddEventHandler('eden_accesories:use', function( type )
    if weapons[GetSelectedPedWeapon(PlayerPedId())] and weapons[GetSelectedPedWeapon(PlayerPedId())][type] then
        if not HasPedGotWeaponComponent(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type]) then
            GiveWeaponComponentToPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            DGCore.ShowNotification(string.format('%s %s', "You've equiped your ", type))
        else
            RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetSelectedPedWeapon(PlayerPedId()), weapons[GetSelectedPedWeapon(PlayerPedId())][type])  
            DGCore.ShowNotification(string.format('%s %s', "You've removed your ", type))
        end
    else
        DGCore.ShowNotification(string.format('%s %s %s', 'The ', type, " doesn't fit on your weapon.."))
    end
end)

RegisterNetEvent('RunUseItem')
AddEventHandler('RunUseItem', function(itemid, slot, inventoryName, isWeapon)
    
    if itemid == nil then return end
    local ItemInfo = GetItemInfo(slot)

    if tonumber(ItemInfo.quality) <= 1 then
        TriggerEvent("notification","This item is not useable anymore",2) 
        if isWeapon then TriggerEvent("brokenWeapon") end
        return
    end

    if justUsed then
        retardCounter = retardCounter + 1
        if retardCounter > 10 and retardCounter > lastCounter+5 then
            lastCounter = retardCounter
            TriggerServerEvent("exploiter", "Tried using " .. retardCounter .. " items in < 500ms ")
        end
        return
    end

    if (not hasEnoughOfItem(itemid,1,false)) then
        TriggerEvent("DoLongHudText","You dont appear to have this item on you?",2) 
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    justUsed = true

    if itemid == "-72657034" then
        TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        TriggerEvent("inventory:removeItem",itemid, 1)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if not isValidUseCase(itemid,isWeapon) then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if (itemid == nil) then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if (isWeapon) and not usedxx then
        usedxx = true
        TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        Wait(500)
        usedxx = false
        return
    end

    if (itemid == "silencer_l") then
        TriggerEvent('eden_accesories:use', 'suppressor')
    end

    -- if (itemid == "silencer_l2") then
    --     TriggerEvent('eden_accesories:use', 'suppressor')
    -- end

    -- if (itemid == "silencer_s") then
    --     TriggerEvent('eden_accesories:use', 'suppressor')
    -- end

    -- if (itemid == "silencer_s2") then
    --     TriggerEvent('eden_accesories:use', 'suppressor')
    -- end

    if (itemid == "TinyScope") then
        TriggerEvent('eden_accesories:use', 'scope')
    end

    if (itemid == "flash") then
        TriggerEvent('eden_accesories:use', 'flashlight')
    end

    TriggerEvent("hud-display-item",itemid,"Used")
    Wait(800)

    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)

    local remove = false

    -- Food

    if (itemid == "hamburger") then TriggerEvent('food:burger') end
    if (itemid == "sandwich") then TriggerEvent('food:sandwich') end
    if (itemid == "donut") then TriggerEvent('food:donut') end
    if (itemid == "chocobar") then TriggerEvent('food:chocobar') end
    if (itemid == "pizza") then TriggerEvent('food:pizza') end
    if (itemid == "pancakes") then TriggerEvent('food:pancakes') end
    if (itemid == "maccheese") then TriggerEvent('food:maccheese') end
    if (itemid == "spaghetti") then TriggerEvent('food:spaghetti') end
    if (itemid == "cookie") then TriggerEvent('food:cookie') end
    if (itemid == "energybar") then TriggerEvent('food:energybar') end
    if (itemid == "ciggy") then TriggerEvent('smoke:ciggy')  end


    -- Tool Shop Stuff
    
    if (itemid == "oxygentank") then TriggerEvent('tool:otank') end
    if (itemid == "bulletproof") then TriggerEvent('tool:armour') end
    if (itemid == "pdarmour") then TriggerEvent('tool:armour2') end
    if (itemid == "parachute") then TriggerEvent('tool:parachute') end
    -- if (itemid == "binoculars") then TriggerEvent('tool:binoculars')  end
    if (itemid == "boltcutter") then TriggerEvent('tool:boltcutter') end
    if (itemid == "boombox") then TriggerEvent('tool:boombox') end
    -- if (itemid == "radio") then TriggerEvent('ls-radio:use') end
    if (itemid == "cuff_keys") then TriggerEvent('tool:cuff_keys') end
    if (itemid == "cuffs") then TriggerEvent('tool:cuffs', 'cuffs') end
    if (itemid == "handcuffs") then TriggerEvent('tool:cuffs', 'handcuffs') end
    if (itemid == "radio") then 
        TriggerEvent('radioGui')
        -- TriggerEvent('ls-radio:use') 
    end
 
    -- Macdonalds item
    if (itemid == "salad") then
        TriggerEvent("inventory:removeItem",'salad', 1)
        TriggerEvent('food:salad')
    end
    if (itemid == "mcmshake") then
        TriggerEvent("inventory:removeItem",'mcmshake', 1)
        TriggerEvent('drink:mccafe')
    end
    if (itemid == "alootikki") then
        TriggerEvent("inventory:removeItem",'alootikki', 1)
        TriggerEvent('food:mcaloo')
    end
    if (itemid == "mcveggie") then
        TriggerEvent("inventory:removeItem",'mcveggie', 1)
        TriggerEvent('food:mcveggie')
    end
    if (itemid == "mcchicken") then
        TriggerEvent("inventory:removeItem",'mcchicken', 1)
        TriggerEvent('food:mcchicken')
    end
    if (itemid == "mcmaharaja") then
        TriggerEvent("inventory:removeItem",'mcmaharaja', 1)
        TriggerEvent('food:mcmaharaja')
    end
    if (itemid == "mcfries") then
        TriggerEvent("inventory:removeItem",'mcfries', 1)
        TriggerEvent('food:fries')
    end

    -- Burgershot Items
    if (itemid == "cafe") then
        TriggerEvent("inventory:removeItem",'cafe', 1)
        TriggerEvent('drink:mccafe')
    end
    
    if (itemid == "meatfree") then
        TriggerEvent("inventory:removeItem",'meatfree', 1)
        TriggerEvent('food:mcveggie')
    end
    if (itemid == "cbfowl") then
        TriggerEvent("inventory:removeItem",'cbfowl', 1)
        TriggerEvent('food:mcchicken')
    end
    if (itemid == "heartstopper") then
        TriggerEvent("inventory:removeItem",'heartstopper', 1)
        TriggerEvent('food:mcmaharaja')
    end
    if (itemid == "fries") then
        TriggerEvent("inventory:removeItem",'fries', 1)
        TriggerEvent('food:fries')
    end

    -- Drinks

    if (itemid == "water") then TriggerEvent('drink:water') end
    --if (itemid == "coffee") then TriggerEvent('drink:coffee') end
    if (itemid == "sprunk") then TriggerEvent('drink:sprunk') end
    if (itemid == "cola") then TriggerEvent('drink:cola') end
    if (itemid == "vodka") then TriggerEvent('drink:vodka') end
    if (itemid == "beer") then TriggerEvent('drink:beer') end
    if (itemid == "wine") then TriggerEvent('drink:wine') end
    if (itemid == "whisky") then TriggerEvent('drink:whisky') end
    if (itemid == "tequila") then TriggerEvent('drink:tequila') end

    -- Weed Plant

    if (itemid == "purifiedwater" ) then
        if hasEnoughOfItem("purifiedwater",1,false) then
            TriggerServerEvent("dg-weedplants:purifiedwater")
        end
    end

    if (itemid == "highgradefert" ) then
        if hasEnoughOfItem("highgradefert",1,false) then
            TriggerServerEvent("dg-weedplants:highgradefert")
        end
    end

    if (itemid == "lowgradefert" ) then
        if hasEnoughOfItem("lowgradefert",1,false) then
            TriggerServerEvent("dg-weedplants:lowgradefert")
        end
    end

    if (itemid == "highgrademaleseed" ) then
        if (hasEnoughOfItem("highgrademaleseed",1,false) and hasEnoughOfItem('plantpot',1,false)) then
            TriggerServerEvent("dg-weedplants:highgrademaleseed")
        end
    end

    if (itemid == "highgradefemaleseed" ) then
        if (hasEnoughOfItem("highgradefemaleseed",1,false) and hasEnoughOfItem('plantpot',1,false)) then
            TriggerServerEvent("dg-weedplants:highgradefemaleseed")
        end
    end

    if (itemid == "lowgrademaleseed" ) then
        if (hasEnoughOfItem("lowgrademaleseed",1,false) and hasEnoughOfItem('plantpot',1,false)) then
            TriggerServerEvent("dg-weedplants:lowgrademaleseed")
        end
    end

    if (itemid == "lowgradefemaleseed" ) then
        if (hasEnoughOfItem("lowgradefemaleseed",1,false) and hasEnoughOfItem('plantpot',1,false)) then
            TriggerServerEvent("dg-weedplants:lowgradefemaleseed")
        end
    end

    -- Smoke items

    if (itemid == "joint") then TriggerEvent('smoke:joint',itemid) end
    if (itemid == "bjoint") then TriggerEvent('smoke:joint',itemid) end
    if (itemid == "yjoint") then TriggerEvent('smoke:joint',itemid) end
    if (itemid == "rjoint") then TriggerEvent('smoke:joint',itemid) end
    if (itemid == "pjoint") then TriggerEvent('smoke:joint',itemid) end
    if (itemid == "blunt") then TriggerEvent('smoke:blunt',itemid) end
    if (itemid == "cocaine") then TriggerEvent('smoke:cocaine') end
    if (itemid == "1gcrack") then  TriggerEvent('smoke:crack') end
    if (itemid == "meth") then  TriggerEvent('smoke:meth') end
    if (itemid == "oxy") then  TriggerEvent('medic:oxy') end

    -- Mechanic

    if (itemid == "enginekit") then TriggerEvent('tool:enginekit') end
    if (itemid == "bodykit") then TriggerEvent('tool:bodykit') end
    if (itemid == "tirekit") then TriggerEvent('tool:tirekit') end
    if (itemid == "windowkit") then TriggerEvent('tool:windowkit') end
    if (itemid == "advrepairkit") then TriggerEvent('tool:advrepairkit') end
    if (itemid == "repairkit") then TriggerEvent('tool:repairkit') end

    -- Ambulance job

    if (itemid == "bandage") then TriggerEvent('medic:bandage') end
    if (itemid == "medkit") then TriggerEvent('medic:medkit') end
    if (itemid == "ifak") then TriggerEvent('medic:ifak') end
    if (itemid == "gauze") then TriggerEvent('medic:gauze') end
    if (itemid == "firstaidkit") then TriggerEvent('medic:firstaidkit') end
    if (itemid == "vicodin") then TriggerEvent('medic:vicodin') end
    if (itemid == "hydrocodone") then TriggerEvent('medic:hydrocodone') end
    if (itemid == "adrenaline") then TriggerEvent('medic:adrenaline') end
    if (itemid == "aspirin") then TriggerEvent('medic:aspirin') end

    -- Reload Stuff
    
    -- if (itemid == "pistolammo") then TriggerEvent('ammo:pistol') end
    -- if (itemid == "subammo") then TriggerEvent('ammo:smg') end
    -- if (itemid == "rifleammo") then TriggerEvent('ammo:rifle') end
    -- if (itemid == "shotgunammo") then TriggerEvent('ammo:shotgun') end

    if (itemid == "heavyammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1788949567,50,true)
            remove = true
        end
    end

    if (itemid == "pistolammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1950175060,50,true)
            remove = true
        end
    end

    if (itemid == "rifleammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",218444191,50,true)
            remove = true
        end
    end

    if (itemid == "shotgunammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",-1878508229,50,true)
            remove = true
        end
    end

    if (itemid == "subammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1820140472,50,true)
            remove = true
        end
    end

    if (itemid == "sniperammo") then
        TaskReloadWeapon(player)
        local finished = exports["dg-taskbar"]:taskBar(3000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1285032059,5,true)
            remove = true
        end
    end

    -- Fishing

    if (itemid == "fishingrod") then TriggerEvent("dg-fish:lego") end

    -- robbery stuff
    
    if (itemid == "locksystem") then TriggerEvent("rob:store") end
    if (itemid == "vpnxj") then TriggerEvent("rob:storeatm") end
    if (itemid == "usbdevice") then TriggerEvent("rob:atm") end

    if (itemid == "thermite") then TriggerEvent("rob:bank") end
    if (itemid == "securityblue") then TriggerEvent("open:fleecadoor", itemid) end
    if (itemid == "securitygreen") then TriggerEvent("open:fleecadoor", itemid) end
    if (itemid == "securityred") then TriggerEvent("open:fleecadoor", itemid) end
    
    if (itemid == "Gruppe6Card3") then TriggerEvent("rob:vangelico") end
    -- Mechanic Stuff

    if (itemid == "carhood") then 
        for k,v in pairs(BodyParts) do 
            if v.item == itemid then
                TriggerEvent('dg-mechanicjob:installBodyPartCL',  k, v)
            end
        end
    end

    if (itemid == "car_trunk") then 
        for k,v in pairs(BodyParts) do 
            if v.item == itemid then
                TriggerEvent('dg-mechanicjob:installBodyPartCL',  k, v)
            end
        end
    end

    if (itemid == "tire") then 
        for k,v in pairs(BodyParts) do 
            if v.item == itemid then
                TriggerEvent('dg-mechanicjob:installBodyPartCL', k, v)
            end
        end
    end

    if (itemid == "car_door") then 
        for k,v in pairs(BodyParts) do 
            if v.item == itemid then
                TriggerEvent('dg-mechanicjob:installBodyPartCL',  k, v)
            end
        end
    end

    if (itemid == "lockpick") then
        local myJob = exports["isPed"]:isPed("myJob")
        TriggerEvent("inv:lockPick",false,inventoryName,slot)
    end


    if (itemid == "advlockpick") then 
        TriggerEvent('houseRobberies:attempt')
    end
    
    if (itemid == "radio") then 
        TriggerEvent('ls-radio:use')
    end

    if (itemid == "chopradio") then 
        TriggerServerEvent('dg-chop:usedRadio')
    end

    if (itemid == "burnerphone") then 
        TriggerEvent('dg_drugs:burnerUsed')
    end

    ---old id card system
    -- if (itemid == "idcard") then 
    --     local ItemInfo = GetItemInfo(slot)
    --     TriggerServerEvent("showid",ItemInfo.information)   
    -- end

    ---new idcard system
    local player, distance = DGCore.Game.GetClosestPlayer()
    if (itemid == "idcard") then 
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
        if distance ~= -1 and distance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
        else
            DGCore.ShowNotification('No players nearby')
        end
    end

    local player, distance = DGCore.Game.GetClosestPlayer()
    if (itemid == "lcard") then 
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
        if distance ~= -1 and distance <= 3.0 then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
        else
            DGCore.ShowNotification('No players nearby')
        end
    end

    -- if (itemid == "idcard") then 
    --     local ItemInfo = GetItemInfo(slot)
    --     TriggerEvent("idcard:show",ItemInfo.information)
    -- end

-- RegisterNetEvent('idcard:show')
-- AddEventHandler('idcard:show', function(data)
--     t, distance = GetClosestPlayer()
--     if(distance ~= -1 and distance < 5) then
--         TriggerServerEvent("police:showID", GetPlayerServerId(t), data)
--     else
--         TriggerEvent("DoLongHudText", "No player nearby!",2)
--     end
-- end)

    -- Drug items

    if (itemid == "cannabis") then TriggerEvent("drug:cannabis") end
    if (itemid == "trimmedweed") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "weedoz") then TriggerEvent("drug:weedoz", itemid) end
    if (itemid == "pkhush") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "bkhush") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "ykhush") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "rkhush") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "khush") then TriggerEvent("drug:blunt", itemid) end
    if (itemid == "cpowder") then  TriggerEvent('drug:cpowder') end
    
    if remove == true then
        TriggerEvent("inventory:removeItem",itemid, 1)
    end

    Wait(1000)
    retardCounter = 0
    justUsed = false

end)

function AttachPropAndPlayAnimation(dictionary,animation,typeAnim,timer,message,func,remove,itemid,vehicle)
    if itemid == "fishtaco" or itemid == "taco" then
        TriggerEvent("attachItem", "taco")
    elseif itemid == "greencow" then
        TriggerEvent("attachItem", "energydrink")
    elseif itemid == "slushy" then
        TriggerEvent("attachItem", "cup")
    end
    TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid,vehicle)
end

RegisterNetEvent('randPickupAnim')
AddEventHandler('randPickupAnim', function()
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)



local clientInventory = {};
RegisterNetEvent('current-items')
AddEventHandler('current-items', function(inv)
    clientInventory = inv
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait (5000)
     
        TriggerEvent('nui-myinventory')
    end
end)

RegisterNetEvent('SniffRequestCID')
AddEventHandler('SniffRequestCID', function(src)
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("SniffCID",cid,src)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local cuntfuck = #(GetEntityCoords(PlayerPedId()) - vector3(256.2986, -369.2406,-44.13768))
		if cuntfuck < 2.5 then
				DrawText3Ds(256.2986, -369.2406,-44.13768, "[E] to buy a ID Card ($500)") 			
                if IsControlJustReleased(0,38) then
                    TriggerServerEvent("spawn100k")
                    TriggerEvent("player:receiveItem","idcard",1)
                end
            end
         end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(1)
--         local cuntfuck = #(GetEntityCoords(PlayerPedId()) - vector3(953.29, -977.82,39.49))
-- 		if cuntfuck < 2.5 then
-- 				DrawText3Ds(953.29, -977.82,39.49, "[E] to open Mechanic Crafting") 			
--                 if IsControlJustPressed(1, 38) and exports["isPed"]:GroupRank("tuner_carshop") > 3 then
--                     TriggerEvent("server-inventory-open", "27", "Craft");

--                 end
--             end
--          end
-- end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,15.72802066803,-1598.2983398438,29.377981185913,false)
        if distance <= 1.2 then
            DrawText3Ds(15.72802066803,-1598.2983398438,29.377981185913, "Open pockets to cook here")
        end
        Citizen.Wait(5)
    end
end)

-- Citizen.CreateThread(function()
--     Citizen.Wait(1000)
--     while true do
--     local ped = GetPlayerPed(-1)
--     local pos = GetEntityCoords(ped)
--     local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,11.69,-1599.69,29.38,false)
--         if distance <= 1.2 then
--             DrawText3Ds(11.69,-1599.69,29.38, "Open pockets to cook here")
--         end
--         Citizen.Wait(5)
--     end
-- end)


function GetItemInfo(checkslot)
    for i,v in pairs(clientInventory) do
        if (tonumber(v.slot) == tonumber(checkslot)) then
            local info = {["information"] = v.information, ["id"] = v.id, ["quality"] = v.quality }
            return info
        end
    end
    return "No information stored";
 end

-- item id, amount allowed, crafting.

function CreateCraftOption(id, add, craft)
    TriggerEvent("CreateCraftOption", id, add, craft)
end

-- Animations

function loadAnimDict( dict )
    while(not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function TaskItem(dictionary,animation,typeAnim,timer,message,func,remove,itemid,playerVeh)
    loadAnimDict( dictionary ) 
    TaskPlayAnim( PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0 )
    local timer = tonumber(timer)
    if timer > 0 then
        local finished = exports["dg-taskbar"]:taskBar(timer,message,true,false,playerVeh)
        if finished == 100 or timer == 0 then
            TriggerEvent(func)
            ClearPedTasks(PlayerPedId())
            TriggerEvent("destroyProp")
        end
    else
        TriggerEvent(func)
    end

    if remove then
        TriggerEvent("inventory:removeItem",itemid, 1)
    end
end

RegisterNetEvent('inv:remove')
AddEventHandler('inv:remove', function(itemid,quantity)
    TriggerEvent("inventory:removeItem",itemid, quantity)
end)

RegisterNetEvent('inv:add')
AddEventHandler('inv:add', function(itemid,quantity)
    TriggerEvent('player:receiveItem', itemid, quantity)
end)

function GetCurrentWeapons()
    local returnTable = {}
    for i,v in pairs(clientInventory) do
        if (tonumber(v.item_id)) then
            local t = { ["hash"] = v.item_id, ["id"] = v.id, ["information"] = v.information, ["name"] = v.item_id, ["slot"] = v.slot }
            returnTable[#returnTable+1]=t
        end
    end   
    if returnTable == nil then 
        return {}
    end
    return returnTable
end

function getQuantity(itemid)
    local amount = 0
    for i,v in pairs(clientInventory) do
        if (v.item_id == itemid) then
            amount = amount + v.amount
        end
    end
    return amount
end

function hasEnoughOfItem(itemid,amount)
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then 
        return false 
    end
    amount = tonumber(amount)
    if getQuantity(itemid) >= amount then
        return true
    end 
    return false
end


function isValidUseCase(itemID,isWeapon)
    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)
    if playerVeh ~= 0 then
        local model = GetEntityModel(playerVeh)
        if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
            if IsEntityInAir(playerVeh) then
                Wait(1000)
                if IsEntityInAir(playerVeh) then
                    TriggerEvent("notification","You appear to be flying through the air",2) 
                    return false
                end
            end
        end
    end

    if not validWaterItem[itemID] and not isWeapon then
        if IsPedSwimming(player) then
            local targetCoords = GetEntityCoords(player, 0)
            Wait(700)
            local plyCoords = GetEntityCoords(player, 0)
            if #(targetCoords - plyCoords) > 1.3 then
                TriggerEvent("notification","Cannot be moving while swimming to use this.",2) 
                return false
            end
        end

        if IsPedSwimmingUnderWater(player) then
            TriggerEvent("notification","Cannot be underwater to use this.",2) 
            return false
        end
    end

    return true
end


RegisterNetEvent('evidence:addDnaSwab')
AddEventHandler('evidence:addDnaSwab', function(dna)
    TriggerEvent("notification", "DNA Result: " .. dna,1)    
end)

RegisterNetEvent('CheckDNA')
AddEventHandler('CheckDNA', function()
    TriggerServerEvent("Evidence:checkDna")
end)

RegisterNetEvent('evidence:dnaSwab')
AddEventHandler('evidence:dnaSwab', function()
    t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
        TriggerServerEvent("police:dnaAsk", GetPlayerServerId(t))
    end
end)

RegisterNetEvent('evidence:swabNotify')
AddEventHandler('evidence:swabNotify', function()
    TriggerEvent("notification", "DNA swab taken.",1)
end)


function GetPlayers()
    local players = {}
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end
    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

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

local burgies = 0
RegisterNetEvent('inv:wellfed')
AddEventHandler('inv:wellfed', function()
    burgies = 0
end)

RegisterNetEvent('animation:lockpickinvtestoutside')
AddEventHandler('animation:lockpickinvtestoutside', function()
    local lPed = PlayerPedId()
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    while lockpicking do        
        TaskPlayAnim(lPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
        Citizen.Wait(2500)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('animation:lockpickinvtest')
AddEventHandler('animation:lockpickinvtest', function(disable)
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    if disable ~= nil then
        if not disable then
            lockpicking = false
            return
        else
            lockpicking = true
        end
    end
    while lockpicking do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

-- Animations
RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        BlockWeaponWheelThisFrame()
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        HideHudComponentThisFrame(17)
        DisableControlAction(0, 37, true) 
    end
end)

RegisterNetEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(bool, isFrisk)
    local _bool = bool

    if _bool == nil or _bool == false then 
        _bool = false 
    else 
        _bool = true
    end
	if isFrisk == nil then isFrisk = false end
	t, distance, closestPed = GetClosestPlayer()
	if(distance ~= -1 and distance < 5) then
		TriggerServerEvent("server-inventory-openPlayer", GetPlayerServerId(t), isFrisk, _bool)
	else
		TriggerEvent("notification", "No player near you!",2)
	end
end)


RegisterCommand("takecash", function(source, args)
    local player = DGCore.GetPlayerData()
    local closestPlayer, closestDistance = DGCore.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 and DGCore.PlayerData.job.name == 'police' then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        TriggerServerEvent("police:SeizeCash",  GetPlayerServerId(closestPlayer))
    else
        TriggerEvent("notification", "Job Required: Police")
        print("Your job is: " ..DGCore.PlayerData.job.name)
    end
end)

RegisterNetEvent('searching-person')
AddEventHandler('searching-person', function(target)
    TriggerEvent("server-inventory-open", "1", target)
end)


function DrawText3D(x,y,z, text)
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

RegisterNetEvent('check2:alive')
AddEventHandler('check2:alive', function(status)
    if status then
        dead = true
    else
        dead  = false
    end
end)