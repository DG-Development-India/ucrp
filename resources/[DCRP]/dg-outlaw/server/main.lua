DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('ndrp_outlawalert:carJackInProgress')
AddEventHandler('ndrp_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender,steal)
	local playerGender = 'Someone'
	mytype = 'police'
	if steal ~= nil then 
		data = {["type"] = "carjack", ["icon"] = "fas fa-car", ["code"] = '10-60', ["name"] = '  ' .. playerGender .. ' is stealing a car!', ["veh"] = vehicleLabel, ["loc"] = streetName}
	else
		data = {["type"] = "carjack", ["icon"] = "fas fa-car", ["code"] = '10-60', ["name"] = '  ' .. playerGender .. ' is hotwiring a car!', ["veh"] = vehicleLabel, ["loc"] = streetName}
	end
	TriggerClientEvent('ndrp_outlawalert:outlawNotify', -1, mytype, data)
	TriggerClientEvent('ndrp_outlawalert:carJackInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('ndrp_outlawalert:carTheftInProgress')
AddEventHandler('ndrp_outlawalert:carTheftInProgress', function(targetCoords, streetName, vehicleLabel, playerGender,steal)
	local playerGender = 'Someone'
	mytype = 'police'
	if steal ~= nil then 
		data = {["type"] = "carjack", ["icon"] = "fas fa-car", ["code"] = '10-60', ["name"] = '  ' .. playerGender .. ' is stealing a car!', ["loc"] = streetName}
	else
		data = {["type"] = "carjack", ["icon"] = "fas fa-car", ["code"] = '10-60', ["name"] = '  ' .. playerGender .. ' is Thefting a car!', ["loc"] = streetName}
	end
	TriggerClientEvent('ndrp_outlawalert:outlawNotify', -1, mytype, data)
	TriggerClientEvent('ndrp_outlawalert:carTheftInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('ndrp_outlawalert:gunshotInProgress')
AddEventHandler('ndrp_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	local playerGender = 'Someone'
	mytype = 'police'
	data = {["type"] = "red", ["icon"] = "fas fa-crosshairs", ["code"] = '10-71', ["name"] = '  Reports of gunshots!', ["loc"] = streetName}
	TriggerClientEvent('ndrp_outlawalert:outlawNotify', -1, mytype, data)
	TriggerClientEvent('ndrp_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('ndrp_outlawalert:custom')
AddEventHandler('ndrp_outlawalert:custom', function(targetCoords, playerGender, type, icon, code, title, streetName, blipx)
	local playerGender = 'Someone'
	if (icon == nil) then
		icon = "fas fa-map-marker-alt"
	end
	mytype = 'police'
	data = {["type"] = type, ["icon"] = icon, ["code"] = code, ["name"] = title, ["loc"] = streetName}
	TriggerClientEvent('ndrp_outlawalert:outlawNotify', -1, mytype, data)
	TriggerClientEvent('ndrp_outlawalert:custom', -1, targetCoords, blipx)
end, false)

