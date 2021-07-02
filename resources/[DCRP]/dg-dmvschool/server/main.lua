DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

AddEventHandler('dg:playerLoaded', function(source)
	TriggerEvent('dg-license:getLicenses', source, function(licenses)
		TriggerClientEvent('dg-dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('dg-dmvschool:addLicense')
AddEventHandler('dg-dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('dg-license:addLicense', _source, type, function()
		TriggerEvent('dg-license:getLicenses', _source, function(licenses)
			TriggerClientEvent('dg-dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterNetEvent('dg-dmvschool:pay')
AddEventHandler('dg-dmvschool:pay', function(price)
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('DoLongHudText', _source, 'You paid $'.. DGCore.Math.GroupDigits(price) .. ' to the DMV school', 1)
end)
