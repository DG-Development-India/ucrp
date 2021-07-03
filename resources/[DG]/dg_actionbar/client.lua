DGCore = nil

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

Citizen.CreateThread(function()
    while DGCore == nil or DGCore.PlayerData == nil or DGCore.PlayerData.job == nil do
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

local guiOpen = false
local currentWeapons = {}
local disableHotbarx = false

RegisterNetEvent('disableHotbar')
AddEventHandler('disableHotbar', function(statusx)
	disableHotbarx = statusx
end)

RegisterNetEvent('updateAllAmmo')
AddEventHandler('updateAllAmmo', function(data)
	currentWeapons = data
end)

local selected = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0
}

unholsteringactive = false
local usedGun = {}
local prevupdate = 0
local gunEquipped = false
local armed = false
local sleeploop = false
local policeweapons = {}
local droppedweapons = {}
local currentInformation = 0
local CurrentID = 0
local CurrentSqlID = 0
local TIME_REMOVED_FOR_DEG = 1000 * 60 * 5 -- 5 mins 

RegisterNUICallback('dropweapon', function(data, cb)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

local Drops = {}
local allowwait = false

function WeaponSlot(hash)
    local strHash = "" .. GetWeapontypeGroup(hash) .. ""
    if weaponTypes[strHash] then
        return weaponTypes[strHash]["slot"]
    else
        return 4
    end
end


local displaycounter = 0
local shieldActive = false
local shieldEntity = nil
local hadPistol = false

-- ANIM

local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"
local pistol = `WEAPON_PISTOL`

local lastWeaponDeg = 0

function attemptToDegWeapon()
	if math.random(100) > 85 then
		local hasTimer = 99999
		hasTimer = (GetGameTimer()-lastWeaponDeg)
		if  hasTimer >= 2000 then
			lastWeaponDeg = GetGameTimer();
			TriggerServerEvent("inventory:degItem",CurrentSqlID)
		end
	end
end

Controlkey = {["actionBar"] = {37,"TAB"}} 

RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
	Controlkey["actionBar"] = table["actionBar"]
end)



Citizen.CreateThread( function()

	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()

		if IsPedShooting(ped) then
			local hash = GetSelectedPedWeapon(ped)
			local hash2 = tostring(hash)
			local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)
			currentWeapons[hash2] = GetAmmoInPedWeapon(ped, hash)
			attemptToDegWeapon()
		end

		if unholsteringactive then
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		end

		prevupdate = prevupdate - 1
		local pressed1, pressed2, pressed3, pressed4, pressed5 = false, false, false, false, false

		if not disableHotbarx then
			if IsControlJustReleased(0,157) or IsDisabledControlJustReleased(0,157) and not pressed1 then
				pressed1 = true
				TriggerEvent("inventory-bind",1)
				Citizen.Wait(2000)
				pressed1 = false

			end

			if IsControlJustReleased(0,158) or IsDisabledControlJustReleased(0,158) and not pressed2 then
				pressed2 = true
				TriggerEvent("inventory-bind",2)
				Citizen.Wait(2000)
				pressed2 = false
			end

			if IsControlJustReleased(0,160) or IsDisabledControlJustReleased(0,160) and not pressed3 then
				pressed3 = true
				TriggerEvent("inventory-bind",3)
				Citizen.Wait(2000)
				pressed3 = false
			end

			if IsControlJustReleased(0,164) or IsDisabledControlJustReleased(0,164) and not pressed4 then
				pressed4 = true
				TriggerEvent("inventory-bind",4)
				Citizen.Wait(2000)
				pressed4 = false
			end

			if IsControlJustReleased(0,165) or IsDisabledControlJustReleased(0,165) and not pressed5 then
				pressed5 = true
				TriggerEvent("inventory-bind",5)
				Citizen.Wait(2000)
				pressed5 = false
			end
		end

		if IsControlJustPressed(0,Controlkey["actionBar"][1]) or IsDisabledControlJustPressed(0,Controlkey["actionBar"][1]) then
			TriggerEvent("inventory-bar",true)
		end

		if IsControlJustReleased(0,Controlkey["actionBar"][1]) or IsDisabledControlJustReleased(0,Controlkey["actionBar"][1]) then
			TriggerEvent("inventory-bar",false)
		end

		if 'WEAPON_UNARMED' ~= GetSelectedPedWeapon(PlayerPedId()) then
			DisplayAmmoThisFrame(true)
		end

		if IsPedPlantingBomb(ped) then
			if exports["dg-inventory"]:hasEnoughOfItem("741814745",1,false) then
				TriggerEvent("inventory:removeItem", 741814745, 1)
				Citizen.Wait(3000)
			end
		end

	end

end)

function helpDisplay(text, state)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

RegisterNUICallback('equipweapon', function(data, cb)
	equipWeaponID(data.saveid)
end)

lasthash = 0
lastslot = 2

RegisterNetEvent('equipWeaponID')
AddEventHandler('equipWeaponID', function(_hash,newInformation,sqlID)
	
	local hash = tonumber(_hash)

	CurrentSqlID = sqlID
	currentInformation = json.decode(newInformation)

	if (currentInformation.cartridge == nil) then
		currentInformation = "Scratched off data"
	else
		currentInformation = currentInformation.cartridge
	end

	TriggerEvent("evidence:bulletInformation", currentInformation)

	local dead = exports["isPed"]:isPed("dead")
	if dead then
		return
	end

	if 'WEAPON_UNARMED' == GetSelectedPedWeapon(PlayerPedId()) then
		armed = false
	end

	if armed then

		armed = false
		TriggerEvent('updateWeapon',0)
		TriggerEvent("hud-display-item",hash,"Holster")

		holster1h()
		TriggerServerEvent('dg:updateAmmoCount',currentWeapons)
		
	else

		armed = true
		TriggerEvent('updateWeapon',hash)
		TriggerEvent("hud-display-item",hash,"Equip")
		unholster1h(hash,true)

	end

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)
	SetPedAmmo(PlayerPedId(),  `WEAPON_PetrolCan`, 10000)

end)

RegisterNetEvent('brokenWeapon')
AddEventHandler('brokenWeapon', function()
	local dead = exports["isPed"]:isPed("dead")
	if dead then return end

	holster1h()
	armed = false

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)
	SetPedAmmo(PlayerPedId(),  `WEAPON_PetrolCan`, 10000)

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('actionbar:ammo')
AddEventHandler('actionbar:ammo', function(hash,amount,addition)

	local ped = PlayerPedId()
	local hashx = GetSelectedPedWeapon(ped)
	local hashx2 = tostring(hashx)

	if currentWeapons[hashx2] == nil then
		currentWeapons[hashx2] = 0
	end

	currentWeapons[hashx2] = currentWeapons[hashx2] + amount

	SetPedAmmo(ped, hashx, currentWeapons[hashx2])
	TriggerServerEvent('dg:updateAmmoCount',currentWeapons)

end)

RegisterNetEvent('armory:ammo')
AddEventHandler('armory:ammo', function()
	TriggerEvent("actionbar:ammo",1950175060,150,true)
	TriggerEvent("actionbar:ammo",218444191,150,true)
	TriggerEvent("actionbar:ammo",-1878508229,150,true)
	TriggerEvent("actionbar:ammo",1820140472,150,true)
end)

RegisterNetEvent('actionbar:setEmptyHanded')
AddEventHandler('actionbar:setEmptyHanded', function()
	prevupdate = 0
	Wait(500)
	--SetCurrentPedWeapon(PlayerPedId(), 'WEAPON_UNARMED', true)
end)



function unholster1h(weaponHash)
	unholsteringactive = true
	local dict = "reaction@intimidation@1h"
	local anim = "intro"
	local myJob = DGCore.PlayerData.job.name
	local ped = PlayerPedId()

	if myJob == "police" then
		
		copunholster(weaponHash)
		print('cop')

	    if weaponHash == 3219281620 then
			GiveWeaponComponentToPed(PlayerPedId(), 3219281620, `COMPONENT_AT_PI_FLSH_02` )
	    end

	    if weaponHash == 736523883 then
			GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_AR_FLSH` )
			GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_SCOPE_MACRO_02` )	
	    end

		if weaponHash == -2084633992 then
			print('adding attechments')
			GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_FLSH` )
			GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_AFGRIP` )
			GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_SCOPE_MEDIUM` )
	    end
	    if weaponHash == 1432025498 then
			GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_SCOPE_MACRO_MK2` )
			GiveWeaponComponentToPed( ped, 1432025498, `COMPONENT_AT_AR_FLSH` )
	    end

	    if weaponHash == 2024373456 then
			GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_AR_FLSH` )
			GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SIGHTS_SMG` )	
			GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_MUZZLE_01` )
			GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SB_BARREL_02` )	
	    end

	    if weaponHash == -86904375 then

	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_MUZZLE_04` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_FLSH` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_SIGHTS` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_AFGRIP_02` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_CR_BARREL_02` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER` )
	    end

	    if weaponHash == -1075685676 then
	    	GiveWeaponComponentToPed( ped, -1075685676, `COMPONENT_AT_PI_FLSH_02` )
	    end

	    AttachmentCheck(weaponHash)

	    Citizen.Wait(450)
	    unholsteringactive = false
		return
	end

	RemoveAllPedWeapons(ped)

	if weaponHash ~= -538741184 and weaponHash ~= 615608432 then
		local animLength = GetAnimDuration(dict, anim) * 1000
	    loadAnimDict(dict) 
	    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
		Citizen.Wait(900)
		
		local weaponHash2 = tostring(weaponHash)

		if currentWeapons[weaponHash2] == nil then
			currentWeapons[weaponHash2] = 0
		end

	    GiveWeaponToPed(ped, weaponHash, currentWeapons[weaponHash2], 0, 1)
		SetCurrentPedWeapon(ped, weaponHash, 1)
		
	else

		GiveWeaponToPed(ped, weaponHash, 0 , 1, 0)
		SetCurrentPedWeapon(ped, weaponHash, 0)

	end

    AttachmentCheck(weaponHash)
    Citizen.Wait(500)
    ClearPedTasks(ped)
    Citizen.Wait(1200)
    unholsteringactive = false

end

function AttachmentCheck(weaponhash)
	if exports["dg-inventory"]:hasEnoughOfItem("silencer_l",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP` )
	end

	if exports["dg-inventory"]:hasEnoughOfItem("silencer_l2",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP_02` )
	end

	if exports["dg-inventory"]:hasEnoughOfItem("silencer_s",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP` )
	end

	if exports["dg-inventory"]:hasEnoughOfItem("silencer_s2",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP_02` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("extended_ap",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_APPISTOL_CLIP_02` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("extended_sns",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_SNSPISTOL_CLIP_02` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("extended_micro",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_MICROSMG_CLIP_02` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("MediumScope",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MEDIUM` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("SmallScope",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_SMALL` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("TinyScope",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MACRO` )	
	end

	if exports["dg-inventory"]:hasEnoughOfItem("extended_tec9",1,false) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_MACHINEPISTOL_CLIP_02` )	
	end
end


function copunholster(weaponHash)
	local dic = "reaction@intimidation@cop@unarmed"
  	local anim = "intro"
	local ammoCount = 0
   	loadAnimDict( dic ) 
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped)
	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0 )
	Citizen.Wait(600)
	local weaponHash2 = tostring(weaponHash)

	if currentWeapons[weaponHash2] == nil then
		currentWeapons[weaponHash2] = 0
	end

	GiveWeaponToPed(ped, weaponHash, currentWeapons[weaponHash2], 0, 1)
	SetCurrentPedWeapon(ped, weaponHash, 1)
	ClearPedTasks(ped)
end

function copholster()
  	local dic = "reaction@intimidation@cop@unarmed"
  	local anim = "intro"
  	local ammoCount = 0
   	loadAnimDict(dic) 
	local ped = PlayerPedId()
	prevupdate = 0
	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0 )
	Citizen.Wait(600)
	SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, 1)
	RemoveAllPedWeapons(ped)
	ClearPedTasks(ped)
end

function holster1h()

	unholsteringactive = true
	local dict = "reaction@intimidation@1h"
	local anim = "outro"
	local myJob = DGCore.PlayerData.job.name
	if myJob == "police" then
		copholster()
		Citizen.Wait(600)
		unholsteringactive = false
		return
	end
	local ped = PlayerPedId()

	prevupdate = 0
	local animLength = GetAnimDuration(dict, anim) * 1000
    loadAnimDict(dict) 
    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)   
    Citizen.Wait(animLength - 2200)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, 1)
    Citizen.Wait(300)
    RemoveAllPedWeapons(ped)
    ClearPedTasks(ped)
    Citizen.Wait(800)
    unholsteringactive = false
end

function holster2h(weaponHash)
	unholsteringactive = true
	local dict = "amb@world_human_golf_player@male@idle_a"
	local anim = "idle_a"
	local ped = PlayerPedId()
	prevupdate = 0
    loadAnimDict(dict) 
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, 1)
    TriggerEvent("attachWeaponPull",weaponHash,true)
    TaskPlayAnim(ped, dict, anim, 1.5, 1.5, -1, 49, 10, 0, 0, 0)   
    Citizen.Wait(1200)  
    RemoveAllPedWeapons(ped)
    ClearPedTasks(ped)
    Citizen.Wait(500)
    unholsteringactive = false
end

function grab2h(weaponHash)
	unholsteringactive = true
	local dict = "amb@world_human_golf_player@male@idle_a"
	local anim = "idle_a"
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped)
    loadAnimDict(dict) 
    TaskPlayAnim(ped, dict, anim, 1.5, 1.5, -1, 49, 10, 0, 0, 0)   
    Citizen.Wait(1100)
    TriggerEvent("attachWeaponPull",weaponHash,false)
    ClearPedTasks(ped)
	Citizen.Wait(650)
	
	local weaponHash2 = tostring(weaponHash)
	if currentWeapons[weaponHash2] == nil then
		currentWeapons[weaponHash2] = 0
	end

	GiveWeaponToPed(ped, weaponHash, currentWeapons[weaponHash2], 0, 1)

	SetCurrentPedWeapon(ped, weaponHash, 1)
    ClearPedTasks(ped)

    local myJob = DGCore.PlayerData.job.name
	if myJob == "police" then
	    if weaponHash == 2210333304 then
			GiveWeaponComponentToPed( ped, 2210333304, `COMPONENT_AT_AR_FLSH` )
			GiveWeaponComponentToPed( ped, 2210333304, `COMPONENT_AT_AR_AFGRIP_02` )
			GiveWeaponComponentToPed( ped, 2210333304, `COMPONENT_AT_SCOPE_MEDIUM` )
			GiveWeaponComponentToPed( ped, 2210333304, `COMPONENT_AT_AR_SUPP_02` )   	
	    end
	   
	    Citizen.Wait(600)

    	unholsteringactive = false
		return
	end

    Citizen.Wait(600)
    unholsteringactive = false
end