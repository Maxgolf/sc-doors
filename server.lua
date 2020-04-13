ESX = nil
local doorState = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sc-doors:updateState')
AddEventHandler('sc-doors:updateState', function(doorIndex, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and type(doorIndex) == 'number' and type(state) == 'boolean' and Config.DoorList[doorIndex] and isAuthorized(xPlayer.job.name, Config.DoorList[doorIndex]) then
		doorState[doorIndex] = state
		TriggerClientEvent('sc-doors:setDoorState', -1, doorIndex, state)
	end
end)

ESX.RegisterServerCallback('sc-doors:getDoorState', function(source, cb)
	cb(doorState)
end)

function isAuthorized(jobName, doorObject)
	for k,job in pairs(doorObject.authorizedJobs) do
		if job == jobName then
			return true
		end
	end

	return false
end