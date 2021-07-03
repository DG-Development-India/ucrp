Strings = {
    ['enter_garage'] = '%s Enter the garage',
    ['store_garage'] = '%s Store your vehicle',
    ['not_your'] = 'Garage - you do not own this vehicle!',
    ['no_vehicle'] = 'Garage - no vehicle found',
    ['impound'] = 'Impounded',
    ['yes'] = 'Yes',
    ['no'] = 'No',
    ['retrieve_impounded'] = 'Retrieve %s for <a style="color:red">$%s</a>',
    ['open_impound'] = '%s Enter the impound',
    ['no_money'] = "You don't have enough money!",
    ['impound_blip'] = 'Impound',
    ['garage'] = 'Garage',
    ['fetching'] = 'Fetching vehicles...',
    ['vehicle_info'] = '~b~~h~%s ~h~~s~garage\n~h~Plate:~h~ %s\n%s %s %s %s',
    ['already_out'] = 'Vehicle is out within 300 meter.',
}

Config = {
    ['IndependentGarage'] = false, -- if you store vehicle at garage A, you can't take it out at garage B if this is set to true.
    ['Damages'] = true, -- load damages?
    ['ImpoundPrice'] = 500, -- cost to retrieve an impounded vehicle

    ['Interior'] = {
        ['Enabled'] = false, -- view the vehicle in the interior, or at the garage location?
        ['Coords'] = vector3(228.8, -986.97, -99.96),
        ['Heading'] = 180.0
    },

    ['Garages'] = {
        ['C'] = {
            ['coords'] = vector3(-298.07, -768.74, 33.97), 
            ['heading'] = 70.02
        },
        ['E'] = {
            ['coords'] = vector3(154.64, 6585.62, 32.82), 
            ['heading'] = 215.09
        },
        ['A'] = {
            ['coords'] = vector3(278.67,-336.91, 45.79), 
            ['heading'] = 69.31
        },
        ['D'] = {
            ['coords'] = vector3(1514.36, 3761.47, 34.89), 
            ['heading'] = 197.83
        },
        ['E'] = {
            ['coords'] = vector3(-78.9,-2017.28, 18.89), 
            ['heading'] = 79.87
        },
        ['F'] = {
            ['coords'] = vector3(-1439.34, -671.86, 27.30), 
            ['heading'] = 79.87
        },
        ['B'] = {
            ['coords'] = vector3(-761.83, 5539.91, 34.00), 
            ['heading'] = 94.3
        },
        ['G'] = {
            ['coords'] = vector3(247.69, -751.34, 35.1),
            ['heading'] = 71.37
        },
        ['H'] = {
            ['coords'] = vector3(64.36,22.58,69.99), 
            ['heading'] =  250.53
        },
        ['I'] = {
            ['coords'] = vector3(1039.88,-774.02,58.47), 
            ['heading'] = 0.5
        },
        ['J'] = {
            ['coords'] = vector3(-1190.25,-1496.11,4.84), 
            ['heading'] = 218.77
        },
        ['K'] = {
            ['coords'] = vector3(-1574.18, -1036.58, 13.35), 
            ['heading'] = 55.65
        },
        ['L'] = {
            ['coords'] = vector3(-3249.72,991.07, 12.82), 
            ['heading'] = 271.16
        },
        ['M'] = {
            ['coords'] = vector3(-1577.1, 5161.56, 20.20), 
            ['heading'] = 285.28
        },
        ['N'] = {
            ['coords'] = vector3(733.64, 4175.04, 41.02), 
            ['heading'] = 345.75
        },
        ['O'] = {
            ['coords'] = vector3(-212.63, 6561.19, 11.21), 
            ['heading'] = 224.58
        },
        ['P'] = {
            ['coords'] = vector3(3792.6,4445.74,4.93), 
            ['heading'] =  103.9
        },
        ['Q'] = {
            ['coords'] = vector3(55.94,-2743.32,5.33), 
            ['heading'] = 264.81
        },
        ['R'] = {
            ['coords'] = vector3(-761.96,-1488.48,5.0), 
            ['heading'] = 291.79
        },
        ['T'] = {
            ['coords'] = vector3(-968.95, -2703.84, 13.86), 
            ['heading'] = 64.93
        },
        ['U'] = {
            ['coords'] = vector3(641.14, 194.32, 96.63), 
            ['heading'] = 338.47
        },
        ['V'] = {
            ['coords'] = vector3(825.57, -2120.77, 29.50), 
            ['heading'] = 97.86
        },
        ['W'] = {
            ['coords'] = vector3(-917.34, -155.43, 41.90), 
            ['heading'] = 115.83
        },
        ['X'] = {
            ['coords'] = vector3(1247.66, 2714.25, 38.01), 
            ['heading'] = 180.28
        },

        ['Y'] = {
            ['coords'] = vector3(-333.9, 276.67, 86.03), 
            ['heading'] = 85.69
        },		
        ['Z'] = {
            ['coords'] = vector3(-420.84, -1679.53, 19.50), 
            ['heading'] = 338.05
		},		
        ['S'] = {
            ['coords'] = vector3(1859.26, 2709.64, 46.70), 
            ['heading'] = 198.38
		},
        ['AA'] = {
            ['coords'] = vector3(896.7, -1020.74, 35.35), 
            ['heading'] = 0.58
		}

    },

    ['Impounds'] = {
        {
            ['Menu'] = vector3(409.79, -1623.27, 29.89),
            ['SpawnVehicle'] = vector4(405.15, -1642.89, 28.31, 0.0) ,
            ['type'] = 'car'
        },

        {
            ['Menu'] = vector3(1737.65, 3709.57, 34.14),
            ['SpawnVehicle'] = vector4(1737.9, 3719.55, 33.27, 18.27), 
            ['type'] = 'car'
        },

        {
            ['Menu'] = vector3(-718.28, -1326.76, 1.6),
            ['SpawnVehicle'] = vector4(-726.12, -1326.8, 0.4, 230.48), 
            ['type'] = 'bot'
        },

    },
}

Config['3DText'] = {
    ['Enabled'] = false,
    ['Draw'] = function(coords, text)
        local StringRemove = {
            '~r~',
            '~w~',
            '~y~',
            '~b~',
            '~g~'
        }

        SetDrawOrigin(coords)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(0.0, 0.0)
        for k, v in pairs(StringRemove) do
            text = text:gsub(v, '')
        end
        DrawRect(0.0, 0.0 + 0.0125, 0.015 + string.len(text) / 370, 0.03, 45, 45, 45, 150)
        ClearDrawOrigin()
    end
}