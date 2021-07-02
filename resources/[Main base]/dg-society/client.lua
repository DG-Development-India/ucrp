DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
	while DGCore.GetPlayerData().job == nil do Citizen.Wait(10) end
	DGCore.PlayerData = DGCore.GetPlayerData()
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	DGCore.PlayerData.job = job
end)

function OpenBossMenu(_society)
	local society = _society
	local isBoss = nil
	local options  = options or {}
	local elements = {}
	

	DGCore.TriggerServerCallback('dg_society:isBoss', function(result)
		isBoss = result
	end, _society)

	while isBoss == nil do Citizen.Wait(100) end
	if not isBoss then return end

	local defaultOptions = {
		check = true,
		withdraw  = true,
		deposit   = true,
		employees = true,
	}

	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.check then
		table.insert(elements, {label = 'Check Society Money', value = 'check_society_money'})
	end

	if options.withdraw then
		table.insert(elements, {label = 'Withdraw Money', value = 'withdraw_society_money'})
	end

	if options.deposit then
		table.insert(elements, {label = 'Deposit Money', value = 'deposit_money'})
	end

	if options.employees then
		table.insert(elements, {label = 'Manage Employees', value = 'manage_employees'})
	end

	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. _society, {
		title    = 'Boss Menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'check_society_money' then
			DGCore.TriggerServerCallback('dg_society:getSocietyMoney', function(money)
				_money = money
				menu.close()
				exports['mythic_notify']:SendAlert('inform', 'Total society money: $ '.._money..'', 5000)
			end, _society)

		elseif data.current.value == 'withdraw_society_money' then
			DGCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. _society, {
				title = 'Withdraw money'
			}, function(data, menu)
				local amount = tonumber(data.value)
				if amount == nil then
					DGCore.ShowNotification('Invalid Amount')
				else
					menu.close()
					TriggerServerEvent('dg_society:withdrawMoney', _society, amount)
				end
			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'deposit_money' then
			
			DGCore.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. _society, {
				title = 'Deposit Money'
			}, function(data, menu)
				local amount = tonumber(data.value)
				if amount == nil then
					DGCore.ShowNotification('Invalid Amount')
				else
					menu.close()
					TriggerServerEvent('dg_society:depositMoney', _society, amount)
				end
			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'manage_employees' then
			OpenManageEmployeesMenu(_society)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenManageEmployeesMenu(society)

	DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
		title    = 'Manage Employees',
		align    = 'top-left',
		elements = {
			{label = 'Employees List', value = 'employee_list'},
			{label = 'Recruit',       value = 'recruit'}
		}
	}, function(data, menu)

		if data.current.value == 'employee_list' then
			OpenEmployeeList(society)
		end

		if data.current.value == 'recruit' then
			OpenRecruitMenu(society)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenEmployeeList(society)
	
	DGCore.TriggerServerCallback('dg_society:getEmployees', function(employees)
		
		local elements = {
			head = {'Name', 'Grade', 'Action'},
			rows = {}
		}

		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)
			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{promote|promote}} {{fire|fire}}'
				}
			})
		end

		DGCore.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			
			local employee = data.data
			
			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				DGCore.ShowNotification('You\'ve Fired '..employee.name)
				DGCore.TriggerServerCallback('dg_society:setJob', function()
					OpenEmployeeList(society)
				end, employee.identifier, 'unemployed', 0, 'fire')
			end

		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(society)
		end)
	end, society)
end

function OpenRecruitMenu(society)
	
	DGCore.TriggerServerCallback('dg_society:getOnlinePlayers', function(players)
		
		local elements = {}
		for i=1, #players, 1 do
			if players[i].job.name ~= society then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					identifier = players[i].identifier
				})
			end
		end

		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. society, {
			title    = 'Recruiting',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
				title    = 'Do you want to recruit ' ..data.current.name,
				align    = 'top-left',
				elements = {
					{label = 'No',  value = 'no'},
					{label = 'Yes', value = 'yes'}
				}
			}, function(data2, menu2)
				menu2.close()
				if data2.current.value == 'yes' then
					DGCore.ShowNotification('You\'ve hired '..data.current.name)
					DGCore.TriggerServerCallback('dg_society:setJob', function()
						OpenRecruitMenu(society)
					end, data.current.identifier, society, 0, 'hire')
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenPromoteMenu(society, employee)
	DGCore.TriggerServerCallback('dg_society:getJob', function(job)
		
		local elements = {}
		
		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)
			table.insert(elements, {
				label = gradeLabel,
				value = job.grades[i].grade,
				selected = (employee.job.grade == job.grades[i].grade)
			})
		end

		DGCore.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = 'Promote ' .. employee.name .. ' ?',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()
			DGCore.ShowNotification('You have promoted ' .. employee.name .. ' to ' ..data.current.label)
			DGCore.TriggerServerCallback('dg_society:setJob', function()
				OpenEmployeeList(society)
			end, employee.identifier, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(society)
		end)
	end, society)
end

AddEventHandler('dg_society:openBossMenu', function(society)
	OpenBossMenu(society)
end)