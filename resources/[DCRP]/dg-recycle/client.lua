Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
        Citizen.Wait(0)
        TriggerServerEvent("playerSpawned")
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	DGCore.PlayerData = DGCore.GetPlayerData()
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

local RecyclePoints = {
	{1015.4642333984,-3110.4521484375,-38.99991607666,["time"] = 0,["used"] = false},  
	{1011.2679443359,-3110.8725585938,-38.99991607666,["time"] = 0,["used"] = false},  
	{1005.8571777344,-3110.6271972656,-38.99991607666,["time"] = 0,["used"] = false},  
	{995.37841796875,-3108.6293945313,-38.99991607666,["time"] = 0,["used"] = false}, 
	{1003.0407104492,-3104.7854003906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1008.2990112305,-3106.94140625,-38.999881744385,["time"] = 0,["used"] = false},  
	{1010.9890136719,-3104.5573730469,-38.999881744385,["time"] = 0,["used"] = false},  
	{1013.3607788086,-3106.8874511719,-38.999881744385,["time"] = 0,["used"] = false},  
	{1017.8317260742,-3104.5822753906,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1019.0430297852,-3098.9851074219,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1013.7381591797,-3100.9680175781,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1009.3251342773,-3098.8120117188,-38.999881744385,["time"] = 0,["used"] = false},  
	{1005.9111938477,-3100.9387207031,-38.999881744385,["time"] = 0,["used"] = false}, 
	{1003.2393798828,-3093.9182128906,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1008.0280151367,-3093.384765625,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1010.8000488281,-3093.544921875,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1016.1090087891,-3095.3405761719,-38.999885559082,["time"] = 0,["used"] = false},  
	{1018.2312011719,-3093.1293945313,-38.999885559082,["time"] = 0,["used"] = false},  
	{1025.1221923828,-3091.4680175781,-38.999885559082,["time"] = 0,["used"] = false}, 
	{1024.9321289063,-3096.4670410156,-38.999885559082,["time"] = 0,["used"] = false}, 
}

local dropPoints = {
	{1001.375,-3108.3840332031,-38.999900817871},
	{997.32006835938,-3099.3923339844,-38.999900817871},
	{1022.0564575195,-3095.892578125,-38.999855041504},
	{1022.1699829102,-3106.6181640625,-38.999855041504},
}

-----------------------------
-- Metal Harvest
-----------------------------

isRunningCrate = false

function runRecycle()
	
	isRunningCrate = true
	local isHolding = false

	TriggerEvent("attachItem","crate01")
    RequestAnimDict("anim@heists@box_carry@")
    TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180, 49, 0, 0, 0, 0)
    Wait(1000)
    TaskPlayAnim(GetPlayerPed(-1),"anim@heists@box_carry@","idle",2.0, -8, 180000000, 49, 0, 0, 0, 0)
    
    isHolding = true
    local rnd = math.random(1,4)

    while isHolding do
		Wait(0)
    	if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], true) <= 40 then
    		DrawText3Ds(dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], "[~g~E~s~] - Drop Material")
    		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
	    		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),dropPoints[rnd][1],dropPoints[rnd][2],dropPoints[rnd][3], true) <= 1.5 then
	    			isHolding = false
	    		end
			end
		end
		
    end

    ClearPedTasks(GetPlayerPed(-1))
    TriggerEvent("destroyProp")
    FreezeEntityPosition(GetPlayerPed(-1),true)
    RequestAnimDict("mp_car_bomb")
    TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 180,49, 0, 0, 0, 0)
    Wait(100)
    TaskPlayAnim(GetPlayerPed(-1),"mp_car_bomb","car_bomb_mechanic",2.0, -8, 1800000,49, 0, 0, 0, 0)
    Wait(3000)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1),false)

    if math.random(1,10) == 8 then
    	TriggerEvent('player:receiveItem',"recyclablematerial", math.random(3,8))
    else
    	TriggerEvent('player:receiveItem',"recyclablematerial", math.random(1,6))
	end

	TriggerEvent("DoLongHudText","Nice work, keep it up!")
	isRunningCrate = false
	
end



isTrading = false

local recycleCoords = {x = 995.37, y= -3100.18, z = -38.99}

Citizen.CreateThread(function()
	listOn = false
	while true do
		Citizen.Wait(5)
		local PlayerPos = GetEntityCoords(PlayerPedId())
		for k,v in pairs(RecyclePoints) do
			if GetDistanceBetweenCoords(PlayerPos, v[1],v[2],v[3], true) <= 3 and not v.used and not isRunningCrate then
				DrawText3Ds(v[1],v[2],v[3], "Material, Pickup with [E]")
			end
		end
		
		if GetDistanceBetweenCoords(PlayerPos, recycleCoords.x,recycleCoords.y,recycleCoords.z, true) <= 2.0 then
			if DGCore.PlayerData.job ~= nil and DGCore.PlayerData.job.name == 'recycle' and DGCore.PlayerData.job.grade > 0 then
				DrawText3Ds(recycleCoords.x,recycleCoords.y,recycleCoords.z, "[~g~E~s~] - Recycle Material")
			end
		end

		if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then

			for k,v in pairs(RecyclePoints) do
				if GetDistanceBetweenCoords(PlayerPos, v[1],v[2],v[3], true) <= 2 then
					if not v.used and not isRunningCrate then
						v.used = true
						runRecycle()
					end
				end
			end

			if GetDistanceBetweenCoords(PlayerPos, recycleCoords.x,recycleCoords.y,recycleCoords.z, true) <= 1 and not isTrading then
				if DGCore.PlayerData.job ~= nil and DGCore.PlayerData.job.name == 'recycle' and DGCore.PlayerData.job.grade > 0 then
					TriggerEvent("server-inventory-open", "57", "Craft")
				end
			end
			Wait(2500)
		end
	end
end)

RegisterNetEvent('EnterAnimation')
AddEventHandler('EnterAnimation', function()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "anim@heists@keycard@" ) 
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())
end)

searchlocs = {
	[1] = { ["x"] = 3201.2182617188, ["y"] = -391.48400878906, ["z"] = -23.259761810303},
	[2] = { ["x"] = 3196.9177246094, ["y"] = -408.05932617188, ["z"] = -27.876317977905},
	[3] = { ["x"] = 3215.7932128906, ["y"] = -407.1276550293, ["z"] = -44.167171478271},
	[4] = { ["x"] = 3206.1162109375, ["y"] = -375.3466796875, ["z"] = -36.000392913818},
	[5] = { ["x"] = 3200.2814941406, ["y"] = -379.67575073242, ["z"] = -34.961269378662},
	[6] = { ["x"] = 3187.3615722656, ["y"] = -332.20944213867, ["z"] = -29.669620513916},
	[7] = { ["x"] = 3179.2360839844, ["y"] = -312.16946411133, ["z"] = -25.496395111084},
	[8] = { ["x"] = 3172.1965332031, ["y"] = -317.11364746094, ["z"] = -27.636051177979},
	[9] = { ["x"] = 3174.7990722656, ["y"] = -302.24227905273, ["z"] = -23.497297286987},
	[10] = { ["x"] = 3171.578125, ["y"] = -296.20367431641, ["z"] = -13.480889320374},
	[11] = { ["x"] = 3154.416015625, ["y"] = -296.89733886719, ["z"] = -28.087270736694},
	[12] = { ["x"] = 3158.9484863281, ["y"] = -281.97003173828, ["z"] = -27.074890136719},
	[13] = { ["x"] = 3150.7426757813, ["y"] = -262.9921875, ["z"] = -28.271263122559},
	[14] = { ["x"] = 3150.8854980469, ["y"] = -217.15423583984, ["z"] = -16.165866851807},
	[15] = { ["x"] = 3120.6462402344, ["y"] = -200.17106628418, ["z"] = -24.049646377563},
	[16] = { ["x"] = 3140.7524414063, ["y"] = -316.0227355957, ["z"] = -24.688371658325},
	[17] = { ["x"] = 3146.8132324219, ["y"] = -247.95794677734, ["z"] = -24.676942825317},
	[18] = { ["x"] = 3165.4816894531, ["y"] = -258.66400146484, ["z"] = -26.750165939331},
	[19] = { ["x"] = 3181.0842285156, ["y"] = -317.25454711914, ["z"] = -26.883680343628},
	[20] = { ["x"] = 3180.0959472656, ["y"] = -341.40322875977, ["z"] = -30.784688949585},
	[21] = { ["x"] = 3193.1364746094, ["y"] = -363.17828369141, ["z"] = -30.75234413147},
	[22] = { ["x"] = 3197.1911621094, ["y"] = -385.39462280273, ["z"] = -35.836166381836},
	[23] = { ["x"] = 3182.8552246094, ["y"] = -390.6247253418, ["z"] = -29.592353820801},
	[24] = { ["x"] = 3141.5588378906, ["y"] = -367.74792480469, ["z"] = -21.118682861328},
	[25] = { ["x"] = 3119.9138183594, ["y"] = -345.11264038086, ["z"] = -24.653188705444},
	[26] = { ["x"] = 3118.1330566406, ["y"] = -306.34729003906, ["z"] = -16.11749458313},
	[27] = { ["x"] = 3142.1520996094, ["y"] = -283.90283203125, ["z"] = -10.221350669861},
	[28] = { ["x"] = 3148.6247558594, ["y"] = -280.36285400391, ["z"] = -9.3033046722412},
	[29] = { ["x"] = 3156.5888671875, ["y"] = -279.69830322266, ["z"] = -7.2221312522888},
	[30] = { ["x"] = 3141.9328613281, ["y"] = -260.60629272461, ["z"] = -26.25365447998},
	[31] = { ["x"] = 3157.6818847656, ["y"] = -251.28622436523, ["z"] = -28.205274581909},
	[32] = { ["x"] = 3159.1472167969, ["y"] = -224.02615356445, ["z"] = -16.791307449341},
	[33] = { ["x"] = 3118.2922363281, ["y"] = -227.54614257813, ["z"] = -20.618988037109},
	[34] = { ["x"] = 3163.9130859375, ["y"] = -273.08697509766, ["z"] = -6.8318490982056},
	[35] = { ["x"] = 3166.4831542969, ["y"] = -307.53030395508, ["z"] = -10.113006591797},
	[36] = { ["x"] = 3164.4318847656, ["y"] = -323.21084594727, ["z"] = -12.844867706299},
	[37] = { ["x"] = 3168.4270019531, ["y"] = -331.61938476563, ["z"] = -25.868635177612},
	[38] = { ["x"] = 3181.1440429688, ["y"] = -350.92611694336, ["z"] = -29.355766296387},
	[39] = { ["x"] = 3167.3950195313, ["y"] = -322.44485473633, ["z"] = -12.537293434143},
	[40] = { ["x"] = 3173.3049316406, ["y"] = -325.94842529297, ["z"] = -13.356497764587},
	[41] = { ["x"] = 3188.8291015625, ["y"] = -400.81228637695, ["z"] = -25.698865890503},
	[42] = { ["x"] = 3146.501953125, ["y"] = -404.28521728516, ["z"] = -17.819589614868},
	[43] = { ["x"] = 3146.7465820313, ["y"] = -359.43133544922, ["z"] = -21.088090896606},
}

local materialsTable = {4,26,27,28,30,31,32,33,34}
local craftingItemsTable = {47,48,50,51,52,53}
local craftingItemsChances= {90,86,65,60,40,40}

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end


function CleanUpArea()
    local playerped = GetPlayerPed(-1)
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = GetDistanceBetweenCoords(plycoords, pos, true)
        if distance < 50.0 and ObjectFound ~= playerped then
            if IsEntityAPed(ObjectFound) then
                if IsPedAPlayer(ObjectFound) then
                else
                    DeleteObject(ObjectFound)
                end
            else
                if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
                    DeleteObject(ObjectFound)
                end
            end
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    EndFindObject(handle)
end

function renderPropsWhereHouse()
	CreateObject(GetHashKey("ex_prop_crate_bull_sc_02"),1003.63013,-3108.50415,-39.9669662,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_bc"),1018.18011,-3102.8042,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_closed_bc"),1006.05511,-3096.954,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_wlife_sc"),1003.63013,-3102.8042,-37.81769,false,false,false)
	CreateObject(GetHashKey("ex_prop_crate_jewels_racks_sc"),1003.63013,-3091.604,-37.8179666,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1013.330000003,-3102.80400000,-35.62896000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1018.18000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1003.63000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3106.52900000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3106.52900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_SC"),1010.90500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1013.33000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1010.90500000,-3096.95400000,-39.86697000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_SC"),993.35510000,-3111.30400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),993.35510000,-3108.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,-3096.95400000,-37.8177600,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1018.180000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_BC"),1008.48000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3108.50400000,-35.61234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_BC"),1026.75500000,-3091.59400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1008.48000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1018.18000000,-3096.95400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1018.18000000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1008.48000000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),1013.33000000,-3108.50400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3108.88900000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1010.90500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Wlife_BC"),1015.75500000,-3091.60400000,-35.74857000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_BC"),1003.63000000,-3108.50400000,-37.81561000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3096.954000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1006.05500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_RW"),1013.33000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Narc_SC"),1026.75500000,-3094.014000000,-37.81684000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3096.95400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Ammo_BC"),1013.33000000,-3102.80400000,-37.81427000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_BC"),1003.63000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1003.63000000,-3096.95400000,-37.81187000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1010.90500000,-3091.60400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1013.33000000,-3091.60400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3091.59400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3094.0140000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_BC"),1026.75500000,-3096.43400000,-35.74885000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_clothing_SC"),1013.33000000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_biohazard_SC"),1006.05500000,-3108.50400000,-37.81576000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3106.60400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1026.75500000,-3111.38400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3096.4340000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1015.75500000,-3096.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1003.63000000,-3091.60400000,-35.62571000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_SC"),1015.75500000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.330000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1018.18000000,-3102.80400000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1013.33000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1018.18000000,-3108.50400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1010.90500000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1026.75500000,-3108.88900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1010.90500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_SC"),1008.48000000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),1018.180000000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1008.48000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_02_BC"),993.35510000,-3106.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.480000000,-3102.804000000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),993.35510000,-3111.30400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_HighEnd_pharma_BC"),1018.18000000,-3091.60400000,-37.81572000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1015.75500000,-3102.80400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_BC"),1003.63000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1006.05500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1003.630000000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_furJacket_SC"),1006.05500000,-3102.80400000,-37.81544000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Expl_bc"),1010.90500000,-3102.80400000,-37.81982000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3096.9540000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1006.05500000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3108.50400000,-37.81529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Art_BC"),1015.75500000,-3096.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_BC"),1010.90500000,-3096.95400000,-37.81234000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1010.90500000,-3102.804000000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_BC"),1008.48000000,-3102.80400000,-35.60529000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3106.60400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Money_SC"),1015.75500000,-3091.604000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Med_BC"),1026.75500000,-3106.52900000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),1015.75500000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_SC"),1010.905000000,-3091.60400000,-37.81240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3091.60400000,-35.62796000,false,false,false) -- This one
	CreateObject(GetHashKey("ex_Prop_Crate_pharma_SC"),1026.75500000,-3096.43400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1006.05500000,-3108.50400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1015.75500000,-3108.504000000,-37.81776000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1018.18000000,-3102.80400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Tob_BC"),1008.48000000,-3108.50400000,-35.75240000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),993.35510000,-3111.30400000,-37.81342000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_racks_SC"),1026.75500000,-3111.384000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_SC"),1006.05500000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1013.33000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Gems_SC"),1013.33000000,1013.33000000,1013.33000000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Jewels_BC"),1026.75500000,-3108.889000000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_SC_02"),993.35510000,-3108.95400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_BC"),1008.48000000,-3091.60400000,-37.81797000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Elec_SC"),993.35510000,-3108.95400000,-35.62796000,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_XLDiam"),1026.75500000,-3094.01400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_watch"),1013.33000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_SHide"),1018.18000000,-3096.95400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Oegg"),1006.05500000,-3091.60400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_MiniG"),1018.18000000,-3108.50400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_FReel"),11008.48000000,-3102.80400000,-39.99757,false,false,false)
	CreateObject(GetHashKey("ex_Prop_Crate_Closed_SC"),1006.05500000,-3091.60400000,-37.81985000,false,false,false) -- -64
	CreateObject(GetHashKey("ex_Prop_Crate_Bull_BC_02"),1026.75500000,-3091.59400000,-39.99757,false,false,false)

	local tool1 = CreateObject(-573669520,1022.6115112305,-3107.1694335938,-39.999912261963,false,false,false)
	local tool2 = CreateObject(-573669520,1022.5317382813,-3095.3305664063,-39.999912261963,false,false,false)
	local tool3 = CreateObject(-573669520,996.60125732422,-3099.2927246094,-39.999923706055,false,false,false)
	local tool4 = CreateObject(-573669520,1002.0411987305,-3108.3645019531,-39.999897003174,false,false,false)

	SetEntityHeading(tool1,GetEntityHeading(tool1)-130)
	SetEntityHeading(tool2,GetEntityHeading(tool2)-40)
	SetEntityHeading(tool3,GetEntityHeading(tool3)+90)
	SetEntityHeading(tool4,GetEntityHeading(tool4)-90)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Getmecuh = PlayerPedId()
        local x,y,z = 895.7985,-896.2082, 27.7958
        local drawtext = "[~g~E~s~] Enter Recycling Centre"
        local plyCoords = GetEntityCoords(Getmecuh)
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z,false)
        if distance <= 1.2 then
            DrawText3Ds(x,y,z, drawtext) 
            if IsControlJustReleased(0, 38) then
                renderPropsWhereHouse()
                TriggerEvent('dooranim')
				TriggerEvent('InteractSound_CL:PlayOnOne', 'door', 0.8)
                DoScreenFadeOut(400)
                Citizen.Wait(500)
                SetEntityCoords(Getmecuh, 997.4598, -3091.976, -38.99984)
                Citizen.Wait(500)
                DoScreenFadeIn(500)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local Getmecuh = PlayerPedId()
        local drawtext2 = "[~g~E~s~] Exit Recycling Centre"
        local x,y,z = 997.4598, -3091.976, -38.99984
        local plyCoords = GetEntityCoords(Getmecuh)
        local distance = GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z,false)
        if distance <= 1.2 then
            DrawText3Ds(x,y,z, drawtext2) 
            if IsControlJustReleased(0, 38) then
                CleanUpArea()
                TriggerEvent('dooranim')
                TriggerEvent('InteractSound_CL:PlayOnOne', 'door', 0.8)
                DoScreenFadeOut(400)
                Citizen.Wait(500)
                SetEntityCoords(Getmecuh,-428.65,-1728.35,19.78)
                Citizen.Wait(500)
                DoScreenFadeIn(500)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5*60*1000)
		for k,v in pairs(RecyclePoints) do
			v.used = false
		end
	end
end)