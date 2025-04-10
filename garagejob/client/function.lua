function helpnotificationfunction(x, y, z, message)
	if Config.interactType == "ESX" then
		ESX.ShowHelpNotification(message)  
	elseif Config.interactType == "draw3Dtext" then
		DrawText3D(x, y, z, message)
	elseif Config.interactType == "Ox_lib" then
		lib.showTextUI(message)
	end
end

function store_helpnotificationfunction(x, y, z, message)
	if Config.storeInteractType == "ESX" then
		ESX.ShowHelpNotification(message)  
	elseif Config.storeInteractType == "draw3Dtext" then
		DrawText3D(x, y, z, message)
	elseif Config.storeInteractType == "Ox_lib" then
		lib.showTextUI(message)
	end
end

function notificationfunction(message)
	if Config.notif == "ESX" then
		ESX.ShowNotification(message)
	elseif Config.notif == "Ox_lib" then
		lib.notify({
			description = message,
			position = 'top-right',
			type = "inform"
		})
	elseif Config.notif == "custom" then
		Config.customnotif(message)
	end
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry('STRING')
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	local factor = string.len(text) / 370
	DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.garage) do
		local hash = GetHashKey(v.pedhash) 
		while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
		end
		ped = CreatePed("PED_TYPE_CIVFEMALE", v.pedhash, v.position.x, v.position.y, v.position.z-1, v.pedheading, false, true)
		TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)

		if Config.interactType == "ox_target" then
			exports.ox_target:addLocalEntity(ped, {
				{
					label = Locale["interact_target"],
					icon = 'fa-solid fa-warehouse',
					distance = v.interactDist,
					onSelect = function(data)
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
				}
			})
		end
	end
end)  

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVehiclesInArea (coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

function FoundClearSpawnPoint(zones)
	local found = false
	local count = 0
	for k,v in pairs(zones) do
		local clear = IsSpawnPointClear(v.pos, 2.0)
		if clear then
			found = v
			break
		end
	end
	return found
end
