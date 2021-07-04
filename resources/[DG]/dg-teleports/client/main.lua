DGCore                           = nil
local PlayerData              = {}

Citizen.CreateThread(function ()
    while DGCore == nil do
        TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(1)
    end

    while DGCore.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = DGCore.GetPlayerData()
    LoadMarkers()
end) 

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
    PlayerData.job = job
end)

function LoadMarkers()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            local plyCoords = GetEntityCoords(PlayerPedId())
            for location, val in pairs(Config.Teleporters) do

                local Enter = val['Enter']
                local Exit = val['Exit']
                local JobNeeded = val['Job']

                local dstCheckEnter, dstCheckExit = GetDistanceBetweenCoords(plyCoords, Enter['x'], Enter['y'], Enter['z'], Enter['r'], Enter['g'], Enter['b'], true), GetDistanceBetweenCoords(plyCoords, Exit['x'], Exit['y'], Exit['z'], true)

                if dstCheckEnter <= 5.0 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then
                            DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'], Enter['r'], Enter['g'], Enter['b'])
                            if dstCheckEnter <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'enter')
                                end
                            end
                        end
                    else
                        DrawM(Enter['Information'], 27, Enter['x'], Enter['y'], Enter['z'], Enter['r'], Enter['g'], Enter['b'])
                        if dstCheckEnter <= 1.2 then
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'enter')
                            end
                        end

                    end
                end

                if dstCheckExit <= 5.0 then
                    if JobNeeded ~= 'none' then
                        if PlayerData.job.name == JobNeeded then
                            DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'],Exit['r'], Exit['g'], Exit['b'])
                            if dstCheckExit <= 1.2 then
                                if IsControlJustPressed(0, 38) then
                                    Teleport(val, 'exit')
                                end
                            end
                        end
                    else

                        DrawM(Exit['Information'], 27, Exit['x'], Exit['y'], Exit['z'],Exit['r'], Exit['g'], Exit['b'])
                        if dstCheckExit <= 1.2 then
                            if IsControlJustPressed(0, 38) then
                                Teleport(val, 'exit')
                            end
                        end
                    end
                end

            end

        end

    end)
end

function Teleport(table, location)
    if location == 'enter' then
        DoScreenFadeOut(1500)
        Citizen.Wait(750)
        DGCore.Game.Teleport(PlayerPedId(), table['Exit'])
        DoScreenFadeIn(1500)
    else
        DoScreenFadeOut(1500)
        Citizen.Wait(750)
        DGCore.Game.Teleport(PlayerPedId(), table['Enter'])
        DoScreenFadeIn(1500)
    end
end

RegisterCommand('enter', function(source, args)
	
	local coords = GetEntityCoords(PlayerPedId())
	-- local blackEnter = GetDistanceBetweenCoords(coords, vector3(1010.34, -2288.55, 30.51), true)
	-- local blackExit = GetDistanceBetweenCoords(coords, vector3(179.05, -1000.14, -99.0), true)
    -- local cashEnter = GetDistanceBetweenCoords(coords, vector3(512.18, -1479.8, 29.29), true)
	-- local cashExit = GetDistanceBetweenCoords(coords, vector3(514.73, -1466.51, -2.78), true)
    -- local gunEnter = GetDistanceBetweenCoords(coords, vector3(734.26, -1311.13, 26.99), true)
	-- local gunExit = GetDistanceBetweenCoords(coords, vector3(740.08, -1300.38, -50.56), true)
    local cocEnter = GetDistanceBetweenCoords(coords, vector3(48.21037, 6306.168, 31.49607), true)
	local cocExit = GetDistanceBetweenCoords(coords, vector3(1088.74, -3187.61, -38.99), true)
    local weedEnter = GetDistanceBetweenCoords(coords, vector3(1334.506, 4306.836, 38.23389), true)
	local weedExit = GetDistanceBetweenCoords(coords, vector3(1066.36, -3183.46, -39.16), true)
    local methEnter = GetDistanceBetweenCoords(coords, vector3(-237.3168, -2667.097, 8.875904), true)
	local methExit = GetDistanceBetweenCoords(coords, vector3(997.0199, -3200.684, -36.39373), true)

	-- if blackEnter < 0.7 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(179.12, -1000.13, -99.0), false, false, false, false)
	-- elseif blackExit < 0.7 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(1010.34, -2288.55, 30.51), false, false, false, false)
	-- end
    
    -- if cashEnter < 0.5 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(514.73, -1466.51, -4.4), false, false, false, false)
	-- elseif cashExit < 0.5 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(512.18, -1479.8, 29.29), false, false, false, false)
	-- end

    -- if gunEnter < 0.5 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(740.08, -1300.38, -50.56), false, false, false, false)
	-- elseif gunExit < 0.5 then
	-- 	SetEntityCoords(PlayerPedId(), vector3(734.26, -1311.13, 26.99), false, false, false, false)
	-- end

    if cocEnter < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(1088.74, -3187.61, -38.99), false, false, false, false)
	elseif cocExit < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(48.21037, 6306.168, 31.49607), false, false, false, false)
	end

    if weedEnter < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(1066.36, -3183.46, -39.16), false, false, false, false)
	elseif weedExit < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(1334.506, 4306.836, 38.23389), false, false, false, false)
	end

    if methEnter < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(997.0199, -3200.684, -36.39373), false, false, false, false)
	elseif methExit < 0.5 then
		SetEntityCoords(PlayerPedId(), vector3(-237.3168, -2667.097, 8.875904), false, false, false, false)
	end

end, false)


function DrawM(hint, type, x, y, z, r, g, b)
    DrawText3Ds(x,y,z+1, hint)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, r, g, b, 100, false, true, 2, false, false, false, false)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.70, 0.35)
    SetTextFont(6)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 900
end