local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local RunService         = game:GetService("RunService")
local UserInputService   = game:GetService("UserInputService")
local VirtualUser        = game:GetService("VirtualUser")
local Lighting           = game:GetService("Lighting")
local CollectionService  = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer

local RemoteEvents  = ReplicatedStorage:WaitForChild("RemoteEvents")
local ReplicaSet    = RemoteEvents:WaitForChild("ReplicaSet")
local PacketRemote  = ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Packet"):WaitForChild("RemoteEvent")

-- ── Load all modules ─────────────────────────────────────────────────────
local Networking, FruitValueCalc, SellFlags, SellValueData, PlantSizeMultipliers
local FruitVisualizerController, StealFlagsModule

pcall(function() Networking         = require(ReplicatedStorage.SharedModules.Networking) end)
pcall(function() FruitValueCalc     = require(ReplicatedStorage.SharedModules.FruitValueCalc) end)
pcall(function() SellFlags          = require(ReplicatedStorage.SharedModules.Flags.SellFlags) end)
pcall(function() SellValueData      = require(ReplicatedStorage.SharedModules.SellValueData) end)
pcall(function() PlantSizeMultipliers = require(ReplicatedStorage.SharedModules.PlantSizeMultipliers) end)
pcall(function()
    local Controllers = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Controllers")
    FruitVisualizerController = require(Controllers:WaitForChild("FruitVisualizerController"))
end)
pcall(function() StealFlagsModule = require(ReplicatedStorage.SharedModules.Flags.StealFlags) end)

local Library = loadstring(game:HttpGet("https://pastefy.app/Ir29cpGU/raw", true))()
local gameName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name

local Window = Library:Window({
    Name     = "Arincy Hub Reborn",
    SubTitle = gameName,
    Logo     = "rbxassetid://93450275909746",
    Size     = UDim2.fromOffset(620, 440),
    Privacy  = true,
})

-- ── Constants ─────────────────────────────────────────────────────────────
local MUTATIONS = {
    "All", "None", "Gold", "Rainbow", "Electric", "Solarflare",
    "Frozen", "Bloodlit", "Chained", "Pizza", "Starstruck",
}
local RARITIES = {
    "All", "None", "Epic", "Legendary", "Mythic", "Super",
    "Rare", "Uncommon", "Common",
}
local ALL_GEAR = {
    "Common Watering Can", "Common Sprinkler", "Sign", "Lantern",
    "Uncommon Sprinkler", "Rare Sprinkler", "Legendary Sprinkler",
    "Super Sprinkler", "Trowel", "Speed Mushroom", "Jump Mushroom",
    "Gnome", "Shrink Mushroom", "Supersize Mushroom", "Invisibility Mushroom",
    "Wheelbarrow", "Teleporter", "Super Watering Can", "Basic Pot", "Flashbang",
}
local ALL_SPRINKLERS = {
    "Common Sprinkler", "Uncommon Sprinkler", "Rare Sprinkler",
    "Legendary Sprinkler", "Super Sprinkler",
}
local ALL_WATERING_CANS = {
    "Common Watering Can", "Super Watering Can",
}
local ALL_CRATES = {
    "Arch Crate", "Bear Trap Crate", "Bench Crate", "Bridge Crate",
    "Conveyor Crate", "Fence Crate", "Ladder Crate", "Light Crate",
    "Owner Door Crate", "Roleplay Crate", "Seesaw Crate", "Sign Crate",
    "Spring Crate", "Teleporter Pad Crate", "Weather Machine Crate", "Wood Wall Crate",
}
local ALL_SEEDS = {
    "Acorn", "Apple", "Baby Cactus", "Bamboo", "Banana", "Beanstalk",
    "Blueberry", "Buttercup", "Cactus", "Carrot", "Cherry", "Coconut",
    "Corn", "Dragon Fruit", "Dragon's Breath", "Ghost Pepper", "Glow Mushroom",
    "Gold", "Grape", "Green Bean", "Horned Melon", "Lotus", "Mango",
    "Moon Bloom", "Moon Bloom OLD", "Mushroom", "PartFruit", "Pineapple",
    "Pinetree", "Poison Apple", "Poison Ivy", "Pomegranate", "Pumpkin",
    "Rainbow", "Romanesco", "Strawberry", "Sunflower", "Thorn Rose",
    "Tomato", "Tulip", "Venus Fly Trap",
}
local TARGET_PETS = {
    "Bee", "BlackDragon", "Bunny", "Deer", "Frog",
    "GoldenDragonfly", "IceSerpent", "Monkey", "Owl",
    "Raccoon", "Robin", "Unicorn",
}
local FRUIT_OPTIONS = { "All" }
for _, s in ipairs(ALL_SEEDS) do table.insert(FRUIT_OPTIONS, s) end

local RARITY_RANK = {
    Common = 1, Uncommon = 2, Rare = 3, Epic = 4,
    Legendary = 5, Mythic = 6, Super = 7,
}

-- ── State ─────────────────────────────────────────────────────────────────
local State = {
    -- Movement
    WalkSpeed = 16, WalkSpeedEnabled = false,
    NoClip = false, InfiniteJump = false,
    FlyEnabled = false, FlySpeed = 50,
    JumpPower = 50, JumpPowerEnabled = false,
    HipHeight = 0, HipHeightEnabled = false,
    GravityEnabled = false, Gravity = 196,
    InstantPrompt = false,
    -- Plant
    PlantDelay = 0, PlantPosition = "Random Position",
    SelectedSeeds = {}, AutoPlantSeed = false, AutoPlantAllSeeds = false,
    SavedPlantPos = nil,
    -- Collect
    CollectFruit = {"All"}, CollectMutation = {"All"}, CollectRarity = {"All"},
    AutoCollectFruit = false, AutoCollectAllFruit = false,
    CollectStopWhenFull = false, CollectMinKg = 0, CollectMaxKg = 0,
    -- Shop
    SelectedShopSeeds = {}, SelectedGear = {}, SelectedCrate = {},
    AutoBuySeeds = false, AutoBuyAllSeeds = false,
    AutoBuyGear = false, AutoBuyAllGear = false,
    AutoBuyCrate = false, AutoBuyAllCrates = false,
    -- Pets
    SelectedPets = {}, AutoBuyPet = false, PetBuyDelay = 1,
    AutoBuyBestPet = false,  -- NEW: buy highest rarity wild pet
    -- Sell
    AutoSell = false, SellOnlyWhenFull = false, SellDelay = 2,
    SellFruit = {"All"}, SellRarity = {"All"}, SellMutation = {"All"},
    SellMinKg = 0, SellMaxKg = 0,
    -- Steal
    AutoSteal = false,
    StealFruit = {"All"}, StealRarity = {"All"}, StealMutation = {"All"},
    StealLimit = 50, StealMinValue = 0, StealPrioritize = false,
    AntiSteal = false,  -- NEW: hit intruders at night
    -- Watering
    AutoWater = false, AutoWaterAll = false,
    SelectedWateringCan = "Common Watering Can",
    WaterPosition = "Random Position", SavedWaterPos = nil, WaterDelay = 0,
    -- Sprinkler
    SelectedSprinkler = "Common Sprinkler",
    SprinklerPosition = "Random Position", SavedSprinklerPos = nil,
    SprinklerDelay = 0, AutoPlaceSprinkler = false, AutoPlaceAllSprinklers = false,
    -- Shovel
    AutoShovelTree = false, AutoShovelFruit = false, SelectedShovelSeeds = {},
    ShovelTreeRarity = {"All"}, ShovelTreeMutation = {"All"},
    ShovelFruits = {"All"}, ShovelFruitRarity = {"All"}, ShovelFruitMutation = {"All"},
    ShovelTreeMinKg = 0, ShovelTreeMaxKg = 0,
    ShovelFruitMinKg = 0, ShovelFruitMaxKg = 0,
    -- Seed Pack
    AutoSeedPack = false,
    -- Favorites
    FavoriteFruit = {"All"}, FavoriteRarity = {"All"}, FavoriteMutation = {"All"},
    AutoFavoriteFruit = false, AutoUnfavoriteFruit = false, AutoUnfavoriteAll = false,
    -- Misc
    AntiAFK = false, FullBright = false, NoGameplayPause = false,
    AntiFling = false,
    ForceTeleportGarden = false,
    AutoReconnect = false,
    -- Bargain
    AutoBargain = false, BargainMaxAttempts = 3,
    BargainTargetMult = 1.2, BargainMaxFeePct = 0.1,
    AllowBargainWhileSelling = false,
    -- Egg
    AutoOpenEggs = false, EggOpenDelay = 0.3,
    -- Event Seeds (NEW from second script)
    AutoCollectEventSeeds = false,
    -- Harvest via CollectFruit remote (NEW from second script)
    AutoHarvestFast = false,
    HarvestPrioritize = false,
    -- Camera/render
    CameraZoomEnabled = false, MinZoom = 0, MaxZoom = 100,
    FOVEnabled = false, FOV = 70,
    LimitFPS = false, FPSLimit = 60,
    UncapFPS = false, Disable3DRendering = false,
}

local OriginalLighting = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows,
}

-- ── Loop IDs ──────────────────────────────────────────────────────────────


local PlantLoopId = 0
local CollectLoopId = 0
local BuySeedLoopId = 0
local BuyGearLoopId = 0
local BuyCrateLoopId = 0
local PetLoopId = 0
local StealLoopId = 0
local SellLoopId = 0
local WaterLoopId = 0
local ShovelLoopId = 0
local SeedPackLoopId = 0
local SprinklerLoopId = 0
local FavoriteLoopId = 0
local EggLoopId = 0
local BargainLoopId = 0
local EventSeedLoopId = 0
local HarvestFastLoopId = 0
local AntiStealLoopId = 0
local BestPetLoopId = 0

-- ── Connections ────────────────────────────────────────────────────────────
local NoClipConn, JumpConn, AntiAFKConn, NoGameplayPauseConn = nil, nil, nil, nil
local AntiFlingConn, FlyConn, InstantPromptConn = nil, nil, nil
local FPSConn, AutoReconnectConn = nil, nil
local BodyVel, BodyGyro = nil, nil

-- ═══════════════════════════════════════════════════════════════════════════
-- HELPERS
-- ═══════════════════════════════════════════════════════════════════════════

function toList(v)
    if type(v) == "table" then return v end
    if type(v) == "string" then return {v} end
    return {}
end

function matchesMultiFilter(actualValue, selectedList)
    if #selectedList == 0 then return true end
    for _, sel in ipairs(selectedList) do
        if sel == "All" then return true end
    end
    local actual = actualValue
    if actual == nil or actual == "" then actual = "None" end
    for _, sel in ipairs(selectedList) do
        if string.lower(actual) == string.lower(sel) then return true end
    end
    return false
end

function disconnect(conn)
    if conn then conn:Disconnect() end
end

function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

function getHumanoid()
    return getCharacter():FindFirstChildOfClass("Humanoid")
end

function getRoot()
    return getCharacter():FindFirstChild("HumanoidRootPart")
end

function TpTo(pos)
    local hrp = getRoot()
    if hrp then
        hrp.Anchored = true
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.CFrame = CFrame.new(pos)
        task.wait(0.08)
        hrp.Anchored = false
    end
end

function isInventoryFull()
    local current = LocalPlayer:GetAttribute("FruitCount") or 0
    local max = LocalPlayer:GetAttribute("MaxFruitCapacity") or 100
    return current >= max
end

local CheckBackpackFull = isInventoryFull

function isNight()
    local n = ReplicatedStorage:FindFirstChild("Night")
    return n ~= nil and n.Value == true
end

function getOwnedPlot()
    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then return nil end
    -- Fast path via PlotId attribute
    local plotId = LocalPlayer:GetAttribute("PlotId")
    if plotId then
        local plot = Gardens:FindFirstChild("Plot" .. tostring(plotId))
        if plot then return plot end
    end
    -- Fallback: scan by sign
    for _, plot in ipairs(Gardens:GetChildren()) do
        if plot.Name:match("^Plot%d+$") then
            local ok, label = pcall(function()
                return plot.Signs.Garden.CorePart.SurfaceGui.Player.TextLabel
            end)
            if ok and label then
                local ownerName = label.Text:match("^(.-)'s")
                if ownerName == LocalPlayer.Name or ownerName == LocalPlayer.DisplayName then
                    return plot
                end
            end
        end
    end
    return nil
end

function getPlantArea()
    local plot = getOwnedPlot()
    local visual = plot and plot:FindFirstChild("Visual")
    if not visual then return nil end
    return {
        Column1 = visual:FindFirstChild("PlantAreaColumn1"),
        Column2 = visual:FindFirstChild("PlantAreaColumn2"),
    }
end

function getPlantsFolder()
    local plot = getOwnedPlot()
    return plot and plot:FindFirstChild("Plants")
end

function getRandomPlantPosition()
    local area = getPlantArea()
    if not area then return nil end
    local columns = {area.Column1, area.Column2}
    local col = columns[math.random(1, 2)]
    if not col or not col:IsA("BasePart") then return nil end
    local cf, size = col.CFrame, col.Size
    local rx = (math.random() - 0.5) * size.X * 0.85
    local rz = (math.random() - 0.5) * size.Z * 0.85
    return (cf * CFrame.new(rx, size.Y / 2 + 0.25, rz)).Position
end

function clampToPlantArea(position)
    local area = getPlantArea()
    if not area then return position end
    function clampToColumn(col)
        if not col or not col:IsA("BasePart") then return nil end
        local cf, size = col.CFrame, col.Size
        local localPos = cf:PointToObjectSpace(position)
        localPos = Vector3.new(
            math.clamp(localPos.X, -size.X * 0.425, size.X * 0.425),
            size.Y / 2 + 0.25,
            math.clamp(localPos.Z, -size.Z * 0.425, size.Z * 0.425)
        )
        return cf:PointToWorldSpace(localPos)
    end
    local c1 = clampToColumn(area.Column1)
    local c2 = clampToColumn(area.Column2)
    if not c1 then return c2 or position end
    if not c2 then return c1 end
    return (c1 - position).Magnitude <= (c2 - position).Magnitude and c1 or c2
end

function getPlantPosition()
    if State.PlantPosition == "Saved Position" and State.SavedPlantPos then
        return State.SavedPlantPos
    end
    if State.PlantPosition == "Under Player Character" then
        local root = getRoot()
        if root then return clampToPlantArea(root.Position - Vector3.new(0, 3, 0)) end
    end
    return getRandomPlantPosition()
end

function teleportHomeIfForced()
    if not State.ForceTeleportGarden then return end
    local myPlot = getOwnedPlot()
    if not myPlot then return end
    local plotPart = (myPlot:FindFirstChild("Visual") and myPlot.Visual:FindFirstChild("PRIM"))
                  or myPlot:FindFirstChild("GardenZone") or myPlot.PrimaryPart
    if plotPart then TpTo(plotPart.Position + Vector3.new(0, 2, 0)) end
end

-- Value of a fruit model (for prioritization)
function fruitModelValue(m)
    local name = m:GetAttribute("CorePartName") or m:GetAttribute("SeedName") or ""
    if not SellValueData or not FruitValueCalc or not SellValueData[name] then return 0 end
    local ok, v = pcall(FruitValueCalc, name,
        m:GetAttribute("SizeMulti") or 1,
        m:GetAttribute("Mutation"), LocalPlayer,
        m:GetAttribute("DecayAlpha"))
    return (ok and type(v) == "number") and v or 0
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PLAYER CONTROLS
-- ═══════════════════════════════════════════════════════════════════════════

function setWalkSpeed()
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = State.WalkSpeedEnabled and State.WalkSpeed or 16 end
end

function setNoClip(enabled)
    State.NoClip = enabled
    if NoClipConn then disconnect(NoClipConn) NoClipConn = nil end
    if not enabled then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
        return
    end
    NoClipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)
end

function setInfiniteJump(enabled)
    State.InfiniteJump = enabled
    if JumpConn then disconnect(JumpConn) JumpConn = nil end
    if not enabled then return end
    JumpConn = UserInputService.JumpRequest:Connect(function()
        local hum = getHumanoid()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end

function setAntiAFK(enabled)
    State.AntiAFK = enabled
    if AntiAFKConn then disconnect(AntiAFKConn) AntiAFKConn = nil end
    if not enabled then return end
    AntiAFKConn = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end

function setNoGameplayPause(enabled)
    State.NoGameplayPause = enabled
    if NoGameplayPauseConn then disconnect(NoGameplayPauseConn) NoGameplayPauseConn = nil end
    if not enabled then return end
    NoGameplayPauseConn = RunService.Heartbeat:Connect(function()
        pcall(function() VirtualUser:CaptureController() end)
    end)
end

function setFullBright(enabled)
    State.FullBright = enabled
    if enabled then
        Lighting.Brightness = 2; Lighting.ClockTime = 14
        Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
    else
        Lighting.Brightness = OriginalLighting.Brightness
        Lighting.ClockTime = OriginalLighting.ClockTime
        Lighting.FogEnd = OriginalLighting.FogEnd
        Lighting.GlobalShadows = OriginalLighting.GlobalShadows
    end
end

function setFly(enabled)
    State.FlyEnabled = enabled
    if not enabled then
        if FlyConn then FlyConn:Disconnect() FlyConn = nil end
        if BodyVel then BodyVel:Destroy() BodyVel = nil end
        if BodyGyro then BodyGyro:Destroy() BodyGyro = nil end
        local hum = getHumanoid()
        if hum then hum.PlatformStand = false end
        return
    end
    local hrp = getRoot()
    local hum = getHumanoid()
    if not hrp or not hum then return end
    hum.PlatformStand = true
    BodyVel = Instance.new("BodyVelocity")
    BodyVel.Velocity = Vector3.zero; BodyVel.MaxForce = Vector3.new(1e5,1e5,1e5)
    BodyVel.Parent = hrp
    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5); BodyGyro.D = 100
    BodyGyro.CFrame = hrp.CFrame; BodyGyro.Parent = hrp
    FlyConn = RunService.Heartbeat:Connect(function()
        if not State.FlyEnabled then return end
        local cam = workspace.CurrentCamera
        local dir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end
        if BodyVel then BodyVel.Velocity = dir.Magnitude > 0 and (dir.Unit * State.FlySpeed) or Vector3.zero end
        if BodyGyro then BodyGyro.CFrame = cam.CFrame end
    end)
end

function setJumpPower(enabled, value)
    State.JumpPowerEnabled = enabled
    if value then State.JumpPower = value end
    local hum = getHumanoid()
    if hum then hum.JumpPower = enabled and State.JumpPower or 50 end
end

function setHipHeight(enabled, value)
    State.HipHeightEnabled = enabled
    if value then State.HipHeight = value end
    local hum = getHumanoid()
    if hum then hum.HipHeight = enabled and State.HipHeight or 0 end
end

function setGravity(enabled, value)
    State.GravityEnabled = enabled
    if value then State.Gravity = value end
    workspace.Gravity = enabled and State.Gravity or 196
end

function setInstantPrompt(enabled)
    State.InstantPrompt = enabled
    if InstantPromptConn then InstantPromptConn:Disconnect() InstantPromptConn = nil end
    if not enabled then return end
    InstantPromptConn = RunService.Heartbeat:Connect(function()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end
        end
    end)
end

function setAntiFling(enabled)
    if AntiFlingConn then AntiFlingConn:Disconnect() AntiFlingConn = nil end
    if not enabled then return end
    AntiFlingConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp and hrp.Velocity.Magnitude > 120 then
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
        end
    end)
end

function setFOV(enabled, value)
    State.FOVEnabled = enabled
    if value then State.FOV = value end
    local cam = workspace.CurrentCamera
    if cam then cam.FieldOfView = enabled and State.FOV or 70 end
end

function setCameraZoom(enabled, min, max)
    State.CameraZoomEnabled = enabled
    if min then State.MinZoom = min end
    if max then State.MaxZoom = max end
    if enabled then
        pcall(function()
            LocalPlayer.CameraMinZoomDistance = State.MinZoom
            LocalPlayer.CameraMaxZoomDistance = State.MaxZoom
        end)
    else
        pcall(function()
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 400
        end)
    end
end

local lastFrame = os.clock()
function setFPSLimit(enabled, value)
    State.LimitFPS = enabled
    if value then State.FPSLimit = value end
    if FPSConn then FPSConn:Disconnect() FPSConn = nil end
    if not enabled then return end
    FPSConn = RunService.RenderStepped:Connect(function()
        local now = os.clock()
        local wt = (1 / State.FPSLimit) - (now - lastFrame)
        if wt > 0 then task.wait(wt) end
        lastFrame = os.clock()
    end)
end

function setUncapFPS(enabled)
    State.UncapFPS = enabled
    pcall(function()
        settings().Rendering.FrameRateManager = enabled
            and Enum.FramerateManagerMode.Off or Enum.FramerateManagerMode.Auto
    end)
end

function setDisable3D(enabled)
    State.Disable3DRendering = enabled
    pcall(function()
        settings().Rendering.QualityLevel = enabled
            and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end)
end

function setAutoReconnect(enabled)
    State.AutoReconnect = enabled
    if AutoReconnectConn then AutoReconnectConn:Disconnect() AutoReconnectConn = nil end
    if not enabled then return end
    AutoReconnectConn = Players.LocalPlayer.OnTeleport:Connect(function(state)
        if state == Enum.TeleportState.Failed then
            task.wait(3)
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- GEAR TOOLS
-- ═══════════════════════════════════════════════════════════════════════════

function findGearTool(toolName)
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    for _, parent in ipairs({char, backpack}) do
        if parent then
            local t = parent:FindFirstChild(toolName)
            if t and t:IsA("Tool") then return t end
        end
    end
    return nil
end

function equipGearTool(toolName)
    pcall(function() ReplicaSet:FireServer(4, {"Inventory", "Gear", toolName}) end)
    local deadline = os.clock() + 1.5
    while os.clock() < deadline do
        local tool = findGearTool(toolName)
        if tool then
            local char = LocalPlayer.Character
            if char and tool.Parent ~= char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:UnequipTools() end
                tool.Parent = char
            end
            task.wait(0.05)
            return tool
        end
        task.wait(0.05)
    end
    return nil
end

function equipTool(toolName)
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not char then return nil end
    local equipped = char:FindFirstChild(toolName)
    if equipped and equipped:IsA("Tool") then return equipped end
    local tool = backpack and backpack:FindFirstChild(toolName)
    if not tool then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum:UnequipTools() end
    task.wait(0.1)
    tool.Parent = char
    task.wait(0.3)
    return tool
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SEED TOOLS
-- ═══════════════════════════════════════════════════════════════════════════

function findSeedTool(seedName)
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local names = {seedName, seedName .. " Seed"}
    for _, parent in ipairs({char, backpack}) do
        if parent then
            for _, name in ipairs(names) do
                local tool = parent:FindFirstChild(name)
                if tool and tool:IsA("Tool") then return tool end
            end
            for _, tool in ipairs(parent:GetChildren()) do
                if tool:IsA("Tool") and tool:GetAttribute("SeedTool") == seedName then return tool end
            end
        end
    end
    return nil
end

function equipSeedToolFast(seedName)
    local char = LocalPlayer.Character
    if not char then return nil end
    local equipped = char:FindFirstChildWhichIsA("Tool")
    if equipped and equipped:GetAttribute("SeedTool") == seedName then return equipped end
    local tool = findSeedTool(seedName)
    if tool then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:UnequipTools() end
        tool.Parent = char
        task.wait(0.1)
        return tool
    end
    pcall(function() ReplicaSet:FireServer(4, {"Inventory", "Seeds", seedName}) end)
    local deadline = os.clock() + 1
    while os.clock() < deadline do
        tool = findSeedTool(seedName)
        if tool then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:UnequipTools() end
            tool.Parent = char
            task.wait(0.1)
            return tool
        end
        task.wait(0.05)
    end
    return nil
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PLANT SEED — uses Networking.Plant.PlantSeed:Fire() (confirmed working)
-- ═══════════════════════════════════════════════════════════════════════════

function plantSeedFast(seedName)
    local tool = equipSeedToolFast(seedName)
    if not tool then
        warn("[Zen] Could not equip seed:", seedName)
        return false
    end
    local targetPos = getPlantPosition()
    if not targetPos then return false end
    local ok = pcall(function()
        Networking.Plant.PlantSeed:Fire(targetPos, seedName, tool)
    end)
    return ok
end

function getSeedsToPlant()
    if State.AutoPlantAllSeeds then return ALL_SEEDS end
    if #State.SelectedSeeds > 0 then return State.SelectedSeeds end
    return {}
end

-- ═══════════════════════════════════════════════════════════════════════════
-- BUY REMOTES — uses Networking.SeedShop/GearShop/CrateShop (from second script)
-- ═══════════════════════════════════════════════════════════════════════════

function buySeed(itemName)
    pcall(function()
        Networking.SeedShop.PurchaseSeed:Fire(itemName)
    end)
end

function buyGear(itemName)
    pcall(function()
        Networking.GearShop.PurchaseGear:Fire(itemName)
    end)
end

function buyCrate(itemName)
    pcall(function()
        Networking.CrateShop.PurchaseCrate:Fire(itemName)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- HARVEST — uses Networking.Garden.CollectFruit (from second script — FAST)
-- ═══════════════════════════════════════════════════════════════════════════

function fireHarvestPrompt(prompt)
    if not prompt or not prompt.Enabled then return false end
    if fireproximityprompt then
        fireproximityprompt(prompt, prompt.HoldDuration or 0)
        return true
    end
    pcall(function() prompt:InputHoldBegin() end)
    task.wait(prompt.HoldDuration > 0 and prompt.HoldDuration or 0.05)
    pcall(function() prompt:InputHoldEnd() end)
    return true
end

-- Fast harvest using CollectFruit remote (no proximity prompt needed)
local harvestDebounce = {}
function doFastHarvest()
    local myId = LocalPlayer.UserId
    local tagged = CollectionService:GetTagged("HarvestPrompt")
    local list = {}
    for _, p in ipairs(tagged) do
        if p:IsA("ProximityPrompt") and p.Parent and p:IsDescendantOf(workspace) then
            local m = p.Parent:FindFirstAncestorWhichIsA("Model")
            if m and tonumber(m:GetAttribute("UserId")) == myId and m:GetAttribute("PlantId") then
                table.insert(list, {m = m, v = State.HarvestPrioritize and fruitModelValue(m) or 0})
            end
        end
    end
    if State.HarvestPrioritize then
        table.sort(list, function(a, b) return a.v > b.v end)
    end
    for _, e in ipairs(list) do
        if not State.AutoHarvestFast then break end
        local m = e.m
        local pid = m:GetAttribute("PlantId")
        local fid = m:GetAttribute("FruitId")
        local key = tostring(pid) .. "|" .. tostring(fid)
        local now = os.clock()
        if not harvestDebounce[key] or now - harvestDebounce[key] > 0.15 then
            harvestDebounce[key] = now
            pcall(function() Networking.Garden.CollectFruit:Fire(pid, fid or "") end)
        end
    end
    if #tagged == 0 then table.clear(harvestDebounce) end
end

function plantMatchesCollectFilters(plant)
    if not plant:GetAttribute("PlantGrowthReady") then return false end
    local seedName = plant:GetAttribute("SeedName") or ""
    local mutation = plant:GetAttribute("Mutation")
    local rarity = plant:GetAttribute("Rarity") or plant:GetAttribute("PlantRarity") or plant:GetAttribute("FruitRarity")
    if not matchesMultiFilter(seedName, State.CollectFruit) then return false end
    if not matchesMultiFilter(mutation, State.CollectMutation) then return false end
    if not matchesMultiFilter(rarity, State.CollectRarity) then return false end
    return true
end

function getHarvestPrompts(collectAll)
    local prompts = {}
    local plantsFolder = getPlantsFolder()
    if not plantsFolder then return prompts end
    for _, plant in ipairs(plantsFolder:GetChildren()) do
        if collectAll or plantMatchesCollectFilters(plant) then
            for _, desc in ipairs(plant:GetDescendants()) do
                if desc:IsA("ProximityPrompt") then
                    local action = desc.ActionText:lower()
                    if action:find("harvest") or action:find("collect") then
                        table.insert(prompts, desc)
                    end
                end
            end
        end
    end
    return prompts
end

function collectFruits(collectAll)
    if not collectAll and not State.AutoCollectFruit and not State.AutoCollectAllFruit then return 0 end
    if State.CollectStopWhenFull and isInventoryFull() then return 0 end
    local prompts = getHarvestPrompts(collectAll)
    local collected = 0
    for _, prompt in ipairs(prompts) do
        if not collectAll and not State.AutoCollectFruit and not State.AutoCollectAllFruit then break end
        if State.CollectStopWhenFull and isInventoryFull() then break end
        if fireHarvestPrompt(prompt) then collected += 1 task.wait(0.15) end
    end
    return collected
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SELL — uses Networking.NPCS.SellAll (confirmed working)
-- ═══════════════════════════════════════════════════════════════════════════

function hasSellFilters()
    function isAll(t) return #t == 0 or (#t == 1 and t[1] == "All") end
    return not (isAll(State.SellFruit) and isAll(State.SellMutation) and isAll(State.SellRarity)
        and State.SellMinKg == 0 and State.SellMaxKg == 0)
end

function fruitToolMatchesSellFilters(tool)
    local seedName = tool:GetAttribute("FruitName") or ""
    local mutation = tool:GetAttribute("Mutation") or "None"
    local rarity   = tool:GetAttribute("Rarity") or tool:GetAttribute("FruitRarity") or "Common"
    if not matchesMultiFilter(seedName, State.SellFruit) then return false end
    if not matchesMultiFilter(mutation, State.SellMutation) then return false end
    if not matchesMultiFilter(rarity, State.SellRarity) then return false end
    local hasKgFilter = State.SellMinKg > 0 or State.SellMaxKg > 0
    if hasKgFilter then
        local weight = tonumber(tool:GetAttribute("SizeMultiplier")) or 0
        if State.SellMinKg > 0 and weight < State.SellMinKg then return false end
        if State.SellMaxKg > 0 and weight >= State.SellMaxKg then return false end
    end
    return true
end

function DoAutoSell()
    if State.SellOnlyWhenFull and not CheckBackpackFull() then return end
    if not Networking then return end

    if hasSellFilters() then
        local char = LocalPlayer.Character
        local backpack = LocalPlayer:FindFirstChild("Backpack")
        local soldCount = 0
        for _, parent in ipairs({char, backpack}) do
            if parent then
                for _, tool in ipairs(parent:GetChildren()) do
                    if tool:IsA("Tool") and tool:GetAttribute("FruitName") and fruitToolMatchesSellFilters(tool) then
                        local fruitId = tool:GetAttribute("Id")
                        if fruitId then
                            pcall(function()
                                local result = Networking.NPCS.SellFruit:Fire(fruitId)
                                if result and result.Success then
                                    soldCount += 1
                                    if tool.Parent then tool:Destroy() end
                                end
                            end)
                            task.wait(0.15)
                        end
                    end
                end
            end
        end
    else
        pcall(function()
            local preview = Networking.NPCS.PreviewSellAll:Fire()
            if preview and (preview.FruitCount or 0) > 0 then
                task.wait(0.3)
                Networking.NPCS.SellAll:Fire()
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- STEAL — uses Networking.Steal.BeginSteal + CompleteSteal (from second script)
-- ═══════════════════════════════════════════════════════════════════════════

function GetPlotOwner(plot)
    local ok, label = pcall(function() return plot.Signs.Garden.CorePart.SurfaceGui.Player.TextLabel end)
    if not ok or not label or not label:IsA("TextLabel") then return "Unknown" end
    local text = label.Text or ""
    text = text:gsub("<[^>]+>", "")
    text = text:match("^(.-)%'s%s+Garden$") or text:match("^(.-)%\u{2019}s%s+Garden$") or text
    text = text:match("^%s*(.-)%s*$")
    return text ~= "" and text or "Unknown"
end

function calcFruitValue(fruit, plant)
    local seed = fruit:GetAttribute("CorePartName") or fruit:GetAttribute("FruitName")
              or (plant and plant:GetAttribute("SeedName")) or "Unknown"
    local sizeMulti = tonumber(fruit:GetAttribute("SizeMulti")) or tonumber(fruit:GetAttribute("SizeMultiplier")) or 1
    local mutation = fruit:GetAttribute("Mutation")
    local price = 0
    pcall(function()
        if SellValueData and SellValueData[seed] and FruitValueCalc then
            local base = FruitValueCalc(seed, sizeMulti, mutation, LocalPlayer, fruit:GetAttribute("DecayAlpha"))
            price = SellFlags and SellFlags.Apply(seed, base) or base
        end
    end)
    return price
end

function GetStealablePlants(plot, fruitFilter, rarityFilter, mutationFilter)
    local plants = {}
    local plantsFolder = plot:FindFirstChild("Plants")
    if not plantsFolder then return plants end
    for _, plant in ipairs(plantsFolder:GetChildren()) do
        local isReady = plant:GetAttribute("PlantGrowthReady") or plant:GetAttribute("FruitName") or plant:GetAttribute("HasFruit")
        if not isReady then continue end
        local seedName = plant:GetAttribute("SeedName") or plant:GetAttribute("FruitName") or ""
        local mutation = plant:GetAttribute("Mutation") or "None"
        local rarity = plant:GetAttribute("Rarity") or plant:GetAttribute("PlantRarity") or "Common"
        if not matchesMultiFilter(seedName, fruitFilter) then continue end
        if not matchesMultiFilter(rarity, rarityFilter) then continue end
        if not matchesMultiFilter(mutation, mutationFilter) then continue end
        if State.StealMinValue > 0 then
            local bestVal = 0
            local ff = plant:FindFirstChild("Fruits")
            if ff then
                for _, fruit in ipairs(ff:GetChildren()) do
                    local v = calcFruitValue(fruit, plant)
                    if v > bestVal then bestVal = v end
                end
            end
            if bestVal < State.StealMinValue then continue end
        end
        local prompt = nil
        for _, desc in ipairs(plant:GetDescendants()) do
            if desc:IsA("ProximityPrompt") then
                local a = (desc.ActionText or ""):lower()
                if a:find("harvest") or a:find("collect") or a:find("steal") then
                    prompt = desc; break
                end
            end
        end
        if not prompt then
            for _, desc in ipairs(plant:GetDescendants()) do
                if desc:IsA("ProximityPrompt") then prompt = desc; break end
            end
        end
        if prompt then
            local plantRoot = plant.PrimaryPart or plant:FindFirstChildOfClass("BasePart")
            if plantRoot then
                table.insert(plants, {Plant = plant, Root = plantRoot, Prompt = prompt,
                    SeedName = seedName, Mutation = mutation, Rarity = rarity})
            end
        end
    end
    return plants
end

-- NEW: Fast steal using Networking.Steal.BeginSteal + CompleteSteal
function doFastStealPlant(plantData, ownerUserId)
    local plant = plantData.Plant
    local plantId = plant:GetAttribute("PlantId") or plant.Name
    -- Try all fruits
    local ff = plant:FindFirstChild("Fruits")
    if ff then
        for _, fruit in ipairs(ff:GetChildren()) do
            if not State.AutoSteal then return end
            local fid = fruit:GetAttribute("FruitId") or fruit.Name
            local holdDur = 0
            if StealFlagsModule then
                pcall(function()
                    holdDur = StealFlagsModule.GetStealHoldDuration(plantData.SeedName) or 0
                end)
            end
            TpTo(plantData.Root.Position + Vector3.new(0, 3, 0))
            task.wait(0.15)
            pcall(function() Networking.Steal.BeginSteal:Fire(ownerUserId, plantId, fid) end)
            if holdDur > 0 then task.wait(holdDur + 0.1) end
            pcall(function() Networking.Steal.CompleteSteal:Fire() end)
            task.wait(0.1)
        end
    else
        -- No fruits subfolder, try whole plant
        local fid = plant:GetAttribute("FruitId") or ""
        TpTo(plantData.Root.Position + Vector3.new(0, 3, 0))
        task.wait(0.15)
        pcall(function() Networking.Steal.BeginSteal:Fire(ownerUserId, plantId, fid) end)
        task.wait(0.2)
        pcall(function() Networking.Steal.CompleteSteal:Fire() end)
        task.wait(0.2)
    end
end

function DoAutoSteal()
    if not isNight() then return end
    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then return end
    local myPlot = getOwnedPlot()
    local homePos = nil
    if myPlot then
        local plotPart = (myPlot:FindFirstChild("Visual") and myPlot.Visual:FindFirstChild("PRIM"))
                      or myPlot:FindFirstChild("GardenZone") or myPlot.PrimaryPart
        if plotPart then homePos = plotPart.Position end
    end
    if not homePos then
        local hrp = getRoot()
        if hrp then homePos = hrp.Position end
    end
    if not homePos then return end

    local myNameLower = string.lower(LocalPlayer.Name)
    local myDisplayLower = string.lower(LocalPlayer.DisplayName)
    local targetPlots = {}
    for _, plot in ipairs(Gardens:GetChildren()) do
        if not plot.Name:match("^Plot%d+$") then continue end
        if plot == myPlot then continue end
        local ownerName = GetPlotOwner(plot)
        if ownerName == "Unknown" then continue end
        local ownerLower = string.lower(ownerName)
        if ownerLower:find("empty", 1, true) then continue end
        if ownerLower == myNameLower or ownerLower == myDisplayLower then continue end
        table.insert(targetPlots, plot)
    end
    if #targetPlots == 0 then return end

    local stolenCount = 0
    for _, plot in ipairs(targetPlots) do
        if not State.AutoSteal then return end
        if not isNight() then TpTo(homePos) return end

        -- Get plot owner's UserId for BeginSteal
        local ownerUserId = nil
        pcall(function()
            local label = plot.Signs.Garden.CorePart.SurfaceGui.Player.TextLabel
            local ownerName = label.Text:match("^(.-)'s")
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Name == ownerName or p.DisplayName == ownerName then
                    ownerUserId = p.UserId; break
                end
            end
        end)

        local plotPart = (plot:FindFirstChild("Visual") and plot.Visual:FindFirstChild("PRIM"))
                      or plot:FindFirstChild("GardenZone") or plot.PrimaryPart
        if plotPart then
            TpTo(plotPart.Position + Vector3.new(3, 2, 3))
            task.wait(0.8)
        end

        local plants = GetStealablePlants(plot, State.StealFruit, State.StealRarity, State.StealMutation)
        if #plants == 0 then continue end

        if State.StealPrioritize then
            table.sort(plants, function(a, b)
                function best(pd)
                    local ff = pd.Plant:FindFirstChild("Fruits"); if not ff then return 0 end
                    local best = 0
                    for _, fruit in ipairs(ff:GetChildren()) do
                        local v = calcFruitValue(fruit, pd.Plant); if v > best then best = v end
                    end
                    return best
                end
                return best(a) > best(b)
            end)
        end

        for _, plantData in ipairs(plants) do
            if not State.AutoSteal then return end
            if not isNight() then TpTo(homePos) return end
            if stolenCount >= State.StealLimit then
                TpTo(homePos); task.wait(2)
                stolenCount = 0
                if not isNight() then return end
            end

            -- Use fast remote if we have ownerUserId, else fall back to proximity prompt
            if ownerUserId and Networking and Networking.Steal then
                doFastStealPlant(plantData, ownerUserId)
                stolenCount += 1
            else
                TpTo(plantData.Root.Position + Vector3.new(0, 0, 1.5))
                task.wait(0.35)
                if plantData.Prompt and plantData.Prompt.Enabled then
                    local hd = plantData.Prompt.HoldDuration or 0
                    if fireproximityprompt then
                        fireproximityprompt(plantData.Prompt)
                        task.wait(math.max(hd, 0.1))
                    else
                        pcall(function() plantData.Prompt:InputHoldBegin() end)
                        task.wait(hd > 0 and hd or 0.1)
                        pcall(function() plantData.Prompt:InputHoldEnd() end)
                    end
                    stolenCount += 1
                    task.wait(0.4)
                end
            end
        end
    end
    TpTo(homePos); task.wait(1)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ANTI-STEAL — uses Networking.Shovel.SwingShovel + HitPlayer (from second script)
-- ═══════════════════════════════════════════════════════════════════════════

function findShovelTool()
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    for _, parent in ipairs({char, backpack}) do
        if parent then
            for _, tool in ipairs(parent:GetChildren()) do
                if tool:IsA("Tool") and tool:GetAttribute("Shovel") then return tool end
            end
        end
    end
    return nil
end

function getPlotIntruders()
    local plotId = LocalPlayer:GetAttribute("PlotId")
    if not plotId then return {} end
    local out = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pPlotId = p:GetAttribute("PlotId")
            local ch = p.Character
            if tostring(pPlotId) == tostring(plotId) and ch and ch:FindFirstChild("HumanoidRootPart") then
                table.insert(out, p)
            end
        end
    end
    return out
end

function doAntiSteal()
    if not isNight() then return end
    local intruders = getPlotIntruders()
    if #intruders == 0 then return end
    local shovel = findShovelTool()
    local hrp = getRoot()
    if not shovel or not hrp then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum:EquipTool(shovel) end) end
    local saved = hrp.CFrame
    for _, p in ipairs(intruders) do
        if not State.AntiSteal then break end
        local ch = p.Character
        local tHRP = ch and ch:FindFirstChild("HumanoidRootPart")
        if tHRP then
            local tp = tHRP.Position
            local h2 = getRoot()
            if h2 then h2.CFrame = CFrame.new(tp + Vector3.new(0, 0, 5), tp) end
            pcall(function() Networking.Shovel.SwingShovel:Fire() end)
            pcall(function() Networking.Shovel.HitPlayer:Fire(p.UserId) end)
            task.wait(0.7)
        end
    end
    local hb = getRoot()
    if hb then hb.CFrame = saved end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SHOVEL — uses Networking.Shovel.UseShovel (confirmed)
-- ═══════════════════════════════════════════════════════════════════════════

function shovelTarget(plant, shovelFruits)
    local shovelTool = findShovelTool()
    if not shovelTool then
        pcall(function() ReplicaSet:FireServer(4, {"Inventory", "Gear", "Shovel"}) end)
        local deadline = os.clock() + 2
        while os.clock() < deadline do
            shovelTool = findShovelTool()
            if shovelTool then break end
            task.wait(0.05)
        end
    end
    if not shovelTool then return false end
    local shovelType = shovelTool:GetAttribute("Shovel")
    if not shovelType then return false end
    local plantId = plant.Name
    if shovelFruits then
        local fruitsFolder = plant:FindFirstChild("Fruits")
        if not fruitsFolder then return false end
        for _, fruit in ipairs(fruitsFolder:GetChildren()) do
            if not fruit.Parent then continue end
            pcall(function()
                Networking.Shovel.UseShovel:Fire(plantId, fruit.Name, shovelType, shovelTool)
            end)
            task.wait(0.3)
        end
    else
        pcall(function()
            Networking.Shovel.UseShovel:Fire(plantId, "", shovelType, shovelTool)
        end)
    end
    return true
end

-- ═══════════════════════════════════════════════════════════════════════════
-- WATERING — uses Networking.WateringCan.UseWateringCan (confirmed)
-- ═══════════════════════════════════════════════════════════════════════════

function getWaterPosition()
    if State.WaterPosition == "Saved Position" and State.SavedWaterPos then
        return State.SavedWaterPos
    end
    if State.WaterPosition == "Under Player Character" then
        local root = getRoot()
        if root then return clampToPlantArea(root.Position - Vector3.new(0, 3, 0)) end
    end
    return getRandomPlantPosition()
end

function placeWateringCan(canName)
    local position = getWaterPosition()
    if not position then return false end
    local tool = findGearTool(canName)
    if not tool then
        pcall(function() ReplicaSet:FireServer(4, {"Inventory", "Gear", canName}) end)
        local deadline = os.clock() + 2
        while os.clock() < deadline do
            tool = findGearTool(canName)
            if tool then break end
            task.wait(0.05)
        end
    end
    if not tool then return false end
    local char = LocalPlayer.Character
    if char and tool.Parent ~= char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:UnequipTools() end
        tool.Parent = char
        task.wait(0.1)
    end
    local ok = pcall(function()
        Networking.WateringCan.UseWateringCan:Fire(position, canName, tool)
    end)
    return ok
end

-- ═══════════════════════════════════════════════════════════════════════════
-- SPRINKLER — uses Networking.Place.PlaceSprinkler (confirmed)
-- ═══════════════════════════════════════════════════════════════════════════

function getSprinklerPosition()
    if State.SprinklerPosition == "Saved Position" and State.SavedSprinklerPos then
        return State.SavedSprinklerPos
    end
    if State.SprinklerPosition == "Under Player Character" then
        local root = getRoot()
        if root then return clampToPlantArea(root.Position - Vector3.new(0, 3, 0)) end
    end
    return getRandomPlantPosition()
end

function placeSprinkler(sprinklerName)
    local position = getSprinklerPosition()
    if not position then return false end
    local tool = findGearTool(sprinklerName)
    if not tool then
        pcall(function() ReplicaSet:FireServer(4, {"Inventory", "Gear", sprinklerName}) end)
        local deadline = os.clock() + 2
        while os.clock() < deadline do
            tool = findGearTool(sprinklerName)
            if tool then break end
            task.wait(0.05)
        end
    end
    if not tool then return false end
    local char = LocalPlayer.Character
    if char and tool.Parent ~= char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum:UnequipTools() end
        tool.Parent = char
        task.wait(0.1)
    end
    local plot = getOwnedPlot()
    local plotId = plot and tonumber(plot.Name:match("%d+"))
    if not plotId then return false end
    local ok = pcall(function()
        Networking.Place.PlaceSprinkler:Fire(position, sprinklerName, tool, plotId)
    end)
    return ok
end

-- ═══════════════════════════════════════════════════════════════════════════
-- PET — uses Networking.Pets.WildPetTame (confirmed)
-- ═══════════════════════════════════════════════════════════════════════════

local TARGET_PET_SET = {}
for _, v in ipairs(TARGET_PETS) do TARGET_PET_SET[v] = true end

function ActivatePrompt(prompt)
    if not prompt then return end
    pcall(fireproximityprompt, prompt)
end

function DoAutoBuyPet()
    for k in pairs(TARGET_PET_SET) do TARGET_PET_SET[k] = nil end
    for _, v in ipairs(State.SelectedPets) do TARGET_PET_SET[v] = true end
    local map = workspace:FindFirstChild("Map")
    local WildPetRef = map and map:FindFirstChild("WildPetRef")
    if WildPetRef then
        -- Use WildPetRef BaseParts (more reliable)
        for _, ref in ipairs(WildPetRef:GetChildren()) do
            if ref:IsA("BasePart") then
                local petName = ref:GetAttribute("PetName") or ""
                if TARGET_PET_SET[petName] and (ref:GetAttribute("OwnerUserId") or 0) == 0 then
                    local hrp = getRoot()
                    if hrp then
                        TpTo(ref.Position + Vector3.new(2, 0, 0))
                        task.wait(0.4)
                        pcall(function() Networking.Pets.WildPetTame:Fire(ref) end)
                        task.wait(State.PetBuyDelay)
                    end
                end
            end
        end
    else
        -- Fallback: search workspace models
        pcall(function()
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") then
                    local raw = obj:GetAttribute("PetName") or obj.Name
                    local name = raw:match("WildPet_(.+)_WildPet") or raw:match("WildPet_(.+)") or raw
                    local finalName = obj:GetAttribute("PetName") or name
                    if TARGET_PET_SET[finalName] then
                        local prompt
                        for _, d in ipairs(obj:GetDescendants()) do
                            if d:IsA("ProximityPrompt") then prompt = d; break end
                        end
                        if prompt then
                            local hrp2 = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart
                            if hrp2 then
                                TpTo(hrp2.Position + Vector3.new(2, 0, 0))
                                task.wait(0.4)
                                ActivatePrompt(prompt)
                                task.wait(State.PetBuyDelay)
                            end
                        end
                    end
                end
            end
        end)
    end
end

-- NEW: Buy best rarity wild pet (from second script)
function doAutoBuyBestPet()
    local map = workspace:FindFirstChild("Map")
    local refFolder = map and map:FindFirstChild("WildPetRef")
    if not refFolder then return end
    local best, bestRank = nil, -1
    for _, ref in ipairs(refFolder:GetChildren()) do
        if ref:IsA("BasePart") and (ref:GetAttribute("OwnerUserId") or 0) == 0 then
            local r = ref:GetAttribute("Rarity")
            local rank = (r and RARITY_RANK[r]) or 0
            if rank > bestRank then best = ref; bestRank = rank end
        end
    end
    if not best then return end
    local hrp = getRoot()
    if not hrp then return end
    local t0 = os.clock()
    while State.AutoBuyBestPet and best.Parent
        and (best:GetAttribute("OwnerUserId") or 0) == 0
        and os.clock() - t0 < 30 do
        local h2 = getRoot()
        if h2 then h2.CFrame = CFrame.new(best.Position + Vector3.new(0, 3, 2)) end
        pcall(function() Networking.Pets.WildPetTame:Fire(best) end)
        task.wait(0.15)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EVENT SEEDS — uses SeedPackSpawnServerLocations (from second script)
-- ═══════════════════════════════════════════════════════════════════════════

function doCollectEventSeeds()
    local map = workspace:FindFirstChild("Map")
    local locs = map and map:FindFirstChild("SeedPackSpawnServerLocations")
    if not locs then return end

    local hrp = getRoot()
    if not hrp then return end
    local saved = hrp.CFrame

    for _, marker in ipairs(locs:GetChildren()) do
        if not State.AutoCollectEventSeeds then break end

        local part
        if marker:IsA("BasePart") then
            part = marker
        elseif marker:IsA("Model") then
            part = marker.PrimaryPart or marker:FindFirstChildWhichIsA("BasePart")
        end

        if part then
            local prompt = marker:FindFirstChildOfClass("ProximityPrompt")
                or marker:FindFirstChildWhichIsA("ProximityPrompt", true)

            local t0 = os.clock()

            while State.AutoCollectEventSeeds
                and marker.Parent
                and os.clock() - t0 < 30 do

                local h2 = getRoot()
                if h2 then
                    h2.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
                end

                if prompt and prompt.Enabled then
                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    else
                        pcall(function() prompt:InputHoldBegin() end)
                        task.wait(prompt.HoldDuration > 0 and prompt.HoldDuration or 0.1)
                        pcall(function() prompt:InputHoldEnd() end)
                    end
                end

                -- Stop once the seed pack is collected/despawned
                if not marker.Parent then
                    break
                end

                task.wait(0.15)
            end
        end
    end

    local h2 = getRoot()
    if h2 then
        h2.CFrame = saved
    end
end

-- ═══════════════════════════════════════════════════════════════════════════
-- EGG OPENER — uses Networking.Egg.OpenEgg (from decompiled EggHandleController)
-- ═══════════════════════════════════════════════════════════════════════════

function openEgg(eggName)
    local ok, result = pcall(function()
        return Networking.Egg.OpenEgg:Fire(eggName)
    end)
    if ok then
        print("[Zen] Opened egg:", eggName)
        return true
    end
    return false
end

function findEggTools()
    local eggs = {}
    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    for _, parent in ipairs({char, backpack}) do
        if not parent then continue end
        for _, tool in ipairs(parent:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("Egg") then
                table.insert(eggs, tool)
            end
        end
    end
    return eggs
end

function openAllEggs()
    local eggs = findEggTools()
    local count = 0
    for _, tool in ipairs(eggs) do
        local eggName = tool:GetAttribute("Egg")
        if eggName then
            if openEgg(eggName) then count += 1 end
            task.wait(State.EggOpenDelay)
        end
    end
    return count
end

-- ═══════════════════════════════════════════════════════════════════════════
-- FAVORITES
-- ═══════════════════════════════════════════════════════════════════════════

function fruitMatchesFavoriteFilters(fruit, plant)
    local seedName = fruit:GetAttribute("CorePartName") or fruit:GetAttribute("FruitName")
                  or (plant and plant:GetAttribute("SeedName")) or ""
    local mutation = fruit:GetAttribute("Mutation") or (plant and plant:GetAttribute("Mutation")) or "None"
    local rarity   = fruit:GetAttribute("Rarity") or fruit:GetAttribute("FruitRarity")
                  or (plant and (plant:GetAttribute("Rarity") or plant:GetAttribute("PlantRarity"))) or "Common"
    if not matchesMultiFilter(seedName, State.FavoriteFruit) then return false end
    if not matchesMultiFilter(mutation, State.FavoriteMutation) then return false end
    if not matchesMultiFilter(rarity, State.FavoriteRarity) then return false end
    return true
end

function doFavoriteFruits(favoriteMode)
    local plantsFolder = getPlantsFolder()
    if not plantsFolder then return end
    local count = 0
    for _, plant in ipairs(plantsFolder:GetChildren()) do
        local fruitsFolder = plant:FindFirstChild("Fruits")
        if not fruitsFolder then continue end
        for _, fruit in ipairs(fruitsFolder:GetChildren()) do
            local fruitId = fruit:GetAttribute("FruitId") or fruit:GetAttribute("Id") or fruit.Name
            local shouldProcess = favoriteMode == nil or fruitMatchesFavoriteFilters(fruit, plant)
            if shouldProcess then
                local fav = (favoriteMode == true)
                local ok1 = pcall(function()
                    ReplicaSet:FireServer(2, {"Inventory", "Fruits", tostring(fruitId), "Favorited"}, fav)
                end)
                if not ok1 then
                    pcall(function()
                        local flagByte = fav and "\001" or "\000"
                        local idStr = tostring(fruitId)
                        PacketRemote:FireServer(buffer.fromstring("f\000" .. string.char(#idStr) .. idStr .. flagByte))
                    end)
                end
                count += 1
                task.wait(0.08)
            end
        end
    end
    print(("[Zen] %s %d fruit(s)."):format(
        favoriteMode == true and "Favorited" or favoriteMode == false and "Unfavorited" or "Unfavorited ALL", count))
end

-- ═══════════════════════════════════════════════════════════════════════════
-- BARGAIN
-- ═══════════════════════════════════════════════════════════════════════════

function DoAutoBargain()
    if not Networking then return end
    local ok, previewData = pcall(function() return Networking.NPCS.PreviewSellAll:Fire() end)
    if not ok or not previewData or (previewData.FruitCount or 0) <= 0 then return end
    local baseValue = previewData.TotalValue or 0
    local targetValue = baseValue * State.BargainTargetMult
    local attempt = 0
    local currentOffer = baseValue
    while attempt < State.BargainMaxAttempts do
        if currentOffer >= targetValue then break end
        local feePct = math.floor(currentOffer * 0.05) / math.max(currentOffer, 1)
        if feePct > State.BargainMaxFeePct then break end
        attempt += 1
        local bidResult
        local bidOk = pcall(function() bidResult = Networking.NPCS.AskBidAll:Fire() end)
        if not bidOk or not bidResult then break end
        if not bidResult.Success then
            if bidResult.Reason == "Cooldown" then
                task.wait((bidResult.Remaining or 10) + 0.5)
                attempt -= 1; continue
            else break end
        end
        currentOffer = bidResult.NewTotalSellValue or bidResult.NewTotalOffer or currentOffer
        if bidResult.HadLegendary then break end
        if attempt < State.BargainMaxAttempts and currentOffer < targetValue then task.wait(12.5) end
    end
    pcall(function() Networking.NPCS.SellAll:Fire() end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- DELETE OTHERS GARDEN
-- ═══════════════════════════════════════════════════════════════════════════

function deleteOthersGarden()
    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then Library:Notification("Gardens not found.", 3, nil) return end
    local myPlot = getOwnedPlot()
    local myName = string.lower(LocalPlayer.Name)
    local myDisp = string.lower(LocalPlayer.DisplayName)
    local deleted = 0
    for _, plot in ipairs(Gardens:GetChildren()) do
        if not plot.Name:match("^Plot%d+$") then continue end
        if plot == myPlot then continue end
        local ownerName = GetPlotOwner(plot)
        if ownerName == "Unknown" then continue end
        local ownerLower = string.lower(ownerName)
        if ownerLower == myName or ownerLower == myDisp then continue end
        if ownerLower:find("empty", 1, true) then continue end
        local plantsFolder = plot:FindFirstChild("Plants")
        if not plantsFolder then continue end
        for _, plant in ipairs(plantsFolder:GetChildren()) do
            if not plant.Parent then continue end
            local plantId = plant:GetAttribute("PlantId") or plant.Name
            pcall(function()
                PacketRemote:FireServer(buffer.fromstring("D\000" .. tostring(plantId) .. "\006ShovelF\000"))
            end)
            deleted += 1
            task.wait(0.1)
        end
    end
    Library:Notification(("Deleted %d plants from other gardens."):format(deleted), 4, nil)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- LOOP STARTERS/STOPPERS
-- ═══════════════════════════════════════════════════════════════════════════

function stopPlantLoop() PlantLoopId += 1 end
function startPlantLoop()
    PlantLoopId += 1; local myId = PlantLoopId
    task.spawn(function()
        local seedIndex = 1
        while myId == PlantLoopId and (State.AutoPlantSeed or State.AutoPlantAllSeeds) do
            local seeds = getSeedsToPlant()
            if #seeds == 0 then task.wait(0.5); continue end
            if seedIndex > #seeds then seedIndex = 1 end
            plantSeedFast(seeds[seedIndex])
            teleportHomeIfForced()
            seedIndex += 1
            task.wait(State.PlantDelay > 0 and State.PlantDelay or 0.05)
        end
    end)
end

function setAutoPlant(enabled)
    State.AutoPlantSeed = enabled
    if enabled then startPlantLoop() elseif not State.AutoPlantAllSeeds then stopPlantLoop() end
end

function setAutoPlantAll(enabled)
    State.AutoPlantAllSeeds = enabled
    if enabled then State.AutoPlantSeed = true; startPlantLoop()
    else State.AutoPlantSeed = false; stopPlantLoop() end
end

function stopCollectLoop() CollectLoopId += 1 end
function startCollectLoop()
    CollectLoopId += 1; local myId = CollectLoopId
    task.spawn(function()
        while myId == CollectLoopId and (State.AutoCollectFruit or State.AutoCollectAllFruit) do
            if State.CollectStopWhenFull and isInventoryFull() then task.wait(2); continue end
            collectFruits(State.AutoCollectAllFruit)
            teleportHomeIfForced()
            task.wait(0.5)
        end
    end)
end

-- Fast harvest loop (uses CollectFruit remote)
function stopHarvestFastLoop() HarvestFastLoopId += 1 end
function startHarvestFastLoop()
    HarvestFastLoopId += 1; local id = HarvestFastLoopId
    task.spawn(function()
        while id == HarvestFastLoopId and State.AutoHarvestFast do
            doFastHarvest()
            RunService.Heartbeat:Wait()
        end
    end)
end

function stopBuySeedLoop() BuySeedLoopId += 1 end
function startBuySeedLoop()
    BuySeedLoopId += 1; local myId = BuySeedLoopId
    task.spawn(function()
        while myId == BuySeedLoopId and (State.AutoBuySeeds or State.AutoBuyAllSeeds) do
            local items = State.AutoBuyAllSeeds and ALL_SEEDS or State.SelectedShopSeeds
            for _, seed in ipairs(items) do
                if myId ~= BuySeedLoopId or not (State.AutoBuySeeds or State.AutoBuyAllSeeds) then break end
                buySeed(seed); task.wait(0.06)
            end
            task.wait(0.5)
        end
    end)
end

function stopBuyGearLoop() BuyGearLoopId += 1 end
function startBuyGearLoop()
    BuyGearLoopId += 1; local myId = BuyGearLoopId
    task.spawn(function()
        while myId == BuyGearLoopId and (State.AutoBuyGear or State.AutoBuyAllGear) do
            local items = State.AutoBuyAllGear and ALL_GEAR or State.SelectedGear
            for _, item in ipairs(items) do
                if myId ~= BuyGearLoopId or not (State.AutoBuyGear or State.AutoBuyAllGear) then break end
                buyGear(item); task.wait(0.06)
            end
            task.wait(0.5)
        end
    end)
end

function stopBuyCrateLoop() BuyCrateLoopId += 1 end
function startBuyCrateLoop()
    BuyCrateLoopId += 1; local myId = BuyCrateLoopId
    task.spawn(function()
        while myId == BuyCrateLoopId and (State.AutoBuyCrate or State.AutoBuyAllCrates) do
            local items = State.AutoBuyAllCrates and ALL_CRATES or State.SelectedCrate
            for _, crate in ipairs(items) do
                if myId ~= BuyCrateLoopId or not (State.AutoBuyCrate or State.AutoBuyAllCrates) then break end
                buyCrate(crate); task.wait(0.06)
            end
            task.wait(0.5)
        end
    end)
end

function stopPetLoop() PetLoopId += 1 end
function startPetLoop()
    PetLoopId += 1; local id = PetLoopId
    task.spawn(function()
        while id == PetLoopId and State.AutoBuyPet do
            DoAutoBuyPet(); task.wait(1)
        end
    end)
end

function stopBestPetLoop() BestPetLoopId += 1 end
function startBestPetLoop()
    BestPetLoopId += 1; local id = BestPetLoopId
    task.spawn(function()
        while id == BestPetLoopId and State.AutoBuyBestPet do
            doAutoBuyBestPet(); task.wait(0.5)
        end
    end)
end

function stopStealLoop() StealLoopId += 1 end
function startStealLoop()
    StealLoopId += 1; local id = StealLoopId
    task.spawn(function()
        while id == StealLoopId and State.AutoSteal do
            if not isNight() then
                repeat
                    task.wait(5)
                    if id ~= StealLoopId or not State.AutoSteal then return end
                until isNight()
            end
            DoAutoSteal()
            if id == StealLoopId and State.AutoSteal then task.wait(8) end
        end
    end)
end

function stopAntiStealLoop() AntiStealLoopId += 1 end
function startAntiStealLoop()
    AntiStealLoopId += 1; local id = AntiStealLoopId
    task.spawn(function()
        while id == AntiStealLoopId and State.AntiSteal do
            doAntiSteal(); task.wait(0.2)
        end
    end)
end

function stopSellLoop() SellLoopId += 1 end
function startSellLoop()
    SellLoopId += 1; local id = SellLoopId
    task.spawn(function()
        while id == SellLoopId and State.AutoSell do
            if State.AllowBargainWhileSelling then DoAutoBargain() else DoAutoSell() end
            task.wait(math.max(1, State.SellDelay))
        end
    end)
end

function stopWaterLoop() WaterLoopId += 1 end
function startWaterLoop()
    WaterLoopId += 1; local id = WaterLoopId
    task.spawn(function()
        local canIndex = 1
        while id == WaterLoopId and (State.AutoWater or State.AutoWaterAll) do
            local list = State.AutoWaterAll and ALL_WATERING_CANS or {State.SelectedWateringCan}
            if #list == 0 then task.wait(0.5); continue end
            if canIndex > #list then canIndex = 1 end
            placeWateringCan(list[canIndex])
            teleportHomeIfForced()
            canIndex += 1
            task.wait(State.WaterDelay > 0 and State.WaterDelay or 0.1)
        end
    end)
end

function stopShovelLoop() ShovelLoopId += 1 end
function startShovelLoop(shovelFruits)
    ShovelLoopId += 1; local id = ShovelLoopId
    task.spawn(function()
        while id == ShovelLoopId and (State.AutoShovelTree or State.AutoShovelFruit) do
            local plantsFolder = getPlantsFolder()
            if not plantsFolder then task.wait(2); continue end
            for _, plant in ipairs(plantsFolder:GetChildren()) do
                if id ~= ShovelLoopId then break end
                if not (State.AutoShovelTree or State.AutoShovelFruit) then break end
                if not plant.Parent then continue end
                local seedName = plant:GetAttribute("SeedName") or ""
                local rarity   = plant:GetAttribute("Rarity") or "Common"
                local mutation = plant:GetAttribute("Mutation") or "None"
                if shovelFruits then
                    if not matchesMultiFilter(seedName, State.ShovelFruits) then continue end
                    if not matchesMultiFilter(rarity, State.ShovelFruitRarity) then continue end
                    if not matchesMultiFilter(mutation, State.ShovelFruitMutation) then continue end
                else
                    local shouldShovel = #State.SelectedShovelSeeds == 0
                    if not shouldShovel then
                        for _, sel in ipairs(State.SelectedShovelSeeds) do
                            if sel == seedName then shouldShovel = true; break end
                        end
                    end
                    if not shouldShovel then continue end
                    if not matchesMultiFilter(rarity, State.ShovelTreeRarity) then continue end
                    if not matchesMultiFilter(mutation, State.ShovelTreeMutation) then continue end
                end
                shovelTarget(plant, shovelFruits)
                teleportHomeIfForced()
                task.wait(0.5)
            end
            task.wait(2)
        end
    end)
end

function stopSeedPackLoop() SeedPackLoopId += 1 end
function startSeedPackLoop()
    SeedPackLoopId += 1; local id = SeedPackLoopId
    task.spawn(function()
        while id == SeedPackLoopId and State.AutoSeedPack do
            local map = workspace:FindFirstChild("Map")
            local locs = map and map:FindFirstChild("SeedPackSpawnServerLocations")
            if not locs or #locs:GetChildren() == 0 then task.wait(2); continue end
            for _, item in ipairs(locs:GetChildren()) do
                if id ~= SeedPackLoopId or not State.AutoSeedPack then break end
                local pos
                if item:IsA("BasePart") then pos = item.Position
                elseif item:IsA("Model") then
                    local pp = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                    if pp then pos = pp.Position end
                end
                if not pos then continue end
                TpTo(pos + Vector3.new(0, 0, 1.5))
                task.wait(0.25)
                local prompt = item:FindFirstChildOfClass("ProximityPrompt")
                    or item:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt and prompt.Enabled then
                    if fireproximityprompt then
                        fireproximityprompt(prompt); task.wait(0.2)
                    else
                        pcall(function() prompt:InputHoldBegin() end)
                        task.wait(prompt.HoldDuration > 0 and prompt.HoldDuration or 0.1)
                        pcall(function() prompt:InputHoldEnd() end)
                    end
                    task.wait(0.2)
                end
            end
            task.wait(1)
        end
    end)
end

function stopSprinklerLoop() SprinklerLoopId += 1 end
function startSprinklerLoop()
    SprinklerLoopId += 1; local myId = SprinklerLoopId
    task.spawn(function()
        local idx = 1
        while myId == SprinklerLoopId and (State.AutoPlaceSprinkler or State.AutoPlaceAllSprinklers) do
            local list = State.AutoPlaceAllSprinklers and ALL_SPRINKLERS or {State.SelectedSprinkler}
            if #list == 0 then task.wait(0.5); continue end
            if idx > #list then idx = 1 end
            placeSprinkler(list[idx])
            teleportHomeIfForced()
            idx += 1
            task.wait(State.SprinklerDelay > 0 and State.SprinklerDelay or 0.1)
        end
    end)
end

function stopFavoriteLoop() FavoriteLoopId += 1 end
function startFavoriteLoop(mode)
    FavoriteLoopId += 1; local id = FavoriteLoopId
    task.spawn(function()
        while id == FavoriteLoopId and (State.AutoFavoriteFruit or State.AutoUnfavoriteFruit or State.AutoUnfavoriteAll) do
            if mode == "favorite" then doFavoriteFruits(true)
            elseif mode == "unfavorite" then doFavoriteFruits(false)
            elseif mode == "unfavoriteAll" then doFavoriteFruits(nil) end
            task.wait(3)
        end
    end)
end

function stopEggLoop() EggLoopId += 1 end
function startEggLoop()
    EggLoopId += 1; local id = EggLoopId
    function watchParent(parent)
        if not parent then return end
        parent.ChildAdded:Connect(function(tool)
            if id ~= EggLoopId or not State.AutoOpenEggs then return end
            if tool:IsA("Tool") and tool:GetAttribute("Egg") then
                task.wait(0.2)
                local eggName = tool:GetAttribute("Egg")
                if eggName then openEgg(eggName) end
            end
        end)
    end
    watchParent(LocalPlayer.Character)
    watchParent(LocalPlayer:FindFirstChild("Backpack"))
    LocalPlayer.CharacterAdded:Connect(function(c)
        if id ~= EggLoopId or not State.AutoOpenEggs then return end
        watchParent(c)
    end)
    task.spawn(function()
        if id == EggLoopId and State.AutoOpenEggs then openAllEggs() end
    end)
end

function stopBargainLoop() BargainLoopId += 1 end
function startBargainLoop()
    BargainLoopId += 1; local id = BargainLoopId
    task.spawn(function()
        while id == BargainLoopId and State.AutoBargain do
            DoAutoBargain()
            if id == BargainLoopId and State.AutoBargain then task.wait(5) end
        end
    end)
end

function stopEventSeedLoop() EventSeedLoopId += 1 end
function startEventSeedLoop()
    EventSeedLoopId += 1; local id = EventSeedLoopId
    task.spawn(function()
        while id == EventSeedLoopId and State.AutoCollectEventSeeds do
            doCollectEventSeeds(); task.wait(1)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    setWalkSpeed()
    if State.NoClip then setNoClip(true) end
    if State.FlyEnabled then setFly(true) end
    if State.JumpPowerEnabled then setJumpPower(true) end
    if State.HipHeightEnabled then setHipHeight(true) end
    if State.GravityEnabled then setGravity(true) end
    if State.InstantPrompt then setInstantPrompt(true) end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- ESP SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════

local FruitPriceCache = {}

local ESP = {
    FruitEnabled   = false,
    PetEnabled     = false,
    FruitFilter    = { "All" },
    FruitRarity    = { "All" },
    FruitMutation  = { "All" },
    PetFilter      = { "All" },
    PetRarity      = { "All" },
    PetSize        = { "All" },
    Bills          = {},
    BestFruitEnabled = false,
    BestFruitBill    = nil,
    BestFruitConn    = nil,
}

local PET_RARITIES = { "All", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" }
local PET_SIZES    = { "All", "Tiny", "Small", "Normal", "Large", "Huge", "Titanic" }
local PET_NAMES    = { "All", "Bee", "BlackDragon", "Bunny", "Deer", "Frog",
                       "GoldenDragonfly", "IceSerpent", "Monkey", "Owl",
                       "Raccoon", "Robin", "Unicorn" }

local RARITY_COLORS = {
    Common    = Color3.fromRGB(180, 180, 180),
    Uncommon  = Color3.fromRGB( 80, 200,  80),
    Rare      = Color3.fromRGB( 80, 140, 255),
    Epic      = Color3.fromRGB(160,  80, 255),
    Legendary = Color3.fromRGB(255, 180,  30),
    Mythic    = Color3.fromRGB(255,  60, 120),
    Super     = Color3.fromRGB( 30, 220, 255),
    Divine    = Color3.fromRGB(255, 255, 100),
    Prismatic = Color3.fromRGB(255, 100, 255),
}

local function rarityColor(rarity)
    return RARITY_COLORS[rarity] or Color3.fromRGB(220, 220, 220)
end

local function mutationColor(mutation)
    local m = mutation or "None"
    local map = {
        Gold       = Color3.fromRGB(255, 210,  30),
        Rainbow    = Color3.fromRGB(255, 100, 255),
        Electric   = Color3.fromRGB(100, 220, 255),
        Solarflare = Color3.fromRGB(255, 140,  30),
        Frozen     = Color3.fromRGB(160, 230, 255),
        Bloodlit   = Color3.fromRGB(200,  30,  30),
        Chained    = Color3.fromRGB(140, 140, 140),
        Pizza      = Color3.fromRGB(255, 160,  30),
        Starstruck = Color3.fromRGB(255, 240, 100),
    }
    return map[m]
end

local function removeESPBill(inst)
    local data = ESP.Bills[inst]
    if data then
        if data.conn then data.conn:Disconnect() end
        if data.bill and data.bill.Parent then data.bill:Destroy() end
        ESP.Bills[inst] = nil
    end
end

local function makeESPBill(part, lines)
    local bill = Instance.new("BillboardGui")
    bill.Name            = "ZenESP"
    bill.AlwaysOnTop     = true
    bill.MaxDistance     = 1200
    bill.Size            = UDim2.new(0, 280, 0, 18 * #lines + 8)
    bill.StudsOffset     = Vector3.new(0, 3.5, 0)
    bill.LightInfluence  = 0
    bill.ResetOnSpawn    = false
    bill.Adornee         = part
    bill.Parent          = part

    for i, ln in ipairs(lines) do
        local frame = Instance.new("Frame")
        frame.BackgroundTransparency = 1
        frame.Size     = UDim2.new(1, 0, 0, 18)
        frame.Position = UDim2.new(0, 0, 0, (i - 1) * 18)
        frame.Parent   = bill

        local bg = Instance.new("Frame")
        bg.BackgroundColor3       = Color3.fromRGB(8, 8, 12)
        bg.BackgroundTransparency = 0.45
        bg.BorderSizePixel        = 0
        bg.Size                   = UDim2.new(1, 4, 1, 2)
        bg.Position               = UDim2.new(0, -2, 0, -1)
        bg.Parent                 = frame
        Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 3)

        if ln.costColor then
            local text  = ln.text
            local splitAt = text:find("%[ %$")
            local leftPart  = splitAt and text:sub(1, splitAt - 1) or text
            local rightPart = splitAt and text:sub(splitAt) or ""

            local lblLeft = Instance.new("TextLabel")
            lblLeft.BackgroundTransparency = 1
            lblLeft.Size        = UDim2.new(1, 0, 1, 0)
            lblLeft.Text        = leftPart
            lblLeft.TextColor3  = ln.color
            lblLeft.TextSize    = ln.size or 13
            lblLeft.Font        = Enum.Font.GothamBold
            lblLeft.TextStrokeTransparency = 0.3
            lblLeft.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
            lblLeft.TextXAlignment = Enum.TextXAlignment.Center
            lblLeft.Parent      = frame

            lblLeft.RichText = true
            lblLeft.Text = ('<font color="rgb(%d,%d,%d)">%s</font><font color="rgb(0,255,80)">%s</font>'):format(
                math.floor(ln.color.R * 255),
                math.floor(ln.color.G * 255),
                math.floor(ln.color.B * 255),
                leftPart,
                rightPart
            )
        else
            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size        = UDim2.new(1, 0, 1, 0)
            lbl.Text        = ln.text
            lbl.TextColor3  = ln.color or Color3.fromRGB(255, 255, 255)
            lbl.TextSize    = ln.size or 13
            lbl.Font        = Enum.Font.GothamBold
            lbl.TextStrokeTransparency = 0.3
            lbl.TextStrokeColor3       = Color3.fromRGB(0, 0, 0)
            lbl.TextXAlignment = Enum.TextXAlignment.Center
            lbl.Parent      = frame
        end
    end

    return bill
end

local function getFruitPrice(fruit, seed)
    local sizeMulti = tonumber(fruit:GetAttribute("SizeMulti"))
                   or tonumber(fruit:GetAttribute("SizeMultiplier"))
                   or 1
    local mutation = fruit:GetAttribute("Mutation")
    local price = 0
    pcall(function()
        if SellValueData[seed] then
            local base = FruitValueCalc(seed, sizeMulti, mutation, LocalPlayer, fruit:GetAttribute("DecayAlpha"))
            price = SellFlags.Apply(seed, base)
        end
    end)
    return price
end

local function buildFruitLines(fruit, plantFallback)
    local seed     = fruit:GetAttribute("CorePartName")
                  or fruit:GetAttribute("FruitName")
                  or fruit:GetAttribute("SeedName")
                  or (plantFallback and plantFallback:GetAttribute("SeedName"))
                  or "Unknown"
    local rarity   = fruit:GetAttribute("Rarity")
                  or fruit:GetAttribute("FruitRarity")
                  or (plantFallback and (plantFallback:GetAttribute("Rarity") or plantFallback:GetAttribute("PlantRarity")))
                  or "Common"
    local mutation = fruit:GetAttribute("Mutation")
                  or (plantFallback and plantFallback:GetAttribute("Mutation"))
                  or ""
    local sizeMulti = tonumber(fruit:GetAttribute("SizeMulti"))
                   or tonumber(fruit:GetAttribute("SizeMultiplier"))
                   or 1

    local realWeight = nil
    pcall(function()
        realWeight = FruitVisualizerController:CalculateFruitWeight(fruit)
    end)
    local displayKg = realWeight or sizeMulti

    local price = 0
    pcall(function()
        if SellValueData[seed] then
            local base = FruitValueCalc(seed, sizeMulti, mutation ~= "" and mutation or nil, LocalPlayer, fruit:GetAttribute("DecayAlpha"))
            price = SellFlags.Apply(seed, base)
        end
    end)

    local rc  = rarityColor(rarity)
    local kg  = ("%.2fkg"):format(tonumber(displayKg) or 0)
    local function abbreviate(n)
        n = math.floor(tonumber(n) or 0)
        if n >= 1e9 then return ("$%.1fB"):format(n/1e9)
        elseif n >= 1e6 then return ("$%.1fM"):format(n/1e6)
        elseif n >= 1e3 then return ("$%.1fK"):format(n/1e3)
        else return ("$%d"):format(n) end
    end
    local cost = abbreviate(price)
    local lines = {}

    table.insert(lines, {
        text      = ("%s [ %s ] [ %s ]"):format(seed, kg, cost),
        color     = rc,
        size      = 13,
        costColor = Color3.fromRGB(0, 255, 80),
    })

    if mutation ~= "" and mutation ~= "None" then
        local mc = mutationColor(mutation) or Color3.fromRGB(255, 255, 255)
        table.insert(lines, { text = mutation, color = mc, size = 12 })
    end

    return lines
end

local function refreshBestFruitESP()
    if ESP.BestFruitBill then
        ESP.BestFruitBill:Destroy()
        ESP.BestFruitBill = nil
    end
    if not ESP.BestFruitEnabled then return end

    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then return end

    local bestFruit, bestPlant, bestPrice = nil, nil, -1

    for _, plot in ipairs(Gardens:GetChildren()) do
        local pf = plot:FindFirstChild("Plants")
        if not pf then continue end
        for _, plant in ipairs(pf:GetChildren()) do
            local fruitsFolder = plant:FindFirstChild("Fruits")
            if not fruitsFolder then continue end
            for _, fruit in ipairs(fruitsFolder:GetChildren()) do
                local seed = fruit:GetAttribute("CorePartName")
                          or fruit:GetAttribute("FruitName")
                          or plant:GetAttribute("SeedName")
                          or "Unknown"
                local price = getFruitPrice(fruit, seed)
                if price > bestPrice then
                    bestPrice = price
                    bestFruit = fruit
                    bestPlant = plant
                end
            end
        end
    end

    if bestFruit then
        local part = bestFruit.PrimaryPart or bestFruit:FindFirstChildOfClass("BasePart")
        if part then
            local lines = buildFruitLines(bestFruit, bestPlant)
            table.insert(lines, 1, { text = "★ BEST FRUIT ★", color = Color3.fromRGB(255, 215, 0), size = 12 })
            ESP.BestFruitBill = makeESPBill(part, lines)
        end
    end
end

local function startBestFruitESP()
    refreshBestFruitESP()
    if ESP.BestFruitConn then ESP.BestFruitConn:Disconnect() end
    ESP.BestFruitConn = RunService.Heartbeat:Connect(function()
        if not ESP.BestFruitEnabled then
            ESP.BestFruitConn:Disconnect()
            ESP.BestFruitConn = nil
            return
        end
        refreshBestFruitESP()
    end)
end

local function stopBestFruitESP()
    if ESP.BestFruitConn then ESP.BestFruitConn:Disconnect() ESP.BestFruitConn = nil end
    if ESP.BestFruitBill then ESP.BestFruitBill:Destroy() ESP.BestFruitBill = nil end
end

local function plantPassesFilter(plant)
    local seed     = plant:GetAttribute("SeedName")
                  or plant:GetAttribute("CorePartName")
                  or ""
    local rarity   = plant:GetAttribute("Rarity") or plant:GetAttribute("PlantRarity") or plant:GetAttribute("FruitRarity") or "Common"
    local mutation = plant:GetAttribute("Mutation") or "None"
    if not matchesMultiFilter(seed,     ESP.FruitFilter)   then return false end
    if not matchesMultiFilter(rarity,   ESP.FruitRarity)   then return false end
    if not matchesMultiFilter(mutation, ESP.FruitMutation) then return false end
    return true
end

local function refreshFruitESP()
    for key, data in pairs(ESP.Bills) do
        if data.isFruit then
            local inst = data.inst
            if not ESP.FruitEnabled or not inst or not inst.Parent then
                if data.conn then data.conn:Disconnect() end
                if data.bill and data.bill.Parent then data.bill:Destroy() end
                if inst then
                    local fid = inst:GetAttribute("FruitId") or inst.Name
                    FruitPriceCache[fid] = nil
                end
                ESP.Bills[key] = nil
            end
        end
    end

    if not ESP.FruitEnabled then return end

    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then return end

    for _, plot in ipairs(Gardens:GetChildren()) do
        local pf = plot:FindFirstChild("Plants")
        if not pf then continue end

        for _, plant in ipairs(pf:GetChildren()) do
            if not plantPassesFilter(plant) then continue end

            local fruitsFolder = plant:FindFirstChild("Fruits")
            if fruitsFolder then
                for _, fruit in ipairs(fruitsFolder:GetChildren()) do
                    local fruitKey = "fruit_" .. tostring(fruit)
                    if not ESP.Bills[fruitKey] then
                        local part = fruit.PrimaryPart or fruit:FindFirstChildOfClass("BasePart")
                        if part then
                            local bill = makeESPBill(part, buildFruitLines(fruit, plant))
                            local conn = fruit.AttributeChanged:Connect(function()
                                if not ESP.FruitEnabled then return end
                                local d = ESP.Bills[fruitKey]
                                if d then
                                    if d.conn then d.conn:Disconnect() end
                                    if d.bill and d.bill.Parent then d.bill:Destroy() end
                                    local fid = fruit:GetAttribute("FruitId") or fruit.Name
                                    FruitPriceCache[fid] = nil
                                    ESP.Bills[fruitKey] = nil
                                end
                                if fruit.Parent and plantPassesFilter(plant) then
                                    local p2 = fruit.PrimaryPart or fruit:FindFirstChildOfClass("BasePart")
                                    if p2 then
                                        local b2 = makeESPBill(p2, buildFruitLines(fruit, plant))
                                        local c2 = fruit.AttributeChanged:Connect(function() end)
                                        ESP.Bills[fruitKey] = { bill = b2, conn = c2, inst = fruit, isFruit = true }
                                    end
                                end
                            end)
                            ESP.Bills[fruitKey] = { bill = bill, conn = conn, inst = fruit, isFruit = true }
                        end
                    end
                end
            end
        end
    end

    for key, data in pairs(ESP.Bills) do
        if (data.isFruit or data.isTree) and (not data.inst or not data.inst.Parent) then
            if data.conn then data.conn:Disconnect() end
            if data.bill and data.bill.Parent then data.bill:Destroy() end
            if data.inst then
                local fid = data.inst:GetAttribute("FruitId") or data.inst.Name
                FruitPriceCache[fid] = nil
            end
            ESP.Bills[key] = nil
        end
    end
end

local FruitESPConn = nil
local function startFruitESP()
    refreshFruitESP()
    if FruitESPConn then FruitESPConn:Disconnect() end
    FruitESPConn = RunService.Heartbeat:Connect(function()
        if not ESP.FruitEnabled then
            FruitESPConn:Disconnect()
            FruitESPConn = nil
            return
        end
        refreshFruitESP()
    end)
end

local function stopFruitESP()
    if FruitESPConn then FruitESPConn:Disconnect() FruitESPConn = nil end
    for key, data in pairs(ESP.Bills) do
        if data.isFruit then
            if data.conn then data.conn:Disconnect() end
            if data.bill and data.bill.Parent then data.bill:Destroy() end
            ESP.Bills[key] = nil
        end
    end
end

local function petPassesFilter(obj)
    local petName = obj:GetAttribute("PetName") or obj.Name:match("WildPet_(.+)_WildPet") or obj.Name:match("WildPet_(.+)") or obj.Name
    local rarity  = obj:GetAttribute("Rarity") or "Common"
    local size    = obj:GetAttribute("Size") or "Normal"
    if not matchesMultiFilter(petName, ESP.PetFilter)  then return false end
    if not matchesMultiFilter(rarity,  ESP.PetRarity)  then return false end
    if not matchesMultiFilter(size,    ESP.PetSize)    then return false end
    return true
end

local function buildPetLines(obj)
    local raw     = obj:GetAttribute("PetName") or obj.Name
    local petName = raw:match("WildPet_(.+)_WildPet") or raw:match("WildPet_(.+)") or raw
    local rarity  = obj:GetAttribute("Rarity") or "Common"
    local size    = obj:GetAttribute("Size") or ""
    local value   = obj:GetAttribute("Value") or obj:GetAttribute("SellValue") or obj:GetAttribute("Price") or 0
    local rc      = rarityColor(rarity)

    local function abbreviate(n)
        n = math.floor(tonumber(n) or 0)
        if n >= 1e9 then return ("$%.1fB"):format(n/1e9)
        elseif n >= 1e6 then return ("$%.1fM"):format(n/1e6)
        elseif n >= 1e3 then return ("$%.1fK"):format(n/1e3)
        else return ("$%d"):format(n) end
    end
    local cost = abbreviate(value)

    local lines = {}
    table.insert(lines, {
        text      = ("%s [ %s ]"):format(petName, cost),
        color     = rc,
        size      = 13,
        costColor = Color3.fromRGB(0, 255, 80),
    })
    table.insert(lines, { text = rarity:upper(), color = rc, size = 11 })
    if size ~= "" and size ~= "Normal" then
        table.insert(lines, { text = size, color = Color3.fromRGB(200, 200, 200), size = 10 })
    end
    return lines
end

local PetESPConn = nil
function refreshPetESP()
    for inst, data in pairs(ESP.Bills) do
        if data.isPet then
            if not ESP.PetEnabled or not inst.Parent or not petPassesFilter(inst) then
                removeESPBill(inst)
            end
        end
    end
    if not ESP.PetEnabled then return end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and not ESP.Bills[obj] then
            local hasPet = obj:GetAttribute("PetName") or obj.Name:match("WildPet_")
            if hasPet and petPassesFilter(obj) then
                local part = obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart")
                if part then
                    local bill = makeESPBill(part, buildPetLines(obj))
                    ESP.Bills[obj] = {bill=bill, conn=nil, isPet=true}
                end
            end
        end
    end
end

function startPetESP()
    refreshPetESP()
    if PetESPConn then PetESPConn:Disconnect() end
    PetESPConn = RunService.Heartbeat:Connect(function()
        if not ESP.PetEnabled then PetESPConn:Disconnect() PetESPConn = nil; return end
        refreshPetESP()
    end)
end
function stopPetESP()
    if PetESPConn then PetESPConn:Disconnect() PetESPConn = nil end
    for inst, data in pairs(ESP.Bills) do
        if data.isPet then removeESPBill(inst) end
    end
end

do

local _RS2 = game:GetService("ReplicatedStorage")
local StockValues = _RS2:WaitForChild("StockValues", 10)

if not StockValues then return end

local SeedData, GearData
pcall(function() SeedData = require(_RS2.SharedModules.SeedData) end)
pcall(function() GearData = require(_RS2.SharedModules.GearShopData) end)

local seedRarity = {}
local seedPrice  = {}
if SeedData then
    for _, e in ipairs(SeedData) do
        if e.SeedName then
            seedRarity[e.SeedName] = e.Rarity or "Common"
            seedPrice[e.SeedName]  = e.Price or e.Cost or e.PurchasePrice or nil
        end
    end
end

local gearRarity = {}
local gearPrice  = {}
if GearData then
    for _, e in ipairs(GearData.Data or GearData) do
        if e.ItemName then
            gearRarity[e.ItemName] = e.Rarity or "Common"
            gearPrice[e.ItemName]  = e.Price or e.Cost or nil
        end
    end
end

local RARITY_ORDER = {
    Divine = 0, Mythic = 1, Legendary = 2, Super = 3,
    Epic = 4, Rare = 5, Uncommon = 6, Common = 7,
}

local RARITY_COLOR_HEX = {
    Divine    = "ffff64",
    Mythic    = "ff3c78",
    Legendary = "ffb41e",
    Super     = "1edcff",
    Epic      = "a050ff",
    Rare      = "508cff",
    Uncommon  = "50c850",
    Common    = "b4b4b4",
}

local function formatTime(s)
    s = math.max(0, math.floor(s))
    local h = math.floor(s / 3600)
    local m = math.floor((s % 3600) / 60)
    local sec = s % 60
    if h > 0 then return ("%dh %dm %ds"):format(h, m, sec)
    elseif m > 0 then return ("%dm %ds"):format(m, sec)
    else return ("%ds"):format(sec) end
end

local function abbreviate(n)
    n = math.floor(tonumber(n) or 0)
    if n >= 1e9 then return ("$%.1fB"):format(n / 1e9)
    elseif n >= 1e6 then return ("$%.1fM"):format(n / 1e6)
    elseif n >= 1e3 then return ("$%.1fK"):format(n / 1e3)
    else return ("$%d"):format(n) end
end

local function colorText(text, hex)
    return ('<font color="#' .. hex .. '">' .. text .. '</font>')
end

local function getRestockLabel(folder)
    if not folder then return "Next Restock: —" end
    local nrv = folder:FindFirstChild("UnixNextRestock")
    if not nrv then return "Next Restock: —" end
    local secs = math.max(0, nrv.Value - os.time())
    if secs <= 0 then
        return colorText("Restocking Now!", "00ff88")
    end
    return colorText("Next Restock: ", "aaaaaa") .. colorText(formatTime(secs), "ffd700")
end

local function buildStockDesc(itemsFolder, rarityLookup, priceLookup)
    if not itemsFolder then return colorText("No data available.", "888888") end
    local inStock = {}
    for _, item in ipairs(itemsFolder:GetChildren()) do
        if item:IsA("NumberValue") and item.Value > 0 then
            local rarity = (rarityLookup and rarityLookup[item.Name]) or "Common"
            local price  = priceLookup and priceLookup[item.Name]
            table.insert(inStock, { name = item.Name, count = item.Value, rarity = rarity, price = price })
        end
    end
    if #inStock == 0 then
        return colorText("Nothing in stock right now.", "ff6464")
    end
    table.sort(inStock, function(a, b)
        local wa = RARITY_ORDER[a.rarity] or 8
        local wb = RARITY_ORDER[b.rarity] or 8
        if wa ~= wb then return wa < wb end
        return a.name < b.name
    end)
    local lines = {}
    for _, e in ipairs(inStock) do
        local hex      = RARITY_COLOR_HEX[e.rarity] or "b4b4b4"
        local nameStr  = colorText(e.name, hex)
        local priceStr = e.price
            and ("  " .. colorText("[" .. abbreviate(e.price) .. "]", "ffd700"))
            or ""
        local countStr = colorText("  x" .. e.count, "aaaaaa")
        table.insert(lines, nameStr .. priceStr .. countStr)
    end
    return table.concat(lines, "\n")
end

local function getPetLeaveTime(obj)
    local rootPart = obj:FindFirstChild("RootPart")
    if not rootPart then return nil end
    local leaveTimer = rootPart:FindFirstChild("PetLeaveTimer")
    if not leaveTimer then return nil end
    local lbl = leaveTimer:FindFirstChildOfClass("TextLabel")
        or leaveTimer:FindFirstChild("TextLabel", true)
    if lbl then
        local t = lbl.Text or ""
        t = t:gsub("[^%d:ms ]", ""):match("^%s*(.-)%s*$")
        return t ~= "" and t or nil
    end
    return nil
end

local function formatPrice(num)
    num = tonumber(num)
    if not num then return nil end
    if num >= 1000000 then
        return string.format("%.1fm", num / 1000000):gsub("%.0m", "m")
    elseif num >= 1000 then
        return string.format("%.1fk", num / 1000):gsub("%.0k", "k")
    else
        return tostring(num)
    end
end

local function getPetCost(obj)
    local rootPart = obj:FindFirstChild("RootPart")
    if not rootPart then return nil end
    local costTimer = rootPart:FindFirstChild("PetCostTimer")
    if not costTimer then return nil end
    local lbl = costTimer:FindFirstChildOfClass("TextLabel")
        or costTimer:FindFirstChild("TextLabel", true)
    if lbl then
        local t = lbl.Text or ""
        t = t:gsub(",", ""):match("%d+")
        return t and ("¢" .. formatPrice(t)) or nil
    end
    return nil
end

local function buildSpawnedPetsDesc()
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local raw = obj:GetAttribute("PetName")
                     or obj.Name:match("WildPet_(.+)_WildPet")
                     or obj.Name:match("WildPet_(.+)")
            if raw then
                local petName = raw:match("WildPet_(.+)_WildPet") or raw:match("WildPet_(.+)") or raw
                local rarity  = obj:GetAttribute("Rarity") or "Common"
                local size    = obj:GetAttribute("Size") or ""
                local leave   = getPetLeaveTime(obj) or "?"
                local cost    = getPetCost(obj) or "?"
                table.insert(found, {
                    name   = petName,
                    rarity = rarity,
                    size   = size,
                    leave  = leave,
                    cost   = cost,
                })
            end
        end
    end

    if #found == 0 then
        return colorText("No pets spawned nearby.", "888888")
    end

    table.sort(found, function(a, b)
        local wa = RARITY_ORDER[a.rarity] or 8
        local wb = RARITY_ORDER[b.rarity] or 8
        if wa ~= wb then return wa < wb end
        return a.name < b.name
    end)

    local lines = {}
    for _, e in ipairs(found) do
        local hex      = RARITY_COLOR_HEX[e.rarity] or "b4b4b4"
        local nameStr  = colorText(e.name, hex)
        local sizeStr  = e.size ~= "" and colorText("  [" .. e.size .. "]", "aaaaaa") or ""
        local costStr  = colorText("  [" .. e.cost .. "]", "ffd700")
        local leaveStr = colorText("  Despawn in: " .. e.leave, "ff9944")
        table.insert(lines, nameStr .. sizeStr .. costStr .. leaveStr)
    end
    return table.concat(lines, "\n")
end

local SidePanel = Window:SidePanel({ Title = "Garden Info", Width = 280 })

SidePanel:AddDivider("My Plot")
local plotStat   = SidePanel:AddStatRow("Plot",   "—")
local plantsStat = SidePanel:AddStatRow("Plants", "—")
local fruitsStat = SidePanel:AddStatRow("Fruits", "—")
local gardenValueStat = SidePanel:AddStatRow("Garden Value", "—")   -- ADD THIS
local invValueStat    = SidePanel:AddStatRow("Inv Value",    "—")   -- ADD THIS

SidePanel:AddDivider("Spawned Pets")
local petCard = SidePanel:AddCard({ Name = "Available Pets", Description = "Scanning..." })

SidePanel:AddDivider("Seeds In Stock")
local seedCard = SidePanel:AddCard({ Name = "Next Restock: —", Description = "Loading..." })

SidePanel:AddDivider("Gear In Stock")
local gearCard = SidePanel:AddCard({ Name = "Next Restock: —", Description = "Loading..." })

SidePanel:AddDivider("Crates In Stock")
local crateCard = SidePanel:AddCard({ Name = "Next Restock: —", Description = "Loading..." })

SidePanel:AddDivider("Quick Actions")

SidePanel:AddButton("Collect All", function()
    local n = collectFruits(true)
    Library:Notification(("Collected %d fruits."):format(n), 3, nil)
end)

SidePanel:AddButton("Sell Now", function()
    task.spawn(DoAutoSell)
    Library:Notification("Sell fired.", 2, nil)
end)

SidePanel:AddButton("Teleport to Plot", function()
    local plot = getOwnedPlot()
    if not plot then Library:Notification("Plot not found.", 3, nil) return end
    local pp = (plot:FindFirstChild("Visual") and plot.Visual:FindFirstChild("PRIM"))
            or plot:FindFirstChild("GardenZone")
            or plot.PrimaryPart
    if pp then
        TpTo(pp.Position + Vector3.new(0, 3, 0))
        Library:Notification("Teleported to plot.", 2, nil)
    end
end)

local function updatePlot()
    pcall(function()
        local plot = getOwnedPlot()
        if not plot then
            plotStat:SetValue("Not found")
            plantsStat:SetValue("—")
            fruitsStat:SetValue("—")
            return
        end
        plotStat:SetValue(plot.Name)
        local plantsFolder = plot:FindFirstChild("Plants")
        if not plantsFolder then
            plantsStat:SetValue("0")
            fruitsStat:SetValue("0")
            return
        end
        local totalP, readyP, totalF = 0, 0, 0
        for _, plant in ipairs(plantsFolder:GetChildren()) do
            totalP += 1
            if plant:GetAttribute("PlantGrowthReady") then readyP += 1 end
            local ff = plant:FindFirstChild("Fruits")
            if ff then totalF += #ff:GetChildren() end
        end
        plantsStat:SetValue(("%d total, %d ready"):format(totalP, readyP))
        fruitsStat:SetValue(("%d on plants"):format(totalF))
    end)
end

local function updateStocks()
    pcall(function()
        local ss = StockValues:FindFirstChild("SeedShop")
        local gs = StockValues:FindFirstChild("GearShop")
        local cs = StockValues:FindFirstChild("CrateShop")

        seedCard:SetName(getRestockLabel(ss))
        seedCard:SetDescription(buildStockDesc(ss and ss:FindFirstChild("Items"), seedRarity, seedPrice))

        gearCard:SetName(getRestockLabel(gs))
        gearCard:SetDescription(buildStockDesc(gs and gs:FindFirstChild("Items"), gearRarity, gearPrice))

        crateCard:SetName(getRestockLabel(cs))
        crateCard:SetDescription(buildStockDesc(cs and cs:FindFirstChild("Items"), nil, nil))
    end)
end

local function updatePets()
    pcall(function()
        petCard:SetName("Available Pets :")
        petCard:SetDescription(buildSpawnedPetsDesc())
    end)
end

local function hookStockChanges()
    local function hookFolder(folder)
        if not folder then return end
        local items = folder:FindFirstChild("Items")
        if items then
            items.ChildAdded:Connect(function() task.wait() updateStocks() end)
            for _, item in ipairs(items:GetChildren()) do
                if item:IsA("NumberValue") then
                    item:GetPropertyChangedSignal("Value"):Connect(updateStocks)
                end
            end
        end
        local nrv = folder:FindFirstChild("UnixNextRestock")
        if nrv then nrv:GetPropertyChangedSignal("Value"):Connect(updateStocks) end
    end
    hookFolder(StockValues:FindFirstChild("SeedShop"))
    hookFolder(StockValues:FindFirstChild("GearShop"))
    hookFolder(StockValues:FindFirstChild("CrateShop"))
end

hookStockChanges()

local fastTimer = 0
local slowTimer = 0
local petTimer  = 0

local PanelConn = RunService.Heartbeat:Connect(function(dt)
    fastTimer += dt
    slowTimer += dt
    petTimer  += dt

    if fastTimer >= 1 then
        fastTimer = 0
        pcall(updateStocks)
    end
    if slowTimer >= 2 then
        slowTimer = 0
        pcall(updatePlot)
    end
    if petTimer >= 2 then
        petTimer = 0
        pcall(updatePets)
    end
end)

local _origDestroy = Window.Destroy
function Window:Destroy(...)
    if PanelConn then PanelConn:Disconnect() PanelConn = nil end
    return _origDestroy(self, ...)
end

task.spawn(function()
    task.wait(0.5)
    updateStocks()
    updatePlot()
    updatePets()
end)

end

-- ═══════════════════════════════════════════════════════════════════════════
-- UI
-- ═══════════════════════════════════════════════════════════════════════════

Window:Category("Farming")

-- ── Garden Page ───────────────────────────────────────────────────────────
local GardenPage  = Window:Page({Name="Garden", Icon="119555300033233"})
local PlantSub    = GardenPage:SubPage({Name="Planting"})
local HarvestSub  = GardenPage:SubPage({Name="Harvesting"})
local SellSub     = GardenPage:SubPage({Name="Sell"})
local SeedPackSub = GardenPage:SubPage({Name="Seed Packs"})

-- Planting
local PlantSection = PlantSub:Section({Name="Automation Plants", Icon="136879043989014"})
PlantSection:Dropdown({Name="Select Seeds", Flag="auto_selected_seeds",
    Items=ALL_SEEDS, Multi=true, Callback=function(s) State.SelectedSeeds=toList(s) end})
PlantSection:Dropdown({Name="Plant Position", Flag="auto_plant_position",
    Items={"Under Player Character","Random Position","Saved Position"}, Default="Random Position", Multi=false,
    Callback=function(v) State.PlantPosition=v end})
PlantSection:Button({Name="Save Plant Position", Callback=function()
    local root = getRoot()
    if root then
        State.SavedPlantPos = clampToPlantArea(root.Position - Vector3.new(0,3,0))
        Library:Notification("Plant position saved.", 2, nil)
    end
end})
PlantSection:Textbox({Flag="auto_plant_delay", Name="Delay to Plants",
    Placeholder="", Default="0", Finished=true, Numeric=true,
    Callback=function(v) State.PlantDelay=tonumber(v) or 0 end})
PlantSection:Toggle({Name="Auto Plant Seed", Flag="auto_plant_seed",
    Callback=function(v) setAutoPlant(v) end})
PlantSection:Toggle({Name="Auto Plant All Seeds", Flag="auto_plant_all_seeds",
    Callback=function(v) setAutoPlantAll(v) end})
PlantSection:Button({Name="Plant Selected Once", Callback=function()
    local seeds = getSeedsToPlant()
    if #seeds == 0 then Library:Notification("No seeds selected!", 3, nil); return end
    local planted = 0
    for _, seed in ipairs(seeds) do
        if plantSeedFast(seed) then planted += 1 end
        task.wait(math.max(0.05, State.PlantDelay))
    end
    Library:Notification(("Planted %d/%d seeds."):format(planted, #seeds), 3, nil)
end})

-- Harvesting
local CollectSection = HarvestSub:Section({Name="Automation Collect", Icon="136879043989014"})


CollectSection:Dropdown({Name="Select Fruit", Flag="collect_fruit",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(s) State.CollectFruit=toList(s) if #State.CollectFruit==0 then State.CollectFruit={"All"} end end})
CollectSection:Dropdown({Name="Select Rarity", Flag="collect_rarity",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(s) State.CollectRarity=toList(s) if #State.CollectRarity==0 then State.CollectRarity={"All"} end end})
CollectSection:Dropdown({Name="Select Mutation", Flag="collect_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(s) State.CollectMutation=toList(s) if #State.CollectMutation==0 then State.CollectMutation={"All"} end end})
CollectSection:Toggle({Name="Stop Collect When Full", Flag="collect_stop_when_full",
    Callback=function(v) State.CollectStopWhenFull=v end})
CollectSection:Toggle({Name="Auto Collect Fruit", Flag="auto_collect_fruit",
    Callback=function(v)
        State.AutoCollectFruit = v
        if v then startCollectLoop() elseif not State.AutoCollectAllFruit then stopCollectLoop() end
    end})
	CollectSection:Toggle({Name="Auto Collect Best Fruit Only", Flag="harvest_prio",
    Callback=function(v) State.HarvestPrioritize = v end})
CollectSection:Toggle({Name="Auto Collect All Fruit", Flag="auto_collect_all_fruit",
    Callback=function(v)
        State.AutoCollectAllFruit = v
        if v then startCollectLoop() else State.AutoCollectFruit=false; stopCollectLoop() end
    end})
CollectSection:Button({Name="Collect All Now", Callback=function()
    local count = collectFruits(true)
    Library:Notification(("Triggered %d harvest prompt(s)."):format(count), 3, nil)
end})

-- Sell
local SellSection = SellSub:Section({Name="Auto Sell", Icon="136879043989014"})
SellSection:Dropdown({Name="Sell Fruit Filter", Flag="sell_fruit_filter",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(s) State.SellFruit=toList(s) if #State.SellFruit==0 then State.SellFruit={"All"} end end})
SellSection:Dropdown({Name="Sell Rarity Filter", Flag="sell_rarity_filter",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(s) State.SellRarity=toList(s) if #State.SellRarity==0 then State.SellRarity={"All"} end end})
SellSection:Dropdown({Name="Sell Mutation Filter", Flag="sell_mutation_filter",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(s) State.SellMutation=toList(s) if #State.SellMutation==0 then State.SellMutation={"All"} end end})
SellSection:Toggle({Name="Auto Sell", Flag="sell_auto",
    Callback=function(v) State.AutoSell=v; if v then startSellLoop() else stopSellLoop() end end})
SellSection:Toggle({Name="Sell Only When Full", Flag="sell_only_when_full",
    Callback=function(v) State.SellOnlyWhenFull=v end})
SellSection:Textbox({Flag="sell_delay", Name="Sell Delay", Placeholder="", Default="2",
    Finished=true, Numeric=true, Callback=function(v) State.SellDelay=tonumber(v) or 2 end})
SellSection:Button({Name="Sell Now", Callback=function() task.spawn(DoAutoSell) end})

local BargainSection = SellSub:Section({Name="Auto Bargain", Icon="136879043989014"})
BargainSection:Slider({Flag="bargain_max_attempts", Name="Max Bid Attempts", Min=1, Max=10, Default=3,
    Callback=function(v) State.BargainMaxAttempts=v end})
BargainSection:Slider({Flag="bargain_target_mult", Name="Target Multiplier % (120=1.2x)", Min=100, Max=300, Default=120,
    Callback=function(v) State.BargainTargetMult=v/100 end})
BargainSection:Slider({Flag="bargain_max_fee_pct", Name="Max Fee % (10=10%)", Min=1, Max=50, Default=10,
    Callback=function(v) State.BargainMaxFeePct=v/100 end})
BargainSection:Toggle({Name="Allow Bargain While Selling", Flag="allow_bargain_while_selling",
    Callback=function(v) State.AllowBargainWhileSelling=v end})
BargainSection:Button({Name="Bargain Once Now", Callback=function() task.spawn(DoAutoBargain) end})

-- Seed Pack
local SeedPackSection = SeedPackSub:Section({Name="Auto Seed Pack", Icon="136879043989014"})
SeedPackSection:Toggle({Name="Auto Collect Event Seeds", Flag="auto_event_seeds",
    Callback=function(v)
        State.AutoCollectEventSeeds=v
        if v then startEventSeedLoop() else stopEventSeedLoop() end
    end})

-- ── Watering Page ─────────────────────────────────────────────────────────
local WaterPage    = Window:Page({Name="Watering", Icon="119555300033233"})
local WaterSub     = WaterPage:SubPage({Name="Watering Can"})
local SprinklerSub = WaterPage:SubPage({Name="Sprinklers"})

local WaterSection = WaterSub:Section({Name="Auto Watering", Icon="136879043989014"})
WaterSection:Dropdown({Name="Select Watering Can", Flag="water_selected_can",
    Items=ALL_WATERING_CANS, Default="Common Watering Can", Multi=false,
    Callback=function(v) State.SelectedWateringCan=v or "Common Watering Can" end})
WaterSection:Dropdown({Name="Select Position", Flag="water_position",
    Items={"Random Position","Saved Position","Under Player Character"}, Default="Random Position", Multi=false,
    Callback=function(v) State.WaterPosition=v or "Random Position" end})
WaterSection:Button({Name="Save Position", Callback=function()
    local root = getRoot()
    if root then
        State.SavedWaterPos = clampToPlantArea(root.Position - Vector3.new(0,3,0))
        Library:Notification("Water position saved.", 2, nil)
    end
end})
WaterSection:Textbox({Flag="water_delay", Name="Delay To Water", Placeholder="", Default="0",
    Finished=true, Numeric=true, Callback=function(v) State.WaterDelay=tonumber(v) or 0 end})
WaterSection:Toggle({Name="Auto Water", Flag="water_auto",
    Callback=function(v)
        State.AutoWater=v; State.AutoWaterAll=false
        if v then startWaterLoop() else stopWaterLoop() end
    end})
WaterSection:Toggle({Name="Auto Water All Cans", Flag="water_auto_all",
    Callback=function(v)
        State.AutoWaterAll=v; State.AutoWater=false
        if v then startWaterLoop() else stopWaterLoop() end
    end})

local SprinklerSection = SprinklerSub:Section({Name="Auto Sprinkler", Icon="136879043989014"})
SprinklerSection:Dropdown({Name="Select Sprinkler", Flag="sprinkler_selected",
    Items=ALL_SPRINKLERS, Default="Common Sprinkler", Multi=false,
    Callback=function(v) State.SelectedSprinkler=v or "Common Sprinkler" end})
SprinklerSection:Dropdown({Name="Select Position", Flag="sprinkler_position",
    Items={"Random Position","Saved Position","Under Player Character"}, Default="Random Position", Multi=false,
    Callback=function(v) State.SprinklerPosition=v or "Random Position" end})
SprinklerSection:Button({Name="Save Position", Callback=function()
    local root = getRoot()
    if root then
        State.SavedSprinklerPos = clampToPlantArea(root.Position - Vector3.new(0,3,0))
        Library:Notification("Sprinkler position saved.", 2, nil)
    end
end})
SprinklerSection:Textbox({Flag="sprinkler_delay", Name="Delay To Sprinkler", Placeholder="", Default="0",
    Finished=true, Numeric=true, Callback=function(v) State.SprinklerDelay=tonumber(v) or 0 end})
SprinklerSection:Toggle({Name="Auto Place Sprinkler", Flag="sprinkler_auto_place",
    Callback=function(v)
        State.AutoPlaceSprinkler=v; State.AutoPlaceAllSprinklers=false
        if v then startSprinklerLoop() else stopSprinklerLoop() end
    end})
SprinklerSection:Toggle({Name="Auto Place All Sprinklers", Flag="sprinkler_auto_place_all",
    Callback=function(v)
        State.AutoPlaceAllSprinklers=v; State.AutoPlaceSprinkler=false
        if v then startSprinklerLoop() else stopSprinklerLoop() end
    end})

-- ── Shovel/Favorites Page ─────────────────────────────────────────────────
local ShovelPage     = Window:Page({Name="Shovels/Favorites", Icon="119555300033233"})
local ShovelTreeSub  = ShovelPage:SubPage({Name="Shovel Trees"})
local ShovelFruitSub = ShovelPage:SubPage({Name="Shovel Fruits"})
local FavoritesSub   = ShovelPage:SubPage({Name="Favorites"})

local ShovelTreeSection = ShovelTreeSub:Section({Name="Auto Shovel Tree", Icon="136879043989014"})
ShovelTreeSection:Dropdown({Name="Select Plants To Shovel", Flag="shovel_selected_seeds",
    Items=ALL_SEEDS, Multi=true, Callback=function(s) State.SelectedShovelSeeds=toList(s) end})
ShovelTreeSection:Dropdown({Name="Rarity Filter", Flag="shovel_tree_rarity",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(s) State.ShovelTreeRarity=toList(s) if #State.ShovelTreeRarity==0 then State.ShovelTreeRarity={"All"} end end})
ShovelTreeSection:Dropdown({Name="Mutation Filter", Flag="shovel_tree_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(s) State.ShovelTreeMutation=toList(s) if #State.ShovelTreeMutation==0 then State.ShovelTreeMutation={"All"} end end})
ShovelTreeSection:Toggle({Name="Auto Shovel Tree", Flag="shovel_auto_tree",
    Callback=function(v)
        State.AutoShovelTree=v; State.AutoShovelFruit=false
        if v then startShovelLoop(false) else stopShovelLoop() end
    end})

local ShovelFruitSection = ShovelFruitSub:Section({Name="Auto Shovel Fruit", Icon="136879043989014"})
ShovelFruitSection:Dropdown({Name="Select Fruits To Shovel", Flag="shovel_selected_fruits",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(s) State.ShovelFruits=toList(s) if #State.ShovelFruits==0 then State.ShovelFruits={"All"} end end})
ShovelFruitSection:Dropdown({Name="Rarity Filter", Flag="shovel_fruit_rarity",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(s) State.ShovelFruitRarity=toList(s) if #State.ShovelFruitRarity==0 then State.ShovelFruitRarity={"All"} end end})
ShovelFruitSection:Dropdown({Name="Mutation Filter", Flag="shovel_fruit_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(s) State.ShovelFruitMutation=toList(s) if #State.ShovelFruitMutation==0 then State.ShovelFruitMutation={"All"} end end})
ShovelFruitSection:Toggle({Name="Auto Shovel Fruit", Flag="shovel_auto_fruit",
    Callback=function(v)
        State.AutoShovelFruit=v; State.AutoShovelTree=false
        if v then startShovelLoop(true) else stopShovelLoop() end
    end})

local FavSection = FavoritesSub:Section({Name="Auto Favorite Fruit", Icon="136879043989014"})
FavSection:Dropdown({Name="Select Fruit to Favorite", Flag="fav_fruit",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(s) State.FavoriteFruit=toList(s) if #State.FavoriteFruit==0 then State.FavoriteFruit={"All"} end end})
FavSection:Dropdown({Name="Select Rarity to Favorite", Flag="fav_rarity",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(s) State.FavoriteRarity=toList(s) if #State.FavoriteRarity==0 then State.FavoriteRarity={"All"} end end})
FavSection:Dropdown({Name="Select Mutation to Favorite", Flag="fav_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(s) State.FavoriteMutation=toList(s) if #State.FavoriteMutation==0 then State.FavoriteMutation={"All"} end end})
FavSection:Button({Name="Favorite Matching Fruits Now", Callback=function()
    task.spawn(function() doFavoriteFruits(true) end)
end})
FavSection:Toggle({Name="Auto Favorite Fruit", Flag="auto_fav_fruit",
    Callback=function(v)
        State.AutoFavoriteFruit=v; State.AutoUnfavoriteFruit=false; State.AutoUnfavoriteAll=false
        stopFavoriteLoop(); if v then startFavoriteLoop("favorite") end
    end})
FavSection:Button({Name="Unfavorite Matching Fruits Now", Callback=function()
    task.spawn(function() doFavoriteFruits(false) end)
end})
FavSection:Toggle({Name="Auto Unfavorite Fruit", Flag="auto_unfav_fruit",
    Callback=function(v)
        State.AutoUnfavoriteFruit=v; State.AutoFavoriteFruit=false; State.AutoUnfavoriteAll=false
        stopFavoriteLoop(); if v then startFavoriteLoop("unfavorite") end
    end})
FavSection:Button({Name="Unfavorite ALL Fruits Now", Callback=function()
    task.spawn(function() doFavoriteFruits(nil) end)
end})
FavSection:Toggle({Name="Auto Unfavorite All", Flag="auto_unfav_all",
    Callback=function(v)
        State.AutoUnfavoriteAll=v; State.AutoFavoriteFruit=false; State.AutoUnfavoriteFruit=false
        stopFavoriteLoop(); if v then startFavoriteLoop("unfavoriteAll") end
    end})

-- ── Steal & Tools Page ────────────────────────────────────────────────────
local StealPage = Window:Page({Name="Steal & Tools", Icon="136879043989014"})
local StealSub  = StealPage:SubPage({Name="Night Steal"})
local ToolsSub  = StealPage:SubPage({Name="Garden Tools"})

local StealSection = StealSub:Section({Name="Auto Steal (Night Only)", Icon="136879043989014"})
StealSection:Dropdown({Name="Fruit Filter", Flag="steal_fruit",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(v) State.StealFruit=toList(v) if #State.StealFruit==0 then State.StealFruit={"All"} end end})
StealSection:Dropdown({Name="Rarity Filter", Flag="steal_rarity",
    Items={"All","Common","Uncommon","Rare","Epic","Legendary","Mythic","Super"}, Default="All", Multi=true,
    Callback=function(v) State.StealRarity=toList(v) if #State.StealRarity==0 then State.StealRarity={"All"} end end})
StealSection:Dropdown({Name="Mutation Filter", Flag="steal_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(v) State.StealMutation=toList(v) if #State.StealMutation==0 then State.StealMutation={"All"} end end})
StealSection:Textbox({Flag="steal_limit", Name="Steal Limit", Placeholder="50", Default="50",
    Finished=true, Numeric=true, Callback=function(v) State.StealLimit=tonumber(v) or 50 end})
StealSection:Textbox({Flag="steal_min_value", Name="Min Fruit Value (0=any)", Placeholder="0", Default="0",
    Finished=true, Numeric=true, Callback=function(v) State.StealMinValue=tonumber(v) or 0 end})
StealSection:Toggle({Name="Prioritize Highest Value", Flag="steal_prioritize",
    Callback=function(v) State.StealPrioritize=v end})
StealSection:Toggle({Name="Auto Steal", Flag="steal_auto",
    Callback=function(v) State.AutoSteal=v; if v then startStealLoop() else stopStealLoop() end end})
StealSection:Toggle({Name="Anti Steal (Hit player if they steal)", Flag="anti_steal",
    Callback=function(v)
        State.AntiSteal=v
        if v then startAntiStealLoop() else stopAntiStealLoop() end
    end})

local ToolsSection = ToolsSub:Section({Name="Garden Tools", Icon="136879043989014"})
ToolsSection:Button({Name="Delete Others Garden", Callback=function()
    Library:Notification("Deleting plants from other gardens...", 2, nil)
    task.spawn(deleteOthersGarden)
end})

Window:Category("Shop")

-- ── Shop Page ─────────────────────────────────────────────────────────────
local ShopPage     = Window:Page({Name="Shop", Icon="129090689199756"})
local SeedShopSub  = ShopPage:SubPage({Name="Seeds"})
local GearShopSub  = ShopPage:SubPage({Name="Gear"})
local CrateShopSub = ShopPage:SubPage({Name="Crates"})
local EggShopSub   = ShopPage:SubPage({Name="Eggs"})

local SeedShopSection = SeedShopSub:Section({Name="Shop Seeds", Icon="136879043989014"})
SeedShopSection:Dropdown({Name="Select Seeds To Buy", Flag="shop_selected_seeds",
    Items=ALL_SEEDS, Multi=true, Callback=function(s) State.SelectedShopSeeds=toList(s) end})
SeedShopSection:Toggle({Name="Auto Buy Seeds", Flag="shop_auto_buy_seeds",
    Callback=function(v)
        State.AutoBuySeeds=v
        if v then startBuySeedLoop() elseif not State.AutoBuyAllSeeds then stopBuySeedLoop() end
    end})
SeedShopSection:Toggle({Name="Auto Buy All Seeds", Flag="shop_auto_buy_all_seeds",
    Callback=function(v)
        State.AutoBuyAllSeeds=v
        if v then State.AutoBuySeeds=true; startBuySeedLoop()
        else State.AutoBuySeeds=false; stopBuySeedLoop() end
    end})

local GearShopSection = GearShopSub:Section({Name="Shop Gear", Icon="136879043989014"})
GearShopSection:Dropdown({Name="Select Gear To Buy", Flag="shop_selected_gear",
    Items=ALL_GEAR, Multi=true, Callback=function(s) State.SelectedGear=toList(s) end})
GearShopSection:Toggle({Name="Auto Buy Gear", Flag="shop_auto_buy_gear",
    Callback=function(v)
        State.AutoBuyGear=v
        if v then startBuyGearLoop() elseif not State.AutoBuyAllGear then stopBuyGearLoop() end
    end})
GearShopSection:Toggle({Name="Auto Buy All Gear", Flag="shop_auto_buy_all_gear",
    Callback=function(v)
        State.AutoBuyAllGear=v
        if v then State.AutoBuyGear=true; startBuyGearLoop()
        else State.AutoBuyGear=false; stopBuyGearLoop() end
    end})

local CrateShopSection = CrateShopSub:Section({Name="Shop Crates", Icon="136879043989014"})
CrateShopSection:Dropdown({Name="Select Crates To Buy", Flag="shop_selected_crates",
    Items=ALL_CRATES, Multi=true, Callback=function(s) State.SelectedCrate=toList(s) end})
CrateShopSection:Toggle({Name="Auto Buy Crate", Flag="shop_auto_buy_crate",
    Callback=function(v)
        State.AutoBuyCrate=v
        if v then startBuyCrateLoop() elseif not State.AutoBuyAllCrates then stopBuyCrateLoop() end
    end})
CrateShopSection:Toggle({Name="Auto Buy All Crates", Flag="shop_auto_buy_all_crates",
    Callback=function(v)
        State.AutoBuyAllCrates=v
        if v then State.AutoBuyCrate=true; startBuyCrateLoop()
        else State.AutoBuyCrate=false; stopBuyCrateLoop() end
    end})

-- Egg Opener
local EggSection = EggShopSub:Section({Name="Egg Opener", Icon="136879043989014"})
EggSection:Label("Uses Networking.Egg.OpenEgg:Fire(eggName)")
EggSection:Textbox({Flag="egg_open_delay", Name="Delay Between Opens (s)", Placeholder="0.3", Default="0.3",
    Finished=true, Numeric=true, Callback=function(v) State.EggOpenDelay=math.max(0.1, tonumber(v) or 0.3) end})
EggSection:Button({Name="Open All Eggs Now", Callback=function()
    local count = openAllEggs()
    Library:Notification(("Opened %d egg(s)."):format(count), 3, nil)
end})
EggSection:Toggle({Name="Auto Open Eggs (on pickup)", Flag="egg_auto_open",
    Callback=function(v)
        State.AutoOpenEggs=v
        if v then startEggLoop() else stopEggLoop() end
    end})

-- ── Pets Page ─────────────────────────────────────────────────────────────
local PetPage = Window:Page({Name="Pets", Icon="129090689199756"})
local PetSub  = PetPage:SubPage({Name="Pet Buyer"})

local PetSection = PetSub:Section({Name="Pet Buyer", Icon="136879043989014"})
PetSection:Dropdown({Name="Select Specific Pets To Buy", Flag="pet_selected",
    Items=TARGET_PETS, Multi=true, Callback=function(s) State.SelectedPets=toList(s) end})
PetSection:Textbox({Flag="pet_buy_delay", Name="Buy Delay (seconds)", Placeholder="1", Default="1",
    Finished=true, Numeric=true, Callback=function(v) State.PetBuyDelay=tonumber(v) or 1 end})
PetSection:Toggle({Name="Auto Buy Selected Pets", Flag="pet_auto_buy",
    Callback=function(v)
        State.AutoBuyPet=v
        State.AutoBuyBestPet=false
        if v then startPetLoop() else stopPetLoop() end
    end})
PetSection:Toggle({Name="Auto Buy Best Wild Pet (Highest Rarity)", Flag="pet_auto_buy_best",
    Callback=function(v)
        State.AutoBuyBestPet=v
        State.AutoBuyPet=false
        if v then startBestPetLoop() else stopBestPetLoop() end
    end})

Window:Category("Misc")

-- ── Visuals Page ──────────────────────────────────────────────────────────
local VisualsPage = Window:Page({Name="Visuals", Icon="104396788397678"})
local FruitESPSub = VisualsPage:SubPage({Name="Fruit ESP"})
local PetESPSub   = VisualsPage:SubPage({Name="Pet ESP"})
local RenderSub   = VisualsPage:SubPage({Name="Camera & Render"})

local FruitESPSection = FruitESPSub:Section({Name="ESP Fruit", Icon="136879043989014"})
FruitESPSection:Dropdown({Name="Select ESP Fruit", Flag="esp_fruit_filter",
    Items=FRUIT_OPTIONS, Default="All", Multi=true,
    Callback=function(v) ESP.FruitFilter=toList(v) if #ESP.FruitFilter==0 then ESP.FruitFilter={"All"} end
    if ESP.FruitEnabled then stopFruitESP(); startFruitESP() end end})
FruitESPSection:Dropdown({Name="Select ESP Rarity", Flag="esp_fruit_rarity",
    Items=RARITIES, Default="All", Multi=true,
    Callback=function(v) ESP.FruitRarity=toList(v) if #ESP.FruitRarity==0 then ESP.FruitRarity={"All"} end
    if ESP.FruitEnabled then stopFruitESP(); startFruitESP() end end})
FruitESPSection:Dropdown({Name="Select ESP Mutation", Flag="esp_fruit_mutation",
    Items=MUTATIONS, Default="All", Multi=true,
    Callback=function(v) ESP.FruitMutation=toList(v) if #ESP.FruitMutation==0 then ESP.FruitMutation={"All"} end
    if ESP.FruitEnabled then stopFruitESP(); startFruitESP() end end})
FruitESPSection:Toggle({Name="ESP Fruit", Flag="esp_fruit_enabled",
    Callback=function(v) ESP.FruitEnabled=v; if v then startFruitESP() else stopFruitESP() end end})
	FruitESPSection:Toggle({ Name = "ESP Best Fruit Only", Flag = "esp_best_fruit_enabled",
    Callback = function(v)
        ESP.BestFruitEnabled = v
        if v then startBestFruitESP() else stopBestFruitESP() end
    end })

local PetESPSection = PetESPSub:Section({Name="ESP Spawned Pets", Icon="136879043989014"})
PetESPSection:Dropdown({Name="Select Pets", Flag="esp_pet_filter",
    Items=PET_NAMES, Default="All", Multi=true,
    Callback=function(v) ESP.PetFilter=toList(v) if #ESP.PetFilter==0 then ESP.PetFilter={"All"} end
    if ESP.PetEnabled then stopPetESP(); startPetESP() end end})
PetESPSection:Dropdown({Name="Select Rarity", Flag="esp_pet_rarity",
    Items=PET_RARITIES, Default="All", Multi=true,
    Callback=function(v) ESP.PetRarity=toList(v) if #ESP.PetRarity==0 then ESP.PetRarity={"All"} end
    if ESP.PetEnabled then stopPetESP(); startPetESP() end end})
PetESPSection:Dropdown({Name="Select Size", Flag="esp_pet_size",
    Items=PET_SIZES, Default="All", Multi=true,
    Callback=function(v) ESP.PetSize=toList(v) if #ESP.PetSize==0 then ESP.PetSize={"All"} end
    if ESP.PetEnabled then stopPetESP(); startPetESP() end end})
PetESPSection:Toggle({Name="ESP Spawned Pets", Flag="esp_pet_enabled",
    Callback=function(v) ESP.PetEnabled=v; if v then startPetESP() else stopPetESP() end end})

local RenderSection = RenderSub:Section({Name="Camera & Rendering", Icon="136879043989014"})
RenderSection:Slider({Flag="cam_min_zoom", Name="Min Zoom", Min=0, Max=100, Default=0,
    Callback=function(v) State.MinZoom=v; if State.CameraZoomEnabled then setCameraZoom(true) end end})
RenderSection:Slider({Flag="cam_max_zoom", Name="Max Zoom", Min=0, Max=400, Default=100,
    Callback=function(v) State.MaxZoom=v; if State.CameraZoomEnabled then setCameraZoom(true) end end})
RenderSection:Toggle({Name="Camera Zoom", Flag="cam_zoom_enabled", Callback=function(v) setCameraZoom(v) end})
RenderSection:Slider({Flag="cam_fov_value", Name="FOV", Min=1, Max=120, Default=70,
    Callback=function(v) setFOV(State.FOVEnabled, v) end})
RenderSection:Toggle({Name="FOV", Flag="cam_fov_enabled", Callback=function(v) setFOV(v) end})
RenderSection:Slider({Flag="fps_limit_value", Name="FPS Limit", Min=1, Max=360, Default=60,
    Callback=function(v) setFPSLimit(State.LimitFPS, v) end})
RenderSection:Toggle({Name="Limit FPS", Flag="fps_limit_enabled", Callback=function(v) setFPSLimit(v) end})
RenderSection:Toggle({Name="Uncap FPS", Flag="fps_uncap", Callback=function(v) setUncapFPS(v) end})
RenderSection:Toggle({Name="Disable 3D Rendering", Flag="render_disable_3d", Callback=function(v) setDisable3D(v) end})
RenderSection:Toggle({Name="Full Bright", Flag="misc_full_bright", Callback=function(v) setFullBright(v) end})

-- ── Player Page ────────────────────────────────────────────────────────────
local PlayerPage   = Window:Page({Name="Player", Icon="97650943483989"})
local MovementSub  = PlayerPage:SubPage({Name="Movement"})
local SafetySub    = PlayerPage:SubPage({Name="Safety"})

local MovementSection = MovementSub:Section({Name="Local Player", Icon="136879043989014"})
MovementSection:Slider({Flag="lp_walk_speed_value", Name="Walk Speed", Min=1, Max=500, Default=16,
    Callback=function(v) State.WalkSpeed=v; setWalkSpeed() end})
MovementSection:Toggle({Name="Enable Walkspeed", Flag="lp_walk_speed_enabled",
    Callback=function(v) State.WalkSpeedEnabled=v; setWalkSpeed() end})
MovementSection:Slider({Flag="lp_jump_power_value", Name="Jump Power", Min=0, Max=1000, Default=50,
    Callback=function(v) setJumpPower(State.JumpPowerEnabled, v) end})
MovementSection:Toggle({Name="Enable Jump Power", Flag="lp_jump_power_enabled",
    Callback=function(v) setJumpPower(v) end})
MovementSection:Slider({Flag="lp_hip_height_value", Name="Hip Height", Min=0, Max=100, Default=0,
    Callback=function(v) setHipHeight(State.HipHeightEnabled, v) end})
MovementSection:Toggle({Name="Enable Hip Height", Flag="lp_hip_height_enabled",
    Callback=function(v) setHipHeight(v) end})
MovementSection:Slider({Flag="lp_gravity_value", Name="Gravity", Min=0, Max=1000, Default=196,
    Callback=function(v) setGravity(State.GravityEnabled, v) end})
MovementSection:Toggle({Name="Enable Gravity", Flag="lp_gravity_enabled",
    Callback=function(v) setGravity(v) end})
MovementSection:Slider({Flag="lp_fly_speed_value", Name="Fly Speed", Min=1, Max=500, Default=50,
    Callback=function(v) State.FlySpeed=v end})
MovementSection:Toggle({Name="Fly", Flag="lp_fly", Callback=function(v) setFly(v) end})
MovementSection:Toggle({Name="No Clip", Flag="lp_no_clip", Callback=function(v) setNoClip(v) end})
MovementSection:Toggle({Name="Infinite Jump", Flag="lp_infinite_jump", Callback=function(v) setInfiniteJump(v) end})
MovementSection:Toggle({Name="Instant Prompt", Flag="lp_instant_prompt", Callback=function(v) setInstantPrompt(v) end})

local SafetySection = SafetySub:Section({Name="Miscellaneous", Icon="136879043989014"})
SafetySection:Toggle({Name="Anti AFK", Flag="misc_anti_afk", Callback=function(v) setAntiAFK(v) end})
SafetySection:Toggle({Name="No Gameplay Pause", Flag="misc_no_gameplay_pause",
    Callback=function(v) setNoGameplayPause(v) end})
SafetySection:Toggle({Name="Anti Fling", Flag="misc_anti_fling",
    Callback=function(v) setAntiFling(v) end})

-- ── Server Page ────────────────────────────────────────────────────────────
local ServerPage    = Window:Page({Name="Server", Icon="104396788397678"})
local ServerSub     = ServerPage:SubPage({Name="Connection"})
local ServerSection = ServerSub:Section({Name="Server Tools", Icon="136879043989014"})

ServerSection:Button({Name="Rejoin Server", Callback=function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end})
ServerSection:Button({Name="Server Hop", Callback=function()
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local ok, servers = pcall(function()
        return HttpService:JSONDecode(
            game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if ok and servers and servers.data then
        for _, server in ipairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                return
            end
        end
    end
    Library:Notification("No available servers found.", 3, nil)
end})
ServerSection:Toggle({Name="Auto Reconnect", Flag="server_auto_reconnect",
    Callback=function(v) setAutoReconnect(v) end})
ServerSection:Button({Name="Copy Server Invite", Callback=function()
    local link = "roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId
    setclipboard(link)
    Library:Notification("Server invite copied!", 3, nil)
end})

Window:Category("Settings")
local SettingsPage = Library:CreateSettingsPage(Window)
Library:Notification("Arincy Hub Reborn — Grow a Garden 2  |  v2.0.0", 5, nil)
print("[Arincy Hub] Loaded v2.0.0")