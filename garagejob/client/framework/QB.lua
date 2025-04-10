if Config.framework == "QB"  then  
    QBCore = exports['qb-core']:GetCoreObject()

    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
        local playerData = QBCore.Functions.GetPlayerData()
        playerData.job = job
    end)


    function getPlayerJob()
        local playerData = QBCore.Functions.GetPlayerData()
        return playerData.job.name
    end
end