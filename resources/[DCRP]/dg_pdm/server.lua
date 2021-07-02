DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

local spawnedVehicles = {
	{ 	cat= 'bicycles', 			model = 'bmx', 				price = 500,		spawned = true},
	{ 	cat= 'motorcycles', 		model = 'bati',  			price = 35000,		spawned = true},
	{ 	cat= 'compacts', 			model = 'issi3',  			price = 12000,		spawned = true},
	{	cat= 'sports', 				model = 'comet5',  			price = 150000,		spawned = true},
	{	cat= 'muscle',				model = 'dominator3', 		price = 65000,		spawned = true},
	{ 	cat= 'super',				model = 'tyrant',  			price = 320000,		spawned = true},
	{ 	cat= 'coupes',				model = 'felon',  			price = 45000,		spawned = true},
	{ 	cat= 'sportsclassics',		model = 'jb700',  			price = 200000,		spawned = true},
	{ 	cat= 'suvs',				model = 'mesa3', 	 		price = 50000,		spawned = true},
	{ 	cat= 'offroad',				model = 'trophytruck2', 	price = 50000,		spawned = true},
	{ 	cat= 'smallbot',			model = 'dinghy', 			price = 550000,		spawned = true},
	{ 	cat= 'newmuscle',			model = 'alfa65', 			price = 120000,		spawned = true},
	{ 	cat= 'newsuv',				model = 'mansm8', 			price = 150000,		spawned = true},
	{ 	cat= 'newsport',			model = 'camarozl1', 		price = 200000,		spawned = true},
}

RegisterNetEvent('ndrp_pdm:spawnDefaultS')
AddEventHandler('ndrp_pdm:spawnDefaultS', function(slot,status)
	TriggerClientEvent('ndrp_pdm:spawnDefaultC', -1, spawnedVehicles,slot,status)
end)

RegisterNetEvent('ndrp_pdm:updateTable')
AddEventHandler('ndrp_pdm:updateTable', function(tab) 
	for k, v in pairs(tab) do
        spawnedVehicles[k].model = v.model
		spawnedVehicles[k].cat = v.cat
		spawnedVehicles[k].price = v.price
		spawnedVehicles[k].spawned = v.spawned
		spawnedVehicles[k].stock = v.stock
	end
end)

RegisterServerEvent('ndrp_pdm:pdmswap')
AddEventHandler('ndrp_pdm:pdmswap', function(slot,cat)
	TriggerClientEvent('ndrp_pdm:pdmspawn', source , slot, cat)
end, false)

------- DO NOT TOUCH -----

DGCore.RegisterServerCallback('ndrp_pdm:checkmoney', function(source, cb, price)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local price = tonumber(price)
	if money >= price then cb(true) else cb(false) end
end)

DGCore.RegisterServerCallback('ndrp_pdm:isPlateTaken', function(source, cb, plate)
	exports.ghmattimysql:execute('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

DGCore.RegisterServerCallback('ndrp_pdm:checkStock', function(source, cb, model)
	exports.ghmattimysql:execute('SELECT stock FROM cars WHERE model = @model', {
		['@model'] = model
	}, function(result)
		if result[1] == nil then
			cb(false)
		else
			print(result[1])
			cb(result[1])
		end
	end)
end)

DGCore.RegisterServerCallback('ogrp_taxi:isVehicleTaken', function(source, cb, _vname)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local vname = _vname
	if xPlayer ~= nil then
		exports.ghmattimysql:execute('SELECT model FROM owned_vehicles WHERE owner = @owner and model = @model' , {
			['@owner'] = xPlayer.identifier,
			['@model'] = vname
		}, function(result)
			if #result > 0 then
				cb(false)
			else
				cb(true)
			end
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('ndrp_pdm:updateStock')
AddEventHandler('ndrp_pdm:updateStock', function(model)
	
	exports.ghmattimysql:execute('UPDATE cars SET stock = (SELECT stock FROM cars WHERE model = @model)-1 WHERE model=@model',
	{
		['@model'] = model
	}, function(rowsChanged)
	end)
end)

RegisterServerEvent('ndrp_pdm:addStock')
AddEventHandler('ndrp_pdm:addStock', function(model, stock)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local price = stock*carprice[model].price*0.90
	if money >= price then
		xPlayer.removeMoney(price)
		exports.ghmattimysql:execute('UPDATE cars SET stock = (SELECT stock FROM cars WHERE model = @model)+@stock WHERE model=@model',
		{
			['@model'] = model,
			['@stock'] = stock
		}, function(rowsChanged)
			
		end)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You have restocked '..stock..' amount of '..model..'!' })
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have that much money!' })
	end
end)

RegisterServerEvent('ndrp_pdm:buycar')
AddEventHandler('ndrp_pdm:buycar', function(vehicleProps,money,direct,sellerid,buyername,reason,model,amount,commission,slot)
	
	local _slot, type  = slot, 'car'
	
	if _slot == 11 then
		type = 'bot'
	end

	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)
	local buyernam = xPlayer.getName()
	local vehicleProps,money,direct,sellerid,reason,model,amount,commission = vehicleProps,money,direct,sellerid,reason,model,amount,commission
	
	if direct then
		if amount == carprice[model].price then
			exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, ownername, type, pricepaid, totalprice, plate, model, vehicle) VALUES (@owner, @ownername, @type, @pricepaid, @totalprice, @plate, @model, @vehicle)',
			{
				['@vehicle'] = json.encode(vehicleProps),
				['@owner']   = xPlayer.identifier,
				['@ownername'] = buyernam,
				['pricepaid'] = money,
				['totalprice'] = amount,
				['@plate']   = vehicleProps.plate,
				['@model'] = model,
				['@type'] = type

			}, function(rowsChanged)
				xPlayer.removeMoney(money)
				--xPlayer.showNotification("Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
				TriggerClientEvent('dg:showNotification', xPlayer.source, "Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
				TriggerEvent('ndrp_pdm:updateStock', model)
				TriggerEvent('dg_society:addMoney', 'pdm', amount)
				TriggerEvent('pdm:buy',_source,false,buyernam,vehicleProps.plate,model,amount,commission)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Suspicious Activity Detected!' })
		end
	else
		if amount == carprice[model].price then

			local sellerP = DGCore.GetPlayerFromId(sellerid)
			local sellernam = sellerP.getName()

			exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, ownername, type, pricepaid, totalprice, plate, model, vehicle,seller) VALUES (@owner, @ownername, @type, @pricepaid, @totalprice, @plate, @model, @vehicle,@seller)',
			{
				['@vehicle'] = json.encode(vehicleProps),
				['@owner']   = xPlayer.identifier,
				['@ownername'] = buyernam,
				['pricepaid'] = money,
				['totalprice'] = amount,
				['@plate']   = vehicleProps.plate,
				['@model'] = model,
				['@seller'] = sellernam,
				['@type'] = type

			}, function(rowsChanged)
				xPlayer.removeMoney(money)
				--xPlayer.showNotification("Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
				TriggerClientEvent('dg:showNotification', xPlayer.source, "Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
				TriggerEvent('ndrp_pdm:pdmresponse',sellerid,buyernam,1,vehicleProps.plate,model,amount,commission,slot)
				TriggerEvent('ndrp_pdm:updateStock', model)
				TriggerEvent('dg_society:addMoney', 'pdm', amount)
				TriggerEvent('pdm:buy',_source,sellerid,buyernam,vehicleProps.plate,model,amount,commission)
			end)
		else
			TriggerEvent('ndrp_pdm:pdmresponse',sellerid,buyernam,2,0,model,0,0)
		end
	end
end)


RegisterServerEvent('ogrp_pdm:financecar')
AddEventHandler('ogrp_pdm:financecar', function(_vehicleProps,_downpayment,_price,_sellerid,_buyername,_reason,_model,_installments,_interest,_emiprice,_slot)
	
	local vehicleProps,downpayment,price,sellerid,buyername,reason,model,installments,interest,emiprice, slot = _vehicleProps,_downpayment,_price,_sellerid,_buyername,_reason,_model,tonumber(_installments),_interest,_emiprice,_slot
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)
	local sellerP = DGCore.GetPlayerFromId(sellerid)
	local buyernam = xPlayer.getName()
	local sellernam = sellerP.getName()

	exports.ghmattimysql:execute('INSERT INTO owned_vehicles (owner, ownername, emi, emiprice, pricepaid, totalprice, plate, model, vehicle,seller) VALUES (@owner, @ownername, @emi, @emiprice, @pricepaid, @totalprice, @plate, @model, @vehicle, @seller)',
	{
		['@vehicle'] = json.encode(vehicleProps),
		['@owner']   = xPlayer.identifier,
		['@ownername'] = buyername,
		['emi'] = installments,
		['pricepaid'] = downpayment,
		['totalprice'] = price,
		['@plate']   = vehicleProps.plate,
		['@model'] = model,
		['@emiprice'] = emiprice,
		['@seller'] = sellernam

	}, function(rowsChanged)

		xPlayer.removeMoney(downpayment)
		--xPlayer.showNotification("Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
		TriggerClientEvent('dg:showNotification', xPlayer.source, "Vehicle with Plate: " .. vehicleProps.plate .. " now belongs to you")
		TriggerEvent('ndrp_pdm:pdmresponse',sellerid,buyernam,1,vehicleProps.plate,model,carprice[model].price,interest,slot)
		TriggerEvent('pdm:buy',_source,sellerid,buyernam,vehicleProps.plate,model,downpayment,interest)

	end)

end)

RegisterServerEvent('ndrp_pdm:pdmmoney')
AddEventHandler('ndrp_pdm:pdmmoney', function(money)
	local xPlayer = DGCore.GetPlayerFromId(source)
	while xPlayer == nil do
		xPlayer = DGCore.GetPlayerFromId(source)
	end
	xPlayer.addMoney(money)
end)

RegisterServerEvent('ndrp_pdm:pdmsell')
AddEventHandler('ndrp_pdm:pdmsell', function(buyer, commission, model, price, slot)
	local sellerid = source
	local xPlayer = DGCore.GetPlayerFromId(source)
	local xTarget = DGCore.GetPlayerFromId(buyer)
	local seller = xPlayer.getName()
	local buyername = xTarget.getName()
	TriggerClientEvent('ndrp_pdm:buyer',buyer,price,model,seller,commission,sellerid,buyername,slot)
end)

RegisterServerEvent('ogrp_pdm:pdmfinance')
AddEventHandler('ogrp_pdm:pdmfinance', function(buyer, commission, model, price, slot)
	local sellerid = source
	local xPlayer = DGCore.GetPlayerFromId(source)
	local xTarget = DGCore.GetPlayerFromId(buyer)
	local seller = xPlayer.getName()
	local buyername = xTarget.getName()
	TriggerClientEvent('ogrp_pdm:finance',buyer,price,model,seller,commission,sellerid,buyername,slot)
end)

RegisterServerEvent('ndrp_pdm:pdmresponse')
AddEventHandler('ndrp_pdm:pdmresponse', function(sellerid,buyername,reason,plate,model,price,commission)
	TriggerClientEvent('ndrp_pdm:pdmresponse', sellerid ,buyername,reason,plate,model,price,commission)
end)

RegisterServerEvent('ndrp_pdm:givetest')
AddEventHandler('ndrp_pdm:givetest', function(buyer, model,slot)
	TriggerClientEvent('ndrp_pdm:testdrive',buyer,model,slot)
end)

RegisterServerEvent('ndrp_pdm:testdrivemoney')
AddEventHandler('ndrp_pdm:testdrivemoney', function(deducted)
	local xPlayer = DGCore.GetPlayerFromId(source)
	while xPlayer == nil do
		xPlayer = DGCore.GetPlayerFromId(source)
	end
	if deducted then
		xPlayer.removeMoney(1000)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You paid $1000 for test drive' })
	else
		xPlayer.addMoney(1000)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You got back $1000 for returning vehicle' })
	end
end)

carstock = {
	
	['bmx'] = 			{stock = 5},
	['fixter'] = 		{stock = 5},
	['scorcher'] = 		{stock = 5},
	['cruiser'] = 		{stock = 5},		
	['tribike3'] = 		{stock = 5},
	['panto'] = 		{stock = 5},
	['rhapsody'] = 		{stock = 5},
	['blista'] = 		{stock = 5},
	['issi2'] = 		{stock = 5},
	['issi3'] = 		{stock = 5},
	['prairie'] = 		{stock = 5},
	['dilettante'] = 	{stock = 5},
	['brioso'] = 		{stock = 5},
	['sentinel2'] = 	{stock = 5},
	['felon2'] = 		{stock = 5},
	['exemplar'] = 		{stock = 5},
	['f620'] = 			{stock = 5},
	['felon'] = 		{stock = 5},
	['cogcabrio'] = 	{stock = 5},
	['jackal'] = 		{stock = 5},
	['windsor'] = 		{stock = 5},
	['windsor2'] = 		{stock = 5},
	['faggio'] = 		{stock = 5},
	['faggio2'] = 		{stock = 5},
	['sanchez'] = 		{stock = 5},
	['manchez'] = 		{stock = 5},
	['enduro'] = 		{stock = 5},
	['esskey'] = 		{stock = 5},
	['innovation'] = 	{stock = 5},
	['double'] = 		{stock = 5},
	['gargoyle'] = 		{stock = 5},
	['bati'] = 			{stock = 5},
	['carbonrs'] = 		{stock = 5},
	['cliffhanger'] = 	{stock = 5},
	['vindicator'] = 	{stock = 5},
	['daemon2'] = 		{stock = 5},
	['akuma'] = 		{stock = 5},
	['avarus'] = 		{stock = 5},
	['defiler'] = 		{stock = 5},
	['bati2'] = 		{stock = 5},
	['hakuchou'] = 		{stock = 5},
	['vortex'] = 		{stock = 5},
	['ratbike'] = 		{stock = 5},
	['diablous'] = 		{stock = 5},
	['wolfsbane'] = 	{stock = 5},
	['zombieb'] = 		{stock = 5},
	['zombiea'] = 		{stock = 5},
	['fcr2'] = 			{stock = 5},
	['hakuchou2'] = 	{stock = 5},
	['nightblade'] = 	{stock = 5},
	['sanctus'] = 		{stock = 5},
	['diablous2'] = 	{stock = 5},
	['chimera'] = 		{stock = 5},
	['shotaro'] = 		{stock = 5},
	['stalion'] = 		{stock = 5},
	['virgo'] = 		{stock = 5},
	['slamvan'] = 		{stock = 5},
	['tampa'] = 		{stock = 5},
	['chino'] = 		{stock = 5},
	['voodoo'] = 		{stock = 5},
	['gauntlet'] = 		{stock = 5},
	['sabregt'] = 		{stock = 5},
	['dukes'] = 		{stock = 5},
	['dominator'] = 	{stock = 5},
	['slamvan2'] = 		{stock = 5},
	['yosemite'] = 		{stock = 5},
	['lurcher'] = 		{stock = 5},
	['sabregt2'] = 		{stock = 5},
	['buccaneer2'] = 	{stock = 5},
	['hermes'] = 		{stock = 5},
	['ratloader2'] = 	{stock = 5},
	['slamvan3'] = 		{stock = 5},
	['faction2'] = 		{stock = 5},
	['chino2'] = 		{stock = 5},
	['clique'] = 		{stock = 5},
	['ellie'] = 		{stock = 5},
	['faction3'] = 		{stock = 5},
	['coquette3'] = 	{stock = 5},
	['dominator3'] = 	{stock = 5},
    ['nightshade'] = 	{stock = 5},		
	['deviant'] = 		{stock = 5},
	['hustler'] = 		{stock = 5},
	['hotknife'] = 		{stock = 5},
	['blazer3'] = 		{stock = 5},
	['dune'] = 			{stock = 5},
	['blazer4'] = 		{stock = 5},
	['bifta'] = 		{stock = 5},
	['brawler'] = 		{stock = 5},
	['trophytruck2'] = 	{stock = 5},
	['trophytruck'] = 	{stock = 5},
	['bodhi2'] = 		{stock = 5},
	['freecrawler'] = 	{stock = 5},
	['sandking'] = 		{stock = 5},
	['guardian'] = 		{stock = 5},
	['riata'] = 		{stock = 5},
	['kamacho'] = 		{stock = 5},
	['dubsta3'] = 		{stock = 5},
	['tourbus'] = 		{stock = 5},
	['monster'] = 		{stock = 5},
	['emperor'] = 		{stock = 5},
	['ingot'] = 		{stock = 5},
	['asea'] = 			{stock = 5},
	['washington'] = 	{stock = 5},
	['glendale'] = 		{stock = 5},
	['warrener'] = 		{stock = 5},
	['romero'] = 		{stock = 5},
	['intruder'] = 		{stock = 5},
	['primo2'] = 		{stock = 5},
	['fugitive'] = 		{stock = 5},
	['stafford'] = 		{stock = 5},
	['schafter2'] = 	{stock = 5},
	['surge'] = 		{stock = 5},
	['superd'] = 		{stock = 5},
	['cognoscenti'] = 	{stock = 5},
	['stretch'] = 		{stock = 5},		
	['neon'] = 			{stock = 5},
	['khamelion'] = 	{stock = 5},
	['buffalo2'] = 		{stock = 5},
	['sultan'] = 		{stock = 5},
	['raptor'] = 		{stock = 5},
	['elegy2'] = 		{stock = 5},
	['rapidgt2'] = 		{stock = 5},
	['schafter3'] = 	{stock = 5},
	['surano'] = 		{stock = 5},
	['lynx'] = 			{stock = 5},
	['furoregt'] = 		{stock = 5},
	['feltzer2'] = 		{stock = 5},
	['seven7'] = 		{stock = 5},
	['ruston'] = 		{stock = 5},		
	['kuruma'] = 		{stock = 5},
	['alpha'] = 		{stock = 5},
	['banshee'] = 		{stock = 5},
	['bestiagts'] = 	{stock = 5},
	['carbonizzare'] = 	{stock = 5},
	['tampa2'] = 		{stock = 5},
	['jester3'] = 		{stock = 5},
	['elegy'] = 		{stock = 5},
	['specter2'] = 		{stock = 5},
	['coquette'] = 		{stock = 5},
	['mamba'] = 		{stock = 5},
	['jester'] = 		{stock = 5},
	['massacro2'] = 	{stock = 5},
	['schlagen'] = 		{stock = 5},
	['ninef2'] = 		{stock = 5},
	['gb2'] = 			{stock = 5},
	['flashgt'] = 		{stock = 5},
	['jester2'] = 		{stock = 5},
	['omnis'] = 		{stock = 5},
	['streiter'] = 		{stock = 5},
	['verlierer2'] = 	{stock = 5},
	['sentinel3'] = 	{stock = 5},
	['comet5'] = 		{stock = 5},
	['pariah'] = 		{stock = 5},
	['comet3'] = 		{stock = 5},
	['raiden'] = 		{stock = 5},
	['italigto'] = 		{stock = 5},
	['casco'] = 		{stock = 5},
	['monroe'] = 		{stock = 5},
	['peyote'] = 		{stock = 5},
	['tornado5'] = 		{stock = 5},	
	['coquette2'] = 	{stock = 5},
	['retinue'] = 		{stock = 5},
	['z19'] = 			{stock = 5},	
	['btype'] = 		{stock = 5},
	['swinger'] = 		{stock = 5},
	['feltzer3'] = 		{stock = 5},
	['stinger'] = 		{stock = 5},
	['stingergt'] = 	{stock = 5},
	['gt5'] = 			{stock = 5},
	['btype2'] = 		{stock = 5},
	['btype3'] = 		{stock = 5},
	['cheetah2'] = 		{stock = 5},
	['rapidgt3'] = 		{stock = 5},
	['ztype'] = 		{stock = 5},
	['jb7'] = 			{stock = 5},
	['sultanrs'] = 		{stock = 5},
	['infernus'] = 		{stock = 5},
	['sheava'] = 		{stock = 5},
	['gp1'] = 			{stock = 5},
	['cheetah'] = 		{stock = 5},
	['banshee2'] = 		{stock = 5},
	['tyrus'] = 		{stock = 5},
	['turismor'] = 		{stock = 5},
	['penetrator'] = 	{stock = 5},
	['vacca'] = 		{stock = 5},
	['entityxf'] = 		{stock = 5},
	['sc1'] = 			{stock = 5},
	['voltic'] = 		{stock = 5},
	['reaper'] = 		{stock = 5},
	['nero'] = 			{stock = 5},
	['taipan'] = 		{stock = 5},
	['tempesta'] = 		{stock = 5},
	['osiris'] = 		{stock = 5},
	['deveste'] = 		{stock = 5},
	['le7b'] = 			{stock = 5},
	['fmj'] = 			{stock = 5},
	['t20'] = 			{stock = 5},
	['italigtb'] = 		{stock = 5},
	['adder'] = 		{stock = 5},
	['nero2'] = 		{stock = 5},
	['entity2'] = 		{stock = 5},
	['autarch'] = 		{stock = 5},
	['italigtb2'] = 	{stock = 5},
	['cyclone'] = 		{stock = 5},
	['pfister811'] = 	{stock = 5},
	['tyrant'] = 		{stock = 5},
	['visione'] = 		{stock = 5},
	['zentorno'] = 		{stock = 5},
	['xa21'] = 			{stock = 5},
	['tezeract'] = 		{stock = 5},
	['prototipo'] = 	{stock = 5},
	['bjxl'] = 			{stock = 5},
	['mesa'] = 			{stock = 5},
	['granger'] = 		{stock = 5},
	['rocoto'] = 		{stock = 5},
	['fq2'] = 			{stock = 5},
	['huntley'] = 		{stock = 5},
	['dubsta2'] = 		{stock = 5},
	['xls'] = 			{stock = 5},
	['mesa3'] = 		{stock = 5},
	['patriot'] = 		{stock = 5},
	['contender'] = 	{stock = 5},
	['baller3'] = 		{stock = 5},
	['patriot2'] = 		{stock = 5},
	['toros'] = 		{stock = 5},
	['minivan'] = 		{stock = 5},
	['burrito3'] = 		{stock = 5},
	['youga'] = 		{stock = 5},
	['speedo2'] = 		{stock = 5},
	['paradise'] = 		{stock = 5},
	['pony2'] = 		{stock = 5},
	['gburrito2'] = 	{stock = 5},
	['bison'] = 		{stock = 5},
	['gburrito'] = 		{stock = 5},
	['moonbeam2'] = 	{stock = 5},
	['rumpo3'] = 		{stock = 5},
	['seashark'] = 		{stock = 5},
	['seashark2'] = 	{stock = 5},
    ['seashark3'] = 	{stock = 5},
    ['squalo'] = 		{stock = 5},
	['suntrap'] =		{stock = 5},
    ['tropic'] = 		{stock = 5},
    ['tropic2'] = 		{stock = 5},
    ['dinghy'] = 		{stock = 5},
    ['dinghy2'] = 		{stock = 5},
    ['dinghy3'] = 		{stock = 5},
    ['dinghy4'] = 		{stock = 5},
    ['jetmax'] = 		{stock = 5},
    ['speeder'] = 		{stock = 5},
    ['speeder2'] = 		{stock = 5},
    ['toro'] = 			{stock = 5},
	['toro2'] = 		{stock = 5},
	['taxi'] = 			{stock = 5},
	['towtruck'] = 		{stock = 5},
	['towtruck2'] = 	{stock = 5},
	['flatbed'] = 		{stock = 5},
	['vstr'] = 			{stock = 5},
	['zion3'] = 		{stock = 5},
	['retinue'] = 		{stock = 5},
	['neo'] = 			{stock = 5},
	['jugular'] = 		{stock = 5},
	['drafter'] = 		{stock = 5},
	['zorrusso'] = 		{stock = 5},
	['thrax'] = 		{stock = 5},
	['krieger'] = 		{stock = 5},
	['locust'] = 		{stock = 5},
	['issi7'] = 		{stock = 5},
	['paragon'] = 		{stock = 5},
	['furia'] = 		{stock = 5},
	['imorgon'] = 		{stock = 5},
	['komoda'] = 		{stock = 5},
	['kanjo'] = 		{stock = 5},
	['sultan2'] = 		{stock = 5},
	['rebla'] = 		{stock = 5},
	['novak'] = 		{stock = 5},
	['hellion'] = 		{stock = 5},
	['caracara2'] = 	{stock = 5},
	['vagrant'] = 		{stock = 5},
	['gauntlet3'] = 	{stock = 5},
	['peyote2'] = 		{stock = 5},
	['gauntlet4'] = 	{stock = 5},
	['outlaw'] = 		{stock = 5},
	['vagrant'] = 		{stock = 5},
	['alfa65'] = 		{stock = 5},
	['camarozl1'] = 	{stock = 5},
	['mansm8'] = 		{stock = 5},
	['pgtc4'] = 		{stock = 5},
}


carprice = {
	
	['bmx'] = 			{price = 500},
	['fixter'] = 		{price = 700},
	['scorcher'] = 		{price = 1000},
	['cruiser'] = 		{price = 1500},		
	['tribike3'] = 		{price = 2000},
	['panto'] = 		{price = 10000},
	['rhapsody'] = 		{price = 12500},
	['blista'] = 		{price = 10000},
	['issi2'] = 		{price = 15000},
	['issi3'] = 		{price = 12000},
	['prairie'] = 		{price = 12000},
	['dilettante'] = 	{price = 18000},
	['brioso'] = 		{price = 20000},
	['sentinel2'] = 	{price = 35000},
	['felon2'] = 		{price = 40000},
	['exemplar'] = 		{price = 42000},
	['f620'] = 			{price = 43000},
	['felon'] = 		{price = 45000},
	['cogcabrio'] = 	{price = 48000},
	['jackal'] = 		{price = 55000},
	['windsor'] = 		{price = 55000},
	['windsor2'] = 		{price = 70000},
	['faggio'] = 		{price = 1900},
	['faggio2'] = 		{price = 2800},
	['sanchez'] = 		{price = 6500},
	['manchez'] = 		{price = 8000},
	['enduro'] = 		{price = 15500},
	['esskey'] = 		{price = 20000},
	['innovation'] = 	{price = 25500},
	['double'] = 		{price = 30000},
	['gargoyle'] = 		{price = 32000},
	['bati'] = 			{price = 35000},
	['carbonrs'] = 		{price = 35000},
	['cliffhanger'] = 	{price = 35000},
	['vindicator'] = 	{price = 35000},
	['daemon2'] = 		{price = 40000},
	['akuma'] = 		{price = 43000},
	['avarus'] = 		{price = 45000},
	['defiler'] = 		{price = 45000},
	['bati2'] = 		{price = 50000},
	['hakuchou'] = 		{price = 55000},
	['vortex'] = 		{price = 60000},
	['ratbike'] = 		{price = 60000},
	['diablous'] = 		{price = 65000},
	['wolfsbane'] = 	{price = 65000},
	['zombieb'] = 		{price = 70000},
	['zombiea'] = 		{price = 75000},
	['fcr2'] = 			{price = 75000},
	['hakuchou2'] = 	{price = 80000},
	['nightblade'] = 	{price = 85000},
	['sanctus'] = 		{price = 85000},
	['diablous2'] = 	{price = 90000},
	['chimera'] = 		{price = 100000},
	['shotaro'] = 		{price = 150000},
	['stalion'] = 		{price = 20000},
	['virgo'] = 		{price = 22000},
	['slamvan'] = 		{price = 22500},
	['tampa'] = 		{price = 24000},
	['chino'] = 		{price = 25000},
	['voodoo'] = 		{price = 28000},
	['gauntlet'] = 		{price = 30000},
	['sabregt'] = 		{price = 30000},
	['dukes'] = 		{price = 30000},
	['dominator'] = 	{price = 30000},
	['slamvan2'] = 		{price = 30000},
	['yosemite'] = 		{price = 35000},
	['lurcher'] = 		{price = 35000},
	['sabregt2'] = 		{price = 35000},
	['buccaneer2'] = 	{price = 35000},
	['hermes'] = 		{price = 350000},
	['ratloader2'] = 	{price = 35000},
	['slamvan3'] = 		{price = 38000},
	['faction2'] = 		{price = 38000},
	['chino2'] = 		{price = 40000},
	['clique'] = 		{price = 40000},
	['ellie'] = 		{price = 45000},
	['faction3'] = 		{price = 50000},
	['coquette3'] = 	{price = 60000},
	['dominator3'] = 	{price = 65000},
    ['nightshade'] = 	{price = 65000},		
	['deviant'] = 		{price = 70000},
	['hustler'] = 		{price = 105000},
	['hotknife'] = 		{price = 125000},
	['blazer3'] = 		{price = 15000},
	['dune'] = 			{price = 17000},
	['blazer4'] = 		{price = 18000},
	['bifta'] = 		{price = 25000},
	['brawler'] = 		{price = 45000},
	['trophytruck2'] = 	{price = 50000},
	['trophytruck'] = 	{price = 50000},
	['bodhi2'] = 		{price = 50000},
	['freecrawler'] = 	{price = 65000},
	['sandking'] = 		{price = 70000},
	['guardian'] = 		{price = 80000},
	['riata'] = 		{price = 90000},
	['kamacho'] = 		{price = 150000},
	['dubsta3'] = 		{price = 150000},
	['tourbus'] = 		{price = 150000},
	['monster'] = 		{price = 250000},
	['emperor'] = 		{price = 6500},
	['ingot'] = 		{price = 8000},
	['asea'] = 			{price = 10000},
	['washington'] = 	{price = 10000},
	['glendale'] = 		{price = 12000},
	['warrener'] = 		{price = 12500},
	['romero'] = 		{price = 15000},
	['intruder'] = 		{price = 15000},
	['primo2'] = 		{price = 24000},
	['fugitive'] = 		{price = 25000},
	['stafford'] = 		{price = 35000},
	['schafter2'] = 	{price = 45000},
	['surge'] = 		{price = 55000},
	['superd'] = 		{price = 60000},
	['cognoscenti'] = 	{price = 65000},
	['stretch'] = 		{price = 70000},		
	['neon'] = 			{price = 350000},
	['khamelion'] = 	{price = 35000},
	['buffalo2'] = 		{price = 40000},
	['sultan'] = 		{price = 42500},
	['raptor'] = 		{price = 45000},
	['elegy2'] = 		{price = 45000},
	['rapidgt2'] = 		{price = 50000},
	['schafter3'] = 	{price = 50000},
	['surano'] = 		{price = 50000},
	['lynx'] = 			{price = 52000},
	['furoregt'] = 		{price = 55000},
	['feltzer2'] = 		{price = 58500},
	['seven70'] = 		{price = 60000},
	['ruston'] = 		{price = 65000},		
	['kuruma'] = 		{price = 68500},
	['alpha'] = 		{price = 70000},
	['banshee'] = 		{price = 75000},
	['bestiagts'] = 	{price = 70000},
	['carbonizzare'] = 	{price = 70000},
	['tampa2'] = 		{price = 70000},
	['jester3'] = 		{price = 70000},
	['elegy'] = 		{price = 105000},
	['specter2'] = 		{price = 75000},
	['coquette'] = 		{price = 75000},
	['mamba'] = 		{price = 80000},
	['jester'] = 		{price = 80000},
	['massacro2'] = 	{price = 80000},
	['schlagen'] = 		{price = 80000},
	['ninef2'] = 		{price = 80000},
	['gb200'] = 		{price = 85000},
	['flashgt'] = 		{price = 95000},
	['jester2'] = 		{price = 100000},
	['omnis'] = 		{price = 100000},
	['streiter'] = 		{price = 100000},
	['verlierer2'] = 	{price = 120000},
	['sentinel3'] = 	{price = 125000},
	['comet5'] = 		{price = 150000},
	['pariah'] = 		{price = 175000},
	['comet3'] = 		{price = 190000},
	['raiden'] = 		{price = 300000},
	['italigto'] = 		{price = 300000},
	['casco'] = 		{price = 40000},
	['monroe'] = 		{price = 40000},
	['peyote'] = 		{price = 40000},
	['tornado5'] = 		{price = 45000},	
	['coquette2'] = 	{price = 50000},
	['retinue'] = 		{price = 55000},
	['z190'] = 			{price = 60000},	
	['btype'] = 		{price = 60000},
	['swinger'] = 		{price = 60000},
	['feltzer3'] = 		{price = 65000},
	['stinger'] = 		{price = 70000},
	['stingergt'] = 	{price = 75000},
	['gt500'] = 		{price = 78500},
	['btype2'] = 		{price = 150000},
	['btype3'] = 		{price = 95000},
	['cheetah2'] = 		{price = 115000},
	['rapidgt3'] = 		{price = 125000},
	['ztype'] = 		{price = 200000},
	['jb700'] = 		{price = 200000},
	['sultanrs'] = 		{price = 85000},
	['infernus'] = 		{price = 90000},
	['sheava'] = 		{price = 120000},
	['gp1'] = 			{price = 120000},
	['cheetah'] = 		{price = 150000},
	['banshee2'] = 		{price = 175000},
	['tyrus'] = 		{price = 180000},
	['turismor'] = 		{price = 180000},
	['penetrator'] = 	{price = 185000},
	['vacca'] = 		{price = 190000},
	['entityxf'] = 		{price = 200000},
	['sc1'] = 			{price = 200000},
	['voltic'] = 		{price = 200000},
	['reaper'] = 		{price = 220000},
	['nero'] = 			{price = 225000},
	['taipan'] = 		{price = 230000},
	['tempesta'] = 		{price = 235000},
	['osiris'] = 		{price = 235000},
	['deveste'] = 		{price = 240000},
	['le7b'] = 			{price = 240000},
	['fmj'] = 			{price = 250000},
	['t20'] = 			{price = 250000},
	['italigtb'] = 		{price = 250000},
	['adder'] = 		{price = 250000},
	['nero2'] = 		{price = 275000},
	['entity2'] = 		{price = 275000},
	['autarch'] = 		{price = 280000},
	['italigtb2'] = 	{price = 300000},
	['cyclone'] = 		{price = 300000},
	['pfister811'] = 	{price = 300000},
	['tyrant'] = 		{price = 320000},
	['visione'] = 		{price = 350000},
	['zentorno'] = 		{price = 350000},
	['xa21'] = 			{price = 350000},
	['tezeract'] = 		{price = 500000},
	['prototipo'] = 	{price = 550000},
	['bjxl'] = 			{price = 25000},
	['mesa'] = 			{price = 35000},
	['granger'] = 		{price = 35000},
	['rocoto'] = 		{price = 35000},
	['fq2'] = 			{price = 40000},
	['huntley'] = 		{price = 45000},
	['dubsta2'] = 		{price = 50000},
	['xls'] = 			{price = 50000},
	['mesa3'] = 		{price = 50000},
	['patriot'] = 		{price = 50000},
	['contender'] = 	{price = 60000},
	['baller3'] = 		{price = 65000},
	['patriot2'] = 		{price = 65000},
	['toros'] = 		{price = 150000},
	['minivan'] = 		{price = 15000},
	['burrito3'] = 		{price = 25000},
	['youga'] = 		{price = 25000},
	['speedo2'] = 		{price = 25000},
	['paradise'] = 		{price = 25000},
	['pony2'] = 		{price = 28000},
	['gburrito2'] = 	{price = 35000},
	['bison'] = 		{price = 45000},
	['gburrito'] = 		{price = 45000},
	['moonbeam2'] = 	{price = 50000},
	['rumpo3'] = 		{price = 150000},
	['seashark'] = 		{price = 150000},
	['seashark2'] = 	{price = 150000},
    ['seashark3'] = 	{price = 150000},
    ['squalo'] = 		{price = 350000},
	['suntrap'] =		{price = 350000},
    ['tropic'] = 		{price = 450000},
    ['tropic2'] = 		{price = 450000},
    ['dinghy'] = 		{price = 550000},
    ['dinghy2'] = 		{price = 550000},
    ['dinghy3'] = 		{price = 550000},
    ['dinghy4'] = 		{price = 550000},
    ['jetmax'] = 		{price = 650000},
    ['speeder'] = 		{price = 750000},
    ['speeder2'] = 		{price = 750000},
    ['toro'] = 			{price = 900000},
	['toro2'] = 		{price = 900000},
	['taxi'] = 			{price = 3000},
	['towtruck'] = 		{price = 3000},
	['towtruck2'] = 	{price = 2000},
	['flatbed'] = 		{price = 4000},
	['vstr'] = 			{price = 200000},
	['zion3'] = 		{price = 145000},
	['retinue'] = 		{price = 80000},
	['neo'] = 			{price = 240000},
	['jugular'] = 		{price = 260000},
	['drafter'] = 		{price = 250000},
	['zorrusso'] = 		{price = 250000},
	['thrax'] = 		{price = 220000},
	['krieger'] = 		{price = 250000},
	['locust'] = 		{price = 100000},
	['issi7'] = 		{price = 80000},
	['paragon'] = 		{price = 185000},
	['furia'] = 		{price = 400000},
	['imorgon'] = 		{price = 200000},
	['komoda'] = 		{price = 140000},
	['kanjo'] = 		{price = 50000},
	['sultan2'] = 		{price = 70000},
	['rebla'] = 		{price = 150000},
	['novak'] = 		{price = 250000},
	['hellion'] = 		{price = 225000},
	['caracara2'] = 	{price = 250000},
	['vagrant'] = 		{price = 50000},
	['gauntlet3'] = 	{price = 120000},
	['peyote2'] = 		{price = 90000},
	['gauntlet4'] = 	{price = 150000},
	['outlaw'] = 		{price = 100000},
	['vagrant'] = 		{price = 50000},
	['alfa65'] = 		{price = 120000},
	['camarozl1'] = 	{price = 200000},
	['mansm8'] = 		{price = 150000},
	['pgtc4'] = 		{price = 165000},
}