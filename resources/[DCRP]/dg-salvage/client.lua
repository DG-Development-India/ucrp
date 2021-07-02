local PlayerData              = {}
DGCore                           = nil

Citizen.CreateThread(function ()
  while DGCore == nil do
    TriggerEvent('DGCore:getSharedObject', function(obj) DGCore = obj end)
    Citizen.Wait(0)
  PlayerData = DGCore.GetPlayerData()
  end
end)

RegisterNetEvent('DGCore:playerLoaded')
AddEventHandler('DGCore:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('DGCore:setJob')
AddEventHandler('DGCore:setJob', function(job)
  PlayerData.job = job
end)

-- Jewellery cutting
Citizen.CreateThread(function()
	
	local x = 605.5384
	local y = -3095.19
	local z = 6.069259
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to cut jewellery')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 10000)
					TriggerEvent("server-inventory-open", "112", "Craft");
				end
			end
		end
	end
end)

-- Jewellery crafting
Citizen.CreateThread(function()
	
	local x = 606.3259
	local y = -3087.966
	local z = 6.06926
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make jewellery')
				if IsControlJustReleased(0,  46) then
					TriggerEvent("server-inventory-open", "111", "Craft");
				end
			end
		end
	end
end)

-- Blackmarket
Citizen.CreateThread(function()
	
	local x = 173.0593
	local y = -1000.345
	local z = -98.99997
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to Blackmarket')
				if IsControlJustReleased(0,  46) then
					TriggerEvent("server-inventory-open", "110", "Shop");
				end
			end
		end
	end
end)

-- level 1 guncrafting
-- gun components
Citizen.CreateThread(function()
	
	local x = -1077.688
	local y = -1677.407
	local z = 4.575236
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make gun components')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making gun components")
					if (finished == 100) then
					TriggerEvent("server-inventory-open", "121", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun crafting (level 1)
Citizen.CreateThread(function()
	
	local x = -1062.355
	local y = -1662.17
	local z = 4.833212
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make guns')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making guns")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "120", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun ammo (level 1)
Citizen.CreateThread(function()
	
	local x = -1103.592
	local y = -1665.084
	local z = 7.352077
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make guns')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making ammo")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "122", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- level 2 guncrafting
-- gun components
Citizen.CreateThread(function()
	
	local x = 887.3602
	local y = -3209.778
	local z = -98.19629
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make gun components')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making gun components")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "104", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun spring (level2)
Citizen.CreateThread(function()
	
	local x = 883.9586
	local y = -3207.336
	local z = -98.1962
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make springs')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making gun spring")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "105", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun barrel (level2)
Citizen.CreateThread(function()
	
	local x = 891.5975
	local y = -3196.814
	local z = -98.19619
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make barrel')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making gun barrel")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "119", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun ammo (level2)
Citizen.CreateThread(function()
	
	local x = 899.259
	local y = -3223.735
	local z = -98.26371
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make ammo')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making ammo")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "118", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

-- gun crafting (level2)
Citizen.CreateThread(function()
	
	local x = 896.4982
	local y = -3217.447
	local z = -98.22585
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to make guns')
				if IsControlJustReleased(0,  46) then
					playAnim("mini@repair", "fixing_a_player", 20000)
					local finished = exports["dg-taskbar"]:taskBar(20000,"making guns")
					if (finished == 100) then
						TriggerEvent("server-inventory-open", "31", "Craft");
					Wait(1000)
					end
				end
			end
		end
	end
end)

--Weed processing
-- Weed12oz < weed5oz
Citizen.CreateThread(function()
	
	local x = 1037.524
	local y = -3205.321
	local z = -38.17028
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to trim')
				if IsControlJustReleased(0,  46) then
					if exports['dg-inventory']:hasEnoughOfItem('weedq', 1)then
						TriggerEvent('inventory:removeItem', "weedq", 1)
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 20000)
						local finished = exports["dg-taskbar"]:taskBar(20000,"Trimming weed")
						if (finished == 100) then	
							TriggerEvent('player:receiveItem', "weed5oz", 5)
						Wait(1000)
						end
					else
					exports['mythic_notify']:DoLongHudText('error', 'You do not have enough item!')
					end
				end
			end
		end
	end
end)

-- Weed5oz < weedoz
Citizen.CreateThread(function()
	
	local x = 1032.97
	local y = -3205.456
	local z = -38.18038
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to package')
				if IsControlJustReleased(0,  46) then
					if exports['dg-inventory']:hasEnoughOfItem('weed5oz', 1)then
						TriggerEvent('inventory:removeItem', "weed5oz", 1)
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 20000)
						local finished = exports["dg-taskbar"]:taskBar(20000,"packaging weed")
						if (finished == 100) then
							TriggerEvent('player:receiveItem', "weedoz", 10)
						Wait(1000)
						end
					else
					exports['mythic_notify']:DoLongHudText('error', 'You do not have enough item!')
					end
				end
			end
		end
	end
end)

-- methbag < methbaggy
Citizen.CreateThread(function()
	
	local x = 1649.429
	local y = 4858.119
	local z = 41.97048
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to cook meth')
				if IsControlJustReleased(0,  46) then
					if exports['dg-inventory']:hasEnoughOfItem('methbag', 1)then
						TriggerEvent('inventory:removeItem', "methbag", 1)
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 20000)
						local finished = exports["dg-taskbar"]:taskBar(20000,"cooking meth")
						if (finished == 100) then
							TriggerEvent('player:receiveItem', "methbaggy", 15)
						Wait(1000)
						end
					else
					exports['mythic_notify']:DoLongHudText('error', 'You do not have enough item!')
					end
				end
			end
		end
	end
end)

-- methbaggy < 1gcrack
Citizen.CreateThread(function()
	
	local x = 1649.945
	local y = 4863.982
	local z = 42.00842
	
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
		if distance < 10 then
			if distance < 1 then
				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to break')
				if IsControlJustReleased(0,  46) then
					if exports['dg-inventory']:hasEnoughOfItem('methbaggy', 1)then
						TriggerEvent('inventory:removeItem', "methbaggy", 1)
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 20000)
						local finished = exports["dg-taskbar"]:taskBar(20000,"breaking")
						if (finished == 100) then
							TriggerEvent('player:receiveItem', "1gcrack", 2)
						Wait(1000)
						end
					else
					exports['mythic_notify']:DoLongHudText('error', 'You do not have enough item!')
					end
				end
			end
		end
	end
end)

-- Hunting
-- Citizen.CreateThread(function()
	
-- 	local x = 713.6496
-- 	local y = -973.8303
-- 	local z = 30.39534
	
-- 	while true do
-- 		Citizen.Wait(10)
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)
-- 		local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
-- 		if distance < 10 then
-- 			if distance < 1 then
-- 				DrawText3Ds(x,y,z, 'Press [~g~E~s~] to cut leather')
-- 				if IsControlJustReleased(0,  46) then
-- 					if exports['dg-inventory']:hasEnoughOfItem('leather', 1)then
-- 						playAnim("anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v1_coccutter", 20000)
-- 						local finished = exports["dg-taskbar"]:taskBar(20000,"cutting leather")
-- 							if (finished == 100) then
-- 							TriggerEvent('player:receiveItem', "pleather", 1)
-- 							Wait(1000)
-- 							end
-- 						else
-- 							exports['mythic_notify']:DoLongHudText('error', 'You do not have enough item!')
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)


-- Function for Animation:
function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.80, 0.40)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 900
 --   DrawRect(_x,_y+(0.0125*1.7), 0.015+ factor, 0.045, 0, 0, 0, 80)
end


-- local object_model = "prop_watercooler"
-- local atm_model = "prop_atm_02"

-- Citizen.CreateThread(function()
-- 	Citizen.Wait(5000)
-- 	RequestModel(object_model)
-- 	RequestModel(atm_model)
	
-- 	local iter_for_request = 1
-- 	local atm_for_request = 1

-- 	while not HasModelLoaded(object_model) and iter_for_request < 5 do
-- 		Citizen.Wait(500)				
-- 		iter_for_request = iter_for_request + 1
-- 	end

-- 	if not HasModelLoaded(object_model) then
-- 		SetModelAsNoLongerNeeded(object_model)
-- 	else
-- 		local ped = PlayerPedId()
-- 		local x,y,z = table.unpack(GetEntityCoords(ped))
-- 		local created_object = CreateObjectNoOffset(object_model, -627.6, 228.47, 80.87, 1, 0, 1)
-- 		local created_object2 = CreateObjectNoOffset(object_model, -598.12, -913.47, 22.88, 1, 0, 1)
-- 		PlaceObjectOnGroundProperly(created_object)
-- 		FreezeEntityPosition(created_object,true)
-- 		PlaceObjectOnGroundProperly(created_object2)
-- 		FreezeEntityPosition(created_object2,true)
-- 		SetModelAsNoLongerNeeded(object_model)
-- 	end

-- 	while not HasModelLoaded(atm_model) and atm_for_request < 5 do
-- 		Citizen.Wait(500)				
-- 		atm_for_request = atm_for_request + 1
-- 	end
	
-- 	if not HasModelLoaded(atm_model) then
-- 		SetModelAsNoLongerNeeded(atm_model)
-- 	else
-- 		local created_atm = CreateObjectNoOffset(atm_model, -37.57, -1115.57, 25.80, 1, 0, 1)
-- 		FreezeEntityPosition(created_atm,true)
-- 		SetEntityHeading(created_atm, 247.9)
-- 		SetModelAsNoLongerNeeded(atm_model)
-- 	end
-- end)