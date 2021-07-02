DGCore = nil
local Status, isPaused = {}, false

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

function GetStatusData(minimal)
	local status = {}

	for i=1, #Status, 1 do
		if minimal then
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		else
			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100
			})
		end
	end

	return status
end

AddEventHandler('dg_status:registerStatus', function(name, default, color, visible, tickCallback)
	local status = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, status)
end)

AddEventHandler('dg_status:unregisterStatus', function(name)
	for k,v in ipairs(Status) do
		if v.name == name then
			table.remove(Status, k)
			break
		end
	end
end)

RegisterNetEvent('dg_status:load')
AddEventHandler('dg_status:load', function(status)
	TriggerEvent('dg_status:loaded')
	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
		while true do
			for i=1, #Status, 1 do
				Status[i].onTick()
			end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})

			TriggerEvent('dg_status:onTick', GetStatusData(true))
			Citizen.Wait(Config.TickTime)
		end
	end)
end)

RegisterNetEvent('dg_status:set')
AddEventHandler('dg_status:set', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('dg_status:update', GetStatusData(true))
end)

RegisterNetEvent('dg_status:add')
AddEventHandler('dg_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('dg_status:update', GetStatusData(true))
end)

RegisterNetEvent('dg_status:remove')
AddEventHandler('dg_status:remove', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('dg_status:update', GetStatusData(true))
end)

AddEventHandler('dg_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

AddEventHandler('dg_status:setDisplay', function(val)
	SendNUIMessage({
		setDisplay = true,
		display    = val
	})
end)

-- Pause menu disable hud display
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not isPaused then
			isPaused = true
			TriggerEvent('dg_status:setDisplay', 0.0)
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false 
			TriggerEvent('dg_status:setDisplay', 0.5)
		end
	end
end)

-- Loading screen off event
AddEventHandler('dg:loadingScreenOff', function()
	if not isPaused then
		TriggerEvent('dg_status:setDisplay', 0.3)
	end
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)

		TriggerServerEvent('dg_status:update', GetStatusData(true))
	end
end)
