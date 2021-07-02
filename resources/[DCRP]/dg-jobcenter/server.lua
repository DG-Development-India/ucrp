
DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(job)
	local xPlayer = DGCore.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.setJob(job, 0)
    end
    
end)