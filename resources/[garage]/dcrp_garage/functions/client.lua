DGCore = nil

CreateThread(function()
    while DGCore == nil do 
        TriggerEvent('dg:getSharedObject', function(obj) 
            DGCore = obj 
        end)
        Wait(0) 
    end

    for k, v in pairs(Config['Garages']) do
        CreateBlip(v['coords'], 357, 57, "Garages")
    end

    for k, v in pairs(Config['Impounds']) do
        if v['type'] ~= 'bot' then
            CreateBlip(v['Menu'], 67, 47, 'Impound Lot')
        end
    end
    
end)

Marker = function(coords)
    DrawMarker(20, coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 1, 156, 227, 200, false, true, 2, false, false, false, false)
end

GetDamages = function(vehicle)
    local props = DGCore['Game']['GetVehicleProperties'](vehicle)
    local damages = {
        ['damaged_windows'] = {}, 
        ['burst_tires'] = {}, 
        ['broken_doors'] = {}, 
        ['body_health'] = GetVehicleBodyHealth(vehicle), 
        ['engine_health'] = GetVehicleEngineHealth(vehicle)
    }

    for i = 0, GetNumberOfVehicleDoors(vehicle) do 
        if IsVehicleDoorDamaged(vehicle, i) then table.insert(damages['broken_doors'], i) end 
    end

    for i = 0, GetVehicleNumberOfWheels(vehicle) do
        if IsVehicleTyreBurst(vehicle, i, false) then table.insert(damages['burst_tires'], i) end 
    end
    
    for i = 0, 3 do
        if not IsVehicleWindowIntact(vehicle, i) then table.insert(damages['damaged_windows'], i) end
    end

    return damages
end

SetDamages = function(car, damages)

    for i = 0, GetNumberOfVehicleDoors(car)-1 do
        if damages['broken_doors'] then
            if damages['broken_doors'][i] then
                SetVehicleDoorBroken(car, damages['broken_doors'][i], true)
            end
        end
    end

    -- for i = 0, 3 do
    --     if damages['damaged_windows'] then
    --         if damages['damaged_windows'][i] then
    --             SmashVehicleWindow(car, damages['damaged_windows'][i])
    --         end
    --     end
    -- end
    
    for i = 0, 5 do
        if damages['burst_tires'] then
            if damages['burst_tires'][i] then
                SetVehicleTyreBurst(car, damages['burst_tires'][i], true, 1000.0)
            end
        end
    end

    if damages['body_health'] then
        SetVehicleBodyHealth(car, damages['body_health'])
    end
    if damages['engine_health'] then
        SetVehicleEngineHealth(car, damages['engine_health'])
    end
end

VehicleExists = function(plate)
    local data = {}
    local handle, ent, success = FindFirstVehicle()
    repeat
        success, vehicle = FindNextVehicle(handle)
        if DoesEntityExist(vehicle) then
            if GetVehicleNumberPlateText(vehicle):gsub(' ', '') == plate:gsub(' ', '') then
                return true
            end
        end
	until not success
    EndFindVehicle(handle)
    return false
end

CreateBlip = function(coords, sprite, color, text)
    local blip = AddBlipForCoord(coords)
	SetBlipSprite (blip,sprite )
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end