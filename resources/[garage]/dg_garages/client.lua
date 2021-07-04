DGCore = nil
local playerJob = "unemployed"

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	playerJob = DGCore.GetPlayerData().job
end)

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
	DGCore.PlayerData = xPlayer
	if DGCore.PlayerData ~= nil then
		playerJob = DGCore.PlayerData.job
	end
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
	playerJob = DGCore.PlayerData.job
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

local playerPedx = nil
local insideMarker = false

--[[ VSP Coords

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
			local coords = GetEntityCoords(PlayerPedId())
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
			local vCoords = Config.vaspucci['car']
			local hCoords = Config.vaspucci['heli']
			local pCoords = Config.vaspucci['personal']
			local eCoords = Config.vaspucci['extra']
			local vDistance = Vdist(coords, vCoords.x, vCoords.y, vCoords.z)
			local hDistance = Vdist(coords, hCoords.x, hCoords.y, hCoords.z)
			local pDistance = Vdist(coords, pCoords.x, pCoords.y, pCoords.z)
			local eDistance = Vdist(coords, eCoords.x, eCoords.y, eCoords.z)

			if vDistance < 5.0 and not insideMarker then
				DrawMarker(2, vCoords.x, vCoords.y, vCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if vDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(vCoords.x, vCoords.y, vCoords.z+0.25, "[E] - Police Garage")
					end

					if IsControlJustPressed(0, 46) then
						insideMarker = true
						OpenGarage('car','police', vCoords.h )
						Citizen.Wait(2000)
					end

				end				
			end

			if hDistance < 5.0 and not insideMarker then
				DrawMarker(34, hCoords.x, hCoords.y, hCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if hDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(hCoords.x, hCoords.y, hCoords.z+0.25, "[E] - Heli Garage")
					end

					if IsControlJustPressed(0, 46) and not insideMarker then	
						insideMarker = true
						OpenGarage('heli','police', hCoords.h)
					end

				end
			end

			if pDistance < 5.0 and not insideMarker then
				DrawMarker(36, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if pDistance < 2.0 then

					if pedInVeh then 

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Store Vehicle")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							StorePersonalVehicle()
						end	
					
					else

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Personal Garage")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							TakePersonalVehicle(pCoords)
						end	
					end
				end		
			end

			if eDistance < 5.0 and pedInVeh and not insideMarker then
				DrawMarker(2, eCoords.x, eCoords.y, eCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if eDistance < 2.0 then 
					if not insideMarker then
						DrawText3Ds(eCoords.x, eCoords.y, eCoords.z+0.25, "[E] - Vehicle Extras")
					end

					if IsControlJustPressed(0, 46) and not pressed then	
						insideMarker = true
						OpenMainMenu()
					end

				end				
			end
		end
	end
end) ]]--


-- MRPD Coords

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
			local coords = GetEntityCoords(PlayerPedId())
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
			local class = GetVehicleClass(veh)
			local vCoords = Config.mrpd['car']
			local hCoords = Config.mrpd['heli']
			local pCoords = Config.mrpd['personal']
			local eCoords = Config.mrpd['extra']
			local vDistance = Vdist(coords, vCoords.x, vCoords.y, vCoords.z)
			local hDistance = Vdist(coords, hCoords.x, hCoords.y, hCoords.z)
			local pDistance = Vdist(coords, pCoords.x, pCoords.y, pCoords.z)
			local eDistance = Vdist(coords, eCoords.x, eCoords.y, eCoords.z)

			if vDistance < 5.0 and not insideMarker then
				DrawMarker(2, vCoords.x, vCoords.y, vCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if vDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(vCoords.x, vCoords.y, vCoords.z+0.25, "[E] - Police Garage")
					end

					if IsControlJustPressed(0, 46) then
						insideMarker = true
						OpenGarage('car','police', vCoords.h)
						Citizen.Wait(2000)
					end

				end				
			end

			if hDistance < 5.0 and not insideMarker then
				DrawMarker(34, hCoords.x, hCoords.y, hCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if hDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(hCoords.x, hCoords.y, hCoords.z+0.25, "[E] - Heli Garage")
					end

					if IsControlJustPressed(0, 46) and not insideMarker then	
						insideMarker = true
						OpenGarage('heli','police', hCoords.h)
					end

				end
			end

			if pDistance < 5.0 and not insideMarker then
				DrawMarker(36, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if pDistance < 2.0 then

					if pedInVeh then 

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Store Vehicle")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							StorePersonalVehicle()
						end	
					
					else

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Personal Garage")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							TakePersonalVehicle(pCoords)
						end	
					end
				end		
			end

			if eDistance < 5.0 and pedInVeh and not insideMarker and class == 18 then
				DrawMarker(2, eCoords.x, eCoords.y, eCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if eDistance < 2.0 then 
					if not insideMarker then
						DrawText3Ds(eCoords.x, eCoords.y, eCoords.z+0.25, "[E] - Vehicle Extras")
					end

					if IsControlJustPressed(0, 46) and not pressed then	
						insideMarker = true
						OpenMainMenu()
					end

				end				
			end
		end
	end
end)

-- WEAZEL Coords

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'news') then
			local coords = GetEntityCoords(PlayerPedId())
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
			local class = GetVehicleClass(veh)
			local vCoords = Config.weazel['car']
			local hCoords = Config.weazel['heli']
			local pCoords = Config.weazel['personal']
			local eCoords = Config.weazel['extra']
			local vDistance = Vdist(coords, vCoords.x, vCoords.y, vCoords.z)
			local hDistance = Vdist(coords, hCoords.x, hCoords.y, hCoords.z)
			local pDistance = Vdist(coords, pCoords.x, pCoords.y, pCoords.z)
			local eDistance = Vdist(coords, eCoords.x, eCoords.y, eCoords.z)

			if vDistance < 5.0 and not insideMarker then
				DrawMarker(2, vCoords.x, vCoords.y, vCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if vDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(vCoords.x, vCoords.y, vCoords.z+0.25, "[E] - News Garage")
					end

					if IsControlJustPressed(0, 46) then
						insideMarker = true
						OpenGarage('car','news', vCoords.h)
						Citizen.Wait(2000)
					end

				end				
			end

			if hDistance < 5.0 and not insideMarker then
				DrawMarker(34, hCoords.x, hCoords.y, hCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if hDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(hCoords.x, hCoords.y, hCoords.z+0.25, "[E] - Heli Garage")
					end

					if IsControlJustPressed(0, 46) and not insideMarker then	
						insideMarker = true
						OpenGarage('heli','news',hCoords.h)
					end

				end
			end

			if pDistance < 5.0 and not insideMarker then
				DrawMarker(36, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if pDistance < 2.0 then

					if pedInVeh then 

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Store Vehicle")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							StorePersonalVehicle()
						end	
					
					else

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Personal Garage")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							TakePersonalVehicle(pCoords)
						end	
					end
				end		
			end

			if eDistance < 5.0 and pedInVeh and not insideMarker and class == 18 then
				DrawMarker(2, eCoords.x, eCoords.y, eCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if eDistance < 2.0 then 
					if not insideMarker then
						DrawText3Ds(eCoords.x, eCoords.y, eCoords.z+0.25, "[E] - Vehicle Extras")
					end

					if IsControlJustPressed(0, 46) and not pressed then	
						insideMarker = true
						OpenMainMenu()
					end

				end				
			end
		end
	end
end)


-- EMS Coords

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(10)
		if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'ambulance') then
			local coords = GetEntityCoords(PlayerPedId())
			local veh = GetVehiclePedIsIn(PlayerPedId(), false)
			local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
			local class = GetVehicleClass(veh)
			local vCoords = Config.ambulance['car']
			local hCoords = Config.ambulance['heli']
			local pCoords = Config.ambulance['personal']
			local eCoords = Config.ambulance['extra']
			local vDistance = Vdist(coords, vCoords.x, vCoords.y, vCoords.z)
			local hDistance = Vdist(coords, hCoords.x, hCoords.y, hCoords.z)
			local pDistance = Vdist(coords, pCoords.x, pCoords.y, pCoords.z)
			local eDistance = Vdist(coords, eCoords.x, eCoords.y, eCoords.z)

			if vDistance < 5.0 and not insideMarker then
				DrawMarker(2, vCoords.x, vCoords.y, vCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if vDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(vCoords.x, vCoords.y, vCoords.z+0.25, "[E] - EMS Garage")
					end

					if IsControlJustPressed(0, 46) then
						insideMarker = true
						OpenGarage('car','ambulance',vCoords.h)
						Citizen.Wait(2000)
					end

				end				
			end

			if hDistance < 5.0 and not insideMarker then
				DrawMarker(34, hCoords.x, hCoords.y, hCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if hDistance < 2.0 then

					if not insideMarker then
						DrawText3Ds(hCoords.x, hCoords.y, hCoords.z+0.25, "[E] - Heli Garage")
					end

					if IsControlJustPressed(0, 46) and not insideMarker then	
						insideMarker = true
						OpenGarage('heli','ambulance',hCoords.h)
					end

				end
			end

			if pDistance < 5.0 and not insideMarker then
				DrawMarker(36, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if pDistance < 2.0 then

					if pedInVeh then 

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Store Vehicle")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							StorePersonalVehicle()
						end	
					
					else

						DrawText3Ds(pCoords.x, pCoords.y, pCoords.z+0.25, "[E] - Personal Garage")

						if IsControlJustPressed(0, 46) then
							insideMarker = true
							TakePersonalVehicle(pCoords)
						end	
					end
				end		
			end

			if eDistance < 5.0 and pedInVeh and not insideMarker and class == 18 then
				DrawMarker(2, eCoords.x, eCoords.y, eCoords.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.3, 51, 51, 255, 150, false, true, 2, true, false, false, false)	
				if eDistance < 2.0 then 
					if not insideMarker then
						DrawText3Ds(eCoords.x, eCoords.y, eCoords.z+0.25, "[E] - Vehicle Extras")
					end

					if IsControlJustPressed(0, 46) and not pressed then	
						insideMarker = true
						OpenMainMenu()
					end

				end				
			end
		end
	end
end)



--- Boat Garages

Citizen.CreateThread(function()
	local wait = 5
	while true do 
		Citizen.Wait(wait)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		local class = GetVehicleClass(veh)
		local boatCoords = Config.Boat
		for k,v in pairs(boatCoords) do
			
			local pDistance = Vdist(coords, boatCoords[k].menu.x, boatCoords[k].menu.y, boatCoords[k].menu.z) 
			local sDistance = Vdist(coords, boatCoords[k].spawn.x, boatCoords[k].spawn.y, boatCoords[k].spawn.z) 
			
			if pDistance < 10.0 and not insideMarker then
				wait = 5
				if boatCoords[k].menu.x ~= -806.2 then
					DrawMarker(35, boatCoords[k].menu.x, boatCoords[k].menu.y, boatCoords[k].menu.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 230, 132, 0, 150, false, true, 2, true, false, false, false)
					if pDistance < 2.0 then
						DrawText3Ds(boatCoords[k].menu.x, boatCoords[k].menu.y, boatCoords[k].menu.z+0.35, "[E] - Boat Garage")
						if IsControlJustPressed(0, 46) then
							insideMarker = true
							TakePersonalBoat(boatCoords[k].spawn)
						end
					end
				else
					
					if (DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'police') then
						DrawMarker(35, boatCoords[k].menu.x, boatCoords[k].menu.y, boatCoords[k].menu.z, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.5, 0.5, 0.5, 0, 102, 255, 150, false, true, 2, true, false, false, false)
						if pDistance < 2.0 then
							DrawText3Ds(boatCoords[k].menu.x, boatCoords[k].menu.y, boatCoords[k].menu.z+0.35, "[E] - PD Boat Garage")
							if IsControlJustPressed(0, 46) then
								insideMarker = true
								OpenGarage('boat','police', boatCoords[k].spawn)
							end
						end
					end

				end

			end

			if sDistance < 30.0 and not insideMarker then
				wait = 5
				if pedInVeh then
					DrawMarker(35, boatCoords[k].spawn.x, boatCoords[k].spawn.y, boatCoords[k].spawn.z+1.5, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 2.0, 2.0, 2.0, 230, 132, 0, 200, false, true, 2, true, false, false, false)
					if sDistance < 4.0 then
						DrawText3Ds(boatCoords[k].spawn.x, boatCoords[k].spawn.y, boatCoords[k].spawn.z+3.00, "[E] - Store Boat")
						if IsControlJustPressed(0, 46) then
							insideMarker = true
							StorePersonalVehicle(boatCoords[k].menu)
						end
					end		
				end
			else
				wait = 5
			end



		end
	end
end)


-- Open Garage

function OpenGarage(typex,jobx,headingx)
	local job = jobx
	local type = typex
	local heading = headingx
	local elements = {
		{ label = 'Store', action = "store_vehicle" },
		{ label = 'Take out', action = "get_vehicle" },
	}
		
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), "garage_menu",
		{
			title    = "".. job .." Garage",
			align    = "center",
			elements = elements
		},
		function(data, menu)
			menu.close()
			local action = data.current.action
			if action == "get_vehicle" then
				if type == 'car' then
					VehicleMenu('car',job, heading)
				elseif type == 'heli' then
					VehicleMenu('heli',job, heading)
				elseif type == 'boat' then
					VehicleMenu('boat',job, heading)
				end
			elseif data.current.action == 'store_vehicle' then
				local veh,dist = DGCore.Game.GetClosestVehicle(playerCoords)
				if dist < 3 then
					DeleteEntity(veh)
					DGCore.ShowNotification("The vehicle has been stored")
				else
					DGCore.ShowNotification("No vehicle to store")
				end
				insideMarker = false
			end
		end, function(data, menu)
			menu.close()
			insideMarker = false
		end, function(data, menu)
	end)
end

-- Spawn Vehicle

function VehicleMenu(typex,jobx, headingx)
	local type = typex
	local job = jobx
	local heading = headingx
	local storage = nil
	local elements = {}
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	if type == 'boat' then
		pos = vector3(heading.x, heading.y, heading.z)
		heading = heading.h
	end
	
	if type == 'car' then
		
		if job == 'police' then
			for k,v in pairs(Config.PoliceVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, type = 'car'})
			end
		end

		if job == 'news' then
			for k,v in pairs(Config.NewsVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, type = 'car'})
			end
		end

		if job == 'ambulance' then
			for k,v in pairs(Config.EMSVehicles) do
				table.insert(elements,{label = v.label, name = v.label, model = v.model, type = 'car'})
			end
		end


	elseif type == 'heli' then
		
		if job == 'police' then
			for k,v in pairs(Config.PoliceHeli) do
				table.insert(elements, {label = v.label, name = v.label, model = v.model, type = 'helicopter'})
			end
		end

		if job == 'news' then
			for k,v in pairs(Config.NewsHeli) do
				table.insert(elements, {label = v.label, name = v.label, model = v.model, type = 'helicopter'})
			end
		end

		if job == 'ambulance' then
			for k,v in pairs(Config.EMSHeli) do
				table.insert(elements, {label = v.label, name = v.label, model = v.model, type = 'helicopter'})
			end
		end

	elseif type == 'boat' then

		if job == 'police' then
			for k,v in pairs(Config.PoliceBoat) do
				table.insert(elements, {label = v.label, name = v.label, model = v.model, type = 'boat'})
			end
		end
	end
		
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), "vehicle_garage",
		{
			title    = "".. job .." Garage",
			align    = "center",
			elements = elements
		},
		function(data, menu)
			menu.close()
			insideMarker = false
			VehicleLoadTimer(data.current.model)
			local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,heading,true,false)
			SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
			if type == 'heli' and job == 'police' then
				SetVehicleLivery(veh,0)
			elseif type == 'heli' and job == 'ambulance' then
				SetVehicleLivery(veh,1)
			end
			local plate = GetVehicleNumberPlateText(veh)

			Wait(1000)
			TriggerEvent("fuel:setFuel",veh,100.0)
			SetVehicleDirtLevel(veh, 0.1)
			Citizen.Wait(100)
			--TriggerEvent('ndrp_carkeys:carkeys', veh)
			TriggerServerEvent('garage:addKeys', plate)
		end, function(data, menu)
			menu.close()
			insideMarker = false
		end, function(data, menu)
	end)

end


-- Load Timer Function for Vehicle Spawn:

function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)
		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
			drawLoadingText("The Vehicle is on the way!", 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles Function:

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end


-- Extra Menu:

function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end

	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = 'Vehicle Extras',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Livery Menu:

function OpenLiveryMenu()
	local elements = {}
	
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
	local liveryCount = GetVehicleLiveryCount(vehicle)
			
	for i = 1, liveryCount do
		local state = GetVehicleLivery(vehicle) 
		local text
		
		if state == i then
			text = "Livery: "..i.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			text = "Livery: "..i.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		
		table.insert(elements, {
			label = text,
			value = i,
			state = not state
		}) 
	end

	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'livery_menu', {
		title    = Config.TitlePoliceLivery,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		SetVehicleLivery(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Livery: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state
		menu.update({value = data.current.value}, newData)
		menu.refresh()
		menu.close()	
	end, function(data, menu)
		menu.close()		
	end)

end

-- Police Extra Main Menu:

function OpenMainMenu()
	local elements = {
		{label = "Primary Color", value = 'primary'},
		{label = "Secondary Color", value = 'secondary'},
		{label = "Vehicle Extras", value = 'extra'},
		{label = "Vehicle Liveries", value = 'livery'}
	}
	DGCore.UI.Menu.CloseAll()

	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'color_menu', {
		title    = 'Extra Menu',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'extra' then
			OpenExtraMenu()
		elseif data.current.value == 'livery' then
			OpenLiveryMenu()
		elseif data.current.value == 'primary' then
			OpenMainColorMenu('primary')
		elseif data.current.value == 'secondary' then
			OpenMainColorMenu('secondary')
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end)
end

-- Police Color Main Menu:

function OpenMainColorMenu(colortype)
	local elements = {}
	for k,v in pairs(Config.Colors) do
		table.insert(elements, {
			label = v.label,
			value = v.value
		})
	end
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'main_color_menu', {
		title    = colortype,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		OpenColorMenu(data.current.type, data.current.value, colortype)
	end, function(data, menu)
		menu.close()
	end)
end

-- Police Color Menu:

function OpenColorMenu(type, value, colortype)
	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = type,
		align    = 'top-right',
		elements = GetColors(value)
	}, function(data, menu)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local pr,sec = GetVehicleColours(vehicle)
		if colortype == 'primary' then
			SetVehicleColours(vehicle, data.current.index, sec)
		elseif colortype == 'secondary' then
			SetVehicleColours(vehicle, pr, data.current.index)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end


-- Personal Garage

function StorePersonalVehicle(Coords)
	local coordsx = Coords
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local model = GetEntityModel(vehicle)
	if model ~= -488123221 then
		
		local vehprops = DGCore.Game.GetVehicleProperties(vehicle)
		FreezeEntityPosition(vehicle, true)
		exports['dg-taskbar']:taskBar(1000, "Storing Vehicle")
		FreezeEntityPosition(vehicle, false)
		insideMarker = false

		DGCore['TriggerServerCallback']('loaf_garage:store', function(success)
			if success then
				while DoesEntityExist(vehicle) do
					Wait(10)
				   	SetEntityAsMissionEntity(vehicle, true, true)
					DeleteVehicle(vehicle)
					SetEntityCoords(playerPed, coordsx.x, coordsx.y, coordsx.z-0.8 )
				end
			end
		end, json.encode(exports['dg_garage']:GetDamages(vehicle)), json.encode(vehprops), vehprops.plate, "hehe")

	else
		FreezeEntityPosition(vehicle, true)
		--exports['progressBars']:startUI(1000, "Storing Vehicle")
		exports['dg-taskbar']:taskBar(1000, "Storing Vehicle")
		FreezeEntityPosition(vehicle, false)
		insideMarker = false
		while DoesEntityExist(vehicle) do
			Wait(10)
			SetEntityAsMissionEntity(vehicle, true, true)
			DeleteVehicle(vehicle)
			SetEntityCoords(playerPed,-806.2,-1496.7, 0.6)
		end
	end

end

function TakePersonalVehicle(coords)
	local heading = coords.h
	local coordsx = vector3(coords.x,coords.y,coords.z)
	--exports['progressBars']:startUI(1000, "Listing Vehicles")
	exports['dg-taskbar']:taskBar(1000, "Listing Vehicles")
	TriggerServerEvent('dg_garage:viewVehicles', coordsx, heading, "hehe")
	insideMarker = false
end

function TakePersonalBoat(coords)
	local heading = coords.h
	local coordsx = vector3(coords.x,coords.y,coords.z)
	--exports['progressBars']:startUI(1000, "Listing Boats")
	exports['dg-taskbar']:taskBar(1000, "Listing Boats")
	TriggerServerEvent('dg_garage:viewBoats', coordsx, heading, "hehe")
	insideMarker = false
end

-- Blips

CreateThread(function()
	for k, v in pairs(Config.Boat) do
		if v.menu.x ~= -806.2 then
			CreateBlip(v.menu, 427, 60, "Boat Garage")
		end
    end
end)

CreateBlip = function(coords, sprite, color, text)
    local blip = AddBlipForCoord(coords.x,coords.y,coords.z)
	SetBlipSprite (blip,sprite )
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end