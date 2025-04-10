menuOpen = false


if Config.interactType ~= "ox_target" then
  Citizen.CreateThread(function()
      while true do
      local wait = 750
      local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    
      for k,v in pairs(Config.garage) do
        if getPlayerJob() == v.job then
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.position.x, v.position.y, v.position.z)
          if dist <= v.interactDist then
            if menuOpen == false then
              helpnotificationfunction(v.position.x, v.position.y, v.position.z + 1.0, Locale["interact"])
            end
            if IsControlJustPressed(0, 38) then 
                menuOpen = true
                SetNuiFocus(true, true) 
                SendNUIMessage({
                    action = 'openmenu',
                    label = v.label,
                    header = v.banner,
                    vehicle = v.vehicle,
                    garagenumber = k,
                    traduction = Locale.ui
                })
                if Config.interactType == "Ox_lib" then
                  lib.hideTextUI()
                end
            end
            wait = 0
          else
            if Config.interactType == "Ox_lib" then
              local isOpen = lib.isTextUIOpen()
              if isOpen == true then
                lib.hideTextUI()
              end
            end
          end
        end
      end
      Citizen.Wait(wait)
      end
  end)
end


RegisterNUICallback("closemenu", function(data, cb)
  SetNuiFocus(false, false) -- Active/désactive le curseur
  Wait(500)
  menuOpen = false
end)

RegisterNUICallback("spawncar", function(data, cb)
    local pos = FoundClearSpawnPoint(Config.garage[tonumber(data.garagenumber)].spawncar)
    if pos ~= false then
      if Config.fadeEffect == true and Config.autoSeat == true then
        DoScreenFadeOut(500) 
        Wait(500)
      end
      local car = GetHashKey(data.spawnname)
      local ped = GetPlayerPed(-1)

      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Citizen.Wait(0)
      end

      local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
      local vehicle = CreateVehicle(car, pos.pos, pos.heading, true, false)
      SetVehicleDirtLevel(vehicle, 0.0)
      if DoesEntityExist(vehicle) then
          for i = 0, 20 do 
              if DoesExtraExist(vehicle, i) then
                toggleExtra = false
                for k,v in pairs(Config.garage[tonumber(data.garagenumber)].vehicle[tonumber(data.number)].extra) do  
                  if v == i then
                    SetVehicleExtra(vehicle, i, 0)
                    toggleExtra = true
                  elseif toggleExtra == false then
                    SetVehicleExtra(vehicle, i, 1) 
                  end
                end

                if toggleExtra == false then
                  SetVehicleExtra(vehicle, i, 1) 
                  toggleExtra = true
                end
              end
          end
      end  

      if Config.garage[tonumber(data.garagenumber)].vehicle[tonumber(data.number)].liveries ~= nil then
        SetVehicleModKit(vehicle, 0)
        if Config.garage[tonumber(data.garagenumber)].vehicle[tonumber(data.number)].liveries_method == 1 then
          SetVehicleLivery(vehicle, Config.garage[tonumber(data.garagenumber)].vehicle[tonumber(data.number)].liveries)
        else
          SetVehicleMod(vehicle, 48, Config.garage[tonumber(data.garagenumber)].vehicle[tonumber(data.number)].liveries)
        end
      end
      
      if Config.autoSeat == true then
        SetPedIntoVehicle(ped, vehicle, -1)
        if Config.fadeEffect == true then
          DoScreenFadeIn(500) -- Réafficher l'écran progressivement
        end
      end

      Config.keySystem_give(GetVehicleNumberPlateText(vehicle))
      notificationfunction((Locale["success_vehicle"]):format(data.label))
    else
      notificationfunction(Locale["no_place"])
    end
end)

Citizen.CreateThread(function()
  while true do
      local Timer = 800
      for k,v in pairs(Config.garage) do
        if getPlayerJob() == v.job then
          local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
          local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, v.rangement.x, v.rangement.y, v.rangement.z)
          if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if dist3 <= Config.marker_ranger.drawdistance and Config.marker_ranger.actif == true then
              Timer = 0
              DrawMarker(Config.marker_ranger.MarkerType, v.rangement.x, v.rangement.y, v.rangement.z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.marker_ranger.MarkerSizeLargeur, Config.marker_ranger.MarkerSizeEpaisseur, Config.marker_ranger.MarkerSizeHauteur, Config.marker_ranger.MarkerColorR, Config.marker_ranger.MarkerColorG, Config.marker_ranger.MarkerColorB, Config.marker_ranger.MarkerOpacite, Config.marker_ranger.MarkerSaute, true, Config.marker_ranger.MarkerTourne, Config.marker_ranger.MarkerTourne)  
            end
            if dist3 <= v.rangerInteractDist then
              Timer = 0
              if dist3 <= 3.0 then 
                  Timer = 0
                  store_helpnotificationfunction(v.rangement.x, v.rangement.y, v.rangement.z + 1.0, Locale["store_vehicle_interact"])
                    if IsControlJustPressed(1,51) then
                      vehicle = GetVehiclePedIsIn(PlayerPedId())
                      TaskLeaveVehicle(PlayerPedId(), vehicle, 0)	
                      Citizen.Wait(2000)
                      Config.keySystem_delete(GetVehicleNumberPlateText(vehicle))
                      DeleteEntity(vehicle)
                      notificationfunction(Locale["store_vehicle"])
                  end
              end
            else
              if Config.interactType == "Ox_lib" then
                local isOpen = lib.isTextUIOpen()
                if isOpen == true then
                  lib.hideTextUI()
                end
              end
            end 
          end
        end
      end
      Citizen.Wait(Timer)
  end
end)