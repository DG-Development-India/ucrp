DGCore = nil

Citizen.CreateThread(function()
	while DGCore == nil do
		TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('dg:playerLoaded', function (source)
	GetLicenses(source)
	TriggerEvent("playerSpawned")
end)

function GetLicenses(source)
    TriggerEvent('dg_license:getLicenses', source, function (licenses)
        TriggerClientEvent('suku:GetLicenses', source, licenses)
    end)
end


--RegisterServerEvent('cash:remove')
--AddEventHandler('cash:remove', function(source, cash)
--    local src = source
	--local xPlayer = DGCore.GetPlayerFromId(src)
	--if xPlayer.getMoney() >= cash then
        --xPlayer.removeMoney(cash)
        --TriggerClientEvent('isPed:UpdateCash', source, xPlayer.getMoney())
	--end
--end)

RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local xPlayer = DGCore.GetPlayerFromId(target)
    local identifier = xPlayer.identifier
	TriggerClientEvent("server-inventory-open", source, "1", identifier)
end)

RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
	local quality = data.quality
	local slot = data.slot
	local itemid = data.item_id
    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {['quality'] = quality, ['name'] = player, ['slot'] = slot, ['item_id'] = itemid})
end)

RegisterServerEvent('police:SeizeCash')
AddEventHandler('police:SeizeCash', function(target)
    local src = source
    local xPlayer = DGCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = DGCore.GetPlayerFromId(target)
    if not xPlayer.job.name == 'police' then
        print('steam:'..identifier..' User attempted sieze cash')
        return
    end
    TriggerClientEvent("banking:addBalance", src, zPlayer.getMoney())
    TriggerClientEvent("banking:removeBalance", target, zPlayer.getMoney())
    zPlayer.setMoney(0)
    TriggerClientEvent('notification', target, 'Your cash was seized',1)
    TriggerClientEvent('notification', src, 'Seized persons cash', 1)
end)

RegisterServerEvent('Stealtheybread')
AddEventHandler('Stealtheybread', function(target)
    local src = source
    local xPlayer = DGCore.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local zPlayer = DGCore.GetPlayerFromId(target)
    if not xPlayer.job.name == 'police' then
        print('steam:'..identifier..' User attempted sieze cash')
        return
    end
    TriggerClientEvent("banking:addBalance", src, zPlayer.getMoney())
    TriggerClientEvent("banking:removeBalance", target, zPlayer.getMoney())
    xPlayer.addMoney(zPlayer.getMoney())
    zPlayer.setMoney(0)
    TriggerClientEvent('notification', target, 'Your cash was robbed off you.', 1)
end)

RegisterServerEvent('inv:addItem')
AddEventHandler('inv:addItem', function(target,item,count)
    TriggerClientEvent('player:receiveItem', target, item, count)
end)