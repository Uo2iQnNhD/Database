--[[
	Delta Mobile | Keyboard Script [but fixed lol]
	Made by: Chillz#0348
	Author: Lxnny ✞#5013 & Chillz#0348 (DeltaTeam)
]]

local game = game
local enum = Enum
local instance = Instance.new
local spawn = task.spawn
local pcall = pcall
local c3 = Color3.new
local rgb = Color3.fromRGB
local hsv = Color3.fromHSV
local u2 = UDim2.new
local u = UDim.new
local fn = Font.new
local KeyCode = enum.KeyCode

local cloneref = cloneref or function(ref)
	if not getreg then return ref end
	local InstanceList
	local a = instance("Part")
	for _, c in pairs(getreg()) do
		if type(c) == "table" and #c then
			if rawget(c, "__mode") == "kvs" then
				for d, e in pairs(c) do
					if e == a then
						InstanceList = c
						break
					end
				end
			end
		end
	end
	local f = {}
	function f.invalidate(g)
		if not InstanceList then
			return
		end
		for b, c in pairs(InstanceList) do
			if c == g then
				InstanceList[b] = nil
				return g
			end
		end
	end
	return f.invalidate
end

local plrs = cloneref(game:GetService("Players"))
local ts = cloneref(game:GetService("TweenService"))
local uis = cloneref(game:GetService("UserInputService"))

--Delta always fuck up the key functions so just use the one provided by roblox engine
local VirtualInput = uis:CreateVirtualInput()
if not VirtualInput then
	return error("[Delta Keyboard]: CreateVirtualInput couldnt be created")
end
local SendKey = VirtualInput.SendKey
local simulatekeypress = function(a)
	pcall(SendKey,VirtualInput, true, a, false)
end
local simulatekeyrelease = function(a)
	pcall(SendKey, VirtualInput, false, a, false)
end

local DLTA = {};

-- StarterGui.DeltaKeyboard
DLTA["1"] = instance("ScreenGui");
DLTA["1"]["Name"] = [[DeltaKeyboard]];
DLTA["1"]["ZIndexBehavior"] = enum.ZIndexBehavior.Sibling;
DLTA["1"]["ResetOnSpawn"] = false;

-- StarterGui.DeltaKeyboard.Main
DLTA["2"] = instance("Frame", DLTA["1"]);
DLTA["2"]["Active"] = true;
DLTA["2"]["BackgroundColor3"] = rgb(25, 25, 25);
DLTA["2"]["Size"] = u2(0, 478, 0, 236);
DLTA["2"]["Position"] = u2(0.5, -239, 0.5, -118);
DLTA["2"]["Name"] = [[Main]];

-- StarterGui.DeltaKeyboard.Main.UIStroke
DLTA["3"] = instance("UIStroke", DLTA["2"]);
DLTA["3"]["Color"] = rgb(158, 0, 255);

-- StarterGui.DeltaKeyboard.Main.Background
DLTA["4"] = instance("Frame", DLTA["2"]);
DLTA["4"]["Active"] = true;
DLTA["4"]["BackgroundColor3"] = rgb(255, 255, 255);
DLTA["4"]["BackgroundTransparency"] = 1;
DLTA["4"]["Size"] = u2(0.9978905916213989, 0, 0.8684942126274109, 0);
DLTA["4"]["Position"] = u2(0, 0, 0.12748458981513977, 0);
DLTA["4"]["Name"] = [[Background]];

-- StarterGui.DeltaKeyboard.Main.Background.-Backquote
DLTA["5"] = instance("TextButton", DLTA["4"]);
DLTA["5"]["TextWrapped"] = true;
DLTA["5"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["5"]["TextSize"] = 21;
DLTA["5"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["5"]["TextColor3"] = rgb(255, 255, 255);
DLTA["5"]["Size"] = u2(0, 25, 0, 25);
DLTA["5"]["Name"] = [[-Backquote]];
DLTA["5"]["Text"] = [[`]];
DLTA["5"]["Position"] = u2(0, 7, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Backquote.UIStroke
DLTA["6"] = instance("UIStroke", DLTA["5"]);
DLTA["6"]["Color"] = rgb(255, 255, 255);
DLTA["6"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Backquote.UICorner
DLTA["7"] = instance("UICorner", DLTA["5"]);
DLTA["7"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-One
DLTA["8"] = instance("TextButton", DLTA["4"]);
DLTA["8"]["TextWrapped"] = true;
DLTA["8"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["8"]["TextSize"] = 21;
DLTA["8"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["8"]["TextColor3"] = rgb(255, 255, 255);
DLTA["8"]["Size"] = u2(0, 25, 0, 25);
DLTA["8"]["Name"] = [[-One]];
DLTA["8"]["Text"] = [[1]];
DLTA["8"]["Position"] = u2(0, 39, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-One.UIStroke
DLTA["9"] = instance("UIStroke", DLTA["8"]);
DLTA["9"]["Color"] = rgb(255, 255, 255);
DLTA["9"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-One.UICorner
DLTA["a"] = instance("UICorner", DLTA["8"]);
DLTA["a"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Two
DLTA["b"] = instance("TextButton", DLTA["4"]);
DLTA["b"]["TextWrapped"] = true;
DLTA["b"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["b"]["TextSize"] = 21;
DLTA["b"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["b"]["Size"] = u2(0, 25, 0, 25);
DLTA["b"]["Name"] = [[-Two]];
DLTA["b"]["Text"] = [[2]];
DLTA["b"]["Position"] = u2(0, 71, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Two.UIStroke
DLTA["c"] = instance("UIStroke", DLTA["b"]);
DLTA["c"]["Color"] = rgb(255, 255, 255);
DLTA["c"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Two.UICorner
DLTA["d"] = instance("UICorner", DLTA["b"]);
DLTA["d"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Three
DLTA["e"] = instance("TextButton", DLTA["4"]);
DLTA["e"]["TextWrapped"] = true;
DLTA["e"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["e"]["TextSize"] = 21;
DLTA["e"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["e"]["TextColor3"] = rgb(255, 255, 255);
DLTA["e"]["Size"] = u2(0, 25, 0, 25);
DLTA["e"]["Name"] = [[-Three]];
DLTA["e"]["Text"] = [[3]];
DLTA["e"]["Position"] = u2(0, 104, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Three.UIStroke
DLTA["f"] = instance("UIStroke", DLTA["e"]);
DLTA["f"]["Color"] = rgb(255, 255, 255);
DLTA["f"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Three.UICorner
DLTA["10"] = instance("UICorner", DLTA["e"]);
DLTA["10"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Four
DLTA["11"] = instance("TextButton", DLTA["4"]);
DLTA["11"]["TextWrapped"] = true;
DLTA["11"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["11"]["TextSize"] = 21;
DLTA["11"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["11"]["TextColor3"] = rgb(255, 255, 255);
DLTA["11"]["Size"] = u2(0, 25, 0, 25);
DLTA["11"]["Name"] = [[-Four]];
DLTA["11"]["Text"] = [[4]];
DLTA["11"]["Position"] = u2(0, 135, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Four.UIStroke
DLTA["12"] = instance("UIStroke", DLTA["11"]);
DLTA["12"]["Color"] = rgb(255, 255, 255);
DLTA["12"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Four.UICorner
DLTA["13"] = instance("UICorner", DLTA["11"]);
DLTA["13"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Five
DLTA["14"] = instance("TextButton", DLTA["4"]);
DLTA["14"]["TextWrapped"] = true;
DLTA["14"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["14"]["TextSize"] = 21;
DLTA["14"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["14"]["TextColor3"] = rgb(255, 255, 255);
DLTA["14"]["Size"] = u2(0, 25, 0, 25);
DLTA["14"]["Name"] = [[-Five]];
DLTA["14"]["Text"] = [[5]];
DLTA["14"]["Position"] = u2(0, 167, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Five.UIStroke
DLTA["15"] = instance("UIStroke", DLTA["14"]);
DLTA["15"]["Color"] = rgb(255, 255, 255);
DLTA["15"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Five.UICorner
DLTA["16"] = instance("UICorner", DLTA["14"]);
DLTA["16"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Zero
DLTA["17"] = instance("TextButton", DLTA["4"]);
DLTA["17"]["TextWrapped"] = true;
DLTA["17"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["17"]["TextSize"] = 21;
DLTA["17"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["17"]["TextColor3"] = rgb(255, 255, 255);
DLTA["17"]["Size"] = u2(0, 24, 0, 25);
DLTA["17"]["Name"] = [[-Zero]];
DLTA["17"]["Text"] = [[0]];
DLTA["17"]["Position"] = u2(0, 327, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Zero.UIStroke
DLTA["18"] = instance("UIStroke", DLTA["17"]);
DLTA["18"]["Color"] = rgb(255, 255, 255);
DLTA["18"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Zero.UICorner
DLTA["19"] = instance("UICorner", DLTA["17"]);
DLTA["19"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Six
DLTA["1a"] = instance("TextButton", DLTA["4"]);
DLTA["1a"]["TextWrapped"] = true;
DLTA["1a"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["1a"]["TextSize"] = 21;
DLTA["1a"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["1a"]["TextColor3"] = rgb(255, 255, 255);
DLTA["1a"]["Size"] = u2(0, 25, 0, 25);
DLTA["1a"]["Name"] = [[-Six]];
DLTA["1a"]["Text"] = [[6]];
DLTA["1a"]["Position"] = u2(0, 199, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Six.UIStroke
DLTA["1b"] = instance("UIStroke", DLTA["1a"]);
DLTA["1b"]["Color"] = rgb(255, 255, 255);
DLTA["1b"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Six.UICorner
DLTA["1c"] = instance("UICorner", DLTA["1a"]);
DLTA["1c"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Seven
DLTA["1d"] = instance("TextButton", DLTA["4"]);
DLTA["1d"]["TextWrapped"] = true;
DLTA["1d"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["1d"]["TextSize"] = 21;
DLTA["1d"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["1d"]["TextColor3"] = rgb(255, 255, 255);
DLTA["1d"]["Size"] = u2(0, 25, 0, 25);
DLTA["1d"]["Name"] = [[-Seven]];
DLTA["1d"]["Text"] = [[7]];
DLTA["1d"]["Position"] = u2(0, 231, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Seven.UIStroke
DLTA["1e"] = instance("UIStroke", DLTA["1d"]);
DLTA["1e"]["Color"] = rgb(255, 255, 255);
DLTA["1e"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Seven.UICorner
DLTA["1f"] = instance("UICorner", DLTA["1d"]);
DLTA["1f"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Eight
DLTA["20"] = instance("TextButton", DLTA["4"]);
DLTA["20"]["TextWrapped"] = true;
DLTA["20"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["20"]["TextSize"] = 21;
DLTA["20"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["20"]["TextColor3"] = rgb(255, 255, 255);
DLTA["20"]["Size"] = u2(0, 24, 0, 25);
DLTA["20"]["Name"] = [[-Eight]];
DLTA["20"]["Text"] = [[8]];
DLTA["20"]["Position"] = u2(0, 264, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Eight.UIStroke
DLTA["21"] = instance("UIStroke", DLTA["20"]);
DLTA["21"]["Color"] = rgb(255, 255, 255);
DLTA["21"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Eight.UICorner
DLTA["22"] = instance("UICorner", DLTA["20"]);
DLTA["22"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Nine
DLTA["23"] = instance("TextButton", DLTA["4"]);
DLTA["23"]["TextWrapped"] = true;
DLTA["23"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["23"]["TextSize"] = 21;
DLTA["23"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["23"]["TextColor3"] = rgb(255, 255, 255);
DLTA["23"]["Size"] = u2(0, 24, 0, 25);
DLTA["23"]["Name"] = [[-Nine]];
DLTA["23"]["Text"] = [[9]];
DLTA["23"]["Position"] = u2(0, 295, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Nine.UIStroke
DLTA["24"] = instance("UIStroke", DLTA["23"]);
DLTA["24"]["Color"] = rgb(255, 255, 255);
DLTA["24"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Nine.UICorner
DLTA["25"] = instance("UICorner", DLTA["23"]);
DLTA["25"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Minus
DLTA["26"] = instance("TextButton", DLTA["4"]);
DLTA["26"]["TextWrapped"] = true;
DLTA["26"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["26"]["TextSize"] = 21;
DLTA["26"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["26"]["TextColor3"] = rgb(255, 255, 255);
DLTA["26"]["Size"] = u2(0, 24, 0, 25);
DLTA["26"]["Name"] = [[-Minus]];
DLTA["26"]["Text"] = [[-]];
DLTA["26"]["Position"] = u2(0, 358, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Minus.UIStroke
DLTA["27"] = instance("UIStroke", DLTA["26"]);
DLTA["27"]["Color"] = rgb(255, 255, 255);
DLTA["27"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Minus.UICorner
DLTA["28"] = instance("UICorner", DLTA["26"]);
DLTA["28"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Equals
DLTA["29"] = instance("TextButton", DLTA["4"]);
DLTA["29"]["TextWrapped"] = true;
DLTA["29"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["29"]["TextSize"] = 21;
DLTA["29"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["29"]["TextColor3"] = rgb(255, 255, 255);
DLTA["29"]["Size"] = u2(0, 24, 0, 25);
DLTA["29"]["Name"] = [[-Equals]];
DLTA["29"]["Text"] = [[=]];
DLTA["29"]["Position"] = u2(0, 389, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.-Equals.UIStroke
DLTA["2a"] = instance("UIStroke", DLTA["29"]);
DLTA["2a"]["Color"] = rgb(255, 255, 255);
DLTA["2a"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Equals.UICorner
DLTA["2b"] = instance("UICorner", DLTA["29"]);
DLTA["2b"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Backspace
DLTA["2c"] = instance("TextButton", DLTA["4"]);
DLTA["2c"]["TextWrapped"] = true;
DLTA["2c"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["2c"]["TextSize"] = 11;
DLTA["2c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["2c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["2c"]["Size"] = u2(0, 47, 0, 25);
DLTA["2c"]["Name"] = [[Backspace]];
DLTA["2c"]["Text"] = [[Backspace]];
DLTA["2c"]["Position"] = u2(0, 422, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background.Backspace.UIStroke
DLTA["2d"] = instance("UIStroke", DLTA["2c"]);
DLTA["2d"]["Color"] = rgb(255, 255, 255);
DLTA["2d"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Backspace.UICorner
DLTA["2e"] = instance("UICorner", DLTA["2c"]);
DLTA["2e"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Q
DLTA["2f"] = instance("TextButton", DLTA["4"]);
DLTA["2f"]["TextWrapped"] = true;
DLTA["2f"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["2f"]["TextSize"] = 21;
DLTA["2f"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["2f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["2f"]["Size"] = u2(0, 25, 0, 25);
DLTA["2f"]["Name"] = [[Q]];
DLTA["2f"]["Text"] = [[Q]];
DLTA["2f"]["Position"] = u2(0, 54, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.Q.UIStroke
DLTA["30"] = instance("UIStroke", DLTA["2f"]);
DLTA["30"]["Color"] = rgb(255, 255, 255);
DLTA["30"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Q.UICorner
DLTA["31"] = instance("UICorner", DLTA["2f"]);
DLTA["31"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.W
DLTA["32"] = instance("TextButton", DLTA["4"]);
DLTA["32"]["TextWrapped"] = true;
DLTA["32"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["32"]["TextSize"] = 21;
DLTA["32"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["32"]["TextColor3"] = rgb(255, 255, 255);
DLTA["32"]["Size"] = u2(0, 25, 0, 25);
DLTA["32"]["Name"] = [[W]];
DLTA["32"]["Text"] = [[W]];
DLTA["32"]["Position"] = u2(0, 87, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.W.UIStroke
DLTA["33"] = instance("UIStroke", DLTA["32"]);
DLTA["33"]["Color"] = rgb(255, 255, 255);
DLTA["33"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.W.UICorner
DLTA["34"] = instance("UICorner", DLTA["32"]);
DLTA["34"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.O
DLTA["35"] = instance("TextButton", DLTA["4"]);
DLTA["35"]["TextWrapped"] = true;
DLTA["35"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["35"]["TextSize"] = 21;
DLTA["35"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["35"]["TextColor3"] = rgb(255, 255, 255);
DLTA["35"]["Size"] = u2(0, 25, 0, 25);
DLTA["35"]["Name"] = [[O]];
DLTA["35"]["Text"] = [[O]];
DLTA["35"]["Position"] = u2(0, 312, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.O.UIStroke
DLTA["36"] = instance("UIStroke", DLTA["35"]);
DLTA["36"]["Color"] = rgb(255, 255, 255);
DLTA["36"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.O.UICorner
DLTA["37"] = instance("UICorner", DLTA["35"]);
DLTA["37"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.I
DLTA["38"] = instance("TextButton", DLTA["4"]);
DLTA["38"]["TextWrapped"] = true;
DLTA["38"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["38"]["TextSize"] = 21;
DLTA["38"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["38"]["TextColor3"] = rgb(255, 255, 255);
DLTA["38"]["Size"] = u2(0, 25, 0, 25);
DLTA["38"]["Name"] = [[I]];
DLTA["38"]["Text"] = [[I]];
DLTA["38"]["Position"] = u2(0, 280, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.I.UIStroke
DLTA["39"] = instance("UIStroke", DLTA["38"]);
DLTA["39"]["Color"] = rgb(255, 255, 255);
DLTA["39"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.I.UICorner
DLTA["3a"] = instance("UICorner", DLTA["38"]);
DLTA["3a"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.U
DLTA["3b"] = instance("TextButton", DLTA["4"]);
DLTA["3b"]["TextWrapped"] = true;
DLTA["3b"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["3b"]["TextSize"] = 21;
DLTA["3b"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["3b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["3b"]["Size"] = u2(0, 25, 0, 25);
DLTA["3b"]["Name"] = [[U]];
DLTA["3b"]["Text"] = [[U]];
DLTA["3b"]["Position"] = u2(0, 249, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.U.UIStroke
DLTA["3c"] = instance("UIStroke", DLTA["3b"]);
DLTA["3c"]["Color"] = rgb(255, 255, 255);
DLTA["3c"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.U.UICorner
DLTA["3d"] = instance("UICorner", DLTA["3b"]);
DLTA["3d"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Y
DLTA["3e"] = instance("TextButton", DLTA["4"]);
DLTA["3e"]["TextWrapped"] = true;
DLTA["3e"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["3e"]["TextSize"] = 21;
DLTA["3e"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["3e"]["TextColor3"] = rgb(255, 255, 255);
DLTA["3e"]["Size"] = u2(0, 25, 0, 25);
DLTA["3e"]["Name"] = [[Y]];
DLTA["3e"]["Text"] = [[Y]];
DLTA["3e"]["Position"] = u2(0, 216, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.Y.UIStroke
DLTA["3f"] = instance("UIStroke", DLTA["3e"]);
DLTA["3f"]["Color"] = rgb(255, 255, 255);
DLTA["3f"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Y.UICorner
DLTA["40"] = instance("UICorner", DLTA["3e"]);
DLTA["40"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.T
DLTA["41"] = instance("TextButton", DLTA["4"]);
DLTA["41"]["TextWrapped"] = true;
DLTA["41"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["41"]["TextSize"] = 21;
DLTA["41"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["41"]["TextColor3"] = rgb(255, 255, 255);
DLTA["41"]["Size"] = u2(0, 25, 0, 25);
DLTA["41"]["Name"] = [[T]];
DLTA["41"]["Text"] = [[T]];
DLTA["41"]["Position"] = u2(0, 184, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.T.UIStroke
DLTA["42"] = instance("UIStroke", DLTA["41"]);
DLTA["42"]["Color"] = rgb(255, 255, 255);
DLTA["42"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.T.UICorner
DLTA["43"] = instance("UICorner", DLTA["41"]);
DLTA["43"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.R
DLTA["44"] = instance("TextButton", DLTA["4"]);
DLTA["44"]["TextWrapped"] = true;
DLTA["44"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["44"]["TextSize"] = 21;
DLTA["44"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["44"]["TextColor3"] = rgb(255, 255, 255);
DLTA["44"]["Size"] = u2(0, 25, 0, 25);
DLTA["44"]["Name"] = [[R]];
DLTA["44"]["Text"] = [[R]];
DLTA["44"]["Position"] = u2(0, 152, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.R.UIStroke
DLTA["45"] = instance("UIStroke", DLTA["44"]);
DLTA["45"]["Color"] = rgb(255, 255, 255);
DLTA["45"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.R.UICorner
DLTA["46"] = instance("UICorner", DLTA["44"]);
DLTA["46"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.E
DLTA["47"] = instance("TextButton", DLTA["4"]);
DLTA["47"]["TextWrapped"] = true;
DLTA["47"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["47"]["TextSize"] = 21;
DLTA["47"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["47"]["TextColor3"] = rgb(255, 255, 255);
DLTA["47"]["Size"] = u2(0, 25, 0, 25);
DLTA["47"]["Name"] = [[E]];
DLTA["47"]["Text"] = [[E]];
DLTA["47"]["Position"] = u2(0, 120, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.E.UIStroke
DLTA["48"] = instance("UIStroke", DLTA["47"]);
DLTA["48"]["Color"] = rgb(255, 255, 255);
DLTA["48"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.E.UICorner
DLTA["49"] = instance("UICorner", DLTA["47"]);
DLTA["49"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.P
DLTA["4a"] = instance("TextButton", DLTA["4"]);
DLTA["4a"]["TextWrapped"] = true;
DLTA["4a"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["4a"]["TextSize"] = 21;
DLTA["4a"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["4a"]["TextColor3"] = rgb(255, 255, 255);
DLTA["4a"]["Size"] = u2(0, 25, 0, 25);
DLTA["4a"]["Name"] = [[P]];
DLTA["4a"]["Text"] = [[P]];
DLTA["4a"]["Position"] = u2(0, 344, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.P.UIStroke
DLTA["4b"] = instance("UIStroke", DLTA["4a"]);
DLTA["4b"]["Color"] = rgb(255, 255, 255);
DLTA["4b"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.P.UICorner
DLTA["4c"] = instance("UICorner", DLTA["4a"]);
DLTA["4c"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Semicolon
DLTA["4d"] = instance("TextButton", DLTA["4"]);
DLTA["4d"]["TextWrapped"] = true;
DLTA["4d"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["4d"]["TextSize"] = 21;
DLTA["4d"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["4d"]["TextColor3"] = rgb(255, 255, 255);
DLTA["4d"]["Size"] = u2(0, 25, 0, 25);
DLTA["4d"]["Name"] = [[-Semicolon]];
DLTA["4d"]["Text"] = [[;]];
DLTA["4d"]["Position"] = u2(0, 354, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.-Semicolon.UIStroke
DLTA["4e"] = instance("UIStroke", DLTA["4d"]);
DLTA["4e"]["Color"] = rgb(255, 255, 255);
DLTA["4e"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Semicolon.UICorner
DLTA["4f"] = instance("UICorner", DLTA["4d"]);
DLTA["4f"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.A
DLTA["50"] = instance("TextButton", DLTA["4"]);
DLTA["50"]["TextWrapped"] = true;
DLTA["50"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["50"]["TextSize"] = 21;
DLTA["50"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["50"]["TextColor3"] = rgb(255, 255, 255);
DLTA["50"]["Size"] = u2(0, 25, 0, 25);
DLTA["50"]["Name"] = [[A]];
DLTA["50"]["Text"] = [[A]];
DLTA["50"]["Position"] = u2(0, 64, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.A.UIStroke
DLTA["51"] = instance("UIStroke", DLTA["50"]);
DLTA["51"]["Color"] = rgb(255, 255, 255);
DLTA["51"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.A.UICorner
DLTA["52"] = instance("UICorner", DLTA["50"]);
DLTA["52"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.S
DLTA["53"] = instance("TextButton", DLTA["4"]);
DLTA["53"]["TextWrapped"] = true;
DLTA["53"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["53"]["TextSize"] = 21;
DLTA["53"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["53"]["TextColor3"] = rgb(255, 255, 255);
DLTA["53"]["Size"] = u2(0, 25, 0, 25);
DLTA["53"]["Name"] = [[S]];
DLTA["53"]["Text"] = [[S]];
DLTA["53"]["Position"] = u2(0, 97, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.S.UIStroke
DLTA["54"] = instance("UIStroke", DLTA["53"]);
DLTA["54"]["Color"] = rgb(255, 255, 255);
DLTA["54"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.S.UICorner
DLTA["55"] = instance("UICorner", DLTA["53"]);
DLTA["55"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Handler
DLTA["56"] = instance("LocalScript", DLTA["4"]);
DLTA["56"]["Name"] = [[Handler]];

-- StarterGui.DeltaKeyboard.Main.Background.G
DLTA["57"] = instance("TextButton", DLTA["4"]);
DLTA["57"]["TextWrapped"] = true;
DLTA["57"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["57"]["TextSize"] = 21;
DLTA["57"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["57"]["TextColor3"] = rgb(255, 255, 255);
DLTA["57"]["Size"] = u2(0, 25, 0, 25);
DLTA["57"]["Name"] = [[G]];
DLTA["57"]["Text"] = [[G]];
DLTA["57"]["Position"] = u2(0, 194, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.G.UIStroke
DLTA["58"] = instance("UIStroke", DLTA["57"]);
DLTA["58"]["Color"] = rgb(255, 255, 255);
DLTA["58"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.G.UICorner
DLTA["59"] = instance("UICorner", DLTA["57"]);
DLTA["59"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F
DLTA["5a"] = instance("TextButton", DLTA["4"]);
DLTA["5a"]["TextWrapped"] = true;
DLTA["5a"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["5a"]["TextSize"] = 21;
DLTA["5a"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["5a"]["TextColor3"] = rgb(255, 255, 255);
DLTA["5a"]["Size"] = u2(0, 25, 0, 25);
DLTA["5a"]["Name"] = [[F]];
DLTA["5a"]["Text"] = [[F]];
DLTA["5a"]["Position"] = u2(0, 162, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.F.UIStroke
DLTA["5b"] = instance("UIStroke", DLTA["5a"]);
DLTA["5b"]["Color"] = rgb(255, 255, 255);
DLTA["5b"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F.UICorner
DLTA["5c"] = instance("UICorner", DLTA["5a"]);
DLTA["5c"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.H
DLTA["5d"] = instance("TextButton", DLTA["4"]);
DLTA["5d"]["TextWrapped"] = true;
DLTA["5d"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["5d"]["TextSize"] = 21;
DLTA["5d"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["5d"]["TextColor3"] = rgb(255, 255, 255);
DLTA["5d"]["Size"] = u2(0, 25, 0, 25);
DLTA["5d"]["Name"] = [[H]];
DLTA["5d"]["Text"] = [[H]];
DLTA["5d"]["Position"] = u2(0, 226, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.H.UIStroke
DLTA["5e"] = instance("UIStroke", DLTA["5d"]);
DLTA["5e"]["Color"] = rgb(255, 255, 255);
DLTA["5e"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.H.UICorner
DLTA["5f"] = instance("UICorner", DLTA["5d"]);
DLTA["5f"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.J
DLTA["60"] = instance("TextButton", DLTA["4"]);
DLTA["60"]["TextWrapped"] = true;
DLTA["60"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["60"]["TextSize"] = 21;
DLTA["60"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["60"]["TextColor3"] = rgb(255, 255, 255);
DLTA["60"]["Size"] = u2(0, 25, 0, 25);
DLTA["60"]["Name"] = [[J]];
DLTA["60"]["Text"] = [[J]];
DLTA["60"]["Position"] = u2(0, 258, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.J.UIStroke
DLTA["61"] = instance("UIStroke", DLTA["60"]);
DLTA["61"]["Color"] = rgb(255, 255, 255);
DLTA["61"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.J.UICorner
DLTA["62"] = instance("UICorner", DLTA["60"]);
DLTA["62"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.K
DLTA["63"] = instance("TextButton", DLTA["4"]);
DLTA["63"]["TextWrapped"] = true;
DLTA["63"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["63"]["TextSize"] = 21;
DLTA["63"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["63"]["TextColor3"] = rgb(255, 255, 255);
DLTA["63"]["Size"] = u2(0, 25, 0, 25);
DLTA["63"]["Name"] = [[K]];
DLTA["63"]["Text"] = [[K]];
DLTA["63"]["Position"] = u2(0, 290, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.K.UIStroke
DLTA["64"] = instance("UIStroke", DLTA["63"]);
DLTA["64"]["Color"] = rgb(255, 255, 255);
DLTA["64"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.K.UICorner
DLTA["65"] = instance("UICorner", DLTA["63"]);
DLTA["65"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.L
DLTA["66"] = instance("TextButton", DLTA["4"]);
DLTA["66"]["TextWrapped"] = true;
DLTA["66"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["66"]["TextSize"] = 21;
DLTA["66"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["66"]["TextColor3"] = rgb(255, 255, 255);
DLTA["66"]["Size"] = u2(0, 25, 0, 25);
DLTA["66"]["Name"] = [[L]];
DLTA["66"]["Text"] = [[L]];
DLTA["66"]["Position"] = u2(0, 322, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.L.UIStroke
DLTA["67"] = instance("UIStroke", DLTA["66"]);
DLTA["67"]["Color"] = rgb(255, 255, 255);
DLTA["67"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.L.UICorner
DLTA["68"] = instance("UICorner", DLTA["66"]);
DLTA["68"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Z
DLTA["69"] = instance("TextButton", DLTA["4"]);
DLTA["69"]["TextWrapped"] = true;
DLTA["69"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["69"]["TextSize"] = 21;
DLTA["69"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["69"]["TextColor3"] = rgb(255, 255, 255);
DLTA["69"]["Size"] = u2(0, 25, 0, 25);
DLTA["69"]["Name"] = [[Z]];
DLTA["69"]["Text"] = [[Z]];
DLTA["69"]["Position"] = u2(0, 80, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.Z.UIStroke
DLTA["6a"] = instance("UIStroke", DLTA["69"]);
DLTA["6a"]["Color"] = rgb(255, 255, 255);
DLTA["6a"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Z.UICorner
DLTA["6b"] = instance("UICorner", DLTA["69"]);
DLTA["6b"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.X
DLTA["6c"] = instance("TextButton", DLTA["4"]);
DLTA["6c"]["TextWrapped"] = true;
DLTA["6c"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["6c"]["TextSize"] = 21;
DLTA["6c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["6c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["6c"]["Size"] = u2(0, 25, 0, 25);
DLTA["6c"]["Name"] = [[X]];
DLTA["6c"]["Text"] = [[X]];
DLTA["6c"]["Position"] = u2(0, 112, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.X.UIStroke
DLTA["6d"] = instance("UIStroke", DLTA["6c"]);
DLTA["6d"]["Color"] = rgb(255, 255, 255);
DLTA["6d"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.X.UICorner
DLTA["6e"] = instance("UICorner", DLTA["6c"]);
DLTA["6e"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.C
DLTA["6f"] = instance("TextButton", DLTA["4"]);
DLTA["6f"]["TextWrapped"] = true;
DLTA["6f"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["6f"]["TextSize"] = 21;
DLTA["6f"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["6f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["6f"]["Size"] = u2(0, 25, 0, 25);
DLTA["6f"]["Name"] = [[C]];
DLTA["6f"]["Text"] = [[C]];
DLTA["6f"]["Position"] = u2(0, 145, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.C.UIStroke
DLTA["70"] = instance("UIStroke", DLTA["6f"]);
DLTA["70"]["Color"] = rgb(255, 255, 255);
DLTA["70"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.C.UICorner
DLTA["71"] = instance("UICorner", DLTA["6f"]);
DLTA["71"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.V
DLTA["72"] = instance("TextButton", DLTA["4"]);
DLTA["72"]["TextWrapped"] = true;
DLTA["72"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["72"]["TextSize"] = 21;
DLTA["72"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["72"]["TextColor3"] = rgb(255, 255, 255);
DLTA["72"]["Size"] = u2(0, 25, 0, 25);
DLTA["72"]["Name"] = [[V]];
DLTA["72"]["Text"] = [[V]];
DLTA["72"]["Position"] = u2(0, 177, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.V.UIStroke
DLTA["73"] = instance("UIStroke", DLTA["72"]);
DLTA["73"]["Color"] = rgb(255, 255, 255);
DLTA["73"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.V.UICorner
DLTA["74"] = instance("UICorner", DLTA["72"]);
DLTA["74"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.B
DLTA["75"] = instance("TextButton", DLTA["4"]);
DLTA["75"]["TextWrapped"] = true;
DLTA["75"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["75"]["TextSize"] = 21;
DLTA["75"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["75"]["TextColor3"] = rgb(255, 255, 255);
DLTA["75"]["Size"] = u2(0, 25, 0, 25);
DLTA["75"]["Name"] = [[B]];
DLTA["75"]["Text"] = [[B]];
DLTA["75"]["Position"] = u2(0, 209, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.B.UIStroke
DLTA["76"] = instance("UIStroke", DLTA["75"]);
DLTA["76"]["Color"] = rgb(255, 255, 255);
DLTA["76"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.B.UICorner
DLTA["77"] = instance("UICorner", DLTA["75"]);
DLTA["77"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.N
DLTA["78"] = instance("TextButton", DLTA["4"]);
DLTA["78"]["TextWrapped"] = true;
DLTA["78"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["78"]["TextSize"] = 21;
DLTA["78"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["78"]["TextColor3"] = rgb(255, 255, 255);
DLTA["78"]["Size"] = u2(0, 25, 0, 25);
DLTA["78"]["Name"] = [[N]];
DLTA["78"]["Text"] = [[N]];
DLTA["78"]["Position"] = u2(0, 241, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.N.UIStroke
DLTA["79"] = instance("UIStroke", DLTA["78"]);
DLTA["79"]["Color"] = rgb(255, 255, 255);
DLTA["79"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.N.UICorner
DLTA["7a"] = instance("UICorner", DLTA["78"]);
DLTA["7a"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.M
DLTA["7b"] = instance("TextButton", DLTA["4"]);
DLTA["7b"]["TextWrapped"] = true;
DLTA["7b"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["7b"]["TextSize"] = 21;
DLTA["7b"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["7b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["7b"]["Size"] = u2(0, 25, 0, 25);
DLTA["7b"]["Name"] = [[M]];
DLTA["7b"]["Text"] = [[M]];
DLTA["7b"]["Position"] = u2(0, 273, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.M.UIStroke
DLTA["7c"] = instance("UIStroke", DLTA["7b"]);
DLTA["7c"]["Color"] = rgb(255, 255, 255);
DLTA["7c"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.M.UICorner
DLTA["7d"] = instance("UICorner", DLTA["7b"]);
DLTA["7d"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Period
DLTA["7e"] = instance("TextButton", DLTA["4"]);
DLTA["7e"]["TextWrapped"] = true;
DLTA["7e"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["7e"]["TextSize"] = 21;
DLTA["7e"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["7e"]["TextColor3"] = rgb(255, 255, 255);
DLTA["7e"]["Size"] = u2(0, 25, 0, 25);
DLTA["7e"]["Name"] = [[-Period]];
DLTA["7e"]["Text"] = [[.]];
DLTA["7e"]["Position"] = u2(0, 338, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.-Period.UIStroke
DLTA["7f"] = instance("UIStroke", DLTA["7e"]);
DLTA["7f"]["Color"] = rgb(255, 255, 255);
DLTA["7f"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Period.UICorner
DLTA["80"] = instance("UICorner", DLTA["7e"]);
DLTA["80"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Comma
DLTA["81"] = instance("TextButton", DLTA["4"]);
DLTA["81"]["TextWrapped"] = true;
DLTA["81"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["81"]["TextSize"] = 21;
DLTA["81"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["81"]["TextColor3"] = rgb(255, 255, 255);
DLTA["81"]["Size"] = u2(0, 25, 0, 25);
DLTA["81"]["Name"] = [[-Comma]];
DLTA["81"]["Text"] = [[,]];
DLTA["81"]["Position"] = u2(0, 305, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.-Comma.UIStroke
DLTA["82"] = instance("UIStroke", DLTA["81"]);
DLTA["82"]["Color"] = rgb(255, 255, 255);
DLTA["82"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Comma.UICorner
DLTA["83"] = instance("UICorner", DLTA["81"]);
DLTA["83"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.RightShift
DLTA["84"] = instance("TextButton", DLTA["4"]);
DLTA["84"]["TextWrapped"] = true;
DLTA["84"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["84"]["TextSize"] = 21;
DLTA["84"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["84"]["TextColor3"] = rgb(255, 255, 255);
DLTA["84"]["Size"] = u2(0, 64, 0, 25);
DLTA["84"]["Name"] = [[RightShift]];
DLTA["84"]["Text"] = [[Shift]];
DLTA["84"]["Position"] = u2(0, 405, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.RightShift.UIStroke
DLTA["85"] = instance("UIStroke", DLTA["84"]);
DLTA["85"]["Color"] = rgb(255, 255, 255);
DLTA["85"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.RightShift.UICorner
DLTA["86"] = instance("UICorner", DLTA["84"]);
DLTA["86"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Slash
DLTA["87"] = instance("TextButton", DLTA["4"]);
DLTA["87"]["TextWrapped"] = true;
DLTA["87"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["87"]["TextSize"] = 21;
DLTA["87"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["87"]["TextColor3"] = rgb(255, 255, 255);
DLTA["87"]["Size"] = u2(0, 25, 0, 25);
DLTA["87"]["Name"] = [[-Slash]];
DLTA["87"]["Text"] = [[/]];
DLTA["87"]["Position"] = u2(0, 372, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.-Slash.UIStroke
DLTA["88"] = instance("UIStroke", DLTA["87"]);
DLTA["88"]["Color"] = rgb(255, 255, 255);
DLTA["88"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Slash.UICorner
DLTA["89"] = instance("UICorner", DLTA["87"]);
DLTA["89"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Enter
DLTA["8a"] = instance("TextButton", DLTA["4"]);
DLTA["8a"]["TextWrapped"] = true;
DLTA["8a"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["8a"]["TextSize"] = 21;
DLTA["8a"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["8a"]["TextColor3"] = rgb(255, 255, 255);
DLTA["8a"]["Size"] = u2(0, 51, 0, 25);
DLTA["8a"]["Name"] = [[Enter]];
DLTA["8a"]["Text"] = [[Enter]];
DLTA["8a"]["Position"] = u2(0, 418, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.Enter.UIStroke
DLTA["8b"] = instance("UIStroke", DLTA["8a"]);
DLTA["8b"]["Color"] = rgb(255, 255, 255);
DLTA["8b"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Enter.UICorner
DLTA["8c"] = instance("UICorner", DLTA["8a"]);
DLTA["8c"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-Qoute
DLTA["8d"] = instance("TextButton", DLTA["4"]);
DLTA["8d"]["TextWrapped"] = true;
DLTA["8d"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["8d"]["TextSize"] = 21;
DLTA["8d"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["8d"]["TextColor3"] = rgb(255, 255, 255);
DLTA["8d"]["Size"] = u2(0, 25, 0, 25);
DLTA["8d"]["Name"] = [[-Qoute]];
DLTA["8d"]["Text"] = [[']];
DLTA["8d"]["Position"] = u2(0, 386, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.-Qoute.UIStroke
DLTA["8e"] = instance("UIStroke", DLTA["8d"]);
DLTA["8e"]["Color"] = rgb(255, 255, 255);
DLTA["8e"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-Qoute.UICorner
DLTA["8f"] = instance("UICorner", DLTA["8d"]);
DLTA["8f"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-BackSlash
DLTA["90"] = instance("TextButton", DLTA["4"]);
DLTA["90"]["TextWrapped"] = true;
DLTA["90"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["90"]["TextSize"] = 21;
DLTA["90"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["90"]["TextColor3"] = rgb(255, 255, 255);
DLTA["90"]["Size"] = u2(0, 25, 0, 25);
DLTA["90"]["Name"] = [[-BackSlash]];
DLTA["90"]["Text"] = [[\]];
DLTA["90"]["Position"] = u2(0, 442, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.-BackSlash.UIStroke
DLTA["91"] = instance("UIStroke", DLTA["90"]);
DLTA["91"]["Color"] = rgb(255, 255, 255);
DLTA["91"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-BackSlash.UICorner
DLTA["92"] = instance("UICorner", DLTA["90"]);
DLTA["92"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-RightBracket
DLTA["93"] = instance("TextButton", DLTA["4"]);
DLTA["93"]["TextWrapped"] = true;
DLTA["93"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["93"]["TextSize"] = 21;
DLTA["93"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["93"]["TextColor3"] = rgb(255, 255, 255);
DLTA["93"]["Size"] = u2(0, 25, 0, 25);
DLTA["93"]["Name"] = [[-RightBracket]];
DLTA["93"]["Text"] = "]";
DLTA["93"]["Position"] = u2(0, 410, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.-RightBracket.UIStroke
DLTA["94"] = instance("UIStroke", DLTA["93"]);
DLTA["94"]["Color"] = rgb(255, 255, 255);
DLTA["94"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-RightBracket.UICorner
DLTA["95"] = instance("UICorner", DLTA["93"]);
DLTA["95"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.-LeftBracket
DLTA["96"] = instance("TextButton", DLTA["4"]);
DLTA["96"]["TextWrapped"] = true;
DLTA["96"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["96"]["TextSize"] = 21;
DLTA["96"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["96"]["TextColor3"] = rgb(255, 255, 255);
DLTA["96"]["Size"] = u2(0, 25, 0, 25);
DLTA["96"]["Name"] = [[-LeftBracket]];
DLTA["96"]["Text"] = [[[]];
DLTA["96"]["Position"] = u2(0, 378, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.-LeftBracket.UIStroke
DLTA["97"] = instance("UIStroke", DLTA["96"]);
DLTA["97"]["Color"] = rgb(255, 255, 255);
DLTA["97"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.-LeftBracket.UICorner
DLTA["98"] = instance("UICorner", DLTA["96"]);
DLTA["98"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Tab
DLTA["99"] = instance("TextButton", DLTA["4"]);
DLTA["99"]["TextWrapped"] = true;
DLTA["99"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["99"]["TextSize"] = 21;
DLTA["99"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["99"]["TextColor3"] = rgb(255, 255, 255);
DLTA["99"]["Size"] = u2(0, 40, 0, 25);
DLTA["99"]["Name"] = [[Tab]];
DLTA["99"]["Text"] = [[Tab]];
DLTA["99"]["Position"] = u2(0, 7, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background.Tab.UIStroke
DLTA["9a"] = instance("UIStroke", DLTA["99"]);
DLTA["9a"]["Color"] = rgb(255, 255, 255);
DLTA["9a"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Tab.UICorner
DLTA["9b"] = instance("UICorner", DLTA["99"]);
DLTA["9b"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.CapsLock
DLTA["9c"] = instance("TextButton", DLTA["4"]);
DLTA["9c"]["TextWrapped"] = true;
DLTA["9c"]["TextScaled"] = true;
DLTA["9c"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["9c"]["TextSize"] = 1;
DLTA["9c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["9c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["9c"]["Size"] = u2(0, 50, 0, 25);
DLTA["9c"]["Name"] = [[CapsLock]];
DLTA["9c"]["Text"] = [[Caps Lock]];
DLTA["9c"]["Position"] = u2(0, 7, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.CapsLock.UIStroke
DLTA["9d"] = instance("UIStroke", DLTA["9c"]);
DLTA["9d"]["Color"] = rgb(255, 255, 255);
DLTA["9d"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.CapsLock.UICorner
DLTA["9e"] = instance("UICorner", DLTA["9c"]);
DLTA["9e"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.LeftShift
DLTA["9f"] = instance("TextButton", DLTA["4"]);
DLTA["9f"]["TextWrapped"] = true;
DLTA["9f"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["9f"]["TextSize"] = 21;
DLTA["9f"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["9f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["9f"]["Size"] = u2(0, 65, 0, 25);
DLTA["9f"]["Name"] = [[LeftShift]];
DLTA["9f"]["Text"] = [[Shift]];
DLTA["9f"]["Position"] = u2(0, 7, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background.LeftShift.UIStroke
DLTA["a0"] = instance("UIStroke", DLTA["9f"]);
DLTA["a0"]["Color"] = rgb(255, 255, 255);
DLTA["a0"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.LeftShift.UICorner
DLTA["a1"] = instance("UICorner", DLTA["9f"]);
DLTA["a1"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.LeftControl
DLTA["a2"] = instance("TextButton", DLTA["4"]);
DLTA["a2"]["TextWrapped"] = true;
DLTA["a2"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["a2"]["TextSize"] = 23;
DLTA["a2"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["a2"]["TextColor3"] = rgb(255, 255, 255);
DLTA["a2"]["Size"] = u2(0, 57, 0, 25);
DLTA["a2"]["Name"] = [[LeftControl]];
DLTA["a2"]["Text"] = [[Ctrl]];
DLTA["a2"]["Position"] = u2(0, 7, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.LeftControl.UIStroke
DLTA["a3"] = instance("UIStroke", DLTA["a2"]);
DLTA["a3"]["Color"] = rgb(255, 255, 255);
DLTA["a3"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.LeftControl.UICorner
DLTA["a4"] = instance("UICorner", DLTA["a2"]);
DLTA["a4"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F12
DLTA["a5"] = instance("TextButton", DLTA["4"]);
DLTA["a5"]["TextWrapped"] = true;
DLTA["a5"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["a5"]["TextSize"] = 15;
DLTA["a5"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["a5"]["TextColor3"] = rgb(255, 255, 255);
DLTA["a5"]["Size"] = u2(0, 24, 0, 25);
DLTA["a5"]["Name"] = [[F12]];
DLTA["a5"]["Text"] = [[F12]];
DLTA["a5"]["Position"] = u2(0, 389, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F12.UIStroke
DLTA["a6"] = instance("UIStroke", DLTA["a5"]);
DLTA["a6"]["Color"] = rgb(255, 255, 255);
DLTA["a6"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F12.UICorner
DLTA["a7"] = instance("UICorner", DLTA["a5"]);
DLTA["a7"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Delete
DLTA["a8"] = instance("TextButton", DLTA["4"]);
DLTA["a8"]["TextWrapped"] = true;
DLTA["a8"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["a8"]["TextSize"] = 14;
DLTA["a8"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["a8"]["TextColor3"] = rgb(255, 255, 255);
DLTA["a8"]["Size"] = u2(0, 44, 0, 25);
DLTA["a8"]["Name"] = [[Delete]];
DLTA["a8"]["Text"] = [[Del]];
DLTA["a8"]["Position"] = u2(0, 423, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.Delete.UIStroke
DLTA["a9"] = instance("UIStroke", DLTA["a8"]);
DLTA["a9"]["Color"] = rgb(255, 255, 255);
DLTA["a9"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Delete.UICorner
DLTA["aa"] = instance("UICorner", DLTA["a8"]);
DLTA["aa"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.LeftAlt
DLTA["ab"] = instance("TextButton", DLTA["4"]);
DLTA["ab"]["TextWrapped"] = true;
DLTA["ab"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["ab"]["TextSize"] = 21;
DLTA["ab"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["ab"]["TextColor3"] = rgb(255, 255, 255);
DLTA["ab"]["Size"] = u2(0, 56, 0, 25);
DLTA["ab"]["Name"] = [[LeftAlt]];
DLTA["ab"]["Text"] = [[Alt]];
DLTA["ab"]["Position"] = u2(0, 73, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.LeftAlt.UIStroke
DLTA["ac"] = instance("UIStroke", DLTA["ab"]);
DLTA["ac"]["Color"] = rgb(255, 255, 255);
DLTA["ac"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.LeftAlt.UICorner
DLTA["ad"] = instance("UICorner", DLTA["ab"]);
DLTA["ad"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Space
DLTA["ae"] = instance("TextButton", DLTA["4"]);
DLTA["ae"]["TextWrapped"] = true;
DLTA["ae"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["ae"]["TextSize"] = 21;
DLTA["ae"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["ae"]["TextColor3"] = rgb(255, 255, 255);
DLTA["ae"]["Size"] = u2(0, 159, 0, 25);
DLTA["ae"]["Name"] = [[Space]];
DLTA["ae"]["Text"] = [[]];
DLTA["ae"]["Position"] = u2(0, 137, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.Space.UIStroke
DLTA["af"] = instance("UIStroke", DLTA["ae"]);
DLTA["af"]["Color"] = rgb(255, 255, 255);
DLTA["af"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Space.UICorner
DLTA["b0"] = instance("UICorner", DLTA["ae"]);
DLTA["b0"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.RightAlt
DLTA["b1"] = instance("TextButton", DLTA["4"]);
DLTA["b1"]["TextWrapped"] = true;
DLTA["b1"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["b1"]["TextSize"] = 21;
DLTA["b1"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["b1"]["TextColor3"] = rgb(255, 255, 255);
DLTA["b1"]["Size"] = u2(0, 25, 0, 25);
DLTA["b1"]["Name"] = [[RightAlt]];
DLTA["b1"]["Text"] = [[Alt]];
DLTA["b1"]["Position"] = u2(0, 305, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.RightAlt.UIStroke
DLTA["b2"] = instance("UIStroke", DLTA["b1"]);
DLTA["b2"]["Color"] = rgb(255, 255, 255);
DLTA["b2"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.RightAlt.UICorner
DLTA["b3"] = instance("UICorner", DLTA["b1"]);
DLTA["b3"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.RightControl
DLTA["b4"] = instance("TextButton", DLTA["4"]);
DLTA["b4"]["TextWrapped"] = true;
DLTA["b4"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["b4"]["TextSize"] = 12;
DLTA["b4"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["b4"]["TextColor3"] = rgb(255, 255, 255);
DLTA["b4"]["Size"] = u2(0, 25, 0, 25);
DLTA["b4"]["Name"] = [[RightControl]];
DLTA["b4"]["Text"] = [[Ctrl]];
DLTA["b4"]["Position"] = u2(0, 337, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.RightControl.UIStroke
DLTA["b5"] = instance("UIStroke", DLTA["b4"]);
DLTA["b5"]["Color"] = rgb(255, 255, 255);
DLTA["b5"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.RightControl.UICorner
DLTA["b6"] = instance("UICorner", DLTA["b4"]);
DLTA["b6"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.PageUp
DLTA["b7"] = instance("TextButton", DLTA["4"]);
DLTA["b7"]["TextWrapped"] = true;
DLTA["b7"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["b7"]["TextSize"] = 12;
DLTA["b7"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["b7"]["TextColor3"] = rgb(255, 255, 255);
DLTA["b7"]["Size"] = u2(0, 33, 0, 11);
DLTA["b7"]["Name"] = [[PageUp]];
DLTA["b7"]["Text"] = [[Up]];
DLTA["b7"]["Position"] = u2(0, 400, 0, 160);

-- StarterGui.DeltaKeyboard.Main.Background.PageUp.UIStroke
DLTA["b8"] = instance("UIStroke", DLTA["b7"]);
DLTA["b8"]["Color"] = rgb(255, 255, 255);
DLTA["b8"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.PageUp.UICorner
DLTA["b9"] = instance("UICorner", DLTA["b7"]);
DLTA["b9"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.PageDown
DLTA["ba"] = instance("TextButton", DLTA["4"]);
DLTA["ba"]["TextWrapped"] = true;
DLTA["ba"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["ba"]["TextSize"] = 12;
DLTA["ba"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["ba"]["TextColor3"] = rgb(255, 255, 255);
DLTA["ba"]["Size"] = u2(0, 33, 0, 10);
DLTA["ba"]["Name"] = [[PageDown]];
DLTA["ba"]["Text"] = [[Down]];
DLTA["ba"]["Position"] = u2(0, 400, 0, 174);

-- StarterGui.DeltaKeyboard.Main.Background.PageDown.UIStroke
DLTA["bb"] = instance("UIStroke", DLTA["ba"]);
DLTA["bb"]["Color"] = rgb(255, 255, 255);
DLTA["bb"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.PageDown.UICorner
DLTA["bc"] = instance("UICorner", DLTA["ba"]);
DLTA["bc"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.End
DLTA["bd"] = instance("TextButton", DLTA["4"]);
DLTA["bd"]["TextWrapped"] = true;
DLTA["bd"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["bd"]["TextSize"] = 12;
DLTA["bd"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["bd"]["TextColor3"] = rgb(255, 255, 255);
DLTA["bd"]["Size"] = u2(0, 33, 0, 10);
DLTA["bd"]["Name"] = [[End]];
DLTA["bd"]["Text"] = [[>]];
DLTA["bd"]["Position"] = u2(0, 436, 0, 174);

-- StarterGui.DeltaKeyboard.Main.Background.End.UIStroke
DLTA["be"] = instance("UIStroke", DLTA["bd"]);
DLTA["be"]["Color"] = rgb(255, 255, 255);
DLTA["be"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.End.UICorner
DLTA["bf"] = instance("UICorner", DLTA["bd"]);
DLTA["bf"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Home
DLTA["c0"] = instance("TextButton", DLTA["4"]);
DLTA["c0"]["TextWrapped"] = true;
DLTA["c0"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["c0"]["TextSize"] = 12;
DLTA["c0"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["c0"]["TextColor3"] = rgb(255, 255, 255);
DLTA["c0"]["Size"] = u2(0, 30, 0, 10);
DLTA["c0"]["Name"] = [[Home]];
DLTA["c0"]["Text"] = [[<]];
DLTA["c0"]["Position"] = u2(0, 366, 0, 174);

-- StarterGui.DeltaKeyboard.Main.Background.Home.UIStroke
DLTA["c1"] = instance("UIStroke", DLTA["c0"]);
DLTA["c1"]["Color"] = rgb(255, 255, 255);
DLTA["c1"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Home.UICorner
DLTA["c2"] = instance("UICorner", DLTA["c0"]);
DLTA["c2"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.Escape
DLTA["c3"] = instance("TextButton", DLTA["4"]);
DLTA["c3"]["TextWrapped"] = true;
DLTA["c3"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["c3"]["TextSize"] = 12;
DLTA["c3"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["c3"]["TextColor3"] = rgb(255, 255, 255);
DLTA["c3"]["Size"] = u2(0, 25, 0, 25);
DLTA["c3"]["Name"] = [[Escape]];
DLTA["c3"]["Text"] = [[Esc]];
DLTA["c3"]["Position"] = u2(0, 7, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.Escape.UIStroke
DLTA["c4"] = instance("UIStroke", DLTA["c3"]);
DLTA["c4"]["Color"] = rgb(255, 255, 255);
DLTA["c4"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.Escape.UICorner
DLTA["c5"] = instance("UICorner", DLTA["c3"]);
DLTA["c5"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F1
DLTA["c6"] = instance("TextButton", DLTA["4"]);
DLTA["c6"]["TextWrapped"] = true;
DLTA["c6"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["c6"]["TextSize"] = 21;
DLTA["c6"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["c6"]["TextColor3"] = rgb(255, 255, 255);
DLTA["c6"]["Size"] = u2(0, 25, 0, 25);
DLTA["c6"]["Name"] = [[F1]];
DLTA["c6"]["Text"] = [[F1]];
DLTA["c6"]["Position"] = u2(0, 39, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F1.UIStroke
DLTA["c7"] = instance("UIStroke", DLTA["c6"]);
DLTA["c7"]["Color"] = rgb(255, 255, 255);
DLTA["c7"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F1.UICorner
DLTA["c8"] = instance("UICorner", DLTA["c6"]);
DLTA["c8"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F2
DLTA["c9"] = instance("TextButton", DLTA["4"]);
DLTA["c9"]["TextWrapped"] = true;
DLTA["c9"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["c9"]["TextSize"] = 21;
DLTA["c9"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["c9"]["TextColor3"] = rgb(255, 255, 255);
DLTA["c9"]["Size"] = u2(0, 25, 0, 25);
DLTA["c9"]["Name"] = [[F2]];
DLTA["c9"]["Text"] = [[F2]];
DLTA["c9"]["Position"] = u2(0, 71, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F2.UIStroke
DLTA["ca"] = instance("UIStroke", DLTA["c9"]);
DLTA["ca"]["Color"] = rgb(255, 255, 255);
DLTA["ca"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F2.UICorner
DLTA["cb"] = instance("UICorner", DLTA["c9"]);
DLTA["cb"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F3
DLTA["cc"] = instance("TextButton", DLTA["4"]);
DLTA["cc"]["TextWrapped"] = true;
DLTA["cc"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["cc"]["TextSize"] = 21;
DLTA["cc"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["cc"]["TextColor3"] = rgb(255, 255, 255);
DLTA["cc"]["Size"] = u2(0, 25, 0, 25);
DLTA["cc"]["Name"] = [[F3]];
DLTA["cc"]["Text"] = [[F3]];
DLTA["cc"]["Position"] = u2(0, 104, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F3.UIStroke
DLTA["cd"] = instance("UIStroke", DLTA["cc"]);
DLTA["cd"]["Color"] = rgb(255, 255, 255);
DLTA["cd"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F3.UICorner
DLTA["ce"] = instance("UICorner", DLTA["cc"]);
DLTA["ce"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F4
DLTA["cf"] = instance("TextButton", DLTA["4"]);
DLTA["cf"]["TextWrapped"] = true;
DLTA["cf"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["cf"]["TextSize"] = 21;
DLTA["cf"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["cf"]["TextColor3"] = rgb(255, 255, 255);
DLTA["cf"]["Size"] = u2(0, 25, 0, 25);
DLTA["cf"]["Name"] = [[F4]];
DLTA["cf"]["Text"] = [[F4]];
DLTA["cf"]["Position"] = u2(0, 135, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F4.UIStroke
DLTA["d0"] = instance("UIStroke", DLTA["cf"]);
DLTA["d0"]["Color"] = rgb(255, 255, 255);
DLTA["d0"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F4.UICorner
DLTA["d1"] = instance("UICorner", DLTA["cf"]);
DLTA["d1"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F5
DLTA["d2"] = instance("TextButton", DLTA["4"]);
DLTA["d2"]["TextWrapped"] = true;
DLTA["d2"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["d2"]["TextSize"] = 21;
DLTA["d2"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["d2"]["TextColor3"] = rgb(255, 255, 255);
DLTA["d2"]["Size"] = u2(0, 25, 0, 25);
DLTA["d2"]["Name"] = [[F5]];
DLTA["d2"]["Text"] = [[F5]];
DLTA["d2"]["Position"] = u2(0, 167, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F5.UIStroke
DLTA["d3"] = instance("UIStroke", DLTA["d2"]);
DLTA["d3"]["Color"] = rgb(255, 255, 255);
DLTA["d3"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F5.UICorner
DLTA["d4"] = instance("UICorner", DLTA["d2"]);
DLTA["d4"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F6
DLTA["d5"] = instance("TextButton", DLTA["4"]);
DLTA["d5"]["TextWrapped"] = true;
DLTA["d5"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["d5"]["TextSize"] = 21;
DLTA["d5"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["d5"]["TextColor3"] = rgb(255, 255, 255);
DLTA["d5"]["Size"] = u2(0, 25, 0, 25);
DLTA["d5"]["Name"] = [[F6]];
DLTA["d5"]["Text"] = [[F6]];
DLTA["d5"]["Position"] = u2(0, 199, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F6.UIStroke
DLTA["d6"] = instance("UIStroke", DLTA["d5"]);
DLTA["d6"]["Color"] = rgb(255, 255, 255);
DLTA["d6"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F6.UICorner
DLTA["d7"] = instance("UICorner", DLTA["d5"]);
DLTA["d7"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F7
DLTA["d8"] = instance("TextButton", DLTA["4"]);
DLTA["d8"]["TextWrapped"] = true;
DLTA["d8"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["d8"]["TextSize"] = 21;
DLTA["d8"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["d8"]["TextColor3"] = rgb(255, 255, 255);
DLTA["d8"]["Size"] = u2(0, 25, 0, 25);
DLTA["d8"]["Name"] = [[F7]];
DLTA["d8"]["Text"] = [[F7]];
DLTA["d8"]["Position"] = u2(0, 231, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F7.UIStroke
DLTA["d9"] = instance("UIStroke", DLTA["d8"]);
DLTA["d9"]["Color"] = rgb(255, 255, 255);
DLTA["d9"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F7.UICorner
DLTA["da"] = instance("UICorner", DLTA["d8"]);
DLTA["da"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F8
DLTA["db"] = instance("TextButton", DLTA["4"]);
DLTA["db"]["TextWrapped"] = true;
DLTA["db"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["db"]["TextSize"] = 21;
DLTA["db"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["db"]["TextColor3"] = rgb(255, 255, 255);
DLTA["db"]["Size"] = u2(0, 24, 0, 25);
DLTA["db"]["Name"] = [[F8]];
DLTA["db"]["Text"] = [[F8]];
DLTA["db"]["Position"] = u2(0, 264, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F8.UIStroke
DLTA["dc"] = instance("UIStroke", DLTA["db"]);
DLTA["dc"]["Color"] = rgb(255, 255, 255);
DLTA["dc"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F8.UICorner
DLTA["dd"] = instance("UICorner", DLTA["db"]);
DLTA["dd"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F9
DLTA["de"] = instance("TextButton", DLTA["4"]);
DLTA["de"]["TextWrapped"] = true;
DLTA["de"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["de"]["TextSize"] = 21;
DLTA["de"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["de"]["TextColor3"] = rgb(255, 255, 255);
DLTA["de"]["Size"] = u2(0, 25, 0, 25);
DLTA["de"]["Name"] = [[F9]];
DLTA["de"]["Text"] = [[F9]];
DLTA["de"]["Position"] = u2(0, 295, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F9.UIStroke
DLTA["df"] = instance("UIStroke", DLTA["de"]);
DLTA["df"]["Color"] = rgb(255, 255, 255);
DLTA["df"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F9.UICorner
DLTA["e0"] = instance("UICorner", DLTA["de"]);
DLTA["e0"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F10
DLTA["e1"] = instance("TextButton", DLTA["4"]);
DLTA["e1"]["TextWrapped"] = true;
DLTA["e1"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["e1"]["TextSize"] = 15;
DLTA["e1"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["e1"]["TextColor3"] = rgb(255, 255, 255);
DLTA["e1"]["Size"] = u2(0, 24, 0, 25);
DLTA["e1"]["Name"] = [[F10]];
DLTA["e1"]["Text"] = [[F10]];
DLTA["e1"]["Position"] = u2(0, 327, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F10.UIStroke
DLTA["e2"] = instance("UIStroke", DLTA["e1"]);
DLTA["e2"]["Color"] = rgb(255, 255, 255);
DLTA["e2"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F10.UICorner
DLTA["e3"] = instance("UICorner", DLTA["e1"]);
DLTA["e3"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.F11
DLTA["e4"] = instance("TextButton", DLTA["4"]);
DLTA["e4"]["TextWrapped"] = true;
DLTA["e4"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["e4"]["TextSize"] = 15;
DLTA["e4"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["e4"]["TextColor3"] = rgb(255, 255, 255);
DLTA["e4"]["Size"] = u2(0, 24, 0, 25);
DLTA["e4"]["Name"] = [[F11]];
DLTA["e4"]["Text"] = [[F11]];
DLTA["e4"]["Position"] = u2(0, 358, 0, -1);

-- StarterGui.DeltaKeyboard.Main.Background.F11.UIStroke
DLTA["e5"] = instance("UIStroke", DLTA["e4"]);
DLTA["e5"]["Color"] = rgb(255, 255, 255);
DLTA["e5"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.F11.UICorner
DLTA["e6"] = instance("UICorner", DLTA["e4"]);
DLTA["e6"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.RGBHandler
DLTA["e7"] = instance("LocalScript", DLTA["4"]);
DLTA["e7"]["Name"] = [[RGBHandler]];

-- StarterGui.DeltaKeyboard.Main.Background._Pipe
DLTA["e8"] = instance("TextButton", DLTA["4"]);
DLTA["e8"]["TextWrapped"] = true;
DLTA["e8"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["e8"]["TextSize"] = 21;
DLTA["e8"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["e8"]["TextColor3"] = rgb(255, 255, 255);
DLTA["e8"]["Visible"] = false;
DLTA["e8"]["Size"] = u2(0, 25, 0, 25);
DLTA["e8"]["Name"] = [[_Pipe]];
DLTA["e8"]["Text"] = [[|]];
DLTA["e8"]["Position"] = u2(0, 442, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background._Pipe.UIStroke
DLTA["e9"] = instance("UIStroke", DLTA["e8"]);
DLTA["e9"]["Color"] = rgb(255, 255, 255);
DLTA["e9"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Pipe.UICorner
DLTA["ea"] = instance("UICorner", DLTA["e8"]);
DLTA["ea"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Tilde
DLTA["eb"] = instance("TextButton", DLTA["4"]);
DLTA["eb"]["TextWrapped"] = true;
DLTA["eb"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["eb"]["TextSize"] = 21;
DLTA["eb"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["eb"]["TextColor3"] = rgb(255, 255, 255);
DLTA["eb"]["Visible"] = false;
DLTA["eb"]["Size"] = u2(0, 25, 0, 25);
DLTA["eb"]["Name"] = [[_Tilde]];
DLTA["eb"]["Text"] = [[~]];
DLTA["eb"]["Position"] = u2(0, 7, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Tilde.UIStroke
DLTA["ec"] = instance("UIStroke", DLTA["eb"]);
DLTA["ec"]["Color"] = rgb(255, 255, 255);
DLTA["ec"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Tilde.UICorner
DLTA["ed"] = instance("UICorner", DLTA["eb"]);
DLTA["ed"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Exclamation
DLTA["ee"] = instance("TextButton", DLTA["4"]);
DLTA["ee"]["TextWrapped"] = true;
DLTA["ee"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["ee"]["TextSize"] = 21;
DLTA["ee"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["ee"]["TextColor3"] = rgb(255, 255, 255);
DLTA["ee"]["Visible"] = false;
DLTA["ee"]["Size"] = u2(0, 25, 0, 25);
DLTA["ee"]["Name"] = [[_Exclamation]];
DLTA["ee"]["Text"] = [[!]];
DLTA["ee"]["Position"] = u2(0, 39, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Exclamation.UIStroke
DLTA["ef"] = instance("UIStroke", DLTA["ee"]);
DLTA["ef"]["Color"] = rgb(255, 255, 255);
DLTA["ef"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Exclamation.UICorner
DLTA["f0"] = instance("UICorner", DLTA["ee"]);
DLTA["f0"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._At
DLTA["f1"] = instance("TextButton", DLTA["4"]);
DLTA["f1"]["TextWrapped"] = true;
DLTA["f1"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["f1"]["TextSize"] = 21;
DLTA["f1"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["f1"]["TextColor3"] = rgb(255, 255, 255);
DLTA["f1"]["Visible"] = false;
DLTA["f1"]["Size"] = u2(0, 25, 0, 25);
DLTA["f1"]["Name"] = [[_At]];
DLTA["f1"]["Text"] = [[@]];
DLTA["f1"]["Position"] = u2(0, 71, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._At.UIStroke
DLTA["f2"] = instance("UIStroke", DLTA["f1"]);
DLTA["f2"]["Color"] = rgb(255, 255, 255);
DLTA["f2"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._At.UICorner
DLTA["f3"] = instance("UICorner", DLTA["f1"]);
DLTA["f3"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Hash
DLTA["f4"] = instance("TextButton", DLTA["4"]);
DLTA["f4"]["TextWrapped"] = true;
DLTA["f4"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["f4"]["TextSize"] = 21;
DLTA["f4"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["f4"]["TextColor3"] = rgb(255, 255, 255);
DLTA["f4"]["Visible"] = false;
DLTA["f4"]["Size"] = u2(0, 25, 0, 25);
DLTA["f4"]["Name"] = [[_Hash]];
DLTA["f4"]["Text"] = [[#]];
DLTA["f4"]["Position"] = u2(0, 104, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Hash.UIStroke
DLTA["f5"] = instance("UIStroke", DLTA["f4"]);
DLTA["f5"]["Color"] = rgb(255, 255, 255);
DLTA["f5"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Hash.UICorner
DLTA["f6"] = instance("UICorner", DLTA["f4"]);
DLTA["f6"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Dollar
DLTA["f7"] = instance("TextButton", DLTA["4"]);
DLTA["f7"]["TextWrapped"] = true;
DLTA["f7"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["f7"]["TextSize"] = 21;
DLTA["f7"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["f7"]["TextColor3"] = rgb(255, 255, 255);
DLTA["f7"]["Visible"] = false;
DLTA["f7"]["Size"] = u2(0, 25, 0, 25);
DLTA["f7"]["Name"] = [[_Dollar]];
DLTA["f7"]["Text"] = [[$]];
DLTA["f7"]["Position"] = u2(0, 135, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Dollar.UIStroke
DLTA["f8"] = instance("UIStroke", DLTA["f7"]);
DLTA["f8"]["Color"] = rgb(255, 255, 255);
DLTA["f8"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Dollar.UICorner
DLTA["f9"] = instance("UICorner", DLTA["f7"]);
DLTA["f9"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Percent
DLTA["fa"] = instance("TextButton", DLTA["4"]);
DLTA["fa"]["TextWrapped"] = true;
DLTA["fa"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["fa"]["TextSize"] = 21;
DLTA["fa"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["fa"]["TextColor3"] = rgb(255, 255, 255);
DLTA["fa"]["Visible"] = false;
DLTA["fa"]["Size"] = u2(0, 25, 0, 25);
DLTA["fa"]["Name"] = [[_Percent]];
DLTA["fa"]["Text"] = [[%]];
DLTA["fa"]["Position"] = u2(0, 167, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Percent.UIStroke
DLTA["fb"] = instance("UIStroke", DLTA["fa"]);
DLTA["fb"]["Color"] = rgb(255, 255, 255);
DLTA["fb"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Percent.UICorner
DLTA["fc"] = instance("UICorner", DLTA["fa"]);
DLTA["fc"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Caret
DLTA["fd"] = instance("TextButton", DLTA["4"]);
DLTA["fd"]["TextWrapped"] = true;
DLTA["fd"]["TextStrokeTransparency"] = 0;
DLTA["fd"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["fd"]["TextSize"] = 21;
DLTA["fd"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["fd"]["TextColor3"] = rgb(255, 255, 255);
DLTA["fd"]["Visible"] = false;
DLTA["fd"]["Size"] = u2(0, 25, 0, 25);
DLTA["fd"]["Name"] = [[_Caret]];
DLTA["fd"]["Text"] = [[^]];
DLTA["fd"]["Position"] = u2(0, 199, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Caret.UIStroke
DLTA["fe"] = instance("UIStroke", DLTA["fd"]);
DLTA["fe"]["Color"] = rgb(255, 255, 255);
DLTA["fe"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Caret.UICorner
DLTA["ff"] = instance("UICorner", DLTA["fd"]);
DLTA["ff"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Ampersand
DLTA["100"] = instance("TextButton", DLTA["4"]);
DLTA["100"]["TextWrapped"] = true;
DLTA["100"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["100"]["TextSize"] = 21;
DLTA["100"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["100"]["TextColor3"] = rgb(255, 255, 255);
DLTA["100"]["Visible"] = false;
DLTA["100"]["Size"] = u2(0, 25, 0, 25);
DLTA["100"]["Name"] = [[_Ampersand]];
DLTA["100"]["Text"] = [[&]];
DLTA["100"]["Position"] = u2(0, 231, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Ampersand.UIStroke
DLTA["101"] = instance("UIStroke", DLTA["100"]);
DLTA["101"]["Color"] = rgb(255, 255, 255);
DLTA["101"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Ampersand.UICorner
DLTA["102"] = instance("UICorner", DLTA["100"]);
DLTA["102"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Asterisk
DLTA["103"] = instance("TextButton", DLTA["4"]);
DLTA["103"]["TextWrapped"] = true;
DLTA["103"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["103"]["TextSize"] = 21;
DLTA["103"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["103"]["TextColor3"] = rgb(255, 255, 255);
DLTA["103"]["Visible"] = false;
DLTA["103"]["Size"] = u2(0, 24, 0, 25);
DLTA["103"]["Name"] = [[_Asterisk]];
DLTA["103"]["Text"] = [[*]];
DLTA["103"]["Position"] = u2(0, 264, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Asterisk.UIStroke
DLTA["104"] = instance("UIStroke", DLTA["103"]);
DLTA["104"]["Color"] = rgb(255, 255, 255);
DLTA["104"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Asterisk.UICorner
DLTA["105"] = instance("UICorner", DLTA["103"]);
DLTA["105"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._LeftParenthesis
DLTA["106"] = instance("TextButton", DLTA["4"]);
DLTA["106"]["TextWrapped"] = true;
DLTA["106"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["106"]["TextSize"] = 21;
DLTA["106"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["106"]["TextColor3"] = rgb(255, 255, 255);
DLTA["106"]["Visible"] = false;
DLTA["106"]["Size"] = u2(0, 24, 0, 25);
DLTA["106"]["Name"] = [[_LeftParenthesis]];
DLTA["106"]["Text"] = [[(]];
DLTA["106"]["Position"] = u2(0, 295, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._LeftParenthesis.UIStroke
DLTA["107"] = instance("UIStroke", DLTA["106"]);
DLTA["107"]["Color"] = rgb(255, 255, 255);
DLTA["107"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._LeftParenthesis.UICorner
DLTA["108"] = instance("UICorner", DLTA["106"]);
DLTA["108"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._RightParenthesis
DLTA["109"] = instance("TextButton", DLTA["4"]);
DLTA["109"]["TextWrapped"] = true;
DLTA["109"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["109"]["TextSize"] = 21;
DLTA["109"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["109"]["TextColor3"] = rgb(255, 255, 255);
DLTA["109"]["Visible"] = false;
DLTA["109"]["Size"] = u2(0, 24, 0, 25);
DLTA["109"]["Name"] = [[_RightParenthesis]];
DLTA["109"]["Text"] = [[)]];
DLTA["109"]["Position"] = u2(0, 327, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._RightParenthesis.UIStroke
DLTA["10a"] = instance("UIStroke", DLTA["109"]);
DLTA["10a"]["Color"] = rgb(255, 255, 255);
DLTA["10a"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._RightParenthesis.UICorner
DLTA["10b"] = instance("UICorner", DLTA["109"]);
DLTA["10b"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Underscore
DLTA["10c"] = instance("TextButton", DLTA["4"]);
DLTA["10c"]["TextWrapped"] = true;
DLTA["10c"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["10c"]["TextSize"] = 21;
DLTA["10c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["10c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["10c"]["Visible"] = false;
DLTA["10c"]["Size"] = u2(0, 24, 0, 25);
DLTA["10c"]["Name"] = [[_Underscore]];
DLTA["10c"]["Text"] = [[_]];
DLTA["10c"]["Position"] = u2(0, 358, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Underscore.UIStroke
DLTA["10d"] = instance("UIStroke", DLTA["10c"]);
DLTA["10d"]["Color"] = rgb(255, 255, 255);
DLTA["10d"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Underscore.UICorner
DLTA["10e"] = instance("UICorner", DLTA["10c"]);
DLTA["10e"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Plus
DLTA["10f"] = instance("TextButton", DLTA["4"]);
DLTA["10f"]["TextWrapped"] = true;
DLTA["10f"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["10f"]["TextSize"] = 21;
DLTA["10f"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["10f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["10f"]["Visible"] = false;
DLTA["10f"]["Size"] = u2(0, 24, 0, 25);
DLTA["10f"]["Name"] = [[_Plus]];
DLTA["10f"]["Text"] = [[+]];
DLTA["10f"]["Position"] = u2(0, 389, 0, 31);

-- StarterGui.DeltaKeyboard.Main.Background._Plus.UIStroke
DLTA["110"] = instance("UIStroke", DLTA["10f"]);
DLTA["110"]["Color"] = rgb(255, 255, 255);
DLTA["110"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Plus.UICorner
DLTA["111"] = instance("UICorner", DLTA["10f"]);
DLTA["111"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._RightCurly
DLTA["112"] = instance("TextButton", DLTA["4"]);
DLTA["112"]["TextWrapped"] = true;
DLTA["112"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["112"]["TextSize"] = 21;
DLTA["112"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["112"]["TextColor3"] = rgb(255, 255, 255);
DLTA["112"]["Visible"] = false;
DLTA["112"]["Size"] = u2(0, 25, 0, 25);
DLTA["112"]["Name"] = [[_RightCurly]];
DLTA["112"]["Text"] = [[}]];
DLTA["112"]["Position"] = u2(0, 410, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background._RightCurly.UIStroke
DLTA["113"] = instance("UIStroke", DLTA["112"]);
DLTA["113"]["Color"] = rgb(255, 255, 255);
DLTA["113"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._RightCurly.UICorner
DLTA["114"] = instance("UICorner", DLTA["112"]);
DLTA["114"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._LeftCurly
DLTA["115"] = instance("TextButton", DLTA["4"]);
DLTA["115"]["TextWrapped"] = true;
DLTA["115"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["115"]["TextSize"] = 21;
DLTA["115"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["115"]["TextColor3"] = rgb(255, 255, 255);
DLTA["115"]["Visible"] = false;
DLTA["115"]["Size"] = u2(0, 25, 0, 25);
DLTA["115"]["Name"] = [[_LeftCurly]];
DLTA["115"]["Text"] = [[{]];
DLTA["115"]["Position"] = u2(0, 378, 0, 63);

-- StarterGui.DeltaKeyboard.Main.Background._LeftCurly.UIStroke
DLTA["116"] = instance("UIStroke", DLTA["115"]);
DLTA["116"]["Color"] = rgb(255, 255, 255);
DLTA["116"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._LeftCurly.UICorner
DLTA["117"] = instance("UICorner", DLTA["115"]);
DLTA["117"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._QuotedDouble
DLTA["118"] = instance("TextButton", DLTA["4"]);
DLTA["118"]["TextWrapped"] = true;
DLTA["118"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["118"]["TextSize"] = 21;
DLTA["118"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["118"]["TextColor3"] = rgb(255, 255, 255);
DLTA["118"]["Visible"] = false;
DLTA["118"]["Size"] = u2(0, 25, 0, 25);
DLTA["118"]["Name"] = [[_QuotedDouble]];
DLTA["118"]["Text"] = [["]];
DLTA["118"]["Position"] = u2(0, 386, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background._QuotedDouble.UIStroke
DLTA["119"] = instance("UIStroke", DLTA["118"]);
DLTA["119"]["Color"] = rgb(255, 255, 255);
DLTA["119"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._QuotedDouble.UICorner
DLTA["11a"] = instance("UICorner", DLTA["118"]);
DLTA["11a"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Colon
DLTA["11b"] = instance("TextButton", DLTA["4"]);
DLTA["11b"]["TextWrapped"] = true;
DLTA["11b"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["11b"]["TextSize"] = 21;
DLTA["11b"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["11b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["11b"]["Visible"] = false;
DLTA["11b"]["Size"] = u2(0, 25, 0, 25);
DLTA["11b"]["Name"] = [[_Colon]];
DLTA["11b"]["Text"] = [[:]];
DLTA["11b"]["Position"] = u2(0, 354, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background._Colon.UIStroke
DLTA["11c"] = instance("UIStroke", DLTA["11b"]);
DLTA["11c"]["Color"] = rgb(255, 255, 255);
DLTA["11c"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Colon.UICorner
DLTA["11d"] = instance("UICorner", DLTA["11b"]);
DLTA["11d"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._Question
DLTA["11e"] = instance("TextButton", DLTA["4"]);
DLTA["11e"]["TextWrapped"] = true;
DLTA["11e"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["11e"]["TextSize"] = 21;
DLTA["11e"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["11e"]["TextColor3"] = rgb(255, 255, 255);
DLTA["11e"]["Visible"] = false;
DLTA["11e"]["Size"] = u2(0, 25, 0, 25);
DLTA["11e"]["Name"] = [[_Question]];
DLTA["11e"]["Text"] = [[?]];
DLTA["11e"]["Position"] = u2(0, 372, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background._Question.UIStroke
DLTA["11f"] = instance("UIStroke", DLTA["11e"]);
DLTA["11f"]["Color"] = rgb(255, 255, 255);
DLTA["11f"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._Question.UICorner
DLTA["120"] = instance("UICorner", DLTA["11e"]);
DLTA["120"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._GreaterThan
DLTA["121"] = instance("TextButton", DLTA["4"]);
DLTA["121"]["TextWrapped"] = true;
DLTA["121"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["121"]["TextSize"] = 21;
DLTA["121"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["121"]["TextColor3"] = rgb(255, 255, 255);
DLTA["121"]["Visible"] = false;
DLTA["121"]["Size"] = u2(0, 25, 0, 25);
DLTA["121"]["Name"] = [[_GreaterThan]];
DLTA["121"]["Text"] = [[>]];
DLTA["121"]["Position"] = u2(0, 338, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background._GreaterThan.UIStroke
DLTA["122"] = instance("UIStroke", DLTA["121"]);
DLTA["122"]["Color"] = rgb(255, 255, 255);
DLTA["122"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._GreaterThan.UICorner
DLTA["123"] = instance("UICorner", DLTA["121"]);
DLTA["123"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background._LessThan
DLTA["124"] = instance("TextButton", DLTA["4"]);
DLTA["124"]["TextWrapped"] = true;
DLTA["124"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["124"]["TextSize"] = 21;
DLTA["124"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["124"]["TextColor3"] = rgb(255, 255, 255);
DLTA["124"]["Visible"] = false;
DLTA["124"]["Size"] = u2(0, 25, 0, 25);
DLTA["124"]["Name"] = [[_LessThan]];
DLTA["124"]["Text"] = [[<]];
DLTA["124"]["Position"] = u2(0, 305, 0, 127);

-- StarterGui.DeltaKeyboard.Main.Background._LessThan.UIStroke
DLTA["125"] = instance("UIStroke", DLTA["124"]);
DLTA["125"]["Color"] = rgb(255, 255, 255);
DLTA["125"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background._LessThan.UICorner
DLTA["126"] = instance("UICorner", DLTA["124"]);
DLTA["126"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.UICorner
DLTA["127"] = instance("UICorner", DLTA["4"]);
DLTA["127"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.Background.D
DLTA["128"] = instance("TextButton", DLTA["4"]);
DLTA["128"]["TextWrapped"] = true;
DLTA["128"]["BackgroundColor3"] = rgb(8, 8, 8);
DLTA["128"]["TextSize"] = 21;
DLTA["128"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["128"]["TextColor3"] = rgb(255, 255, 255);
DLTA["128"]["Size"] = u2(0, 25, 0, 25);
DLTA["128"]["Name"] = [[D]];
DLTA["128"]["Text"] = [[D]];
DLTA["128"]["Position"] = u2(0, 130, 0, 95);

-- StarterGui.DeltaKeyboard.Main.Background.D.UIStroke
DLTA["129"] = instance("UIStroke", DLTA["128"]);
DLTA["129"]["Color"] = rgb(255, 255, 255);
DLTA["129"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.Background.D.UICorner
DLTA["12a"] = instance("UICorner", DLTA["128"]);
DLTA["12a"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.UICorner
DLTA["12b"] = instance("UICorner", DLTA["2"]);
DLTA["12b"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.ToggleRGB
DLTA["12c"] = instance("TextButton", DLTA["2"]);
DLTA["12c"]["BackgroundColor3"] = rgb(0, 255, 0);
DLTA["12c"]["TextSize"] = 14;
DLTA["12c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["12c"]["TextColor3"] = rgb(0, 0, 0);
DLTA["12c"]["Size"] = u2(0, 14, 0, 14);
DLTA["12c"]["Name"] = [[ToggleRGB]];
DLTA["12c"]["Text"] = [[]];
DLTA["12c"]["Position"] = u2(0.9649999737739563, 0, 0.9300000071525574, 0);

-- StarterGui.DeltaKeyboard.Main.ToggleRGB.UICorner
DLTA["12d"] = instance("UICorner", DLTA["12c"]);
DLTA["12d"]["CornerRadius"] = u(0, 4);

-- StarterGui.DeltaKeyboard.Main.ToggleRGB.UIStroke
DLTA["12e"] = instance("UIStroke", DLTA["12c"]);
DLTA["12e"]["Color"] = rgb(255, 255, 255);
DLTA["12e"]["Thickness"] = 0.8999999761581421;
DLTA["12e"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.tesy
DLTA["12f"] = instance("TextButton", DLTA["2"]);
DLTA["12f"]["BackgroundColor3"] = rgb(0, 255, 0);
DLTA["12f"]["TextSize"] = 14;
DLTA["12f"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["12f"]["TextColor3"] = rgb(0, 0, 0);
DLTA["12f"]["Visible"] = false;
DLTA["12f"]["Size"] = u2(0, 58, 0, 14);
DLTA["12f"]["Name"] = [[tesy]];
DLTA["12f"]["Text"] = [[]];
DLTA["12f"]["Position"] = u2(0.8352929353713989, 0, 0.9299998879432678, 0);

-- StarterGui.DeltaKeyboard.Main.tesy.UICorner
DLTA["130"] = instance("UICorner", DLTA["12f"]);
DLTA["130"]["CornerRadius"] = u(0, 4);

-- StarterGui.DeltaKeyboard.Main.tesy.UIStroke
DLTA["131"] = instance("UIStroke", DLTA["12f"]);
DLTA["131"]["Color"] = rgb(255, 255, 255);
DLTA["131"]["Thickness"] = 0.8999999761581421;
DLTA["131"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.ToggleShift
DLTA["132"] = instance("TextButton", DLTA["2"]);
DLTA["132"]["BackgroundColor3"] = rgb(0, 255, 0);
DLTA["132"]["TextSize"] = 14;
DLTA["132"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["132"]["TextColor3"] = rgb(255, 255, 255);
DLTA["132"]["Size"] = u2(0, 78, 0, 14);
DLTA["132"]["Name"] = [[ToggleShift]];
DLTA["132"]["Text"] = [[Enable Shift]];
DLTA["132"]["Position"] = u2(0.7934519052505493, 0, 0.9299998879432678, 0);

-- StarterGui.DeltaKeyboard.Main.ToggleShift.UICorner
DLTA["133"] = instance("UICorner", DLTA["132"]);
DLTA["133"]["CornerRadius"] = u(0, 4);

-- StarterGui.DeltaKeyboard.Main.ToggleShift.UIStroke
DLTA["134"] = instance("UIStroke", DLTA["132"]);
DLTA["134"]["Color"] = rgb(255, 255, 255);
DLTA["134"]["Thickness"] = 0.8999999761581421;
DLTA["134"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.Main.ToggleShift.UIStroke
DLTA["135"] = instance("UIStroke", DLTA["132"]);
DLTA["135"]["Thickness"] = 0.8999999761581421;

-- StarterGui.DeltaKeyboard.Main.Drag
DLTA["136"] = instance("LocalScript", DLTA["2"]);
DLTA["136"]["Name"] = [[Drag]];

-- StarterGui.DeltaKeyboard.Main.UICorner
DLTA["137"] = instance("UICorner", DLTA["2"]);
DLTA["137"]["CornerRadius"] = u(0, 5);

-- StarterGui.DeltaKeyboard.Main.ButtonHandler
DLTA["138"] = instance("LocalScript", DLTA["2"]);
DLTA["138"]["Name"] = [[ButtonHandler]];

-- StarterGui.DeltaKeyboard.Main.Close
DLTA["139"] = instance("TextButton", DLTA["2"]);
DLTA["139"]["BorderSizePixel"] = 0;
DLTA["139"]["AutoButtonColor"] = false;
DLTA["139"]["BackgroundColor3"] = rgb(25, 25, 25);
DLTA["139"]["TextSize"] = 16;
DLTA["139"]["FontFace"] = fn([[rbxasset://fonts/families/FredokaOne.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["139"]["TextColor3"] = rgb(255, 255, 255);
DLTA["139"]["Size"] = u2(0, 34, 0, 22);
DLTA["139"]["Name"] = [[Close]];
DLTA["139"]["BorderColor3"] = rgb(255, 255, 255);
DLTA["139"]["Text"] = [[X]];
DLTA["139"]["Position"] = u2(0, 437, 0, 2);

-- StarterGui.DeltaKeyboard.Main.Minimize
DLTA["13a"] = instance("TextButton", DLTA["2"]);
DLTA["13a"]["BorderSizePixel"] = 0;
DLTA["13a"]["BackgroundColor3"] = rgb(36, 36, 36);
DLTA["13a"]["TextSize"] = 21;
DLTA["13a"]["FontFace"] = fn([[rbxasset://fonts/families/FredokaOne.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["13a"]["TextColor3"] = rgb(255, 255, 255);
DLTA["13a"]["Size"] = u2(0, 34, 0, 22);
DLTA["13a"]["Name"] = [[Minimize]];
DLTA["13a"]["Text"] = [[-]];
DLTA["13a"]["Position"] = u2(0, 367, 0, 2);
DLTA["13a"]["BackgroundTransparency"] = 1;

-- StarterGui.DeltaKeyboard.Main.Window
DLTA["13b"] = instance("TextButton", DLTA["2"]);
DLTA["13b"]["BorderSizePixel"] = 0;
DLTA["13b"]["BackgroundColor3"] = rgb(36, 36, 36);
DLTA["13b"]["TextSize"] = 21;
DLTA["13b"]["FontFace"] = fn([[rbxasset://fonts/families/FredokaOne.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["13b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["13b"]["Size"] = u2(0, 34, 0, 22);
DLTA["13b"]["Name"] = [[Window]];
DLTA["13b"]["Text"] = [[☐]];
DLTA["13b"]["Position"] = u2(0, 401, 0, 2);
DLTA["13b"]["BackgroundTransparency"] = 1;

-- StarterGui.DeltaKeyboard.Main.Title
DLTA["13c"] = instance("TextLabel", DLTA["2"]);
DLTA["13c"]["BackgroundColor3"] = rgb(255, 255, 255);
DLTA["13c"]["TextXAlignment"] = enum.TextXAlignment.Left;
DLTA["13c"]["FontFace"] = fn([[rbxasset://fonts/families/Nunito.json]], enum.FontWeight.Bold, enum.FontStyle.Normal);
DLTA["13c"]["TextSize"] = 14;
DLTA["13c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["13c"]["Size"] = u2(0, 121, 0, 22);
DLTA["13c"]["Active"] = true;
DLTA["13c"]["Text"] = [[Delta Mobile - Keyboard]];
DLTA["13c"]["Name"] = [[Title]];
DLTA["13c"]["BackgroundTransparency"] = 1;
DLTA["13c"]["Position"] = u2(0, 9, 0, 2);

-- StarterGui.DeltaKeyboard.Main.Settings
DLTA["13d"] = instance("TextButton", DLTA["2"]);
DLTA["13d"]["BorderSizePixel"] = 0;
DLTA["13d"]["BackgroundColor3"] = rgb(255, 255, 255);
DLTA["13d"]["FontFace"] = fn([[rbxasset://fonts/families/LegacyArial.json]], enum.FontWeight.Bold, enum.FontStyle.Normal);
DLTA["13d"]["TextColor3"] = rgb(255, 255, 255);
DLTA["13d"]["Selectable"] = false;
DLTA["13d"]["Size"] = u2(0, 17, 0, 17);
DLTA["13d"]["Name"] = [[Settings]];
DLTA["13d"]["Text"] = [[a +]];
DLTA["13d"]["Position"] = u2(0.0041841003112494946, 0, 0.9237288236618042, 0);
DLTA["13d"]["BackgroundTransparency"] = 1;

-- StarterGui.DeltaKeyboard.IsSelectingKey
DLTA["13e"] = instance("BoolValue", DLTA["1"]);
DLTA["13e"]["Name"] = [[IsSelectingKey]];

-- StarterGui.DeltaKeyboard.KEY
DLTA["13f"] = instance("TextButton", DLTA["1"]);
DLTA["13f"]["TextWrapped"] = true;
DLTA["13f"]["TextScaled"] = true;
DLTA["13f"]["BackgroundColor3"] = rgb(31, 31, 31);
DLTA["13f"]["FontFace"] = fn([[rbxasset://fonts/families/TitilliumWeb.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["13f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["13f"]["Selectable"] = false;
DLTA["13f"]["Visible"] = false;
DLTA["13f"]["Size"] = u2(0, 40, 0, 40);
DLTA["13f"]["Name"] = [[KEY]];
DLTA["13f"]["Text"] = [[KEY]];
DLTA["13f"]["Position"] = u2(0.47962817549705505, 0, 0.46487605571746826, 0);

-- StarterGui.DeltaKeyboard.KEY.UICorner
DLTA["140"] = instance("UICorner", DLTA["13f"]);


-- StarterGui.DeltaKeyboard.KEY.UIStroke
DLTA["141"] = instance("UIStroke", DLTA["13f"]);
DLTA["141"]["Color"] = rgb(255, 255, 255);
DLTA["141"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.KEY.Close
DLTA["142"] = instance("TextButton", DLTA["13f"]);
DLTA["142"]["TextWrapped"] = true;
DLTA["142"]["TextScaled"] = true;
DLTA["142"]["BackgroundColor3"] = rgb(255, 0, 0);
DLTA["142"]["TextSize"] = 14;
DLTA["142"]["FontFace"] = fn([[rbxasset://fonts/families/FredokaOne.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["142"]["TextColor3"] = rgb(255, 255, 255);
DLTA["142"]["Size"] = u2(0, 11, 0, 11);
DLTA["142"]["Name"] = [[Close]];
DLTA["142"]["Text"] = [[X]];
DLTA["142"]["Position"] = u2(1, 0, -0.125, 0);

-- StarterGui.DeltaKeyboard.KEY.Close.UICorner
DLTA["143"] = instance("UICorner", DLTA["142"]);


-- StarterGui.DeltaKeyboard.CreateKey
DLTA["144"] = instance("Frame", DLTA["1"]);
DLTA["144"]["Active"] = true;
DLTA["144"]["BackgroundColor3"] = rgb(32, 32, 32);
DLTA["144"]["Size"] = u2(0, 284, 0, 292);
DLTA["144"]["Position"] = u2(0.3589794337749481, 0, 0.24793387949466705, 0);
DLTA["144"]["Visible"] = false;
DLTA["144"]["Name"] = [[CreateKey]];

-- StarterGui.DeltaKeyboard.CreateKey.UICorner
DLTA["145"] = instance("UICorner", DLTA["144"]);


-- StarterGui.DeltaKeyboard.CreateKey.UIStroke
DLTA["146"] = instance("UIStroke", DLTA["144"]);
DLTA["146"]["Color"] = rgb(158, 0, 255);
DLTA["146"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.CreateKey.Title
DLTA["147"] = instance("TextLabel", DLTA["144"]);
DLTA["147"]["BackgroundColor3"] = rgb(255, 255, 255);
DLTA["147"]["FontFace"] = fn([[rbxasset://fonts/families/Nunito.json]], enum.FontWeight.Bold, enum.FontStyle.Normal);
DLTA["147"]["Selectable"] = true;
DLTA["147"]["TextSize"] = 18;
DLTA["147"]["TextColor3"] = rgb(255, 255, 255);
DLTA["147"]["Size"] = u2(0, 285, 0, 24);
DLTA["147"]["Active"] = true;
DLTA["147"]["Text"] = [[Delta Keyboard - Settings Floating Key]];
DLTA["147"]["Name"] = [[Title]];
DLTA["147"]["BackgroundTransparency"] = 1;
DLTA["147"]["Position"] = u2(-0.0035211266949772835, 0, 0.02054794505238533, 0);

-- StarterGui.DeltaKeyboard.CreateKey.Create
DLTA["148"] = instance("TextButton", DLTA["144"]);
DLTA["148"]["BackgroundColor3"] = rgb(21, 21, 21);
DLTA["148"]["TextSize"] = 31;
DLTA["148"]["FontFace"] = fn([[rbxasset://fonts/families/Nunito.json]], enum.FontWeight.Bold, enum.FontStyle.Normal);
DLTA["148"]["TextColor3"] = rgb(255, 255, 255);
DLTA["148"]["Size"] = u2(0, 166, 0, 46);
DLTA["148"]["Name"] = [[Create]];
DLTA["148"]["Text"] = [[Create]];
DLTA["148"]["Position"] = u2(0.2042253464460373, 0, 0.6095890402793884, 0);

-- StarterGui.DeltaKeyboard.CreateKey.Create.UICorner
DLTA["149"] = instance("UICorner", DLTA["148"]);


-- StarterGui.DeltaKeyboard.CreateKey.Create.UIStroke
DLTA["14a"] = instance("UIStroke", DLTA["148"]);
DLTA["14a"]["Color"] = rgb(255, 255, 255);
DLTA["14a"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.CreateKey.Title2
DLTA["14b"] = instance("TextLabel", DLTA["144"]);
DLTA["14b"]["BackgroundColor3"] = rgb(255, 255, 255);
DLTA["14b"]["FontFace"] = fn([[rbxasset://fonts/families/Nunito.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["14b"]["Selectable"] = true;
DLTA["14b"]["TextSize"] = 20;
DLTA["14b"]["TextColor3"] = rgb(255, 255, 255);
DLTA["14b"]["Size"] = u2(0, 285, 0, 24);
DLTA["14b"]["Active"] = true;
DLTA["14b"]["Text"] = [[Enter your keybind here.]];
DLTA["14b"]["Name"] = [[Title2]];
DLTA["14b"]["BackgroundTransparency"] = 1;
DLTA["14b"]["Position"] = u2(-0.003521125763654709, 0, 0.19178083539009094, 0);

-- StarterGui.DeltaKeyboard.CreateKey.TextBox
DLTA["14c"] = instance("TextBox", DLTA["144"]);
DLTA["14c"]["TextSize"] = 14;
DLTA["14c"]["TextWrapped"] = true;
DLTA["14c"]["TextScaled"] = true;
DLTA["14c"]["BackgroundColor3"] = rgb(16, 16, 16);
DLTA["14c"]["TextColor3"] = rgb(255, 255, 255);
DLTA["14c"]["FontFace"] = fn([[rbxasset://fonts/families/SourceSansPro.json]], enum.FontWeight.Regular, enum.FontStyle.Normal);
DLTA["14c"]["Size"] = u2(0, 167, 0, 76);
DLTA["14c"]["Text"] = [[]];
DLTA["14c"]["Position"] = u2(0.2042253464460373, 0, 0.29109588265419006, 0);

-- StarterGui.DeltaKeyboard.CreateKey.TextBox.UIStroke
DLTA["14d"] = instance("UIStroke", DLTA["14c"]);
DLTA["14d"]["Color"] = rgb(255, 255, 255);
DLTA["14d"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.CreateKey.TextBox.UICorner
DLTA["14e"] = instance("UICorner", DLTA["14c"]);


-- StarterGui.DeltaKeyboard.CreateKey.Close
DLTA["14f"] = instance("TextButton", DLTA["144"]);
DLTA["14f"]["BackgroundColor3"] = rgb(21, 21, 21);
DLTA["14f"]["TextSize"] = 20;
DLTA["14f"]["FontFace"] = fn([[rbxasset://fonts/families/Nunito.json]], enum.FontWeight.Bold, enum.FontStyle.Normal);
DLTA["14f"]["TextColor3"] = rgb(255, 255, 255);
DLTA["14f"]["Size"] = u2(0, 166, 0, 22);
DLTA["14f"]["Name"] = [[Close]];
DLTA["14f"]["Text"] = [[Close]];
DLTA["14f"]["Position"] = u2(0.2042253464460373, 0, 0.8835616707801819, 0);

-- StarterGui.DeltaKeyboard.CreateKey.Close.UICorner
DLTA["150"] = instance("UICorner", DLTA["14f"]);


-- StarterGui.DeltaKeyboard.CreateKey.Close.UIStroke
DLTA["151"] = instance("UIStroke", DLTA["14f"]);
DLTA["151"]["Color"] = rgb(255, 255, 255);
DLTA["151"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.CreateKey.LocalScript
DLTA["152"] = instance("LocalScript", DLTA["144"]);


-- StarterGui.DeltaKeyboard.Keys
DLTA["153"] = instance("Folder", DLTA["1"]);
DLTA["153"]["Name"] = [[Keys]];

-- StarterGui.DeltaKeyboard.ToggleShift
DLTA["154"] = instance("BoolValue", DLTA["1"]);
DLTA["154"]["Value"] = true;
DLTA["154"]["Name"] = [[ToggleShift]];

-- StarterGui.DeltaKeyboard.Shifting
DLTA["155"] = instance("BoolValue", DLTA["1"]);
DLTA["155"]["Name"] = [[Shifting]];

-- StarterGui.DeltaKeyboard.FloatingIcon
DLTA["156"] = instance("ImageButton", DLTA["1"]);
DLTA["156"]["BackgroundColor3"] = rgb(30, 30, 30);
DLTA["156"]["Image"] = [[rbxassetid://13501536441]];
DLTA["156"]["Size"] = u2(0, 40, 0, 40);
DLTA["156"]["Name"] = [[FloatingIcon]];
DLTA["156"]["Visible"] = false;
DLTA["156"]["Position"] = u2(0.015649452805519104, 0, 0.03064066171646118, 0);

-- StarterGui.DeltaKeyboard.FloatingIcon.UICorner
DLTA["157"] = instance("UICorner", DLTA["156"]);
DLTA["157"]["CornerRadius"] = u(0, 12);

-- StarterGui.DeltaKeyboard.FloatingIcon.UIStroke
DLTA["158"] = instance("UIStroke", DLTA["156"]);
DLTA["158"]["Color"] = rgb(158, 0, 255);
DLTA["158"]["Thickness"] = 1.2999999523162842;
DLTA["158"]["ApplyStrokeMode"] = enum.ApplyStrokeMode.Border;

-- StarterGui.DeltaKeyboard.FloatingIcon.LocalScript
DLTA["159"] = instance("LocalScript", DLTA["156"]);


-- StarterGui.DeltaKeyboard.Main.Background.Handler
local function C_56()
	local script = DLTA["56"];

	local btns = script.Parent
	local IsSelecting = script.Parent.Parent.Parent.IsSelectingKey
	local ToggleShift = script.Parent.Parent.Parent.ToggleShift
	local function CreateFloatingKey(keybind, text)

		local key = script.Parent.Parent.Parent.KEY:Clone()
		if text == "" then
			text = "Space"
			keybind = "Space"
		end
		key.Parent = script.Parent.Parent.Parent.Keys
		key.Visible = true
		key.Draggable = true
		key.Name = keybind
		key.Text = text
		key.MouseButton1Up:Connect(function()
			simulatekeyrelease(KeyCode[keybind])
		end)
		key.MouseButton1Down:Connect(function()
			simulatekeypress(KeyCode[keybind])		
		end)
		key.Close.MouseButton1Up:Connect(function()
			key:Destroy()
		end)
	end

	for _, keys in next, btns:QueryDescendants("TextButton") do
		if keys.Parent==btns then
			if string.find(keys.Name, "-") then
				local key = string.sub(keys.Name, 2)

				keys.MouseButton1Down:Connect(function()

					if IsSelecting.Value == true then
						CreateFloatingKey(key, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeypress(KeyCode[key])
					end
				end)
				keys.MouseButton1Up:Connect(function()

					if IsSelecting.Value == true then
						CreateFloatingKey(key, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeyrelease(KeyCode[key])
					end
				end)
			elseif string.find(keys.Name, "_") then
				local key = string.sub(keys.Name, 2)

				keys.MouseButton1Down:Connect(function()

					if IsSelecting.Value == true then
						CreateFloatingKey(key, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeypress(KeyCode[key])
					end
				end)
				keys.MouseButton1Up:Connect(function()

					if IsSelecting.Value == true then
						CreateFloatingKey(key, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeyrelease(KeyCode[key])
					end
				end)

			elseif keys.Name == "RightShift" then

				keys.MouseButton1Up:Connect(function()
					if ToggleShift.Value == false then
						if script.Parent.Parent.Parent.Shifting.Value then
							script.Parent.Parent.Parent.Shifting.Value = false
							for i,v in next, btns:QueryDescendants("TextButton") do
								if v.Parent==btns then
									local a = v.Name
									if string.find(a, "_") then
										v.Visible = false
									elseif string.find(a, "-") then
										v.Visible = true
									end
								end
							end
						elseif not script.Parent.Parent.Parent.Shifting.Value then
							script.Parent.Parent.Parent.Shifting.Value = true
							for i,v in next, btns:QueryDescendants("TextButton") do
								if v.Parent==btns then
									local a = v.Name
									if string.find(a, "_") then
										v.Visible = true
									elseif string.find(a, "-") then
										v.Visible = false
									end
								end
							end
						end
					elseif ToggleShift.Value == true then
						if IsSelecting.Value == false then
							simulatekeypress(KeyCode[keys.Name])
						elseif IsSelecting.Value == true then
							IsSelecting.Value = false
							CreateFloatingKey(keys.Name, keys.Name)
						end
					end
				end)
			elseif keys.Name == "LeftShift" then
				keys.MouseButton1Up:Connect(function()
					if ToggleShift.Value == false then
						if script.Parent.Parent.Parent.Shifting.Value then
							script.Parent.Parent.Parent.Shifting.Value = false
							for i,v in next, btns:QueryDescendants("TextButton") do
								if v.Parent==btns then
									local a = v.Name
									if string.find(a, "_") then
										v.Visible = false
									elseif string.find(a, "-") then
										v.Visible = true
									end
								end
							end
						elseif not script.Parent.Parent.Parent.Shifting.Value then
							script.Parent.Parent.Parent.Shifting.Value = true
							for i,v in next, btns:QueryDescendants("TextButton") do
								if v.Parent==btns then
									local a = v.Name
									if string.find(a, "_") then
										v.Visible = true
									elseif string.find(a, "-") then
										v.Visible = false
									end
								end
							end
						end
					elseif ToggleShift.Value == true then
						if IsSelecting.Value == false then
							simulatekeypress(KeyCode[keys.Name])
						elseif IsSelecting.Value == true then
							IsSelecting.Value = false
							CreateFloatingKey(keys.Name, keys.Name)
						end
					end
				end)
				keys.MouseButton1Down:Connect(function()
					if ToggleShift.Value == true then
						simulatekeypress(KeyCode[keys.Name])
					end
				end)

			else
				keys.MouseButton1Down:Connect(function()
					if IsSelecting.Value == true then
						CreateFloatingKey(keys.Text, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeypress(KeyCode[keys.Name])
					end

				end)
				keys.MouseButton1Up:Connect(function()
					if IsSelecting.Value == true then
						CreateFloatingKey(keys.Text, keys.Text)
						IsSelecting.Value = false
					else
						simulatekeyrelease(KeyCode[keys.Name])
					end
				end)
			end		
		end
	end
end;
spawn(C_56);
-- StarterGui.DeltaKeyboard.Main.Background.RGBHandler
local function C_e7()
	local script = DLTA["e7"];
	pcall(function()
		local TweenService = game:GetService("TweenService")
		local bool = true

		script.Parent.Parent.ToggleRGB.MouseButton1Up:Connect(function()
			if bool then
				bool = false
				script.Parent.Parent.Parent.Main.UIStroke.Color =  rgb(255, 255, 255)
				script.Parent.Parent.ToggleRGB.BackgroundColor3 = rgb(255, 0, 0)
			elseif not bool then
				bool = true
				script.Parent.Parent.Parent.Main.UIStroke.Color =  rgb(157, 0, 255)
				script.Parent.Parent.ToggleRGB.BackgroundColor3 = rgb(0, 255, 0)
				for i, v in next, script.Parent:QueryDescendants("TextButton") do
					if v.Parent==script.Parent then
						spawn(function()
							local x = 0
							while true do
								v.UIStroke.Color = hsv(x,1,1) 
								x = x + 1/255 
								if x >= 1 then
									x = 0
								end
								if not bool then
									v.UIStroke.Color = c3(1,1,1)
									break
								end
								wait() 
							end
						end)
					end
				end
			end
		end)

		for i, v in next, script.Parent:QueryDescendants("TextButton") do
			if v.Parent==script.Parent then
				spawn(function()
					local x = 0
					while true do
						v.UIStroke.Color = hsv(x,1,1) 
						x = x + 1/255 
						if x >= 1 then
							x = 0
						end
						if not bool then
							v.UIStroke.Color = c3(1,1,1)
							break
						end
						wait() 
					end
				end)
			end
		end
	end)
end;
spawn(C_e7);
-- StarterGui.DeltaKeyboard.Main.Drag
local function C_136()
	local script = DLTA["136"];
	local function dragify(Frame)
		dragToggle = nil
		dragSpeed = .25 -- You can edit this.
		dragInput = nil
		dragStart = nil
		dragPos = nil

		function updateInput(input)
			Delta = input.Position - dragStart
			Position = u2(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			ts:Create(Frame, TweenInfo.new(0.1), {Position = Position}):Play()
		end

		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == enum.UserInputType.MouseButton1 or input.UserInputType == enum.UserInputType.Touch) then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if (input.UserInputState == enum.UserInputState.End) then
						dragToggle = false
					end
				end)
			end
		end)

		Frame.InputChanged:Connect(function(input)
			if (input.UserInputType == enum.UserInputType.MouseMovement or input.UserInputType == enum.UserInputType.Touch) then
				dragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if (input == dragInput and dragToggle) then
				updateInput(input)
			end
		end)
	end
	spawn(function()
		dragify(script.Parent.Parent.FloatingIcon)
	end)
	dragify(script.Parent)

end;
spawn(C_136);
-- StarterGui.DeltaKeyboard.Main.ButtonHandler
local function C_138()
	local script = DLTA["138"];
	local buttons = script.Parent
	local cooldown = false

	buttons.Close.MouseButton1Up:Connect(function()
		script.Parent.Parent:Destroy()
	end)
	buttons.Close.MouseEnter:Connect(function()
		buttons.Close.BackgroundColor3 = rgb(220, 0, 0)
	end)
	buttons.Close.MouseLeave:Connect(function()
		buttons.Close.BackgroundColor3 = rgb(35, 35, 35)
	end)
	buttons.Minimize.MouseButton1Up:Connect(function()

		script.Parent.Visible = false
		script.Parent.Parent.FloatingIcon.Visible = true
	end)
	buttons.Window.MouseButton1Up:Connect(function()
		if not cooldown then
			if script.Parent.Background.Visible == true then
				script.Parent.ToggleRGB.Visible = false
				script.Parent.Settings.Visible = false
				script.Parent.Background.Visible = false
				script.Parent.ToggleShift.Visible = false
				local ti = TweenInfo.new(.8, enum.EasingStyle.Quint, enum.EasingDirection.Out)
				local tw = ts:Create(script.Parent, ti, {Size = u2(0, 478,0, 29)})
				tw:Play()
				cooldown = true
				tw.Completed:Wait()
				cooldown = false
			elseif script.Parent.Background.Visible ==false then

				local ti = TweenInfo.new(.8, enum.EasingStyle.Quint, enum.EasingDirection.Out)
				local tw = ts:Create(script.Parent, ti, {Size = u2(0, 478,0, 236)})
				tw:Play()
				cooldown = true
				tw.Completed:Wait()
				script.Parent.ToggleRGB.Visible = true
				script.Parent.Settings.Visible = true
				script.Parent.Background.Visible = true
				script.Parent.ToggleShift.Visible = true
				cooldown = false
			end
		end
	end)

	buttons.Settings.MouseButton1Up:Connect(function()
		script.Parent.Parent.IsSelectingKey.Value = true
	end)

	local IsSelecting =script.Parent.Parent.IsSelectingKey
	IsSelecting:GetPropertyChangedSignal("Value"):Connect(function()
		if IsSelecting.Value == true then
			script.Parent.Title.Text = "Delta Mobile - Keyboard (Selecting Key)"
		elseif IsSelecting.Value == false then
			script.Parent.Title.Text = "Delta Mobile - Keyboard"
		end
	end)

	script.Parent.ToggleShift.MouseButton1Up:Connect(function()
		if script.Parent.Parent.ToggleShift.Value == true then
			script.Parent.Parent.ToggleShift.Value = false
			script.Parent.ToggleShift.BackgroundColor3 = rgb(255, 0, 0)
		elseif script.Parent.Parent.ToggleShift.Value == false then
			script.Parent.Parent.ToggleShift.Value = true
			script.Parent.ToggleShift.BackgroundColor3 = rgb(0, 255, 0)
		end
	end)
end;
spawn(C_138);
-- StarterGui.DeltaKeyboard.CreateKey.LocalScript
local function C_152()
	local script = DLTA["152"];
	local close = script.Parent.Close
	local create = script.Parent.Create
	local textbox = script.Parent.TextBox

	script.Parent.Draggable = true
	close.MouseButton1Up:Connect(function()
		script.Parent.Visible = false
	end)
	create.MouseButton1Up:Connect(function()
		if textbox.Text ~= "" then
			local key = script.Parent.Parent.KEY:Clone()
			key.Parent = script.Parent.Parent.Keys
			key.Visible = true
			key.Draggable = true
			key.Name = textbox.Text
			key.MouseButton1Up:Connect(function()
				simulatekeyrelease(KeyCode[textbox.Text])
			end)
			key.MouseButton1Down:Connect(function()
				simulatekeypress(KeyCode[textbox.Text])
			end)
			key.Close.MouseButton1Up:Connect(function()
				key:Destroy()
			end)
		end
	end)
end;
spawn(C_152);
-- StarterGui.DeltaKeyboard.FloatingIcon.LocalScript
local function C_159()
	local script = DLTA["159"];
	script.Parent.MouseButton1Up:Connect(function()
		script.Parent.Visible=false
		script.Parent.Parent.Main.Visible = true
	end)
end;
spawn(C_159);

local coregui = game:GetService("CoreGui")
do
	local hiddenui=get_hidden_gui or gethui
	if hiddenui then
		DLTA["1"].Parent=hiddenui()
	elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
		syn.protect_gui(DLTA["1"])
		DLTA["1"].Parent=cloneref(coregui)
	elseif coregui then
		DLTA["1"].Parent=cloneref(coregui:FindFirstChild("RobloxGui") or coregui)
	else
		DLTA["1"].DisplayOrder=2147483647
		DLTA["1"].Parent=cloneref(plrs.LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	end
end
