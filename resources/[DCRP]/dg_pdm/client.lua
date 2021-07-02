DGCore = nil
local spawnedCars = {}
local testvehicle = 0
local hasMoney = false
local commision = 10
local connected = false
local buying = false
local buyingd = false

local slotsOccupiedBy = {
	{ slot = 1, 	cat= 'bicycles', 			model = 'bmx', 				price = 500,		spawned = true},
	{ slot = 2, 	cat= 'motorcycles', 		model = 'bati',  			price = 35000,		spawned = true},
	{ slot = 3,		cat= 'compacts', 			model= 'issi3',  			price = 12000,		spawned = true},
	{ slot = 4, 	cat= 'sports', 				model = 'comet5',  			price = 150000,		spawned = true},
	{ slot = 5, 	cat= 'muscle',				model = 'dominator3', 		price = 65000,		spawned = true},
	{ slot = 6, 	cat= 'super',				model  = 'tyrant',  		price = 320000,		spawned = true},
	{ slot = 7,		cat= 'coupes',				model  = 'felon',  			price = 45000,		spawned = true},
	{ slot = 8,		cat= 'sportsclassics',		model  = 'jb700',  			price = 200000,		spawned = true},
	{ slot = 9,		cat= 'suvs',				model  = 'mesa3',  			price = 50000,		spawned = true},
	{ slot = 10,	cat= 'offroad',				model  = 'trophytruck2',	price = 50000,		spawned = true},
	{ slot = 11,	cat= 'smallbot',			model  = 'dinghy',			price = 550000,		spawned = true},
	{ slot = 12,	cat= 'newmuscle',			model  = 'alfa65', 			price = 120000,		spawned = true},
	{ slot = 13,	cat= 'newsuv',				model  = 'mansm8', 			price = 150000,		spawned = true},
	{ slot = 14,	cat= 'newsport',			model  = 'camarozl1', 		price = 200000,		spawned = true},
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
	TriggerServerEvent('ndrp_pdm:spawnDefaultS',11,false)
end)

local myjob = false
RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
	if DGCore.PlayerData.job ~= nil and DGCore.PlayerData.job.name == 'pdm' then
		myjob = true
	end
end)

RegisterNetEvent('ndrp_pdm:spawnDefaultC')
AddEventHandler('ndrp_pdm:spawnDefaultC', function(tab,slot,status)
	local slots = Config.slots
	if status then
		connected = false
	end
	if slot == 12 and not connected then
		connected = true
		for k,v in pairs(tab) do
			Citizen.Wait(100)
			local xVehicle = 0 
			
			if slots[k].cat == 'smallbot' then
				xVehicle = DGCore.Game.GetClosestVehicle(slots[k].pos,0)
				NetworkRequestControlOfEntity(xVehicle)
				SetEntityAsMissionEntity(xVehicle, true, true)
			else
				xVehicle = GetClosestVehicle(slots[k].pos , 3.0, 0, 71)
				NetworkRequestControlOfEntity(xVehicle)
				SetEntityAsMissionEntity(xVehicle, true, true)
			end

			if xVehicle >= 0 then
				DGCore.Game.DeleteVehicle(xVehicle)
				if DoesEntityExist(xVehicle) then
					DGCore.Game.DeleteVehicle(xVehicle)
				end
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
			
			if slots[slot].cat == 'smallbot' then
				xVehicle = DGCore.Game.GetClosestVehicle(slots[slot].pos ,0)
				NetworkRequestControlOfEntity(xVehicle)
				SetEntityAsMissionEntity(xVehicle, true, true)
			else
				xVehicle = GetClosestVehicle(slots[slot].pos  , 3.0, 0, 71)
				NetworkRequestControlOfEntity(xVehicle)
				SetEntityAsMissionEntity(xVehicle, true, true)
			end


			if xVehicle >= 0 then
				DGCore.Game.DeleteVehicle(xVehicle)
				if DoesEntityExist(xVehicle) then
				DGCore.Game.DeleteVehicle(xVehicle)
				end
			end

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

Citizen.CreateThread(function()
	local delay = 100
	local slots = Config.slots
	local stocks = Config.stock
	while true do
		Citizen.Wait(delay)
		for k, v in ipairs(slots) do
			local pos = v.pos
			if v.cat == 'smallbot' then
				pos = vector3(-731.6,-1340.45,0.6)
			end
			local ped = PlayerPedId()
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), pos, true)
			if dist < 2.0 then
				delay = 5
				for a, b in pairs(slotsOccupiedBy) do
					if b.slot == k then
						local buypoint = Config.buy_point.pos
						local buyheading = Config.buy_point.heading
						if b.slot > 11 then
							buypoint = Config.buy_point2.pos
							buyheading = Config.buy_point2.heading
						end
						
						if b.slot == 11 then
							buypoint = vector3(-724.36, -1350.95, 0.00)
							buyheading = 139.65
						end
						
						local hash = GetHashKey(b.model)
						local car = GetDisplayNameFromVehicleModel(hash)
						DrawText3Ds(pos.x, pos.y, pos.z + 1.3, "[ ~g~" .. car .. " ~s~] | [~r~ $" .. b.price .. " ~s~]\n" .. "[ ~g~E~s~ ] | [ ~w~BUY~s~ ] | [ ~g~G~s~ ] | [ ~w~ Swap~s~ ]")
						
						if myjob then

							if v.cat ~= 'smallbot' then

								DrawText3Ds(pos.x, pos.y, pos.z + 1.1, "[ ~g~H~s~ ] | [ ~w~ Sell~s~ ] | [ ~g~M~s~ ] | [ ~w~ Test ~s~ ]")

								if IsControlPressed(0,301) and not pressed then
									pressed = true
									TestVehicle(k)
									Citizen.Wait(3000)
									pressed  =	false
								end

							--[[	if IsControlPressed(0,75) and not pressed then
									pressed = true
									FinanceVehicle(k)
									Citizen.Wait(3000)
									pressed  =	false
								end ]]--

								if IsControlPressed(0,74) and not pressed then
									pressed = true
									SellVehicle(k)
									Citizen.Wait(3000)
									pressed  =	false
								end

							else

								DrawText3Ds(pos.x, pos.y, pos.z + 1.05, "[ ~g~H~s~ ] | [ ~w~ Sell~s~ ]")

								if IsControlPressed(0,74) and not pressed then
									pressed = true
									SellVehicle(k)
									Citizen.Wait(3000)
									pressed  =	false
								end
							
							end

						end

						if IsControlPressed(0,47) and not pressed then
							pressed = false
							TriggerServerEvent('ndrp_pdm:pdmswap',k,v.cat,b.spawned)
							pressed  =	false
						end
						
						if IsControlPressed(0,38) and not pressed then
							pressed = true
							if DGCore.Game.IsSpawnPointClear(buypoint, 5) then
								local price = b.price * 1.15
								price = math.floor(price+0.5)
								local elements = {}
								local clickedbuy = false
								table.insert(elements, {label = 'No (Buy from PDM)',  value = 'no'})
								table.insert(elements, {label = 'Buy for $'.. price ..' (15% Extra)' , value = 'yes'})
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
											DGCore.TriggerServerCallback('ndrp_pdm:checkStock', function(cb)
												if cb.stock > 0 then
													DGCore.TriggerServerCallback('ndrp_pdm:checkmoney', function(hM)
														if hM then
															local generatedPlate = GeneratePlate()
															Citizen.Wait(50)
															RequestModel(b.model)
															while not HasModelLoaded(b.model) do
																Wait(10)
															end
															local buyveh  = CreateVehicle(hash, buypoint, buyheading, true, true)
															Citizen.Wait(20)
															SetVehicleNumberPlateText(buyveh, generatedPlate)
															Citizen.Wait(50)
															local vehicleProps = DGCore.Game.GetVehicleProperties(buyveh)
															print(vehicleProps.plate)
															Citizen.Wait(20)
															if not clickedbuy then
																clickedbuy = true
																TriggerServerEvent('ndrp_pdm:buycar',  vehicleProps, price, true,0,0,0,b.model,b.price,0,b.slot)	
															end
															--TriggerEvent('ndrp_carkeys:carkeys',buyveh)
															local pl = GetVehicleNumberPlateText(buyveh)
															TriggerServerEvent('garage:addKeys', pl)
															TaskWarpPedIntoVehicle(ped, buyveh, -1)
															local migid = NetworkGetNetworkIdFromEntity(buyveh)
															SetNetworkIdCanMigrate(migid,true)
															pressed = false
														else
															exports['mythic_notify']:SendAlert('error', 'You don\'t have enough cash')
															Citizen.Wait(1000)
															pressed = false
															menu.close()
														end
													end, price)
												else
													exports['mythic_notify']:SendAlert('error', 'This car is out of Stock! Contact PDM Manager.')
													Citizen.Wait(1000)
													pressed = false
													menu.close()
												end
											end, b.model)
											buyingd = false
											pressed = false
										else
											menu.close()
											buyingd = false
										end
									end
								end, function(data, menu)
									pressed = false
									menu.close()
								end)
							else
								exports['mythic_notify']:SendAlert('inform', 'Please clear the spawn spoint!')
								Citizen.Wait(2000)
								pressed = false
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

RegisterCommand('pdmfix', function(source, args)
	if myjob then
		connected = false
		TriggerServerEvent('ndrp_pdm:spawnDefaultS',12,true)
	else
		exports['mythic_notify']:SendAlert('inform', 'Only ON-DUTY PDM\'s can use it')
	end
end, false)

RegisterCommand('stock', function(source, args)
	if myjob then
		DGCore.TriggerServerCallback('ndrp_pdm:checkStock', function(cb)
			if not cb then
				exports['mythic_notify']:SendAlert('inform', 'Please enter a valid car model name!')
			else
				exports['mythic_notify']:SendAlert('inform', 'There are '..cb.stock..' '..args[1]..' in stock!', 5000)
			end
		end, args[1])
	else
		exports['mythic_notify']:SendAlert('inform', 'Only ON-DUTY PDM\'s can use it')
	end
end, false)

RegisterCommand('restock', function(source, args)
	if myjob and tonumber(DGCore.PlayerData.job.grade) == 3 then
		if args[1] == nil or args[2] == nil then
			exports['mythic_notify']:SendAlert('inform', 'Give the model name and the amount to re-stock!', 5000)
		else
			TriggerServerEvent('ndrp_pdm:addStock', args[1], args[2])
		end
	else
		exports['mythic_notify']:SendAlert('inform', 'Only PDM Managers can do that!')
	end
end, false)

RegisterCommand('pdm', function(source, args)
	if not myjob then
		if DGCore.PlayerData.job ~= nil and DGCore.PlayerData.job.name == 'pdm' then
			myjob = true
			exports['mythic_notify']:SendAlert('inform', 'You are now ON-DUTY')
		end
	else
		myjob = false
		exports['mythic_notify']:SendAlert('inform', 'You are now OFF-DUTY')
	end
end, false)

RegisterCommand('pdmcom', function(source, args)
	if args ~= nil and tonumber(args[1]) <=10 then	
		commision = tonumber(args[1])
		exports['mythic_notify']:SendAlert('inform', 'You set '.. commision ..'% commission')
	else
		exports['mythic_notify']:SendAlert('error', 'You are allowed to set max 10% commission')
	end
end, false)

RegisterNetEvent('ndrp_pdm:pdmspawn')
AddEventHandler('ndrp_pdm:pdmspawn', function(slot,cat)
	if  slot == 9 then
		local vehicles,slot,cat,i ={},slot,cat,0
		DGCore.UI.Menu.CloseAll()
		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'job_actions', {
			title    = 'Swap '.. cat,
			align    = 'top-right',
			elements = {
				{label = 'Sedans', value = 'sedans'},
				{label = 'SUVs', value = 'suvs'},
				{label = 'VANs', value = 'vans'},
			}
		}, function(data, menu)
			menu.close()
			for k, v in pairs(Config.cars[data.current.value]) do
				i = i + 1
				local hash = GetHashKey(k)
				local dname = GetDisplayNameFromVehicleModel(hash)
				vehicles[i] = {label = dname .. "‎‎‎‎‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‎ | ‎‏‏‎ ‎‏‏‎ ‎‏‏‎  $" .. v.price, value = k, price = v.price}
			end
			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'changevehicles', {
				title    = 'Swap',
				align    = 'top-right',
				elements = vehicles
			}, function(data2, menu2)
				menu2.close()
				SpawnCar(slot,cat,data2.current.value, data2.current.price)
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	else
		local elements,slot,cat,i ={},slot,cat,0
		for k, v in pairs(Config.cars[cat]) do
			i = i + 1
			local hash = GetHashKey(k)
			local dname = GetDisplayNameFromVehicleModel(hash)
			elements[i] = {label = dname .. "‎‎‎‎‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎ ‎‏‏‎‎ | ‎‏‏‎ ‎‏‏‎ ‎‏‏‎  $" .. v.price, value = k, price = v.price}
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
	end
end)

function SpawnCar(slot, cat, model, price)
	local slot,model,cat,price,pos,heading = slot,model,cat,price,Config.slots[slot].pos,Config.slots[slot].heading
	
	local vehicle = 0 
	if cat == 'smallbot' then
		vehicle = DGCore.Game.GetClosestVehicle(pos ,0)
		NetworkRequestControlOfEntity(vehicle)
		SetEntityAsMissionEntity(vehicle, true, true)
	else
		vehicle = GetClosestVehicle(pos  , 3.0, 0, 71)
		NetworkRequestControlOfEntity(vehicle)
		SetEntityAsMissionEntity(vehicle, true, true)
	end

	if vehicle >= 0 then
		DGCore.Game.DeleteVehicle(vehicle)
		if DoesEntityExist(vehicle) then
		DGCore.Game.DeleteVehicle(vehicle)
		end
	end

	slotsOccupiedBy[slot].cat = cat
	slotsOccupiedBy[slot].price = price
	slotsOccupiedBy[slot].model = model
	slotsOccupiedBy[slot].spawned = true

	Citizen.Wait(50)

	TriggerServerEvent('ndrp_pdm:updateTable', slotsOccupiedBy)
	TriggerServerEvent('ndrp_pdm:spawnDefaultS',slot)
	
end

function TestVehicle(slot)
	if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == "pdm") then
		local slot = slot
		local model = slotsOccupiedBy[slot].model
		local price = slotsOccupiedBy[slot].price
		local playerPed = PlayerPedId()
		local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(playerPed), 6.0)
		local closeplayers, i = {} , 0
		for k = 1, #players, 1 do
		--	if players[k] ~= PlayerId() then
				i = i + 1
				closeplayers[i] = {value = GetPlayerServerId(players[k]) , label = GetPlayerServerId(players[k])}
		--	end
		end
		if closeplayers[1] ~= nil then
			DGCore.UI.Menu.CloseAll()
			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_pdmvehicle', {
				title    = 'Choose Test Driver',
				align    = 'top-right',
				elements = closeplayers
			}, function(data, menu)
				menu.close()
				TriggerServerEvent('ndrp_pdm:givetest', data.current.value, model,slot)
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

function SellVehicle(slot)
	if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == "pdm") then
		local slot = slot
		local model = slotsOccupiedBy[slot].model
		local price = slotsOccupiedBy[slot].price
		local playerPed = PlayerPedId()
		local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(playerPed), 6.0)
		local closeplayers, i = {} , 0
		for k = 1, #players, 1 do
		--	if players[k] ~= PlayerId() then
				i = i + 1
				closeplayers[i] = {value = GetPlayerServerId(players[k]) , label = GetPlayerServerId(players[k])}
		--	end
		end
		if closeplayers[1] ~= nil then
			DGCore.UI.Menu.CloseAll()
			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_pdmvehicle', {
				title    = 'Choose Buyer',
				align    = 'top-right',
				elements = closeplayers
			}, function(data, menu)
				menu.close()
				TriggerServerEvent('ndrp_pdm:pdmsell', data.current.value, commision, model, price, slot)
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


function FinanceVehicle(slot)
	
	if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == "pdm") then
		local slot = slot
		local model = slotsOccupiedBy[slot].model
		local price = slotsOccupiedBy[slot].price
		local playerPed = PlayerPedId()
		local players, nearbyPlayer = DGCore.Game.GetPlayersInArea(GetEntityCoords(playerPed), 6.0)
		local closeplayers, i = {} , 0
		for k = 1, #players, 1 do
		--	if players[k] ~= PlayerId() then
				i = i + 1
				closeplayers[i] = {value = GetPlayerServerId(players[k]) , label = GetPlayerServerId(players[k])}
		--	end
		end
		if closeplayers[1] ~= nil then
			DGCore.UI.Menu.CloseAll()
			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'f_pdmvehicle', {
				title    = 'Choose Buyer (' .. commision ..'% EMI Interest)',
				align    = 'top-right',
				elements = closeplayers
			}, function(data, menu)
				menu.close()
				TriggerServerEvent('ogrp_pdm:pdmfinance', data.current.value, commision, model, price, slot)
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


RegisterNetEvent('ndrp_pdm:buyer')
AddEventHandler('ndrp_pdm:buyer', function(price,model,seller,commission,sellerid,buyername,slot)
	buying = false
	print(slot)
	local buypoint = Config.buy_point.pos
	local buyheading = Config.buy_point.heading
	if slot > 11 then
		buypoint = Config.buy_point2.pos
		buyheading = Config.buy_point2.heading
	end
	if slot == 11 then
		buypoint = vector3(-724.36, -1350.95, 0.00)
		buyheading = 139.65
	end

	local model = model
	local seller = seller
	local amount = tonumber(price)
	local commission = tonumber(commission)
	local price = math.floor((amount*commission/100)+amount)
	local ped = GetPlayerPed(-1) 
	local reason = 0
	
	if DGCore.Game.IsSpawnPointClear(buypoint, 5) then
		
		local elements = {}
		table.insert(elements, {label = 'No',  value = 'no'})
		table.insert(elements, {label = 'Yes ('.. amount ..' + ' .. commission .. '% Commission)', value = 'yes'})
		DGCore.UI.Menu.CloseAll()
		
		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'Buy_vehicle', {
			title    = 'Buy '.. model ..' from ' .. seller ..  '?',
			align	= 'top-right',
			elements = elements,
		}, function(data, menu)
			
			if data.current.value == 'no' then
				menu.close()
				reason = 5
				TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,model,0,0)
				buying = false
			elseif data.current.value == 'yes' then
				if not buying then
					buying = true
					DGCore.TriggerServerCallback('ndrp_pdm:checkStock', function(cb)
						if cb.stock > 0 then
							DGCore.TriggerServerCallback('ndrp_pdm:checkmoney', function(hM)
								if hM then 
									menu.close()
									local generatedPlate = GeneratePlate()
									Citizen.Wait(50)
									RequestModel(model)
									while not HasModelLoaded(model) do
										Wait(10)
									end							
									local buyveh  = CreateVehicle(model, buypoint, buyheading, true, true)
									SetVehicleNumberPlateText(buyveh, generatedPlate)
									local migid = NetworkGetNetworkIdFromEntity(buyveh)
									SetNetworkIdCanMigrate(migid,true)
									Citizen.Wait(50)
									local vehicleProps = DGCore.Game.GetVehicleProperties(buyveh)
									Citizen.Wait(20)
									TriggerServerEvent('ndrp_pdm:buycar',  vehicleProps, price, false, sellerid,buyername,1,model,amount,commission,slot)
									TaskWarpPedIntoVehicle(ped, buyveh, -1)
									local pl = GetVehicleNumberPlateText(buyveh)
								   	TriggerServerEvent('garage:addKeys', pl)
								else
									menu.close()
									reason = 2
									exports['mythic_notify']:SendAlert('inform', 'You don\'t have enough balance')
									Citizen.Wait(2500)
									--TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,model,0,0)
								end
							end, price)
						else
							exports['mythic_notify']:SendAlert('error', 'This car is out of Stock! Contact PDM Manager.')
							TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,4,0,model,0,0)
						end
					end, model)
				else
					menu.close()
					buying = false
				end
			end
		end, function(data, menu)
			pressed = false
			menu.close()
		end)
	else
		reason = 3
		exports['mythic_notify']:SendAlert('inform', 'Please clear the spawn spoint!')
		Citizen.Wait(2000)
		TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,0,0,0)
	end	
end)


RegisterNetEvent('ogrp_pdm:finance')
AddEventHandler('ogrp_pdm:finance', function(price,_model,_seller,commission,sellerid,buyername,_slot)
	buying = false
	local buypoint = Config.buy_point.pos
	local buyheading = Config.buy_point.heading

	local model, seller, amount, emiinterest, slot = _model, _seller, tonumber(price), tonumber(commission), _slot
	amount = math.floor(amount+((amount*emiinterest)/100)+0.05)
	local ped = GetPlayerPed(-1) 
	local reason = 0
	local baseprice = math.floor(amount/2)
	local downpayment = math.floor((baseprice + ( (baseprice*emiinterest) /100) )+0.5)

	local emi3, emi6, emi9 = math.floor((((baseprice)*emiinterest)/100)+0.5), math.floor((((baseprice)*(emiinterest+2))/100)+0.5), math.floor((((baseprice)*(emiinterest+4))/100)+0.5)
	
	if DGCore.Game.IsSpawnPointClear(buypoint, 5) then

		local elements = {}
		table.insert(elements, {label = 'No (I don\'t like this guy )',  value = 'no'})
		table.insert(elements, {label = 'Yes ($'.. downpayment ..' Down Payment + ' .. emiinterest .. '% Interest on Lowest EMI)', value = 'yes'})
		DGCore.UI.Menu.CloseAll()
		
		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'Buy_vehicle', {
			
			title    = 'Finance '.. model ..' from ' .. seller ..  '?',
			align	= 'top-right',
			elements = elements,

		}, function(data, menu)
			
			if data.current.value == 'no' then
				
				menu.close()
				reason = 2
				TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,model,0,0)
				buying = false

			elseif data.current.value == 'yes' then

				if not buying then
					buying = true

					DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'emi', 
					{
						title    = 'Down Payment $'.. downpayment .. ' | Choose no. of installments',
						align	= 'top-right',

						elements = {	{value = 3,  label = ' 3 | $' .. (math.floor((baseprice/3)+0.5)) .. ' + ' .. emiinterest .. '% Interest | Total Cost $' ..(emi3)+(baseprice+downpayment)},
										{value = 6,  label = ' 6 | $' .. (math.floor((baseprice/6)+0.5)) .. ' + ' .. (emiinterest+2) .. '% Interest | Total Cost $' ..(emi6)+(baseprice+downpayment)},
										{value = 9,  label = ' 9 | $' .. (math.floor((baseprice/9)+0.5)) .. ' + ' .. (emiinterest+4) .. '% Interest | Total Cost $' ..(emi9)+(baseprice+downpayment)}
									}

					}, function(data2, menu2)
						
						local totalprice = (emi3)+(baseprice+downpayment)
						local emiprice =  math.floor((emi3/3)+(baseprice/3)+0.5)
						
						if data2.current.value == 6 then
							totalprice = (emi6)+(baseprice+downpayment)
							emiprice =  math.floor((emi6/6)+(baseprice/6)+0.5)
						elseif data2.current.value == 9 then
							totalprice = (emi9)+(baseprice+downpayment)
							emiprice =  math.floor((emi9/9)+(baseprice/9)+0.5)
						end

						DGCore.TriggerServerCallback('ndrp_pdm:checkmoney', function(hM)
							
							if hM then 
								
								DGCore.UI.Menu.CloseAll()
								local generatedPlate = GeneratePlate()
								Citizen.Wait(50)
								RequestModel(model)
								while not HasModelLoaded(model) do
									Wait(10)
								end							
								local buyveh  = CreateVehicle(model, buypoint, buyheading, true, true)
								SetVehicleNumberPlateText(buyveh, generatedPlate)
								Citizen.Wait(50)
								local vehicleProps = DGCore.Game.GetVehicleProperties(buyveh)
								Citizen.Wait(20)
								local migid = NetworkGetNetworkIdFromEntity(buyveh)
								SetNetworkIdCanMigrate(migid,true)
								TriggerServerEvent('ogrp_pdm:financecar',  vehicleProps, downpayment, totalprice, sellerid, buyername, 1, model, data2.current.value, emiinterest , emiprice, slot)
								TaskWarpPedIntoVehicle(ped, buyveh, -1)

							else
								
								DGCore.UI.Menu.CloseAll()
								reason = 2
								exports['mythic_notify']:SendAlert('inform', 'You don\'t have enough balance')
								Citizen.Wait(2500)		
								TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,model,0,0)

							end

						end, downpayment )
					
					end, function(data2, menu2)
						pressed = false
						menu2.close()
					end)

				else
					menu.close()
					buying = false
				end

			end

		end, function(data, menu)
			pressed = false
			menu.close()
		end)

	else

		reason = 3
		exports['mythic_notify']:SendAlert('inform', 'Please clear the spawn spoint!')
		Citizen.Wait(2000)
		TriggerServerEvent('ndrp_pdm:pdmresponse',sellerid,buyername,reason,0,0,0,0)
		
	end	
end)

RegisterNetEvent('ndrp_pdm:pdmresponse')
AddEventHandler('ndrp_pdm:pdmresponse', function(buyername,reason,plate,model,price,commission)
	if reason == 1 then
		local reward = (commission /100) * price
		local price = reward + price
		TriggerServerEvent('ndrp_pdm:pdmmoney',reward)
		exports['mythic_notify']:SendAlert('success','You received $'.. reward .. ' for selling a vehicle')
	elseif reason == 2 then
		exports['mythic_notify']:SendAlert('error',' '.. buyername .. ' don\'t have enough money for '.. model,5000)
	elseif reason == 3 then
		exports['mythic_notify']:SendAlert('inform', 'Please clear the spawn spoint!')
	elseif reason == 4 then
		exports['mythic_notify']:SendAlert('error', 'This car needs to be restocked!', 5000)
	elseif reason == 5 then
		exports['mythic_notify']:SendAlert('error', 'The buyer declined the offer!', 5000)
	else
		exports['mythic_notify']:SendAlert('inform', ' ' .. buyername .. ' don\'t want to buy ' .. model,5000)
	end
end)

RegisterNetEvent('ndrp_pdm:testdrive')
AddEventHandler('ndrp_pdm:testdrive', function(model,slot)
	
	local buypoint = Config.buy_point.pos
	local buyheading = Config.buy_point.heading
	if slot > 11 then
		buypoint = Config.buy_point2.pos
		buyheading = Config.buy_point2.heading
	end
	if slot == 11 then
		buypoint = vector3(-724.36, -1350.95, 0.00)
		buyheading = 139.65
	end

	if DGCore.Game.IsSpawnPointClear(buypoint, 5) then
		local elements = {}
		table.insert(elements, {label = 'No',  value = 'no'})
		table.insert(elements, {label = 'Yes ($1000 Refundable)', value = 'yes'})
		DGCore.UI.Menu.CloseAll()
		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'Buy_vehicle', {
			title    = 'Test Drive '.. model ..'?',
			align	= 'top-right',
			elements = elements,
		}, function(data, menu)
			menu.close()
			if data.current.value == 'yes' then
				DGCore.TriggerServerCallback('ndrp_pdm:checkmoney', function(hM)
					if hM then
						DGCore.Game.SpawnVehicle(model,buypoint, buyheading, function(vehicle)
							SetVehicleNumberPlateText(vehicle, ' PDM '..math.random(500,999))
							testvehicle = vehicle
							Citizen.Wait(50)
							local migid = NetworkGetNetworkIdFromEntity(buyveh)
							SetNetworkIdCanMigrate(migid,true)
							TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
							TriggerServerEvent('ndrp_pdm:testdrivemoney',true)
							--TriggerEvent('ndrp_carkeys:forceTurnOver',vehicle)
							local pl = GetVehicleNumberPlateText(vehicle)
							TriggerServerEvent('garage:addKeys', pl)
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
	local wait = 100
	while true do
		Citizen.Wait(wait)
		local player = PlayerPedId()
		local posx = vector3(-45.06,-1082.29,26.41)
		local posy = vector3(111.86,-118.98,56.37)
		local dist1 = GetDistanceBetweenCoords(GetEntityCoords(player), posx, false)
		local dist2 = GetDistanceBetweenCoords(GetEntityCoords(player), posy, false)
		if dist1 < 5 then
			wait = 5
			if IsPedInAnyVehicle(player,false) then
				DrawText3Ds(posx.x, posx.y, posx.z, "[ ~g~E~s~ ] | [ ~w~End Test Drive~s~ ]")
				if IsControlPressed(0,46) and not pressed then
					if testvehicle == GetVehiclePedIsIn(player,false) then
						NetworkRequestControlOfEntity(GetVehiclePedIsIn(player,false))
						DGCore.Game.DeleteVehicle(GetVehiclePedIsIn(player,false))

						testvehicle = 0
						TriggerServerEvent('ndrp_pdm:testdrivemoney',false)
						Citizen.Wait(2000)
						pressed = false
					else
						exports['mythic_notify']:SendAlert('inform', 'This is not the test vehicle or it\'s too late')
						Citizen.Wait(2000)
						pressed = false
					end
				end
			end
		elseif dist2 < 5 then
			wait = 5
			if IsPedInAnyVehicle(player,false) then
				DrawText3Ds(posy.x, posy.y, posy.z, "[ ~g~E~s~ ] | [ ~w~End Test Drive~s~ ]")
				if IsControlPressed(0,46) and not pressed then
					if testvehicle == GetVehiclePedIsIn(player,false) then
						NetworkRequestControlOfEntity(GetVehiclePedIsIn(player,false))
						DGCore.Game.DeleteVehicle(GetVehiclePedIsIn(player,false))

						testvehicle = 0
						TriggerServerEvent('ndrp_pdm:testdrivemoney',false)
						Citizen.Wait(2000)
						pressed = false
					else
						exports['mythic_notify']:SendAlert('inform', 'This is not the test vehicle or it\'s too late')
						Citizen.Wait(2000)
						pressed = false
					end
				end
			end
		else
			wait = 100
		end
	end
end)


Citizen.CreateThread(function()
	local wait = 100
	while true do
		Citizen.Wait(wait)
		local player = PlayerPedId()
		local posx = vector3(-763.59, -1369.33, 0.08)
		local dist = GetDistanceBetweenCoords(GetEntityCoords(player), posx, false)
		if dist < 5 then
			wait = 5
			if IsPedInAnyVehicle(player,false) then
				DrawText3Ds(posx.x, posx.y, posx.z, "[ ~g~E~s~ ] | [ ~w~End Test Drive~s~ ]")
				if IsControlPressed(0,46) and not pressed then
					if testvehicle == GetVehiclePedIsIn(player,false) then
						DGCore.Game.DeleteVehicle(GetVehiclePedIsIn(player,false))
						testvehicle = 0
						TriggerServerEvent('ndrp_pdm:testdrivemoney',false)
						SetEntityCoords(player,-756.84, -1367.66, 1.0)
						Citizen.Wait(2000)
						pressed = false
					else
						exports['mythic_notify']:SendAlert('inform', 'This is not the test vehicle or it\'s too late')
						Citizen.Wait(2000)
						pressed = false
					end
				end
			end
		else
			wait = 100
		end
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-39.79,-1104.28,25.31)
	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 3)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('PDM Car Dealership')
	EndTextCommandSetBlipName(blip)
end)
	
TriggerEvent('chat:addSuggestion', '/pdmcom', 'Set commission for PDM', {
    { name="commission", help="Max 10%" },
 })
TriggerEvent('chat:addSuggestion', '/pdmfix', 'Fix PDM bugs if vehicles are not spawning')
 TriggerEvent('chat:addSuggestion', '/pdm', 'Commands for PDM to go ON-DUTY or OFF-DUTY')