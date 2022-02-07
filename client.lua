blipTime = 300
blipRadius = 10.0
local isDead = false

RegisterCommand('ambulanza', function(source, args)   
	if not isDead then
		TriggerEvent('pnpNotify:send', '<b><span style="color: #8707CC;">Ospedale di Sigma</span></b> </br>' .. 'Puoi usare questo comando solo da morto.')
	else
		local name = GetPlayerName(PlayerId())
		local ped = GetPlayerPed(PlayerId())
		local x, y, z = table.unpack(GetEntityCoords(ped, true))
		local street = GetStreetNameAtCoord(x, y, z)
		local location = GetStreetNameFromHashKey(street)
		local msg = table.concat(args, ' ')
		TriggerServerEvent('call911', location, msg, x, y, z, name)
	end
end)

RegisterNetEvent('setBlip')
AddEventHandler('setBlip', function(name, x, y, z)
	blips = {}
    local blipsVisible= false
    while true do
      	blip = nil
		local blip = AddBlipForRadius(x, y, z, blipRadius)
   	 	SetBlipSprite(blip , 161)
    	SetBlipScale(blip , 0.8)
		SetBlipColour(blip, 8)
		PulseBlip(blip)
		local blip1 = AddBlipForCoord(x, y, z)
   	 	SetBlipSprite(blip1 , 161)
    	SetBlipScale(blip1 , 0.8)
		SetBlipColour(blip1, 8)
		PulseBlip(blip1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Ambulanza Richiesta - " .. name)
    	EndTextCommandSetBlipName(blip1)
    	table.insert(blips, blip1)
    	Wait(blipTime * 1000)
    	for i, blip1 in pairs(blips) do 
       		RemoveBlip(blip)
        	RemoveBlip(blip1)
    	end
	end
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)



