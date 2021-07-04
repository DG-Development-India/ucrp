local spawnedWeeds = 0
local cokePlants = {}
local isPickingUp, isProcessing = false, false
DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	DGCore.PlayerData = DGCore.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeField.coords, true) < 50 then
			SpawnWeedPlants()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		for i=1, #cokePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cokePlants[i]), false) < 1 then
				nearbyObject, nearbyID = cokePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			if not isPickingUp then
				Draw2DText(0.06, 0.50, 'Press ~r~[E]~w~ to collect leaves', 0.4)
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				FreezeEntityPosition(playerPed, true)
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
				if not exports["dg-taskbar"]:taskBar(2000, 'Cutting coca leaves') then
					exports['mythic_notify']:SendAlert('error', 'Already doing an action!')
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					isPickingUp = false
				else
					ClearPedTasks(playerPed)
					Citizen.Wait(1500)
					FreezeEntityPosition(playerPed, false)
					DGCore.Game.DeleteObject(nearbyObject)
					table.remove(cokePlants, nearbyID)
					spawnedWeeds = spawnedWeeds - 1
					local randomchance = math.random(1,100)
					TriggerEvent('player:receiveItem', 'cocaleaves', 1)
					-- if randomchance > 50 and randomchance <= 90 then
						-- if math.random(1,2) == 1 then
							-- TriggerEvent('player:receiveItem', 'lowgrademaleseed', 1)
						-- else
							-- TriggerEvent('player:receiveItem', 'lowgradefemaleseed', 1)
						-- end
					-- elseif randomchance > 90 then
						-- if math.random(1,2) == 1 then
							-- TriggerEvent('player:receiveItem', 'highgrademaleseed', 1)
						-- else
							-- TriggerEvent('player:receiveItem', 'highgradefemaleseed', 1)
						-- end
					-- end
					isPickingUp = false
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cokePlants) do
			DGCore.Game.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 25 do
		Citizen.Wait(0)
		local cokeCoords = GenerateWeedCoords()
		DGCore.Game.SpawnLocalObject('prop_coke_02', cokeCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
			table.insert(cokePlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true
		for k, v in pairs(cokePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CokeField.coords, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)
		local cokeCoordX, cokeCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-90, 90)
		Citizen.Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-90, 90)
		cokeCoordX = Config.CircleZones.CokeField.coords.x + modX
		cokeCoordY = Config.CircleZones.CokeField.coords.y + modY
		local coordZ = GetCoordZ(cokeCoordX, cokeCoordY)
		local coord = vector3(cokeCoordX, cokeCoordY, coordZ)
		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 43.0
end

--- Cocaine Processing System ---

local pressed = false
local cokeProcessCoords = {['x'] = 1092.875, ['y'] = -3194.929, ['z'] = -38.99347}

Citizen.CreateThread(function()
    local wait = 100
	local pressed = false
    while true do
        Citizen.Wait(wait)
		if DGCore.PlayerData then
        	local ped = GetPlayerPed(-1)
        	local pos = GetEntityCoords(ped)
        	local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,cokeProcessCoords.x,cokeProcessCoords.y,cokeProcessCoords.z,false)
        	if distance <= 5.0 then
            	wait = 0
            	if distance <= 1.0 then
                	DrawText3D(cokeProcessCoords.x,cokeProcessCoords.y,cokeProcessCoords.z, "[~g~E~s~] - Process")
                	if IsControlJustReleased(0, 86) and not pressed then
						if exports['dg-inventory']:hasEnoughOfItem('cocaleaves', 3) and exports['dg-inventory']:hasEnoughOfItem('smallscales', 1) and exports['dg-inventory']:hasEnoughOfItem('emptybaggies', 1) then
							pressed = true
                    		cokeprocessing()
							Citizen.Wait(2000)
							pressed = false	
						else
							exports['mythic_notify']:SendAlert('error', 'Not Enough items')
						end
					end
            	end
        	else
            	wait = 100
       		end
    	end
	end
end)

function cokeprocessing()
	local player = GetPlayerPed(-1)
	SetEntityHeading(player, 180.07)
	FreezeEntityPosition(player, true)
    exports['mythic_progbar']:Progress({
        name = "Coke Processing",
        duration = 20000,
        label = 'Processing cocaine',
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,
        },
        animation = {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 49,
        }
    }, function(cancelled)
        if not cancelled then
            if exports['dg-inventory']:hasEnoughOfItem('cocaleaves', 3) and exports['dg-inventory']:hasEnoughOfItem('smallscales', 1) and exports['dg-inventory']:hasEnoughOfItem('emptybaggies', 1) then
                TriggerEvent("inventory:removeItem","cocaleaves", 3)
                TriggerEvent("inventory:removeItem","emptybaggies", 1)
                TriggerEvent('player:receiveItem', "cocaine", 1)
            else
                exports['mythic_notify']:SendAlert('error', 'Not Enough items')
            end
        end
    end)
	FreezeEntityPosition(player, false)
end


--- end of Weed Processing System ---

--- DrawText Function ---

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

function Draw2DText(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
	SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end