DGCore = nil
TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
local caller = 

RegisterServerEvent('dg_emHelp:911')
AddEventHandler('dg_emHelp:911', function(targetCoords, msg, streetName)
	local _source = source
	local _msg = msg
	local _coords = targetCoords
	local _streetName = streetName
	TriggerClientEvent('dg_emHelp:show911',-1,_source,_msg,_streetName,_coords)
end)

RegisterServerEvent('dg_emHelp:311')
AddEventHandler('dg_emHelp:311', function(targetCoords, msg, streetName)
	local _source = source
	local _msg = msg
	local _coords = targetCoords
	local _streetName = streetName
	TriggerClientEvent('dg_emHelp:show311',-1,_source,_msg,_streetName,_coords)
end)

RegisterServerEvent('dg_trHelp:code3p')
AddEventHandler('dg_trHelp:code3p', function(targetCoords, msg, streetName)
	local _source = source
	local _msg = msg
	local _coords = targetCoords
	local _streetName = streetName
	TriggerClientEvent('dg_trHelp:showcode3p',-1,_source,_msg,_streetName,_coords)
end)

RegisterServerEvent('dg_emHelp:respond')
AddEventHandler('dg_emHelp:respond', function(callType, target, msg )
	TriggerClientEvent('dg_emHelp:showResponser',-1,target, source, callType, msg)
	TriggerClientEvent('dg_emHelp:showResponse',target,callType, msg)
end)