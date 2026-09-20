-- ZEN HUB v3.0
-- UI by ZenHub • Key system by Panda Development

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService  = game:GetService("HttpService")
local Analytics    = game:GetService("RbxAnalyticsService")
local LocalPlayer  = Players.LocalPlayer

-- ─── CONFIG URLS ───────────────────────────────────────────────
local configURL   = "https://pastefy.app/yFFMmIDj/raw"
local klConfigURL = "https://pastefy.app/2Equ0nPn/raw"

-- ─── KL GAME DETECTION ─────────────────────────────────────────
local KL_PLACE_IDS = {
	[6381829480]  = true,
	[15759515082] = true,
	[4520749081]  = true,
}
local isKLGame = KL_PLACE_IDS[game.PlaceId] == true

-- ─── FETCH CONFIGS ─────────────────────────────────────────────
local config = {}
local ok, result = pcall(function()
	config = HttpService:JSONDecode(game:HttpGet(configURL, true))
end)
if not ok then
	config = { keyless = false }
	warn("Global config fetch failed: " .. tostring(result))
end


local klConfig = {}
if isKLGame then
	local klOk, klResult = pcall(function()
		klConfig = HttpService:JSONDecode(game:HttpGet(klConfigURL, true))
	end)
	if not klOk then
		klConfig = { keyless = false }
		warn("KL config fetch failed: " .. tostring(klResult))
	end
end

local keyless = isKLGame and (klConfig.keyless == true) or (config.keyless == true)

-- ─── SCRIPT LOADER ─────────────────────────────────────────────
local function scriptLoad()
	local BF      = "https://raw.githubusercontent.com/notfoundaaditya-creator/ZenMain/refs/heads/main/bloxfruit"
	local KL      = "https://pastefy.app/esX3AUtH/raw"
	local sailorp = "https://vss.pandadevelopment.net/virtual/file/95f4ee49b35d46b2"

	local scripts = {
		[2753915549]      = BF,
		[4442272183]      = BF,
		[7449423635]      = BF,
		[85211729168715]  = BF,
		[79091703265657]  = BF,
		[100117331123089] = BF,
		[2788229376]      = "https://sharetext.me/raw/83mf11f4jf",
		[286090429]       = "https://pastefy.app/BmzIHyM3/raw",
		[13772394625]     = "https://raw.githubusercontent.com/Wumpuspro/Scripts/main/bladeball.lua",
		[17590362521]     = "https://raw.githubusercontent.com/Itz-Npg/Zen-Hub/main/spellingbees.lua",
		[6381829480]      = KL,
		[15759515082]     = KL,
		[4520749081]      = KL,
		[77747658251236]  = sailorp,
		[9186719164]      = sailorp,
		[123955125827131] = sailorp,
		[75159314259063]  = sailorp,
		[99684056491472]  = sailorp,
		[96767841099256]  = sailorp,
		[138368689293913] = sailorp,
		[130167267952199] = sailorp,
		[98826438856089]  = sailorp,
		[75982168454032]  = sailorp,
		[92416421522960]  = "https://vss.pandadevelopment.net/virtual/file/3e76ed5ff40d4405",
	}

	local scriptToLoad = scripts[game.PlaceId]
	if scriptToLoad then
		local s, err = pcall(function()
			loadstring(game:HttpGet(scriptToLoad, true))()
		end)
		if not s then warn("Script load error: " .. tostring(err)) end
	else
		warn("No script found for PlaceId: " .. tostring(game.PlaceId))
	end
end

-- ─── KEY SYSTEM API ────────────────────────────────────────────
local BaseURL     = "https://new.pandadevelopment.net/api/v1"
local ServiceID   = "zenhubnew"
local requestFunc = http_request or request or HttpPost or syn.request

local function getHWID()
	local s, id = pcall(gethwid)
	if s and id then return id end
	return tostring(Analytics:GetClientId()):gsub("-", "")
end

local function requestAPI(endpoint, data)
	local res = requestFunc({
		Url     = BaseURL .. endpoint,
		Method  = "POST",
		Headers = { ["Content-Type"] = "application/json" },
		Body    = HttpService:JSONEncode(data),
	})
	if res and res.Body then
		local s, decoded = pcall(HttpService.JSONDecode, HttpService, res.Body)
		if s then return decoded end
	end
end

local function GetKeyURL()
	return "https://new.pandadevelopment.net/getkey/" .. ServiceID .. "?hwid=" .. getHWID()
end

local function ValidateKey(key)
	if not key or key == "" then return false, "No key entered" end
	local res = requestAPI("/keys/validate", {
		ServiceID = ServiceID,
		HWID      = getHWID(),
		Key       = key,
	})
	if not res then return false, "Connection failed" end
	if res.Authenticated_Status == "Success" then
		return true, res.Note or "Key valid"
	end
	return false, res.Note or "Invalid key"
end

local function notify(title, text)
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title    = title,
		Text     = text,
		Duration = 5,
	})
end

-- Skip UI entirely if keyless
if keyless then
	scriptLoad()
	return
end

-- ─── COLOURS ───────────────────────────────────────────────────

local C = {
	BG           = Color3.fromRGB(8,   8,   12),
	Panel        = Color3.fromRGB(10,  10,  18),
	Surface      = Color3.fromRGB(13,  13,  24),
	Surface2     = Color3.fromRGB(17,  17,  30),
	Border       = Color3.fromRGB(26,  26,  46),
	Border2      = Color3.fromRGB(20,  20,  38),
	Accent       = Color3.fromRGB(99,  102, 241),
	AccentGlow   = Color3.fromRGB(120, 123, 255),
	AccentDim    = Color3.fromRGB(40,  42,  100),
	Green        = Color3.fromRGB(34,  197, 94),
	GreenDim     = Color3.fromRGB(10,  30,  14),
	GreenBorder  = Color3.fromRGB(20,  58,  26),
	Amber        = Color3.fromRGB(245, 158, 11),
	AmberDim     = Color3.fromRGB(40,  26,  5),
	Red          = Color3.fromRGB(239, 68,  68),
	RedSurface   = Color3.fromRGB(28,  10,  10),
	RedBorder    = Color3.fromRGB(60,  16,  16),
	TextPrimary  = Color3.fromRGB(224, 224, 240),
	TextMuted    = Color3.fromRGB(140, 140, 165),
	TextDim      = Color3.fromRGB(70,  70,  90),
	TextLabel    = Color3.fromRGB(45,  45,  65),
	White        = Color3.fromRGB(255, 255, 255),
	ScanLine     = Color3.fromRGB(99,  102, 241),
	Red         = Color3.fromRGB(239, 68,  68),
	RedDim      = Color3.fromRGB(28,  14,  14),
	Blue        = Color3.fromRGB(56,  139, 220),
	BlueDim     = Color3.fromRGB(12,  28,  50),
	TextPrimary = Color3.fromRGB(220, 220, 235),
	TextMuted   = Color3.fromRGB(140, 140, 165),
	TextDim     = Color3.fromRGB(70,  70,  90),
	TextLabel   = Color3.fromRGB(50,  50,  65),
	White       = Color3.fromRGB(255, 255, 255),
}

-- ─── HELPERS ───────────────────────────────────────────────────
local function corner(p, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = p
end

local function stroke(p, col, thick)
	local s = Instance.new("UIStroke")
	s.Color           = col or C.Border
	s.Thickness       = thick or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = p
	return s
end

local function frame(parent, col, size, pos, trans)
	local f = Instance.new("Frame")
	f.BackgroundColor3       = col or C.Panel
	f.BackgroundTransparency = trans or 0
	f.BorderSizePixel        = 0
	f.Size                   = size or UDim2.new(1,0,0,40)
	f.Position               = pos  or UDim2.new(0,0,0,0)
	f.Parent                 = parent
	return f
end

local function label(parent, text, size, col, font, xalign, lsize, lpos, wrap, rich)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.BorderSizePixel        = 0
	l.Text                   = text or ""
	l.TextSize               = size or 13
	l.TextColor3             = col  or C.TextMuted
	l.Font                   = font or Enum.Font.GothamMedium
	l.TextXAlignment         = xalign or Enum.TextXAlignment.Left
	l.TextYAlignment         = Enum.TextYAlignment.Center
	l.Size                   = lsize or UDim2.new(1,0,0,20)
	l.Position               = lpos  or UDim2.new(0,0,0,0)
	l.TextWrapped            = wrap  or false
	l.RichText               = rich  or false
	l.Parent                 = parent
	return l
end

local function btn(parent, text, bgcol, hov, txtcol, scol, sz, pos, rad)
	local b = Instance.new("TextButton")
	b.BackgroundColor3 = bgcol or C.Surface
	b.BorderSizePixel  = 0
	b.Size             = sz  or UDim2.new(0,120,0,36)
	b.Position         = pos or UDim2.new(0,0,0,0)
	b.Font             = Enum.Font.GothamBold
	b.Text             = text or ""
	b.TextColor3       = txtcol or C.TextPrimary
	b.TextSize         = 12
	b.AutoButtonColor  = false
	b.Parent           = parent
	corner(b, rad or 10)
	stroke(b, scol or C.Border, 1)
	local hovCol = hov or C.Surface2
	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = hovCol}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = bgcol or C.Surface}):Play()
	end)
	return b
end

local function divider(parent, ypos)
	return frame(parent, C.Border2, UDim2.new(1,-36,0,1), UDim2.new(0,18,0,ypos))
end

-- ─── ROOT GUI ──────────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "ZenHubV3"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent         = LocalPlayer:WaitForChild("PlayerGui")

local Main = frame(ScreenGui, C.BG,
	UDim2.new(0,500,0,340),
	UDim2.new(0.5,-250,0.5,-210))
Main.Active    = true
Main.Draggable = true
Main.ClipsDescendants = true
corner(Main, 12)
stroke(Main, C.Border, 1.5)

-- ─── TOPBAR ────────────────────────────────────────────────────
local Topbar = frame(Main, C.Panel, UDim2.new(1,0,0,48), UDim2.new(0,0,0,0))

corner(Topbar, 12)

local avatarBg = frame(Topbar, C.Accent, UDim2.new(0,32,0,32), UDim2.new(0,12,0.5,-16))
corner(avatarBg, 99)
label(avatarBg, "Z", 15, C.White, Enum.Font.GothamBold,
	Enum.TextXAlignment.Center, UDim2.new(1,0,1,0))

label(Topbar, "ZEN HUB", 14, C.White, Enum.Font.GothamBold, Enum.TextXAlignment.Left,
	UDim2.new(0,110,0,18), UDim2.new(0,52,0,6))
label(Topbar, "SCRIPT LOADER v2.0", 9, C.TextDim, Enum.Font.GothamMedium, Enum.TextXAlignment.Left,
	UDim2.new(0,130,0,14), UDim2.new(0,52,0,26))

local onlinePill = frame(Topbar, C.GreenDim, UDim2.new(0,84,0,24), UDim2.new(1,-130,0.5,-12))
corner(onlinePill, 99)
stroke(onlinePill, Color3.fromRGB(20,50,30), 1)
local onlineDot = frame(onlinePill, C.Green, UDim2.new(0,7,0,7), UDim2.new(0,10,0.5,-3))
corner(onlineDot, 99)
label(onlinePill, "ONLINE", 10, C.Green, Enum.Font.GothamBold, Enum.TextXAlignment.Left,
	UDim2.new(1,-24,1,0), UDim2.new(0,24,0,0))

local closeBtn = Instance.new("TextButton")
closeBtn.BackgroundColor3 = C.RedDim
closeBtn.BorderSizePixel  = 0
closeBtn.Size             = UDim2.new(0,28,0,28)
closeBtn.Position         = UDim2.new(1,-40,0.5,-14)
closeBtn.Font             = Enum.Font.GothamBold
closeBtn.Text             = "✕"
closeBtn.TextColor3       = C.Red
closeBtn.TextSize         = 13
closeBtn.AutoButtonColor  = false
closeBtn.Parent           = Topbar
corner(closeBtn, 8)
stroke(closeBtn, Color3.fromRGB(60,20,20), 1)
closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(40,16,16) end)
closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = C.RedDim end)
closeBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ─── TAB BAR ───────────────────────────────────────────────────
divider(Main, 48)

local TabBar = frame(Main, C.BG, UDim2.new(1,0,0,38), UDim2.new(0,0,0,50), 1)

local tabs     = {}
local tabPages = {}
local activeTab = nil

local tabDefs = {
	{name="key",   text="KEY"},
	{name="games", text="GAMES"},
	{name="info",  text="INFO"},
}

local TAB_W = math.floor(500/3)
for i, td in ipairs(tabDefs) do
	local tb = Instance.new("TextButton")
	tb.BackgroundTransparency = 1
	tb.BorderSizePixel        = 0
	tb.Size                   = UDim2.new(0,TAB_W,1,0)
	tb.Position               = UDim2.new(0, (i-1)*TAB_W, 0, 0)
	tb.Font                   = Enum.Font.GothamBold
	tb.Text                   = td.text
	tb.TextColor3             = C.TextDim
	tb.TextSize               = 12
	tb.AutoButtonColor        = false
	tb.Parent                 = TabBar

	local indicator = frame(tb, C.Accent, UDim2.new(0.6,0,0,2), UDim2.new(0.2,0,1,-2))
	indicator.Visible = false
	corner(indicator, 99)
	tabs[td.name] = {btn=tb, ind=indicator}
end

divider(Main, 89)

-- ─── PAGE CONTAINER ────────────────────────────────────────────
local PageContainer = frame(Main, C.BG,
	UDim2.new(1,0,1,-92), UDim2.new(0,0,0,92), 1)

local function makePage(name)
	local p = frame(PageContainer, C.BG, UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), 1)
	p.Visible = false
	tabPages[name] = p
	local scroll = Instance.new("ScrollingFrame")
	scroll.BackgroundTransparency = 1
	scroll.BorderSizePixel        = 0
	scroll.ScrollBarThickness     = 4
	scroll.ScrollBarImageColor3   = C.Accent
	scroll.CanvasSize             = UDim2.new(1,0,0,400)
	scroll.Size                   = UDim2.new(1,0,1,0)
	scroll.Position               = UDim2.new(0,0,0,0)
	scroll.ScrollingEnabled       = true
	scroll.Parent                 = p
	return scroll
end

local function switchTab(name)
	if activeTab then
		local old = tabs[activeTab]
		TweenService:Create(old.btn, TweenInfo.new(0.2), {TextColor3 = C.TextDim}):Play()
		old.ind.Visible = false
	end
	activeTab = name
	local cur = tabs[name]
	TweenService:Create(cur.btn, TweenInfo.new(0.2), {TextColor3 = C.Accent}):Play()
	cur.ind.Visible = true
	for n, pg in pairs(tabPages) do
		pg.Visible = (n == name)
	end
end

for _, td in ipairs(tabDefs) do
	local n = td.name
	tabs[n].btn.MouseButton1Click:Connect(function() switchTab(n) end)
end

-- ═══════════════════════════════════════════════════════════════
-- PAGE 1 — KEY SYSTEM
-- ═══════════════════════════════════════════════════════════════
local keyPage = makePage("key")

-- Use a container frame inside scroll for proper layout
local content = frame(keyPage, C.BG, UDim2.new(1,-8,0,380), UDim2.new(0,4,0,0), 1)

-- HWID Display with copy button
local hwidBg = frame(content, C.Surface, UDim2.new(1,-28,0,38), UDim2.new(0,14,0,8))
corner(hwidBg, 10)
stroke(hwidBg, C.Border2, 1)

label(hwidBg, "HWID", 10, C.TextDim, Enum.Font.GothamBold,
	Enum.TextXAlignment.Left, UDim2.new(0,50,0,18), UDim2.new(0,12,0,10))

local hwidText = getHWID()
local displayHWID = hwidText:sub(1, 32) .. (hwidText:len() > 32 and "..." or "")
local hwidValue = label(hwidBg, displayHWID, 11, C.TextMuted, Enum.Font.Code,
	Enum.TextXAlignment.Left, UDim2.new(1,-140,0,18), UDim2.new(0,60,0,10))

-- Copy HWID button
local copyHwidBtn = btn(hwidBg, "COPY",
	C.AccentDim, C.Accent, C.Accent, C.Border,
	UDim2.new(0,60,0,26), UDim2.new(1,-70,0.5,-13), 6)
copyHwidBtn.Font = Enum.Font.GothamBold
copyHwidBtn.TextSize = 10
copyHwidBtn.MouseButton1Click:Connect(function()
	pcall(setclipboard, hwidText)
	setStatus("HWID copied!", C.Green, C.Green)
end)

-- Key input with PASTE button
local inputBg = frame(content, C.Surface, UDim2.new(1,-28,0,48), UDim2.new(0,14,0,54))
corner(inputBg, 10)
stroke(inputBg, C.Border2, 1)

label(inputBg, "🔑", 14, C.TextMuted, Enum.Font.Gotham,
	Enum.TextXAlignment.Left, UDim2.new(0,26,1,0), UDim2.new(0,12,0,0))

local keyInput = Instance.new("TextBox")
keyInput.BackgroundTransparency = 1
keyInput.BorderSizePixel        = 0
keyInput.ClearTextOnFocus       = false
keyInput.Size                   = UDim2.new(1,-100,1,0)
keyInput.Position               = UDim2.new(0,36,0,0)
keyInput.Font                   = Enum.Font.Code
keyInput.PlaceholderColor3      = C.TextDim
keyInput.PlaceholderText        = "Paste your zen key here..."
keyInput.Text                   = ""
keyInput.TextColor3             = C.TextPrimary
keyInput.TextSize               = 12
keyInput.TextXAlignment         = Enum.TextXAlignment.Left
keyInput.Parent                 = inputBg

-- Paste button
local pasteBtn = btn(inputBg, "PASTE",
	C.AccentDim, C.Accent, C.Accent, C.Border,
	UDim2.new(0,52,0,28), UDim2.new(1,-60,0.5,-14), 6)
pasteBtn.Font = Enum.Font.GothamBold
pasteBtn.TextSize = 10
pasteBtn.MouseButton1Click:Connect(function()
	local clip = pcall(getclipboard) and getclipboard() or ""
	keyInput.Text = clip or ""
end)

-- Buttons row
local getKeyBtn = btn(content,
	"GET KEY",
	C.Surface, C.Surface2, C.TextMuted, C.Border,
	UDim2.new(0,223,0,36), UDim2.new(0,14,0,110), 8)
getKeyBtn.Font = Enum.Font.GothamBold

local validateBtn = btn(content,
	"VALIDATE",
	C.Accent, C.AccentHover, C.White, C.Accent,
	UDim2.new(0,223,0,36), UDim2.new(0,249,0,110), 8)
validateBtn.Font = Enum.Font.GothamBold

-- Status bar
local statusBg = frame(content, C.Surface, UDim2.new(1,-28,0,32), UDim2.new(0,14,0,200))
corner(statusBg, 8)
stroke(statusBg, C.Border2, 1)

local statusDot = frame(statusBg, C.Amber, UDim2.new(0,6,0,6), UDim2.new(0,10,0.5,-3))
corner(statusDot, 99)

local statusLabel = label(statusBg,
	"SYS :: Waiting for input...", 11, C.TextDim, Enum.Font.GothamMedium,
	Enum.TextXAlignment.Left, UDim2.new(1,-26,1,0), UDim2.new(0,22,0,0))

-- Footer
local discordBtn = btn(content,
	"discord.gg/zen-hub",
	C.Surface, C.Surface2, C.TextDim, C.Border,
	UDim2.new(0,150,0,26), UDim2.new(0,14,0,244), 6)
discordBtn.Font = Enum.Font.GothamMedium
discordBtn.TextSize = 10

label(content, "© 2022 2024 PELICAN DEV", 10, C.TextDim,
	Enum.Font.Gotham, Enum.TextXAlignment.Right,
	UDim2.new(0,180,0,26), UDim2.new(1,-194,0,244))

-- ─── STATUS HELPER ─────────────────────────────────────────────
local function setStatus(text, col, dotCol)
	statusLabel.Text               = text
	statusLabel.TextColor3         = col    or C.TextMuted
	statusDot.BackgroundColor3     = dotCol or C.Amber
end

-- ─── LOADING OVERLAY ───────────────────────────────────────────
-- Shown while validating so the user gets clear feedback
local function setLoading(active)
	validateBtn.Active = not active
	getKeyBtn.Active   = not active
	validateBtn.TextColor3 = active and C.TextDim or C.White
end

-- ─── AUTO-LOGIN (saved key) ─────────────────────────────────────
task.spawn(function()
	if isfile("zenkey14.txt") then
		local savedKey = readfile("zenkey14.txt")
		setStatus("Checking saved key...", C.Amber, C.Amber)
		setLoading(true)
		local valid, msg = ValidateKey(savedKey)
		setLoading(false)
		if valid then
			setStatus("✓  Auto-login successful!", C.Green, C.Green)
			keyInput.Text = savedKey
			notify("Zen Hub", "Auto-login successful!")
			task.wait(1)
			ScreenGui:Destroy()
			scriptLoad()
		else
			setStatus("Saved key invalid: " .. msg, C.Red, C.Red)
			task.delay(3, function()
				setStatus("Enter a new key below.", C.TextMuted, C.Amber)
			end)
		end
	else
		setStatus("No saved key — paste your key above", C.TextMuted, C.Amber)
	end
end)

-- ─── BUTTON EVENTS ─────────────────────────────────────────────
getKeyBtn.MouseButton1Click:Connect(function()
	local url = GetKeyURL()
	pcall(setclipboard, url)        -- copy HWID-linked key URL
	keyInput.Text = url
	setStatus("⬡  Key link copied — open in browser", C.Accent, C.Accent)
	task.delay(3, function()
		setStatus("Waiting for input...", C.TextMuted, C.Amber)
	end)
end)

validateBtn.MouseButton1Click:Connect(function()
	local key = keyInput.Text:match("^%s*(.-)%s*$")
	if key == "" then
		setStatus("⚠  No key entered.", C.Red, C.Red)
		task.delay(2, function() setStatus("Waiting for input...", C.TextMuted, C.Amber) end)
		return
	end

	setStatus("Validating key...", C.Amber, C.Amber)
	setLoading(true)

	task.spawn(function()
		local valid, msg = ValidateKey(key)
		setLoading(false)

		if valid then
			writefile("zenkey14.txt", key)         -- persist key
			setStatus("✓  Key valid — loading Zen Hub...", C.Green, C.Green)
			notify("Zen Hub", "Authenticated successfully!")
			task.wait(1)
			ScreenGui:Destroy()
			scriptLoad()
		else
			setStatus("✗  " .. msg, C.Red, C.Red)
			task.delay(3, function()
				setStatus("Waiting for input...", C.TextMuted, C.Amber)
			end)
		end
	end)
end)

discordBtn.MouseButton1Click:Connect(function()
	pcall(setclipboard, "https://discord.gg/zen-hub")
	setStatus("Discord link copied!", C.Green, C.Green)
	task.delay(2.5, function() setStatus("Waiting for input...", C.TextMuted, C.Amber) end)
end)

-- ═══════════════════════════════════════════════════════════════
-- PAGE 2 — SUPPORTED GAMES
-- ═══════════════════════════════════════════════════════════════
local gamesPage = makePage("games")

-- Use container frame - bigger for 3x2 grid
local gamesContent = frame(gamesPage, C.BG, UDim2.new(1,-8,0,320), UDim2.new(0,4,0,0), 1)

-- Game cards 3-column bigger layout (like screenshot)
local gamesData = {
	{name="Blox Fruits",  icon="🍇", grad={Color3.fromRGB(45,25,80), Color3.fromRGB(65,35,120)}},
	{name="Blade Ball",   icon="⚽", grad={Color3.fromRGB(25,35,70), Color3.fromRGB(40,55,110)}},
	{name="King Legacy",  icon="👑", grad={Color3.fromRGB(20,45,80), Color3.fromRGB(35,70,130)}},
	{name="Sail Piece",   icon="⛵", grad={Color3.fromRGB(25,50,90), Color3.fromRGB(45,80,140)}},
	{name="Spelling Bees",icon="🐝", grad={Color3.fromRGB(45,40,20), Color3.fromRGB(75,65,35)}},
	{name="Pet Simulator",icon="🐾", grad={Color3.fromRGB(60,30,30), Color3.fromRGB(90,45,45)}},
}
local CARD_W = math.floor((492 - 24 - 16) / 3)
local CARD_H = 130
local GRID_Y = 8
local GAP = 8

for i, g in ipairs(gamesData) do
	local col = (i-1) % 3
	local row = math.floor((i-1)/3)
	local xPos = 12 + col*(CARD_W+GAP)
	local yPos = GRID_Y + row*(CARD_H+GAP)

	local card = frame(gamesContent, C.Surface,
		UDim2.new(0,CARD_W,0,CARD_H), UDim2.new(0,xPos,0,yPos))
	corner(card, 12)
	stroke(card, C.Border2, 1)

	-- Gradient top section with icon (bigger)
	local topH = 82
	local topSec = frame(card, g.grad[1], UDim2.new(1,0,0,topH), UDim2.new(0,0,0,0))
	corner(topSec, 12)

	-- Icon centered in top
	label(topSec, g.icon, 32, C.White, Enum.Font.GothamBold,
		Enum.TextXAlignment.Center, UDim2.new(1,0,0,36), UDim2.new(0,0,0,(topH-36)/2))

	-- Game name
	label(card, g.name, 11, C.TextPrimary, Enum.Font.GothamBold,
		Enum.TextXAlignment.Center, UDim2.new(1,-16,0,18), UDim2.new(0,8,0,topH+2))

	-- Join button (full width like screenshot)
	local joinBtn = btn(card, "► JOIN",
		C.AccentDim, C.Accent, C.Accent, C.Border,
		UDim2.new(1,-16,0,24), UDim2.new(0,8,0,topH+22), 6)
	joinBtn.Font = Enum.Font.GothamBold
	joinBtn.TextSize = 10

	joinBtn.MouseEnter:Connect(function()
		joinBtn.BackgroundColor3 = C.Accent
		joinBtn.TextColor3 = C.White
	end)
	joinBtn.MouseLeave:Connect(function()
		joinBtn.BackgroundColor3 = C.AccentDim
		joinBtn.TextColor3 = C.Accent
	end)
	joinBtn.MouseButton1Click:Connect(function()
		notify("Zen Hub", "Joining " .. g.name .. "...")
	end)
end

-- ═══════════════════════════════════════════════════════════════
-- PAGE 3 — INFO
-- ═══════════════════════════════════════════════════════════════
local infoPage = makePage("info")

-- Use container frame
local infoContent = frame(infoPage, C.BG, UDim2.new(1,-8,0,250), UDim2.new(0,4,0,0), 1)

-- Hero with version
local iHero = frame(infoContent, C.Surface, UDim2.new(1,-28,0,50), UDim2.new(0,14,0,10))
corner(iHero, 12)
stroke(iHero, C.Border2, 1)
label(iHero, "ZEN HUB", 14, C.Accent, Enum.Font.GothamBold,
	Enum.TextXAlignment.Left, UDim2.new(0,100,0,18), UDim2.new(0,12,0,6))
label(iHero, "v3.0  •  PELICAN DEV", 9, C.TextDim, Enum.Font.GothamMedium,
	Enum.TextXAlignment.Left, UDim2.new(0,140,0,14), UDim2.new(0,12,0,26))

-- Executors section - fixed spacing
local execBg = frame(infoContent, C.Surface, UDim2.new(1,-28,0,86), UDim2.new(0,14,0,68))
corner(execBg, 12)
stroke(execBg, C.Border2, 1)
label(execBg, "SUPPORTED EXECUTORS", 9, C.TextDim, Enum.Font.GothamBold,
	Enum.TextXAlignment.Left, UDim2.new(1,-20,0,14), UDim2.new(0,12,0,10))

local execs = {"Synapse X","KRNL","Script-Ware","Fluxus","Electron","Delta"}
local exCols = 3
local exW = math.floor((456 - 28 - (exCols-1)*8) / exCols)
for i, ex in ipairs(execs) do
	local col = (i-1) % exCols
	local row = math.floor((i-1)/exCols)
	local xPos = 12 + col*(exW+8)
	local yPos = 30 + row*28
	local chip = frame(execBg, C.Surface2, UDim2.new(0,exW,0,26), UDim2.new(0,xPos,0,yPos))
	corner(chip, 8)
	stroke(chip, C.Border, 1)
	label(chip, ex, 10, C.TextMuted, Enum.Font.GothamMedium,
		Enum.TextXAlignment.Center, UDim2.new(1,0,1,0))
end

-- Details section
local detailBg = frame(infoContent, C.Surface, UDim2.new(1,-28,0,96), UDim2.new(0,14,0,148))
corner(detailBg, 12)
stroke(detailBg, C.Border2, 1)
label(detailBg, "INFO", 9, C.TextDim, Enum.Font.GothamBold,
	Enum.TextXAlignment.Left, UDim2.new(1,-20,0,14), UDim2.new(0,12,0,8))

local rows = {
	{k="Key Provider", v="Panda Development"},
	{k="Duration",   v="24 Hours"},
	{k="Checkpoint", v="1"},
	{k="Auto Save",  v="Enabled"},
}
for i, r in ipairs(rows) do
	local ry = 26 + (i-1)*18
	label(detailBg, r.k, 10, C.TextDim, Enum.Font.GothamMedium,
		Enum.TextXAlignment.Left, UDim2.new(0.5,0,0,16), UDim2.new(0,12,0,ry))
	label(detailBg, r.v, 10, C.TextPrimary, Enum.Font.GothamBold,
		Enum.TextXAlignment.Right, UDim2.new(0.5,-12,0,16), UDim2.new(0.5,0,0,ry))
	if i < #rows then
		frame(detailBg, C.Border2, UDim2.new(1,-24,0,1), UDim2.new(0,12,0,ry+17))
	end
end

-- ─── STARTUP ───────────────────────────────────────────────────
switchTab("key")