DGCore = nil
local spawnedCars = {}
local testvehicle = 0
local hasMoney = false
local commision = 10
local connected = false
local buying = false
local buyingd = false
local clickedbuy = false

local slotsOccupiedBy = {
	--           -------- Rotation 1 --------
	-- { slot = 1, 		cat= 'cars', 		model = 	'evo9', 				price =  	300000,			spawned = true},
	-- { slot = 2, 		cat= 'bikes', 		model = 	'fatboy',  				price =  	120000,			spawned = true},
	-- { slot = 3,		cat= 'bikes', 		model= 		'hcbr17',  				price = 	75000,			spawned = true},
	-- { slot = 4, 		cat= 'bikes', 		model = 	'hexer',  				price =  	60000,			spawned = true},
	-- { slot = 5, 		cat= 'bikes',		model = 	'sovereign', 			price =  	110000,			spawned = true},
	-- { slot = 6, 		cat= 'big',			model  = 	'nissantitan17',  		price = 	250000,			spawned = true},
	          -------- Rotation 2 --------
	{ slot = 1,       cat= 'cars', 	        model = 	'accord20', 			price =  	550000,			spawned = true},
	{ slot = 2, 	  cat= 'bikes', 		model = 	'HDIron883',  		price =  	200000,			spawned = true},
	{ slot = 3,	      cat= 'bikes', 	    model= 		'HDIron883',  		price = 	150000,			spawned = true},
	{ slot = 4,       cat= 'bikes', 		model = 	'HDIron883',  			price =  	80000,			spawned = true},
	{ slot = 5, 	  cat= 'bikes',		    model = 	'HDIron883', 			price =  	200000,			spawned = true},
	{ slot = 6, 	  cat= 'big',			model  = 	'a8fsi',  			price = 	435000,			spawned = true},
}

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
    end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
	DGCore.PlayerData = xPlayer
	TriggerServerEvent('ndrp_edm:spawnDefaultS',11,false)
end)


RegisterNetEvent('ndrp_edm:spawnDefaultC')
AddEventHandler('ndrp_edm:spawnDefaultC', function(tab,slot,status)
	local slots = Config.slots
	if status then
		connected = false
	end
	if slot == 11 and not connected then
		connected = true
		for k,v in pairs(tab) do
			Citizen.Wait(100)
			local xVehicle = GetClosestVehicle(slots[k].pos , 2.0, 0, 71)
			if xVehicle >= 0 then
				DGCore.Game.DeleteVehicle(xVehicle)
			end
			local hash = GetHashKey(v.model)
			while not HasModelLoaded(hash) do
				Citizen.Wait(10)
				RequestModel(hash)
			end
			DGCore.Game.SpawnLocalVehicle(hash, slots[k].pos, slots[k].heading, function(vehicle)
				Citizen.Wait(50)
				SetEntityAsMissionEntity(vehicle, true, true)
				SetVehicleOnGroundProperly(vehicle)
				Citizen.Wait(50)
				if v.model == 'trhawk' then
					SetVehicleExtra (vehicle , 2 , true)
				end
				FreezeEntityPosition(vehicle, true)
				SetEntityInvincible(vehicle, true)
				SetModelAsNoLongerNeeded(hash)
				SetVehicleDirtLevel(vehicle, 0.1)
				SetVehicleOnGroundProperly(vehicle)
				SetVehicleDoorsLocked(vehicle, 2)
			end)
		end
	else
		Citizen.Wait(100)
		local xVehicle = 0
		if slots[slot] ~= nil then
			xVehicle = GetClosestVehicle(slots[slot].pos , 3.0, 0, 71)
		end
			
		if xVehicle >= 0 then
			DGCore.Game.DeleteVehicle(xVehicle)
		end

		if tab[slot] ~= nil then
			local hash = GetHashKey(tab[slot].model)
			while not HasModelLoaded(hash) do
				Citizen.Wait(10)
				RequestModel(hash)
			end

			slotsOccupiedBy[slot].cat = tab[slot].cat
			slotsOccupiedBy[slot].price = tab[slot].price
			slotsOccupiedBy[slot].model = tab[slot].model
			slotsOccupiedBy[slot].spawned = true

			DGCore.Game.SpawnLocalVehicle(hash, slots[slot].pos, slots[slot].heading, function(vehicle)
				Citizen.Wait(50)
				SetEntityAsMissionEntity(vehicle, true, true)
				SetVehicleOnGroundProperly(vehicle)
				Citizen.Wait(50)
				if tab[slot].model == 'trhawk' then
					SetVehicleExtra (vehicle , 2 , true)
				end
				FreezeEntityPosition(vehicle, true)
				SetEntityInvincible(vehicle, true)
				SetModelAsNoLongerNeeded(hash)
				SetVehicleDirtLevel(vehicle, 0.1)
				SetVehicleOnGroundProperly(vehicle)
				SetVehicleDoorsLocked(vehicle, 2)
			end)
		end
	end
end)


-- RegisterCommand('acar', function(source, args)
--     if checkStage == 0 then
		
-- 		DGCore.TriggerServerCallback("dg_marker:fetchUserRank", function(playerRank)
-- 			if playerRank == "admin" or playerRank == "superadmin" then
-- 				checkStage = 1 
-- 			else
-- 				checkStage = 2
-- 			end
-- 		end)

-- 	elseif checkStage == 1 then

-- 	    local playerPed = GetPlayerPed(-1)
-- 		local model = args[1]
-- 		local generatedPlate = exports['dg_pdm']:GeneratePlate()
-- 		Citizen.Wait(50)
-- 		RequestModel(model)
-- 		while not HasModelLoaded(model) do
-- 			Wait(10)
-- 		end
-- 		local buyveh  = CreateVehicle(hash, GetEntityCoords(playerPed), GetEntityHeading(playerPed), true, true)
-- 		SetVehicleNumberPlateText(buyveh, generatedPlate)
-- 		Citizen.Wait(50)
-- 		local vehicleProps = DGCore.Game.GetVehicleProperties(buyveh)
-- 		Citizen.Wait(20)
-- 		TriggerServerEvent('ndrp_edm:buycar',  vehicleProps, 0, model)
-- 		TriggerEvent('ndrp_carkeys:carkeys',buyveh)
-- 		TaskWarpPedIntoVehicle(playerPed, buyveh, -1)
-- 		exports['mythic_notify']:SendAlert('success', 'You owned this vehicle now!')
--     end
-- end)

Citizen.CreateThread(function()
	local delay = 100
	local slots = Config.slots
	
	while true do
		
		Citizen.Wait(delay)
		for k, v in ipairs(slots) do
			local pos = v.pos
			local ped = PlayerPedId()
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), pos, true)
			if dist < 2.0 then
				delay = 5
				for a, b in pairs(slotsOccupiedBy) do
					if b.slot == k then
						local hash = GetHashKey(b.model)
						local car = GetDisplayNameFromVehicleModel(hash)
						local cname =  Config.cars[b.cat][b.model].name
						DrawText3Ds(pos.x, pos.y, pos.z + 1.5, "[ ~g~" .. cname .. " ~s~] | [~r~ $" .. b.price .. " ~s~]\n" .. "[ ~g~E~s~ ] | [ ~w~BUY~s~ ] [ ~g~G~s~ ]")
					--	DrawText3Ds(pos.x, pos.y, pos.z + 1.05, "")
						if IsControlPressed(0,47) and not pressed then
							pressed = false
							TriggerServerEvent('ndrp_edm:pdmswap',k,v.cat,b.spawned)
							pressed  =	false
						end
						
					--[[	if IsControlPressed(0,48) and not pressed then
							pressed = false
							TestVehicle(k)
							pressed  =	false
						end ]]--
						
						if IsControlPressed(0,38) and not pressed then
							pressed = true
							if DGCore.Game.IsSpawnPointClear(Config.buy_point.pos, 5) then
								local price = b.price
								local elements = {}
								table.insert(elements, {label = 'No',  value = 'no'})
								table.insert(elements, {label = 'Yes' , value = 'yes'})
								DGCore.UI.Menu.CloseAll()
								DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'Buy_vehicle', {
									title    = 'Buy '.. b.model ..' for $' .. b.price .. '?',
									align	= 'top-right',
									elements = elements,
								}, function(data, menu)
									if data.current.value == 'no' then
										menu.close()
										pressed = false
									elseif data.current.value == 'yes' then
										if not buyingd then
											buyingd = true
											menu.close()
											DGCore.UI.Menu.CloseAll()
											DGCore.TriggerServerCallback('ndrp_edm:checkpass', function(hP)
												if hP then
													DGCore.TriggerServerCallback('ndrp_edm:checkmoney', function(hM)
														if hM then
															local generatedPlate = exports['dg_pdm']:GeneratePlate()
															Citizen.Wait(50)
															RequestModel(b.model)
															while not HasModelLoaded(b.model) do
																Wait(10)
															end
															local buyveh  = CreateVehicle(hash, Config.buy_point.pos, Config.buy_point.heading, true, true)
															SetVehicleNumberPlateText(buyveh, generatedPlate)
															Citizen.Wait(50)
															
															if b.model == 'trhawk' then
																SetVehicleExtra (buyveh , 2 , true)
															end

															local vehicleProps = DGCore.Game.GetVehicleProperties(buyveh)
															Citizen.Wait(20)
															if not clickedbuy then
																clickedbuy = true
																TriggerServerEvent('ndrp_edm:buycar',  vehicleProps, price, b.model)	
															end
															clickedbuy = false
															TriggerEvent('ndrp_carkeys:carkeys',buyveh)
															TaskWarpPedIntoVehicle(ped, buyveh, -1)
															pressed = false
														else	
															exports['mythic_notify']:SendAlert('error', 'You don\'t have enough cash')
															Citizen.Wait(1000)
															pressed = false
															menu.close()
														end
													end, price)
												else
													buyingd = false
													exports['mythic_notify']:SendAlert('error', 'You don\'t have pass for this exclusive vehicle')
													Citizen.Wait(1000)
													pressed = false
													menu.close()
												end
											end, b.cat)
										else
											menu.close()
											buyingd = false
											pressed = false
										end
									end
								end, function(data, menu)
									pressed = false
									buyingd = false
									menu.close()
								end)
							else
								exports['mythic_notify']:SendAlert('inform', 'Please clear the spawn spoint!')
								Citizen.Wait(2000)
								pressed = false
								buyingd = false
							end
						end
					end
				end
			end
		end
	end
end)

-- Function for 3D text:
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

RegisterCommand('edmfix', function(source, args)
	connected = false
	TriggerServerEvent('ndrp_edm:spawnDefaultS',11,true)
end, false)


-- Spawn Swapped Car

RegisterNetEvent('ndrp_edm:pdmspawn')
AddEventHandler('ndrp_edm:pdmspawn', function(slot,cat,spstatus)
	local elements,slot,cat,i ={},slot,cat,0
	for k, v in pairs(Config.cars[cat]) do
		i = i + 1
		elements[i] = {label = v.name .. "‎‎‎‎‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‎ | ‎‏‏‎ ‎‏‏‎ ‎‏‏‎  $" .. v.price, value = k, price = v.price}
	end
	DGCore.UI.Menu.CloseAll()
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'job_actions', {
		title    = 'Swap '.. cat,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		SpawnCar(slot,cat,data.current.value, data.current.price)
	end, function(data, menu)
		menu.close()
	end)
end)

-- Swap the car

function SpawnCar(slot, cat, model, price)
    local slot,model,cat,price,pos,heading = slot,model,cat,price,Config.slots[slot].pos,Config.slots[slot].heading
	local vehicle = GetClosestVehicle(pos , 3.0, 0, 71)
	DGCore.Game.DeleteVehicle(vehicle)
	slotsOccupiedBy[slot].cat = cat
	slotsOccupiedBy[slot].price = price
	slotsOccupiedBy[slot].model = model
	slotsOccupiedBy[slot].spawned = true
	Citizen.Wait(50)
	TriggerServerEvent('ndrp_edm:updateTable', slotsOccupiedBy)
	TriggerServerEvent('ndrp_edm:spawnDefaultS',slot)
end

-- Test vehicle

function TestVehicle(slot)
	if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == "pdm") then
		local slot = slot
		local model = slotsOccupiedBy[slot].model
		local price = slotsOccupiedBy[slot].price
		local playerPed = PlayerPedId()
		local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(playerPed), 6.0)
		local closeplayers, i = {} , 0
		for k = 1, #players, 1 do
			i = i + 1
			closeplayers[i] = {value = GetPlayerServerId(players[k]) , label = GetPlayerServerId(players[k])}
		end
		if closeplayers[1] ~= nil then
			DGCore.UI.Menu.CloseAll()
			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_pdmvehicle', {
				title    = 'Choose Test Driver',
				align    = 'top-right',
				elements = closeplayers
			}, function(data, menu)
				menu.close()
				TriggerServerEvent('ndrp_edm:givetest', data.current.value, model,slot)
			end, function(data, menu)
				menu.close()
				pressed = false
			end)
		else
			exports['mythic_notify']:SendAlert('error', 'No player nearby')
		end
	else
		exports['mythic_notify']:SendAlert('inform', 'Only PDM can use this command!')
	end	
end

RegisterNetEvent('ndrp_edm:testdrive')
AddEventHandler('ndrp_edm:testdrive', function(model,slot)
	if DGCore.Game.IsSpawnPointClear(Config.buy_point.pos, 5) then
		local elements = {}
		table.insert(elements, {label = 'No',  value = 'no'})
		table.insert(elements, {label = 'Yes ($5000 Refundable)', value = 'yes'})
		DGCore.UI.Menu.CloseAll()
		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'Buy_vehicle', {
			title    = 'Test Drive '.. model ..'?',
			align	= 'top-right',
			elements = elements,
		}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				DGCore.TriggerServerCallback('ndrp_edm:checkmoney', function(hM)
					if hM then
						DGCore.Game.SpawnVehicle(model,Config.buy_point.pos, Config.buy_point.heading, function(vehicle)
							SetVehicleNumberPlateText(vehicle, ' PDM '..math.random(500,999))
							testvehicle = vehicle
							Citizen.Wait(50)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
							TriggerServerEvent('ndrp_edm:testdrivemoney',true)
							TriggerEvent('ndrp_carkeys:forceTurnOver',vehicle)
						end)
					else
						exports['mythic_notify']:SendAlert('inform', 'You don\'t have money for test drive')
					end
				end, 1000)
			end
		end, function(data, menu)
			menu.close()
		end)
	else
		exports['mythic_notify']:SendAlert('inform', 'There\'s already a vehicle at test point')
	end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local player = PlayerPedId()
		local posx = vector3(-45.06,-1082.29,26.41)
		local dist = GetDistanceBetweenCoords(GetEntityCoords(player), posx, false)
		if dist < 10 then
			if IsPedInAnyVehicle(player,false) then
				DrawText3Ds(posx.x, posx.y, posx.z, "[ ~g~E~s~ ] | [ ~w~End Test Drive~s~ ]")
				if IsControlPressed(0,46) then
					if testvehicle == GetVehiclePedIsIn(player,false) then
						DGCore.Game.DeleteVehicle(GetVehiclePedIsIn(player,false))
						testvehicle = 0
						TriggerServerEvent('ndrp_edm:testdrivemoney',false)
					else
						exports['mythic_notify']:SendAlert('inform', 'This is not the test vehicle or it\'s too late')
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(110.18,-152.7,54.85)
	SetBlipSprite (blip, 523)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 81)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('PDM & EDM Exclusive Dealership')
	EndTextCommandSetBlipName(blip)
end)

TriggerEvent('chat:addSuggestion', '/edmfix', 'Fix EDM bugs if vehicles are not spawning')