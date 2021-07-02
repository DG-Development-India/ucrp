RegisterCommand('trunk', function(source, args)
    local playerPed = PlayerPedId()
    local cid = exports["isPed"]:isPed("cid")
    local vehicle = DGCore.Game.GetVehicleInDirection()
    if DoesEntityExist(vehicle) and GetVehiclePedIsIn(playerPed) == 0 then
        local locked = GetVehicleDoorLockStatus(vehicle)
        local hasBoot = DoesVehicleHaveDoor(vehicle, 5)
        if locked ~= 10 then
            local boneIndex = GetEntityBoneIndexByName(vehicle, 'platelight')
            local vehicleCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
            local playerCoords = GetEntityCoords(playerPed)
            local distance = GetDistanceBetweenCoords(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)
            local closestPlayer, closestPlayerDistance = DGCore.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                if distance < 1.5 and closestPlayerDistance > 5 then
                    local startPosition = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.5, 0)
                    local licensePlate = GetVehicleNumberPlateText(vehicle)
                    SetVehicleDoorOpen(vehicle, 5, 0, 0)
                    TaskTurnPedToFaceEntity(player, vehicle, 1.5)
                    TriggerEvent("toggle-animation", true, vehicle)
                    --print(licensePlate)
                    TriggerServerEvent("server-inventory-open", startPosition, cid, "1", "Trunk-" .. licensePlate)
                else
                    exports['mythic_notify']:SendAlert('error', 'Too many people around your trunk!')
                end
            else
                local startPosition = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.5, 0)
                local licensePlate = GetVehicleNumberPlateText(vehicle)
                SetVehicleDoorOpen(vehicle, 5, 0, 0)
                TaskTurnPedToFaceEntity(player, vehicle, 1.5)
                TriggerEvent("toggle-animation", true, vehicle)
                TriggerServerEvent("server-inventory-open", startPosition, cid, "1", "Trunk-" .. licensePlate)
            end
        else
            exports['mythic_notify']:SendAlert('error', 'The trunk is locked!')
        end
    end
end)

-- RegisterCommand('trunk', function(source, args)
--     local playerPed = PlayerPedId()
--     local cid = exports["isPed"]:isPed("cid")
--     local vehicle = DGCore.Game.GetVehicleInDirection()
--     if DoesEntityExist(vehicle) and GetVehiclePedIsIn(playerPed) == 0 then
--         local locked = GetVehicleDoorLockStatus(vehicle) ~= 1
--         local hasBoot = DoesVehicleHaveDoor(vehicle, 5)
--         if not locked then
--             local boneIndex = GetEntityBoneIndexByName(vehicle, 'platelight')
--             local vehicleCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
--             local playerCoords = GetEntityCoords(playerPed)
--             local distance = GetDistanceBetweenCoords(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)
--             local closestPlayer, closestPlayerDistance = DGCore.Game.GetClosestPlayer()
--             --if closestPlayer ~= -1 then
--                 if distance < 1.5 and closestPlayerDistance > 5 then
--                     local startPosition = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.5, 0)
--                     local licensePlate = GetVehicleNumberPlateText(vehicle)
--                     SetVehicleDoorOpen(vehicle, 5, 0, 0)
--                     TaskTurnPedToFaceEntity(player, vehicle, 1.5)
--                     TriggerEvent("toggle-animation", true, vehicle)
--                     TriggerServerEvent("server-inventory-open", startPosition, cid, "1", "Trunk-" .. licensePlate)
--                 else
--                     exports['mythic_notify']:SendAlert('error', 'Too many people around your trunk!')
--                 end
--             --end
--         end
--     end
-- end)