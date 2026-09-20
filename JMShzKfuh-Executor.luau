-- ============================================
-- SCRIPT EXECUTOR EDITOR - 3 BUTTONS ALIGNED
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local plr = Players.LocalPlayer
local playerGui = plr:WaitForChild("PlayerGui")

-- ============================================
-- MAIN SCREEN GUI
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExecutorEditor"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

-- ============================================
-- NOTIFICATION SYSTEM
-- ============================================
local function showNotification(title, content, duration, color)
	local notifFrame = Instance.new("Frame")
	notifFrame.Name = "Notification"
	notifFrame.Size = UDim2.new(0, 300, 0, 70)
	notifFrame.Position = UDim2.new(1, 20, 0, 20)
	notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	notifFrame.BorderSizePixel = 0
	notifFrame.Parent = ScreenGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notifFrame
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = 2
	stroke.Parent = notifFrame
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 25)
	titleLabel.Position = UDim2.new(0, 10, 0, 8)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = color
	titleLabel.TextSize = 14
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = notifFrame
	
	local contentLabel = Instance.new("TextLabel")
	contentLabel.Size = UDim2.new(1, -20, 1, -33)
	contentLabel.Position = UDim2.new(0, 10, 0, 33)
	contentLabel.BackgroundTransparency = 1
	contentLabel.Text = content
	contentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	contentLabel.TextSize = 12
	contentLabel.Font = Enum.Font.Gotham
	contentLabel.TextXAlignment = Enum.TextXAlignment.Left
	contentLabel.TextWrapped = true
	contentLabel.Parent = notifFrame
	
	-- Animasi Masuk
	TweenService:Create(notifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -320, 0, 20)
	}):Play()
	
	-- Animasi Keluar & Hapus
	task.delay(duration, function()
		TweenService:Create(notifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 20, 0, 20),
			BackgroundTransparency = 1
		}):Play()
		task.wait(0.3)
		notifFrame:Destroy()
	end)
end

-- ============================================
-- MAIN WINDOW (COMPACT SIZE)
-- ============================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 550, 0, 360) -- Tinggi sedikit dikurangi agar lebih pas
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local Border = Instance.new("UIStroke")
Border.Color = Color3.fromRGB(80, 120, 255)
Border.Thickness = 2
Border.Transparency = 0.3
Border.Parent = MainFrame

-- ============================================
-- TITLE BAR
-- ============================================
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "Title"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🕹️ ZETHUB Executor | V-214"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 15
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -33, 0, 3)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 15
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
	TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
CloseButton.MouseButton1Click:Connect(function()
	TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	}):Play()
	task.wait(0.3)
	ScreenGui:Destroy()
end)

-- ============================================
-- SCRIPT INPUT AREA
-- ============================================
local ScriptBox = Instance.new("ScrollingFrame")
ScriptBox.Name = "ScriptBox"
ScriptBox.Size = UDim2.new(1, -20, 1, -110)
ScriptBox.Position = UDim2.new(0, 10, 0, 45)
ScriptBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScriptBox.BorderSizePixel = 0
ScriptBox.ScrollBarThickness = 5
ScriptBox.ScrollBarImageColor3 = Color3.fromRGB(80, 120, 255)
ScriptBox.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptBox.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptBox.Parent = MainFrame

local ScriptCorner = Instance.new("UICorner")
ScriptCorner.CornerRadius = UDim.new(0, 8)
ScriptCorner.Parent = ScriptBox

local ScriptPadding = Instance.new("UIPadding")
ScriptPadding.PaddingTop = UDim.new(0, 8)
ScriptPadding.PaddingBottom = UDim.new(0, 8)
ScriptPadding.PaddingLeft = UDim.new(0, 8)
ScriptPadding.PaddingRight = UDim.new(0, 8)
ScriptPadding.Parent = ScriptBox

local ScriptInput = Instance.new("TextBox")
ScriptInput.Name = "ScriptInput"
ScriptInput.Size = UDim2.new(1, -16, 0, 200)
ScriptInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScriptInput.BackgroundTransparency = 1
ScriptInput.Text = "-- Created by externimate0\nprint('Hello World!')"
ScriptInput.TextColor3 = Color3.fromRGB(200, 200, 200)
ScriptInput.TextSize = 13
ScriptInput.Font = Enum.Font.Code
ScriptInput.TextXAlignment = Enum.TextXAlignment.Left
ScriptInput.TextYAlignment = Enum.TextYAlignment.Top
ScriptInput.ClearTextOnFocus = false
ScriptInput.MultiLine = true
ScriptInput.TextWrapped = true
ScriptInput.PlaceholderText = "-- Enter your Lua script here..."
ScriptInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
ScriptInput.Parent = ScriptBox

-- ============================================
-- BUTTON CONTAINER (3 BUTTONS ALIGNED)
-- ============================================
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(1, -20, 0, 40)
ButtonContainer.Position = UDim2.new(0, 10, 1, -75)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center -- Sejajar tengah
ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ButtonLayout.Padding = UDim.new(0, 10) -- Jarak antar tombol
ButtonLayout.Parent = ButtonContainer

local function createButton(name, color, text)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 130, 0, 35) -- Lebar diperbesar sedikit agar 3 tombol proporsional
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.Parent = ButtonContainer
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn
	
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.new(math.min(color.R * 1.2, 1), math.min(color.G * 1.2, 1), math.min(color.B * 1.2, 1))
		}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
	end)
	btn.MouseButton1Down:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0, 126, 0, 33)}):Play()
	end)
	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0, 130, 0, 35)}):Play()
	end)
	
	return btn
end

-- Hanya 3 Tombol: Execute, Clear, Copy
local ExecuteButton = createButton("ExecuteButton", Color3.fromRGB(80, 200, 120), "▶ Execute")
local ClearButton = createButton("ClearButton", Color3.fromRGB(255, 150, 50), "🗑 Clear")
local CopyButton = createButton("CopyButton", Color3.fromRGB(100, 150, 255), "📋 Copy")

-- ============================================
-- ATTACHED INDICATOR
-- ============================================
local AttachedFrame = Instance.new("Frame")
AttachedFrame.Name = "AttachedIndicator"
AttachedFrame.Size = UDim2.new(0, 110, 0, 28)
AttachedFrame.Position = UDim2.new(0, 10, 1, -35)
AttachedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
AttachedFrame.BorderSizePixel = 0
AttachedFrame.Parent = MainFrame

local AttachedCorner = Instance.new("UICorner")
AttachedCorner.CornerRadius = UDim.new(0, 14)
AttachedCorner.Parent = AttachedFrame

local GreenCircle = Instance.new("Frame")
GreenCircle.Name = "GreenCircle"
GreenCircle.Size = UDim2.new(0, 10, 0, 10)
GreenCircle.Position = UDim2.new(0, 10, 0.5, -5)
GreenCircle.BackgroundColor3 = Color3.fromRGB(80, 255, 120)
GreenCircle.BorderSizePixel = 0
GreenCircle.Parent = AttachedFrame

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = GreenCircle

local CircleGlow = Instance.new("ImageLabel")
CircleGlow.Size = UDim2.new(0, 20, 0, 20)
CircleGlow.Position = UDim2.new(0, -5, 0.5, -10)
CircleGlow.BackgroundTransparency = 1
CircleGlow.Image = "rbxassetid://5554236805"
CircleGlow.ImageColor3 = Color3.fromRGB(80, 255, 120)
CircleGlow.ImageTransparency = 0.5
CircleGlow.Parent = GreenCircle

local AttachedText = Instance.new("TextLabel")
AttachedText.Size = UDim2.new(1, -28, 1, 0)
AttachedText.Position = UDim2.new(0, 26, 0, 0)
AttachedText.BackgroundTransparency = 1
AttachedText.Text = "Attached"
AttachedText.TextColor3 = Color3.fromRGB(200, 200, 200)
AttachedText.TextSize = 12
AttachedText.Font = Enum.Font.GothamBold
AttachedText.TextXAlignment = Enum.TextXAlignment.Left
AttachedText.Parent = AttachedFrame

task.spawn(function()
	while GreenCircle do
		TweenService:Create(GreenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			BackgroundColor3 = Color3.fromRGB(100, 255, 140)
		}):Play()
		task.wait(1)
		TweenService:Create(GreenCircle, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			BackgroundColor3 = Color3.fromRGB(80, 255, 120)
		}):Play()
		task.wait(1)
	end
end)

-- ============================================
-- BUTTON CALLBACKS WITH NOTIFICATIONS
-- ============================================

ExecuteButton.MouseButton1Click:Connect(function()
	local scriptText = ScriptInput.Text
	if scriptText and scriptText:gsub("%s+", "") ~= "" then
		local success, err = pcall(function()
			loadstring(scriptText)()
		end)
		
		if success then
			showNotification("Execution Success", "The script executed successfully without errors", 3, Color3.fromRGB(80, 200, 120))
		else
			showNotification("Execution Error", "Error: " .. tostring(err), 4, Color3.fromRGB(255, 80, 80))
		end
	else
		showNotification("Warning", "Blank script!, Nothing is executed", 3, Color3.fromRGB(255, 150, 50))
	end
end)

ClearButton.MouseButton1Click:Connect(function()
	ScriptInput.Text = ""
	showNotification("Cleared", "Editor script telah dibersihkan.", 2.5, Color3.fromRGB(255, 150, 50))
end)

CopyButton.MouseButton1Click:Connect(function()
	if ScriptInput.Text and ScriptInput.Text:gsub("%s+", "") ~= "" then
		local success = pcall(function()
			setclipboard(ScriptInput.Text)
		end)
		if success then
			showNotification("Copied", "Script successfully copied to clipboard", 2.5, Color3.fromRGB(100, 150, 255))
		else
			showNotification("Error", "The executor does not support setclipboard", 3, Color3.fromRGB(255, 80, 80))
		end
	else
		showNotification("Warning", "No script to copy.", 2.5, Color3.fromRGB(255, 150, 50))
	end
end)

-- ============================================
-- DRAG FUNCTIONALITY
-- ============================================
local dragging = false
local dragInput, mousePos, framePos

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = MainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		MainFrame.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end)

-- ============================================
-- ANIMASI OPENING
-- ============================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 550, 0, 360),
	Position = UDim2.new(0.5, -275, 0.5, -180)
}):Play()

task.spawn(function()
	while Border do
		TweenService:Create(Border, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Transparency = 0.5
		}):Play()
		task.wait(2)
		TweenService:Create(Border, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Transparency = 0.2
		}):Play()
		task.wait(2)
	end
end)

-- Notifikasi selamat datang
task.wait(0.5)
showNotification("System Ready", "Script Executor successfully To Loaded", 3, Color3.fromRGB(80, 200, 120))
