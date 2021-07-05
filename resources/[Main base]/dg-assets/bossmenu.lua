DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(0)
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

-- EMS JOB

local emsCoords = {x = 359.27, y = -599.46, z = 43.28}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'ambulance') then
            
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,emsCoords.x,emsCoords.y,emsCoords.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, emsCoords.x, emsCoords.y, emsCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(emsCoords.x,emsCoords.y,emsCoords.z, "[E] - Open Boss Menu")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('dg_society:openBossMenu', 'ambulance')
                    end
                end
            end
        end
    end
end)

-- POLICE JOB

local policeCoords = {x = 462.24, y = -985.41, z = 30.73}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'police') then
            
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,policeCoords.x,policeCoords.y,policeCoords.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, policeCoords.x, policeCoords.y, policeCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(policeCoords.x,policeCoords.y,policeCoords.z, "[E] - Open Boss Menu")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('dg_society:openBossMenu', 'police')
                    end
                end
            end
        end
    end
end)


-- NEWS JOB

-- local newsCoords = {x = -576.67, y = -938.47, z = 28.82}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'news') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,newsCoords.x,newsCoords.y,newsCoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, newsCoords.x, newsCoords.y, newsCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(newsCoords.x,newsCoords.y,newsCoords.z, "[E] - Open Boss Menu")
--                     if IsControlJustReleased(0, 46) then
--                         TriggerEvent('dg_society:openBossMenu', 'news')
--                     end
--                 end
--             end
--         end
--     end
-- end)

-- PDM JOB

local pdmCoords = {x = -31.35, y = -1106.75, z = 26.42}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'pdm') then
            
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,pdmCoords.x,pdmCoords.y,pdmCoords.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, pdmCoords.x, pdmCoords.y, pdmCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(pdmCoords.x,pdmCoords.y,pdmCoords.z, "[E] - Open Boss Menu")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('dg_society:openBossMenu', 'pdm')
                    end
                end
            end
        end
    end
end)

-- Recycle JOB

local recycleCoords = {x = 992.91, y = -3102.98, z = -39.0}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'recycle') then
            
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,recycleCoords.x,recycleCoords.y,recycleCoords.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, recycleCoords.x, recycleCoords.y, recycleCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(recycleCoords.x,recycleCoords.y,recycleCoords.z, "[E] - Open Boss Menu")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('dg_society:openBossMenu', 'recycle')
                    end
                end
            end
        end

    end
end)

-- Mechanic JOB


local mechanicCoords = {x = 992.91, y = -3102.98, z = -39.0}

Citizen.CreateThread(function()
    local wait = 100
    while true do
        Citizen.Wait(wait)
        
        if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mechanic') then
            
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,mechanicCoords.x,mechanicCoords.y,mechanicCoords.z,false)
            if distance < 10.0 then
                wait = 5
                DrawMarker(27, mechanicCoords.x, mechanicCoords.y, mechanicCoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
                if distance <= 1.2 then
                    DrawText3D(mechanicCoords.x,mechanicCoords.y,mechanicCoords.z, "[E] - Open Boss Menu")
                    if IsControlJustReleased(0, 46) then
                        TriggerEvent('dg_society:openBossMenu', 'recycle')
                    end
                end
            end
        end

    end
end)

-- Best Buds Job

-- local bestbudscoords = {x = 376.37, y = -823.59, z = 29.3}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
        
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'bestbuds') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,bestbudscoords.x,bestbudscoords.y,bestbudscoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, bestbudscoords.x, bestbudscoords.y, bestbudscoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(bestbudscoords.x,bestbudscoords.y,bestbudscoords.z, "[E] - Open Boss Menu")
--                     if IsControlJustReleased(0, 46) then
--                         TriggerEvent('dg_society:openBossMenu', 'bestbuds')
--                     end
--                 end
--             end
--         end

--     end
-- end)

-- BurgerShot Job

-- local burgershotcoords = {x = -1193.21, y = -901.13, z = 14.0}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
        
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'mcd') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,burgershotcoords.x,burgershotcoords.y,burgershotcoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, burgershotcoords.x, burgershotcoords.y, burgershotcoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(burgershotcoords.x,burgershotcoords.y,burgershotcoords.z, "[E] - Open Boss Menu")
--                     if IsControlJustReleased(0, 46) then
--                         TriggerEvent('dg_society:openBossMenu', 'mcd')
--                     end
--                 end
--             end
--         end

--     end
-- end)

-- Beanmachine Job

-- local beanmachinecoords = {x = 283.9, y = -978.5, z = 29.42}

-- Citizen.CreateThread(function()
--     local wait = 100
--     while true do
--         Citizen.Wait(wait)
        
--         if (DGCore.PlayerData.job ~= nil) and (DGCore.PlayerData.job.name == 'beanmachine') then
            
--             local ped = GetPlayerPed(-1)
--             local pos = GetEntityCoords(ped)
--             local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,beanmachinecoords.x,beanmachinecoords.y,beanmachinecoords.z,false)
--             if distance < 10.0 then
--                 wait = 5
--                 DrawMarker(27, beanmachinecoords.x, beanmachinecoords.y, beanmachinecoords.z-0.95, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 105, 155, 0, 0, 2, 0, 0, 0, 0)
--                 if distance <= 1.2 then
--                     DrawText3D(beanmachinecoords.x,beanmachinecoords.y,beanmachinecoords.z, "[E] - Open Boss Menu")
--                     if IsControlJustReleased(0, 46) then
--                         TriggerEvent('dg_society:openBossMenu', 'beanmachine')
--                     end
--                 end
--             end
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