local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeyGeneratorUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999 -- Paling depan dari UI lain
ScreenGui.Parent = playerGui


-- Main Frame (Ukuran compact seperti sebelumnya)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 260)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Stroke
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(45, 45, 45)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Dark Overlay
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.Parent = MainFrame

-- ============ PARTICLE CONTAINER ============
local ParticleContainer = Instance.new("Frame")
ParticleContainer.Name = "Particles"
ParticleContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleContainer.BackgroundTransparency = 1
ParticleContainer.ClipsDescendants = true
ParticleContainer.Parent = MainFrame

-- Partikel GARIS PUTIH TURUN
for i = 1, 20 do
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(0, 1, 0, math.random(30, 70))
    Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Line.BorderSizePixel = 0
    Line.AnchorPoint = Vector2.new(0.5, 0)
    Line.Position = UDim2.new(math.random() * 0.95 + 0.025, 0, -0.15, 0)
    Line.BackgroundTransparency = 0.6
    Line.Parent = ParticleContainer
    
    spawn(function()
        while Line.Parent do
            local duration = math.random(5, 10)
            local tween = TweenService:Create(Line, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                Position = UDim2.new(Line.Position.X.Scale, 0, 1.2, 0)
            })
            tween:Play()
            tween.Completed:Wait()
            Line.Position = UDim2.new(math.random() * 0.95 + 0.025, 0, -0.15, 0)
        end
    end)
end

-- Partikel TITIK UNGU
for i = 1, 15 do
    local Particle = Instance.new("Frame")
    Particle.Size = UDim2.new(0, 2, 0, 2)
    Particle.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
    Particle.BorderSizePixel = 0
    Particle.AnchorPoint = Vector2.new(0.5, 0.5)
    Particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Particle.Parent = ParticleContainer
    
    local ParticleCorner = Instance.new("UICorner")
    ParticleCorner.CornerRadius = UDim.new(1, 0)
    ParticleCorner.Parent = Particle
    
    spawn(function()
        while Particle.Parent do
            local tween = TweenService:Create(Particle, TweenInfo.new(math.random(4, 7), Enum.EasingStyle.Linear), {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundTransparency = math.random(0, 6) / 10
            })
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

-- ============ TITLE & SUBTITLE (CENTERED) ============
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 32)
Title.Position = UDim2.new(0, 20, 0, 20)
Title.BackgroundTransparency = 1
Title.Text = "KEY GENERATOR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 26
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = MainFrame

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -40, 0, 18)
Subtitle.Position = UDim2.new(0, 20, 0, 52)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Generate and copy your unique access key"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 12
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.Parent = MainFrame

-- ============ KEY INPUT ============
local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(1, -40, 0, 40)
InputFrame.Position = UDim2.new(0, 20, 0, 85)
InputFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 7)
InputCorner.Parent = InputFrame

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(55, 55, 55)
InputStroke.Thickness = 1
InputStroke.Parent = InputFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Text = ""
KeyInput.PlaceholderText = "Generated key will appear here..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
KeyInput.TextColor3 = Color3.fromRGB(220, 220, 220)
KeyInput.TextSize = 13
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextXAlignment = Enum.TextXAlignment.Center
KeyInput.Parent = InputFrame

-- Input focus effects
KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(120, 60, 220)
    }):Play()
end)

KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {
        Color = Color3.fromRGB(55, 55, 55)
    }):Play()
end)

-- ============ STATUS LABEL ============
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 22)
StatusLabel.Position = UDim2.new(0, 20, 0, 135)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

-- ============ GENERATE BUTTON ============
local GenerateBtn = Instance.new("TextButton")
GenerateBtn.Size = UDim2.new(1, -40, 0, 45)
GenerateBtn.Position = UDim2.new(0, 20, 0, 165)
GenerateBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
GenerateBtn.Text = "⏳ WAIT 90s..."
GenerateBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
GenerateBtn.TextSize = 15
GenerateBtn.Font = Enum.Font.GothamBold
GenerateBtn.BorderSizePixel = 0
GenerateBtn.Parent = MainFrame
GenerateBtn.Active = false -- Button tidak bisa diklik dulu
GenerateBtn.AutoButtonColor = false

local GenerateCorner = Instance.new("UICorner")
GenerateCorner.CornerRadius = UDim.new(0, 7)
GenerateCorner.Parent = GenerateBtn

local GenerateStroke = Instance.new("UIStroke")
GenerateStroke.Color = Color3.fromRGB(75, 75, 75)
GenerateStroke.Thickness = 1
GenerateStroke.Parent = GenerateBtn

-- Created by Text
local CreatedByText = Instance.new("TextLabel")
CreatedByText.Size = UDim2.new(1, -40, 0, 18)
CreatedByText.Position = UDim2.new(0, 20, 0, 225)
CreatedByText.BackgroundTransparency = 1
CreatedByText.Text = "Created By Exterminate0"
CreatedByText.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatedByText.TextSize = 11
CreatedByText.Font = Enum.Font.GothamBold
CreatedByText.TextXAlignment = Enum.TextXAlignment.Center
CreatedByText.Parent = MainFrame

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.TextSize = 15
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(90, 45, 45)
CloseStroke.Thickness = 1
CloseStroke.Parent = CloseBtn

-- ============ HOVER & CLICK EFFECTS ============
local function addHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        if button.Active then
            TweenService:Create(button, TweenInfo.new(0.15), {
                BackgroundColor3 = hoverColor
            }):Play()
        end
    end)
    button.MouseLeave:Connect(function()
        if button.Active then
            TweenService:Create(button, TweenInfo.new(0.15), {
                BackgroundColor3 = normalColor
            }):Play()
        end
    end)
end

addHoverEffect(GenerateBtn, Color3.fromRGB(55, 55, 55), Color3.fromRGB(38, 38, 38))
addHoverEffect(CloseBtn, Color3.fromRGB(70, 35, 35), Color3.fromRGB(45, 25, 25))

local function addClickEffect(button)
    button.MouseButton1Click:Connect(function()
        if button.Active then
            local originalSize = button.Size
            TweenService:Create(button, TweenInfo.new(0.08), {
                Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 4, originalSize.Y.Scale, originalSize.Y.Offset - 4)
            }):Play()
            task.wait(0.08)
            TweenService:Create(button, TweenInfo.new(0.08), {
                Size = originalSize
            }):Play()
        end
    end)
end

addClickEffect(GenerateBtn)
addClickEffect(CloseBtn)

-- ============ RANDOM KEY GENERATOR (Format: KEY-XXXXXX-XXXXXX-XXXXXX) ============
local function generateRandomString(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = ""
    for i = 1, length do
        local randIndex = math.random(1, #chars)
        result = result .. string.sub(chars, randIndex, randIndex)
    end
    return result
end

local function generateSecureKey()
    -- Format: KEY-XXXXXX-XXXXXX-XXXXXX (3 bagian, masing-masing 6 karakter)
    local part1 = generateRandomString(6)
    local part2 = generateRandomString(6)
    local part3 = generateRandomString(6)
    return "KEY-" .. part1 .. "-" .. part2 .. "-" .. part3
end

-- ============ 10 DETIK WAIT SYSTEM (Hanya di Button) ============
local canGenerate = false
local loadingTime = 120 -- detik

task.spawn(function()
    for i = 1, loadingTime do
        local remaining = loadingTime - i
        
        -- Update text di button saja
        if remaining > 0 then
            GenerateBtn.Text = "⏳ WAIT " .. remaining .. "s..."
        end
        
        task.wait(1)
    end
    
    -- Selesai loading
    canGenerate = true
    GenerateBtn.Active = true
    GenerateBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    GenerateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GenerateBtn.Text = "⚡ GENERATE KEY"
end)

-- ============ GENERATE KEY FUNCTION ============
GenerateBtn.MouseButton1Click:Connect(function()
    if not canGenerate then
        StatusLabel.Text = "⚠️ Please wait for the timer!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    StatusLabel.Text = "⏳ Generating secure key..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    task.wait(0.5) -- Simulasi loading
    
    -- Generate Key dengan format baru
    local newKey = generateSecureKey()
    
    KeyInput.Text = newKey
    
    -- Copy ke clipboard
    if setclipboard then
        setclipboard(newKey)
        StatusLabel.Text = "✓ Key generated & copied to clipboard!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StatusLabel.Text = "✓ Key generated! (Clipboard not available)"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
    
    GenerateBtn.Text = "✓ COPIED"
    GenerateBtn.BackgroundColor3 = Color3.fromRGB(25, 90, 25)
    
    task.wait(3)
    GenerateBtn.Text = "⚡ GENERATE KEY"
    GenerateBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
end)

-- ============ CLOSE BUTTON ============
CloseBtn.MouseButton1Click:Connect(function()
    local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.25), {
        BackgroundTransparency = 1
    })
    fadeTween:Play()
    
    for _, child in pairs(MainFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            pcall(function()
                TweenService:Create(child, TweenInfo.new(0.25), {
                    BackgroundTransparency = 1,
                    TextTransparency = 1,
                    ImageTransparency = 1
                }):Play()
            end)
        end
    end
    
    task.wait(0.3)
    
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
    
    print("✓ Key Generator closed!")
end)

-- ============ DRAGGABLE ============
local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============ ENTRANCE ANIMATION ============
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -180)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.5, -225, 0.5, -130),
    BackgroundTransparency = 0
}):Play()
