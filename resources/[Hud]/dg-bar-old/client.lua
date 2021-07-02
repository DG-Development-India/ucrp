DGCore = nil
Citizen.CreateThread(function()
    while DGCore == nil do
        TriggerEvent('dg:getSharedObject', function(obj)
            DGCore = obj
        end)
        Citizen.Wait(0)
    end

    while DGCore.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    DGCore.PlayerData = DGCore.GetPlayerData()
end)

local toghud = true

RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
    else
        toghud = true
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

Citizen.CreateThread(function()
    while true do

        if toghud == true then
            if (not IsPedInAnyVehicle(PlayerPedId(), false) )then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end 
        
        TriggerEvent('dg_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('dg_status:getStatus', 'thirst', function(thirst)
                TriggerEvent('dg_status:getStatus','stress',function(stress)

                    local myhunger = hunger.getPercent()
                    local mythirst = thirst.getPercent()
                    local mystress = stress.getPercent()

                    SendNUIMessage({
                        action = "updateStatusHud",
                        show = toghud,
                        hunger = myhunger,
                        thirst = mythirst,
                        stress = mystress,
                    })
                end)
            end)
        end)
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId())
        if oxy <= 100.0 then
            SendNUIMessage({            
                action = 'updateStatusHud',         
                show = toghud,          
                health = health,        
                armour = armor,      
                oxygen = oxy,        
            })
        else
            SendNUIMessage({            
                action = 'updateStatusHud',         
                show = toghud,          
                health = health,        
                armour = armor,      
                oxygen = 100.0,        
            })
        end
        Citizen.Wait(200)
    end
end)