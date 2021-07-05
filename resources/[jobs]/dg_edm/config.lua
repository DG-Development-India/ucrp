Config = {}

Config.allow_test_drive = true -- allow test driving
Config.test_drive_time = 120 -- test drive time in seconds
Config.currency = "$" -- currency to show in menu above car
-- Config.buy_point = { pos = vector3(-59.51, 78.96, 71.20), heading = 72.5 } -- location where to tp player with car after buying it
-- Config.test_point = { pos = vector3(-59.51, 78.96, 71.20), heading = 72.5 } -- location where to tp player with car after buying it
Config.buy_point = { pos = vector3(149.82, -126.0, 54.66), heading = 71.0 } -- location where to tp player with car after buying it
Config.test_point = { pos = vector3(149.82, -126.0, 54.66), heading = 71.0 } -- location where to tp player with car after buying it
Config.render_center = vector3(-49.86,-1075.95,26.26)
Config.render_distance = 50 -- distance from render_center from which the cars will be visible

Config.slots = {
    {
		pos = vector3(-1265.25, -354.8939, 35.90746),
		heading = 205.85549926758,
		cat = 'cars'
    },
    {
		pos = vector3(-1270.072, -358.731, 35.90747),
		heading = 250.10653686523,
		cat = 'bikes'
    },
	{
		pos = vector3(-1250.095, -362.8106, 35.90747),
        heading = 26.545846939087,
		cat = 'bikes'
    },
	{
        pos = vector3(-1251.32, -354.2889, 35.90747),
        heading = 88.252632141113,
		cat = 'bikes'
    },
	{
		pos = vector3(-1254.839, -365.3632, 35.90747),
        heading = 19.944295883179,
		cat = 'bikes'
    },
	{
        pos = vector3(-1268.971, -364.9844, 35.90745),
        heading = 293.20367431641,
		cat = 'big'
    }
}

Config.cars = {

    ['bikes'] = {
        --          ----Rotation 1----
        -- ['r6'] = {price = 65000, name = 'Yamaha R6'},
        -- ['hcbr17'] = {price = 75000, name = 'Honda CBR17'},
        -- ['hexer'] = {price = 60000, name = 'H.D. Knucklehead Bobber'},
        -- ['kcc_queens_warrior'] = {price = 90000, name = 'KCC Queens Warrior'},
        -- ['zx10r'] = {price = 100000, name = 'Kawasaki Ninja'},
        -- ['sovereign'] = {price = 110000, name = 'HD FatBoy Racing'},
        -- ['fatboy'] = {price = 120000, name = 'H.D. FatBoy Vintage'},
                    -----Rotation 2---
        ['HDIron883'] = {price = 250000, name = 'Harley Davidson Iron'},
        -- ['hdiron883'] = {price = 150000, name = 'Harle Davidson Iron883'},
        -- ['slave'] = {price = 80000, name = 'Western MC'},
        -- ['na25'] = {price = 200000, name = 'Harley Davidson Nazgul25'},
        -- ['flhxs_streetglide_special18'] = {price = 300000, name = 'Harley Davidson Goldwing'},
        -- ['y1700max'] = {price = 150000, name = 'Yamaha 1700Max'},
    },

    ['cars'] = {
                      ----Rotation 1---
        -- ['evo9'] = {price = 300000, name = 'Mitsubishi Evo9'},
        -- ['gtrb'] = {price = 300000, name = 'Nissan GTR34 Rocket Bunny'},
        -- ['audirs6tk'] = {price = 220000, name = 'Audi RS6'},
        -- ['esv'] = {price = 250000, name = 'Cadillac Escalade'},
        -- ['gt63'] = {price = 350000, name = 'Mercedes AMG GT63'},
        -- ['69charger'] = {price = 200000, name = 'Dodge Charger 1969'},
        -- ['mig'] = {price = 550000, name = 'Ferrari Enzo'},
        -- ['one77'] = {price = 350000, name = 'Aston Martin one77'},
        -- ['gt2rwb'] = {price = 155000, name = 'Porsche Classic Rally'},
        -- ['filthynsx'] = {price = 325000, name = 'Acura NSX LB'},
        -- ['granlb'] = {price = 350000, name = 'Maserati Sports'},
                      ----Rotation 2---
        ['accord20'] = {price = 300000, name = 'Hyundai Accord'},
        ['santa9'] = {price = 550000, name = 'Hyundai SantaFe'},
        ['avj'] = {price = 450000, name = 'Lamborghini Aventador J'},
        ['STO'] = {price = 150000, name = 'Lamborghini Huracan STO'},
        ['urustc'] = {price = 150000, name = 'Lamborghini URUS'},
        ['650slbs'] = {price = 150000, name = 'McLaren 650SLBS'},
        ['elva'] = {price = 150000, name = 'McLaren Elva'},
        ['cz4a'] = {price = 150000, name = 'Mitsubishi Lancer Evo X'},
        ['skyline'] = {price = 150000, name = 'Nissan R34'},
    },

    ['big'] = {
                   ---Rotation 1----
        -- ['nissantitan17'] = {price = 250000, name = 'Nissan Titan'},  
                   ---Rotation 2----
        ['a8fsi'] = {price = 350000, name = 'Audi A8'},
        ['audsq517'] = {price = 435000, name = 'Audi Q5'},
        ['r820'] = {price = 300000, name = 'Audi R8 V10'},
        ['rs7c8'] = {price = 300000, name = 'Audi RS7'},
        ['rmodbmwi8'] = {price = 150000, name = 'BMW I8'},
        ['m5f90'] = {price = 150000, name = 'BMW M5'},
        ['m6gc'] = {price = 150000, name = 'BMW M6'},
        ['x5mcompetition'] = {price = 150000, name = 'BMW X5'},
        ['monza'] = {price = 150000, name = 'Ferrari Monza'},
        ['forgt50020'] = {price = 150000, name = 'Ford Mustang GT500'}, 
    }

}

