--------------------------------------------------------------------------------------
local pairs = pairs;
local ipairs = ipairs;
-------------------------------------------------------------------------------------

local LocalPlayer = game:GetService('Players').LocalPlayer
local TextService = game:GetService('TextService')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local HttpService = game:GetService('HttpService')

local Core = game:GetService("CoreGui")
local Plrs = game:GetService("Players")
local Lplr = Plrs.LocalPlayer
local UIS = game:GetService("UserInputService")
local TWS = game:GetService("TweenService")
local Run = game:GetService("RunService")
local Mouse = Lplr:GetMouse()
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local HTTP = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local SGui = game:GetService("StarterGui")

local function GetChar()
	return Lplr.Character or Lplr.CharacterAdded:Wait()
end

local function GetHum()
	return GetChar():FindFirstChild("Humanoid")
end

local function GetRoot()
	return GetChar():FindFirstChild("HumanoidRootPart")
end

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function AdvancedNotify(title, text, duration)
	duration = duration or 4

	local gui = Instance.new("ScreenGui")
	gui.Name = "AdvancedNotification"
	gui.ResetOnSpawn = false
	gui.Parent = player:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 320, 0, 90)
	frame.Position = UDim2.new(0.5, -160, 1, 120) -- start below screen (centered)
	frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	frame.Parent = gui

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = 1.5
	stroke.Color = Color3.fromRGB(60, 60, 60)

	local logo = Instance.new("ImageLabel")
	logo.Size = UDim2.new(0, 60, 0, 60)
	logo.Position = UDim2.new(0, 15, 0.5, -30)
	logo.BackgroundTransparency = 1
	logo.Image = "rbxassetid://116422175458617"
	logo.Parent = frame

	local logoCorner = Instance.new("UICorner", logo)
	logoCorner.CornerRadius = UDim.new(1, 0)

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -95, 0, 30)
	titleLabel.Position = UDim2.new(0, 85, 0, 15)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 18
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = frame

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -95, 0, 40)
	textLabel.Position = UDim2.new(0, 85, 0, 40)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = text
	textLabel.TextWrapped = true
	textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	textLabel.TextSize = 14
	textLabel.Font = Enum.Font.Gotham
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = frame

	local tweenIn = TweenService:Create(
		frame,
		TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{Position = UDim2.new(0.5, -160, 1, -140)} -- center lower position
	)

	tweenIn:Play()

	task.delay(duration, function()
		local tweenOut = TweenService:Create(
			frame,
			TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{Position = UDim2.new(0.5, -160, 1, 120)}
		)

		tweenOut:Play()
		tweenOut.Completed:Wait()
		gui:Destroy()
	end)
end

local CoreGui = game:GetService("CoreGui")
for _, v in pairs(CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and (v.Name == "ZenUiCore" or v.Name == "ZenUiCore2") then
        v:Destroy()
    end
end

--------------------------------------------------------------------------------------
local UIConfig = {
	Bind = Enum.KeyCode.RightControl
}

local UserInputService = game:GetService("UserInputService")

local Alc = {
	Config = {
		['MainColor'] = Color3.fromRGB(127, 255, 212),
		['DropColor'] = Color3.fromRGB(121,111,121),
		['UI Size'] = UDim2.new(0.000009, 530, 0.01, 350)
	},
	CoreGui = game:FindFirstChild('CoreGui') or game.Players.LocalPlayer.PlayerGui,
	Windows = {},
}

local function getMainZenFrame()
	local gui = Alc.CoreGui and Alc.CoreGui:FindFirstChild("ZenUiCore")
	if not gui then
		return nil
	end

	for _, child in ipairs(gui:GetChildren()) do
		if child:IsA("Frame") then
			return child
		end
	end

	return nil
end

function Alc:SetTheme(mainColor, dropColor)
	if mainColor then
		self.Config.MainColor = mainColor
	end
	if dropColor then
		self.Config.DropColor = dropColor
	end

	local gui = self.CoreGui and self.CoreGui:FindFirstChild("ZenUiCore")
	if not gui then
		return
	end

	for _, grad in ipairs(gui:GetDescendants()) do
		if grad:IsA("UIGradient") then
			grad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, self.Config.MainColor),
				ColorSequenceKeypoint.new(1.00, self.Config.DropColor)
			})
		end
	end
end

function Alc:SetUISize(size)
	if typeof(size) ~= "UDim2" then
		return
	end

	self.Config["UI Size"] = size

	local frame = getMainZenFrame()
	if not frame then
		return
	end

	-- direct set (cheaper than tweening every slider step)
	frame.Size = size
end

function Alc:SetUIOpacity(alpha)
	alpha = tonumber(alpha) or 1
	alpha = math.clamp(alpha, 0, 1)

	local gui = self.CoreGui and self.CoreGui:FindFirstChild("ZenUiCore")
	if not gui then
		return
	end

	local transparency = 1 - alpha

	for _, inst in ipairs(gui:GetDescendants()) do
		if inst:IsA("Frame") or inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
			if inst:IsA("Frame") or inst:IsA("TextLabel") or inst:IsA("TextButton") then
				if inst.BackgroundTransparency ~= 1 then
					inst.BackgroundTransparency = transparency
				end
			end
			if (inst:IsA("TextLabel") or inst:IsA("TextButton")) and inst.TextTransparency ~= 1 then
				inst.TextTransparency = transparency
			end
			if (inst:IsA("ImageLabel") or inst:IsA("ImageButton")) and inst.ImageTransparency ~= 1 then
				inst.ImageTransparency = transparency
			end
		end
	end
end


local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end);

local function cretate_button(asd)
	local button=Instance.new('TextButton')
	button.Size=UDim2.new(1,0,1,0)
	button.BackgroundTransparency=1
	button.TextTransparency=1
	button.Text=""
	button.Parent=asd
	button.ZIndex=5000
	return button
end

function Alc:GetTextSize(TextLabel)
	return TextService:GetTextSize(TextLabel.Text,TextLabel.TextSize,TextLabel.Font,Vector2.new(math.huge,math.huge))
end

--[[function Alc:GetId(Original)
	if Original:find('rbxassetid://') or Original:find('=') then
		return Original
	end

	if Alc['Icons']['icons'][Original] then
		return Alc['Icons']['icons'][Original]
	end

	return "rbxassetid://"..Original
end]]

local function scrolling_connectY(scrollframe)
    task.spawn(function()
        local address = 1 -- Padding or additional space to add
        local UIListLayout = scrollframe:WaitForChild('UIListLayout', 9999999)
        
        scrollframe.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + address)
        
        UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            scrollframe.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + address)
        end)
    end)
end

local function scrolling_connectX(scrollframe)
    task.spawn(function()
        local address = 1 -- Padding or additional space to add
        local UIListLayout = scrollframe:WaitForChild('UIListLayout', 9999999)
        
        scrollframe.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + address, 0, 0)
        
        UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            scrollframe.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + address, 0, 0)
        end)
    end)
end

function Alc:NewWindow(WindowDescription,WindowLogo)
	WindowName = WindowName or "...";
	WindowDescription = WindowDescription or "..."
	WindowLogo = WindowLogo or '0'

	local WindowAlc = {
		Toggle = Enum.KeyCode.LeftControl,
		Tabs = {},
		TabSelect = 1
	}

	local Main = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local DropShadow = Instance.new("ImageLabel")
	local Topbar = Instance.new("Frame")
	local HubLogo = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local TextTitle = Instance.new("TextLabel")
	local TextDescription = Instance.new("TextLabel")
	local UIGradient = Instance.new("UIGradient")
	local UIGradient1 = Instance.new("UIGradient")
	local MenuFrames = Instance.new("Frame")
	local MenuScroll = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local CloseUI = Instance.new("Frame")
	local HubLogo_2 = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local UICorner_4 = Instance.new("UICorner")
	local Frame1 = Instance.new("Frame")
	local UICorner8 = Instance.new("UICorner")

	Main.Name = "ZenUiCore"
	Main.Parent = Alc.CoreGui
	Main.ResetOnSpawn = false
	Main.IgnoreGuiInset = true
	Main.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
	Frame.Parent = Main
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Frame.BackgroundTransparency = 0
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.fromScale(0,0)
	Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
	Frame.ClipsDescendants = true

	TweenService:Create(Frame,TweenInfo.new(1.5),{Size = Alc.Config["UI Size"]}):Play()

    
local Image = Instance.new("ImageLabel")
Image.Name = "FrameImage"
Image.Parent = Frame
Image.AnchorPoint = Vector2.new(0.5, 0.5)
Image.Position = UDim2.new(0.5, 0, 0.5, 0) -- center of Frame
Image.Size = UDim2.fromScale(0.5, 0.5) -- 50% of Frame size
Image.BackgroundTransparency = 1
Image.Image = "rbxassetid://116422175458617"
Image.SizeConstraint = Enum.SizeConstraint.RelativeYY


	UICorner.Parent = Frame

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Frame
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	DropShadow.Rotation = 0.01

	Topbar.Name = "Topbar"
	Topbar.Parent = Frame
	Topbar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	Topbar.BackgroundTransparency = 1.000
	Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Topbar.BorderSizePixel = 0
	Topbar.Size = UDim2.new(1, 0, 0.09, 0)
	Topbar.ZIndex = 0

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 034)
	TopBarCorner.Parent = Topbar

    local LowerBar = Instance.new("Frame")

    LowerBar.Name = "LowerBar"
    LowerBar.Parent = Frame
    LowerBar.AnchorPoint = Vector2.new(0.5, 0.5)
    LowerBar.Position = UDim2.new(0.5, 0, 0.960, 0)
    LowerBar.Size = UDim2.new(1.02, 0, 0.138, 0)
    LowerBar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
    LowerBar.BorderSizePixel = 0
    LowerBar.ZIndex = 1

    local LowerBarCorner = Instance.new("UICorner")
    LowerBarCorner.CornerRadius = UDim.new(0, 034)
	LowerBarCorner.Parent = LowerBar

    	local stroke44 = Instance.new("UIStroke", LowerBar)
	stroke44.Thickness = 1.5
	stroke44.Color = Color3.fromRGB(60, 60, 60)



local LowerLogo = Instance.new("ImageLabel")
local LowerUICorner_2 = Instance.new("UICorner")

LowerLogo.Name = "LowerLogo"
LowerLogo.Parent = LowerBar
LowerLogo.AnchorPoint = Vector2.new(0.5, 0.5)
LowerLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LowerLogo.BackgroundTransparency = 1
LowerLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
LowerLogo.BorderSizePixel = 0
LowerLogo.Position = UDim2.new(0.06, 0, 0.4, 0)
LowerLogo.Size = UDim2.new(0, 25, 0, 25)
LowerLogo.ZIndex = 3

local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local imageUrl, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

LowerLogo.Image = imageUrl

LowerUICorner_2.Parent = LowerLogo

local LowerTextTitle = Instance.new("TextLabel")

LowerTextTitle.Name = "LowerTextTitle"
LowerTextTitle.Parent = LowerBar
LowerTextTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LowerTextTitle.BackgroundTransparency = 1
LowerTextTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
LowerTextTitle.BorderSizePixel = 0
LowerTextTitle.Position = UDim2.new(0.103, 0, 0.08, 0)
LowerTextTitle.Size = UDim2.new(0.896, 0, 0.434, 0)
LowerTextTitle.ZIndex = 3
LowerTextTitle.Font = Enum.Font.GothamBold

LowerTextTitle.Text = player.DisplayName

LowerTextTitle.RichText = true
LowerTextTitle.RichText = true
LowerTextTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LowerTextTitle.TextScaled = false
LowerTextTitle.TextSize = 11
LowerTextTitle.TextWrapped = true
LowerTextTitle.TextXAlignment = Enum.TextXAlignment.Left


local LowerTextDescription = Instance.new("TextLabel")

LowerTextDescription.Name = "LowerTextDescription"
LowerTextDescription.Parent = LowerBar
LowerTextDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LowerTextDescription.BackgroundTransparency = 1
LowerTextDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
LowerTextDescription.BorderSizePixel = 0
LowerTextDescription.Position = UDim2.new(0.103, 0, 0.4, 0)
LowerTextDescription.Size = UDim2.new(0, 120, 0.3, 0)
LowerTextDescription.ZIndex = 3
LowerTextDescription.Font = Enum.Font.Gotham
LowerTextDescription.Text = "Executor : "..identifyexecutor()
LowerTextDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
LowerTextDescription.TextTransparency = 0.5
LowerTextDescription.TextScaled = false
LowerTextDescription.TextSize = 9
LowerTextDescription.TextWrapped = true
LowerTextDescription.TextXAlignment = Enum.TextXAlignment.Left

local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")


local RightStats = Instance.new("Frame")
local RightCorner = Instance.new("UICorner")

RightStats.Name = "RightStats"
RightStats.Parent = LowerBar
RightStats.AnchorPoint = Vector2.new(1, 0.5)
RightStats.Position = UDim2.new(0.87, 0, 0.66, 0)
RightStats.Size = UDim2.new(0.45, 0, 0.75, 0)
RightStats.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
RightStats.BackgroundTransparency = 1
RightStats.BorderSizePixel = 0

RightCorner.CornerRadius = UDim.new(0, 16)
RightCorner.Parent = RightStats


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")


local TextContainer = Instance.new("Frame")
TextContainer.Parent = RightStats
TextContainer.BackgroundTransparency = 1
TextContainer.Size = UDim2.new(0.95, 0, 1, 0)
TextContainer.Position = UDim2.new(0.030, 0, 0, 0)


local PingLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local TimeLabel = Instance.new("TextLabel")

local topLabels = {PingLabel, FPSLabel, TimeLabel}
local topColors = {
	Color3.fromRGB(255,85,85),
	Color3.fromRGB(85,255,85),
	Color3.fromRGB(85,170,255)
}

for i, lbl in ipairs(topLabels) do
	lbl.Parent = TextContainer
	lbl.BackgroundTransparency = 1
	lbl.Size = UDim2.new(0.3, 0, 0.25, 0)
	lbl.Position = UDim2.new((i-1)*0.33, 0, 0, 0)
	lbl.Font = Enum.Font.GothamBold
	lbl.TextColor3 = topColors[i]
	lbl.TextTransparency = 0.2
    lbl.TextSize = 10
	lbl.TextScaled = true
	lbl.TextXAlignment = Enum.TextXAlignment.Left
end


local StatsButton = Instance.new("ImageButton")
StatsButton.Parent = LowerBar
StatsButton.Size = UDim2.new(0.04, 0, 0.4, 0)
StatsButton.Position = UDim2.new(0.93, 0, 0.4, 0)
StatsButton.AnchorPoint = Vector2.new(0.5, 0.5)
StatsButton.BackgroundTransparency = 1
StatsButton.Image = "rbxassetid://81116723474925"

StatsButton.MouseButton1Click:Connect(function()
AdvancedNotify("Zen Hub", "Link copied successfully! Paste it into your browser.", 5)
end)

    Frame1.Parent = Frame
Frame1.AnchorPoint = Vector2.new(0.5, 0)       -- top-center
Frame1.Position = UDim2.new(0.5, 0, 0, 43)     -- X=center, Y=10px from top
Frame1.Size = UDim2.new(0.95, 0, 0, 001)         -- width relative, height absolute
    Frame1.BackgroundColor3 = Color3.fromRGB(127, 255, 212)
	Frame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame1.BorderSizePixel = 0
	Frame1.BackgroundTransparency = 0.5
    Frame1.ZIndex = 5
	local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), 
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(221, 160, 221)), 
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) 
})
uiGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.5), 
    NumberSequenceKeypoint.new(0.6, 0),
    NumberSequenceKeypoint.new(1, 0.5) 
})
uiGradient.Parent = Frame1

UICorner8.CornerRadius = UDim.new(0, 034)
		UICorner8.Parent = Frame1


HubLogo.Name = "HubLogo"
HubLogo.Parent = Topbar
HubLogo.AnchorPoint = Vector2.new(0.5, 0.5)
HubLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
HubLogo.BackgroundTransparency = 1
HubLogo.BorderSizePixel = 0
HubLogo.Position = UDim2.new(0.045, 0, 0.6, 0)
HubLogo.Size = UDim2.new(0.9, 0, 0.9, 0)
HubLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
HubLogo.ZIndex = 3
HubLogo.Image = WindowLogo

local function FullRotation()
    while true do
        local tween1 = TweenService:Create(HubLogo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 160})
        tween1:Play()
        tween1.Completed:Wait()
        task.wait(0.2)

        local tween2 = TweenService:Create(HubLogo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 360})
        tween2:Play()
        tween2.Completed:Wait()
        task.wait(0.2)

        HubLogo.Rotation = 0
        task.wait(0.1)
    end
end

task.spawn(FullRotation)

	UICorner_2.Parent = HubLogo

	TextTitle.Name = "TextTitle"
	TextTitle.Parent = Topbar
	TextTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextTitle.BackgroundTransparency = 1.000
	TextTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextTitle.BorderSizePixel = 0
	TextTitle.Position = UDim2.new(0.103366353, 0, 0.2099998972, 0)
	TextTitle.Size = UDim2.new(0.896555603, 0, 0.433997005, 0)
	TextTitle.ZIndex = 3
	TextTitle.Font = Enum.Font.GothamBold
	TextTitle.Text = "ZEN HUB" .. "<font color='rgb(127, 255, 212)'> ELITE </font>"
	TextTitle.RichText = true;
	TextTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextTitle.TextScaled = true
	TextTitle.TextSize = 14.000
	TextTitle.TextWrapped = true
	TextTitle.TextXAlignment = Enum.TextXAlignment.Left

	TextDescription.Name = "TextDescription"
	TextDescription.Parent = Topbar
	TextDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextDescription.BackgroundTransparency = 1.000
	TextDescription.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextDescription.BorderSizePixel = 0
	TextDescription.Position = UDim2.new(0.103366353, 0, 0.65399694, 0)
	TextDescription.Size = UDim2.new(0, 80, 0.300000012, 0)
	TextDescription.ZIndex = 3
	TextDescription.Font = Enum.Font.GothamBold
	TextDescription.Text = WindowDescription
	TextDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextDescription.TextScaled = false
	TextDescription.TextSize = 10.000
	TextDescription.TextWrapped = true
	TextDescription.TextXAlignment = Enum.TextXAlignment.Left

    local TWS = game:GetService("TweenService")

    -- Exit Button
local ExitButton = Instance.new("ImageButton")
ExitButton.Name = "Exit"
ExitButton.Parent = Topbar
ExitButton.AnchorPoint = Vector2.new(1, 0)
ExitButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.BackgroundTransparency = 1
ExitButton.BorderSizePixel = 0
ExitButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ExitButton.Position = UDim2.new(1, -8, 0, 10)
ExitButton.Size = UDim2.new(0, 26, 0, 26)
ExitButton.Image = [[rbxassetid://79737394637933]]

-- Minimize Button
local MinimizeButton = Instance.new("ImageButton")
MinimizeButton.Name = "Minimize"
MinimizeButton.Parent = Topbar
MinimizeButton.AnchorPoint = Vector2.new(1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.BorderSizePixel = 0
MinimizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
MinimizeButton.Position = UDim2.new(1, -33, 0, 10)
MinimizeButton.Size = UDim2.new(0, 26, 0, 26)
MinimizeButton.Image = [[rbxassetid://111463616734199]]

local TweenService = game:GetService("TweenService")

local normalSize = UDim2.new(0.000009, 530, 0.01, 350)
local Fullscreen = UDim2.new(0.1, 730, 0.1, 550)
local isMinimized = false

Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)

MinimizeButton.MouseButton1Click:Connect(function()
    local targetSize = isMinimized and normalSize or Fullscreen
    local targetY = isMinimized and 43 or 80  -- Y position for Frame1

    -- Tween the main frame size
    local tween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = targetSize})
    tween:Play()

    -- Update Frame1 position instantly (or you can tween it too)
    Frame1.Position = UDim2.new(0.5, 0, 0, targetY)

    isMinimized = not isMinimized
end)

	--[[UPDATE TEXT]]
	local function UpdateDescTextSize()
		local size = Alc:GetTextSize(TextDescription)
		TweenService:Create(TextDescription,TweenInfo.new(0.5),{Size = UDim2.new(0,size.X,0.3,0)}):Play()
	end

	UpdateDescTextSize()

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Alc.Config.MainColor), ColorSequenceKeypoint.new(1.00, Alc.Config.DropColor)}
	UIGradient.Parent = TextDescription

	MenuFrames.Name = "MenuFrames"
	MenuFrames.Parent = Frame
	MenuFrames.AnchorPoint = Vector2.new(0.5, 0)
	MenuFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MenuFrames.BackgroundTransparency = 1.000
	MenuFrames.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrames.BorderSizePixel = 0
	MenuFrames.Position = UDim2.new(0, 0, 0.0000003, 0)
	MenuFrames.Size = UDim2.new(0.949999988, 0, 0.0799999982, 0)
	MenuFrames.ZIndex = 2

	MenuScroll.Name = "MenuScroll"
	MenuScroll.Parent = MenuFrames
	MenuScroll.Active = true
	MenuScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MenuScroll.BackgroundTransparency = 1.000
	MenuScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuScroll.BorderSizePixel = 0
	MenuScroll.Size = UDim2.new(1, 0, 0, 0)
	MenuScroll.ZIndex = 0
	MenuScroll.CanvasSize = UDim2.new(2, 0, 0, 0)
	MenuScroll.ScrollBarThickness = 0
	MenuScroll.TopImage = ""

	scrolling_connectX((MenuScroll))

	UIListLayout.Parent = MenuScroll
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0,8)
	CloseUI.Name = "CloseUI"
	CloseUI.Parent = Frame
	CloseUI.AnchorPoint = Vector2.new(0.5, 0.5)
	CloseUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	CloseUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseUI.BorderSizePixel = 0
	CloseUI.Position = UDim2.new(0.5, 0, 0.5, 0)
	CloseUI.Visible = false
	CloseUI.ZIndex = 45
	CloseUI.Size = UDim2.fromScale(1,1)

	TweenService:Create(CloseUI,TweenInfo.new(2,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Size = UDim2.fromScale(0,0)}):Play()

	HubLogo_2.Name = "HubLogo"
	HubLogo_2.Parent = CloseUI
	HubLogo_2.AnchorPoint = Vector2.new(0.5, 0.5)
	HubLogo_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HubLogo_2.BackgroundTransparency = 1.000
	HubLogo_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HubLogo_2.BorderSizePixel = 0
	HubLogo_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	HubLogo_2.Size = UDim2.new(0.25, 0, 0.25, 0)
	HubLogo_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
	HubLogo_2.ZIndex = 55
	HubLogo_2.Image = WindowLogo

	UICorner_3.Parent = HubLogo_2

	UICorner_4.Parent = CloseUI

    local UIStroke = Instance.new("UIStroke")

	UIStroke.Color = Color3.fromRGB(37, 37, 37)
	UIStroke.Parent = CloseUI

	local dragToggle = nil
	local dragSpeed = 0.1
	local dragStart = nil
	local startPos = nil
	local valUI = true

	Frame:GetPropertyChangedSignal('Size'):Connect(function()
		if Frame.Size.X.Scale <= 0 then
			Frame.Visible = false
		else
			Frame.Visible = true
		end
	end)

	CloseUI:GetPropertyChangedSignal('Size'):Connect(function()
		if CloseUI.Size.X.Scale <= 0 then
			CloseUI.Visible = false
		else
			CloseUI.Visible = true
		end
	end)

	local function ToggleUI(val)
		if val then
			TweenService:Create(Frame,TweenInfo.new(0.5),{Size = Alc.Config["UI Size"]}):Play()
			TweenService:Create(CloseUI,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Size = UDim2.fromScale(0,0)}):Play()
		else
			TweenService:Create(Frame,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Size = UDim2.fromScale(0,0)}):Play()
			TweenService:Create(CloseUI,TweenInfo.new(0.5),{Size = UDim2.fromScale(1,1)}):Play()
		end
	end

		task.spawn(function()
			local Toggle = Instance.new("ScreenGui")
			local Frames = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local logo = Instance.new("ImageLabel")
			local DropShadow = Instance.new("ImageLabel")

			Toggle.Name = "ZenUiCore2"
			Toggle.Parent = Alc.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
			Toggle.ZIndexBehavior = Enum.ZIndexBehavior.Global

			Frames.Name = 'c4'
			Frames.Parent = Toggle
			Frames.AnchorPoint = Vector2.new(0.5, 0.5)
			Frames.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frames.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frames.BorderSizePixel = 0
			Frames.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
			Frames.Size = UDim2.new(0, 65, 0, 65)
			Frames.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Frames.ZIndex = 67

			UICorner.Parent = Frames

			UIStroke.Color = Color3.fromRGB(121, 121, 121)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Frames

			logo.Name = "logo"
			logo.Parent = Frames
			logo.AnchorPoint = Vector2.new(0.5, 0.5)
			logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			logo.BackgroundTransparency = 1.010
			logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
			logo.BorderSizePixel = 0
			logo.Position = UDim2.new(0.5, 0, 0.5, 0)
			logo.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
			logo.ZIndex = 68
			logo.Image = WindowLogo

			DropShadow.Name = "DropShadow"
			DropShadow.Parent = Frames
			DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			DropShadow.BackgroundTransparency = 1.000
			DropShadow.BorderSizePixel = 0
			DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropShadow.Size = UDim2.new(1, 47, 1, 47)
			DropShadow.ZIndex = 66
			DropShadow.Image = "rbxassetid://6015897843"
			DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			DropShadow.ImageTransparency = 0.500
			DropShadow.ScaleType = Enum.ScaleType.Slice
			DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

			local dragToggle = false
			local dragStart = nil
			local startPos = nil

			local old = Frames.Position
			local function dInput(input)
				local delta = input.Position - dragStart
				local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				game:GetService('TweenService'):Create(Frames, TweenInfo.new(dragSpeed), {Position = position}):Play()
			end

			local but = cretate_button(Frames)
			but.ZIndex = 68
			but.MouseButton1Click:Connect(function()
				if old == Frames.Position then
					valUI = not valUI
					ToggleUI(valUI)
				end
			end)
			but.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
					dragToggle = true
					dragStart = input.Position
					startPos = Frames.Position
					old = Frames.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false
						end
					end)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					if dragToggle then
						dInput(input)
					end
				end
			end)
		end)
	

	
	UIS.InputBegan:Connect(function(io, p)
		if io.KeyCode == UIConfig.Bind then
			if uitoggled == false then
				Frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 1, true)
				uitoggled = true;
				task.wait(.5)
				Main.Enabled = false
			else
				Frame:TweenSize(UDim2.new(0.100000001, 410, 0.100000001, 240), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 1, true)
				Main.Enabled = true;
				uitoggled = false
			end
		end
	end)

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(Frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
	end

	Topbar.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end)

	UserInputService.InputBegan:Connect(function(input,ty)
		if ty then
			return
		end

		if input.KeyCode == WindowAlc.Toggle then
			valUI = not valUI
			ToggleUI(valUI)
		end
	end)


ExitButton.MouseButton1Click:Connect(function()
    valUI = not valUI
    ToggleUI(valUI)
    wait(1)
    -- Only destroy Zen UI when toggling OFF
    if not valUI then
        for _, v in pairs(CoreGui:GetChildren()) do
            if v:IsA("ScreenGui") and (v.Name == "ZenUiCore" or v.Name == "ZenUiCore2") then
                v:Destroy()
            end
        end
    end
end)

	function WindowAlc:AddMenu(MenuName, MenuDescription, IconId, MenuType)
		MenuType = MenuType or 'tab'
		local MenuAlc = {
			Checker = {}
		}

		local MenuButton = Instance.new("Frame")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		local UICorner = Instance.new("UICorner")
		local MenuLogo = Instance.new("ImageLabel")
		local MenuText = Instance.new("TextLabel")
		local MenuDesc = Instance.new("TextLabel")
		local Button = Instance.new("TextButton")

		MenuButton.Name = "MenuButton"
		MenuButton.Parent = MenuScroll
		MenuButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MenuButton.BackgroundTransparency = 1.000
		MenuButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MenuButton.BorderSizePixel = 0
		MenuButton.ClipsDescendants = false
		MenuButton.Size = UDim2.new(0.5, 0, 0.75, 0)
		MenuButton.ZIndex = 4

		UIAspectRatioConstraint.Parent = MenuButton
		UIAspectRatioConstraint.AspectRatio = 0.1
		UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
		UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height

		TweenService:Create(UIAspectRatioConstraint,TweenInfo.new(0.3 + (#WindowAlc.Tabs / 10),Enum.EasingStyle.Back),{AspectRatio = 4.000}):Play()
		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = MenuButton

		MenuLogo.Name = "MenuLogo"
		MenuLogo.Parent = MenuButton
		MenuLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MenuLogo.BackgroundTransparency = 1.000
		MenuLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MenuLogo.BorderSizePixel = 0
		MenuLogo.Size = UDim2.new(1, 0, 1, 0)
		MenuLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
		MenuLogo.ZIndex = 5
		MenuLogo.Image = "MenuIcon"

		MenuText.Name = "MenuText"
		MenuText.Parent = MenuButton
		MenuText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MenuText.BackgroundTransparency = 1.000
		MenuText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MenuText.BorderSizePixel = 0
		MenuText.Position = UDim2.new(0.010877919, 0, 0.5, 0)
		MenuText.Size = UDim2.new(2.10955262, 0, 0.5, 0)
		MenuText.ZIndex = 5
		MenuText.Font = Enum.Font.GothamBold
		MenuText.Text = MenuName or "Menu"
		MenuText.TextColor3 = Color3.fromRGB(100, 100, 15)
		MenuText.TextTransparency = 0.8
		MenuText.TextScaled = true
		MenuText.TextSize = 14.000
		MenuText.TextWrapped = true
		MenuText.TextXAlignment = Enum.TextXAlignment.Left

		MenuDesc.Name = "MenuDesc"
		MenuDesc.Parent = MenuButton
		MenuDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MenuDesc.BackgroundTransparency = 1.000
		MenuDesc.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MenuDesc.BorderSizePixel = 0
		MenuDesc.Position = UDim2.new(0.11100589, 0, 0.600000083, 0)
		MenuDesc.Size = UDim2.new(2.10955262, 0, 0.349999547, 0)
		MenuDesc.ZIndex = 5
		MenuDesc.Font = Enum.Font.GothamBold
		MenuDesc.Text = MenuDescription or "Description"
		MenuDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
		MenuDesc.TextScaled = true
		MenuDesc.TextSize = 14.000
		MenuDesc.TextTransparency = 0.800
		MenuDesc.TextWrapped = true
		MenuDesc.TextXAlignment = Enum.TextXAlignment.Left

		Button.Name = "Button"
		Button.Parent = MenuButton
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1.000
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Size = UDim2.new(1, 0, 1, 0)
		Button.ZIndex = 25
		Button.Font = Enum.Font.SourceSans
		Button.Text = ""
		Button.TextColor3 = Color3.fromRGB(0, 0, 0)
		Button.TextSize = 14.000
		Button.TextTransparency = 1.000
		local MainFrame

		if MenuType:find('tab') then
			local PageFrames = Instance.new("Frame")
			local Search = Instance.new("Frame")
			local SearchEngine = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local LabelText = Instance.new("TextLabel")
			local SearchIcon = Instance.new("ImageLabel")
			local UICorner_2 = Instance.new("UICorner")
			local searchbox = Instance.new("TextBox")
			local Framet = Instance.new("Frame")
			local Frame_2 = Instance.new("Frame")
			local TabFrames = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Main = Instance.new("Frame")
			Main.Name = "Main"
			Main.Parent = PageFrames
			Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Main.BackgroundTransparency = 1.000
			Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Main.BorderSizePixel = 0
			Main.ClipsDescendants = true
			Main.Position = UDim2.new(0.27, 5, 0.02, 0)
			Main.Size = UDim2.new(0.73, -15, 0.96, 0)
			Main.ZIndex = 4



			PageFrames.Name = "PageFrames"
			PageFrames.Parent = Frame
			PageFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageFrames.BackgroundTransparency = 1.000
			PageFrames.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageFrames.BorderSizePixel = 0
			PageFrames.ClipsDescendants = true
			PageFrames.Position = UDim2.new(0, 0, 0, 0)
			PageFrames.Size = UDim2.new(1, 0, 0.886814642, 0)
			PageFrames.ZIndex = 4

			MainFrame = PageFrames
			Search.Name = "Search"
			Search.Parent = PageFrames
			Search.AnchorPoint = Vector2.new(0, 0.5)
			Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Search.BackgroundTransparency = 1.000
			Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Search.BorderSizePixel = 0
			Search.ClipsDescendants = true
			Search.Position = UDim2.new(0, 8, 0.44, 0)
			Search.Size = UDim2.new(0.24, 0, 0.85, 0)
			Search.Visible = true
			Search.ZIndex = 4

			SearchEngine.Name = "SearchEngine"
			SearchEngine.Parent = Search
			SearchEngine.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			SearchEngine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SearchEngine.BorderSizePixel = 0
			SearchEngine.ClipsDescendants = true
            SearchEngine.Visible = false
			SearchEngine.Size = UDim2.new(1, 0, 0.0680000037, 0)
			SearchEngine.ZIndex = 6

			UICorner.CornerRadius = UDim.new(0, 2)
			UICorner.Parent = SearchEngine

			UIStroke.Thickness = 0
			UIStroke.Color = Color3.fromRGB(39, 39, 39)
			UIStroke.Parent = SearchEngine

			LabelText.Name = "LabelText"
			LabelText.Parent = SearchEngine
			LabelText.AnchorPoint = Vector2.new(0.5, 0.5)
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LabelText.BorderSizePixel = 0
			LabelText.Position = UDim2.new(0.612374663, 0, 0.499999851, 0)
			LabelText.Size = UDim2.new(0.871346772, 0, 0.50000006, 0)
			LabelText.ZIndex = 6
			LabelText.Font = Enum.Font.GothamBold
			LabelText.Text = "Search"
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.TextScaled = true
			LabelText.TextSize = 14.000
			LabelText.TextTransparency = 0.750
			LabelText.TextWrapped = true
			LabelText.TextXAlignment = Enum.TextXAlignment.Left

			SearchIcon.Name = "SearchIcon"
			SearchIcon.Parent = SearchEngine
			SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
			SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SearchIcon.BackgroundTransparency = 1.000
			SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SearchIcon.BorderSizePixel = 0
			SearchIcon.Position = UDim2.new(0.075000003, 0, 0.5, 0)
			SearchIcon.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
			SearchIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
			SearchIcon.ZIndex = 6
			SearchIcon.Image = "rbxassetid://7734052925"
			SearchIcon.ImageTransparency = 0.750

			UICorner_2.CornerRadius = UDim.new(0, 6)
			UICorner_2.Parent = SearchIcon

			searchbox.Name = "searchbox"
			searchbox.Parent = SearchEngine
			searchbox.AnchorPoint = Vector2.new(0.5, 0.5)
			searchbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			searchbox.BackgroundTransparency = 1.000
			searchbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			searchbox.BorderSizePixel = 0
			searchbox.Position = UDim2.new(1.46321285, 0, 0.499999851, 0)
			searchbox.Size = UDim2.new(2.66615963, 0, 0.50000006, 0)
			searchbox.ZIndex = 7
			searchbox.ClearTextOnFocus = false
			searchbox.Font = Enum.Font.GothamBold
			searchbox.Text = ""
			searchbox.TextColor3 = Color3.fromRGB(255, 255, 255)
			searchbox.TextScaled = true
			searchbox.TextSize = 14.000
			searchbox.TextWrapped = true
			searchbox.TextXAlignment = Enum.TextXAlignment.Left

			Framet.Parent = Search
			Framet.Active = true
			Framet.AnchorPoint = Vector2.new(0, 0.5)
			Framet.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			Framet.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Framet.BorderSizePixel = 0
			Framet.Position = UDim2.new(1.01999998, 0, 0.5, 0)
			Framet.Rotation = 0
			Framet.Size = UDim2.new(0.00499999989, 0, 1, 0)
			Framet.ZIndex = 3

			Frame_2.Parent = Framet
			Frame_2.Active = true
			Frame_2.AnchorPoint = Vector2.new(0, 0.5)
			Frame_2.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(1.00999999, 0, 0.5, 0)
			Frame_2.Size = UDim2.new(1, 0, 1, 0)
			Frame_2.ZIndex = 3

			TabFrames.Name = "TabFrames"
			TabFrames.Parent = Search
			TabFrames.Active = true
			TabFrames.AnchorPoint = Vector2.new(0.5, 0.5)
			TabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabFrames.BackgroundTransparency = 1.000
			TabFrames.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TabFrames.BorderSizePixel = 0
			TabFrames.ClipsDescendants = false
			TabFrames.Position = UDim2.new(0.5, 0, 0.5, 0)
			TabFrames.Size = UDim2.new(1, -4, 1, -4)
			TabFrames.ZIndex = 1
			TabFrames.ScrollBarThickness = 0

            
			UIListLayout.Parent = TabFrames
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 4)

			Main.ZIndex = 6

			-- Settings Search Bar
			local SearchSettings = Instance.new("Frame")
			local SearchCorner = Instance.new("UICorner")
			local SearchStroke = Instance.new("UIStroke")
			local SearchIcon = Instance.new("ImageLabel")
			local SearchInput = Instance.new("TextBox")

			SearchSettings.Name = "SearchSettings"
			SearchSettings.Parent = Main
			SearchSettings.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
			SearchSettings.Position = UDim2.new(1, -5, 0, 5)
			SearchSettings.AnchorPoint = Vector2.new(1, 0)
			SearchSettings.Size = UDim2.new(1, -10, 0, 32)
			SearchSettings.ZIndex = 15

			SearchCorner.CornerRadius = UDim.new(0, 8)
			SearchCorner.Parent = SearchSettings

			SearchStroke.Color = Color3.fromRGB(212, 175, 55)
			SearchStroke.Thickness = 1
			SearchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			SearchStroke.Parent = SearchSettings

			SearchIcon.Name = "SearchIcon"
			SearchIcon.Parent = SearchSettings
			SearchIcon.BackgroundTransparency = 1
			SearchIcon.Position = UDim2.new(0, 10, 0.5, 0)
			SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
			SearchIcon.Size = UDim2.new(0, 16, 0, 16)
			SearchIcon.Image = "rbxassetid://6031154871"
			SearchIcon.ImageColor3 = Color3.fromRGB(212, 175, 55)
			SearchIcon.ZIndex = 16

			SearchInput.Name = "SearchInput"
			SearchInput.Parent = SearchSettings
			SearchInput.BackgroundTransparency = 1
			SearchInput.Position = UDim2.new(0, 34, 0, 0)
			SearchInput.Size = UDim2.new(1, -44, 1, 0)
			SearchInput.Font = Enum.Font.Gotham
			SearchInput.PlaceholderText = "Search settings..."
			SearchInput.Text = ""
			SearchInput.TextColor3 = Color3.fromRGB(235, 235, 245)
			SearchInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
			SearchInput.TextSize = 14
			SearchInput.TextXAlignment = Enum.TextXAlignment.Left
			SearchInput.ZIndex = 16

			local function GetElementText(element)
				local title = element:FindFirstChild("Title") or element:FindFirstChild("Text") or element:FindFirstChild("Label") or element:FindFirstChild("DropTitle") or element:FindFirstChild("DropTitle1")
				if title and title:IsA("TextLabel") then
					return title.Text
				end
				
				local topRow = element:FindFirstChild("TopRow")
				if topRow then
					local sliderLabel = topRow:FindFirstChild("LabelNameSlider")
					if sliderLabel and sliderLabel:IsA("TextLabel") then
						return sliderLabel.Text
					end
				end
				
				local buttonMain = element:FindFirstChild("ButtonMainFrame")
				if buttonMain then
					local buttonText = buttonMain:FindFirstChild("Text")
					if buttonText and buttonText:IsA("TextLabel") then
						return buttonText.Text
					end
				end

				if element:IsA("TextLabel") then
					return element.Text
				end

				return ""
			end

			local function FilterScrollContent(scrollFrame, query)
				if not scrollFrame then return end
				query = query:lower()
				for _, section in ipairs(scrollFrame:GetChildren()) do
					if section:IsA("Frame") and section.Name == "SectionFrame" then
						local sectionVisible = false
						local content = section:FindFirstChild("Content")
						
						local row = section:FindFirstChild("Row")
						local sectionTitle = row and row:FindFirstChild("Title") and row.Title.Text or ""
						local sectionTitleMatch = sectionTitle:lower():find(query) ~= nil

						if content then
							for _, element in ipairs(content:GetChildren()) do
								if element:IsA("Frame") or element:IsA("TextButton") then
									local text = GetElementText(element)
									if sectionTitleMatch or text:lower():find(query) then
										element.Visible = true
										sectionVisible = true
									else
										element.Visible = false
									end
								end
							end
						end
						section.Visible = sectionVisible or (query == "")
					end
				end
			end

			SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
				local query = SearchInput.Text
				local activeMenu = WindowAlc.Tabs[WindowAlc.TabSelect]
				if activeMenu and activeMenu[3] then
					local menuAlc = activeMenu[3]
					local activeTab = menuAlc[menuAlc.TabSelect]
					if activeTab and activeTab[3] then
						FilterScrollContent(activeTab[3], query)
					end
				end
			end)


			searchbox.Focused:Connect(function()
				TweenService:Create(LabelText,TweenInfo.new(0.1),{TextTransparency = 1}):Play()
				TweenService:Create(SearchIcon,TweenInfo.new(0.1),{ImageTransparency = 1}):Play() 
			end)

			searchbox.FocusLost:Connect(function()
				if #searchbox.Text > 0 then
					for i,v in ipairs(TabFrames:GetChildren()) do
						if v:IsA('Frame') then
							if v.Name:lower():find(searchbox.Text:lower()) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				else
					TweenService:Create(LabelText,TweenInfo.new(0.1),{TextTransparency = 0.75}):Play()
					TweenService:Create(SearchIcon,TweenInfo.new(0.1),{ImageTransparency = 0.75}):Play()
					for i,v in ipairs(TabFrames:GetChildren()) do
						if v:IsA('Frame') then
							v.Visible = true
						end
					end
				end
			end)

			searchbox:GetPropertyChangedSignal('Text'):Connect(function()
				if #searchbox.Text > 0 then
					TweenService:Create(LabelText,TweenInfo.new(0.1),{TextTransparency = 1}):Play()
					TweenService:Create(SearchIcon,TweenInfo.new(0.1),{ImageTransparency = 1}):Play()
					for i,v in ipairs(TabFrames:GetChildren()) do
						if v:IsA('Frame') then
							if v.Name:lower():find(searchbox.Text:lower()) then
								v.Visible = true
							else
								v.Visible = false
							end
						end
					end
				else
					TweenService:Create(LabelText,TweenInfo.new(0.1),{TextTransparency = 0.75}):Play()
					TweenService:Create(SearchIcon,TweenInfo.new(0.1),{ImageTransparency = 0.75}):Play()

					for i,v in ipairs(TabFrames:GetChildren()) do
						if v:IsA('Frame') then
							v.Visible = true
						end
					end
				end
			end)

		elseif MenuType:find('change') then
			local ChangeLog = Instance.new("Frame")
			local Main = Instance.new("Frame")
			local MainScrolling = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Framec = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			scrolling_connectY(MainScrolling)
			ChangeLog.Name = "ChangeLog"
			ChangeLog.Parent = Frame
			ChangeLog.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ChangeLog.BackgroundTransparency = 1.000
			ChangeLog.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ChangeLog.BorderSizePixel = 0
			ChangeLog.Position = UDim2.new(0, 0, 0.163185388, 0)
			ChangeLog.Size = UDim2.new(1, 0, 0.836814642, 0)
			ChangeLog.Visible = true

			ChangeLog.ZIndex = 4
			MainFrame = ChangeLog

			Main.Name = "Main"
			Main.Parent = ChangeLog
			Main.AnchorPoint = Vector2.new(0.5, 0.5)
			Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Main.BackgroundTransparency = 1.000
			Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Main.BorderSizePixel = 0
			Main.ClipsDescendants = true
			Main.Position = UDim2.new(0.5, 0, 0.5, 0)
			Main.Size = UDim2.new(0.949999988, 0, 0.949999988, 0)
			Main.ZIndex = 4

			MainScrolling.Name = "MainScrolling"
			MainScrolling.Parent = Main
			MainScrolling.Active = true
			MainScrolling.AnchorPoint = Vector2.new(0.5, 0.5)
			MainScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MainScrolling.BackgroundTransparency = 1.000
			MainScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MainScrolling.BorderSizePixel = 0
			MainScrolling.ClipsDescendants = false
			MainScrolling.Position = UDim2.new(0.5, 0, 0.5, 0)
			MainScrolling.Size = UDim2.new(0.99000001, 0, 1, 0)
			MainScrolling.ZIndex = 2
			MainScrolling.ScrollBarThickness = 0

			UIListLayout.Parent = MainScrolling
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			Framec.Parent = ChangeLog
			Framec.AnchorPoint = Vector2.new(0.5, 1)
			Framec.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
			Framec.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Framec.BorderSizePixel = 0
			Framec.Position = UDim2.new(0.5, 0, 0, 0)
			Framec.Size = UDim2.new(0.949999988, 0, 0.00499999989, 0)

			UICorner.CornerRadius = UDim.new(0.5, 0)
			UICorner.Parent = Framec
		end

		local myindex = #WindowAlc.Tabs + 1

		local function Connect(val)
			if val then
				TweenService:Create(MainFrame,TweenInfo.new(0.3),{Position = UDim2.fromScale(0,0.163)}):Play()
				TweenService:Create(MenuText,TweenInfo.new(0.1 + (myindex / 10)),{TextColor3 = Color3.fromRGB(255,255,255),TextTransparency=0.8}):Play()
			else

				if myindex < WindowAlc.TabSelect then
					TweenService:Create(MainFrame,TweenInfo.new(0.3),{Position = UDim2.fromScale(-1,0.163)}):Play()
				else
					TweenService:Create(MainFrame,TweenInfo.new(0.3),{Position = UDim2.fromScale(1,0.163)}):Play()
				end
				TweenService:Create(MenuText,TweenInfo.new(0.1),{TextColor3 = Color3.fromRGB(255, 255, 255),TextTransparency=0.25}):Play()
			end
		end

		if not WindowAlc.Tabs[1] then
			Connect(true)
		else
			Connect(false)
		end

		MenuAlc.TabSelect = 1
		table.insert(WindowAlc.Tabs,{MenuButton,Connect,MenuAlc}) 

		myindex = #WindowAlc.Tabs

		Button.MouseButton1Click:Connect(function()
			WindowAlc.TabSelect = myindex
			for i,v in ipairs(WindowAlc.Tabs) do
				if v[1]==MenuButton then
					WindowAlc.TabSelect = i
					v[2](true)
					-- Apply current search filter when switching tabs
					if v[3] then
						FilterScrollContent(v[3], SearchInput.Text)
					end
				else
					v[2](false)
				end
			end
		end)

		function MenuAlc:AddTab(TabName,IconId)
			local MainTab = {

			}

			local TabAlc = {}

			local MainScrollingfr
			if MenuType:find('tab') then
				local MainScrolling = Instance.new("ScrollingFrame")
				local UIListLayout_2 = Instance.new("UIListLayout")

				scrolling_connectY(MainScrolling)
				MainScrollingfr = MainScrolling
				MainScrolling.Name = tostring(TabName or "Main")
				MainScrolling.Name = "MainScrolling"
				MainScrolling.Parent =  MainFrame:WaitForChild('Main')
				MainScrolling.Active = true
				MainScrolling.AnchorPoint = Vector2.new(0.5, 0)
				MainScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				MainScrolling.BackgroundTransparency = 1.000
				MainScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
				MainScrolling.BorderSizePixel = 0
				MainScrolling.ClipsDescendants = false
				MainScrolling.Position = UDim2.new(0.8, 0, 0.1, 45)
				MainScrolling.Size = UDim2.new(0.99500001, 0, 1, -45)
				MainScrolling.ZIndex = 7
				MainScrolling.ScrollBarThickness = 3
                MainScrolling.ScrollBarImageColor3 = Color3.fromRGB(127, 255, 212)
 
				UIListLayout_2.Parent = MainScrolling
				UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_2.Padding = UDim.new(0, 10)

				local TabButton = Instance.new("Frame")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				local UICorner = Instance.new("UICorner")
				local UIStroke = Instance.new("UIStroke")
				local UIGradient = Instance.new("UIGradient")
				local TabIcon = Instance.new("ImageLabel")
				local Text = Instance.new("TextLabel")
				local Description = Instance.new("TextLabel")
				local Button = Instance.new("TextButton")
                local StrokeButton = Instance.new("Frame")

				TabButton.Name = tostring(TabName or "Main")
				TabButton.Parent = MainFrame:WaitForChild('Search'):WaitForChild('TabFrames')
                TabButton.BackgroundTransparency = 1
				TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
				TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TabButton.BorderSizePixel = 0
				TabButton.Size = UDim2.new(1, 0, 1, 0)
				TabButton.ZIndex = 1

                StrokeButton.Name = "StrokeButton"
				StrokeButton.Parent = TabButton
				StrokeButton.BackgroundColor3 = Color3.fromRGB(127, 255, 212)
                StrokeButton.BackgroundTransparency = 1
				StrokeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				StrokeButton.BorderSizePixel = 0
                StrokeButton.Position = UDim2.new(0, 0, 0.5, 0)
				StrokeButton.AnchorPoint = Vector2.new(0, 0.5)
				StrokeButton.Size = UDim2.new(0, 2, 0.65, 0)
				StrokeButton.ZIndex = 6

				UIAspectRatioConstraint.Parent = TabButton
				UIAspectRatioConstraint.AspectRatio = 5.250
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				UICorner.CornerRadius = UDim.new(0, 1)
				UICorner.Parent = StrokeButton

				UIStroke.Transparency = 0.3
				UIStroke.Color = Color3.fromRGB(127, 255, 212)
				UIStroke.Parent = StrokeButton

				UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.50), NumberSequenceKeypoint.new(0.20, 0.00), NumberSequenceKeypoint.new(0.80, 0.00), NumberSequenceKeypoint.new(1.00, 0.50)}
				UIGradient.Parent = UIStroke

				TabIcon.Name = "TabIcon"
				TabIcon.Parent = TabButton
				TabIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TabIcon.BackgroundTransparency = 1.000
				TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TabIcon.BorderSizePixel = 0
				TabIcon.Position = UDim2.new(0.135000005, 0, 0.5, 0)
				TabIcon.Size = UDim2.new(0.699999988, 0, 0.699999988, 0)
				TabIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
				TabIcon.ZIndex = 6
				TabIcon.Image = "rbxassetid://"..IconId

				Text.Name = "Text"
				Text.Parent = TabButton
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Text.BorderSizePixel = 0
				Text.Position = UDim2.new(0.246999651, 0, 0.200000003, 0)
				Text.Size = UDim2.new(0.753000021, 0, 0.400000006, 0)
				Text.ZIndex = 7
				Text.Font = Enum.Font.GothamBold
				Text.Text = TabName or "Main"
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextScaled = true
				Text.TextSize = 14.000
				Text.TextWrapped = true
                Text.Visible = false
				Text.TextXAlignment = Enum.TextXAlignment.Left

				Description.Name = "Description"
				Description.Parent = TabButton
				Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Description.BackgroundTransparency = 1.000
				Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Description.BorderSizePixel = 0
				Description.Position = UDim2.new(0.246999651, 0, 0.600000024, 0)
				Description.Size = UDim2.new(0.753000081, 0, 0.25, 0)
				Description.ZIndex = 7
				Description.Font = Enum.Font.GothamBold
				Description.Text = Descriptions or "loadstring()()"
				Description.TextColor3 = Color3.fromRGB(255, 255, 255)
				Description.TextScaled = true
				Description.TextSize = 14.000
				Description.TextTransparency = 0.500
                Description.Visible = false
				Description.TextWrapped = true
				Description.TextXAlignment = Enum.TextXAlignment.Left

				Button.Name = "Button"
				Button.Parent = TabButton
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.BackgroundTransparency = 1.000
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0.199999988, 0, 0.899999988, 0)
				Button.ZIndex = 25
				Button.Font = Enum.Font.SourceSans
				Button.Text = ""
				Button.TextColor3 = Color3.fromRGB(0, 0, 0)
				Button.TextSize = 14.000
				Button.TextTransparency = 1.000

				local function connect(val)
					if val then
						MainScrolling.Visible = true
                        Text.TextColor3 = Color3.fromRGB(127, 255, 212)
                        StrokeButton.BackgroundTransparency = 0.250
                        UIStroke.Transparency = 0
						TweenService:Create(TabIcon,TweenInfo.new(0.15),{ImageTransparency = 0}):Play()
						TweenService:Create(Description,TweenInfo.new(0.15),{TextTransparency = 0.5}):Play()
						TweenService:Create(Text,TweenInfo.new(0.15),{TextTransparency = 0}):Play()
						TweenService:Create(MainScrolling,TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),{
							Position = UDim2.new(0.5, 0, 0, 45)
						}):Play()
					else
                        StrokeButton.BackgroundTransparency = 1
                        UIStroke.Transparency = 1
						Text.TextColor3 = Color3.fromRGB(255, 255, 255)
						TweenService:Create(TabIcon,TweenInfo.new(0.15),{ImageTransparency = 0.55}):Play()
						TweenService:Create(Description,TweenInfo.new(0.15),{TextTransparency = 0.85}):Play()
						TweenService:Create(Text,TweenInfo.new(0.15),{TextTransparency = 0.55}):Play()
						local tw = TweenService:Create(MainScrolling,TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),{
							Position = UDim2.new(1.5, 0, 0, 45)
						})
						tw:Play()
						tw.Completed:Connect(function()
							if MenuAlc.TabSelect ~= table.find(MenuAlc, v) then
								MainScrolling.Visible = false
							end
						end)
					end
				end

				if not MenuAlc[1] then
					connect(true)
				else
					connect(false)
				end

				table.insert(MenuAlc,{connect,TabIcon,MainScrolling})

				Button.MouseButton1Click:Connect(function()
					for i,v in ipairs(MenuAlc) do
						if v[2] == TabIcon then
							MenuAlc.TabSelect = i
							v[1](true)
							-- Apply current search filter when switching tabs within the menu
							FilterScrollContent(v[3], SearchInput.Text)
						else
							v[1](false)
						end
					end
				end)
			elseif MenuType:find('change') then
				MainScrollingfr = MainFrame:FindFirstChild('Main'):FindFirstChild('MainScrolling')
			end

            local MainLayout = Instance.new("UIListLayout")
MainLayout.Parent = MainScrollingfr
MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
MainLayout.Padding = UDim.new(0, 6) -- space between rows

local MainPadding = Instance.new("UIPadding")
MainPadding.Parent = MainScrollingfr
MainPadding.PaddingTop = UDim.new(0, 8)   -- pushes the first section down
MainPadding.PaddingBottom = UDim.new(0, 8)
MainPadding.PaddingLeft = UDim.new(0, 8)
MainPadding.PaddingRight = UDim.new(0, 8)
			

		function MainTab:AddSection(SectionName)
    local SectionInfo = {}

    -- Main container
    local SectionFrame = Instance.new("Frame")
SectionFrame.Name = "SectionFrame"
SectionFrame.Parent = MainScrollingfr
SectionFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
SectionFrame.Size = UDim2.new(0.96, 0, 0, HEADER_H) -- Centered width
SectionFrame.ZIndex = 4
SectionFrame.ClipsDescendants = true

    -- Row header (clickable)
local Row = Instance.new("TextButton")
Row.Name = "Row"
Row.Parent = SectionFrame
Row.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
Row.BackgroundTransparency = 0
Row.BorderSizePixel = 0
Row.Size = UDim2.new(1, 0, 0, 36)
Row.AutoButtonColor = false
Row.Text = ""
Row.ZIndex = 5

local RowCorner = Instance.new("UICorner")
RowCorner.CornerRadius = UDim.new(0, 10)
RowCorner.Parent = Row

local RowStroke = Instance.new("UIStroke")
RowStroke.Color = Color3.fromRGB(70, 70, 80)
RowStroke.Transparency = 0.6
RowStroke.Thickness = 1
RowStroke.Parent = Row

local RowPad = Instance.new("UIPadding")
RowPad.PaddingLeft = UDim.new(0, 12)
RowPad.PaddingRight = UDim.new(0, 12)
RowPad.Parent = Row

-- Left dot
local Dot = Instance.new("Frame")
Dot.Name = "Dot"
Dot.Parent = Row
Dot.BackgroundColor3 = Color3.fromRGB(127, 255, 212)
Dot.BorderSizePixel = 0
Dot.Size = UDim2.new(0, 8, 0, 8)
Dot.Position = UDim2.new(0, 0, 0.5, 0)
Dot.AnchorPoint = Vector2.new(0, 0.5)
Dot.ZIndex = 6

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = Dot

-- Title text
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Row
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Size = UDim2.new(1, -(14 + 22), 1, 0) -- leave room for arrow
Title.Font = Enum.Font.GothamSemibold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(235, 235, 245)
Title.Text = SectionName or "Section"
Title.ZIndex = 6

-- Right chevron (your image)
local Arrow = Instance.new("ImageButton")
Arrow.Name = "Arrow"
Arrow.Parent = Row
Arrow.BackgroundTransparency = 1
Arrow.BorderSizePixel = 0
Arrow.AnchorPoint = Vector2.new(1, 0.5)
Arrow.Position = UDim2.new(1, 0, 0.5, 0)
Arrow.Size = UDim2.new(0, 16, 0, 16)
Arrow.AutoButtonColor = false
Arrow.Image = "rbxassetid://116634521786394"
Arrow.ImageColor3 = Color3.fromRGB(127, 255, 212)
Arrow.ZIndex = 6

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = SectionFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(60, 60, 60)
    UIStroke.Transparency = 0.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = SectionFrame

    -- Content container (all controls go here)
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Parent = SectionFrame
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 0, 0, 40)
    Content.Size = UDim2.new(1, 0, 0, 0)
    Content.ZIndex = 4

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Content
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    local isOpen = false
Content.Visible = false        
Arrow.Rotation = -90          
                

local HEADER_H = 36
local BOTTOM_PAD = 10

local function UpdateSize()
    local contentH = isOpen and UIListLayout.AbsoluteContentSize.Y or 0
    SectionFrame.Size = UDim2.new(1, -10, 0, HEADER_H + (isOpen and (contentH + BOTTOM_PAD) or 0))
end

local function SetOpen(open)
    isOpen = open
    Content.Visible = open
    Arrow.Rotation = open and 0 or -90
    UpdateSize()
end

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSize)
    Content.ChildAdded:Connect(UpdateSize)
    Content.ChildRemoved:Connect(UpdateSize)

Arrow.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    Arrow.Rotation = isOpen and 0 or -90  -- rotate when closed
    Content.Visible = isOpen
    UpdateSize()
end)

    function SectionInfo:Update()
        UpdateSize()
    end


                function SectionInfo:AddLabel(LabelName)
                    local SectionTitle = Instance.new("TextLabel")
                    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
                    local Config = {}

                    -- Configure the TextLabel
                    SectionTitle.Name = "SectionTitle"
                    SectionTitle.Parent = Content
                    SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SectionTitle.BackgroundTransparency = 1.0
                    SectionTitle.BorderSizePixel = 0
                    SectionTitle.Size = UDim2.new(0.92, 0, 0.5, 0)
                    SectionTitle.ZIndex = 4
                    SectionTitle.Font = Enum.Font.GothamBold
                    SectionTitle.Text = LabelName or "SECTION"
                    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    SectionTitle.TextTransparency = 0.5
                    SectionTitle.TextScaled = false
                    SectionTitle.TextSize = 12.0
                    SectionTitle.TextWrapped = true
                    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

                    -- Set up AspectRatioConstraint
                    UIAspectRatioConstraint.Parent = SectionTitle
                    UIAspectRatioConstraint.AspectRatio = 23.0
                    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

                    -- Function to update text
                    function Config:Set(newText)
                        SectionTitle.Text = tostring(newText)
                    end

                    -- Function to delete the label
                    function Config:Delete()
                        SectionTitle:Destroy()
                        UpdateSiz()
                    end

                    -- Optionally update the section's size
                    SectionInfo:Update()

                    return Config
                end

                function SectionInfo:AddSeperator(text)
                    local Seperator = Instance.new("Frame")
                    local Sep1 = Instance.new("Frame")
                    local Sep2 = Instance.new("TextLabel")
                    local Sep3 = Instance.new("Frame")
                    local Sep21 = Instance.new("TextLabel")
                    local Sep212 = Instance.new("TextLabel")
                    local UIStroke = Instance.new("UIStroke")
                    local UICorner_2 = Instance.new("UICorner")

                    Seperator.Name = "Seperator"
                    Seperator.Parent = Content
                    Seperator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Seperator.BorderSizePixel = 0
                    Seperator.BackgroundTransparency = 1
                    Seperator.ZIndex = 4
                    Seperator.Size = UDim2.new(0.90, 0, 0, 30)

                    UICorner_2.CornerRadius = UDim.new(0.4, 0)
                    UICorner_2.Parent = Seperator

                    UIStroke.Color = Color3.fromRGB(127, 255, 212)
                    UIStroke.Transparency = 0.5
                    UIStroke.Parent = Seperator
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

                    Sep1.Name = "Sep1"
                    Sep1.Parent = Seperator
                    Sep1.BackgroundColor3 = Color3.fromRGB(127, 255, 212)
                    Sep1.BackgroundTransparency = 0
                    Sep1.ZIndex = 10
                    Sep1.BorderSizePixel = 0
                    Sep1.ZIndex = 6
                    Sep1.Position = UDim2.new(0, 10, 0, 10)
                    Sep1.Size = UDim2.new(0, 90, 0, 2)
                    Sep1.Visible = false

                    Sep2.Name = "Sep2"
                    Sep2.Parent = Seperator
                    Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sep2.BackgroundTransparency = 1
                    Sep2.AnchorPoint = Vector2.new(0.5, 0.5) -- Center alignment
                    Sep2.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered position
                    Sep2.Size = UDim2.new(0.95, 0, 0, 30) -- Width 95% of parent, height 30 pixels

                    Sep2.Font = Enum.Font.SourceSansBold
                    Sep2.Text = text
                    Sep2.RichText = true
                    Sep2.ZIndex = 6
                    Sep2.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Sep2.TextTransparency = 0.5
                    Sep2.TextSize = 18.000

                    Sep21.Name = "Sep2"
                    Sep21.Parent = Seperator
                    Sep21.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sep21.BackgroundTransparency = 1
                    Sep21.Position = UDim2.new(0, 0, 0, 0)
                    Sep21.Size = UDim2.new(0.3385, 0, 0, 30)
                    Sep21.Font = Enum.Font.SourceSansBold
                    Sep21.Text = "<<"
                    Sep21.RichText = true
                    Sep21.ZIndex = 6
                    Sep21.TextColor3 = Color3.fromRGB(127, 255, 212)
                    Sep21.TextSize = 20.000

                    Sep212.Name = "Sep2"
                    Sep212.Parent = Seperator
                    Sep212.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Sep212.BackgroundTransparency = 1
                    Sep212.Position = UDim2.new(0, 0, 0, 0)
                    Sep212.AnchorPoint = Vector2.new(1, 0.5) -- Aligns the right edge of the frame to the position
                    Sep212.Position = UDim2.new(0.8, 0, 0.5, 0)
                    Sep212.Font = Enum.Font.SourceSansBold
                    Sep212.Text = ">>"
                    Sep212.RichText = true
                    Sep212.ZIndex = 6
                    Sep212.TextColor3 = Color3.fromRGB(127, 255, 212)
                    Sep212.TextSize = 20.000

                    Sep3.Name = "Sep3"
                    Sep3.Parent = Seperator
                    Sep3.BackgroundColor3 = Color3.fromRGB(127, 255, 212)
                    Sep3.BackgroundTransparency = .1
                    Sep3.BorderSizePixel = 0
                    Sep3.ZIndex = 6
                    Sep3.Visible = false
                    Sep3.Position = UDim2.new(0, 280, 0, 10)
                    Sep3.Size = UDim2.new(0, 90, 0, 2)
                end

                function SectionInfo:addLabel(text)
                    local Label = Instance.new("TextLabel")
                    local PaddingLabel = Instance.new("UIPadding")
                    local labelfunc = {}
                    Label.Name = "Label"
                    Label.Parent = Content
                    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Label.BackgroundTransparency = 1.000
                    Label.Size = UDim2.new(0, 270, 0, 20)
                    Label.Font = Enum.Font.GothamBold
                    Label.TextColor3 = Color3.fromRGB(225, 225, 255)
                    Label.TextTransparency = 0.5
                    Label.TextSize = 10.000
                    Label.Text = text
                    Label.ZIndex = 5
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    PaddingLabel.PaddingLeft = UDim.new(0, 10)
                    PaddingLabel.Parent = Label
                    PaddingLabel.Name = "PaddingLabel"
                    function labelfunc:Set(newtext)
                        Label.Text = newtext
                    end
                    return labelfunc
                end
                
function SectionInfo:PlayerInfo(player)
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Name = "PlayerInfo"
    InfoFrame.Parent = Content
    InfoFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    InfoFrame.Size = UDim2.new(0.94, 0, 0, 70)
    InfoFrame.BorderSizePixel = 0
    InfoFrame.ZIndex = 4

    -- Rounded corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = InfoFrame

    -- Stroke outline
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(50, 50, 65)  -- stroke color
    Stroke.Thickness = 2                        -- stroke thickness
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = InfoFrame

    -- Player avatar image
    local Avatar = Instance.new("ImageLabel")
    Avatar.Name = "Avatar"
    Avatar.Parent = InfoFrame
    Avatar.Position = UDim2.new(0, 10, 0.5, -20)
    Avatar.Size = UDim2.new(0, 40, 0, 40)
    Avatar.BackgroundTransparency = 1
    Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=420&h=420"
    Avatar.ZIndex = 5
    local AvCorner = Instance.new("UICorner")
    AvCorner.CornerRadius = UDim.new(1, 0)
    AvCorner.Parent = Avatar

    -- Player name
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Parent = InfoFrame
    NameLabel.Position = UDim2.new(0, 60, 0, 10)
    NameLabel.Size = UDim2.new(0.7, 0, 0, 20)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 14
    NameLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Text = "Welcome to Zen hub,   <font color='rgb(127,255,212)'>" .. player.Name.."!" .. "</font>"
	NameLabel.RichText = true;
    NameLabel.ZIndex = 5

    -- Display name
    local DisplayLabel = Instance.new("TextLabel")
    DisplayLabel.Name = "DisplayLabel"
    DisplayLabel.Parent = InfoFrame
    DisplayLabel.Position = UDim2.new(0, 60, 0, 30)
    DisplayLabel.Size = UDim2.new(0.7, 0, 0, 20)
    DisplayLabel.BackgroundTransparency = 1
    DisplayLabel.Font = Enum.Font.Gotham
    DisplayLabel.TextSize = 12
    DisplayLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
    DisplayLabel.TextXAlignment = Enum.TextXAlignment.Left
    DisplayLabel.Text = "@"..player.DisplayName
    DisplayLabel.ZIndex = 5

    -- Description
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Name = "DescLabel"
    DescLabel.Parent = InfoFrame
    DescLabel.Position = UDim2.new(0, 60, 0, 50)
    DescLabel.Size = UDim2.new(0.9, 0, 0, 20)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 11
    DescLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Text = "Join Zen Hub Discord For Updates! Use at your own risk."
    DescLabel.TextWrapped = true
    DescLabel.ZIndex = 5
end

function SectionInfo:UICreators()
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Name = "UICreators"
    InfoFrame.Parent = Content
    InfoFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    InfoFrame.Size = UDim2.new(0.94, 0, 0, 70)
    InfoFrame.BorderSizePixel = 0
    InfoFrame.ZIndex = 4

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = InfoFrame

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(50, 50, 65)
    Stroke.Thickness = 2
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = InfoFrame

    -- UI Creator (Jay) block
    local UICreatorFrame = Instance.new("Frame")
    UICreatorFrame.Name = "UICreator"
    UICreatorFrame.Parent = InfoFrame
    UICreatorFrame.BackgroundTransparency = 1
    UICreatorFrame.Position = UDim2.new(0, 10, 0, 10)
    UICreatorFrame.Size = UDim2.new(0.48, 0, 1, -20)
    UICreatorFrame.ZIndex = 5

    local UIAvatar = Instance.new("ImageLabel")
    UIAvatar.Name = "UIAvatar"
    UIAvatar.Parent = UICreatorFrame
    UIAvatar.Position = UDim2.new(0, 0, 0.5, -18)
    UIAvatar.Size = UDim2.new(0, 36, 0, 36)
    UIAvatar.BackgroundTransparency = 1
    UIAvatar.Image = "http://www.roblox.com/asset/?id=81990169842028"
    UIAvatar.ZIndex = 5
    local UIAvCorner = Instance.new("UICorner")
    UIAvCorner.CornerRadius = UDim.new(1, 0)
    UIAvCorner.Parent = UIAvatar

    local UITitle = Instance.new("TextLabel")
    UITitle.Name = "UITitle"
    UITitle.Parent = UICreatorFrame
    UITitle.Position = UDim2.new(0, 42, 0, 4)
    UITitle.Size = UDim2.new(1, -42, 0, 18)
    UITitle.BackgroundTransparency = 1
    UITitle.Font = Enum.Font.GothamBold
    UITitle.TextSize = 12
    UITitle.TextColor3 = Color3.fromRGB(240, 240, 245)
    UITitle.TextXAlignment = Enum.TextXAlignment.Left
    UITitle.Text = "UI Creator"
    UITitle.ZIndex = 5

    local UIName = Instance.new("TextLabel")
    UIName.Name = "UIName"
    UIName.Parent = UICreatorFrame
    UIName.Position = UDim2.new(0, 42, 0, 22)
    UIName.Size = UDim2.new(1, -42, 0, 20)
    UIName.BackgroundTransparency = 1
    UIName.Font = Enum.Font.Gotham
    UIName.TextSize = 11
    UIName.TextColor3 = Color3.fromRGB(180, 180, 195)
    UIName.TextXAlignment = Enum.TextXAlignment.Left
    UIName.Text = "Jay  (jay0050)"
    UIName.ZIndex = 5

    -- Script Creator (Npg) block, to the right of UI creator
    local ScriptCreatorFrame = Instance.new("Frame")
    ScriptCreatorFrame.Name = "ScriptCreator"
    ScriptCreatorFrame.Parent = InfoFrame
    ScriptCreatorFrame.BackgroundTransparency = 1
    ScriptCreatorFrame.Position = UDim2.new(0.52, 0, 0, 10)
    ScriptCreatorFrame.Size = UDim2.new(0.48, 0, 1, -20)
    ScriptCreatorFrame.ZIndex = 5

    local ScriptAvatar = Instance.new("ImageLabel")
    ScriptAvatar.Name = "ScriptAvatar"
    ScriptAvatar.Parent = ScriptCreatorFrame
    ScriptAvatar.Position = UDim2.new(0, 0, 0.5, -18)
    ScriptAvatar.Size = UDim2.new(0, 36, 0, 36)
    ScriptAvatar.BackgroundTransparency = 1
    ScriptAvatar.Image = "http://www.roblox.com/asset/?id=75165518025574"
    ScriptAvatar.ZIndex = 5
    local ScriptAvCorner = Instance.new("UICorner")
    ScriptAvCorner.CornerRadius = UDim.new(1, 0)
    ScriptAvCorner.Parent = ScriptAvatar

    local ScriptTitle = Instance.new("TextLabel")
    ScriptTitle.Name = "ScriptTitle"
    ScriptTitle.Parent = ScriptCreatorFrame
    ScriptTitle.Position = UDim2.new(0, 42, 0, 4)
    ScriptTitle.Size = UDim2.new(1, -42, 0, 18)
    ScriptTitle.BackgroundTransparency = 1
    ScriptTitle.Font = Enum.Font.GothamBold
    ScriptTitle.TextSize = 12
    ScriptTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
    ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    ScriptTitle.Text = "Script Creator"
    ScriptTitle.ZIndex = 5

    local ScriptName = Instance.new("TextLabel")
    ScriptName.Name = "ScriptName"
    ScriptName.Parent = ScriptCreatorFrame
    ScriptName.Position = UDim2.new(0, 42, 0, 22)
    ScriptName.Size = UDim2.new(1, -42, 0, 20)
    ScriptName.BackgroundTransparency = 1
    ScriptName.Font = Enum.Font.Gotham
    ScriptName.TextSize = 11
    ScriptName.TextColor3 = Color3.fromRGB(180, 180, 195)
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.Text = "NpgNpg  (npg.demon)"
    ScriptName.ZIndex = 5
end
                function SectionInfo:Textbox(Name, PlaceholderText, Callback)

                    local InputFrame = Instance.new("Frame")
                    InputFrame.Name = "Input"
                    InputFrame.Parent = Content
                    InputFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                    InputFrame.Size = UDim2.new(0.94, 0, 0, 40)
                    InputFrame.BorderSizePixel = 0
                    InputFrame.ZIndex = 4

                    local InputCorner = Instance.new("UICorner")
                    InputCorner.CornerRadius = UDim.new(0, 8)
                    InputCorner.Parent = InputFrame

                    local InputStroke = Instance.new("UIStroke")
                    InputStroke.Color = Color3.fromRGB(50, 50, 65)
                    InputStroke.Thickness = 1
                    InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    InputStroke.Parent = InputFrame

                    local InputPad = Instance.new("UIPadding")
                    InputPad.PaddingLeft = UDim.new(0, 12)
                    InputPad.PaddingRight = UDim.new(0, 12)
                    InputPad.Parent = InputFrame

                    local Title = Instance.new("TextLabel")
                    Title.Name = "Title"
                    Title.Parent = InputFrame
                    Title.AnchorPoint = Vector2.new(0, 0.5)
                    Title.Position = UDim2.new(0, 0, 0.5, 0)
                    Title.Size = UDim2.new(1, -160, 0, 20)
                    Title.BackgroundTransparency = 1
                    Title.Font = Enum.Font.GothamBold
                    Title.Text = Name
                    Title.TextColor3 = Color3.fromRGB(240, 240, 245)
                    Title.TextSize = 13
                    Title.TextXAlignment = Enum.TextXAlignment.Left
                    Title.ZIndex = 5

                    local TextBoxBg = Instance.new("Frame")
                    TextBoxBg.Name = "TextBoxBg"
                    TextBoxBg.Parent = InputFrame
                    TextBoxBg.AnchorPoint = Vector2.new(1, 0.5)
                    TextBoxBg.Position = UDim2.new(1, 0, 0.5, 0)
                    TextBoxBg.Size = UDim2.new(0, 140, 0, 28)
                    TextBoxBg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
                    TextBoxBg.BorderSizePixel = 0
                    TextBoxBg.ZIndex = 5

                    local TextBoxCorner = Instance.new("UICorner")
                    TextBoxCorner.CornerRadius = UDim.new(0, 6)
                    TextBoxCorner.Parent = TextBoxBg

                    local TextBoxStroke = Instance.new("UIStroke")
                    TextBoxStroke.Color = Color3.fromRGB(40, 40, 50)
                    TextBoxStroke.Thickness = 1
                    TextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    TextBoxStroke.Parent = TextBoxBg

                    local TextBox = Instance.new("TextBox")
                    TextBox.Name = "TextBox"
                    TextBox.Parent = TextBoxBg
                    TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
                    TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
                    TextBox.Size = UDim2.new(1, -16, 1, 0)
                    TextBox.BackgroundTransparency = 1
                    TextBox.Font = Enum.Font.Gotham
                    TextBox.Text = ""
                    TextBox.PlaceholderText = PlaceholderText or "Enter text..."
                    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
                    TextBox.TextSize = 12
                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                    TextBox.ClipsDescendants = true
                    TextBox.ZIndex = 6

                    TextBox.Focused:Connect(function()
                        TweenService:Create(TextBoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 220, 180)}):Play()
                        TweenService:Create(TextBoxBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play()
                    end)

                    TextBox.FocusLost:Connect(function(enterPressed)
                        TweenService:Create(TextBoxStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(40, 40, 50)}):Play()
                        TweenService:Create(TextBoxBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(15, 15, 20)}):Play()
                        if enterPressed then
                            pcall(Callback, TextBox.Text)
                        end
                    end)
                end

                function SectionInfo:AddToggle(config)

                if type(config) ~= "table" then
                  error("AddToggle expects a table")
                 end

                 local ToggleName = config.Name or "Toggle"
                 local Description = config.Description or ""
                 local Default = config.Default or false
                  local Callback = config.Callback or function() end
                    
                    local Toggle = Instance.new("Frame")
                    Toggle.Name = "Toggle"
                    Toggle.Parent = Content
                    Toggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                    Toggle.BackgroundTransparency = 0
                    Toggle.Size = UDim2.new(0.94, 0, 0, 35)
                    Toggle.BorderSizePixel = 0
                    Toggle.ZIndex = 4

                    local ToggleCorner = Instance.new("UICorner")
                    ToggleCorner.CornerRadius = UDim.new(0, 8)
                    ToggleCorner.Parent = Toggle

                    local ToggleStroke = Instance.new("UIStroke")
                    ToggleStroke.Color = Color3.fromRGB(50, 50, 65)
                    ToggleStroke.Thickness = 1
                    ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ToggleStroke.Parent = Toggle

                    local TogglePad = Instance.new("UIPadding")
                    TogglePad.PaddingLeft = UDim.new(0, 12)
                    TogglePad.PaddingRight = UDim.new(0, 12)
                    TogglePad.Parent = Toggle

                    local Text = Instance.new("TextLabel")
                    Text.Name = "Text"
                    Text.Parent = Toggle
                    Text.AnchorPoint = Vector2.new(0, 0.5)
                    Text.Position = UDim2.new(0, 0, 0.5, 0)
                    Text.Size = UDim2.new(1, -60, 0, 20)
                    Text.BackgroundTransparency = 1
                    Text.Font = Enum.Font.GothamBold
                    Text.Text = ToggleName or "Toggle"
                    Text.TextColor3 = Color3.fromRGB(240, 240, 245)
                    Text.TextSize = 13
                    Text.TextXAlignment = Enum.TextXAlignment.Left
                    Text.ZIndex = 5

                    local Bg = Instance.new("Frame")
                    Bg.Name = "Bg"
                    Bg.Parent = Toggle
                    Bg.AnchorPoint = Vector2.new(1, 0.5)
                    Bg.Position = UDim2.new(1, 0, 0.5, 0)
                    Bg.Size = UDim2.new(0, 44, 0, 24)
                    Bg.BackgroundColor3 = ToggleDefault and Color3.fromRGB(100, 220, 180) or Color3.fromRGB(35, 35, 45)
                    Bg.BorderSizePixel = 0
                    Bg.ZIndex = 5

                    local BgCorner = Instance.new("UICorner")
                    BgCorner.CornerRadius = UDim.new(0, 12)
                    BgCorner.Parent = Bg

                    local Circle = Instance.new("Frame")
                    Circle.Name = "Circle"
                    Circle.Parent = Bg
                    Circle.AnchorPoint = Vector2.new(0, 0.5)
                    Circle.Position = ToggleDefault and UDim2.new(1, -21, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
                    Circle.Size = UDim2.new(0, 18, 0, 18)
                    Circle.BackgroundColor3 = ToggleDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 100)
                    Circle.BorderSizePixel = 0
                    Circle.ZIndex = 6

                    local CircleCorner = Instance.new("UICorner")
                    CircleCorner.CornerRadius = UDim.new(0, 9)
                    CircleCorner.Parent = Circle


                    local ClickArea = Instance.new("TextButton")
                    ClickArea.Name = "Click"
                    ClickArea.Parent = Toggle
                    ClickArea.Size = UDim2.new(1, 0, 1, 0)
                    ClickArea.BackgroundTransparency = 1
                    ClickArea.Text = ""
                    ClickArea.ZIndex = 10

                    local function Onv(val)
                        if val then
                            TweenService:Create(Bg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(100, 220, 180)}):Play()
                            TweenService:Create(Circle, TweenInfo.new(0.15), {
                                Position = UDim2.new(1, -21, 0.5, 0),
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            }):Play()
                        else
                            TweenService:Create(Bg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
                            TweenService:Create(Circle, TweenInfo.new(0.15), {
                                Position = UDim2.new(0, 3, 0.5, 0),
                                BackgroundColor3 = Color3.fromRGB(80, 80, 100)
                            }):Play()
                        end
                    end

                    ClickArea.MouseButton1Click:Connect(function()
                        ToggleDefault = not ToggleDefault
                        Onv(ToggleDefault)
                        if Callback then Callback(ToggleDefault) end
                    end)

                    ClickArea.MouseEnter:Connect(function()
                        TweenService:Create(Toggle, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 32, 40)}):Play()
                    end)
                    ClickArea.MouseLeave:Connect(function()
                        TweenService:Create(Toggle, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 28)}):Play()
                    end)

                    if ToggleDefault then
                        pcall(Callback, true)
                    end

                    SectionInfo:Update()

                    local Config = {}
                    function Config:Text(...) Text.Text = tostring(...) end
                    function Config:Value(V)
                        ToggleDefault = V
                        Onv(V)
                        if Callback then Callback(ToggleDefault) end
                    end
                    function Config:Delete()
                        Toggle:Destroy()
                        UpdateSiz()
                    end
                    return Config
                end

                function SectionInfo:MultiDropdown(Name, option, default, callback)
                    local selectedItems = default or {}
                    local isDropping = false
                    local Dropdown = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local DropTitle = Instance.new("TextLabel")
                    local DropTitle1 = Instance.new("TextLabel")
                    local DropScroll = Instance.new("ScrollingFrame")
                    local UIListLayout = Instance.new("UIListLayout")
                    local UIPadding = Instance.new("UIPadding")
                    local DropButton = Instance.new("TextButton")
                    local DropImage = Instance.new("ImageLabel")

                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = Content
                    Dropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    Dropdown.ClipsDescendants = true
                    Dropdown.Size = UDim2.new(0.94, 0, 0, 30)
                    Dropdown.ZIndex = 6

                    UICorner.CornerRadius = UDim.new(0, 3)
                    UICorner.Parent = Dropdown

                    DropTitle1.Name = "DropTitle1"
                    DropTitle1.Parent = Dropdown
                    DropTitle1.BackgroundTransparency = 1
                    DropTitle1.Size = UDim2.new(0.90, 0, 0, 20)
                    DropTitle1.Font = Enum.Font.GothamBold
                    DropTitle1.Text = "  " .. Name
                    DropTitle1.TextColor3 = Color3.fromRGB(225, 225, 225)
                    DropTitle1.TextSize = 12
                    DropTitle1.TextXAlignment = Enum.TextXAlignment.Left
                    DropTitle1.ZIndex = 6

                    DropTitle.Name = "DropTitle"
                    DropTitle.Parent = Dropdown
                    DropTitle.BackgroundTransparency = 1
                    DropTitle.Size = UDim2.new(0.90, 0, 0, 38)
                    DropTitle.Font = Enum.Font.GothamBold
                    --DropTitle.Text = "   Select Multiple: " .. default
                    DropTitle.TextColor3 = Color3.fromRGB(190, 190, 190)
                    DropTitle.TextSize = 9
                    DropTitle.TextXAlignment = Enum.TextXAlignment.Left
                    DropTitle.ZIndex = 6
                    DropTitle.TextScaled = false

                    DropScroll.Name = "DropScroll"
                    DropScroll.Parent = DropTitle
                    DropScroll.Active = true
                    DropScroll.BackgroundTransparency = 1
                    DropScroll.Position = UDim2.new(0, 0, 0, 31)
                    DropScroll.Size = UDim2.new(0.99, 0, 0, 150)
                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                    DropScroll.ScrollBarThickness = 20
                    DropScroll.ZIndex = 6

                    UIListLayout.Parent = DropScroll
                    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout.Padding = UDim.new(0, 5)

                    UIPadding.Parent = DropScroll
                    UIPadding.PaddingLeft = UDim.new(0, 5)
                    UIPadding.PaddingTop = UDim.new(0, 5)

                    DropImage.Name = "DropImage"
                    DropImage.Parent = Dropdown
                    DropImage.BackgroundTransparency = 1
                    DropImage.Position = UDim2.new(0.90, 0, 0, 6)
                    DropImage.Rotation = 180
                    DropImage.Size = UDim2.new(0, 20, 0, 20)
                    DropImage.Image = "rbxassetid://10734963191"
                    DropImage.ZIndex = 6

                    DropButton.Name = "DropButton"
                    DropButton.Parent = Dropdown
                    DropButton.BackgroundTransparency = 1
                    DropButton.Size = UDim2.new(0.95, 0, 0, 31)
                    DropButton.Font = Enum.Font.GothamBold
                    DropButton.Text = ""
                    DropButton.ZIndex = 6

                    -- Function to return formatted selected options
                    local function getpro()
                        if #selectedItems > 0 then
                            return "   " .. "Select Multiple: " .. table.concat(selectedItems, ", ")
                        elseif default and #default > 0 then
                            return "   " .. "Select Multiple: " .. table.concat(default, ", ")
                        else
                            return "   " .. "Select Multiple: "
                        end
                    end

                    -- Initialize selectedItems with default values
                    selectedItems = default or {}
                    DropTitle.Text = getpro() -- Set initial text

                    -- Update selected items and the display dynamically
                    local function updateDropTitle()
                        DropTitle.Text = getpro()
                    end

                    -- Create options
                    for i, v in ipairs(option) do
                        local Item = Instance.new("TextButton")
                        local UICorner1 = Instance.new("UICorner")

                        Item.Name = "Item"
                        Item.Parent = DropScroll
                        Item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        Item.Size = UDim2.new(0.99, 0, 0, 20)
                        Item.Font = Enum.Font.GothamBold
                        Item.Text = tostring(v)
                        Item.TextColor3 = Color3.fromRGB(225, 225, 225)
                        Item.TextSize = 13
                        Item.ZIndex = 6

                        UICorner1.CornerRadius = UDim.new(0, 4)
                        UICorner1.Parent = Item

                        -- Check if this option is already selected and update the item appearance
                        if table.find(selectedItems, v) then
                            Item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                        end

                        -- Toggle item selection
                        Item.MouseButton1Click:Connect(
                            function()
                                if table.find(selectedItems, v) then
                                    -- Remove from selected
                                    table.remove(selectedItems, table.find(selectedItems, v))
                                    Item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                else
                                    -- Add to selected
                                    table.insert(selectedItems, v)
                                    Item.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
                                end
                                DropTitle.Text = getpro()
                                callback(selectedItems)
                            end
                        )
                    end

                    -- Adjust the dropdown size dynamically based on the content
                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)

                    -- Toggle dropdown visibility
                    DropButton.MouseButton1Click:Connect(
                        function()
                            if not isDropping then
                                isDropping = true
                                Dropdown:TweenSize(UDim2.new(0.94, 0, 0, 181), "Out", "Quad", 0.3, true)
                                DropImage.Rotation = 0
                            else
                                isDropping = false
                                Dropdown:TweenSize(UDim2.new(0.94, 0, 0, 30), "Out", "Quad", 0.3, true)
                                DropImage.Rotation = 180
                            end
                        end
                    )

                    -- Return the options to manipulate the dropdown further if needed
                    return {
                        Add = function(_, t)
                            local Item = Instance.new("TextButton")
                            local UICorner1 = Instance.new("UICorner")

                            Item.Name = "Item"
                            Item.Parent = DropScroll
                            Item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                            Item.Size = UDim2.new(0.99, 0, 0, 20)
                            Item.Font = Enum.Font.GothamBold
                            Item.Text = tostring(t)
                            Item.TextColor3 = Color3.fromRGB(225, 225, 225)
                            Item.TextSize = 13
                            Item.ZIndex = 6

                            UICorner1.CornerRadius = UDim.new(0, 4)
                            UICorner1.Parent = Item

                            Item.MouseButton1Click:Connect(
                                function()
                                    if table.find(selectedItems, t) then
                                        table.remove(selectedItems, table.find(selectedItems, t))
                                        Item.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                    else
                                        table.insert(selectedItems, t)
                                        Item.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                                    end
                                    DropTitle.Text = getpro()
                                    callback(selectedItems)
                                end
                            )
                        end,
                        Clear = function()
                            selectedItems = {}
                            DropTitle.Text = "   " .. "Select Multiple : "
                            for _, v in ipairs(DropScroll:GetChildren()) do
                                if v:IsA("TextButton") then
                                    v.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                                end
                            end
                            callback(selectedItems)
                        end
                    }
                end

                function SectionInfo:AddDropdown(config)
    -- Ensure a table is passed
    if type(config) ~= "table" then
        error("AddDropdown expects a table")
    end

    -- Extract fields with defaults
    local Name = config.Name or "Dropdown"
    local Description = config.Description or ""
    local option = config.option or {}
    local default = config.default or option[1]
    local callback = config.callback or function() end

    local Selected = Default

                    local isdropping = false
                    local selectedValue = Description

                    -- === TRIGGER BUTTON (collapsed state) ===
                    local Dropdown = Instance.new("Frame")
                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = Content
                    Dropdown.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                    Dropdown.BackgroundTransparency = 0
                    Dropdown.ClipsDescendants = false
                    Dropdown.Size = UDim2.new(0.94, 0, 0, 43)
                    Dropdown.ZIndex = 6

                    local UiDropStroke = Instance.new("UIStroke")
                    UiDropStroke.Color = Color3.fromRGB(255, 255, 255)
                    UiDropStroke.Thickness = 1
                    UiDropStroke.Transparency = 0.92
                    UiDropStroke.Parent = Dropdown

                    local UICorner = Instance.new("UICorner")
                    UICorner.CornerRadius = UDim.new(0, 5)
                    UICorner.Parent = Dropdown

                    -- Main label (e.g. "Select Tool")
                    local DropTitle = Instance.new("TextLabel")
                    DropTitle.Name = "DropTitle"
                    DropTitle.Parent = Dropdown
                    DropTitle.BackgroundTransparency = 1
                    DropTitle.Position = UDim2.new(0, 12, 0, 8)
                    DropTitle.Size = UDim2.new(0.85, 0, 0, 20)
                    DropTitle.Font = Enum.Font.GothamBold
                    DropTitle.Text = Name
                    DropTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
                    DropTitle.TextSize = 14
                    DropTitle.TextXAlignment = Enum.TextXAlignment.Left
                    DropTitle.ZIndex = 7

                    -- Sub-label (shows selected value or hint)
                    local DropSub = Instance.new("TextLabel")
                    DropSub.Name = "DropSub"
                    DropSub.Parent = Dropdown
                    DropSub.BackgroundTransparency = 1
                    DropSub.Position = UDim2.new(0, 11, 0, 25)
                    DropSub.Size = UDim2.new(0.85, 0, 0, 16)
                    DropSub.Font = Enum.Font.Gotham
                    DropSub.Text = (selectedValue and tostring(selectedValue) ~= "" and selectedValue) or "Selected - None"
                    DropSub.TextColor3 = Color3.fromRGB(140, 140, 160)
                    DropSub.TextSize = 10
                    DropSub.TextXAlignment = Enum.TextXAlignment.Left
                    DropSub.ZIndex = 7

                    -- Chevron icon
                    local DropImage = Instance.new("ImageLabel")
                    DropImage.Name = "DropImage"
                    DropImage.Parent = Dropdown
                    DropImage.BackgroundTransparency = 1
                    DropImage.Position = UDim2.new(1, -32, 0.5, -10)
                    DropImage.Size = UDim2.new(0, 20, 0, 20)
                    DropImage.Image = "rbxassetid://10734963191"
                    DropImage.ImageColor3 = Color3.fromRGB(100, 100, 180)
                    DropImage.Rotation = 180
                    DropImage.ZIndex = 7

                    -- Invisible click button over the trigger
                    local DropButton = Instance.new("TextButton")
                    DropButton.Name = "DropButton"
                    DropButton.Parent = Dropdown
                    DropButton.BackgroundTransparency = 1
                    DropButton.Size = UDim2.new(1, 0, 1, 0)
                    DropButton.Font = Enum.Font.GothamBold
                    DropButton.Text = ""
                    DropButton.ZIndex = 8

                    -- === FLOATING OVERLAY PANEL ===
                    -- We parent the overlay to the ScreenGui so it floats above everything
                    local screenGui = Dropdown:FindFirstAncestorWhichIsA("ScreenGui")

                    local OverlayPanel = Instance.new("Frame")
                    OverlayPanel.Name = "DropOverlay"
                    OverlayPanel.Parent = screenGui or Dropdown
                    OverlayPanel.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                    OverlayPanel.BorderSizePixel = 0
                    OverlayPanel.Size = UDim2.new(0, 180, 0, math.min(#option * 46 + 8, 220))
                    OverlayPanel.Visible = false
                    OverlayPanel.ZIndex = 100
                    OverlayPanel.ClipsDescendants = true

                    local OverlayCorner = Instance.new("UICorner")
                    OverlayCorner.CornerRadius = UDim.new(0, 8)
                    OverlayCorner.Parent = OverlayPanel

                    local OverlayStroke = Instance.new("UIStroke")
                    OverlayStroke.Color = Color3.fromRGB(60, 60, 80)
                    OverlayStroke.Thickness = 1
                    OverlayStroke.Transparency = 0.5
                    OverlayStroke.Parent = OverlayPanel

                    -- Close (×) button in top-right of the panel
                    local CloseBtn = Instance.new("TextButton")
                    CloseBtn.Name = "CloseBtn"
                    CloseBtn.Parent = OverlayPanel
                    CloseBtn.BackgroundTransparency = 1
                    CloseBtn.Position = UDim2.new(1, -28, 0, 4)
                    CloseBtn.Size = UDim2.new(0, 24, 0, 24)
                    CloseBtn.Font = Enum.Font.GothamBold
                    CloseBtn.Text = "×"
                    CloseBtn.TextColor3 = Color3.fromRGB(190, 190, 210)
                    CloseBtn.TextSize = 18
                    CloseBtn.ZIndex = 102

                    -- Scrolling list of items
                    local DropScroll = Instance.new("ScrollingFrame")
                    DropScroll.Name = "DropScroll"
                    DropScroll.Parent = OverlayPanel
                    DropScroll.Active = true
                    DropScroll.BackgroundTransparency = 1
                    DropScroll.BorderSizePixel = 0
                    DropScroll.Position = UDim2.new(0, 0, 0, 4)
                    DropScroll.Size = UDim2.new(1, 0, 1, -4)
                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                    DropScroll.ScrollBarThickness = 3
                    DropScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
                    DropScroll.ZIndex = 101

                    local UIListLayout = Instance.new("UIListLayout")
                    UIListLayout.Parent = DropScroll
                    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout.Padding = UDim.new(0, 0)

                    local UIPadding = Instance.new("UIPadding")
                    UIPadding.Parent = DropScroll
                    UIPadding.PaddingTop = UDim.new(0, 4)
                    UIPadding.PaddingBottom = UDim.new(0, 4)

local LeftOffset = 213 -- increase this to move more left

local function positionOverlay()
    task.wait()

    local absPos = Dropdown.AbsolutePosition
    local absSize = Dropdown.AbsoluteSize

    OverlayPanel.Position = UDim2.new(
        0,
        absPos.X + absSize.X - LeftOffset,
        0,
        absPos.Y
    )
end
                    -- Helper: open/close the overlay
                    local function openOverlay()
                        positionOverlay()
                        OverlayPanel.Visible = true
                        isdropping = true
                        TweenService:Create(DropImage, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                    end

                    local function closeOverlay()
                        OverlayPanel.Visible = false
                        isdropping = false
                        TweenService:Create(DropImage, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
                    end

                    -- Build option items
                    local UICorner1 = Instance.new("UICorner")

                    for i, v in next, option do
                        local ItemFrame = Instance.new("Frame")
                        ItemFrame.Name = "ItemFrame"
                        ItemFrame.Parent = DropScroll
                        ItemFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                        ItemFrame.BackgroundTransparency = 0
                        ItemFrame.Size = UDim2.new(1, 0, 0, 44)
                        ItemFrame.BorderSizePixel = 0
                        ItemFrame.ZIndex = 101
                        ItemFrame.LayoutOrder = i

                        -- Purple left accent bar (visible only for selected item)
                        local Accent = Instance.new("Frame")
                        Accent.Name = "Accent"
                        Accent.Parent = ItemFrame
                        Accent.BackgroundColor3 = Color3.fromRGB(100, 80, 220)
                        Accent.BorderSizePixel = 0
                        Accent.Position = UDim2.new(0, 0, 0.15, 0)
                        Accent.Size = UDim2.new(0, 3, 0.7, 0)
                        Accent.ZIndex = 102
                        Accent.Visible = (selectedValue == v)

                        local AccentCorner = Instance.new("UICorner")
                        AccentCorner.CornerRadius = UDim.new(0, 2)
                        AccentCorner.Parent = Accent

                        local ItemLabel = Instance.new("TextLabel")
                        ItemLabel.Name = "ItemLabel"
                        ItemLabel.Parent = ItemFrame
                        ItemLabel.BackgroundTransparency = 1
                        ItemLabel.Position = UDim2.new(0, 16, 0, 0)
                        ItemLabel.Size = UDim2.new(1, -16, 1, 0)
                        ItemLabel.Font = (selectedValue == v) and Enum.Font.GothamBold or Enum.Font.Gotham
                        ItemLabel.Text = tostring(v)
                        ItemLabel.TextColor3 = (selectedValue == v) and Color3.fromRGB(230, 230, 255) or Color3.fromRGB(175, 175, 195)
                        ItemLabel.TextSize = 14
                        ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ItemLabel.ZIndex = 102

                        -- Hover effect
                        local ItemBtn = Instance.new("TextButton")
                        ItemBtn.Name = "ItemBtn"
                        ItemBtn.Parent = ItemFrame
                        ItemBtn.BackgroundTransparency = 1
                        ItemBtn.Size = UDim2.new(1, 0, 1, 0)
                        ItemBtn.Font = Enum.Font.Gotham
                        ItemBtn.Text = ""
                        ItemBtn.ZIndex = 103

                        ItemBtn.MouseEnter:Connect(function()
                            if selectedValue ~= v then
                                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 32, 40)}):Play()
                            end
                        end)

                        ItemBtn.MouseLeave:Connect(function()
                            if selectedValue ~= v then
                                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 28)}):Play()
                            end
                        end)

                        ItemBtn.MouseButton1Click:Connect(function()
                            -- Update all accents/labels
                            for _, child in ipairs(DropScroll:GetChildren()) do
                                if child:IsA("Frame") then
                                    local acc = child:FindFirstChild("Accent")
                                    local lbl = child:FindFirstChild("ItemLabel")
                                    if acc then acc.Visible = false end
                                    if lbl then
                                        lbl.Font = Enum.Font.Gotham
                                        lbl.TextColor3 = Color3.fromRGB(175, 175, 195)
                                    end
                                    TweenService:Create(child, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 28)}):Play()
                                end
                            end

                            -- Highlight selected
                            Accent.Visible = true
                            ItemLabel.Font = Enum.Font.GothamBold
                            ItemLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
                            TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 28, 45)}):Play()

                            selectedValue = v
                            DropSub.Text = tostring(v)
                            DropSub.TextColor3 = Color3.fromRGB(200, 200, 220)

                            closeOverlay()
                            callback(v)
                        end)
                    end

                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 8)

                    -- Wire up trigger and close buttons
                    DropButton.MouseButton1Click:Connect(function()
                        if not isdropping then
                            openOverlay()
                        else
                            closeOverlay()
                        end
                    end)

                    CloseBtn.MouseButton1Click:Connect(function()
                        closeOverlay()
                    end)

                    -- Update canvas size when items change
                    UIListLayout.Changed:Connect(function()
                        DropScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 8)
                        OverlayPanel.Size = UDim2.new(0, 200, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 16, 220))
                    end)

                    -- Call default callback if default is valid
                    if default and table.find(option, default) then
                        callback(default)
                    end

                    SectionInfo:Update()

                    local dropfunc = {}
                    function dropfunc:Add(t)
                        local i = #DropScroll:GetChildren()
                        local ItemFrame = Instance.new("Frame")
                        ItemFrame.Name = "ItemFrame"
                        ItemFrame.Parent = DropScroll
                        ItemFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                        ItemFrame.BackgroundTransparency = 0
                        ItemFrame.Size = UDim2.new(1, 0, 0, 44)
                        ItemFrame.BorderSizePixel = 0
                        ItemFrame.ZIndex = 101
                        ItemFrame.LayoutOrder = i

                        local Accent = Instance.new("Frame")
                        Accent.BackgroundColor3 = Color3.fromRGB(100, 80, 220)
                        Accent.BorderSizePixel = 0
                        Accent.Position = UDim2.new(0, 0, 0.15, 0)
                        Accent.Size = UDim2.new(0, 3, 0.7, 0)
                        Accent.ZIndex = 102
                        Accent.Visible = false
                        Accent.Parent = ItemFrame

                        local AccentCorner = Instance.new("UICorner")
                        AccentCorner.CornerRadius = UDim.new(0, 2)
                        AccentCorner.Parent = Accent

                        local ItemLabel = Instance.new("TextLabel")
                        ItemLabel.BackgroundTransparency = 1
                        ItemLabel.Position = UDim2.new(0, 16, 0, 0)
                        ItemLabel.Size = UDim2.new(1, -16, 1, 0)
                        ItemLabel.Font = Enum.Font.Gotham
                        ItemLabel.Text = tostring(t)
                        ItemLabel.TextColor3 = Color3.fromRGB(175, 175, 195)
                        ItemLabel.TextSize = 14
                        ItemLabel.TextXAlignment = Enum.TextXAlignment.Left
                        ItemLabel.ZIndex = 102
                        ItemLabel.Parent = ItemFrame

                        local ItemBtn = Instance.new("TextButton")
                        ItemBtn.BackgroundTransparency = 1
                        ItemBtn.Size = UDim2.new(1, 0, 1, 0)
                        ItemBtn.Font = Enum.Font.Gotham
                        ItemBtn.Text = ""
                        ItemBtn.ZIndex = 103
                        ItemBtn.Parent = ItemFrame

                        ItemBtn.MouseEnter:Connect(function()
                            if selectedValue ~= t then
                                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(32, 32, 40)}):Play()
                            end
                        end)
                        ItemBtn.MouseLeave:Connect(function()
                            if selectedValue ~= t then
                                TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 28)}):Play()
                            end
                        end)
                        ItemBtn.MouseButton1Click:Connect(function()
                            for _, child in ipairs(DropScroll:GetChildren()) do
                                if child:IsA("Frame") then
                                    local acc = child:FindFirstChild("Accent")
                                    local lbl = child:FindFirstChild("ItemLabel")
                                    if acc then acc.Visible = false end
                                    if lbl then lbl.Font = Enum.Font.Gotham; lbl.TextColor3 = Color3.fromRGB(175, 175, 195) end
                                    TweenService:Create(child, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22, 22, 28)}):Play()
                                end
                            end
                            Accent.Visible = true
                            ItemLabel.Font = Enum.Font.GothamBold
                            ItemLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
                            TweenService:Create(ItemFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 28, 45)}):Play()
                            selectedValue = t
                            DropSub.Text = tostring(t)
                            DropSub.TextColor3 = Color3.fromRGB(200, 200, 220)
                            closeOverlay()
                            callback(t)
                        end)
                    end

                    function dropfunc:Clear()
                        selectedValue = nil
                        DropSub.Text = "Choose the tool you want to use"
                        DropSub.TextColor3 = Color3.fromRGB(140, 140, 160)
                        isdropping = false
                        closeOverlay()
                        for _, v in next, DropScroll:GetChildren() do
                            if v:IsA("Frame") then
                                v:Destroy()
                            end
                        end
                    end

                    return dropfunc
                end

                function SectionInfo:AddSlider(config)
    -- Ensure a table is passed
    if type(config) ~= "table" then
        error("AddSlider expects a table")
    end

    -- Extract values from the table, with defaults
    local SliderName = config.Name or "Slider"
    local min = config.min or 0
    local max = config.max or 100
    local de = config.Default or min
    local dallback = config.Callback or function() end

    local SliderValue = Default
                    local sliderfunc = {}

                    -- Outer card
                    local SliderFrame = Instance.new("Frame")
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = Content
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                    SliderFrame.BackgroundTransparency = 0
                    SliderFrame.Size = UDim2.new(0.94, 0, 0, 54)
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.ZIndex = 16

                    local SliderCorner = Instance.new("UICorner")
                    SliderCorner.CornerRadius = UDim.new(0, 8)
                    SliderCorner.Parent = SliderFrame

                    local SliderStroke = Instance.new("UIStroke")
                    SliderStroke.Color = Color3.fromRGB(50, 50, 65)
                    SliderStroke.Thickness = 1
                    SliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    SliderStroke.Parent = SliderFrame

                    local SliderPad = Instance.new("UIPadding")
                    SliderPad.PaddingLeft   = UDim.new(0, 12)
                    SliderPad.PaddingRight  = UDim.new(0, 12)
                    SliderPad.PaddingTop    = UDim.new(0, 10)
                    SliderPad.PaddingBottom = UDim.new(0, 10)
                    SliderPad.Parent = SliderFrame

                    -- Top row: label + value chip
                    local TopRow = Instance.new("Frame")
                    TopRow.Name = "TopRow"
                    TopRow.Parent = SliderFrame
                    TopRow.Size = UDim2.new(1, 0, 0, 16)
                    TopRow.BackgroundTransparency = 1
                    TopRow.ZIndex = 17

                    local LabelNameSlider = Instance.new("TextLabel")
                    LabelNameSlider.Name = "LabelNameSlider"
                    LabelNameSlider.Parent = TopRow
                    LabelNameSlider.BackgroundTransparency = 1
                    LabelNameSlider.Size = UDim2.new(1, -56, 1, 0)
                    LabelNameSlider.Font = Enum.Font.GothamBold
                    LabelNameSlider.Text = tostring(SliderName)
                    LabelNameSlider.TextColor3 = Color3.fromRGB(240, 240, 245)
                    LabelNameSlider.TextSize = 12
                    LabelNameSlider.TextXAlignment = Enum.TextXAlignment.Left
                    LabelNameSlider.ZIndex = 17

                    -- Value chip (pill badge)
                    local Chip = Instance.new("Frame")
                    Chip.Name = "Chip"
                    Chip.Parent = TopRow
                    Chip.AnchorPoint = Vector2.new(1, 0.5)
                    Chip.Position = UDim2.new(1, 0, 0.5, 0)
                    Chip.Size = UDim2.new(0, 50, 0, 19)
                    Chip.BackgroundColor3 = Color3.fromRGB(20, 32, 28)
                    Chip.BorderSizePixel = 0
                    Chip.ZIndex = 17

                    local ChipCorner = Instance.new("UICorner")
                    ChipCorner.CornerRadius = UDim.new(0, 9)
                    ChipCorner.Parent = Chip

                    local ChipStroke = Instance.new("UIStroke")
                    ChipStroke.Color = Color3.fromRGB(60, 160, 130)
                    ChipStroke.Thickness = 1
                    ChipStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    ChipStroke.Parent = Chip

                    local CustomValue = Instance.new("TextBox")
                    CustomValue.Name = "CustomValue"
                    CustomValue.Parent = Chip
                    CustomValue.Size = UDim2.new(1, 0, 1, 0)
                    CustomValue.BackgroundTransparency = 1
                    CustomValue.Font = Enum.Font.GothamBold
                    CustomValue.Text = tostring(de or 0)
                    CustomValue.TextColor3 = Color3.fromRGB(100, 220, 180)
                    CustomValue.TextSize = 11
                    CustomValue.TextXAlignment = Enum.TextXAlignment.Center
                    CustomValue.ClearTextOnFocus = false
                    CustomValue.ZIndex = 17

                    -- Track row
                    local TrackRow = Instance.new("Frame")
                    TrackRow.Name = "TrackRow"
                    TrackRow.Parent = SliderFrame
                    TrackRow.Position = UDim2.new(0, 0, 0, 26)
                    TrackRow.Size = UDim2.new(1, 0, 0, 20)
                    TrackRow.BackgroundTransparency = 1
                    TrackRow.ClipsDescendants = false
                    TrackRow.ZIndex = 17

                    local ValueFrame = Instance.new("Frame")
                    ValueFrame.Name = "ValueFrame"
                    ValueFrame.Parent = TrackRow
                    ValueFrame.AnchorPoint = Vector2.new(0, 0.5)
                    ValueFrame.Position = UDim2.new(0, 0, 0.5, 0)
                    ValueFrame.Size = UDim2.new(1, 0, 0, 6)
                    ValueFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
                    ValueFrame.BorderSizePixel = 0
                    ValueFrame.ZIndex = 16

                    local VFCorner = Instance.new("UICorner")
                    VFCorner.CornerRadius = UDim.new(0, 3)
                    VFCorner.Parent = ValueFrame

                    local pct = math.clamp((de or 0) / math.max(max - min, 1), 0, 1)

                    local MainValue = Instance.new("Frame")
                    MainValue.Name = "MainValue"
                    MainValue.Parent = ValueFrame
                    MainValue.Size = UDim2.new(pct, 0, 1, 0)
                    MainValue.BackgroundColor3 = Color3.fromRGB(100, 220, 180)
                    MainValue.BorderSizePixel = 0
                    MainValue.ZIndex = 17

                    local MVCorner = Instance.new("UICorner")
                    MVCorner.CornerRadius = UDim.new(0, 3)
                    MVCorner.Parent = MainValue

                    -- Thumb
                    local ConneValue = Instance.new("Frame")
                    ConneValue.Name = "ConneValue"
                    ConneValue.Parent = ValueFrame
                    ConneValue.AnchorPoint = Vector2.new(0.5, 0.5)
                    ConneValue.Position = UDim2.new(pct, 0, 0.5, 0)
                    ConneValue.Size = UDim2.new(0, 12, 0, 12)
                    ConneValue.BackgroundColor3 = Color3.fromRGB(100, 220, 180)
                    ConneValue.BorderSizePixel = 0
                    ConneValue.ZIndex = 18

                    local CVCorner = Instance.new("UICorner")
                    CVCorner.CornerRadius = UDim.new(0, 8)
                    CVCorner.Parent = ConneValue

                    local CVStroke = Instance.new("UIStroke")
                    CVStroke.Color = Color3.fromRGB(255, 255, 255)
                    CVStroke.Thickness = 2
                    CVStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    CVStroke.Parent = ConneValue

                    local InnerDot = Instance.new("Frame")
                    InnerDot.Name = "InnerDot"
                    InnerDot.Parent = ConneValue
                    InnerDot.AnchorPoint = Vector2.new(0.5, 0.5)
                    InnerDot.Position = UDim2.new(0.5, 0, 0.5, 0)
                    InnerDot.Size = UDim2.new(0, 5, 0, 5)
                    InnerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    InnerDot.BorderSizePixel = 0
                    InnerDot.ZIndex = 19

                    local InnerCorner = Instance.new("UICorner")
                    InnerCorner.CornerRadius = UDim.new(0, 3)
                    InnerCorner.Parent = InnerDot

                    -- Invisible drag button
                    local DragBtn = Instance.new("TextButton")
                    DragBtn.Name = "DragBtn"
                    DragBtn.Parent = TrackRow
                    DragBtn.AnchorPoint = Vector2.new(0, 0.5)
                    DragBtn.Position = UDim2.new(0, 0, 0.5, 0)
                    DragBtn.Size = UDim2.new(1, 0, 1, 12)
                    DragBtn.BackgroundTransparency = 1
                    DragBtn.Text = ""
                    DragBtn.ZIndex = 20

                    local currentVal = de or 0

                    local function setAndTweenValue(val)
                        val = math.clamp(val, min, max)
                        local rel = (val - min) / (max - min)
                        currentVal = val
                        local newStr = tostring(math.floor(val))
                        CustomValue.Text = newStr
                        TweenService:Create(MainValue, TweenInfo.new(0.12), {Size = UDim2.new(rel, 0, 1, 0)}):Play()
                        TweenService:Create(ConneValue, TweenInfo.new(0.12), {Position = UDim2.new(rel, 0, 0.5, 0)}):Play()
                        pcall(callback, val)
                    end

                    local function move(inputX)
                        local rel = math.clamp((inputX - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1)
                        local val = math.floor(min + (max - min) * rel)
                        setAndTweenValue(val)
                    end

                    -- Connecting the new TextBox FocusLost event
                    CustomValue.FocusLost:Connect(function()
                        local num = tonumber(CustomValue.Text)
                        if num then
                            setAndTweenValue(num)
                        else
                            setAndTweenValue(min)
                        end
                    end)
                    CustomValue.Focused:Connect(function()
                        TweenService:Create(chipStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(100, 220, 180)}):Play()
                    end)
                    CustomValue.FocusLost:Connect(function()
                        TweenService:Create(chipStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 65, 50)}):Play()
                    end)

                    local dragging = false

                    DragBtn.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = true
                            move(input.Position.X)
                            TweenService:Create(ConneValue, TweenInfo.new(0.1), {Size = UDim2.new(0, 20, 0, 20), BackgroundColor3 = Color3.fromRGB(80, 255, 200)}):Play()
                        end
                    end)
                    DragBtn.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            TweenService:Create(ConneValue, TweenInfo.new(0.1), {Size = UDim2.new(0, 16, 0, 16), BackgroundColor3 = Color3.fromRGB(100, 220, 180)}):Play()
                        end
                    end)
                    DragBtn.MouseEnter:Connect(function()
                        if not dragging then
                            TweenService:Create(ConneValue, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(80, 255, 200)}):Play()
                        end
                    end)
                    DragBtn.MouseLeave:Connect(function()
                        if not dragging then
                            TweenService:Create(ConneValue, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 220, 180)}):Play()
                        end
                    end)

                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                            move(input.Position.X)
                        end
                    end)

                    function sliderfunc:Update(value)
                        local val = tonumber(value) or min
                        setAndTweenValue(val)
                    end

                    SectionInfo:Update()
                    return sliderfunc
                end


                function SectionInfo:AddButton(config)

    if type(config) ~= "table" then
        error("AddButton expects a table")
    end
    local ButtonName = config.Title or "Button"
    local callback = config.callback or function() end
    
                    local Button = Instance.new("Frame")
                    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
                    local ButtonMainFrame = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local UIGradient = Instance.new("UIGradient")
                    local Text = Instance.new("TextLabel")

                    Button.Name = "Button"
                    Button.Parent = Content
                    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Button.BackgroundTransparency = 1.000
                    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Button.BorderSizePixel = 0
                    Button.Size = UDim2.new(0.980000019, 0, 0.5, 1)
                    Button.ZIndex = 5

                    UIAspectRatioConstraint.Parent = Button
                    UIAspectRatioConstraint.AspectRatio = 15.800
                    UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

                    ButtonMainFrame.Name = "ButtonMainFrame"
                    ButtonMainFrame.Parent = Button
                    ButtonMainFrame.AnchorPoint = Vector2.new(0.5, 0)
                    ButtonMainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonMainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ButtonMainFrame.BorderSizePixel = 0
                    ButtonMainFrame.Position = UDim2.new(0.5, 0, 0, 0)
                    ButtonMainFrame.Size = UDim2.new(0.949999988, 0, 1, 0)
                    ButtonMainFrame.ZIndex = 6

                    UICorner.CornerRadius = UDim.new(0, 3)
                    UICorner.Parent = ButtonMainFrame

                    UIGradient.Color =
                        ColorSequence.new {
                        ColorSequenceKeypoint.new(0.00, Alc.Config.MainColor),
                        ColorSequenceKeypoint.new(1.00, Alc.Config.DropColor)
                    }
                    UIGradient.Rotation = 90
                    UIGradient.Parent = ButtonMainFrame

                    Text.Name = "Text"
                    Text.Parent = ButtonMainFrame
                    Text.AnchorPoint = Vector2.new(0.5, 0.5)
                    Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Text.BackgroundTransparency = 1.000
                    Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Text.BorderSizePixel = 0
                    Text.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Text.Size = UDim2.new(1, 0, 0.600000024, 0)
                    Text.ZIndex = 6
                    Text.Font = Enum.Font.GothamBold
                    Text.Text = ButtonName or "Sea Event"
                    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Text.TextScaled = false
                    Text.TextSize = 14.000
                    Text.TextWrapped = true

                    local c = cretate_button(ButtonMainFrame)

                    c.MouseButton1Down:Connect(
                        function()
                            TweenService:Create(UIGradient, TweenInfo.new(0.1), {Offset = Vector2.new(0, 1)}):Play()
                        end
                    )

                    c.MouseButton1Up:Connect(
                        function()
                            TweenService:Create(UIGradient, TweenInfo.new(0.1), {Offset = Vector2.new(0, 0)}):Play()
                        end
                    )

                    c.MouseButton1Click:Connect(callback)

                    local Config = {}

                    function Config:Text(...)
                        Text.Text = tostring(...)
                    end

                    function Config:Fire(...)
                        callback(...)
                    end

                    function Config:Delete()
                        Button:Destroy()
                        UpdateSiz()
                    end

                    return Config
                end
                return SectionInfo
            end

            return MainTab
        end

        return MenuAlc
    end
    return WindowAlc
end


local MarketplaceService = game:GetService("MarketplaceService")
local gameName = "Unknown"
pcall(function()
	local info = MarketplaceService:GetProductInfo(game.PlaceId)
	gameName = info.Name
end)
local Window = Alc:NewWindow(
    "Version : 2.1 / " .. gameName, 
    'rbxassetid://116422175458617'
)

local MenuFunctions = Window:AddMenu()


local tab2 = MenuFunctions:AddTab("Configs Farm", 10734950020)
local tab3 = MenuFunctions:AddTab("Main Farm", 10723407389)
local Tab_3 = MenuFunctions:AddTab("Items Farm", 15557776256)
local Stats = MenuFunctions:AddTab("Local Player", 10709770431)
local Events = MenuFunctions:AddTab("Sea Events", 10734941354)
local dragons = MenuFunctions:AddTab("Dragon Events", 105643281470017)
local Racev4 = MenuFunctions:AddTab("Race V4", 14477517268)
local Tab_4 = MenuFunctions:AddTab("Dungeon Raid", 10734932295)
local Tab_5 = MenuFunctions:AddTab("Island Travel", 10734886004)
local Tab_6 = MenuFunctions:AddTab("Stores", 10734952479)
local Tab_7 = MenuFunctions:AddTab("Miscellaneous", 10734949856)
local Tab_8 = MenuFunctions:AddTab("Fun Visual", 6034467796)

local Home_Left = tab2:AddSection("Info and Ui settings")

Home_Left:PlayerInfo(game.Players.LocalPlayer)
Home_Left:UICreators()

-- UI Theme Preset
Home_Left:AddDropdown({
    Name = "UI Theme",
    Description = "Change Zen UI theme colors",
    option = { "Aqua (Default)", "Purple", "Red" },
    default = "Aqua (Default)",
    callback = function(selected)
        if selected == "Purple" then
            Alc:SetTheme(Color3.fromRGB(180, 130, 255), Color3.fromRGB(80, 60, 120))
        elseif selected == "Red" then
            Alc:SetTheme(Color3.fromRGB(255, 90, 90), Color3.fromRGB(120, 50, 50))
        else
            Alc:SetTheme(Color3.fromRGB(127, 255, 212), Color3.fromRGB(121, 111, 121))
        end
    end
})

-- UI Size Scale (50%–150%)
Home_Left:AddSlider({
    Name = "UI Size Scale",
    min = 50,
    max = 150,
    default = 100,
    callback = function(v)
        local scale = v / 100
        local base = UDim2.new(0.000009, 530, 0.01, 350)
        local newSize = UDim2.new(
            base.X.Scale,
            base.X.Offset * scale,
            base.Y.Scale,
            base.Y.Offset * scale
        )
        Alc:SetUISize(newSize)
    end
})

-- UI Opacity (0–100%)
Home_Left:AddSlider({
    Name = "UI Opacity",
    min = 0,
    max = 100,
    default = 100,
    callback = function(v)
        Alc:SetUIOpacity(v / 100)
    end
})