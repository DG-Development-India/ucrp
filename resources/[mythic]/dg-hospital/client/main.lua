local hospitalCheckin = { x = 307.03, y = -594.96, z = 43.291839599609, h = 180.4409942627 }
local pillboxTeleports = {
    { x = 325.48892211914, y = -598.75372314453, z = 43.291839599609, h = 64.513374328613, text = 'Press ~INPUT_CONTEXT~ ~s~to go to lower Pillbox Entrance' },
    { x = 355.47183227539, y = -596.26495361328, z = 28.773477554321, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
    { x = 359.57849121094, y = -584.90911865234, z = 28.817169189453, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
}

DGCore = nil

local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local cam = nil
local beingTreated = false
local playerarmour = false

local inBedDict = "missarmenian2"
local inBedAnim = "corpse_search_exit_ped"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local numberofems = 3

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)
    SetEntityInvincible(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), bedOccupyingData.h-90.0)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('dg-hospital:server:LeaveBed', bedOccupying)
    beingTreated = false
    FreezeEntityPosition(bedObject, false)
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end

RegisterNetEvent('dg-hospital:client:RPCheckPos')
AddEventHandler('dg-hospital:client:RPCheckPos', function()
    TriggerServerEvent('dg-hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('dg-hospital:client:RPSendToBed')
AddEventHandler('dg-hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h)
    --SetEntityInvincible(PlayerPedId(), false)
    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)

            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('dg-hospital:client:SendToBed')
AddEventHandler('dg-hospital:client:SendToBed', function(id, data)
    beingTreated = true
    bedOccupying = id
    bedOccupyingData = data
    TriggerEvent("ndrp_base:isDead", true)
    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h)
    SetEntityInvincible(PlayerPedId(), true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local finished = exports["dg-taskbar"]:taskBar(Config.AIHealTimer * 1000, "You are being treated")
        if (finished == 100) then
            if playerarmour then
                SetPedArmour(PlayerPedId(), playerarmour)
                playerarmour = false
            end
            TriggerServerEvent('dg-hospital:server:EnteredBed')
        end
    end)
end)

RegisterNetEvent('dg-hospital:client:FinishServices')
AddEventHandler('dg-hospital:client:FinishServices', function()
	local player = PlayerPedId()
	if IsPedDeadOrDying(player) then
		local playerPos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
    end
    
    TriggerEvent('dg_ambulancejob:heal', 'big', true)
	SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    TriggerEvent('dg-hospital:client:RemoveBleed')
    TriggerEvent('dg-hospital:client:ResetLimbs')
    TriggerEvent('dg_ambulancejob:revive')
	SetEntityHealth(player, 200)
    exports['mythic_notify']:SendAlert('inform', 'You\'ve been treated and billed.')
    TriggerEvent("dg_base:isDead", false)
    LeaveBed()
end)

RegisterNetEvent('dg-hospital:client:ForceLeaveBed')
AddEventHandler('dg-hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

local pressede = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
        if distance < 10 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 then
                    DrawText3Ds(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.2, '[~g~E~s~] Check in')
                    if IsControlJustReleased(0, 54) and pressede then
						if (GetEntityHealth(PlayerPedId()) < 200) or (IsInjuredOrBleeding()) then
							pressede = false
							TriggerServerEvent('dg-hospital:checkems')
							Citizen.Wait(500)
							print(numberofems)
                            if numberofems < 3 then
                                playerarmour = GetPedArmour(PlayerPedId())
								exports['mythic_progbar']:Progress({
									name = "hospital_action",
									duration = 2000,
									label = "Checking In",
									useWhileDead = true,
									canCancel = true,
									controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
									},
									animation = {
										animDict = "missheistdockssetup1clipboard@base",
										anim = "base",
										flags = 49,
									}
								}, function(status)
									if not status then
										TriggerServerEvent('dg-hospital:server:RequestBed')
										Citizen.Wait(2000)
										pressede = true
									end
								end)
							else
								exports['mythic_notify']:SendAlert('error', 'Local doctors are not available. Call the EMS')
								Citizen.Wait(2000)
								pressede = true
							end
						else
							exports['mythic_notify']:SendAlert('error', 'You do not need any medical attention.')
							Citizen.Wait(2000)
							pressede = true
						end
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

local analyzedData = {}

RegisterCommand('checkup', function()
    if exports["isPed"]:isPed("myjob") == 'ambulance' then
        local closestPlayer, closestDistance = DGCore.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            TriggerEvent('ndrp_emotes:playthisemote','clipboard')
            local finished = exports["dg-taskbar"]:taskBar(2000, "Analyzing Patient's Injuries")
            if (finished == 100) then
                TriggerServerEvent('dg-hospital:getInjuries',GetPlayerServerId(closestPlayer))
                TriggerEvent('ndrp_emotes:playthisemote','c')
            end
        else
            exports['mythic_notify']:SendAlert('error', 'No patient nearby')
        end
    end
end)

RegisterCommand('treat', function(source , args)
    if exports['dg-inventory']:hasEnoughOfItem('MedicalBag', 1) then
        if exports["isPed"]:isPed("myjob") == 'ambulance' then
            if #analyzedData ~= 0 then
                if args[1] ~= nil then 
                    local number = tonumber(args[1])
                    if number ~= nil then
                        local closestPlayer, closestDistance = DGCore.Game.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            if #analyzedData > 1 then
                                TriggerEvent('ndrp_emotes:playthisemote','medic')
                                local finished = exports["dg-taskbar"]:taskBar(10000, "Patching up the wounds")
                                if (finished == 100) then
                                    TriggerServerEvent('dg-hospital:healInjuries',number,GetPlayerServerId(closestPlayer))
                                    TriggerEvent('ndrp_emotes:playthisemote','c')
                                    exports['mythic_notify']:SendAlert('success', 'The wound is patched.')
                                    TriggerServerEvent("dg_base:addmoney", math.random(10,40), "Treatment for "..closestPlayer)
                                    table.remove(analyzedData, #analyzedData)
                                end
                            else
                                TriggerEvent('ndrp_emotes:playthisemote','medic')
                                local finished = exports["dg-taskbar"]:taskBar(10000, "Patching up the wounds")
                                if (finished == 100) then
                                    TriggerServerEvent('dg-hospital:healInjuries',number,GetPlayerServerId(closestPlayer))
                                    TriggerEvent('ndrp_emotes:playthisemote','c')
                                    exports['mythic_notify']:SendAlert('success', 'The wound is patched.')
                                    TriggerServerEvent("dg_base:addmoney", math.random(10,40), "Treatment for "..closestPlayer)
                                    table.remove(analyzedData, #analyzedData)
                                end
                                TriggerServerEvent('dg_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                                exports['mythic_notify']:SendAlert('success', 'No treatment required')
                            end
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Do the checkup first!')
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You need a medical bag dummy!')
    end
end)

RegisterCommand('treatb', function(source , args)
    if exports['dg-inventory']:hasEnoughOfItem('MedicalBag', 1) then
        if exports["isPed"]:isPed("myjob") == 'ambulance' then
            if #analyzedData ~= 0 then
                if args[1] ~= nil then 
                    local number = tonumber(args[1])
                    if number ~= nil then
                        local closestPlayer, closestDistance = DGCore.Game.GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance <= 3.0 then
                            if #analyzedData > 1 then
                                TriggerEvent('ndrp_emotes:playthisemote','mechanic4')
                                local finished = exports["dg-taskbar"]:taskBar(10000, "Patching up the wounds")
                                if (finished == 100) then
                                    TriggerServerEvent('dg-hospital:healInjuries',number,GetPlayerServerId(closestPlayer))
                                    TriggerEvent('ndrp_emotes:playthisemote','c')
                                    exports['mythic_notify']:SendAlert('success', 'The wound is patched.')
                                    TriggerServerEvent("dg_base:addmoney", math.random(20,50), "Treatment for "..closestPlayer)
                                    table.remove(analyzedData, #analyzedData)
                                end
                            else
                                TriggerEvent('ndrp_emotes:playthisemote','mechanic4')
                                local finished = exports["dg-taskbar"]:taskBar(10000, "Patching up the wounds")
                                if (finished == 100) then
                                    TriggerServerEvent('dg-hospital:healInjuries',number,GetPlayerServerId(closestPlayer))
                                    TriggerEvent('ndrp_emotes:playthisemote','c')
                                    exports['mythic_notify']:SendAlert('success', 'The wound is patched.')
                                    TriggerServerEvent("dg_base:addmoney", math.random(20,50), "Treatment for "..closestPlayer)
                                    table.remove(analyzedData, #analyzedData)
                                end
                                TriggerServerEvent('dg_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                                exports['mythic_notify']:SendAlert('success', 'No treatment required')
                            end
                        end
                    end
                end
            else
                exports['mythic_notify']:SendAlert('error', 'Do the checkup first!')
            end
        end
    else
        exports['mythic_notify']:SendAlert('error', 'You need a medical bag dummy!')
    end
end)

RegisterNetEvent('dg-hospital:getInjuries')
AddEventHandler('dg-hospital:getInjuries', function(pid,data)
    analyzedData = {}
    local i = 0
    
    for k,v in pairs(data.limbs) do
        if v.isDamaged then
            i = i+1
            table.insert(analyzedData, {id = i, wounds = k})
        end
    end

    if #analyzedData ~= 0 then
        TriggerEvent('chat:addMessage', { templateId = 'broadcast',  args = {"Report", "Diagnostics Results for Patient "..pid } })
        for k,v in pairs(data.limbs) do
            if v.isDamaged then
                i = i+1
                TriggerEvent('chat:addMessage', { templateId = 'broadcast',  args = {"[".. i .."]", "Wounds "..k} })
            end
        end
    else
        exports['mythic_notify']:SendAlert('success', 'Patient is healthy. No treartment required!')
    end

end)

RegisterNetEvent('dg-hospital:checkems')
AddEventHandler('dg-hospital:checkems', function(ems)
	numberofems = ems
end)

RegisterCommand('bed', function(source, args)
    TriggerEvent('dg-hospital:client:RPCheckPos')
end, false)

TriggerEvent('chat:addSuggestion', '/bed', 'Lie down on the nearest bed in Pillbox (Ward A)')

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if beingTreated then
            DisableAllControlActions(0,73,true)
            EnableControlAction(0,249,true)
            EnableControlAction(0,0,true)
            EnableControlAction(0,1,true)
            EnableControlAction(0,2,true)
            EnableControlAction(0,3,true)
			EnableControlAction(0,4,true)
            EnableControlAction(0,5,true)
            EnableControlAction(0,6,true)
			EnableControlAction(0,20,true)
			EnableControlAction(0,245,true)
        end
    end
end)