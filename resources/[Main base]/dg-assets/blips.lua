local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},
	 {name="Barber Shop", color=0, id=71, x=136.8, y=-1708.4, z=28.3},
	 {name="Barber Shop", color=0, id=71, x=-1282.6, y=-1116.8, z=6.0},
	 {name="Barber Shop", color=0, id=71, x=1931.5, y=3729.7, z=31.8},
	 {name="Barber Shop", color=0, id=71, x=1212.8, y=-472.9, z=65.2},
	 {name="Barber Shop", color=0, id=71, x=-32.9, y=-152.3, z=56.1},
	 {name="Barber Shop", color=51, id=71, x=-278.1, y=6228.5, z=30.7},
	 {name="Clothing Store", color=4, id=73, x=72.254, y=-1399.102, z=28.376},
	 {name="Clothing Store", color=4, id=73, x=-703.776,  y=-152.258,  z=36.415},
	 {name="Clothing Store", color=4, id=73, x=-167.863,  y=-298.969,  z=38.733},
	 {name="Clothing Store", color=4, id=73, x=428.694,   y=-800.106,  z=28.491},
	 {name="Clothing Store", color=4, id=73, x=-829.413,  y=-1073.710, z=10.328},
	 {name="Clothing Store", color=4, id=73, x=-1447.797, y=-242.461,  z=48.820},
	 {name="Clothing Store", color=4, id=73, x=11.632,    y=6514.224,  z=30.877},
	 {name="Clothing Store", color=4, id=73, x=123.646,   y=-219.440,  z=53.557},
	 {name="Clothing Store", color=4, id=73, x=1696.291,  y=4829.312,  z=41.063},
	 {name="Clothing Store", color=4, id=73, x=618.093,   y=2759.629,  z=41.088},
	 {name="Clothing Store", color=4, id=73, x=1190.550,  y=2713.441,  z=37.222},
	 {name="Clothing Store", color=4, id=73, x=-1193.429, y=-772.262,  z=16.324},
	 {name="Clothing Store", color=4, id=73, x=-3172.496, y=1048.133,  z=19.863},
	 {name="Clothing Store", color=4, id=73, x=-1108.441, y=2708.923,  z=18.107},
	 {name="Clothing Store", color=4, id=73, x=1858.9041748047, y=3687.8701171875,  z=34.267036437988},
	 {name="Clothing Store", color=4, id=73, x=2435.4169921875, y=4965.6123046875,  z=46.810600280762},
	 {name="Tattoo Shop", color=1, id=75, x=1322.645, y=-1651.976, z=52.275},
	 {name="Tattoo Shop", color=1, id=75, x=-1153.676, y=-1425.68, z=4.954},
	 {name="Tattoo Shop", color=1, id=75, x=322.139, y=180.467, z=103.587},
	 {name="Tattoo Shop", color=1, id=75, x=1864.633, y=3747.738, z=33.032},
	 {name="Tattoo Shop", color=1, id=75, x=-293.713, y=6200.04, z=31.487},
	 {name="Tattoo Shop", color=1, id=75, x=-293.713, y=6200.04, z=31.487},
	 --twentyfourseven shop---
	 {name="Shop", color=2, id=52, x=1961.1140136719, y=3741.4494628906, z=32.34375}, --Grove street
	 {name="Shop", color=2, id=52, x=1392.4129638672, y=3604.47265625, z=34.980926513672},
	 {name="Shop", color=2, id=52, x=546.98962402344, y=2670.3176269531, z=42.156539916992},
	 {name="Shop", color=2, id=52, x=2556.2534179688, y=382.876953125, z=108.62294769287},
	 {name="Shop", color=2, id=52, x=-1821.9542236328, y=792.40191650391, z=138.13920593262},
	 {name="Shop", color=2, id=52, x=-1223.6690673828, y=-906.67517089844, z=12.326356887817},
	 {name="Shop", color=2, id=52, x=-708.19256591797, y=-914.65264892578, z=19.215591430664},
	 {name="Shop", color=2, id=52, x=26.419162750244, y=-1347.5804443359, z=29.497024536133},
	 {name="Shop", color=2, id=52, x=-45.4649, y=-1754.41, z=29.421},
	 {name="Shop", color=2, id=52, x=1162.87, y=-319.218, z=69.2051},
	 {name="Shop", color=2, id=52, x=373.872, y=331.028, z=103.566},
	 {name="Shop", color=2, id=52, x=2552.47, y=381.031, z=108.623},
	 {name="Shop", color=2, id=52, x=-1823.67, y=796.291, z=138.126},
	 {name="Shop", color=2, id=52, x=2673.91, y=3281.77, z=55.2411},
	 {name="Shop", color=2, id=52, x=1957.64, y=3744.29, z=32.3438},
	 {name="Shop", color=2, id=52, x=1701.97, y=4921.81, z=42.0637},
	 {name="Shop", color=2, id=52, x=1730.06, y=6419.63, z=35.0372},
	 {name="Shop", color=2, id=52, x=1842.973, y=2570.243, z=46.02},
	 -------------------------
	 {name="Court House",color=46, id=58, x= 231.8554, y= -422.3298,  z = 48.07677},
	 {name="Vangelico Jewery Store", color=4, id=617, x=-622.097, y=-230.720, z=38.057},
	 --{name="Downtown Cab Co.", color=5, id=56, x=903.9481, y=-173.5247, z=74.0756},
	 --{name="Bean Machine",color=10, id=106, x = -632.64, y = 235.25, z = 81.89},
	 {name="Police Department",color=38, id=60, x = 454.6035, y = -983.9653, z = 30.68951},
	 --{name="Pillbox Hospital",color=38, id=153, x = 323.2469, y = -592.575, z = 43.28399}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.color)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.name)
      EndTextCommandSetBlipName(info.blip)
    end
end)