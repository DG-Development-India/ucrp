DGCore = nil
local PhoneNumbers = {}

-- PhoneNumbers = {
--   ambulance = {
--     type  = "ambulance",
--     sources = {
--        ['1'] = true
--     }
--   }
-- }

TriggerEvent('dg:getSharedObject', function(obj)
  DGCore = obj
end)

function notifyAlertSMS (number, alert, listSrc)
  if PhoneNumbers[number] ~= nil then
	local mess = 'De #' .. alert.numero  .. ' : ' .. alert.message
	if alert.coords ~= nil then
		mess = mess .. ' ' .. alert.coords.x .. ', ' .. alert.coords.y 
	end
    for k, _ in pairs(listSrc) do
      getPhoneNumber(tonumber(k), function (n)
        if n ~= nil then
          TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, function (smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
          end)
        end
      end)
    end
  end
end

AddEventHandler('dg_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
  print('= INFO = Enregistrement du telephone ' .. number .. ' => ' .. type)
	local hideNumber    = hideNumber    or false
	local hidePosIfAnon = hidePosIfAnon or false

PhoneNumbers[number] = {
    type          = type,
    sources       = {},
    alerts        = {}
}
end)

AddEventHandler('dg:setJob', function(source, job, lastJob)
  if PhoneNumbers[lastJob.name] ~= nil then
    TriggerEvent('dg_addons_gcphone:removeSource', lastJob.name, source)
  end

  if PhoneNumbers[job.name] ~= nil then
    TriggerEvent('dg_addons_gcphone:addSource', job.name, source)
  end
end)

AddEventHandler('dg_addons_gcphone:addSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = true
end)

AddEventHandler('dg_addons_gcphone:removeSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = nil
end)

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(number, message)
    local sourcePlayer = tonumber(source)
    if PhoneNumbers[number] ~= nil then
      getPhoneNumber(source, function (phone) 
        notifyAlertSMS(number, {
          message = message,
          numero = phone,
        }, PhoneNumbers[number].sources)
      end)
    end
end)

RegisterServerEvent('dg_addons_gcphone:startCall')
AddEventHandler('dg_addons_gcphone:startCall', function (number, message, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone) 
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    print('= WARNING = Appels sur un service non enregistre => numero : ' .. number)
  end
end)

AddEventHandler('dg:playerLoaded', function(source)
  local xPlayer = DGCore.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)

    local phoneNumber = result[1].phone_number
    xPlayer.set('phoneNumber', phoneNumber)

    if PhoneNumbers[xPlayer.job.name] ~= nil then
      TriggerEvent('dg_addons_gcphone:addSource', xPlayer.job.name, source)
    end
  end)
end)

AddEventHandler('dg:playerDropped', function(source)
  local source = source
  local xPlayer = DGCore.GetPlayerFromId(source)
  if PhoneNumbers[xPlayer.job.name] ~= nil then
    TriggerEvent('dg_addons_gcphone:removeSource', xPlayer.job.name, source)
  end
end)

function getPhoneNumber (source, callback) 
  local xPlayer = DGCore.GetPlayerFromId(source)
  if xPlayer == nil then
    callback(nil)
  end
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)
    callback(result[1].phone_number)
  end)
end

RegisterServerEvent('dg_phone:send')
AddEventHandler('dg_phone:send', function(number, message, _, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone) 
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    -- print('dg_phone:send | Appels sur un service non enregistre => numero : ' .. number)
  end
end)
