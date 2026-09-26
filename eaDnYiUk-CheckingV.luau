-- 1. Daftar Game yang Didukung (Bisa lebih dari 1 URL per game)
local supportedScripts = {
    [606849621] = { 
        Name = "Jailbreak", 
        -- Gunakan format table {} untuk memasukkan banyak link
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/M6txEKBD-Break.lua"
        }
    },

    [6933626061] = { 
        Name = "TLK Prison", 
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XjXPfzSo-Library.lua"
        } 
    },

    [107778070777162] = { 
        Name = "Steal An Egg", 
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/sAcfzDLt-Steal%20An%20Egg.lua"
        } 
    },

    [13811085661] = { 
        Name = "Area 51 Remake", 
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/Area-51-Remake.lua" 
        }
    },

    [96668710663666] = { 
        Name = "Power Incremental", 
        Urls = {
            "https://raw.githubusercontent.com/IOERHUB/Power-Incremental/refs/heads/main/Working" 
        }
    },

    [93978595733734] = { 
        Name = "Violence District", 
        Urls = {
            "https://raw.githubusercontent.com/Uo2iQnNhD/Maintenance/refs/heads/main/XptC65ba-MainVD.lua"
        }
    }
}

-- 2. URL Script Universal (Fallback) - Bisa juga lebih dari 1
local universalScripts = {
    "https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/F4DiY9yZ9-Checking.luau"
}

-- 3. Pengecekan PlaceId saat ini
local currentPlaceId = game.PlaceId
local scriptData = supportedScripts[currentPlaceId]

-- Fungsi helper untuk memuat script dengan aman
local function loadScriptSafely(url, scriptName)
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if success then
        print(string.format("  [✅ SUCCESS] %s loaded successfully.", scriptName))
    else
        warn(string.format("  [❌ ERROR] Failed to load %s! Detail: %s", scriptName, tostring(err)))
    end
    return success
end

-- 4. Eksekusi Script
print("==================================================")
print("🚀 Starting Script Loader...")
print("🎮 Current PlaceId: " .. currentPlaceId)
print("==================================================")

if scriptData then
    -- Jika game DIDUKUNG (Supported)
    print(string.format("[SUPPORTED] Game Detected: %s", scriptData.Name))
    print("⏳ Loading multiple modules...")
    
    local totalLoaded = 0
    for index, url in ipairs(scriptData.Urls) do
        local moduleName = string.format("%s (Part %d)", scriptData.Name, index)
        if loadScriptSafely(url, moduleName) then
            totalLoaded = totalLoaded + 1
        end
    end
    
    print(string.format("🎉 Finished! %d/%d modules loaded for %s.", totalLoaded, #scriptData.Urls, scriptData.Name))

else
    -- Jika game TIDAK DIDUKUNG (Universal Fallback)
    warn("[⚠️ UNIVERSAL] This game is not specifically supported (PlaceId: " .. currentPlaceId .. ").")
    print("⏳ Loading Universal Fallback scripts...")
    
    local totalLoaded = 0
    for index, url in ipairs(universalScripts) do
        local moduleName = string.format("Universal Script (Part %d)", index)
        if loadScriptSafely(url, moduleName) then
            totalLoaded = totalLoaded + 1
        end
    end
    
    if totalLoaded > 0 then
        print(string.format("🎉 Finished! %d universal module(s) loaded.", totalLoaded))
    else
        warn("💀 All universal scripts failed to load.")
    end
end
