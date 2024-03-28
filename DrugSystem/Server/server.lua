RegisterNetEvent("buongiornodev:daiitemprocesso")
AddEventHandler("buongiornodev:daiitemprocesso", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    exports.ox_inventory:RemoveItem(ID, droga.itemDaRaccogliere, droga.quantitaProcesso)
    exports.ox_inventory:AddItem(ID, droga.itemProcessato, droga.quantitaProcessoFrutto)
    TriggerClientEvent('esx:showNotification', ID, 'Droga processata con successo')
end)

RegisterNetEvent("buongiornodev:daiitemdroga")
AddEventHandler("buongiornodev:daiitemdroga", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    if droga then
        exports.ox_inventory:AddItem(ID, droga.itemDaRaccogliere, droga.quantitaRaccolta)
    end
end)

RegisterNetEvent("buongiornodev:venditadroga")
AddEventHandler("buongiornodev:venditadroga", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    if droga then
        local haDroga = exports.ox_inventory:GetItemCount(ID, droga.itemProcessato)
        if haDroga >= 1 then
            local prezzoTotale = droga.prezzoUnitario * haDroga
            exports.ox_inventory:RemoveItem(ID, droga.itemProcessato, haDroga)
            exports.ox_inventory:AddItem(ID, Config.ItemMoney, prezzoTotale)
        elseif haDroga < 1 then
            TriggerClientEvent('esx:showNotification', source, 'Non hai abbastanza droga da vendere!')
        end
    end
end)
