Config = {}
Config.Locale = 'en'

Config.Draw3DText = "~r~Locked~r~"
Config.Draw3DTexts = "Press ~g~[E]~s~ for ~y~Unlock~s~"

Config.DrawText3D = "~r~Locked~r~"
Config.DrawText3DTest = "Press ~g~[E]~s~ for ~y~Unlock~s~"


Config.DoorList = {

	-- MRPD Doords --

	{
		textCoords = vector3(434.81, -981.93, 30.89),
		authorizedJobs = { 'police' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = -90.0,
				objCoords = vector3(434.7444, -980.7556, 30.8153)
			},

			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 90.0,
				objCoords = vector3(434.7444, -983.0781, 30.8153)
			}
		}
	},


	{
		objName = "gabz_mrpd_door_04",
		objYaw = 0.0,
		objCoords = vector3(440.5201, -977.6011, 30.82319),
		textCoords = vector3(440.5201, -977.6011, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	{
		objName = "gabz_mrpd_door_05",
		objYaw = 180.0,
		objCoords = vector3(440.5201, -986.2335, 30.82319),
		textCoords = vector3(440.5201, -986.2335, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	{
		objName = "gabz_mrpd_door_04",
		objYaw = 90.0,
		objCoords = vector3(445.4067, -984.2014, 30.82319),
		textCoords = vector3(445.4067, -984.2014, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	{ -- DOOR NUM.5 , COP TALKER.
		textCoords = vector3(438.1971, -993.9113, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_01",
				objYaw = 90.0,
				objCoords = vector3(438.1971, -996.3167, 30.82319)
			},

			{
				objName = "gabz_mrpd_door_01",
				objYaw = -90.0,
				objCoords = vector3(438.1971, -993.9113, 30.82319)
			}
		}
	},

	{ -- DOOR NUM.6 , Door side station exit.
		textCoords = vector3(440.7392, -998.7462, 30.8153),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 0.0,
				objCoords = vector3(440.7392, -998.7462, 30.8153)
			},

			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 180.0,
				objCoords = vector3(443.0618, -998.7462, 30.8153)
			}
		}
	},

	{
		objName = "gabz_mrpd_door_05",
		objYaw = 135.0,
		objCoords = vector3(452.2663, -995.5254, 30.82319),
		textCoords = vector3(452.2663, -995.5254, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	{
		objName = "gabz_mrpd_door_02",
		objYaw = 225.0,
		objCoords = vector3(458.0894, -995.5247, 30.82319),
		textCoords = vector3(458.0894, -995.5247, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	{ -- DOOR 9
		objName = "gabz_mrpd_door_05",
		objYaw = 270.0,
		objCoords = vector3(458.6543, -990.6498, 30.82319),
		textCoords = vector3(458.6543, -990.6498, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 270.0,
		objCoords = vector3(458.6543, -976.8864, 30.82319),
		textCoords = vector3(458.6543, -976.8864, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	{ -- DOOR NUM.11 , Door side station exit.
		textCoords = vector3(455.8862, -972.2543, 30.81531),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 0.0,
				objCoords = vector3(455.8862, -972.2543, 30.81531)
			},

			{
				objName = "gabz_mrpd_reception_entrancedoor",
				objYaw = 180.0,
				objCoords = vector3(458.2087, -972.2543, 30.81531)
			}
		}
	},


	{ -- DOOR NUM.12
		textCoords = vector3(469.4406, -987.4377, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_01",
				objYaw = -90.0,
				objCoords = vector3(469.4406, -985.0313, 30.82319)
			},

			{
				objName = "gabz_mrpd_door_01",
				objYaw = 90.0,
				objCoords = vector3(469.4406, -987.4377, 30.82319)
			}
		}
	},


	{ -- DOOR NUM.13
		textCoords = vector3(475.3837, -984.3722, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_02",
				objYaw = 0.0,
				objCoords = vector3(472.9781, -984.3722, 30.82319)
			},

			{
				objName = "gabz_mrpd_door_02",
				objYaw = 180.0,
				objCoords = vector3(475.3837, -984.3722, 30.82319)
			}
		}
	},


	{  -- DOOR NUM.14 - Ambulance stuff
		textCoords = vector3(479.7534, -988.6204, 30.82319),
		authorizedJobs = { 'police', 'ambulance' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_04",
				objYaw = -90.0,
				objCoords = vector3(479.7534, -986.2151, 30.82319)
			},

			{
				objName = "gabz_mrpd_door_05",
				objYaw = -90.0,
				objCoords = vector3(479.7534, -988.6204, 30.82319)
			}
		}
	},



	-- Door 15:
	{ 
		textCoords = vector3(472.9777, -989.8247, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_04",
				objYaw = -180.0,
				objCoords = vector3(475.3837, -989.8247, 30.82319)
			},

			{
				objName = "gabz_mrpd_door_05",
				objYaw = 180.0,
				objCoords = vector3(472.9777, -989.8247, 30.82319)
			}
		}
	},


	-- 16
	{
		objName = "gabz_mrpd_door_03",
		objYaw = 90.0,
		objCoords = vector3(479.7507, -999.629, 30.78917),
		textCoords = vector3(479.7507, -999.629, 30.78917),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- 17
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 90.0,
		objCoords = vector3(476.7512, -999.6307, 30.82319),
		textCoords = vector3(476.7512, -999.6307, 30.82319),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- 18
	{
		objName = "gabz_mrpd_door_03",
		objYaw = 180.0,
		objCoords = vector3(487.4378, -1000.189, 30.78697),
		textCoords = vector3(487.4378, -1000.189, 30.78697),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	-- Door 19:
	{ 
		textCoords = vector3(485.6133, -1002.902, 30.78697),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_03",
				objYaw = -180.0,
				objCoords = vector3(488.0184, -1002.902, 30.78697)
			},

			{
				objName = "gabz_mrpd_door_03",
				objYaw = 0.0,
				objCoords = vector3(485.6133, -1002.902, 30.78697)
			}
		}
	},



	-- GGGGGGGGGGGG DONE FLOOR 1 !!!!!!!!!!!!!!!!!!!!!!!
	-- FLOOR 2 [ called main due size ]

	-- Door 2 | [Missing 1 due helicopter floor, will be in the end of config].
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 180.0,
		objCoords = vector3(459.9454, -981.0742, 35.10398),
		textCoords = vector3(459.9454, -981.0742, 35.10398),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 3
	{
		objName = "gabz_mrpd_door_05",
		objYaw = 0.0,
		objCoords = vector3(459.9454, -990.7053, 35.10398),
		textCoords = vector3(459.9454, -990.7053, 35.10398),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 4
	{
		objName = "gabz_mrpd_door_05",
		objYaw = 135.0,
		objCoords = vector3(448.9868, -981.5785, 35.10376),
		textCoords = vector3(448.9868, -981.5785, 35.10376),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},



	-- Door 5
	{
		objName = "gabz_mrpd_door_04",
		objYaw = 45.0,
		objCoords = vector3(448.9868, -990.2007, 35.10376),
		textCoords = vector3(448.9868, -990.2007, 35.10376),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 6
	{
		objName = "gabz_mrpd_door_05",
		objYaw = 135.0,
		objCoords = vector3(448.9846, -995.5264, 35.10376),
		textCoords = vector3(448.9846, -995.5264, 35.10376),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},



	-- NO Door 1 [ Shitty helicopters - GABZ FUCK U ITS WRONG DOOR NAME -_- ]

	

	-- GGGGGGGGGGGG DONE FLOOR 2 !!!!!!!!!!!!!!!!!!!!!!!
	-- FLOOR 0

	-- Door 3
	{
		objName = "gabz_mrpd_room13_parkingdoor",
		objYaw = -90.0,
		objCoords = vector3(464.1591, -974.6656, 26.3707),
		textCoords = vector3(464.1591, -974.6656, 26.3707),
		authorizedJobs = { 'police' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 4
	{
		objName = "gabz_mrpd_room13_parkingdoor",
		objYaw = 90.0,
		objCoords = vector3(464.1566, -997.5093, 26.3707),
		textCoords = vector3(464.1566, -997.5093, 26.3707),
		authorizedJobs = { 'police' },
		locking = false,
		locked = false,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	

	-- Door 5:
	{ 
		textCoords = vector3(471.3753, -987.4374, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_04",
				objYaw = -90.0,
				objCoords = vector3(471.3753, -985.0319, 26.40548)
			},

			{
				objName = "gabz_mrpd_door_05",
				objYaw = -90.0,
				objCoords = vector3(471.3753, -987.4374, 26.40548)
			}
		}
	},


	
	-- Door 10:
	{ 
		textCoords = vector3(479.0624, -987.4376, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_02",
				objYaw = -90.0,
				objCoords = vector3(479.0624, -985.0323, 26.40548)
			},

			{
				objName = "gabz_mrpd_door_02",
				objYaw = 90.0,
				objCoords = vector3(479.0624, -987.4376, 26.40548)
			}
		}
	},

	-- Door 11
	{
		objName = "gabz_mrpd_door_04",
		objYaw = -90.0,
		objCoords = vector3(482.6694, -983.9868, 26.40548),
		textCoords = vector3(482.6694, -983.9868, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 12 -- FUCK U GABZ U FORGOT THE X -_-


	-- Door 13
	{
		objName = "gabz_mrpd_door_04",
		objYaw = -90.0,
		objCoords = vector3(482.6699, -992.2991, 26.40548),
		textCoords = vector3(482.6699, -992.2991, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 14
	{
		objName = "gabz_mrpd_door_04",
		objYaw = -90.0,
		objCoords = vector3(482.6703, -995.7285, 26.40548),
		textCoords = vector3(482.6703, -995.7285, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	
	-- Door 15:
	{ 
		textCoords = vector3(479.6638, -997.91, 26.4065),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_02",
				objYaw = 180.0,
				objCoords = vector3(482.0686, -997.91, 26.4065)
			},

			{
				objName = "gabz_mrpd_door_02",
				objYaw = 0.0,
				objCoords = vector3(479.6638, -997.91, 26.4065)
			}
		}
	},

	-- Door 16
	{
		objName = "gabz_mrpd_door_02",
		objYaw = 180.0,
		objCoords = vector3(478.2892, -997.9101, 26.40548),
		textCoords = vector3(478.2892, -997.9101, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	-- Door 17
	{
		objName = "gabz_mrpd_door_01",
		objYaw = 0.0,
		objCoords = vector3(479.06, -1003.173, 26.4065),
		textCoords = vector3(479.06, -1003.173, 26.4065),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	-- Door 18
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 180.0,
		objCoords = vector3(481.0084, -1004.118, 26.48005),
		textCoords = vector3(481.0084, -1004.118, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},



	-- Door 19
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 180.0,
		objCoords = vector3(484.1764, -1007.734, 26.48005),
		textCoords = vector3(484.1764, -1007.734, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	

	-- Door 20
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(486.9131, -1012.189, 26.48005),
		textCoords = vector3(486.9131, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 21
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(483.9127, -1012.189, 26.48005),
		textCoords = vector3(483.9127, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},



	-- Door 22
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(480.9128, -1012.189, 26.48005),
		textCoords = vector3(480.9128, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 23
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = 0.0,
		objCoords = vector3(477.9126, -1012.189, 26.48005),
		textCoords = vector3(477.9126, -1012.189, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},


	-- Door 24
	{
		objName = "gabz_mrpd_cells_door",
		objYaw = -90.0,
		objCoords = vector3(476.6157, -1008.875, 26.48005),
		textCoords = vector3(476.6157, -1008.875, 26.48005),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},
	

	-- Door 25
	{
		objName = "gabz_mrpd_door_01",
		objYaw = 180.0,
		objCoords = vector3(475.9539, -1006.938, 26.40639),
		textCoords = vector3(475.9539, -1006.938, 26.40639),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.0,
		size = 2
	},

	-- Door 26 missing.
	

	-- Door 7
	{ 
		textCoords = vector3(471.3758, -1010.198, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "gabz_mrpd_door_02",
				objYaw = -90.0,
				objCoords = vector3(471.3679, -1007.793, 26.40548)
			},

			{
				objName = "gabz_mrpd_door_02",
				objYaw = 90.0,
				objCoords = vector3(471.3758, -1010.198, 26.40548)
			}
		}
	},


	-- Door 8
	{ 
		textCoords = vector3(467.3686, -1014.406, 26.48382),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{ -- BROKEN
				objName = "gabz_mrpd_door_03",
				objYaw = 90.0,
				objCoords = vector3(469.7743, -1014.406, 26.48382)
			},

			{
				objName = "gabz_mrpd_door_03",
				objYaw = 0.0,
				objCoords = vector3(467.3686, -1014.406, 26.48382)
			}
		}
	},



	-- Door 9
	{ 
		textCoords = vector3(467.5222, -1000.544, 26.40548),
		authorizedJobs = { 'police' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{ -- BROKEN
				objName = "gabz_mrpd_door_01",
				objYaw = 180.0,
				objCoords = vector3(469.9274, -1000.544, 26.40548)
			},

			{
				objName = "gabz_mrpd_door_01",
				objYaw = 0.0,
				objCoords = vector3(467.5222, -1000.544, 26.40548)
			}
		}
	},



	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = false,
		distance = 2.0,
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = false,
		distance = 2.0,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 12,
		size = 2
	},
	
	{
		objName = 'bobo_prison_cellgate',
		objCoords  = vector3(1831.26, 2593.27, 45.89),
		textCoords = vector3(1831.26, 2593.27, 46.40),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 5,
		size = 2
	},

	{
		objName = 'bobo_prison_cellgate',
		objCoords  = vector3(1838.48, 2587.82, 45.89),
		textCoords = vector3(1838.48, 2587.82, 46.40),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 5,
		size = 2
	},
	


	
	-- principal bank
	{
		objName = 'hei_v_ilev_bk_gate2_pris',
		objCoords  = vector3(261.99899291992, 221.50576782227, 106.68346405029),
		textCoords = vector3(261.99899291992, 221.50576782227, 107.68346405029),
		authorizedJobs = { 'police' , 'offpolice'},
		locked = true,
		distance = 2.0,
		size = 2
	},

	
	-- Pillbox
	-- locker room
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(303.39,-597.53, 43.28),
		textCoords = vector3(303.39,-597.53, 44.00),
		authorizedJobs = { 'ambulance' , 'offambulance'},
		locked = true,
		distance = 2
	},

	-- Pharmacy

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(308.00,-570.00, 43.28),
		textCoords = vector3(308.00,-570.00, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 2
	},


	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(337.28,-580.00, 43.28),
		textCoords = vector3(337.28,-580.00, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 3
	},

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(339.8,-587.00, 43.28),
		textCoords = vector3(339.8,-587.00, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 3
	},

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(341.72,-581.46, 43.28),
		textCoords = vector3(341.72,-581.46, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 3
	},

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(347.8,-583.66, 43.28),
		textCoords = vector3(347.8,-583.66, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 3
	},

	-- wardrobe
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(304.21,-571.56, 43.28),
		textCoords = vector3(304.21,-571.56, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 2
	},

	-- reception

	{
		objName = 'gabz_pillbox_singledoor',
		objCoords = vector3(313.58,-596.00, 43.28),
		textCoords = vector3(313.58,-596.00, 44.00),
		authorizedJobs = { 'ambulance' , 'police' , 'offpolice', 'offambulance'},
		locked = true,
		distance = 2
	},

	{
		textCoords = vector3(-1099.73, -837.70, 127.30),
		authorizedJobs = {},
		locked = true,
		distance = 5.0,
		doors = {
			{
				objName = 'vesp_door1',
				objYaw = 125.0,
				objCoords = vector3(-1099.73, -836.68, 26.85)
			},

			{
				objName = 'vesp_door1',
				objYaw = -50.0,
				objCoords = vector3(-1099.73, -837.90, 26.85)
			}
		}
	},

	-- Weazel News
	{
		objName = 'apa_p_mp_yacht_door_01',
		objYaw = 0.0,
		objCoords = vector3(-568.81, -918.44, 32.34),
		textCoords = vector3(-568.81, -918.44, 33.34),
		authorizedJobs = { 'news' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2
	},

	{ 
		textCoords = vector3(-570.76, -931.39, 28.82),
		authorizedJobs = { 'news' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2.5,
		doors = {
			{
				objName = "ba_prop_door_club_glass",
				objYaw = -90.0,
				objCoords = vector3(-570.8, -930.9, 28.82)
			},

			{
				objName = "ba_prop_door_club_glass",
				objYaw = 90.0,
				objCoords = vector3(-570.8, -932.15, 28.82)
			}
		}
	},

	{
		objName = 'ba_prop_door_club_glass',
		objYaw = 0.0,
		objCoords = vector3(-574.44, -934.25, 27.82),
		textCoords = vector3(-574.44, -934.25, 28.82),
		authorizedJobs = { 'news' },
		locking = false,
		locked = true,
		pickable = false,
		distance = 2
	}

	--- pdm

	
	-- {
	-- 	textCoords = vector3(-1260.673, -349.44, 36.90749),
	-- 	authorizedJobs = { 'pdm' },
	-- 	locking = false,
	-- 	locked = true,
	-- 	pickable = false,
	-- 	distance = 2.5,
	-- 	doors = {
	-- 		{
	-- 			objName = "v_ilev_genbankdoor1",
	-- 			objYaw = 60.0,
	-- 			objCoords = vector3(-1261.8756103515625, -349.6961975097656, 37.11116027832031)
	-- 		},

	-- 		{
	-- 			objName = "v_ilev_genbankdoor2",
	-- 			objYaw = 60.0,
	-- 			objCoords = vector3(-1259.59130859375, -348.5322570800781, 37.11116027832031)
	-- 		}
	-- 	}
	-- },

	-- {
	-- 	textCoords = vector3(-1269.339, -369.3975, 36.90405),
	-- 	authorizedJobs = { 'pdm' },
	-- 	locking = false,
	-- 	locked = true,
	-- 	pickable = false,
	-- 	distance = 2.5,
	-- 	doors = {
	-- 		{
	-- 			objName = "v_ilev_genbankdoor1",
	-- 			objYaw = 0.0,
	-- 			objCoords = vector3(-1268.5780029296875, -370.37017822265625, 37.0992431640625)
	-- 		},

	-- 		{
	-- 			objName = "v_ilev_genbankdoor2",
	-- 			objYaw = 0.0,
	-- 			objCoords = vector3(-1269.7930908203125, -368.1114807128906, 37.11116027832031)
	-- 		}
	-- 	}
	-- }

}