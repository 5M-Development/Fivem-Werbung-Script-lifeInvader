ESX = nil
ESX = exports["es_extended"]:getSharedObject()
RegisterServerEvent('lifeinv:buyAd')
AddEventHandler('lifeinv:buyAd', function(adtext)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local requiredItem = Config.IdCard
    print(('Spieler %s versucht, eine Anzeige mit dem Text %s zu kaufen'):format(source, adtext))
    if xPlayer and xPlayer.getInventoryItem(requiredItem).count > 0 then
        xPlayer.removeInventoryItem(requiredItem, 1)
        TriggerClientEvent('lifeinv:sendAd', -1, adtext)
        print(('Spieler %s versucht, eine Anzeige mit dem Text %s zu kaufen'):format(source))
    else
        TriggerClientEvent('esx:showNotification', source, Config.TextKeinIdCard)
        print(('Fehler: Spieler %s hat nicht das erforderliche Item.'):format(source))
    end
end)