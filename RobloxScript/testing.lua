--[[
    Arincy Hub
    Simple toggles for Admin Treadmill bypass + Auto Win
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remotes / modules
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local PromptAdminTreadmill = Remotes:WaitForChild("PromptAdminTreadmill")
local UpdateSpeed = Remotes:WaitForChild("UpdateSpeed")
local TreadmillSignal = Remotes:WaitForChild("TreadmillSignal")
local ClientState = require(ReplicatedStorage:WaitForChild("ClientState"))
local treadmillFilter = require(ReplicatedStorage:WaitForChild("Treadmill"):WaitForChild("Raycast")).getTreadmillFilter()

-- Win block — Stage3.WinBlock2.WinGui under player (not Socle)
local WinBlock = workspace:WaitForChild("Structure"):WaitForChild("Stage3"):WaitForChild("WinBlock2")
local WinGui = WinBlock:WaitForChild("WinGui")
local winOriginalPivot = WinBlock:GetPivot()

-- Use whatever part WinGui is attached to as the pivot (usually not Socle directly)
local winPivotPart = WinGui:IsA("BillboardGui") and WinGui.Adornee
    or WinGui:IsA("SurfaceGui") and WinGui.Adornee
    or WinGui:FindFirstChildWhichIsA("BasePart", true)
    or WinBlock:FindFirstChildWhichIsA("BasePart", true)

if winPivotPart and WinBlock:IsA("Model") then
    WinBlock.PrimaryPart = winPivotPart
end

-- State
local adminEnabled = false
local autoWinEnabled = false
local adminLoopRunning = false
local autoWinConn = nil
local adminOnTreadmill = false
local clientStateHooked = false
local remoteHooked = false
local oldClientGet = ClientState.Get

-- ── Admin treadmill logic ────────────────────────────────────────────────

local function applyClientStateHook()
    if clientStateHooked then
        return
    end
    clientStateHooked = true

    function ClientState:Get(...)
        local state = oldClientGet(self, ...)
        if type(state) == "table" then
            state.AdminTreadmillActive = true
            state.GoldTreadmillActive = true
            state.DiamondTreadmillActive = true
            state.CandyTreadmillActive = true
        end
        return state
    end
end

local function blockPromptRemote()
    if remoteHooked then
        return true
    end

    local function shouldBlock(self, method)
        return method == "FireServer" and self == PromptAdminTreadmill
    end

    if hookmetamethod then
        local old
        old = hookmetamethod(game, "__namecall", function(self, ...)
            if shouldBlock(self, getnamecallmethod()) then
                return nil
            end
            return old(self, ...)
        end)
        remoteHooked = true
        return true
    end

    if getrawmetatable and setreadonly and newcclosure and getnamecallmethod then
        local ok = pcall(function()
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local oldNamecall = mt.__namecall
            mt.__namecall = newcclosure(function(self, ...)
                if shouldBlock(self, getnamecallmethod()) then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
            setreadonly(mt, true)
        end)
        if ok then
            remoteHooked = true
        end
        return ok
    end

    return false
end

local function isOnAdminTreadmill()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then
        return false
    end

    local hit = workspace:Raycast(root.Position, Vector3.new(0, -7, 0), treadmillFilter)
    if not hit or not hit.Instance then
        return false
    end

    return CollectionService:HasTag(hit.Instance, "AdminTreadmill")
end

local function startAdminLoop()
    if adminLoopRunning then
        return
    end
    adminLoopRunning = true

    task.spawn(function()
        while adminEnabled do
            task.wait(0.1)
            local onAdmin = isOnAdminTreadmill()

            if onAdmin and not adminOnTreadmill then
                TreadmillSignal:FireServer(true)
                adminOnTreadmill = true
            elseif not onAdmin and adminOnTreadmill then
                TreadmillSignal:FireServer(false)
                adminOnTreadmill = false
            end

            if onAdmin then
                UpdateSpeed:FireServer("AdminTreadmill")
            end
        end
        adminLoopRunning = false
    end)
end

local function setAdminTreadmill(enabled)
    adminEnabled = enabled
    if enabled then
        applyClientStateHook()
        blockPromptRemote()
        startAdminLoop()
    else
        if adminOnTreadmill then
            TreadmillSignal:FireServer(false)
            adminOnTreadmill = false
        end
    end
end

-- ── Auto win logic (simple — matches how other hubs do it) ───────────────

local WIN_Y_OFFSET = -3

local function moveWinBlockUnderPlayer()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root or not WinBlock.Parent then
        return
    end

    -- Network ownership on the WinGui pivot part only (not Socle)
    if winPivotPart then
        pcall(function()
            if setnetworkowner then
                setnetworkowner(winPivotPart, LocalPlayer)
            end
        end)
    end

    -- Move entire WinBlock2 so WinGui sits under the player
    WinBlock:PivotTo(root.CFrame * CFrame.new(0, WIN_Y_OFFSET, 0))
end

local function setAutoWin(enabled)
    autoWinEnabled = enabled

    if autoWinConn then
        autoWinConn:Disconnect()
        autoWinConn = nil
    end

    if enabled then
        autoWinConn = RunService.Heartbeat:Connect(moveWinBlockUnderPlayer)
    else
        pcall(function()
            WinBlock:PivotTo(winOriginalPivot)
        end)
    end
end

-- ── Simple UI ────────────────────────────────────────────────────────────

local function createToggle(parent, name, order, callback)
    local row = Instance.new("TextButton")
    row.Name = name
    row.BackgroundColor3 = Color3.fromRGB(34, 36, 40)
    row.BackgroundTransparency = 0.15
    row.BorderSizePixel = 0
    row.Size = UDim2.new(1, 0, 0, 36)
    row.LayoutOrder = order
    row.Text = ""
    row.AutoButtonColor = false
    row.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = row

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = name
    label.TextColor3 = Color3.fromRGB(235, 235, 235)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local track = Instance.new("Frame")
    track.BackgroundColor3 = Color3.fromRGB(50, 52, 56)
    track.Position = UDim2.new(1, -46, 0.5, -10)
    track.Size = UDim2.new(0, 38, 0, 20)
    track.Parent = row

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    local knob = Instance.new("Frame")
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.Position = UDim2.new(0, 3, 0.5, -7)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local enabled = false

    local function updateVisual()
        track.BackgroundColor3 = enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 52, 56)
        knob.Position = enabled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    end

    row.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateVisual()
        callback(enabled)
    end)

    updateVisual()
    return row
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArincyHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.BackgroundColor3 = Color3.fromRGB(28, 30, 34)
main.BackgroundTransparency = 0.05
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Size = UDim2.new(0, 260, 0, 170)
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(55, 58, 64)
stroke.Thickness = 1
stroke.Parent = main

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.BackgroundTransparency = 1
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Parent = main

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 14, 0, 10)
title.Size = UDim2.new(1, -50, 0, 24)
title.Font = Enum.Font.GothamBold
title.Text = "Arincy Hub"
title.TextColor3 = Color3.fromRGB(127, 255, 212)
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "Close"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.Position = UDim2.new(1, -34, 0, 10)
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 12
closeBtn.AutoButtonColor = false
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    setAutoWin(false)
    setAdminTreadmill(false)
    screenGui:Destroy()
end)

local list = Instance.new("Frame")
list.BackgroundTransparency = 1
list.Position = UDim2.new(0, 12, 0, 44)
list.Size = UDim2.new(1, -24, 1, -56)
list.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

createToggle(list, "Admin Treadmill", 1, function(on)
    setAdminTreadmill(on)
end)

createToggle(list, "Auto Win", 2, function(on)
    setAutoWin(on)
end)

print("[Arincy Hub] Loaded — toggles ready")
