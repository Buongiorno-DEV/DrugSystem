Config = {}

-- Impostazioni generali
Config.Tipo = -1  -- Tipo di marker
Config.NomeTexture = "general" -- Nome della texutre
Config.rprogress = true  -- Vuoi utilizzare lo script rprogress? se impostato su false utilizzerà la progressBar di LIB
Config.Durata = 2000 -- Durata della progressBar per ogni processo
Config.ItemMoney = "black_money" -- Scegli il nome del tuo item dei soldi

-- Impostazioni delle droghe
Config.Droghe = {
    {
        nome = "Marijuana",
        posizione_raccolta = vector3(2220.2971, 5578.0869, 53.7254),
        posizione_processo = vector3(-1168.5908, -2050.8936, 14.4399),
        posizione_vendita = vector3(-1172.7941, -1572.6609, 4.6644),
        itemDaRaccogliere = "marijuana_da_processare",
        itemProcessato = "marijuana_processata",
        quantitaProcesso = 2,
        quantitaProcessoFrutto = 1,
        quantitaRaccolta = 1,
        prezzoUnitario = 300,
    },
    {
        nome = "Metanfetamina",
        posizione_raccolta = vector3(3559.2773, 3672.2886, 28.1219),
        posizione_processo = vector3(3535.1528, 3660.5642, 28.1219),
        posizione_vendita = vector3(2671.1562, 1600.9487, 24.4980),
        itemDaRaccogliere = "metanfetamina_da_processare",
        itemProcessato = "metanfetamina_processata",
        quantitaProcesso = 2,
        quantitaProcessoFrutto = 1,
        quantitaRaccolta = 1,
        prezzoUnitario = 800,
    },
    -- Puoi aggiungere quante droghe vuoi!
}
