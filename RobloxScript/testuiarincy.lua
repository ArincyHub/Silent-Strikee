--[[
    Grow a Garden 2 - Auto Farm
    Criador: DevBrown
    UI: Rayfield Interface Suite
    Versão: 2.0
    Data: 2024
]]

-- Anti-Kick System
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

getgenv().GAG2_Loaded = true

-- Carregando Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Ícones verdadeiros do Grow a Garden 2

-- Sistema de Notificação
local function Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 5,
        Image = "",
    })
end

-- Variáveis de Estado
local State = {
    AutoFarm = false,
    AutoBuy = false,
    AutoPlant = false,
    AutoHarvest = false,
    AutoSell = false,
    AutoWater = false,
    AutoSprinkler = false,
    AutoExpand = false,
    AutoDaily = false,
    AutoSkill = false,
    AutoEquipPets = false,
    AutoBuyPets = false,
    AutoSellPets = false,
    AutoOpenEggs = false,
    AutoOpenCrates = false,
    AutoOpenPacks = false,
    AutoSteal = false,
    AutoGear = false,
    AutoMail = false,
    AutoCodes = false,
    FPSBoost = false,
    WebhookEnabled = false,
}

local Config = {
    BuyInterval = 5,
    PlantSpacing = 4,
    HarvestDelay = 0.01,
    SellInterval = 15,
    WaterInterval = 8,
    SprinklerInterval = 30,
    PetPrice = 25000,
    WebhookURL = "",
    WebhookInterval = 300,
    SelectedSeeds = {},
    SelectedGear = {},
    SelectedPetsToSell = {},
    SkillStats = {},
}

local Stats = {
    Bought = 0,
    Planted = 0,
    Harvested = 0,
    Sold = 0,
    Earned = 0,
    Watered = 0,
    Sprinklers = 0,
    Tamed = 0,
    Opened = 0,
    Stolen = 0,
    Codes = 0,
    StartTime = os.clock(),
}

-- Sistema de Networking
local Net = nil
do
    local sm = ReplicatedStorage:WaitForChild("SharedModules", 10)
    if sm then
        local netModule = sm:FindFirstChild("Networking")
        if netModule then
            local success, result = pcall(require, netModule)
            if success then
                Net = result
                Notify("✅ Conectado", "Sistema de rede carregado!", 3)
            else
                warn("Erro ao carregar Networking:", result)
            end
        end
    end
end

if not Net then
    Notify("❌ Erro", "Módulo de rede não encontrado!", 10)
    return
end

-- Funções de Utilidade
local function FormatNumber(num)
    num = tonumber(num) or 0
    if num >= 1e12 then return string.format("%.2fT", num/1e12)
    elseif num >= 1e9 then return string.format("%.2fB", num/1e9)
    elseif num >= 1e6 then return string.format("%.2fM", num/1e6)
    elseif num >= 1e3 then return string.format("%.2fK", num/1e3)
    else return tostring(math.floor(num)) end
end

local function GetAction(path)
    local current = Net
    for part in string.gmatch(path, "[^.]+") do
        if type(current) ~= "table" then return nil end
        current = current[part]
    end
    return current
end

local function FireAction(path, ...)
    local action = GetAction(path)
    if not action or not action.Fire then 
        return false, "Action not found: " .. path 
    end
    
    local success, result = pcall(function()
        return action:Fire()
    end)
    
    return success, result
end

local function FireActionFast(path, ...)
    local action = GetAction(path)
    if not action or not action.Fire then return false end
    return pcall(function() return action:Fire() end)
end

-- Função para obter réplica do jogador
local PlayerReplica = nil
local function GetReplica()
    if PlayerReplica then return PlayerReplica end
    
    local success, psc = pcall(function()
        return require(ReplicatedStorage.ClientModules.PlayerStateClient)
    end)
    
    if success and psc and psc.WaitForLocalReplica then
        local success2, replica = pcall(function()
            return psc:WaitForLocalReplica(30)
        end)
        if success2 and replica then
            PlayerReplica = replica
        end
    end
    
    return PlayerReplica
end

local function GetPlayerData()
    local replica = GetReplica()
    return (replica and replica.Data) or {}
end

local function GetSheckles()
    return tonumber(GetPlayerData().Sheckles) or 0
end

local function GetTokens()
    return tonumber(GetPlayerData().Tokens) or 0
end

local function GetInventory(category)
    local inv = GetPlayerData().Inventory
    return (inv and inv[category]) or {}
end

local function GetInventoryNames(category)
    local items = {}
    for key, value in pairs(GetInventory(category)) do
        local name, count
        if type(value) == "table" then
            name = value.Name or value.ItemName or value.Type or tostring(key)
            count = tonumber(value.Count) or tonumber(value.Amount) or 1
        elseif type(value) == "number" then
            name = tostring(key)
            count = value
        else
            name = tostring(key)
            count = 1
        end
        items[name] = (items[name] or 0) + count
    end
    return items
end

-- Funções de Plot
local function GetMyPlot()
    local plotId = LocalPlayer:GetAttribute("PlotId")
    local gardens = Workspace:FindFirstChild("Gardens")
    if not plotId or not gardens then return nil end
    return gardens:FindFirstChild("Plot" .. tostring(plotId))
end

local function GetPlantAreas()
    local areas = {}
    local plot = GetMyPlot()
    if not plot then return areas end
    
    for _, part in ipairs(CollectionService:GetTagged("PlantArea")) do
        if part:IsA("BasePart") and part:IsDescendantOf(plot) then
            table.insert(areas, part)
        end
    end
    return areas
end

local function GetPlantGrid(spacing)
    local points = {}
    local areas = GetPlantAreas()
    if #areas == 0 then return points end
    
    spacing = math.max(2, spacing or 4)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Include
    rayParams.FilterDescendantsInstances = areas
    
    for _, area in ipairs(areas) do
        local success, cf, size = pcall(function()
            return area.CFrame, area.Size
        end)
        
        if success then
            local topY = (cf * CFrame.new(0, size.Y/2, 0)).Position.Y
            for dx = -size.X/2 + spacing/2, size.X/2 - spacing/2, spacing do
                for dz = -size.Z/2 + spacing/2, size.Z/2 - spacing/2, spacing do
                    local worldPos = (cf * CFrame.new(dx, 0, dz)).Position
                    local ray = Workspace:Raycast(
                        Vector3.new(worldPos.X, topY + 10, worldPos.Z),
                        Vector3.new(0, -40, 0),
                        rayParams
                    )
                    if ray then
                        table.insert(points, ray.Position)
                    end
                end
            end
        end
    end
    
    return points
end

local function GetExistingPlants()
    local positions = {}
    local plot = GetMyPlot()
    if not plot then return positions end
    
    local plants = plot:FindFirstChild("Plants")
    if not plants then return positions end
    
    for _, model in ipairs(plants:GetChildren()) do
        local success, pivot = pcall(function()
            return model:GetPivot().Position
        end)
        if success then
            table.insert(positions, pivot)
        end
    end
    
    return positions
end

-- Funções de Colheita
local function GetCarrierModel(prompt)
    local node = prompt.Parent
    while node and node ~= Workspace and node:GetAttribute("PlantId") == nil do
        node = node.Parent
    end
    if node and node:GetAttribute("PlantId") then return node end
    return prompt:FindFirstAncestorWhichIsA("Model")
end

local function GetRipeHarvests()
    local harvests = {}
    for _, prompt in ipairs(CollectionService:GetTagged("HarvestPrompt")) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled and prompt:IsDescendantOf(Workspace) then
            local model = GetCarrierModel(prompt)
            local plantId = model and model:GetAttribute("PlantId")
            if plantId then
                local userId = tonumber(model:GetAttribute("UserId"))
                if userId == nil or userId == LocalPlayer.UserId then
                    table.insert(harvests, {
                        plantId = tostring(plantId),
                        fruitId = tostring(model:GetAttribute("FruitId") or "")
                    })
                end
            end
        end
    end
    return harvests
end

local function GetStealableHarvests()
    local steals = {}
    for _, prompt in ipairs(CollectionService:GetTagged("StealPrompt")) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled and prompt:IsDescendantOf(Workspace) then
            local model = GetCarrierModel(prompt)
            local plantId = model and model:GetAttribute("PlantId")
            if plantId then
                local pos = nil
                if prompt.Parent and prompt.Parent:IsA("BasePart") then
                    pos = prompt.Parent.Position
                elseif model then
                    local success, pivot = pcall(function()
                        return model:GetPivot().Position
                    end)
                    if success then pos = pivot end
                end
                
                table.insert(steals, {
                    owner = tonumber(model:GetAttribute("UserId")) or 0,
                    plantId = tostring(plantId),
                    fruitId = tostring(model:GetAttribute("FruitId") or ""),
                    position = pos
                })
            end
        end
    end
    return steals
end

-- Funções de Ferramentas
local function GetToolsByAttribute(attr, wantName)
    local tools = {}
    
    local function scanContainer(container)
        if not container then return end
        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute(attr) ~= nil then
                if not wantName or tool:GetAttribute(attr) == wantName or tool.Name == wantName then
                    table.insert(tools, tool)
                end
            end
        end
    end
    
    scanContainer(LocalPlayer:FindFirstChild("Backpack"))
    scanContainer(LocalPlayer.Character)
    
    return tools
end

local function GetHeldTool()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildWhichIsA("Tool")
end

local function EquipTool(tool)
    if not tool then return false end
    
    local char = LocalPlayer.Character
    if not char then return false end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    local success = pcall(function()
        humanoid:EquipTool(tool)
    end)
    
    if success then
        task.wait(0.22)
        return true
    end
    
    return false
end

-- Catálogo de Sementes
local function GetSeedCatalog()
    local catalog = {}
    
    local success, seedData = pcall(function()
        return require(ReplicatedStorage.SharedModules.SeedData)
    end)
    
    if success and type(seedData) == "table" then
        for _, entry in pairs(seedData) do
            if type(entry) == "table" and entry.SeedName and entry.RestockShop ~= false then
                table.insert(catalog, {
                    name = entry.SeedName,
                    price = tonumber(entry.PurchasePrice) or 0,
                    rarity = entry.Rarity or ""
                })
            end
        end
    end
    
    table.sort(catalog, function(a, b) return a.price < b.price end)
    
    -- Fallback com sementes conhecidas
    if #catalog == 0 then
        local knownSeeds = {
            "Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato", "Apple",
            "Bamboo", "Corn", "Cactus", "Pineapple", "Mushroom", "Green Bean",
            "Banana", "Grape", "Coconut", "Mango", "Dragon Fruit", "Acorn",
            "Cherry", "Sunflower", "Venus Fly Trap", "Pomegranate",
            "Poison Apple", "Moon Bloom", "Dragon's Breath", "Ghost Pepper", "Poison Ivy"
        }
        for _, name in ipairs(knownSeeds) do
            table.insert(catalog, {name = name, price = 0, rarity = ""})
        end
    end
    
    return catalog
end

-- Catálogo de Equipamentos
local function GetGearCatalog()
    local gear = {}
    local seen = {}
    
    local success, gearData = pcall(function()
        return require(ReplicatedStorage.SharedModules.GearShopData)
    end)
    
    if success and gearData and type(gearData.Data) == "table" then
        for _, entry in pairs(gearData.Data) do
            if type(entry) == "table" and entry.ItemName and not entry.RobuxOnly then
                if not seen[entry.ItemName] then
                    seen[entry.ItemName] = true
                    table.insert(gear, entry.ItemName)
                end
            end
        end
    end
    
    -- Fallback com itens em estoque
    if #gear == 0 then
        local success2, stockItems = pcall(function()
            return ReplicatedStorage.StockValues.GearShop.Items
        end)
        if success2 and stockItems then
            for _, item in ipairs(stockItems:GetChildren()) do
                table.insert(gear, item.Name)
            end
        end
    end
    
    table.sort(gear)
    return gear
end

-- Função de estoque da loja
local function GetShopStock(shop, itemName)
    local success, stockValues = pcall(function()
        return ReplicatedStorage.StockValues[shop].Items
    end)
    
    if not success or not stockValues then return nil end
    
    local stockValue = stockValues:FindFirstChild(itemName)
    return stockValue and tonumber(stockValue.Value) or 0
end

-- Pets Selvagens
local function GetWildPets()
    local pets = {}
    local map = Workspace:FindFirstChild("Map")
    local wildPetRef = map and map:FindFirstChild("WildPetRef")
    
    if wildPetRef then
        for _, part in ipairs(wildPetRef:GetChildren()) do
            if part:IsA("BasePart") then
                table.insert(pets, {
                    part = part,
                    name = part:GetAttribute("PetName"),
                    price = tonumber(part:GetAttribute("Price")) or 0,
                    owner = tonumber(part:GetAttribute("OwnerUserId")) or 0,
                    position = part.Position
                })
            end
        end
    end
    
    return pets
end

-- Pets Próprios
local function GetOwnedPets()
    local petNames = {}
    local seen = {}
    
    for name in pairs(GetInventoryNames("Pets")) do
        if not seen[name] then
            seen[name] = true
            table.insert(petNames, name)
        end
    end
    
    for _, tool in ipairs(GetToolsByAttribute("PetId")) do
        local name = tool:GetAttribute("PetName") or tool.Name
        if name and not seen[name] then
            seen[name] = true
            table.insert(petNames, name)
        end
    end
    
    table.sort(petNames)
    return petNames
end

-- Teleporte
local function TeleportTo(position, callback)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local originalCFrame = hrp.CFrame
    
    pcall(function()
        hrp.CFrame = CFrame.new(position + Vector3.new(0, 4, 0))
    end)
    
    task.wait(0.45)
    
    local success = false
    if callback then
        success = pcall(callback)
    end
    
    task.wait(0.15)
    
    if hrp and hrp.Parent then
        pcall(function()
            hrp.CFrame = originalCFrame
        end)
    end
    
    return success
end

-- Base do Jardim
local function GetGardenBase()
    local plot = GetMyPlot()
    if not plot then return nil end
    
    for _, tag in ipairs({"GardenTotalArea", "GardenZone"}) do
        for _, part in ipairs(CollectionService:GetTagged(tag)) do
            if part:IsA("BasePart") and part:IsDescendantOf(plot) then
                return Vector3.new(
                    part.Position.X,
                    part.Position.Y - part.Size.Y / 2 + 5,
                    part.Position.Z
                )
            end
        end
    end
    
    local spawnPoint = plot:FindFirstChild("SpawnPoint")
    if spawnPoint and spawnPoint:IsA("BasePart") then
        return spawnPoint.Position
    end
    
    local success, pivot = pcall(function()
        return plot:GetPivot().Position
    end)
    
    return success and pivot or nil
end

-- Verificar se é noite
local function IsNight()
    local nightValue = ReplicatedStorage:FindFirstChild("Night")
    return nightValue and nightValue.Value == true
end

-- Capacidade de Frutas
local function GetMaxFruitCapacity()
    return tonumber(LocalPlayer:GetAttribute("MaxFruitCapacity")) or 100
end

local function GetFruitCount()
    return tonumber(LocalPlayer:GetAttribute("FruitCount")) or 0
end

-- ===============================
-- LOOPS DE AUTOMAÇÃO
-- ===============================

-- Sistema de Debounce
local LastAction = {}
local function CanDoAction(key, interval)
    local now = os.clock()
    if not LastAction[key] or (now - LastAction[key]) >= interval then
        LastAction[key] = now
        return true
    end
    return false
end

-- Auto Buy Seeds
task.spawn(function()
    while task.wait(1) do
        if State.AutoFarm or State.AutoBuy then
            if CanDoAction("buy_seeds", Config.BuyInterval) then
                local catalog = GetSeedCatalog()
                for _, seed in ipairs(catalog) do
                    if Config.SelectedSeeds[seed.name] then
                        local stock = GetShopStock("SeedShop", seed.name)
                        local bought = 0
                        
                        while bought < 8 do
                            if stock ~= nil and stock <= 0 then break end
                            if seed.price > 0 and GetSheckles() < seed.price then break end
                            
                            local success = FireAction("SeedShop.PurchaseSeed", seed.name)
                            if not success then break end
                            
                            Stats.Bought = Stats.Bought + 1
                            bought = bought + 1
                            if stock then stock = stock - 1 end
                            
                            task.wait(0.15)
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Plant
task.spawn(function()
    while task.wait(0.5) do
        if State.AutoFarm or State.AutoPlant then
            local grid = GetPlantGrid(Config.PlantSpacing)
            if #grid > 0 then
                local tools = GetToolsByAttribute("SeedTool")
                if #tools > 0 then
                    local tool = tools[1]
                    EquipTool(tool)
                    
                    local seedAttr = tool:GetAttribute("SeedTool")
                    if seedAttr then
                        local occupied = GetExistingPlants()
                        
                        for _, pos in ipairs(grid) do
                            local clear = true
                            for _, occupiedPos in ipairs(occupied) do
                                local distance = (Vector2.new(pos.X, pos.Z) - Vector2.new(occupiedPos.X, occupiedPos.Z)).Magnitude
                                if distance < 1 then
                                    clear = false
                                    break
                                end
                            end
                            
                            if clear then
                                FireAction("Plant.PlantSeed", pos, seedAttr, tool)
                                Stats.Planted = Stats.Planted + 1
                                table.insert(occupied, pos)
                                task.wait(0.12)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Harvest & Sell (Otimizado)
task.spawn(function()
    while task.wait(0.05) do
        if State.AutoFarm or State.AutoHarvest then
            local harvests = GetRipeHarvests()
            local capacity = GetMaxFruitCapacity()
            
            for _, harvest in ipairs(harvests) do
                if GetFruitCount() >= capacity - 1 then
                    break
                end
                
                FireActionFast("Garden.CollectFruit", harvest.plantId, harvest.fruitId)
                Stats.Harvested = Stats.Harvested + 1
                
                if Config.HarvestDelay > 0 then
                    task.wait(Config.HarvestDelay)
                end
            end
            
            -- Auto Sell quando inventário cheio
            if (State.AutoFarm or State.AutoSell) and GetFruitCount() > 0 then
                local success, result = FireActionFast("NPCS.SellAll")
                if success and type(result) == "table" and result.Success then
                    local soldCount = tonumber(result.SoldCount) or 0
                    Stats.Sold = Stats.Sold + soldCount
                    Stats.Earned = Stats.Earned + (tonumber(result.SellPrice) or 0)
                end
            end
        end
    end
end)

-- Auto Water
task.spawn(function()
    while task.wait(Config.WaterInterval) do
        if State.AutoWater then
            local tools = GetToolsByAttribute("WateringCan")
            if #tools > 0 then
                local tool = tools[1]
                EquipTool(tool)
                
                local canName = tool:GetAttribute("WateringCan")
                if canName then
                    for _, pos in ipairs(GetExistingPlants()) do
                        FireAction("WateringCan.UseWateringCan", pos - Vector3.new(0, 0.3, 0), canName, tool)
                        Stats.Watered = Stats.Watered + 1
                        task.wait(0.2)
                    end
                end
            end
        end
    end
end)

-- Auto Sprinkler
task.spawn(function()
    while task.wait(Config.SprinklerInterval) do
        if State.AutoSprinkler then
            local plotId = LocalPlayer:GetAttribute("PlotId")
            if plotId then
                local placed = GetExistingPlants()
                
                for _, tool in ipairs(GetToolsByAttribute("Sprinkler")) do
                    EquipTool(tool)
                    
                    local sprinklerAttr = tool:GetAttribute("Sprinkler")
                    if sprinklerAttr then
                        local grid = GetPlantGrid(8)
                        for _, pos in ipairs(grid) do
                            local farEnough = true
                            for _, placedPos in ipairs(placed) do
                                if (pos - placedPos).Magnitude < 12 then
                                    farEnough = false
                                    break
                                end
                            end
                            
                            if farEnough then
                                FireAction("Place.PlaceSprinkler", pos, sprinklerAttr, tool, plotId)
                                Stats.Sprinklers = Stats.Sprinklers + 1
                                table.insert(placed, pos)
                                task.wait(0.3)
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Expand
task.spawn(function()
    while task.wait(12) do
        if State.AutoFarm or State.AutoExpand then
            FireAction("Actions.ExpandGarden")
        end
    end
end)

-- Auto Daily
task.spawn(function()
    while task.wait(60) do
        if State.AutoFarm or State.AutoDaily then
            FireAction("NPCS.CheckDailyDeal")
            task.wait(0.3)
            FireAction("NPCS.UseDailyDealAll")
        end
    end
end)

-- Auto Skill Points
task.spawn(function()
    while task.wait(6) do
        if State.AutoSkill then
            for stat, enabled in pairs(Config.SkillStats) do
                if enabled then
                    FireAction("SkillPoints.SpendSkillPoint", stat)
                    task.wait(0.25)
                end
            end
        end
    end
end)

-- Auto Equip Pets
task.spawn(function()
    while task.wait(12) do
        if State.AutoEquipPets then
            local maxPets = tonumber(LocalPlayer:GetAttribute("MaxEquippedPets")) or 3
            local success, equippedPets = FireAction("Pets.GetEquippedPets")
            
            if success and type(equippedPets) == "table" then
                local count = 0
                for _ in pairs(equippedPets) do count = count + 1 end
                
                if count < maxPets then
                    for _, petName in ipairs(GetOwnedPets()) do
                        if count >= maxPets then break end
                        FireAction("Pets.RequestEquipByName", petName)
                        count = count + 1
                        task.wait(0.3)
                    end
                end
            end
        end
    end
end)

-- Auto Buy Pets
task.spawn(function()
    while task.wait(5) do
        if State.AutoBuyPets then
            for _, pet in ipairs(GetWildPets()) do
                if pet.owner == 0 and pet.price > 0 and pet.price <= Config.PetPrice then
                    if GetSheckles() >= pet.price then
                        if pet.position then
                            TeleportTo(pet.position, function()
                                FireAction("Pets.WildPetTame", pet.part)
                            end)
                        else
                            FireAction("Pets.WildPetTame", pet.part)
                        end
                        Stats.Tamed = Stats.Tamed + 1
                        task.wait(0.5)
                    end
                end
            end
        end
    end
end)

-- Auto Sell Pets
task.spawn(function()
    while task.wait(4) do
        if State.AutoSellPets then
            for _, tool in ipairs(GetToolsByAttribute("PetId")) do
                local petName = tool:GetAttribute("PetName") or tool.Name
                if Config.SelectedPetsToSell[petName] then
                    EquipTool(tool)
                    task.wait(0.25)
                    FireAction("NPCS.SellPet", tool:GetAttribute("PetId"))
                    task.wait(0.3)
                end
            end
        end
    end
end)

-- Auto Open Eggs
local function AutoOpenItems(category, path)
    task.spawn(function()
        while task.wait(4) do
            if (category == "Eggs" and State.AutoOpenEggs) or
               (category == "Crates" and State.AutoOpenCrates) or
               (category == "SeedPacks" and State.AutoOpenPacks) then
                
                for itemName, count in pairs(GetInventoryNames(category)) do
                    for i = 1, math.min(count, 25) do
                        local success, result = FireAction(path, itemName)
                        if not success then break end
                        if type(result) == "table" and result.Success == false then break end
                        
                        Stats.Opened = Stats.Opened + 1
                        task.wait(0.3)
                    end
                end
            end
        end
    end)
end

AutoOpenItems("Eggs", "Egg.OpenEgg")
AutoOpenItems("Crates", "Crate.OpenCrate")
AutoOpenItems("SeedPacks", "SeedPack.OpenSeedPack")

-- Auto Buy Gear
task.spawn(function()
    while task.wait(10) do
        if State.AutoGear then
            for gearName, enabled in pairs(Config.SelectedGear) do
                if enabled then
                    local stock = GetShopStock("GearShop", gearName)
                    if stock == nil or stock > 0 then
                        FireAction("GearShop.PurchaseGear", gearName)
                        task.wait(0.3)
                    end
                end
            end
        end
    end
end)

-- Auto Steal
task.spawn(function()
    while task.wait(1.5) do
        if State.AutoSteal and IsNight() then
            for _, steal in ipairs(GetStealableHarvests()) do
                if not State.AutoSteal or not IsNight() then break end
                
                -- Teleportar para a fruta
                if steal.position then
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        pcall(function()
                            hrp.CFrame = CFrame.new(steal.position + Vector3.new(0, 4, 0))
                        end)
                        task.wait(0.4)
                    end
                end
                
                -- Roubar
                FireAction("Steal.BeginSteal", steal.owner, steal.plantId, steal.fruitId)
                FireAction("Steal.CompleteSteal")
                Stats.Stolen = Stats.Stolen + 1
                
                -- Voltar para base
                local base = GetGardenBase()
                if base then
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        pcall(function()
                            hrp.CFrame = CFrame.new(base + Vector3.new(0, 4, 0))
                        end)
                        
                        local timeout = os.clock()
                        while LocalPlayer:GetAttribute("CarryingStolenFruit") and 
                              (os.clock() - timeout) < 3 and 
                              State.AutoSteal do
                            task.wait(0.15)
                        end
                    end
                end
                
                task.wait(0.05)
            end
        end
    end
end)

-- Auto Mail
task.spawn(function()
    while task.wait(30) do
        if State.AutoMail then
            local success, mailbox = FireAction("Mailbox.OpenInbox")
            if success and type(mailbox) == "table" then
                local inbox = mailbox.Mailbox or mailbox.Inbox or mailbox
                for mailId, entry in pairs(inbox) do
                    if type(entry) == "table" then
                        if not (entry.Claimed == true or entry.IsClaimed == true) then
                            FireAction("Mailbox.Claim", mailId)
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Codes
local KNOWN_CODES = {
    "RELEASE",
    "UPDATE1",
    "PETS",
    "GARDEN",
    "GROW",
}

task.spawn(function()
    local triedCodes = {}
    while task.wait(120) do
        if State.AutoCodes then
            for _, code in ipairs(KNOWN_CODES) do
                if not triedCodes[code] then
                    local success, result = FireAction("Settings.SubmitCode", code)
                    triedCodes[code] = true
                    if success and result == true then
                        Stats.Codes = Stats.Codes + 1
                        Notify("✅ Código", "Código resgatado: " .. code, 5)
                    end
                    task.wait(0.4)
                end
            end
        end
    end
end)

-- FPS Boost
local function ApplyFPSBoost(enabled)
    if enabled then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 1e6
            
            for _, effect in ipairs(Lighting:GetChildren()) do
                if effect:IsA("BloomEffect") or 
                   effect:IsA("SunRaysEffect") or 
                   effect:IsA("DepthOfFieldEffect") or 
                   effect:IsA("BlurEffect") then
                    effect.Enabled = false
                end
            end
            
            if sethiddenproperty then
                pcall(sethiddenproperty, Lighting, "Technology", Enum.Technology.Legacy)
            end
            
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            
            task.spawn(function()
                for _, descendant in ipairs(Workspace:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or 
                       descendant:IsA("Trail") or 
                       descendant:IsA("Smoke") or 
                       descendant:IsA("Fire") or 
                       descendant:IsA("Sparkles") then
                        descendant.Enabled = false
                    elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                        descendant.Transparency = 1
                    end
                end
            end)
        end)
        
        Notify("⚡ FPS Boost", "Gráficos otimizados!", 3)
    end
end

-- Webhook
local function SendWebhook()
    if not State.WebhookEnabled or Config.WebhookURL == "" then return end
    
    local httpRequest = (syn and syn.request) or http_request or request
    if not httpRequest then return end
    
    local function formatTime(seconds)
        local hours = math.floor(seconds / 3600)
        local minutes = math.floor((seconds % 3600) / 60)
        local secs = math.floor(seconds % 60)
        
        if hours > 0 then
            return string.format("%dh %dm", hours, minutes)
        elseif minutes > 0 then
            return string.format("%dm %ds", minutes, secs)
        else
            return string.format("%ds", secs)
        end
    end
    
    local embed = {
        title = "🌱 Grow a Garden 2 - Relatório",
        color = 5763719,
        fields = {
            {
                name = "💰 Recursos",
                value = string.format("**Sheckles:** %s\n**Tokens:** %s", 
                    FormatNumber(GetSheckles()), 
                    FormatNumber(GetTokens())),
                inline = true
            },
            {
                name = "📊 Estatísticas",
                value = string.format(
                    "**Comprado:** %d\n**Plantado:** %d\n**Colhido:** %d\n**Vendido:** %d\n**Ganho:** %s",
                    Stats.Bought,
                    Stats.Planted,
                    Stats.Harvested,
                    Stats.Sold,
                    FormatNumber(Stats.Earned)
                ),
                inline = true
            },
            {
                name = "✨ Extras",
                value = string.format(
                    "**Regado:** %d\n**Aspersores:** %d\n**Pets:** %d\n**Abertos:** %d\n**Roubado:** %d",
                    Stats.Watered,
                    Stats.Sprinklers,
                    Stats.Tamed,
                    Stats.Opened,
                    Stats.Stolen
                ),
                inline = true
            },
            {
                name = "⏱️ Tempo Ativo",
                value = formatTime(os.clock() - Stats.StartTime),
                inline = false
            }
        },
        footer = {
            text = "DevBrown • Grow a Garden 2",
            icon_url = "https://www.roblox.com/avatar-thumbnails?userId=" .. LocalPlayer.UserId
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    local payload = {
        username = "GAG2 Farm Bot",
        avatar_url = "https://tr.rbxcdn.com/d8fb3bcb8f5e7edc6e4f4d4a6e6e1a4e/150/150/AvatarHeadshot/Png",
        embeds = {embed}
    }
    
    pcall(function()
        httpRequest({
            Url = Config.WebhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

-- Webhook Loop
task.spawn(function()
    while task.wait(Config.WebhookInterval) do
        if State.WebhookEnabled then
            SendWebhook()
        end
    end
end)

-- ===============================
-- CRIAÇÃO DA UI COM RAYFIELD
-- ===============================

local Window = Rayfield:CreateWindow({
    Name = "🌱 Grow a Garden 2",
    LoadingTitle = "DevBrown Farm Bot",
    LoadingSubtitle = "by DevBrown",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GAG2_Config",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
    KeySystem = false,
})

-- ===== TAB: HOME =====
local HomeTab = Window:CreateTab("🏠 Home")
local HomeSection = HomeTab:CreateSection("Informações")

local StatusParagraph = HomeTab:CreateParagraph({
    Title = "📊 Status Atual",
    Content = "Carregando..."
})

task.spawn(function()
    while task.wait(2) do
        local plot = GetMyPlot()
        StatusParagraph:Set({
            Title = "📊 Status Atual",
            Content = string.format(
                "Plot: %s\n💰 Sheckles: %s\n🪙 Tokens: %s\n🌾 Plantado: %d | Colhido: %d\n💵 Ganho Total: %s",
                plot and plot.Name or "Nenhum",
                FormatNumber(GetSheckles()),
                FormatNumber(GetTokens()),
                Stats.Planted,
                Stats.Harvested,
                FormatNumber(Stats.Earned)
            )
        })
    end
end)

HomeTab:CreateButton({
    Name = "🔄 Reiniciar Estatísticas",
    Callback = function()
        Stats = {
            Bought = 0,
            Planted = 0,
            Harvested = 0,
            Sold = 0,
            Earned = 0,
            Watered = 0,
            Sprinklers = 0,
            Tamed = 0,
            Opened = 0,
            Stolen = 0,
            Codes = 0,
            StartTime = os.clock(),
        }
        Notify("✅ Resetado", "Estatísticas reiniciadas!", 3)
    end,
})

-- ===== TAB: FARM =====
local FarmTab = Window:CreateTab("🌾 Farm")

FarmTab:CreateToggle({
    Name = "🚀 Auto Farm (Tudo)",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(value)
        State.AutoFarm = value
        Notify("🚀 Auto Farm", value and "Ativado!" or "Desativado!", 3)
    end,
})

FarmTab:CreateToggle({
    Name = "🌱 Auto Plant",
    CurrentValue = false,
    Flag = "AutoPlant",
    Callback = function(value)
        State.AutoPlant = value
    end,
})

FarmTab:CreateSlider({
    Name = "📏 Espaçamento (studs)",
    Range = {2, 10},
    Increment = 0.5,
    CurrentValue = 4,
    Flag = "PlantSpacing",
    Callback = function(value)
        Config.PlantSpacing = value
    end,
})

FarmTab:CreateToggle({
    Name = "🍎 Auto Harvest",
    CurrentValue = false,
    Flag = "AutoHarvest",
    Callback = function(value)
        State.AutoHarvest = value
    end,
})

FarmTab:CreateSlider({
    Name = "⏱️ Harvest Delay (s)",
    Range = {0, 0.2},
    Increment = 0.01,
    CurrentValue = 0.01,
    Flag = "HarvestDelay",
    Callback = function(value)
        Config.HarvestDelay = value
    end,
})

FarmTab:CreateToggle({
    Name = "💰 Auto Sell",
    CurrentValue = false,
    Flag = "AutoSell",
    Callback = function(value)
        State.AutoSell = value
    end,
})

FarmTab:CreateToggle({
    Name = "📈 Auto Expand Garden",
    CurrentValue = false,
    Flag = "AutoExpand",
    Callback = function(value)
        State.AutoExpand = value
    end,
})

FarmTab:CreateToggle({
    Name = "📅 Auto Daily Deals",
    CurrentValue = false,
    Flag = "AutoDaily",
    Callback = function(value)
        State.AutoDaily = value
    end,
})

-- ===== TAB: SEEDS =====
local SeedsTab = Window:CreateTab("🌰 Seeds")

SeedsTab:CreateSection("Comprar Sementes")

SeedsTab:CreateToggle({
    Name = "🛒 Auto Buy Seeds",
    CurrentValue = false,
    Flag = "AutoBuy",
    Callback = function(value)
        State.AutoBuy = value
    end,
})

SeedsTab:CreateSlider({
    Name = "⏱️ Intervalo de Compra (s)",
    Range = {1, 30},
    Increment = 1,
    CurrentValue = 5,
    Flag = "BuyInterval",
    Callback = function(value)
        Config.BuyInterval = value
    end,
})

local SeedCatalog = GetSeedCatalog()
for _, seed in ipairs(SeedCatalog) do
    SeedsTab:CreateToggle({
        Name = seed.name .. " ($" .. FormatNumber(seed.price) .. ")",
        CurrentValue = false,
        Flag = "Seed_" .. seed.name,
        Callback = function(value)
            Config.SelectedSeeds[seed.name] = value
        end,
    })
end

-- ===== TAB: PETS =====
local PetsTab = Window:CreateTab("🐾 Pets")

PetsTab:CreateToggle({
    Name = "✨ Auto Equip Pets",
    CurrentValue = false,
    Flag = "AutoEquipPets",
    Callback = function(value)
        State.AutoEquipPets = value
    end,
})

PetsTab:CreateToggle({
    Name = "🛒 Auto Buy Wild Pets",
    CurrentValue = false,
    Flag = "AutoBuyPets",
    Callback = function(value)
        State.AutoBuyPets = value
    end,
})

PetsTab:CreateSlider({
    Name = "💵 Max Pet Price",
    Range = {1000, 1000000},
    Increment = 1000,
    CurrentValue = 25000,
    Flag = "MaxPetPrice",
    Callback = function(value)
        Config.PetPrice = value
    end,
})

PetsTab:CreateSection("Vender Pets")

PetsTab:CreateToggle({
    Name = "💸 Auto Sell Pets",
    CurrentValue = false,
    Flag = "AutoSellPets",
    Callback = function(value)
        State.AutoSellPets = value
    end,
})

for _, petName in ipairs(GetOwnedPets()) do
    PetsTab:CreateToggle({
        Name = "Vender: " .. petName,
        CurrentValue = false,
        Flag = "SellPet_" .. petName,
        Callback = function(value)
            Config.SelectedPetsToSell[petName] = value
        end,
    })
end

-- ===== TAB: BOOSTS =====
local BoostsTab = Window:CreateTab("⚡ Boosts")

BoostsTab:CreateToggle({
    Name = "💧 Auto Water",
    CurrentValue = false,
    Flag = "AutoWater",
    Callback = function(value)
        State.AutoWater = value
    end,
})

BoostsTab:CreateSlider({
    Name = "⏱️ Water Interval (s)",
    Range = {2, 60},
    Increment = 1,
    CurrentValue = 8,
    Flag = "WaterInterval",
    Callback = function(value)
        Config.WaterInterval = value
    end,
})

BoostsTab:CreateToggle({
    Name = "🚿 Auto Sprinkler",
    CurrentValue = false,
    Flag = "AutoSprinkler",
    Callback = function(value)
        State.AutoSprinkler = value
    end,
})

BoostsTab:CreateSlider({
    Name = "⏱️ Sprinkler Interval (s)",
    Range = {10, 120},
    Increment = 5,
    CurrentValue = 30,
    Flag = "SprinklerInterval",
    Callback = function(value)
        Config.SprinklerInterval = value
    end,
})

BoostsTab:CreateSection("Skill Points")

BoostsTab:CreateToggle({
    Name = "📊 Auto Spend Skill Points",
    CurrentValue = false,
    Flag = "AutoSkill",
    Callback = function(value)
        State.AutoSkill = value
    end,
})

local SkillStats = {"BaseSpeed", "BaseJump", "ShovelPower", "MaxBackpack"}
for _, stat in ipairs(SkillStats) do
    BoostsTab:CreateToggle({
        Name = stat,
        CurrentValue = false,
        Flag = "Skill_" .. stat,
        Callback = function(value)
            Config.SkillStats[stat] = value
        end,
    })
end

-- ===== TAB: EGGS & CRATES =====
local EggsTab = Window:CreateTab("🥚 Eggs & Crates")

EggsTab:CreateToggle({
    Name = "🥚 Auto Open Eggs",
    CurrentValue = false,
    Flag = "AutoOpenEggs",
    Callback = function(value)
        State.AutoOpenEggs = value
    end,
})

EggsTab:CreateToggle({
    Name = "📦 Auto Open Crates",
    CurrentValue = false,
    Flag = "AutoOpenCrates",
    Callback = function(value)
        State.AutoOpenCrates = value
    end,
})

EggsTab:CreateToggle({
    Name = "🎁 Auto Open Seed Packs",
    CurrentValue = false,
    Flag = "AutoOpenPacks",
    Callback = function(value)
        State.AutoOpenPacks = value
    end,
})

-- ===== TAB: SHOP =====
local ShopTab = Window:CreateTab("🛒 Shop")

ShopTab:CreateToggle({
    Name = "🛍️ Auto Buy Gear",
    CurrentValue = false,
    Flag = "AutoGear",
    Callback = function(value)
        State.AutoGear = value
    end,
})

local GearCatalog = GetGearCatalog()
for _, gearName in ipairs(GearCatalog) do
    ShopTab:CreateToggle({
        Name = gearName,
        CurrentValue = false,
        Flag = "Gear_" .. gearName,
        Callback = function(value)
            Config.SelectedGear[gearName] = value
        end,
    })
end

-- ===== TAB: STEAL =====
local StealTab = Window:CreateTab("🌙 Steal")

StealTab:CreateToggle({
    Name = "🥷 Auto Steal (Night Only)",
    CurrentValue = false,
    Flag = "AutoSteal",
    Callback = function(value)
        State.AutoSteal = value
        Notify("🌙 Auto Steal", value and "Ativado! (Apenas à noite)" or "Desativado!", 3)
    end,
})

StealTab:CreateParagraph({
    Title = "ℹ️ Informação",
    Content = "Auto Steal só funciona durante a noite no jogo. Teleporta até frutas de outros jogadores, rouba e retorna para sua base."
})

-- ===== TAB: MISC =====
local MiscTab = Window:CreateTab("⚙️ Misc")

MiscTab:CreateToggle({
    Name = "📬 Auto Mail",
    CurrentValue = false,
    Flag = "AutoMail",
    Callback = function(value)
        State.AutoMail = value
    end,
})

MiscTab:CreateToggle({
    Name = "🎫 Auto Redeem Codes",
    CurrentValue = false,
    Flag = "AutoCodes",
    Callback = function(value)
        State.AutoCodes = value
    end,
})

MiscTab:CreateInput({
    Name = "Resgatar Código",
    PlaceholderText = "Digite o código",
    RemoveTextAfterFocusLost = true,
    Callback = function(text)
        if text and text ~= "" then
            local success, result = FireAction("Settings.SubmitCode", text)
            if success and result == true then
                Notify("✅ Código", "Código resgatado: " .. text, 5)
                Stats.Codes = Stats.Codes + 1
            else
                Notify("❌ Código", "Código inválido: " .. text, 5)
            end
        end
    end,
})

MiscTab:CreateButton({
    Name = "📋 Copiar Códigos Conhecidos",
    Callback = function()
        local codesList = table.concat(KNOWN_CODES, ", ")
        setclipboard(codesList)
        Notify("📋 Códigos", "Códigos copiados: " .. codesList, 5)
    end,
})

-- ===== TAB: SETTINGS =====
local SettingsTab = Window:CreateTab("⚙️ Settings")

SettingsTab:CreateToggle({
    Name = "⚡ FPS Boost",
    CurrentValue = false,
    Flag = "FPSBoost",
    Callback = function(value)
        State.FPSBoost = value
        ApplyFPSBoost(value)
    end,
})

SettingsTab:CreateSection("Discord Webhook")

SettingsTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "https://discord.com/api/webhooks/...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        Config.WebhookURL = text or ""
    end,
})

SettingsTab:CreateToggle({
    Name = "📡 Enable Webhook Reports",
    CurrentValue = false,
    Flag = "WebhookEnabled",
    Callback = function(value)
        State.WebhookEnabled = value
    end,
})

SettingsTab:CreateSlider({
    Name = "⏱️ Webhook Interval (min)",
    Range = {1, 60},
    Increment = 1,
    CurrentValue = 5,
    Flag = "WebhookInterval",
    Callback = function(value)
        Config.WebhookInterval = value * 60
    end,
})

SettingsTab:CreateButton({
    Name = "📤 Send Test Webhook",
    Callback = function()
        SendWebhook()
        Notify("📤 Webhook", "Relatório de teste enviado!", 3)
    end,
})

SettingsTab:CreateSection("Informações")

SettingsTab:CreateParagraph({
    Title = "ℹ️ Sobre",
    Content = "Grow a Garden 2 Auto Farm\nCriador: DevBrown\nVersão: 2.0\n\nScript completo com auto-farm, pets, steal e muito mais!"
})

SettingsTab:CreateButton({
    Name = "🔄 Recarregar Script",
    Callback = function()
        getgenv().GAG2_Loaded = false
        Rayfield:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/devbrown/gag2/main/script.lua"))()
    end,
})

SettingsTab:CreateButton({
    Name = "❌ Destruir UI",
    Callback = function()
        Rayfield:Destroy()
        Notify("👋 Tchau!", "UI destruída. Execute novamente para reabrir.", 5)
    end,
})

-- Mensagem Final
Notify("✅ Carregado!", "Grow a Garden 2 - DevBrown", 5)
print([[
╔═══════════════════════════════════════╗
║  🌱 Grow a Garden 2 - Auto Farm      ║
║  👤 Criador: DevBrown                ║
║  📅 Versão: 2.0                      ║
║  ✅ Carregado com sucesso!           ║
╚═══════════════════════════════════════╝
]])