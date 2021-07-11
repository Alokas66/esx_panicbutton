arp = nil
local PlayerData = {}
local alert = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while arp == nil do
		TriggerEvent('esx:getSharedObject', function(obj) arp = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(10000)
	PlayerData = arp.GetPlayerData()
end)

Citizen.CreateThread(function()
	Citizen.Wait(15000)
	while true do
		Citizen.Wait(77)
		if PlayerData.job.name == 'police' then
			if GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == 18 then
				if IsDisabledControlPressed(0, Config.Panicbutton) and not alert then
					local coords = GetEntityCoords(GetPlayerPed(-1))
					TriggerServerEvent('esx_panicbutton:alertcops', coords.x, coords.y, coords.z)
					Citizen.Wait(15000)
					alert = true
				end
			end
			if alert then
				TriggerServerEvent('esx_panicbutton:stopalertcops')
				alert = false
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_panicbutton:removecopblip')
AddEventHandler('esx_panicbutton:removecopblip', function()
	RemoveBlip(copblip)
end)

RegisterNetEvent('esx_panicbutton:setcopblip')
AddEventHandler('esx_panicbutton:setcopblip', function(cx,cy,cz)
	RemoveBlip(copblip)
    copblip = AddBlipForCoord(cx,cy,cz)
    SetBlipSprite(copblip , 161)
    SetBlipScale(copblipy , 1.0)
	SetBlipColour(copblip, 49)
	PulseBlip(copblip)
	arp.ShowNotification(Config.Panicmessage)
end)