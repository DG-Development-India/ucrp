DGCore = nil

local taskBlip
local jobCoords
local lastJobCoords

local onDuty = false
local finished = true
local activeJob = false
local incLast = false


--- DGCore STUFF

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

-- Clock Room

Citizen.CreateThread(function()
	wait = 100
	local pressed =false
	while true do
		Citizen.Wait(wait)
		local coords = GetEntityCoords(PlayerPedId())
		local distance = Vdist(coords, Config.Marker.x, Config.Marker.y, Config.Marker.z)
		if distance < 10.0 then
			wait = 0
			if (DGCore.PlayerData and DGCore.PlayerData.job) and DGCore.PlayerData.job.name == 'itsupport' then
				if onDuty then
					--DrawMarker(2, Config.Marker, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, 113, 204, 81, 150, false, true, 2, false, false, false, false)
					if distance <= 2.0 then
						DrawText3D(Config.Marker.x, Config.Marker.y, Config.Marker.z+0.2, '[~r~E~s~] - Go OFF-DUTY')
						if distance <= 1.0 then
							if IsControlJustReleased(0, 46) and not pressed then
								onDuty = false
								pressed = true
								if activeJob then
									activeJob = false
									incLast = true
								end
								RemoveBlip(taskBlip)
								TriggerEvent('play:sound','error',0.5)
								exports['mythic_notify']:SendAlert('error', 'you went OFF-DUTY')
								Citizen.Wait(1000)
								pressed = false
							end
						end
					end
				else
					--DrawMarker(2, Config.Marker, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 0, 0, 150, false, true, 2, false, false, false, false)
					if distance <= 2.0 then
						DrawText3D(Config.Marker.x, Config.Marker.y, Config.Marker.z+0.2, '[~g~E~s~] - Go ON-DUTY')
						if distance <= 1.0 then
							if IsControlJustReleased(0, 46)  and not pressed then
								pressed = true
								onDuty = true
								Citizen.Wait(1000)
								TriggerEvent('play:sound','demo',0.5)
								exports['mythic_notify']:SendAlert('success', 'you went ON-DUTY')
								-- TriggerEvent('chat:addMessage', {
								-- 	templateId = 'edispatch',
								-- 	args = {"E-Corp", "Use /ecorp in your car to find job"}
								-- })
								exports['mythic_notify']:SendAlert('error', 'Use /ecorp in your car to find job')
								pressed = false
							end
						end
					end
				end
			end
		else
			wait = 100
		end		
	end
end)

-- Function that provides new location 

function startJob()
	RemoveBlip(taskBlip)
	lastJobCoords = jobCoords

	if not incLast then
		jobCoords = Config.Zones[math.random(1, #Config.Zones)]
		while (jobCoords == lastJobCoords) do
			Wait(5) 
			jobCoords = Config.Zones[Zones[math.random(1, #Config.Zones)]]
		end
	end
		
	TriggerEvent('play:sound','demo',0.5)
	exports['mythic_notify']:SendAlert('success', 'Location updated on your GPS')
	taskBlip = AddBlipForCoord(jobCoords.x, jobCoords.y, jobCoords.z)
	SetBlipRoute(taskBlip, 1)
	SetBlipSprite(taskBlip,606)
	SetBlipScale(taskBlip,0.8)
	SetBlipRouteColour(taskBlip, 49)
	Wait(1000)
	activeJob = true
end

--- Thread for Jon

Citizen.CreateThread(function()
	wait = 100
	local pressed = false
	while true do
		Citizen.Wait(wait)
		if activeJob then
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local distance = Vdist(pedCoords,jobCoords.x,jobCoords.y,jobCoords.z)
			if distance <= 10.0 then
				wait = 0
				if distance <= 2.0 then
					DrawText3D(jobCoords.x,jobCoords.y,jobCoords.z, '[~g~E~s~] - Start Hacking')
					if IsControlJustReleased(0, 46) and not pressed and not IsPedInAnyVehicle(PlayerPedId(), false) then
						pressed = true
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:start", math.random(3,5), math.random(15,25), jobCallback)
						activeJob = false
						pressed = false
						RemoveBlip(taskBlip)
					end
				end
			else
				wait = 100
			end
		else
			wait = 200
		end
	end
end)

-- Check Success

function jobCallback(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		TriggerServerEvent("dg-base:addmoney", math.random(150,200), "Fixing the bugs")
		if math.random(1,100) < 90 then
			give('common')
		elseif math.random(1,100) > 90 and math.random(1,100) < 97 then
			give('rare')
		elseif math.random(1,100) > 98 then
			give('super')
		else
			give('common')
		end

		TriggerServerEvent('ogrp_skill',1,'hacking',1)
		incLast = false
	else
		exports['mythic_notify']:SendAlert('error', 'Task failed!')
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('ogrp_skill',0,'hacking',1)
		incLast = false
	end
end

--- Command for the job

RegisterCommand('cloc', function(source, args, rawCommand)
	if onDuty then
		if not activeJob then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				startJob()
			else
				exports['mythic_notify']:SendAlert('error', 'You can only do that in a vehicle')
			end
		else
			exports['mythic_notify']:SendAlert('error', 'Finish your current job first!')
		end
	else
		exports['mythic_notify']:SendAlert('error', 'You are off-duty')
	end
end)

TriggerEvent('chat:addSuggestion', '/cloc', 'Get a new job location (For Hackers)')

-- Draw Text

function DrawText3D(x,y,z, text)
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
end

local commonItems = {'electronics','wire'}
local rareItems = {'electronics','wire'}
local superItems = {'electronics','wire'}

function give(type)
    local dropi = 1
    if type == 'common' then
		dropi = math.random(1, #commonItems)
		if commonItems[dropi] == 'electronics' then
			TriggerEvent('player:receiveItem', commonItems[dropi] , math.random(1,8))
		else
			TriggerEvent('player:receiveItem', commonItems[dropi] , 1)
		end
    elseif type == 'rare' then
        dropi = math.random(1, #rareItems)
        TriggerEvent('player:receiveItem', rareItems[dropi] , 1)
    elseif type == 'super' then 
        dropi = math.random(1, #superItems)
        TriggerEvent('player:receiveItem', superItems[dropi] , 1)
    end
end