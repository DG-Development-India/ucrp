local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}

local WeaponDamage = {
    {name = "WEAPON_PISTOL", damage = 0.50},
    {name = "WEAPON_APPISTOL", damage = 0.50},
    {name = "WEAPON_SNSPISTOL", damage = 0.45},
    {name = "WEAPON_VINTAGEPISTOL", damage = 0.35},
	{name = "WEAPON_COMBATPISTOL", damage = 0.55},
	{name = "WEAPON_HEAVYPISTOL", damage = 0.45},
	{name = "WEAPON_PISTOL_MK2", damage = 0.55},
    {name = "WEAPON_PISTOL50", damage = 0.50},
	{name = "WEAPON_REVOLVER", damage = 1.00},
	{name = "WEAPON_MACHINEPISTOL", damage = 0.50},
	{name = "WEAPON_MINISMG", damage = 0.65},	
	{name = "WEAPON_SMG", damage = 0.65},
	{name = "WEAPON_ASSAULTSMG", damage = 0.65},
	{name = "WEAPON_ASSAULTSMG_MK2", damage = 0.65},
    {name = "WEAPON_ASSAULTRIFLE", damage = 0.65},
    {name = "WEAPON_ASSAULTRIFLE_MK2", damage = 0.65},	
	{name = "WEAPON_CARBINERIFLE", damage = 0.65},
	{name = "WEAPON_ADVANCEDRIFLE", damage = 0.425},
	{name = "WEAPON_COMPACTRIFLE", damage = 0.40},
	{name = "WEAPON_MICROSMG", damage = 0.70},
	{name = "WEAPON_PUMPSHOTGUN", damage = 0.30},
	{name = "WEAPON_PUMPSHOTGUN_MK2", damage = 0.30},	
	{name = "WEAPON_SAWNOFFSHOTGUN", damage = 0.40},
}

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 
    return false 
end 


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for k,v in ipairs(WeaponDamage) do
            local weaponName = v.name
            local weaponHash = GetHashKey(weaponName)
            SetWeaponDamageModifier(weaponHash, v.damage)
			SetPedSuffersCriticalHits(PlayerPedId(), false)
            Wait(0)
        end
    end
end) 

Citizen.CreateThread( function()
	while true do 
		if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		else
		 	Citizen.Wait(1500)
	 	end  
	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(130,140+(math.ceil(MovementSpeed*1.5)))/100
	        local rifle = false


          	if group == 970310034 or group == 1159398588 then
          		rifle = true
          	end


          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end


	        if Vehicled then
	        	recoil = recoil + (recoil * 1.5)
	        else
	        	recoil = recoil * 1.0
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.6
		        if rifle then
		        	recoil = recoil * 0.1
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.1
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 1.5
	        end

	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
    
	        local set = p+recoil
	       	SetGameplayCamRelativePitch(set,0.8)    	       	
	    end
	end
end)