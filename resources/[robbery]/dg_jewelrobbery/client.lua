DGCore                        		= nil
local leftdoor, rightdoor		= nil, nil
local HasAlreadyEnteredArea 	= false
local IsAbleToRob				= false
local policeclosed				= false
local IsBusy, HasNotified		= false, false
local CopsOnline 				= 0
local shockingevent 			= false
local COPREQUIRED 				= 0
local stage1 					= false


Citizen.CreateThread(function()
    while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = DGCore.GetPlayerData()
end)

RegisterNetEvent('dg_jewelrobbery:policeclosure')
AddEventHandler('dg_jewelrobbery:policeclosure', function()
	policeclosed = true
	storeclosed = false
	IsAbleToRob = false
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('dg_jewelrobbery:loadconfig')
end)

RegisterNetEvent('dg_jewelrobbery:resetcases')
AddEventHandler('dg_jewelrobbery:resetcases', function(list)
	if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.2496, -230.8000, 38.05705, true)  < 20.0  then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
	Config.CaseLocations = list
	HasNotified = false
	policeclosed = false
	storeclosed = false
	IsAbleToRob = false
	HasAlreadyEnteredArea = false
end)

RegisterNetEvent('dg_jewelrobbery:setcase')
AddEventHandler('dg_jewelrobbery:setcase', function(casenumber, switch)
	Config.CaseLocations[casenumber].Broken = switch
	HasAlreadyEnteredArea = false
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z, currentStreetHash, intersectStreetHash)
		currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
		intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
	end
end)

RegisterNetEvent('dg_jewelrobbery:loadconfig')
AddEventHandler('dg_jewelrobbery:loadconfig', function(casestatus)
	while not DoesEntityExist(GetPlayerPed(-1)) do
		Citizen.Wait(100)
	end
	Config.CaseLocations = casestatus
	if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
		for i, v in pairs(Config.CaseLocations) do
			if v.Broken then
				CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
			end
		end
	end
end)

RegisterNetEvent('dg_jewelrobbery:playsound')
AddEventHandler('dg_jewelrobbery:playsound', function(x,y,z, soundtype)
	ply = GetPlayerPed(-1)
	plyloc = GetEntityCoords(ply)
	if GetDistanceBetweenCoords(plyloc,x,y,z,true) < 20.0 then
		if soundtype == 'break' then
			PlaySoundFromCoord(-1, "Glass_Smash", x,y,z, 0, 0, 0)
		elseif soundtype == 'nonbreak' then
			PlaySoundFromCoord(-1, "Drill_Pin_Break", x,y,z, "DLC_HEIST_FLEECA_SOUNDSET", 0, 0, 0)
		end
	end
end)

AddEventHandler('dg_jewelrobbery:EnteredArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

AddEventHandler('dg_jewelrobbery:LeftArea', function()
	for i, v in pairs(Config.CaseLocations) do
		if v.Broken then
			RemoveModelSwap(v.Pos.x, v.Pos.y, v.Pos.z, 0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
		end
	end
end)

function UnAuthJob()
	while DGCore == nil do
		Citizen.Wait(0)
	end
	local UnAuthjob = false
	for i,v in pairs(Config.UnAuthJobs) do
		if PlayerData.job.name == v then
			UnAuthjob = true
			break
		end
	end

	return UnAuthjob
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

Citizen.CreateThread( function()
	while true do 
		ply = GetPlayerPed(-1)
		plyloc = GetEntityCoords(ply)
		IsInArea = false
		
		if GetDistanceBetweenCoords(plyloc, -622.2496, -230.8000, 38.05705, true)  < 20.0 then
			IsInArea = true
		end
		
		if IsInArea and not HasAlreadyEnteredArea then
			TriggerEvent('dg_jewelrobbery:EnteredArea')
			shockingevent = false
			if Config.Closed and not policeclosed then
				leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
				rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
				ClearAreaOfPeds(-622.2496, -230.8000, 38.05705, 10.0, 1)
				storeclosed = true
				HasNotified = false
			else
				leftdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_l"), false, false, false)
				rightdoor = GetClosestObjectOfType(-631.9554, -236.3333, 38.20653, 11.0, GetHashKey("p_jewel_door_r1"), false, false, false)			
				storeclosed = false
				Citizen.Wait(100)
				freezedoors(false)
				IsAbleToRob = true
			
			end
			HasAlreadyEnteredArea = true
		end

		if not IsInArea and HasAlreadyEnteredArea then
			TriggerEvent('dg_jewelrobbery:LeftArea')
			HasAlreadyEnteredArea = false
			shockingevent = false
			IsAbleToRob = false
			storeclosed = false
			HasNotified = false
		end
		
		if Config.Closed and not storeclosed and not policeclosed then
			Citizen.Wait(1250)
		else
			Citizen.Wait(3250)
		end
	end
end)

function freezedoors(status)
	FreezeEntityPosition(leftdoor, status)
	FreezeEntityPosition(rightdoor, status)
end

Citizen.CreateThread( function()
	while true do 
		sleep = 1500
		while IsAbleToRob do
			Citizen.Wait(0)
			sleep = 0
			ply = GetPlayerPed(-1)
			plyloc = GetEntityCoords(ply)
			for i, v in pairs(Config.CaseLocations) do
				if GetDistanceBetweenCoords(plyloc, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.0  and not v.Broken and not IsBusy then
					local robalbe = false
					local _, weaponname = GetCurrentPedWeapon(ply)
					for index, weapon in pairs (Config.AllowedWeapons) do
						if GetHashKey(weapon.name) == weaponname then
							robalbe = weapon
							break 
						end
					end
					if robalbe then	
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z + 0.5, 'Press ~g~E~w~ to Break')
						if IsControlJustPressed(0, 38) and not IsBusy and not IsPedWalking(ply) and not IsPedRunning(ply) and not IsPedSprinting(ply) then
							local policenotify = math.random(1,100)
							if not shockingevent  then
								AddShockingEventAtPosition(99, v.Pos.x, v.Pos.y, v.Pos.z,25.0)
								shockingevent = true
							end
							IsBusy = true				
							TaskTurnPedToFaceCoord(ply, v.Pos.x, v.Pos.y, v.Pos.z, 1250)
							Citizen.Wait(1250)
							if not HasAnimDictLoaded("missheist_jewel") then
								RequestAnimDict("missheist_jewel") 
							end
							while not HasAnimDictLoaded("missheist_jewel") do 
							Citizen.Wait(0)
							end
							TaskPlayAnim(ply, 'missheist_jewel', 'smash_case', 1.0, -1.0,-1,1,0,0, 0,0)
							local breakchance = math.random(1, 100)
							if breakchance <= robalbe.chance then
								
								Citizen.Wait(2100)
								TriggerServerEvent('dg_jewelrobbery:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'break')
								CreateModelSwap(v.Pos.x, v.Pos.y, v.Pos.z,  0.1, GetHashKey(v.Prop1), GetHashKey(v.Prop), false )
								ClearPedTasksImmediately(ply)
								TriggerServerEvent("dg_jewelrobbery:setcase", i, true)	
							else
								Citizen.Wait(2100)
								TriggerServerEvent('dg_jewelrobbery:playsound', v.Pos.x, v.Pos.y, v.Pos.z, 'nonbreak')
								ClearPedTasksImmediately(ply)
							end	
							Citizen.Wait(1250)
							IsBusy = false			
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)


-- Stage 1
local roofCoords = {x = -596.47, y = -283.96, z = 50.33,h = 214.24}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
		local ped = GetPlayerPed(-1)
		local pos = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,roofCoords.x,roofCoords.y,roofCoords.z,false)
		if distance < 10.0 then
			wait = 0
			DrawMarker(27, roofCoords.x,roofCoords.y,roofCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
		else
			wait = 100
		end
    end
end)

RegisterNetEvent('rob:vangelico')
AddEventHandler('rob:vangelico', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-596.47, -283.96, 50.33) - player)
    if distance < 1.0 then
		DGCore.TriggerServerCallback('checkCops', function(copnumber)
			if copnumber >= COPREQUIRED then
				DGCore.TriggerServerCallback('checkCooldown', function(checked)
					if checked then
						stage1 = true
						TriggerEvent("inventory:removeItem", "Gruppe6Card3", 1)
						TriggerEvent('dg-emotes:playthisemote','weld')
						-- local prop = CreateObject(GetHashKey('prop_weld_torch'), player.x, player.y, player.z, true, true, true)
						-- local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
						-- AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.12, -0.03, 0.03, -100.0, 0.0, -10.0, true, true, false, true, 1, true)
						FreezeEntityPosition(PlayerPedId(), true)
						exports["dg-taskbar"]:taskBar(15*1000, "Disabling power supply")
						-- TriggerEvent('dg-dispatch:jewelrobbery')
						TriggerEvent('dg-emotes:playthisemote','c')
						FreezeEntityPosition(PlayerPedId(), false)
						exports['mythic_notify']:SendAlert('success', 'Succesfully Disabled the power supply')
						TriggerServerEvent('notifyCops','Vangelico Store',GetEntityCoords(PlayerPedId()),458,'10-90')
					else
						exports['mythic_notify']:SendAlert('error', 'The store was robbed recently')
					end
				end)
			else
				exports['mythic_notify']:SendAlert('error', 'Not enough security')
			end
		end)
    end
end)

-- Stage 2

local st2Coords = {x = -631.43, y = -230.18, z = 38.06,h = 214.24}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if stage1 then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,st2Coords.x,st2Coords.y,st2Coords.z,false)
            if distance < 10.0 then
                wait = 0
                DrawMarker(27, st2Coords.x,st2Coords.y,st2Coords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DT(st2Coords.x,st2Coords.y,st2Coords.z, "[E] - Disable the store security")
                    if IsControlJustReleased(0, 46) and not pressed then
						pressed = false
						if exports['dg-inventory']:hasEnoughOfItem('electronickit', 1) then
							TriggerEvent("mhacking:show")
							TriggerEvent("mhacking:start",4,30, disableSec)
							TriggerEvent('dg-emotes:playthisemote','type')
							FreezeEntityPosition(PlayerPedId(), true)
						else
							exports['mythic_notify']:SendAlert('inform', 'Do you think you can hack me that easy hein?')
						end
						Citizen.Wait(2000)
						pressed = false
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- MiniGame Result

function disableSec(success, timeremaining)
	if success then
		stage1 = false
		TriggerServerEvent('startCooldown',30)
		TriggerEvent('mhacking:hide')
		TriggerEvent('dg-emotes:playthisemote','c')
		FreezeEntityPosition(PlayerPedId(), false)
		SetEntityCoords(st2Coords.x,st2Coords.y,st2Coords.z)
		SetEntityHeading(st2Coords.h)
        local looting = exports["dg-taskbar"]:taskBar(2*60*1000, "Disabling The Security")
		TriggerEvent('dg-dispatch:jewelrobbery')
		TriggerServerEvent('dg_skill',1,'criminal',1)
        IsAbleToRob = true
	else
		exports['mythic_notify']:SendAlert('error', 'Task failed! try Again')
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('dg_skill',0,'criminal',1)
	end
end

function DT(x,y,z,text)
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