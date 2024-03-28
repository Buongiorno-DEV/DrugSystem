local markeriMostrati = {
    raccolta = false,
    processo = false,
    vendita = false,
}

local ox = exports.ox_inventory

Citizen.CreateThread(function()
    for k, v in ipairs(Config.Droghe) do
        CreaMarker("raccolta", k, v.posizione_raccolta, "RACCOLTA " .. v.nome, function()
            TriggerEvent("buongiornodev:progressbarraccolta", k)
            markeriMostrati.raccolta = true
        end)
        CreaMarker("processo", k, v.posizione_processo, "PROCESSO " .. v.nome, function()
            TriggerEvent("buongiornodev:cercaitemprocesso", k)
            markeriMostrati.processo = true
        end)
        CreaMarker("vendita", k, v.posizione_vendita, "VENDITA " .. v.nome, function()
            TriggerEvent("buongiornodev:cercaitemvendita", k)
            markeriMostrati.vendita = true
        end)
    end
end)


function CreaMarker(categoria, indice, posizione, messaggio, azione)
    local nomeMarker = categoria .. "droga" .. indice
    if not markeriMostrati[categoria] then
        TriggerEvent('gridsystem:registerMarker', {
            name = nomeMarker,
            pos = posizione,
            scale = vector3(1.0, 1.0, 1.0),
            msg = messaggio,
            control = 'E',
            type = Config.Tipo,
            texture = Config.NomeTexture,
            color = { r = 255, g = 255, b = 255 },
            action = azione
        })
    end
end


-- PROGRESS BAR
function MostraProgressBar(etichetta, alCompletamento, durata)
    local opzioni = {
        Async = true,
        canCancel = true,
        cancelKey = 178,
        x = 0.5,
        y = 0.5,
        From = 0,
        To = 100,
        Duration = durata or 1000,
        Radius = 60,
        Stroke = 10,
        Cap = 'butt',
        Padding = 0,
        MaxAngle = 360,
        Rotation = 0,
        Width = 300,
        Height = 40,
        ShowTimer = true,
        ShowProgress = false,
        Easing = "easeLinear",
        Label = etichetta,
        LabelPosition = "bottom",
        Color = "rgba(255, 255, 255, 1.0)",
        BGColor = "rgba(0, 0, 0, 0.4)",
        Animation = {
            animationDictionary = "mini@repair",
            animationName = "fixing_a_ped",
        },
        DisableControls = {
            Vehicle = true
        },    
        onStart = function()
        end,
        onComplete = alCompletamento
    }
    
    if Config.rprogress then
        exports.rprogress:Custom(opzioni)
    else
        lib.progressCircle({
            duration = opzioni.Duration,
            position = 'middle',
            label = etichetta,
            useWhileDead = false,
            canCancel = opzioni.canCancel,
            disable = opzioni.DisableControls,
            anim = {
                dict = opzioni.Animation.animationDictionary,
                clip = opzioni.Animation.animationName
            }
        })
        if alCompletamento then
            alCompletamento()
        end
    end
end



RegisterNetEvent("buongiornodev:progressbarraccolta")
AddEventHandler("buongiornodev:progressbarraccolta", function(drogaId)
    local alCompletamento = function(annullato)
        TriggerServerEvent("buongiornodev:daiitemdroga", drogaId)
    end
    MostraProgressBar("Stai raccogliendo della droga", alCompletamento, Config.Durata)
end)

RegisterNetEvent("buongiornodev:progressbarvendita")
AddEventHandler("buongiornodev:progressbarvendita", function(drogaId)
    local alCompletamento = function(annullato)
        TriggerServerEvent("buongiornodev:venditadroga", drogaId)
    end
    MostraProgressBar("Stai vendendo della droga", alCompletamento, Config.Durata)
end)

RegisterNetEvent("buongiornodev:cercaitemprocesso")
AddEventHandler("buongiornodev:cercaitemprocesso", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    local alCompletamento = function(annullato)
        TriggerServerEvent("buongiornodev:daiitemprocesso", drogaId)
    end
    local haDroga = ox:Search('count', droga.itemDaRaccogliere) 
    if haDroga < droga.quantitaProcesso then
        ESX.ShowNotification("Non hai abbastanza droga da processare!")
    else
        MostraProgressBar("Stai processando della droga", alCompletamento, Config.Durata)
    end
end)

RegisterNetEvent("buongiornodev:cercaitemvendita")
AddEventHandler("buongiornodev:cercaitemvendita", function(drogaId)
    local ID = source
    local droga = Config.Droghe[drogaId]
    local alCompletamento = function(annullato)
        TriggerServerEvent("buongiornodev:venditadroga", drogaId)
    end
    local haDroga = ox:Search('count', droga.itemProcessato) 
    if haDroga < 1 then
        ESX.ShowNotification("Non hai abbastanza droga da processare!")
    else
        MostraProgressBar("Stai vendendo della droga", alCompletamento, Config.Durata)
    end
end)
