bedNames = { 'v_med_bed1', 'v_med_bed2'} -- Add more model strings here if you'd like
bedHashes = {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
isOnBed = false

CreateThread(function()
    for k,v in ipairs(bedNames) do
        table.insert( bedHashes, GetHashKey(v))
    end
end)

RegisterCommand('bed', function()
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        if isOnBed then
            ClearPedTasksImmediately(playerPed)
            isOnBed = false
            return
        end

        local playerPos = GetEntityCoords(playerPed, true)

        local bed = nil

        for k,v in ipairs(bedHashes) do
            bed = GetClosestObjectOfType(playerPos.x, playerPos.y, playerPos.z, 4.0, v, false, false, false)
            if bed ~= 0 then
                break
            end
        end

        if bed ~= nil and DoesEntityExist(bed) then
            if not HasAnimDictLoaded(animDict) then
                RequestAnimDict(animDict)
            end
            local bedCoords = GetEntityCoords(bed)

            SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)

            isOnBed = true
        end
    end)
end, false)

-- RegisterCommand('end', function()
--     local playerPed = PlayerPedId()
--     local playerPos = GetEntityCoords(playerPed, true)
--     local bedHash = GetHashKey('v_med_bed1')
--     CreateObject(bedHash, playerPos.x, playerPos.y + 1.0, playerPos.z - 0.95, true, true, true)
-- end, false)


RegisterCommand('bed', function(source, args)
    TriggerEvent('dg-hospital:client:RPCheckPos')
end, false)

RegisterNetEvent('dg-hospital:client:RPCheckPos')
AddEventHandler('dg-hospital:client:RPCheckPos', function()
    TriggerServerEvent('dg-hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('dg-hospital:client:RPSendToBed')
AddEventHandler('dg-hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h)
    --SetEntityInvincible(PlayerPedId(), false)
    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)

            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)


function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)
    SetEntityInvincible(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), bedOccupyingData.h-90.0)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('dg-hospital:server:LeaveBed', bedOccupying)
    beingTreated = false
    FreezeEntityPosition(bedObject, false)
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
end