-- local healing = false
-- local healing2 = false

-- function loadAnimDict(dict)
-- 	while (not HasAnimDictLoaded(dict)) do
-- 		RequestAnimDict(dict)
-- 		Citizen.Wait(5)
-- 	end
-- end

-- RegisterNetEvent("dg-hospital:items:bandage")
-- AddEventHandler("dg-hospital:items:bandage", function(item)
--     HealSlow2()
-- end)

-- RegisterNetEvent("healed:useOxy")
-- AddEventHandler("healed:useOxy", function()
--     ClearPedBloodDamage(PlayerPedId())
--     HealSlow()
-- end)

-- RegisterNetEvent("healed:useOxy2")
-- AddEventHandler("healed:useOxy2", function()
--     ClearPedBloodDamage(PlayerPedId())
--     HealSlow()
-- end)

-- RegisterNetEvent("dg-hospital:items:ifak")
-- AddEventHandler("dg-hospital:items:ifak", function(item)
--     loadAnimDict("missheistdockssetup1clipboard@idle_a")
--     TaskPlayAnim( PlayerPedId(), "missheistdockssetup1clipboard@idle_a", "idle_a", 3.0, 1.0, -1, 49, 0, 0, 0, 0 ) 
--     exports["dg-taskbar"]:taskBar(3500, "Using IFAK")
--         local maxHealth = GetEntityMaxHealth(PlayerPedId())
-- 		local health = GetEntityHealth(PlayerPedId())
-- 		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 30))
--         SetEntityHealth(PlayerPedId(), newHealth)
--         TriggerEvent('dg-hospital:client:RemoveBleed')
--         ClearPedTasks(PlayerPedId())
-- end)

-- function HealSlow()
--     if not healing then
--         healing = true
--     else
--         return
--     end
    
--     local count = 30
--     while count > 0 do
--         Citizen.Wait(1000)
--         count = count - 1
--         SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
--         TriggerEvent('dg-hospital:client:RemoveBleed') 
--     end
--     healing = false
-- end

-- function HealSlow2()
--     if not healing2 then
--         healing2 = true
--     else
--         return
--     end
    
--     local count = 30
--     while count > 0 do
--         Citizen.Wait(1000)
--         count = count - 1
--         SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
--     end
--     if math.random(0, 2) then
--         TriggerEvent('dg-hospital:client:RemoveBleed')
--     end
--     healing2 = false
-- end

RegisterNetEvent("dg-hospital:items:gauze")
AddEventHandler("dg-hospital:items:gauze", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1500,
        label = "Packing Wounds...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        } 
    }, function(cancelled)
        if not cancelled then
            TriggerEvent('dg-hospital:client:FieldTreatBleed')
        else
            TriggerEvent('player:receiveItem', 'gauze', 1)
        end
    end)
end)

RegisterNetEvent("dg-hospital:items:bandage")
AddEventHandler("dg-hospital:items:bandage", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 3000,
        label = "Using Bandage...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_paper_bag_small",
        }
    }, function(cancelled)
        if not cancelled then
		    local maxHealth = GetEntityMaxHealth(PlayerPedId())
		    local health = GetEntityHealth(PlayerPedId())
		    local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
		    SetEntityHealth(PlayerPedId(), newHealth)
        else
            TriggerEvent('player:receiveItem', 'bandage', 1)
        end
    end)
end)

RegisterNetEvent("dg-hospital:items:firstaid")
AddEventHandler("dg-hospital:items:firstaid", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 10000,
        label = "Using First Aid...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        }, 
    }, function(cancelled)
        if not cancelled then
		    local maxHealth = GetEntityMaxHealth(PlayerPedId())
		    SetEntityHealth(PlayerPedId(), maxHealth)
        else
            TriggerEvent('player:receiveItem', 'firstaidkit', 1)
        end
    end)
end)

RegisterNetEvent("dg-hospital:items:ifak")
AddEventHandler("dg-hospital:items:ifak", function(item)
    exports['mythic_progbar']:Progress({
        name = "ifak_action",
        duration = 5000,
        label = "Using IFAK...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
            anim = "idle_a",
            flags = 49,
        },
        prop = {
            model = "prop_ld_health_pack"
        }, 
    }, function(cancelled)
        if not cancelled then
            TriggerEvent('dg-hospital:client:ResetLimbs')
            TriggerEvent('dg-hospital:client:RemoveBleed')
            for i = 1, 5 , 1 do 
                local health = GetEntityHealth(PlayerPedId())
                if health < 200 then
                    SetEntityHealth(PlayerPedId(), health+10)
                    Citizen.Wait(5000)
                else
                    return
                end
            end
        else
            TriggerEvent('player:receiveItem', 'ifak', 1)
        end
    end)
end)

RegisterNetEvent("dg-hospital:items:vicodin")
AddEventHandler("dg-hospital:items:vicodin", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1000,
        label = "Taking " .. item.label,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
       prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        }, 
    }, function(cancelled)
        if not cancelled then
            
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
			SetEntityHealth(PlayerPedId(), newHealth)
			TriggerEvent('dg-hospital:client:UsePainKiller', 2)
			
        else
            TriggerEvent('player:receiveItem', 'vicodin', 1)
        end
            
    end)
end)

RegisterNetEvent("dg-hospital:items:hydrocodone")
AddEventHandler("dg-hospital:items:hydrocodone", function(item)
    exports['mythic_progbar']:Progress({
        name = "firstaid_action",
        duration = 1000,
        label = "Taking " .. item.label,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        }, 
    }, function(cancelled)
        if not cancelled then
            
			local maxHealth = GetEntityMaxHealth(PlayerPedId())
			local health = GetEntityHealth(PlayerPedId())
			local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 4))
			SetEntityHealth(PlayerPedId(), newHealth)
			TriggerEvent('dg-hospital:client:UsePainKiller', 3)
			
        else
            TriggerEvent('player:receiveItem', 'hydrocodone', 1)
        end
    end)
end)

RegisterNetEvent("dg-hospital:items:adrenaline")
AddEventHandler("dg-hospital:items:adrenaline", function(item)
    exports['mythic_progbar']:Progress({
        name = "adrenaline_action",
        duration = 2000,
        label = "Taking Adrenaline...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mp_suicide",
            anim = "pill",
            flags = 49,
        },
        prop = {
            model = "prop_cs_pills",
            bone = 58866,
            coords = { x = 0.1, y = 0.0, z = 0.001 },
            rotation = { x = -60.0, y = 0.0, z = 0.0 },
        }, 
    }, function(cancelled)
        if not cancelled then
            TriggerEvent('dg-hospital:client:UseAdrenaline', 4)
        else
            TriggerEvent('player:receiveItem', 'adrenaline', 1)
        end
    end)
end)
