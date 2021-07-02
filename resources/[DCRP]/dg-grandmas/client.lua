DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

function Draw3DText(x,y,z, text)
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

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

local hospitalCheckin = { x = 2433.91, y = 4965.50, z = 42.00, h = 43.69 }

Citizen.CreateThread(function()
    DeletePed(grandmaPed)
    CreategrandmaPed()
    while true do
        Citizen.Wait(1)
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
        local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
        if distance < 10 then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 then
                    --PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
			        Draw3DText(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5, '[E] - treated by GrandMa [$2000]')
                    if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(PlayerPedId()) <= 200) then
                            --loadAnimDict('missheistdockssetup1clipboard@base')
                            --TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@base", "base", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
                            exports["dg-taskbar"]:taskBar(10500, "Checking In")
                                exports["dg-taskbar"]:taskBar(60000, "Treating, Do not move")
                                    TriggerEvent('dg-ambulancejob:revive')
                                    TriggerServerEvent('mythic_hospital:server:HealSomeShit')
                                    ClearPedTasks(PlayerPedId())
                                else
                            TriggerEvent('DoLongHudText', 'You do not need medical attention', 2)
                        end
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

local grandma = {x = 2433.91, y = 4965.50, z = 42.37, h=43.69}
-- local veggieShop = {x = -1375.4, y = -688.81, z = 24.82}
function CreategrandmaPed()

    local hashKey = `a_f_m_eastsa_01`
    local pedType = 1
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

	grandmaPed = CreatePed(pedType, hashKey, grandma.x,grandma.y,grandma.z-1, grandma.h, 0, 0)
	
    ClearPedTasks(grandmaPed)
    ClearPedSecondaryTask(grandmaPed)
    TaskSetBlockingOfNonTemporaryEvents(grandmaPed, true)
    SetPedFleeAttributes(grandmaPed, 0, 0)
    SetPedCombatAttributes(grandmaPed, 17, 1)
    SetPedSeeingRange(grandmaPed, 0.0)
    SetPedHearingRange(grandmaPed, 0.0)
    SetPedAlertness(grandmaPed, 0)
    SetPedKeepTask(grandmaPed, true)
	SetEntityInvincible(grandmaPed, true)
    FreezeEntityPosition(grandmaPed, true)
	
end

