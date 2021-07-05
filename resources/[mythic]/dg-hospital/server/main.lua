local beds = {
    { x = 307.64, y = -582.01, z = 42.2, h = 180.00, taken = false, model = 1631638868 },
    { x = 310.95, y = -583.30, z = 42.2, h = 180.00, taken = false, model = -1091386327 },
    { x = 314.32, y = -584.22, z = 42.2, h = 180.00, taken = false, model = 1631638868 },
    { x = 317.71, y = -585.52, z = 42.2, h = 180.00, taken = false, model = -1091386327 }, 
    { x = 322.74, y = -587.2,  z = 42.2, h = 180.00, taken = false, model = -1091386327 }, 
    { x = 309.33, y = -577.13, z = 42.2, h = 0.00, taken = false, model = -1091386327 },
    { x = 313.85, y = -578.92, z = 42.2, h = 0.00, taken = false, model = -1091386327 },
    { x = 319.32, y = -580.91, z = 42.2, h = 0.00, taken = false, model = -1091386327 },
    { x = 324.15, y = -582.67, z = 42.2, h = 0.00, taken = false, model = -1091386327 }
}

local bedsTaken = {}
local injuryBasePrice = 100
DGCore             = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('dg-hospital:server:RequestBed')
AddEventHandler('dg-hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('dg-hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'No beds available.' })
end)

RegisterServerEvent('dg-hospital:server:RPRequestBed')
AddEventHandler('dg-hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('dg-hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'That bed is taken.' })
            end
        end
    end

    if not foundbed then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You are not near a hospital bed.' })
    end
end)

RegisterServerEvent('dg-hospital:checkems')
AddEventHandler('dg-hospital:checkems', function()
	local xPlayers = DGCore.GetPlayers()
	local ems = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = DGCore.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			ems = ems + 1
		end
	end
	TriggerClientEvent("dg-hospital:checkems", source, ems)
end)


RegisterServerEvent('dg-hospital:server:EnteredBed')
AddEventHandler('dg-hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)

    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end

    -- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = DGCore.GetPlayerFromId(src)
    xPlayer.removeBank(totalBill)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You were billed for $' .. totalBill ..'.' })
    TriggerClientEvent('dg-hospital:client:FinishServices', src)
end)

RegisterServerEvent('dg-hospital:server:LeaveBed')
AddEventHandler('dg-hospital:server:LeaveBed', function(id)
    if id ~= nil then
        beds[id].taken = false
    end
end)