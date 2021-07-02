AddEventHandler('dg:getSharedObject', function(cb)
	cb(DGCore)
end)

function getSharedObject()
	return DGCore
end
