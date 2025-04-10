Config = {

    -- ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗     
    --██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║     
    --██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║     
    --██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║     
    --╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗
    -- ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

    framework = "ESX", -- ESX | OLDESX | QB
    interactType = "ox_target", -- ESX | Ox_lib | ox_target | draw3Dtext
    storeInteractType = "ESX", -- ESX | Ox_lib | draw3Dtext
    notificationType = "ESX", -- ESX | Ox_lib | Custom
    autoSeat = true, -- TP automatiquement dans le véhicule
    fadeEffect = true, -- Effet transition quand on est téléporter (uniquement si autoSeat = true)

    keySystem_give = function(plate)
    end,

    keySystem_delete = function(plate)
    end,

    customnotif = function(msg)
    end,

    
    --███╗   ███╗ █████╗ ██████╗ ██╗  ██╗███████╗██████╗ 
    --████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔══██╗
    --██╔████╔██║███████║██████╔╝█████╔╝ █████╗  ██████╔╝
    --██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗ ██╔══╝  ██╔══██╗
    --██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗███████╗██║  ██║
    --╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
    
    marker_ranger = {
        actif = true,
        drawdistance = 5.0,
        MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
        MarkerSizeLargeur = 0.2, -- Largeur du marker
        MarkerSizeEpaisseur = 0.2, -- Épaisseur du marker
        MarkerSizeHauteur = 0.2, -- Hauteur du marker
        MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
        MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
        MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
        MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
        MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
        MarkerSaute = false, -- Si le marker saute (true = oui, false = non)
        MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)
    },
                                                   


    -- ██████╗  █████╗ ██████╗  █████╗  ██████╗ ███████╗
    --██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝
    --██║  ███╗███████║██████╔╝███████║██║  ███╗█████╗  
    --██║   ██║██╔══██║██╔══██╗██╔══██║██║   ██║██╔══╝  
    --╚██████╔╝██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗
    -- ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

    garage = {
        {
            job = "agentimmo",
            label = "Los Santos Police Department",
            banner = "img/header/police.png",
            pedhash = "s_m_y_cop_01",
            pedheading = 178.98524475097656,
            position = vector3(457.31118774414, -1008.1211547852, 28.301429748535),
            rangement = vector3(456.68505859375, -1019.7026977539, 28.301776885986),
            interactDist = 1.3,
            rangerInteractDist = 1.6,
            vehicle = {
                {
                    label = "Police Cruiser 2",
                    spawn = "police2",
                    img = "img/vehicle/police2.png",
                    extra = {},
                    liveries = 2, -- nil si aucune modification liveries souhaitée.
                    liveries_method = 1, -- 1 : SetVehicleLivery | 2 : SetVehicleMod
                },
                {
                    label = "Police Cruiser 3",
                    spawn = "police3", 
                    img = "img/vehicle/police3.png",
                    extra = {},
                    liveries = nil, -- nil si aucune modification liveries souhaitée.
                    liveries_method = 1, -- 1 : SetVehicleLivery | 2 : SetVehicleMod
                },
            },
            spawncar = {
                {pos = vector3(446.19830322266, -1025.8807373047, 28.645347595215), heading = 3.47791671752929},
                {pos = vector3(442.40347290039, -1026.1317138672, 28.716131210327), heading = 3.74022459983825},
                {pos = vector3(438.52697753906, -1026.9498291016, 28.789510726929), heading = 3.74022459983825},
                {pos = vector3(434.88864135742, -1027.2778320313, 28.854223251343), heading = 5.46526336669921},
                {pos = vector3(431.13986206055, -1027.8258056641, 28.922468185425), heading = 6.046799659729},
                {pos = vector3(427.33920288086, -1028.0793457031, 28.989706039429), heading = 7.64307069778442}
            }
        },
    }
}