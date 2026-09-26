-- ZETHUB Splash Screen + Rayfield Loader (Mobile Support Fixed)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
math.randomseed(os.clock())

-- Ambil parent GUI yang aman (coregui/gethui)
local function getGuiParent()
    if gethui then
        local ok, hui = pcall(gethui)
        if ok and hui then return hui end
    end
    if syn and syn.protect_gui then
        return game:GetService("CoreGui")
    end
    return player:WaitForChild("PlayerGui")
end

local parentGui = getGuiParent()

-- Helper buat instance
local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

-- Helper tween
local function tween(obj, props, duration, style, direction)
    local info = TweenInfo.new(
        duration,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Hapus splash lama kalau ada
for _, v in ipairs(parentGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name:find("ZETHUB_SPLASH") then
        v:Destroy()
    end
end

local guiName = "ZETHUB_SPLASH_" .. tostring(math.random(100000, 999999))

-- DisplayOrder tinggi agar tidak tertimpa UI lain
local gui = new("ScreenGui", {
    Name = guiName,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = parentGui
})

-- Background utama: darker tapi masih sedikit transparan
local main = new("Frame", {
    Name = "Main",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = gui
})

-- Container untuk konten
local content = new("Frame", {
    Name = "Content",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 11,
    Parent = main
})

-- ==========================================
-- MOBILE SUPPORT FIXED
-- PC = scale selalu 1
-- HP/Tablet = scale menyesuaikan layar
-- ==========================================
local viewport = camera.ViewportSize
local isTouchDevice = UserInputService.TouchEnabled
local isMouseDevice = UserInputService.MouseEnabled

-- Anggap mobile kalau touch aktif tapi mouse tidak aktif
local isMobile = isTouchDevice and not isMouseDevice

local scaleFactor = 1

if isMobile then
    -- Scale berdasarkan layar HP
    scaleFactor = math.min(viewport.X / 1920, viewport.Y / 1080)
    scaleFactor = math.clamp(scaleFactor, 0.5, 1)
else
    -- PC selalu normal, tidak ikut mengecil
    scaleFactor = 1
end

local contentScale = new("UIScale", {
    Scale = scaleFactor,
    Parent = content
})

-- Efek glow tipis kiri atas
local orb1 = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.22, 0, 0.30, 0),
    Size = UDim2.fromOffset(260, 260),
    BackgroundColor3 = Color3.fromRGB(95, 55, 220),
    BackgroundTransparency = 0.93,
    BorderSizePixel = 0,
    ZIndex = 12,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = orb1 })

-- Efek glow tipis kanan bawah
local orb2 = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.78, 0, 0.72, 0),
    Size = UDim2.fromOffset(300, 300),
    BackgroundColor3 = Color3.fromRGB(45, 120, 255),
    BackgroundTransparency = 0.95,
    BorderSizePixel = 0,
    ZIndex = 12,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = orb2 })

-- Logo ZETHUB
local logo = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.42, 0),
    Size = UDim2.fromOffset(560, 100),
    BackgroundTransparency = 1,
    Text = "ZETHUB",
    Font = Enum.Font.GothamBlack,
    TextSize = 72,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextStrokeColor3 = Color3.fromRGB(110, 70, 255),
    TextStrokeTransparency = 1,
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})

local logoScale = new("UIScale", {
    Scale = 0.86,
    Parent = logo
})

-- Subtitle
local subtitle = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.50, 0),
    Size = UDim2.fromOffset(480, 26),
    BackgroundTransparency = 1,
    Text = "Powered by Exterminate0",
    Font = Enum.Font.Gotham,
    TextSize = 17,
    TextColor3 = Color3.fromRGB(205, 205, 220),
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})

-- Garis bawah logo
local line = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.545, 0),
    Size = UDim2.fromOffset(0, 3),
    BackgroundColor3 = Color3.fromRGB(120, 80, 255),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = line })

-- Loading bar background
local barBg = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.62, 0),
    Size = UDim2.fromOffset(360, 8),
    BackgroundColor3 = Color3.fromRGB(24, 24, 30),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = barBg })

-- Loading bar fill
local barFill = new("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = Color3.fromRGB(120, 80, 255),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 16,
    Parent = barBg
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = barFill })
new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 90, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(70, 140, 255))
    }),
    Parent = barFill
})

-- Persen
local percent = new("TextLabel", {
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0.5, 190, 0.62, 0),
    Size = UDim2.fromOffset(60, 20),
    BackgroundTransparency = 1,
    Text = "0%",
    Font = Enum.Font.GothamBold,
    TextSize = 15,
    TextColor3 = Color3.fromRGB(225, 225, 235),
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 15,
    Parent = content
})

-- Status loading
local status = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.665, 0),
    Size = UDim2.fromOffset(520, 22),
    BackgroundTransparency = 1,
    Text = "Starting...",
    Font = Enum.Font.Gotham,
    TextSize = 15,
    TextColor3 = Color3.fromRGB(180, 180, 195),
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})

local splashActive = true

-- Animasi glow/orb bergerak pelan
task.spawn(function()
    while splashActive and gui.Parent do
        tween(orb1, { Position = UDim2.new(0.28, 0, 0.26, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        tween(orb2, { Position = UDim2.new(0.72, 0, 0.78, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(2.2)

        if not (splashActive and gui.Parent) then break end

        tween(orb1, { Position = UDim2.new(0.20, 0, 0.34, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        tween(orb2, { Position = UDim2.new(0.80, 0, 0.68, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(2.2)
    end
end)

-- Fade in background
tween(main, { BackgroundTransparency = 0.16 }, 0.55)

-- Fade in logo
tween(logo, { TextTransparency = 0, TextStrokeTransparency = 0.18 }, 0.75)
tween(subtitle, { TextTransparency = 0.12 }, 0.75)
tween(logoScale, { Scale = 1 }, 0.85, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

task.wait(0.25)

-- Fade in garis + loading bar
tween(line, { BackgroundTransparency = 0, Size = UDim2.fromOffset(280, 3) }, 0.55)
tween(barBg, { BackgroundTransparency = 0.24 }, 0.45)
tween(barFill, { BackgroundTransparency = 0 }, 0.45)
tween(percent, { TextTransparency = 0.08 }, 0.45)
tween(status, { TextTransparency = 0.08 }, 0.45)

-- Preload Rayfield (Dijaga agar teks "Memuat Rayfield..." tetap valid)
local Rayfield = nil
local rayfieldReady = false
local rayfieldError = nil

task.spawn(function()
    local ok, result = pcall(function()
        return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
    end)

    if ok then
        Rayfield = result
    else
        rayfieldError = result
    end

    rayfieldReady = true
end)

-- Loading fake/simulasi
local messages = {
    "Loading data...",
    "Preparing interface...",
    "Connecting module...",
    "Optimizing the UI...",
    "Loading Interface...",
    "Almost complete..."
}

local progress = 0

local function setProgress(value)
    value = math.clamp(value, 0, 100)
    tween(barFill, { Size = UDim2.fromScale(value / 100, 1) }, 0.20)
    percent.Text = math.floor(value) .. "%"
end

for _, msg in ipairs(messages) do
    status.Text = msg

    for _ = 1, math.random(2, 4) do
        progress = math.min(98, progress + math.random(4, 10))
        setProgress(progress)
        task.wait(math.random(12, 24) / 98)
    end
end

setProgress(99)

while not rayfieldReady do
    status.Text = "Waiting for Interface to finish loading..."
    task.wait(3)
end

status.Text = Rayfield and "Interface ready for use!" or "Interface Failed to load!"
task.wait(2.5)

setProgress(100)

-- ==========================================
-- LONG & SMOOTH DESTROY ANIMATION
-- ==========================================
splashActive = false

local fadeTime = 1.2
local smoothStyle = Enum.EasingStyle.Quint

-- 1. Hilangkan Loading Bar & Status
tween(barBg, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(barFill, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(percent, { TextTransparency = 1 }, fadeTime, smoothStyle)
tween(status, { TextTransparency = 1 }, fadeTime, smoothStyle)
task.wait(0.4)

-- 2. Hilangkan Subtitle & Garis
tween(subtitle, { TextTransparency = 1 }, fadeTime, smoothStyle)
tween(line, { BackgroundTransparency = 1, Size = UDim2.fromOffset(0, 3) }, fadeTime, smoothStyle)
task.wait(0.4)

-- 3. Hilangkan Logo + zoom out tipis
tween(logo, { TextTransparency = 1, TextStrokeTransparency = 1 }, fadeTime, smoothStyle)
tween(logoScale, { Scale = 1.15 }, fadeTime, smoothStyle)
task.wait(0.5)

-- 4. Hilangkan Background & Orbs
tween(orb1, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(orb2, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(main, { BackgroundTransparency = 1 }, fadeTime + 0.5, smoothStyle)

task.wait(fadeTime + 0.6)

-- Hapus splash UI setelah animasi selesai total
gui:Destroy()

-- ==========================================
-- EXECUTE CUSTOM SCRIPT (RAYFIELD / UI)
-- ==========================================
local success, errorMessage = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/eaDnYiUk-CheckingV2.luau"))()
end)

if not success then
    warn("[System] Failed to load script:", errorMessage)
end
