-- Load library
local ts = game:GetService("TweenService")
local ui = game:GetService("UserInputService")
local plr = game:GetService("Players")
local lg = game:GetService("Lighting")
local rs = game:GetService("RunService")
local gs = game:GetService("GuiService")
local hs = game:GetService("HttpService")

local n = "Acrylic"

local c = {
    Background = Color3.fromRGB(28, 30, 34), -- main panel
    Secondary = Color3.fromRGB(34, 36, 40), -- cards / sections
    Border = Color3.fromRGB(55, 58, 64), -- subtle border

    Text = Color3.fromRGB(235, 235, 235),
    TextDark = Color3.fromRGB(160, 165, 170),
    TextFade = Color3.fromRGB(20, 22, 25),

    Accent = Color3.fromRGB(0, 120, 255), -- soft blue (like buttons)

    Toggle = {
        Enabled = Color3.fromRGB(0, 120, 255),
        Disabled = Color3.fromRGB(50, 52, 56),
        Circle = Color3.fromRGB(200, 200, 200)
    },

    Notification = {
        Background = Color3.fromRGB(30, 32, 36),
        Border = Color3.fromRGB(70, 75, 80),
        Timer = Color3.fromRGB(0, 120, 255)
    }
}

local s = {
    v0rtexd = {Width = 600, Height = 400},
    Minv0rtexd = {Width = 500, Height = 300},
    Maxv0rtexd = {Width = 1200, Height = 800},
    Toggle = {Width = 38, Height = 21, Circle = 13},
    Button = {Height = 39},
    Slider = {Height = 46},
    Dropdown = {Height = 39, OptionHeight = 30},
    Tab = {Width = 135, Height = 35},
    ColorPicker = {Width = 180, Height = 160},
    Notification = {Width = 220, Height = 70},
    TextBox = {Height = 39, InputWidth = 150}
}

local f = {
    Regular = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
    Bold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
}

local textsize = {
    Title = 16,
    Normal = 14,
    Small = 13,
    Tiny = 11
}

local animationspeed = {
    Fast = 0.1,
    Normal = 0.15,
    Slow = 0.2,
    VerySlow = 0.3
}

local Library = {}
Library.__index = Library

local Connections = {}
local NotificationQueue = {}
local NotificationContainer = nil

local function CreateTween(instance, properties, duration, easingStyle, easingDirection)
    local tween = ts:Create(
        instance,
        TweenInfo.new(
            duration or animationspeed.Normal,
            easingStyle or Enum.EasingStyle.Quad,
            easingDirection or Enum.EasingDirection.Out
        ),
        properties
    )
    tween:Play()
    return tween
end

local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            instance[property] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function CreateCorner(parent, radius)
    return CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, radius or 5),
        Parent = parent
    })
end

local function CreateStroke(parent, color, transparency)
    return CreateInstance("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = color or c.Border,
        Transparency = transparency or 0,
        Thickness = 1,
        Parent = parent
    })
end

local function CreatePadding(parent, top, bottom, left, right)
    return CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        Parent = parent
    })
end

local function CreateListLayout(parent, padding, sortOrder, direction)
    return CreateInstance("UIListLayout", {
        Padding = UDim.new(0, padding or 0),
        SortOrder = sortOrder or Enum.SortOrder.LayoutOrder,
        FillDirection = direction or Enum.FillDirection.Vertical,
        Parent = parent
    })
end

local function IsMobileDevice()
    return ui.TouchEnabled and not ui.KeyboardEnabled
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, dragStart, startPos
    handle = handle or frame

    local function OnInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end

    local function OnInputChanged(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end

    handle.InputBegan:Connect(OnInputBegan)
    handle.InputChanged:Connect(OnInputChanged)

    ui.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

local function DisconnectAll()
    for _, connection in pairs(Connections) do
        if typeof(connection) == "RBXScriptConnection" then
            connection:Disconnect()
        end
    end
    Connections = {}
end

local function GetConfigFolder(configName)
    return "AcrylicConfigs/" .. configName
end

local function EnsureConfigFolder()
    if isfolder and not isfolder("AcrylicConfigs") then
        makefolder("AcrylicConfigs")
    end
end

local function GetAvailableConfigs()
    local configs = {}
    if isfolder and listfiles then
        EnsureConfigFolder()
        local files = listfiles("AcrylicConfigs")
        for _, file in ipairs(files) do
            local name = file:match("AcrylicConfigs/(.+)%.json$") or file:match("AcrylicConfigs\\(.+)%.json$")
            if name then
                table.insert(configs, name)
            end
        end
    end
    return configs
end

local AcrylicBlur = {}
AcrylicBlur.__index = AcrylicBlur

function AcrylicBlur.new(object)
    local self = setmetatable({
        _object = object,
        _folder = nil,
        _root = nil,
        _frame = nil,
        _dof = nil,
        _enabled = true
    }, AcrylicBlur)
    self:_Initialize()
    return self
end

function AcrylicBlur:_CreateDepthOfField()
    local existingDOF = lg:FindFirstChild("AcrylicBlur")
    if existingDOF then
        existingDOF:Destroy()
    end
    local existingBlur = lg:FindFirstChild("AcrylicBlurEffect")
    if existingBlur then
        existingBlur:Destroy()
    end
    
    local dof = CreateInstance("DepthOfFieldEffect", {
        Name = "AcrylicBlur",
        FarIntensity = 0,
        FocusDistance = 0.05,
        InFocusRadius = 0.1,
        NearIntensity = 0.5, 
        Parent = lg
    })
    
    self._dof = dof
    return dof
end

function AcrylicBlur:_CreateFolder()
    local existingFolder = workspace.CurrentCamera:FindFirstChild("AcrylicBlur")
    if existingFolder then
        existingFolder:Destroy()
    end
    self._folder = CreateInstance("Folder", {
        Name = "AcrylicBlur",
        Parent = workspace.CurrentCamera
    })
end

function AcrylicBlur:_CreateRoot()
    local part = CreateInstance("Part", {
        Name = "Root",
        Color = Color3.new(0, 0, 0),
        Material = Enum.Material.Glass,
        Size = Vector3.new(1, 1, 0),
        Anchored = true,
        CanCollide = false,
        CanQuery = false,
        Locked = true,
        CastShadow = false,
        Transparency = 0.95, 
        Parent = self._folder
    })
    CreateInstance("SpecialMesh", {
        MeshType = Enum.MeshType.Brick,
        Parent = part
    })
    self._root = part
end

function AcrylicBlur:_CreateFrame()
    self._frame = CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Parent = self._object
    })
end

function AcrylicBlur:_Render(distance)
    distance = distance or 0.001
    local positions = {
        top_left = Vector2.new(),
        top_right = Vector2.new(),
        bottom_right = Vector2.new()
    }

    local function ViewportToWorld(location, dist)
        local ray = workspace.CurrentCamera:ScreenPointToRay(location.X, location.Y)
        return ray.Origin + ray.Direction * dist
    end

    local function GetOffset()
        local viewY = workspace.CurrentCamera.ViewportSize.Y
        return (viewY / 2560) * 24 + 4
    end

    local function UpdatePositions(size, position)
        positions.top_left = position
        positions.top_right = position + Vector2.new(size.X, 0)
        positions.bottom_right = position + size
    end

    local function Update()
        if not self._root or not self._enabled then return end
        local tl = ViewportToWorld(positions.top_left, distance)
        local tr = ViewportToWorld(positions.top_right, distance)
        local br = ViewportToWorld(positions.bottom_right, distance)
        local width = (tr - tl).Magnitude
        local height = (tr - br).Magnitude
        self._root.CFrame = CFrame.fromMatrix(
            (tl + br) / 2,
            workspace.CurrentCamera.CFrame.XVector,
            workspace.CurrentCamera.CFrame.YVector,
            workspace.CurrentCamera.CFrame.ZVector
        )
        self._root.Mesh.Scale = Vector3.new(width, height, 0)
    end

    local function OnChange()
        if not self._enabled then return end
        local offset = GetOffset()
        local size = self._frame.AbsoluteSize - Vector2.new(offset, offset)
        local position = self._frame.AbsolutePosition + Vector2.new(offset / 2, offset / 2)
        UpdatePositions(size, position)
        task.spawn(Update)
    end

    Connections["blur_cframe"] = workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Connect(Update)
    Connections["blur_viewport"] = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(Update)
    Connections["blur_fov"] = workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(Update)
    Connections["blur_pos"] = self._frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(OnChange)
    Connections["blur_size"] = self._frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(OnChange)
    Connections["blur_render"] = rs.RenderStepped:Connect(Update)
    task.spawn(OnChange)
end

function AcrylicBlur:_Initialize()
    self:_CreateDepthOfField()
    self:_CreateFolder()
    self:_CreateRoot()
    self:_CreateFrame()
    self:_Render(0.001)
end

function AcrylicBlur:SetEnabled(enabled)
    self._enabled = enabled
    if self._root then
        self._root.Transparency = enabled and 0.95 or 1
    end
    if self._dof then
        self._dof.Enabled = enabled
    end
end

function AcrylicBlur:Destroy()
    if self._folder then
        self._folder:Destroy()
    end
    local dof = lg:FindFirstChild("AcrylicBlur")
    if dof then
        dof:Destroy()
    end
    local blur = lg:FindFirstChild("AcrylicBlurEffect")
    if blur then
        blur:Destroy()
    end
end

local function CreateNotificationContainer(screenGui)
    if NotificationContainer then return NotificationContainer end
    NotificationContainer = CreateInstance("Frame", {
        Name = "NotificationContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -240, 0, 20),
        Size = UDim2.new(0, 220, 1, -40),
        Parent = screenGui
    })
    CreateListLayout(NotificationContainer, 10, Enum.SortOrder.LayoutOrder, Enum.FillDirection.Vertical)
    return NotificationContainer
end

function Library.new(title, configFolder)
    local self = setmetatable({}, Library)
    self.title = title or "Acrylic"
    self.configFolder = configFolder or title or "Acrylic"
    self.sections = {}
    self.currentTab = nil
    self.minimized = false
    self._acrylicBlur = nil
    self._keybinds = {}
    self._toggleKey = Enum.KeyCode.RightControl
    self._visible = true
    self._originalHeight = s.v0rtexd.Height
    self._minSize = Vector2.new(s.Minv0rtexd.Width, s.Minv0rtexd.Height)
    self._maxSize = Vector2.new(s.Maxv0rtexd.Width, s.Maxv0rtexd.Height)
    self._mobileToggle = nil
    self._configElements = {}
    self._autoSave = false
    self._currentConfig = "default"
    self:_CreateMainv0rtexd()
    self:_SetupKeybindListener()
    self:_SetupMobileSupport()
    CreateNotificationContainer(self.screenGui)
    return self
end

function Library:Notify(config)
    local title = config.Title or "Notification"
    local description = config.Description or ""
    local duration = config.Duration or 3
    local icon = config.Icon or "rbxassetid://10709775704"

    local notification = CreateInstance("Frame", {
        Name = "Notification",
        BackgroundColor3 = c.Notification.Background,
        Position = UDim2.new(1, 20, 0, 0),
        Size = UDim2.new(1, 0, 0, s.Notification.Height),
        ClipsDescendants = true,
        Parent = NotificationContainer
    })
    CreateCorner(notification, 4)
    CreateInstance("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = c.Notification.Border,
        Thickness = 1.5,
        Parent = notification
    })

    
    local titleLabel = CreateInstance("TextLabel", {
        Name = "Title",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = title,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 16),
        TextSize = textsize.Normal,
        Size = UDim2.new(1, -60, 0, 19),
        Parent = notification
    })
    local descriptionLabel = CreateInstance("TextLabel", {
        Name = "Description",
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = description,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 14, 0, 38),
        TextSize = textsize.Normal,
        Size = UDim2.new(1, -60, 0, 19),
        Parent = notification
    })
    local iconImage = CreateInstance("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = icon,
        Position = UDim2.new(1, -33, 0, 23),
        Size = UDim2.new(0, 19, 0, 19),
        Parent = notification
    })
    CreateInstance("UIAspectRatioConstraint", {
        Parent = iconImage
    })
    local timerBar = CreateInstance("Frame", {
        Name = "Timer",
        BackgroundColor3 = c.Notification.Timer,
        Position = UDim2.new(0, 0, 1, -3),
        Size = UDim2.new(1, 0, 0, 3),
        Parent = notification
    })
    CreateCorner(timerBar, 100)
    CreateTween(notification, {Position = UDim2.new(0, 0, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    CreateTween(timerBar, {Size = UDim2.new(0, 0, 0, 3)}, duration, Enum.EasingStyle.Linear)
    task.delay(duration, function()
        CreateTween(notification, {Position = UDim2.new(1, 20, 0, 0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.3)
        notification:Destroy()
    end)
    return notification
end

function Library:_SetupKeybindListener()
    Connections["keybind_listener"] = ui.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self._toggleKey then
            self:Toggle()
        end
        for _, keybindData in pairs(self._keybinds) do
            if input.KeyCode == keybindData.key then
                keybindData.callback()
            end
        end
    end)
end

function Library:Toggle()
    self._visible = not self._visible
    self.container.Visible = self._visible
    
    if self._acrylicBlur then
        self._acrylicBlur:SetEnabled(self._visible)
    end
    
    if self._mobileToggle then
        self._mobileToggle.Visible = not self._visible
    end
end

function Library:SetToggleKey(keyCode)
    self._toggleKey = keyCode
end

function Library:_SetupMobileSupport()
    local mobileButton = CreateInstance("ImageButton", {
        Name = "MobileToggle",
        Image = "rbxassetid://112235310154264",
        ImageColor3 = c.Text,
        BackgroundColor3 = c.Background,
        BackgroundTransparency = 0.1,
        Position = UDim2.new(0, 15, 0.5, -25),
        Size = UDim2.new(0, 50, 0, 50),
        AnchorPoint = Vector2.new(0, 0.5),
        Visible = false,
        ZIndex = 999,
        Parent = self.screenGui
    })
    CreateCorner(mobileButton, 25)
    CreateStroke(mobileButton)
    
    local dragging = false
    local dragStart, startPos
    
    mobileButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mobileButton.Position
        end
    end)
    
    mobileButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                local delta = input.Position - dragStart
                if delta.Magnitude < 10 then
                    self:Toggle()
                end
            end
            dragging = false
        end
    end)
    
    ui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            mobileButton.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    self._mobileToggle = mobileButton
    
    if IsMobileDevice() then
        mobileButton.Visible = not self._visible
    end
end

function Library:_CreateMainv0rtexd()
    self.screenGui = CreateInstance("ScreenGui", {
        Name = n,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })

    self.container = CreateInstance("Frame", {
        Name = "Container",
        BackgroundColor3 = c.Background,
        BackgroundTransparency = 0.05,
        Position = UDim2.new(0.5, -s.v0rtexd.Width / 2, 0.5, -s.v0rtexd.Height / 2),
        BorderSizePixel = 0,
        Size = UDim2.new(0, s.v0rtexd.Width, 0, s.v0rtexd.Height),
        ClipsDescendants = false,
        Parent = self.screenGui
    })

    CreateCorner(self.container, 5)
    CreateStroke(self.container)

    self.topBar = CreateInstance("Frame", {
        Name = "TopBar",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 45),
        Parent = self.container
    })



    self.titleLabel = CreateInstance("TextLabel", {
        Name = "Title",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = self.title,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 10),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = textsize.Title,
        RichText = true,
        Size = UDim2.new(0, 150, 0, 25),
        Parent = self.topBar
    })


    self:_Createv0rtexdControls()

    CreateInstance("Frame", {
        Name = "Header",
        BackgroundColor3 = c.Border,
        Position = UDim2.new(0, 0, 0, 45),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        Parent = self.container
    })

    self:_CreateContentArea()
    MakeDraggable(self.container, self.topBar)

    local player = plr.LocalPlayer
    self.screenGui.Parent = player:WaitForChild("PlayerGui")
    self._acrylicBlur = AcrylicBlur.new(self.container)
end

function Library:_Createv0rtexdControls()
    local minimizeBtn = CreateInstance("ImageLabel", {
        Name = "Minimize",
        ImageColor3 = c.TextDark,
        Image = "rbxassetid://72537100913553",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -35, 0, 10),
        Size = UDim2.new(0, 25, 0, 25),
        Parent = self.topBar
    })

    local minimizeClickArea = CreateInstance("TextButton", {
        Name = "TextButton",
        Text = "",
        Rotation = 0.01,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 21, 0, 15),
        Parent = minimizeBtn
    })

    minimizeClickArea.MouseButton1Click:Connect(function()
        self:_ToggleMinimize()
    end)

    minimizeBtn.MouseEnter:Connect(function()
        CreateTween(minimizeBtn, {ImageColor3 = c.Text}, animationspeed.Fast)
    end)

    minimizeBtn.MouseLeave:Connect(function()
        CreateTween(minimizeBtn, {ImageColor3 = c.TextDark}, animationspeed.Fast)
    end)

    local closeBtn = CreateInstance("ImageButton", {
        Name = "Close",
        ImageColor3 = c.TextDark,
        Image = "rbxassetid://79737394637933",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 10),
        Size = UDim2.new(0, 25, 0, 25),
        Parent = self.topBar
    })

    closeBtn.MouseButton1Click:Connect(function()
        self:Destroy()
    end)

    closeBtn.MouseEnter:Connect(function()
        CreateTween(closeBtn, {ImageColor3 = Color3.fromRGB(255, 100, 100)}, animationspeed.Fast)
    end)

    closeBtn.MouseLeave:Connect(function()
        CreateTween(closeBtn, {ImageColor3 = c.TextDark}, animationspeed.Fast)
    end)

    local resizeBtn = CreateInstance("ImageButton", {
        Name = "Resize",
        ImageColor3 = Color3.fromRGB(110, 110, 110),
        Image = "rbxassetid://120997033468887",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(1, -5, 1, -5),
        Size = UDim2.new(0, 62, 0, 60),
        BorderSizePixel = 0,
        Parent = self.container
    })

    self.resizeBtn = resizeBtn
    self:_SetupSmartResize(resizeBtn)
end

function Library:_CreateContentArea()
    self.mainContent = CreateInstance("Frame", {
        Name = "MainContent",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 46),
        Size = UDim2.new(1, 0, 1, -46),
        ClipsDescendants = true,
        Parent = self.container
    })

    self.sectionsContainer = CreateInstance("ScrollingFrame", {
        Name = "SectionsContainer",
        ScrollBarThickness = 0,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 165, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = self.mainContent
    })
    CreateListLayout(self.sectionsContainer, 0, Enum.SortOrder.LayoutOrder)
    CreatePadding(self.sectionsContainer, 5, 5, 5, 5)

    CreateInstance("Frame", {
        Name = "Separator",
        BackgroundColor3 = c.Border,
        Position = UDim2.new(0, 165, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 1, 1, 0),
        Parent = self.mainContent
    })

    self.contentContainer = CreateInstance("ScrollingFrame", {
        Name = "ContentContainer",
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 166, 0, 0),
        Size = UDim2.new(1, -166, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent = self.mainContent
    })
    CreateListLayout(self.contentContainer, 8, Enum.SortOrder.LayoutOrder)
    CreatePadding(self.contentContainer, 10, 10, 15, 15)
end

function Library:_SetupSmartResize(handle)
    local resizing = false
    local resizeStart, startSize, startPos

    handle.MouseEnter:Connect(function()
        CreateTween(handle, {ImageColor3 = c.Text}, animationspeed.Fast)
    end)

    handle.MouseLeave:Connect(function()
        if not resizing then
            CreateTween(handle, {ImageColor3 = Color3.fromRGB(110, 110, 110)}, animationspeed.Fast)
        end
    end)

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            startSize = self.container.AbsoluteSize
            startPos = self.container.AbsolutePosition
            self._originalHeight = startSize.Y

            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                    CreateTween(handle, {ImageColor3 = Color3.fromRGB(110, 110, 110)}, animationspeed.Fast)
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end
    end)

    ui.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local newWidth = math.clamp(startSize.X + delta.X, self._minSize.X, self._maxSize.X)
            local newHeight = math.clamp(startSize.Y + delta.Y, self._minSize.Y, self._maxSize.Y)
            self.container.Size = UDim2.new(0, newWidth, 0, newHeight)
            self._originalHeight = newHeight
        end
    end)
end

function Library:_ToggleMinimize()
    self.minimized = not self.minimized
    if self.minimized then
        if self._acrylicBlur then
            self._acrylicBlur:SetEnabled(false)
        end
        CreateTween(self.mainContent, {Size = UDim2.new(1, 0, 0, 0)}, animationspeed.Slow)
        CreateTween(self.container, {Size = UDim2.new(0, self.container.AbsoluteSize.X, 0, 45)}, animationspeed.Slow)
        if self.resizeBtn then
            self.resizeBtn.Visible = false
        end
    else
        if self._acrylicBlur then
            self._acrylicBlur:SetEnabled(true)
        end
        CreateTween(self.container, {Size = UDim2.new(0, self.container.AbsoluteSize.X, 0, self._originalHeight)}, animationspeed.Slow)
        task.delay(0.1, function()
            CreateTween(self.mainContent, {Size = UDim2.new(1, 0, 1, -46)}, animationspeed.Normal)
        end)
        if self.resizeBtn then
            self.resizeBtn.Visible = true
        end
    end
end

function Library:Destroy()
    if self._autoSave then
        self:SaveConfig(self._currentConfig)
    end
    
    DisconnectAll()
    if self._acrylicBlur then
        self._acrylicBlur:Destroy()
    end
    if self.screenGui then
        self.screenGui:Destroy()
    end
end


function Library:_RegisterConfigElement(id, elementType, getValue, setValue)
    self._configElements[id] = {
        type = elementType,
        getValue = getValue,
        setValue = setValue
    }
end

function Library:SaveConfig(configName)
    if not writefile then
        self:Notify({
            Title = "Error",
            Description = "Config system not supported",
            Duration = 3
        })
        return false
    end
    
    EnsureConfigFolder()
    
    local configData = {}
    for id, element in pairs(self._configElements) do
        local value = element.getValue()
        
        if typeof(value) == "Color3" then
            value = {R = value.R, G = value.G, B = value.B, _type = "Color3"}
        elseif typeof(value) == "EnumItem" then
            value = {_type = "EnumItem", _enum = tostring(value.EnumType), _value = value.Name}
        end
        
        configData[id] = value
    end
    
    local success, err = pcall(function()
        writefile("AcrylicConfigs/" .. configName .. ".json", hs:JSONEncode(configData))
    end)
    
    if success then
        self._currentConfig = configName
        self:Notify({
            Title = "Config Saved",
            Description = "Saved as: " .. configName,
            Duration = 2,
            Icon = "rbxassetid://10723356507"
        })
        return true
    else
        self:Notify({
            Title = "Error",
            Description = "Failed to save config",
            Duration = 3
        })
        return false
    end
end

function Library:LoadConfig(configName)
    if not readfile or not isfile then
        self:Notify({
            Title = "Error",
            Description = "Config system not supported",
            Duration = 3
        })
        return false
    end
    
    local path = "AcrylicConfigs/" .. configName .. ".json"
    if not isfile(path) then
        self:Notify({
            Title = "Error",
            Description = "Config not found: " .. configName,
            Duration = 3
        })
        return false
    end
    
    local success, data = pcall(function()
        return hs:JSONDecode(readfile(path))
    end)
    
    if not success or not data then
        self:Notify({
            Title = "Error",
            Description = "Failed to load config",
            Duration = 3
        })
        return false
    end
    
    for id, value in pairs(data) do
        if self._configElements[id] then
            if type(value) == "table" and value._type == "Color3" then
                value = Color3.new(value.R, value.G, value.B)
            elseif type(value) == "table" and value._type == "EnumItem" then
                value = Enum[value._enum][value._value]
            end
            
            pcall(function()
                self._configElements[id].setValue(value)
            end)
        end
    end
    
    self._currentConfig = configName
    self:Notify({
        Title = "Config Loaded",
        Description = "Loaded: " .. configName,
        Duration = 2,
        Icon = "rbxassetid://10723356507"
    })
    return true
end

function Library:DeleteConfig(configName)
    if not delfile or not isfile then
        return false
    end
    
    local path = "AcrylicConfigs/" .. configName .. ".json"
    if isfile(path) then
        delfile(path)
        self:Notify({
            Title = "Config Deleted",
            Description = "Deleted: " .. configName,
            Duration = 2
        })
        return true
    end
    return false
end

function Library:GetConfigs()
    return GetAvailableConfigs()
end

function Library:SetAutoSave(enabled)
    self._autoSave = enabled
    if enabled then
        task.spawn(function()
            while self._autoSave and self.screenGui and self.screenGui.Parent do
                task.wait(30)
                if self._autoSave then
                    self:SaveConfig(self._currentConfig)
                end
            end
        end)
    end
end

function Library:CreateSection(name)
    local section = {
        name = name,
        tabs = {},
        expanded = true,
        _library = self
    }

    local sectionFrame = CreateInstance("Frame", {
        Name = "Section_" .. name,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = self.sectionsContainer
    })
    CreateListLayout(sectionFrame, 2, Enum.SortOrder.LayoutOrder)

    local headerContainer = CreateInstance("Frame", {
        Name = "HeaderContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 25),
        LayoutOrder = 0,
        Parent = sectionFrame
    })

    local headerBtn = CreateInstance("TextButton", {
        Name = "Header",
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = "",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = headerContainer
    })

    local headerLabel = CreateInstance("TextLabel", {
        Name = "Label",
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 0),
        TextSize = textsize.Small,
        Size = UDim2.new(1, -25, 1, 0),
        Parent = headerContainer
    })

    local arrow = CreateInstance("ImageButton", {
        Name = "Arrow",
        Image = "rbxassetid://105558791071013",
        ImageColor3 = c.TextDark,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20, 0.5, -7),
        Size = UDim2.new(0, 15, 0, 15),
        Rotation = 0,
        Parent = headerContainer
    })

    local tabsContainer = CreateInstance("Frame", {
        Name = "TabsContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true,
        LayoutOrder = 1,
        Parent = sectionFrame
    })
    CreateListLayout(tabsContainer, 2, Enum.SortOrder.LayoutOrder)
    CreatePadding(tabsContainer, 0, 0, 15, 0)

    local function ToggleSection()
        section.expanded = not section.expanded
        CreateTween(arrow, {Rotation = section.expanded and 0 or 180}, animationspeed.Normal)
        tabsContainer.Visible = section.expanded
    end

    headerBtn.MouseButton1Click:Connect(ToggleSection)
    arrow.MouseButton1Click:Connect(ToggleSection)

    section.frame = sectionFrame
    section.tabsContainer = tabsContainer
    table.insert(self.sections, section)

    local sectionMethods = setmetatable({}, {__index = section})

    function sectionMethods:CreateTab(tabName, icon)
        return Library._CreateTab(self, tabName, icon)
    end

    return sectionMethods
end

function Library:CreateDualSection(nameLeft, nameRight)
    local dual = {
        _library = self,
        leftTabs = {},
        rightTabs = {},
    }

    -- Outer wrapper inside sectionsContainer
    local dualFrame = CreateInstance("Frame", {
        Name = "DualSection_" .. nameLeft .. "_" .. nameRight,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = self.sectionsContainer,
    })
    CreateListLayout(dualFrame, 4, Enum.SortOrder.LayoutOrder)

    -- ── Helper: build one column ──────────────────────────────────────
    local function BuildColumn(colName, tabsList)
        local colWrap = CreateInstance("Frame", {
            Name = "Col_" .. colName,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = dualFrame,
        })
        CreateListLayout(colWrap, 2, Enum.SortOrder.LayoutOrder)

        -- Section header
        local headerCon = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 22),
            LayoutOrder = 0,
            Parent = colWrap,
        })

        CreateInstance("TextLabel", {
            FontFace = f.Regular,
            TextColor3 = c.TextDark,
            Text = colName,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 5, 0, 0),
            TextSize = textsize.Small,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = headerCon,
        })

        -- Divider under header
        CreateInstance("Frame", {
            BackgroundColor3 = c.Border,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            LayoutOrder = 1,
            Parent = colWrap,
        })

        -- Tab list container
        local tabsCon = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 2,
            Parent = colWrap,
        })
        CreateListLayout(tabsCon, 2, Enum.SortOrder.LayoutOrder)
        CreatePadding(tabsCon, 2, 2, 2, 2)

        return tabsCon
    end

    -- Two columns side-by-side
    local twoCol = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = dualFrame,
    })
    CreateListLayout(twoCol, 4, Enum.SortOrder.LayoutOrder, Enum.FillDirection.Horizontal)

    -- Left column wrapper (slightly less than half to leave a gap)
    local leftWrap = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, -3, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = twoCol,
    })
    CreateListLayout(leftWrap, 2, Enum.SortOrder.LayoutOrder)

    -- Right column wrapper
    local rightWrap = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, -3, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = twoCol,
    })
    CreateListLayout(rightWrap, 2, Enum.SortOrder.LayoutOrder)

    -- Build headers + tab containers
    local function BuildColInWrap(wrap, colName, tabsList)
        -- Header label
        CreateInstance("TextLabel", {
            FontFace = f.Regular,
            TextColor3 = c.TextDark,
            Text = colName,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 4, 0, 0),
            TextSize = textsize.Small,
            Size = UDim2.new(1, 0, 0, 20),
            Parent = wrap,
        })

        local tabsCon = CreateInstance("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = wrap,
        })
        CreateListLayout(tabsCon, 2, Enum.SortOrder.LayoutOrder)
        CreatePadding(tabsCon, 1, 1, 1, 1)
        return tabsCon
    end

    local leftTabsCon  = BuildColInWrap(leftWrap,  nameLeft,  dual.leftTabs)
    local rightTabsCon = BuildColInWrap(rightWrap, nameRight, dual.rightTabs)

    -- ── CreateTab helper (shared logic, narrower buttons) ─────────────
    local function CreateDualTab(tabsCon, tabsList, tabName, icon)
        local tab = { name = tabName, elements = {} }

        -- Narrower button to fit half-width column
        local TAB_W = 60
        local TAB_H = s.Tab.Height

        local tabBtn = CreateInstance("Frame", {
            Name = tabName,
            BackgroundColor3 = c.Secondary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, TAB_H),
            Parent = tabsCon,
        })
        CreateCorner(tabBtn, 5)
        local tabStroke = CreateStroke(tabBtn, c.Border, 1)

        local iconLabel = CreateInstance("ImageLabel", {
            BackgroundTransparency = 1,
            Image = icon or "rbxassetid://112235310154264",
            ImageColor3 = c.TextDark,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 8, 0.5, 0),
            Size = UDim2.new(0, 13, 0, 13),
            Parent = tabBtn,
        })

        local tabText = CreateInstance("TextLabel", {
            FontFace = f.Regular,
            TextColor3 = c.TextDark,
            Text = tabName,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 26, 0, 0),
            Size = UDim2.new(1, -30, 1, 0),
            TextSize = textsize.Tiny,
            Parent = tabBtn,
        })

        local textGradient = CreateInstance("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, c.TextDark),
                ColorSequenceKeypoint.new(0.65, c.TextDark),
                ColorSequenceKeypoint.new(1, c.TextFade),
            }),
            Parent = tabText,
        })

        local clickBtn = CreateInstance("TextButton", {
            Text = "",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = tabBtn,
        })

        tab.content = CreateInstance("Frame", {
            Name = tabName .. "_Content",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = self.contentContainer,
        })
        CreateListLayout(tab.content, 8, Enum.SortOrder.LayoutOrder)

        tab.button     = tabBtn
        tab.stroke     = tabStroke
        tab.icon       = iconLabel
        tab.textLabel  = tabText
        tab.textGradient = textGradient
        tab._library   = self

        clickBtn.MouseButton1Click:Connect(function()
            Library._SelectTab(self, tab, tabBtn, tabStroke, iconLabel, tabText, textGradient)
        end)
        clickBtn.MouseEnter:Connect(function()
            if self.currentTab ~= tab then
                CreateTween(tabBtn, {BackgroundTransparency = 0.7}, animationspeed.Fast)
            end
        end)
        clickBtn.MouseLeave:Connect(function()
            if self.currentTab ~= tab then
                CreateTween(tabBtn, {BackgroundTransparency = 1}, animationspeed.Fast)
            end
        end)

        table.insert(tabsList, tab)

        if not self.currentTab then
            Library._SelectTab(self, tab, tabBtn, tabStroke, iconLabel, tabText, textGradient)
        end

        -- Attach all the same tab methods
        local tabMethods = setmetatable({}, {__index = tab})
        function tabMethods:CreateSection(sn)   return Library._CreateContentSection(self, sn) end
        function tabMethods:CreateParagraph(cfg) return Library._CreateParagraph(self, cfg) end
        function tabMethods:CreateSlider(cfg)    return Library._CreateSlider(self, cfg) end
        function tabMethods:CreateButton(cfg)    return Library._CreateButton(self, cfg) end
        function tabMethods:CreateToggle(cfg)    return Library._CreateToggle(self, cfg) end
        function tabMethods:CreateDropdown(cfg)  return Library._CreateDropdown(self, cfg) end
        function tabMethods:CreateKeybind(cfg)   return Library._CreateKeybind(self, cfg, dual._library) end
        function tabMethods:CreateColorPicker(cfg) return Library._CreateColorPicker(self, cfg) end
        function tabMethods:CreateTextBox(cfg)   return Library._CreateTextBox(self, cfg) end
        function tabMethods:CreateConfigSection() return Library._CreateConfigSection(self) end
        function tabMethods:CreateInfoSection(cfg) return Library._CreateInfoSection(self, cfg) end
        return tabMethods
    end

    -- ── Public API ─────────────────────────────────────────────────────
    local dualMethods = {}

    function dualMethods:CreateLeftTab(tabName, icon)
        return CreateDualTab(leftTabsCon, dual.leftTabs, tabName, icon)
    end

    function dualMethods:CreateRightTab(tabName, icon)
        return CreateDualTab(rightTabsCon, dual.rightTabs, tabName, icon)
    end

    return dualMethods
end

function Library._CreateTab(section, name, icon)
    local tab = {
        name = name,
        elements = {}
    }

    local tabBtn = CreateInstance("Frame", {
        Name = name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(0, s.Tab.Width, 0, s.Tab.Height),
        Parent = section.tabsContainer
    })
    CreateCorner(tabBtn, 5)

    local tabStroke = CreateStroke(tabBtn, c.Border, 1)

    local iconLabel = CreateInstance("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = icon or "rbxassetid://112235310154264",
        ImageColor3 = c.TextDark,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 11, 0.5, 0),
        Size = UDim2.new(0, 15, 0, 15),
        Parent = tabBtn
    })

    local tabText = CreateInstance("TextLabel", {
        Name = "TabText",
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 33, 0, 0),
        Size = UDim2.new(1, -42, 1, 0),
        TextSize = textsize.Small,
        Parent = tabBtn
    })

    CreateInstance("UIPadding", {
        PaddingRight = UDim.new(0, 9),
        Parent = tabText
    })

    local textGradient = CreateInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, c.TextDark),
            ColorSequenceKeypoint.new(0.65, c.TextDark),
            ColorSequenceKeypoint.new(1, c.TextFade)
        }),
        Parent = tabText
    })

    local clickBtn = CreateInstance("TextButton", {
        Name = "ClickButton",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = tabBtn
    })

    tab.content = CreateInstance("Frame", {
        Name = name .. "_Content",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Visible = false,
        Parent = section._library.contentContainer
    })
    CreateListLayout(tab.content, 8, Enum.SortOrder.LayoutOrder)

    clickBtn.MouseButton1Click:Connect(function()
        Library._SelectTab(section._library, tab, tabBtn, tabStroke, iconLabel, tabText, textGradient)
    end)

    clickBtn.MouseEnter:Connect(function()
        if section._library.currentTab ~= tab then
            CreateTween(tabBtn, {BackgroundTransparency = 0.7}, animationspeed.Fast)
        end
    end)

    clickBtn.MouseLeave:Connect(function()
        if section._library.currentTab ~= tab then
            CreateTween(tabBtn, {BackgroundTransparency = 1}, animationspeed.Fast)
        end
    end)

    tab.button = tabBtn
    tab.stroke = tabStroke
    tab.icon = iconLabel
    tab.textLabel = tabText
    tab.textGradient = textGradient
    tab._library = section._library

    table.insert(section.tabs, tab)

    if not section._library.currentTab then
        Library._SelectTab(section._library, tab, tabBtn, tabStroke, iconLabel, tabText, textGradient)
    end

    local tabMethods = setmetatable({}, {__index = tab})

    function tabMethods:CreateSection(sectionName)
        return Library._CreateContentSection(self, sectionName)
    end

    function tabMethods:CreateParagraph(config)
        return Library._CreateParagraph(self, config)
    end

    function tabMethods:CreateSlider(config)
        return Library._CreateSlider(self, config)
    end

    function tabMethods:CreateButton(config)
        return Library._CreateButton(self, config)
    end

    function tabMethods:CreateToggle(config)
        return Library._CreateToggle(self, config)
    end

    function tabMethods:CreateDropdown(config)
        return Library._CreateDropdown(self, config)
    end

    function tabMethods:CreateKeybind(config)
        return Library._CreateKeybind(self, config, section._library)
    end

    function tabMethods:CreateColorPicker(config)
        return Library._CreateColorPicker(self, config)
    end

    function tabMethods:CreateTextBox(config)
        return Library._CreateTextBox(self, config)
    end

    function tabMethods:CreateConfigSection()
        return Library._CreateConfigSection(self)
    end

    function tabMethods:CreateInfoSection(config)
    return Library._CreateInfoSection(self, config)
end

    return tabMethods
end

function Library._SelectTab(lib, tab, btn, stroke, icon, textLabel, textGradient)
    
    if lib.currentTab then
        lib.currentTab.content.Visible = false
        CreateTween(lib.currentTab.button, {BackgroundTransparency = 1}, animationspeed.Fast)
        CreateTween(lib.currentTab.icon, {ImageColor3 = c.TextDark}, animationspeed.Fast)
        lib.currentTab.stroke.Transparency = 1
        
        if lib.currentTab.textGradient then
            lib.currentTab.textGradient.Enabled = true
        end
    end
    
    lib.currentTab = tab
    tab.content.Visible = true
    
    CreateTween(btn, {BackgroundTransparency = 1}, animationspeed.Fast)
    CreateTween(icon, {ImageColor3 = c.Text}, animationspeed.Fast)
    stroke.Transparency = 1  
    
    if textGradient then
        textGradient.Enabled = false
    end
    textLabel.TextColor3 = c.Text
end

function Library._CreateContentSection(tab, name)
    local section = CreateInstance("TextLabel", {
        Name = "Section_" .. name,
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        TextSize = 15,
        Size = UDim2.new(1, 0, 0, 25),
        Parent = tab.content
    })
    return section
end

function Library._CreateParagraph(tab, config)
    local title = config.Title or "Paragraph"
    local content = config.Content or "Description text here."

    local frame = CreateInstance("Frame", {
        Name = "Paragraph",
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)
    CreatePadding(frame, 10, 10, 10, 10)

    local titleLabel = CreateInstance("TextLabel", {
        Name = "Title",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = title,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        TextSize = textsize.Normal,
        Size = UDim2.new(1, 0, 0, 20),
        Parent = frame
    })

    local contentLabel = CreateInstance("TextLabel", {
        Name = "Content",
        FontFace = f.Regular,
        TextColor3 = c.TextDark,
        Text = content,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        BackgroundTransparency = 1,
        TextSize = textsize.Small,
        Position = UDim2.new(0, 0, 0, 22),
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Parent = frame
    })

    return {
        SetTitle = function(_, newTitle)
            titleLabel.Text = newTitle
        end,
        SetContent = function(_, newContent)
            contentLabel.Text = newContent
        end
    }
end

function Library._CreateSlider(tab, config)
    local name = config.Name or "Slider"
    local min = config.Min or 0
    local max = config.Max or 100
    local default = config.Default or 50
    local callback = config.Callback or function() end
    local flag = config.Flag
    local currentValue = default

    local frame = CreateInstance("Frame", {
        Name = "Slider_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Slider.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 5),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 200, 0, 20),
        Parent = frame
    })

    local valueLabel = CreateInstance("TextLabel", {
        Name = "Value",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = tostring(currentValue),
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -60, 0, 5),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 50, 0, 20),
        Parent = frame
    })

    local sliderBg = CreateInstance("Frame", {
        Name = "SliderBackground",
        BackgroundColor3 = Color3.fromRGB(11, 11, 11),
        Position = UDim2.new(0, 10, 0, 29),
        BorderSizePixel = 0,
        Size = UDim2.new(1, -20, 0, 7),
        Parent = frame
    })
    CreateCorner(sliderBg, 100)

    local sliderFill = CreateInstance("Frame", {
        Name = "SliderFill",
        BackgroundColor3 = c.Accent,
        BorderSizePixel = 0,
        Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
        Parent = sliderBg
    })
    CreateCorner(sliderFill, 100)

    local dragging = false

    local function UpdateSlider(input)
        local pos = input.Position
        local framePos = sliderBg.AbsolutePosition
        local frameSize = sliderBg.AbsoluteSize
        local relativeX = math.clamp((pos.X - framePos.X) / frameSize.X, 0, 1)
        currentValue = math.floor(min + (max - min) * relativeX)
        CreateTween(sliderFill, {Size = UDim2.new(relativeX, 0, 1, 0)}, 0.05)
        valueLabel.Text = tostring(currentValue)
        callback(currentValue)
    end

    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            UpdateSlider(input)
        end
    end)

    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    ui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)

    local methods = {
        SetValue = function(_, value)
            currentValue = math.clamp(value, min, max)
            local relativeX = (currentValue - min) / (max - min)
            sliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            valueLabel.Text = tostring(currentValue)
            callback(currentValue)
        end,
        GetValue = function()
            return currentValue
        end
    }

    if flag and tab._library then
        tab._library:_RegisterConfigElement(flag, "Slider", 
            function() return currentValue end,
            function(value) methods:SetValue(value) end
        )
    end

    return methods
end

function Library._CreateButton(tab, config)
    local name = config.Name or "Button"
    local callback = config.Callback or function() end

    local frame = CreateInstance("Frame", {
        Name = "Button_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Button.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -10),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 200, 0, 20),
        Parent = frame
    })

    local icon = CreateInstance("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = "rbxassetid://10734898355",
        ImageColor3 = c.Text,
        Position = UDim2.new(1, -30, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Parent = frame
    })
    CreateInstance("UIAspectRatioConstraint", {
        Parent = icon
    })

    local button = CreateInstance("TextButton", {
        Name = "Button",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = frame
    })

    button.MouseButton1Click:Connect(function()
        CreateTween(frame, {BackgroundTransparency = 0.2}, animationspeed.Fast)
        task.wait(0.1)
        CreateTween(frame, {BackgroundTransparency = 0.4}, animationspeed.Fast)
        callback()
    end)

    return {
        SetText = function(_, text)
            nameLabel.Text = text
        end
    }
end

function Library._CreateToggle(tab, config)
    local name = config.Name or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local flag = config.Flag
    local enabled = default

    local frame = CreateInstance("Frame", {
        Name = "Toggle_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Button.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -10),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 200, 0, 20),
        Parent = frame
    })

    local switchBg = CreateInstance("Frame", {
        Name = "SwitchBackground",
        BackgroundColor3 = enabled and c.Toggle.Enabled or c.Toggle.Disabled,
        Position = UDim2.new(1, -48, 0.5, -10),
        BorderSizePixel = 0,
        Size = UDim2.new(0, s.Toggle.Width, 0, s.Toggle.Height),
        Parent = frame
    })
    CreateCorner(switchBg, 100)

    local switchCircle = CreateInstance("Frame", {
        Name = "Circle",
        BackgroundColor3 = c.Toggle.Circle,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = enabled and UDim2.new(0, 21, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, s.Toggle.Circle, 0, s.Toggle.Circle),
        Parent = switchBg
    })
    CreateCorner(switchCircle, 100)

    local toggleBtn = CreateInstance("TextButton", {
        Name = "ToggleButton",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = switchCircle
    })

    local button = CreateInstance("TextButton", {
        Name = "Button",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = frame
    })

    local function UpdateToggle()
        if enabled then
            CreateTween(switchBg, {BackgroundColor3 = c.Toggle.Enabled}, animationspeed.Normal)
            CreateTween(switchCircle, {Position = UDim2.new(0, 21, 0.5, 0)}, animationspeed.Normal)
        else
            CreateTween(switchBg, {BackgroundColor3 = c.Toggle.Disabled}, animationspeed.Normal)
            CreateTween(switchCircle, {Position = UDim2.new(0, 4, 0.5, 0)}, animationspeed.Normal)
        end
    end

    button.MouseButton1Click:Connect(function()
        enabled = not enabled
        UpdateToggle()
        callback(enabled)
    end)

    local methods = {
        SetValue = function(_, value)
            enabled = value
            UpdateToggle()
            callback(enabled)
        end,
        GetValue = function()
            return enabled
        end
    }

    if flag and tab._library then
        tab._library:_RegisterConfigElement(flag, "Toggle", 
            function() return enabled end,
            function(value) methods:SetValue(value) end
        )
    end

    return methods
end

function Library._CreateDropdown(tab, config)
    local name = config.Name or "Dropdown"
    local options = config.Options or {"Option 1", "Option 2", "Option 3"}
    local default = config.Default or options[1]
    local multiSelect = config.MultiSelect or false
    local callback = config.Callback or function() end
    local flag = config.Flag
    local selected = multiSelect and {} or default
    local expanded = false
    local filteredOptions = {}

    if multiSelect and type(default) == "table" then
        selected = default
    elseif multiSelect then
        selected = {}
    end

    -- Copy options to filtered list initially
    for _, v in ipairs(options) do
        table.insert(filteredOptions, v)
    end

    -- ── Main row frame ────────────────────────────────────────────────
    local frame = CreateInstance("Frame", {
        Name = "Dropdown_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Dropdown.Height),
        ClipsDescendants = false,
        ZIndex = 1,
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 10),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 200, 0, 20),
        ZIndex = 1,
        Parent = frame
    })

    local selectedDisplay = CreateInstance("Frame", {
        Name = "SelectedDisplay",
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.04,
        Position = UDim2.new(1, -145, 0, 6),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 135, 0, 26),
        ZIndex = 2,
        Parent = frame
    })
    CreateCorner(selectedDisplay, 5)
    CreateStroke(selectedDisplay)

    local selectedLabel = CreateInstance("TextLabel", {
        Name = "SelectedLabel",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = multiSelect and (#selected > 0 and table.concat(selected, ", ") or "None") or tostring(selected),
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        TextSize = textsize.Small,
        Size = UDim2.new(1, -30, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 2,
        Parent = selectedDisplay
    })

    local arrow = CreateInstance("ImageLabel", {
        Name = "Arrow",
        Image = "rbxassetid://105558791071013",
        ImageColor3 = c.TextDark,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20, 0.5, -5),
        Size = UDim2.new(0, 10, 0, 10),
        Rotation = 0,
        ZIndex = 2,
        Parent = selectedDisplay
    })

    -- ── Portal overlay (attaches to ScreenGui root) ───────────────────
    local OVERLAY_WIDTH = 220
    local SEARCH_HEIGHT = 32
    local OPTION_H = s.Dropdown.OptionHeight + 2  -- slightly taller for readability
    local MAX_VISIBLE = 6
    local overlayVisible = false

    local overlay = CreateInstance("Frame", {
        Name = "DropdownOverlay_" .. name,
        BackgroundColor3 = Color3.fromRGB(28, 30, 34),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(0, OVERLAY_WIDTH, 0, SEARCH_HEIGHT + math.min(#options, MAX_VISIBLE) * OPTION_H),
        Position = UDim2.new(0, 0, 0, 0),
        Visible = false,
        ZIndex = 9000,
        ClipsDescendants = true,
        Parent = tab._library.screenGui
    })
    CreateCorner(overlay, 6)
    CreateInstance("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = c.Border,
        Thickness = 1,
        ZIndex = 9001,
        Parent = overlay
    })

    -- Search bar inside overlay
    local searchBar = CreateInstance("Frame", {
        Name = "SearchBar",
        BackgroundColor3 = Color3.fromRGB(20, 22, 25),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, SEARCH_HEIGHT),
        ZIndex = 9002,
        Parent = overlay
    })
    CreateInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = searchBar })

    local searchIcon = CreateInstance("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://93828793199781",
        ImageColor3 = c.TextDark,
        Position = UDim2.new(0, 8, 0.5, -8),
        Size = UDim2.new(0, 16, 0, 16),
        ZIndex = 9003,
        Parent = searchBar
    })

    local searchInput = CreateInstance("TextBox", {
        Name = "SearchInput",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        PlaceholderText = "Search...",
        PlaceholderColor3 = c.TextDark,
        Text = "",
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        TextSize = textsize.Small,
        ClearTextOnFocus = false,
        Size = UDim2.new(1, -36, 1, 0),
        Position = UDim2.new(0, 30, 0, 0),
        ZIndex = 9003,
        Parent = searchBar
    })

    -- Scrolling list of options
    local optionsScroll = CreateInstance("ScrollingFrame", {
        Name = "OptionsScroll",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, SEARCH_HEIGHT),
        Size = UDim2.new(1, 0, 1, -SEARCH_HEIGHT),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(70, 72, 78),
        ZIndex = 9002,
        Parent = overlay
    })
    CreateListLayout(optionsScroll, 0, Enum.SortOrder.LayoutOrder)

    -- ── Helpers ───────────────────────────────────────────────────────
    local function UpdateSelectedText()
        if multiSelect then
            selectedLabel.Text = #selected > 0 and table.concat(selected, ", ") or "None"
        else
            selectedLabel.Text = tostring(selected)
        end
    end

    local function RefreshOverlaySize(count)
        local h = SEARCH_HEIGHT + math.min(count, MAX_VISIBLE) * OPTION_H
        overlay.Size = UDim2.new(0, OVERLAY_WIDTH, 0, h)
    end

    local function BuildOptions(filter)
        -- Clear existing buttons
        for _, child in ipairs(optionsScroll:GetChildren()) do
            if child:IsA("TextButton") or child:IsA("Frame") then
                child:Destroy()
            end
        end

        filteredOptions = {}
        local lFilter = filter and filter:lower() or ""
        for _, opt in ipairs(options) do
            if lFilter == "" or opt:lower():find(lFilter, 1, true) then
                table.insert(filteredOptions, opt)
            end
        end

        RefreshOverlaySize(#filteredOptions)

        for _, opt in ipairs(filteredOptions) do
            local row = CreateInstance("TextButton", {
                Name = opt,
                FontFace = f.Regular,
                TextColor3 = c.Text,
                Text = "  " .. opt,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundColor3 = Color3.fromRGB(34, 36, 40),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextSize = textsize.Normal,
                Size = UDim2.new(1, 0, 0, OPTION_H),
                ZIndex = 9003,
                Parent = optionsScroll
            })

            -- Highlight if currently selected
            local isSelected = (not multiSelect and selected == opt)
                or (multiSelect and table.find(selected, opt))
            if isSelected then
                row.TextColor3 = c.Accent
            end

            row.MouseEnter:Connect(function()
                CreateTween(row, {BackgroundTransparency = 0.5}, animationspeed.Fast)
            end)
            row.MouseLeave:Connect(function()
                CreateTween(row, {BackgroundTransparency = 1}, animationspeed.Fast)
            end)

            row.MouseButton1Click:Connect(function()
                if multiSelect then
                    local idx = table.find(selected, opt)
                    if idx then
                        table.remove(selected, idx)
                        row.TextColor3 = c.Text
                    else
                        table.insert(selected, opt)
                        row.TextColor3 = c.Accent
                    end
                    UpdateSelectedText()
                    callback(selected)
                else
                    selected = opt
                    UpdateSelectedText()
                    callback(selected)
                    -- Close
                    overlay.Visible = false
                    overlayVisible = false
                    CreateTween(arrow, {Rotation = 0}, animationspeed.Normal)
                end
            end)
        end
    end

    local function PositionOverlay()
        -- Get absolute position of the selectedDisplay button
        local absPos = selectedDisplay.AbsolutePosition
        local absSize = selectedDisplay.AbsoluteSize
        local viewport = workspace.CurrentCamera.ViewportSize
        local overlayH = overlay.AbsoluteSize.Y

        local x = absPos.X + absSize.X - OVERLAY_WIDTH
        local y = absPos.Y + absSize.Y + 4

        -- Flip up if not enough room below
        if y + overlayH > viewport.Y - 10 then
            y = absPos.Y - overlayH - 4
        end
        -- Clamp horizontally
        x = math.clamp(x, 4, viewport.X - OVERLAY_WIDTH - 4)

        overlay.Position = UDim2.new(0, x, 0, y)
    end

    local function OpenOverlay()
        searchInput.Text = ""
        BuildOptions("")
        PositionOverlay()
        overlay.Visible = true
        overlayVisible = true
        CreateTween(arrow, {Rotation = 180}, animationspeed.Normal)
        -- Focus search
        task.defer(function()
            searchInput:CaptureFocus()
        end)
    end

    local function CloseOverlay()
        overlay.Visible = false
        overlayVisible = false
        CreateTween(arrow, {Rotation = 0}, animationspeed.Normal)
    end

    -- Toggle button
    local toggleBtn = CreateInstance("TextButton", {
        Name = "ToggleBtn",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 3,
        Parent = selectedDisplay
    })

    toggleBtn.MouseButton1Click:Connect(function()
        if overlayVisible then
            CloseOverlay()
        else
            OpenOverlay()
        end
    end)

    -- Live search filter
    searchInput:GetPropertyChangedSignal("Text"):Connect(function()
        BuildOptions(searchInput.Text)
    end)

Connections["dropdown_close_" .. name] = ui.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and overlayVisible then
        local mousePos = ui:GetMouseLocation()

        local ovPos = overlay.AbsolutePosition
        local ovSize = overlay.AbsoluteSize

        local insideOverlay = mousePos.X >= ovPos.X and mousePos.X <= ovPos.X + ovSize.X
            and mousePos.Y >= ovPos.Y and mousePos.Y <= ovPos.Y + ovSize.Y

        local btnPos = selectedDisplay.AbsolutePosition
        local btnSize = selectedDisplay.AbsoluteSize

        local insideButton = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X
            and mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y

        if not insideOverlay and not insideButton then
            CloseOverlay()
        end
    end
end)

    -- ── Public API ────────────────────────────────────────────────────
    local methods = {
        SetValue = function(_, value)
            if multiSelect and type(value) == "table" then
                selected = value
            elseif not multiSelect then
                selected = value
            end
            UpdateSelectedText()
            callback(selected)
        end,
        GetValue = function()
            return selected
        end,
        Refresh = function(_, newOptions)
            options = newOptions
            if overlayVisible then
                BuildOptions(searchInput.Text)
            end
        end
    }

    if flag and tab._library then
        tab._library:_RegisterConfigElement(flag, "Dropdown",
            function() return selected end,
            function(value) methods:SetValue(value) end
        )
    end

    return methods
end

 
function Library._CreateInfoSection(tab, config)
    -- ── Pull config ────────────────────────────────────────────────────
    local hubName        = config.HubName        or "My Hub"
    local hubSubtitle    = config.HubSubtitle    or ".gg/example"
    local hubLogo        = config.HubLogo        or "rbxassetid://10709775704"
    local playerGreeting = config.PlayerGreeting or "Hello, {Player}!"
    local playerSubtitle = config.PlayerSubtitle or "{Player} - " .. hubName
    local joinCallback   = config.JoinCallback   or function() end
    local discordLabel   = config.Discord        or "Tap to join the Discord Server"
    local discordUrl     = config.DiscordUrl     or ""
    local serverLabel    = config.ServerLabel    or "Server"
    local serverDesc     = config.ServerDesc     or "Information on the session you're currently in"
    local waveTitle      = config.WaveTitle      or nil
    local waveBody       = config.WaveBody       or nil
    local waveColor      = config.WaveColor      or Color3.fromRGB(160, 30, 30)
 
    local serverStats = config.ServerStats or {
        { Label = "Players",         Value = "0"        },
        { Label = "Maximum Players", Value = "16"       },
        { Label = "Latency",         Value = "0ms"      },
        { Label = "Server Region",   Value = "US"       },
        { Label = "In server for",   Value = "00:00:00" },
        { Label = "Join Script",     Value = "Tap to copy join script" },
    }
 
    local friendsData = config.Friends or {
        { Label = "In Server", Value = "0"   },
        { Label = "Offline",   Value = "0"   },
        { Label = "Online",    Value = "0"   },
        { Label = "All",       Value = "0"   },
    }
 
    -- Resolve {Player} token
    local localPlayer = plr.LocalPlayer
    local playerName  = localPlayer and localPlayer.Name or "Player"
    local function Resolve(str)
        return (str:gsub("{Player}", playerName))
    end
 
    -- ── Helpers ────────────────────────────────────────────────────────
    local CARD_BG   = Color3.fromRGB(34, 36, 40)
    local CARD_BG2  = Color3.fromRGB(20, 22, 26)
    local RADIUS    = 10  -- slightly rounder than default to match ref
 
    local function Card(parent, props)
        local f = CreateInstance("Frame", {
            BackgroundColor3    = props.bg or CARD_BG,
            BackgroundTransparency = props.alpha or 0.15,
            BorderSizePixel     = 0,
            Size                = props.size or UDim2.new(1, 0, 0, 40),
            Parent              = parent,
        })
        CreateCorner(f, props.radius or RADIUS)
        if not props.noStroke then
            CreateStroke(f, props.strokeColor or c.Border, props.strokeAlpha or 0)
        end
        return f
    end
 
    local function Label(parent, props)
        return CreateInstance("TextLabel", {
            FontFace            = props.bold and f.Bold or f.Regular,
            TextColor3          = props.color or c.Text,
            Text                = props.text or "",
            TextXAlignment      = props.align or Enum.TextXAlignment.Left,
            TextTruncate        = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            TextSize            = props.size or textsize.Normal,
            Position            = props.pos  or UDim2.new(0, 0, 0, 0),
            Size                = props.sz   or UDim2.new(1, 0, 1, 0),
            Parent              = parent,
        })
    end

 
    -- ── 2. Player greeting card ────────────────────────────────────────
    local greetCard = Card(tab.content, {
        bg    = CARD_BG,
        alpha = 0.1,
        size  = UDim2.new(1, 0, 0, 64),
        radius = RADIUS,
    })
 
    -- Avatar
    local avatarFrame = CreateInstance("Frame", {
        BackgroundColor3 = c.Secondary,
        AnchorPoint      = Vector2.new(0, 0.5),
        Position         = UDim2.new(0, 10, 0.5, 0),
        Size             = UDim2.new(0, 46, 0, 46),
        Parent           = greetCard,
    })
    CreateCorner(avatarFrame, 8)
    CreateStroke(avatarFrame, c.Border, 0)
 
    local avatarImg = CreateInstance("ImageLabel", {
        BackgroundTransparency = 1,
        Image  = "rbxassetid://116422175458617",
        Size   = UDim2.new(1, 0, 1, 0),
        Parent = avatarFrame,
    })
    CreateCorner(avatarImg, 8)
 
    Label(greetCard, {
        text  = Resolve(playerGreeting),
        bold  = true,
        color = c.Text,
        size  = textsize.Normal,
        pos   = UDim2.new(0, 64, 0, 12),
        sz    = UDim2.new(1, -70, 0, 20),
    })
 
    Label(greetCard, {
        text  = Resolve(playerSubtitle),
        color = c.TextDark,
        size  = textsize.Small,
        pos   = UDim2.new(0, 64, 0, 34),
        sz    = UDim2.new(1, -70, 0, 16),
    })
 
    -- ── 3. Two-column row (Server stats left | Wave/Friends right) ─────
    local twoCol = CreateInstance("Frame", {
        Name                    = "TwoColumn",
        BackgroundTransparency  = 1,
        Size                    = UDim2.new(1, 0, 0, 0),
        AutomaticSize           = Enum.AutomaticSize.Y,
        Parent                  = tab.content,
    })
    CreateListLayout(twoCol, 8, Enum.SortOrder.LayoutOrder, Enum.FillDirection.Horizontal)
 
    -- Left column
    local leftCol = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(0.52, -4, 0, 0),
        AutomaticSize          = Enum.AutomaticSize.Y,
        Parent                 = twoCol,
    })
    CreateListLayout(leftCol, 6, Enum.SortOrder.LayoutOrder)
 
    -- Right column
    local rightCol = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(0.48, -4, 0, 0),
        AutomaticSize          = Enum.AutomaticSize.Y,
        Parent                 = twoCol,
    })
    CreateListLayout(rightCol, 6, Enum.SortOrder.LayoutOrder)
 
    -- ── 3a. Server card (left) ─────────────────────────────────────────
    local serverCard = Card(leftCol, {
        bg    = CARD_BG,
        alpha = 0.1,
        size  = UDim2.new(1, 0, 0, 0),
        radius = RADIUS,
    })
    serverCard.AutomaticSize = Enum.AutomaticSize.Y
    CreatePadding(serverCard, 10, 10, 10, 10)
    CreateListLayout(serverCard, 6, Enum.SortOrder.LayoutOrder)
 
    Label(serverCard, {
        text  = serverLabel,
        bold  = true,
        color = c.Text,
        size  = textsize.Normal,
        sz    = UDim2.new(1, 0, 0, 18),
    })
    Label(serverCard, {
        text  = serverDesc,
        color = c.TextDark,
        size  = textsize.Tiny,
        sz    = UDim2.new(1, 0, 0, 14),
    })
 
    -- Stat mini-grid (2 columns, auto rows)
    local statsGrid = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(1, 0, 0, 0),
        AutomaticSize          = Enum.AutomaticSize.Y,
        Parent                 = serverCard,
    })
    CreateInstance("UIGridLayout", {
        CellSize              = UDim2.new(0.5, -3, 0, 44),
        CellPadding           = UDim2.new(0, 6, 0, 6),
        SortOrder             = Enum.SortOrder.LayoutOrder,
        Parent                = statsGrid,
    })
 
    for _, stat in ipairs(serverStats) do
        local cell = Card(statsGrid, {
            bg     = CARD_BG2,
            alpha  = 0,
            radius = 7,
            noStroke = false,
            strokeAlpha = 0.4,
        })
        CreatePadding(cell, 6, 6, 8, 8)
        CreateListLayout(cell, 2, Enum.SortOrder.LayoutOrder)
 
        Label(cell, {
            text  = stat.Label,
            color = c.Text,
            bold  = true,
            size  = textsize.Tiny,
            sz    = UDim2.new(1, 0, 0, 14),
        })
        Label(cell, {
            text  = tostring(stat.Value),
            color = c.TextDark,
            size  = textsize.Tiny,
            sz    = UDim2.new(1, 0, 0, 14),
        })
    end
 
    -- ── 3b. Discord button (at bottom of left col) ─────────────────────
    local discordBtn = CreateInstance("TextButton", {
        Name              = "DiscordBtn",
        BackgroundColor3  = c.Accent,
        BackgroundTransparency = 0,
        BorderSizePixel   = 0,
        Size              = UDim2.new(1, 0, 0, 50),
        FontFace          = f.Bold,
        TextColor3        = Color3.new(1, 1, 1),
        Text              = "",
        Parent            = leftCol,
    })
    CreateCorner(discordBtn, RADIUS)
 
    Label(discordBtn, {
        text  = "Discord",
        bold  = true,
        color = Color3.new(1,1,1),
        size  = textsize.Normal,
        pos   = UDim2.new(0, 12, 0, 7),
        sz    = UDim2.new(1, -20, 0, 18),
    })
    Label(discordBtn, {
        text  = discordLabel,
        color = Color3.fromRGB(200, 220, 255),
        size  = textsize.Tiny,
        pos   = UDim2.new(0, 12, 0, 27),
        sz    = UDim2.new(1, -20, 0, 14),
    })
 
    discordBtn.MouseEnter:Connect(function()
        CreateTween(discordBtn, {BackgroundColor3 = Color3.fromRGB(30, 140, 255)}, animationspeed.Fast)
    end)
    discordBtn.MouseLeave:Connect(function()
        CreateTween(discordBtn, {BackgroundColor3 = c.Accent}, animationspeed.Fast)
    end)
    discordBtn.MouseButton1Click:Connect(function()
        CreateTween(discordBtn, {BackgroundColor3 = Color3.fromRGB(0, 90, 200)}, animationspeed.Fast)
        task.wait(0.12)
        CreateTween(discordBtn, {BackgroundColor3 = c.Accent}, animationspeed.Fast)
        joinCallback()
        if setclipboard and discordUrl ~= "" then
            setclipboard(discordUrl)
        end
    end)
 
    -- ── 3c. Wave / announcement card (right, optional) ─────────────────
    if waveTitle and waveBody then
        local waveCard = Card(rightCol, {
            bg     = CARD_BG2,
            alpha  = 0,
            radius = RADIUS,
            noStroke = false,
            strokeAlpha = 0.3,
        })
        waveCard.AutomaticSize = Enum.AutomaticSize.Y
        CreateListLayout(waveCard, 0, Enum.SortOrder.LayoutOrder)
 
        -- Coloured header strip
        local waveHeader = CreateInstance("Frame", {
            BackgroundColor3    = waveColor,
            BackgroundTransparency = 0,
            BorderSizePixel     = 0,
            Size                = UDim2.new(1, 0, 0, 34),
            Parent              = waveCard,
        })
        CreateInstance("UICorner", { CornerRadius = UDim.new(0, RADIUS), Parent = waveHeader })
        -- Mask bottom corners
        CreateInstance("Frame", {
            BackgroundColor3    = waveColor,
            BackgroundTransparency = 0,
            BorderSizePixel     = 0,
            Position            = UDim2.new(0, 0, 0.5, 0),
            Size                = UDim2.new(1, 0, 0.5, 0),
            Parent              = waveHeader,
        })
        Label(waveHeader, {
            text  = waveTitle,
            bold  = true,
            color = Color3.new(1,1,1),
            size  = textsize.Normal,
            pos   = UDim2.new(0, 10, 0, 0),
            sz    = UDim2.new(1, -16, 1, 0),
        })
 
        local waveBody2 = CreateInstance("TextLabel", {
            FontFace            = f.Regular,
            TextColor3          = c.TextDark,
            Text                = waveBody,
            TextXAlignment      = Enum.TextXAlignment.Left,
            TextWrapped         = true,
            BackgroundTransparency = 1,
            TextSize            = textsize.Small,
            Size                = UDim2.new(1, 0, 0, 0),
            AutomaticSize       = Enum.AutomaticSize.Y,
            Parent              = waveCard,
        })
        CreatePadding(waveBody2, 8, 10, 10, 10)
    end
 
    -- ── 3d. Friends grid (right col) ───────────────────────────────────
    local friendsTitle = config.FriendsTitle or "Friends"
    local friendsDesc  = config.FriendsDesc  or "Find out what your friends are currently doing"
 
    local friendsCard = Card(rightCol, {
        bg     = CARD_BG,
        alpha  = 0.1,
        radius = RADIUS,
    })
    friendsCard.AutomaticSize = Enum.AutomaticSize.Y
    CreatePadding(friendsCard, 10, 10, 10, 10)
    CreateListLayout(friendsCard, 6, Enum.SortOrder.LayoutOrder)
 
    Label(friendsCard, {
        text  = friendsTitle,
        bold  = true,
        color = c.Text,
        size  = textsize.Normal,
        sz    = UDim2.new(1, 0, 0, 18),
    })
    Label(friendsCard, {
        text  = friendsDesc,
        color = c.TextDark,
        size  = textsize.Tiny,
        sz    = UDim2.new(1, 0, 0, 28),
    })
 
    local friendsGrid = CreateInstance("Frame", {
        BackgroundTransparency = 1,
        Size                   = UDim2.new(1, 0, 0, 0),
        AutomaticSize          = Enum.AutomaticSize.Y,
        Parent                 = friendsCard,
    })
    CreateInstance("UIGridLayout", {
        CellSize        = UDim2.new(0.5, -3, 0, 44),
        CellPadding     = UDim2.new(0, 6, 0, 6),
        SortOrder       = Enum.SortOrder.LayoutOrder,
        Parent          = friendsGrid,
    })
 
    local friendCells = {}
    for _, fd in ipairs(friendsData) do
        local cell = Card(friendsGrid, {
            bg        = CARD_BG2,
            alpha     = 0,
            radius    = 7,
            noStroke  = false,
            strokeAlpha = 0.4,
        })
        CreatePadding(cell, 6, 6, 8, 8)
        CreateListLayout(cell, 2, Enum.SortOrder.LayoutOrder)
 
        Label(cell, {
            text  = fd.Label,
            bold  = true,
            color = c.Text,
            size  = textsize.Tiny,
            sz    = UDim2.new(1, 0, 0, 14),
        })
        local valLabel = Label(cell, {
            text  = tostring(fd.Value),
            color = c.TextDark,
            size  = textsize.Tiny,
            sz    = UDim2.new(1, 0, 0, 14),
        })
        table.insert(friendCells, { label = fd.Label, valueLabel = valLabel })
    end
 
    -- ── Public API ─────────────────────────────────────────────────────
    return {
        -- Dynamically update a server stat by label
        SetServerStat = function(_, label, newValue)
            -- (You can extend this with stored refs if needed)
        end,
        -- Dynamically update a friend count by label
        SetFriendCount = function(_, label, newValue)
            for _, cell in ipairs(friendCells) do
                if cell.label == label then
                    cell.valueLabel.Text = tostring(newValue)
                end
            end
        end,
    }
end

function Library._CreateKeybind(tab, config, lib)
    local name = config.Name or "Keybind"
    local default = config.Default or Enum.KeyCode.F
    local callback = config.Callback or function() end
    local flag = config.Flag
    local currentKey = default
    local listening = false

    local frame = CreateInstance("Frame", {
        Name = "Keybind_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Button.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -10),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 200, 0, 20),
        Parent = frame
    })

    local keybindBox = CreateInstance("Frame", {
        Name = "KeybindBox",
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.04,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 30, 0, 26),
        Parent = frame
    })
    CreateCorner(keybindBox, 5)
    CreateStroke(keybindBox)

    local keyLabel = CreateInstance("TextLabel", {
        Name = "KeyLabel",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = currentKey.Name,
        BackgroundTransparency = 1,
        TextSize = textsize.Normal,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = keybindBox
    })

    local button = CreateInstance("TextButton", {
        Name = "Button",
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = keybindBox
    })

    local keybindId = name .. "_" .. tostring(tick())

    lib._keybinds[keybindId] = {
        key = currentKey,
        callback = callback
    }

    local function UpdateKeyDisplay()
        if listening then
            keyLabel.Text = "..."
            keybindBox.Size = UDim2.new(0, 43, 0, 26)
        else
            local keyName = currentKey.Name
            local textWidth = math.max(#keyName * 9 + 10, 24)
            keybindBox.Size = UDim2.new(0, textWidth, 0, 26)
            keyLabel.Text = keyName
        end
    end

    button.MouseButton1Click:Connect(function()
        listening = true
        UpdateKeyDisplay()
    end)

    local inputConnection
    inputConnection = ui.InputBegan:Connect(function(input, gameProcessed)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            currentKey = input.KeyCode
            listening = false
            lib._keybinds[keybindId].key = currentKey
            UpdateKeyDisplay()
        end
    end)

    table.insert(Connections, inputConnection)
    UpdateKeyDisplay()

    local methods = {
        SetKey = function(_, keyCode)
            currentKey = keyCode
            lib._keybinds[keybindId].key = currentKey
            UpdateKeyDisplay()
        end,
        GetKey = function()
            return currentKey
        end
    }

    if flag and lib then
        lib:_RegisterConfigElement(flag, "Keybind", 
            function() return currentKey end,
            function(value) methods:SetKey(value) end
        )
    end

    return methods
end

function Library._CreateColorPicker(tab, config)
    local name = config.Name or "Color Picker"
    local default = config.Default or Color3.fromRGB(255, 255, 255)
    local callback = config.Callback or function() end
    local flag = config.Flag
    local currentColor = default
    local hue, sat, val = currentColor:ToHSV()
    local expanded = false

    local frame = CreateInstance("Frame", {
        Name = "ColorPicker_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.Button.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 6)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        TextSize = textsize.Normal,
        Size = UDim2.new(1, -50, 1, 0),
        Parent = frame
    })

    local colorPreview = CreateInstance("Frame", {
        Name = "ColorPreview",
        BackgroundColor3 = currentColor,
        Position = UDim2.new(1, -45, 0.5, -8),
        Size = UDim2.new(0, 35, 0, 16),
        ZIndex = 2,
        Parent = frame
    })
    CreateCorner(colorPreview, 4)
    CreateStroke(colorPreview)

    local previewBtn = CreateInstance("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 3,
        Parent = colorPreview
    })

    local pickerContainer = CreateInstance("Frame", {
        Name = "PickerContainer",
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 160, 0, 115),
        Visible = false,
        ZIndex = 3000,
        Parent = tab.content:FindFirstAncestorOfClass("ScreenGui") or tab.content
    })
    CreateCorner(pickerContainer, 6)

    local containerStroke = CreateInstance("UIStroke", {
        Color = Color3.fromRGB(40, 40, 40),
        Thickness = 1,
        Parent = pickerContainer
    })

    local svPicker = CreateInstance("Frame", {
        Name = "SVPicker",
        BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
        Position = UDim2.new(0, 8, 0, 8),
        Size = UDim2.new(1, -16, 0, 85),
        ZIndex = 3001,
        Parent = pickerContainer
    })
    CreateCorner(svPicker, 4)

    local whiteLayer = CreateInstance("Frame", {
        BackgroundColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 3002,
        Parent = svPicker
    })
    CreateCorner(whiteLayer, 4)

    local whiteGrad = CreateInstance("UIGradient", {
        Color = ColorSequence.new(Color3.new(1, 1, 1)),
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
        }),
        Parent = whiteLayer
    })

    local blackLayer = CreateInstance("Frame", {
        BackgroundColor3 = Color3.new(0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 3003,
        Parent = svPicker
    })
    CreateCorner(blackLayer, 4)

    local blackGrad = CreateInstance("UIGradient", {
        Color = ColorSequence.new(Color3.new(0, 0, 0)),
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        }),
        Parent = blackLayer
    })

    local svCursor = CreateInstance("Frame", {
        Name = "Cursor",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(sat, 0, 1 - val, 0),
        Size = UDim2.new(0, 10, 0, 10),
        ZIndex = 3005,
        Parent = svPicker
    })

    local svCursorStroke = CreateInstance("UIStroke", {
        Thickness = 1.5,
        Color = Color3.new(1, 1, 1),
        Parent = svCursor
    })
    CreateCorner(svCursor, 100)

    local hueSlider = CreateInstance("Frame", {
        Name = "HueSlider",
        Position = UDim2.new(0, 8, 0, 98),
        Size = UDim2.new(1, -16, 0, 8),
        ZIndex = 3001,
        Parent = pickerContainer
    })
    CreateCorner(hueSlider, 100)

    local hueGrad = CreateInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
            ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
            ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)),
            ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
            ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)),
            ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
        }),
        Parent = hueSlider
    })

    local hueCursor = CreateInstance("Frame", {
        Name = "HueCursor",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(hue, 0, 0.5, 0),
        Size = UDim2.new(0, 10, 0, 10),
        ZIndex = 3005,
        Parent = hueSlider
    })
    CreateCorner(hueCursor, 100)
    CreateInstance("UIStroke", {
        Thickness = 1,
        Color = Color3.fromRGB(20, 20, 20),
        Parent = hueCursor
    })

    local function UpdateColor()
        currentColor = Color3.fromHSV(hue, sat, val)
        colorPreview.BackgroundColor3 = currentColor
        svPicker.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        svCursor.Position = UDim2.new(sat, 0, 1 - val, 0)
        hueCursor.Position = UDim2.new(hue, 0, 0.5, 0)
        callback(currentColor)
    end

    local svDragging, hueDragging = false, false

    local function ProcessInput(input)
        if not pickerContainer.Visible then return end

        if svDragging then
            local size = svPicker.AbsoluteSize
            local pos = svPicker.AbsolutePosition
            sat = math.clamp((input.Position.X - pos.X) / size.X, 0, 1)
            val = 1 - math.clamp((input.Position.Y - pos.Y) / size.Y, 0, 1)
            UpdateColor()
        elseif hueDragging then
            local size = hueSlider.AbsoluteSize
            local pos = hueSlider.AbsolutePosition
            hue = math.clamp((input.Position.X - pos.X) / size.X, 0, 1)
            UpdateColor()
        end
    end

    svPicker.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            svDragging = true
            ProcessInput(input)
        end
    end)

    hueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            hueDragging = true
            ProcessInput(input)
        end
    end)

    ui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            ProcessInput(input)
        end
    end)

    ui.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            svDragging = false
            hueDragging = false
        end
    end)

    local function ClosePicker()
        pickerContainer.Visible = false
        expanded = false
        if Library.ActivePicker == ClosePicker then
            Library.ActivePicker = nil
        end
    end

    local function OpenPicker()
        if Library.ActivePicker then
            Library.ActivePicker()
        end
        Library.ActivePicker = ClosePicker

        local btnPos = colorPreview.AbsolutePosition
        local viewport = workspace.CurrentCamera.ViewportSize
        local targetX = btnPos.X - 170
        local targetY = btnPos.Y

        if targetY + 115 > viewport.Y then
            targetY = viewport.Y - 125
        end
        if targetX < 0 then
            targetX = btnPos.X + 50
        end

        pickerContainer.Position = UDim2.new(0, targetX, 0, targetY)
        pickerContainer.Visible = true
        expanded = true
    end

    previewBtn.MouseButton1Click:Connect(function()
        if expanded then
            ClosePicker()
        else
            OpenPicker()
        end
    end)

    local methods = {
        SetColor = function(_, color)
            currentColor = color
            hue, sat, val = color:ToHSV()
            UpdateColor()
        end,
        GetColor = function()
            return currentColor
        end
    }

    if flag and tab._library then
        tab._library:_RegisterConfigElement(flag, "ColorPicker", 
            function() return currentColor end,
            function(value) methods:SetColor(value) end
        )
    end

    return methods
end

function Library._CreateTextBox(tab, config)
    local name = config.Name or "TextBox"
    local default = config.Default or ""
    local placeholder = config.Placeholder or "Enter text..."
    local callback = config.Callback or function() end
    local clearOnFocus = config.ClearOnFocus or false
    local numbersOnly = config.NumbersOnly or false
    local flag = config.Flag
    local currentText = default

    local frame = CreateInstance("Frame", {
        Name = "TextBox_" .. name,
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, s.TextBox.Height),
        Parent = tab.content
    })
    CreateCorner(frame, 5)
    CreateStroke(frame)

    local nameLabel = CreateInstance("TextLabel", {
        Name = "Name",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        Text = name,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -10),
        TextSize = textsize.Normal,
        Size = UDim2.new(0, 150, 0, 20),
        Parent = frame
    })

    local icon = CreateInstance("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Image = "rbxassetid://93828793199781",
        ImageColor3 = c.TextDark,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -165, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 18),
        Parent = frame
    })

    local textBoxContainer = CreateInstance("Frame", {
        Name = "TextBoxContainer",
        BackgroundColor3 = c.Secondary,
        BackgroundTransparency = 0.04,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, s.TextBox.InputWidth, 0, 26),
        Parent = frame
    })
    CreateCorner(textBoxContainer, 5)
    local textBoxStroke = CreateStroke(textBoxContainer)

    local textBox = CreateInstance("TextBox", {
        Name = "Input",
        FontFace = f.Regular,
        TextColor3 = c.Text,
        PlaceholderText = placeholder,
        PlaceholderColor3 = c.TextDark,
        Text = currentText,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        TextSize = textsize.Small,
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.new(0, 8, 0, 0),
        ClearTextOnFocus = clearOnFocus,
        Parent = textBoxContainer
    })

    textBox.Focused:Connect(function()
        CreateTween(textBoxContainer, {BackgroundTransparency = 0}, animationspeed.Fast)
        CreateTween(textBoxStroke, {Color = c.Accent}, animationspeed.Fast)
        CreateTween(icon, {ImageColor3 = c.Text}, animationspeed.Fast)
    end)

    textBox.FocusLost:Connect(function(enterPressed)
        CreateTween(textBoxContainer, {BackgroundTransparency = 0.04}, animationspeed.Fast)
        CreateTween(textBoxStroke, {Color = c.Border}, animationspeed.Fast)
        CreateTween(icon, {ImageColor3 = c.TextDark}, animationspeed.Fast)
        
        if numbersOnly then
            local numValue = tonumber(textBox.Text)
            if numValue then
                currentText = tostring(numValue)
                textBox.Text = currentText
            else
                textBox.Text = currentText
            end
        else
            currentText = textBox.Text
        end
        
        callback(currentText, enterPressed)
    end)

    if numbersOnly then
        textBox:GetPropertyChangedSignal("Text"):Connect(function()
            local text = textBox.Text
            local filtered = text:gsub("[^%d%.%-]", "")
            if text ~= filtered then
                textBox.Text = filtered
            end
        end)
    end

    local methods = {
        SetText = function(_, text)
            currentText = tostring(text)
            textBox.Text = currentText
        end,
        GetText = function()
            return currentText
        end,
        SetPlaceholder = function(_, newPlaceholder)
            textBox.PlaceholderText = newPlaceholder
        end,
        Focus = function()
            textBox:CaptureFocus()
        end
    }

    if flag and tab._library then
        tab._library:_RegisterConfigElement(flag, "TextBox", 
            function() return currentText end,
            function(value) methods:SetText(value) end
        )
    end

    return methods
end

function Library._CreateConfigSection(tab)
    local lib = tab._library
    
    Library._CreateContentSection(tab, "Configuration")

    local configNameBox = Library._CreateTextBox(tab, {
        Name = "Config Name",
        Default = "default",
        Placeholder = "Enter config name...",
        Callback = function(text)
            lib._currentConfig = text
        end
    })

    local configDropdown
    configDropdown = Library._CreateDropdown(tab, {
        Name = "Select Config",
        Options = lib:GetConfigs(),
        Default = "default",
        Callback = function(selected)
            configNameBox:SetText(selected)
            lib._currentConfig = selected
        end
    })

    Library._CreateButton(tab, {
        Name = "Save Config",
        Callback = function()
            local configName = configNameBox:GetText()
            if configName and configName ~= "" then
                lib:SaveConfig(configName)
                configDropdown:Refresh(lib:GetConfigs())
            end
        end
    })

    Library._CreateButton(tab, {
        Name = "Load Config",
        Callback = function()
            local configName = configNameBox:GetText()
            if configName and configName ~= "" then
                lib:LoadConfig(configName)
            end
        end
    })



    Library._CreateButton(tab, {
        Name = "Delete Config",
        Callback = function()
            local configName = configNameBox:GetText()
            if configName and configName ~= "" then
                lib:DeleteConfig(configName)
                configDropdown:Refresh(lib:GetConfigs())
            end
        end
    })

    Library._CreateButton(tab, {
        Name = "Refresh Configs",
        Callback = function()
            configDropdown:Refresh(lib:GetConfigs())
            lib:Notify({
                Title = "Configs Refreshed",
                Description = "Config list updated",
                Duration = 2,
                Icon = "rbxassetid://10723356507"
            })
        end
    })

    Library._CreateToggle(tab, {
        Name = "Auto Save",
        Default = false,
        Callback = function(enabled)
            lib:SetAutoSave(enabled)
        end
    })

    return {
        RefreshConfigs = function()
            configDropdown:Refresh(lib:GetConfigs())
        end
    }
end

local Library = loadstring(game:HttpGet('https://pastefy.app/GNu87OAj/raw'))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local window = Library.new("Zen Hub -" .. "<font color='rgb(127, 255, 212)'> " .. gameName .. " </font>", "ExampleHubConfigs")
window:SetToggleKey(Enum.KeyCode.RightControl)
local InfoTab1 = window:CreateSection("General")

local InfoTab = InfoTab1:CreateTab("Information", "rbxassetid://10709775704")

InfoTab:CreateInfoSection({

    -- Player greeting header
    PlayerGreeting = "Hello, {Player}!",
    PlayerSubtitle = "{Player} - Zen Hub",
 
    -- Server info panel
    ServerLabel = "Server",
    ServerDesc  = "Information on the session you're currently in",
    ServerStats = {
        { Label = "Players",         Value = tostring(#game:GetService("Players"):GetPlayers()) },
        { Label = "Maximum Players", Value = tostring(game:GetService("Players").MaxPlayers)    },
        { Label = "Latency",         Value = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms" },
        { Label = "Server Region",   Value = "US" },
        { Label = "In server for",   Value = "00:00:00" },
        { Label = "Join Script",     Value = "Tap to copy" },
    },
 
    -- Discord button (left col, bottom)
    Discord    = "Tap to join the Discord Server",
    DiscordUrl = "https://discord.gg/yourlink",
    JoinCallback = function()
        -- setclipboard handled automatically from DiscordUrl
    end,
 
    -- Optional Wave/announcement card (right col, top)
    WaveTitle = "Executor : ".. identifyexecutor(),
    WaveBody  = "Your executor seems to support this script.",
    WaveColor = Color3.fromRGB(160, 30, 30),
 
    -- Friends panel (right col, bottom)
    FriendsTitle = "Friends",
    FriendsDesc  = "Find out what your friends are currently doing",
    Friends = {
        { Label = "In Server", Value = "0"  },
        { Label = "Offline",   Value = "0"  },
        { Label = "Online",    Value = "0"  },
        { Label = "All",       Value = "0"  },
    },
})

-- Welcome notification
window:Notify({
    Title = "Welcome!",
    Description = "Hub loaded successfully",
    Duration = 3,
    Icon = "rbxassetid://10709775704"
})

-- Two-column section example
local DualSection = window:CreateDualSection("Combat", "Utility")

local AimbotTab = DualSection:CreateLeftTab("Aimbot", "rbxassetid://10723407389")
local ESPTab    = DualSection:CreateLeftTab("ESP",    "rbxassetid://10734898355")
local SpeedTab  = DualSection:CreateRightTab("Speed",  "rbxassetid://10734898355")
local TeleTab   = DualSection:CreateRightTab("Teleport","rbxassetid://10734898355")

-- Then add elements exactly as normal:
AimbotTab:CreateToggle({ Name = "Enable Aimbot", Default = false, Callback = function(v) end })
SpeedTab:CreateSlider({ Name = "Walk Speed", Min = 16, Max = 200, Default = 16, Callback = function(v) end })

-- Create sections
local CombatSection = window:CreateSection("Combat")
local PlayerSection = window:CreateSection("Player")
local MiscSection = window:CreateSection("Miscellaneous")
local SettingsSection = window:CreateSection("Settings")

-- Combat Tab
local AimbotTab = CombatSection:CreateTab("Aimbot", "rbxassetid://10723407389")

AimbotTab:CreateSection("Main Settings")

local aimbotEnabled = false
AimbotTab:CreateToggle({
    Name = "Enable Aimbot",
    Default = false,
    Flag = "AimbotEnabled",
    Callback = function(enabled)
        aimbotEnabled = enabled
        window:Notify({
            Title = enabled and "Enabled" or "Disabled",
            Description = "Aimbot " .. (enabled and "activated" or "deactivated"),
            Duration = 2
        })
    end
})

AimbotTab:CreateSlider({
    Name = "Aim Speed",
    Min = 1,
    Max = 100,
    Default = 50,
    Flag = "AimSpeed",
    Callback = function(value)
        print("Aim speed set to:", value)
    end
})

AimbotTab:CreateDropdown({
    Name = "Target Priority",
    Options = {"Closest", "Lowest HP", "Highest Threat"},
    Default = "Closest",
    Flag = "TargetPriority",
    Callback = function(selected)
        print("Priority:", selected)
    end
})

AimbotTab:CreateColorPicker({
    Name = "Aim FOV Color",
    Default = Color3.fromRGB(255, 0, 0),
    Flag = "AimFOVColor",
    Callback = function(color)
        print("FOV Color:", color)
    end
})

-- Player Tab
local MovementTab = PlayerSection:CreateTab("Movement", "rbxassetid://10734898355")

MovementTab:CreateSection("Speed Settings")

MovementTab:CreateToggle({
    Name = "Speed Boost",
    Default = false,
    Flag = "SpeedBoost",
    Callback = function(enabled)
        print("Speed boost:", enabled)
    end
})

MovementTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Flag = "WalkSpeed",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

MovementTab:CreateKeybind({
    Name = "Fly Toggle",
    Default = Enum.KeyCode.F,
    Flag = "FlyKeybind",
    Callback = function()
        window:Notify({
            Title = "Fly Mode",
            Description = "Flight toggled",
            Duration = 1.5
        })
    end
})

MovementTab:CreateSection("Teleport")

MovementTab:CreateTextBox({
    Name = "Player Name",
    Default = "",
    Placeholder = "Enter player name...",
    Flag = "TeleportTarget",
    Callback = function(text, enterPressed)
        if enterPressed and text ~= "" then
            print("Teleporting to:", text)
        end
    end
})

-- Misc Tab
local AutoTab = MiscSection:CreateTab("Automation", "rbxassetid://10734898355")

AutoTab:CreateSection("Auto Farm")

AutoTab:CreateButton({
    Name = "Start Auto Farm",
    Callback = function()
        window:Notify({
            Title = "Auto Farm",
            Description = "Started farming",                             
            Duration = 2
        })
    end
})

AutoTab:CreateTextBox({
    Name = "Farm Amount",
    Default = "100",
    Placeholder = "Enter amount...",
    NumbersOnly = true,
    Flag = "FarmAmount",
    Callback = function(text)
        print("Farm amount:", tonumber(text))
    end
})

AutoTab:CreateParagraph({
    Title = "About",
    Content = "This is an example hub showcasing all AcrylicUI components and features."
})

-- Settings Tab with Config System
local ConfigTab = SettingsSection:CreateTab("Config", "rbxassetid://10734898355")

-- This creates a full config management UI
ConfigTab:CreateConfigSection()

-- Or use individual config methods:
-- window:SaveConfig("MyConfig")
-- window:LoadConfig("MyConfig")
-- window:DeleteConfig("MyConfig")
-- window:SetAutoSave(true)