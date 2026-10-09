-- ==========================================
-- ZETHUB // NEON CYBER GLASS LOADING SCREEN
-- ★ PC ONLY - BULLETPROOF EDITION ★
-- FIX: Background solid, Blur optional, Fallback lengkap
-- ==========================================

local lastExecution = _G.ZETHUB_SPLASH_PC_LAST_EXEC or 0
local currentTime = os.clock()

if (currentTime - lastExecution) < 30 then
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/eaDnYiUk-CheckingV2.luau"))()
    end)
    return
end
_G.ZETHUB_SPLASH_PC_LAST_EXEC = currentTime

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- Kunci PC
if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
    warn("[ZETHUB] Script ini khusus PC.")
    return
end

math.randomseed(os.clock() * 1000)

local function getGuiParent()
    local ok, hui = pcall(gethui)
    if ok and hui then return hui end
    if syn and syn.protect_gui then return game:GetService("CoreGui") end
    return player:WaitForChild("PlayerGui")
end
local parentGui = getGuiParent()

-- Safe Instance Creator
local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do
        pcall(function() inst[k] = v end)
    end
    return inst
end

-- Ultra-Safe Optional Creator
local function tryNew(class, props)
    local inst = nil
    local ok = pcall(function()
        inst = Instance.new(class)
        for k, v in pairs(props or {}) do
            pcall(function() inst[k] = v end)
        end
    end)
    if ok and inst then return inst
    else
        if inst then pcall(function() inst:Destroy() end) end
        return nil
    end
end

local function tween(obj, props, duration, style, direction)
    if not obj or not obj.Parent then return nil end
    local info = TweenInfo.new(duration, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function loopTween(obj, props, duration)
    if not obj or not obj.Parent then return nil end
    local info = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- Bersihkan splash lama
pcall(function()
    for _, v in ipairs(parentGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name:find("ZETHUB_CYBER") then v:Destroy() end
    end
end)

local gui = new("ScreenGui", {
    Name = "ZETHUB_CYBER_" .. tostring(math.random(100000, 999999)),
    ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 9999999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = parentGui
})

-- Scaling Adaptif
local viewport = camera.ViewportSize
local tries = 0
while (viewport.X < 100 or viewport.Y < 100) and tries < 30 do
    task.wait(0.1)
    viewport = camera.ViewportSize
    tries += 1
end
if viewport.X < 100 or viewport.Y < 100 then viewport = Vector2.new(1920, 1080) end

local scaleFactor = 1
local function computeScale() scaleFactor = math.clamp(math.min(viewport.X / 1920, viewport.Y / 1080), 0.7, 1.5) end
computeScale()
local function sc(n) return n * scaleFactor end
local function ts(n, minSize) return math.max(minSize or 10, math.floor(n * scaleFactor)) end

-- Palette Neon Cyber
local BG_DARK = Color3.fromRGB(10, 12, 20)
local CYAN = Color3.fromRGB(0, 229, 255)
local PINK = Color3.fromRGB(255, 0, 128)
local PURPLE = Color3.fromRGB(138, 43, 226)
local WHITE = Color3.fromRGB(240, 248, 255)
local GLASS_BG = Color3.fromRGB(20, 25, 40)

local splashActive = true

-- ==========================================
-- 1. BACKGROUND OVERLAY (SOLID - PASTI KELIHATAN)
-- ==========================================
local bgOverlay = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = BG_DARK,
    BackgroundTransparency = 0.15, -- Hampir solid, pasti terlihat
    ZIndex = 1,
    Parent = gui
})

-- Gradient overlay untuk depth
local bgGradient = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 8, 15)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 20, 35)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 8, 15))
    }),
    Rotation = 45,
    Parent = bgOverlay
})

-- Vignette effect
local vignette = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 2,
    Parent = gui
})
new("UIGradient", {
    Color = ColorSequence.new(Color3.fromRGB(0,0,0), Color3.fromRGB(0,0,0)),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 0.85)
    }),
    Parent = vignette
})

-- ==========================================
-- 2. ANIMATED GRID BACKGROUND
-- ==========================================
local gridContainer = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 3,
    Parent = gui
})

-- Grid lines horizontal
for i = 1, 20 do
    local line = new("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, i / 20, 0),
        BackgroundColor3 = CYAN,
        BackgroundTransparency = 0.95,
        ZIndex = 3,
        Parent = gridContainer
    })
end

-- Grid lines vertical
for i = 1, 30 do
    local line = new("Frame", {
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(i / 30, 0, 0, 0),
        BackgroundColor3 = CYAN,
        BackgroundTransparency = 0.95,
        ZIndex = 3,
        Parent = gridContainer
    })
end

-- ==========================================
-- 3. FLOATING PARTICLES
-- ==========================================
local particleContainer = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 4,
    Parent = gui
})

local particleColors = {CYAN, PINK, PURPLE, WHITE}

task.spawn(function()
    while splashActive and gui.Parent do
        local size = math.random(2, 6)
        local p = new("Frame", {
            Size = UDim2.fromOffset(sc(size), sc(size)),
            BackgroundColor3 = particleColors[math.random(1, #particleColors)],
            BackgroundTransparency = 1,
            ZIndex = 4,
            Parent = particleContainer
        })
        new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = p})

        local startX = math.random(0, math.floor(viewport.X))
        local startY = viewport.Y + 50
        p.Position = UDim2.fromOffset(startX, startY)

        tween(p, {BackgroundTransparency = 0.4}, 0.8)
        tween(p, {
            Position = UDim2.fromOffset(startX + math.random(-200, 200), -50),
            BackgroundTransparency = 1
        }, math.random(5, 10), Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        task.wait(math.random(6, 12))
        if p and p.Parent then p:Destroy() end
        task.wait(0.1)
    end
end)

-- ==========================================
-- 4. MAIN CARD (GLASS EFFECT)
-- ==========================================
local cardHolder = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(sc(700), sc(420)),
    BackgroundTransparency = 1,
    ZIndex = 10,
    Parent = gui
})

local cardScale = new("UIScale", {Scale = 0.85, Parent = cardHolder})

local card = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = GLASS_BG,
    BackgroundTransparency = 0.2, -- Glass effect
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = cardHolder
})
new("UICorner", {CornerRadius = UDim.new(0, sc(16)), Parent = card})

-- Blur (Optional - kalau gagal, card tetap terlihat karena background solid)
local cardBlur = tryNew("UIBlur", {Size = sc(20), Transparency = 0.2, Parent = card})

-- Neon Border (Cyan to Pink gradient)
local cardBorder = tryNew("UIStroke", {
    Thickness = sc(2),
    Color = CYAN,
    Transparency = 0.3,
    Parent = card
})

if cardBorder then
    local borderGrad = new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, CYAN),
            ColorSequenceKeypoint.new(0.5, PINK),
            ColorSequenceKeypoint.new(1, CYAN)
        }),
        Parent = cardBorder
    })
    loopTween(borderGrad, {Rotation = 360}, 4)
end

-- Inner glow effect
local innerGlow = new("UIStroke", {
    Thickness = sc(15),
    Color = CYAN,
    Transparency = 0.92,
    Parent = card
})
new("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.6),
        NumberSequenceKeypoint.new(1, 1)
    }),
    Parent = innerGlow
})

-- ==========================================
-- 5. LOGO & TITLE
-- ==========================================
local logo = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.20, 0),
    Size = UDim2.fromOffset(sc(500), sc(80)),
    BackgroundTransparency = 1,
    Text = "ZETHUB",
    Font = Enum.Font.GothamBlack,
    TextSize = ts(72, 32),
    TextColor3 = WHITE,
    TextTransparency = 1,
    ZIndex = 12,
    Parent = card
})

-- Logo gradient
local logoGrad = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, CYAN),
        ColorSequenceKeypoint.new(0.5, WHITE),
        ColorSequenceKeypoint.new(1, PINK)
    }),
    Rotation = 45,
    Parent = logo
})

-- Shimmer effect
local shimmer = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
        ColorSequenceKeypoint.new(1, Color3.new(1,1,1))
    }),
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.4, 1),
        NumberSequenceKeypoint.new(0.5, 0.2),
        NumberSequenceKeypoint.new(0.6, 1),
        NumberSequenceKeypoint.new(1, 1)
    }),
    Offset = Vector2.new(-1, 0),
    Parent = logo
})
loopTween(shimmer, {Offset = Vector2.new(1, 0)}, 3)

-- Subtitle
local subtitle = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.34, 0),
    Size = UDim2.fromOffset(sc(400), sc(28)),
    BackgroundTransparency = 1,
    Text = "NEON CYBER EDITION",
    Font = Enum.Font.Gotham,
    TextSize = ts(16, 10),
    TextColor3 = CYAN,
    TextTransparency = 1,
    ZIndex = 12,
    Parent = card
})

-- ==========================================
-- 6. LOADING SPINNER
-- ==========================================
local loaderHolder = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.55, 0),
    Size = UDim2.fromOffset(sc(140), sc(140)),
    BackgroundTransparency = 1,
    ZIndex = 12,
    Parent = card
})

-- Outer ring
local outerRing = new("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 12,
    Parent = loaderHolder
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = outerRing})
local outerStroke = new("UIStroke", {
    Thickness = sc(4),
    Color = CYAN,
    Transparency = 0.3,
    Parent = outerRing
})
new("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0),
        NumberSequenceKeypoint.new(1, 1)
    }),
    Rotation = 90,
    Parent = outerStroke
})
loopTween(outerRing, {Rotation = 360}, 2)

-- Inner ring
local innerRing = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(sc(100), sc(100)),
    BackgroundTransparency = 1,
    ZIndex = 12,
    Parent = loaderHolder
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = innerRing})
local innerStroke = new("UIStroke", {
    Thickness = sc(3),
    Color = PINK,
    Transparency = 0.3,
    Parent = innerRing
})
new("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0),
        NumberSequenceKeypoint.new(1, 1)
    }),
    Rotation = 90,
    Parent = innerStroke
})
loopTween(innerRing, {Rotation = -360}, 1.5)

-- Center dot
local centerDot = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(sc(20), sc(20)),
    BackgroundColor3 = WHITE,
    BackgroundTransparency = 0.3,
    ZIndex = 12,
    Parent = loaderHolder
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = centerDot})

-- Pulse animation
local pulseInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
TweenService:Create(centerDot, pulseInfo, {
    BackgroundTransparency = 0.8,
    Size = UDim2.fromOffset(sc(30), sc(30))
}):Play()

-- Percent text
local percentText = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(sc(100), sc(50)),
    BackgroundTransparency = 1,
    Text = "0%",
    Font = Enum.Font.GothamBold,
    TextSize = ts(32, 16),
    TextColor3 = WHITE,
    TextTransparency = 1,
    ZIndex = 13,
    Parent = loaderHolder
})

-- ==========================================
-- 7. PROGRESS BAR
-- ==========================================
local barBg = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.76, 0),
    Size = UDim2.fromOffset(sc(500), sc(8)),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9,
    BorderSizePixel = 0,
    ZIndex = 12,
    Parent = card
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = barBg})

local barFill = new("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = CYAN,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    ZIndex = 13,
    Parent = barBg
})
new("UICorner", {CornerRadius = UDim.new(1, 0), Parent = barFill})

local barGrad = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, CYAN),
        ColorSequenceKeypoint.new(0.5, PINK),
        ColorSequenceKeypoint.new(1, CYAN)
    }),
    Parent = barFill
})
loopTween(barGrad, {Offset = Vector2.new(1, 0)}, 2)

-- ==========================================
-- 8. STATUS TEXT
-- ==========================================
local status = new("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.88, 0),
    Size = UDim2.fromOffset(sc(600), sc(28)),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.Code,
    TextSize = ts(15, 10),
    TextColor3 = CYAN,
    TextTransparency = 1,
    ZIndex = 12,
    Parent = card
})

-- ==========================================
-- 9. RESCALE HANDLER
-- ==========================================
local function applyScale()
    cardHolder.Size = UDim2.fromOffset(sc(700), sc(420))
    logo.Size = UDim2.fromOffset(sc(500), sc(80)); logo.TextSize = ts(72, 32)
    subtitle.Size = UDim2.fromOffset(sc(400), sc(28)); subtitle.TextSize = ts(16, 10)
    loaderHolder.Size = UDim2.fromOffset(sc(140), sc(140))
    percentText.Size = UDim2.fromOffset(sc(100), sc(50)); percentText.TextSize = ts(32, 16)
    barBg.Size = UDim2.fromOffset(sc(500), sc(8))
    status.Size = UDim2.fromOffset(sc(600), sc(28)); status.TextSize = ts(15, 10)
    if cardBorder then cardBorder.Thickness = sc(2) end
end
applyScale()

camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local vp = camera.ViewportSize
    if vp.X > 100 and vp.Y > 100 then
        viewport = vp
        computeScale()
        applyScale()
    end
end)

-- ==========================================
-- 10. TYPEWRITER FUNCTION
-- ==========================================
local function typewriter(label, text, charsPerSec)
    label.Text = ""
    for i = 1, #text do
        if not gui.Parent then return end
        label.Text = text:sub(1, i)
        task.wait(1 / charsPerSec)
    end
end

-- ==========================================
-- 11. ENTRANCE ANIMATION
-- ==========================================
tween(bgOverlay, {BackgroundTransparency = 0.15}, 1)
task.wait(0.2)

tween(cardScale, {Scale = 1}, 1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
task.wait(0.3)

tween(logo, {TextTransparency = 0}, 0.8)
tween(subtitle, {TextTransparency = 0.2}, 0.8)
task.wait(0.2)

tween(percentText, {TextTransparency = 0}, 0.6)
tween(status, {TextTransparency = 0}, 0.6)
tween(barBg, {BackgroundTransparency = 0.9}, 0.6)
tween(barFill, {BackgroundTransparency = 0.2}, 0.6)
task.wait(0.8)

-- ==========================================
-- 12. LOADING LOGIC
-- ==========================================
local TargetScriptReady = false
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
        TargetScriptReady = true
    end)
end)

local progress = 0
local function setProgress(value)
    value = math.clamp(value, 0, 100)
    tween(barFill, {Size = UDim2.fromScale(value / 100, 1)}, 0.3)
    percentText.Text = math.floor(value) .. "%"
end

local messages = {
    "> INITIALIZING NEON CORE...",
    "> LOADING CYBER MODULES...",
    "> CONNECTING TO NETWORK...",
    "> COMPILING INTERFACE...",
    "> FINALIZING SYSTEM..."
}

for _, msg in ipairs(messages) do
    task.spawn(typewriter, status, msg, 50)
    for _ = 1, math.random(4, 7) do
        progress = math.min(98, progress + math.random(2, 6))
        setProgress(progress)
        task.wait(math.random(10, 25) / 100)
    end
end

setProgress(99)
task.spawn(typewriter, status, "> WAITING FOR SYSTEM...", 50)

while not TargetScriptReady do task.wait(0.5) end

task.spawn(typewriter, status, "> SYSTEM ONLINE. WELCOME.", 60)
task.wait(1)
setProgress(100)
task.wait(1.5)

-- ==========================================
-- 13. EXIT ANIMATION
-- ==========================================
splashActive = false

tween(cardScale, {Scale = 0.9}, 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
tween(card, {BackgroundTransparency = 1}, 0.5)
tween(logo, {TextTransparency = 1}, 0.4)
tween(subtitle, {TextTransparency = 1}, 0.4)
tween(percentText, {TextTransparency = 1}, 0.4)
tween(status, {TextTransparency = 1}, 0.4)
tween(barBg, {BackgroundTransparency = 1}, 0.4)
tween(barFill, {BackgroundTransparency = 1}, 0.4)
tween(bgOverlay, {BackgroundTransparency = 1}, 0.8)

task.wait(0.8)
gui:Destroy()

-- ==========================================
-- 14. EXECUTE TARGET SCRIPT
-- ==========================================
local success, errorMessage = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/eaDnYiUk-CheckingV2.luau"))()
end)
if not success then warn("[System] Failed to load script:", errorMessage) end
