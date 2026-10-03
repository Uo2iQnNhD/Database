--[[ MONKE HUB V3.4 - Fixed bottom clipping & corner poke ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Library = {
	Accent = Color3.fromRGB(124, 96, 255),
	Rainbow = true,
	ToggleKey = Enum.KeyCode.RightShift,
	Open = true,
}

local Theme = {
	Background = Color3.fromRGB(15, 15, 19),
	Sidebar = Color3.fromRGB(20, 20, 25),
	Element = Color3.fromRGB(27, 27, 34),
	ElementHover = Color3.fromRGB(35, 35, 44),
	Border = Color3.fromRGB(42, 42, 52),
	Text = Color3.fromRGB(238, 238, 244),
	SubText = Color3.fromRGB(148, 148, 160),
}

local function Tween(obj, dur, props, style, dir)
	local tw = TweenService:Create(obj, TweenInfo.new(dur or .3, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end
local function Corner(p, r) local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, r or 7) c.Parent = p return c end
local function Stroke(p, col, th) local s = Instance.new("UIStroke") s.Color = col or Theme.Border s.Thickness = th or 1 s.Parent = p return s end
local function Pad(p, t, l, b, r) local d = Instance.new("UIPadding") d.PaddingTop = UDim.new(0,t or 0) d.PaddingLeft = UDim.new(0,l or 0) d.PaddingBottom = UDim.new(0,b or 0) d.PaddingRight = UDim.new(0,r or 0) d.Parent = p return d end

--// Manual FPS counter
local fpsFrames, fpsLast = 0, os.clock()
RunService.RenderStepped:Connect(function() fpsFrames = fpsFrames + 1 end)

--// RGB Moving Border Engine
local rgbGradients = {}
local function rainbowSeq()
	local kp = {}
	for i = 0, 6 do table.insert(kp, ColorSequenceKeypoint.new(i/6, Color3.fromHSV(i/6, 1, 1))) end
	table.insert(kp, ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 1, 1)))
	return ColorSequence.new(kp)
end
local function accentSeq(c)
	return ColorSequence.new{
		ColorSequenceKeypoint.new(0, c:Lerp(Color3.new(0,0,0), .45)),
		ColorSequenceKeypoint.new(.5, c:Lerp(Color3.new(1,1,1), .2)),
		ColorSequenceKeypoint.new(1, c:Lerp(Color3.new(0,0,0), .45)),
	}
end
local function refreshRGBColors()
	for _, g in ipairs(rgbGradients) do
		g.Color = Library.Rainbow and rainbowSeq() or accentSeq(Library.Accent)
	end
end
local function registerRGB(parent)
	local g = Instance.new("UIGradient")
	g.Color = Library.Rainbow and rainbowSeq() or accentSeq(Library.Accent)
	g.Rotation = 35
	g.Parent = parent
	table.insert(rgbGradients, g)
	return g
end
RunService.RenderStepped:Connect(function()
	local off = (os.clock() * 0.18) % 1
	for i = #rgbGradients, 1, -1 do
		local g = rgbGradients[i]
		if g.Parent then g.Offset = Vector2.new(off, 0) else table.remove(rgbGradients, i) end
	end
end)
function Library:SetRainbow(on) Library.Rainbow = on refreshRGBColors() end
function Library:SetAccent(c) Library.Accent = c refreshRGBColors() end

--// Notification GUI
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "MonkeNotifies"
NotifGui.ResetOnSpawn = false
NotifGui.DisplayOrder = 999
NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() NotifGui.Parent = game:GetService("CoreGui") end)
if not NotifGui.Parent then NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local notifyContainer = Instance.new("Frame")
notifyContainer.Size = UDim2.new(0, 280, 1, -30)
notifyContainer.Position = UDim2.new(1, -292, 0, 15)
notifyContainer.BackgroundTransparency = 1
notifyContainer.Parent = NotifGui
local notifyList = Instance.new("UIListLayout")
notifyList.SortOrder = Enum.SortOrder.LayoutOrder
notifyList.Padding = UDim.new(0, 8)
notifyList.Parent = notifyContainer
local notifyOrder = 0

function Library:Notify(text, duration, title)
	duration = duration or 5
	notifyOrder -= 1
	local n = Instance.new("Frame")
	n.Size = UDim2.new(1, 0, 0, 48)
	n.LayoutOrder = notifyOrder
	n.BackgroundColor3 = Theme.Element
	n.BorderSizePixel = 0
	n.Parent = notifyContainer
	Corner(n, 8)
	registerRGB(Stroke(n, Color3.new(1,1,1), 1.5))
	local dot = Instance.new("Frame")
	dot.Size = UDim2.new(0, 4, 0, 24)
	dot.Position = UDim2.new(0, 8, 0.5, -12)
	dot.BackgroundColor3 = Library.Accent
	dot.BorderSizePixel = 0
	dot.Parent = n
	Corner(dot, 2)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -24, 1, title and -14 or 0)
	lbl.Position = UDim2.new(0, 18, 0, title and 14 or 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Theme.Text
	lbl.TextSize = 12
	lbl.Font = Enum.Font.Gotham
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextWrapped = true
	lbl.Parent = n
	if title then
		local t = Instance.new("TextLabel")
		t.Size = UDim2.new(1, -24, 0, 14)
		t.Position = UDim2.new(0, 18, 0, 5)
		t.BackgroundTransparency = 1
		t.Text = title
		t.TextColor3 = Library.Accent
		t.TextSize = 12
		t.Font = Enum.Font.GothamBold
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.Parent = n
	end
	n.Position = UDim2.new(1, 30, 0, 0)
	Tween(n, .45, {Position = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	task.delay(duration, function()
		Tween(n, .4, {Position = UDim2.new(1, 30, 0, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In).Completed:Connect(function() n:Destroy() end)
	end)
end

--// Window
function Library:CreateWindow(config)
	config = config or {}
	local title = config.Title or "Monke Hub"
	local subtitle = config.Subtitle or "V3 • Premium"
	local OPEN_SIZE = UDim2.new(0, 560, 0, 400)

	local gui = Instance.new("ScreenGui")
	gui.Name = "MonkeHubV3"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 998
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() gui.Parent = game:GetService("CoreGui") end)
	if not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local main = Instance.new("Frame")
	main.Name = "Main"
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Position = UDim2.new(0.5, 0, 0.5, 0)
	main.Size = OPEN_SIZE
	main.BackgroundColor3 = Theme.Background
	main.BorderSizePixel = 0
	main.ClipsDescendants = true
	main.Active = true
	main.ZIndex = 40
	main.Parent = gui
	Corner(main, 10)
	registerRGB(Stroke(main, Color3.new(1,1,1), 2))

	-- Topbar
	local topbar = Instance.new("Frame")
	topbar.Size = UDim2.new(1, 0, 0, 46)
	topbar.BackgroundTransparency = 1
	topbar.ZIndex = 45
	topbar.Parent = main
	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(0.6, 0, 0, 18)
	titleLbl.Position = UDim2.new(0, 16, 0, 7)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = title
	titleLbl.TextColor3 = Theme.Text
	titleLbl.TextSize = 15
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.Parent = topbar
	local subLbl = Instance.new("TextLabel")
	subLbl.Size = UDim2.new(0.6, 0, 0, 14)
	subLbl.Position = UDim2.new(0, 16, 0, 25)
	subLbl.BackgroundTransparency = 1
	subLbl.Text = subtitle
	subLbl.TextColor3 = Theme.SubText
	subLbl.TextSize = 11
	subLbl.Font = Enum.Font.Gotham
	subLbl.TextXAlignment = Enum.TextXAlignment.Left
	subLbl.Parent = topbar

	local function iconButton(xoff, kind)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0, 26, 0, 26)
		b.Position = UDim2.new(1, xoff, 0.5, -13)
		b.BackgroundColor3 = Theme.Element
		b.BorderSizePixel = 0
		b.Text = ""
		b.AutoButtonColor = false
		b.Parent = topbar
		Corner(b, 6)
		if kind == "close" then
			for _, rot in ipairs({45, -45}) do
				local l = Instance.new("Frame")
				l.Size = UDim2.new(0, 12, 0, 2)
				l.Position = UDim2.new(0.5, -6, 0.5, -1)
				l.Rotation = rot
				l.BackgroundColor3 = Theme.SubText
				l.BorderSizePixel = 0
				l.Parent = b
			end
			b.MouseEnter:Connect(function() Tween(b, .2, {BackgroundColor3 = Color3.fromRGB(225, 70, 70)}) end)
			b.MouseLeave:Connect(function() Tween(b, .2, {BackgroundColor3 = Theme.Element}) end)
		else
			local l = Instance.new("Frame")
			l.Size = UDim2.new(0, 12, 0, 2)
			l.Position = UDim2.new(0.5, -6, 0.5, -1)
			l.BackgroundColor3 = Theme.SubText
			l.BorderSizePixel = 0
			l.Parent = b
			b.MouseEnter:Connect(function() Tween(b, .2, {BackgroundColor3 = Theme.ElementHover}) end)
			b.MouseLeave:Connect(function() Tween(b, .2, {BackgroundColor3 = Theme.Element}) end)
		end
		return b
	end
	local minimizeBtn = iconButton(-62, "min")
	local closeBtn = iconButton(-32, "close")

	local window = { accent = config.Accent or Library.Accent, listeners = {}, offset = Vector2.new(0, 0) }
	function window:onAccent(fn) table.insert(self.listeners, fn) fn(self.accent) end
	function window:SetAccent(c) self.accent = c for _, fn in ipairs(self.listeners) do fn(c) end end

	-- Dragging window
	local dragging, dragStart, dragOrig
	topbar.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = inp.Position; dragOrig = window.offset
		end
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local d = inp.Position - dragStart
			local vp = workspace.CurrentCamera.ViewportSize
			local x = math.clamp(dragOrig.X + d.X, -(vp.X/2 - 80), vp.X/2 - 80)
			local y = math.clamp(dragOrig.Y + d.Y, -(vp.Y/2 - 60), vp.Y/2 - 60)
			window.offset = Vector2.new(x, y)
			main.Position = UDim2.new(0.5, x, 0.5, y)
		end
	end)

	-- Sidebar (FIX V3.4: corner sendiri agar siku tidak menonjol keluar lengkungan window)
	local sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, 150, 1, -46)
	sidebar.Position = UDim2.new(0, 0, 0, 46)
	sidebar.BackgroundColor3 = Theme.Sidebar
	sidebar.BorderSizePixel = 0
	sidebar.ZIndex = 41
	sidebar.Parent = main
	Corner(sidebar, 10)
	-- Strip penutup: membuat sudut ATAS sidebar tetap siku rapi (menyatu dengan topbar)
	local sideTop = Instance.new("Frame")
	sideTop.Size = UDim2.new(1, 0, 0, 12)
	sideTop.Position = UDim2.new(0, 0, 0, 46)
	sideTop.BackgroundColor3 = Theme.Sidebar
	sideTop.BorderSizePixel = 0
	sideTop.ZIndex = 41
	sideTop.Parent = main
	local sideList = Instance.new("UIListLayout")
	sideList.SortOrder = Enum.SortOrder.LayoutOrder
	sideList.Padding = UDim.new(0, 5)
	sideList.Parent = sidebar
	Pad(sidebar, 10, 8, 10, 8)

	-- Content (FIX V3.4: inset bawah 12px agar elemen terakhir tidak terpotong border)
	local content = Instance.new("ScrollingFrame")
	content.Size = UDim2.new(1, -150, 1, -58)
	content.Position = UDim2.new(0, 150, 0, 46)
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.ScrollBarThickness = 3
	content.ScrollBarImageColor3 = window.accent
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.CanvasSize = UDim2.new(0, 0, 0, 0)
	content.ZIndex = 41
	content.Parent = main
	window:onAccent(function(c) content.ScrollBarImageColor3 = c end)

	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -24, 0, 0)
	container.Position = UDim2.new(0, 12, 0, 10)
	container.BackgroundTransparency = 1
	container.AutomaticSize = Enum.AutomaticSize.Y
	container.Parent = content
	local containerList = Instance.new("UIListLayout")
	containerList.SortOrder = Enum.SortOrder.LayoutOrder
	containerList.Padding = UDim.new(0, 8)
	containerList.Parent = container
	local spacer = Instance.new("Frame")
	spacer.Size = UDim2.new(1, 0, 0, 6)
	spacer.BackgroundTransparency = 1
	spacer.Parent = container

	-- FIX V3.3: forward declaration agar info card bisa diakses window:Toggle
	local info = nil

	--// Tabs
	function window:CreateTab(name)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 34)
		btn.BackgroundColor3 = window.accent
		btn.BackgroundTransparency = 1
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Parent = sidebar
		Corner(btn, 7)
		local ind = Instance.new("Frame")
		ind.Size = UDim2.new(0, 3, 0, 16)
		ind.Position = UDim2.new(0, 5, 0.5, -8)
		ind.BackgroundColor3 = window.accent
		ind.BackgroundTransparency = 1
		ind.BorderSizePixel = 0
		ind.Parent = btn
		Corner(ind, 2)
		local tabLbl = Instance.new("TextLabel")
		tabLbl.Size = UDim2.new(1, -22, 1, 0)
		tabLbl.Position = UDim2.new(0, 14, 0, 0)
		tabLbl.BackgroundTransparency = 1
		tabLbl.Text = name
		tabLbl.Font = Enum.Font.GothamMedium
		tabLbl.TextSize = 13
		tabLbl.TextColor3 = Theme.SubText
		tabLbl.TextXAlignment = Enum.TextXAlignment.Left
		tabLbl.TextTruncate = Enum.TextTruncate.AtEnd
		tabLbl.Parent = btn

		local tabContent = Instance.new("Frame")
		tabContent.Size = UDim2.new(1, 0, 0, 0)
		tabContent.BackgroundTransparency = 1
		tabContent.AutomaticSize = Enum.AutomaticSize.Y
		tabContent.Visible = false
		tabContent.Parent = container
		local tabList = Instance.new("UIListLayout")
		tabList.SortOrder = Enum.SortOrder.LayoutOrder
		tabList.Padding = UDim.new(0, 8)
		tabList.Parent = tabContent

		local tab = { content = tabContent, btn = btn, ind = ind }
		local function curAccent() return window.accent end

		local function setActive(on)
			if on then
				Tween(btn, .2, {BackgroundColor3 = curAccent(), BackgroundTransparency = .84})
				Tween(tabLbl, .2, {TextColor3 = Theme.Text})
				Tween(ind, .2, {BackgroundTransparency = 0})
			else
				Tween(btn, .2, {BackgroundTransparency = 1})
				Tween(tabLbl, .2, {TextColor3 = Theme.SubText})
				Tween(ind, .2, {BackgroundTransparency = 1})
			end
		end
		btn.MouseEnter:Connect(function()
			if window.currentTab ~= tabContent then Tween(tabLbl, .2, {TextColor3 = Theme.Text}) Tween(btn, .2, {BackgroundTransparency = .93}) end
		end)
		btn.MouseLeave:Connect(function()
			if window.currentTab ~= tabContent then
				Tween(tabLbl, .2, {TextColor3 = Theme.SubText})
				Tween(btn, .2, {BackgroundColor3 = curAccent(), BackgroundTransparency = 1})
			end
		end)
		btn.MouseButton1Click:Connect(function()
			if window.currentTab == tabContent then return end
			if window.currentTab then window.currentTab.Visible = false if window.currentTabData then window.currentTabData.setActive(false) end end
			tabContent.Visible = true
			setActive(true)
			window.currentTab = tabContent
			window.currentTabData = { setActive = setActive }
			content.CanvasPosition = Vector2.new(0, 0)
		end)
		window:onAccent(function(c)
			ind.BackgroundColor3 = c
			if window.currentTab == tabContent then btn.BackgroundColor3 = c end
		end)
		if not window.currentTab then
			tabContent.Visible = true
			setActive(true)
			window.currentTab = tabContent
			window.currentTabData = { setActive = setActive }
		end

		--// Elements
		local function elementFrame(h)
			local f = Instance.new("Frame")
			f.Size = UDim2.new(1, 0, 0, h)
			f.BackgroundColor3 = Theme.Element
			f.BorderSizePixel = 0
			f.Parent = tabContent
			Corner(f, 7)
			local s = Stroke(f)
			return f, s
		end

		function tab:CreateSection(text)
			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1, 0, 0, 18)
			holder.BackgroundTransparency = 1
			holder.Parent = tabContent
			local bar = Instance.new("Frame")
			bar.Size = UDim2.new(0, 3, 0, 12)
			bar.Position = UDim2.new(0, 2, 0.5, -6)
			bar.BackgroundColor3 = window.accent
			bar.BorderSizePixel = 0
			bar.Parent = holder
			Corner(bar, 2)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -14, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = text:upper()
			lbl.TextColor3 = Theme.SubText
			lbl.TextSize = 11
			lbl.Font = Enum.Font.GothamBold
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = holder
			window:onAccent(function(c) bar.BackgroundColor3 = c end)
			return holder
		end

		function tab:CreateLabel(text)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, 0, 0, 18)
			lbl.BackgroundTransparency = 1
			lbl.Text = text
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 12
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.TextWrapped = true
			lbl.Parent = tabContent
			return { Set = function(self, t) lbl.Text = t end }
		end

		function tab:CreateToggle(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(38)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -60, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Toggle"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local switch = Instance.new("TextButton")
			switch.Size = UDim2.new(0, 40, 0, 20)
			switch.Position = UDim2.new(1, -52, 0.5, -10)
			switch.BackgroundColor3 = Theme.Border
			switch.BorderSizePixel = 0
			switch.Text = ""
			switch.AutoButtonColor = false
			switch.Parent = f
			Corner(switch, 99)
			local circle = Instance.new("Frame")
			circle.Size = UDim2.new(0, 14, 0, 14)
			circle.Position = UDim2.new(0, 3, 0.5, -7)
			circle.BackgroundColor3 = Theme.SubText
			circle.BorderSizePixel = 0
			circle.Parent = switch
			Corner(circle, 99)
			local enabled = cfg.Default or false
			local function accent() return col or window.accent end
			local function update()
				if enabled then
					Tween(switch, .2, {BackgroundColor3 = accent()})
					Tween(circle, .2, {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.new(1,1,1)})
				else
					Tween(switch, .2, {BackgroundColor3 = Theme.Border})
					Tween(circle, .2, {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Theme.SubText})
				end
			end
			update()
			window:onAccent(function() update() end)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = accent()}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			switch.MouseButton1Click:Connect(function()
				enabled = not enabled
				update()
				if cfg.Callback then task.spawn(cfg.Callback, enabled) end
			end)
			return { Set = function(self, v) enabled = v update() if cfg.Callback then task.spawn(cfg.Callback, enabled) end end }
		end

		function tab:CreateSlider(cfg)
			cfg = cfg or {}
			local min, max = cfg.Min or 0, cfg.Max or 100
			local value = cfg.Default or min
			local col = cfg.Color
			local f, s = elementFrame(52)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, -12, 0, 18)
			lbl.Position = UDim2.new(0, 12, 0, 7)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Slider"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local val = Instance.new("TextLabel")
			val.Size = UDim2.new(0.4, -12, 0, 18)
			val.Position = UDim2.new(0.6, 0, 0, 7)
			val.BackgroundTransparency = 1
			val.Text = tostring(value)
			val.TextColor3 = col or window.accent
			val.TextSize = 13
			val.Font = Enum.Font.GothamBold
			val.TextXAlignment = Enum.TextXAlignment.Right
			val.Parent = f
			local track = Instance.new("Frame")
			track.Size = UDim2.new(1, -24, 0, 6)
			track.Position = UDim2.new(0, 12, 0, 34)
			track.BackgroundColor3 = Theme.Border
			track.BorderSizePixel = 0
			track.Parent = f
			Corner(track, 99)
			local fill = Instance.new("Frame")
			fill.BackgroundColor3 = col or window.accent
			fill.BorderSizePixel = 0
			fill.Parent = track
			Corner(fill, 99)
			local knob = Instance.new("Frame")
			knob.Size = UDim2.new(0, 12, 0, 12)
			knob.BackgroundColor3 = Color3.new(1,1,1)
			knob.BorderSizePixel = 0
			knob.Parent = track
			Corner(knob, 99)
			Stroke(knob, col or window.accent, 2)
			local hit = Instance.new("TextButton")
			hit.Size = UDim2.new(1, -24, 0, 20)
			hit.Position = UDim2.new(0, 12, 0, 27)
			hit.BackgroundTransparency = 1
			hit.Text = ""
			hit.Parent = f
			local function apply(v, fire)
				value = math.clamp(math.floor(v), min, max)
				local rel = (value - min) / math.max(1, max - min)
				fill.Size = UDim2.new(rel, 0, 1, 0)
				knob.Position = UDim2.new(rel, -6, 0.5, -6)
				val.Text = tostring(value)
				if fire and cfg.Callback then task.spawn(cfg.Callback, value) end
			end
			apply(value, false)
			window:onAccent(function(c)
				if not col then val.TextColor3 = c fill.BackgroundColor3 = c knob.UIStroke.Color = c end
			end)
			local sliding = false
			hit.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					sliding = true
					local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
					apply(min + (max - min) * rel, true)
				end
			end)
			UserInputService.InputChanged:Connect(function(inp)
				if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
					local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
					apply(min + (max - min) * rel, true)
				end
			end)
			UserInputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then sliding = false end
			end)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = col or window.accent}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			return { Set = function(self, v) apply(v, true) end }
		end

		function tab:CreateButton(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(34)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -24, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Button"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.GothamMedium
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 20, 1, 0)
			arrow.Position = UDim2.new(1, -28, 0, 0)
			arrow.BackgroundTransparency = 1
			arrow.Text = "›"
			arrow.TextColor3 = col or window.accent
			arrow.TextSize = 18
			arrow.Font = Enum.Font.GothamBold
			arrow.Parent = f
			window:onAccent(function(c) if not col then arrow.TextColor3 = c end end)
			f.MouseEnter:Connect(function() Tween(f, .2, {BackgroundColor3 = Theme.ElementHover}) Tween(s, .2, {Color = col or window.accent}) end)
			f.MouseLeave:Connect(function() Tween(f, .2, {BackgroundColor3 = Theme.Element}) Tween(s, .2, {Color = Theme.Border}) end)
			local click = Instance.new("TextButton")
			click.Size = UDim2.new(1, 0, 1, 0)
			click.BackgroundTransparency = 1
			click.Text = ""
			click.Parent = f
			click.MouseButton1Click:Connect(function()
				Tween(f, .1, {Size = UDim2.new(1, -6, 0, 32)}, Enum.EasingStyle.Back)
				task.delay(.12, function() if f.Parent then Tween(f, .15, {Size = UDim2.new(1, 0, 0, 34)}, Enum.EasingStyle.Back) end end)
				if cfg.Callback then task.spawn(cfg.Callback) end
			end)
			return f
		end

		function tab:CreateTextbox(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(38)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -160, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Textbox"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0, 140, 0, 24)
			box.Position = UDim2.new(1, -150, 0.5, -12)
			box.BackgroundColor3 = Theme.Background
			box.BorderSizePixel = 0
			box.PlaceholderText = cfg.Placeholder or "Type here..."
			box.PlaceholderColor3 = Theme.SubText
			box.Text = ""
			box.TextColor3 = col or window.accent
			box.TextSize = 12
			box.Font = Enum.Font.Gotham
			box.Parent = f
			Corner(box, 6)
			Stroke(box, Theme.Border, 1)
			Pad(box, 0, 8, 0, 8)
			window:onAccent(function(c) if not col then box.TextColor3 = c end end)
			box:GetPropertyChangedSignal("Text"):Connect(function()
				if cfg.Callback then task.spawn(cfg.Callback, box.Text) end
			end)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = col or window.accent}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			return { Set = function(self, t) box.Text = t end }
		end

		function tab:CreateDropdown(cfg)
			cfg = cfg or {}
			local options = cfg.Options or {}
			local col = cfg.Color
			local openH = 44 + math.min(#options * 30, 150) + 6
			local f, s = elementFrame(38)
			f.ClipsDescendants = true
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.5, -12, 0, 38)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Dropdown"
			lbl.TextColor3 = Theme.SubText
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local val = Instance.new("TextLabel")
			val.Size = UDim2.new(0.5, -34, 0, 38)
			val.Position = UDim2.new(0.5, 0, 0, 0)
			val.BackgroundTransparency = 1
			val.Text = cfg.Default or (options[1] or "...")
			val.TextColor3 = Theme.Text
			val.TextSize = 13
			val.Font = Enum.Font.GothamMedium
			val.TextXAlignment = Enum.TextXAlignment.Right
			val.Parent = f
			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 16, 0, 16)
			arrow.Position = UDim2.new(1, -26, 0, 11)
			arrow.BackgroundTransparency = 1
			arrow.Text = "›"
			arrow.TextColor3 = Theme.SubText
			arrow.TextSize = 16
			arrow.Font = Enum.Font.GothamBold
			arrow.Rotation = 90
			arrow.Parent = f
			local list = Instance.new("ScrollingFrame")
			list.Size = UDim2.new(1, -12, 0, 0)
			list.Position = UDim2.new(0, 6, 0, 42)
			list.BackgroundTransparency = 1
			list.BorderSizePixel = 0
			list.ScrollBarThickness = 2
			list.ScrollBarImageColor3 = Theme.Border
			list.AutomaticCanvasSize = Enum.AutomaticSize.Y
			list.CanvasSize = UDim2.new(0, 0, 0, 0)
			list.Parent = f
			local listLayout = Instance.new("UIListLayout")
			listLayout.SortOrder = Enum.SortOrder.LayoutOrder
			listLayout.Padding = UDim.new(0, 2)
			listLayout.Parent = list
			local isOpen = false
			local function toggleOpen()
				isOpen = not isOpen
				if isOpen then
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, openH)})
					Tween(list, .3, {Size = UDim2.new(1, -12, 0, math.min(#options * 30, 150))})
					Tween(arrow, .3, {Rotation = -90, TextColor3 = col or window.accent})
				else
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, 38)})
					Tween(list, .3, {Size = UDim2.new(1, -12, 0, 0)})
					Tween(arrow, .3, {Rotation = 90, TextColor3 = Theme.SubText})
				end
			end
			local function addOption(opt)
				local o = Instance.new("TextButton")
				o.Size = UDim2.new(1, 0, 0, 28)
				o.BackgroundColor3 = Color3.new(1,1,1)
				o.BackgroundTransparency = 1
				o.BorderSizePixel = 0
				o.Text = opt
				o.TextColor3 = Theme.SubText
				o.TextSize = 12
				o.Font = Enum.Font.Gotham
				o.TextXAlignment = Enum.TextXAlignment.Left
				o.AutoButtonColor = false
				o.Parent = list
				Corner(o, 5)
				Pad(o, 0, 8, 0, 4)
				o.MouseEnter:Connect(function() Tween(o, .15, {BackgroundTransparency = .85, BackgroundColor3 = col or window.accent, TextColor3 = Theme.Text}) end)
				o.MouseLeave:Connect(function() Tween(o, .15, {BackgroundTransparency = 1, TextColor3 = Theme.SubText}) end)
				o.MouseButton1Click:Connect(function()
					val.Text = opt
					toggleOpen()
					if cfg.Callback then task.spawn(cfg.Callback, opt) end
				end)
			end
			for _, opt in ipairs(options) do addOption(opt) end
			local head = Instance.new("TextButton")
			head.Size = UDim2.new(1, 0, 0, 38)
			head.BackgroundTransparency = 1
			head.Text = ""
			head.Parent = f
			head.MouseButton1Click:Connect(toggleOpen)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = col or window.accent}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			return { Refresh = function(self, newOpts)
				for _, c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
				options = newOpts
				openH = 44 + math.min(#options * 30, 150) + 6
				for _, opt in ipairs(options) do addOption(opt) end
			end }
		end

		function tab:CreateKeybind(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(38)
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -100, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Keybind"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local badge = Instance.new("TextButton")
			badge.Size = UDim2.new(0, 78, 0, 22)
			badge.Position = UDim2.new(1, -90, 0.5, -11)
			badge.BackgroundColor3 = Theme.Background
			badge.BorderSizePixel = 0
			badge.Text = (cfg.Default and cfg.Default.Name) or "NONE"
			badge.TextColor3 = col or window.accent
			badge.TextSize = 11
			badge.Font = Enum.Font.GothamBold
			badge.AutoButtonColor = false
			badge.Parent = f
			Corner(badge, 5)
			Stroke(badge, Theme.Border, 1)
			local current = cfg.Default or Enum.KeyCode.Unknown
			local binding = false
			window:onAccent(function(c) if not col and not binding then badge.TextColor3 = c end end)
			badge.MouseButton1Click:Connect(function()
				binding = true
				badge.Text = "..."
				badge.TextColor3 = col or window.accent
			end)
			UserInputService.InputBegan:Connect(function(inp, gp)
				if gp then return end
				if binding and inp.UserInputType == Enum.UserInputType.Keyboard then
					current = inp.KeyCode
					binding = false
					badge.Text = current.Name
					badge.TextColor3 = col or window.accent
					if cfg.Callback then task.spawn(cfg.Callback, current) end
				elseif not binding and current ~= Enum.KeyCode.Unknown and inp.KeyCode == current then
					if cfg.Callback then task.spawn(cfg.Callback, current) end
				end
			end)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = col or window.accent}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			return { SetKey = function(self, k) current = k badge.Text = k.Name end }
		end

		function tab:CreateColorPicker(cfg)
			cfg = cfg or {}
			local col = cfg.Default or Color3.fromRGB(255, 80, 80)
			local f, s = elementFrame(38)
			f.ClipsDescendants = true
			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -70, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Title or "Color Picker"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f
			local swatch = Instance.new("TextButton")
			swatch.Size = UDim2.new(0, 42, 0, 20)
			swatch.Position = UDim2.new(1, -54, 0.5, -10)
			swatch.BackgroundColor3 = col
			swatch.BorderSizePixel = 0
			swatch.Text = ""
			swatch.Parent = f
			Corner(swatch, 5)
			Stroke(swatch, Color3.new(1,1,1), 1).Transparency = .75
			local picker = Instance.new("Frame")
			picker.Size = UDim2.new(1, -16, 0, 0)
			picker.Position = UDim2.new(0, 8, 0, 42)
			picker.BackgroundTransparency = 1
			picker.ClipsDescendants = true
			picker.Parent = f
			local grid = Instance.new("UIGridLayout")
			grid.CellSize = UDim2.new(0, 26, 0, 26)
			grid.CellPadding = UDim.new(0, 5, 0, 5)
			grid.SortOrder = Enum.SortOrder.LayoutOrder
			grid.Parent = picker
			local isOpen = false
			local function togglePicker()
				isOpen = not isOpen
				if isOpen then
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, 108)})
					Tween(picker, .3, {Size = UDim2.new(1, -16, 0, 57)})
				else
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, 38)})
					Tween(picker, .3, {Size = UDim2.new(1, -16, 0, 0)})
				end
			end
			local presets = {
				Color3.fromRGB(255, 70, 70), Color3.fromRGB(255, 150, 60), Color3.fromRGB(255, 220, 60),
				Color3.fromRGB(90, 230, 90), Color3.fromRGB(60, 220, 220), Color3.fromRGB(70, 130, 255),
				Color3.fromRGB(140, 80, 255), Color3.fromRGB(255, 80, 180), Color3.fromRGB(255, 255, 255),
				Color3.fromRGB(160, 160, 160),
			}
			for _, pc in ipairs(presets) do
				local b = Instance.new("TextButton")
				b.BackgroundColor3 = pc
				b.BorderSizePixel = 0
				b.Text = ""
				b.Parent = picker
				Corner(b, 6)
				b.MouseButton1Click:Connect(function()
					col = pc
					swatch.BackgroundColor3 = pc
					togglePicker()
					if cfg.Callback then task.spawn(cfg.Callback, pc) end
				end)
			end
			swatch.MouseButton1Click:Connect(togglePicker)
			f.MouseEnter:Connect(function() Tween(s, .2, {Color = col}) end)
			f.MouseLeave:Connect(function() Tween(s, .2, {Color = Theme.Border}) end)
			return { Set = function(self, c) col = c swatch.BackgroundColor3 = c if cfg.Callback then task.spawn(cfg.Callback, c) end end }
		end

		return tab
	end

	--// Mini Show/Hide Box
	local MiniToggle = Instance.new("TextButton")
	MiniToggle.AnchorPoint = Vector2.new(0.5, 0.5)
	MiniToggle.Position = UDim2.new(0, 37, 0.5, 0)
	MiniToggle.Size = UDim2.new(0, 50, 0, 50)
	MiniToggle.BackgroundColor3 = Theme.Background
	MiniToggle.BorderSizePixel = 0
	MiniToggle.Text = ""
	MiniToggle.AutoButtonColor = false
	MiniToggle.ZIndex = 60
	MiniToggle.Parent = gui
	Corner(MiniToggle, 12)
	registerRGB(Stroke(MiniToggle, Color3.new(1,1,1), 2))
	local iconLines = {}
	local function makeLine(y)
		local l = Instance.new("Frame")
		l.AnchorPoint = Vector2.new(0.5, 0.5)
		l.Position = UDim2.new(0.5, 0, 0.5, y)
		l.Size = UDim2.new(0, 22, 0, 3)
		l.BackgroundColor3 = Theme.Text
		l.BorderSizePixel = 0
		l.ZIndex = 2
		l.Parent = MiniToggle
		Corner(l, 2)
		table.insert(iconLines, l)
		return l
	end
	makeLine(-8) makeLine(0) makeLine(8)
	local function setMiniIcon(open)
		if open then
			Tween(iconLines[1], .3, {Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = 45})
			Tween(iconLines[2], .3, {Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = -45})
			Tween(iconLines[3], .2, {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 3)})
		else
			Tween(iconLines[1], .3, {Position = UDim2.new(0.5, 0, 0.5, -8), Rotation = 0})
			Tween(iconLines[2], .3, {Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = 0})
			Tween(iconLines[3], .3, {BackgroundTransparency = 0, Size = UDim2.new(0, 22, 0, 3), Position = UDim2.new(0.5, 0, 0.5, 8), Rotation = 0})
		end
	end
	local function clampMini()
		local vp = workspace.CurrentCamera.ViewportSize
		local half = MiniToggle.AbsoluteSize.X / 2
		local x = math.clamp(MiniToggle.Position.X.Offset, half + 4, vp.X - half - 4)
		local y = math.clamp(MiniToggle.Position.Y.Offset, half + 4, vp.Y - half - 4)
		MiniToggle.Position = UDim2.new(0, x, 0, y)
	end
	local mDrag, mStart, mMoved = false, nil, 0
	local mOrigX, mOrigY = 0, 0
	MiniToggle.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			mDrag, mMoved = true, 0
			mStart = inp.Position
			local center = MiniToggle.AbsolutePosition + MiniToggle.AbsoluteSize / 2
			mOrigX, mOrigY = center.X, center.Y
		end
	end)
	MiniToggle.MouseButton1Click:Connect(function()
		if mMoved > 8 then return end
		window:Toggle()
	end)
	UserInputService.InputChanged:Connect(function(inp)
		if mDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local d = inp.Position - mStart
			mMoved = math.max(mMoved, math.abs(d.X) + math.abs(d.Y))
			MiniToggle.Position = UDim2.new(0, mOrigX + d.X, 0, mOrigY + d.Y)
			clampMini()
		end
	end)
	UserInputService.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then mDrag = false end
	end)

	--// Toggle Window (info card sync)
	function window:Toggle(force)
		local open = (force ~= nil) and force or not Library.Open
		Library.Open = open
		if info then info.Visible = open end
		if open then
			main.Visible = true
			Tween(main, .35, {Size = OPEN_SIZE}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		else
			Tween(main, .25, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In).Completed:Connect(function()
				if not Library.Open then main.Visible = false end
			end)
		end
		setMiniIcon(open)
	end

	function window:SetInfoCard(vis)
		if info then info.Visible = vis end
	end

	minimizeBtn.MouseButton1Click:Connect(function() window:Toggle(false) end)
	closeBtn.MouseButton1Click:Connect(function()
		Tween(main, .25, {Size = UDim2.new(0, 0, 0, 0)}).Completed:Connect(function() gui:Destroy() end)
	end)
	UserInputService.InputBegan:Connect(function(inp, gp)
		if gp then return end
		if inp.KeyCode == Library.ToggleKey then window:Toggle() end
	end)

	--// Player Info Card
	info = Instance.new("Frame")
	info.Size = UDim2.new(0, 230, 0, 74)
	info.Position = UDim2.new(0, 12, 1, -86)
	info.BackgroundColor3 = Theme.Background
	info.BackgroundTransparency = 0.1
	info.BorderSizePixel = 0
	info.ZIndex = 55
	info.Parent = gui
	info.Visible = Library.Open
	Corner(info, 10)
	Stroke(info, Theme.Border, 1)
	local avatar = Instance.new("ImageLabel")
	avatar.Size = UDim2.new(0, 48, 0, 48)
	avatar.Position = UDim2.new(0, 13, 0.5, -24)
	avatar.BackgroundColor3 = Theme.Element
	avatar.BorderSizePixel = 0
	avatar.Parent = info
	Corner(avatar, 99)
	registerRGB(Stroke(avatar, Color3.new(1,1,1), 2))
	avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"
	local nameLbl = Instance.new("TextLabel")
	nameLbl.Size = UDim2.new(1, -74, 0, 18)
	nameLbl.Position = UDim2.new(0, 70, 0, 11)
	nameLbl.BackgroundTransparency = 1
	nameLbl.Text = LocalPlayer.DisplayName
	nameLbl.TextColor3 = Theme.Text
	nameLbl.TextSize = 13
	nameLbl.Font = Enum.Font.GothamBold
	nameLbl.TextXAlignment = Enum.TextXAlignment.Left
	nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
	nameLbl.Parent = info
	local userLbl = Instance.new("TextLabel")
	userLbl.Size = UDim2.new(1, -74, 0, 14)
	userLbl.Position = UDim2.new(0, 70, 0, 29)
	userLbl.BackgroundTransparency = 1
	userLbl.Text = "@" .. LocalPlayer.Name
	userLbl.TextColor3 = Theme.SubText
	userLbl.TextSize = 10
	userLbl.Font = Enum.Font.Gotham
	userLbl.TextXAlignment = Enum.TextXAlignment.Left
	userLbl.TextTruncate = Enum.TextTruncate.AtEnd
	userLbl.Parent = info
	local statsLbl = Instance.new("TextLabel")
	statsLbl.Size = UDim2.new(1, -74, 0, 14)
	statsLbl.Position = UDim2.new(0, 70, 0, 45)
	statsLbl.BackgroundTransparency = 1
	statsLbl.Text = "FPS -- • PING --ms"
	statsLbl.TextColor3 = window.accent
	statsLbl.TextSize = 10
	statsLbl.Font = Enum.Font.GothamMedium
	statsLbl.TextXAlignment = Enum.TextXAlignment.Left
	statsLbl.Parent = info
	window:onAccent(function(c) statsLbl.TextColor3 = c end)
	task.spawn(function()
		while info.Parent do
			task.wait(1)
			local now = os.clock()
			local fps = math.floor(fpsFrames / math.max(now - fpsLast, 0.0001))
			fpsFrames, fpsLast = 0, now
			local ping = 0
			pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
			statsLbl.Text = "FPS " .. math.min(fps, 999) .. " • PING " .. ping .. "ms"
		end
	end)

	setMiniIcon(true)
	return window
end

return Library
