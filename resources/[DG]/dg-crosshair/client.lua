local crosshair = false
local aiming = true

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if crosshair then
            if aiming then
                SendNUIMessage({ display = "crosshairShow"})
            else
                SendNUIMessage({ display = "crosshairHide" })
            end
        else
            SendNUIMessage({ display = "crosshairHide" })
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
          --  if (IsPlayerFreeAiming(PlayerId()))  then
                aiming = true
                crosshair = true
                wait = 100
          --  else
            --    aiming = false
             --   Wait(100)
          --  end
        else
            aiming = false
            SendNUIMessage({ display = "crosshairHide" })
            Wait(100)
        end
    end
end)


RegisterCommand("ch", function(src, args, raw)
    SendNUIMessage({ display = "crosshairHide"})
end)