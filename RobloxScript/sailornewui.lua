repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0


-- ════════════════════════════════════════════════════════════
-- SERVICES
-- ════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local MarketplaceService = game:GetService("MarketplaceService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════
local function SafeModule(parent, name)
    local obj = parent:FindFirstChild(name)

    if obj and obj:IsA('ModuleScript') then
        local ok, res = pcall(require, obj)

        if ok then
            return res
        end
    end

    return nil
end
local function GetRemote(parent, pathString)
    local current = parent

    for _, name in ipairs(pathString:split('.'))do
        if not current then
            return nil
        end

        current = current:FindFirstChild(name)
    end

    return current
end
local function Fire(remote, ...)
    if not remote then return end

    local args = {...}

    local success, err = pcall(function()
        remote:FireServer(table.unpack(args))
    end)

    if not success then
        warn("[Fire Error]:", err)
    end
end

local function Invoke(remote, ...)
    if not remote then return nil end

    local args = {...}

    local success, result = pcall(function()
        return remote:InvokeServer(table.unpack(args))
    end)

    if not success then
        warn("[Invoke Error]:", result)
        return nil
    end

    return result
end
local function CommaFormat(n)
    local s = tostring(n)
    return s:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local function Abbreviate(n)
    local abbrev = {{1e12, "T"}, {1e9, "B"}, {1e6, "M"}, {1e3, "K"}}
    for _, v in ipairs(abbrev) do
        if n >= v[1] then return string.format("%.1f%s", n / v[1], v[2]) end
    end
    return tostring(n)
end

-- ════════════════════════════════════════════════════════════
-- REMOTES
-- ════════════════════════════════════════════════════════════
local Remotes = {
    -- Combat
    M1 = GetRemote(ReplicatedStorage, "CombatSystem.Remotes.RequestHit"),
    UseSkill = GetRemote(ReplicatedStorage, "AbilitySystem.Remotes.RequestAbility"),
    UseFruit = GetRemote(ReplicatedStorage, "RemoteEvents.FruitPowerRemote"),
    EquipWeapon = GetRemote(ReplicatedStorage, "Remotes.EquipWeapon"),
    
    -- Haki
    ArmHaki = GetRemote(ReplicatedStorage, "RemoteEvents.HakiRemote"),
    ObsHaki = GetRemote(ReplicatedStorage, "RemoteEvents.ObservationHakiRemote"),
    ConqHaki = GetRemote(ReplicatedStorage, "Remotes.ConquerorHakiRemote"),
    
    -- Quest
    QuestAccept = GetRemote(ReplicatedStorage, "RemoteEvents.QuestAccept"),
    QuestAbandon = GetRemote(ReplicatedStorage, "RemoteEvents.QuestAbandon"),
    
    -- Teleport
    TP_Portal = GetRemote(ReplicatedStorage, "Remotes.TeleportToPortal"),
    
    -- Boss Summon
    SummonBoss = GetRemote(ReplicatedStorage, "Remotes.RequestSummonBoss"),
    JJKSummon = GetRemote(ReplicatedStorage, "Remotes.RequestSpawnStrongestBoss"),
    RimuruBoss = GetRemote(ReplicatedStorage, "RemoteEvents.RequestSpawnRimuru"),
    AnosBoss = GetRemote(ReplicatedStorage, "Remotes.RequestSpawnAnosBoss"),
    TrueAizen = GetRemote(ReplicatedStorage, "RemoteEvents.RequestSpawnTrueAizen"),
    
    -- Items
    UseItem = GetRemote(ReplicatedStorage, "Remotes.UseItem"),
    SlimeCraft = GetRemote(ReplicatedStorage, "Remotes.RequestSlimeCraft"),
    GrailCraft = GetRemote(ReplicatedStorage, "Remotes.RequestGrailCraft"),
    
    -- Stats & Rolls
    AddStat = GetRemote(ReplicatedStorage, "RemoteEvents.AllocateStat"),
    RerollStat = GetRemote(ReplicatedStorage, "Remotes.RerollSingleStat"),
    Roll_Trait = GetRemote(ReplicatedStorage, "RemoteEvents.TraitReroll"),
    TraitConfirm = GetRemote(ReplicatedStorage, "RemoteEvents.TraitConfirm"),
    TraitAutoSkip = GetRemote(ReplicatedStorage, "RemoteEvents.TraitUpdateAutoSkip"),
    SpecReroll = GetRemote(ReplicatedStorage, "RemoteEvents.SpecPassiveReroll"),
    
    -- Equipment
    Enchant = GetRemote(ReplicatedStorage, "Remotes.EnchantAccessory"),
    Blessing = GetRemote(ReplicatedStorage, "Remotes.BlessWeapon"),
    EquipTitle = GetRemote(ReplicatedStorage, "RemoteEvents.TitleEquip"),
    TitleUnequip = GetRemote(ReplicatedStorage, "RemoteEvents.TitleUnequip"),
    EquipRune = GetRemote(ReplicatedStorage, "Remotes.EquipRune"),
    LoadoutLoad = GetRemote(ReplicatedStorage, "RemoteEvents.LoadoutLoad"),
    
    -- Skill Tree
    SkillTreeUpgrade = GetRemote(ReplicatedStorage, "RemoteEvents.SkillTreeUpgrade"),
    
    -- Merchant
    MerchantOpen = GetRemote(ReplicatedStorage, "Remotes.MerchantRemotes.OpenMerchantUI"),
    MerchantBuy = GetRemote(ReplicatedStorage, "Remotes.MerchantRemotes.PurchaseMerchantItem"),
    MerchantStock = GetRemote(ReplicatedStorage, "Remotes.MerchantRemotes.MerchantStockUpdate"),
    
    -- Dungeon
    OpenDungeon = GetRemote(ReplicatedStorage, "Remotes.RequestDungeonPortal"),
    
    -- Artifacts
    ArtifactSync = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactDataSync"),
    ArtifactClaim = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactMilestoneClaimReward"),
    ArtifactDelete = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactMassDeleteByUUIDs"),
    ArtifactUpgrade = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactMassUpgrade"),
    ArtifactLock = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactLock"),
    ArtifactEquip = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactEquip"),
    ArtifactUnequip = GetRemote(ReplicatedStorage, "RemoteEvents.ArtifactUnequip"),
    
    -- Trade
    TradeSend = GetRemote(ReplicatedStorage, "Remotes.TradeRemotes.SendTradeRequest"),
    TradeRespond = GetRemote(ReplicatedStorage, "Remotes.TradeRemotes.RespondToRequest"),
    TradeAddItem = GetRemote(ReplicatedStorage, "Remotes.TradeRemotes.AddItemToTrade"),
    TradeReady = GetRemote(ReplicatedStorage, "Remotes.TradeRemotes.SetReady"),
    TradeConfirm = GetRemote(ReplicatedStorage, "Remotes.TradeRemotes.ConfirmTrade"),
    
    -- Ascend
    Ascend = GetRemote(ReplicatedStorage, "RemoteEvents.RequestAscend"),
    ReqAscend = GetRemote(ReplicatedStorage, "RemoteEvents.GetAscendData"),
    CloseAscend = GetRemote(ReplicatedStorage, "RemoteEvents.CloseAscendUI"),
    
    -- Inventory
    ReqInventory = GetRemote(ReplicatedStorage, "Remotes.RequestInventory"),
    
    -- Settings
    SettingsToggle = GetRemote(ReplicatedStorage, "RemoteEvents.SettingsToggle"),
}

-- ════════════════════════════════════════════════════════════
-- MODULES
-- ════════════════════════════════════════════════════════════
local Modules = {
    BossConfig = SafeModule(ReplicatedStorage.Modules, "BossConfig") or {Bosses = {}},
    TimedConfig = SafeModule(ReplicatedStorage.Modules, "TimedBossConfig"),
    SummonConfig = SafeModule(ReplicatedStorage.Modules, "SummonableBossConfig"),
    Quests = SafeModule(ReplicatedStorage.Modules, "QuestConfig") or {RepeatableQuests = {}, Questlines = {}},
    WeaponClass = SafeModule(ReplicatedStorage.Modules, "WeaponClassification") or {Tools = {}},
    Merchant = SafeModule(ReplicatedStorage.Modules, "MerchantConfig") or {ITEMS = {}},
    Trait = SafeModule(ReplicatedStorage.Modules, "TraitConfig") or {Traits = {}},
    Race = SafeModule(ReplicatedStorage.Modules, "RaceConfig") or {Races = {}},
    Clan = SafeModule(ReplicatedStorage.Modules, "ClanConfig") or {Clans = {}},
    SpecPassive = SafeModule(ReplicatedStorage.Modules, "SpecPassiveConfig"),
    Stats = SafeModule(ReplicatedStorage.Modules, "StatRerollConfig") or {StatKeys = {}, RankOrder = {}},
    SkillTree = SafeModule(ReplicatedStorage.Modules, "SkillTreeConfig") or {Branches = {}},
    ArtifactConfig = SafeModule(ReplicatedStorage.Modules, "ArtifactConfig"),
    ItemRarity = SafeModule(ReplicatedStorage.Modules, "ItemRarityConfig"),
    Title = SafeModule(ReplicatedStorage.Modules, "TitlesConfig") or {},
}

-- ════════════════════════════════════════════════════════════
-- WORKSPACE PATHS
-- ════════════════════════════════════════════════════════════
local NPCsFolder = workspace:WaitForChild("NPCs")
local ServiceNPCs = workspace:WaitForChild("ServiceNPCs")

-- ════════════════════════════════════════════════════════════
-- DATA TABLES
-- ════════════════════════════════════════════════════════════
local Tables = {
    MobList = {},
    BossList = {},
    AllBossList = {},
    SummonList = {},
        ManualWeaponClass = {
        Invisible = 'Power',
        Bomb = 'Power',
        Quake = 'Power',
        ['Soul Reaper'] = 'Sword',
        ['Light'] = 'Power',
    },
    OtherSummonList = {"StrongestHistory", "StrongestToday", "Rimuru", "Anos", "TrueAizen"},
    DiffList = {"Normal", "Medium", "Hard", "Extreme"},
    WeaponTypes = {"Melee", "Sword", "Power"},
    MerchantList = {},
    IslandList = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HuecoMundo", "Boss", "Dungeon", "Shinjuku", "Valentine", "Slime", "Academy", "Judgement", "SoulSociety"},
    DungeonList = {"CidDungeon", "RuneDungeon", "DoubleDungeon", "BossRush"},
    ChestList = {"Common", "Rare", "Epic", "Legendary", "Mythical", "Secret", "Aura Crate", "Cosmetic Crate"},
    StatList = {"Melee", "Defense", "Sword", "Power"},
    SkillKeys = {"Z", "X", "C", "V", "F"},
    BuildList = {"1", "2", "3", "4", "5", "None"},
    CraftItems = {"SlimeKey", "DivineGrail"},
    TraitList = {},
    RaceList = {},
    ClanList = {},
    SpecPassiveList = {},
    TitleList = {},
    RuneList = {"None"},
    OwnedWeapons = {},
    OwnedAccessories = {},
    GemStatList = {},
    GemRankList = {},
    MobToIsland = {},
    MiniBossList = {"ThiefBoss", "MonkeyBoss", "DesertBoss", "SnowBoss", "PandaMiniBoss"},
    NPCList = {},
}

local SummonMap = {}
local BossToIslandMap = {}

-- ════════════════════════════════════════════════════════════
-- State STATE
-- ════════════════════════════════════════════════════════════
local State = {
    Running = false,
    Farm = true,
    Target = nil,
    Island = "",
    Recovering = false,
    MovingIsland = false,
        WeapRotationIdx = 1,
    QuestNPC = "",
    
    -- Indexes for rotation
    MobIdx = 1,
    AllMobIdx = 1,
    WeaponIdx = 1,
    ComboIdx = 1,

    -- Extend State table for Sea 2
CosmicBossFound = false,
SeaBossFound = false,
DioBossFound = false,
    
    -- Timers
    LastM1 = 0,
    LastIslandTP = 0,
    LastWeaponSwitch = 0,
    LastBuildSwitch = 0,
    KillTick = 0,
    
    -- Haki
    ArmHakiOn = false,
    ObsHakiOn = false,
    
    -- Merchant
    MerchantBusy = false,
    MerchantTime = 0,
    MerchantExecuting = false,
    FirstMerchantSync = false,
    CurrentStock = {},
    
    -- Alt Help
    AltDamage = {},
    AltActive = false,
    
    -- Trade
    TradeState = {},
    
    -- Cached Data
    Inventory = {},
    Accessories = {},
    WeaponCache = {Sword = {}, Melee = {}},
    Stats = {},
    GemStats = {},
    SkillTree = {Nodes = {}, Points = 0},
    Passives = {},
    ArtifactInventory = {},
    ArtifactDust = 0,
    UnlockedTitles = {},
    
    -- Pity
    CurrentPity = 0,
    MaxPity = 25,
    
    -- Active Weapon
    ActiveWeapon = "",
    
    -- Last Switch
    LastSwitch = {Title = "", Rune = "", Build = ""},
    
    -- Global Priority
    GlobalPrio = "FARM",
}

-- ════════════════════════════════════════════════════════════
-- TOGGLES & OPTIONS (for UI binding)
-- ════════════════════════════════════════════════════════════
local Toggles = {
    -- Farm
    MobFarm = false,
    AllMobFarm = false,
    LevelFarm = false,
    BossFarm = false,
    AllBossFarm = false,
    SummonFarm = false,
    OtherSummonFarm = false,
    AutoSummon = false,
    AutoOtherSummon = false,
    PityBossFarm = false,
    AltBossFarm = false,
    
    -- Combat
    AutoM1 = false,
    AutoSkill = false,
    AutoCombo = false,
    KillAura = false,
    InstaKill = false,

AutoCosmicBoss   = false,
AutoSeaBossSpawn = false,
AutoSeaBoss      = false,
AutoHopSeaBoss   = false,
AutoSpawnDio     = false,
AutoKillDio      = false,
AutoDungeonEnabled = false,
AutoDungeonRetry   = true,
AutoTowerEnabled   = false,
AutoTowerStart     = true,
AutoTowerReset     = false,
AutoCrystalDefense = false,
AutoCrystalReplay  = true,
    
    -- Haki
    AutoArmHaki = false,
    AutoObsHaki = false,
    AutoConqHaki = false,
    OnlyTarget = false,
    
    -- Stats
    AutoStats = false,
    AutoRollStats = false,
    AutoSkillTree = false,
    
    -- Rolls
    AutoTrait = false,
    AutoRace = false,
    AutoClan = false,
    AutoSpec = false,
    
    -- Enchant
    AutoEnchant = false,
    AutoEnchantAll = false,
    AutoBlessing = false,
    AutoBlessingAll = false,
    
    -- Switch
    AutoTitle = false,
    AutoRune = false,
    AutoBuild = false,
    
    -- Misc
    AutoChest = false,
    AutoCraft = false,
    AutoMerchant = false,
    AutoDungeon = false,
    AutoAscend = false,
    ArtifactMilestone = false,
    AutoQuestline = false,
    
    -- Artifact
    ArtifactLock = false,
    ArtifactDelete = false,
    ArtifactUpgrade = false,
    ArtifactEquip = false,
    DeleteUnlocked = false,
    UpgradeStage = false,
    
    -- Trade
    AutoSendTrade = false,
    AutoAcceptTrade = false,
    AutoConfirmTrade = false,
    
    -- Player
    WalkSpeed = false,
    JumpPower = false,
    Noclip = false,
    AntiKnockback = false,
    AntiAFK = true,
    AutoReconnect = false,
    FPSBoost = false,
    Fullbright = false,
    
    -- Farm Config
    IslandTP = true,
    
    -- Webhook
    SendWebhook = false,
    PingUser = false,
    
    -- Safety
    AutoKick = false,
}

local Options = {
    -- Farm
    SelectedMobs = {},
    SelectedBosses = {},
    SelectedSummon = nil,
    SelectedSummonDiff = "Normal",
    SelectedOtherSummon = nil,
    SelectedOtherSummonDiff = "Normal",
    SelectedBuildPity = {},
    SelectedUsePity = nil,
    SelectedPityDiff = "Normal",
    SelectedAltBoss = nil,
    SelectedAltDiff = "Normal",
    SelectedAlts = {},

    SelectedDioDiff    = "Normal",
SelectedDungeonType = "BossRush",
SelectedDungeonDiff = "Easy",
SelectedTowerDiff   = "Easy",
TowerResetFloor     = 50,
    
    -- Combat
    SelectedWeaponType = {Melee = true},
    SelectedSkills = {Z = true, X = true, C = true, V = true},
    ComboPattern = "Z>X>C>V>F",
    M1Speed = 0.2,
    KillAuraRange = 200,
    KillAuraCD = 0.12,
    InstaKillHP = 90,
    InstaKillMinHP = 100000,
    
    -- Farm Config
    FarmDistance = 12,
    FarmType = "Behind",
    MovementType = "Teleport",
    TweenSpeed = 160,
    IslandTPCD = 0.8,
    TargetTPCD = 0,
    WeaponSwitchCD = 4,
    
    -- Stats
    SelectedStats = {},
    SelectedGemStats = {},
    SelectedRanks = {},
    StatRollCD = 0.1,
    
    -- Rolls
    SelectedTraits = {},
    SelectedRaces = {},
    SelectedClans = {},
    RollCD = 0.3,
    
    -- Enchant
    SelectedEnchant = {},
    SelectedBlessing = {},
    SelectedPassive = {},
    SelectedSpec = {},
    SpecRollCD = 0.1,
    
    -- Switch
    DefaultTitle = "None",
    Title_Mob = "",
    Title_Boss = "",
    Title_BossHP = "",
    Title_BossHPAmt = 15,
    Title_Combo = "",
    DefaultRune = "None",
    Rune_Mob = "",
    Rune_Boss = "",
    Rune_BossHP = "",
    Rune_BossHPAmt = 15,
    Rune_Combo = "",
    DefaultBuild = "None",
    Build_Mob = "",
    Build_Boss = "",
    Build_BossHP = "",
    Build_BossHPAmt = 15,
    
    -- Misc
    SelectedChests = {},
    SelectedCraftItems = {},
    SelectedMerchantItems = {},
    SelectedDungeon = nil,
    SelectedQuestline = nil,
    
    -- Artifact
    UpgradeLimit = 12,
    Lock_Type = {},
    Lock_Set = {},
    Lock_MS = {},
    Lock_SS = {},
    Lock_MinSS = 0,
    Del_Type = {},
    Del_Set = {},
    Del_MS = {},
    Del_SS = {},
    Del_MinSS = 0,
    Up_MS = {},
    Eq_Type = {},
    Eq_MS = {},
    Eq_SS = {},
    
    -- Trade
    SelectedTradePlr = nil,
    SelectedTradeItems = {},
    
    -- Player
    WalkSpeedVal = 16,
    JumpPowerVal = 50,
    
    -- Webhook
    WebhookURL = "",
    WebhookUID = "",
    WebhookDelay = 5,
    SelectedWebhookData = {},
    SelectedItemRarity = {},
    
    -- Safety
    SelectedKickTypes = {},
}

-- ════════════════════════════════════════════════════════════
-- THREAD MANAGER
-- ════════════════════════════════════════════════════════════
local Threads = {}

local function Thread(key, func, enabled, ...)
    if enabled then
        if not Threads[key] or coroutine.status(Threads[key]) == "dead" then
            Threads[key] = task.spawn(func, ...)
        end
    else
        if Threads[key] and typeof(Threads[key]) == "thread" then
            task.cancel(Threads[key])
            Threads[key] = nil
        end
    end
end

local function StopAllThreads()
    for key, thread in pairs(Threads) do
        if typeof(thread) == "thread" then
            pcall(task.cancel, thread)
        end
    end
    table.clear(Threads)
end

-- ════════════════════════════════════════════════════════════
-- ISLAND CRYSTALS
-- ════════════════════════════════════════════════════════════
local IslandCrystals = {}

local function UpdateIslandCrystals()
    IslandCrystals = {
        Starter = workspace:FindFirstChild("StarterIsland") and workspace.StarterIsland:FindFirstChild("SpawnPointCrystal_Starter"),
        Jungle = workspace:FindFirstChild("JungleIsland") and workspace.JungleIsland:FindFirstChild("SpawnPointCrystal_Jungle"),
        Desert = workspace:FindFirstChild("DesertIsland") and workspace.DesertIsland:FindFirstChild("SpawnPointCrystal_Desert"),
        Snow = workspace:FindFirstChild("SnowIsland") and workspace.SnowIsland:FindFirstChild("SpawnPointCrystal_Snow"),
        Sailor = workspace:FindFirstChild("SailorIsland") and workspace.SailorIsland:FindFirstChild("SpawnPointCrystal_Sailor"),
        Shibuya = workspace:FindFirstChild("ShibuyaStation") and workspace.ShibuyaStation:FindFirstChild("SpawnPointCrystal_Shibuya"),
        HuecoMundo = workspace:FindFirstChild("HuecoMundo") and workspace.HuecoMundo:FindFirstChild("SpawnPointCrystal_HuecoMundo"),
        Boss = workspace:FindFirstChild("BossIsland") and workspace.BossIsland:FindFirstChild("SpawnPointCrystal_Boss"),
        Dungeon = workspace:FindFirstChild("Main Temple") and workspace["Main Temple"]:FindFirstChild("SpawnPointCrystal_Dungeon"),
        Shinjuku = workspace:FindFirstChild("ShinjukuIsland") and workspace.ShinjukuIsland:FindFirstChild("SpawnPointCrystal_Shinjuku"),
        Valentine = workspace:FindFirstChild("ValentineIsland") and workspace.ValentineIsland:FindFirstChild("SpawnPointCrystal_Valentine"),
        Slime = workspace:FindFirstChild("SlimeIsland") and workspace.SlimeIsland:FindFirstChild("SpawnPointCrystal_Slime"),
        Academy = workspace:FindFirstChild("AcademyIsland") and workspace.AcademyIsland:FindFirstChild("SpawnPointCrystal_Academy"),
        Judgement = workspace:FindFirstChild("JudgementIsland") and workspace.JudgementIsland:FindFirstChild("SpawnPointCrystal_Judgement"),
        SoulSociety = workspace:FindFirstChild("SoulSocietyIsland") and workspace.SoulSocietyIsland:FindFirstChild("SpawnPointCrystal_SoulSociety"),
    }
end
UpdateIslandCrystals()

-- ════════════════════════════════════════════════════════════
-- BUILD DATA TABLES
-- ════════════════════════════════════════════════════════════

-- Build Boss Lists
if Modules.TimedConfig and Modules.TimedConfig.Bosses then
    for internalName, data in pairs(Modules.TimedConfig.Bosses) do
        table.insert(Tables.BossList, data.displayName)
        local tpName = data.spawnLocation:gsub(" Island", ""):gsub(" Station", "")
        if data.spawnLocation == "Hueco Mundo Island" then tpName = "HuecoMundo" end
        if data.spawnLocation == "Judgement Island" then tpName = "Judgement" end
        BossToIslandMap[data.displayName] = tpName
    end
    table.sort(Tables.BossList)
end

-- Build All Boss List
for bossName, _ in pairs(Modules.BossConfig.Bosses) do
    local clean = bossName:gsub("Boss$", "")
    table.insert(Tables.AllBossList, clean)
end
table.sort(Tables.AllBossList)

-- Build Summon List
if Modules.SummonConfig and Modules.SummonConfig.Bosses then
    for internalId, data in pairs(Modules.SummonConfig.Bosses) do
        table.insert(Tables.SummonList, data.displayName)
        SummonMap[data.displayName] = data.bossId
    end
    table.sort(Tables.SummonList)
end

-- Build Merchant List
for itemName in pairs(Modules.Merchant.ITEMS) do
    table.insert(Tables.MerchantList, itemName)
end

-- Build Trait List
for name, data in pairs(Modules.Trait.Traits) do
    table.insert(Tables.TraitList, name)
end
table.sort(Tables.TraitList)

-- Build Race List
for name, _ in pairs(Modules.Race.Races) do
    table.insert(Tables.RaceList, name)
end
table.sort(Tables.RaceList)

-- Build Clan List
for name, _ in pairs(Modules.Clan.Clans) do
    table.insert(Tables.ClanList, name)
end
table.sort(Tables.ClanList)

-- Build Spec Passive List
if Modules.SpecPassive and Modules.SpecPassive.Passives then
    for name, _ in pairs(Modules.SpecPassive.Passives) do
        table.insert(Tables.SpecPassiveList, name)
    end
    table.sort(Tables.SpecPassiveList)
end

-- Build Gem Stats List
Tables.GemStatList = Modules.Stats.StatKeys or {}
Tables.GemRankList = Modules.Stats.RankOrder or {}

-- Build NPC List
for _, v in pairs(ServiceNPCs:GetChildren()) do
    table.insert(Tables.NPCList, v.Name)
end
table.sort(Tables.NPCList)

-- ════════════════════════════════════════════════════════════
-- CORE FUNCTIONS
-- ════════════════════════════════════════════════════════════
local function GetCharacter()
    local c = Player.Character
    return (c and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChildOfClass("Humanoid")) and c or nil
end

local function IsValidTarget(npc)
    if not npc or not npc.Parent then return false end
    local hum = npc:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    
    if npc:FindFirstChild("IK_Active") then return true end
    
    local minMaxHP = Options.InstaKillMinHP
    local isEligible = Toggles.InstaKill and hum.MaxHealth >= minMaxHP
    
    if isEligible then
        return (hum.Health > 0) or (npc == State.Target)
    else
        return (hum.Health > 0)
    end
end

local function GetNearestIsland(pos, npcName)
    if npcName and BossToIslandMap[npcName] then
        return BossToIslandMap[npcName]
    end
    
    local nearest = "Starter"
    local minDist = math.huge
    
    for islandName, crystal in pairs(IslandCrystals) do
        if crystal then
            local dist = (pos - crystal:GetPivot().Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = islandName
            end
        end
    end
    
    return nearest
end

local function BossMatch(npcName, targetName)
    local n = npcName:lower():gsub("%s+", "")
    local t = targetName:lower():gsub("%s+", "")
    
    if n:find("true") and not t:find("true") then return false end
    
    if t:find("strongest") then
        local era = t:find("history") and "history" or "today"
        return n:find("strongest") and n:find(era)
    end
    
    return n:find(t)
end

local function UpdateMobList()
    table.clear(Tables.MobList)
    local seen = {}
    
    for _, v in pairs(NPCsFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") then
            local cleanName = v.Name:gsub("%d+$", "")
            local isMiniBoss = table.find(Tables.MiniBossList, cleanName)
            
            if (isMiniBoss or not cleanName:find("Boss")) and not seen[cleanName] then
                table.insert(Tables.MobList, cleanName)
                seen[cleanName] = true
                
                local npcPos = v:GetPivot().Position
                Tables.MobToIsland[cleanName] = GetNearestIsland(npcPos)
            end
        end
    end
    
    table.sort(Tables.MobList)
end

local function Clean(str)
    if not str then return "" end
    return str:lower():gsub("%s+", "")
end

local function GetToolType(toolName)
    if not toolName then return "Melee" end
    
    local manualMap = {
        ["Invisible"] = "Power",
        ["Bomb"] = "Power",
        ["Quake"] = "Power",
    }
    
    local cleanName = toolName:lower():gsub("%s+", "")
    
    for name, toolType in pairs(manualMap) do
        if cleanName == name:lower():gsub("%s+", "") then
            return toolType
        end
    end
    
    if Modules.WeaponClass and Modules.WeaponClass.Tools then
        for name, toolType in pairs(Modules.WeaponClass.Tools) do
            if cleanName == name:lower():gsub("%s+", "") then
                return toolType
            end
        end
    end
    
    if toolName:lower():find("fruit") then return "Power" end
    if toolName:lower():find("sword") or toolName:lower():find("blade") or toolName:lower():find("katana") then return "Sword" end
    
    return "Melee"
end

function GetToolTypeFromModule(toolName)
    local cleaned = Clean(toolName)
    for mName, toolType in pairs(Tables.ManualWeaponClass) do
        if Clean(mName) == cleaned then return toolType end
    end
    if Modules.WeaponClass and Modules.WeaponClass.Tools then
        for mName, toolType in pairs(Modules.WeaponClass.Tools) do
            if Clean(mName) == cleaned then return toolType end
        end
    end
    if toolName:lower():find('fruit') then return 'Power' end
    return 'Melee'
end

function GetWeaponsByType()
    local available = {}
    local enabledTypes = Options.SelectedWeaponType or {}
    local char = Player.Character
    local backpack = Player:FindFirstChild("Backpack")
    
    local containers = {}
    if backpack then table.insert(containers, backpack) end
    if char then table.insert(containers, char) end
    if #containers == 0 then return available end
    
    for _, container in ipairs(containers) do
        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") then
                local toolType = GetToolTypeFromModule(tool.Name)
                if enabledTypes[toolType] and not table.find(available, tool.Name) then
                    table.insert(available, tool.Name)
                end
            end
        end
    end
    return available
end

function UpdateWeaponRotation()
    local list = GetWeaponsByType()
    if #list == 0 then State.ActiveWeap = ""; return end
    if #list == 1 then
        State.ActiveWeap = list[1]
        State.WeapRotationIdx = 1
        return
    end
    if State.WeapRotationIdx > #list then State.WeapRotationIdx = 1 end
    local exists = false
    for _, n in ipairs(list) do
        if n == State.ActiveWeap then exists = true; break end
    end
    if not exists then
        State.WeapRotationIdx = 1
        State.ActiveWeap = list[1]
        State.LastWRSwitch = tick()
        return
    end
    local delay = Options.SwitchWeaponCD or 4
    if tick() - State.LastWRSwitch >= delay then
        State.WeapRotationIdx = State.WeapRotationIdx + 1
        if State.WeapRotationIdx > #list then State.WeapRotationIdx = 1 end
        State.ActiveWeap = list[State.WeapRotationIdx]
        State.LastWRSwitch = tick()
    end
end

function EquipWeapon()
    UpdateWeaponRotation()
    if not State.ActiveWeap or State.ActiveWeap == "" then return end
    
    local char = Player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    
    -- Already equipped
    if char:FindFirstChild(State.ActiveWeap) then return end
    
    local backpack = Player:FindFirstChild("Backpack")
    if not backpack then return end
    local tool = backpack:FindFirstChild(State.ActiveWeap)
    if not tool then
        -- Tool not found, reset so rotation picks a new one
        State.ActiveWeap = ""
        State.WeapRotationIdx = 1
        return
    end
    
    local current = char:FindFirstChildOfClass("Tool")
    if current then
        pcall(function() hum:UnequipTools() end)
        task.wait(0.05)
    end
    
    local attempts = 0
    repeat
        pcall(function() hum:EquipTool(tool) end)
        task.wait(0.06)
        attempts += 1
    until char:FindFirstChild(State.ActiveWeap) or attempts >= 8
end

-- Auto Equip Weapon Loop
local function AutoEquipWeaponLoop()
    while Toggles.AutoEquipWeapon do
        task.wait(0.5)
        local char = GetCharacter()
        if not char then continue end
        -- Check if desired weapon is already equipped
        local alreadyEquipped = false
        local list = GetWeaponsByType()
        for _, name in ipairs(list) do
            if char:FindFirstChild(name) then
                alreadyEquipped = true
                State.ActiveWeap = name
                break
            end
        end
        if not alreadyEquipped then
            EquipWeapon()
        end
    end
end

local function CheckObsHaki()
    local dodgeUI = PlayerGui:FindFirstChild("DodgeCounterUI")
    if dodgeUI and dodgeUI:FindFirstChild("MainFrame") then
        return dodgeUI.MainFrame.Visible
    end
    return false
end

local function CheckArmHaki()
    if State.ArmHakiOn then return true end
    
    local char = GetCharacter()
    if char then
        local leftArm = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm")
        local rightArm = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
        
        local hasVisual = (leftArm and leftArm:FindFirstChild("Lightning Strike")) or
                          (rightArm and rightArm:FindFirstChild("Lightning Strike"))
        
        if hasVisual then
            State.ArmHakiOn = true
            return true
        end
    end
    
    return false
end

local function GetCurrentPity()
    local pityLabel = PlayerGui:FindFirstChild("BossUI") and 
                      PlayerGui.BossUI:FindFirstChild("MainFrame") and
                      PlayerGui.BossUI.MainFrame:FindFirstChild("BossHPBar") and
                      PlayerGui.BossUI.MainFrame.BossHPBar:FindFirstChild("Pity")
    
    if pityLabel then
        local current, max = pityLabel.Text:match("Pity: (%d+)/(%d+)")
        return tonumber(current) or 0, tonumber(max) or 25
    end
    
    return 0, 25
end

local function GetBestQuestNPC()
    local playerLevel = Player.Data.Level.Value
    local bestNPC = "QuestNPC1"
    local highestLevel = -1
    
    for npcId, questData in pairs(Modules.Quests.RepeatableQuests) do
        local reqLevel = questData.recommendedLevel or 0
        if playerLevel >= reqLevel and reqLevel > highestLevel then
            highestLevel = reqLevel
            bestNPC = npcId
        end
    end
    
    return bestNPC
end

-- ════════════════════════════════════════════════════════════
-- FIRE BOSS REMOTE
-- ════════════════════════════════════════════════════════════
local function FireBossRemote(bossName, diff)
    local lowerName = bossName:lower():gsub("%s+", "")
    
    table.clear(State.AltDamage)
    
    local function GetInternalSummonId(name)
        local cleanTarget = name:lower():gsub("%s+", "")
        for displayName, internalId in pairs(SummonMap) do
            if displayName:lower():gsub("%s+", "") == cleanTarget then
                return internalId
            end
        end
        return name:gsub("%s+", "") .. "Boss"
    end
    
    pcall(function()
        if lowerName:find("rimuru") then
            Fire(Remotes.RimuruBoss, diff)
        elseif lowerName:find("anos") then
            Fire(Remotes.AnosBoss, "Anos", diff)
        elseif lowerName:find("trueaizen") then
            Fire(Remotes.TrueAizen, diff)
        elseif lowerName:find("strongest") then
            local era = lowerName:find("history") and "StrongestHistory" or "StrongestToday"
            Fire(Remotes.JJKSummon, era, diff)
        else
            local summonId = GetInternalSummonId(bossName)
            Fire(Remotes.SummonBoss, summonId, diff)
        end
    end)
end

-- ════════════════════════════════════════════════════════════
-- TARGET FINDERS
-- ════════════════════════════════════════════════════════════
local function GetBestMobCluster(mobNamesDictionary)
    local allMobs = {}
    local clusterRadius = 35
    
    if type(mobNamesDictionary) ~= "table" then return nil end
    
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            local cleanName = npc.Name:gsub("%d+$", "")
            if mobNamesDictionary[cleanName] and IsValidTarget(npc) then
                table.insert(allMobs, npc)
            end
        end
    end
    
    if #allMobs == 0 then return nil end
    
    local bestMob = allMobs[1]
    local maxNearby = 0
    
    for _, mobA in ipairs(allMobs) do
        local nearbyCount = 0
        local posA = mobA:GetPivot().Position
        
        for _, mobB in ipairs(allMobs) do
            if (posA - mobB:GetPivot().Position).Magnitude <= clusterRadius then
                nearbyCount = nearbyCount + 1
            end
        end
        
        if nearbyCount > maxNearby then
            maxNearby = nearbyCount
            bestMob = mobA
        end
    end
    
    return bestMob, maxNearby
end

local function GetMobTarget()
    if not Toggles.MobFarm then
        State.MobIdx = 1
        return nil
    end
    
    local enabledMobs = {}
    for mob, enabled in pairs(Options.SelectedMobs) do
        if enabled then table.insert(enabledMobs, mob) end
    end
    table.sort(enabledMobs)
    
    if #enabledMobs == 0 then return nil end
    
    if State.MobIdx > #enabledMobs then State.MobIdx = 1 end
    
    local targetMobName = enabledMobs[State.MobIdx]
    local target, count = GetBestMobCluster({[targetMobName] = true})
    
    if target then
        local island = GetNearestIsland(target:GetPivot().Position, target.Name)
        return target, island, "Mob"
    else
        State.MobIdx = State.MobIdx + 1
        return nil
    end
end

local function GetAllMobTarget()
    if not Toggles.AllMobFarm then
        State.AllMobIdx = 1
        return nil
    end
    
    local rotateList = {}
    for _, mobName in ipairs(Tables.MobList) do
        if mobName ~= "TrainingDummy" then
            table.insert(rotateList, mobName)
        end
    end
    
    if #rotateList == 0 then return nil end
    
    if State.AllMobIdx > #rotateList then State.AllMobIdx = 1 end
    
    local targetMobName = rotateList[State.AllMobIdx]
    local target, count = GetBestMobCluster({[targetMobName] = true})
    
    if target then
        local island = GetNearestIsland(target:GetPivot().Position, target.Name)
        return target, island, "Mob"
    else
        State.AllMobIdx = State.AllMobIdx + 1
        if State.AllMobIdx > #rotateList then State.AllMobIdx = 1 end
        return nil
    end
end

local function GetLevelFarmTarget()
    if not Toggles.LevelFarm then return nil end
    
    -- Update quest
    local targetNPC = GetBestQuestNPC()
    local questUI = PlayerGui:FindFirstChild("QuestUI") and PlayerGui.QuestUI:FindFirstChild("Quest")
    
    if State.QuestNPC ~= targetNPC or (questUI and not questUI.Visible) then
        Fire(Remotes.QuestAbandon, "repeatable")
        task.wait(0.5)
        Fire(Remotes.QuestAccept, targetNPC)
        task.wait(1)
        if questUI and questUI.Visible then
            State.QuestNPC = targetNPC
        end
    end
    
    if not questUI or not questUI.Visible then return nil end
    
    local questData = Modules.Quests.RepeatableQuests[State.QuestNPC]
    if not questData or not questData.requirements or not questData.requirements[1] then return nil end
    
    local targetMobType = questData.requirements[1].npcType
    local matches = {}
    
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            local cleanName = npc.Name:gsub("%d+$", ""):lower()
            if cleanName == targetMobType:lower() or cleanName:find(targetMobType:lower()) then
                matches[npc.Name:gsub("%d+$", "")] = true
            end
        end
    end
    
    local bestMob, count = GetBestMobCluster(matches)
    
    if bestMob then
        local island = GetNearestIsland(bestMob:GetPivot().Position, bestMob.Name)
        return bestMob, island, "Mob"
    end
    
    return nil
end

local function GetWorldBossTarget()
    if Toggles.AllBossFarm then
        for _, npc in pairs(NPCsFolder:GetChildren()) do
            local name = npc.Name
            if name:find("Boss") and not table.find(Tables.MiniBossList, name) then
                if IsValidTarget(npc) then
                    local island = "Boss"
                    for dName, iName in pairs(BossToIslandMap) do
                        if BossMatch(name, dName) then
                            island = iName
                            break
                        end
                    end
                    return npc, island, "Boss"
                end
            end
        end
    end
    
    if Toggles.BossFarm then
        for bossDisplayName, isEnabled in pairs(Options.SelectedBosses) do
            if isEnabled then
                for _, npc in pairs(NPCsFolder:GetChildren()) do
                    if BossMatch(npc.Name, bossDisplayName) and not table.find(Tables.MiniBossList, npc.Name) then
                        if IsValidTarget(npc) then
                            local island = BossToIslandMap[bossDisplayName] or "Boss"
                            return npc, island, "Boss"
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

local function GetSummonTarget()
    if not Toggles.SummonFarm then return nil end
    local selected = Options.SelectedSummon
    if not selected then return nil end
    
    local workspaceName = SummonMap[selected] or (selected .. "Boss")
    
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc.Name:lower():find(workspaceName:lower()) then
            if IsValidTarget(npc) then
                return npc, "Boss", "Boss"
            end
        end
    end
    
    return nil
end

local function GetOtherSummonTarget()
    if not Toggles.OtherSummonFarm then return nil end
    local selected = Options.SelectedOtherSummon
    if not selected then return nil end
    
    local lowerSelected = selected:lower()
    
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        local name = npc.Name:lower()
        local isMatch = false
        
        if lowerSelected:find("strongest") then
            if name:find("strongest") and (
                (lowerSelected:find("history") and name:find("history")) or
                (lowerSelected:find("today") and name:find("today"))
            ) then
                isMatch = true
            end
        elseif name:find(lowerSelected) then
            isMatch = true
        end
        
        if isMatch and IsValidTarget(npc) then
            local island = GetNearestIsland(npc:GetPivot().Position, npc.Name)
            return npc, island, "Boss"
        end
    end
    
    return nil
end

local function GetPityTarget()
    if not Toggles.PityBossFarm then return nil end
    
    local current, max = GetCurrentPity()
    local buildBosses = Options.SelectedBuildPity
    local useName = Options.SelectedUsePity
    if not useName then return nil end
    
    local isUseTurn = (current >= (max - 1))
    
    if isUseTurn then
        for _, npc in pairs(NPCsFolder:GetChildren()) do
            if BossMatch(npc.Name, useName) and IsValidTarget(npc) then
                local island = BossToIslandMap[useName] or "Boss"
                return npc, island, "Boss"
            end
        end
    else
        for bossName, enabled in pairs(buildBosses) do
            if enabled then
                for _, npc in pairs(NPCsFolder:GetChildren()) do
                    if BossMatch(npc.Name, bossName) and IsValidTarget(npc) then
                        local island = BossToIslandMap[bossName] or "Boss"
                        return npc, island, "Boss"
                    end
                end
            end
        end
    end
    
    return nil
end

local function GetAltHelpTarget()
    if not Toggles.AltBossFarm then return nil end
    
    local targetBossName = Options.SelectedAltBoss
    if not targetBossName then return nil end
    
    local targetNPC = nil
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if BossMatch(npc.Name, targetBossName) then
            if IsValidTarget(npc) then
                targetNPC = npc
                break
            end
        end
    end
    
    if not targetNPC then
        FireBossRemote(targetBossName, Options.SelectedAltDiff)
        task.wait(0.5)
        return nil
    end
    
    -- Check if alts have enough damage
    local shouldWait = false
    for i = 1, 5 do
        local altName = Options.SelectedAlts[i]
        if altName and altName ~= "" then
            local currentDmg = State.AltDamage[altName] or 0
            if currentDmg < 10 then
                shouldWait = true
                break
            end
        end
    end
    
    State.AltActive = shouldWait
    
    local island = BossToIslandMap[targetBossName] or "Boss"
    return targetNPC, island, "Boss"
end

-- ════════════════════════════════════════════════════════════
-- HANDLE SUMMONS
-- ════════════════════════════════════════════════════════════
local function HandleSummons()
    if State.MerchantBusy then return end
    
    local function MatchName(name1, name2)
        if not name1 or not name2 then return false end
        return name1:lower():gsub("%s+", "") == name2:lower():gsub("%s+", "")
    end
    
    local function IsSummonable(name)
        local cleanName = name:lower():gsub("%s+", "")
        for _, boss in ipairs(Tables.SummonList) do
            if MatchName(boss, cleanName) then return true end
        end
        for _, boss in ipairs(Tables.OtherSummonList) do
            if MatchName(boss, cleanName) then return true end
        end
        return false
    end
    
    -- Pity Boss
    if Toggles.PityBossFarm then
        local current, max = GetCurrentPity()
        local buildOptions = Options.SelectedBuildPity
        local useName = Options.SelectedUsePity
        
        if useName and next(buildOptions) then
            local isUseTurn = (current >= (max - 1))
            
            if isUseTurn then
                local found = false
                for _, v in pairs(NPCsFolder:GetChildren()) do
                    if MatchName(v.Name, useName) or v.Name:lower():find(useName:lower():gsub("%s+", "")) then
                        found = true break
                    end
                end
                
                if not found and IsSummonable(useName) then
                    FireBossRemote(useName, Options.SelectedPityDiff)
                    task.wait(0.5)
                    return
                end
            else
                local anyBuildBossSpawned = false
                for bossName, enabled in pairs(buildOptions) do
                    if enabled then
                        for _, v in pairs(NPCsFolder:GetChildren()) do
                            if MatchName(v.Name, bossName) or v.Name:lower():find(bossName:lower():gsub("%s+", "")) then
                                anyBuildBossSpawned = true
                                break
                            end
                        end
                    end
                    if anyBuildBossSpawned then break end
                end
                
                if not anyBuildBossSpawned then
                    for bossName, enabled in pairs(buildOptions) do
                        if enabled and IsSummonable(bossName) then
                            FireBossRemote(bossName, "Normal")
                            task.wait(0.5)
                            return
                        end
                    end
                end
            end
        end
    end
    
    -- Other Summon
    if Toggles.AutoOtherSummon then
        local selected = Options.SelectedOtherSummon
        local diff = Options.SelectedOtherSummonDiff
        
        if selected and diff then
            local keyword = selected:gsub("Strongest", ""):lower()
            
            local found = false
            for _, v in pairs(NPCsFolder:GetChildren()) do
                local npcName = v.Name:lower()
                if npcName:find(selected:lower()) or (npcName:find("strongest") and npcName:find(keyword)) then
                    found = true break
                end
            end
            
            if not found then
                FireBossRemote(selected, diff)
                task.wait(0.5)
            end
        end
    end
    
    -- Regular Summon
    if Toggles.AutoSummon then
        local selected = Options.SelectedSummon
        if selected then
            local found = false
            for _, v in pairs(NPCsFolder:GetChildren()) do
                if BossMatch(v.Name, selected) then
                    found = true break
                end
            end
            
            if not found then
                FireBossRemote(selected, Options.SelectedSummonDiff)
                task.wait(0.5)
            end
        end
    end
end

-- ════════════════════════════════════════════════════════════
-- EXECUTE FARM LOGIC
-- ════════════════════════════════════════════════════════════
local function ExecuteFarmLogic(target, island, farmType)
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not target or State.Recovering or not root then return end
    if State.MovingIsland then return end
    
    State.Target = target
    
    if Toggles.AltBossFarm and farmType == "Boss" then
        -- Check alt damage
        local shouldWait = false
        for i = 1, 5 do
            local altName = Options.SelectedAlts[i]
            if altName and altName ~= "" then
                local currentDmg = State.AltDamage[altName] or 0
                if currentDmg < 10 then
                    shouldWait = true
                    break
                end
            end
        end
        State.AltActive = shouldWait
    else
        State.AltActive = false
    end
    
    -- Island TP
    if Toggles.IslandTP then
        if island and island ~= "" and island ~= "Unknown" and island ~= State.Island then
            State.MovingIsland = true
            Fire(Remotes.TP_Portal, island)
            task.wait(Options.IslandTPCD)
            State.Island = island
            State.MovingIsland = false
            return
        end
    end
    
    local targetPivot = target:GetPivot()
    local targetPos = targetPivot.Position
    local distVal = Options.FarmDistance
    local posType = Options.FarmType
    
    local finalPos
    local ikTag = target:FindFirstChild("IK_Active")
    
    if ikTag and Toggles.InstaKill then
        local startTime = ikTag:GetAttribute("TriggerTime") or 0
        if tick() - startTime >= 3 then
            root.CFrame = CFrame.new(targetPos + Vector3.new(0, 300, 0))
            root.AssemblyLinearVelocity = Vector3.zero
            return
        end
    end
    
    if State.AltActive then
        finalPos = targetPos + Vector3.new(0, 120, 0)
    elseif posType == "Above" then
        finalPos = targetPos + Vector3.new(0, distVal, 0)
    elseif posType == "Below" then
        finalPos = targetPos + Vector3.new(0, -distVal, 0)
    else
        finalPos = (targetPivot * CFrame.new(0, 0, distVal)).Position
    end
    
    local finalDestination = CFrame.lookAt(finalPos, targetPos)
    
    if (root.Position - finalPos).Magnitude > 0.1 then
        if Options.MovementType == "Teleport" then
            root.CFrame = finalDestination
        else
            local distance = (root.Position - finalPos).Magnitude
            local speed = Options.TweenSpeed
            TweenService:Create(root, TweenInfo.new(distance/speed, Enum.EasingStyle.Linear), {CFrame = finalDestination}):Play()
        end
    end
    
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end

-- ════════════════════════════════════════════════════════════
-- LOOP FUNCTIONS
-- ════════════════════════════════════════════════════════════

-- Main Farm Loop
local function FarmLoop()
    while State.Running do
        task.wait()
        
        if not State.Farm or State.MerchantBusy then
            State.Target = nil
           -- continue
        end
        
        local char = GetCharacter()
        if not char or State.Recovering then --continue 
        end
        
        HandleSummons()
        
        local currentPity, maxPity = GetCurrentPity()
        local isPityReady = Toggles.PityBossFarm and currentPity >= (maxPity - 1)
        
        local foundTask = false
        local target, island, farmType
        
        -- Priority Order
        local priorities = {
            {check = "PityBoss", fn = GetPityTarget, cond = isPityReady},
            {check = "Boss", fn = GetWorldBossTarget, cond = not isPityReady},
            {check = "Summon", fn = GetSummonTarget, cond = true},
            {check = "OtherSummon", fn = GetOtherSummonTarget, cond = true},
            {check = "AltHelp", fn = GetAltHelpTarget, cond = true},
            {check = "LevelFarm", fn = GetLevelFarmTarget, cond = not isPityReady},
            {check = "AllMob", fn = GetAllMobTarget, cond = not isPityReady},
            {check = "Mob", fn = GetMobTarget, cond = not isPityReady},
        }
        
        for _, p in ipairs(priorities) do
            if p.cond then
                target, island, farmType = p.fn()
                if target then
                    foundTask = true
                    break
                end
            end
        end
        
        if foundTask and target then
            State.Target = target
            ExecuteFarmLogic(target, island, farmType)
        else
            State.Target = nil
        end
    end
end

-- Combat Loop
local function CombatLoop()
    while State.Running do
        task.wait()
        
        if State.AltActive then continue end
        if not State.Farm or State.MerchantBusy then continue end
        
        local char = GetCharacter()
        if not char then continue end
        
        local target = State.Target
        if not target or not target.Parent then continue end
        
        local npcHum = target:FindFirstChildOfClass("Humanoid")
        local npcRoot = target:FindFirstChild("HumanoidRootPart")
        local root = char:FindFirstChild("HumanoidRootPart")
        
        if not npcHum or not npcRoot or not root then continue end
        if npcHum.Health <= 0 then continue end
        
        local currentDist = (root.Position - npcRoot.Position).Magnitude
        local hpPercent = (npcHum.Health / npcHum.MaxHealth) * 100
        local minMaxHP = Options.InstaKillMinHP
        local ikThreshold = Options.InstaKillHP
        
        -- Insta Kill
        if Toggles.InstaKill and npcHum.MaxHealth >= minMaxHP and hpPercent < ikThreshold then
            pcall(function() npcHum.Health = 0 end)
            if not target:FindFirstChild("IK_Active") then
                local tag = Instance.new("Folder")
                tag.Name = "IK_Active"
                tag:SetAttribute("TriggerTime", tick())
                tag.Parent = target
            end
        end
        
        -- Attack
        if currentDist < 35 then
            if math.abs(root.Position.Y - npcRoot.Position.Y) > 50 then
                pcall(function() root.Velocity = Vector3.new(0, -100, 0) end)
            end
            
            local m1Delay = Options.M1Speed or 0.2
            if tick() - State.LastM1 >= m1Delay then
                pcall(function() EquipWeapon() end)
                Fire(Remotes.M1)
                State.LastM1 = tick()
            end
        end
    end
end

-- Auto M1 Loop
local function AutoM1Loop()
    while Toggles.AutoM1 do
        task.wait(Options.M1Speed)
        Fire(Remotes.M1)
    end
end

-- Kill Aura Loop
local function KillAuraLoop()
    while Toggles.KillAura do
        task.wait(Options.KillAuraCD)
        
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then --continue 
        end
        
        local best, bestDist = nil, Options.KillAuraRange
        
        for _, npc in pairs(NPCsFolder:GetChildren()) do
            if npc:IsA("Model") then
                local hum = npc:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local dist = (root.Position - npc:GetPivot().Position).Magnitude
                    if dist < bestDist then
                        bestDist = dist
                        best = npc
                    end
                end
            end
        end
        
        if best then
            EquipWeapon()
            Fire(Remotes.M1, best:GetPivot().Position)
        end
    end
end

-- Auto Skill Loop
local keyToSlot = {Z = 1, X = 2, C = 3, V = 4, F = 5}
local keyToEnum = {Z = Enum.KeyCode.Z, X = Enum.KeyCode.X, C = Enum.KeyCode.C, V = Enum.KeyCode.V, F = Enum.KeyCode.F}

local function AutoSkillLoop()
    while Toggles.AutoSkill do
        task.wait(0.1)
        
        if Toggles.OnlyTarget and (not State.Farm or not State.Target or not State.Target.Parent) then
           -- continue
        end
        
        local char = GetCharacter()
        local tool = char and char:FindFirstChildOfClass("Tool")
        if not tool then --continue 
        end
        
        local toolType = GetToolType(tool.Name)
        
        for _, key in ipairs(Tables.SkillKeys) do
            if Options.SelectedSkills[key] then
                if toolType == "Power" then
                    Fire(Remotes.UseFruit, "UseAbility", {
                        FruitPower = tool.Name:gsub(" Fruit", ""),
                        KeyCode = keyToEnum[key]
                    })
                else
                    Fire(Remotes.UseSkill, keyToSlot[key])
                end
                task.wait(0.05)
            end
        end
    end
end

-- Auto Haki Loop
local function AutoHakiLoop()
    while Toggles.AutoArmHaki or Toggles.AutoObsHaki or Toggles.AutoConqHaki do
        task.wait(0.5)
        
        if Toggles.AutoObsHaki and not CheckObsHaki() then
            Fire(Remotes.ObsHaki, "Toggle")
        end
        
        if Toggles.AutoArmHaki and not CheckArmHaki() then
            Fire(Remotes.ArmHaki, "Toggle")
            task.wait(0.5)
        end
        
        if Toggles.AutoConqHaki then
            if Toggles.OnlyTarget then
                if State.Farm and State.Target and State.Target.Parent then
                    Fire(Remotes.ConqHaki, "Activate")
                end
            else
                Fire(Remotes.ConqHaki, "Activate")
            end
        end
    end
end

-- Auto Stats Loop
local function AutoStatsLoop()
    while Toggles.AutoStats do
        task.wait(1)
        
        local pts = Player.Data.StatPoints.Value
        if pts > 0 then
            local active = {}
            for stat, on in pairs(Options.SelectedStats) do
                if on then table.insert(active, stat) end
            end
            
            if #active > 0 then
                local each = math.floor(pts / #active)
                if each > 0 then
                    for _, s in ipairs(active) do
                        Fire(Remotes.AddStat, s, each)
                    end
                end
            end
        end
    end
end

-- Auto Roll Stats Loop
local function AutoRollStatsLoop()
    while Toggles.AutoRollStats do
        task.wait(Options.StatRollCD)
        
        local done = true
        for stat, on in pairs(Options.SelectedGemStats) do
            if on then
                local cur = State.GemStats[stat]
                if cur and not Options.SelectedRanks[cur.Rank] then
                    done = false
                    Invoke(Remotes.RerollStat, stat)
                    task.wait(Options.StatRollCD)
                    break
                end
            end
        end
        
        if done then
            Toggles.AutoRollStats = false
            break
        end
    end
end

-- Auto Trait Loop
local function AutoTraitLoop()
    while Toggles.AutoTrait do
        task.wait(Options.RollCD)
        
        local traitUI = PlayerGui:FindFirstChild("TraitRerollUI")
        if not traitUI then --continue 
        end
        
        local frame = traitUI.MainFrame.Frame.Content.TraitPage
        local confirm = traitUI.MainFrame.Frame.Content:FindFirstChild("AreYouSureYouWantToRerollFrame")
        local currentTrait = frame.TraitGottenFrame.Holder.Trait.TraitGotten.Text
        
        if Options.SelectedTraits[currentTrait] then
            Toggles.AutoTrait = false
            break
        else
            if confirm and confirm.Visible then
                Fire(Remotes.TraitConfirm, true)
                task.wait(0.1)
            end
            Fire(Remotes.Roll_Trait)
        end
    end
end

-- Auto Race Loop
local function AutoRaceLoop()
    while Toggles.AutoRace do
        task.wait(Options.RollCD)
        
        local cur = Player:GetAttribute("CurrentRace") or ""
        if Options.SelectedRaces[cur] then
            Toggles.AutoRace = false
            break
        end
        
        Fire(Remotes.UseItem, "Use", "Race Reroll", 1)
    end
end

-- Auto Clan Loop
local function AutoClanLoop()
    while Toggles.AutoClan do
        task.wait(Options.RollCD)
        
        local cur = Player:GetAttribute("CurrentClan") or ""
        if Options.SelectedClans[cur] then
            Toggles.AutoClan = false
            break
        end
        
        Fire(Remotes.UseItem, "Use", "Clan Reroll", 1)
    end
end

-- Auto Spec Passive Loop
local function AutoSpecLoop()
    while Toggles.AutoSpec do
        task.wait(Options.SpecRollCD)
        
        local done = true
        for wpn, on in pairs(Options.SelectedPassive) do
            if on then
                local cur = State.Passives[wpn]
                local curName = (type(cur) == "table" and cur.Name) or (type(cur) == "string" and cur) or "None"
                
                if not Options.SelectedSpec[curName] then
                    done = false
                    Fire(Remotes.SpecReroll, wpn)
                    task.wait(0.5)
                    break
                end
            end
        end
        
        if done then
            Toggles.AutoSpec = false
            break
        end
    end
end

-- Auto Enchant Loop
local function AutoEnchantLoop()
    while Toggles.AutoEnchant or Toggles.AutoEnchantAll do
        task.wait(1.5)
        
        for acc, on in pairs(Options.SelectedEnchant) do
            if on or Toggles.AutoEnchantAll then
                Invoke(Remotes.Enchant, acc)
                task.wait(0.5)
            end
        end
    end
end

-- Auto Blessing Loop
local function AutoBlessingLoop()
    while Toggles.AutoBlessing or Toggles.AutoBlessingAll do
        task.wait(1.5)
        
        for wpn, on in pairs(Options.SelectedBlessing) do
            if on or Toggles.AutoBlessingAll then
                Invoke(Remotes.Blessing, wpn)
                task.wait(0.5)
            end
        end
    end
end

-- Auto Skill Tree Loop
local function AutoSkillTreeLoop()
    while Toggles.AutoSkillTree do
        task.wait(0.5)
        
        if State.SkillTree.Points <= 0 then --continue 
        end
        
        for _, branch in pairs(Modules.SkillTree.Branches or {}) do
            for _, node in ipairs(branch.Nodes or {}) do
                if not State.SkillTree.Nodes[node.Id] and State.SkillTree.Points >= (node.Cost or 1) then
                    Fire(Remotes.SkillTreeUpgrade, node.Id)
                    State.SkillTree.Points = State.SkillTree.Points - (node.Cost or 1)
                    task.wait(0.3)
                    break
                end
            end
        end
    end
end

-- Auto Chest Loop
local function AutoChestLoop()
    while Toggles.AutoChest do
        task.wait(2)
        
        for _, rarity in ipairs(Tables.ChestList) do
            if Options.SelectedChests[rarity] then
                local fullName = rarity == "Aura Crate" and "Aura Crate" or rarity .. " Chest"
                Fire(Remotes.UseItem, "Use", fullName, 10000)
                task.wait(1)
            end
        end
    end
end

-- Auto Craft Loop
local function AutoCraftLoop()
    while Toggles.AutoCraft do
        task.wait(1)
        
        for _, item in pairs(State.Inventory) do
            if Options.SelectedCraftItems.DivineGrail and item.name == "Broken Sword" and item.quantity >= 3 then
                local craftAmount = math.min(math.floor(item.quantity / 3), 99)
                Invoke(Remotes.GrailCraft, "DivineGrail", craftAmount)
                task.wait(0.5)
            end
            
            if Options.SelectedCraftItems.SlimeKey and item.name == "Slime Shard" and item.quantity >= 2 then
                local craftAmount = math.min(math.floor(item.quantity / 2), 99)
                Invoke(Remotes.SlimeCraft, "SlimeKey", craftAmount)
            end
        end
    end
end

-- Auto Merchant Loop
local function AutoMerchantLoop()
    local MerchantUI = PlayerGui:WaitForChild("MerchantUI")
    local Holder = MerchantUI:FindFirstChild("Holder", true)
    
    local function OpenMerchant()
        Invoke(Remotes.MerchantOpen)
        task.wait(2)
    end
    
    -- Initial sync
    OpenMerchant()
    local label = MerchantUI:FindFirstChild("RefreshTimerLabel", true)
    if label and label.Text:find(":") then
        local m, s = label.Text:match("(%d+):(%d+)")
        if m and s then State.MerchantTime = tonumber(m) * 60 + tonumber(s) end
    end
    if MerchantUI:FindFirstChild("MainFrame") then MerchantUI.MainFrame.Visible = false end
    State.FirstMerchantSync = true
    
    while Toggles.AutoMerchant do
        task.wait(1)
        State.MerchantTime = math.max(0, State.MerchantTime - 1)
        
        if State.MerchantTime <= 1 or not State.FirstMerchantSync then
            if not State.MerchantExecuting then
                State.MerchantExecuting = true
                task.spawn(function()
                    OpenMerchant()
                    if Holder then
                        for _, child in pairs(Holder:GetChildren()) do
                            if child:IsA("Frame") and Options.SelectedMerchantItems[child.Name] then
                                Invoke(Remotes.MerchantBuy, child.Name, 99)
                                task.wait(1.2)
                            end
                        end
                    end
                    if MerchantUI:FindFirstChild("MainFrame") then MerchantUI.MainFrame.Visible = false end
                    State.MerchantExecuting = false
                    State.MerchantTime = 1800
                    State.FirstMerchantSync = true
                end)
            end
        end
    end
end

-- Auto Dungeon Loop
local function AutoDungeonLoop()
    local lastDungeon = 0
    
    while Toggles.AutoDungeon do
        task.wait(1)
        
        if not Options.SelectedDungeon then --continue 
        end
        
        local leaveBtn = PlayerGui:FindFirstChild("DungeonPortalJoinUI") and PlayerGui.DungeonPortalJoinUI:FindFirstChild("LeaveButton")
        if leaveBtn and leaveBtn.Visible then --continue 
        end
        
        if tick() - lastDungeon > 15 then
            Fire(Remotes.OpenDungeon, tostring(Options.SelectedDungeon))
            lastDungeon = tick()
            task.wait(1)
        end
        
        local portal = workspace:FindFirstChild("ActiveDungeonPortal")
        if portal then
            local char = GetCharacter()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = portal.CFrame
                task.wait(0.2)
                local prompt = portal:FindFirstChildOfClass("ProximityPrompt")
                if prompt and fireproximityprompt then
                    fireproximityprompt(prompt)
                    task.wait(1)
                end
            end
        else
            local island = Options.SelectedDungeon == "BossRush" and "Sailor" or "Dungeon"
            Fire(Remotes.TP_Portal, island)
            task.wait(2.5)
        end
    end
end

-- Auto Ascend Loop
local function AutoAscendLoop()
    while Toggles.AutoAscend do
        task.wait(3)
        Invoke(Remotes.ReqAscend)
    end
end

-- Artifact Milestone Loop
local function ArtifactMilestoneLoop()
    local milestone = 1
    while Toggles.ArtifactMilestone do
        task.wait(1)
        Fire(Remotes.ArtifactClaim, milestone)
        milestone = milestone + 1
        if milestone > 40 then milestone = 1 end
    end
end

-- Noclip Loop
local function NoclipLoop()
    while Toggles.Noclip do
        task.wait()
        local char = GetCharacter()
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end

-- WalkSpeed Loop
local function WalkSpeedLoop()
    while Toggles.WalkSpeed do
        task.wait()
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Options.WalkSpeedVal end
    end
    local char = GetCharacter()
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

-- JumpPower Loop
local function JumpPowerLoop()
    while Toggles.JumpPower do
        task.wait()
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = Options.JumpPowerVal
            hum.UseJumpPower = true
        end
    end
end

-- Anti Knockback
local AKBConnections = {}
local function ApplyAntiKB(char)
    local root = char:WaitForChild("HumanoidRootPart", 10)
    if root then
        local c = root.ChildAdded:Connect(function(child)
            if not Toggles.AntiKnockback then return end
            if child:IsA("BodyVelocity") and child.MaxForce == Vector3.new(40000, 40000, 40000) then
                child:Destroy()
            end
        end)
        table.insert(AKBConnections, c)
    end
end

local function AntiKnockbackLoop()
    if Player.Character then ApplyAntiKB(Player.Character) end
    local cc = Player.CharacterAdded:Connect(ApplyAntiKB)
    table.insert(AKBConnections, cc)
    
    repeat task.wait(1) until not Toggles.AntiKnockback
    
    for _, c in pairs(AKBConnections) do c:Disconnect() end
    table.clear(AKBConnections)
end

-- ════════════════════════════════════════════════════════════
-- EVENT CONNECTIONS
-- ════════════════════════════════════════════════════════════

-- Inventory Update
local UpInventory = GetRemote(ReplicatedStorage, "Remotes.UpdateInventory")
if UpInventory then
    UpInventory.OnClientEvent:Connect(function(category, data)
        if category == "Items" then
            State.Inventory = data or {}
        elseif category == "Accessories" then
            State.Accessories = data or {}
            
            -- Update owned accessories
            table.clear(Tables.OwnedAccessories)
            local processed = {}
            for _, item in ipairs(data or {}) do
                if (item.enchantLevel or 0) < 10 and not processed[item.name] then
                    table.insert(Tables.OwnedAccessories, item.name)
                    processed[item.name] = true
                end
            end
            table.sort(Tables.OwnedAccessories)
            
        elseif category == "Sword" or category == "Melee" then
            State.WeaponCache[category] = data or {}
            
            -- Update owned weapons
            table.clear(Tables.OwnedWeapons)
            local processed = {}
            for _, cat in pairs({"Sword", "Melee"}) do
                for _, item in ipairs(State.WeaponCache[cat] or {}) do
                    if (item.blessingLevel or 0) < 10 and not processed[item.name] then
                        table.insert(Tables.OwnedWeapons, item.name)
                        processed[item.name] = true
                    end
                end
            end
            table.sort(Tables.OwnedWeapons)
            
        elseif category == "Runes" then
            table.clear(Tables.RuneList)
            table.insert(Tables.RuneList, "None")
            for name, _ in pairs(data or {}) do
                table.insert(Tables.RuneList, name)
            end
            table.sort(Tables.RuneList)
        end
    end)
end

-- Stat Reroll Update
local UpStatReroll = GetRemote(ReplicatedStorage, "RemoteEvents.StatRerollUpdate")
if UpStatReroll then
    UpStatReroll.OnClientEvent:Connect(function(data)
        if data and data.Stats then
            State.GemStats = data.Stats
        end
    end)
end

-- Skill Tree Update
local UpSkillTree = GetRemote(ReplicatedStorage, "RemoteEvents.SkillTreeUpdate")
if UpSkillTree then
    UpSkillTree.OnClientEvent:Connect(function(data)
        if data then
            State.SkillTree.Nodes = data.Nodes or {}
            State.SkillTree.Points = data.SkillPoints or 0
        end
    end)
end

-- Spec Passive Update
local SpecPassiveUpdate = GetRemote(ReplicatedStorage, "RemoteEvents.SpecPassiveDataUpdate")
if SpecPassiveUpdate then
    SpecPassiveUpdate.OnClientEvent:Connect(function(data)
        if data and data.Passives then
            for wpn, info in pairs(data.Passives) do
                State.Passives[wpn] = info
            end
        end
    end)
end

-- Haki State Update
local HakiStateUpdate = GetRemote(ReplicatedStorage, "RemoteEvents.HakiStateUpdate")
if HakiStateUpdate then
    HakiStateUpdate.OnClientEvent:Connect(function(arg1, arg2)
        if arg1 == false then
            State.ArmHakiOn = false
        elseif arg1 == Player then
            State.ArmHakiOn = arg2
        end
    end)
end

-- Title Sync
local TitleSync = GetRemote(ReplicatedStorage, "RemoteEvents.TitleDataSync")
if TitleSync then
    TitleSync.OnClientEvent:Connect(function(data)
        if data and data.unlocked then
            State.UnlockedTitles = data.unlocked
        end
    end)
end

-- Anti AFK
task.spawn(function()
    while true do
        task.wait(60)
        if Toggles.AntiAFK then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.1)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

local CosmicBossKeywords = {"CosmicBeingBoss_Normal"}
local SeaBossKeywords = {"Kraken", "SeaSerpent", "seaserpent", "kraken", "Sea Serpent"}
local DioBossKeywords = {"TheWorldBoss_Normal", "TheWorldBoss_Medium", "TheWorldBoss_Hard", "TheWorldBoss_Extreme"}
local DioDiffList = {"Normal", "Medium", "Hard", "Extreme"}
 
local SEA_WAIT_CENTER = Vector3.new(-3617, -8, -2396)
local SEA_ORBIT_RADIUS = 15

local function FindLiveBossAnywhere(keywords)
    if not keywords then return nil end
    for _, obj in ipairs(workspace:GetDescendants()) do
        local hum = obj:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 then
            for _, keyword in ipairs(keywords) do
                if obj.Name:lower():find(keyword:lower()) then
                    return obj
                end
            end
        end
    end
    return nil
end
 
local function GetSeaBossPosition(boss)
    local pos = nil
    pcall(function() pos = boss:GetPivot().Position end)
    if not pos then
        local root = boss:FindFirstChild("RootPart")
            or boss.PrimaryPart
            or boss:FindFirstChild("kraken_low")
            or boss:FindFirstChildOfClass("BasePart")
        if root then pos = root.Position end
    end
    return pos
end
 
local function IsSeaBossAlive()
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc:IsA("Model") then
            local n = npc.Name:lower():gsub("[%s_%-]", "")
            if n:find("kraken") or n:find("seaserpent") or n:find("seabeast") then
                local bossHP = npc:GetAttribute("_BossHP") or npc:GetAttribute("BossHP")
                local hum = npc:FindFirstChildOfClass("Humanoid")
                local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                    or (hum and hum.Health > 0)
                if alive then return true, npc end
            end
        end
    end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local n = obj.Name:lower():gsub("[%s_%-]", "")
            if n:find("kraken") or n:find("seaserpent") or n:find("seabeast") then
                local bossHP = obj:GetAttribute("_BossHP") or obj:GetAttribute("BossHP")
                local hum = obj:FindFirstChildOfClass("Humanoid")
                local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                    or (hum and hum.Health > 0)
                if alive then return true, obj end
            end
        end
    end
    return false, nil
end

-- Cosmic Boss
local function Func_AutoCosmicBoss()
    while Toggles.AutoCosmicBoss do
        task.wait(0.05)
        local boss = FindLiveBossAnywhere(CosmicBossKeywords)
        if not boss then
            State.CosmicBossFound = false
            task.wait(0.5)
            continue
        end
        State.CosmicBossFound = true
        State.Target = boss
 
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then task.wait(0.3); continue end
 
        local bossPos
        pcall(function() bossPos = boss:GetPivot().Position end)
        if not bossPos then task.wait(0.3); continue end
 
        local targetPos = bossPos + Vector3.new(0, 150, 0)
        local dist = (root.Position - targetPos).Magnitude
        if dist > 3 then
            local tw = TweenService:Create(root,
                TweenInfo.new(math.clamp(dist / 160, 0.05, 0.4), Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {CFrame = CFrame.new(targetPos)})
            tw:Play()
            tw.Completed:Wait()
        end
        root.AssemblyLinearVelocity = Vector3.zero
 
        EquipWeapon()
        local hum = boss:FindFirstChildOfClass("Humanoid")
        if Toggles.InstaKill and hum then pcall(function() hum.Health = 0 end) end
 
        for i = 1, 5 do
            local h2 = boss:FindFirstChildOfClass("Humanoid")
            if not h2 or h2.Health <= 0 then break end
            Fire(Remotes.M1)
            State.LastM1 = tick()
            task.wait(0.04)
        end
    end
    State.CosmicBossFound = false
end
 
-- Sea Beast Spawn Wait
local function Func_AutoSeaBossSpawn()
    while Toggles.AutoSeaBossSpawn do
        local bossAlive, _ = IsSeaBossAlive()
        if bossAlive then
            State.SeaBossFound = true
            repeat task.wait(0.5); bossAlive, _ = IsSeaBossAlive()
            until not bossAlive or not Toggles.AutoSeaBossSpawn
            State.SeaBossFound = false
            task.wait(3)
            continue
        end
        State.SeaBossFound = false
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local startPos = SEA_WAIT_CENTER + Vector3.new(SEA_ORBIT_RADIUS, 0, 0)
            if (root.Position - startPos).Magnitude > 20 then
                local tw = TweenService:Create(root,
                    TweenInfo.new(3, Enum.EasingStyle.Linear),
                    {CFrame = CFrame.new(startPos, SEA_WAIT_CENTER)})
                tw:Play(); tw.Completed:Wait()
            end
            local angle = 0
            while Toggles.AutoSeaBossSpawn do
                local alive2, _ = IsSeaBossAlive()
                if alive2 then State.SeaBossFound = true; break end
                angle = (angle + math.pi * 2 / 30 * 0.1) % (math.pi * 2)
                local orbitPos = Vector3.new(
                    SEA_WAIT_CENTER.X + math.cos(angle) * SEA_ORBIT_RADIUS,
                    SEA_WAIT_CENTER.Y,
                    SEA_WAIT_CENTER.Z + math.sin(angle) * SEA_ORBIT_RADIUS)
                local c = GetCharacter()
                local r = c and c:FindFirstChild("HumanoidRootPart")
                if r then
                    TweenService:Create(r, TweenInfo.new(0.1, Enum.EasingStyle.Linear),
                        {CFrame = CFrame.new(orbitPos, SEA_WAIT_CENTER)}):Play()
                end
                task.wait(0.1)
            end
        end
    end
    State.SeaBossFound = false
end
 
-- Sea Beast Kill
local function Func_AutoSeaBoss()
    while Toggles.AutoSeaBoss do
        task.wait(0.05)
        local boss = nil
        local function findBoss()
            for _, npc in pairs(NPCsFolder:GetChildren()) do
                if npc:IsA("Model") then
                    local n = npc.Name:lower():gsub("[%s_%-]", "")
                    if n:find("kraken") or n:find("seaserpent") or n:find("seabeast") then
                        local bossHP = npc:GetAttribute("_BossHP") or npc:GetAttribute("BossHP")
                        local hum = npc:FindFirstChildOfClass("Humanoid")
                        if (bossHP and tonumber(bossHP) > 0) or (hum and hum.Health > 0) then
                            return npc
                        end
                    end
                end
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") then
                    local n = obj.Name:lower():gsub("[%s_%-]", "")
                    if n:find("kraken") or n:find("seaserpent") or n:find("seabeast") then
                        local bossHP = obj:GetAttribute("_BossHP") or obj:GetAttribute("BossHP")
                        local hum = obj:FindFirstChildOfClass("Humanoid")
                        if (bossHP and tonumber(bossHP) > 0) or (hum and hum.Health > 0) then
                            return obj
                        end
                    end
                end
            end
        end
        boss = findBoss()
        if not boss then State.SeaBossFound = false; task.wait(0.5); continue end
 
        State.SeaBossFound = true
        State.Target = boss
 
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then task.wait(0.3); continue end
 
        local bossPos = GetSeaBossPosition(boss)
        if not bossPos then task.wait(0.3); continue end
 
        local targetPos = bossPos + Vector3.new(0, 150, 0)
        local dist = (root.Position - targetPos).Magnitude
        if dist > 3 then
            local speed = Options.TweenSpeed or 160
            local tw = TweenService:Create(root,
                TweenInfo.new(math.clamp(dist / speed, 0.05, 0.4), Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {CFrame = CFrame.new(targetPos)})
            tw:Play(); tw.Completed:Wait()
        end
        root.AssemblyLinearVelocity = Vector3.zero
 
        EquipWeapon()
        local hum = boss:FindFirstChildOfClass("Humanoid")
        local bossHP = boss:GetAttribute("_BossHP") or boss:GetAttribute("BossHP")
        local alive = (bossHP and tonumber(bossHP) > 0) or (hum and hum.Health > 0)
        if not alive then State.SeaBossFound = false; continue end
 
        if Toggles.InstaKill and hum then pcall(function() hum.Health = 0 end) end
 
        for i = 1, 5 do
            local h2 = boss:FindFirstChildOfClass("Humanoid")
            local bp2 = boss:GetAttribute("_BossHP") or boss:GetAttribute("BossHP")
            if not ((bp2 and tonumber(bp2) > 0) or (h2 and h2.Health > 0)) then break end
            Fire(Remotes.M1)
            State.LastM1 = tick()
            task.wait(0.04)
        end
    end
    State.SeaBossFound = false
end
 
-- Dio/The World Boss Spawn
local function Func_AutoSpawnDio()
    while Toggles.AutoSpawnDio do
        task.wait(3)
        local boss = FindLiveBossAnywhere(DioBossKeywords)
        if not boss then
            local diff = Options.SelectedDioDiff or "Normal"
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("RemoteEvents")
                    :WaitForChild("RequestSpawnTheWorld")
                    :FireServer(diff)
            end)
            task.wait(3)
        end
    end
end
 
-- Dio/The World Boss Kill
local function Func_AutoKillDio()
    while Toggles.AutoKillDio do
        task.wait(0.05)
        local boss = nil
        for _, npc in pairs(NPCsFolder:GetChildren()) do
            local n = npc.Name:lower():gsub("[%s_%-]", "")
            if n:find("theworldboss") then
                local hum = npc:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then boss = npc; break end
            end
        end
        if not boss then
            boss = FindLiveBossAnywhere(DioBossKeywords)
        end
        if not boss then task.wait(0.5); continue end
 
        State.Target = boss
        State.DioBossFound = true
 
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then task.wait(0.3); continue end
 
        local bossPos
        pcall(function() bossPos = boss:GetPivot().Position end)
        if not bossPos then task.wait(0.3); continue end
 
        local targetPos = bossPos + Vector3.new(0, Options.FarmDistance or 5, 0)
        local dest = CFrame.lookAt(targetPos, bossPos)
        local dist = (root.Position - targetPos).Magnitude
        if dist > 2 then
            if Options.MovementType == "Tween" then
                local tw = TweenService:Create(root,
                    TweenInfo.new(math.clamp(dist / (Options.TweenSpeed or 160), 0.05, 0.35),
                        Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {CFrame = dest})
                tw:Play()
            else
                root.CFrame = dest
            end
        end
        root.AssemblyLinearVelocity = Vector3.zero
 
        EquipWeapon()
        local hum = boss:FindFirstChildOfClass("Humanoid")
        if Toggles.InstaKill and hum then pcall(function() hum.Health = 0 end) end
 
        if (root.Position - bossPos).Magnitude < 35 then
            Fire(Remotes.M1)
            State.LastM1 = tick()
        end
    end
    State.DioBossFound = false
end
 
-- Server Hop for Sea Beast
local function Func_AutoHopUntilSeaBoss()
    local TARGET_PLACE_ID = game.PlaceId
    local checkInterval = 3
    local elapsed = 0
    local hopAttempts = 0
    local MAX_HOP_ATTEMPTS = 10
 
    local alive, _ = IsSeaBossAlive()
    if alive then
        warn("[Sea Hop] Already found in this server!")
        Toggles.AutoHopSeaBoss = false
        Toggles.AutoSeaBoss = true
        Thread("SeaBoss.AutoKill", Func_AutoSeaBoss, true)
        return
    end
 
    while Toggles.AutoHopSeaBoss do
        task.wait(1)
        elapsed = elapsed + 1
        local isAlive, _ = IsSeaBossAlive()
        if isAlive then
            warn("[Sea Hop] Sea Boss found! Starting farm...")
            Toggles.AutoHopSeaBoss = false
            Toggles.AutoSeaBoss = true
            Thread("SeaBoss.AutoKill", Func_AutoSeaBoss, true)
            break
        end
        if elapsed >= checkInterval then
            elapsed = 0
            hopAttempts = hopAttempts + 1
            if hopAttempts > MAX_HOP_ATTEMPTS then
                warn("[Sea Hop] Max hops reached.")
                Toggles.AutoHopSeaBoss = false
                break
            end
            pcall(function()
                local Http = game:GetService("HttpService")
                local TS = game:GetService("TeleportService")
                local JobID = game.JobId
                local candidates = {}
                local url = "https://games.roblox.com/v1/games/" .. TARGET_PLACE_ID .. "/servers/Public?sortOrder=Asc&limit=100"
                local ok, res = pcall(function() return Http:JSONDecode(game:HttpGet(url)) end)
                if ok and res and res.data then
                    for _, server in pairs(res.data) do
                        if server.id ~= JobID and server.playing > 0 and server.playing < server.maxPlayers then
                            table.insert(candidates, server)
                        end
                    end
                end
                if #candidates > 0 then
                    local pick = candidates[math.random(1, math.min(10, #candidates))]
                    TS:TeleportToPlaceInstance(TARGET_PLACE_ID, pick.id, Player)
                else
                    TS:Teleport(TARGET_PLACE_ID, Player)
                end
            end)
            task.wait(10)
        end
    end
end
 
-- ════════════════════════════════════════════════════════════
-- DUNGEON HELPER FUNCTIONS
-- ════════════════════════════════════════════════════════════
local function GetAllDungeonNPCTargets()
    local targets = {}
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc:IsA("Model") then
            local hum = npc:FindFirstChildOfClass("Humanoid")
            local root = npc:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local isPlayer = false
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character == npc then isPlayer = true; break end
                end
                if not isPlayer then table.insert(targets, npc) end
            end
        end
    end
    return targets
end
 
local function AttackAllDungeonTargets()
    local targets = GetAllDungeonNPCTargets()
    if #targets == 0 then return false end
    local nameDict = {}
    for _, npc in ipairs(targets) do nameDict[npc.Name:gsub("%d+$", "")] = true end
    local best = GetBestMobCluster(nameDict) or targets[1]
    if not best then return false end
    local hum = best:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return false end
 
    State.Target = best
    ExecuteFarmLogic(best, GetNearestIsland(best:GetPivot().Position), "Boss")
    EquipWeapon()
    if Toggles.InstaKill and hum then pcall(function() hum.Health = 0 end) end
    Fire(Remotes.M1)
    State.LastM1 = tick()
    return true
end
 
local function ReplayVote()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DungeonWaveReplayVote"):FireServer("sponsor")
    end)
    pcall(function()
        local r = GetRemote(ReplicatedStorage, "Remotes.DungeonWaveVote")
        if r then r:FireServer("start") end
    end)
end
 
local function OpenDungeonPortal(dungeonId, difficulty)
    if not Remotes.OpenDungeon then return end
    pcall(function() Remotes.OpenDungeon:FireServer(tostring(dungeonId), tostring(difficulty or "Easy")) end)
    task.wait(1.5)
    local R_Vote = GetRemote(ReplicatedStorage, "Remotes.DungeonWaveVote")
    if R_Vote then
        pcall(function() R_Vote:FireServer(tostring(difficulty or "Easy")) end)
        task.wait(0.3)
        pcall(function() R_Vote:FireServer("start") end)
        task.wait(0.3)
    end
end
 
local function TryEnterDungeonPortal()
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    local portal = nil
    for _, n in ipairs({"ActiveDungeonPortal", "DungeonPortal", "RaidPortal", "TowerPortal", "BossRushPortal"}) do
        portal = workspace:FindFirstChild(n)
        if portal then break end
    end
    if not portal then
        for _, obj in pairs(workspace:GetChildren()) do
            local n = obj.Name:lower()
            if n:find("portal") and (n:find("dungeon") or n:find("tower") or n:find("raid")) then
                portal = obj; break
            end
        end
    end
    if not portal then return false end
    local pivotCF
    pcall(function() pivotCF = portal:GetPivot() end)
    if not pivotCF then
        local bp = portal:FindFirstChildOfClass("BasePart")
        if bp then pivotCF = bp.CFrame end
    end
    if pivotCF then
        root.CFrame = pivotCF * CFrame.new(0, 2, 0)
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.3)
    end
    local prompt = portal:FindFirstChildOfClass("ProximityPrompt", true)
    if prompt and fireproximityprompt then
        fireproximityprompt(prompt)
        task.wait(1)
        return true
    end
    return false
end
 
-- ════════════════════════════════════════════════════════════
-- AUTO DUNGEON (Boss Rush, Cid, Rune, Double)
-- ════════════════════════════════════════════════════════════
local function Func_AutoDungeon()
    local dungeonId = Options.SelectedDungeonType or "BossRush"
    local difficulty = Options.SelectedDungeonDiff or "Easy"
 
    local function StartRun()
        Fire(Remotes.TP_Portal, "Dungeon")
        task.wait(2.5)
        OpenDungeonPortal(dungeonId, difficulty)
        task.wait(2)
        TryEnterDungeonPortal()
    end
 
    StartRun()
 
    while Toggles.AutoDungeonEnabled do
        task.wait(0.05)
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not hum or hum.Health <= 0 then task.wait(0.5); continue end
 
        local hasTargets = AttackAllDungeonTargets()
        if not hasTargets then
            if Toggles.AutoDungeonRetry then
                ReplayVote()
                task.wait(3)
                if #GetAllDungeonNPCTargets() == 0 then
                    StartRun()
                end
            end
        end
    end
end
 
-- ════════════════════════════════════════════════════════════
-- AUTO INFINITE TOWER
-- ════════════════════════════════════════════════════════════
local function Func_AutoInfiniteTower()
    local difficulty = Options.SelectedTowerDiff or "Easy"
    local R_SetAutoReset = GetRemote(ReplicatedStorage, "RemoteEvents.SetAutoTowerReset")
    local R_Vote = GetRemote(ReplicatedStorage, "Remotes.DungeonWaveVote")
 
    local function StartTower()
        Fire(Remotes.TP_Portal, "Dungeon")
        task.wait(2.5)
        pcall(function() Remotes.OpenDungeon:FireServer("InfiniteTower", tostring(difficulty)) end)
        task.wait(1)
        if R_Vote then
            pcall(function() R_Vote:FireServer(tostring(difficulty)) end)
            task.wait(0.3)
            pcall(function() R_Vote:FireServer("start") end)
        end
        task.wait(2)
        TryEnterDungeonPortal()
    end
 
    StartTower()
 
    local function GetCurrentFloor()
        local floor = 0
        pcall(function()
            for _, gui in pairs(PlayerGui:GetChildren()) do
                for _, lbl in pairs(gui:GetDescendants()) do
                    if lbl:IsA("TextLabel") then
                        local f = tonumber(lbl.Text:match("Floor%s*(%d+)") or (lbl.Text:match("^(%d+)$")))
                        if f and f > floor then floor = f end
                    end
                end
            end
        end)
        return floor
    end
 
    while Toggles.AutoTowerEnabled do
        task.wait(0.05)
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not hum or hum.Health <= 0 then task.wait(0.5); continue end
 
        local hasTargets = AttackAllDungeonTargets()
 
        if not hasTargets and Toggles.AutoTowerStart then
            ReplayVote()
            task.wait(2)
 
            if Toggles.AutoTowerReset then
                local floorLimit = Options.TowerResetFloor or 50
                local curFloor = GetCurrentFloor()
                if curFloor >= floorLimit then
                    if R_SetAutoReset then
                        pcall(function() R_SetAutoReset:FireServer(0) end)
                    end
                    StartTower()
                end
            end
        end
    end
end
 
-- ════════════════════════════════════════════════════════════
-- AUTO CRYSTAL DEFENSE
-- ════════════════════════════════════════════════════════════
local function Func_AutoCrystalDefense()
    local function StartCrystalRun()
        pcall(function() Remotes.OpenDungeon:FireServer("CrystalDefense", "Normal") end)
        task.wait(1.5)
        local R_Vote = GetRemote(ReplicatedStorage, "Remotes.DungeonWaveVote")
        if R_Vote then
            pcall(function() R_Vote:FireServer("Normal") end)
            task.wait(0.3)
            pcall(function() R_Vote:FireServer("start") end)
        end
        task.wait(2)
        TryEnterDungeonPortal()
    end
 
    StartCrystalRun()
 
    while Toggles.AutoCrystalDefense do
        task.wait(0.05)
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not char or not hum or hum.Health <= 0 then task.wait(0.5); continue end
 
        local hasTargets = AttackAllDungeonTargets()
 
        if not hasTargets and Toggles.AutoCrystalReplay then
            ReplayVote()
            task.wait(3)
            if #GetAllDungeonNPCTargets() == 0 then
                StartCrystalRun()
            end
        end
    end
end

-- Character Respawn Handler
Player.CharacterAdded:Connect(function(char)
    State.Recovering = true
    State.Island = ""
    task.wait(3)
    State.Recovering = false
end)

-- ════════════════════════════════════════════════════════════
-- INITIALIZE
-- ════════════════════════════════════════════════════════════
UpdateMobList()

-- Request inventory
if Remotes.ReqInventory then
    Fire(Remotes.ReqInventory)
end

-- ════════════════════════════════════════════════════════════
-- UI LIBRARY LOADING
-- ════════════════════════════════════════════════════════════
local Library = loadstring(game:HttpGet("https://pastefy.app/FeedlhPN/raw", true))()

local Window = Library:Window({
    Title = "Daida Sailor Piece",
    SubTitle = "Version : Premuim",
    WelcomeTitle = "*******",
    Developer = {Name = "melodyics", Role = "Developer", Avatar = 12345678},
})

-- ════════════════════════════════════════════════════════════
-- PAGE 1: AUTO FARM LEVEL & MOB
-- ════════════════════════════════════════════════════════════
local PageLevel = Window:NewPage({
    Title = "Level & Mob Farm",
    Desc = "Level up and farm mobs",
    Icon = 10709782497,
})

PageLevel:Section("🗡️ Weapon Select")

PageLevel:Dropdown({
    Title = "Select Weapon Type",
    List = Tables.WeaponTypes,
    Multi = true,
    Callback = function(v)
        Options.SelectedWeaponType = {}
        if type(v) == "table" then
            for _, t in pairs(v) do Options.SelectedWeaponType[t] = true end
        end
    end,
})

PageLevel:Toggle({
    Title = "Auto Equip Weapon",
    Desc = "Automatically equips selected weapon type from backpack",
    Value = false,
    Callback = function(v)
        Toggles.AutoEquipWeapon = v
        Thread("AutoEquipWeapon", AutoEquipWeaponLoop, v)
    end,
})

PageLevel:Slider({
    Title = "Weapon Switch CD",
    Min = 1,
    Max = 20,
    Value = 4,
    Callback = function(v) Options.WeaponSwitchCD = v end,
})

PageLevel:Section("⚡ Level Farm")

PageLevel:Toggle({
    Title = "Auto Farm Level (Quest)",
    Desc = "Farms the best quest mob for your level",
    Value = false,
    Callback = function(v)
        Toggles.LevelFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageLevel:Section("⚔️ Mob Farm")

PageLevel:Dropdown({
    Title = "Select Mob(s)",
    List = Tables.MobList,
    Value = nil,
    Multi = true,
    Callback = function(v)
        Options.SelectedMobs = {}
        if type(v) == "table" then
            for _, name in pairs(v) do Options.SelectedMobs[name] = true end
        end
    end,
})

PageLevel:Button({
    Title = "Refresh Mob List",
    Text = "Refresh",
    Callback = function()
        UpdateMobList()
    end,
})

PageLevel:Toggle({
    Title = "Auto Farm Selected Mob",
    Value = false,
    Callback = function(v)
        Toggles.MobFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageLevel:Toggle({
    Title = "Auto Farm All Mobs",
    Value = false,
    Callback = function(v)
        Toggles.AllMobFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageLevel:Section("⚙️ Farm Config")

PageLevel:Slider({
    Title = "Attack Distance",
    Min = 5,
    Max = 30,
    Value = 12,
    Callback = function(v) Options.FarmDistance = v end,
})

PageLevel:Slider({
    Title = "M1 Attack Speed",
    Min = 0,
    Max = 1,
    Rounding = 2,
    Value = 0.2,
    Callback = function(v) Options.M1Speed = v end,
})

PageLevel:Dropdown({
    Title = "Movement Type",
    List = {"Teleport", "Tween"},
    Value = "Teleport",
    Callback = function(v) Options.MovementType = v end,
})

PageLevel:Dropdown({
    Title = "Farm Position",
    List = {"Behind", "Above", "Below"},
    Value = "Behind",
    Callback = function(v) Options.FarmType = v end,
})

PageLevel:Toggle({
    Title = "Island Teleport",
    Desc = "TP to mob island automatically",
    Value = true,
    Callback = function(v) Toggles.IslandTP = v end,
})

PageLevel:Slider({
    Title = "Island TP Cooldown",
    Min = 0,
    Max = 3,
    Rounding = 2,
    Value = 0.8,
    Callback = function(v) Options.IslandTPCD = v end,
})

PageLevel:Toggle({
    Title = "Instant Kill",
    Desc = "Set enemy HP to 0 (risky)",
    Value = false,
    Callback = function(v) Toggles.InstaKill = v end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 2: AUTO FARM BOSS
-- ════════════════════════════════════════════════════════════
local PageBoss = Window:NewPage({
    Title = "Boss Farm",
    Desc = "Farm bosses and raids",
    Icon = 127561653320876,
})

PageBoss:Section("🏆 World Bosses")

PageBoss:Dropdown({
    Title = "Select Boss(es)",
    List = Tables.BossList,
    Multi = true,
    Callback = function(v)
        Options.SelectedBosses = {}
        if type(v) == "table" then
            for _, name in pairs(v) do Options.SelectedBosses[name] = true end
        end
    end,
})

PageBoss:Toggle({
    Title = "Auto Farm Selected Boss",
    Value = false,
    Callback = function(v)
        Toggles.BossFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageBoss:Toggle({
    Title = "Auto Farm ALL Bosses",
    Value = false,
    Callback = function(v)
        Toggles.AllBossFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageBoss:Section("🌀 Summon Boss")

PageBoss:Dropdown({
    Title = "Select Summon Boss",
    List = Tables.SummonList,
    Callback = function(v) Options.SelectedSummon = v end,
})

PageBoss:Dropdown({
    Title = "Select Difficulty",
    List = Tables.DiffList,
    Value = "Normal",
    Callback = function(v) Options.SelectedSummonDiff = v end,
})

PageBoss:Toggle({
    Title = "Auto Summon Boss",
    Value = false,
    Callback = function(v) Toggles.AutoSummon = v end,
})

PageBoss:Toggle({
    Title = "Auto Farm Summon Boss",
    Value = false,
    Callback = function(v)
        Toggles.SummonFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageBoss:Section("💀 Other Summons")

PageBoss:Dropdown({
    Title = "Select Other Summon",
    List = Tables.OtherSummonList,
    Callback = function(v) Options.SelectedOtherSummon = v end,
})

PageBoss:Dropdown({
    Title = "Select Difficulty",
    List = Tables.DiffList,
    Value = "Normal",
    Callback = function(v) Options.SelectedOtherSummonDiff = v end,
})

PageBoss:Toggle({
    Title = "Auto Summon (Other)",
    Value = false,
    Callback = function(v) Toggles.AutoOtherSummon = v end,
})

PageBoss:Toggle({
    Title = "Auto Farm Other Summon",
    Value = false,
    Callback = function(v)
        Toggles.OtherSummonFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

PageBoss:Section("🎯 Pity Boss Farm")

PageBoss:Dropdown({
    Title = "Boss to Build Pity",
    List = Tables.AllBossList,
    Multi = true,
    Callback = function(v)
        Options.SelectedBuildPity = {}
        if type(v) == "table" then
            for _, name in pairs(v) do Options.SelectedBuildPity[name] = true end
        end
    end,
})

PageBoss:Dropdown({
    Title = "Boss to Use Pity",
    List = Tables.AllBossList,
    Callback = function(v) Options.SelectedUsePity = v end,
})

PageBoss:Dropdown({
    Title = "Use Pity Difficulty",
    List = Tables.DiffList,
    Value = "Normal",
    Callback = function(v) Options.SelectedPityDiff = v end,
})

PageBoss:Toggle({
    Title = "Auto Pity Boss Farm",
    Value = false,
    Callback = function(v)
        Toggles.PityBossFarm = v
        if v then
            State.Running = true
            Thread("FarmLoop", FarmLoop, true)
            Thread("CombatLoop", CombatLoop, true)
        end
    end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 3: AUTO SKILLS
-- ════════════════════════════════════════════════════════════
local PageSkills = Window:NewPage({
    Title = "Combat & Skills",
    Desc = "Auto M1, Skills, Haki",
    Icon = 10709783577,
})

PageSkills:Section("👊 Auto Haki")

PageSkills:Toggle({
    Title = "Auto Arm Haki",
    Value = false,
    Callback = function(v)
        Toggles.AutoArmHaki = v
        Thread("AutoHaki", AutoHakiLoop, v or Toggles.AutoObsHaki or Toggles.AutoConqHaki)
    end,
})

PageSkills:Toggle({
    Title = "Auto Obs Haki",
    Value = false,
    Callback = function(v)
        Toggles.AutoObsHaki = v
        Thread("AutoHaki", AutoHakiLoop, v or Toggles.AutoArmHaki or Toggles.AutoConqHaki)
    end,
})

PageSkills:Toggle({
    Title = "Auto Conqueror Haki",
    Value = false,
    Callback = function(v)
        Toggles.AutoConqHaki = v
        Thread("AutoHaki", AutoHakiLoop, v or Toggles.AutoArmHaki or Toggles.AutoObsHaki)
    end,
})

PageSkills:Section("⚔️ Auto M1 (Attack)")

PageSkills:Slider({
    Title = "M1 Speed (CD)",
    Min = 0,
    Max = 1,
    Rounding = 2,
    Value = 0.2,
    Callback = function(v) Options.M1Speed = v end,
})

PageSkills:Toggle({
    Title = "Auto Attack (M1)",
    Value = false,
    Callback = function(v)
        Toggles.AutoM1 = v
        Thread("AutoM1", AutoM1Loop, v)
    end,
})

PageSkills:Section("💥 Kill Aura")

PageSkills:Slider({
    Title = "Kill Aura Range",
    Min = 0,
    Max = 200,
    Value = 200,
    Callback = function(v) Options.KillAuraRange = v end,
})

PageSkills:Slider({
    Title = "Kill Aura CD",
    Min = 0.05,
    Max = 2,
    Rounding = 2,
    Value = 0.12,
    Callback = function(v) Options.KillAuraCD = v end,
})

PageSkills:Toggle({
    Title = "Kill Aura",
    Value = false,
    Callback = function(v)
        Toggles.KillAura = v
        Thread("KillAura", KillAuraLoop, v)
    end,
})

PageSkills:Section("🎯 Auto Skills")

PageSkills:Dropdown({
    Title = "Select Skills",
    List = Tables.SkillKeys,
    Multi = true,
    Callback = function(v)
        Options.SelectedSkills = {}
        if type(v) == "table" then
            for _, k in pairs(v) do Options.SelectedSkills[k] = true end
        end
    end,
})

PageSkills:Toggle({
    Title = "Target Only",
    Desc = "Only use skills when targeting",
    Value = false,
    Callback = function(v) Toggles.OnlyTarget = v end,
})

PageSkills:Toggle({
    Title = "Auto Use Skills",
    Value = false,
    Callback = function(v)
        Toggles.AutoSkill = v
        Thread("AutoSkill", AutoSkillLoop, v)
    end,
})


-- ════════════════════════════════════════════════════════════
-- PAGE 4: CHARACTER STATS & ROLLS
-- ════════════════════════════════════════════════════════════
local PageChar = Window:NewPage({
    Title = "Character",
    Desc = "Stats, Traits, Race, Clan",
    Icon = 115164375298022,
})

PageChar:Section("📊 Auto Stats")

PageChar:Dropdown({
    Title = "Select Stats",
    List = Tables.StatList,
    Multi = true,
    Callback = function(v)
        Options.SelectedStats = {}
        if type(v) == "table" then
            for _, s in pairs(v) do Options.SelectedStats[s] = true end
        end
    end,
})

PageChar:Toggle({
    Title = "Auto Allocate Stats",
    Value = false,
    Callback = function(v)
        Toggles.AutoStats = v
        Thread("AutoStats", AutoStatsLoop, v)
    end,
})

PageChar:Section("🎲 Auto Roll Gem Stats")

PageChar:Dropdown({
    Title = "Select Gem Stats",
    List = Tables.GemStatList,
    Multi = true,
    Callback = function(v)
        Options.SelectedGemStats = {}
        if type(v) == "table" then
            for _, s in pairs(v) do Options.SelectedGemStats[s] = true end
        end
    end,
})

PageChar:Dropdown({
    Title = "Select Target Rank",
    List = Tables.GemRankList,
    Multi = true,
    Callback = function(v)
        Options.SelectedRanks = {}
        if type(v) == "table" then
            for _, r in pairs(v) do Options.SelectedRanks[r] = true end
        end
    end,
})

PageChar:Slider({
    Title = "Roll Delay",
    Min = 0.05,
    Max = 2,
    Rounding = 2,
    Value = 0.1,
    Callback = function(v) Options.StatRollCD = v end,
})

PageChar:Toggle({
    Title = "Auto Roll Gem Stats",
    Value = false,
    Callback = function(v)
        Toggles.AutoRollStats = v
        Thread("AutoRollStats", AutoRollStatsLoop, v)
    end,
})

PageChar:Section("✨ Auto Roll Trait")

PageChar:Dropdown({
    Title = "Select Target Trait(s)",
    List = Tables.TraitList,
    Multi = true,
    Callback = function(v)
        Options.SelectedTraits = {}
        if type(v) == "table" then
            for _, t in pairs(v) do Options.SelectedTraits[t] = true end
        end
    end,
})

PageChar:Slider({
    Title = "Roll Delay",
    Min = 0.1,
    Max = 2,
    Rounding = 1,
    Value = 0.3,
    Callback = function(v) Options.RollCD = v end,
})

PageChar:Toggle({
    Title = "Auto Roll Trait",
    Value = false,
    Callback = function(v)
        Toggles.AutoTrait = v
        Thread("AutoTrait", AutoTraitLoop, v)
    end,
})

PageChar:Section("🧬 Auto Roll Race")

PageChar:Dropdown({
    Title = "Select Target Race(s)",
    List = Tables.RaceList,
    Multi = true,
    Callback = function(v)
        Options.SelectedRaces = {}
        if type(v) == "table" then
            for _, r in pairs(v) do Options.SelectedRaces[r] = true end
        end
    end,
})

PageChar:Toggle({
    Title = "Auto Roll Race",
    Value = false,
    Callback = function(v)
        Toggles.AutoRace = v
        Thread("AutoRace", AutoRaceLoop, v)
    end,
})

PageChar:Section("🏯 Auto Roll Clan")

PageChar:Dropdown({
    Title = "Select Target Clan(s)",
    List = Tables.ClanList,
    Multi = true,
    Callback = function(v)
        Options.SelectedClans = {}
        if type(v) == "table" then
            for _, c in pairs(v) do Options.SelectedClans[c] = true end
        end
    end,
})

PageChar:Toggle({
    Title = "Auto Roll Clan",
    Value = false,
    Callback = function(v)
        Toggles.AutoClan = v
        Thread("AutoClan", AutoClanLoop, v)
    end,
})

PageChar:Section("🌳 Auto Skill Tree")

PageChar:Toggle({
    Title = "Auto Upgrade Skill Tree",
    Value = false,
    Callback = function(v)
        Toggles.AutoSkillTree = v
        Thread("AutoSkillTree", AutoSkillTreeLoop, v)
    end,
})

PageChar:Section("⬆️ Auto Ascend")

PageChar:Toggle({
    Title = "Auto Ascend",
    Value = false,
    Callback = function(v)
        Toggles.AutoAscend = v
        Thread("AutoAscend", AutoAscendLoop, v)
    end,
})

local PageSea2 = Window:NewPage({
    Title = "Sea 2 Farm",
    Desc = "Cosmic, Sea Beast, Dio Boss",
    Icon = 10723405360,
})
 
-- Cosmic Boss
PageSea2:Section("🌌 Cosmic Being Boss")
 
PageSea2:Paragraph({
    Title = "Cosmic Boss Status",
    Desc = "Tracks whether Cosmic Being Boss is alive in this server.",
})
 
PageSea2:Toggle({
    Title = "Auto Kill Cosmic Boss",
    Desc = "Teleports above the boss and attacks it continuously",
    Value = false,
    Callback = function(v)
        Toggles.AutoCosmicBoss = v
        Thread("CosmicBoss", Func_AutoCosmicBoss, v)
    end,
})
 
-- Sea Beast
PageSea2:Section("🌊 Sea Beast (Kraken / Sea Serpent)")
 
PageSea2:Toggle({
    Title = "Auto Wait at Sea (Spawn Watch)",
    Desc = "Orbits at the sea spawn point and waits for Sea Beast to spawn",
    Value = false,
    Callback = function(v)
        Toggles.AutoSeaBossSpawn = v
        Thread("SeaBossSpawn", Func_AutoSeaBossSpawn, v)
    end,
})
 
PageSea2:Toggle({
    Title = "Auto Kill Sea Beast",
    Desc = "Attacks Sea Beast when alive (positions above it)",
    Value = false,
    Callback = function(v)
        Toggles.AutoSeaBoss = v
        Thread("SeaBossKill", Func_AutoSeaBoss, v)
    end,
})
 
PageSea2:Toggle({
    Title = "Auto Hop Until Sea Beast Found",
    Desc = "Server hops until it finds a server with a live Sea Beast",
    Value = false,
    Callback = function(v)
        Toggles.AutoHopSeaBoss = v
        if v then
            Toggles.AutoSeaBossSpawn = false
            Toggles.AutoSeaBoss = false
            Thread("SeaBossSpawn", Func_AutoSeaBossSpawn, false)
            Thread("SeaBossKill", Func_AutoSeaBoss, false)
        end
        Thread("SeaBossHop", Func_AutoHopUntilSeaBoss, v)
    end,
})
 
-- Dio / The World Boss
PageSea2:Section("🕛 Dio — The World Boss")
 
PageSea2:Dropdown({
    Title = "Dio Difficulty",
    List = DioDiffList,
    Value = "Normal",
    Callback = function(v) Options.SelectedDioDiff = v end,
})
 
PageSea2:Toggle({
    Title = "Auto Spawn Dio",
    Desc = "Fires the RequestSpawnTheWorld remote to summon Dio",
    Value = false,
    Callback = function(v)
        Toggles.AutoSpawnDio = v
        Thread("DioSpawn", Func_AutoSpawnDio, v)
    end,
})
 
PageSea2:Toggle({
    Title = "Auto Kill Dio",
    Desc = "Attacks The World Boss when it is alive",
    Value = false,
    Callback = function(v)
        Toggles.AutoKillDio = v
        Thread("DioKill", Func_AutoKillDio, v)
    end,
})
 
-- ════════════════════════════════════════════════════════════
-- PAGE: AUTO DUNGEON (replace/extend the existing one)
-- ════════════════════════════════════════════════════════════
local PageDungeonNew = Window:NewPage({
    Title = "Dungeons",
    Desc = "Boss Rush, Inf Tower, Crystal Defense",
    Icon = 135478075951994,
})
 
-- Boss Rush / Raid
PageDungeonNew:Section("⚔️ Dungeon / Boss Rush")
 
PageDungeonNew:Dropdown({
    Title = "Raid Selection",
    List = {"BossRush", "CidDungeon", "RuneDungeon", "DoubleDungeon"},
    Value = "BossRush",
    Callback = function(v) Options.SelectedDungeonType = v end,
})
 
PageDungeonNew:Dropdown({
    Title = "Difficulty",
    List = {"Easy", "Medium", "Hard", "Extreme"},
    Value = "Easy",
    Callback = function(v) Options.SelectedDungeonDiff = v end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Retry / Replay",
    Value = true,
    Callback = function(v) Toggles.AutoDungeonRetry = v end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Dungeon",
    Desc = "Automatically runs and replays dungeons/raids",
    Value = false,
    Callback = function(v)
        Toggles.AutoDungeonEnabled = v
        if v then
            State.Running = true
        end
        Thread("AutoDungeon", Func_AutoDungeon, v)
    end,
})
 
-- Infinite Tower
PageDungeonNew:Section("🏰 Infinite Tower")
 
PageDungeonNew:Dropdown({
    Title = "Tower Difficulty",
    List = {"Easy", "Medium", "Hard", "Extreme"},
    Value = "Easy",
    Callback = function(v) Options.SelectedTowerDiff = v end,
})
 
PageDungeonNew:Slider({
    Title = "Restart at Floor #",
    Min = 1,
    Max = 200,
    Value = 50,
    Callback = function(v) Options.TowerResetFloor = v end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Start Next Wave",
    Value = true,
    Callback = function(v) Toggles.AutoTowerStart = v end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Restart at Floor Limit",
    Value = false,
    Callback = function(v)
        Toggles.AutoTowerReset = v
        if v then
            local R_SetAutoReset = GetRemote(ReplicatedStorage, "RemoteEvents.SetAutoTowerReset")
            if R_SetAutoReset then
                pcall(function() R_SetAutoReset:FireServer(Options.TowerResetFloor or 50) end)
            end
        end
    end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Infinite Tower",
    Desc = "Runs, attacks, and replays Infinite Tower automatically",
    Value = false,
    Callback = function(v)
        Toggles.AutoTowerEnabled = v
        if v then
            State.Running = true
        end
        Thread("AutoTower", Func_AutoInfiniteTower, v)
    end,
})
 
-- Crystal Defense
PageDungeonNew:Section("💎 Crystal Defense")
 
PageDungeonNew:Toggle({
    Title = "Auto Replay Crystal Defense",
    Value = true,
    Callback = function(v) Toggles.AutoCrystalReplay = v end,
})
 
PageDungeonNew:Toggle({
    Title = "Auto Crystal Defense",
    Desc = "Farms Crystal Defense and auto-replays each round",
    Value = false,
    Callback = function(v)
        Toggles.AutoCrystalDefense = v
        if v then
            State.Running = true
        end
        Thread("AutoCrystalDefense", Func_AutoCrystalDefense, v)
    end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 5: ENCHANT & CRAFT
-- ════════════════════════════════════════════════════════════
local PageEnchant = Window:NewPage({
    Title = "Enchant & Craft",
    Desc = "Enchant, Blessing, Craft, Chests",
    Icon = 10709782497,
})

PageEnchant:Section("✨ Auto Enchant")

PageEnchant:Dropdown({
    Title = "Select Accessory",
    List = Tables.OwnedAccessories,
    Multi = true,
    Callback = function(v)
        Options.SelectedEnchant = {}
        if type(v) == "table" then
            for _, a in pairs(v) do Options.SelectedEnchant[a] = true end
        end
    end,
})

PageEnchant:Toggle({
    Title = "Auto Enchant",
    Value = false,
    Callback = function(v)
        Toggles.AutoEnchant = v
        Thread("AutoEnchant", AutoEnchantLoop, v)
    end,
})

PageEnchant:Toggle({
    Title = "Auto Enchant ALL",
    Value = false,
    Callback = function(v)
        Toggles.AutoEnchantAll = v
        Thread("AutoEnchant", AutoEnchantLoop, v or Toggles.AutoEnchant)
    end,
})

PageEnchant:Section("🙏 Auto Blessing")

PageEnchant:Dropdown({
    Title = "Select Weapon",
    List = Tables.OwnedWeapons,
    Multi = true,
    Callback = function(v)
        Options.SelectedBlessing = {}
        if type(v) == "table" then
            for _, w in pairs(v) do Options.SelectedBlessing[w] = true end
        end
    end,
})

PageEnchant:Toggle({
    Title = "Auto Blessing",
    Value = false,
    Callback = function(v)
        Toggles.AutoBlessing = v
        Thread("AutoBlessing", AutoBlessingLoop, v)
    end,
})

PageEnchant:Toggle({
    Title = "Auto Blessing ALL",
    Value = false,
    Callback = function(v)
        Toggles.AutoBlessingAll = v
        Thread("AutoBlessing", AutoBlessingLoop, v or Toggles.AutoBlessing)
    end,
})

PageEnchant:Section("🌀 Auto Spec Passive")

PageEnchant:Dropdown({
    Title = "Select Weapon",
    List = Tables.OwnedWeapons,
    Multi = true,
    Callback = function(v)
        Options.SelectedPassive = {}
        if type(v) == "table" then
            for _, w in pairs(v) do Options.SelectedPassive[w] = true end
        end
    end,
})

PageEnchant:Dropdown({
    Title = "Select Target Passive",
    List = Tables.SpecPassiveList,
    Multi = true,
    Callback = function(v)
        Options.SelectedSpec = {}
        if type(v) == "table" then
            for _, s in pairs(v) do Options.SelectedSpec[s] = true end
        end
    end,
})

PageEnchant:Slider({
    Title = "Roll Delay",
    Min = 0.05,
    Max = 2,
    Rounding = 2,
    Value = 0.1,
    Callback = function(v) Options.SpecRollCD = v end,
})

PageEnchant:Toggle({
    Title = "Auto Reroll Passive",
    Value = false,
    Callback = function(v)
        Toggles.AutoSpec = v
        Thread("AutoSpec", AutoSpecLoop, v)
    end,
})

PageEnchant:Section("🔨 Auto Craft")

PageEnchant:Dropdown({
    Title = "Select Craft Item",
    List = Tables.CraftItems,
    Multi = true,
    Callback = function(v)
        Options.SelectedCraftItems = {}
        if type(v) == "table" then
            for _, i in pairs(v) do Options.SelectedCraftItems[i] = true end
        end
    end,
})

PageEnchant:Toggle({
    Title = "Auto Craft",
    Value = false,
    Callback = function(v)
        Toggles.AutoCraft = v
        Thread("AutoCraft", AutoCraftLoop, v)
    end,
})

PageEnchant:Section("📦 Auto Open Chests")

PageEnchant:Dropdown({
    Title = "Select Chest Rarities",
    List = Tables.ChestList,
    Multi = true,
    Callback = function(v)
        Options.SelectedChests = {}
        if type(v) == "table" then
            for _, r in pairs(v) do Options.SelectedChests[r] = true end
        end
    end,
})

PageEnchant:Toggle({
    Title = "Auto Open Chests",
    Value = false,
    Callback = function(v)
        Toggles.AutoChest = v
        Thread("AutoChest", AutoChestLoop, v)
    end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 6: DUNGEON & MERCHANT
-- ════════════════════════════════════════════════════════════
local PageDungeon = Window:NewPage({
    Title = "Dungeon & Merchant",
    Desc = "Auto dungeon and merchant",
    Icon = 91920478152016,
})

PageDungeon:Section("🏯 Auto Dungeon")

PageDungeon:Dropdown({
    Title = "Select Dungeon",
    List = Tables.DungeonList,
    Callback = function(v) Options.SelectedDungeon = v end,
})

PageDungeon:Toggle({
    Title = "Auto Join Dungeon",
    Value = false,
    Callback = function(v)
        Toggles.AutoDungeon = v
        Thread("AutoDungeon", AutoDungeonLoop, v)
    end,
})

PageDungeon:Section("🛒 Auto Merchant")

PageDungeon:Dropdown({
    Title = "Select Items to Buy",
    List = Tables.MerchantList,
    Multi = true,
    Callback = function(v)
        Options.SelectedMerchantItems = {}
        if type(v) == "table" then
            for _, i in pairs(v) do Options.SelectedMerchantItems[i] = true end
        end
    end,
})

PageDungeon:Toggle({
    Title = "Auto Buy Merchant",
    Value = false,
    Callback = function(v)
        Toggles.AutoMerchant = v
        Thread("AutoMerchant", AutoMerchantLoop, v)
    end,
})

PageDungeon:Section("🎲 Artifact Milestone")

PageDungeon:Toggle({
    Title = "Auto Claim Artifact Milestones",
    Value = false,
    Callback = function(v)
        Toggles.ArtifactMilestone = v
        Thread("ArtifactMilestone", ArtifactMilestoneLoop, v)
    end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 7: TELEPORT
-- ════════════════════════════════════════════════════════════
local PageTP = Window:NewPage({
    Title = "Teleport",
    Desc = "Teleport to islands & NPCs",
    Icon = 10734886004,
})

PageTP:Section("🗺️ Island Teleport")

PageTP:Dropdown({
    Title = "Select Island",
    List = Tables.IslandList,
    Callback = function(v)
        if v then Fire(Remotes.TP_Portal, v) end
    end,
})

PageTP:Section("🧍 NPC Teleport")

PageTP:Dropdown({
    Title = "Select NPC",
    List = Tables.NPCList,
    Callback = function(v)
        if not v then return end
        local npc = ServiceNPCs:FindFirstChild(v)
        if npc then
            local char = GetCharacter()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then root.CFrame = npc:GetPivot() * CFrame.new(0, 3, 0) end
        end
    end,
})

-- ════════════════════════════════════════════════════════════
-- PAGE 8: PLAYER OPTIONS
-- ════════════════════════════════════════════════════════════
local PagePlayer = Window:NewPage({
    Title = "Player",
    Desc = "Speed, Noclip, Anti-AFK",
    Icon = 13075651575,
})

PagePlayer:Section("🏃 Movement")

PagePlayer:Slider({
    Title = "WalkSpeed",
    Min = 16,
    Max = 500,
    Value = 16,
    Callback = function(v) Options.WalkSpeedVal = v end,
})

PagePlayer:Toggle({
    Title = "Set WalkSpeed",
    Value = false,
    Callback = function(v)
        Toggles.WalkSpeed = v
        Thread("WalkSpeed", WalkSpeedLoop, v)
    end,
})

PagePlayer:Slider({
    Title = "JumpPower",
    Min = 0,
    Max = 500,
    Value = 50,
    Callback = function(v) Options.JumpPowerVal = v end,
})

PagePlayer:Toggle({
    Title = "Set JumpPower",
    Value = false,
    Callback = function(v)
        Toggles.JumpPower = v
        Thread("JumpPower", JumpPowerLoop, v)
    end,
})

PagePlayer:Section("🕹️ Misc")

PagePlayer:Toggle({
    Title = "Noclip",
    Value = false,
    Callback = function(v)
        Toggles.Noclip = v
        Thread("Noclip", NoclipLoop, v)
    end,
})

PagePlayer:Toggle({
    Title = "Anti Knockback",
    Value = false,
    Callback = function(v)
        Toggles.AntiKnockback = v
        Thread("AntiKnockback", AntiKnockbackLoop, v)
    end,
})

PagePlayer:Toggle({
    Title = "Anti AFK",
    Value = true,
    Callback = function(v) Toggles.AntiAFK = v end,
})

PagePlayer:Toggle({
    Title = "Fullbright",
    Value = false,
    Callback = function(v)
        Toggles.Fullbright = v
        if v then
            task.spawn(function()
                while Toggles.Fullbright do
                    task.wait(0.5)
                    Lighting.Brightness = 2
                    Lighting.ClockTime = 14
                    Lighting.GlobalShadows = false
                end
            end)
        end
    end,
})

PagePlayer:Section("🔄 Server")

PagePlayer:Button({
    Title = "Rejoin Server",
    Text = "Rejoin",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Player)
    end,
})

PagePlayer:Button({
    Title = "Stop All Scripts",
    Text = "STOP",
    Callback = function()
        State.Running = false
        State.Farm = false
        StopAllThreads()
        
        for k, _ in pairs(Toggles) do
            Toggles[k] = false
        end
    end,
})

-- ════════════════════════════════════════════════════════════
-- FINAL INITIALIZATION
-- ════════════════════════════════════════════════════════════
print("[Sailor Farm] Script loaded successfully!")
print("[Sailor Farm] All features ready.")
