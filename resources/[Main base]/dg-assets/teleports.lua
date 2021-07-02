key_to_teleport = 38

positions = {
    {{331.8652, -595.5778, 43.28411}, {338.75, -583.96, 74.17, 251.27},{255,255,255}, "[E] - Rooftop / HeliPad"},
    {{330.36, -601.22, 43.28, 72.25}, {344.3253, -586.2847, 28.79685, 251.5539855957},{255,255,255}, "[E] - Pillbox Ground Floor"},
    {{1383.632, 4305.569, 36.66505, 255.68}, {1065.430, -3182.969, -39.163, 70.54},{255,255,255}, "[E] - Weed Lab"},
    {{48.21037, 6306.168, 31.49607, 255.68}, {1088.803, -3188.257, -38.993, 70.54},{255,255,255}, "[E] - Coke Lab"},
    --{{-1148.962, 4906.792, 220.9687, 255.68}, {996.933, -3200.605, -36.394, 70.54},{255,255,255}, "[E] - Meth Lab"},
    {{756.3687, -3197.855, 6.076845, 255.68}, {903.1516, -3182.393, -97.05228, 70.54},{255,255,255}, "[E] - Bunker"},
    {{614.6008, 2784.232, 43.48122, 255.68}, {179.0187, -1000.296, -98.99997, 70.54},{255,255,255}, "[E] - Enter"}, --Blackmarket
    {{327.4709, -603.3749, 43.284, 156.36882019043}, {341.4525, -580.9807, 28.79685, 72.489524841309},{255,255,255}, "[E] - Garage"}, --Medic Garage
}

-----------------------------------------------------------------------------
-------------------------DO NOT EDIT BELOW THIS LINE-------------------------
-----------------------------------------------------------------------------


function DrawText3DTest(x,y,z, text)
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
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end

local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for _,location in ipairs(positions) do
            teleport_text = location[4]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3],
                heading=location[1][4]
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
                heading=location[2][4]
            }
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]

            --DrawMarker(1, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)
            --DrawMarker(1, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.5001, Red, Green, Blue, 200, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                DrawText3DTest(location[1][1], location[1][2], location[1][3], teleport_text)
                
                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc2.heading)
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(player, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                DrawText3DTest(location[2][1], location[2][2], location[2][3], '[E] - Go')

                if IsControlJustReleased(1, key_to_teleport) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetVehiclePedIsUsing(player), loc1.heading)
                    else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(player, loc1.heading)
                    end
                end
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end