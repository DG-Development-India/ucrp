local JobCount = {}


Citizen.CreateThread(function()
    while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
	while DGCore.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = DGCore.GetPlayerData()
end)

RegisterNetEvent('dg:setJob')
AddEventHandler('dg:setJob', function(job)
	PlayerData.job = job
	TriggerServerEvent('dg-jobnumbers:setjobs', job)
end)

RegisterNetEvent('dg:playerLoaded')
AddEventHandler('dg:playerLoaded', function(xPlayer)
    TriggerServerEvent('dg-jobnumbers:setjobs', xPlayer.job)
end)


RegisterNetEvent('dg-jobnumbers:setjobs')
AddEventHandler('dg-jobnumbers:setjobs', function(jobslist)
   JobCount = jobslist
end)

function jobonline(joblist)
    for i,v in pairs(Config.MultiNameJobs) do
        for u,c in pairs(v) do
            if c == joblist then
                joblist = i
            end
        end
    end

    local amount = 0
    local job = joblist
    if JobCount[job] ~= nil then
        amount = JobCount[job]
    end

    return amount
end


