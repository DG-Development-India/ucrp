
DGCore 						= nil
local PlayerData            = nil
local MiningPos 			= {}
local WashingPos 			= {}
local SmeltingPos 			= {}
local keyPressed 			= false
local currentlyMining 		= false
local currentlyWashing 		= false
local currentlySmelting 	= false

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

-- Load Spot Status:
RegisterNetEvent('dg_lumberjack:loadSpot')
AddEventHandler('dg_lumberjack:loadSpot', function(list, list2, list3)
    MiningPos = list
    WashingPos = list2
    SmeltingPos = list3
end)

-- Update Mining Spot Status:
RegisterNetEvent('dg_lumberjack:updateStatus')
AddEventHandler('dg_lumberjack:updateStatus', function(id,status)
    if id ~= nil or status ~= nil then 
        MiningPos[id].mining = status
    end
end)

-- CreateThread Function for Mining:
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(MiningPos) do
            v.spot[1] = v.spot[1]
            v.spot[2] = v.spot[2]
            v.spot[3] = v.spot[3]
			if not v.mining and not currentlyMining then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 10.0 then
					DrawMarker(Config.MiningMarker, v.spot[1], v.spot[2], v.spot[3]-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MiningMarkerScale.x, Config.MiningMarkerScale.y, Config.MiningMarkerScale.z, Config.MiningMarkerColor.r, Config.MiningMarkerColor.g, Config.MiningMarkerColor.b, Config.MiningMarkerColor.a, false, true, 2, false, false, false, false)
				end    
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.5 then
					DrawText3Ds(v.spot[1], v.spot[2], v.spot[3], Config.DrawMining3DText)
				end
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.0 then
					if IsControlJustPressed(0,Config.KeyToStartMining) and not keyPressed then
						keyPressed = true
						--DGCore.TriggerServerCallback("dg_lumberjack:getPickaxe", function(pickaxe)
						if exports['dg-inventory']:hasEnoughOfItem('axe', 1, true) then
							local stone = exports['dg-inventory']:getQuantity('wood')
							if stone <= 95 then		
								DGCore.TriggerServerCallback("dg_lumberjack:didmining", function(didminingok) 
									if didminingok then
										TriggerServerEvent("dg_lumberjack:spotStatus", k, true)
										currentlyMining = true
										Citizen.Wait(250)
										MiningEvent(k,v)
									else
										exports['mythic_notify']:SendAlert('error', 'Take some rest now !')
										keyPressed = false
									end
								end)
							else
								TriggerServerEvent("dg_lumberjack:getStoneLimit")
								exports['mythic_notify']:SendAlert('error', 'You can’t carry more woods with you!')
								keyPressed = false
							end
						else
							exports['mythic_notify']:SendAlert('error', 'You need a axe')
							keyPressed = false
						end
						--end
						break;
					end
				end
			end
        end
    end
end)

-- Create Mining Blips:
Citizen.CreateThread(function()
	for i = 1, #Config.MiningPositions do
		if Config.MiningPositions[i].blipEnable then
			local blip = AddBlipForCoord(Config.MiningPositions[i].spot[1], Config.MiningPositions[i].spot[2], Config.MiningPositions[i].spot[3])
			SetBlipSprite(blip, Config.MiningPositions[i].blipSprite)
			SetBlipDisplay(blip, Config.MiningPositions[i].blipDisplay)
			SetBlipScale  (blip, Config.MiningPositions[i].blipScale)
			SetBlipColour (blip, Config.MiningPositions[i].blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.MiningPositions[i].blipName)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Mining Function:
function MiningEvent(k,v)

	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	--FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
	
	--local pickaxe = GetHashKey("prop_tool_pickaxe")
	local pickaxe = GetHashKey("prop_tool_fireaxe")
	
	-- Loads model
	RequestModel(pickaxe)
    while not HasModelLoaded(pickaxe) do
      Wait(1)
    end
	
	--local anim = "melee@hatchet@streamed_core_fps"
	--local anim = "melee@large_wpn@streamed_core"
	local anim = "melee@hatchet@streamed_core"
	--local action = "plyr_front_takedown"
	--local action = "ground_attack_on_spot"
	local action = "plyr_front_takedown"
	
	 -- Loads animation
    RequestAnimDict(anim)
    while not HasAnimDictLoaded(anim) do
      Wait(1)
    end
	
	local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
	AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)

	-- exports['pogressBar']:drawBar(10000, 'Kasama')
	exports['dg-taskbar']:taskBar(1000, "Cutting")
	Citizen.Wait(200)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	--TriggerEvent("InteractSound_CL:PlayOnOne","choppingwood",0.7)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	--TriggerEvent("InteractSound_CL:PlayOnOne","choppingwood",0.7)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	--TriggerEvent("InteractSound_CL:PlayOnOne","choppingwood",0.7)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	--TriggerEvent("InteractSound_CL:PlayOnOne","choppingwood",0.7)
	Citizen.Wait(2000)
	TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
	--TriggerEvent("InteractSound_CL:PlayOnOne","choppingwood",0.7)
	Citizen.Wait(2000)
	TriggerEvent( "player:receiveItem", "wood", 5 )
	--TriggerServerEvent("dg_lumberjack:reward",Config.Stone,Config.StoneReward)
	TriggerServerEvent("dg_lumberjack:spotStatus", k, false)
	
	ClearPedTasks(PlayerPedId())
	--FreezeEntityPosition(playerPed, false)
    DeleteObject(object)
	currentlyMining = false
	keyPressed = false
end

-- CreateThread Function for Washing:
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(WashingPos) do
            v.spot[1] = v.spot[1]
            v.spot[2] = v.spot[2]
            v.spot[3] = v.spot[3]
			if not currentlyWashing then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 20.0 then
					DrawMarker(Config.WasherMarker, v.spot[1], v.spot[2], v.spot[3], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.WasherMarkerScale.x, Config.WasherMarkerScale.y, Config.WasherMarkerScale.z, Config.WasherMarkerColor.r, Config.WasherMarkerColor.g, Config.WasherMarkerColor.b, Config.WasherMarkerColor.a, false, true, 2, false, false, false, false)
				end    
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.2 then
					DrawText3Ds(v.spot[1], v.spot[2], v.spot[3], Config.DrawWasher3DText)
				end
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.2 then
					if IsControlJustPressed(0,Config.KeyToStartWashing) and not keyPressed then
						keyPressed = true
						--DGCore.TriggerServerCallback("dg_lumberjack:getWashPan", function(washPan)
							--if washPan then
							local WStone = exports['dg-inventory']:getQuantity('cutwood')
								--DGCore.TriggerServerCallback("dg_lumberjack:getWashedStoneLimit", function(washedStoneLimitOK)
									if WStone <= 95  then
										currentlyWashing = true
										Citizen.Wait(250)
										WashingEvent(k,v)
									else
										exports['mythic_notify']:SendAlert('error', 'You cannot carry more cutted wood with you!')
										keyPressed = false
									end
								--end)
							--else
								--exports['mythic_notify']:SendAlert('error', 'A wash plate is needed here!')
								--keyPressed = false
							--end
						--end)
						break;
					end
				end
			end
        end
    end
end)

-- Create Washing Blips:
Citizen.CreateThread(function()
	for i = 1, #Config.WashingPositions do
		if Config.WashingPositions[i].blipEnable then
			local blip = AddBlipForCoord(Config.WashingPositions[i].spot[1], Config.WashingPositions[i].spot[2], Config.WashingPositions[i].spot[3])
			SetBlipSprite(blip, Config.WashingPositions[i].blipSprite)
			SetBlipDisplay(blip, Config.WashingPositions[i].blipDisplay)
			SetBlipScale  (blip, Config.WashingPositions[i].blipScale)
			SetBlipColour (blip, Config.WashingPositions[i].blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.WashingPositions[i].blipName)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

function WashingEvent(k,v)
	
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)
	
	--DGCore.TriggerServerCallback("dg_lumberjack:removeStone", function(stoneCount)
	local WStoneCount = exports['dg-inventory']:hasEnoughOfItem('wood', 10, true)
		if WStoneCount then
			-- exports['pogressBar']:drawBar(10000, 'Plaunami akmenys')
			playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 15000)
			TriggerEvent("InteractSound_CL:PlayOnOne","cuttingsound",0.50)
			exports['dg-taskbar']:taskBar(15000, "Cutting")
			--Citizen.Wait(200)
			if WStoneCount then
			--TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			TriggerEvent("inventory:removeItem", "wood", 10)
			--Citizen.Wait(10000)
			--Citizen.Wait(1000)
			TriggerEvent("player:receiveItem", "cutwood", 10)
			--TriggerEvent("player:recieveItem", 'washedstone', Config.WStoneReward)
			--TriggerEvent( "player:receiveItem", "heartstopper", 10 )
			else
				exports['mythic_notify']:SendAlert('error', 'You need at least 10 cutted wood!')
			end
			--TriggerServerEvent("dg_lumberjack:reward",Config.WStone,Config.WStoneReward)
		else
			exports['mythic_notify']:SendAlert('error', 'You need at least 10 cutted wood!')
		end
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)
		currentlyWashing = false
		keyPressed = false
	--end)
end

-- CreateThread Function for Washing:
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped,true)
        for k,v in pairs(SmeltingPos) do
            v.spot[1] = v.spot[1]
            v.spot[2] = v.spot[2]
            v.spot[3] = v.spot[3]
			if not currentlySmelting then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 20.0 then
					DrawMarker(Config.SmelterMarker, v.spot[1], v.spot[2], v.spot[3]-0.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.SmelterMarkerScale.x, Config.SmelterMarkerScale.y, Config.SmelterMarkerScale.z, Config.SmelterMarkerColor.r, Config.SmelterMarkerColor.g, Config.SmelterMarkerColor.b, Config.SmelterMarkerColor.a, false, true, 2, false, false, false, false)
				end    
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.5 then
					DrawText3Ds(v.spot[1], v.spot[2], v.spot[3], Config.DrawSmelter3DText)
				end
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.spot[1], v.spot[2], v.spot[3], true) <= 1.0 then
					if IsControlJustPressed(0,Config.KeyToStartSmelting) and not keyPressed then
						keyPressed = true
						local closestPlayer, closestDistance = DGCore.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance >= 0.7 then
							local WStoneCount1 = exports['dg-inventory']:hasEnoughOfItem('cutwood', 10, true)
							if WStoneCount1 then
								TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
								TriggerEvent("inventory:removeItem", 'cutwood', 10)
								currentlySmelting = true
								Citizen.Wait(250)
								SmeltingEvent(k,v)
							else
								exports['mythic_notify']:SendAlert('error', 'You need at least 10 cutted wood to start shape here!')
								keyPressed = false
							end
							--end)
						else
							exports['mythic_notify']:SendAlert('error', 'You are too close to another person!')
							keyPressed = false
						end	
						break;
					end
				end
			end
        end
    end
end)

-- Create Smelting Blips:
Citizen.CreateThread(function()
	for i = 1, #Config.SmeltingPositions do
		if Config.SmeltingPositions[i].blipEnable then
			local blip = AddBlipForCoord(Config.SmeltingPositions[i].spot[1], Config.SmeltingPositions[i].spot[2], Config.SmeltingPositions[i].spot[3])
			SetBlipSprite(blip, Config.SmeltingPositions[i].blipSprite)
			SetBlipDisplay(blip, Config.SmeltingPositions[i].blipDisplay)
			SetBlipScale  (blip, Config.SmeltingPositions[i].blipScale)
			SetBlipColour (blip, Config.SmeltingPositions[i].blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.SmeltingPositions[i].blipName)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Function for Smelting:
function SmeltingEvent()
		
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	
	FreezeEntityPosition(playerPed, true)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
	Citizen.Wait(200)

	-- exports['pogressBar']:drawBar(10000, 'Lydomi nuplauti akmenys')
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
	exports['dg-taskbar']:taskBar(10000, "Packaging woods")
	--Citizen.Wait(10000)
	local rewardChance = math.random(1,10)
	if rewardChance <= 1 then
		TriggerEvent("player:receiveItem", 'swood', 1)
	elseif rewardChance > 1  and rewardChance < 3 then
		TriggerEvent("player:receiveItem", 'pwood', 1)
	elseif rewardChance > 3 and rewardChance < 5 then
		TriggerEvent("player:receiveItem", 'owood', 5)
	elseif rewardChance > 5 and rewardChance <= 7 then
		TriggerEvent("player:receiveItem", 'bwood', 10)
	elseif rewardChance > 7 and rewardChance <= 10 then
		TriggerEvent("player:receiveItem", 'twood', 10)
	end
	--TriggerServerEvent("dg_lumberjack:rewardSmelting")
	
	FreezeEntityPosition(playerPed, false)
	currentlySmelting = false
	keyPressed = false

end

-- jewellery craft
-- local isCrafting = false
-- Citizen.CreateThread(function()
-- 	local sleep
-- 	while not process do
-- 		Citizen.Wait(0)
-- 	end
-- 	while true do
-- 		sleep = 5
-- 		local player = GetPlayerPed(-1)
-- 		local playercoords = GetEntityCoords(player)
-- 		local dist = #(vector3(playercoords.x,playercoords.y,playercoords.z)-vector3(process.x,process.y,process.z))
-- 		if dist <= 3 and not isCrafting then
-- 			sleep = 5
-- 			DrawText3Ds(process.x, process.y, process.z, '[E] cut')			
-- 			if IsControlJustPressed(1, 51) then		
-- 				isProcessing = true
-- 				--DGCore.TriggerServerCallback('coke:process', function(success)
-- 					if exports['dg-inventory']:hasEnoughOfItem('uncut_diamond', 1) then				
-- 						crafting()
-- 					elseif exports['dg-inventory']:hasEnoughOfItem('uncut_ruby', 1) then
-- 						crafting()
-- 					elseif exports['dg-inventory']:hasEnoughOfItem('uncut_yellow_diamond', 1) then
-- 						crafting()
-- 					elseif exports['dg-inventory']:hasEnoughOfItem('uncut_blue_diamond', 1) then
-- 						crafting()
-- 					else
-- 						isCrafting = false
-- 					end
-- 				--end)
-- 			end
-- 		else
-- 			sleep = 1500
-- 		end
-- 		Citizen.Wait(sleep)
-- 	end
-- end)

-- function crafting()
-- 	local player = GetPlayerPed(-1)
-- 	SetEntityCoords(player, process.x,process.y,process.z-1, 0.0, 0.0, 0.0, false)
-- 	SetEntityHeading(player, 298.02)
-- 	FreezeEntityPosition(player, true)
-- 	--if Config.progBar then
-- 		exports['dg-taskbar']:taskBar(6000, 'Cutting')
-- 	--end
-- 	playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 6000)
-- 	Citizen.Wait(6000)
-- 	FreezeEntityPosition(player, false)
-- 	--local pick = Config.randBrick
-- 	if exports['dg-inventory']:hasEnoughOfItem('uncut_diamond', 1) then
-- 		TriggerEvent("inventory:removeItem","uncut_diamond", 1)
-- 		TriggerEvent('player:receiveItem', "diamond", pick)
-- 		TriggerEvent('OpenInv')
-- 	elseif exports['dg-inventory']:hasEnoughOfItem('uncut_ruby', 1) then
-- 		TriggerEvent("inventory:removeItem","uncut_ruby", 1)
-- 		TriggerEvent('player:receiveItem', "ruby", pick)
-- 		TriggerEvent('OpenInv')
-- 	elseif exports['dg-inventory']:hasEnoughOfItem('uncut_yellow_diamond', 1) then
-- 		TriggerEvent("inventory:removeItem","uncut_yellow_diamond", 1)
-- 		TriggerEvent('player:receiveItem', "ydiamond", pick)
-- 		TriggerEvent('OpenInv')
-- 	elseif exports['dg-inventory']:hasEnoughOfItem('uncut_blue_diamond', 1) then
-- 		TriggerEvent("inventory:removeItem","uncut_blue_diamond", 1)
-- 		TriggerEvent('player:receiveItem', "bdiamond", pick)
-- 		TriggerEvent('OpenInv')
-- 	else
-- 		exports['mythic_notify']:DoHudText('error', 'Not Enough stuffs')
-- 	--TriggerServerEvent('coke:processed')
-- 	end
-- 	isCrafting = false
-- end

-- Refresh Spots:
Citizen.CreateThread(function()
    TriggerServerEvent("dg_lumberjack:refreshSpots")
end)

-- Function for 3D text:
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

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end