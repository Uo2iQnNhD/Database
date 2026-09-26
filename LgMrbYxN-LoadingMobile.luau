-- ==========================================
-- ZETHUB Splash Screen + Rayfield Loader
-- ★ MOBILE ONLY EDITION ★
-- (Versi PC tetap pakai script PC kamu yang sudah ada)
-- ==========================================
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- Kunci mobile: kalau device PC, keluar (biar script PC yang jalan)
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
if not isMobile then
    warn("[ZETHUB] Script ini khusus mobile. Gunakan script versi PC di desktop.")
    return
end

math.randomseed(os.clock())

-- HTTP fetch ramah executor mobile (request/http_request/syn.request)
local function fetch(url)
    local req = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
    if req then
        local ok, res = pcall(req, { Url = url, Method = "GET" })
        if ok and res and res.Body then
            return res.Body
        end
    end
    return game:HttpGet(url)
end

-- Parent GUI aman (gethui / protect_gui / PlayerGui)
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

local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        inst[k] = v
    end
    return inst
end

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

-- Bersihkan splash lama
pcall(function()
    for _, v in ipairs(parentGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("ZETHUB_SPLASH") then
            v:Destroy()
        end
    end
end)

local gui = new("ScreenGui", {
    Name = "ZETHUB_SPLASH_" .. tostring(math.random(100000, 999999)),
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 9999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = parentGui
})

-- Overlay gelap full screen
local main = new("Frame", {
    Name = "Main",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = gui
})

-- Container full screen (TANPA UIScale di sini — ini bug lama mobile)
local content = new("Frame", {
    Name = "Content",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 11,
    Parent = main
})

-- ==========================================
-- SCALING MOBILE (portrait & landscape aman)
-- ==========================================
local viewport = camera.ViewportSize
local tries = 0
while (viewport.X < 100 or viewport.Y < 100) and tries < 30 do
    task.wait(0.1)
    viewport = camera.ViewportSize
    tries += 1
end
if viewport.X < 100 or viewport.Y < 100 then
    viewport = Vector2.new(1280, 720)
end

local scaleFactor = 1
local function computeScale()
    -- Basis 1280x720 biar elemen tidak terlalu kecil di HP
    local s = math.min(viewport.X / 1280, viewport.Y / 720)
    scaleFactor = math.clamp(s, 0.6, 1)
end
computeScale()

local function sc(n) return n * scaleFactor end
local function ts(n, minSize) return math.max(minSize or 10, math.floor(n * scaleFactor)) end

-- Glow kiri atas
local orb1 = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.22, 0, 0.28, 0),
    BackgroundColor3 = Color3.fromRGB(95, 55, 220),
    BackgroundTransparency = 0.93,
    BorderSizePixel = 0,
    ZIndex = 12,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = orb1 })

-- Glow kanan bawah
local orb2 = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.78, 0, 0.74, 0),
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
    Position = UDim2.new(0.5, 0, 0.40, 0),
    BackgroundTransparency = 1,
    Text = "ZETHUB",
    Font = Enum.Font.GothamBlack,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextStrokeColor3 = Color3.fromRGB(110, 70, 255),
    TextStrokeTransparency = 1,
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})
local logoScale = new("UIScale", { Scale = 0.86, Parent = logo }) -- aman: leaf element, anchor 0.5

-- Subtitle
local subtitle = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.475, 0),
    BackgroundTransparency = 1,
    Text = "Powered by Exterminate0",
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(205, 205, 220),
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})

-- Garis bawah logo
local line = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.52, 0),
    Size = UDim2.fromOffset(0, sc(3)),
    BackgroundColor3 = Color3.fromRGB(120, 80, 255),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = line })

-- Loading bar
local barBg = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.60, 0),
    BackgroundColor3 = Color3.fromRGB(24, 24, 30),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = content
})
new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = barBg })

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
    BackgroundTransparency = 1,
    Text = "0%",
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(225, 225, 235),
    TextTransparency = 1,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 15,
    Parent = content
})

-- Status
local status = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.645, 0),
    BackgroundTransparency = 1,
    Text = "Starting...",
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(180, 180, 195),
    TextTransparency = 1,
    ZIndex = 15,
    Parent = content
})

-- ==========================================
-- TERAPKAN UKURAN (dipanggil ulang saat rotasi)
-- ==========================================
local function applyScale()
    orb1.Size = UDim2.fromOffset(sc(240), sc(240))
    orb2.Size = UDim2.fromOffset(sc(280), sc(280))

    logo.Size = UDim2.fromOffset(sc(560), sc(100))
    logo.TextSize = ts(72, 30)

    subtitle.Size = UDim2.fromOffset(sc(480), sc(26))
    subtitle.TextSize = ts(17, 11)

    line.Size = UDim2.fromOffset(line.Size.X.Offset, sc(3))

    barBg.Size = UDim2.fromOffset(sc(320), sc(8))

    percent.Size = UDim2.fromOffset(sc(60), sc(20))
    percent.TextSize = ts(15, 10)
    percent.Position = UDim2.new(0.5, sc(170), 0.60, 0) -- nempel kanan bar (320/2 + 10)

    status.Size = UDim2.fromOffset(sc(520), sc(22))
    status.TextSize = ts(15, 10)
end
applyScale()

-- Auto-rescale saat layar diputar (portrait <-> landscape)
camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local vp = camera.ViewportSize
    if vp.X > 100 and vp.Y > 100 then
        viewport = vp
        computeScale()
        applyScale()
    end
end)

local splashActive = true

-- Orbs bergerak pelan
task.spawn(function()
    while splashActive and gui.Parent do
        tween(orb1, { Position = UDim2.new(0.28, 0, 0.24, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        tween(orb2, { Position = UDim2.new(0.72, 0, 0.80, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(2.2)
        if not (splashActive and gui.Parent) then break end
        tween(orb1, { Position = UDim2.new(0.20, 0, 0.32, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        tween(orb2, { Position = UDim2.new(0.80, 0, 0.70, 0) }, 2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        task.wait(2.2)
    end
end)

-- Fade in
tween(main, { BackgroundTransparency = 0.16 }, 0.55)
tween(logo, { TextTransparency = 0, TextStrokeTransparency = 0.18 }, 0.75)
tween(subtitle, { TextTransparency = 0.12 }, 0.75)
tween(logoScale, { Scale = 1 }, 0.85, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

task.wait(0.25)

tween(line, { BackgroundTransparency = 0, Size = UDim2.fromOffset(sc(240), sc(3)) }, 0.55)
tween(barBg, { BackgroundTransparency = 0.24 }, 0.45)
tween(barFill, { BackgroundTransparency = 0 }, 0.45)
tween(percent, { TextTransparency = 0.08 }, 0.45)
tween(status, { TextTransparency = 0.08 }, 0.45)

-- Preload Rayfield
local Rayfield = nil
local rayfieldReady = false

task.spawn(function()
    local ok, result = pcall(function()
        return loadstring(fetch("https://sirius.menu/rayfield"))()
    end)
    if ok then
        Rayfield = result
    end
    rayfieldReady = true
end)

-- Loading simulasi
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
task.wait(2)

setProgress(100)

-- Mobile friendly: tap layar untuk lanjut, atau auto setelah 2.5 detik
local function waitForTapOrTimeout(timeout)
    local done = false
    local conn
    conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            done = true
        end
    end)
    local t0 = os.clock()
    while not done and (os.clock() - t0) < timeout do
        task.wait(0.05)
    end
    conn:Disconnect()
end
waitForTapOrTimeout(2.5)

-- ==========================================
-- DESTROY ANIMATION
-- ==========================================
splashActive = false
local fadeTime = 1.0
local smoothStyle = Enum.EasingStyle.Quint

tween(barBg, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(barFill, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(percent, { TextTransparency = 1 }, fadeTime, smoothStyle)
tween(status, { TextTransparency = 1 }, fadeTime, smoothStyle)
task.wait(0.35)

tween(subtitle, { TextTransparency = 1 }, fadeTime, smoothStyle)
tween(line, { BackgroundTransparency = 1, Size = UDim2.fromOffset(0, sc(3)) }, fadeTime, smoothStyle)
task.wait(0.35)

tween(logo, { TextTransparency = 1, TextStrokeTransparency = 1 }, fadeTime, smoothStyle)
tween(logoScale, { Scale = 1.15 }, fadeTime, smoothStyle)
task.wait(0.45)

tween(orb1, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(orb2, { BackgroundTransparency = 1 }, fadeTime, smoothStyle)
tween(main, { BackgroundTransparency = 1 }, fadeTime + 0.4, smoothStyle)

task.wait(fadeTime + 0.5)
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
