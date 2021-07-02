DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

function AddLicense(target, type, cb)
	local xPlayer = DGCore.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
			['@type']  = type,
			['@owner'] = xPlayer.identifier
		}, function(rowsChanged)
			if cb then
				cb()
			end
		end)
	else
		if cb then
			cb()
		end
	end
end

function RemoveLicense(target, type, cb)
	local xPlayer = DGCore.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type'] = type,
			['@owner'] = xPlayer.identifier
		}, function(rowsChanged)
			if cb then
				cb()
			end
		end)
	else
		if cb then
			cb()
		end
	end
end

function GetLicense(type, cb)
	MySQL.Async.fetchAll('SELECT label FROM licenses WHERE type = @type', {
		['@type'] = type
	}, function(result)
		local data = {
			type  = type,
			label = result[1].label
		}

		cb(data)
	end)
end

function GetLicenses(target, cb)
	local xPlayer = DGCore.GetPlayerFromId(target)

	exports.ghmattimysql:execute('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		if #result ~= 0 then
			local licenses = {}
			for i=1, #result, 1 do
				table.insert(licenses, {
					type  = result[1].type,
					label = ''.. result[1].type .. ' License'
				})
			end
			cb(licenses)
		else
			cb({})
		end
	end)

end

function CheckLicense(target, type, cb)
	local xPlayer = DGCore.GetPlayerFromId(target)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
			['@type'] = type,
			['@owner'] = xPlayer.identifier
		}, function(result)
			if tonumber(result[1].count) > 0 then
				cb(true)
			else
				cb(false)
			end
		end)
	else
		cb(false)
	end
end

function GetLicensesList(cb)
	MySQL.Async.fetchAll('SELECT type, label FROM licenses', {
		['@type'] = type
	}, function(result)
		local licenses = {}

		for i=1, #result, 1 do
			table.insert(licenses, {
				type  = result[i].type,
				label = result[i].label
			})
		end

		cb(licenses)
	end)
end

RegisterNetEvent('dg_license:addLicense')
AddEventHandler('dg_license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

RegisterNetEvent('dg_license:removeLicense')
AddEventHandler('dg_license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

AddEventHandler('dg_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('dg_license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler('dg_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('dg_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)

DGCore.RegisterServerCallback('dg_license:getLicense', function(source, cb, type)
	GetLicense(type, cb)
end)

DGCore.RegisterServerCallback('dg_license:getLicenses', function(source, cb, target)
	GetLicenses(target, cb)
end)

DGCore.RegisterServerCallback('dg_license:checkLicense', function(source, cb, target, type)
	CheckLicense(target, type, cb)
end)

DGCore.RegisterServerCallback('dg_license:getLicensesList', function(source, cb)
	GetLicensesList(cb)
end)

DGCore.RegisterServerCallback('dg:buyGunLicense', function(source, cb)
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 1500 then
		xPlayer.removeMoney(1500)
		TriggerEvent('dg_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		DGCore.showNotification('You don\'t have enough money')
		cb(false)
	end
end)