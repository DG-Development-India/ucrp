Config                            = {}

Config.Teleporters = {
	['EMSGarage'] = {
		['Job'] = 'ems',
		['Enter'] = { 
			['x'] = 330.01, 
			['y'] = -601.01, 
			['z'] = 42.29,
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] - Garage',
		},
		['Exit'] = {
			['x'] = 339.64, 
			['y'] = -584.61, 
			['z'] = 27.9, 
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] - Main Lobby' 
		}
	},

	['PillboxEnter'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['x'] = 346.19, 
			['y'] = -582.71, 
			['z'] = 27.9,
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] - Main Lobby',
		},
		['Exit'] = {
			['x'] = 332.31, 
			['y'] = -595.55, 
			['z'] = 42.30, 
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] - Hallway',
		}
	},

	['PillboxRoof'] = {
		['Job'] = 'ems',
		['Enter'] = { 
			['x'] = 327.18, 
			['y'] = -603.41, 
			['z'] = 42.30,
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] to Roof',
		},
		['Exit'] = {
			['x'] = 338.57, 
			['y'] = -583.97, 
			['z'] = 73.17, 
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] to Ward D',
		}
	},
	
	['PillboxMorgue'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['x'] = 332.8, 
			['y'] = -569.3, 
			['z'] = 42.30,
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] to Morgue',
		},
		['Exit'] = {
			['x'] = 275.69, 
			['y'] = -1361.35, 
			['z'] = 23.55, 
			['r'] = 102, 
			['g'] = 0, 
			['b'] = 102,
			['Information'] = '[E] to Pillbox',
		}
	},


	
	['TBF'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['x'] = -781.87, 
			['y'] = 322.25, 
			['z'] = 211.0,
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = 1348.33, 
			['y'] = -547.05, 
			['z'] = 72.90, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},
	
	['BF'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['x'] = -708.17, 
			['y'] = 629.17, 
			['z'] = 154.17,
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = -787.38, 
			['y'] = 315.74, 
			['z'] = 186.92, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},
	
	['BF2'] = {
		['Job'] = 'none',
		['Enter'] = {
			['x'] = -700.94, 
			['y'] = 646.97, 
			['z'] = 154.39,
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = -785.33, 
			['y'] = 314.15, 
			['z'] = 186.92, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},

	['GALAXY'] = {
		['Job'] = 'none',
		['Enter'] = {
			['x'] = -379.36, 
			['y'] = 217.96, 
			['z'] = 82.68,
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = -1569.37, 
			['y'] = -3017.53, 
			['z'] = -75.42, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},


	['VASPUCCI'] = {
		['Job'] = 'none',
		['Enter'] = {
			['x'] = -1092.73, 
			['y'] = -828.28, 
			['z'] = 22.00,
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = -1098.64, 
			['y'] = -837.15, 
			['z'] = 25.74, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},

	-- ['tunershop'] = {
	-- 	['Job'] = 'none',
	-- 	['Enter'] = {
	-- 		['x'] = 804.07, 
	-- 		['y'] = -988.93, 
	-- 		['z'] = 25.14,
	-- 		['r'] = 0, 
	-- 		['g'] = 0, 
	-- 		['b'] = 0,
	-- 		['Information'] = '[E] to Enter',
	-- 	},
	-- 	['Exit'] = {
	-- 		['x'] = 1004.34, 
	-- 		['y'] = -2992.28, 
	-- 		['z'] = -40.64, 
	-- 		['r'] = 0, 
	-- 		['g'] = 0, 
	-- 		['b'] = 0,
	-- 		['Information'] = '[E] to Leave',
	-- 	}
	-- },

	['oxyshop'] = {
		['Job'] = 'none',
		['Enter'] = {
			['x'] = 114.62, 
			['y'] = -5.33, 
			['z'] = 67.0,
			['r'] = 0,
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Enter',
		},
		['Exit'] = {
			['x'] = -173.5478, 
			['y'] = 6381.8296, 
			['z'] = 24.0, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '[E] to Leave',
		}
	},

	['vehicleshop'] = {
		['Job'] = 'none',
		['Enter'] = {
			['x'] = 138.2, 
			['y'] = -137.19, 
			['z'] = 53.86,
			['r'] = 0,
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '~g~[E]~w~ use lift',
		},
		['Exit'] = {
			['x'] = 137.57, 
			['y'] = -134.41, 
			['z'] = 59.52, 
			['r'] = 0, 
			['g'] = 0, 
			['b'] = 0,
			['Information'] = '~g~[E]~w~ use lift',
		}
	},

}