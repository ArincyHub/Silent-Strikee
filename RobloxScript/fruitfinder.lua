repeat wait(1) until game:IsLoaded()
repeat wait(1) until game.Players.LocalPlayer
repeat wait(1) until game.Players.LocalPlayer:FindFirstChild("Backpack")
wait(3)

local configN = _G.Config or {
	["Team"] = "Marines" -- Pirates / Marines
}

-- Select Team
local IschooseTeam = function()
	for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
		if v:FindFirstChild("ChooseTeam") then
			return not(v:FindFirstChild("ChooseTeam").Visible)
		end
	end
end

local chooseTeam = function(_)
	for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
		if v:FindFirstChild("ChooseTeam") and v:FindFirstChild("ChooseTeam").Visible then
			local args = {
				[1] = "SetTeam",
				[2] = tostring(_)
			}
			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
		end
	end
end

local TeamSelect = configN["Team"] or "Pirates"
repeat wait() chooseTeam(TeamSelect) until IschooseTeam()

-- ============================================================
--  COLOR PALETTE
-- ============================================================
local C = {
	BG          = Color3.fromRGB(13,  13,  15),   -- #0d0d0f  panel bg
	Panel       = Color3.fromRGB(17,  17,  20),   -- #111114  inner panel
	Surface     = Color3.fromRGB(22,  22,  25),   -- #161619  stat cards
	Surface2    = Color3.fromRGB(26,  26,  30),   -- #1a1a1e  info rows
	Border      = Color3.fromRGB(34,  34,  40),   -- #222228  border
	Border2     = Color3.fromRGB(30,  30,  38),   -- #1e1e26  inner border
	Accent      = Color3.fromRGB(99,  102, 241),  -- #6366f1  indigo
	AccentHover = Color3.fromRGB(117, 119, 243),  -- #7577f3
	Green       = Color3.fromRGB(34,  197, 94),   -- #22c55e
	Amber       = Color3.fromRGB(245, 158, 11),   -- #f59e0b
	Red         = Color3.fromRGB(239, 68,  68),   -- #ef4444
	RedSurface  = Color3.fromRGB(30,  20,  20),   -- #1e1414
	TextPrimary = Color3.fromRGB(232, 232, 240),  -- #e8e8f0
	TextMuted   = Color3.fromRGB(160, 160, 176),  -- #a0a0b0
	TextDim     = Color3.fromRGB(85,  85,  85),   -- #555555
	TextLabel   = Color3.fromRGB(68,  68,  68),   -- #444444
	White       = Color3.fromRGB(255, 255, 255),
	Black       = Color3.fromRGB(0,   0,   0),
}

-- ============================================================
--  HELPERS
-- ============================================================
local function makeCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 8)
	c.Parent = parent
	return c
end

local function makePadding(parent, top, right, bottom, left)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, top    or 0)
	p.PaddingRight  = UDim.new(0, right  or 0)
	p.PaddingBottom = UDim.new(0, bottom or 0)
	p.PaddingLeft   = UDim.new(0, left   or 0)
	p.Parent = parent
	return p
end

local function makeLabel(parent, props)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.BorderSizePixel = 0
	l.Font     = props.Font     or Enum.Font.GothamMedium
	l.Text     = props.Text     or ""
	l.TextSize = props.TextSize or 13
	l.TextColor3 = props.Color  or C.TextMuted
	l.TextXAlignment = props.XAlign or Enum.TextXAlignment.Left
	l.TextYAlignment = props.YAlign or Enum.TextYAlignment.Center
	l.Size     = props.Size     or UDim2.new(1, 0, 0, 20)
	l.Position = props.Position or UDim2.new(0, 0, 0, 0)
	l.TextWrapped = true
	l.Parent   = parent
	return l
end

local function makeFrame(parent, props)
	local f = Instance.new("Frame")
	f.BackgroundColor3 = props.Color or C.Panel
	f.BorderSizePixel  = 0
	f.Size     = props.Size     or UDim2.new(1, 0, 0, 40)
	f.Position = props.Position or UDim2.new(0, 0, 0, 0)
	f.Parent   = parent
	if props.Transparency then
		f.BackgroundTransparency = props.Transparency
	end
	return f
end

local function makeStroke(parent, color, thickness, transparency)
	local s = Instance.new("UIStroke")
	s.Color = color or C.Border
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

local function makeButton(parent, props)
	local b = Instance.new("TextButton")
	b.BackgroundColor3 = props.Color or C.Surface
	b.BorderSizePixel  = 0
	b.Size     = props.Size or UDim2.new(0, 100, 0, 36)
	b.Position = props.Position or UDim2.new(0, 0, 0, 0)
	b.Font     = Enum.Font.GothamBold
	b.Text     = props.Text or ""
	b.TextColor3 = props.TextColor or C.TextPrimary
	b.TextSize = 12
	b.AutoButtonColor = false
	b.Parent   = parent
	makeCorner(b, 10)
	makeStroke(b, props.StrokeColor or C.Border, 1, 0)
	-- hover effect
	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = props.HoverColor or C.AccentHover
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = props.Color or C.Surface
	end)
	return b
end

-- ============================================================
--  ROOT GUI
-- ============================================================
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "ZenHubGui"
MainGui.ResetOnSpawn = false
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main panel
local Panel = makeFrame(MainGui, {
	Color    = C.BG,
	Size     = UDim2.new(0, 340, 0, 460),
	Position = UDim2.new(0.44, 0, 0.42, 0),
})
Panel.AnchorPoint = Vector2.new(0.5, 0.5)
Panel.Active = true
Panel.Draggable = true
makeCorner(Panel, 20)
makeStroke(Panel, C.Border, 1.5, 0)

-- Thin accent top line (UIStroke on a tiny frame at top)
local TopLine = makeFrame(Panel, {
	Color    = C.Accent,
	Size     = UDim2.new(0.5, 0, 0, 1),
	Position = UDim2.new(0.25, 0, 0, 0),
	Transparency = 0.5,
})

-- ============================================================
--  TOPBAR  (logo + badge)
-- ============================================================
local Topbar = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, 0, 0, 40),
	Position = UDim2.new(0, 0, 0, 0),
	Transparency = 1,
})

-- Logo dot
local LogoDot = makeFrame(Topbar, {
	Color    = C.Accent,
	Size     = UDim2.new(0, 8, 0, 8),
	Position = UDim2.new(0, 18, 0.5, -4),
})
makeCorner(LogoDot, 99)

-- Logo text
makeLabel(Topbar, {
	Text     = "ZEN HUB",
	Font     = Enum.Font.GothamBold,
	TextSize = 11,
	Color    = C.Accent,
	Size     = UDim2.new(0, 80, 1, 0),
	Position = UDim2.new(0, 32, 0, 0),
	XAlign   = Enum.TextXAlignment.Left,
})

-- Badge
local Badge = makeFrame(Topbar, {
	Color    = C.Surface,
	Size     = UDim2.new(0, 88, 0, 22),
	Position = UDim2.new(1, -106, 0.5, -11),
})
makeCorner(Badge, 20)
makeStroke(Badge, C.Border, 1, 0)
makeLabel(Badge, {
	Text     = "Fruit Finder",
	Font     = Enum.Font.GothamMedium,
	TextSize = 10,
	Color    = C.TextDim,
	Size     = UDim2.new(1, 0, 1, 0),
	XAlign   = Enum.TextXAlignment.Center,
})

-- ============================================================
--  AVATAR SECTION
-- ============================================================
local AvatarSection = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, 0, 0, 74),
	Position = UDim2.new(0, 0, 0, 42),
	Transparency = 1,
})

-- Avatar container
local AvatarBg = makeFrame(AvatarSection, {
	Color    = C.Surface,
	Size     = UDim2.new(0, 60, 0, 60),
	Position = UDim2.new(0, 18, 0.5, -30),
})
makeCorner(AvatarBg, 14)
makeStroke(AvatarBg, C.Border, 1, 0)

local players = game:GetService("Players")
local LocalPlayer = players.LocalPlayer
local userId = LocalPlayer.UserId

local UserImage = Instance.new("ImageLabel")
UserImage.Name = "userimage"
UserImage.BackgroundTransparency = 1
UserImage.BorderSizePixel = 0
UserImage.Size = UDim2.new(1, 0, 1, 0)
UserImage.ScaleType = Enum.ScaleType.Crop
UserImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=150&height=150&format=png"
UserImage.Parent = AvatarBg
makeCorner(UserImage, 14)

-- Online dot
local OnlineDot = makeFrame(AvatarSection, {
	Color    = C.Green,
	Size     = UDim2.new(0, 12, 0, 12),
	Position = UDim2.new(0, 64, 0.5, 16),
})
makeCorner(OnlineDot, 99)
local OnlineBorder = makeFrame(AvatarSection, {
	Color    = C.BG,
	Size     = UDim2.new(0, 16, 0, 16),
	Position = UDim2.new(0, 62, 0.5, 14),
})
makeCorner(OnlineBorder, 99)
OnlineDot.ZIndex = OnlineBorder.ZIndex + 1

-- Username
makeLabel(AvatarSection, {
	Text     = LocalPlayer.Name,
	Font     = Enum.Font.GothamBold,
	TextSize = 15,
	Color    = C.TextPrimary,
	Size     = UDim2.new(0, 200, 0, 22),
	Position = UDim2.new(0, 90, 0.5, -24),
	XAlign   = Enum.TextXAlignment.Left,
})

-- Team subtext
makeLabel(AvatarSection, {
	Text     = "Team: " .. TeamSelect,
	Font     = Enum.Font.Gotham,
	TextSize = 12,
	Color    = C.TextDim,
	Size     = UDim2.new(0, 200, 0, 18),
	Position = UDim2.new(0, 90, 0.5, 2),
	XAlign   = Enum.TextXAlignment.Left,
})

-- ============================================================
--  DIVIDER
-- ============================================================
local Divider1 = makeFrame(Panel, {
	Color    = C.Border2,
	Size     = UDim2.new(1, -36, 0, 1),
	Position = UDim2.new(0, 18, 0, 118),
})

-- ============================================================
--  STATUS ROW
-- ============================================================
local StatusRow = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, 0, 0, 34),
	Position = UDim2.new(0, 0, 0, 122),
	Transparency = 1,
})

local StatusDot = makeFrame(StatusRow, {
	Color    = C.Amber,
	Size     = UDim2.new(0, 7, 0, 7),
	Position = UDim2.new(0, 18, 0.5, -3),
})
makeCorner(StatusDot, 99)

makeLabel(StatusRow, {
	Text     = "STATUS",
	Font     = Enum.Font.GothamBold,
	TextSize = 10,
	Color    = C.TextLabel,
	Size     = UDim2.new(0, 56, 1, 0),
	Position = UDim2.new(0, 32, 0, 0),
	XAlign   = Enum.TextXAlignment.Left,
})

local StatusText = makeLabel(StatusRow, {
	Text     = "Start Hop Server (3)",
	Font     = Enum.Font.Code,
	TextSize = 13,
	Color    = C.TextMuted,
	Size     = UDim2.new(0, 190, 1, 0),
	Position = UDim2.new(0, 92, 0, 0),
	XAlign   = Enum.TextXAlignment.Left,
})

-- ============================================================
--  STATS GRID  (Fruits | Ping | FPS)
-- ============================================================
local StatsSection = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, -36, 0, 70),
	Position = UDim2.new(0, 18, 0, 160),
	Transparency = 1,
})

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = StatsSection

local function makeStatCard(parent, labelTxt, valTxt, valColor, order)
	local card = makeFrame(parent, {
		Color    = C.Surface,
		Size     = UDim2.new(0, 92, 1, 0),
	})
	card.LayoutOrder = order
	makeCorner(card, 12)
	makeStroke(card, C.Border2, 1, 0)
	makeLabel(card, {
		Text     = labelTxt,
		Font     = Enum.Font.GothamBold,
		TextSize = 10,
		Color    = C.TextLabel,
		Size     = UDim2.new(1, -16, 0, 18),
		Position = UDim2.new(0, 12, 0, 10),
		XAlign   = Enum.TextXAlignment.Left,
	})
	local val = makeLabel(card, {
		Text     = valTxt,
		Font     = Enum.Font.Code,
		TextSize = 18,
		Color    = valColor or C.TextPrimary,
		Size     = UDim2.new(1, -16, 0, 26),
		Position = UDim2.new(0, 12, 0, 30),
		XAlign   = Enum.TextXAlignment.Left,
	})
	return val
end

local FruitVal  = makeStatCard(StatsSection, "FRUITS",  "0",     C.Accent, 1)
local PingVal   = makeStatCard(StatsSection, "PING",    "--- ms", C.TextPrimary, 2)
local FpsVal    = makeStatCard(StatsSection, "FPS",     "---",   C.Green, 3)

-- ============================================================
--  INFO BLOCK  (time / game mode / found)
-- ============================================================
local InfoBlock = makeFrame(Panel, {
	Color    = C.Surface,
	Size     = UDim2.new(1, -36, 0, 102),
	Position = UDim2.new(0, 18, 0, 242),
})
makeCorner(InfoBlock, 14)
makeStroke(InfoBlock, C.Border2, 1, 0)

local function makeInfoRow(parent, keyTxt, defaultVal, valColor, yPos, isLast)
	local row = makeFrame(parent, {
		Color    = C.Surface,
		Size     = UDim2.new(1, 0, 0, 34),
		Position = UDim2.new(0, 0, 0, yPos),
		Transparency = 1,
	})
	if not isLast then
		local sep = makeFrame(row, {
			Color    = C.Border2,
			Size     = UDim2.new(1, -28, 0, 1),
			Position = UDim2.new(0, 14, 1, -1),
		})
	end
	makeLabel(row, {
		Text     = keyTxt,
		Font     = Enum.Font.GothamMedium,
		TextSize = 12,
		Color    = C.TextLabel,
		Size     = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.new(0, 14, 0, 0),
		XAlign   = Enum.TextXAlignment.Left,
	})
	local v = makeLabel(row, {
		Text     = defaultVal,
		Font     = Enum.Font.Code,
		TextSize = 12,
		Color    = valColor or C.TextMuted,
		Size     = UDim2.new(0.5, -14, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		XAlign   = Enum.TextXAlignment.Right,
	})
	return v
end

local TimeVal  = makeInfoRow(InfoBlock, "Server Time",  "0h 0m 0s",    C.TextMuted, 0)
local ModeVal  = makeInfoRow(InfoBlock, "Game Mode",    "Auto Hop",    C.Accent,    34)
local FoundVal = makeInfoRow(InfoBlock, "Found",        "Not Found",   C.Amber,     68, true)

-- ============================================================
--  BUTTONS
-- ============================================================
local BtnFrame = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, -36, 0, 40),
	Position = UDim2.new(0, 18, 0, 358),
	Transparency = 1,
})

local BtnLayout = Instance.new("UIListLayout")
BtnLayout.FillDirection = Enum.FillDirection.Horizontal
BtnLayout.SortOrder = Enum.SortOrder.LayoutOrder
BtnLayout.Padding = UDim.new(0, 8)
BtnLayout.Parent = BtnFrame

local HopButton = makeButton(BtnFrame, {
	Text       = "Hop",
	Color      = C.Accent,
	HoverColor = C.AccentHover,
	TextColor  = C.White,
	StrokeColor = Color3.fromRGB(120, 123, 255),
	Size       = UDim2.new(0, 92, 1, 0),
})
HopButton.LayoutOrder = 1

local RejoinButton = makeButton(BtnFrame, {
	Text       = "Rejoin",
	Color      = C.Surface2,
	HoverColor = Color3.fromRGB(32, 32, 38),
	TextColor  = C.TextMuted,
	StrokeColor = C.Border,
	Size       = UDim2.new(0, 92, 1, 0),
})
RejoinButton.LayoutOrder = 2

local CloseButton = makeButton(BtnFrame, {
	Text       = "Close",
	Color      = C.RedSurface,
	HoverColor = Color3.fromRGB(38, 22, 22),
	TextColor  = C.Red,
	StrokeColor = Color3.fromRGB(80, 30, 30),
	Size       = UDim2.new(0, 92, 1, 0),
})
CloseButton.LayoutOrder = 3

-- ============================================================
--  FOOTER
-- ============================================================
local Footer = makeFrame(Panel, {
	Color    = C.BG,
	Size     = UDim2.new(1, 0, 0, 36),
	Position = UDim2.new(0, 0, 0, 412),
	Transparency = 1,
})

local FooterLine = makeFrame(Panel, {
	Color    = C.Border2,
	Size     = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 0, 411),
})

makeLabel(Footer, {
	Text     = "discord.gg/zen-hub",
	Font     = Enum.Font.GothamMedium,
	TextSize = 10,
	Color    = C.Accent,
	Size     = UDim2.new(0.6, 0, 1, 0),
	Position = UDim2.new(0, 18, 0, 0),
	XAlign   = Enum.TextXAlignment.Left,
})

makeLabel(Footer, {
	Text     = "v2.0.0",
	Font     = Enum.Font.Code,
	TextSize = 10,
	Color    = C.TextLabel,
	Size     = UDim2.new(0.3, 0, 1, 0),
	Position = UDim2.new(0.68, 0, 0, 0),
	XAlign   = Enum.TextXAlignment.Right,
})

-- ============================================================
--  LOGIC FUNCTIONS
-- ============================================================
local function changeStatus(txt, dotColor)
	StatusText.Text = txt
	StatusDot.BackgroundColor3 = dotColor or C.Amber
end

local function changeAmou(num)
	if type(num) == "number" then
		FruitVal.Text = tostring(num)
		FoundVal.Text = tostring(num) .. " Found"
		FoundVal.TextColor3 = C.Green
	else
		FruitVal.Text = "0"
		FoundVal.Text = "Not Found"
		FoundVal.TextColor3 = C.Amber
	end
end

-- Time updater
spawn(function()
	while task.wait() do
		pcall(function()
			local t = math.floor(workspace.DistributedGameTime + 0.5)
			local h = math.floor(t / 3600) % 24
			local m = math.floor(t / 60) % 60
			local s = t % 60
			TimeVal.Text = h .. "h " .. m .. "m " .. s .. "s"
		end)
	end
end)

-- Ping & FPS updater
local runService = game:GetService("RunService")
local stats = game:GetService("Stats")
runService.RenderStepped:Connect(function()
	pcall(function()
		local fps = math.floor(1 / runService.RenderStepped:Wait())
		local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		PingVal.Text = ping .. " ms"
		FpsVal.Text = tostring(fps)
		FpsVal.TextColor3 = fps >= 30 and C.Green or (fps >= 20 and C.Amber or C.Red)
	end)
end)

-- Hop Server
local HopServer = function()
	local Http = game:GetService("HttpService")
	local ServerBrowser = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser")
	local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"

	changeStatus("Fetching servers...", C.Amber)
	local success, data = pcall(function()
		return Http:JSONDecode(game:HttpGet(url))
	end)

	if not success or not data or not data.data then
		changeStatus("Failed to fetch", C.Red)
		return
	end

	local target = nil
	for _, server in pairs(data.data) do
		if server and server.playing and server.maxPlayers then
			if server.playing < server.maxPlayers and server.id ~= game.JobId then
				target = server
				break
			end
		end
	end

	if not target then
		changeStatus("No server found", C.Red)
		return
	end

	changeStatus("Hopping...", C.Amber)
	ModeVal.Text = "Hopping"
	for i = 1, 3 do
		task.spawn(function()
			pcall(function()
				ServerBrowser:InvokeServer("teleport", target.id)
			end)
		end)
	end
end

-- Rejoin Server
local RejoinServer = function()
	local ServerBrowser = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser")
	changeStatus("Rejoining...", C.Amber)
	for i = 1, 5 do
		task.spawn(function()
			pcall(function()
				ServerBrowser:InvokeServer("teleport", game.JobId)
			end)
		end)
	end
end

-- Button events
HopButton.MouseButton1Click:Connect(HopServer)
RejoinButton.MouseButton1Click:Connect(RejoinServer)
CloseButton.MouseButton1Click:Connect(function()
	MainGui:Destroy()
end)

-- ============================================================
--  FRUIT LOGIC
-- ============================================================
local alreadyHop = false

-- Store fruits loop
task.spawn(function()
	while true do
		pcall(function()
			local Fruit = LocalPlayer.Backpack:FindFirstChild("EatRemote", true) or LocalPlayer.Character:FindFirstChild("EatRemote", true)
			if Fruit then
				local ohString1 = "StoreFruit"
				local ohString2 = Fruit.Parent:GetAttribute("OriginalName")
				local ohInstance3 = Fruit.Parent
				local index = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(ohString1, ohString2, ohInstance3)
				if index then
					changeStatus("Storing fruits", C.Green)
					ModeVal.Text = "Storing"
				end
				if not index then
					if Fruit.Parent.Parent ~= LocalPlayer.Character and Fruit.Parent.Parent == LocalPlayer.Backpack and LocalPlayer.Character:FindFirstChild("Humanoid") then
						LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(Fruit.Parent)
					else
						Fruit:Destroy()
					end
				end
			end
		end)
		task.wait(0.04)
	end
end)

-- Count fruits & hop loop
local countFruits = function()
	local data = {}
	for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
		if string.find(v.Name, "Fruit") and #(v:GetChildren()) > 1 then
			table.insert(data, v.Name)
		end
	end
	return data
end

task.spawn(function()
	while true do
		local FruitsAmo = #countFruits()
		local Fruit
		pcall(function()
			Fruit = LocalPlayer.Backpack:FindFirstChild("EatRemote", true) or LocalPlayer.Character:FindFirstChild("EatRemote", true)
		end)

		if FruitsAmo > 0 and not Fruit then
			changeAmou(FruitsAmo)
			changeStatus("Bringing fruits", C.Green)
			ModeVal.Text = "Collecting"
		else
			changeAmou("null")
			if alreadyHop then
				HopServer()
			else
				changeStatus("Hop in 3...", C.Amber)
				wait(1)
				changeStatus("Hop in 2...", C.Amber)
				wait(1)
				changeStatus("Hop in 1...", C.Amber)
				wait(1)
				changeStatus("Hopping...", C.Amber)
				alreadyHop = true
				HopServer()
			end
		end
		task.wait(5)
	end
end)

-- Bring fruits loop
task.spawn(function()
	while true do
		task.wait()
		pcall(function()
			for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
				if string.find(v.Name, "Fruit") and #(v:GetChildren()) > 1 then
					changeStatus("Bring Fruits", C.Green)
					game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
				end
			end
		end)
	end
end)

-- Notification cleaner
task.spawn(function()
	while true do
		task.wait()
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Notifications.ChildAdded:Connect(function(v)
				pcall(function()
					repeat task.wait() until v.Text ~= "" and v.Text ~= "nil" and v.Text ~= nil
					if string.find(v.Text, "store 1") then
						v:Destroy()
					end
				end)
			end)
		end)
	end
end)