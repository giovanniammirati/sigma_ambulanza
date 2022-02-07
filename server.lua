ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('call911')
AddEventHandler('call911', function(location, msg, x, y, z, name, p)
	local source = source
	local pName = GetPlayerName(source)
	local p = GetPlayerPed(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('setBlip', -1, name, x, y, z)
			TriggerClientEvent('pnpNotify:send', -1, '<b><span style="color: #8707CC;">Ambulanza richiesta!</span></b> </br>' .. 'Guarda la mappa per la posizione')
		end
	end
		TriggerClientEvent('pnpNotify:send', -1, '<b><span style="color: #8707CC;">Ospedale di Sigma</span></b> </br>' .. 'Abbiamo inviato una richiesta di supporto a tutte le unità.')
end)
	
