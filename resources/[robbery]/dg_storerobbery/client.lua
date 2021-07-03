DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end

	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

local robCoords = 0
local robCoordsATM = 0
local playerRobbing = false

local storeCoords = {
    {x = -709.67, y = -904.17, z = 19.22, h = 87.93 },
    {x = 378.19, y = 333.42, z = 103.57, h = 345.2 },
    {x = -43.42, y = -1748.47, z = 29.42, h = 50.94 },
    {x = 1159.45, y = -314.0, z = 69.21, h = 99.71},
    {x = 28.24, y = -1339.14, z = 29.5, h = 356.38}
}

local atmCoords = {
    {x = -717.61, y = -915.72, z = 19.22, h = 89.75 },
    {x = 380.83, y = 323.53, z = 103.57, h = 160.79 },
    {x = -56.92, y = -1752.17, z = 29.42, h = 45.28 },
    {x = 1159.45, y = -326.76, z = 69.21, h = 94.41},
    {x = 33.17, y = -1348.25, z = 29.5, h = 176.65}
}

-- Store Robbery

RegisterNetEvent('cancelstorerob')
AddEventHandler('cancelstorerob', function()
    playerRobbing = false
end)


RegisterNetEvent('rob:store')
AddEventHandler('rob:store', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for k,v in pairs (storeCoords) do
        local distance = Vdist(playerCoords,v.x, v.y , v.z)
        if distance <= 0.5 then
            DGCore.TriggerServerCallback('checkCooldown', function(checked)
                if checked then
                    DGCore.TriggerServerCallback('checkCops', function(copnumber)
                        if copnumber > 1  then
                            robCoords = v
                            playerRobbing = true
                            TriggerEvent("safecracking:start")
                            TriggerServerEvent('startCooldown',15)
                            TriggerEvent('inv:remove','advlockpick',1)
                            TriggerServerEvent('notifyCops','Store',v,458,'10-90(B)')
                            -- TriggerEvent('dg-dispatch:storerobbery')
                            SetEntityHeading(playerPed,v.h)
                        else
                            exports['mythic_notify']:SendAlert('error', 'Not enough security')
                        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'The store was robbed recently')
                end
            end)
        end
    end
end)

-- ATM Robbery

RegisterNetEvent('rob:storeatm')
AddEventHandler('rob:storeatm', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for k,v in pairs (atmCoords) do
        local distance = Vdist(playerCoords,v.x, v.y , v.z)
        if distance <= 0.5 then
            DGCore.TriggerServerCallback('checkCooldown2', function(checked)
                if checked then
                    DGCore.TriggerServerCallback('checkCops', function(copnumber)
                        if copnumber > 1  then
                            robCoordsATM = v
                            playerRobbing = true
                            TriggerEvent("mhacking:show")
						    TriggerEvent("mhacking:start",3,20, robbedATM)
                            TriggerEvent('inv:remove','vpnxj',1)
                            -- TriggerEvent('dg-dispatch:storerobbery')
                            SetEntityHeading(playerPed,v.h)
                        else
                            exports['mythic_notify']:SendAlert('error', 'Not enough security')
                        end
                    end)
                else
                    exports['mythic_notify']:SendAlert('error', 'Bank server is currently down')
                end
            end)
        end
    end
end)

-- Normal ATM Robbery

local atms = {
    [1] = -1126237515,
    [2] = 506770882,
    [3] = 150237004,
    [4] = -239124254,
    [5] = -1364697528,  
  }
  

v_5_b_atm1=150237004
v_5_b_atm2=-239124254

prop_atm_03=-1364697528

function IsNearATM()
    for i = 1, #atms do
        local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 0.75, atms[i], 0, 0, 0)
  
        if DoesEntityExist(objFound) then
            return true
        end
    end
    return false
end

RegisterNetEvent('rob:atm')
AddEventHandler('rob:atm', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    if IsNearATM() then
        print('near ATM')
        DGCore.TriggerServerCallback('checkCooldown2', function(checked)
            if checked then
                DGCore.TriggerServerCallback('checkCops', function(copnumber)
                    if copnumber > 0  then
                        robCoordsATM = playerCoords
                        playerRobbing = true
                        TriggerEvent("mhacking:show")
                        TriggerEvent("mhacking:start",4,30, robbedlocalATM)
                    else
                        exports['mythic_notify']:SendAlert('error', 'Not enough security')
                    end
                end)
            else
                exports['mythic_notify']:SendAlert('error', 'Bank server is currently down')
            end
        end)
    end
end)

-- Loading Search Anim

function LoadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(10)
    end
end

-- Show Notification

RegisterNetEvent('notifyCops')
AddEventHandler('notifyCops', function(type,coords,xx,yy)
    local sprite = xx 
    local dispatch = yy
    local newsDispatch = "Local reported: "
    local streetName,_ = GetStreetNameAtCoord(coords.x,coords.y,coords.z)
    local streetName = GetStreetNameFromHashKey(streetName)
    local robbery = 'An ongoing '.. type .. ' robbery at ' ..streetName
    
    if exports["isPed"]:isPed("myjob") == 'police' then
        TriggerEvent('chat:addMessage', {
			templateId = 'admindm',
			args = {"Dispatch: ".. dispatch, robbery }
		})

		local robblip = AddBlipForCoord(coords.x, coords.y , coords.z)
		SetBlipSprite (robblip, sprite)
		SetBlipColour (robblip, 1)
        SetBlipScale (robblip, 1.5)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(''.. type .. ' Robbery')
		EndTextCommandSetBlipName(robblip)
		Citizen.Wait(5*60*1000)
		RemoveBlip(robblip)
    
    elseif exports["isPed"]:isPed("myjob") == 'news' and type ~= 'ATM' then
        TriggerEvent('chat:addMessage', {
			templateId = 'admindm',
			args = {newsDispatch, robbery}
		})
        PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        local robblip = AddBlipForCoord(coords.x, coords.y , coords.z)
		SetBlipSprite (robblip, sprite)
		SetBlipColour (robblip, 1)
        SetBlipScale (robblip, 1.5)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(''.. type .. ' Robbery')
		EndTextCommandSetBlipName(robblip)
		Citizen.Wait(5*60*1000)
		RemoveBlip(robblip)
    end
end)

-- Store Reward

RegisterNetEvent('safe:success')
AddEventHandler('safe:success', function()
    local playerPed = PlayerPedId()
    local reward1 = math.random(28,30)
    --local reward2 = math.random(12,15)
    local special = math.random(1,100)
    if special > 50 and special < 80 then
        if math.random(2) == 1 then
            TriggerEvent('player:receiveItem', 'securityblue', 1)
        -- else
        --     TriggerEvent('player:receiveItem', 'Gruppe6Card3', 1)
        end
    elseif special > 79 and special < 95 then
        TriggerEvent('player:receiveItem', 'securitygreen', 1)
    end
    SetEntityCoords(robCoords.x, robCoords.y-1.0, robCoords.z)
    LoadDict('amb@medic@standing@tendtodead@idle_a')
	TaskPlayAnim(GetPlayerPed(-1), 'amb@medic@standing@tendtodead@idle_a', 'idle_a', 8.0, -8.0, -1, 1, 0.0, 0, 0, 0)
    local stage1 = exports["dg-taskbar"]:taskBar(2*60*1000, "Searching for Valuables")
    Wait(200)
    TriggerEvent('player:receiveItem', 'cashroll', reward1)
    Wait(200)
    --TriggerEvent('player:receiveItem', 'cashroll', reward2)
    ClearPedTasksImmediately(playerPed)
    playerRobbing = false
    TriggerServerEvent('dg_skill',1,'criminal',1)
end)

-- Store ATM REWARD

function robbedATM(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
        TriggerEvent('dg_emotes:playthisemote','atm')
        TriggerServerEvent('startCooldown2',15)
        TriggerServerEvent('notifyCops','ATM',robCoordsATM,500,'10-90(C)')
        SetEntityCoords(robCoordsATM.x, robCoordsATM.y, robCoordsATM.z)
        local looting = exports["dg-taskbar"]:taskBar(2*60*1000, "Withdrawing money")
        TriggerEvent('dg_emotes:playthisemote','c')
		TriggerServerEvent("dg_base:addmoney", math.random(1000,1500), "Robbing the Store ATM")
		TriggerServerEvent('dg_skill',1,'criminal',1)
        playerRobbing = false
	else
		exports['mythic_notify']:SendAlert('error', 'Task failed!')
        playerRobbing = false
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('dg_skill',0,'criminal',1)
	end
end

-- Normal ATM REWARD

function robbedlocalATM(success, timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
        TriggerEvent('dg_emotes:playthisemote','atm')
        TriggerServerEvent('startCooldown2',5)
        TriggerServerEvent('notifyCops','ATM',robCoordsATM,500,'10-90(C)')
        SetEntityCoords(robCoordsATM.x, robCoordsATM.y, robCoordsATM.z)
        local looting = exports["dg-taskbar"]:taskBar(1*60*1000, "Withdrawing money")
        TriggerEvent('dg_emotes:playthisemote','c')
		TriggerServerEvent("dg_base:addmoney", math.random(100,250), "Robbing the ATM")
		TriggerServerEvent('dg_skill',1,'criminal',1)
        playerRobbing = false
	else
		exports['mythic_notify']:SendAlert('error', 'Task failed!')
        playerRobbing = false
		TriggerEvent('mhacking:hide')
		TriggerServerEvent('dg_skill',0,'criminal',1)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if playerRobbing then
            DisableAllControlActions(0,73,true)
            EnableControlAction(0,249,true)
            EnableControlAction(0,0,true)
            EnableControlAction(0,1,true)
            EnableControlAction(0,2,true)
            EnableControlAction(0,3,true)
			EnableControlAction(0,4,true)
            EnableControlAction(0,5,true)
            EnableControlAction(0,6,true)
            EnableControlAction(0,23,true)
            EnableControlAction(0,38,true)
            EnableControlAction(0,74,true)
            EnableControlAction(0,44,true)
			EnableControlAction(0,20,true)
			EnableControlAction(0,245,true)
            EnableControlAction(0,177,true)
            EnableControlAction(0,246,true)
        end
    end
end)