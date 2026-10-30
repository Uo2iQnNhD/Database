--------------------------------------------------
-- SETTINGS
--------------------------------------------------
local LoaderSettings = {
    -- Mode pencocokan:
    -- "GameIdThenPlaceId" => utamakan GameId, fallback ke PlaceId
    -- "PlaceIdThenGameId" => utamakan PlaceId, fallback ke GameId
    -- "GameIdOnly"        => hanya terima GameId
    -- "PlaceIdOnly"       => hanya terima PlaceId
    MatchMode = "GameIdThenPlaceId",

    -- Tolak URL selain http/https
    AllowNonHttps = false,

    -- Tampilkan log detail
    PrintDetailedLog = true,

    -- Jika game terdaftar tapi tidak punya URL, load universal
    FallbackToUniversalIfNoUrls = true,

    -- Jika semua script game gagal dimuat, load universal
    FallbackToUniversalIfSupportedFails = false,
}

--------------------------------------------------
-- NOTIFICATION SETTINGS
--------------------------------------------------
local NotificationSettings = {
    -- Master switch notification
    Enabled = true,

    -- Prefix judul notification
    TitlePrefix = "Loader",

    -- Durasi default notification dalam detik
    Duration = 5,

    -- Jeda antar notification supaya tidak spam
    QueueDelay = 0.12,

    -- Batas panjang judul/text
    MaxTitleLength = 42,
    MaxTextLength = 180,

    -- Notification saat loader mulai
    NotifyOnStart = true,

    -- Notification saat hasil load: sukses/gagal/sebagian gagal
    NotifyOnResult = true,

    -- Notification untuk setiap script/part
    -- Matikan jika tidak ingin spam
    NotifyOnEachScript = false,

    -- Notification untuk setiap warning/error kecil
    -- Matikan secara default agar tidak terlalu spam
    NotifyOnErrors = false,
}

--------------------------------------------------
-- CONFIG GAME
--------------------------------------------------
-- Saya isi GameIds dan PlaceIds dengan ID yang sama
-- agar kompatibel dengan script lamamu.
--
-- Jika kamu ingin lebih ketat:
-- - Kalau ID berasal dari URL game Roblox, pindahkan ke GameIds saja.
-- - Kalau ID khusus place tertentu, pindahkan ke PlaceIds saja.
--------------------------------------------------
local LoaderConfig = {
    Universal = {
        Name = "Universal",
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/L3aun246-Universal.lua"
        }
    },

    Games = {
        {
            Name = "Jailbreak",
            GameIds = {606849621},
            PlaceIds = {606849621},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/M6txEKBD-Break.lua"
            }
        },

        {
            Name = "TLK Prison",
            GameIds = {6933626061},
            PlaceIds = {6933626061},
            Urls = {
                "https://raw.githubusercontent.com/IOERHUB/CheckingV2/refs/heads/main/Protection"
            }
        },

        {
            Name = "Steal An Egg",
            GameIds = {107778070777162},
            PlaceIds = {107778070777162},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/sAcfzDLt-Steal%20An%20Egg.lua"
            }
        },

        {
            Name = "Area 51 Remake",
            GameIds = {13811085661},
            PlaceIds = {13811085661},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/Area-51-Remake.lua"
            }
        },

        {
            Name = "Power Incremental",
            GameIds = {96668710663666},
            PlaceIds = {96668710663666},
            Urls = {
                "https://raw.githubusercontent.com/IOERHUB/Power-Incremental/refs/heads/main/Working"
            }
        },

        {
            Name = "Violence District",
            GameIds = {93978595733734},
            PlaceIds = {93978595733734},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XptC65ba-MainVD.lua"
            }
        },

        {
            Name = "Murderer vs Sheriff Duels",
            GameIds = {12355337193},
            PlaceIds = {12355337193},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/eyPSrASq-MVSD.lua"
            }
        },

        {
            Name = "The Hollow: Roblox",
            GameIds = {116463962153167},
            PlaceIds = {116463962153167},
            Urls = {
                "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/The%20Hollow%3A%20Roblox.lua"
            }
        },
    }
}

--------------------------------------------------
-- UTILITAS
--------------------------------------------------
local function countKeys(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

local function isFinitePositiveInteger(value)
    if type(value) ~= "number" then
        return false
    end

    -- NaN check
    if value ~= value then
        return false
    end

    -- Infinity check
    if value == math.huge or value == -math.huge then
        return false
    end

    -- Harus positif dan bulat
    if value <= 0 then
        return false
    end

    return value == math.floor(value)
end

local function normalizeUrl(url)
    if type(url) ~= "string" then
        return ""
    end

    -- Hapus spasi di awal/akhir
    url = url:gsub("^%s+", ""):gsub("%s+$", "")

    -- Hapus BOM jika tidak sengaja menempel di string URL
    url = url:gsub("^\239\187\191", "")

    return url
end

local function isHttpUrl(url)
    return type(url) == "string" and url:match("^https?://") ~= nil
end

--------------------------------------------------
-- NOTIFICATION SYSTEM
--------------------------------------------------
local notificationQueue = {}
local notificationProcessing = false

local spawnFn = (task and task.spawn) or spawn
local waitFn = (task and task.wait) or wait

local function getUtf8Length(str)
    if utf8 and utf8.len then
        local ok, len = pcall(utf8.len, str)
        if ok and type(len) == "number" then
            return len
        end
    end

    -- Fallback hitung byte
    return #str
end

local function truncateNotificationString(value, maxLength)
    if not maxLength or maxLength <= 0 then
        return value
    end

    local length = getUtf8Length(value)
    if length <= maxLength then
        return value
    end

    local keepChars = math.max(1, maxLength - 3)

    -- Coba potong aman berdasarkan UTF-8 character
    if utf8 and utf8.offset then
        local ok, offset = pcall(utf8.offset, value, keepChars + 1)
        if ok and type(offset) == "number" and offset > 1 then
            return value:sub(1, offset - 1) .. "..."
        end
    end

    -- Fallback potong byte
    return value:sub(1, keepChars) .. "..."
end

local function cleanNotificationString(value, maxLength)
    value = tostring(value or "")

    -- Ganti control character/newline jadi spasi
    value = value:gsub("[%c]", " ")

    -- Rapikan spasi berlebih
    value = value:gsub("%s+", " ")
    value = value:gsub("^%s+", ""):gsub("%s+$", "")

    -- Potong jika terlalu panjang
    value = truncateNotificationString(value, maxLength)

    return value
end

local function buildNotificationTitle(title)
    title = tostring(title or "Notification")

    if NotificationSettings.TitlePrefix and NotificationSettings.TitlePrefix ~= "" then
        title = NotificationSettings.TitlePrefix .. " • " .. title
    end

    return cleanNotificationString(title, NotificationSettings.MaxTitleLength)
end

local function sendNotificationImmediate(title, text, duration)
    if not NotificationSettings.Enabled then
        return false
    end

    title = buildNotificationTitle(title)
    text = cleanNotificationString(text, NotificationSettings.MaxTextLength)
    duration = tonumber(duration) or NotificationSettings.Duration

    if duration < 1 then
        duration = 1
    end

    if text == "" then
        text = "Selesai."
    end

    local payload = {
        Title = title,
        Text = text,
        Duration = duration,
    }

    local sent = false

    -- Metode 1: StarterGui:SetCore("SendNotification", ...)
    sent = pcall(function()
        local starterGui = game:GetService("StarterGui")
        starterGui:SetCore("SendNotification", payload)
    end)

    if sent then
        return true
    end

    -- Metode 2: NotificationService:Notify(...)
    sent = pcall(function()
        local service = game:GetService("NotificationService")
        service:Notify(payload)
    end)

    if sent then
        return true
    end

    -- Metode 3: CoreGui.NotificationService
    sent = pcall(function()
        local coreGui = game:GetService("CoreGui")
        local service = coreGui:FindFirstChild("NotificationService")

        if service then
            service:Notify(payload)
        end
    end)

    return sent
end

local function processNotificationQueue()
    if notificationProcessing then
        return
    end

    -- Jika spawn/task tidak tersedia, kirim langsung dengan jeda manual jika possible
    if not spawnFn then
        while #notificationQueue > 0 do
            local item = table.remove(notificationQueue, 1)
            sendNotificationImmediate(item.title, item.text, item.duration)

            if waitFn then
                waitFn(NotificationSettings.QueueDelay or 0.12)
            end
        end

        return
    end

    notificationProcessing = true

    local spawnOk = pcall(spawnFn, function()
        local queueOk, queueErr = pcall(function()
            while #notificationQueue > 0 do
                local item = table.remove(notificationQueue, 1)
                sendNotificationImmediate(item.title, item.text, item.duration)

                if waitFn then
                    waitFn(NotificationSettings.QueueDelay or 0.12)
                end
            end
        end)

        notificationProcessing = false

        if not queueOk then
            warn("Notification queue error: " .. tostring(queueErr))
        end
    end)

    if not spawnOk then
        notificationProcessing = false
        warn("Failed to start notification queue thread.")
    end
end

local function notify(title, text, duration)
    if not NotificationSettings.Enabled then
        return
    end

    table.insert(notificationQueue, {
        title = title,
        text = text,
        duration = duration,
    })

    processNotificationQueue()
end

--------------------------------------------------
-- LOGGING
--------------------------------------------------
local function logInfo(message)
    if LoaderSettings.PrintDetailedLog then
        print("  [INFO] " .. message)
    end
end

local function logSuccess(message)
    if LoaderSettings.PrintDetailedLog then
        print("  [✅] " .. message)
    end
end

local function logWarn(message)
    warn("  [❌] " .. message)

    if NotificationSettings.NotifyOnErrors then
        notify("Warning", message, NotificationSettings.Duration)
    end
end

--------------------------------------------------
-- BUILD INDEX CHECKER
--------------------------------------------------
local gameIndex = {}
local placeIndex = {}

local function registerIndex(index, id, entry, idKind)
    if not isFinitePositiveInteger(id) then
        logWarn(string.format(
            "ID tidak valid untuk %s (%s): %s",
            tostring(entry.Name),
            idKind,
            tostring(id)
        ))
        return false
    end

    if index[id] ~= nil then
        logWarn(string.format(
            "Duplicate %s %d untuk %s. Entri terakhir akan dipakai.",
            idKind,
            id,
            tostring(entry.Name)
        ))
    end

    index[id] = entry
    return true
end

-- Validasi dan bangun index sekali saja saat script dimulai
for i, entry in ipairs(LoaderConfig.Games) do
    if type(entry) == "table" then
        entry.Name = entry.Name or ("Game #" .. i)
        entry.GameIds = entry.GameIds or {}
        entry.PlaceIds = entry.PlaceIds or {}
        entry.Urls = entry.Urls or {}

        for _, id in ipairs(entry.GameIds) do
            registerIndex(gameIndex, id, entry, "GameId")
        end

        for _, id in ipairs(entry.PlaceIds) do
            registerIndex(placeIndex, id, entry, "PlaceId")
        end
    else
        logWarn("Entri game ke-" .. i .. " bukan table dan dilewati.")
    end
end

--------------------------------------------------
-- LOADER AMAN
--------------------------------------------------
local loadedUrls = {}
local loadFunction = loadstring or load

local function loadRemoteScript(url, label)
    url = normalizeUrl(url)

    if url == "" then
        logWarn(label .. ": URL kosong.")
        return false
    end

    if not LoaderSettings.AllowNonHttps and not isHttpUrl(url) then
        logWarn(label .. ": URL bukan http/https: " .. url)
        return false
    end

    -- Hindari load ulang URL yang sama
    local previousStatus = loadedUrls[url]
    if previousStatus ~= nil then
        if previousStatus then
            logSuccess(label .. ": URL sudah pernah sukses dimuat, dilewati.")
        else
            logWarn(label .. ": URL sudah pernah gagal, tidak diulang.")
        end

        return previousStatus
    end

    -- Download
    local fetchOk, body = pcall(function()
        return game:HttpGet(url)
    end)

    if not fetchOk then
        loadedUrls[url] = false
        logWarn(string.format(
            "%s: gagal download. Error: %s",
            label,
            tostring(body)
        ))
        return false
    end

    if type(body) ~= "string" then
        loadedUrls[url] = false
        logWarn(label .. ": hasil download bukan string.")
        return false
    end

    -- Hapus UTF-8 BOM dari awal konten script
    body = body:gsub("^\239\187\191", "")

    if body == "" then
        loadedUrls[url] = false
        logWarn(label .. ": konten script kosong.")
        return false
    end

    if type(loadFunction) ~= "function" then
        loadedUrls[url] = false
        logWarn(label .. ": loadstring/load tidak tersedia.")
        return false
    end

    -- Compile
    local compileOk, compiled, compileError = pcall(loadFunction, body)

    if not compileOk then
        loadedUrls[url] = false
        logWarn(string.format(
            "%s: loadstring error. Detail: %s",
            label,
            tostring(compiled)
        ))
        return false
    end

    if compiled == nil then
        loadedUrls[url] = false
        logWarn(string.format(
            "%s: script gagal dikompilasi. Detail: %s",
            label,
            tostring(compileError)
        ))
        return false
    end

    -- Execute
    local runOk, runError = pcall(compiled)
    loadedUrls[url] = runOk

    if runOk then
        logSuccess(label .. ": berhasil dimuat dan dijalankan.")
    else
        logWarn(string.format(
            "%s: runtime error. Detail: %s",
            label,
            tostring(runError)
        ))
    end

    return runOk
end

local function loadUrlList(urls, baseName)
    if type(urls) ~= "table" then
        return 0, 0
    end

    local total = #urls
    local successCount = 0

    for i = 1, total do
        local label = string.format("%s [%d/%d]", baseName, i, total)

        if NotificationSettings.NotifyOnEachScript then
            notify("Memuat", label, 2)
        end

        local ok = loadRemoteScript(urls[i], label)

        if ok then
            successCount = successCount + 1
        end

        if NotificationSettings.NotifyOnEachScript then
            notify(ok and "Sukses" or "Gagal", label, 2)
        end
    end

    return successCount, total
end

--------------------------------------------------
-- CHECKER CEPAT
--------------------------------------------------
local function getIndexValue(index, id)
    if isFinitePositiveInteger(id) then
        return index[id]
    end

    return nil
end

local function getMatchedGame()
    local mode = LoaderSettings.MatchMode
    local gameId = game.GameId
    local placeId = game.PlaceId

    local entry
    local source

    if mode == "GameIdOnly" then
        entry = getIndexValue(gameIndex, gameId)
        source = "GameId"

    elseif mode == "PlaceIdOnly" then
        entry = getIndexValue(placeIndex, placeId)
        source = "PlaceId"

    elseif mode == "PlaceIdThenGameId" then
        entry = getIndexValue(placeIndex, placeId)
        source = "PlaceId"

        if not entry then
            entry = getIndexValue(gameIndex, gameId)
            source = "GameId"
        end

    else
        -- Default: GameIdThenPlaceId
        entry = getIndexValue(gameIndex, gameId)
        source = "GameId"

        if not entry then
            entry = getIndexValue(placeIndex, placeId)
            source = "PlaceId"
        end
    end

    if entry then
        return entry, source
    end

    return nil, nil
end

--------------------------------------------------
-- NOTIFICATION RESULT HELPER
--------------------------------------------------
local function notifyLoadResult(kind, name, loaded, total)
    if not NotificationSettings.NotifyOnResult then
        return
    end

    name = tostring(name or kind)

    if total == 0 then
        notify(kind .. " Kosong", string.format("%s tidak memiliki URL.", name), 5)
    elseif loaded == total then
        notify(kind .. " Sukses", string.format("%s: %d/%d script dimuat.", name, loaded, total), 5)
    elseif loaded > 0 then
        notify(kind .. " Sebagian Gagal", string.format("%s: %d/%d script dimuat.", name, loaded, total), 5)
    else
        notify(kind .. " Gagal", string.format("%s: 0/%d script dimuat.", name, total), 5)
    end
end

--------------------------------------------------
-- UNIVERSAL FALLBACK
--------------------------------------------------
local function loadUniversal(reason)
    if reason then
        warn(reason)
    end

    print("⏳ Memuat Universal...")

    if type(LoaderConfig.Universal) ~= "table" then
        warn("💀 LoaderConfig.Universal tidak ada.")

        if NotificationSettings.NotifyOnResult then
            notify("Universal Error", "Konfigurasi Universal tidak ada.", 5)
        end

        return 0, 0
    end

    local universalName = LoaderConfig.Universal.Name or "Universal"

    if NotificationSettings.NotifyOnResult then
        notify("Universal", reason or string.format("Memuat %s...", universalName), 4)
    end

    local loaded, total = loadUrlList(
        LoaderConfig.Universal.Urls,
        universalName
    )

    notifyLoadResult("Universal", universalName, loaded, total)

    return loaded, total
end

--------------------------------------------------
-- MAIN
--------------------------------------------------
print("==================================================")
print("🚀 Starting Clean Script Loader...")
print(string.format(
    "🎮 GameId: %s | PlaceId: %s",
    tostring(game.GameId),
    tostring(game.PlaceId)
))
print(string.format(
    "🔎 MatchMode: %s",
    LoaderSettings.MatchMode
))
print(string.format(
    "📚 Registered: GameId=%d, PlaceId=%d",
    countKeys(gameIndex),
    countKeys(placeIndex)
))
print("==================================================")

if NotificationSettings.NotifyOnStart then
    notify(
        "Start",
        string.format(
            "GameId %s | PlaceId %s | Mode %s",
            tostring(game.GameId),
            tostring(game.PlaceId),
            LoaderSettings.MatchMode
        ),
        4
    )
end

local matched, matchedBy = getMatchedGame()

if matched then
    print(string.format(
        "[SUPPORTED] Game Detected: %s (matched by %s)",
        matched.Name,
        tostring(matchedBy)
    ))

    if NotificationSettings.NotifyOnResult then
        notify(
            "Supported",
            string.format(
                "%s terdeteksi via %s. Memuat script...",
                matched.Name,
                tostring(matchedBy)
            ),
            4
        )
    end

    local loaded, total = loadUrlList(matched.Urls, matched.Name)

    notifyLoadResult("Game", matched.Name, loaded, total)

    if total == 0 then
        warn(string.format(
            "[!] %s terdaftar tetapi tidak memiliki URL.",
            matched.Name
        ))

        if LoaderSettings.FallbackToUniversalIfNoUrls then
            loadUniversal("⏳ Fallback ke Universal karena game didukung tidak punya URL.")
        end
    else
        print(string.format(
            "🎉 Finished! %d/%d modules loaded for %s.",
            loaded,
            total,
            matched.Name
        ))

        if loaded == 0 and LoaderSettings.FallbackToUniversalIfSupportedFails then
            loadUniversal("⏳ Fallback ke Universal karena semua script game gagal.")
        end
    end
else
    warn(string.format(
        "[⚠️ UNIVERSAL] Game tidak terdaftar. GameId=%s, PlaceId=%s",
        tostring(game.GameId),
        tostring(game.PlaceId)
    ))

    if NotificationSettings.NotifyOnResult then
        notify(
            "Unsupported",
            string.format(
                "GameId %s | PlaceId %s tidak terdaftar. Menggunakan Universal.",
                tostring(game.GameId),
                tostring(game.PlaceId)
            ),
            4
        )
    end

    loadUniversal()
end
