DGCore = nil
local Jobs = {}
local RegisteredSocieties = {}

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

function GetSociety(name)
	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})
	for i=1, #result, 1 do
		Jobs[result[i].name]        = result[i]
		Jobs[result[i].name].grades = {}
	end
	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})
	for i=1, #result2, 1 do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
end)

AddEventHandler('dg_society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false
	
	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then table.insert(RegisteredSocieties, society) end
end)

TriggerEvent('dg_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', {})
TriggerEvent('dg_society:registerSociety', 'ems', 'EMS', 'society_ems', 'society_ems', {})
TriggerEvent('dg_society:registerSociety', 'pdm', 'Pdm', 'society_pdm', 'society_pdm', {})
TriggerEvent('dg_society:registerSociety', 'news', 'News', 'society_news', 'society_news', {})
TriggerEvent('dg_society:registerSociety', 'recycle', 'Recycle', 'society_recycle', 'society_recycle', {})
TriggerEvent('dg_society:registerSociety', 'bestbuds', 'Bestbuds', 'society_bestbuds', 'society_bestbuds', {})
TriggerEvent('dg_society:registerSociety', 'mcd', 'Burgershot', 'society_burgershot', 'society_burgershot', {})
TriggerEvent('dg_society:registerSociety', 'beanmachine', 'Beanmachine', 'society_beanmachine', 'society_beanmachine', {})

AddEventHandler('dg_society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('dg_society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

RegisterServerEvent('dg_society:withdrawMoney')
AddEventHandler('dg_society:withdrawMoney', function(_society, amount)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local society = GetSociety(_society)
	amount = DGCore.Math.Round(tonumber(amount))

	if xPlayer.job.name == society.name then
		TriggerEvent('dg_addonaccount:getSharedAccount', society.account, function(account)
			if amount > 0 and account.money >= amount then
				account.removeMoney(amount)
				xPlayer.addMoney(amount)

				xPlayer.showNotification('You have withdrawn $ '..DGCore.Math.GroupDigits(amount)..' from the society fund.')
			else
				xPlayer.showNotification('Invalid Amount')
			end
		end)
	else
		print(('dg_society: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('dg_society:addMoney')
AddEventHandler('dg_society:addMoney', function(_society, amount)
	local society = GetSociety(_society)
	amount = DGCore.Math.Round(tonumber(amount))
	if amount > 0 then
		TriggerEvent('dg_addonaccount:getSharedAccount', society.account, function(account)
			account.addMoney(amount)
		end)
	end
end)

RegisterServerEvent('dg_society:depositMoney')
AddEventHandler('dg_society:depositMoney', function(_society, amount)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local society = GetSociety(_society)
	amount = DGCore.Math.Round(tonumber(amount))
	if xPlayer.job.name == society.name then
		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('dg_addonaccount:getSharedAccount', society.account, function(account)
				xPlayer.removeMoney(amount)
				account.addMoney(amount)
			end)

			xPlayer.showNotification('You have deposited $ '..DGCore.Math.GroupDigits(amount)..' to the society fund.')
		else
			xPlayer.showNotification('Invalid Amount')
		end
	else
		print(('dg_society: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	end
end)

DGCore.RegisterServerCallback('dg_society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)
	if society then
		TriggerEvent('dg_addonaccount:getSharedAccount', society.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

DGCore.RegisterServerCallback('dg_society:getEmployees', function(source, cb, society)
	if society == 'police' or society == 'ems' then

		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job OR job = @offjob ORDER BY job_grade DESC', {
			['@job'] = society,
			['@offjob'] = 'off'..society
		}, function (results)
			local employees = {}
			for i=1, #results, 1 do
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
					}
				})
			end
			cb(employees)
		end)

	else
		
		MySQL.Async.fetchAll('SELECT firstname, lastname, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = society
		}, function (results)
			local employees = {}
			for i=1, #results, 1 do
				table.insert(employees, {
					name       = results[i].firstname .. ' ' .. results[i].lastname,
					identifier = results[i].identifier,
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
					}
				})
			end
			cb(employees)
		end)

	end
end)

DGCore.RegisterServerCallback('dg_society:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}
	
	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades
	cb(job)
end)

DGCore.RegisterServerCallback('dg_society:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = DGCore.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'
	if isBoss then
		local xTarget = DGCore.GetPlayerFromIdentifier(identifier)
		if xTarget then
			xTarget.setJob(job, grade)
			if type == 'hire' then
				xTarget.showNotification('You have been hired by '.. job .. ' | Rank: '..grade)
			elseif type == 'promote' then
				xTarget.showNotification('You have been promoted | Rank: ' ..grade)
			elseif type == 'fire' then
				xTarget.showNotification('You have been fired from '..xTarget.getJob().label)
			end
			cb()
		else
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('dg_society: %s attempted to setJob'):format(xPlayer.identifier))
		cb()
	end
end)

DGCore.RegisterServerCallback('dg_society:getOnlinePlayers', function(source, cb)
	local xPlayers = DGCore.GetPlayers()
	local players  = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = DGCore.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			job        = xPlayer.job
		})
	end
	cb(players)
end)

DGCore.RegisterServerCallback('dg_society:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)

function isPlayerBoss(playerId, job)
	local xPlayer = DGCore.GetPlayerFromId(playerId)
	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then
		return true
	else
		print(('dg_society: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end

RegisterServerEvent('dg:updateAmmoCount')
AddEventHandler('dg:updateAmmoCount', function(data)
	
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer ~= nil then

		local owner = xPlayer.identifier
		local allammo = json.encode(data)
		
		exports.ghmattimysql:execute('UPDATE og_base SET ammo = @ammo WHERE identifier = @identifier', {
			['@ammo'] = allammo,
			['@identifier'] = owner,
		})

		exports.ghmattimysql:execute('SELECT * FROM og_base WHERE identifier = @identifier', {
			['@identifier'] = owner,
		}, function(results)
			if #results == 0 then
			else
				TriggerClientEvent('updateAllAmmo', _source, json.decode(results[1].ammo))
			end
		end)
		
	end

end)

RegisterServerEvent('dg:getAmmoData')
AddEventHandler('dg:getAmmoData', function()
	local _source = source
	local xPlayer = DGCore.GetPlayerFromId(source)
	if xPlayer ~= nil then
		local owner = xPlayer.identifier
		exports.ghmattimysql:execute('SELECT * FROM og_base WHERE identifier = @identifier', {
			['@identifier'] = owner,
		}, function(results)
			if #results == 0 then
			else
				TriggerClientEvent('updateAllAmmo', _source, json.decode(results[1].ammo))
			end
		end)
	end
end)