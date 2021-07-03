DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

Freeze = {F1 = 0, F2 = 0, F3 = 0, F4 = 0, F5 = 0, F6 = 0}
Check = {F1 = false, F2 = false, F3 = false, F4 = false, F5 = false, F6 = false}
LootCheck = {
    F1 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F2 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F3 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F4 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F5 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F6 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false}
}

local disableinput = false
local initiator = false
local startdstcheck = false
local currentname = nil
local currentcoords = nil
local done = true
local cardused = false
local COPREQUIRED = 0

Citizen.CreateThread(function() 
    while true do 
        local enabled = false 
        Citizen.Wait(1) 
        if disableinput then 
            enabled = true 
            DisableControl() 
        end 
        if not enabled then 
            Citizen.Wait(500) 
        end 
    end 
end)

function DrawText3D(x, y, z, text) 
    local onScreen, _x, _y = World3dToScreen2d(x, y, z) 
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) 
    SetTextScale(0.35, 0.35) 
    SetTextFont(4) 
    SetTextProportional(1) 
    SetTextEntry("STRING") 
    SetTextCentre(true) 
    SetTextColour(255, 255, 255, 215) 
    AddTextComponentString(text) 
    DrawText(_x, _y) 
    local factor = (string.len(text)) / 700 
    DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) 
end

function DisableControl() 
    DisableControlAction(0, 73, false) 
    DisableControlAction(0, 24, true) 
    DisableControlAction(0, 257, true) 
    DisableControlAction(0, 25, true) 
    DisableControlAction(0, 263, true) 
    DisableControlAction(0, 32, true) 
    DisableControlAction(0, 34, true) 
    DisableControlAction(0, 31, true) 
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 22, true) 
    DisableControlAction(0, 44, true) 
    DisableControlAction(0, 37, true) 
    DisableControlAction(0, 23, true) 
    DisableControlAction(0, 288, true) 
    DisableControlAction(0, 289, true) 
    DisableControlAction(0, 170, true) 
    DisableControlAction(0, 167, true) 
    DisableControlAction(0, 73, true) 
    DisableControlAction(2, 199, true) 
    DisableControlAction(0, 47, true) 
    DisableControlAction(0, 264, true) 
    DisableControlAction(0, 257, true) 
    DisableControlAction(0, 140, true) 
    DisableControlAction(0, 141, true) 
    DisableControlAction(0, 142, true) 
    DisableControlAction(0, 143, true) 
end

function ShowTimer() 
    SetTextFont(0) 
    SetTextProportional(0) 
    SetTextScale(0.42, 0.42) 
    SetTextDropShadow(0, 0, 0, 0,255) 
    SetTextEdge(1, 0, 0, 0, 255) 
    SetTextEntry("STRING") 
    AddTextComponentString("~r~"..fleeca.timer.."~w~") 
    DrawText(0.682, 0.96) 
end

RegisterNetEvent("dg_fleeca:openDoor_c")
AddEventHandler("dg_fleeca:openDoor_c", function(coords, method,type)
    if method == 1 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(fleeca.vaultdoor), false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 2 then
        local obj = GetClosestObjectOfType(fleeca.Banks.F4.doors.startloc.x, fleeca.Banks.F4.doors.startloc.y, fleeca.Banks.F4.doors.startloc.z, 2.0, fleeca.Banks.F4.hash, false, false, false)
        local count = 0
        repeat
            local heading = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 3 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(fleeca.door), false, false, false)

        FreezeEntityPosition(obj, false)
    elseif method == 4 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(fleeca.vaultdoor), false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) + 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 5 then
        local obj = GetClosestObjectOfType(fleeca.Banks.F4.doors.startloc.x, fleeca.Banks.F4.doors.startloc.y, fleeca.Banks.F4.doors.startloc.z, 2.0, fleeca.Banks.F4.hash, false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) + 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    end
end)

RegisterNetEvent("dg_fleeca:resetDoorState")
AddEventHandler("dg_fleeca:resetDoorState", function(name)
    Freeze[name] = 0
end)

RegisterNetEvent("dg_fleeca:lootup_c")
AddEventHandler("dg_fleeca:lootup_c", function(var, var2)
    LootCheck[var][var2] = true
end)

RegisterNetEvent("dg_fleeca:outcome")
AddEventHandler("dg_fleeca:outcome", function(oc, arg)
    for i = 1, #Check, 1 do
        Check[i] = false
    end
    for i = 1, #LootCheck, 1 do
        for j = 1, #LootCheck[i] do
            LootCheck[i][j] = false
        end
    end
    if oc then
        Check[arg] = true
        TriggerEvent("dg_fleeca:startheist", fleeca.Banks[arg], arg)
    elseif not oc then
        TriggerEvent("DoLongHudText", arg, 2)
    end
end)

RegisterNetEvent("dg_fleeca:startLoot_c")
AddEventHandler("dg_fleeca:startLoot_c", function(data, name)
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    if not LootCheck[name].Stop then
        Citizen.CreateThread(function()
            while true do
                local pedcoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)
                
               if not LootCheck[name].Loot1 then
                    local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley1.x, data.trolley1.y, data.trolley1.z+1, true)
                    if dst1 < 2 and cardused then
                        DrawText3D(data.trolley1.x, data.trolley1.y, data.trolley1.z+1, "[E] - Loot")
                        if dst1 < 1 and IsControlJustReleased(0, 38) then
                            TriggerServerEvent("dg_fleeca:lootup", name, "Loot1")
                            StartGrab(name)
                        end
                    end
                end

                if not LootCheck[name].Loot2 then
                    local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley2.x, data.trolley2.y, data.trolley2.z+1, true)
                    if dst1 < 2 and cardused then
                        DrawText3D(data.trolley2.x, data.trolley2.y, data.trolley2.z+1, "[E] - Loot")
                        if dst1 < 1 and IsControlJustReleased(0, 38) then
                            TriggerServerEvent("dg_fleeca:lootup", name, "Loot2")
                            StartGrab(name)
                        end
                    end
                end

                if LootCheck[name].Stop or (LootCheck[name].Loot1 and LootCheck[name].Loot2) then
                    LootCheck[name].Stop = false
                    if initiator then
                        cardused = false
                        TriggerEvent("dg_fleeca:reset", name, data)
                        return
                    end
                    return
                end
                Citizen.Wait(1)
            end
        end)
    end
end)

RegisterNetEvent("dg_fleeca:stopHeist_c")
AddEventHandler("dg_fleeca:stopHeist_c", function(name)
    LootCheck[name].Stop = true
    Check[name] = false
    cardused = false
end)


AddEventHandler("dg_fleeca:freezeDoors", function()
    Citizen.CreateThread(function()
        while true do
            local pedcoords = GetEntityCoords(PlayerPedId())

            for k, v in pairs(fleeca.Banks) do
                if Freeze[k] < 3 then
                    local dst = GetDistanceBetweenCoords(pedcoords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)

                    if dst < 10 then
                        local obj = DGCore.Game.GetClosestObject(fleeca.door, vector3(v.doors.secondloc.x, v.doors.secondloc.y, v.doors.secondloc.z))

                        FreezeEntityPosition(obj, true)
                        Freeze[k] = Freeze[k] + 1
                    end
                end
            end
            if Freeze.F1 > 3 and Freeze.F2 > 3 and Freeze.F3 > 3 and Freeze.F4 > 3 and Freeze.F5 > 3 and Freeze.F6 > 3 then
                Citizen.Wait(5000)
            end
            Citizen.Wait(500)
        end
    end)
end)

AddEventHandler("dg_fleeca:reset", function(name, data)
    for i = 1, #LootCheck[name], 1 do
        LootCheck[name][i] = false
    end
    Check[name] = false
    TriggerEvent('DoLongHudText', 'VAULT DOOR WILL CLOSE IN 30 SECONDS!', 2)
    Citizen.Wait(30000)
    TriggerEvent('DoLongHudText', 'VAULT DOOR CLOSING', 2)
    if data.hash == nil then
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 4)
    elseif not data.hash == nil then
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 5)
    end
    TriggerEvent("dg_fleeca:cleanUp", data, name)
end)

AddEventHandler("dg_fleeca:startheist", function(data, name, type)
    disableinput = true
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    initiator = true
    RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()

    SetEntityCoords(ped, data.doors.startloc.animcoords.x, data.doors.startloc.animcoords.y, data.doors.startloc.animcoords.z)
    SetEntityHeading(ped, data.doors.startloc.animcoords.h)
    local pedco = GetEntityCoords(PlayerPedId())
    IdProp = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, 1, 1, 0)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)

    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    if data.hash == nil then
    TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 1)
    elseif data.hash ~= nil then
        TriggerServerEvent("dg_fleeca:openDoor", "anana", 2)
    end
    startdstcheck = true
    disableinput = false
    currentname = name
    TriggerEvent('DoLongHudText', 'You have 2 minutes until the security system activation.', 1)
    SpawnTrolleys(data, name, type)
end)

AddEventHandler("dg_fleeca:cleanUp", function(data, name)
    Citizen.Wait(60000)
    for i = 1, 3, 1 do -- full trolley clean
        local obj = GetClosestObjectOfType(data.objects[i].x, data.objects[i].y, data.objects[i].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    for j = 1, 3, 1 do -- empty trolley clean
        local obj = GetClosestObjectOfType(data.objects[j].x, data.objects[j].y, data.objects[j].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_03"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    if DoesEntityExist(IdProp) then
        DeleteEntity(IdProp)
    end
    if DoesEntityExist(IdProp2) then
        DeleteEntity(IdProp2)
    end
    initiator = false
end)

function SecondDoor(data,type,bankname)

    cardused = type
    RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()

    SetEntityCoords(ped, data.doors.secondloc.animcoords.x, data.doors.secondloc.animcoords.y, data.doors.secondloc.animcoords.z)
    SetEntityHeading(ped, data.doors.secondloc.animcoords.h)
    local pedco = GetEntityCoords(PlayerPedId())
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_ATM", 0, true)
    Citizen.Wait(1000)
    IdProp2 = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, 1, 1, 0)
    SetEntityCoords(IdProp2, data.prop.second.coords, 0.0, 0.0, 0.0, false)
    SetEntityRotation(IdProp2, data.prop.second.rot, 1, true)
    FreezeEntityPosition(IdProp2, true)
    ClearPedTasksImmediately(ped)

    if bankname == 'F1' or bankname == 'F2' then
        exports["dg-taskbar"]:taskBar(2*60*1000, "Hack Initiated")
        exports["dg-taskbar"]:taskBar(2000, "Hack Sucessful")
        TriggerEvent('DoLongHudText', 'Door Opened!', 1)
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.secondloc.x, data.doors.secondloc.y, data.doors.secondloc.z), 3, type)
        -- TriggerEvent('dg-dispatch:fleecarobbery')
        disableinput = false
    elseif bankname == 'F5' then
        exports["dg-taskbar"]:taskBar(3*60*1000, "Hack Initiated")
        exports["dg-taskbar"]:taskBar(2000, "Hack Sucessful")
        TriggerEvent('DoLongHudText', 'Door Opened!', 1)
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.secondloc.x, data.doors.secondloc.y, data.doors.secondloc.z), 3, type)
        -- TriggerEvent('dg-dispatch:fleecarobbery')
        disableinput = false
    elseif bankname == 'F3' then
        exports["dg-taskbar"]:taskBar(4*60*1000, "Hack Initiated")
        exports["dg-taskbar"]:taskBar(2000, "Hack Sucessful")
        TriggerEvent('DoLongHudText', 'Door Opened!', 1)
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.secondloc.x, data.doors.secondloc.y, data.doors.secondloc.z), 3, type)
        -- TriggerEvent('dg-dispatch:fleecarobbery')
        disableinput = false
    else
        exports["dg-taskbar"]:taskBar(5*60*1000, "Hack Initiated")
        exports["dg-taskbar"]:taskBar(2000, "Hack Sucessful")
        TriggerEvent('DoLongHudText', 'Door Opened!', 1)
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        TriggerServerEvent("dg_fleeca:openDoor", vector3(data.doors.secondloc.x, data.doors.secondloc.y, data.doors.secondloc.z), 3, type)
        -- TriggerEvent('dg-dispatch:fleecarobbery')
        disableinput = false
    end

    
end

function SpawnTrolleys(data, name)
    RequestModel("hei_prop_hei_cash_trolly_01")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(1)
    end
    Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley1.x, data.trolley1.y, data.trolley1.z, 1, 1, 0)
    Trolley2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley2.x, data.trolley2.y, data.trolley2.z, 1, 1, 0)
    local h1 = GetEntityHeading(Trolley1)
    local h2 = GetEntityHeading(Trolley2)

    SetEntityHeading(Trolley1, h1 + fleeca.Banks[name].trolley1.h)
    SetEntityHeading(Trolley2, h2 + fleeca.Banks[name].trolley2.h)
    local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    print(tostring(players))
    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            table.insert(missionplayers, GetPlayerServerId(players[i]))
        end
    end
    TriggerServerEvent("dg_fleeca:startLoot", data, name, missionplayers)
    done = false
end

function StartGrab(name)
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)
    local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
                Citizen.Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
				    end
			    end
		    end
		    DeleteObject(grabobj)
            if cardused == 'securityblue' then
                TriggerEvent("player:receiveItem", "cashroll", 30)
                TriggerEvent("player:receiveItem", "bandcash", 15)
            elseif cardused == 'securitygreen' then
                TriggerEvent("player:receiveItem", "cashroll", 40)
                TriggerEvent("player:receiveItem", "bandcash", 20)
            -- else
            --     TriggerEvent("player:receiveItem", "cashroll", 40)
            --     TriggerEvent("player:receiveItem", "bandcash", 20)
            end
	    end)

    end

	local trollyobj = Trolley
    local emptyobj = GetHashKey("hei_prop_hei_cash_trolly_03")

	if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end

    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(scene1)
	Citizen.Wait(1500)
	CashAppear()
	local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)
	Citizen.Wait(37000)
	local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)
    NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
    SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	DeleteObject(trollyobj)
    PlaceObjectOnGroundProperly(NewTrolley)
	Citizen.Wait(1800)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    disableinput = false
end


Citizen.CreateThread(function()
    while DGCore == nil do
        Citizen.Wait(1)
    end
    DGCore.TriggerServerCallback("dg_fleeca:getBanks", function(result)
        fleeca.Banks = result
    end)
    TriggerEvent("dg_fleeca:freezeDoors")
end)

-- Opens Vault door
local spamprotec = false
RegisterNetEvent("rob:bank")
AddEventHandler("rob:bank", function()
    if not spamprotec then 
        spamprotec = true
        local coords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(fleeca.Banks) do
            local dst = GetDistanceBetweenCoords(coords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)
            if dst <= 2 and not Check[k] then
                DGCore.TriggerServerCallback('checkCops', function(copnumber)
                    if copnumber >= COPREQUIRED then
                        DGCore.TriggerServerCallback('checkCooldown', function(checked)
                            if checked then
                                TriggerEvent('inventory:removeItem', 'thermite', 1)
                                TriggerServerEvent('startCooldown',2)
                                FreezeEntityPosition(PlayerPedId(), false)
                                local outcome = exports['dg_thermite']:startGame(25,2,2,500)
                                if outcome then
                                    FreezeEntityPosition(PlayerPedId(), false)
                                    TriggerServerEvent('startCooldown',30)
                                    TriggerServerEvent("dg_fleeca:startcheck", k)
                                    -- TriggerEvent('dg-dispatch:fleecarobbery')
                                    TriggerServerEvent('notifyCops','Fleeca Bank',GetEntityCoords(PlayerPedId()),458,'10-90(A)')
                                else
                                    local ped = PlayerPedId()
                                    local coords = GetEntityCoords(PlayerPedId())
                                    FreezeEntityPosition(PlayerPedId(), true)
                                    exports['dg_thermite']:startFireAtLocation(coords.x, coords.y, coords.z - 1, 10000)
                                end
                            else
                                exports['mythic_notify']:SendAlert('error', 'A bank was robbed recently')
                            end
                        end)
                    else
                        exports['mythic_notify']:SendAlert('error', 'Not enough security')
                    end
                end)
            end
        end
        Citizen.Wait(1000)
        spamprotec = false
    end
end)

-- Opens Inside door

RegisterNetEvent("open:fleecadoor")
AddEventHandler("open:fleecadoor", function(type)
    if not done then
        local pedcoords = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(pedcoords, fleeca.Banks[currentname].doors.secondloc.x, fleeca.Banks[currentname].doors.secondloc.y, fleeca.Banks[currentname].doors.secondloc.z, true)
        if dst < 1 then
            done = true
            TriggerEvent('inventory:removeItem', type, 1)
            return SecondDoor(fleeca.Banks[currentname],type,currentname)
        end
    end
end)

RegisterCommand('closebank', function()
    local coords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(fleeca.Banks) do
        local dst = GetDistanceBetweenCoords(coords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)
        if dst <= 4 then
            TriggerServerEvent("dg_fleeca:stopHeist", k)
        end
    end
end)