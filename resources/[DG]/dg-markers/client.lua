DGCore = nil

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
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

---------------- MECHANIC -------------------

-- Tuner Shop Crafting

local tunercraft = {x = 953.3022, y = -977.1559, z = 39.49985}
Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then           
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,tunercraft.x,tunercraft.y,tunercraft.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, tunercraft.x, tunercraft.y, tunercraft.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(tunercraft.x,tunercraft.y,tunercraft.z, "[E] - Craft items")
                    if IsControlJustReleased(0, 86) then
                        TriggerEvent("server-inventory-open", "55", "Craft")      
                    end
                end
            end
        end
    end
end)

local tunerstash1 = { x = 947.6878, y = -972.4485, z = 39.49982 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mechanic') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, tunerstash1.x, tunerstash1.y, tunerstash1.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(tunerstash1.x, tunerstash1.y, tunerstash1.z, "[~g~E~s~] - Open Stash")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-Mechanic-Stash")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

local tunerstash2 = { x = 935.8244, y = -984.6761, z = 39.49985 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mechanic') and DGCore.PlayerData.job.grade > 1 then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, tunerstash2.x, tunerstash2.y, tunerstash2.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(tunerstash2.x, tunerstash2.y, tunerstash2.z, "[~g~E~s~] - Open Stash")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-Mechanic-Stash2")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,bennyCoords.x,bennyCoords.y,bennyCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, bennyCoords.x, bennyCoords.y, bennyCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(bennyCoords.x,bennyCoords.y,bennyCoords.z, "[E] - Mechanic Craft")
--                     if IsControlJustReleased(0, 86) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "55", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 5) 
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- -- Tuner Shop Crafting (Kits)

-- local tunCoords = {x = 947.38, y = -969.47, z = 39.5}
-- local tunCoords2 = {x = -196.39, y = -1318.28, z = 31.09}
-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,tunCoords.x,tunCoords.y,tunCoords.z,false)
--             if distance < 10.0 then
--                 wait = 0
--                 DrawMarker(27, tunCoords.x, tunCoords.y, tunCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(tunCoords.x,tunCoords.y,tunCoords.z, "[E] - Craft Upgrades")
--                     if IsControlJustReleased(0, 46) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             --if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "61", "Craft")     
--                             --else
--                                -- exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             --end
--                         end, 7)    
--                     end
--                 end
--             else
--                 wait = 100
--             end
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,tunCoords2.x,tunCoords2.y,tunCoords2.z,false)
--             if distance < 10.0 then
--                 wait = 0
--                 DrawMarker(27, tunCoords2.x, tunCoords2.y, tunCoords2.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(tunCoords2.x,tunCoords2.y,tunCoords2.z, "[E] - Craft Upgrades")
--                     if IsControlJustReleased(0, 46) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "61", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 5)    
--                     end
--                 end
--             else
--                 wait = 100
--             end
--         end
--     end
-- end)

-- -- mechanic shop crafting
-- local harmonyCoords = {x = 1176.26, y = 2635.9, z = 37.75}
-- local msCoords = {x =  1002.67, y = -127.97, z = 74.06}
-- local BennyCoords = {x = -227.83, y = -1327.18, z = 30.89}
-- local tunershopCoords = {x = 949.84, y = -979.03, z = 39.5}
-- --harmony
-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,harmonyCoords.x,harmonyCoords.y,harmonyCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, harmonyCoords.x, harmonyCoords.y, harmonyCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(harmonyCoords.x,harmonyCoords.y,harmonyCoords.z, "[E] - Mechanic Craft")
--                     if IsControlJustReleased(0, 86) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "106", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 6) 
--                     end
--                 end
--             end
--         end
--     end
-- end)
-- --ms custom
-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,msCoords.x,msCoords.y,msCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, msCoords.x,  msCoords.y,  msCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D( msCoords.x, msCoords.y, msCoords.z, "[E] - Mechanic Craft")
--                     if IsControlJustReleased(0, 86) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "106", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 2) 
--                     end
--                 end
--             end
--         end
--     end
-- end)
-- --bennys
-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,BennyCoords.x,BennyCoords.y,BennyCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, BennyCoords.x,  BennyCoords.y,  BennyCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D( BennyCoords.x, BennyCoords.y, BennyCoords.z, "[E] - Mechanic Craft")
--                     if IsControlJustReleased(0, 86) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "106", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 5) 
--                     end
--                 end
--             end
--         end
--     end
-- end)
-- --tunershop
-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,tunershopCoords.x,tunershopCoords.y,tunershopCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, tunershopCoords.x,  tunershopCoords.y,  tunershopCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D( tunershopCoords.x, tunershopCoords.y, tunershopCoords.z, "[E] - Mechanic Craft")
--                     if IsControlJustReleased(0, 86) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "106", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 7) 
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- -- mining craft

-- Citizen.CreateThread(function()
--     Citizen.Wait(1000)
--     while true do
--     local ped = GetPlayerPed(-1)
--     local pos = GetEntityCoords(ped)
--     local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,606.77,-3092.39,6.07,false)
--         if distance <= 1.2 then
--             DrawText3D(606.77,-3092.39,6.07, "[~g~E~s~] - Jewel Craft")
--             if IsControlJustReleased(0, 86) then
--                 playAnim("mini@repair", "fixing_a_player", 10000)
--                 if exports['ogrp_inventory']:hasEnoughOfItem('jtoolkit', 1) then
--                     TriggerEvent("server-inventory-open", "56", "Craft")
--                 else    
--                     exports['mythic_notify']:SendAlert('error', 'You don\'t have a Jeweler\'s kit ')   
--                 end 
--             end
--         end
--         Citizen.Wait(5)
--     end
-- end)

-- taco shop craft

-- Citizen.CreateThread(function()
--     Citizen.Wait(1000)
--     while true do
--     local ped = GetPlayerPed(-1)
--     local pos = GetEntityCoords(ped)
--     local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,15.71,-1598.57,29.38,false)
--         if distance <= 1.2 then
--             DrawText3D(15.71,-1598.57,29.38, "[~g~E~s~] - cook")
--             if IsControlJustReleased(0, 86) then
--                 playAnim("mini@repair", "fixing_a_player", 10000)
--                 --if exports['ogrp_inventory']:hasEnoughOfItem('jtoolkit', 1) then
--                     TriggerEvent("server-inventory-open", "18", "Craft")
--                 --else    
--                     --sexports['mythic_notify']:SendAlert('error', 'You don\'t have a Jeweler\'s kit ')   
--                 --end 
--             end
--         end
--         Citizen.Wait(5)
--     end
-- end)

-- Citizen.CreateThread(function()
	
-- 	local x = 15.71
-- 	local y = -1598.57
-- 	local z = 29.38
		
-- 		while true do
-- 			Citizen.Wait(10)
-- 			local playerPed = PlayerPedId()
-- 			local coords = GetEntityCoords(playerPed)
-- 			local distance = GetDistanceBetweenCoords(coords, x,y,z, true)
-- 			--local job = HHCore.GetPlayerData().job.name
-- 			if distance < 10 then
-- 				--if PlayerData.job and PlayerData.job.name == "cbells" then
-- 				--if job == "cbells" then
-- 					if distance < 1 then
-- 						DrawText3D(x,y,z, 'Press [~g~E~s~] to make food')
-- 						if IsControlJustReleased(0,  46) then
-- 							--if exports['hhrp-inventory']:hasEnoughOfItem('bucket', 1)then
-- 								playAnim("mini@repair", "fixing_a_player", 10000)
-- 								--local finished = exports["hhrp-taskbar"]:taskBar(10000,"making food")
-- 								  --if (finished == 100) then
-- 								--pos = GetEntityCoords(PlayerPedId(), false)
-- 								TriggerEvent("server-inventory-open", "98", "Craft");
-- 								--end
-- 							--else
-- 								--exports['mythic_notify']:DoLongHudText('error', 'You do not have enough stuff')
-- 							--end
-- 						end
-- 					end
					
-- 				--end
-- 			end
-- 		end
-- 	end)


-- ID card 

local idcardCoords = {x = 229.03, y = -429.15, z = 48.08}

Citizen.CreateThread(function()
    local pressed = false
    local wait = 100
    while true do
        Citizen.Wait(wait)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(coords,idcardCoords.x, idcardCoords.y, idcardCoords.z, true)
        if distance < 5.0 then
            wait = 0
            if distance < 1.0 then
                DrawText3D(idcardCoords.x, idcardCoords.y, idcardCoords.z, "[~g~E~s~] - Citizen ID [$50]")
                if IsControlJustReleased(0, 46) and not pressed then
                    if exports['dg-inventory']:hasEnoughOfItem('idcard', 1) then
                        pressed  = true
                        exports['mythic_notify']:SendAlert('error', 'You already have an ID card')
                    else
                        TriggerEvent('player:receiveItem', 'idcard', 1)
                    end
                    Citizen.Wait(2000)
                    pressed = false
                end
            end
        else
            wait = 100
        end
    end
end)

-------------
-----VASP----
-------------
--[[
local policeStashVASP = { x = -1102.8, y = -829.51, z = 14.28 }
local policeElockerVASP = {x = -1074.26, y = -823.42, z = 11.04}
local CapArmVASP = { x = -1106.69, y = -826.35, z = 14.28 }
local ArmVASP = { x = -1105.22, y = -821.57, z = 14.28 }

-- VASP Stash

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, policeStashVASP.x , policeStashVASP.y , policeStashVASP.z , false)
            if distance < 2.0 then
                DrawText3D(policeStashVASP.x, policeStashVASP.y, policeStashVASP.z, "[E] - Open Stash")
                if IsControlJustReleased(0, 86) then
                    TriggerEvent("server-inventory-open", "1", "Vaspucci-PD-Stash")
                end
            end
        end
    end
end)    

-- VASP Locker 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, policeElockerVASP.x, policeElockerVASP.y, policeElockerVASP.z, false)
            if distance < 2.0 then
                DrawText3D(policeElockerVASP.x, policeElockerVASP.y, policeElockerVASP.z, "[E] - Open Evidence Locker")
                if IsControlJustReleased(0, 86) then
                    TriggerEvent("server-inventory-open", "1", "Vaspucci-Evidence-Locker")
                end
            end
        end
    end
end)   

-- VASP Armory Captain +

Citizen.CreateThread(function()
    local pressed = false
    while true do 
        Citizen.Wait(10)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, CapArmVASP.x, CapArmVASP.y, CapArmVASP.z, false)
            if distance < 2.0 then
                DrawText3D(CapArmVASP.x, CapArmVASP.y, CapArmVASP.z, "[E] - Armory")
                if IsControlJustReleased(0, 86) and not pressed then
                    pressed = true
                    DGCore.TriggerServerCallback("ogrp_base:isAboveCaptain", function(isTrue)
                        if isTrue then
                            TriggerEvent("server-inventory-open", "10", "Shop")
                            pressed = false
                        else
                            exports['mythic_notify']:SendAlert('error', 'You don\'t have persmission to access')
                            Citizen.Wait(2000)
                            pressed = false
                        end
                    end)
                end
            end
        end
    end
end)    
 ]]--

-------------
-----MRPD----
-------------

local policeStashMRPD = { x = 448.31, y = -996.89, z = 30.69 }
local policeElockerMRPD = { x = 474.27, y = -990.7, z = 26.27 }
local CapArmMRPD = { x = 485.47, y = -995.23, z = 30.69 }
local normalArm = { x = 482.51, y = -995.2, z = 30.69 }
local MRPDCheck = { x = 452.56, y = -990.1, z = 30.69 }

-- MRPD GENERAL ARMORY --

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,normalArm.x,normalArm.y,normalArm.z,false)
        if distance <= 5.0 then
            wait = 0
            if distance <= 1.0 then
                DrawText3D(normalArm.x,normalArm.y,normalArm.z, "[~g~E~s~] - General Armory")
                if IsControlJustReleased(0, 86) and DGCore.PlayerData.job.name == 'police' then
                    Citizen.Wait(1)
                    TriggerEvent("server-inventory-open", "10", "Shop");	
                end
            end
        else
            wait = 100
        end
    end
end)

-- MRPD Armory Captain +

Citizen.CreateThread(function()
    local wait = 100
    pressed = false
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, CapArmMRPD.x, CapArmMRPD.y, CapArmMRPD.z, false)
            local grade = tonumber(DGCore.PlayerData.job.grade)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(CapArmMRPD.x, CapArmMRPD.y, CapArmMRPD.z, "[~g~E~s~] - High Command Armory")
                    if IsControlJustReleased(0, 86) and not pressed then
                        pressed = true
                        if grade > 6 then
                            TriggerEvent("server-inventory-open", "70", "Shop")
                            pressed = false
                        else
                            exports['mythic_notify']:SendAlert('error', 'Who do you think you are?')
                            Citizen.Wait(2000)
                            pressed = false
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)   

-- MRPD Stash

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, policeStashMRPD.x, policeStashMRPD.y, policeStashMRPD.z, false)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(policeStashMRPD.x, policeStashMRPD.y, policeStashMRPD.z, "[~g~E~s~] - Stash")
                    if IsControlJustReleased(0, 86) then
                        TriggerEvent("server-inventory-open", "1", "Stash-MR-PD-Stash")
                    end
                end
            else
                wait = 0
            end
        end
    end
end) 

-- MRPD Locker

Citizen.CreateThread(function()
    local wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, policeElockerMRPD.x, policeElockerMRPD.y, policeElockerMRPD.z, false)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(policeElockerMRPD.x, policeElockerMRPD.y, policeElockerMRPD.z, "[~g~E~s~] - Evidence Locker")
                    if IsControlJustReleased(0, 86) then
                        TriggerEvent("server-inventory-open", "1", "Stash-MRPD-Evidence-Locker")
                    end
                end
            else
                wait = 100
            end
        end
    end
end)    

-- MRPD Clock Room

-- Citizen.CreateThread(function()
--     local wait = 100
--     local pressed = false
--     while true do 
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') or (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'offpolice') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos, MRPDCheck.x, MRPDCheck.y, MRPDCheck.z, false)
--             if distance < 5.0 then
--                 wait = 0
--                 if distance < 1.0 then
--                     DrawText3D(MRPDCheck.x, MRPDCheck.y, MRPDCheck.z, "[~g~E~s~] - Toggle Duty")
--                     if IsControlJustReleased(0, 86) and not pressed  then
--                         pressed = true
--                         TriggerEvent('InteractSound_CL:PlayOnOne', 'dispatch', 0.4)
--                         TriggerServerEvent('duty:onoff')
--                         Citizen.Wait(3000)
--                         pressed = false
--                     end
--                 end
--             else
--                 wait = 100
--             end
--         end
--     end
-- end)  

-- Attachments menu 

local attechmentsCoords = {x = 487.24, y = -997.03, z = 30.69}

Citizen.CreateThread(function()
    local wait = 100
    local pressed = false
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, attechmentsCoords.x, attechmentsCoords.y, attechmentsCoords.z, false)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(attechmentsCoords.x, attechmentsCoords.y, attechmentsCoords.z, "[~g~E~s~] - Attach Attachments")
                    if IsControlJustReleased(0, 86) and not pressed  then
                        pressed = true
                        local weaponHash = GetSelectedPedWeapon(PlayerPedId())
                        weaponHash = tonumber(weaponHash)
                        if weaponHash then
                            print(weaponHash)
                            if weaponHash == 3219281620 then
                                GiveWeaponComponentToPed(PlayerPedId(), 3219281620, `COMPONENT_AT_PI_FLSH_02` )
                                TriggerEvent("notification", "Attachments Added")
                            end
                    
                            if weaponHash == 736523883 then
                                GiveWeaponComponentToPed( ped, 736523883, 'COMPONENT_AT_AR_FLSH' )
                                GiveWeaponComponentToPed( ped, 736523883, 'COMPONENT_AT_SCOPE_MACRO')	
                                TriggerEvent("notification", "Attachments Added")
                            end
                    
                            if weaponHash == -2084633992 then
                                GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_FLSH` )
                                GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_AFGRIP` )
                                GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_SCOPE_MEDIUM` )
                                TriggerEvent("notification", "Attachments Added")
                            end
                            if weaponHash == 1432025498 then
                                GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_SCOPE_MACRO_MK2` )
                                GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_AR_FLSH` )
                                TriggerEvent("notification", "Attachments Added")
                            end
                    
                            if weaponHash == 2024373456 then
                                GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_AR_FLSH` )
                                GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SIGHTS_SMG` )	
                                GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_MUZZLE_01` )
                                GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SB_BARREL_02` )	
                                TriggerEvent("notification", "Attachments Added")
                            end
                    
                            if weaponHash == -86904375 then
                    
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_MUZZLE_04` )
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_FLSH` )
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_SIGHTS` )
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_AFGRIP_02` )
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_CR_BARREL_02` )
                                GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER` )
                                TriggerEvent("notification", "Attachments Added")
                            end
                    
                            if weaponHash == -1075685676 then
                                GiveWeaponComponentToPed( ped, -1075685676, `COMPONENT_AT_PI_FLSH_02` )
                            end
                        end
                        Citizen.Wait(3000)
                        pressed = false
                    end
                end
            else
                wait = 100
            end
        end
    end
end) 

-- MRPD FIREARM LICENSE

local WeaponLicense = {x = 452.28, y = -975.41, z = 30.69}

Citizen.CreateThread(function()
    local wait = 100
    local pressed = false
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') or (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'offpolice') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, WeaponLicense.x, WeaponLicense.y, WeaponLicense.z, false)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(WeaponLicense.x, WeaponLicense.y, WeaponLicense.z, "[~g~E~s~] - Buy License")
                    if IsControlJustReleased(0, 86) and not pressed  then
                        pressed = true

                        local playerPed = PlayerPedId()
					    local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(playerPed), 6.0)
					    local closeplayers, i = {} , 0
                        
                        for k = 1, #players, 1 do
						    if players[k] ~= PlayerId() then
							    i = i + 1
							    closeplayers[i] = {value = GetPlayerServerId(players[k]) , label = GetPlayerServerId(players[k])}
					        end
					    end
                    
                        if closeplayers[1] ~= nil then
						    DGCore.UI.Menu.CloseAll()
						    DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'firearm', {
							    title    = 'Issue Firearm License',
							    align    = 'top-right',
							    elements = closeplayers
						    }, function(data, menu)
							    menu.close()
							    TriggerServerEvent('dg_issueLicense',data.current.value)
						    end, function(data, menu)
							    menu.close()
						    end)
					    else
						    exports['mythic_notify']:SendAlert('error', 'No player nearby')
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

RegisterNetEvent('dg_buyLicense')
AddEventHandler('dg_buyLicense', function()
    DGCore.UI.Menu.CloseAll()
    
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_glicense', {
		title = 'Buy Gun License',
		align = 'top-left',
		elements = {
			{label = 'no', value = 'no'},
			{label = 'yes', value = 'yes'},
        }
        
	}, function(data, menu)
        if data.current.value == 'yes' then
            DGCore.TriggerServerCallback('dg_license:checkLicense', function(hasWeaponLicense)
                if not hasWeaponLicense then
			        DGCore.TriggerServerCallback('dg:buyGunLicense', function(bought)
                        if bought then
                            menu.close()
                            exports['mythic_notify']:SendAlert('success', 'You received the gun license')
				        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'You already have a gun license')
                end
            end, GetPlayerServerId(PlayerId()), 'weapon')         
        else
            menu.close()
        end
	end, function(data, menu)
		menu.close()
	end)
end)

-- -- EMS CLOCK ROOM

-- local EMSCHECK = { x = 312.4, y = -593.88, z = 43.28 }

-- Citizen.CreateThread(function()
--     local wait = 200
--     local pressed = false
--     while true do 
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'ems') or (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'offems') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos, EMSCHECK.x, EMSCHECK.y, EMSCHECK.z, false)
--             if distance < 5.0 then
--                 wait = 0
--                 if distance < 1.0 then
--                     DrawText3D(EMSCHECK.x, EMSCHECK.y, EMSCHECK.z, "[~g~E~s~] - Toggle Duty")
--                     if IsControlJustReleased(0, 86) and not pressed  then
--                         pressed = true
--                         local finished = exports["dg-taskbar"]:taskBar(2000, "Reporting")
--                         TriggerEvent('InteractSound_CL:PlayOnOne', 'dispatch', 0.4)
--                         TriggerServerEvent('duty:onoff')
--                         pressed = false
--                     end
--                 end
--             else
--                 wait = 200
--             end
--         end
--     end
-- end)  

--EMS Stash
local emsstash = { x = 306.7097, y = -601.6841, z = 43.28408 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'ems') and DGCore.PlayerData.job.grade > 0 then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, emsstash.x, emsstash.y, emsstash.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(emsstash.x, emsstash.y, emsstash.z, "[~g~E~s~] - Open Stash")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-EMS-Stash")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- Recycle Craft

local recyclecraft = { x = 994.38, y = -3099.98, z = -38.99 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'recycle') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, recyclecraft.x, recyclecraft.y, recyclecraft.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(recyclecraft.x, recyclecraft.y, recyclecraft.z, "[~g~E~s~] - Make materials")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "57", "Craft")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)



-- Recycle Stash

local recycle = { x = 995.11, y = -3096.31, z = -39.0 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'recycle') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, recycle.x, recycle.y, recycle.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(recycle.x, recycle.y, recycle.z, "[~g~E~s~] - Open Stash")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-Recycle-Stash")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- burgershot Stash

local burgershotstash = { x = -1191.05, y = -903.48, z = 14.0 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mcd') and DGCore.PlayerData.job.grade > 0 then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, burgershotstash.x, burgershotstash.y, burgershotstash.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(burgershotstash.x, burgershotstash.y, burgershotstash.z, "[~g~E~s~] - Open Stash")
                    if distance < 1.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-mcd-Stash")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- burgershot Shop

local burgershotshop = { x = -1195.25, y = -891.61, z = 15.3 }

Citizen.CreateThread(function()
    wait = 100
    while true do 
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mcd') and DGCore.PlayerData.job.grade > 0 then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, burgershotshop.x, burgershotshop.y, burgershotshop.z, false)
            if distance < 10.0 then
                wait = 5
                if distance < 2.0 then
                    DrawText3D(burgershotshop.x, burgershotshop.y, burgershotshop.z, "[~g~E~s~] - Open Shop")
                    if distance < 3.0 then
                        if IsControlJustReleased(0, 86) then
                            TriggerEvent("server-inventory-open", "1", "Stash-burgershop-Shop")
                        end
                    end
                end
            else
                wait = 100
            end
        end
    end
end)

-- Cycle Rent

local cycle = {x = -1759.786, y = -760.475, z = 9.636102}

Citizen.CreateThread(function()
    
    local wait = 100
    local spawn = false

    while true do
        Citizen.Wait(wait)
        local ped = GetPlayerPed(-1)
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(pos, cycle.x, cycle.y, cycle.z, false)
        if distance < 20.0  and not spawn then
            wait = 0
            DrawMarker(38, cycle.x, cycle.y, cycle.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255,255,255, 100, 0, 0, 0, 0)
            if distance < 1.0 then
                DrawText3D(cycle.x, cycle.y, cycle.z+0.5, "[~g~E~s~] - Rent Bicycle")
                if IsControlJustReleased(0, 86) then
                    
                    spawn = true
                    RequestModel(GetHashKey('bmx'))
                    while not HasModelLoaded(GetHashKey('bmx')) do
						Wait(500)
                    end
                    
					local vehicle = CreateVehicle('bmx', cycle.x, cycle.y, cycle.z, GetEntityHeading(PlayerPedId()), true, false)
                    
                    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
					SetEntityAsNoLongerNeeded(vehicle)
					SetModelAsNoLongerNeeded(GetHashKey('bmx'))
					
                end
            end
        else
            wait = 100
        end
    end
end)


--- Buy Tow truck


-- local buyMcoords = {x = 483.33, y = -1889.7, z = 26.09, h = 294.62 }

-- Citizen.CreateThread(function()
    
--     local vk = {
--         ['towtruck'] = 3000,
--         ['towtruck2'] = 2000,
--         ['flatbed'] = 4000,
--     } 

--     local pressed = false
--     local wait = 100
--     while true do 
--         Citizen.Wait(wait)
--         if DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mechanic' then 
            
--             local player = GetPlayerPed(-1)
--             local playerCoords = GetEntityCoords(player)
--             local distance = Vdist(playerCoords, buyMcoords.x , buyMcoords.y , buyMcoords.z , false)
--             if distance < 15.0 then
--                 wait = 5
--                 DrawMarker(39, buyMcoords.x , buyMcoords.y , buyMcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 165, 0, 150, false, true, 2, false, nil, nil, nil)
--                 if distance < 2.0 then
--                     if not pressed then
--                         DrawText3D(buyMcoords.x , buyMcoords.y , buyMcoords.z+0.3, "[~g~ E ~s~] - Mechanic Vehicle Shop")
--                     end
--                     if IsControlJustPressed(0,46) and not pressed then
--                         pressed = true

--                         DGCore.UI.Menu.CloseAll()
    
-- 	                    DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'impound_shop', {
-- 	                    	title = 'Impound Shop',
-- 	                    	align = 'top-left',
--                             elements = {    
                                
--                                 {label = 'Tow Car ($2000)', value = 'towtruck2'},
--                                 {label = 'Tow Truck ($3000)', value = 'towtruck'},
--                                 {label = 'Flatbed ($4000)', value = 'flatbed'}

--                             }

--                         }, function(data, menu)
--                             menu.close()
--                             local vehicleName = data.current.value

--                             DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'impound_shop_buy', {
--                                 title = 'Buy '.. vehicleName,
--                                 align = 'top-left',
--                                 elements = {    
--                                     {label = 'No', value = 'no'},
--                                     {label = 'Yes', value = 'yes'},
--                                 }
    
--                             }, function(data2, menu2)


--                                 if data2.current.value == 'yes' then
--                                     menu2.close()
--                                     if IsAnyVehicleNearPoint( buyMcoords.x , buyMcoords.y , buyMcoords.z, 5.0) then
--                                         exports['mythic_notify']:SendAlert('error', 'Please clear the spawn area')
--                                     else
--                                         DGCore.TriggerServerCallback('ogrp_taxi:isVehicleTaken', function(cB)
--                                             if cB then
--                                                 DGCore.TriggerServerCallback('ndrp_pdm:checkmoney', function(hM)
--                                                     if hM then
                                                        
--                                                         RequestModel(vehicleName)
--                                                         while not HasModelLoaded(vehicleName) do
--                                                             Wait(500) 
--                                                         end
                                                    
--                                                         local vehicle = CreateVehicle(vehicleName, buyMcoords.x, buyMcoords.y, buyMcoords.z-0.50, buyMcoords.h , true, false)
--                                                         local vehicleProps = DGCore.Game.GetVehicleProperties(vehicle)
--                                                         TaskWarpPedIntoVehicle(player, vehicle, -1)
--                                                         SetEntityAsNoLongerNeeded(vehicle)
--                                                         SetModelAsNoLongerNeeded(vehicleName)
--                                                         TriggerServerEvent('ndrp_pdm:buycar',  vehicleProps, vk[vehicleName], true,0,0,0,vehicleName,vk[vehicleName],0)
--                                                     else
--                                                         exports['mythic_notify']:SendAlert('error', 'You don\'t have enough money to buy the vehicle')
--                                                     end
--                                                 end, vk[vehicleName])
--                                             else
--                                                 exports['mythic_notify']:SendAlert('error', 'You already own this vehicle!')  
--                                             end
--                                         end, vehicleName)
--                                     end
                                
--                                 else
--                                     menu2.close()
--                                 end

--                             end, function(data2, menu2)
--                                 menu2.close()
--                             end)
--                         end, function(data, menu)
--                             menu.close()
--                         end)

--                         Citizen.Wait(2000)
--                         pressed = false
--                     end
--                 end
--             else
--                 wait = 100
--             end

--         end
--     end
-- end)


-- NEWS Stash 

-- local wnStash = {x = -560.19, y = -912.05 , z = 33.24}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'news') and DGCore.PlayerData.job.grade > 1 then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos, wnStash.x, wnStash.y, wnStash.z, false)
--             if distance < 5.0 then
--                 wait = 0
--                 if distance < 1.0 then
--                     DrawText3D(wnStash.x, wnStash.y, wnStash.z, "[~g~E~s~] - Stash")
--                     if IsControlJustReleased(0, 86) then
--                         TriggerEvent("server-inventory-open", "1", "Stash-Weazel-News-Stash-1")
--                     end
--                 end
--             else
--                 wait = 0
--             end
--         end
--     end
-- end)

-- NEWS Stash 2

-- local wnStash2 = {x = -565.88, y = -917.36 , z = 33.24}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'news') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos, wnStash2.x, wnStash2.y, wnStash2.z, false)
--             if distance < 5.0 then
--                 wait = 0
--                 if distance < 1.0 then
--                     DrawText3D(wnStash2.x, wnStash2.y, wnStash2.z, "[~g~E~s~] - Public Stash")
--                     if IsControlJustReleased(0, 86) then
--                         TriggerEvent("server-inventory-open", "1", "Stash-Weazel-News-Stash-2")
--                     end
--                 end
--             else
--                 wait = 0
--             end
--         end
--     end
-- end)

-- -- Tuner Shop Crafting (Kits)

-- local tunCoords = {x = 968.82, y = -3002.37, z = -39.65}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,tunCoords.x,tunCoords.y,tunCoords.z,false)
--             if distance < 10.0 then
--                 wait = 0
--                 DrawMarker(27, tunCoords.x, tunCoords.y, tunCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(tunCoords.x,tunCoords.y,tunCoords.z, "[E] - Craft Upgrades")
--                     if IsControlJustReleased(0, 46) then
--                         DGCore.TriggerServerCallback('ogrp_mechanicjob:checkAccess', function(hasAccess)
--                             if hasAccess then 
--                                 TriggerEvent("server-inventory-open", "61", "Craft")     
--                             else
--                                 exports['mythic_notify']:SendAlert('error', 'You don\'t have access my friend')
--                             end
--                         end, 7)    
--                     end
--                 end
--             else
--                 wait = 100
--             end
--         end
--     end
-- end)

-- Vanilla Unicorn DJ

-- local djCoords = {x = 120.38, y = -1281.33, z = 29.49}

-- Citizen.CreateThread(function()
--     local wait = 100
--     local pressed = false
--     while true do
--         Citizen.Wait(wait)
--         local ped = GetPlayerPed(-1)
--         local pos = GetEntityCoords(ped)
--         local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,djCoords.x,djCoords.y,djCoords.z,false)
--         if distance < 10.0 then
--             wait = 0
--             if distance <= 1.2 then
--                 DrawText3D(djCoords.x,djCoords.y,djCoords.z, "[~g~E~s~] - Access DJ")
--                 if IsControlJustReleased(0, 46) and not pressed then
--                     pressed = true
--                     TriggerEvent('ndrp_emotes:playthisemote','dj')
--                     TriggerEvent('playdj')
--                     Citizen.Wait(2000)
--                     pressed = false
--                 end
--             end
--         else
--             wait = 100
--         end
--     end
-- end)

-- Black Market

local blackmarket = { x = -1583.341, y = -429.4407, z = 37.93999 }

Citizen.CreateThread(function()
    local wait = 100
    pressed = false
    while true do 
        Citizen.Wait(wait)
        --if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos, blackmarket.x, blackmarket.y, blackmarket.z, false)
            --local grade = tonumber(DGCore.PlayerData.job.grade)
            if distance < 5.0 then
                wait = 0
                if distance < 1.0 then
                    DrawText3D(blackmarket.x, blackmarket.y, blackmarket.z, "[~g~E~s~] - Talk with dealer (Access Blackmarket)")
                    if IsControlJustReleased(0, 86) and not pressed then
                        pressed = true
                        exports['mythic_progbar']:Progress({
							name = "Blackmarket Dealer",
							duration = 20000,
							label = 'Talking with Dealer',
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
								TriggerEvent("server-inventory-open", "81", "Shop")
                                pressed = false
							end
						end)
                    end
                end
            else
                wait = 100
            end
    end
end)

local blackmarketped
Citizen.CreateThread(function()

    local hashkey = GetHashKey("a_m_y_soucent_02")

	RequestModel(hashkey)
	while not HasModelLoaded(hashkey) do Wait(1) end

	blackmarketped = CreatePed(1, hashkey, -1583.173, -428.3307, 36.94001, 156.6498260498, false, true)
	SetBlockingOfNonTemporaryEvents(blackmarketped, true)
	SetPedDiesWhenInjured(blackmarketped, false)
	SetPedCanPlayAmbientAnims(blackmarketped, true)
	SetPedCanRagdollFromPlayerImpact(blackmarketped, false)
	SetEntityInvincible(blackmarketped, true)
	FreezeEntityPosition(blackmarketped, true)
    --TaskStartScenarioInPlace(gold_exchange, 'weed', 0, true);

end)



-- Grocery Shop

 local groceryShop = {x = 1791.27, y = 4592.847, z = 37.68294, h=197.11668395996}
-- local veggieShop = {x = -1375.4, y = -688.81, z = 24.82}
function CreateGroceryMerchant()

    local hashKey = `a_m_m_farmer_01`
    local pedType = 1
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end

	merchantPed = CreatePed(pedType, hashKey, groceryShop.x,groceryShop.y,groceryShop.z-1, groceryShop.h, 0, 0)
	
    ClearPedTasks(merchantPed)
    ClearPedSecondaryTask(merchantPed)
    TaskSetBlockingOfNonTemporaryEvents(merchantPed, true)
    SetPedFleeAttributes(merchantPed, 0, 0)
    SetPedCombatAttributes(merchantPed, 17, 1)
    SetPedSeeingRange(merchantPed, 0.0)
    SetPedHearingRange(merchantPed, 0.0)
    SetPedAlertness(merchantPed, 0)
    SetPedKeepTask(merchantPed, true)
	SetEntityInvincible(merchantPed, true)
    FreezeEntityPosition(merchantPed, true)
	
end

Citizen.CreateThread(function()
    local wait = 100
    DeletePed(merchantPed)
    CreateGroceryMerchant()
	local pressed = false
    while true do
        Citizen.Wait(wait)
		if DGCore.PlayerData then
        	local ped = GetPlayerPed(-1)
        	local pos = GetEntityCoords(ped)
        	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,groceryShop.x,groceryShop.y,groceryShop.z,false)
        	if distance <= 5.0 then
            	wait = 0
            	if distance <= 1.0 then
                	DrawText3D(groceryShop.x,groceryShop.y,groceryShop.z, "[~g~E~s~] - Grocery Shop")
                	if IsControlJustReleased(0, 86) and not pressed then
						pressed = true
                    	TriggerEvent("server-inventory-open", "84", "Shop");
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

-- Citizen.CreateThread(function()
--     local wait = 100
-- 	local pressed = false
--     while true do
--         Citizen.Wait(wait)
-- 		if DGCore.PlayerData then
--         	local ped = GetPlayerPed(-1)
--         	local pos = GetEntityCoords(ped)
--         	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,veggieShop.x,veggieShop.y,veggieShop.z,false)
--         	if distance <= 5.0 then
--             	wait = 0
--             	if distance <= 1.0 then
--                 	DrawText3D(veggieShop.x,veggieShop.y,veggieShop.z, "[~g~E~s~] - Buy Essentials")
--                 	if IsControlJustReleased(0, 86) and not pressed then
-- 						pressed = true
--                     	TriggerEvent("server-inventory-open", "85", "Shop");
-- 						Citizen.Wait(2000)
-- 						pressed = false	
-- 					end
--             	end
--         	else
--             	wait = 100
--        		end
--     	end
-- 	end
-- end)

-- Burgershot

local mcdShop = {x = -1191.88, y = -894.17, z = 14.0}
local mcdCookingStation = {x = -1202.19, y = -896.83, z = 14.0}

Citizen.CreateThread(function()
    local wait = 100
	local pressed = false
    while true do
        Citizen.Wait(wait)
		if DGCore.PlayerData then
        	local ped = GetPlayerPed(-1)
        	local pos = GetEntityCoords(ped)
        	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,mcdShop.x,mcdShop.y,mcdShop.z,false)
        	if distance <= 5.0 then
            	wait = 0
            	if distance <= 1.0 then
                	DrawText3D(mcdShop.x,mcdShop.y,mcdShop.z, "[~g~E~s~] - Buy Food")
                	if IsControlJustReleased(0, 86) and not pressed then
						pressed = true
                    	TriggerEvent("server-inventory-open", "82", "Shop");
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

-- McDonald

local mcdShop = {x = 280.0417, y = -971.0593, z = 29.3}

Citizen.CreateThread(function()
    local wait = 100
	local pressed = false
    while true do
        Citizen.Wait(wait)
		if DGCore.PlayerData then
        	local ped = GetPlayerPed(-1)
        	local pos = GetEntityCoords(ped)
        	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,mcdShop.x,mcdShop.y,mcdShop.z,false)
        	if distance <= 5.0 then
            	wait = 0
            	if distance <= 1.0 then
                	DrawText3D(mcdShop.x,mcdShop.y,mcdShop.z, "[~g~E~s~] - Buy Food")
                	if IsControlJustReleased(0, 86) and not pressed then
						pressed = true
                    	TriggerEvent("server-inventory-open", "110", "Shop");
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


-- Citizen.CreateThread(function()
--     local wait = 100
-- 	local pressed = false
--     while true do
--         Citizen.Wait(wait)
-- 		if DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mcd' then
--         	local ped = GetPlayerPed(-1)
--         	local pos = GetEntityCoords(ped)
--         	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,mcdCookingStation.x,mcdCookingStation.y,mcdCookingStation.z,false)
--         	if distance <= 5.0 then
--             	wait = 0
--             	if distance <= 1.0 then
--                 	DrawText3D(mcdCookingStation.x,mcdCookingStation.y,mcdCookingStation.z, "[~g~E~s~] - Start Cooking")
--                 	if IsControlJustReleased(0, 86) and not pressed then
-- 						pressed = true
--                         TriggerEvent("ndrp_emotes:playthisemote", 'bbq')
--                         local stage1 = exports["dg-taskbar"]:taskBar(10*1000, "Cooking")
--                         TriggerEvent("ndrp_emotes:playthisemote", 'c')
--                     	TriggerEvent("server-inventory-open", "83", "Craft");
-- 						Citizen.Wait(2000)
-- 						pressed = false	
-- 					end
--             	end
--         	else
--             	wait = 100
--        		end
--     	end
-- 	end
-- end)

-- Citizen.CreateThread(function()
--     local wait = 100
--     pressed = false
--     while true do 
--         Citizen.Wait(wait)
--         if DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mcd' then
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,mcdCookingStation.x,mcdCookingStation.y,mcdCookingStation.z,false)
--             local grade = tonumber(DGCore.PlayerData.job.grade)
--             if distance <= 5.0 then
--                 wait = 0
--                 if distance <= 1.0 then
--                     DrawText3D(mcdCookingStation.x,mcdCookingStation.y,mcdCookingStation.z, "[~g~E~s~] - Start Cooking")
--                     if IsControlJustReleased(0, 86) and not pressed then
--                         pressed = true
--                         if grade > 0 then
--                             TriggerEvent("ndrp_emotes:playthisemote", 'bbq')
--                             local stage1 = exports["dg-taskbar"]:taskBar(10*1500, "Cooking")
--                             TriggerEvent("ndrp_emotes:playthisemote", 'c')
--                             TriggerEvent("server-inventory-open", "83", "Craft");
--                             Citizen.Wait(2000)
--                             pressed = false
--                         else
--                             exports['mythic_notify']:SendAlert('error', 'You don\'t need to cook!')
--                             Citizen.Wait(2000)
--                             pressed = false
--                         end
--                     end
--                 end
--             else
--                 wait = 100
--             end
--         end
--     end
-- end)  

--- Best Buds Stash

-- local bestbudsstash = {x = 374.64, y = -816.86, z = 29.3}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         local ped = GetPlayerPed(-1)
--         local pos = GetEntityCoords(ped)
--         local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,bestbudsstash.x,bestbudsstash.y,bestbudsstash.z,false)
--         if distance <= 5.0 then
--             wait = 0
--             if distance <= 1.0 then
--                 DrawText3D(bestbudsstash.x,bestbudsstash.y,bestbudsstash.z, "[~g~E~s~] - Storage")
--                 if IsControlJustReleased(0, 86) and DGCore.PlayerData.job.name == 'bestbuds' then
--                     Citizen.Wait(1)
--                     TriggerEvent("server-inventory-open", "1", "Stash-Bestbuds")
--                 end
--             end
--         else
--             wait = 100
--         end
--     end
-- end)

--- Best Buds Shop

-- local bestbudsshop = {x = 376.46, y = -828.22, z = 29.3}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         local ped = GetPlayerPed(-1)
--         local pos = GetEntityCoords(ped)
--         local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,bestbudsshop.x,bestbudsshop.y,bestbudsshop.z,false)
--         if distance <= 5.0 then
--             wait = 0
--             if distance <= 1.0 then
--                 DrawText3D(bestbudsshop.x,bestbudsshop.y,bestbudsshop.z, "[~g~E~s~] - Buy Item")
--                 if IsControlJustReleased(0, 86) and not pressed then
--                     pressed = true
--                     TriggerEvent("server-inventory-open", "96", "Shop");
--                     Citizen.Wait(2000)
--                     pressed = false	
--                 end
--             end
--         else
--             wait = 100
--         end
--     end
-- end)

--- Best Buds Craft

-- local bestbudscraft = {x = 380.8, y = -819.75, z = 29.3}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         local ped = GetPlayerPed(-1)
--         local pos = GetEntityCoords(ped)
--         local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,bestbudscraft.x,bestbudscraft.y,bestbudscraft.z,false)
--         if distance <= 5.0 then
--             wait = 0
--             if distance <= 1.0 then
--                 DrawText3D(bestbudscraft.x,bestbudscraft.y,bestbudscraft.z, "[~g~E~s~] - Craft Item")
--                 if IsControlJustReleased(0, 86) and not pressed and DGCore.PlayerData.job.name == 'bestbuds' then
--                     pressed = true
--                     TriggerEvent("server-inventory-open", "97", "Craft");
--                     Citizen.Wait(2000)
--                     pressed = false	
--                 end
--             end
--         else
--             wait = 100
--         end
--     end
-- end)

-- BurgerShot Stash

-- local burgershotstash = {x = -1197.01, y = -893.85, z = 14.0}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         local ped = GetPlayerPed(-1)
--         local pos = GetEntityCoords(ped)
--         local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,burgershotstash.x,burgershotstash.y,burgershotstash.z,false)
--         if distance <= 5.0 then
--             wait = 0
--             if distance <= 1.0 then
--                 DrawText3D(burgershotstash.x,burgershotstash.y,burgershotstash.z, "[~g~E~s~] - Storage")
--                 if IsControlJustReleased(0, 86) and DGCore.PlayerData.job.name == 'mcd' then
--                     Citizen.Wait(1)
--                     TriggerEvent("server-inventory-open", "1", "Stash-BurgerShot")
--                 end
--             end
--         else
--             wait = 100
--         end
--     end
-- end)

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

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Citizen.Wait(0) 
    end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end