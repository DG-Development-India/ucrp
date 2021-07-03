local busy = false
local ownedVehicles = {}

CreateThread(function()
    
    while DGCore == nil do 
        Wait(0)
    end

    CreateThread(function()
        while true do
            local sleep = 250
            if not busy then
                for k, v in pairs(Config['Garages']) do
                    local PlayerPed = PlayerPedId()
                    local dist = #(GetEntityCoords(PlayerPed) - v['coords'])
                    if dist <= 250.0 then
                        sleep = 0
                        Marker(v['coords'] - vec3(0.0, 0.0, 0.5))
                        local string, vehicle = 'enter_garage', GetVehiclePedIsUsing(PlayerPed)
                        if DoesEntityExist(vehicle) then
                            string = 'store_garage'
                        end
                        if dist <= 7.5 then
                            if dist < 2.0 then
                                HelpText((Strings[string]):format('~INPUT_CONTEXT~'), v['coords'] + vec3(0.0, 0.0, 1.25))
                                if IsControlJustReleased(0, 51) then
                                    if DoesEntityExist(vehicle) then
                                        FreezeEntityPosition(vehicle, true)
                                        --exports['progressBars']:startUI(1000, "Storing Vehicle")
                                        exports['dg-taskbar']:taskBar(1000, "Storing Vehicle")
                                        FreezeEntityPosition(vehicle, false)
                                        local vehprops = DGCore['Game']['GetVehicleProperties'](vehicle)
                                        DGCore['TriggerServerCallback']('loaf_garage:store', function(success)
                                            if success then
                                                DGCore.Game.DeleteVehicle(vehicle)
                                                if DoesEntityExist(vehicle) then
                                                    for i = 1, 1, 20 do
                                                        Citizen.Wait(10)
                                                        if DoesEntityExist(vehicle) then
                                                            DGCore.Game.DeleteVehicle(vehicle)
                                                        else
                                                            i = 21
                                                        end
                                                    end
                                                end
                                            end
                                        end, json.encode(GetDamages(vehicle)), json.encode(vehprops), vehprops['plate'], k)
                                    else
                                        --exports['progressBars']:startUI(1000, "Listing Vehicles")
                                        exports['dg-taskbar']:taskBar(1000, "Listing Vehicles")
                                        TriggerServerEvent('dg_garage:viewVehicles', v['coords'], v['heading'], k)
                                        Wait(3500)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)

    CreateThread(function()
        while true do
            local sleep = 250
            if not busy then
                for k, v in pairs(Config['Impounds']) do
                    local dist = #(GetEntityCoords(PlayerPedId()) - v['Menu'])
                    if dist <= 250.0 then
                        sleep = 0
                        Marker(v['Menu'] - vec3(0.0, 0.0, 0.5))
                        if dist <= 7.5 then
                           if dist <= 2.0 then
                                HelpText((Strings['open_impound']):format('~INPUT_CONTEXT~'), v['Menu'] + vec3(0.0, 0.0, 1.25))
                                if IsControlJustReleased(0, 51) then
                                    TriggerServerEvent('loaf_garage:impound', v['SpawnVehicle'],v['type'])
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)

end)

RegisterNetEvent('loaf_garage:viewImpounded')
AddEventHandler('loaf_garage:viewImpounded', function(vehicleSpawn, impounded)
    DGCore['UI']['Menu']['CloseAll']()
    local elements = {}
    for k, v in pairs(impounded) do
        local hash = json.decode(impounded[k]['vehicle'])['model']
        local name = GetDisplayNameFromVehicleModel(hash)
        if GetLabelText(name) == 'NULL' then
            table.insert(elements, {label = "Retrive: " ..name, value = v.plate})
        else
            table.insert(elements, {label = "Retrive: " .. GetLabelText(name), value = v.plate})
        end
    end

    DGCore['UI']['Menu']['Open'](
        'default', GetCurrentResourceName(), 'take_out',
    {
        title = "Impound: $500",
        align = 'top-left',
        elements = elements
    },
    function(data, menu)
        if not VehicleExists(data['current']['value']) then
            if DGCore.Game.IsSpawnPointClear(vehicleSpawn, 6) then
                DGCore['TriggerServerCallback']('loaf_garage:retrieve', function(data)
                    if data then
                        local model = json.decode(data['vehicle'])['model']
                        while not HasModelLoaded(model) do 
                            RequestModel(model)
                            Wait(0)
                        end

                        local car = CreateVehicle(model, vehicleSpawn + vec4(0.0, 0.0, 0.25, 0.0), true, false)
                        local plate = GetVehicleNumberPlateText(car)
                        TriggerServerEvent('garage:addKeys', plate)
                        DGCore['Game']['SetVehicleProperties'](car, json.decode(data['vehicle']))

                        if Config['Damages'] then
                            SetDamages(car, json.decode(data['damages']))
                        end
                        local pt = GetVehicleNumberPlateText(car)
                        ownedVehicles[pt] = true
                        TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
                        SetEntityAsMissionEntity(car, true, true)
                        SetVehicleHasBeenOwnedByPlayer(car, true)
                        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(car), true)
                        SetVehicleHasBeenOwnedByPlayer(car, true)
                        SetVehicleNeedsToBeHotwired(car, false)
                        SetModelAsNoLongerNeeded(model)
                        SetVehRadioStation(car, 'OFF')
                    end
                end, data['current']['value'])
                DGCore['UI']['Menu']['CloseAll']()
                busy = false
            else
                busy = false
                menu.close()
                exports['mythic_notify']:SendAlert('error', 'Clear the spawn Area')
            end
        else
            busy = false
            menu.close()
            TriggerServerEvent('loaf_garage:notify', Strings['already_out'], 'error', 1500)
        end
    end, 
        function(data, menu)
        menu['close']()
    end)
end)

RegisterNetEvent('loaf_garage:view')
AddEventHandler('loaf_garage:view', function(vehicles, coords, heading, garage)
    busy  = true
    local elements = {}
    DGCore.UI.Menu.CloseAll()
    local _heading = tonumber(heading)
    

    for k,v in pairs(vehicles) do
        local hash = json.decode(vehicles[k]['vehicle'])['model']
        local edamage = 100
        local bdamage = 100
        if vehicles[k]['damages'] ~= '{}' then
            edamage = math.floor(tonumber((json.decode(vehicles[k]['damages'])['engine_health']))/10)
            bdamage = math.floor(tonumber((json.decode(vehicles[k]['damages'])['body_health']))/10)
        end
        local name = GetDisplayNameFromVehicleModel(hash)
        if v.state then
            if GetLabelText(name) == 'NULL' then
                table.insert(elements, {label = name .. " : Out", value = v.plate})
            else
                table.insert(elements, {label = GetLabelText(name) .. " :     Out", value = v.plate})
            end
        else
            if GetLabelText(name) == 'NULL' then
                table.insert(elements, {label = name .. " : Stored | " .. edamage .. "% | " .. bdamage .. " %" , value = v.plate})
            else
                table.insert(elements, {label = GetLabelText(name) .. " : Stored | " .. edamage .. "% | " .. bdamage .. " %" , value = v.plate})
            end
        end
    end

    DGCore.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = 'Garage Menu',
			align    = 'top-left',
			elements = elements,
		},
        function(data, menu)
            if DGCore.Game.IsSpawnPointClear(coords, 6) then
                DGCore['TriggerServerCallback']('loaf_garage:takeOut', function(info)
                    if info ~= false then
                        menu.close()
                        Wait(50)

                        local model = json.decode(info['vehicle'])['model']
                        while not HasModelLoaded(model) do 
                            RequestModel(model)
                            Wait(0)
                        end

                        local veh = CreateVehicle(model, coords + vec3(0.0, 0.0, 0.25), _heading, true, false)
                        local plate = GetVehicleNumberPlateText(veh)
                        TriggerServerEvent('garage:addKeys', plate)
                        SetEntityHeading(veh, _heading)

                        DGCore['Game']['SetVehicleProperties'](veh, json.decode(info['vehicle']))

                        if Config['Damages'] then
                            SetDamages(veh, json.decode(info['damages']))
                        end
                        local pt = GetVehicleNumberPlateText(veh)
                        ownedVehicles[pt] = true
                        SetEntityAsMissionEntity(veh, true, true)
                        SetVehicleHasBeenOwnedByPlayer(veh, true)
                        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(veh), true)
                        SetVehicleHasBeenOwnedByPlayer(veh, true)
                        SetVehicleNeedsToBeHotwired(veh, false)
                        SetModelAsNoLongerNeeded(model)
                        SetVehRadioStation(veh, 'OFF')
                        Wait(150)
                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                        busy = false
                    else
                        busy = false
                        menu.close()
                        exports['mythic_notify']:SendAlert('error', 'This vehicle is already out or Impounded')
                    end                
                end, data.current.value)
            else
                busy = false
                menu.close()
                exports['mythic_notify']:SendAlert('error', 'Clear the spawn Area')
            end
    end, function(data, menu)
        busy = false
        menu.close()
    end)	
end)

HelpText = function(msg, coords)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

local lastBody = 1000.0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(math.random(15000,20000))
        if IsPedInAnyVehicle(PlayerPedId(),false) then
            local vehicle = GetVehiclePedIsUsing(PlayerPedId())
            local body = GetVehicleEngineHealth(vehicle)
            local vehprops = DGCore['Game']['GetVehicleProperties'](vehicle)
            local plate = vehprops['plate']
            if ownedVehicles[plate] then
                if body < 1000.0 then
                    if lastBody ~= body then
                        TriggerServerEvent('dg_garage:saveDamage',json.encode(GetDamages(vehicle)), json.encode(vehprops), vehprops['plate'])
                        lastBody = body
                        Citizen.Wait(10000)
                    end
                end
            end
        end
    end
end)