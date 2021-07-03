DGCore = nil
local fire = nil
local fireexist = false

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("thermite:StartClientFires")
AddEventHandler("thermite:StartClientFires", function(x,y,z,arg1,arg2)
  fire = StartScriptFire(x,y,z,arg1,arg2)
  fireexist = true
end)

RegisterNetEvent("thermite:StopFiresClient")
AddEventHandler("thermite:StopFiresClient", function(x,y,z)
  if fire then
    RemoveScriptFire(fire)
    StopFireInRange(x,y,z,25.0)
    fireexist = false
  end
end)

function startFireAtLocation(x,y,z,time)
  local _time = tonumber(time)
  TriggerServerEvent("thermite:StartFireAtLocation",x,y,z,24,false)
  Citizen.Wait(_time)
  TriggerServerEvent("thermite:StopFires",x,y,z)
end

function randomFloat(min, max, precision)
    local range = max - min
    local offset = range * math.random()
    local unrounded = min + offset

    if not precision then
        return unrounded
    end

    local powerOfTen = 10 ^ precision
    return math.floor(unrounded * powerOfTen + 0.5) / powerOfTen
end

local currentlyInGame = false
local passed = false;


-----------------
-- dropAmount , the amount of letters to drop for completion
-- Letter , the letter set , letterset 1 = [q,w,e,r] letterset 2 = [q,w,e,j,k,l] , the set is used to determain what letters will drop
-- speed , the speed that the letters move on the screen
-- inter , interval , the time between letter drops
----------------

function startGame(dropAmount,letter,speed,inter)
    openGui()
    play(dropAmount,letter,speed,inter)
    currentlyInGame = true
    while currentlyInGame do
      Wait(400)
      if exports["dg-ambulancejob"]:GetDeath() then 
        closeGui()
      end 
    end
    return passed;
end

local gui = false

function openGui()
    gui = true
    SetNuiFocus(true,true)
    SendNUIMessage({openPhone = true})
end

function play(dropAmount,letter,speed,inter) 
  SendNUIMessage({openSection = "playgame", amount = dropAmount,letterSet = letter,speed = speed,interval = inter})
end

function CloseGui()
    currentlyInGame = false
    gui = false
    SetNuiFocus(false,false)
    SendNUIMessage({openPhone = false})
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  CloseGui()
  cb('ok')
end)

RegisterNUICallback('failure', function(data, cb)
  passed = false
  TriggerEvent('DoLongHudText', 'Failure', 2)
  CloseGui()
  cb('ok')
  Citizen.Wait(1500)
  FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNUICallback('complete', function(data, cb)
  passed = true
  TriggerEvent('DoLongHudText', 'Success!')
  CloseGui()
  cb('ok')
end)

AddEventHandler("onResourceStart", function(resource)
  if resource == GetCurrentResourceName() then
    TriggerServerEvent("thermite:StopFires")
  end
end)

Citizen.CreateThread(function()
  while true  do
    Citizen.Wait(200)
    if fireexist then
      local coords = GetEntityCoords(PlayerPedId())
      if IsShockingEventInSphere(88,coords,10.0) then
        TriggerServerEvent("thermite:StopFires",coords.x,coords.y,coords.z)
        fireexist = false
      end
    end
  end
end)