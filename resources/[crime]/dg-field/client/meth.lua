local Keys = {
    ["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["K"] = 311
}
local pressed = false
local havecard = false

local coords = {
    [1] = { pos = vector3(1413.78 , -2042.17 , 51.0), heading = 359.3 },
    [2] = { pos = vector3(120.93 , -2468.62 , 5.0), heading = 233.0 },
    [3] = { pos = vector3(-647.15 , -1148.54 , 8.52),  heading = 334.5 },
	[4] = { pos = vector3(38.48 , -71.51 , 64.73 ), heading = 253.51},
	[5] = { pos = vector3(-1317.89 , -939.2 , 8.73  ),  heading = 117.4 },
	[6] = { pos = vector3(1639.65 , 3731.49 , 36.07 ), heading =  137.48},
}

local blip
DGCore = nil
local phoneCoords = vector3(-1579.41, -440.9, 37.97)
local phoneCoordsPed = {x = -1579.41, y = -440.9, z = 37.97, h = 230.6}


cachedPeds = {}
Citizen.CreateThread(function()
    while true do
        cachedPeds = {}
        Citizen.Wait(300000)
    end
end)


Citizen.CreateThread(function()
    while DGCore == nil do
        TriggerEvent('dg:getSharedObject', function(obj)
            DGCore = obj
        end)
        Citizen.Wait(0)
    end
end)

function CreateMethPed()

    local hashKey = `s_m_m_trucker_01`
    local pedType = 1
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

	methPed = CreatePed(pedType, hashKey, phoneCoordsPed.x,phoneCoordsPed.y,phoneCoordsPed.z-1, phoneCoordsPed.h, 0, 0)
	
    ClearPedTasks(methPed)
    ClearPedSecondaryTask(methPed)
    TaskSetBlockingOfNonTemporaryEvents(methPed, true)
    SetPedFleeAttributes(methPed, 0, 0)
    SetPedCombatAttributes(methPed, 17, 1)
    SetPedSeeingRange(methPed, 0.0)
    SetPedHearingRange(methPed, 0.0)
    SetPedAlertness(methPed, 0)
    SetPedKeepTask(methPed, true)
	SetEntityInvincible(methPed, true)
    FreezeEntityPosition(methPed, true)
	
end

Citizen.CreateThread(function()
    local wait = 100
	DeletePed(methPed)
    CreateMethPed()
    while true do
        Citizen.Wait(wait)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,phoneCoords.x,phoneCoords.y,phoneCoords.z,false)
        if distance <= 5.0 then
            wait = 0
            if distance <= 1.0 then
                DrawText3D(phoneCoords.x,phoneCoords.y,phoneCoords.z, "[~g~E~s~] - interact with Leroy")
				print('has enough items')
                if IsControlJustReleased(0, 86) then
					if exports['dg-inventory']:hasEnoughOfItem('electronics', 20) and exports['dg-inventory']:hasEnoughOfItem('scrap', 10) and exports['dg-inventory']:hasEnoughOfItem('cashstack', 1) then
                    	Citizen.Wait(1)
						exports['mythic_progbar']:Progress({
							name = "Leroy",
							duration = 20000,
							label = 'Talking with Leroy',
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = true,
								disableCombat = true,
							},
							animation = {
								animDict = "misscarsteal4@actor",
								anim = "actor_berating_loop",
								flags = 49,
							}
						}, function(cancelled)
							if not cancelled then
								print('has enough items')
								if exports['dg-inventory']:hasEnoughOfItem('electronics', 20) and exports['dg-inventory']:hasEnoughOfItem('scrap', 10) and exports['dg-inventory']:hasEnoughOfItem('cashstack', 1) then
									print('removing')
									TriggerEvent("inventory:removeItem","electronics", 20)
									TriggerEvent("inventory:removeItem","scrap", 10)
									TriggerEvent("inventory:removeItem","cashstack", 1)
									print('got it')
									TriggerEvent('player:receiveItem', "burnerphone", 1)
									exports['mythic_notify']:SendAlert('inform', 'You got a burnerphone !', 2500, { ['background-color'] = '#56f7fc', ['color'] = '#000' })
								else
									exports['mythic_notify']:SendAlert('error', 'WTF do you want ?')
								end	
							end
						end)
					else
						exports['mythic_notify']:SendAlert('error', 'WTF do you want ?')
					end
                end
            end
        else
            wait = 100
        end
    end
end)

local lastblip

RegisterNetEvent('dg_drugs:burnerUsed')
AddEventHandler('dg_drugs:burnerUsed', function()
	print('has enough item')
	if exports['dg-inventory']:hasEnoughOfItem('burnerphone', 1)
		print('removing burner phone')
		TriggerEvent("inventory:removeItem","burnerphone", 1)
		exports['dg-taskbar']:taskBar(1000, 'Connecting to WAP...')
		exports['mythic_notify']:SendAlert('inform', 'WAP Connected...', 1000, { ['background-color'] = '#56f7fc', ['color'] = '#000' })
		Citizen.Wait(2500)
		exports['dg-taskbar']:taskBar(1000, 'Fetching GPS coordinates...')
		exports['mythic_notify']:SendAlert('inform', 'GPS coordinates fetched', 1000, { ['background-color'] = '#56f7fc', ['color'] = '#000' })
		Citizen.Wait(2500)
		PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
		exports['dg-taskbar']:taskBar(1000, 'Setting GPS coordinates...')
		exports['mythic_notify']:SendAlert('inform', 'GPS coordinates have been set!', 1000, { ['background-color'] = '#56f7fc', ['color'] = '#000' })
		Citizen.Wait(2500)
		RemoveBlip(blip)
		local rand = math.random(1, #coords)
		local blipCoords = coords[rand].pos
		
		while true do
			Citizen.Wait(10)
			if blipCoords == lastblip then
				rand = math.random(1, #coords)
				blipCoords = coords[rand].pos
			else
				lastblip = blipCoords
			break
			end
		end
		
		local blip = AddBlipForCoord(blipCoords)
		SetBlipRoute(blip, 1)

		local delay = 100
		
		while true do
		
			Citizen.Wait(delay)
			local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), blipCoords, true)
			if dist < 1.5  then
				delay = 0
				DGCore.ShowHelpNotification('Press ~INPUT_CONTEXT~ to interact with dealer')
				inRange = true
				RemoveBlip(blip)
			else
				delay = 100
				inRange = false
			end
			if IsControlJustReleased(0, Keys['E']) and inRange and not pressed then
				FreezeEntityPosition(PlayerPedId(), true)
				pressed = true
				SetEntityCoords(PlayerPedId(), coords[rand].pos)
				Citizen.Wait(50)
				SetEntityHeading(PlayerPedId(), coords[rand].heading)
				TriggerEvent('ndrp_emotes:playthisemote', 'knock')
				Citizen.Wait(100)
				TriggerEvent('InteractSound_CL:PlayOnOne', 'doorknock', 0.4)
				Citizen.Wait(4000)
				TriggerEvent('ndrp_emotes:playthisemote', 'c')
				TriggerEvent('InteractSound_CL:PlayOnOne', 'biatch', 0.4)
				Citizen.Wait(2000)
				PlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a')
				print('added items')
				TriggerEvent('player:receiveItem', "aspirin", 10)
				TriggerEvent('player:receiveItem', "drugx", 2)
				TriggerEvent('dg_status:add', 'stress', 100000)
				exports['mythic_notify']:SendAlert('inform', 'Stress gained!.', 2500, { })
				Citizen.Wait(1000)
				pressed = false
				FreezeEntityPosition(PlayerPedId(), false)
				return
			end
		end
	else
		print('not enough items')
		exports['mythic_notify']:SendAlert('error', 'WTF do you want ?')
	end	
end)

--------------------------------------------------------------------------------------------------
function PlayAnim(ped, lib, anim, r)
    DGCore.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(ped, lib, anim, 8.0, -8, -1, r and 49 or 0, 0, 0, 0, 0)
    end)
end

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
end