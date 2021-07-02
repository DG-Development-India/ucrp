
Config = {}

-- Mining Settings:

Config.MiningMarker = 27 												-- marker type
Config.MiningMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 		-- rgba color of the marker
Config.MiningMarkerScale = { x = 0, y = 0, z = 0 }  			-- the scale for the marker on the x, y and z axis
Config.DrawMining3DText = "~g~[E]~s~ to cut"				-- set your desired text here
Config.KeyToStartMining = 38											-- key to start mining, default; [E]
Config.Pickaxe = "axe"												-- name in database for pickaxe
Config.Stone = "wood"													-- name in database for stone
Config.StoneReward = 5													-- amount of stones player receive after mining process
Config.MaxStoneAmount = 90												-- max amount of stone that player can mine and have in inventory

Config.MiningPositions = {
    [1] = { 
		spot = {-503.7269,5392.015,75.96314},
		blipEnable = true, blipName = "Tree Spot", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8,
		mining = false
	},
	[2] = { 
		spot = {-491.8256,5396.649,77.20038},
		blipEnable = false, blipName = "Tree Spot 2", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8,
		mining = false
	},
	[3] = { 
		spot = {-500.1672,5400.434,75.26234},
		blipEnable = false, blipName = "Tree Spot 3", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8,
		mining = false
	},
	[4] = { 
		spot = {-456.896,5397.43,79.47507},
		blipEnable = false, blipName = "Tree Spot 4", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8,
		mining = false
	},
	[5] = { 
		spot = {-457.3548,5409.026,78.78495},
		blipEnable = false, blipName = "Tree Spot 5", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8,
		mining = false
	}, 
}

-- Washer Settings:

Config.WasherMarker = 27 												-- marker type
Config.WasherMarkerColor = { r = 30, g = 139, b = 195, a = 170 } 		-- rgba color of the marker
Config.WasherMarkerScale = { x = 0, y = 0, z = 0 }  				-- the scale for the marker on the x, y and z axis
Config.DrawWasher3DText = "~g~[E]~s~ to cut"				-- set your desired text here
Config.KeyToStartWashing = 38											-- key to start mining, default; [E]
Config.Washpan = "axe"												-- name in database for washpan
Config.WStone = "cutwood"											-- name in database for washed stone
Config.ReqStoneForWash = 10												-- Required amount of stone to process Config.WStoneReward
Config.WStoneReward = 10												-- amount of washed stones player receive after washing process
Config.MaxWStoneAmount = 90												-- max amount of washed stone that player can wash and have in inventory


Config.WashingPositions = {
    [1] = { 
		spot = {-532.4012,5292.835,74.19465},
		blipEnable = true, blipName = "cutting spot", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8
	},
	[2] = { 
		spot = {-534.0975,5292.698,74.17423},
		blipEnable = false, blipName = "cutting spot 2", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8
	},
}

-- Smelter Settings:

Config.SmelterMarker = 27 												-- marker type
Config.SmelterMarkerColor = { r = 240, g = 52, b = 52, a = 100 } 		-- rgba color of the marker
Config.SmelterMarkerScale = { x = 0, y = 0, z = 0 }  			-- the scale for the marker on the x, y and z axis
Config.DrawSmelter3DText = "~g~[E]~s~ to Shape"	-- set your desired text here
Config.KeyToStartSmelting = 38											-- key to start mining, default; [E]

Config.SmeltingPositions = {
    [1] = { 
		spot = {-580.3975,5354.872,70.21441},
		blipEnable = true, blipName = "shaping Spot", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8
	},
	[2] = { 
		spot = {-575.0693,5353.175,70.2144},
		blipEnable = false, blipName = "shaping Spot 2", blipSprite = 285, blipDisplay = 4, blipColor = 25, blipScale = 0.8
	},
}

-- PLEASE LOOK IN SERVER.LUA AT THIS EVENT "dg_lumberjack:rewardSmelting" TO SEE REWARD CHANCES!!!

-- item 1
Config.Item1 = "uncut_diamond"
Config.ItemReward1 = 1
Config.ItemLimit1 = 25
-- item 2
Config.Item2 = "uncut_rubbies"
Config.ItemReward2 = 1
Config.ItemLimit2 = 30
-- item 3
Config.Item3 = "goldminer"
Config.ItemReward3 = 1
Config.ItemLimit3 = 35
-- item 4
Config.Item4 = "silverminer"
Config.ItemReward4 = 2
Config.ItemLimit4 = 40
-- item 5
Config.Item5 = "copper"
Config.ItemReward5 = 3
Config.ItemLimit5 = 45
-- item 6
Config.Item6 = "iron_ore"
Config.ItemReward6 = 7
Config.ItemLimit6 = 50







