DGCore = nil
--local taxiJobCoords = {x = 907.86, y= -176.43, z = 74.15 }
local recycleCoords = {x = 895.9414, y = -896.2136, z = 27.7973 }
local bennysCoords = {x = -207.4775, y = -1331.583, z = 31.95231 }
local tacoCoords = {x = 14.85086, y = -1600.539, z = 29.37658 }
local repairCoords = {x = 942.5527, y = -975.9023, z = 39.49982 }
local pillboxCoords = {x = 322.5744, y = -595.401, z = 43.2841 }
--local burgershotCoords = {x = 743.04, y = -1906.29, z = 29.29 }
--local GoCoords = {x = 79.04, y = 111.82, z = 81.17 }
--local MecCoords = { x = 483.33, y = -1889.7, z = 294.62}

local sellChicken = { x = -591.5437, y = -892.665, z = 25.94248}
local startChicken = {x = 2388.725 , y = 5044.985, z = 46.304}
local convertChicken = {x = -96.007, y =  6206.92, z  = 31.02}
local groceryShop = {x = 1791.27, y =  4592.847, z  = 37.68294}
local burgershotcoords = {x = -1195.25, y = -891.61, z = 15.3}
local Mcdonaldcoords = {x = 272.1775, y = -964.7712, z = 29.30465}
local Pdmcoords = {x = 131.9699, y = -145.2902, z = 66.12199}
local allblips = {}

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end

	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    DGCore.PlayerData = DGCore.GetPlayerData()
    showBlips()
end)

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
	DGCore.PlayerData = xPlayer
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
    DGCore.PlayerData.job = job
    showBlips()
end)

function showBlips()
    
    DeleteBlips()
    
    -- if DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'taxi' then

	--     local blip = AddBlipForCoord(taxiJobCoords.x, taxiJobCoords.y , taxiJobCoords.z)
	--     SetBlipSprite (blip, 198)
	--     SetBlipDisplay(blip, 4)
	--     SetBlipScale  (blip, 0.8)
	--     SetBlipColour (blip, 5)
	--     SetBlipAsShortRange(blip, true)
	--     BeginTextCommandSetBlipName('STRING')
	--     AddTextComponentSubstringPlayerName('Taxi HeadQuarters')
    --     EndTextCommandSetBlipName(blip)
    --     table.insert(allblips, blip)

    -- elseif DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'hacker' then

    --     local hblip = AddBlipForCoord(hackerCoords.x, hackerCoords.y , hackerCoords.z)
	--     SetBlipSprite (hblip, 521)
	--     SetBlipDisplay(hblip, 4)
	--     SetBlipScale  (hblip, 0.8)
	--     SetBlipColour (hblip, 11)
	--     SetBlipAsShortRange(hblip, true)
	--     BeginTextCommandSetBlipName('STRING')
	--     AddTextComponentSubstringPlayerName('E-Corp Inc.')
    --     EndTextCommandSetBlipName(hblip)
    --     table.insert(allblips, hblip)

    -- elseif DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'mechanic' then

    --     local mblip = AddBlipForCoord(MecCoords.x, MecCoords.y , MecCoords.z)
	--     SetBlipSprite (mblip, 317)
	--     SetBlipDisplay(mblip, 4)
	--     SetBlipScale  (mblip, 0.8)
	--     SetBlipColour (mblip, 47)
	--     SetBlipAsShortRange(mblip, true)
	--     BeginTextCommandSetBlipName('STRING')
	--     AddTextComponentSubstringPlayerName('Heavy Duty Vehicles')
    --     EndTextCommandSetBlipName(mblip)
    --     table.insert(allblips, mblip)    

    -- elseif DGCore.PlayerData and DGCore.PlayerData.job and DGCore.PlayerData.job.name == 'gopostal' then

    --     local gpblip = AddBlipForCoord(GoCoords.x, GoCoords.y, GoCoords.z)
    --     SetBlipSprite (gpblip, 541)
    --     SetBlipDisplay(gpblip, 4)
    --     SetBlipScale  (gpblip, 0.7)
    --     SetBlipColour (gpblip, 51)
    --     SetBlipAsShortRange(gpblip, true)
    --     BeginTextCommandSetBlipName('STRING')
    --     AddTextComponentSubstringPlayerName('Go Postal HQ')
    --     EndTextCommandSetBlipName(gpblip)
    --     table.insert(allblips, gpblip)    
    
     --end

end

function DeleteBlips()
    for k,v in pairs(allblips) do
        RemoveBlip(v)
    end
end

Citizen.CreateThread(function()

    local lapaniek = AddBlipForCoord(startChicken.x, startChicken.y , startChicken.z)
    SetBlipSprite (lapaniek, 126)
    SetBlipDisplay(lapaniek, 4)
    SetBlipScale  (lapaniek, 0.6)
    SetBlipColour (lapaniek, 46)
    SetBlipAsShortRange(lapaniek, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Chicken Farm')
    EndTextCommandSetBlipName(lapaniek)
    
    local rzeznia = AddBlipForCoord(convertChicken.x, convertChicken.y , convertChicken.z)
    SetBlipSprite (rzeznia, 273)
    SetBlipDisplay(rzeznia, 4)
    SetBlipScale  (rzeznia, 0.6)
    SetBlipColour (rzeznia, 46)
    SetBlipAsShortRange(rzeznia, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Slaughterhouse')
    EndTextCommandSetBlipName(rzeznia)
        
    local skupk = AddBlipForCoord(sellChicken.x, sellChicken.y, sellChicken.z)
    SetBlipSprite (skupk, 478)
    SetBlipDisplay(skupk, 4)
    SetBlipScale  (skupk, 0.6)
    SetBlipColour (skupk, 46)
    SetBlipAsShortRange(skupk, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Chicken Dealer')
    EndTextCommandSetBlipName(skupk)

    local rblip = AddBlipForCoord(recycleCoords.x, recycleCoords.y , recycleCoords.z)
	SetBlipSprite (rblip, 467)
	SetBlipDisplay(rblip, 4)
	SetBlipScale  (rblip, 1.0)
	SetBlipColour (rblip, 21)
	SetBlipAsShortRange(rblip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Recycle Center')
    EndTextCommandSetBlipName(rblip)

    local mcblip = AddBlipForCoord(bennysCoords.x, bennysCoords.y , bennysCoords.z)
	SetBlipSprite (mcblip, 643)
	SetBlipDisplay(mcblip, 4)
	SetBlipScale  (mcblip, 1.0)
	SetBlipColour (mcblip, 11)
	SetBlipAsShortRange(mcblip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Benny\'s Custom')
    EndTextCommandSetBlipName(mcblip)

    local tacoblip = AddBlipForCoord(tacoCoords.x, tacoCoords.y , tacoCoords.z)
	SetBlipSprite (tacoblip, 436)
	SetBlipDisplay(tacoblip, 4)
	SetBlipScale  (tacoblip, 1.0)
	SetBlipColour (tacoblip, 5)
	SetBlipAsShortRange(tacoblip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Tacoshop')
    EndTextCommandSetBlipName(tacoblip)

    local repairblip = AddBlipForCoord(repairCoords.x, repairCoords.y , repairCoords.z)
	SetBlipSprite (repairblip, 544)
	SetBlipDisplay(repairblip, 4)
	SetBlipScale  (repairblip, 1.2)
	SetBlipColour (repairblip, 0)
	SetBlipAsShortRange(repairblip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Mechanic shop')
    EndTextCommandSetBlipName(repairblip)

    local pillboxblip = AddBlipForCoord(pillboxCoords.x, pillboxCoords.y , pillboxCoords.z)
	SetBlipSprite (pillboxblip, 153)
	SetBlipDisplay(pillboxblip, 4)
	SetBlipScale  (pillboxblip, 1.2)
	SetBlipColour (pillboxblip, 38)
	SetBlipAsShortRange(pillboxblip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Pillbox Hill Medical Centre')
    EndTextCommandSetBlipName(pillboxblip)

    local grocery = AddBlipForCoord(groceryShop.x, groceryShop.y, groceryShop.z)
    SetBlipSprite (grocery, 541)
    SetBlipDisplay(grocery, 4)
    SetBlipScale  (grocery, 0.6)
    SetBlipColour (grocery, 25)
    SetBlipAsShortRange(grocery, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Grocery Shop')
    EndTextCommandSetBlipName(grocery)

    local burgershotblip = AddBlipForCoord(burgershotcoords.x, burgershotcoords.y, burgershotcoords.z)
    SetBlipSprite (burgershotblip, 106)
    SetBlipDisplay(burgershotblip, 4)
    SetBlipScale  (burgershotblip, 0.6)
    SetBlipColour (burgershotblip, 5)
    SetBlipAsShortRange(burgershotblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('BurgerShot')
    EndTextCommandSetBlipName(burgershotblip)

    local Mcdonaldblip = AddBlipForCoord(Mcdonaldcoords.x, Mcdonaldcoords.y, Mcdonaldcoords.z)
    SetBlipSprite (Mcdonaldblip, 124)
    SetBlipDisplay(Mcdonaldblip, 4)
    SetBlipScale  (Mcdonaldblip, 0.6)
    SetBlipColour (Mcdonaldblip, 1)
    SetBlipAsShortRange(Mcdonaldblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('McDonald')
    EndTextCommandSetBlipName(Mcdonaldblip)

    local Pdmblip = AddBlipForCoord(Pdmcoords.x, Pdmcoords.y, Pdmcoords.z)
    SetBlipSprite (Pdmblip, 326)
    SetBlipDisplay(Pdmblip, 4)
    SetBlipScale  (Pdmblip, 0.6)
    SetBlipColour (Pdmblip, 1)
    SetBlipAsShortRange(Pdmblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Exclusive Cardealer')
    EndTextCommandSetBlipName(Pdmblip)

end)