if Config.framework == "OLDESX" or Config.framework == "ESX" then
    ESX = nil

    if Config.framework == "ESX" then
        ESX = exports["es_extended"]:getSharedObject()

        Citizen.CreateThread(function()
            while ESX.GetPlayerData().job == nil do
                Citizen.Wait(10)
            end
            if ESX.IsPlayerLoaded() then
                ESX.PlayerData = ESX.GetPlayerData()
            end
        end)
    else
        ESX = nil
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(10)
            end
            while ESX.GetPlayerData().job == nil do
                Citizen.Wait(10)
            end
            if ESX.IsPlayerLoaded() then
                ESX.PlayerData = ESX.GetPlayerData()
            end
        end)
    end
    

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)

    function getPlayerJob()
        if ESX and ESX.PlayerData and ESX.PlayerData.job then
            return ESX.PlayerData.job.name
        else
            return nil 
        end
    end
end