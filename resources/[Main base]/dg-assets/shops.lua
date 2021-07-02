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

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
	DGCore.PlayerData = xPlayer
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

local tool_shops = {
	{ ['x'] = 44.838947296143, ['y'] = -1748.5364990234, ['z'] = 29.549386978149 },
	{ ['x'] = 2749.2309570313, ['y'] = 3472.3308105469, ['z'] = 55.679393768311 },
	{ ['x'] = -3153.44, ['y'] = 1055.14, ['z'] = 20.85 }
}

local twentyfourseven_shops = {
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.9542236328, ['y'] = 792.40191650391, ['z'] = 138.13920593262 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
	{ ['x'] = -48.9, ['y'] = -1757.34, ['z'] = 29.421 },
	{ ['x'] = 1162.87, ['y'] = -319.218, ['z'] = 69.2051 },
	{ ['x'] = 373.97, ['y'] = 325.75, ['z'] = 103.675 },
	{ ['x'] = 2673.91, ['y'] = 3281.77, ['z'] = 55.2411 },
	{ ['x'] = 1701.97, ['y'] = 4921.81, ['z'] = 42.0637 },
	{ ['x'] = 1730.06, ['y'] = 6419.63, ['z'] = 35.0372 },
}


local drink_shops = {
	{['x'] = 1135.808,  ['y'] = -982.281,  ['z'] = 45.415},
	{['x'] = 1166.024,  ['y'] = 2708.930,  ['z'] = 37.157},
	{['x'] = 1392.562,  ['y'] = 3604.684,  ['z'] = 33.980},
	{['x'] = -1393.409, ['y'] = -606.624,  ['z'] = 29.319}
}


local weashop_locations = {

	{	['x'] = 809.94,		['y'] = -2157.31,	['z'] = 28.63}, 
	{ 	['x'] = 1693.86,	['y'] = 3759.94, 	['z'] = 33.72},
	{  	['x'] = 252.05,		['y'] = -50.11,		['z'] = 68.95}, 
	{	['x'] = 842.08,		['y'] = -1033.43,	['z'] = 27.20}, 
	{	['x'] = -330.25,	['y'] = 6083.89,	['z'] = 30.47}, 
	{	['x'] = -662.06,	['y'] = -935.38,	['z'] = 20.84}, 
	{	['x'] = -1305.93,	['y'] = -394.41,	['z'] = 35.71}, 
	{  	['x'] = -1117.69, 	['y'] = 2698.61, 	['z'] = 17.56}, 
	{	['x'] = 2567.62,	['y'] = 294.36,		['z'] = 107.74},
	{	['x'] = -3171.86, 	['y'] = 1087.71,	['z'] = 19.85}, 
	{	['x'] = 22.32,		['y'] =- 1107.29,	['z'] = 28.82}, 
}

local weashop_blips = {}

function setShopBlip()

	for k,v in ipairs(weashop_locations)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip,110)
		SetBlipScale(blip, 0.85)
		SetBlipAsShortRange(blip,true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		
	end

	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 82)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Shop")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(drink_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 93)
		SetBlipScale(blip, 0.6)
		SetBlipColour(blip, 8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Liquor Shop")
		EndTextCommandSetBlipName(blip)
	end


	for k,v in ipairs(tool_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 4)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tool Shop")
		EndTextCommandSetBlipName(blip)
	end	

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	
	setShopBlip()

	while true do

		local pressed = false
		local found = false

		Citizen.Wait(1)
		local pos = GetEntityCoords(PlayerPedId())

		for k,v in ipairs(weashop_locations) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0) then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if (Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0) then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
					if IsControlJustPressed(1, 38) and not pressed then
						pressed = true
						DGCore.TriggerServerCallback('dg_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								TriggerEvent("server-inventory-open", "58", "Shop");
							else
								exports['mythic_notify']:SendAlert('error', 'You don\'t have a license')	
							end
						end, GetPlayerServerId(PlayerId()), 'weapon')
						
						Wait(2500)
						pressed = false
				    end
                end
            end
		end


		if(Vdist( 310.15, -565.57, 42.29, pos.x, pos.y, pos.z) < 20.0) then
			found = true
			DrawMarker(27,  310.15, -565.57, 42.29, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist( 310.15, -565.57, 42.29, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) and not pressed then
					if DGCore.PlayerData ~= nil and DGCore.PlayerData.job.name == "ambulance" then
						pressed = true
						TriggerEvent("server-inventory-open", "29", "Shop");
						Wait(2500)
						pressed = false
					else
						exports['mythic_notify']:SendAlert('error', 'This shop is only accesible to EMS')	
					end
			    end
			end
		end


		if(Vdist(1773.92, 2517.05, 45.83, pos.x, pos.y, pos.z) < 20.0)then
			found = true
			DrawMarker(27, 1773.92, 2517.05, 45.83 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(1773.92, 2517.05, 45.83, pos.x, pos.y, pos.z) < 2.0)then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) and not pressed then
					if DGCore.PlayerData ~= nil and DGCore.PlayerData.job.name == "police" then
						pressed = true
						TriggerEvent("server-inventory-open", "10", "Shop");	
						Wait(2500)
						pressed = false
					else
						exports['mythic_notify']:SendAlert('error', 'This armoury is only accesible to Police')	
					end
			    end
			end
		end


		if(Vdist(256.18,-368.91,-44.13, pos.x, pos.y, pos.z) < 20.0) then
			found = true
			DrawMarker(27, 256.18,-368.91,-44.13 - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
			if(Vdist(256.18,-368.91,-44.13, pos.x, pos.y, pos.z) < 3.0) then
				DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
				if IsControlJustPressed(1, 38) and not pressed then
					pressed = true
					TriggerEvent("server-inventory-open", "14", "Shop");	
					Wait(2500)
					pressed = false
			    end
			end
		end

		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0) then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0) then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
					if IsControlJustPressed(1, 38) and not pressed then
						pressed = true
						TriggerEvent("server-inventory-open", "2", "Shop");	
						Wait(2500)
						pressed = false
				    end
                end
            end
		end

		for k,v in ipairs(drink_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0) then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 2.0) then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~shop.")
					if IsControlJustPressed(1, 38) and not pressed then
						pressed = true
						TriggerEvent("server-inventory-open", "100", "Shop");	
						Wait(2500)
						pressed = false
				    end
                end
            end
		end

		for k,v in ipairs(tool_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				found = true
				DrawMarker(27, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 3.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to open the ~g~tool shop.")
					if IsControlJustPressed(1, 38) and not pressed then
						pressed = true
						TriggerEvent("server-inventory-open", "4", "Shop");
						Wait(2500)
						pressed = false
				    end
                end
            end
		end

		if not found then
			Wait(1200)
		end
	end
end)