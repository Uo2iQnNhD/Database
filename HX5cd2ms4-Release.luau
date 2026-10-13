--[[ ZETHUB - Library V5 Fixed by Exterminate0 ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// Anti duplicate environment
local Env = (typeof(getgenv) == "function" and getgenv()) or _G
local Generation = (type(Env) == "table" and tonumber(Env.ZethHubGeneration) or 0) + 1
if type(Env) == "table" then
	Env.ZethHubGeneration = Generation
end

local function purgeOldGuis()
	local targets = {
		"ZethHubV5",
		"ZethNotifies",
	}

	local parents = {
		game:GetService("CoreGui"),
		LocalPlayer:FindFirstChild("PlayerGui"),
	}

	if typeof(gethui) == "function" then
		local ok, hui = pcall(gethui)
		if ok and hui then
			table.insert(parents, hui)
		end
	end

	for _, parent in ipairs(parents) do
		if parent then
			for _, child in ipairs(parent:GetChildren()) do
				if child:IsA("ScreenGui") then
					for _, name in ipairs(targets) do
						if child.Name == name then
							pcall(function()
								child:Destroy()
							end)
						end
					end
				end
			end
		end
	end
end

--// Hancurkan library sebelumnya jika ada
local PreviousLibrary = type(Env) == "table" and Env.ZethHubLibrary or nil
if PreviousLibrary and type(PreviousLibrary.Destroy) == "function" then
	pcall(function()
		PreviousLibrary:Destroy()
	end)
end

purgeOldGuis()

local Library = {
	Accent = Color3.fromRGB(255, 255, 255),
	Rainbow = true,
	ToggleKey = Enum.KeyCode.RightShift,
	Open = true,
	Flags = {},
	Generation = Generation,
	_connections = {},
	_windows = {},
	_destroyed = false,
}

local Theme = {
	Background = Color3.fromRGB(15, 15, 15),
	Sidebar = Color3.fromRGB(10, 10, 10),
	Element = Color3.fromRGB(25, 25, 25),
	ElementHover = Color3.fromRGB(35, 35, 35),
	Border = Color3.fromRGB(50, 50, 50),
	Text = Color3.fromRGB(255, 255, 255),
	SubText = Color3.fromRGB(160, 160, 160),
}

--// Presisi tinggi elemen
local H_ELEMENT = 38
local H_SLIDER = 46
local H_SECTION = 20
local H_TAB = 34
local TOPBAR_H = 58

--// Lucide Icons + Rayfield-style icon engine
Library.Lucide = {}
Library.LucideRect = {}

-- Fallback icon milik library lama
local fallbackIcons = {
	["home"]="rbxassetid://7733960981", ["settings"]="rbxassetid://7734053495", ["settings-2"]="rbxassetid://8997386997",
	["shield"]="rbxassetid://7734056608", ["shield-check"]="rbxassetid://7734056411", ["key"]="rbxassetid://7733965118",
	["gamepad-2"]="rbxassetid://7733799795", ["folder"]="rbxassetid://7733799185", ["file-text"]="rbxassetid://7733789088",
	["palette"]="rbxassetid://7734021595", ["wrench"]="rbxassetid://7743878358", ["hammer"]="rbxassetid://7733955511",
	["heart"]="rbxassetid://7733956134", ["star"]="rbxassetid://7734068321", ["check"]="rbxassetid://7733715400",
	["x"]="rbxassetid://7743878857", ["search"]="rbxassetid://7734052925", ["globe"]="rbxassetid://7733954760",
	["cpu"]="rbxassetid://7733765045", ["activity"]="rbxassetid://7733655755", ["gauge"]="rbxassetid://7733799969",
	["map-pin"]="rbxassetid://7733992789", ["eye"]="rbxassetid://7733774602", ["eye-off"]="rbxassetid://7733774495",
	["lock"]="rbxassetid://7733992528", ["unlock"]="rbxassetid://7743875263", ["send"]="rbxassetid://7734053039",
	["message-square"]="rbxassetid://7733993369", ["download"]="rbxassetid://7733770755", ["upload"]="rbxassetid://7743875428",
	["refresh-cw"]="rbxassetid://7734051052", ["play"]="rbxassetid://7743871480", ["pause"]="rbxassetid://7734021897",
	["music"]="rbxassetid://7734020554", ["image"]="rbxassetid://7733964126", ["camera"]="rbxassetid://7733708692",
	["mail"]="rbxassetid://7733992732", ["wifi"]="rbxassetid://7743878148", ["sun"]="rbxassetid://7734068495",
	["moon"]="rbxassetid://7743870134", ["cloud"]="rbxassetid://7733746980", ["flame"]="rbxassetid://7733798747",
	["crown"]="rbxassetid://7733765398", ["gem"]="rbxassetid://7733942651", ["banknote"]="rbxassetid://7733674153",
	["shopping-cart"]="rbxassetid://7734056813", ["gift"]="rbxassetid://7733946818", ["package"]="rbxassetid://7734021469",
	["box"]="rbxassetid://7733917120", ["trash-2"]="rbxassetid://7743873772", ["pencil"]="rbxassetid://7734022107",
	["clipboard"]="rbxassetid://7733734762", ["book-open"]="rbxassetid://7733687281", ["calendar"]="rbxassetid://7733919198",
	["timer"]="rbxassetid://7743873443", ["alarm-clock"]="rbxassetid://7733656100", ["watch"]="rbxassetid://7743877668",
	["megaphone"]="rbxassetid://7733993049", ["monitor"]="rbxassetid://7734002839", ["smartphone"]="rbxassetid://7734058979",
	["laptop"]="rbxassetid://7733965386", ["database"]="rbxassetid://7743866778", ["server"]="rbxassetid://7734053426",
	["link"]="rbxassetid://7733978098", ["external-link"]="rbxassetid://7743866903", ["qr-code"]="rbxassetid://7743871575",
	["scan"]="rbxassetid://8997386861", ["flag"]="rbxassetid://7733798691", ["compass"]="rbxassetid://7733924216",
	["map"]="rbxassetid://7733992829", ["navigation"]="rbxassetid://7734020989", ["crosshair"]="rbxassetid://7733765307",
	["target"]="rbxassetid://7743872758", ["bell"]="rbxassetid://7733911828", ["bell-ring"]="rbxassetid://7733675275",
	["info"]="rbxassetid://7733964719", ["terminal"]="rbxassetid://7743872929", ["check-circle"]="rbxassetid://7733919427",
	["x-circle"]="rbxassetid://7743878496", ["help-circle"]="rbxassetid://7733956210", ["user"]="rbxassetid://7743875962",
	["users"]="rbxassetid://7743876054", ["chevron-down"]="rbxassetid://7733717447", ["chevron-right"]="rbxassetid://7733717755",
	["chevron-left"]="rbxassetid://7733717651", ["chevron-up"]="rbxassetid://7733919605", ["log-out"]="rbxassetid://7733992677",
	["log-in"]="rbxassetid://7733992604", ["power"]="rbxassetid://7734042493", ["toggle-left"]="rbxassetid://7734091286",
	["toggle-right"]="rbxassetid://7743873539", ["type"]="rbxassetid://7743874740", ["menu"]="rbxassetid://7733993211",
	["layout-dashboard"]="rbxassetid://7733970318", ["grid"]="rbxassetid://7733955179", ["sidebar"]="rbxassetid://7734058260",
	["shovel"]="rbxassetid://7734056878", ["sliders"]="rbxassetid://7734058803", ["coin"]="rbxassetid://7743866529",
	["wallet"]="rbxassetid://7743877573", ["piggy-bank"]="rbxassetid://7734034513", ["ticket"]="rbxassetid://7734086558",
	["badge-check"]="rbxassetid://7743875503", ["badge"]="rbxassetid://7733692043", ["award"]="rbxassetid://7733673987",
	["battery"]="rbxassetid://7733674820", ["battery-charging"]="rbxassetid://7733674402", ["lightbulb"]="rbxassetid://7733975185",
	["locate"]="rbxassetid://7733992469", ["locate-fixed"]="rbxassetid://7733992424",
	-- alias
	["house"]="rbxassetid://7733960981", ["gear"]="rbxassetid://7734053495", ["dashboard"]="rbxassetid://7733970318",
	["sliders-horizontal"]="rbxassetid://7734058803",
}

for name, asset in pairs(fallbackIcons) do
	Library.Lucide[name] = asset
end

-- Cache global supaya kalau script dijalankan ulang, icon tidak perlu download terus
local IconCache = (type(Env) == "table" and Env.ZethHubIconCache) or {
	Loaded = false,
	Lucide = {},
	Rect = {},
}

if type(Env) == "table" then
	Env.ZethHubIconCache = IconCache
end

-- Terapkan cache jika sudah pernah dimuat
for name, asset in pairs(IconCache.Lucide) do
	Library.Lucide[name] = asset
end

for name, rect in pairs(IconCache.Rect) do
	Library.LucideRect[name] = rect
end

local function fetchRayfieldIconSource()
	local url = "https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/icons.lua"

	local ok, body = pcall(function()
		return game:HttpGet(url)
	end)

	if ok and type(body) == "string" and #body > 0 then
		return body
	end

	local requestFunc = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request

	if requestFunc then
		local okReq, res = pcall(function()
			return requestFunc({
				Url = url,
				Method = "GET",
			})
		end)

		if okReq and type(res) == "table" and type(res.Body) == "string" and #res.Body > 0 then
			return res.Body
		end
	end

	return nil
end

local function loadRayfieldIcons()
	if IconCache.Loaded then
		return
	end

	IconCache.Loaded = true

	local source = fetchRayfieldIconSource()

	if not source then
		warn("[ZethHub] Gagal memuat Rayfield icons.lua, memakai fallback icon.")
		return
	end

	local ok, Icons = pcall(function()
		return loadstring(source)()
	end)

	if not ok or type(Icons) ~= "table" then
		warn("[ZethHub] Rayfield icons.lua gagal dieksekusi, memakai fallback icon.")
		return
	end

	local iconTable = Icons["48px"] or Icons

	for name, data in pairs(iconTable) do
		if type(name) == "string" and type(data) == "table" then
			local assetId = data[1]
			local rectSize = data[2]
			local rectOffset = data[3]

			if
				type(assetId) == "number"
				and type(rectSize) == "table"
				and type(rectOffset) == "table"
				and rectSize[1] and rectSize[2]
				and rectOffset[1] and rectOffset[2]
			then
				local asset = "rbxassetid://" .. assetId
				local rect = {
					ImageRectOffset = Vector2.new(rectOffset[1], rectOffset[2]),
					ImageRectSize = Vector2.new(rectSize[1], rectSize[2]),
				}

				IconCache.Lucide[name] = asset
				IconCache.Rect[name] = rect

				Library.Lucide[name] = asset
				Library.LucideRect[name] = rect
			end
		end
	end
end

loadRayfieldIcons()

local function resolveIcon(icon)
	if icon == nil or icon == false or icon == 0 or icon == "" then
		return nil, nil, nil
	end

	if type(icon) == "number" then
		return "rbxassetid://" .. icon, nil, nil
	end

	if type(icon) == "string" then
		if
			icon:sub(1, 12) == "rbxassetid://" or
			icon:sub(1, 10) == "rbxasset://" or
			icon:sub(1, 11) == "rbxthumb://" or
			icon:sub(1, 7) == "http://" or
			icon:sub(1, 8) == "https://"
		then
			return icon, nil, nil
		end

		local key = string.match(string.lower(icon), "^%s*(.-)%s*$")
		local asset = Library.Lucide[key]
		local rect = Library.LucideRect[key]

		if not asset or asset == "" then
			asset = Library.Lucide["info"]
			rect = Library.LucideRect["info"]
		end

		return asset, rect and rect.ImageRectOffset, rect and rect.ImageRectSize
	end

	return nil, nil, nil
end

local function setIcon(instance, icon)
	if not instance then
		return
	end

	if not (instance:IsA("ImageLabel") or instance:IsA("ImageButton")) then
		return
	end

	local asset, offset, size = resolveIcon(icon)
	instance.Image = asset or ""

	if offset and size then
		instance.ImageRectOffset = offset
		instance.ImageRectSize = size
	else
		instance.ImageRectOffset = Vector2.new(0, 0)
		instance.ImageRectSize = Vector2.new(0, 0)
	end
end

local function makeIcon(parent, icon, size, pos, color)
	local asset, offset, rectSize = resolveIcon(icon)

	if not asset or asset == "" then
		return nil
	end

	local im = Instance.new("ImageLabel")
	im.Name = "Icon"
	im.Size = size or UDim2.new(0, 16, 0, 16)
	im.Position = pos or UDim2.new(0, 12, 0.5, -8)
	im.BackgroundTransparency = 1
	im.Image = asset
	im.ImageColor3 = color or Theme.Text

	if offset and rectSize then
		im.ImageRectOffset = offset
		im.ImageRectSize = rectSize
	end

	im.Parent = parent
	return im
end

local function Tween(obj, dur, props, style, dir)
	local tw = TweenService:Create(obj, TweenInfo.new(dur or .3, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function Corner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 7)
	c.Parent = p
	return c
end

local function Stroke(p, col, th)
	local s = Instance.new("UIStroke")
	s.Color = col or Theme.Border
	s.Thickness = th or 1
	s.Parent = p
	return s
end

local function Pad(p, t, l, b, r)
	local d = Instance.new("UIPadding")
	d.PaddingTop = UDim.new(0, t or 0)
	d.PaddingLeft = UDim.new(0, l or 0)
	d.PaddingBottom = UDim.new(0, b or 0)
	d.PaddingRight = UDim.new(0, r or 0)
	d.Parent = p
	return d
end

local function Connect(signal, callback, owner)
	local conn
	conn = signal:Connect(function(...)
		if Library._destroyed or (type(Env) == "table" and Env.ZethHubGeneration ~= Library.Generation) then
			pcall(function()
				if conn then conn:Disconnect() end
			end)
			return
		end

		if owner and owner._destroyed then
			pcall(function()
				if conn then conn:Disconnect() end
			end)
			return
		end

		callback(...)
	end)

	table.insert(Library._connections, conn)

	if owner and owner._connections then
		table.insert(owner._connections, conn)
	end

	return conn
end

function Library:GetFlag(flag)
	return Library.Flags[flag]
end

--// FPS / Ping global
local fpsFrames, fpsLast = 0, os.clock()
Connect(RunService.RenderStepped, function()
	fpsFrames += 1
end)

local currentFps, currentPing = 0, 0
task.spawn(function()
	while true do
		task.wait(1)

		if Library._destroyed or (type(Env) == "table" and Env.ZethHubGeneration ~= Library.Generation) then
			return
		end

		local now = os.clock()
		currentFps = math.floor(fpsFrames / math.max(now - fpsLast, 0.0001))
		fpsFrames, fpsLast = 0, now
		pcall(function()
			currentPing = math.floor(LocalPlayer:GetNetworkPing() * 1000)
		end)
	end
end)

--// YinYang Moving Border Engine
local rgbGradients = {}

local function rainbowSeq()
	return ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
	}
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

Connect(RunService.RenderStepped, function()
	local off = (os.clock() * 0.18) % 1
	for i = #rgbGradients, 1, -1 do
		local g = rgbGradients[i]
		if g.Parent then
			g.Offset = Vector2.new(off, 0)
		else
			table.remove(rgbGradients, i)
		end
	end
end)

function Library:SetRainbow(on)
	Library.Rainbow = on
	refreshRGBColors()
end

function Library:SetAccent(c)
	Library.Accent = c
	refreshRGBColors()
end

--// Notification settings (Rayfield-inspired)
Library.NotificationWidth = Library.NotificationWidth or 320
Library.NotificationRightOffset = Library.NotificationRightOffset or 16
Library.NotificationTopOffset = Library.NotificationTopOffset or 12
Library.MiniSafeMargin = Library.MiniSafeMargin or 8

--// Notification GUI (Self-healing + Rayfield-style)
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "ZethNotifies"
NotifGui.ResetOnSpawn = false
NotifGui.DisplayOrder = 9999
NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
NotifGui.IgnoreGuiInset = true

pcall(function()
	NotifGui.Parent = game:GetService("CoreGui")
end)

if not NotifGui.Parent then
	pcall(function()
		NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end)
end

local notifyContainer
local notifyList

local function rebuildNotifyContainer()
	if not NotifGui or not NotifGui.Parent then
		NotifGui = Instance.new("ScreenGui")
		NotifGui.Name = "ZethNotifies"
		NotifGui.ResetOnSpawn = false
		NotifGui.DisplayOrder = 999
		NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		NotifGui.IgnoreGuiInset = true

		pcall(function()
			NotifGui.Parent = game:GetService("CoreGui")
		end)

		if not NotifGui.Parent then
			pcall(function()
				NotifGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
			end)
		end
	end

	if not notifyContainer or not notifyContainer.Parent then
		notifyContainer = Instance.new("Frame")
		notifyContainer.Name = "NotifyContainer"
		notifyContainer.Size = UDim2.new(0, Library.NotificationWidth, 1, -24)
		notifyContainer.Position = UDim2.new(
			1,
			-(Library.NotificationWidth + Library.NotificationRightOffset),
			0,
			Library.NotificationTopOffset
		)
		notifyContainer.BackgroundTransparency = 1
		notifyContainer.BorderSizePixel = 0
		notifyContainer.Parent = NotifGui

		notifyList = Instance.new("UIListLayout")
		notifyList.SortOrder = Enum.SortOrder.LayoutOrder
		notifyList.Padding = UDim.new(0, 8)
		notifyList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		notifyList.VerticalAlignment = Enum.VerticalAlignment.Top
		notifyList.Parent = notifyContainer
	end
end

rebuildNotifyContainer()

local function notifyToText(value)
	if type(value) == "table" then
		return table.concat(value, "\n")
	end

	return tostring(value or "")
end

function Library:Notify(...)
	if Library._destroyed then
		return
	end

	local first = ...
	local cfg

	-- Kompatibel:
	-- Library:Notify({Title=..., Content=..., Duration=..., Image=...})
	-- Library:Notify(text, duration, title, icon)
	if type(first) == "table" then
		cfg = first
	else
		cfg = {
			Content = first,
			Duration = select(2, ...),
			Title = select(3, ...),
			Image = select(4, ...),
		}
	end

	local content = notifyToText(cfg.Content or cfg.Text or cfg.Message or "")
	local title = notifyToText(cfg.Title or cfg.title or "")
	local image = cfg.Image or cfg.Icon or cfg.icon

	-- Default icon supaya mirip Rayfield: selalu ada icon kecuali Image = 0 / false / nil secara eksplisit ingin disembunyikan.
	if image == nil and (title ~= "" or content ~= "") then
		image = "info"
	end

	local duration = tonumber(cfg.Duration or cfg.duration) or 5
	if duration < 0.1 then
		duration = 0.1
	end

	local accent = cfg.Color or cfg.Accent or Library.Accent
	if typeof(accent) ~= "Color3" then
		accent = Library.Accent
	end

	local hasTitle = title ~= ""
	local hasContent = content ~= ""
	local hasIcon = image ~= nil and image ~= "" and image ~= 0

	if not hasTitle and not hasContent and not hasIcon then
		return
	end

	Library._notifyOrder = (Library._notifyOrder or 0) - 1
	local order = Library._notifyOrder

	task.spawn(function()
		if Library._destroyed then
			return
		end

		rebuildNotifyContainer()

		-- Holder dipakai supaya animasi slide kanan-kiri tidak berantakan kena UIListLayout.
		local holder = Instance.new("Frame")
		holder.Name = "NotifyHolder"
		holder.Size = UDim2.new(1, 0, 0, 0)
		holder.AutomaticSize = Enum.AutomaticSize.Y
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.ClipsDescendants = true
		holder.LayoutOrder = order
		holder.Parent = notifyContainer

		local n = Instance.new("Frame")
		n.Name = "Notification"
		n.Size = UDim2.new(1, 0, 0, 0)
		n.AutomaticSize = Enum.AutomaticSize.Y
		n.BackgroundColor3 = Theme.Element
		n.BackgroundTransparency = 1
		n.BorderSizePixel = 0
		n.ClipsDescendants = true
		n.Position = UDim2.new(1, 36, 0, 0)
		n.Parent = holder
		Corner(n, 10)

		local stroke = Stroke(n, Color3.new(1, 1, 1), 1.5)
		stroke.Transparency = 1
		registerRGB(stroke)

		local nPad = Instance.new("UIPadding")
		nPad.PaddingTop = UDim.new(0, 12)
		nPad.PaddingLeft = UDim.new(0, 12)
		nPad.PaddingBottom = UDim.new(0, 10)
		nPad.PaddingRight = UDim.new(0, 12)
		nPad.Parent = n

		local nList = Instance.new("UIListLayout")
		nList.SortOrder = Enum.SortOrder.LayoutOrder
		nList.Padding = UDim.new(0, 8)
		nList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		nList.VerticalAlignment = Enum.VerticalAlignment.Top
		nList.Parent = n

		local row = Instance.new("Frame")
		row.Name = "Row"
		row.Size = UDim2.new(1, 0, 0, 0)
		row.AutomaticSize = Enum.AutomaticSize.Y
		row.BackgroundTransparency = 1
		row.BorderSizePixel = 0
		row.LayoutOrder = 1
		row.Parent = n

		local rowLayout = Instance.new("UIListLayout")
		rowLayout.FillDirection = Enum.FillDirection.Horizontal
		rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
		rowLayout.Padding = UDim.new(0, 10)
		rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		rowLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		rowLayout.Parent = row

		local icon

		if hasIcon then
			icon = Instance.new("ImageLabel")
			icon.Name = "Icon"
			icon.Size = UDim2.new(0, 32, 0, 32)
			icon.BackgroundTransparency = 1
			icon.ImageTransparency = 1
			icon.ImageColor3 = accent
			icon.LayoutOrder = 1
			icon.Parent = row

			setIcon(icon, image)
		end

		local textBox = Instance.new("Frame")
		textBox.Name = "TextBox"
		textBox.Size = UDim2.new(1, hasIcon and -42 or 0, 0, 0)
		textBox.AutomaticSize = Enum.AutomaticSize.Y
		textBox.BackgroundTransparency = 1
		textBox.BorderSizePixel = 0
		textBox.LayoutOrder = 2
		textBox.Parent = row

		local textList = Instance.new("UIListLayout")
		textList.SortOrder = Enum.SortOrder.LayoutOrder
		textList.Padding = UDim.new(0, 3)
		textList.HorizontalAlignment = Enum.HorizontalAlignment.Left
		textList.VerticalAlignment = Enum.VerticalAlignment.Top
		textList.Parent = textBox

		local titleLbl
		local contentLbl

		if hasTitle then
			titleLbl = Instance.new("TextLabel")
			titleLbl.Name = "Title"
			titleLbl.Size = UDim2.new(1, 0, 0, 0)
			titleLbl.AutomaticSize = Enum.AutomaticSize.Y
			titleLbl.BackgroundTransparency = 1
			titleLbl.Text = title
			titleLbl.TextColor3 = accent
			titleLbl.TextSize = 14
			titleLbl.Font = Enum.Font.GothamBold
			titleLbl.TextXAlignment = Enum.TextXAlignment.Left
			titleLbl.TextYAlignment = Enum.TextYAlignment.Top
			titleLbl.TextWrapped = true
			titleLbl.TextTransparency = 1
			titleLbl.LayoutOrder = 1
			titleLbl.Parent = textBox
		end

		if hasContent then
			contentLbl = Instance.new("TextLabel")
			contentLbl.Name = "Content"
			contentLbl.Size = UDim2.new(1, 0, 0, 0)
			contentLbl.AutomaticSize = Enum.AutomaticSize.Y
			contentLbl.BackgroundTransparency = 1
			contentLbl.Text = content
			contentLbl.TextColor3 = Color3.fromRGB(232, 232, 232)
			contentLbl.TextSize = 12
			contentLbl.Font = Enum.Font.Gotham
			contentLbl.TextXAlignment = Enum.TextXAlignment.Left
			contentLbl.TextYAlignment = Enum.TextYAlignment.Top
			contentLbl.TextWrapped = true
			contentLbl.TextTransparency = 1
			contentLbl.LayoutOrder = 2
			contentLbl.Parent = textBox
		end

		local track = Instance.new("Frame")
		track.Name = "ProgressTrack"
		track.Size = UDim2.new(1, 0, 0, 4)
		track.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		track.BackgroundTransparency = 0.25
		track.BorderSizePixel = 0
		track.ClipsDescendants = true
		track.LayoutOrder = 2
		track.Parent = n
		Corner(track, 99)

		local fill = Instance.new("Frame")
		fill.Name = "ProgressFill"
		fill.Size = UDim2.new(1, 0, 1, 0)
		fill.BackgroundColor3 = accent
		fill.BorderSizePixel = 0
		fill.Parent = track
		Corner(fill, 99)

		-- Animasi masuk
		task.wait()

		Tween(
			n,
			0.35,
			{
				Position = UDim2.new(0, 0, 0, 0),
				BackgroundTransparency = 0,
			},
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out
		)

		Tween(stroke, 0.35, {Transparency = 0})

		if icon then
			Tween(icon, 0.28, {ImageTransparency = 0})
		end

		if titleLbl then
			Tween(titleLbl, 0.28, {TextTransparency = 0})
		end

		if contentLbl then
			Tween(contentLbl, 0.28, {TextTransparency = 0})
		end

		-- Progress bar sesuai durasi
		Tween(
			fill,
			duration,
			{Size = UDim2.new(0, 0, 1, 0)},
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.Out
		)

		-- Animasi keluar
		task.delay(duration, function()
			if not holder or not holder.Parent then
				return
			end

			Tween(
				n,
				0.3,
				{
					Position = UDim2.new(1, 36, 0, 0),
					BackgroundTransparency = 1,
				},
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.In
			)

			Tween(stroke, 0.3, {Transparency = 1})

			if icon then
				Tween(icon, 0.25, {ImageTransparency = 1})
			end

			if titleLbl then
				Tween(titleLbl, 0.25, {TextTransparency = 1})
			end

			if contentLbl then
				Tween(contentLbl, 0.25, {TextTransparency = 1})
			end

			task.delay(0.32, function()
				if holder and holder.Parent then
					holder:Destroy()
				end
			end)
		end)
	end)
end

--// Window
function Library:CreateWindow(config)
	if Library._destroyed or (type(Env) == "table" and Env.ZethHubGeneration ~= Library.Generation) then
		return nil
	end

	config = config or {}
	local title = config.Title or "ZETHUB"
	local subtitle = config.Subtitle or "V5 • YinYang Edition"
	local OPEN_SIZE = UDim2.new(0, 560, 0, 420)

local gui = Instance.new("ScreenGui")
	gui.Name = "ZethHubV5"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 998
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function()
		gui.Parent = game:GetService("CoreGui")
	end)
	if not gui.Parent then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

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

	-- Tooltip
	local Tooltip, ttText
	Tooltip = Instance.new("Frame")
	Tooltip.Size = UDim2.new(0, 10, 0, 22)
	Tooltip.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
	Tooltip.BorderSizePixel = 0
	Tooltip.ZIndex = 200
	Tooltip.Visible = false
	Tooltip.Parent = gui
	Corner(Tooltip, 4)
	Stroke(Tooltip, Color3.fromRGB(255,255,255), 1).Transparency = 0.8

	ttText = Instance.new("TextLabel")
	ttText.Size = UDim2.new(1, -10, 1, 0)
	ttText.Position = UDim2.new(0, 5, 0, 0)
	ttText.BackgroundTransparency = 1
	ttText.TextColor3 = Color3.fromRGB(255, 255, 255)
	ttText.TextSize = 11
	ttText.Font = Enum.Font.Gotham
	ttText.TextXAlignment = Enum.TextXAlignment.Left
	ttText.Parent = Tooltip

	local function ShowTooltip(text)
		ttText.Text = text
		Tooltip.Size = UDim2.new(0, ttText.TextBounds.X + 12, 0, 22)
		Tooltip.Visible = true
	end

	local function HideTooltip()
		Tooltip.Visible = false
	end

	local function addTooltip(obj, text)
		if text then
			obj.MouseEnter:Connect(function()
				ShowTooltip(text)
			end)
			obj.MouseLeave:Connect(function()
				HideTooltip()
			end)
		end
	end

	Connect(RunService.RenderStepped, function()
		if Tooltip.Visible then
			local m = UserInputService:GetMouseLocation()
			Tooltip.Position = UDim2.new(0, m.X + 15, 0, m.Y + 15)
		end
	end, nil)

	-- Topbar
	local topbar = Instance.new("Frame")
	topbar.Size = UDim2.new(1, 0, 0, TOPBAR_H)
	topbar.BackgroundTransparency = 1
	topbar.ZIndex = 45
	topbar.Parent = main

	local titleRow = Instance.new("Frame")
	titleRow.Size = UDim2.new(1, -110, 0, 24)
	titleRow.Position = UDim2.new(0, 16, 0, 7)
	titleRow.BackgroundTransparency = 1
	titleRow.ZIndex = 46
	titleRow.Active = false
	titleRow.Parent = topbar

	local titleLayout = Instance.new("UIListLayout")
	titleLayout.FillDirection = Enum.FillDirection.Horizontal
	titleLayout.SortOrder = Enum.SortOrder.LayoutOrder
	titleLayout.Padding = UDim.new(0, 8)
	titleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	titleLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	titleLayout.Parent = titleRow

	local titleLbl = Instance.new("TextLabel")
	titleLbl.Size = UDim2.new(0, 0, 0, 18)
	titleLbl.AutomaticSize = Enum.AutomaticSize.X
	titleLbl.BackgroundTransparency = 1
	titleLbl.Text = title
	titleLbl.TextColor3 = Theme.Text
	titleLbl.TextSize = 15
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.LayoutOrder = 1
	titleLbl.ZIndex = 47
	titleLbl.Parent = titleRow

	local subLbl = Instance.new("TextLabel")
	subLbl.Size = UDim2.new(0.6, 0, 0, 14)
	subLbl.Position = UDim2.new(0, 16, 0, 31)
	subLbl.BackgroundTransparency = 1
	subLbl.Text = subtitle
	subLbl.TextColor3 = Theme.SubText
	subLbl.TextSize = 11
	subLbl.Font = Enum.Font.Gotham
	subLbl.TextXAlignment = Enum.TextXAlignment.Left
	subLbl.ZIndex = 46
	subLbl.Parent = topbar

	--// WindUI-style Tag Row
	local tagRow = Instance.new("Frame")
	tagRow.Size = UDim2.new(0, 0, 0, 22)
	tagRow.AutomaticSize = Enum.AutomaticSize.X
	tagRow.BackgroundTransparency = 1
	tagRow.ZIndex = 47
	tagRow.Active = false
	tagRow.LayoutOrder = 2
	tagRow.Parent = titleRow

	local tagLayout = Instance.new("UIListLayout")
	tagLayout.FillDirection = Enum.FillDirection.Horizontal
	tagLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tagLayout.Padding = UDim.new(0, 6)
	tagLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	tagLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	tagLayout.Parent = tagRow

	local function iconButton(xoff, kind)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0, 26, 0, 26)
		b.Position = UDim2.new(1, xoff, 0.5, -13)
		b.BackgroundColor3 = Theme.Element
		b.BorderSizePixel = 0
		b.Text = ""
		b.AutoButtonColor = false
		b.ZIndex = 48
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
				l.ZIndex = 49
				l.Parent = b
			end
			b.MouseEnter:Connect(function()
				Tween(b, .2, {BackgroundColor3 = Color3.fromRGB(225, 70, 70)})
			end)
			b.MouseLeave:Connect(function()
				Tween(b, .2, {BackgroundColor3 = Theme.Element})
			end)
		else
			local l = Instance.new("Frame")
			l.Size = UDim2.new(0, 12, 0, 2)
			l.Position = UDim2.new(0.5, -6, 0.5, -1)
			l.BackgroundColor3 = Theme.SubText
			l.BorderSizePixel = 0
			l.ZIndex = 49
			l.Parent = b
			b.MouseEnter:Connect(function()
				Tween(b, .2, {BackgroundColor3 = Theme.ElementHover})
			end)
			b.MouseLeave:Connect(function()
				Tween(b, .2, {BackgroundColor3 = Theme.Element})
			end)
		end

		return b
	end

	local minimizeBtn = iconButton(-62, "min")
	local closeBtn = iconButton(-32, "close")

	local window = {
		accent = config.Accent or Library.Accent,
		listeners = {},
		offset = Vector2.new(0, 0),
		_connections = {},
		_destroyed = false,
		_gui = gui,
	}

	function window:Destroy()
		if self._destroyed then return end
		self._destroyed = true

		for _, conn in ipairs(self._connections) do
			pcall(function()
				conn:Disconnect()
			end)
		end

		self._connections = {}
		self.listeners = {}

		pcall(function()
			gui:Destroy()
		end)

		for i, w in ipairs(Library._windows) do
			if w == self then
				table.remove(Library._windows, i)
				break
			end
		end

		if #Library._windows == 0 then
			Library.Open = false
		end
	end

	table.insert(Library._windows, window)

	function window:onAccent(fn)
		table.insert(self.listeners, fn)
		fn(self.accent)
	end

	function window:SetAccent(c)
		self.accent = c
		for _, fn in ipairs(self.listeners) do
			fn(c)
		end
	end

	--// Add Tag API
	function window:AddTag(cfg)
		cfg = cfg or {}
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(0, 0, 0, 22)
		lbl.AutomaticSize = Enum.AutomaticSize.X
		lbl.BackgroundColor3 = cfg.Color or window.accent
		lbl.BorderSizePixel = 0
		lbl.Text = cfg.Text or cfg.Name or cfg.Title or "Tag"
		lbl.TextColor3 = cfg.TextColor or cfg.TextColor3 or Color3.fromRGB(0, 0, 0)
		lbl.TextSize = 11
		lbl.Font = Enum.Font.GothamBold
		lbl.TextXAlignment = Enum.TextXAlignment.Center
		lbl.TextWrapped = false
		lbl.ZIndex = 47
		lbl.Active = false
		lbl.Parent = tagRow
		Corner(lbl, 99)
		Pad(lbl, 0, 10, 0, 10)

		if cfg.FollowAccent then
			window:onAccent(function(c)
				lbl.BackgroundColor3 = c
			end)
		end

		return lbl
	end

	local tagCount = 0
	local function addConfigTag(v)
		tagCount += 1
		local index = tagCount
		if type(v) == "string" then
			v = {Text = v}
		end

		local bg = v.Color or v.BackgroundColor3
		local followAccent = false
		if not bg then
			if index == 1 then
				bg = Color3.fromRGB(255, 204, 0)
			elseif index == 2 then
				bg = Color3.fromRGB(46, 230, 110)
			else
				bg = window.accent
				followAccent = true
			end
		end

		local tc = v.TextColor or v.TextColor3
		if not tc then
			local bright = (bg.R + bg.G + bg.B) / 3
			tc = bright > 0.62 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
		end

		window:AddTag({
			Text = v.Text or v.Name or v.Title or "Tag",
			Color = bg,
			TextColor = tc,
			FollowAccent = followAccent,
		})
	end

	local tagsConfig = config.Tags
	if tagsConfig == nil then
		tagsConfig = {
			{Text = "V5", Color = Color3.fromRGB(255, 204, 0), TextColor = Color3.fromRGB(0, 0, 0)},
			{Text = "UI Library", Color = Color3.fromRGB(46, 230, 110), TextColor = Color3.fromRGB(0, 0, 0)},
		}
	end

	if tagsConfig ~= false and type(tagsConfig) == "table" then
		if tagsConfig.Text or tagsConfig.Name or tagsConfig.Title then
			addConfigTag(tagsConfig)
		else
			for _, v in ipairs(tagsConfig) do
				addConfigTag(v)
			end
		end
	end

	-- Resize handle
	local resizeHandle = Instance.new("TextButton")
	resizeHandle.Size = UDim2.new(0, 14, 0, 14)
	resizeHandle.Position = UDim2.new(1, -15, 1, -15)
	resizeHandle.BackgroundTransparency = 1
	resizeHandle.Text = ""
	resizeHandle.AutoButtonColor = false
	resizeHandle.ZIndex = 50
	resizeHandle.Parent = main

	for i = 0, 2 do
		local d = Instance.new("Frame")
		d.Size = UDim2.new(0, 2 + i * 4, 0, 2)
		d.AnchorPoint = Vector2.new(1, 1)
		d.Position = UDim2.new(1, -2, 1, -2 - i * 4)
		d.BackgroundColor3 = Theme.SubText
		d.BorderSizePixel = 0
		d.ZIndex = 51
		d.Parent = resizeHandle
	end

	local resizing, resizeStart, resizeOrig = false, nil, nil
	Connect(resizeHandle.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			resizing = true
			resizeStart = inp.Position
			resizeOrig = main.Size
		end
	end, window)

	Connect(UserInputService.InputChanged, function(inp)
		if resizing and inp.UserInputType == Enum.UserInputType.MouseMovement then
			local d = inp.Position - resizeStart
			main.Size = UDim2.new(
				0,
				math.clamp(resizeOrig.X.Offset + d.X, 460, 1100),
				0,
				math.clamp(resizeOrig.Y.Offset + d.Y, 340, 760)
			)
		end
	end, window)

	Connect(UserInputService.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			resizing = false
		end
	end, window)

	-- Drag
	local dragging, dragStart, dragOrig
	Connect(topbar.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = inp.Position
			dragOrig = window.offset
		end
	end, window)

	Connect(UserInputService.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end, window)

	Connect(UserInputService.InputChanged, function(inp)
		if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local d = inp.Position - dragStart
			local vp = workspace.CurrentCamera.ViewportSize
			local x = math.clamp(dragOrig.X + d.X, -(vp.X/2 - 80), vp.X/2 - 80)
			local y = math.clamp(dragOrig.Y + d.Y, -(vp.Y/2 - 60), vp.Y/2 - 60)
			window.offset = Vector2.new(x, y)
			main.Position = UDim2.new(0.5, x, 0.5, y)
		end
	end, window)

	-- Sidebar
	local sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, 150, 1, -TOPBAR_H)
	sidebar.Position = UDim2.new(0, 0, 0, TOPBAR_H)
	sidebar.BackgroundColor3 = Theme.Sidebar
	sidebar.BorderSizePixel = 0
	sidebar.ZIndex = 41
	sidebar.Parent = main
	Corner(sidebar, 10)

	local sideTop = Instance.new("Frame")
	sideTop.Size = UDim2.new(1, 0, 0, 12)
	sideTop.Position = UDim2.new(0, 0, 0, TOPBAR_H)
	sideTop.BackgroundColor3 = Theme.Sidebar
	sideTop.BorderSizePixel = 0
	sideTop.ZIndex = 41
	sideTop.Parent = main

	local sideList = Instance.new("UIListLayout")
	sideList.SortOrder = Enum.SortOrder.LayoutOrder
	sideList.Padding = UDim.new(0, 5)
	sideList.Parent = sidebar
	Pad(sidebar, 10, 8, 10, 8)

	-- Content
	local content = Instance.new("ScrollingFrame")
	content.Size = UDim2.new(1, -150, 1, -(TOPBAR_H + 12))
	content.Position = UDim2.new(0, 150, 0, TOPBAR_H)
	content.BackgroundTransparency = 1
	content.BorderSizePixel = 0
	content.ScrollBarThickness = 3
	content.ScrollBarImageColor3 = window.accent
	content.AutomaticCanvasSize = Enum.AutomaticSize.Y
	content.CanvasSize = UDim2.new(0, 0, 0, 0)
	content.ZIndex = 41
	content.Parent = main

	window:onAccent(function(c)
		content.ScrollBarImageColor3 = c
	end)

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
	spacer.Size = UDim2.new(1, 0, 0, 2)
	spacer.BackgroundTransparency = 1
	spacer.Parent = container

	local info = nil

	--// Keybind List
	local kbEnabled = true
	local kbRows = 0
	local windowOpen = true

	local KeybindList = Instance.new("Frame")
	KeybindList.AnchorPoint = Vector2.new(1, 1)
	KeybindList.Position = UDim2.new(1, -12, 1, -12)
	KeybindList.Size = UDim2.new(0, 176, 0, 30)
	KeybindList.BackgroundColor3 = Theme.Background
	KeybindList.BackgroundTransparency = 0.1
	KeybindList.BorderSizePixel = 0
	KeybindList.ZIndex = 100
	KeybindList.AutomaticSize = Enum.AutomaticSize.Y
	KeybindList.Visible = false
	KeybindList.Parent = gui
	Corner(KeybindList, 8)
	registerRGB(Stroke(KeybindList, Color3.new(1,1,1), 1.5))

	local kbHeadIcon = makeIcon(KeybindList, "key", UDim2.new(0, 14, 0, 14), UDim2.new(0, 9, 0, 7), Theme.Text)
	local kbTitle = Instance.new("TextLabel")
	kbTitle.Size = UDim2.new(1, -32, 0, 28)
	kbTitle.Position = UDim2.new(0, 27, 0, 0)
	kbTitle.BackgroundTransparency = 1
	kbTitle.Text = "KEYBINDS"
	kbTitle.TextColor3 = Theme.Text
	kbTitle.TextSize = 10
	kbTitle.Font = Enum.Font.GothamBold
	kbTitle.TextXAlignment = Enum.TextXAlignment.Left
	kbTitle.Parent = KeybindList

	local kbRowsFrame = Instance.new("Frame")
	kbRowsFrame.Size = UDim2.new(1, -12, 0, 0)
	kbRowsFrame.Position = UDim2.new(0, 6, 0, 28)
	kbRowsFrame.BackgroundTransparency = 1
	kbRowsFrame.AutomaticSize = Enum.AutomaticSize.Y
	kbRowsFrame.Parent = KeybindList

	local kbRowList = Instance.new("UIListLayout")
	kbRowList.SortOrder = Enum.SortOrder.LayoutOrder
	kbRowList.Padding = UDim.new(0, 3)
	kbRowList.Parent = kbRowsFrame

	local kbBottomPad = Instance.new("UIPadding")
	kbBottomPad.PaddingBottom = UDim.new(0, 8)
	kbBottomPad.Parent = KeybindList

	local function refreshKbVis()
		KeybindList.Visible = windowOpen and kbEnabled and kbRows > 0
	end

	function window:ToggleKeybindList(state)
		kbEnabled = (state == nil) and not kbEnabled or state
		refreshKbVis()
	end

	function window:AddKeybind(name, keyName)
		kbRows += 1

		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 16)
		row.BackgroundTransparency = 1
		row.Parent = kbRowsFrame

		local nLbl = Instance.new("TextLabel")
		nLbl.Size = UDim2.new(1, -62, 1, 0)
		nLbl.BackgroundTransparency = 1
		nLbl.Text = name
		nLbl.TextColor3 = Theme.SubText
		nLbl.TextSize = 11
		nLbl.Font = Enum.Font.Gotham
		nLbl.TextXAlignment = Enum.TextXAlignment.Left
		nLbl.TextTruncate = Enum.TextTruncate.AtEnd
		nLbl.Parent = row

		local kLbl = Instance.new("TextLabel")
		kLbl.Size = UDim2.new(0, 58, 1, 0)
		kLbl.Position = UDim2.new(1, -58, 0, 0)
		kLbl.BackgroundTransparency = 1
		kLbl.Text = keyName
		kLbl.TextColor3 = window.accent
		kLbl.TextSize = 11
		kLbl.Font = Enum.Font.GothamBold
		kLbl.TextXAlignment = Enum.TextXAlignment.Right
		kLbl.Parent = row

		window:onAccent(function(c)
			kLbl.TextColor3 = c
		end)

		refreshKbVis()

		return {
			Set = function(self, k)
				kLbl.Text = k
			end
		}
	end

	--// Tabs
	function window:CreateTab(name, icon)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, H_TAB)
		btn.BackgroundColor3 = window.accent
		btn.BackgroundTransparency = 1
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Parent = sidebar
		Corner(btn, 7)

		local ind = Instance.new("Frame")
		ind.Size = UDim2.new(0, 3, 0, 16)
		ind.Position = UDim2.new(0, 6, 0.5, -8)
		ind.BackgroundColor3 = window.accent
		ind.BackgroundTransparency = 1
		ind.BorderSizePixel = 0
		ind.Parent = btn
		Corner(ind, 2)

		local tabIcon = makeIcon(btn, icon, UDim2.new(0, 16, 0, 16), UDim2.new(0, 14, 0.5, -8), Theme.SubText)
		local labelX = tabIcon and 36 or 14

		local tabLbl = Instance.new("TextLabel")
		tabLbl.Size = UDim2.new(1, -(labelX + 8), 1, 0)
		tabLbl.Position = UDim2.new(0, labelX, 0, 0)
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
				if tabIcon then Tween(tabIcon, .2, {ImageColor3 = curAccent()}) end
			else
				Tween(btn, .2, {BackgroundTransparency = 1})
				Tween(tabLbl, .2, {TextColor3 = Theme.SubText})
				Tween(ind, .2, {BackgroundTransparency = 1})
				if tabIcon then Tween(tabIcon, .2, {ImageColor3 = Theme.SubText}) end
			end
		end

		btn.MouseEnter:Connect(function()
			if window.currentTab ~= tabContent then
				Tween(tabLbl, .2, {TextColor3 = Theme.Text})
				Tween(btn, .2, {BackgroundTransparency = .93})
			end
		end)

		btn.MouseLeave:Connect(function()
			if window.currentTab ~= tabContent then
				Tween(tabLbl, .2, {TextColor3 = Theme.SubText})
				Tween(btn, .2, {BackgroundColor3 = curAccent(), BackgroundTransparency = 1})
			end
		end)

		btn.MouseButton1Click:Connect(function()
			if window.currentTab == tabContent then return end
			if window.currentTab then
				window.currentTab.Visible = false
				if window.currentTabData then
					window.currentTabData.setActive(false)
				end
			end

			tabContent.Visible = true
			setActive(true)
			window.currentTab = tabContent
			window.currentTabData = { setActive = setActive }
			content.CanvasPosition = Vector2.new(0, 0)
		end)

		window:onAccent(function(c)
			ind.BackgroundColor3 = c
			if window.currentTab == tabContent then
				btn.BackgroundColor3 = c
			end
		end)

		if not window.currentTab then
			tabContent.Visible = true
			setActive(true)
			window.currentTab = tabContent
			window.currentTabData = { setActive = setActive }
		end

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

		local function hoverBorder(f, s, colFn)
			f.MouseEnter:Connect(function()
				Tween(s, .2, {Color = colFn()})
			end)
			f.MouseLeave:Connect(function()
				Tween(s, .2, {Color = Theme.Border})
			end)
		end

		function tab:CreateSection(text)
			local holder = Instance.new("Frame")
			holder.Size = UDim2.new(1, 0, 0, H_SECTION)
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

			window:onAccent(function(c)
				bar.BackgroundColor3 = c
			end)

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

			return {
				Set = function(self, t)
					lbl.Text = t
				end
			}
		end

		--// Paragraph dengan frame/alas versi lebih rapi
		function tab:CreateParagraph(cfg)
			cfg = cfg or {}

			local function toText(v)
				if type(v) == "table" then
					return table.concat(v, "\n")
				end
				return tostring(v or "")
			end

			local titleText = toText(cfg.Title)
			local contentText = toText(cfg.Content)

			local f = Instance.new("Frame")
			f.Size = UDim2.new(1, 0, 0, 0)
			f.AutomaticSize = Enum.AutomaticSize.Y
			f.BackgroundColor3 = Theme.Element
			f.BackgroundTransparency = 0
			f.BorderSizePixel = 0
			f.Parent = tabContent
			Corner(f, 8)

			local s = Stroke(f, Theme.Border, 1)

			local pad = Instance.new("UIPadding")
			pad.PaddingTop = UDim.new(0, 12)
			pad.PaddingLeft = UDim.new(0, 12)
			pad.PaddingBottom = UDim.new(0, 12)
			pad.PaddingRight = UDim.new(0, 12)
			pad.Parent = f

			local layout = Instance.new("UIListLayout")
			layout.SortOrder = Enum.SortOrder.LayoutOrder
			layout.Padding = UDim.new(0, 7)
			layout.Parent = f

			-- ✅ Pastikan frame paragraph selalu punya tinggi minimum
			local sizeConstraint = Instance.new("UISizeConstraint")
			sizeConstraint.MinSize = Vector2.new(0, 58)
			sizeConstraint.MaxSize = Vector2.new(999999, 999999)
			sizeConstraint.Parent = f

			-- Row judul, supaya bisa pakai icon di sebelah kiri judul
			local titleRow = Instance.new("Frame")
			titleRow.Size = UDim2.new(1, 0, 0, 0)
			titleRow.AutomaticSize = Enum.AutomaticSize.Y
			titleRow.BackgroundTransparency = 1
			titleRow.LayoutOrder = 1
			titleRow.Parent = f

			local rowLayout = Instance.new("UIListLayout")
			rowLayout.FillDirection = Enum.FillDirection.Horizontal
			rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
			rowLayout.Padding = UDim.new(0, 8)
			rowLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			rowLayout.Parent = titleRow

			local iconOffset = 0

			-- Optional icon seperti gaya Rayfield
-- Optional icon seperti gaya Rayfield
if cfg.Icon and cfg.Icon ~= "" then
	local asset, offset, rectSize = resolveIcon(cfg.Icon)

	if asset and asset ~= "" then
		local icon = Instance.new("ImageLabel")
		icon.Size = UDim2.new(0, 18, 0, 18)
		icon.BackgroundTransparency = 1
		icon.Image = asset

		if offset and rectSize then
			icon.ImageRectOffset = offset
			icon.ImageRectSize = rectSize
		end

		icon.ImageColor3 = window.accent
		icon.LayoutOrder = 1
		icon.Parent = titleRow

		window:onAccent(function(c)
			if icon.Parent then
				icon.ImageColor3 = c
			end
		end)

		iconOffset = 26
	end
end

			local titleObj = Instance.new("TextLabel")
			titleObj.Size = UDim2.new(1, -iconOffset, 0, 0)
			titleObj.AutomaticSize = Enum.AutomaticSize.Y
			titleObj.BackgroundTransparency = 1
			titleObj.Text = titleText
			titleObj.TextColor3 = Theme.Text
			titleObj.TextSize = 13
			titleObj.Font = Enum.Font.GothamBold
			titleObj.TextXAlignment = Enum.TextXAlignment.Left
			titleObj.TextYAlignment = Enum.TextYAlignment.Top
			titleObj.TextWrapped = true
			titleObj.LayoutOrder = 2
			titleObj.Visible = titleText ~= ""
			titleObj.Parent = titleRow

			titleRow.Visible = (iconOffset > 0) or (titleText ~= "")

			local contentObj = Instance.new("TextLabel")
			contentObj.Size = UDim2.new(1, 0, 0, 0)
			contentObj.AutomaticSize = Enum.AutomaticSize.Y
			contentObj.BackgroundTransparency = 1
			contentObj.Text = contentText
			contentObj.TextColor3 = Theme.SubText
			contentObj.TextSize = 12
			contentObj.Font = Enum.Font.Gotham
			contentObj.TextXAlignment = Enum.TextXAlignment.Left
			contentObj.TextYAlignment = Enum.TextYAlignment.Top
			contentObj.TextWrapped = true
			contentObj.LayoutOrder = 2
			contentObj.Visible = contentText ~= ""
			contentObj.Parent = f

			hoverBorder(f, s, function()
				return window.accent
			end)

			local para = {}
			function para:Set(newCfg)
				if type(newCfg) == "table" then
					if newCfg.Title ~= nil then
						titleText = toText(newCfg.Title)
						titleObj.Text = titleText
						titleObj.Visible = titleText ~= ""
						titleRow.Visible = (iconOffset > 0) or (titleText ~= "")
					end

					if newCfg.Content ~= nil then
						contentText = toText(newCfg.Content)
						contentObj.Text = contentText
						contentObj.Visible = contentText ~= ""
					end
				else
					contentText = toText(newCfg)
					contentObj.Text = contentText
					contentObj.Visible = contentText ~= ""
				end
			end

			return para
		end

		function tab:CreateToggle(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(H_ELEMENT)
			local hasIcon = makeIcon(f, cfg.Icon)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -(lx + 56), 1, 0)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Toggle"
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

				if cfg.Flag then
					Library.Flags[cfg.Flag] = enabled
				end
			end

			update()
			window:onAccent(function() update() end)
			hoverBorder(f, s, accent)

			switch.MouseButton1Click:Connect(function()
				enabled = not enabled
				update()
				if cfg.Callback then
					task.spawn(cfg.Callback, enabled)
				end
			end)

			addTooltip(f, cfg.Tooltip)

			return {
				Set = function(self, v)
					enabled = v
					update()
					if cfg.Callback then
						task.spawn(cfg.Callback, enabled)
					end
				end
			}
		end

		function tab:CreateSlider(cfg)
			cfg = cfg or {}
			local min, max = cfg.Min or 0, cfg.Max or 100
			local value = cfg.Default or min
			local col = cfg.Color
			local f, s = elementFrame(H_SLIDER)

			local hasIcon = makeIcon(f, cfg.Icon, UDim2.new(0, 16, 0, 16), UDim2.new(0, 12, 0, 7))
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.6, -lx, 0, 16)
			lbl.Position = UDim2.new(0, lx, 0, 7)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Slider"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f

			local val = Instance.new("TextLabel")
			val.Size = UDim2.new(0.4, -12, 0, 16)
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
			track.Position = UDim2.new(0, 12, 0, 30)
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

			local knobStroke = Stroke(knob, col or window.accent, 2)

			local hit = Instance.new("TextButton")
			hit.Size = UDim2.new(1, -24, 0, 18)
			hit.Position = UDim2.new(0, 12, 0, 24)
			hit.BackgroundTransparency = 1
			hit.Text = ""
			hit.AutoButtonColor = false
			hit.Parent = f

			local function apply(v, fire)
				value = math.clamp(math.floor(v), min, max)
				local rel = (value - min) / math.max(1, max - min)
				fill.Size = UDim2.new(rel, 0, 1, 0)
				knob.Position = UDim2.new(rel, -6, 0.5, -6)
				val.Text = tostring(value)

				if cfg.Flag then
					Library.Flags[cfg.Flag] = value
				end

				if fire and cfg.Callback then
					task.spawn(cfg.Callback, value)
				end
			end

			apply(value, false)

			window:onAccent(function(c)
				if not col then
					val.TextColor3 = c
					fill.BackgroundColor3 = c
					knobStroke.Color = c
				end
			end)

			local sliding = false
			hit.InputBegan:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					sliding = true
					local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
					apply(min + (max - min) * rel, true)
				end
			end)

			Connect(UserInputService.InputChanged, function(inp)
				if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
					local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
					apply(min + (max - min) * rel, true)
				end
			end, window)

			Connect(UserInputService.InputEnded, function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					sliding = false
				end
			end, window)

			hoverBorder(f, s, function() return col or window.accent end)
			addTooltip(f, cfg.Tooltip)

			return {
				Set = function(self, v)
					apply(v, true)
				end
			}
		end

		function tab:CreateButton(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(H_ELEMENT)
			local hasIcon = makeIcon(f, cfg.Icon)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -(lx + 24), 1, 0)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Button"
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

			window:onAccent(function(c)
				if not col then
					arrow.TextColor3 = c
				end
			end)

			f.MouseEnter:Connect(function()
				Tween(f, .2, {BackgroundColor3 = Theme.ElementHover})
				Tween(s, .2, {Color = col or window.accent})
			end)

			f.MouseLeave:Connect(function()
				Tween(f, .2, {BackgroundColor3 = Theme.Element})
				Tween(s, .2, {Color = Theme.Border})
			end)

			local click = Instance.new("TextButton")
			click.Size = UDim2.new(1, 0, 1, 0)
			click.BackgroundTransparency = 1
			click.Text = ""
			click.AutoButtonColor = false
			click.Parent = f

			click.MouseButton1Click:Connect(function()
				Tween(f, .1, {Size = UDim2.new(1, -6, 0, H_ELEMENT - 2)}, Enum.EasingStyle.Back)
				task.delay(.12, function()
					if f.Parent then
						Tween(f, .15, {Size = UDim2.new(1, 0, 0, H_ELEMENT)}, Enum.EasingStyle.Back)
					end
				end)

				if cfg.Callback then
					task.spawn(cfg.Callback)
				end
			end)

			addTooltip(f, cfg.Tooltip)
			return f
		end

		function tab:CreateTextbox(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(H_ELEMENT)
			local hasIcon = makeIcon(f, cfg.Icon)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -(lx + 150), 1, 0)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Textbox"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0, 140, 0, 24)
			box.Position = UDim2.new(1, -152, 0.5, -12)
			box.BackgroundColor3 = Theme.Background
			box.BorderSizePixel = 0
			box.PlaceholderText = cfg.PlaceholderText or cfg.Placeholder or "Type here..."
			box.PlaceholderColor3 = Theme.SubText
			box.Text = ""
			box.TextColor3 = col or window.accent
			box.TextSize = 12
			box.Font = Enum.Font.Gotham
			box.Parent = f
			Corner(box, 6)
			Stroke(box, Theme.Border, 1)
			Pad(box, 0, 8, 0, 8)

			window:onAccent(function(c)
				if not col then
					box.TextColor3 = c
				end
			end)

			box:GetPropertyChangedSignal("Text"):Connect(function()
				if cfg.Flag then
					Library.Flags[cfg.Flag] = box.Text
				end
				if cfg.Callback then
					task.spawn(cfg.Callback, box.Text)
				end
			end)

			hoverBorder(f, s, function() return col or window.accent end)
			addTooltip(f, cfg.Tooltip)

			return {
				Set = function(self, t)
					box.Text = t
				end
			}
		end

		--// INPUT gaya Rayfield
		function tab:CreateInput(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local value = cfg.CurrentValue or ""
			local f, s = elementFrame(H_ELEMENT)
			local hasIcon = makeIcon(f, cfg.Icon)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -(lx + 150), 1, 0)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Input"
			lbl.TextColor3 = Theme.Text
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f

			local box = Instance.new("TextBox")
			box.Size = UDim2.new(0, 140, 0, 24)
			box.Position = UDim2.new(1, -152, 0.5, -12)
			box.BackgroundColor3 = Theme.Background
			box.BorderSizePixel = 0
			box.PlaceholderText = cfg.PlaceholderText or cfg.Placeholder or "Input here..."
			box.PlaceholderColor3 = Theme.SubText
			box.Text = value
			box.TextColor3 = col or window.accent
			box.TextSize = 12
			box.Font = Enum.Font.Gotham
			box.Parent = f
			Corner(box, 6)
			Stroke(box, Theme.Border, 1)
			Pad(box, 0, 8, 0, 8)

			if cfg.Flag then
				Library.Flags[cfg.Flag] = value
			end

			local suppress = false
			window:onAccent(function(c)
				if not col then
					box.TextColor3 = c
				end
			end)

			box:GetPropertyChangedSignal("Text"):Connect(function()
				if suppress then return end
				value = box.Text
				if cfg.Flag then
					Library.Flags[cfg.Flag] = value
				end
				if cfg.Callback then
					task.spawn(cfg.Callback, value)
				end
			end)

			box.FocusLost:Connect(function()
				if cfg.RemoveTextAfterFocusLost then
					suppress = true
					box.Text = ""
					suppress = false
				end
			end)

			hoverBorder(f, s, function() return col or window.accent end)
			addTooltip(f, cfg.Tooltip)

			return {
				Set = function(self, t)
					value = t
					box.Text = t
					if cfg.Flag then
						Library.Flags[cfg.Flag] = t
					end
				end,
				Get = function()
					return value
				end,
			}
		end

				function tab:CreateDropdown(cfg)
			cfg = cfg or {}
			local options = cfg.Options or {}
			local col = cfg.Color
			local headerH = H_ELEMENT
			local gap = 4
			local listH = math.min(#options * 30, 150)
			local openH = headerH + gap + listH + 6
			local f, s = elementFrame(headerH)
			f.ClipsDescendants = true

			-- ✅ FIX: icon dropdown tidak ikut ke bawah saat dibuka
			-- Posisi vertikal dibuat tetap di header, bukan tengah frame
			local hasIcon = makeIcon(f, cfg.Icon, UDim2.new(0, 16, 0, 16), UDim2.new(0, 12, 0, 11), Theme.SubText)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(0.5, -lx, 0, headerH)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Dropdown"
			lbl.TextColor3 = Theme.SubText
			lbl.TextSize = 13
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = f

			local val = Instance.new("TextLabel")
			val.Size = UDim2.new(0.5, -34, 0, headerH)
			val.Position = UDim2.new(0.5, 0, 0, 0)
			val.BackgroundTransparency = 1
			val.Text = cfg.Default or (options[1] or "...")
			val.TextColor3 = Theme.Text
			val.TextSize = 13
			val.Font = Enum.Font.GothamMedium
			val.TextXAlignment = Enum.TextXAlignment.Right
			val.Parent = f

			if cfg.Flag then
				Library.Flags[cfg.Flag] = val.Text
			end

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
			list.Position = UDim2.new(0, 6, 0, headerH + gap)
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
					Tween(list, .3, {Size = UDim2.new(1, -12, 0, listH)})
					Tween(arrow, .3, {Rotation = -90, TextColor3 = col or window.accent})
				else
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, headerH)})
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

				o.MouseEnter:Connect(function()
					Tween(o, .15, {BackgroundTransparency = .85, BackgroundColor3 = col or window.accent, TextColor3 = Theme.Text})
				end)

				o.MouseLeave:Connect(function()
					Tween(o, .15, {BackgroundTransparency = 1, TextColor3 = Theme.SubText})
				end)

				o.MouseButton1Click:Connect(function()
					val.Text = opt
					if cfg.Flag then
						Library.Flags[cfg.Flag] = opt
					end
					toggleOpen()
					if cfg.Callback then
						task.spawn(cfg.Callback, opt)
					end
				end)
			end

			for _, opt in ipairs(options) do
				addOption(opt)
			end

			local head = Instance.new("TextButton")
			head.Size = UDim2.new(1, 0, 0, headerH)
			head.BackgroundTransparency = 1
			head.Text = ""
			head.AutoButtonColor = false
			head.Parent = f
			head.MouseButton1Click:Connect(toggleOpen)

			hoverBorder(f, s, function() return col or window.accent end)
			addTooltip(f, cfg.Tooltip)

			return {
				Refresh = function(self, newOpts)
					for _, c in ipairs(list:GetChildren()) do
						if c:IsA("TextButton") then
							c:Destroy()
						end
					end

					options = newOpts
					listH = math.min(#options * 30, 150)
					openH = headerH + gap + listH + 6

					for _, opt in ipairs(options) do
						addOption(opt)
					end
				end
			}
		end

		--// KEYBIND gaya Rayfield
		function tab:CreateKeybind(cfg)
			cfg = cfg or {}
			local col = cfg.Color
			local f, s = elementFrame(H_ELEMENT)
			local hasIcon = makeIcon(f, cfg.Icon)
			local lx = hasIcon and 34 or 12

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -(lx + 90), 1, 0)
			lbl.Position = UDim2.new(0, lx, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Keybind"
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
			badge.TextColor3 = col or window.accent
			badge.TextSize = 11
			badge.Font = Enum.Font.GothamBold
			badge.AutoButtonColor = false
			badge.Parent = f
			Corner(badge, 5)
			Stroke(badge, Theme.Border, 1)

			local current = cfg.CurrentKeybind or cfg.Default or Enum.KeyCode.Unknown
			if type(current) == "string" then
				current = Enum.KeyCode[current] or Enum.KeyCode.Unknown
			end

			local hold = cfg.HoldToInteract or false
			local binding, holding = false, false
			badge.Text = (current ~= Enum.KeyCode.Unknown) and current.Name or "None"

			if cfg.Flag then
				Library.Flags[cfg.Flag] = current.Name
			end

			local kbRow = window:AddKeybind(cfg.Name or cfg.Title or "Keybind", (current ~= Enum.KeyCode.Unknown) and current.Name or "None")

			local function setKey(k)
				current = k
				badge.Text = (current ~= Enum.KeyCode.Unknown) and current.Name or "None"
				kbRow:Set((current ~= Enum.KeyCode.Unknown) and current.Name or "None")
				if cfg.Flag then
					Library.Flags[cfg.Flag] = current.Name
				end
			end

			window:onAccent(function(c)
				if not col and not binding then
					badge.TextColor3 = c
				end
			end)

			badge.MouseButton1Click:Connect(function()
				binding = true
				badge.Text = "..."
				badge.TextColor3 = col or window.accent
			end)

			Connect(UserInputService.InputBegan, function(inp, gp)
				if gp then return end

				if binding and inp.UserInputType == Enum.UserInputType.Keyboard then
					binding = false
					setKey(inp.KeyCode)
					badge.TextColor3 = col or window.accent
					if cfg.Callback then
						task.spawn(cfg.Callback, current)
					end
				elseif not binding and current ~= Enum.KeyCode.Unknown and inp.KeyCode == current then
					if hold then
						holding = true
						if cfg.Callback then
							task.spawn(cfg.Callback, true)
						end
					else
						if cfg.Callback then
							task.spawn(cfg.Callback, current)
						end
					end
				end
			end, window)

			Connect(UserInputService.InputEnded, function(inp)
				if holding and inp.KeyCode == current then
					holding = false
					if cfg.Callback then
						task.spawn(cfg.Callback, false)
					end
				end
			end, window)

			hoverBorder(f, s, function() return col or window.accent end)
			addTooltip(f, cfg.Tooltip)

			return {
				SetKey = function(self, k)
					setKey(k)
				end,
				GetKey = function()
					return current
				end
			}
		end

		function tab:CreateColorPicker(cfg)
			cfg = cfg or {}
			local col = cfg.Default or Color3.fromRGB(255, 80, 80)
			local f, s = elementFrame(H_ELEMENT)
			f.ClipsDescendants = true

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -66, 1, 0)
			lbl.Position = UDim2.new(0, 12, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = cfg.Name or cfg.Title or "Color Picker"
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
			swatch.AutoButtonColor = false
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
			-- ✅ FIX BUG: CellPadding harus UDim2, bukan UDim
			grid.CellPadding = UDim2.new(0, 5, 0, 5)
			grid.SortOrder = Enum.SortOrder.LayoutOrder
			grid.Parent = picker

			local isOpen = false
			local function togglePicker()
				isOpen = not isOpen
				if isOpen then
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, 107)})
					Tween(picker, .3, {Size = UDim2.new(1, -16, 0, 57)})
				else
					Tween(f, .3, {Size = UDim2.new(1, 0, 0, H_ELEMENT)})
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
				b.Size = UDim2.new(0, 26, 0, 26)
				b.BackgroundColor3 = pc
				b.BorderSizePixel = 0
				b.Text = ""
				b.AutoButtonColor = false
				b.Parent = picker
				Corner(b, 6)

				b.MouseButton1Click:Connect(function()
					col = pc
					swatch.BackgroundColor3 = pc
					if cfg.Flag then
						Library.Flags[cfg.Flag] = pc
					end
					togglePicker()
					if cfg.Callback then
						task.spawn(cfg.Callback, pc)
					end
				end)
			end

			if cfg.Flag then
				Library.Flags[cfg.Flag] = col
			end

			swatch.MouseButton1Click:Connect(togglePicker)
			hoverBorder(f, s, function() return col end)
			addTooltip(f, cfg.Tooltip)

			return {
				Set = function(self, c)
					col = c
					swatch.BackgroundColor3 = c
					if cfg.Flag then
						Library.Flags[cfg.Flag] = c
					end
					if cfg.Callback then
						task.spawn(cfg.Callback, c)
					end
				end
			}
		end

		return tab
	end

	--// Mini Toggle + Label framed: [icon | Show UI / Hide UI]
local MINI_W, MINI_H = 168, 42
local MINI_ICON = 22
local MINI_LINE = 3

local MiniToggle = Instance.new("TextButton")
MiniToggle.Name = "ZethHubMini"
MiniToggle.AnchorPoint = Vector2.new(0.5, 0.5)
MiniToggle.Position = UDim2.new(0, 112, 0.5, 0)
MiniToggle.Size = UDim2.new(0, MINI_W, 0, MINI_H)
MiniToggle.BackgroundColor3 = Theme.Background
MiniToggle.BackgroundTransparency = 0.05
MiniToggle.BorderSizePixel = 0
MiniToggle.Text = ""
MiniToggle.AutoButtonColor = false
MiniToggle.ZIndex = 60
MiniToggle.Parent = gui
Corner(MiniToggle, 12)
registerRGB(Stroke(MiniToggle, Color3.new(1,1,1), 2))
Pad(MiniToggle, 0, 14, 0, 14)

local miniLayout = Instance.new("UIListLayout")
miniLayout.FillDirection = Enum.FillDirection.Horizontal
miniLayout.SortOrder = Enum.SortOrder.LayoutOrder
miniLayout.Padding = UDim.new(0, 10)
miniLayout.VerticalAlignment = Enum.VerticalAlignment.Center
miniLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
miniLayout.Parent = MiniToggle

local miniIconFrame = Instance.new("Frame")
miniIconFrame.Size = UDim2.new(0, MINI_ICON, 0, MINI_ICON)
miniIconFrame.BackgroundTransparency = 1
miniIconFrame.LayoutOrder = 1
miniIconFrame.ZIndex = 61
miniIconFrame.Parent = MiniToggle

local miniLines = {}
local function makeMiniLine(y)
	local l = Instance.new("Frame")
	l.AnchorPoint = Vector2.new(0.5, 0.5)
	l.Position = UDim2.new(0.5, 0, 0.5, y)
	l.Size = UDim2.new(0, MINI_ICON, 0, MINI_LINE)
	l.BackgroundColor3 = Theme.Text
	l.BorderSizePixel = 0
	l.ZIndex = 62
	l.Parent = miniIconFrame
	Corner(l, 2)
	table.insert(miniLines, l)
	return l
end

makeMiniLine(-8)
makeMiniLine(0)
makeMiniLine(8)

local miniSeparator = Instance.new("Frame")
miniSeparator.Size = UDim2.new(0, 1, 0, MINI_ICON)
miniSeparator.BackgroundColor3 = Theme.Border
miniSeparator.BorderSizePixel = 0
miniSeparator.LayoutOrder = 2
miniSeparator.ZIndex = 61
miniSeparator.Parent = MiniToggle

local miniLbl = Instance.new("TextLabel")
miniLbl.Size = UDim2.new(0, 0, 0, MINI_ICON)
miniLbl.AutomaticSize = Enum.AutomaticSize.X
miniLbl.BackgroundTransparency = 1
miniLbl.Text = "Hide UI"
miniLbl.TextColor3 = Theme.Text
miniLbl.TextSize = 12
miniLbl.Font = Enum.Font.GothamBold
miniLbl.TextXAlignment = Enum.TextXAlignment.Left
miniLbl.LayoutOrder = 3
miniLbl.ZIndex = 61
miniLbl.Parent = MiniToggle

MiniToggle.MouseEnter:Connect(function()
	Tween(MiniToggle, .2, {BackgroundColor3 = Theme.ElementHover})
end)

MiniToggle.MouseLeave:Connect(function()
	Tween(MiniToggle, .2, {BackgroundColor3 = Theme.Background})
end)

local function setMiniIcon(open)
	local lineSize = UDim2.new(0, MINI_ICON, 0, MINI_LINE)
	local emptySize = UDim2.new(0, 0, 0, MINI_LINE)

	if open then
		-- X icon saat UI terbuka
		Tween(miniLines[1], .25, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Rotation = 45,
			BackgroundTransparency = 0,
			Size = lineSize,
		})
		Tween(miniLines[2], .25, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Rotation = -45,
			BackgroundTransparency = 0,
			Size = lineSize,
		})
		Tween(miniLines[3], .15, {
			BackgroundTransparency = 1,
			Size = emptySize,
		})
	else
		-- Hamburger/menu icon saat UI hidden
		Tween(miniLines[1], .25, {
			Position = UDim2.new(0.5, 0, 0.5, -8),
			Rotation = 0,
			BackgroundTransparency = 0,
			Size = lineSize,
		})
		Tween(miniLines[2], .25, {
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Rotation = 0,
			BackgroundTransparency = 0,
			Size = lineSize,
		})
		Tween(miniLines[3], .25, {
			Position = UDim2.new(0.5, 0, 0.5, 8),
			Rotation = 0,
			BackgroundTransparency = 0,
			Size = lineSize,
		})
	end
end

local function setMiniLabel(open)
	miniLbl.Text = open and "Hide UI" or "Show UI"
	Tween(miniLbl, .2, {TextColor3 = open and Theme.Text or Theme.SubText})
end

-- HAPUS ATAU KOMENTARI FUNGSI CLAMP BERIKUT INI AGAR TIDAK ADA BATASAN
--[[ 
local function clampMini()
    local vp = workspace.CurrentCamera.ViewportSize
    local halfX = MiniToggle.AbsoluteSize.X / 2
    local halfY = MiniToggle.AbsoluteSize.Y / 2
    local x = math.clamp(MiniToggle.Position.X.Offset, halfX + 4, vp.X - halfX - 4)
    local y = math.clamp(MiniToggle.Position.Y.Offset, halfY + 4, vp.Y - halfY - 4)
    MiniToggle.Position = UDim2.new(0, x, 0, y)
end
]]

local mDrag, mStart, mMoved = false, nil, 0
local mOrigX, mOrigY = 0, 0

Connect(MiniToggle.InputBegan, function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
		mDrag = true
		mMoved = 0
		mStart = inp.Position
		local center = MiniToggle.AbsolutePosition + MiniToggle.AbsoluteSize / 2
		mOrigX, mOrigY = center.X, center.Y
	end
end, window)

Connect(UserInputService.InputChanged, function(inp)
	if mDrag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
		local d = inp.Position - mStart
		mMoved = math.max(mMoved, math.abs(d.X) + math.abs(d.Y))
		
		-- PERBAIKAN: Posisi diatur langsung tanpa dipotong oleh clampMini()
		MiniToggle.Position = UDim2.new(0, mOrigX + d.X, 0, mOrigY + d.Y)
		
		-- Panggilan clampMini() DIHAPUS dari sini
		-- clampMini() 
	end
end, window)

Connect(UserInputService.InputEnded, function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
		mDrag = false
	end
end, window)

function window:Toggle(force)
	if window._destroyed then return end

	local open = (force ~= nil) and force or not Library.Open
	Library.Open = open
	windowOpen = open

	if info then
		info.Visible = open
	end

	if open then
		main.Visible = true
		Tween(main, .35, {Size = OPEN_SIZE}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	else
		Tween(main, .25, {Size = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In).Completed:Connect(function()
			if not Library.Open and not window._destroyed and main.Parent then
				main.Visible = false
			end
		end)
	end

	refreshKbVis()
	setMiniIcon(open)
	setMiniLabel(open)
end

MiniToggle.MouseButton1Click:Connect(function()
	if mMoved > 8 then return end
	window:Toggle()
end)

function window:SetInfoCard(vis)
	if info then
		info.Visible = vis and windowOpen
	end
end

minimizeBtn.MouseButton1Click:Connect(function()
	window:Toggle(false)
end)

closeBtn.MouseButton1Click:Connect(function()
	window:Destroy()
end)

Connect(UserInputService.InputBegan, function(inp, gp)
	if gp then return end
	if inp.KeyCode == Library.ToggleKey then
		window:Toggle()
	end
end, window)

	--// Info Card FPS/Ping
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
	statsLbl.Text = "FPS -- | Ping --ms"
	statsLbl.TextColor3 = window.accent
	statsLbl.TextSize = 10
	statsLbl.Font = Enum.Font.GothamMedium
	statsLbl.TextXAlignment = Enum.TextXAlignment.Left
	statsLbl.Parent = info

	window:onAccent(function(c)
		statsLbl.TextColor3 = c
	end)

	task.spawn(function()
		while info.Parent do
			task.wait(1)

			if window._destroyed or Library._destroyed or (type(Env) == "table" and Env.ZethHubGeneration ~= Library.Generation) then
				return
			end

			statsLbl.Text = "FPS: " .. math.min(currentFps, 999) .. " | Ping: " .. currentPing .. "ms"
		end
	end)

	setMiniIcon(true)
	setMiniLabel(true)

	return window
end

if type(Env) == "table" then
	Env.ZethHubLibrary = Library
end

return Library
