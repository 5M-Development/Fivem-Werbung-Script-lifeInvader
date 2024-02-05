local lifeInvaderLoc = vector3(Config.lifeInvaderLoc)
local isNearLifeInvader = false

Citizen.CreateThread(function()
    while true do
        DrawMarker(32, lifeInvaderLoc.x, lifeInvaderLoc.y, lifeInvaderLoc.z - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 40, 40, 40, false, false, 2, false, false, false, false)

        if isNearLifeInvader then
            showInfobar(Config.MenuTitel)
            if IsControlJustReleased(0, 38) then
                local input = CreateDialog('')
                if input then
                    TriggerServerEvent('lifeinv:buyAd', input)
                end
            end
        end

        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local dist = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, lifeInvaderLoc.x, lifeInvaderLoc.y, lifeInvaderLoc.z)

        isNearLifeInvader = dist < 1.5

        Citizen.Wait(100)
    end
end)

RegisterNetEvent('lifeinv:sendAd')
AddEventHandler('lifeinv:sendAd', function(text)
    showPictureNotification(Config.Icon, text, Config.Titel, '')
end)

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    SetNotificationMessage(icon, icon, true, 1, title, subtitle)
    DrawNotification(false, true)
end

function showInfobar(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function CreateDialog(OnScreenDisplayTitle_shopmenu)
    AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
    DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "Werbung", "", "", "", "", 100)

    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end

    if GetOnscreenKeyboardResult() then
        local displayResult = GetOnscreenKeyboardResult()
        return displayResult
    end
end