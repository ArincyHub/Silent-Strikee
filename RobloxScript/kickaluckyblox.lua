-- // Services
local Players        = game:GetService("Players")
local TweenService   = game:GetService("TweenService")
local VirtualUser    = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- // Anti-AFK
pcall(function()
    if getconnections then
        for _, conn in pairs(getconnections(LocalPlayer.Idled)) do
            if conn.Disable then conn:Disable() end
        end
    end
end)
LocalPlayer.Idled:Connect(function()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- // Network
local Network = ReplicatedStorage:WaitForChild("Shared")
    :WaitForChild("Packages")
    :WaitForChild("Network")

-- // State
local state = {
    autoKick      = false,
    autoKickVer   = 0,
    autoTrain     = false,
    autoTrainVer  = 0,
    autoCollect   = false,
    instantGrab   = false,
    autoUpgrade   = false,
    autoEvent     = false,
    autoEventVer  = 0,
    autoSell      = false,
    sellRarity    = "All",
    speedEnabled  = false,
    speedValue    = 50,
    upgradeSlots  = {},
    upgradeSlotAll = true,
    kickPowerKey  = "Perfect",
    kickDistMult  = 1,
    kickRarity    = "Common",
    nearestPlot   = nil,
    targetPets    = {},
    targetMuts    = {},
    eventPets     = {},
    eventMuts     = {},
    sellPets      = {},
    sellMuts      = {},
    collected     = {},
    autoPlace     = false,
    autoPlaceAll  = false,
    autoBuySpeed           = false,
    autoRebirth            = false,
    autoVolcanoUpgrade     = false,
    webhookEnabled         = false,
    webhookURL             = "",
    autoVolcanoCollect     = false,
    autoVolcanoCollectVer  = 0,
    autoVolcanoKamikaze    = false,
    autoVolcanoKamikazeVer = 0,
}

-- // Data
local KickPower = {
    Cosmic    = 0.96,
    Perfect   = 1,
    Excellent = 0.867,
    Great     = 0.635,
    Mid       = 0.264,
    Bad       = 0.067,
}

local KickZonePower = {
    Common    = { 1, 0.0000000036448693 },
    Rare      = { 1, 0.00000010934608 },
    Epic      = { 1, 0.0000036448694 },
    Legendary = { 0, 0.264 },
    Mythic    = { 0.24994461610913, 0.01 },
    Godly     = { 1, 0.00061438871273 },
    Secret    = { 1, 0.001917249739421627 },
    Divine    = { 0.7800284549593925, 0.01 },
    Hacked    = { 0.7925464622676373, 0.02 },
    OG        = { 1, 0.06 },
    Celestial = { 1, 0.11024213100273421 },
    Eternal   = { 1, 0.5212494498439 },
}

local Rarities = {
    "Common","Rare","Epic","Legendary","Mythic","Godly",
    "Secret","Divine","Hacked","OG","Celestial","Eternal"
}

local Pets = {
    Common    = {"Noobini Pizzanini","Tim Cheese","LiriIi LariIa","Talpa Di Fero","Fruli Frula","Svinina Bombardino","Pipi Kiwi"},
    Rare      = {"Gangster Footera","Bobrito Bandito","Boneca Ambalabu","Ta Ta Ta Ta Sahur","Ballerina Cappuccina","Brr Brr Patapim","Cappuccino Assassino","Cacto Hipopotamo"},
    Epic      = {"Madung","Waterdino","Pesto Mortioni","Pannaburro","Mangolini Parrocini","Orcalero","John Pork","Gattatino Nyanino"},
    Legendary = {"Chimpanzini Bananini","Plan Red","Plan Blue","Capi Taco","Trulimero Trulicana","Bambini Crostini","Elefantucci Bananucci","Bananita Dolphinita","Salamino Pinguino"},
    Mythic    = {"Penguino Cocosino","67","Burbaloni Luliloli","Chef Crabracadabra","Capybara Eggplant","Bangello","Elefanto Frigo","Rinooccio Veidini","Glorbo Fruttodrillo"},
    Godly     = {"Udin Din Din Dun","Pandaccini Bananini","Octopusini Bluberini","Strawberelli Flamingelli","Sigma Boy","Frigo Camelo","Orangutini Ananasini","Rhino Toasterino","Bombardiro Crocodilo"},
    Secret    = {"Bombini Gusini","Tuff Toucan","Fryuro","Burguro","Guest 666","Zibra Zubra Zibralini","Cavallo Virtuso","Gorillo Watermelondrillo","Cocofanto Elefanto"},
    Divine    = {"Girafa Celeste","Tralalero Tralala","Tralalerita Tralala","Peant jarro","Dipperi Chiperini","Rexosaurus","1X1X1X1","Matteo"},
    Hacked    = {"Alessio","Tripi Tropi Tropa Tripa","Torrtuginni Dragonfruitini","Tictac Sahur","Cactus Pingu","Los Primos Blue","La Vacca Saturno Saturnita","Agaitihi La Palini"},
    OG        = {"Karkerkar Kurkur","Compactororni Diskaloni","Blackhole Goat","Cappuccino Clownino","Nuclearo Dinossauro","Los Nooo My Hotspotsitos","Chillin Chilli","Crazylone Pizaione","Corn Sahur","Meowl","Strawberry Elephant"},
    Celestial = {"Dragonfrutina Dolphinita","Guerriro Digitale","Chicleteira Bicicleteira","Pot Hotspot","Krupuk Pagi Pagi","Beluga Beluga","Tralaledon","Anpalı Babel","Ketupat Kepat","Mastodontico Telepiedone"},
    Eternal   = {"Professora 67","Astro Tim","Baba Yaga","Kicky"},
}

local Mutations = {
    "Normal","Golden","Diamond","Plasma","Molten","Radioactive",
    "Shadow","Electrified","Rainbow","Virus","Alien","Void",
    "Bacon","Enchanted","Phantom","Astral","Wet"
}

local MutationKeys = {
    "Golden","Diamond","Plasma","Molten","Radioactive",
    "Shadow","Electrified","Rainbow","Virus","Alien","Void",
    "Bacon","Enchanted","Phantom","Astral","Wet"
}

local MutationCache = {}
pcall(function()
    local Shared = ReplicatedStorage:WaitForChild("Shared", 5)
    if not Shared then return end
    for _, src in ipairs({
        Shared:FindFirstChild("Data") and Shared.Data:FindFirstChild("MutationData"),
        Shared:FindFirstChild("Data") and Shared.Data:FindFirstChild("MutationSwitch"),
        ReplicatedStorage:FindFirstChild("Objects") and ReplicatedStorage.Objects:FindFirstChild("VFX") and ReplicatedStorage.Objects.VFX:FindFirstChild("MutationVFX"),
    }) do
        if src then
            for _, v in pairs(src:GetChildren()) do
                MutationCache[string.lower(v.Name)] = v.Name
            end
        end
    end
end)
for _, m in ipairs(MutationKeys) do MutationCache[string.lower(m)] = m end
local MutationAliases = {
    eye="Alien", handle="Bacon", water="Wet", splash="Wet", droplet="Wet",
    aura="Void", blackhole="Void", void="Void", glitch="Virus", virus="Virus",
    spark="Electrified", electric="Electrified", fire="Molten", lava="Molten",
    phantom="Phantom", shadow="Shadow", rainbow="Rainbow", gold="Golden", diamond="Diamond",
}
for alias, mut in pairs(MutationAliases) do MutationCache[alias] = mut end

local TrainingTools = {
    ["Wooden Stick"]=true,["Copper Plate"]=true,["Stone Block"]=true,
    ["Bone Barbell"]=true,["Donut Barbell"]=true,["Ice Barbell"]=true,
    ["Iron Plate"]=true,["Heaven Plate"]=true,["Golden Barbell"]=true,
    ["Giant Gold Star Barbell"]=true,["Neon Pulse"]=true,
    ["Mega Golden Barbell"]=true,["Bone Barbel"]=true,["Emerald Barbell"]=true,
}

-- // Helpers
local function teleportTo(cf)
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.zero
        hrp.CFrame   = cf
    end
end

local function moveSmooth(hrp, humanoid, targetPos)
    if not (hrp and humanoid and humanoid.Health > 0) then return end
    local goal    = Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z)
    local speed   = state.speedEnabled and state.speedValue or math.max(humanoid.WalkSpeed, 100)
    local dist    = (hrp.Position - goal).Magnitude
    local prevSpd = humanoid.WalkSpeed
    humanoid.WalkSpeed = speed
    local deadline = tick() + (dist / speed) + 5
    while tick() < deadline and humanoid.Health > 0 do
        if (hrp.Position - goal).Magnitude <= 5 then break end
        humanoid:MoveTo(goal)
        task.wait(0.05)
    end
    if humanoid and humanoid.Parent then humanoid.WalkSpeed = prevSpd end
end

local runTo      = moveSmooth
local tweenMove  = moveSmooth

local function smoothFlyTo(hrp, hum, targetPos)
    if not (hrp and hum and hum.Health > 0) then return end
    local targetCFrame = CFrame.new(targetPos.X, FIXED_Y, targetPos.Z)
    local dist = (hrp.Position - targetCFrame.Position).Magnitude
    local flySpeed = (state.speedEnabled and state.speedValue)
                  or (hum and hum.WalkSpeed > 16 and hum.WalkSpeed)
                  or 50
    local timeToFly = dist / flySpeed
    
    hrp.Anchored = true
    local tweenInfo = TweenInfo.new(timeToFly, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    
    tween:Play()
    tween.Completed:Wait() 
    
    if hrp and hrp.Parent then hrp.Anchored = false end
end
local function getPlayerPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in pairs(plots:GetChildren()) do
        local owner = plot:GetAttribute("Owner") or plot:GetAttribute("PlayerName")
        if owner == LocalPlayer.Name or owner == tostring(LocalPlayer.UserId) then
            return plot
        end
    end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local best, nearest = math.huge, nil
        for _, plot in pairs(plots:GetChildren()) do
            pcall(function()
                local dist = (hrp.Position - plot:GetPivot().Position).Magnitude
                if dist < best then best = dist nearest = plot end
            end)
        end
        return nearest
    end
    return plots:FindFirstChild("Plot1")
end

local function isSlotFree(slot)
    local pp = slot:FindFirstChild("PlacedPart")
    if pp and pp:FindFirstChildOfClass("Model") then return false end
    if slot:GetAttribute("ID") ~= nil then return false end
    for _, child in pairs(slot:GetChildren()) do
        if child:IsA("Model") then return false end
    end
    return true
end

local function getPlacedBrainrotName(slot)
    local pp = slot:FindFirstChild("PlacedPart")
    if not pp then return nil end
    local model = pp:FindFirstChildOfClass("Model")
    return model and model.Name
end

local RarityRank = {}
for i, r in ipairs(Rarities) do RarityRank[r] = i end

local function getRarityRank(petName)
    return RarityRank[getPetRarity(petName)] or 0
end

local function tryRemoveFromSlot(slot)
    local char = LocalPlayer.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local pos = getSlotPosition(slot)
    if not pos then return false end
    teleportTo(CFrame.new(pos + Vector3.new(0, 3, 0)))
    task.wait(0.2)
    local fired = false
    pcall(function()
        for _, v in pairs(slot:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                local txt = string.lower(v.ActionText or "")
                if string.find(txt, "remove") or string.find(txt, "sell") or string.find(txt, "delete") then
                    if fireproximityprompt then fireproximityprompt(v)
                    else
                        local vim = game:GetService("VirtualInputManager")
                        vim:SendProximityPromptEvent(v, Enum.ProximityPromptInputType.Keyboard, true)
                        task.wait(v.HoldDuration + 0.05)
                        vim:SendProximityPromptEvent(v, Enum.ProximityPromptInputType.Keyboard, false)
                    end
                    fired = true return
                end
            end
        end
    end)
    if not fired then
        local slotNum = tonumber(slot.Name:match("%d+"))
        if slotNum then Network.rev_S_Interact:FireServer(slotNum) end
    end
    task.wait(0.6)
    return isSlotFree(slot)
end

local function getSlotPosition(slot)
    if slot:IsA("BasePart") then return slot.Position end
    if slot.PrimaryPart then return slot.PrimaryPart.Position end
    local bp = slot:FindFirstChildWhichIsA("BasePart")
    if bp then return bp.Position end
    local pp = slot:FindFirstChild("PlacedPart")
    return pp and pp.Position
end

local function tryPlaceInSlot(slot, tool)
    local char = LocalPlayer.Character
    local hum  = char and char:FindFirstChild("Humanoid")
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not (hum and hrp and hum.Health > 0) then return false end
    if not isSlotFree(slot) then return false end
    local pos = getSlotPosition(slot)
    if not pos then return false end
    teleportTo(CFrame.new(pos + Vector3.new(0, 3, 0)))
    task.wait(0.25)
    if tool.Parent ~= char then
        hum:EquipTool(tool)
        task.wait(0.3)
    end
    local slotNum = tonumber(slot.Name:match("%d+"))
    if not slotNum then return false end
    Network.rev_S_Interact:FireServer(slotNum)
    task.wait(0.8)
    return not isSlotFree(slot)
end

local function getMutations(model)
    local found = {}
    if not model then return found end
    local nameLow = string.lower(model.Name)
    for _, m in ipairs(MutationKeys) do
        if string.find(nameLow, string.lower(m)) then found[m] = true end
    end
    for attr, val in pairs(model:GetAttributes()) do
        local aLow = string.lower(attr)
        if type(val) == "boolean" and val and MutationCache[aLow] then found[MutationCache[aLow]] = true end
        if type(val) == "string" and MutationCache[string.lower(val)] then found[MutationCache[string.lower(val)]] = true end
    end
    for _, desc in ipairs(model:GetDescendants()) do
        local dLow = string.lower(desc.Name)
        if MutationCache[dLow] then found[MutationCache[dLow]] = true end
        if desc:IsA("StringValue") and MutationCache[string.lower(tostring(desc.Value))] then
            found[MutationCache[string.lower(tostring(desc.Value))]] = true
        end
        if desc:IsA("TextLabel") then
            local txt = string.lower(desc.Text)
            for _, m in ipairs(MutationKeys) do
                if string.find(txt, string.lower(m)) then found[m] = true end
            end
        end
        for attr, val in pairs(desc:GetAttributes()) do
            local aLow = string.lower(attr)
            if type(val) == "boolean" and val and MutationCache[aLow] then found[MutationCache[aLow]] = true end
            if type(val) == "string" and MutationCache[string.lower(val)] then found[MutationCache[string.lower(val)]] = true end
        end
    end
    return found
end

local function sendWebhook(title, desc, color)
    if not (state.webhookEnabled and state.webhookURL ~= "") then return end
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if not req then return end
    task.spawn(function()
        pcall(function()
            req({
                Url    = state.webhookURL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body   = game:GetService("HttpService"):JSONEncode({
                    embeds = {{ title = title, description = desc, type = "rich", color = color or 0x04CB29,
                                footer = { text = "Kick Hub | " .. os.date("%X") } }}
                })
            })
        end)
    end)
end

local function fireButton(btn)
    if not (btn and btn.Parent) then return end
    pcall(function()
        if getconnections then
            for _, c in pairs(getconnections(btn.MouseButton1Down))  do c:Fire() end
            for _, c in pairs(getconnections(btn.MouseButton1Click)) do c:Fire() end
            for _, c in pairs(getconnections(btn.Activated))         do c:Fire() end
        end
    end)
    pcall(function()
        if firesignal then
            firesignal(btn.MouseButton1Down)
            firesignal(btn.MouseButton1Click)
            firesignal(btn.Activated)
        end
        if btn:IsA("GuiButton") then btn:Activate() end
    end)
    pcall(function()
        if btn:IsA("GuiObject") and btn.AbsoluteSize.X > 0 and btn.Visible then
            local vim    = game:GetService("VirtualInputManager")
            local inset  = game:GetService("GuiService"):GetGuiInset()
            local cx = btn.AbsolutePosition.X + btn.AbsoluteSize.X / 2 + inset.X
            local cy = btn.AbsolutePosition.Y + btn.AbsoluteSize.Y / 2 + inset.Y
            vim:SendMouseButtonEvent(cx, cy, 0, true,  game, 1)
            task.wait(0.01)
            vim:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
        end
    end)
end

local function getPetRarity(petName)
    for rarity, list in pairs(Pets) do
        for _, name in ipairs(list) do
            if string.find(string.lower(petName), string.lower(name)) then
                return rarity
            end
        end
    end
    return "Unknown"
end

local function getBestBrainrot()
    local bp   = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    local bestTool, bestScore = nil, -1
    local function checkTool(tool)
        if not (tool:IsA("Tool") and not TrainingTools[tool.Name]) then return end
        local rarity = getPetRarity(tool.Name)
        for i, r in ipairs(Rarities) do
            if r == rarity and i > bestScore then
                bestScore = i
                bestTool  = tool
                break
            end
        end
    end
    if bp   then for _, t in pairs(bp:GetChildren())  do checkTool(t) end end
    if char then for _, t in pairs(char:GetChildren()) do checkTool(t) end end
    return bestTool
end


local function shouldSkip(model, targetPets, targetMuts)
    local muts = getMutations(model)
    local mutFiltered, mutMatch = false, false
    for mut, on in pairs(targetMuts) do
        if on then
            mutFiltered = true
            if mut == "Normal" then
                local hasMut = false
                for _ in pairs(muts) do hasMut = true break end
                if not hasMut then mutMatch = true break end
            elseif muts[mut] then
                mutMatch = true break
            end
        end
    end
    local petFiltered, petMatch = false, false
    for pet, on in pairs(targetPets) do
        if on then
            petFiltered = true
            if string.find(string.lower(model.Name), string.lower(pet)) then
                petMatch = true break
            end
        end
    end
    if mutFiltered and not mutMatch then return true end
    if petFiltered and not petMatch then return true end
    return false
end

-- // UI
local Library  = loadstring(game:HttpGet("https://pastefy.app/supjgRGw/raw"))()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local window   = Library.new("Zen Hub - <font color='rgb(127,255,212)'>Lucky Blox</font>", "LuckyBloxConfig")

window:CreateStatusBar({
    Title    = "<font color='rgb(127,255,212)'>Zen Hub</font> — <font color='rgb(200,180,255)'>" .. gameName .. "</font>",
    Logo     = "rbxassetid://116422175458617",
    Callback = function() window:Toggle() end
})

window:Notify({ Title = "Lucky Blox Loaded", Description = "All systems ready.", Duration = 3 })

-- ===================== MAIN TAB =====================
local mainSection = window:CreateSection("Main")
local mainTab     = mainSection:CreateTab("Farm", "rbxassetid://112235310154264")

mainTab:CreateSection("Auto Kick — Warp & Run")

mainTab:CreateDropdown({
    Name    = "Kick Power",
    Options = {"Cosmic","Perfect","Excellent","Great","Mid","Bad"},
    Default = "Perfect",
    Flag    = "KickPower",
    Callback = function(v) state.kickPowerKey = v end
})

mainTab:CreateDropdown({
    Name      = "Filter Rarity",
    Options   = Rarities,
    Default   = "Common",
    Flag      = "MainRarity",
    Callback  = function(v) state.kickRarity = v end
})

mainTab:CreateDropdown({
    Name        = "Target Pets",
    Options     = Pets[state.kickRarity] or Pets["Common"],
    Default     = {},
    MultiSelect = true,
    Flag        = "MainTargetPets",
    Callback    = function(v)
        state.targetPets = {}
        for _, name in ipairs(v) do state.targetPets[name] = true end
    end
})

mainTab:CreateDropdown({
    Name        = "Target Mutation",
    Options     = Mutations,
    Default     = {},
    MultiSelect = true,
    Flag        = "MainTargetMuts",
    Callback    = function(v)
        state.targetMuts = {}
        for _, m in ipairs(v) do state.targetMuts[m] = true end
    end
})

mainTab:CreateToggle({
    Name     = "Auto Kick (Warp & Run Back)",
    Default  = false,
    Flag     = "AutoKick",
    Callback = function(enabled)
        state.autoKick = enabled
        state.autoKickVer += 1
        local ver = state.autoKickVer
        if not enabled then return end
        task.spawn(function()
            while state.autoKick and ver == state.autoKickVer do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    local hum  = char and char:FindFirstChild("Humanoid")
                    if not (hrp and hum and hum.Health > 0) then return end

                    local kickZone = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                    if not kickZone then return end
                    local zoneCF = kickZone:IsA("BasePart") and kickZone.CFrame or kickZone:GetPivot()

                    if (hrp.Position - zoneCF.Position).Magnitude > 5 then
                        teleportTo(zoneCF + Vector3.new(0, 3, 0))
                    end
                    task.wait(0.5)

                    local startPos = hrp.Position
                    local moved    = false
                    local hud      = PlayerGui:FindFirstChild("HUD")

                    for _ = 1, 150 do
                        task.wait(0.1)
                        if not char or not char.Parent or hum.Health <= 0 then return end
                        if (hrp.Position - startPos).Magnitude > 40 then moved = true break end
                        local kickBtn = hud and hud:FindFirstChild("KickButton")
                        if kickBtn and kickBtn.Visible then
                            Network.rev_KickEvent:FireServer(KickPower[state.kickPowerKey] or 1)
                            task.wait(0.5)
                        end
                    end

                    if not moved then return end
                    task.wait(0.5)

                    local found, foundModel = false, nil
                    for _ = 1, 40 do
                        task.wait(0.2)
                        local best = 60
                        for _, m in pairs(workspace.Debris:GetChildren()) do
                            if m:IsA("Model") and m.PrimaryPart then
                                local dist = (m.PrimaryPart.Position - hrp.Position).Magnitude
                                if dist < best then best = dist found = true foundModel = m end
                            end
                        end
                        if found then break end
                    end

                    if not (found and foundModel) then return end

                    local landDeadline = tick() + 8
                    repeat task.wait(0.1)
                    until not foundModel.Parent
                        or foundModel.PrimaryPart.AssemblyLinearVelocity.Magnitude < 5
                        or tick() > landDeadline
                    if not foundModel.Parent then return end

                    local petName = foundModel.Name
                    local muts    = getMutations(foundModel)
                    local mutList = next(muts) and table.concat((function() local t={} for k in pairs(muts) do t[#t+1]=k end return t end)(), ", ") or "Normal"
                    local rarity  = getPetRarity(petName)
                    if shouldSkip(foundModel, state.targetPets, state.targetMuts) then
                        local waves = workspace:FindFirstChild("Waves")
                        local wavePos = waves and (waves:IsA("BasePart") and waves.Position
                            or waves.PrimaryPart and waves.PrimaryPart.Position
                            or (waves:FindFirstChildWhichIsA("BasePart", true) and waves:FindFirstChildWhichIsA("BasePart", true).Position))
                        local kz2 = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        smoothFlyTo(hrp, hum, wavePos or (kz2 and (kz2:IsA("BasePart") and kz2.CFrame or kz2:GetPivot()).Position) or hrp.Position)
                    else
                        teleportTo(CFrame.new(foundModel.PrimaryPart.Position + Vector3.new(0, 2, 0)))
                        task.wait(0.1)
                        pcall(function()
                            for _, part in pairs(foundModel:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    firetouchinterest(hrp, part, 0)
                                    task.wait()
                                    firetouchinterest(hrp, part, 1)
                                end
                            end
                        end)
                        task.wait(0.4)
                        local count = (state.collected[petName] or 0) + 1
                        state.collected[petName] = count
                        print("Collected: " .. petName .. " [" .. mutList .. "] Rarity: " .. rarity .. " | Total: " .. count)
                        sendWebhook("Pet Collected!", "**Pet:** "..petName.."\n**Rarity:** "..rarity.."\n**Mutation:** "..mutList.."\n**Total:** "..count, 0x04CB29)
                        local kz = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        if kz then
                            smoothFlyTo(hrp, hum, (kz:IsA("BasePart") and kz.CFrame or kz:GetPivot()).Position)
                            task.wait(1)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
})


mainTab:CreateSection("Training")

mainTab:CreateToggle({
    Name     = "Auto Train & x2 Bonus",
    Default  = false,
    Flag     = "AutoTrain",
    Callback = function(enabled)
        state.autoTrain = enabled
        state.autoTrainVer += 1
        local ver = state.autoTrainVer
        if not enabled then return end
        task.spawn(function()
            while state.autoTrain and ver == state.autoTrainVer do
                pcall(function()
                    local char    = LocalPlayer.Character
                    local hum     = char and char:FindFirstChild("Humanoid")
                    local bp      = LocalPlayer:FindFirstChild("Backpack")
                    local equip   = char and char:FindFirstChildOfClass("Tool")
                    if not (char and hum) then return end
                    if not equip then
                        local slot1 = PlayerGui:FindFirstChild("Backpack") and PlayerGui.Backpack:FindFirstChild("Bar") and PlayerGui.Backpack.Bar:FindFirstChild("Slot1")
                        if slot1 and getconnections then
                            for _, c in pairs(getconnections(slot1.MouseButton1Click)) do c:Fire() end
                        end
                        task.wait(0.1)
                        if bp and hum and not char:FindFirstChildOfClass("Tool") then
                            for _, tool in pairs(bp:GetChildren()) do
                                if tool:IsA("Tool") and TrainingTools[tool.Name] then
                                    hum:EquipTool(tool) break
                                end
                            end
                        end
                    else
                        equip:Activate()
                    end
                end)
                pcall(function()
                    local upgrades = PlayerGui:FindFirstChild("KickUpgrades")
                    if not upgrades then return end
                    for _, btn in pairs(upgrades:GetChildren()) do
                        if (btn.Name == "Bonus" or btn.Name == "PopBonus") and btn.Visible then
                            local targets = {btn}
                            for _, d in ipairs(btn:GetDescendants()) do
                                if d:IsA("GuiButton") or d:IsA("ImageLabel") then
                                    targets[#targets+1] = d
                                end
                            end
                            for _, t in ipairs(targets) do fireButton(t) end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
})

mainTab:CreateSection("Movement")

mainTab:CreateToggle({
    Name     = "Custom Speed",
    Default  = false,
    Flag     = "SpeedToggle",
    Callback = function(enabled)
        state.speedEnabled = enabled
        if not enabled then return end
        task.spawn(function()
            while state.speedEnabled do
                pcall(function()
                    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                    if hum then hum.WalkSpeed = state.speedValue end
                end)
                task.wait(0.1)
            end
        end)
    end
})

mainTab:CreateSlider({
    Name     = "Walk Speed",
    Min      = 1,
    Max      = 1000,
    Default  = 50,
    Flag     = "SpeedVal",
    Callback = function(v) state.speedValue = v end
})

mainTab:CreateButton({
    Name     = "TP to KickReady",
    Callback = function()
        pcall(function()
            teleportTo(workspace.Areas.KickReady.CFrame + Vector3.new(0, 5, 0))
        end)
    end
})

mainTab:CreateSection("Place")

mainTab:CreateButton({
    Name     = "Equip Best Brainrot",
    Callback = function()
        local tool = getBestBrainrot()
        local char = LocalPlayer.Character
        local hum  = char and char:FindFirstChild("Humanoid")
        if tool and hum then
            hum:EquipTool(tool)
            window:Notify({ Title = "Equipped", Description = tool.Name, Duration = 2 })
        end
    end
})

mainTab:CreateToggle({
    Name     = "Auto Place Best Brainrot",
    Default  = false,
    Flag     = "AutoPlace",
    Callback = function(enabled)
        state.autoPlace = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoPlace do
                pcall(function()
                    local plot  = getPlayerPlot()
                    local slots = plot and plot:FindFirstChild("Slots")
                    if not slots then return end
                    for _, slot in pairs(slots:GetChildren()) do
                        if not state.autoPlace then break end
                        local tool = getBestBrainrot()
                        if not tool then break end
                        if isSlotFree(slot) then
                            tryPlaceInSlot(slot, tool)
                        else
                            local currentID = getPlacedBrainrotName(slot)
                            if currentID and getRarityRank(tool.Name) > getRarityRank(currentID) then
                                local removed = tryRemoveFromSlot(slot)
                                if removed then tryPlaceInSlot(slot, tool) end
                            end
                        end
                        task.wait(0.5)
                    end
                end)
                task.wait(2)
            end
        end)
    end
})

mainTab:CreateToggle({
    Name     = "Auto Place All Brainrots",
    Default  = false,
    Flag     = "AutoPlaceAll",
    Callback = function(enabled)
        state.autoPlaceAll = enabled
        if not enabled then return end
        task.spawn(function()
            local placed = {}
            while state.autoPlaceAll do
                pcall(function()
                    local plot  = getPlayerPlot()
                    local slots = plot and plot:FindFirstChild("Slots")
                    local bp    = LocalPlayer:FindFirstChild("Backpack")
                    local char  = LocalPlayer.Character
                    local hum   = char and char:FindFirstChild("Humanoid")
                    if not (slots and bp and hum) then return end
                    for _, slot in pairs(slots:GetChildren()) do
                        if not state.autoPlaceAll then break end
                        if placed[slot] then continue end
                        if not isSlotFree(slot) then placed[slot] = true continue end
                        local tool = getBestBrainrot()
                        if not tool then break end
                        local ok = tryPlaceInSlot(slot, tool)
                        if ok then placed[slot] = true end
                    end
                end)
                task.wait(1)
            end
        end)
    end
})

-- ===================== COLLECT TAB =====================
local collectTab = mainSection:CreateTab("Collect", "rbxassetid://10734950309")

collectTab:CreateSection("Auto Collect")

collectTab:CreateToggle({
    Name     = "Auto Claim Money (Instant)",
    Default  = false,
    Flag     = "InstantGrab",
    Callback = function(enabled)
        state.instantGrab = enabled
        if not enabled then return end
        task.spawn(function()
            while state.instantGrab do
                pcall(function()
                    -- auto detect slots from player data or just brute force 1-20
                    local maxSlots = 100
                    for slot = 1, maxSlots do
                        Network.rev_B_Collect:FireServer(slot)
                        task.wait(0.05) -- small gap to avoid throttle
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
})

collectTab:CreateToggle({
    Name     = "Auto Collect Money (TP)",
    Default  = false,
    Flag     = "AutoCollect",
    Callback = function(enabled)
        state.autoCollect = enabled
        if not enabled then return end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and not state.nearestPlot then
            local best = math.huge
            for _, plot in pairs(workspace:WaitForChild("Plots"):GetChildren()) do
                if plot:IsA("Model") or plot:IsA("Folder") then
                    local dist = (hrp.Position - plot:GetPivot().Position).Magnitude
                    if dist < best then best = dist state.nearestPlot = plot end
                end
            end
        end
        task.spawn(function()
            while state.autoCollect do
                if state.nearestPlot then
                    pcall(function()
                        local buttons = state.nearestPlot:FindFirstChild("Buttons")
                        if not buttons then return end
                        for slot = 1, 30 do
                            if not state.autoCollect then break end
                            local slotPart = buttons:FindFirstChild("Slot" .. slot)
                            if not slotPart then continue end
                            local cf = slotPart:IsA("BasePart") and slotPart.CFrame
                                or (slotPart:IsA("Model") and slotPart.PrimaryPart and slotPart.PrimaryPart.CFrame)
                                or (slotPart:FindFirstChildWhichIsA("BasePart") and slotPart:FindFirstChildWhichIsA("BasePart").CFrame)
                            if cf then
                                teleportTo(cf + Vector3.new(0, 1.5, 0))
                                task.wait(0.1)
                                pcall(function() Network.rev_B_Collect:FireServer(slot) end)
                            end
                        end
                    end)
                end
                task.wait(1)
            end
        end)
    end
})


collectTab:CreateSection("Quick Actions")

collectTab:CreateToggle({
    Name     = "Auto Buy Speed x1",
    Default  = false,
    Flag     = "AutoBuySpeed",
    Callback = function(enabled)
        state.autoBuySpeed = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoBuySpeed do
                pcall(function() Network.rev_SPEED_UPGRADE:FireServer(1) end)
                task.wait(0.5)
            end
        end)
    end
})

collectTab:CreateToggle({
    Name     = "Auto Rebirth",
    Default  = false,
    Flag     = "AutoRebirth",
    Callback = function(enabled)
        state.autoRebirth = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoRebirth do
                pcall(function() Network.rev_RebirthRequest:FireServer() end)
                task.wait(1)
            end
        end)
    end
})

collectTab:CreateSection("Volcano Event")

local volcanoKamikazeStart = CFrame.new(669.768, -7.002, 244.569)

collectTab:CreateToggle({
    Name     = "Auto Collect Volcano",
    Default  = false,
    Flag     = "AutoVolcanoKamikaze",
    Callback = function(enabled)
        state.autoVolcanoKamikaze = enabled
        state.autoVolcanoKamikazeVer += 1
        local ver = state.autoVolcanoKamikazeVer
        if not enabled then return end
        task.spawn(function()
            while state.autoVolcanoKamikaze and ver == state.autoVolcanoKamikazeVer do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    local hum  = char and char:FindFirstChild("Humanoid")
                    if not (char and hrp and hum and hum.Health > 0) then task.wait(1) return end
                    local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                    if not kickPos then return end
                    local targetCF = kickPos:IsA("BasePart") and kickPos.CFrame or kickPos:GetPivot()
                    if (hrp.Position - targetCF.Position).Magnitude > 10 then
                        teleportTo(targetCF + Vector3.new(0, 3, 0))
                    end
                    task.wait(0.4)
                    local startPos      = hrp.Position
                    local wasTeleported = false
                    local HUD           = PlayerGui:FindFirstChild("HUD")
                    for _ = 1, 150 do
                        task.wait(0.08)
                        if not state.autoVolcanoKamikaze then return end
                        local kickBtn = HUD and HUD:FindFirstChild("KickButton")
                        if kickBtn and kickBtn.Visible then
                            Network.rev_KickEvent:FireServer(KickPower[state.kickPowerKey] or 1)
                        end
                        if (hrp.Position - startPos).Magnitude > 40 then wasTeleported = true break end
                    end
                    if not wasTeleported then return end
                    local waitSpawn = 0
                    while waitSpawn < 5 do
                        task.wait(0.5)
                        waitSpawn += 0.5
                        local coinCount = 0
                        for _, v in pairs(workspace.Debris:GetChildren()) do
                            if v:FindFirstChild("Hitbox") then coinCount += 1 end
                        end
                        if coinCount > 5 then break end
                    end
                    hrp.CFrame = volcanoKamikazeStart + Vector3.new(0, 3, 0)
                    task.wait(0.2)
                    local collectedPets = {}
                    while state.autoVolcanoKamikaze and hum.Health > 0 do
                        local nearestPet, nearestDist = nil, math.huge
                        for _, obj in pairs(workspace.Debris:GetChildren()) do
                            local hitbox = obj:FindFirstChild("Hitbox")
                            if hitbox and hitbox:IsA("BasePart") and not collectedPets[obj] then
                                local zoneName = string.match(obj.Name, "^[^_]+")
                                if zoneName ~= "Common" then
                                    local flatDist = (Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(hitbox.Position.X, 0, hitbox.Position.Z)).Magnitude
                                    if flatDist < nearestDist then nearestDist = flatDist nearestPet = obj end
                                end
                            end
                        end
                        if not nearestPet then task.wait(0.5) break end
                        local targetHitbox = nearestPet:FindFirstChild("Hitbox")
                        if targetHitbox then
                            local timeout = 0
                            while state.autoVolcanoKamikaze and nearestPet.Parent and hum.Health > 0 and not collectedPets[nearestPet] do
                                task.wait(0.05)
                                timeout += 0.05
                                pcall(function() hum.WalkSpeed = state.speedEnabled and state.speedValue or 50 end)
                                hum:MoveTo(targetHitbox.Position)
                                local flat2D = (Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(targetHitbox.Position.X, 0, targetHitbox.Position.Z)).Magnitude
                                if flat2D <= 6 then
                                    collectedPets[nearestPet] = true
                                    pcall(function()
                                        if firetouchinterest then
                                            firetouchinterest(hrp, targetHitbox, 0)
                                            task.wait(0.01)
                                            firetouchinterest(hrp, targetHitbox, 1)
                                        end
                                        Network.rev_CollectShard:FireServer(nearestPet.Name)
                                    end)
                                    break
                                end
                                if timeout >= 2.5 then collectedPets[nearestPet] = true break end
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
})

collectTab:CreateToggle({
    Name     = "Auto Collect Orb and Brainrot",
    Default  = false,
    Flag     = "AutoVolcanoCollect",
    Callback = function(enabled)
        state.autoVolcanoCollect = enabled
        state.autoVolcanoCollectVer += 1
        local ver = state.autoVolcanoCollectVer
        if not enabled then return end
        task.spawn(function()
            while state.autoVolcanoCollect and ver == state.autoVolcanoCollectVer do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    local hum  = char and char:FindFirstChild("Humanoid")
                    if not (hrp and hum and hum.Health > 0) then return end
                    local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                    if not kickPos then return end
                    local targetCF   = kickPos:IsA("BasePart") and kickPos.CFrame or kickPos:GetPivot()
                    local safeZonePos = targetCF.Position
                    if (hrp.Position - safeZonePos).Magnitude > 10 then
                        teleportTo(targetCF + Vector3.new(0, 3, 0))
                    end
                    task.wait(0.5)
                    local startPos      = hrp.Position
                    local wasTeleported = false
                    local HUD           = PlayerGui:FindFirstChild("HUD")
                    for _ = 1, 150 do
                        task.wait(0.1)
                        if not char or not char.Parent or hum.Health <= 0 or not state.autoVolcanoCollect then return end
                        local kickBtn = HUD and HUD:FindFirstChild("KickButton")
                        if kickBtn and kickBtn.Visible then
                            Network.rev_KickEvent:FireServer(1)
                        end
                        if (hrp.Position - startPos).Magnitude > 40 then wasTeleported = true break end
                    end
                    if not wasTeleported then return end
                    local stuckTimeout = 0
                    local lastPos      = hrp.Position
                    while state.autoVolcanoCollect and hum.Health > 0 do
                        pcall(function()
                            if hum.Sit or hum.PlatformStand
                            or hum:GetState() == Enum.HumanoidStateType.Ragdoll
                            or hum:GetState() == Enum.HumanoidStateType.FallingDown then
                                hum.Sit = false
                                hum.PlatformStand = false
                                hum:ChangeState(Enum.HumanoidStateType.Running)
                                hum.Jump = true
                            end
                        end)
                        local currentPos = hrp.Position
                        local toSafeDir  = (Vector3.new(safeZonePos.X, 0, safeZonePos.Z) - Vector3.new(currentPos.X, 0, currentPos.Z)).Unit
                        for _, obj in pairs(workspace.Debris:GetChildren()) do
                            local hitbox     = obj:FindFirstChild("Hitbox")
                            local shardParts = obj:FindFirstChild("ShardParts")
                            if hitbox and hitbox:IsA("BasePart") and shardParts then
                                local hitPos = hitbox.Position
                                local dist   = (currentPos - hitPos).Magnitude
                                if dist <= 30 then
                                    local toShardDir = (Vector3.new(hitPos.X, 0, hitPos.Z) - Vector3.new(currentPos.X, 0, currentPos.Z)).Unit
                                    if toSafeDir:Dot(toShardDir) >= -0.2 then
                                        pcall(function()
                                            if firetouchinterest then
                                                task.spawn(function()
                                                    firetouchinterest(hrp, hitbox, 0)
                                                    task.wait(0.05)
                                                    firetouchinterest(hrp, hitbox, 1)
                                                end)
                                            end
                                            Network.rev_CollectShard:FireServer(obj.Name)
                                        end)
                                    end
                                end
                            end
                        end
                        pcall(function()
                            if not hum.Sit and hum:GetState() ~= Enum.HumanoidStateType.Ragdoll then
                                hum:MoveTo(safeZonePos)
                            end
                        end)
                        if (hrp.Position - safeZonePos).Magnitude <= 6 then break end
                        if (hrp.Position - lastPos).Magnitude < 0.5 then
                            stuckTimeout += 0.1
                        else
                            stuckTimeout = 0
                            lastPos = hrp.Position
                        end
                        if stuckTimeout > 3 then
                            teleportTo(targetCF + Vector3.new(0, 3, 0))
                            break
                        end
                        task.wait(0.1)
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
})

-- ===================== UPGRADE TAB =====================
local upgradeSection = window:CreateSection("Upgrades")
local upgradeTab     = upgradeSection:CreateTab("Upgrade", "rbxassetid://10734950309")

upgradeTab:CreateSection("Volcano Upgrades")

local VolcanoUpgrades = {
    "OreMultipliers", "OreSize", "SpecialOres",
    "SpecialOresChances", "VolcanicMutation", "VolcanicMutationChance"
}

local volcanoUpgradeOptions = {"All"}
for _, k in ipairs(VolcanoUpgrades) do volcanoUpgradeOptions[#volcanoUpgradeOptions+1] = k end

state.volcanoUpgradeKey = "All"

upgradeTab:CreateDropdown({
    Name     = "Upgrade Type",
    Options  = volcanoUpgradeOptions,
    Default  = "All",
    Flag     = "VolcanoUpgradeKey",
    Callback = function(v) state.volcanoUpgradeKey = v end
})

upgradeTab:CreateToggle({
    Name     = "Auto Buy Volcano Upgrades",
    Default  = false,
    Flag     = "AutoVolcanoUpgrade",
    Callback = function(enabled)
        state.autoVolcanoUpgrade = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoVolcanoUpgrade do
                pcall(function()
                    local targets = state.volcanoUpgradeKey == "All" and VolcanoUpgrades or { state.volcanoUpgradeKey }
                    for _, key in ipairs(targets) do
                        if not state.autoVolcanoUpgrade then break end
                        Network.rev_volcanoUpgrade:FireServer(key, 1)
                        task.wait(0.3)
                    end
                end)
                task.wait(1)
            end
        end)
    end
})


upgradeTab:CreateSection("Auto Upgrade")

local upgradeOptions = {}
for i = 1, 30 do upgradeOptions[i] = tostring(i) end

local upgradeOptionsAll = {"All"}
for _, v in ipairs(upgradeOptions) do upgradeOptionsAll[#upgradeOptionsAll+1] = v end

upgradeTab:CreateDropdown({
    Name        = "Upgrade Slot",
    Options     = upgradeOptionsAll,
    Default     = {"All"},
    MultiSelect = true,
    Flag        = "UpgSlot",
    Callback    = function(v)
        state.upgradeSlots   = {}
        state.upgradeSlotAll = false
        for _, s in ipairs(v) do
            if s == "All" then state.upgradeSlotAll = true break end
            state.upgradeSlots[#state.upgradeSlots+1] = tonumber(s)
        end
    end
})

upgradeTab:CreateToggle({
    Name     = "Auto Upgrade Selected",
    Default  = false,
    Flag     = "AutoUpgrade",
    Callback = function(enabled)
        state.autoUpgrade = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoUpgrade do
                pcall(function()
                    local slots = state.upgradeSlotAll and upgradeOptions or state.upgradeSlots
                    for _, slot in ipairs(slots) do
                        if not state.autoUpgrade then break end
                        Network.rev_B_Upgrade:FireServer(tonumber(slot) or slot)
                        task.wait(0.1)
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
})

-- ===================== KICKZONE TAB =====================
local kickZoneTab = mainSection:CreateTab("KickZone", "rbxassetid://112235310154264")

kickZoneTab:CreateSection("Auto Kick — KickZone & Waves")

kickZoneTab:CreateDropdown({
    Name     = "Zone Rarity",
    Options  = Rarities,
    Default  = "Common",
    Flag     = "EventRarity",
    Callback = function(v) state.kickRarity = v end
})

kickZoneTab:CreateSlider({
    Name     = "Distance Multiplier",
    Min      = 1,
    Max      = 100,
    Default  = 1,
    Flag     = "EventDistMult",
    Callback = function(v) state.kickDistMult = v end
})

kickZoneTab:CreateDropdown({
    Name        = "Target KickZone Pets",
    Options     = Pets["Common"],
    Default     = {},
    MultiSelect = true,
    Flag        = "EventTargetPets",
    Callback    = function(v)
        state.eventPets = {}
        for _, name in ipairs(v) do state.eventPets[name] = true end
    end
})

kickZoneTab:CreateDropdown({
    Name        = "Target KickZone Mutation",
    Options     = Mutations,
    Default     = {},
    MultiSelect = true,
    Flag        = "EventTargetMuts",
    Callback    = function(v)
        state.eventMuts = {}
        for _, m in ipairs(v) do state.eventMuts[m] = true end
    end
})

kickZoneTab:CreateToggle({
    Name     = "Auto Kick (KickZone & Waves)",
    Default  = false,
    Flag     = "AutoEvent",
    Callback = function(enabled)
        state.autoEvent = enabled
        state.autoEventVer += 1
        local ver = state.autoEventVer
        if not enabled then return end
        task.spawn(function()
            while state.autoEvent and ver == state.autoEventVer do
                pcall(function()
                    local char = LocalPlayer.Character
                    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                    local hum  = char and char:FindFirstChild("Humanoid")
                    if not (hrp and hum and hum.Health > 0) then return end

                    local kickZone = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                    if not kickZone then return end
                    local zoneCF = kickZone:IsA("BasePart") and kickZone.CFrame or kickZone:GetPivot()

                    if (hrp.Position - zoneCF.Position).Magnitude > 5 then
                        teleportTo(zoneCF + Vector3.new(0, 3, 0))
                    end
                    task.wait(0.5)

                    local startPos = hrp.Position
                    local moved    = false
                    local hud      = PlayerGui:FindFirstChild("HUD")

                    for _ = 1, 400 do
                        task.wait(0.1)
                        if not char or not char.Parent or hum.Health <= 0 then return end
                        if (hrp.Position - startPos).Magnitude > 40 then moved = true break end
                        local kickBtn = hud and hud:FindFirstChild("KickButton")
                        if kickBtn and kickBtn.Visible then
                            local pwr = KickZonePower[state.kickRarity]
                            if pwr then
                                Network.rev_KickEvent:FireServer(pwr[1], pwr[2] * state.kickDistMult)
                            else
                                Network.rev_KickEvent:FireServer(1)
                            end
                            task.wait(0.5)
                        end
                    end

                    if not moved then return end
                    task.wait(0.5)

                    local found, foundModel = false, nil
                    for _ = 1, 40 do
                        task.wait(0.2)
                        local best = 2000
                        for _, m in pairs(workspace.Debris:GetChildren()) do
                            if m:IsA("Model") and m.PrimaryPart then
                                local dist = (m.PrimaryPart.Position - hrp.Position).Magnitude
                                if dist < best then best = dist found = true foundModel = m end
                            end
                        end
                        if found then break end
                    end

                    if not (found and foundModel) then return end

                    local landDeadline = tick() + 8
                    repeat task.wait(0.1)
                    until not foundModel.Parent
                        or foundModel.PrimaryPart.AssemblyLinearVelocity.Magnitude < 5
                        or tick() > landDeadline
                    if not foundModel.Parent then return end

                    local petName = foundModel.Name
                    local muts    = getMutations(foundModel)
                    local mutList = next(muts) and table.concat((function() local t={} for k in pairs(muts) do t[#t+1]=k end return t end)(), ", ") or "Normal"
                    local rarity  = getPetRarity(petName)
                    if shouldSkip(foundModel, state.eventPets, state.eventMuts) then
                        local waves = workspace:FindFirstChild("Waves")
                        local wavePos = waves and (waves:IsA("BasePart") and waves.Position
                            or waves.PrimaryPart and waves.PrimaryPart.Position
                            or (waves:FindFirstChildWhichIsA("BasePart", true) and waves:FindFirstChildWhichIsA("BasePart", true).Position))
                        smoothFlyTo(hrp, hum, wavePos or zoneCF.Position)
                    else
                        teleportTo(CFrame.new(foundModel.PrimaryPart.Position + Vector3.new(0, 2, 0)))
                        task.wait(0.1)
                        pcall(function()
                            for _, part in pairs(foundModel:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    firetouchinterest(hrp, part, 0)
                                    task.wait()
                                    firetouchinterest(hrp, part, 1)
                                end
                            end
                        end)
                        task.wait(0.4)
                        local count = (state.collected[petName] or 0) + 1
                        state.collected[petName] = count
                        print("KickZone collected: " .. petName .. " [" .. mutList .. "] Rarity: " .. rarity .. " | Total: " .. count)
                        sendWebhook("KickZone Pet Collected!", "**Pet:** "..petName.."\n**Rarity:** "..rarity.."\n**Mutation:** "..mutList.."\n**Total:** "..count, 0x3498DB)
                        if kickZone then smoothFlyTo(hrp, hum, zoneCF.Position) end
                    end
                end)
                task.wait(0.4)
            end
        end)
    end
})

-- ===================== SELL TAB =====================
local sellTab = mainSection:CreateTab("Sell", "rbxassetid://10734950309")

sellTab:CreateSection("Auto Sell")

local sellRarities = {"All"}
for _, r in ipairs(Rarities) do sellRarities[#sellRarities+1] = r end

sellTab:CreateDropdown({
    Name     = "Filter Sell Rarity",
    Options  = sellRarities,
    Default  = "All",
    Flag     = "SellRarity",
    Callback = function(v) state.sellRarity = v end
})

sellTab:CreateDropdown({
    Name        = "Select Pets to Sell",
    Options     = Pets["Common"],
    Default     = {},
    MultiSelect = true,
    Flag        = "SellPets",
    Callback    = function(v)
        state.sellPets = {}
        for _, name in ipairs(v) do state.sellPets[name] = true end
    end
})

sellTab:CreateDropdown({
    Name        = "Select Mutation to Sell",
    Options     = Mutations,
    Default     = {},
    MultiSelect = true,
    Flag        = "SellMuts",
    Callback    = function(v)
        state.sellMuts = {}
        for _, m in ipairs(v) do state.sellMuts[m] = true end
    end
})

sellTab:CreateToggle({
    Name     = "Auto Sell Selected Pets",
    Default  = false,
    Flag     = "AutoSell",
    Callback = function(enabled)
        state.autoSell = enabled
        if not enabled then return end
        task.spawn(function()
            while state.autoSell do
                pcall(function()
                    local bp  = LocalPlayer:FindFirstChild("Backpack")
                    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                    if not (bp and hum) then return end
                    for _, tool in pairs(bp:GetChildren()) do
                        if not state.autoSell then break end
                        if tool:IsA("Tool") and not TrainingTools[tool.Name] then
                            local rarityOK = state.sellRarity == "All" or getPetRarity(tool.Name) == state.sellRarity
                            local nameOK   = not next(state.sellPets) or state.sellPets[tool.Name]
                            local mut      = tool:GetAttribute("Mutation") or "Normal"
                            local mutOK    = not next(state.sellMuts)  or state.sellMuts[mut]
                            if rarityOK and nameOK and mutOK then
                                hum:EquipTool(tool)
                                task.wait(0.15)
                                pcall(function()
                                    Network.rev_B_Sell:FireServer()
                                end)
                                task.wait(0.2)
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end
})

-- ===================== CONFIG TAB =====================
local settingsSection = window:CreateSection("Settings")
local configTab       = settingsSection:CreateTab("Config", "rbxassetid://10734950309")
configTab:CreateConfigSection()

configTab:CreateSection("Discord Webhook")

configTab:CreateToggle({
    Name     = "Enable Webhook",
    Default  = false,
    Flag     = "WebhookEnabled",
    Callback = function(v) state.webhookEnabled = v end
})

configTab:CreateInput({
    Name        = "Webhook URL",
    Placeholder = "https://discord.com/api/webhooks/...",
    Flag        = "WebhookURL",
    Callback    = function(v) state.webhookURL = v end
})

configTab:CreateButton({
    Name     = "Test Webhook",
    Callback = function()
        local prev = state.webhookEnabled
        state.webhookEnabled = true
        sendWebhook("Test Notification", "Webhook is working! — Kick Hub", 0x04CB29)
        state.webhookEnabled = prev
    end
})