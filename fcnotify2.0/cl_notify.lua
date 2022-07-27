function SetQueueMax(queue, max)
    local tmp = {
        queue = tostring(queue),
        max = tonumber(max)
    }

    SendNUIMessage({maxNotifications = tmp})
end

function SendNotification(options)
    options.animation = options.animation or {}
    options.sounds = options.sounds or {}
    options.docTitle = options.docTitle or {}

    if exports['213-Main']:GetSettings('watermark') then
        options.layout = 'bottom'
    else
        options.layout = 'topRight'
    end

    if not exports['213-Main']:GetSettings('powiad_ogo') and (options.type == 'ogolne') then
        return
    elseif not exports['213-Main']:GetSettings('powiad_frak') and (options.type == 'lspd' or options.type == 'lsc' or options.type == 'ems') then
        return
    end

    CreateThread(function()
        if options.frontendSound then
            for i=1, options.frontendSound.times, 1 do
                Wait(options.frontendSound.wait or 1000)
                PlaySoundFrontend(-1, options.frontendSound.string[1], options.frontendSound.string[2], 0)
            end
        end
    end)

    if options.frontendSound then
        options.sounds.volume = 0.0
    end

    local options = {
        type = options.type or "info",
        layout = options.layout or "centerLeft",
        theme = options.theme or "gta",
        text = options.text or "Powiadomienie Testowe",
        timeout = options.timeout or 5000,
        progressBar = options.progressBar ~= false and true or false,
        closeWith = options.closeWith or {},
        animation = {
            open = options.animation.open or "gta_effects_open",
            close = options.animation.close or "gta_effects_close"
        },
        sounds = {
            volume = options.sounds.volume or 0.5,
            conditions = options.sounds.conditions or {"docVisible"},
            sources = options.sounds.sources or {"sounds/notif.wav"}
        },
        docTitle = {
            conditions = options.docTitle.conditions or {}
        },
        modal = options.modal or false,
        id = options.id or false,
        force = options.force or false,
        queue = options.queue or "global",
        killer = options.killer or false,
        container = options.container or false,
        buttons = options.button or false
    }


    SendNUIMessage({options = options})
end

RegisterNetEvent("fcnotify2.0:SendNotification")
AddEventHandler("fcnotify2.0:SendNotification", function(options)
    SendNotification(options)
end)

RegisterNetEvent("fcnotify2.0:SetQueueMax")
AddEventHandler("fcnotify2.0:SetQueueMax", function(queue, max)
    SetQueueMax(queue, max)
end)
