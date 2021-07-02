Config = {

AlwaysDisplayRadar = false, -- Radar will be turned off when not in a vehicle

--Forth Pill function
DisplayId = false, -- Forth pill displays users id
DisplayStress = true, -- Forth pill displays users stress (You need to get the stress value yourself in the script)
DisplayVoice = false, -- Forth pill will display voice range and when speaking (TokoVOIP or Mumble)


StatusUpdateInterval = 100, -- Time it takes for status to update (lowering this value adds ms)
VitalsUpdateInterval = 100, -- Time it takes for vitals to update (lowering this value adds ms)

MapZoom = 0.25, -- The zoom of the map (Lower the value more zoomed out it will be)

-- Choose icons from FontAwsome (https://fontawesome.com/) 
HealthIcon = "fa-heartbeat",
ArmorIcon = "fa-shield-alt",
FoodIcon = "fa-hamburger",
ThirstIcon = "fa-tint",
FourthIcon = "fa-brain", -- Left blank because default function is displaying id (if you use stress or voice add any icon you like)


}


-- Return your hunger, thirst, stress. This uses dg_status and stress is left at 0 because it isn't used by default
function GetStatus(cb)

	TriggerEvent(
        "dg_status:getStatus",
        "hunger",
        function(h)
            TriggerEvent(
                "dg_status:getStatus",
                "thirst",
                function(t)
                    TriggerEvent(
                        "dg_status:getStatus",
                        "stress",
                        function(s)
                            local hunger = h.getPercent()
                            local thirst = t.getPercent()
                            local stress = s.getPercent()

                            cb({hunger, thirst, stress})
                        end)
                end)
        end)
end

