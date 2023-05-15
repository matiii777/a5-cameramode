local CamMovePos = { x = 0, y = 0, z = 0, fov = 0}
local cam, cam2, camera, TrackedEntity, offsetEnd, offsetStart, camTime = nil, nil, nil, nil, nil, nil, nil
local SavedPictures = {}

---this is the function used to zoom on the player and create the first cam
---@param bool any
local function renderCamMode(bool)
    local ped = PlayerPedId()
    if bool then
		TrackedEntity = ped
		offsetEnd = GetOffsetFromEntityInWorldCoords(TrackedEntity, Shared.CameraOffsetEnd)
		offsetStart = GetOffsetFromEntityInWorldCoords(TrackedEntity, Shared.CameraOffsetStart)
		camTime = Shared.CameraTransitionTime
        FreezeEntityPosition(ped, true)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetStart, 0.0 ,0.0, 0, 60.00, true, 0)
        cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", offsetEnd, 0.0 ,0.0, 0, 60.00, false, 0)
        PointCamAtEntity(cam2, TrackedEntity, 0,0,0, true)
        SetCamFov(cam2, Shared.EndFOV)
        SetCamActiveWithInterp(cam2, cam, 0, true, true)

		RenderScriptCams(true, false, 1, true, true)

        CreateThread(function()
			Wait(camTime)
            if DoesCamExist(cam) then
                DestroyCam(cam, true)
            end
        end)
    else
        if DoesCamExist(cam) then
            DestroyCam(cam, true)
        end
        if DoesCamExist(cam2) then
            DestroyCam(cam2, true)
        end
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(ped, false)
    end
    if bool then
		Wait(camTime)
    end
end

---this function is used to open and render cams for the camera mode
local function OpenCameraMode()
	SetNuiFocus(true, true)
	SendNUIMessage({
        action = "opencam",
    })
	renderCamMode(true)
end

---callback for when the camera mode is closed
---@param data any
RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
	renderCamMode(false)
end)

---this callback runs as soon as the script is loaded. it gets the filters and your saved pictures
---@param _ any
---@param cb any
RegisterNUICallback('getCamsData', function(_, cb)
	Wait(1000)
	local Screenshots = GetResourceKvpString('A5Screenshots')
    if Screenshots then SavedPictures = json.decode(Screenshots) end
	local data = {
		Settings = Shared,
		Pictures = SavedPictures,
	}

	print('^5[a5-cameramode] ^7Successfully loaded Camera Mode Settings!')
    cb(data)
end)

---this triggers when you open the cam mode (if you want to add something)
RegisterNUICallback('CameraMode', function()

end)

---this callback is used to setup the position of cam
---@param data any
RegisterNUICallback('SetUpCameraMovement', function(data)
	TriggerScreenblurFadeOut()
	CamMovePos = { x = 0, y = 0, z = 0, fov = 0}
	camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",  offsetEnd, 0.0 ,40.0, 0, 20.00+CamMovePos.fov, false, 0)
	SetCamActiveWithInterp(camera)
	PointCamAtEntity(camera, TrackedEntity, 0,0,0, true)
	RenderScriptCams(1, 1, 0, 0, 0)
	ClearTimecycleModifier("helicamfirst" , 4.2)
end)

---this callback is used to move the camera mode
---@param data any
RegisterNUICallback('Movecamera', function(data)
	DestroyAllCams(true)
	if data.move.type == 'x' then
		CamMovePos.x = data.move.value
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",  offsetEnd.x+data.move.value, offsetEnd.y+CamMovePos.y, offsetEnd.z+CamMovePos.z, 0.0 ,40.0, 0, 20.00+CamMovePos.fov, false, 0)
		SetCamActiveWithInterp(camera)
	elseif data.move.type == 'y' then
		CamMovePos.y = data.move.value
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",  offsetEnd.x+CamMovePos.x, offsetEnd.y+data.move.value, offsetEnd.z+CamMovePos.z, 0.0 ,0.0, 0, 20.00+CamMovePos.fov, false, 0)
		SetCamActiveWithInterp(camera)
	elseif data.move.type == 'z' then
		CamMovePos.z = data.move.value
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",  offsetEnd.x+CamMovePos.x, offsetEnd.y+CamMovePos.y, offsetEnd.z+data.move.value, 0.0 ,0.0, 0, 20.00+CamMovePos.fov, false, 0)
		SetCamActiveWithInterp(camera)
	elseif data.move.type == 'fov' then
		CamMovePos.fov = data.move.value
		camera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",  offsetEnd.x+CamMovePos.x, offsetEnd.y+CamMovePos.y, offsetEnd.z+CamMovePos.z, 0.0 ,0.0, 0, 20.00+data.move.value, false, 0)
		SetCamActiveWithInterp(camera)
	end
	PointCamAtEntity(camera, TrackedEntity, 0,0,0, true)
	RenderScriptCams(1, 1, 0, 0, 0)
end)

---this is used to blur the camera effect
---@param data any
RegisterNUICallback('Blurcamera', function(data)
	if data.blur == true then
		TriggerScreenblurFadeIn()
	else
		TriggerScreenblurFadeOut()
	end
end)

---this is used to change the stregnth of the camera
---@param data any
RegisterNUICallback('SetFilterStrength', function(data)
	FilterStrength = json.decode(data.Strength)
	SetTimecycleModifierStrength(FilterStrength)
end)

---this is used to set the filter change
---@param data any
RegisterNUICallback('SetFilter', function(data)
	CurrentFilter = data.Filter
    if data.filter == false then
		ClearTimecycleModifier("" , 4.2)
	else
		SetTransitionTimecycleModifier(data.filter, 0)
		SetTimecycleModifierStrength(FilterStrength)
	end
end)

---this callback saves your picture to the gallery
---@param data any
RegisterNUICallback('SavePicture', function(data)
	SavedPictures[tostring(data.Saving.id)] = {
		id = data.Saving.id,
        image = data.Saving.image,
        name = data.Saving.name,
	}
	SetResourceKvp('A5Screenshots', json.encode(SavedPictures))
end)

---this callback deletes the picture from the gallery
---@param data any
RegisterNUICallback('DeletePicture', function(data)
	SavedPictures[tostring(data.SelectedId)] = nil
	SetResourceKvp('A5Screenshots', json.encode(SavedPictures))
end)

---this callback is used to take a screenshot and upload it to discord
RegisterNUICallback('TakeScreenShot', function()
    local DiscordWebhook = Shared.DiscordWebHook
	if DiscordWebhook == "YOUR-WEBHOOK-HERE" then
		print("You did not put a valid webhook in the config")
		return
	end

    exports['screenshot-basic']:requestScreenshotUpload(tostring(DiscordWebhook), "files[]", function(data)
        local image = json.decode(data)
        SendNUIMessage({
            action = "CopyScreenshotUrl",
            url = image.attachments[1].proxy_url
        })
    end)
end)

---command to open camera mode
RegisterCommand("cameramode", function()
    OpenCameraMode()
end)

---trigger to open camera mode
RegisterNetEvent('a5-cameramode:client:OpenCameraMode', function()
    OpenCameraMode()
end)


