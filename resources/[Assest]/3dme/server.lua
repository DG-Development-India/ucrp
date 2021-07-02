--local logEnabled = false

DGCore = nil

TriggerEvent('dg:getSharedObject', function(obj) DGCore = obj end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	--TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	TriggerClientEvent('Do3DText', -1, text, source)
	local name = GetPlayerName(source)
	TriggerEvent('me:logging', source, name, text)
	-- if logEnabled then
	-- 	setLog(text, source)
	-- end
end)

-- function setLog(text, source)
-- 	local time = os.date("%d/%m/%Y %X")
-- 	local name = GetPlayerName(source)
-- 	local identifier = GetPlayerIdentifiers(source)
-- 	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

-- 	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
-- 	local newContent = content .. '\r\n' .. data
-- 	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
-- end
