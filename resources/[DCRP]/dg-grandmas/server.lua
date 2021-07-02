DGCore             = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('mythic_hospital:server:HealSomeShit')
AddEventHandler('mythic_hospital:server:HealSomeShit', function()
    local src = source

	-- YOU NEED TO IMPLEMENT YOUR FRAMEWORKS BILLING HERE
	local xPlayer = DGCore.GetPlayerFromId(src)
	xPlayer.removeBank(2000)
        TriggerClientEvent('dg:showNotification', src, '~w~You Were Billed For ~r~$2,000 ~w~For Medical Services & Expenses')
end)