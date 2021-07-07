DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

local spawnedVehicles = {
	{ slot = 1, 	cat= 'cars', 		model = 	'accord20', 				price =  	300000,			spawned = true},
	{ slot = 2, 	cat= 'bikes', 		model = 	'HDIron883',  				price =  	120000,			spawned = true},
	{ slot = 3,		cat= 'bikes', 		model= 		'HDIron883',  				price = 	75000,			spawned = true},
	{ slot = 4, 	cat= 'bikes', 		model = 	'HDIron883',  				price =  	60000,			spawned = true},
	{ slot = 5, 	cat= 'bikes',		model = 	'HDIron883', 				price =  	110000,			spawned = true},
	{ slot = 6, 	cat= 'big',			model  = 	'a8fsi',  					price = 	250000,			spawned = true},
}

local bikepass = {}
local carpass = {}

function loadtiers()
    MySQL.Async.fetchAll('SELECT * FROM supporter', {}, function(supporters)
        for k, v in ipairs(supporters) do
			if v.tier >= 2 then
				bikepass[v.identifier] = v.identifier
				carpass[v.identifier] = v.identifier
            elseif v.tier >= 1 then
				bikepass[v.identifier] = v.identifier
            end   
        end
	end)
end

MySQL.ready(function()
	loadtiers()
end)

RegisterNetEvent('ndrp_edm:spawnDefaultS')
AddEventHandler('ndrp_edm:spawnDefaultS', function(slot,status)
	TriggerClientEvent('ndrp_edm:spawnDefaultC', -1, spawnedVehicles,slot,status)
end)

RegisterNetEvent('ndrp_edm:updateTable')
AddEventHandler('ndrp_edm:updateTable', function(tab) 
	for k, v in pairs(tab) do
        spawnedVehicles[k].model = v.model
		spawnedVehicles[k].cat = v.cat
		spawnedVehicles[k].price = v.price
		spawnedVehicles[k].spawned = v.spawned
	end
end)

RegisterServerEvent('ndrp_edm:pdmswap')
AddEventHandler('ndrp_edm:pdmswap', function(slot,cat)
	local xPlayer = DGCore.GetPlayerFromId(source)
	while xPlayer == nil do
		xPlayer = DGCore.GetPlayerFromId(source)
	end
	TriggerClientEvent('ndrp_edm:pdmspawn', source , slot, cat)
end, false)

------- DO NOT TOUCH -----

DGCore.RegisterServerCallback('ndrp_edm:checkmoney', function(source, cb, price)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local price = tonumber(price)
	if money >= price then cb(true) else cb(false) end
end)


DGCore.RegisterServerCallback('ndrp_edm:checkpass', function(source, cb, vtype)
	local xPlayer = DGCore.GetPlayerFromId(source)
	if vtype ==  'cars' or vtype ==  'big' then
		for k,v in pairs (carpass) do
			if xPlayer.identifier == k then
				cb(true)
				return
			end
		end
	elseif vtype == 'bikes' then
		for k,v in pairs (bikepass) do
			if xPlayer.identifier == k then
				cb(true)
				return
			end
		end
	end
	cb(false)
end)

RegisterServerEvent('ndrp_edm:buycar')
AddEventHandler('ndrp_edm:buycar', function(vehicleProps,money,model)
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)
	local vehicleProps, money, model = vehicleProps,money,model
	print('in event')
	if money == carprice[model].price or money == 0 then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle,model) VALUES (@owner, @plate, @vehicle, @model)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@model'] = model,
			['@vehicle'] = json.encode(vehicleProps)
		}, function(rowsChanged)
			xPlayer.removeMoney(money)
			--xPlayer.showNotification("Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
			TriggerClientEvent('dg:showNotification', xPlayer.source, "Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
			print("Triggering log event")
			TriggerEvent("edm:buy",_source,model,money,vehicleProps.plate)
		end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Suspicious Activity Detected!' })
	end
end)


RegisterServerEvent('ndrp_edm:givetest')
AddEventHandler('ndrp_edm:givetest', function(buyer, model)
	TriggerClientEvent('ndrp_edm:testdrive',buyer,model,slot)
end)

RegisterServerEvent('ndrp_edm:testdrivemoney')
AddEventHandler('ndrp_edm:testdrivemoney', function(deducted)
	local xPlayer = DGCore.GetPlayerFromId(source)
	while xPlayer == nil do
		xPlayer = DGCore.GetPlayerFromId(source)
	end
	if deducted then
		xPlayer.removeMoney(5000)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You paid $1000 for test drive' })
	else
		xPlayer.addMoney(5000)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got back $1000 for returning vehicle' })
	end
end)

carprice = {

	-- ['r6'] = {price = 65000, name = 'Yamaha R6'},
	-- ['hcbr17'] = {price = 75000, name = 'Honda CBR17'},
	-- ['hexer'] = {price = 60000, name = 'H.D. Knucklehead Bobber'},
	-- ['kcc_queens_warrior'] = {price = 90000, name = 'KCC Queens Warrior'},
	-- ['zx10r'] = {price = 100000, name = 'Kawasaki Ninja'},
	-- ['sovereign'] = {price = 110000, name = 'HD FatBoy Racing'},
	-- ['fatboy'] = {price = 120000, name = 'H.D. FatBoy Vintage'},		
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
	-- ['nissantitan17'] = {price = 250000, name = 'Nissan Titan'},
	['HDIron883'] = {price = 300000, name = 'Hyundai Accord'},
	['santa9'] = {price = 550000, name = 'Hyundai SantaFe'},
	['avj'] = {price = 450000, name = 'Lamborghini Aventador J'},
	['STO'] = {price = 150000, name = 'Lamborghini Huracan STO'},
	['urustc'] = {price = 150000, name = 'Lamborghini URUS'},
	['650slbs'] = {price = 150000, name = 'McLaren 650SLBS'},
	['elva'] = {price = 150000, name = 'McLaren Elva'},
	['cz4a'] = {price = 150000, name = 'Mitsubishi Lancer Evo X'},
	['skyline'] = {price = 150000, name = 'Nissan R34'},

	['a8fsi'] = {price = 350000, name = 'Audi A8'},
	['audsq517'] = {price = 435000, name = 'Audi Q5'},
	['r820'] = {price = 300000, name = 'Audi R8 V10'},
	['rs7c8'] = {price = 300000, name = 'Audi RS7'},
	['rmodbmwi8'] = {price = 150000, name = 'BMW I8'},
	['m5f90'] = {price = 150000, name = 'BMW M5'},
	['m6gc'] = {price = 150000, name = 'BMW M6'},
	['x5mcompetition'] = {price = 150000, name = 'BMW X5'},
	['monza'] = {price = 150000, name = 'Ferrari Monza'},
	['forgt50020'] = {price = 150000, name = 'Ford Mustang GT500'}
}