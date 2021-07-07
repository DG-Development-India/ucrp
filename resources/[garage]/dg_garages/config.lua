Config = {}

Config.mrpd = {

    ['heli'] = {x = 448.65,  y = -981.25, z = 43.69, h = 90.0 },
    ['car'] = { x = 452.26, y = -981.42, z = 25.7, h = 88.17 },
    ['personal'] = { x = 426.43, y = -978.86, z = 25.7, h = 267.86 },
	['extra'] = { x = 441.38, y = -981.28, z = 25.7, h = 87.56 }
}

Config.vaspucci = {

    ['heli'] = {x = -1096.69,  y = -832.75, z = 37.7, h = 315.41 },
    ['car'] = { x = -1113.1, y= -835.9, z = 13.34, h = 120.5  }, 
    ['personal'] = { x = -1116.36, y= -829.74, z = 13.34, h = 150.5 }, 
    ['extra'] = { x = -1121.46, y= -840.51, z = 13.37, 90.0 }, 
}

Config.weazel= {

    ['heli'] = {x = -583.51, y = -930.0, z = 36.80, h = 93.23},
    ['car'] = {x = -554.92,  y = -897.07, z = 24.45, h = 183.65 },
    ['personal'] = {x = -540.86, y = -908.22, z = 24.00, h = 57.87 },
    ['extra'] = {x = -543.24,  y = -895.75, z = 24.45, h = 90.0},
}

Config.ambulance= {

    ['heli'] = {x = 351.61, y = -588.08, z = 74.15, h = 250.06},
    ['car'] = {x = 331.23,  y = -580.94, z = 28.73, h = 337.03},
    ['personal'] = {x = 317.89, y= -573.94, z = 29.00, h = 250.23},
    ['extra'] = {x = 334.9,  y = -571.07, z = 28.8, h = 340.14},
}


Config.PoliceVehicles = {
	{ model = '14charger', label = '2014 Charger'},
	{ model = '18charger', label = '2018 charger'},
	{ model = 'f150', label = 'Raptor Ford'},
	{ model = 'fpis', label = 'Ford Setina'},
	{ model = 'fpiu', label = 'Ford Explorer'},
	{ model = 'tahoe', label = 'Tahoe'},
	{ model = 'policeb1', label = 'Hayabusa'},
	{ model = 'fbi3', label = 'Mcgarrets Mercedes Sprinter Van'},
	{ model = 'rmodfordpolice', label = ' Mustang'},
	{ model = 'policeatvrb', label = ' ATV'},
	{ model = 'bmwbike', label = 'BMW Bike'},
	{ model = 's11mg', label = 'Scorpio'},
	{ model = 'riot', label = 'Riot Van' },
}

Config.PoliceHeli = {
	{ model = 'polmav', label = 'Police Maverick'}
}

Config.EMSVehicles = {
	{ model = 'emsa', label = 'Ambulance Van'},
	{ model = 'emsc', label = 'EMS Charger'},
	{ model = 'emsf', label = 'EMS Raptor'},
	{ model = 'emst', label = 'EMS Tahoe'},

}

Config.EMSHeli = {
	{ model = 'polmav', label = 'Air Ambulance'}
}

Config.NewsVehicles = {
	{ model = 'newsvan', label = 'News Van'},
}

Config.NewsHeli = {
	{ model = 'newsfrog', label = 'Weazel Air'}
}

Config.PoliceBoat = {
	{ model = 'predator', label = 'Police Predator'}
}

Config.Boat = {
	{ spawn = {x = -1874.42, y = -1242.09, z = 0.0, h = 50.0}, menu = {x = -1864.3, y = -1237.4, z = 8.62}},
	{ spawn = {x = -3422.92, y = 990.64, z = 0.0, h = 80.0}, menu = {x = -3424.63, y = 982.9, z = 8.35}},
	{ spawn = {x = -1603.04, y = 5260.88, z = 0.0, h = 20.0}, menu = {x = -1608.02, y = 5263.91, z = 3.97}},
	{ spawn = {x = 705.63, y = 4084.25, z = 31.40, h = 180.0}, menu = {x = 714.7, y = 4093.48, z = 34.73}},
	{ spawn = {x = -287.94, y = 6615.2, z = 0.0, h = 50.0}, menu = {x = -286.75, y = 6628.82, z = 7.25}},
	{ spawn = {x = 3859.13, y = 4453.13, z = 0.0, h = 270.0}, menu = {x = 3858.91, y = 4458.75, z = 1.83}},
	{ spawn = {x = 33.45, y = -2792.94, z = 0.0, h = 180.0}, menu = {x = 45.76, y = -2793.56, z = 5.72}},
	{ spawn = {x = -796.23, y = -1503.34, z = 0.00, h = 110.0}, menu = {x = -800.11, y = -1512.9, z = 1.6}},
	{ spawn = {x = -796.23, y = -1503.34, z = 0.00, h = 110.0}, menu = {x = -806.2, y = -1496.7, z = 1.6}}
}

-- Colors

Config.Colors = {
	{ label = 'Black', value = 'black'},
	{ label = 'White', value = 'white'},
	{ label = 'Grey', value = 'grey'},
	{ label = 'Red', value = 'red'},
	{ label = 'Pink', value = 'pink'},
	{ label = 'Blue', value = 'blue'},
	{ label = 'Yellow', value = 'yellow'},
	{ label = 'Green', value = 'green'},
	{ label = 'Orange', value = 'orange'},
	{ label = 'Brown', value = 'brown'},
	{ label = 'Purple', value = 'purple'},
	{ label = 'Chrome', value = 'chrome'},
	{ label = 'Gold', value = 'gold'}
}

function GetColors(color)
	local colors = {}
	if color == 'black' then
		colors = {
			{ index = 0, label = 'Black'},
			{ index = 1, label = 'Graphite'},
			{ index = 2, label = 'Black Metallic'},
			{ index = 3, label = 'Caststeel'},
			{ index = 11, label = 'Black Anth'},
			{ index = 12, label = 'Matte Black'},
			{ index = 15, label = 'Dark Night'},
			{ index = 16, label = 'Deep Black'},
			{ index = 21, label = 'Oil'},
			{ index = 147, label ='Carbon'}
		}
	elseif color == 'white' then
		colors = {
			{ index = 106, label = 'Vanilla'},
			{ index = 107, label = 'Creme'},
			{ index = 111, label = 'White'},
			{ index = 112, label = 'Polar White'},
			{ index = 113, label = 'Beige'},
			{ index = 121, label = 'Matte White'},
			{ index = 122, label = 'Snow'},
			{ index = 131, label = 'Cotton'},
			{ index = 132, label = 'Alabaster'},
			{ index = 134, label = 'Pure White'}
		}
	elseif color == 'grey' then
		colors = {
			{ index = 4, label = 'Silver'},
			{ index = 5, label = 'Metallic Grey'},
			{ index = 6, label = 'Laminatedsteel'},
			{ index = 7, label = 'Dark Gray'},
			{ index = 8, label = 'Rockygray'},
			{ index = 9, label = 'Gray Night'},
			{ index = 10, label = 'Aluminum'},
			{ index = 13, label = 'Graymat'},
			{ index = 14, label = 'Light Grey'},
			{ index = 17, label = 'Asphalt Gray'},
			{ index = 18, label = 'Gray Concrete'},
			{ index = 19, label = 'Dark Silver'},
			{ index = 20, label = 'Magnesite'},
			{ index = 22, label = 'Nickel'},
			{ index = 23, label = 'Zinc'},
			{ index = 24, label = 'Dolomite'},
			{ index = 25, label = 'Blue silver'},
			{ index = 26, label = 'Titanium'},
			{ index = 66, label = 'Steel Blue'},
			{ index = 93, label = 'Champagne'},
			{ index = 144, label = 'Grayhunter'},
			{ index = 156, label = 'Grey'}
		}
	elseif color == 'red' then
		colors = {
			{ index = 27, label = 'Red'},
			{ index = 28, label = 'Torino Red'},
			{ index = 29, label = 'Poppy'},
			{ index = 30, label = 'Copper Red'},
			{ index = 31, label = 'Cardinal'},
			{ index = 32, label = 'Brick'},
			{ index = 33, label = 'Garnet'},
			{ index = 34, label = 'Cabernet'},
			{ index = 35, label = 'Candy'},
			{ index = 39, label = 'Matte Red'},
			{ index = 40, label = 'Dark Red'},
			{ index = 43, label = 'Red Pulp'},
			{ index = 44, label = 'Bril Red'},
			{ index = 46, label = 'Pale Red'},
			{ index = 143, label = 'Wine Red'},
			{ index = 150, label = 'Volcano'}
		}
	elseif color == 'pink' then
		colors = {
			{ index = 135, label = 'Electric Pink'},
			{ index = 136, label = 'Salmon'},
			{ index = 137, label = 'Sugarplum'}
		}
	elseif color == 'blue' then
		colors = {
			{ index = 54, label = 'Topaz'},
			{ index = 60, label = 'Light Blue'},
			{ index = 61, label = 'Galaxy Blue'},
			{ index = 62, label = 'Dark Blue'},
			{ index = 63, label = 'Azure'},
			{ index = 64, label = 'Navy Blue'},
			{ index = 65, label = 'Lapis'},
			{ index = 67, label = 'Blue Diamond'},
			{ index = 68, label = 'Surfer'},
			{ index = 69, label = 'Pastel Blue'},
			{ index = 70, label = 'Celeste Blue'},
			{ index = 73, label = 'Rally Blue'},
			{ index = 74, label = 'Blue Paradise'},
			{ index = 75, label = 'Blue Night'},
			{ index = 77, label = 'Cyan Blue'},
			{ index = 78, label = 'Cobalt'},
			{ index = 79, label = 'Electric Blue'},
			{ index = 80, label = 'Horizon Blue'},
			{ index = 82, label = 'Metallic Blue'},
			{ index = 83, label = 'Aquamarine'},
			{ index = 84, label = 'Blue Agathe'},
			{ index = 85, label = 'Zirconium'},
			{ index = 86, label = 'Spinel'},
			{ index = 87, label = 'Tourmaline'},
			{ index = 127, label = 'Paradise'},
			{ index = 140, label = 'Bubble Gum'},
			{ index = 141, label = 'Midnight Blue'},
			{ index = 146, label = 'Forbidden Blue'},
			{ index = 157, label = 'Glacier Blue'}
		}
	elseif color == 'yellow' then
		colors = {
			{ index = 42, label = 'Yellow'},
			{ index = 88, label = 'Wheat'},
			{ index = 89, label = 'Race Yellow'},
			{ index = 91, label = 'Pale Yellow'},
			{ index = 126, label = 'Light Yellow'}
		}
	elseif color == 'green' then
		colors = {
			{ index = 49, label = 'Met Dark Green'},
			{ index = 50, label = 'Rally Green'},
			{ index = 51, label = 'Pine Green'},
			{ index = 52, label = 'Olive Green'},
			{ index = 53, label = 'Light Green'},
			{ index = 55, label = 'Lime Green'},
			{ index = 56, label = 'Forest Green'},
			{ index = 57, label = 'Lawn Green'},
			{ index = 58, label = 'Imperial Green'},
			{ index = 59, label = 'Green Bottle'},
			{ index = 92, label = 'Citrus Green'},
			{ index = 125, label = 'Green Anis'},
			{ index = 128, label = 'Khaki'},
			{ index = 133, label = 'Army Green'},
			{ index = 151, label = 'Dark Green'},
			{ index = 152, label = 'Hunter Green'},
			{ index = 155, label = 'Matte foilage green'}
		}
	elseif color == 'orange' then
		colors = {
			{ index = 36, label = 'Tangerine'},
			{ index = 38, label = 'Orange'},
			{ index = 41, label = 'Matte Orange'},
			{ index = 123, label = 'Lightorange'},
			{ index = 124, label = 'Peach'},
			{ index = 130, label = 'Pumpkin'},
			{ index = 138, label = 'Orange Lambo'}
		}
	elseif color == 'brown' then
		colors = {
			{ index = 45, label = 'Copper'},
			{ index = 47, label = 'Light Brown'},
			{ index = 48, label = 'Dark Brown'},
			{ index = 90, label = 'Bronze'},
			{ index = 94, label = 'Brown Metallic'},
			{ index = 95, label = 'Expresso'},
			{ index = 96, label = 'Chocolate'},
			{ index = 97, label = 'Terracotta'},
			{ index = 98, label = 'Marble'},
			{ index = 99, label = 'Sand'},
			{ index = 100, label = 'Sepia'},
			{ index = 101, label = 'Bison'},
			{ index = 102, label = 'Palm'},
			{ index = 103, label = 'Caramel'},
			{ index = 104, label = 'Rust'},
			{ index = 105, label = 'Chestnut'},
			{ index = 108, label = 'Brown'},
			{ index = 109, label = 'Hazelnut'},
			{ index = 110, label = 'Shell'},
			{ index = 114, label = 'Mahogany'},
			{ index = 115, label = 'Cauldron'},
			{ index = 116, label = 'Blond'},
			{ index = 129, label = 'Gravel'},
			{ index = 153, label = 'Darkearth'},
			{ index = 154, label = 'Desert'}
		}
	elseif color == 'purple' then
		colors = {
			{ index = 71, label = 'Indigo'},
			{ index = 72, label = 'Deeppurple'},
			{ index = 76, label = 'Darkviolet'},
			{ index = 81, label = 'Amethyst'},
			{ index = 142, label = 'Mystical violet'},
			{ index = 145, label = 'Purple metallic'},
			{ index = 148, label = 'Matte violet'},
			{ index = 149, label = 'Matte Purple'}
		}
	elseif color == 'chrome' then
		colors = {
			{ index = 117, label = 'Brushed chrome'},
			{ index = 118, label = 'Blackchrome'},
			{ index = 119, label = 'Brushed aluminum'},
			{ index = 120, label = 'Chrome'}
		}
	elseif color == 'gold' then
		colors = {
			{ index = 37, label = 'Gold'},
			{ index = 158, label = 'Pure gold'},
			{ index = 159, label = 'Brushed gold'},
			{ index = 160, label = 'Light gold'}
		}
	end
	return colors
end