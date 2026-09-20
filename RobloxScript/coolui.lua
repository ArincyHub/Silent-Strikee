repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0

-- ===== EXECUTOR COMPATIBILITY =====
function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing("function", cloneref, function(...) return ... end)
getgc = missing("function", getgc or get_gc_objects)
getconnections = missing("function", getconnections or get_signal_cons)

Services = setmetatable({}, {
    __index = function(self, name)
        local success, cache = pcall(function()
            return cloneref(game:GetService(name))
        end)
        if success then
            rawset(self, name, cache)
            return cache
        else
            error("Invalid Service: " .. tostring(name))
        end
    end
})

local Players       = Services.Players
local Plr           = Players.LocalPlayer
local Char          = Plr.Character or Plr.CharacterAdded:Wait()
local PGui          = Plr:WaitForChild("PlayerGui")
local Lighting      = game:GetService("Lighting")
local RS            = Services.ReplicatedStorage
local RunService    = Services.RunService
local HttpService   = Services.HttpService
local GuiService    = Services.GuiService
local TeleportService = Services.TeleportService
local Marketplace   = Services.MarketplaceService
local UIS           = Services.UserInputService
local VirtualUser   = Services.VirtualUser
local TweenService  = game:GetService("TweenService")

local v, Asset = pcall(function()
    return Marketplace:GetProductInfo(game.PlaceId)
end)
local assetName = (v and Asset) and Asset.Name or "Sailor Piece"

local Support = {
    Webhook    = (typeof(request) == "function" or typeof(http_request) == "function"),
    Clipboard  = (typeof(setclipboard) == "function"),
    FileIO     = (typeof(writefile) == "function" and typeof(isfile) == "function"),
    QueueOnTP  = (typeof(queue_on_teleport) == "function"),
    Connections= (typeof(getconnections) == "function"),
    FPS        = (typeof(setfpscap) == "function"),
    Proximity  = (typeof(fireproximityprompt) == "function"),
}

local executorName = (identifyexecutor and identifyexecutor() or "Unknown"):lower()
local isXeno = string.find(executorName, "xeno") ~= nil
local isLimitedExecutor = false
for _, name in ipairs({"xeno"}) do
    if string.find(executorName, name) then isLimitedExecutor = true break end
end

-- ===== LOAD ACRYLIC UI =====
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/noowtf31-ui/Arcylic/refs/heads/main/src.lua.txt"))()
local window = Library.new("Zen Hub | "..assetName, "fkTaolaoConfigs")
window:SetToggleKey(Enum.KeyCode.RightControl)

-- ===== MODULES & REMOTES =====
local function GetSafeModule(parent, name)
    local obj = parent:FindFirstChild(name)
    if obj and obj:IsA("ModuleScript") then
        local ok, res = pcall(require, obj)
        if ok then return res end
    end
    return nil
end

local function GetRemote(parent, pathString)
    local current = parent
    for _, name in ipairs(pathString:split(".")) do
        if not current then return nil end
        current = current:FindFirstChild(name)
    end
    return current
end


local Remotes = {
    SettingsToggle = GetRemote(RS, "RemoteEvents.SettingsToggle"),
    SettingsSync = GetRemote(RS, "RemoteEvents.SettingsSync"),
    UseCode = GetRemote(RS, "RemoteEvents.CodeRedeem"),

    M1 = GetRemote(RS, "CombatSystem.Remotes.RequestHit"),
    EquipWeapon = GetRemote(RS, "Remotes.EquipWeapon"),
    UseSkill = GetRemote(RS, "AbilitySystem.Remotes.RequestAbility"),
    UseFruit = GetRemote(RS, "RemoteEvents.FruitPowerRemote"),
    QuestAccept = GetRemote(RS, "RemoteEvents.QuestAccept"),
    QuestAbandon = GetRemote(RS, "RemoteEvents.QuestAbandon"),

    UseItem = GetRemote(RS, "Remotes.UseItem"),
    SlimeCraft = GetRemote(RS, "Remotes.RequestSlimeCraft"),
    GrailCraft = GetRemote(RS, "Remotes.RequestGrailCraft"),

    RerollSingleStat = GetRemote(RS, "Remotes.RerollSingleStat"),

    SkillTreeUpgrade = GetRemote(RS, "RemoteEvents.SkillTreeUpgrade"),
    Enchant = GetRemote(RS, "Remotes.EnchantAccessory"),
    Blessing = GetRemote(RS, "Remotes.BlessWeapon"),

    ArtifactSync = GetRemote(RS, "RemoteEvents.ArtifactDataSync"),
    ArtifactClaim = GetRemote(RS, "RemoteEvents.ArtifactMilestoneClaimReward"),
    MassDelete = GetRemote(RS, "RemoteEvents.ArtifactMassDeleteByUUIDs"),
    MassUpgrade = GetRemote(RS, "RemoteEvents.ArtifactMassUpgrade"),
    ArtifactLock = GetRemote(RS, "RemoteEvents.ArtifactLock"),
    ArtifactUnequip = GetRemote(RS, "RemoteEvents.ArtifactUnequip"),
    ArtifactEquip = GetRemote(RS, "RemoteEvents.ArtifactEquip"),

    Roll_Trait = GetRemote(RS, "RemoteEvents.TraitReroll"),
    TraitAutoSkip = GetRemote(RS, "RemoteEvents.TraitUpdateAutoSkip"),
    TraitConfirm = GetRemote(RS, "RemoteEvents.TraitConfirm"),
    SpecPassiveReroll = GetRemote(RS, "RemoteEvents.SpecPassiveReroll"),

    ArmHaki = GetRemote(RS, "RemoteEvents.HakiRemote"),
    ObserHaki = GetRemote(RS, "RemoteEvents.ObservationHakiRemote"),
    ConquerorHaki = GetRemote(RS, "Remotes.ConquerorHakiRemote"),

    TP_Portal = GetRemote(RS, "Remotes.TeleportToPortal"),
    OpenDungeon = GetRemote(RS, "Remotes.RequestDungeonPortal"),

    EquipTitle = GetRemote(RS, "RemoteEvents.TitleEquip"),
    TitleUnequip = GetRemote(RS, "RemoteEvents.TitleUnequip"),
    EquipRune = GetRemote(RS, "Remotes.EquipRune"),
    LoadoutLoad = GetRemote(RS, "RemoteEvents.LoadoutLoad"),
    AddStat = GetRemote(RS, "RemoteEvents.AllocateStat"),

    OpenMerchant = GetRemote(RS, "Remotes.MerchantRemotes.OpenMerchantUI"),
    MerchantBuy = GetRemote(RS, "Remotes.MerchantRemotes.PurchaseMerchantItem"),
    ValentineBuy = GetRemote(RS, "Remotes.ValentineMerchantRemotes.PurchaseValentineMerchantItem"),
    StockUpdate = GetRemote(RS, "Remotes.MerchantRemotes.MerchantStockUpdate"),

    SummonBoss = GetRemote(RS, "Remotes.RequestSummonBoss"),
    JJKSummonBoss = GetRemote(RS, "Remotes.RequestSpawnStrongestBoss"),
    RimuruBoss = GetRemote(RS, "RemoteEvents.RequestSpawnRimuru"),
    AnosBoss = GetRemote(RS, "Remotes.RequestSpawnAnosBoss"),
    TrueAizenBoss = GetRemote(RS, "RemoteEvents.RequestSpawnTrueAizen"),

    ReqInventory = GetRemote(RS, "Remotes.RequestInventory"),
    Ascend = GetRemote(RS, "RemoteEvents.RequestAscend"),
    ReqAscend = GetRemote(RS, "RemoteEvents.GetAscendData"),
    CloseAscend = GetRemote(RS, "RemoteEvents.CloseAscendUI"),

    TradeRespond = GetRemote(RS, "Remotes.TradeRemotes.RespondToRequest"),
    TradeSend = GetRemote(RS, "Remotes.TradeRemotes.SendTradeRequest"),
    TradeAddItem = GetRemote(RS, "Remotes.TradeRemotes.AddItemToTrade"),
    TradeReady = GetRemote(RS, "Remotes.TradeRemotes.SetReady"),
    TradeConfirm = GetRemote(RS, "Remotes.TradeRemotes.ConfirmTrade"),
    TradeUpdated = GetRemote(RS, "Remotes.TradeRemotes.TradeUpdated"),

    HakiStateUpdate = GetRemote(RS, "RemoteEvents.HakiStateUpdate"),
    UpCurrency = GetRemote(RS, "RemoteEvents.UpdateCurrency"),
    UpInventory = GetRemote(RS, "Remotes.UpdateInventory"),
    UpPlayerStats = GetRemote(RS, "RemoteEvents.UpdatePlayerStats"),
    UpAscend = GetRemote(RS, "RemoteEvents.AscendDataUpdate"),
    UpStatReroll = GetRemote(RS, "RemoteEvents.StatRerollUpdate"),
    SpecPassiveUpdate = GetRemote(RS, "RemoteEvents.SpecPassiveDataUpdate"),
    SpecPassiveSkip = GetRemote(RS, "RemoteEvents.SpecPassiveUpdateAutoSkip"),
    UpSkillTree = GetRemote(RS, "RemoteEvents.SkillTreeUpdate"),
    BossUIUpdate = GetRemote(RS, "Remotes.BossUIUpdate"),
    TitleSync = GetRemote(RS, "RemoteEvents.TitleDataSync"),
}

local Modules = {
    BossConfig = GetSafeModule(RS.Modules, "BossConfig") or {Bosses = {}},
    TimedConfig = GetSafeModule(RS.Modules, "TimedBossConfig"),
    SummonConfig = GetSafeModule(RS.Modules, "SummonableBossConfig"),

    Merchant = GetSafeModule(RS.Modules, "MerchantConfig") or {ITEMS = {}},
    ValentineConfig = GetSafeModule(RS.Modules, "ValentineMerchantConfig"),

    Title = GetSafeModule(RS.Modules, "TitlesConfig") or {},
    Quests = GetSafeModule(RS.Modules, "QuestConfig") or {RepeatableQuests = {}, Questlines = {}},

    WeaponClass = GetSafeModule(RS.Modules, "WeaponClassification") or {Tools = {}},
    Fruits = GetSafeModule(RS:FindFirstChild("FruitPowerSystem") or game, "FruitPowerConfig") or {Powers = {}},
    ArtifactConfig = GetSafeModule(RS.Modules, "ArtifactConfig"),

    Stats = GetSafeModule(RS.Modules, "StatRerollConfig") or {StatKeys = {}, RankOrder = {}},
    Codes = GetSafeModule(RS, "CodesConfig") or {Codes = {}},
    ItemRarity = GetSafeModule(RS.Modules, "ItemRarityConfig"),
    Trait = GetSafeModule(RS.Modules, "TraitConfig") or {Traits = {}},
    Race = GetSafeModule(RS.Modules, "RaceConfig") or {Races = {}},
    Clan = GetSafeModule(RS.Modules, "ClanConfig") or {Clans = {}},
    SpecPassive = GetSafeModule(RS.Modules, "SpecPassiveConfig"),
}

-- ===== SHARED STATE =====
local SummonMap = {}
local Shared = {
    GlobalPrio = "FARM", Farm = true, Recovering = false,
    MovingIsland = false, Island = "", Target = nil,
    KillTick = 0, TargetValid = false, QuestNPC = "",
    MobIdx = 1, AllMobIdx = 1, WeapRotationIdx = 1,
    ComboIdx = 1, ParsedCombo = {}, ActiveWeap = "",
    ArmHaki = false, BossTIMap = {},
    InventorySynced = false, Stats = {}, Settings = {},
    GemStats = {}, SkillTree = {Nodes = {}, Points = 0},
    Passives = {}, SpecStatsSlider = {}, ArtifactSession = {Inventory = {}, Dust = 0},
    UpBlacklist = {}, MerchantBusy = false, LocalMerchantTime = 0,
    LastTimerTick = tick(), MerchantExecute = false, FirstMerchantSync = false,
    CurrentStock = {}, LastM1 = 0, LastWRSwitch = 0,
    LastSwitch = {Title = "", Rune = ""}, LastBuildSwitch = 0, LastDungeon = 0,
    AltDamage = {}, AltActive = false, TradeState = {},
}

local Script_Start_Time = os.time()
local StartStats = {
    Level  = Plr.Data.Level.Value,
    Money  = Plr.Data.Money.Value,
    Gems   = Plr.Data.Gems.Value,
    Bounty = (Plr:FindFirstChild("leaderstats") and Plr.leaderstats:FindFirstChild("Bounty") and Plr.leaderstats.Bounty.Value) or 0,
}
local NewItemsBuffer = {}

-- ===== OPTIONS / TOGGLES STORAGE =====
-- We store all flag values here so every feature can read them
local Toggles = {}
local Options  = {}

-- ===== TABLES =====
local PATH = {
    Mobs = workspace:WaitForChild("NPCs"),
    InteractNPCs = workspace:WaitForChild("ServiceNPCs"),
}

local MerchantItemList = Modules.Merchant.ITEMS
local SortedTitleList = Modules.Title.GetSortedTitleIds and Modules.Title:GetSortedTitleIds() or {}


local Tables = {
    AscendLabels = {},
    DiffList = {"Normal", "Medium", "Hard", "Extreme"},
    MobList = {},
    MiniBossList = {"ThiefBoss", "MonkeyBoss", "DesertBoss", "SnowBoss", "PandaMiniBoss"},
    BossList = {},
    AllBossList = {},
    AllNPCList = {},
    AllEntitiesList = {},
    SummonList = {},
    OtherSummonList = {"StrongestHistory", "StrongestToday", "Rimuru", "Anos", "TrueAizen"},
    Weapon = {"Melee", "Sword", "Power"},
    ManualWeaponClass = {
        ["Invisible"] = "Power",
        ["Bomb"] = "Power",
        ["Quake"] = "Power",
    },

    MerchantList = {},
    ValentineMerchantList = {},

    Rarities = {"Common", "Rare", "Epic", "Legendary", "Mythical", "Secret", "Aura Crate", "Cosmetic Crate"},
    CraftItemList = {"SlimeKey", "DivineGrail"},
    UnlockedTitle = {},
    TitleCategory = {"None", "Best EXP", "Best Money & Gem", "Best Luck", "Best DMG"},
    TitleList = {},
    BuildList = {"1", "2", "3", "4", "5", "None"},
    TraitList = {},
    RarityWeight = {
    ["Secret"] = 1,
    ["Mythical"] = 2,
    ["Legendary"] = 3,
    ["Epic"] = 4,
    ["Rare"] = 5,
    ["Uncommon"] = 6,
    ["Common"] = 7
    },
    RaceList = {},
    ClanList = {},
    RuneList = {"None"},
    SpecPassive = {},
    GemStat = (Modules.Stats and Modules.Stats.StatKeys) or {},
    GemRank = (Modules.Stats and Modules.Stats.RankOrder) or {},
    OwnedWeapon = {},
    AllOwnedWeapons = {},
    OwnedAccessory = {},
    QuestlineList = {},

    OwnedItem = {},

    IslandList = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HuecoMundo", "Boss", "Dungeon", "Shinjuku", "Valentine", "Slime", "Academy", "Judgement", "SoulSociety"},
    NPC_QuestList = {"DungeonUnlock", "SlimeKeyUnlock"},
    NPC_MiscList = {"Artifacts", "Blessing", "Enchant", "SkillTree", "Cupid", "ArmHaki", "Observation", "Conqueror"},
    DungeonList = {"CidDungeon", "RuneDungeon", "DoubleDungeon", "BossRush"},

    NPC_MovesetList = {},
    NPC_MasteryList = {},

    MobToIsland = {}
}
local DefaultPriority = {"Boss","Pity Boss","Summon [Other]","Summon","Level Farm","All Mob Farm","Mob","Merchant","Alt Help"}

local IslandCrystals = {
    Starter    = workspace:FindFirstChild("StarterIsland")    and workspace.StarterIsland:FindFirstChild("SpawnPointCrystal_Starter"),
    Jungle     = workspace:FindFirstChild("JungleIsland")     and workspace.JungleIsland:FindFirstChild("SpawnPointCrystal_Jungle"),
    Desert     = workspace:FindFirstChild("DesertIsland")     and workspace.DesertIsland:FindFirstChild("SpawnPointCrystal_Desert"),
    Snow       = workspace:FindFirstChild("SnowIsland")       and workspace.SnowIsland:FindFirstChild("SpawnPointCrystal_Snow"),
    Sailor     = workspace:FindFirstChild("SailorIsland")     and workspace.SailorIsland:FindFirstChild("SpawnPointCrystal_Sailor"),
    Shibuya    = workspace:FindFirstChild("ShibuyaStation")   and workspace.ShibuyaStation:FindFirstChild("SpawnPointCrystal_Shibuya"),
    HuecoMundo = workspace:FindFirstChild("HuecoMundo")       and workspace.HuecoMundo:FindFirstChild("SpawnPointCrystal_HuecoMundo"),
    Boss       = workspace:FindFirstChild("BossIsland")       and workspace.BossIsland:FindFirstChild("SpawnPointCrystal_Boss"),
    Dungeon    = workspace:FindFirstChild("Main Temple")      and workspace["Main Temple"]:FindFirstChild("SpawnPointCrystal_Dungeon"),
    Shinjuku   = workspace:FindFirstChild("ShinjukuIsland")   and workspace.ShinjukuIsland:FindFirstChild("SpawnPointCrystal_Shinjuku"),
    Valentine  = workspace:FindFirstChild("ValentineIsland")  and workspace.ValentineIsland:FindFirstChild("SpawnPointCrystal_Valentine"),
    Slime      = workspace:FindFirstChild("SlimeIsland")      and workspace.SlimeIsland:FindFirstChild("SpawnPointCrystal_Slime"),
    Academy    = workspace:FindFirstChild("AcademyIsland")    and workspace.AcademyIsland:FindFirstChild("SpawnPointCrystal_Academy"),
    Judgement  = workspace:FindFirstChild("JudgementIsland")  and workspace.JudgementIsland:FindFirstChild("SpawnPointCrystal_Judgement"),
    SoulSociety= workspace:FindFirstChild("SoulSocietyIsland")and workspace.SoulSocietyIsland:FindFirstChild("SpawnPointCrystal_SoulSociety"),
}

local Connections = {Player_General = nil, Idled = nil, Merchant = nil, Dash = nil, Knockback = {}, Reconnect = nil}
local Flags = {}
-- ===== POPULATE TABLES =====
task.spawn(function()
    pcall(function()
        if Modules.TimedConfig and Modules.TimedConfig.Bosses then
            for _, data in pairs(Modules.TimedConfig.Bosses) do
                table.insert(Tables.BossList, data.displayName)
                local tpName = data.spawnLocation:gsub(" Island",""):gsub(" Station","")
                if data.spawnLocation == "Hueco Mundo Island" then tpName = "HuecoMundo" end
                if data.spawnLocation == "Judgement Island"   then tpName = "Judgement"  end
                Shared.BossTIMap[data.displayName] = tpName
            end
            table.sort(Tables.BossList)
        end

        if Modules.SummonConfig and Modules.SummonConfig.Bosses then
            for _, data in pairs(Modules.SummonConfig.Bosses) do
                table.insert(Tables.SummonList, data.displayName)
                SummonMap[data.displayName] = data.bossId
            end
            table.sort(Tables.SummonList)
        end

        if Modules.BossConfig and Modules.BossConfig.Bosses then
            for bossInternalName in pairs(Modules.BossConfig.Bosses) do
                table.insert(Tables.AllBossList, bossInternalName:gsub("Boss$",""))
            end
            table.sort(Tables.AllBossList)
        end

        if MerchantItemList then
            for itemName in pairs(MerchantItemList) do table.insert(Tables.MerchantList, itemName) end
        end

        if SortedTitleList then
            for _, v in ipairs(SortedTitleList) do table.insert(Tables.TitleList, v) end
            local CombinedTitleList = {}
            for _, cat in ipairs(Tables.TitleCategory) do table.insert(CombinedTitleList, cat) end
            for _, t   in ipairs(Tables.TitleList)     do table.insert(CombinedTitleList, t)   end
        end

        if Modules.Trait and Modules.Trait.Traits then
            for k in pairs(Modules.Trait.Traits) do table.insert(Tables.TraitList, k) end
            pcall(function()
                table.sort(Tables.TraitList, function(a,b)
                    local wa = Tables.RarityWeight[Modules.Trait.Traits[a].Rarity] or 99
                    local wb = Tables.RarityWeight[Modules.Trait.Traits[b].Rarity] or 99
                    return wa ~= wb and wa < wb or a < b
                end)
            end)
        end

        if Modules.Race and Modules.Race.Races then
            for k in pairs(Modules.Race.Races) do table.insert(Tables.RaceList, k) end
            pcall(function()
                table.sort(Tables.RaceList, function(a,b)
                    local wa = Tables.RarityWeight[Modules.Race.Races[a].rarity] or 99
                    local wb = Tables.RarityWeight[Modules.Race.Races[b].rarity] or 99
                    return wa ~= wb and wa < wb or a < b
                end)
            end)
        end

        if Modules.Clan and Modules.Clan.Clans then
            for k in pairs(Modules.Clan.Clans) do table.insert(Tables.ClanList, k) end
            pcall(function()
                table.sort(Tables.ClanList, function(a,b)
                    local wa = Tables.RarityWeight[Modules.Clan.Clans[a].rarity] or 99
                    local wb = Tables.RarityWeight[Modules.Clan.Clans[b].rarity] or 99
                    return wa ~= wb and wa < wb or a < b
                end)
            end)
        end

        if Modules.SpecPassive and Modules.SpecPassive.Passives then
            for k in pairs(Modules.SpecPassive.Passives) do table.insert(Tables.SpecPassive, k) end
            table.sort(Tables.SpecPassive)
        end

        if Modules.Quests and Modules.Quests.Questlines then
            for k in pairs(Modules.Quests.Questlines) do table.insert(Tables.QuestlineList, k) end
            table.sort(Tables.QuestlineList)
        end

        pcall(function()
            for _, v in ipairs(PATH.InteractNPCs:GetChildren()) do table.insert(Tables.AllNPCList, v.Name) end
        end)

        local allSets  = {}; if Modules.ArtifactConfig and Modules.ArtifactConfig.Sets then for k in pairs(Modules.ArtifactConfig.Sets)  do table.insert(allSets,  k) end end
        local allStats = {}; if Modules.ArtifactConfig and Modules.ArtifactConfig.Stats then for k in pairs(Modules.ArtifactConfig.Stats) do table.insert(allStats, k) end end
    end)
end)
-- ===== UTILITY FUNCTIONS =====
local function ToSet(v)
    if type(v) ~= "table" then return {[v] = true} end
    local s = {}
    for k, val in pairs(v) do
        if type(k) == "number" then s[val] = true else s[k] = val end
    end
    return s
end

local function GetSessionTime()
    local s = os.time() - Script_Start_Time
    return string.format("%dh %02dm", math.floor(s/3600), math.floor((s%3600)/60))
end

local function CommaFormat(n)
    return tostring(n):reverse():gsub("%d%d%d","%1,"):reverse():gsub("^,","")
end

local function Abbreviate(n)
    for _, v in ipairs({{1e12,"T"},{1e9,"B"},{1e6,"M"},{1e3,"K"}}) do
        if n >= v[1] then return string.format("%.1f%s", n/v[1], v[2]) end
    end
    return tostring(n)
end

local function Clean(str) return str:gsub("%s+",""):lower() end

local function GetCharacter()
    local c = Plr.Character
    return (c and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChildOfClass("Humanoid")) and c or nil
end

local function IsBusy()
    return Plr.Character and Plr.Character:FindFirstChildOfClass("ForceField") ~= nil
end

local function GetNearestIsland(targetPos, npcName)
    if npcName and Shared.BossTIMap[npcName] then return Shared.BossTIMap[npcName] end
    local best, minDist = "Starter", math.huge
    for name, crystal in pairs(IslandCrystals) do
        if crystal then
            local d = (targetPos - crystal:GetPivot().Position).Magnitude
            if d < minDist then minDist = d; best = name end
        end
    end
    return best
end

local function GetToolTypeFromModule(toolName)
    local cleaned = Clean(toolName)
    for mName, toolType in pairs(Tables.ManualWeaponClass) do
        if Clean(mName) == cleaned then return toolType end
    end
    if Modules.WeaponClass and Modules.WeaponClass.Tools then
        for mName, toolType in pairs(Modules.WeaponClass.Tools) do
            if Clean(mName) == cleaned then return toolType end
        end
    end
    if toolName:lower():find("fruit") then return "Power" end
    return "Melee"
end

local function IsSmartMatch(npcName, target)
    local n, t = npcName:gsub("%d+$",""):lower(), target:lower()
    return n == t or t:find(n) == 1 or n:find(t) == 1
end

local function IsStrictBossMatch(npcName, displayName)
    local n = npcName:lower():gsub("%s+","")
    local t = displayName:lower():gsub("%s+","")
    if n:find("true") and not t:find("true") then return false end
    if t:find("strongest") then
        local era = t:find("history") and "history" or "today"
        return n:find("strongest") and n:find(era)
    end
    return n:find(t)
end

local function GetRemoteBossArg(name)
    local map = {strongestinhistory="StrongestHistory",strongestoftoday="StrongestToday",strongesthistory="StrongestHistory",strongesttoday="StrongestToday"}
    return map[name:lower()] or name
end

local function GetCurrentPity()
    local lbl = PGui.BossUI.MainFrame.BossHPBar.Pity
    local cur, max = lbl.Text:match("Pity: (%d+)/(%d+)")
    return tonumber(cur) or 0, tonumber(max) or 25
end

local function SafeLoop(name, func)
    return function()
        local ok, err = pcall(func)
        if not ok then
            window:Notify({Title="Error ["..name.."]", Description=tostring(err), Duration=8})
            warn("Error in ["..name.."]: "..tostring(err))
        end
    end
end

local function Thread(featurePath, featureFunc, isEnabled, ...)
    local parts = featurePath:split(".")
    local cur = Flags
    for i = 1, #parts - 1 do
        local p = parts[i]
        if not cur[p] then cur[p] = {} end
        cur = cur[p]
    end
    local key = parts[#parts]
    local active = cur[key]
    if isEnabled then
        if not active or coroutine.status(active) == "dead" then
            cur[key] = task.spawn(featureFunc, ...)
        end
    else
        if active and typeof(active) == "thread" then
            task.cancel(active); cur[key] = nil
        end
    end
end

local function Cleanup(tbl)
    for k, v in pairs(tbl) do
        if typeof(v) == "RBXScriptConnection" then v:Disconnect(); tbl[k] = nil
        elseif typeof(v) == "thread" then task.cancel(v); tbl[k] = nil
        elseif type(v) == "table" then Cleanup(v) end
    end
end

local function DisableIdled()
    pcall(function()
        local cons = getconnections or get_signal_cons
        if cons then
            for _, v in pairs(cons(Plr.Idled)) do
                if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end
            end
        end
    end)
end

local function gsc(guiObject)
    if not guiObject then return false end
    local ok = false
    pcall(function()
        if Services.GuiService and Services.VirtualInputManager then
            Services.GuiService.SelectedObject = guiObject
            task.wait(0.05)
            for _, key in ipairs({Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter, Enum.KeyCode.ButtonA}) do
                Services.VirtualInputManager:SendKeyEvent(true, key, false, game); task.wait(0.03)
                Services.VirtualInputManager:SendKeyEvent(false, key, false, game); task.wait(0.03)
            end
            Services.GuiService.SelectedObject = nil
            ok = true
        end
    end)
    return ok
end

local function GetSecondsFromTimer(text)
    local m, s = text:match("(%d+):(%d+)")
    return m and s and (tonumber(m)*60 + tonumber(s)) or nil
end

local function FormatSecondsToTimer(s)
    return string.format("Refresh: %02d:%02d", math.floor(s/60), s%60)
end

-- ===== NETWORK EVENT LISTENERS =====
Remotes.UpInventory.OnClientEvent:Connect(function(category, data)
    Shared.InventorySynced = true
    if category == "Items" then
        Shared.Cached_Inv = data or {}
        table.clear(Tables.OwnedItem)
        for _, item in pairs(data) do
            if not table.find(Tables.OwnedItem, item.name) then table.insert(Tables.OwnedItem, item.name) end
        end
        table.sort(Tables.OwnedItem)
    elseif category == "Runes" then
        table.clear(Tables.RuneList); table.insert(Tables.RuneList, "None")
        for name in pairs(data) do table.insert(Tables.RuneList, name) end
        table.sort(Tables.RuneList)
    elseif category == "Accessories" then
        Shared.Cached_Accessories = {}
        table.clear(Tables.OwnedAccessory)
        local seen = {}
        for _, item in ipairs(data) do
            Shared.Cached_Accessories[item.name] = (item.quantity or 0)
            if (item.enchantLevel or 0) < 10 and not seen[item.name] then
                table.insert(Tables.OwnedAccessory, item.name); seen[item.name] = true
            end
        end
        table.sort(Tables.OwnedAccessory)
    elseif category == "Sword" or category == "Melee" then
        Shared["RawWeap_"..category] = data or {}
        table.clear(Tables.OwnedWeapon); table.clear(Tables.AllOwnedWeapons)
        local seen1, seen2 = {}, {}
        for _, cat in pairs({"Sword","Melee"}) do
            for _, item in ipairs(Shared["RawWeap_"..cat] or {}) do
                if (item.blessingLevel or 0) < 10 and not seen1[item.name] then
                    table.insert(Tables.OwnedWeapon, item.name); seen1[item.name] = true
                end
                if not seen2[item.name] then
                    table.insert(Tables.AllOwnedWeapons, item.name); seen2[item.name] = true
                end
            end
        end
        table.sort(Tables.OwnedWeapon); table.sort(Tables.AllOwnedWeapons)
    end
end)

RS.Remotes.NotifyItemDrop.OnClientEvent:Connect(function(data)
    if not data or type(data) ~= "table" or not data.name then return end
    NewItemsBuffer[data.name] = (NewItemsBuffer[data.name] or 0) + (data.quantity or 1)
end)

Remotes.StockUpdate.OnClientEvent:Connect(function(itemName, stockLeft)
    Shared.CurrentStock[itemName] = tonumber(stockLeft)
end)

Remotes.UpSkillTree.OnClientEvent:Connect(function(data)
    if data then Shared.SkillTree.Nodes = data.Nodes or {}; Shared.SkillTree.SkillPoints = data.SkillPoints or 0 end
end)

if Remotes.SettingsSync then
    Remotes.SettingsSync.OnClientEvent:Connect(function(data) Shared.Settings = data end)
end

Remotes.ArtifactSync.OnClientEvent:Connect(function(data)
    Shared.ArtifactSession.Inventory = data.Inventory
    Shared.ArtifactSession.Dust = data.Dust
end)

Remotes.TitleSync.OnClientEvent:Connect(function(data)
    if data and data.unlocked then Tables.UnlockedTitle = data.unlocked end
end)

Remotes.HakiStateUpdate.OnClientEvent:Connect(function(a, b)
    if a == false then Shared.ArmHaki = false return end
    if a == Plr then Shared.ArmHaki = b end
end)

if Remotes.BossUIUpdate then
    Remotes.BossUIUpdate.OnClientEvent:Connect(function(mode, data)
        if mode == "DamageStats" and data.stats then
            for _, info in pairs(data.stats) do
                if info.player and info.player:IsA("Player") then
                    Shared.AltDamage[info.player.Name] = tonumber(info.percent) or 0
                end
            end
        end
    end)
end

Remotes.TradeUpdated.OnClientEvent:Connect(function(data) Shared.TradeState = data end)

PATH.Mobs.ChildRemoved:Connect(function(child)
    if child:IsA("Model") and child.Name:lower():find("boss") then
        table.clear(Shared.AltDamage); Shared.AltActive = false
    end
end)

Remotes.SpecPassiveUpdate.OnClientEvent:Connect(function(data)
    if type(Shared.Passives) ~= "table" then Shared.Passives = {} end
    if data and data.Passives then
        for weapName, info in pairs(data.Passives) do
            Shared.Passives[weapName] = type(info) == "table" and info or {Name = tostring(info), RolledBuffs = {}}
        end
    end
end)

Remotes.UpStatReroll.OnClientEvent:Connect(function(data)
    if data and data.Stats then Shared.GemStats = data.Stats end
end)

Remotes.UpPlayerStats.OnClientEvent:Connect(function(data)
    if data and data.Stats then Shared.Stats = data.Stats end
end)

Remotes.UpAscend.OnClientEvent:Connect(function(data)
    if not (Toggles.AutoAscend and Toggles.AutoAscend.Value) then return end
    if data.isMaxed then
        if Toggles.AutoAscend then Toggles.AutoAscend.Value = false end
        return
    end
    if data.allMet then
        window:Notify({Title="Ascend", Description="All requirements met! Ascending to: "..tostring(data.nextRankName), Duration=5})
        Remotes.Ascend:FireServer(); task.wait(1)
    end
end)

-- ===== CORE FEATURE FUNCTIONS =====
local function UpdateNPCLists()
    local special = {"ThiefBoss","MonkeyBoss","DesertBoss","SnowBoss","PandaMiniBoss"}
    local current = {}
    for _, n in pairs(Tables.MobList) do current[n] = true end
    for _, v in pairs(PATH.Mobs:GetChildren()) do
        local clean = v.Name:gsub("%d+$","")
        if (table.find(special, clean) or not clean:find("Boss")) and not current[clean] then
            table.insert(Tables.MobList, clean); current[clean] = true
            local best, minD = "Unknown", math.huge
            for iname, crystal in pairs(IslandCrystals) do
                if crystal then
                    local d = (v:GetPivot().Position - crystal:GetPivot().Position).Magnitude
                    if d < minD then minD = d; best = iname end
                end
            end
            Tables.MobToIsland[clean] = best
        end
    end
end

local function UpdateAllEntities()
    table.clear(Tables.AllEntitiesList)
    local unique = {}
    for _, v in pairs(PATH.Mobs:GetChildren()) do
        local c = v.Name:gsub("%d+$","")
        if not unique[c] then unique[c] = true; table.insert(Tables.AllEntitiesList, c) end
    end
    table.sort(Tables.AllEntitiesList)
end

local function PopulateNPCLists()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name:match("^QuestNPC%d+$") and not table.find(Tables.NPC_QuestList, child.Name) then
            table.insert(Tables.NPC_QuestList, child.Name)
        end
    end
    for _, child in ipairs(PATH.InteractNPCs:GetChildren()) do
        if child.Name:match("^QuestNPC%d+$") and not table.find(Tables.NPC_QuestList, child.Name) then
            table.insert(Tables.NPC_QuestList, child.Name)
        end
        local n = child.Name
        if (n:find("Moveset") or n:find("Buyer")) and not n:find("Observation") then
            table.insert(Tables.NPC_MovesetList, n)
        end
        if (n:find("Mastery") or n:find("Questline") or n:find("Craft")) and not (n:find("Grail") or n:find("Slime")) then
            table.insert(Tables.NPC_MasteryList, n)
        end
    end
    table.sort(Tables.NPC_QuestList, function(a,b)
        local na = tonumber(a:match("%d+$")) or 0
        local nb = tonumber(b:match("%d+$")) or 0
        return na ~= nb and na < nb or a < b
    end)
    table.sort(Tables.NPC_MovesetList); table.sort(Tables.NPC_MasteryList)
end

local function SafeTeleportToNPC(targetName, customMap)
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local actual = (customMap and customMap[targetName]) or targetName
    local target = workspace:FindFirstChild(actual) or PATH.InteractNPCs:FindFirstChild(actual)
    if not target then
        for _, v in pairs(PATH.InteractNPCs:GetChildren()) do
            if v.Name:find(actual) then target = v break end
        end
    end
    if target then
        root.CFrame = target:GetPivot() * CFrame.new(0, 3, 0)
        root.AssemblyLinearVelocity = Vector3.zero
    else
        window:Notify({Title="TP Failed", Description="NPC not found: "..tostring(actual), Duration=3})
    end
end

local function HybridMove(targetCF)
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local dist = (root.Position - targetCF.Position).Magnitude
    local speed = Options.TweenSpeed or 180
    if dist > (Options.TargetDistTP or 0) then
        local tweenTarget = targetCF * CFrame.new(0, 0, 150)
        local duration = (root.Position - tweenTarget.Position).Magnitude / speed
        local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = tweenTarget})
        tw:Play(); tw.Completed:Wait(); task.wait(0.1)
    end
    root.CFrame = targetCF
    root.AssemblyLinearVelocity = Vector3.new(0, 0.01, 0)
    task.wait(0.2)
end

local function GetAllWeapons()
    local list = {}
    local seen = {}

    local plr = game.Players.LocalPlayer
    local char = plr.Character
    local backpack = plr.Backpack

    local containers = {backpack}
    if char then table.insert(containers, char) end

    for _, container in ipairs(containers) do
        for _, tool in ipairs(container:GetChildren()) do
            if tool:IsA("Tool") and not seen[tool.Name] then
                seen[tool.Name] = true
                table.insert(list, tool.Name)
            end
        end
    end

    table.sort(list)
    return list
end

local function ForceEquip(weaponName)
    local plr = game.Players.LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")

    if not hum then return end

    -- find tool (retry system 🔥)
    local tool
    for i = 1, 5 do
        tool = plr.Backpack:FindFirstChild(weaponName) or char:FindFirstChild(weaponName)
        if tool then break end
        task.wait(0.2)
    end

    if not tool then
        warn("❌ Weapon NOT found:", weaponName)
        return
    end

    -- already equipped
    if tool.Parent == char then
        return
    end

    -- FORCE EQUIP (most reliable way)
    hum:UnequipTools()
    task.wait(0.1)

    tool.Parent = char
    task.wait(0.1)

    hum:EquipTool(tool)

    print("✅ Equipped:", weaponName)
end


local CurrentWeaponIndex = 1

local function AutoEquipWeapon()
    local selected = Options.SelectedWeapons or {}
    local weapons = {}

    for name, v in pairs(selected) do
        if v then
            table.insert(weapons, name)
        end
    end

    if #weapons == 0 then return end

    if CurrentWeaponIndex > #weapons then
        CurrentWeaponIndex = 1
    end

    local weaponName = weapons[CurrentWeaponIndex]

    ForceEquip(weaponName)

    CurrentWeaponIndex += 1
end



local function CheckObsHaki()
    local DodgeUI = PGui:FindFirstChild("DodgeCounterUI")
    return DodgeUI and DodgeUI:FindFirstChild("MainFrame") and DodgeUI.MainFrame.Visible or false
end

local function CheckArmHaki()
    if Shared.ArmHaki then return true end
    local char = GetCharacter()
    if char then
        local la = char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm")
        local ra = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm")
        if (la and la:FindFirstChild("Lightning Strike")) or (ra and ra:FindFirstChild("Lightning Strike")) then
            Shared.ArmHaki = true; return true
        end
    end
    return false
end

local function IsSkillReady(key)
    local char = GetCharacter()
    local tool = char and char:FindFirstChildOfClass("Tool")
    if not tool then return true end
    local mainFrame = PGui:FindFirstChild("CooldownUI") and PGui.CooldownUI:FindFirstChild("MainFrame")
    if not mainFrame then return true end
    local cleanTool = Clean(tool.Name)
    local keyMap = {Z="Z", X="X", C="C", V="V", F="F"}
    for _, frame in pairs(mainFrame:GetChildren()) do
        if not frame:IsA("Frame") then continue end
        local fname = frame.Name:lower()
        if fname:find("cooldown") and (fname:find(cleanTool) or fname:find("skill")) then
            local mapped = "none"
            if fname:find("skill 1") or fname:find("_z") then mapped = "Z"
            elseif fname:find("skill 2") or fname:find("_x") then mapped = "X"
            elseif fname:find("skill 3") or fname:find("_c") then mapped = "C"
            elseif fname:find("skill 4") or fname:find("_v") then mapped = "V"
            elseif fname:find("skill 5") or fname:find("_f") then mapped = "F" end
            if mapped == key then
                local lbl = frame:FindFirstChild("WeaponNameAndCooldown", true)
                return lbl and lbl.Text:find("Ready") or true
            end
        end
    end
    return true
end

-- ===== AUTOFARM TARGET LOGIC =====
local function IsValidTarget(npc)
    if not npc or not npc.Parent then return false end
    local hum = npc:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    if npc:FindFirstChild("IK_Active") then return true end
    local minMaxHP = tonumber(Options.InstaKillMinHP) or 0
    local eligible = (Toggles.InstaKill and Toggles.InstaKill.Value) and hum.MaxHealth >= minMaxHP
    return eligible and (hum.Health > 0 or npc == Shared.Target) or hum.Health > 0
end

local function GetBestMobCluster(nameDict)
    local all = {}
    if type(nameDict) ~= "table" then return nil end
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            local clean = npc.Name:gsub("%d+$","")
            if nameDict[clean] and IsValidTarget(npc) then table.insert(all, npc) end
        end
    end
    if #all == 0 then return nil end
    local best, maxNear = all[1], 0
    for _, a in ipairs(all) do
        local count, posA = 0, a:GetPivot().Position
        for _, b in ipairs(all) do if (posA - b:GetPivot().Position).Magnitude <= 35 then count += 1 end end
        if count > maxNear then maxNear = count; best = a end
    end
    return best, maxNear
end

local function GetMobTarget()
    if not (Toggles.MobFarm and Toggles.MobFarm.Value) then Shared.MobIdx = 1 return nil end
    local selected = Options.SelectedMob or {}
    local enabled = {}
    for mob, on in pairs(selected) do if on then table.insert(enabled, mob) end end
    table.sort(enabled)
    if #enabled == 0 then return nil end
    if Shared.MobIdx > #enabled then Shared.MobIdx = 1 end
    local name = enabled[Shared.MobIdx]
    local target = GetBestMobCluster({[name]=true})
    if target then return target, GetNearestIsland(target:GetPivot().Position, target.Name), "Mob"
    else Shared.MobIdx += 1 return nil end
end

local function GetAllMobTarget()
    if not (Toggles.AllMobFarm and Toggles.AllMobFarm.Value) then Shared.AllMobIdx = 1 return nil end
    local list = {}
    for _, n in ipairs(Tables.MobList) do if n ~= "TrainingDummy" then table.insert(list, n) end end
    if #list == 0 then return nil end
    if Shared.AllMobIdx > #list then Shared.AllMobIdx = 1 end
    local target = GetBestMobCluster({[list[Shared.AllMobIdx]]=true})
    if target then return target, GetNearestIsland(target:GetPivot().Position), "Mob"
    else Shared.AllMobIdx += 1 return nil end
end

local function GetWorldBossTarget()
    if Toggles.AllBossesFarm and Toggles.AllBossesFarm.Value then
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if npc.Name:find("Boss") and not table.find(Tables.MiniBossList, npc.Name) and IsValidTarget(npc) then
                local island = "Boss"
                for dName, iName in pairs(Shared.BossTIMap) do
                    if IsStrictBossMatch(npc.Name, dName) then island = iName break end
                end
                return npc, island, "Boss"
            end
        end
    end
    if Toggles.BossesFarm and Toggles.BossesFarm.Value then
        local selected = Options.SelectedBosses or {}
        for bossName, on in pairs(selected) do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if IsStrictBossMatch(npc.Name, bossName) and not table.find(Tables.MiniBossList, npc.Name) and IsValidTarget(npc) then
                        return npc, Shared.BossTIMap[bossName] or "Boss", "Boss"
                    end
                end
            end
        end
    end
    return nil
end

local function FireBossRemote(bossName, diff)
    local low = bossName:lower():gsub("%s+","")
    table.clear(Shared.AltDamage)
    local function getInternalId(name)
        local ct = name:lower():gsub("%s+","")
        for dName, id in pairs(SummonMap) do
            if dName:lower():gsub("%s+","") == ct then return id end
        end
        return name:gsub("%s+","") .. "Boss"
    end
    pcall(function()
        if low:find("rimuru") then Remotes.RimuruBoss:FireServer(diff)
        elseif low:find("anos") then Remotes.AnosBoss:FireServer("Anos", diff)
        elseif low:find("trueaizen") then if Remotes.TrueAizenBoss then Remotes.TrueAizenBoss:FireServer(diff) end
        elseif low:find("strongest") then Remotes.JJKSummonBoss:FireServer(GetRemoteBossArg(bossName), diff)
        else Remotes.SummonBoss:FireServer(getInternalId(bossName), diff) end
    end)
end

local function GetSummonTarget()
    if not (Toggles.SummonBossFarm and Toggles.SummonBossFarm.Value) then return nil end
    local selected = Options.SelectedSummon
    if not selected then return nil end
    local wName = SummonMap[selected] or (selected .. "Boss")
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc.Name:lower():find(wName:lower()) and IsValidTarget(npc) then
            return npc, "Boss", "Boss"
        end
    end
    return nil
end

local function GetOtherTarget()
    if not (Toggles.OtherSummonFarm and Toggles.OtherSummonFarm.Value) then return nil end
    local selected = Options.SelectedOtherSummon
    if not selected then return nil end
    local ls = selected:lower()
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        local n = npc.Name:lower()
        local match = ls:find("strongest") and n:find("strongest") and
            ((ls:find("history") and n:find("history")) or (ls:find("today") and n:find("today")))
            or n:find(ls)
        if match and IsValidTarget(npc) then
            return npc, GetNearestIsland(npc:GetPivot().Position, npc.Name), "Boss"
        end
    end
    return nil
end

local function GetPityTarget()
    if not (Toggles.PityBossFarm and Toggles.PityBossFarm.Value) then return nil end
    local cur, max = GetCurrentPity()
    local useName = Options.SelectedUsePity
    if not useName then return nil end
    local buildBosses = Options.SelectedBuildPity or {}
    if cur >= (max - 1) then
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if IsStrictBossMatch(npc.Name, useName) and IsValidTarget(npc) then
                return npc, Shared.BossTIMap[useName] or "Boss", "Boss"
            end
        end
    else
        for bossName, on in pairs(buildBosses) do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if IsStrictBossMatch(npc.Name, bossName) and IsValidTarget(npc) then
                        return npc, Shared.BossTIMap[bossName] or "Boss", "Boss"
                    end
                end
            end
        end
    end
    return nil
end

local function GetBestQuestNPC()
    local playerLevel = Plr.Data.Level.Value
    local best, highestLevel = "QuestNPC1", -1
    for npcId, qData in pairs(Modules.Quests.RepeatableQuests) do
        local req = qData.recommendedLevel or 0
        if playerLevel >= req and req > highestLevel then highestLevel = req; best = npcId end
    end
    return best
end

local function EnsureQuestSettings()
    local settings = PGui.SettingsUI.MainFrame.Frame.Content.SettingsTabFrame
    local t1 = settings:FindFirstChild("Toggle_EnableQuestRepeat", true)
    if t1 and t1.SettingsHolder.Off.Visible then Remotes.SettingsToggle:FireServer("EnableQuestRepeat", true); task.wait(0.3) end
    local t2 = settings:FindFirstChild("Toggle_AutoQuestRepeat", true)
    if t2 and t2.SettingsHolder.Off.Visible then Remotes.SettingsToggle:FireServer("AutoQuestRepeat", true) end
end

local function UpdateQuest()
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then return end
    EnsureQuestSettings()
    local target = GetBestQuestNPC()
    local questUI = PGui.QuestUI.Quest
    if Shared.QuestNPC ~= target or not questUI.Visible then
        Remotes.QuestAbandon:FireServer("repeatable")
        local t = 0
        while questUI.Visible and t < 15 do task.wait(0.2); t += 1 end
        Remotes.QuestAccept:FireServer(target)
        t = 0
        while not questUI.Visible and t < 20 do
            task.wait(0.2); t += 1
            if t % 5 == 0 then Remotes.QuestAccept:FireServer(target) end
        end
        if questUI.Visible then Shared.QuestNPC = target end
    end
end

local function GetLevelFarmTarget()
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then return nil end
    UpdateQuest()
    if not PGui.QuestUI.Quest.Visible then return nil end
    local qData = Modules.Quests.RepeatableQuests[Shared.QuestNPC]
    if not qData or not qData.requirements[1] then return nil end
    local targetType = qData.requirements[1].npcType
    local matches = {}
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            if IsSmartMatch(npc.Name, targetType) then matches[npc.Name:gsub("%d+$","")] = true end
        end
    end
    local best = GetBestMobCluster(matches)
    if best then return best, GetNearestIsland(best:GetPivot().Position, best.Name), "Mob" end
    return nil
end

local function ShouldMainWait()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then return false end
    for i = 1, 5 do
        local val = Options["SelectedAlt_"..i]
        local name = (typeof(val) == "Instance" and val:IsA("Player")) and val.Name or tostring(val)
        if name and name ~= "" and name ~= "nil" and name ~= "None" then
            if (Shared.AltDamage[name] or 0) < 10 then return true end
        end
    end
    return false
end

local function GetAltHelpTarget()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then return nil end
    local targetBoss = Options.SelectedAltBoss
    if not targetBoss then return nil end
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if IsStrictBossMatch(npc.Name, targetBoss) and IsValidTarget(npc) then
            Shared.AltActive = ShouldMainWait()
            return npc, Shared.BossTIMap[targetBoss] or "Boss", "Boss"
        end
    end
    FireBossRemote(targetBoss, Options.SelectedAltDiff or "Normal"); task.wait(0.5)
    return nil
end

local function HandleSummons()
    if Shared.MerchantBusy then return end
    local function MatchName(a, b) return a and b and a:lower():gsub("%s+","") == b:lower():gsub("%s+","") end

    if Toggles.PityBossFarm and Toggles.PityBossFarm.Value then
        local cur, max = GetCurrentPity()
        local useName = Options.SelectedUsePity
        local buildOpts = Options.SelectedBuildPity or {}
        if useName then
            if cur >= (max - 1) then
                local found = false
                for _, v in pairs(PATH.Mobs:GetChildren()) do if MatchName(v.Name, useName) then found = true break end end
                if not found then FireBossRemote(useName, Options.SelectedPityDiff or "Normal"); task.wait(0.5) return end
            else
                local anySpawned = false
                for bossName, on in pairs(buildOpts) do
                    if on then
                        for _, v in pairs(PATH.Mobs:GetChildren()) do if MatchName(v.Name, bossName) then anySpawned = true break end end
                    end
                    if anySpawned then break end
                end
                if not anySpawned then
                    for bossName, on in pairs(buildOpts) do
                        if on then FireBossRemote(bossName, "Normal"); task.wait(0.5) return end
                    end
                end
            end
        end
    end

    if Toggles.AutoOtherSummon and Toggles.AutoOtherSummon.Value then
        local sel = Options.SelectedOtherSummon
        if sel then
            local found = false
            for _, v in pairs(PATH.Mobs:GetChildren()) do if v.Name:lower():find(sel:lower()) then found = true break end end
            if not found then FireBossRemote(sel, Options.SelectedOtherSummonDiff or "Normal"); task.wait(0.5) end
        end
    end

    if Toggles.AutoSummon and Toggles.AutoSummon.Value then
        local sel = Options.SelectedSummon
        if sel then
            local found = false
            for _, v in pairs(PATH.Mobs:GetChildren()) do if IsStrictBossMatch(v.Name, sel) then found = true break end end
            if not found then FireBossRemote(sel, Options.SelectedSummonDiff or "Normal"); task.wait(0.5) end
        end
    end
end

local function CheckTask(taskName)
    if taskName == "Merchant"      then return (Toggles.AutoMerchant and Toggles.AutoMerchant.Value and Shared.MerchantBusy) and {true, nil, "None"} or nil
    elseif taskName == "Pity Boss"      then return GetPityTarget()
    elseif taskName == "Summon [Other]" then return GetOtherTarget()
    elseif taskName == "Summon"         then return GetSummonTarget()
    elseif taskName == "Boss"           then return GetWorldBossTarget()
    elseif taskName == "Level Farm"     then return GetLevelFarmTarget()
    elseif taskName == "All Mob Farm"   then return GetAllMobTarget()
    elseif taskName == "Mob"            then return GetMobTarget()
    elseif taskName == "Alt Help"       then return GetAltHelpTarget()
    end
    return nil
end

local function GetBestOwnedTitle(category)
    if #Tables.UnlockedTitle == 0 then return nil end
    local statMap = {["Best EXP"]="XPPercent",["Best Money & Gem"]="MoneyPercent",["Best Luck"]="LuckPercent",["Best DMG"]="DamagePercent"}
    local targetStat = statMap[category]
    if not targetStat then return nil end
    local bestId, highest = nil, -1
    for _, id in ipairs(Tables.UnlockedTitle) do
        local data = Modules.Title.Titles[id]
        if data and data.statBonuses and (data.statBonuses[targetStat] or 0) > highest then
            highest = data.statBonuses[targetStat]; bestId = id
        end
    end
    return bestId
end

local function UpdateSwitchState(target, farmType)
    if Shared.GlobalPrio == "COMBO" then return end
    local types = {
        {id="Title", remote=Remotes.EquipTitle, method=function(v) return v end},
        {id="Rune",  remote=Remotes.EquipRune,  method=function(v) return {"Equip", v} end},
        {id="Build", remote=Remotes.LoadoutLoad, method=function(v) return tonumber(v) end},
    }
    for _, sw in ipairs(types) do
        local tog = Toggles["Auto"..sw.id]
        if not (tog and tog.Value) then continue end
        if sw.id == "Build" and tick() - Shared.LastBuildSwitch < 3.1 then continue end
        local threshold = Options[sw.id.."_BossHPAmt"] or 15
        local isLow = false
        if farmType == "Boss" and target then
            local hum = target:FindFirstChildOfClass("Humanoid")
            if hum then isLow = (hum.Health / hum.MaxHealth * 100) <= threshold end
        end
        local toEquip = ""
        if farmType == "None" then toEquip = Options["Default"..sw.id] or ""
        elseif farmType == "Mob"  then toEquip = Options[sw.id.."_Mob"] or ""
        elseif farmType == "Boss" then toEquip = (isLow and Options[sw.id.."_BossHP"] or Options[sw.id.."_Boss"]) or "" end
        if not toEquip or toEquip == "" or toEquip == "None" then continue end
        local final = toEquip
        if sw.id == "Title" and toEquip:find("Best ") then
            final = GetBestOwnedTitle(toEquip)
            if not final then continue end
        end
        if final ~= Shared.LastSwitch[sw.id] then
            local args = sw.method(final)
            pcall(function()
                if type(args) == "table" then sw.remote:FireServer(unpack(args))
                else sw.remote:FireServer(args) end
            end)
            Shared.LastSwitch[sw.id] = final
            if sw.id == "Build" then Shared.LastBuildSwitch = tick() end
        end
    end
end

local function ExecuteFarmLogic(target, island, farmType)
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not target or Shared.Recovering or not root then return end
    if Shared.MovingIsland then return end
    Shared.Target = target
    Shared.AltActive = (Toggles.AltBossFarm and Toggles.AltBossFarm.Value and farmType == "Boss") and ShouldMainWait() or false

    if Toggles.IslandTP and Toggles.IslandTP.Value then
        if island and island ~= "" and island ~= "Unknown" and island ~= Shared.Island then
            Shared.MovingIsland = true
            Remotes.TP_Portal:FireServer(island)
            task.wait(Options.IslandTPCD or 0.8)
            Shared.Island = island; Shared.MovingIsland = false; return
        end
    end

    local targetPos = target:GetPivot().Position
    local dist = Options.Distance or 12
    local posType = Options.SelectedFarmType or "Behind"
    local finalPos

    if Shared.AltActive then finalPos = targetPos + Vector3.new(0, 120, 0)
    elseif posType == "Above" then finalPos = targetPos + Vector3.new(0, dist, 0)
    elseif posType == "Below" then finalPos = targetPos + Vector3.new(0, -dist, 0)
    else finalPos = (target:GetPivot() * CFrame.new(0, 0, dist)).Position end

    local dest = CFrame.lookAt(finalPos, targetPos)
    if (root.Position - finalPos).Magnitude > 0.1 then
        if (Options.SelectedMovementType or "Tween") == "Teleport" then
            root.CFrame = dest
        else
            local speed = Options.TweenSpeed or 160
            TweenService:Create(root, TweenInfo.new((root.Position - finalPos).Magnitude / speed, Enum.EasingStyle.Linear), {CFrame = dest}):Play()
        end
    end
    root.AssemblyLinearVelocity  = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end

-- ===== SAFETY / PLAYER FEATURES =====
local TargetGroupId = 1002185259
local BannedRanks   = {255, 254, 175, 150}


local function CheckPlayerForSafety(p)
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) or p == Plr then return end
    local types = Options.SelectedKickType or {}
    if types["Player Join"] then
        task.wait(0.5); Plr:Kick("\n[fk taolao]\nReason: Player joined ("..p.Name..")")
        return
    end
    if types["Mod"] then
        local ok, rank = pcall(function() return p:GetRankInGroup(TargetGroupId) end)
        if ok and table.find(BannedRanks, rank) then
            task.wait(0.5); Plr:Kick("\n[fk taolao]\nReason: Moderator Detected ("..p.Name..")")
        end
    end
end

local function CheckServerTypeSafety()
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) then return end
    local types = Options.SelectedKickType or {}
    if not types["Public Server"] then return end
    local ok, serverType = pcall(function()
        local remote = game:GetService("RobloxReplicatedStorage"):WaitForChild("GetServerType", 2)
        return remote and remote:InvokeServer() or "Unknown"
    end)
    if ok and serverType ~= "VIPServer" then
        task.wait(0.8); Plr:Kick("\n[fk taolao]\nReason: You are in a public server.")
    end
end

local function InitAutoKick()
    CheckServerTypeSafety()
    for _, p in ipairs(Players:GetPlayers()) do CheckPlayerForSafety(p) end
    Players.PlayerAdded:Connect(CheckPlayerForSafety)
end

local function PanicStop()
    Shared.Farm = false; Shared.AltActive = false; Shared.GlobalPrio = "FARM"
    Shared.Target = nil; Shared.MovingIsland = false
    for k, tog in pairs(Toggles) do
        if type(tog) == "table" and tog.Value ~= nil then tog.Value = false end
    end
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.AssemblyLinearVelocity  = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = root.CFrame * CFrame.new(0, 2, 0)
    end
    task.delay(0.5, function() Shared.Farm = true end)
    window:Notify({Title="Stopped", Description="All features paused.", Duration=5})
end

-- ===== FPS / GRAPHICS FEATURES =====
local function ApplyFPSBoost(state)
    if not state then return end
    pcall(function()
        Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.Brightness = 1
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostProcessEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then v.Enabled = false end
        end
        task.spawn(function()
            for i, v in pairs(workspace:GetDescendants()) do
                if Toggles.FPSBoost and not Toggles.FPSBoost.Value then break end
                pcall(function()
                    if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic; v.CastShadow = false
                    elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled = false end
                end)
                if i % 500 == 0 then task.wait() end
            end
        end)
    end)
end

local function ApplyIslandWipe()
    if not (Toggles.FPSBoost_AF and Toggles.FPSBoost_AF.Value) then return end
    task.spawn(function()
        local protect = {"SpawnPointCrystal_", "Portal_"}
        pcall(function()
            for _, folder in pairs(workspace:GetChildren()) do
                local n = folder.Name
                if folder:IsA("Folder") and (n:lower():find("island") or n == "HuecoMundo" or n == "ShibuyaStation") then
                    local desc = folder:GetDescendants()
                    for i, obj in ipairs(desc) do
                        if obj:IsA("Model") or obj:IsA("BasePart") then
                            local safe = false
                            for _, kw in ipairs(protect) do if obj.Name:find(kw) then safe = true break end end
                            if not safe then pcall(function() obj:Destroy() end) end
                        end
                        if i % 300 == 0 then task.wait() end
                    end
                end
            end
            for i, v in ipairs(workspace:GetChildren()) do
                local safe = v.Name:find("TimedBossSpawn_") or v.Name == Plr.Name or v.Name == "Main Temple"
                    or v.Name == "NPCs" or v.Name == "ServiceNPCs" or v.Name:find("QuestNPC")
                    or v:IsA("Camera") or v:IsA("Terrain") or v.Name:find("Portal_")
                if not safe and (v:IsA("Model") or v:IsA("BasePart")) then pcall(function() v:Destroy() end) end
                if i % 100 == 0 then task.wait() end
            end
        end)
    end)
end

-- ===== FEATURE LOOPS =====
local function FuncTPW()
    while true do
        local delta = RunService.Heartbeat:Wait()
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if char and hum and hum.Health > 0 and hum.MoveDirection.Magnitude > 0 then
            char:TranslateBy(hum.MoveDirection * (Options.TPWValue or 1) * delta * 10)
        end
    end
end

local function FuncNoclip()
    while Toggles.Noclip and Toggles.Noclip.Value do
        RunService.Stepped:Wait()
        local char = GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
            end
        end
    end
end

local function Func_AntiKnockback()
    if type(Connections.Knockback) == "table" then
        for _, c in pairs(Connections.Knockback) do if c then c:Disconnect() end end
        table.clear(Connections.Knockback)
    else Connections.Knockback = {} end
    local function applyAKB(character)
        if not character then return end
        local root = character:WaitForChild("HumanoidRootPart", 10)
        if root then
            local conn = root.ChildAdded:Connect(function(child)
                if not (Toggles.AntiKnockback and Toggles.AntiKnockback.Value) then return end
                if child:IsA("BodyVelocity") and child.MaxForce == Vector3.new(40000,40000,40000) then child:Destroy() end
            end)
            table.insert(Connections.Knockback, conn)
        end
    end
    if Plr.Character then applyAKB(Plr.Character) end
    local conn = Plr.CharacterAdded:Connect(function(c) applyAKB(c) end)
    table.insert(Connections.Knockback, conn)
    repeat task.wait(1) until not (Toggles.AntiKnockback and Toggles.AntiKnockback.Value)
    for _, c in pairs(Connections.Knockback) do if c then c:Disconnect() end end
    table.clear(Connections.Knockback)
end

local function Func_AutoReconnect()
    if Connections.Reconnect then Connections.Reconnect:Disconnect() end
    Connections.Reconnect = GuiService.ErrorMessageChanged:Connect(function()
        if not (Toggles.AutoReconnect and Toggles.AutoReconnect.Value) then return end
        task.delay(2, function()
            pcall(function()
                local promptOverlay = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                if promptOverlay then
                    local ep = promptOverlay.promptOverlay:FindFirstChild("ErrorPrompt")
                    if ep and ep.Visible then task.wait(5); TeleportService:Teleport(game.PlaceId, Plr) end
                end
            end)
        end)
    end)
end

local function Func_NoGameplayPaused()
    while Toggles.NoGameplayPaused and Toggles.NoGameplayPaused.Value do
        pcall(function()
            local p = game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/NetworkPause")
            if p then p:Destroy() end
        end)
        task.wait(1)
    end
end

local function Func_AutoHaki()
    while task.wait(0.5) do
        if Toggles.ObserHaki and Toggles.ObserHaki.Value and not CheckObsHaki() then
            Remotes.ObserHaki:FireServer("Toggle")
        end
        if Toggles.ArmHaki and Toggles.ArmHaki.Value and not CheckArmHaki() then
            Remotes.ArmHaki:FireServer("Toggle"); task.wait(0.5)
        end
        if Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value then
            if not (Toggles.OnlyTarget and Toggles.OnlyTarget.Value) or (Shared.Farm and Shared.Target and Shared.Target.Parent) then
                Remotes.ConquerorHaki:FireServer("Activate")
            end
        end
    end
end

local function Func_AutoM1()
    while task.wait(Options.M1Speed or 0.2) do
        if Toggles.AutoM1 and Toggles.AutoM1.Value then Remotes.M1:FireServer() end
    end
end

local function Func_KillAura()
    while Toggles.KillAura and Toggles.KillAura.Value do
        if IsBusy() then task.wait(0.1) continue end
        local nearest, maxRange = nil, Options.KillAuraRange or 200
        local char = Plr.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            for _, v in ipairs(workspace:WaitForChild("NPCs"):GetChildren()) do
                if v:IsA("Model") then
                    local d = (root.Position - v:GetPivot().Position).Magnitude
                    local hum = v:FindFirstChildOfClass("Humanoid")
                    if d <= maxRange and hum and hum.Health > 0 and d < maxRange then
                        maxRange = d; nearest = v
                    end
                end
            end
        end
        if nearest then EquipWeapon(); pcall(function() Remotes.M1:FireServer(nearest:GetPivot().Position) end) end
        task.wait(Options.KillAuraCD or 0.12)
    end
end

local function Func_AutoSkill()
    local keyToSlot = {Z=1, X=2, C=3, V=4, F=5}
    local keyToEnum = {Z=Enum.KeyCode.Z, X=Enum.KeyCode.X, C=Enum.KeyCode.C, V=Enum.KeyCode.V, F=Enum.KeyCode.F}
    local priority  = {"Z","X","C","V","F"}

    while task.wait() do
        if not (Toggles.AutoSkill and Toggles.AutoSkill.Value) then continue end

        local target = Shared.Target
        if Toggles.OnlyTarget and Toggles.OnlyTarget.Value and (not Shared.Farm or not target or not target.Parent) then continue end

        local canExec = true

        -- boss check
        if Toggles.AutoSkill_BossOnly and Toggles.AutoSkill_BossOnly.Value then
            if not target or not target.Parent then
                canExec = false
            else
                local hum = target:FindFirstChildOfClass("Humanoid")
                local isBoss = target.Name:find("Boss") and not table.find(Tables.MiniBossList, target.Name)
                local hp = hum and (hum.Health / hum.MaxHealth * 100) or 101

                if not isBoss or hp > (Options.AutoSkill_BossHP or 100) then
                    canExec = false
                end
            end
        end

        if canExec and target and target.Parent and target:FindFirstChild("IK_Active") and (Options.InstaKillType or "V1") == "V1" then
            canExec = false
        end

        if not canExec then continue end

        local char = GetCharacter()
        local tool = char and char:FindFirstChildOfClass("Tool")
        if not tool then continue end

        local selected = Options.SelectedSkills or {}
        local toolType = GetToolTypeFromModule(tool.Name)
        local mode     = Options.AutoSkillType or "Normal"

        -- DEBUG
        print("Selected Skills:", game:GetService("HttpService"):JSONEncode(selected))

        if mode == "Instant" then
            for _, key in ipairs(priority) do
                if selected[key] then
                    if toolType == "Power" then
                        Remotes.UseFruit:FireServer("UseAbility", {
                            FruitPower = tool.Name:gsub(" Fruit",""),
                            KeyCode = keyToEnum[key]
                        })
                    else
                        Remotes.UseSkill:FireServer(keyToSlot[key])
                    end
                end
            end
            task.wait(0.05)

        else
            for _, key in ipairs(priority) do
                if selected[key] then
                    -- 🔥 IGNORE BROKEN COOLDOWN CHECK
                    if toolType == "Power" then
                        Remotes.UseFruit:FireServer("UseAbility", {
                            FruitPower = tool.Name:gsub(" Fruit",""),
                            KeyCode = keyToEnum[key]
                        })
                    else
                        Remotes.UseSkill:FireServer(keyToSlot[key])
                    end

                    task.wait(0.15)
                end
            end
        end
    end
end

local function Func_AutoCombo()
    Shared.ComboIdx = 1
    while Toggles.AutoCombo and Toggles.AutoCombo.Value do
        task.wait(0.1)
        local raw = Options.ComboPattern or "Z>X>C>V>F"
        Shared.ParsedCombo = {}
        for item in raw:upper():gsub("%s+",""):gmatch("([^,>]+)") do table.insert(Shared.ParsedCombo, item) end
        if #Shared.ParsedCombo == 0 then continue end
        if Shared.ComboIdx > #Shared.ParsedCombo then Shared.ComboIdx = 1 end
        if IsBusy() then local t = tick() repeat task.wait(0.1) until not IsBusy() or tick()-t > 8 end
        task.wait(0.4)
        if Toggles.ComboBossOnly and Toggles.ComboBossOnly.Value then
            if not Shared.Target or not Shared.Target.Parent or not Shared.Target.Name:lower():find("boss") then
                Shared.ComboIdx = 1; task.wait(0.5); continue
            end
        end
        local action = Shared.ParsedCombo[Shared.ComboIdx]
        local waitTime = tonumber(action)
        if waitTime then
            if (Options.ComboMode or "Normal") == "Normal" then task.wait(waitTime) end
            Shared.ComboIdx += 1; continue
        end
        if IsSkillReady(action) then
            if action == "F" then
                Shared.GlobalPrio = "COMBO"
                local cTitle = Options.Title_Combo; local cRune = Options.Rune_Combo
                if cTitle and cTitle ~= "None" then Remotes.EquipTitle:FireServer(cTitle) end
                if cRune  and cRune  ~= "None" then Remotes.EquipRune:FireServer("Equip", cRune) end
                Shared.LastSwitch.Title = cTitle; Shared.LastSwitch.Rune = cRune
                task.wait(0.7)
                local confirmed = false
                repeat EquipWeapon(); Remotes.UseSkill:FireServer(5)
                    local t = tick()
                    repeat task.wait(0.1) if not IsSkillReady("F") then confirmed = true end until confirmed or tick()-t > 1
                until confirmed or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)
                local started = false; local ct = tick()
                repeat task.wait() if IsBusy() then started = true end until started or tick()-ct > 2
                if started then local ht = tick() repeat task.wait(0.1) until not IsBusy() or tick()-ht > 15 else task.wait(2.5) end
                Shared.GlobalPrio = "FARM"; Shared.LastSwitch.Title = ""; Shared.LastSwitch.Rune = ""
                Shared.ComboIdx += 1; task.wait(0.3)
            else
                local slot = ({Z=1,X=2,C=3,V=4})[action] or 1
                local done = false
                repeat Remotes.UseSkill:FireServer(slot)
                    local t = tick()
                    repeat task.wait(0.1) if not IsSkillReady(action) or IsBusy() then done = true end until done or tick()-t > 1.2
                until done or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)
                if done then Shared.ComboIdx += 1; task.wait(0.2) end
            end
        else task.wait(0.2) end
    end
end

local function Func_AutoStats()
    local MAX = 11500
    while task.wait(1) do
        if not (Toggles.AutoStats and Toggles.AutoStats.Value) then break end
        local pts = Plr:WaitForChild("Data"):WaitForChild("StatPoints").Value
        if pts > 0 then
            local selected = Options.SelectedStats or {}
            local active = {}
            for stat, on in pairs(selected) do
                if on and (Shared.Stats[stat] or 0) < MAX then table.insert(active, stat) end
            end
            if #active > 0 then
                local perStat = math.floor(pts / #active)
                if perStat > 0 then for _, s in ipairs(active) do Remotes.AddStat:FireServer(s, perStat) end
                else Remotes.AddStat:FireServer(active[1], pts) end
            end
        end
    end
end

local function AutoRollStatsLoop()
    local selStats = Options.SelectedGemStats or {}
    local selRanks = Options.SelectedRank     or {}
    local hasStat, hasRank = false, false
    for _ in pairs(selStats) do hasStat = true break end
    for _ in pairs(selRanks) do hasRank = true break end
    if not hasStat or not hasRank then
        window:Notify({Title="Error", Description="Select at least one stat and rank first!", Duration=5})
        if Toggles.AutoRollStats then Toggles.AutoRollStats.Value = false end; return
    end
    while Toggles.AutoRollStats and Toggles.AutoRollStats.Value do
        if not next(Shared.GemStats) then task.wait(0.1) continue end
        local done = true
        for _, statName in ipairs(Tables.GemStat) do
            if selStats[statName] then
                local cur = Shared.GemStats[statName]
                if cur and not selRanks[cur.Rank] then
                    done = false
                    pcall(function() Remotes.RerollSingleStat:InvokeServer(statName) end)
                    task.wait(Options.StatsRollCD or 0.1); break
                end
            end
        end
        if done then
            window:Notify({Title="Done", Description="Stats rolled successfully.", Duration=5})
            if Toggles.AutoRollStats then Toggles.AutoRollStats.Value = false end; break
        end
        task.wait()
    end
end

-- ROLLS (Trait / Race / Clan unified loop)
local function SyncTraitAutoSkip()
    if not (Toggles.AutoTrait and Toggles.AutoTrait.Value) then return end
    pcall(function()
        local selected = Options.SelectedTrait or {}
        local hier = {Epic=1, Legendary=2, Mythical=3, Secret=4}
        local lowest = 99
        for name, on in pairs(selected) do
            if on then
                local data = Modules.Trait.Traits[name]
                if data then local v = hier[data.Rarity] or 0; if v > 0 and v < lowest then lowest = v end end
            end
        end
        if lowest == 99 then return end
        Remotes.TraitAutoSkip:FireServer({Epic=1<lowest, Legendary=2<lowest, Mythical=3<lowest, Secret=4<lowest})
    end)
end

local function SyncRaceSettings()
    if not (Toggles.AutoRace and Toggles.AutoRace.Value) then return end
    pcall(function()
        local selected = Options.SelectedRace or {}
        local hasEpic, hasLeg = false, false
        for name, data in pairs(Modules.Race.Races) do
            local r = data.rarity or data.Rarity
            if r == "Mythical" then
                local skip = not selected[name]
                if Shared.Settings["SkipRace_"..name] ~= skip then Remotes.SettingsToggle:FireServer("SkipRace_"..name, skip) end
            end
            if selected[name] then
                if r == "Epic" then hasEpic = true end
                if r == "Legendary" then hasLeg = true end
            end
        end
        if Shared.Settings["SkipEpicReroll"]      ~= not hasEpic then Remotes.SettingsToggle:FireServer("SkipEpicReroll",      not hasEpic) end
        if Shared.Settings["SkipLegendaryReroll"]  ~= not hasLeg  then Remotes.SettingsToggle:FireServer("SkipLegendaryReroll", not hasLeg)  end
    end)
end

local function SyncClanSettings()
    if not (Toggles.AutoClan and Toggles.AutoClan.Value) then return end
    pcall(function()
        local selected = Options.SelectedClan or {}
        local hasEpic, hasLeg = false, false
        for name, data in pairs(Modules.Clan.Clans) do
            local r = data.rarity or data.Rarity
            if r == "Legendary" then
                local skip = not selected[name]
                if Shared.Settings["SkipClan_"..name] ~= skip then Remotes.SettingsToggle:FireServer("SkipClan_"..name, skip) end
            end
            if selected[name] then
                if r == "Epic" then hasEpic = true end
                if r == "Legendary" then hasLeg = true end
            end
        end
        if Shared.Settings["SkipEpicClan"]     ~= not hasEpic then Remotes.SettingsToggle:FireServer("SkipEpicClan",     not hasEpic) end
        if Shared.Settings["SkipLegendaryClan"] ~= not hasLeg  then Remotes.SettingsToggle:FireServer("SkipLegendaryClan",not hasLeg)  end
    end)
end

local function Func_UnifiedRollManager()
    while task.wait() do
        if Toggles.AutoTrait and Toggles.AutoTrait.Value then
            local traitUI = PGui:WaitForChild("TraitRerollUI").MainFrame.Frame.Content.TraitPage.TraitGottenFrame.Holder.Trait.TraitGotten
            local confirmFrame = PGui.TraitRerollUI.MainFrame.Frame.Content:FindFirstChild("AreYouSureYouWantToRerollFrame")
            local current = traitUI.Text
            local selected = Options.SelectedTrait or {}
            if selected[current] then
                window:Notify({Title="Trait", Description="Got: "..current, Duration=5})
                if Toggles.AutoTrait then Toggles.AutoTrait.Value = false end
            else
                pcall(SyncTraitAutoSkip)
                if confirmFrame and confirmFrame.Visible then Remotes.TraitConfirm:FireServer(true); task.wait(0.1) end
                Remotes.Roll_Trait:FireServer(); task.wait(Options.RollCD or 0.3)
            end
            continue
        end
        if Toggles.AutoRace and Toggles.AutoRace.Value then
            local cur = Plr:GetAttribute("CurrentRace")
            local sel = Options.SelectedRace or {}
            if sel[cur] then
                window:Notify({Title="Race", Description="Got: "..tostring(cur), Duration=5})
                if Toggles.AutoRace then Toggles.AutoRace.Value = false end
            else pcall(SyncRaceSettings); Remotes.UseItem:FireServer("Use","Race Reroll",1); task.wait(Options.RollCD or 0.3) end
            continue
        end
        if Toggles.AutoClan and Toggles.AutoClan.Value then
            local cur = Plr:GetAttribute("CurrentClan")
            local sel = Options.SelectedClan or {}
            if sel[cur] then
                window:Notify({Title="Clan", Description="Got: "..tostring(cur), Duration=5})
                if Toggles.AutoClan then Toggles.AutoClan.Value = false end
            else pcall(SyncClanSettings); Remotes.UseItem:FireServer("Use","Clan Reroll",1); task.wait(Options.RollCD or 0.3) end
            continue
        end
        task.wait(0.4)
    end
end

local function EnsureRollManager()
    local active = (Toggles.AutoTrait and Toggles.AutoTrait.Value) or
                   (Toggles.AutoRace  and Toggles.AutoRace.Value)  or
                   (Toggles.AutoClan  and Toggles.AutoClan.Value)
    Thread("UnifiedRollManager", Func_UnifiedRollManager, active)
end

-- SPEC PASSIVE
local function SyncSpecPassiveAutoSkip()
    pcall(function()
        if Remotes.SpecPassiveSkip then
            Remotes.SpecPassiveSkip:FireServer({Epic=true, Legendary=true, Mythical=true})
        end
    end)
end

local function AutoSpecPassiveLoop()
    pcall(SyncSpecPassiveAutoSkip); task.wait(Options.SpecRollCD or 0.1)
    while Toggles.AutoSpec and Toggles.AutoSpec.Value do
        local targetWeapons = Options.SelectedPassive or {}
        local targetPassives = Options.SelectedSpec   or {}
        local workDone = false
        if type(Shared.Passives) ~= "table" then Shared.Passives = {} end
        for weapName, on in pairs(targetWeapons) do
            if not on then continue end
            local cur = Shared.Passives[weapName]
            local curName = (type(cur) == "table" and cur.Name) or (type(cur) == "string" and cur) or "None"
            local curBuffs = (type(cur) == "table" and cur.RolledBuffs) or {}
            local correct = targetPassives[curName]
            local meetsStats = true
            if correct and type(curBuffs) == "table" then
                for statKey, val in pairs(curBuffs) do
                    local sid = "Min_"..weapName:gsub("%s+","").."_"..statKey
                    local minReq = Options[sid] or 0
                    if tonumber(val) and val < minReq then meetsStats = false break end
                end
            end
            if not correct or not meetsStats then
                workDone = true
                Remotes.SpecPassiveReroll:FireServer(weapName)
                local t = tick()
                repeat task.wait()
                    local nd = Shared.Passives[weapName]
                    local nn = (type(nd) == "table" and nd.Name) or (type(nd) == "string" and nd) or ""
                until nn ~= curName or tick()-t > 1.5
                break
            end
        end
        if not workDone then
            window:Notify({Title="Passive", Description="Done rolling.", Duration=5})
            if Toggles.AutoSpec then Toggles.AutoSpec.Value = false end; break
        end
        task.wait()
    end
end

-- ENCHANT / BLESSING
local function AutoUpgradeLoop(mode)
    local toggle    = Toggles["Auto"..mode]
    local allToggle = Toggles["Auto"..mode.."All"]
    local remote    = (mode == "Enchant") and Remotes.Enchant or Remotes.Blessing
    local source    = (mode == "Enchant") and Tables.OwnedAccessory or Tables.OwnedWeapon
    while (toggle and toggle.Value) or (allToggle and allToggle.Value) do
        local selection = Options["Selected"..mode] or {}
        local done = false
        for _, itemName in ipairs(source) do
            if Shared.UpBlacklist[itemName] then continue end
            local sel = (allToggle and allToggle.Value) or selection[itemName] or table.find(selection, itemName)
            if sel then
                done = true
                pcall(function() remote:FireServer(itemName) end)
                task.wait(1.5); break
            end
        end
        if not done then
            window:Notify({Title="Stopping", Description="Nothing left to "..mode:lower()..".", Duration=5})
            if toggle    then toggle.Value    = false end
            if allToggle then allToggle.Value = false end; break
        end
        task.wait(0.1)
    end
end

-- ARTIFACT
local function EvaluateArtifact(uuid, data)
    local actions = {lock=false, delete=false, upgrade=false}
    local function filterStatus(filter, val)
        if not filter or not next(filter) then return nil end
        return filter[val] == true
    end
    local function isWhitelisted(filter, val)
        local s = filterStatus(filter, val)
        return s == nil or s
    end
    local function getMatches(d, ssFilter)
        local count = 0
        for _, sub in pairs(d.Substats or {}) do if ssFilter[sub.Stat] then count += 1 end end
        return count
    end

    if Toggles.ArtifactUpgrade and Toggles.ArtifactUpgrade.Value and data.Level < (Options.UpgradeLimit or 0) then
        if isWhitelisted(Options.Up_MS, data.MainStat.Stat) then actions.upgrade = true end
    end

    local lockMin = Options.Lock_MinSS or 0
    if Toggles.ArtifactLock and Toggles.ArtifactLock.Value and not data.Locked and data.Level >= (lockMin * 3) then
        if isWhitelisted(Options.Lock_MS, data.MainStat.Stat) and isWhitelisted(Options.Lock_Type, data.Category) and isWhitelisted(Options.Lock_Set, data.Set) then
            if getMatches(data, Options.Lock_SS or {}) >= lockMin then actions.lock = true end
        end
    end

    if not data.Locked and not actions.lock then
        if Toggles.DeleteUnlock and Toggles.DeleteUnlock.Value then
            actions.delete = true
        elseif Toggles.ArtifactDelete and Toggles.ArtifactDelete.Value then
            local typeMatch = filterStatus(Options.Del_Type, data.Category)
            local setMatch  = filterStatus(Options.Del_Set,  data.Set)
            local msFilter  = Options["Del_MS_"..data.Category] or {}
            local msMatch   = filterStatus(msFilter, data.MainStat.Stat)
            local isTarget  = typeMatch ~= false and setMatch ~= false
            if typeMatch == nil and setMatch == nil and msMatch == nil then isTarget = false end
            if isTarget then
                local trash = getMatches(data, Options.Del_SS or {})
                local minT  = Options.Del_MinSS or 0
                local maxed = data.Level >= (Options.UpgradeLimit or 0)
                if msMatch == true or minT == 0 or (maxed and trash >= minT) then actions.delete = true end
            end
        end
    end
    return actions
end

local function AutoEquipArtifacts()
    if not (Toggles.ArtifactEquip and Toggles.ArtifactEquip.Value) then return end
    local best = {Helmet=nil, Gloves=nil, Body=nil, Boots=nil}
    local scores = {Helmet=-1, Gloves=-1, Body=-1, Boots=-1}
    local tTypes = Options.Eq_Type or {}; local tMS = Options.Eq_MS or {}; local tSS = Options.Eq_SS or {}
    local function getMatches(d)
        local c = 0; for _, s in pairs(d.Substats or {}) do if tSS[s.Stat] then c += 1 end end; return c
    end
    local function mainOK(d)
        if d.Category == "Helmet" or d.Category == "Gloves" then return true end
        return tMS[d.MainStat.Stat] == true
    end
    for uuid, data in pairs(Shared.ArtifactSession.Inventory) do
        if tTypes[data.Category] and mainOK(data) then
            local score = getMatches(data) * 10 + data.Level
            if score > scores[data.Category] then scores[data.Category] = score; best[data.Category] = {UUID=uuid, Equipped=data.Equipped} end
        end
    end
    for _, item in pairs(best) do
        if item and not item.Equipped then Remotes.ArtifactEquip:FireServer(item.UUID); task.wait(0.2) end
    end
end

local function Func_ArtifactAutomation()
    while task.wait(5) do
        if not Shared.ArtifactSession.Inventory or not next(Shared.ArtifactSession.Inventory) then
            Remotes.ArtifactUnequip:FireServer(""); task.wait(2); continue
        end
        local lockQ, delQ, upQ = {}, {}, {}
        for uuid, data in pairs(Shared.ArtifactSession.Inventory) do
            local res = EvaluateArtifact(uuid, data)
            if res.lock    then table.insert(lockQ, uuid) end
            if res.delete  then table.insert(delQ,  uuid) end
            if res.upgrade then
                local lim = Options.UpgradeLimit or 0
                if Toggles.UpgradeStage and Toggles.UpgradeStage.Value then lim = math.min(math.floor(data.Level/3)*3+3, lim) end
                table.insert(upQ, {UUID=uuid, Levels=lim})
            end
        end
        for _, uuid in ipairs(lockQ) do Remotes.ArtifactLock:FireServer(uuid, true); task.wait(0.1) end
        if #delQ > 0 then
            for i = 1, #delQ, 50 do
                local chunk = {}
                for j = i, math.min(i+49, #delQ) do table.insert(chunk, delQ[j]) end
                Remotes.MassDelete:FireServer(chunk); task.wait(0.6)
            end
            Remotes.ArtifactUnequip:FireServer("")
        end
        if #upQ > 0 then
            for i = 1, #upQ, 50 do
                local chunk = {}
                for j = i, math.min(i+49, #upQ) do table.insert(chunk, upQ[j]) end
                Remotes.MassUpgrade:FireServer(chunk); task.wait(0.6)
            end
        end
        AutoEquipArtifacts()
    end
end

local function Func_ArtifactMilestone()
    local m = 1
    while Toggles.ArtifactMilestone and Toggles.ArtifactMilestone.Value do
        Remotes.ArtifactClaim:FireServer(m)
        m = m >= 40 and 1 or m + 1
        task.wait(1)
    end
end

-- MERCHANT
local function OpenMerchantInterface()
    if isXeno then
        local npc = workspace:FindFirstChild("ServiceNPCs") and workspace.ServiceNPCs:FindFirstChild("MerchantNPC")
        local prompt = npc and npc:FindFirstChild("HumanoidRootPart") and npc.HumanoidRootPart:FindFirstChild("MerchantPrompt")
        if prompt then
            local char = GetCharacter()
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local old = root.CFrame
                root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0,0,3); task.wait(0.2)
                if Support.Proximity then fireproximityprompt(prompt)
                else prompt:InputHoldBegin(); task.wait(prompt.HoldDuration + 0.1); prompt:InputHoldEnd() end
                task.wait(0.5); root.CFrame = old
            end
        end
    else
        if firesignal then firesignal(Remotes.OpenMerchant.OnClientEvent)
        elseif getconnections then
            for _, v in pairs(getconnections(Remotes.OpenMerchant.OnClientEvent)) do
                if v.Function then task.spawn(v.Function) end
            end
        end
    end
end

local function Func_AutoMerchant()
    local MerchUI = PGui:WaitForChild("MerchantUI")
    local Holder  = MerchUI:FindFirstChild("Holder", true)
    local LastTimerText = ""

    local function StartPurchaseSequence()
        if Shared.MerchantExecute then return end
        Shared.MerchantExecute = true
        if Shared.FirstMerchantSync then
            MerchUI.Enabled = true; MerchUI.MainFrame.Visible = true; task.wait(0.5)
            local close = MerchUI:FindFirstChild("CloseButton", true)
            if close then gsc(close); task.wait(1.8) end
        end
        OpenMerchantInterface(); task.wait(2)
        local withStock = {}
        for _, child in pairs(Holder:GetChildren()) do
            if child:IsA("Frame") and child.Name ~= "Item" then
                local lbl = child:FindFirstChild("StockAmountForThatItem", true)
                local stock = lbl and tonumber(lbl.Text:match("%d+")) or 0
                Shared.CurrentStock[child.Name] = stock
                if stock > 0 then table.insert(withStock, {Name=child.Name, Stock=stock}) end
            end
        end
        local sel = Options.SelectedMerchantItems or {}
        for _, item in ipairs(withStock) do
            if sel[item.Name] then pcall(function() Remotes.MerchantBuy:InvokeServer(item.Name, 99) end); task.wait(math.random(11,17)/10) end
        end
        if MerchUI.MainFrame then MerchUI.MainFrame.Visible = false end
        Shared.FirstMerchantSync = true; Shared.MerchantExecute = false
    end

    local function SyncClock()
        OpenMerchantInterface(); task.wait(1)
        local lbl = MerchUI:FindFirstChild("RefreshTimerLabel", true)
        if lbl and lbl.Text:find(":") then
            local s = GetSecondsFromTimer(lbl.Text)
            if s then Shared.LocalMerchantTime = s end
        end
        if MerchUI.MainFrame then MerchUI.MainFrame.Visible = false end
    end

    SyncClock()
    while Toggles.AutoMerchant and Toggles.AutoMerchant.Value do
        local lbl = MerchUI:FindFirstChild("RefreshTimerLabel", true)
        if lbl and lbl.Text ~= "" then
            local s = GetSecondsFromTimer(lbl.Text)
            if s then
                Shared.LocalMerchantTime = s
                if lbl.Text ~= LastTimerText then LastTimerText = lbl.Text; Shared.LastTimerTick = tick() end
            else Shared.LocalMerchantTime = math.max(0, Shared.LocalMerchantTime - 1) end
        else Shared.LocalMerchantTime = math.max(0, Shared.LocalMerchantTime - 1) end
        if not Shared.FirstMerchantSync or Shared.LocalMerchantTime <= 1 or Shared.LocalMerchantTime >= 1799 then
            task.spawn(StartPurchaseSequence)
        end
        if tick() - Shared.LastTimerTick > 30 then task.spawn(SyncClock); Shared.LastTimerTick = tick() end
        task.wait(1)
    end
end

-- DUNGEON
local function Func_AutoDungeon()
    while Toggles.AutoDungeon and Toggles.AutoDungeon.Value do
        task.wait(1)
        local sel = Options.SelectedDungeon
        if not sel then continue end
        if PGui.DungeonPortalJoinUI.LeaveButton.Visible then continue end
        local targetIsland = sel == "BossRush" and "Sailor" or "Dungeon"
        if tick() - Shared.LastDungeon > 15 then
            Remotes.OpenDungeon:FireServer(tostring(sel)); Shared.LastDungeon = tick(); task.wait(1)
        end
        if not PGui.DungeonPortalJoinUI.LeaveButton.Visible then
            local portal = workspace:FindFirstChild("ActiveDungeonPortal")
            if not portal then
                if Shared.Island ~= targetIsland then Remotes.TP_Portal:FireServer(targetIsland); Shared.Island = targetIsland; task.wait(2.5) end
            else
                local root = GetCharacter():FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = portal.CFrame; task.wait(0.2)
                    local prompt = portal:FindFirstChild("JoinPrompt")
                    if prompt then fireproximityprompt(prompt); task.wait(1) end
                end
            end
        end
    end
end

-- TRADE
local function Func_AutoTrade()
    while task.wait(0.5) do
        local inTrade   = PGui:FindFirstChild("InTradingUI")   and PGui.InTradingUI.MainFrame.Visible
        local reqUI     = PGui:FindFirstChild("TradeRequestUI") and PGui.TradeRequestUI.TradeRequest.Visible
        if Toggles.ReqTradeAccept and Toggles.ReqTradeAccept.Value and reqUI then
            Remotes.TradeRespond:FireServer(true); task.wait(1)
        end
        if Toggles.ReqTrade and Toggles.ReqTrade.Value and not inTrade and not reqUI then
            local target = Options.SelectedTradePlr
            if target and typeof(target) == "Instance" then Remotes.TradeSend:FireServer(target.UserId); task.wait(3) end
        end
        if inTrade and Toggles.AutoAccept and Toggles.AutoAccept.Value then
            local sel = Options.SelectedTradeItems or {}
            local toAdd = {}
            for itemName, on in pairs(sel) do
                if on then
                    local already = false
                    if Shared.TradeState.myItems then
                        for _, ti in pairs(Shared.TradeState.myItems) do if ti.name == itemName then already = true break end end
                    end
                    if not already then table.insert(toAdd, itemName) end
                end
            end
            if #toAdd > 0 then
                for _, name in ipairs(toAdd) do
                    local qty = 0
                    for _, item in pairs(Shared.Cached_Inv or {}) do if item.name == name then qty = item.quantity break end end
                    if qty > 0 then Remotes.TradeAddItem:FireServer("Items", name, qty); task.wait(0.5) end
                end
            else
                if not Shared.TradeState.myReady then Remotes.TradeReady:FireServer(true)
                elseif Shared.TradeState.myReady and Shared.TradeState.theirReady then
                    if Shared.TradeState.phase == "confirming" and not Shared.TradeState.myConfirm then Remotes.TradeConfirm:FireServer() end
                end
            end
        end
    end
end

-- CHESTS / CRAFT
local function Func_AutoChest()
    while task.wait(2) do
        if not (Toggles.AutoChest and Toggles.AutoChest.Value) then break end
        local sel = Options.SelectedChests or {}
        for _, r in ipairs(Tables.Rarities) do
            if sel[r] then
                local fullName = (r == "Aura Crate") and "Aura Crate" or (r.." Chest")
                pcall(function() Remotes.UseItem:FireServer("Use", fullName, 10000) end); task.wait(1)
            end
        end
    end
end

local function Func_AutoCraft()
    while task.wait(1) do
        if not (Toggles.AutoCraftItem and Toggles.AutoCraftItem.Value) then break end
        local sel = Options.SelectedCraftItems or {}
        for _, item in pairs(Shared.Cached_Inv or {}) do
            if sel["DivineGrail"] and item.name == "Broken Sword" and item.quantity >= 3 then
                pcall(function() Remotes.GrailCraft:InvokeServer("DivineGrail", math.min(math.floor(item.quantity/3), 99)) end); task.wait(0.5)
            end
            if sel["SlimeKey"] and item.name == "Slime Shard" and item.quantity >= 2 then
                pcall(function() Remotes.SlimeCraft:InvokeServer("SlimeKey", math.min(math.floor(item.quantity/2), 99)) end)
            end
        end
    end
end

-- WEBHOOK
local function GetFormattedItemSections(src, isNew)
    local cats = {Chests={}, Rerolls={}, Keys={}, Materials={}, Gears={}, Accessories={}, Runes={}, Others={}}
    local chestOrder = {"Common","Rare","Epic","Legendary","Mythical","Secret","Aura Crate","Cosmetic Crate"}
    local matOrder   = {Wood=1, Iron=2, Obsidian=3, Mythril=4, Adamantite=5}
    local rarOrder   = {Common=1, Rare=2, Epic=3, Legendary=4}
    local gearOrder  = {Helmet=1, Gloves=2, Body=3, Boots=4}
    local totalDust = 0
    for key, data in pairs(src) do
        local name, qty
        if type(data) == "table" and data.name then name = tostring(data.name); qty = tonumber(data.quantity) or 1
        else name = tostring(key); qty = tonumber(data) or 1 end
        if name:find("Auto%-deleted") then
            local dv = name:match("%+(%d+) dust"); if dv then totalDust += qty * tonumber(dv) end; continue
        end
        local totalInv = 0
        if isNew then for _, item in pairs(Shared.Cached_Inv or {}) do if item.name == name then totalInv = item.quantity break end end end
        local txt = isNew and string.format("+ [%d] %s [Total: %s]", qty, name, CommaFormat(totalInv)) or string.format("- %s: %s", name, CommaFormat(qty))
        if name:find("Chest") or name == "Aura Crate" or name == "Cosmetic Crate" then
            local w = 99; for i, v in ipairs(chestOrder) do if name:find(v) then w = i break end end
            table.insert(cats.Chests, {Text=txt, Weight=w})
        elseif name:find("Reroll") then table.insert(cats.Rerolls, txt)
        elseif name:find("Key")    then table.insert(cats.Keys, txt)
        elseif matOrder[name]      then table.insert(cats.Materials, {Text=txt, Weight=matOrder[name]})
        elseif name:find("Helmet") or name:find("Gloves") or name:find("Body") or name:find("Boots") then
            local rw, tw = 99, 99
            for k, v in pairs(rarOrder)  do if name:find(k) then rw = v break end end
            for k, v in pairs(gearOrder) do if name:find(k) then tw = v break end end
            table.insert(cats.Gears, {Text=txt, Rarity=rw, Type=tw})
        elseif name:find("Rune") then table.insert(cats.Runes, txt)
        else table.insert(cats.Others, txt) end
    end
    if totalDust > 0 then
        local dt = isNew and string.format("+ [%d] Dust", totalDust) or string.format("- Dust: %s", CommaFormat(totalDust))
        table.insert(cats.Materials, 1, {Text=dt, Weight=0})
    end
    local result = ""
    local function proc(title, tbl, sortFunc)
        if #tbl > 0 then
            if sortFunc then table.sort(tbl, sortFunc) end
            result = result.."**< "..title.." >**\n```"
            for _, v in ipairs(tbl) do result = result..(type(v)=="table" and v.Text or v).."\n" end
            result = result.."```\n"
        end
    end
    proc("Chests",    cats.Chests,    function(a,b) return a.Weight < b.Weight end)
    proc("Rerolls",   cats.Rerolls)
    proc("Keys",      cats.Keys)
    proc("Materials", cats.Materials, function(a,b) return a.Weight < b.Weight end)
    proc("Gears",     cats.Gears,     function(a,b) return a.Rarity ~= b.Rarity and a.Rarity < b.Rarity or a.Type < b.Type end)
    proc("Runes",     cats.Runes)
    proc("Others",    cats.Others)
    return result
end
--[[
local fire = {
    "[i.pinimg.com](https://i.pinimg.com/736x/9b/d2/5f/9bd25f7e1d6e95c6253ef5e5f075f643.jpg)",
    "[i.pinimg.com](https://i.pinimg.com/736x/f8/4d/c7/f84dc705b8f23ecdb8c650ec931b43c3.jpg)",
}

local function PostToWebhook()
    local url = Options.WebhookURL or ""
    if url == "" or not url:find("discord.com/api/webhooks/") then return end
    local selected = Options.SelectedData or {}
    local rarityFilter = Options.SelectedItemRarity or {}
    local data = Plr.Data
    local bounty = (Plr:FindFirstChild("leaderstats") and Plr.leaderstats:FindFirstChild("Bounty") and Plr.leaderstats.Bounty.Value) or 0
    local desc = "### "..assetName.."\n"
    if selected["Name"]  then desc = desc..string.format("\n👤 **Player:** ||%s||\n", Plr.Name) end
    if selected["Stats"] then
        desc = desc..string.format("📈 **Level:** `%s` (+%d)\n", CommaFormat(data.Level.Value), data.Level.Value - StartStats.Level)
        desc = desc..string.format("💰 **Currency:** 💵 %s (+%s) | 💎 %s (+%s)\n",
            Abbreviate(data.Money.Value), Abbreviate(data.Money.Value - StartStats.Money),
            CommaFormat(data.Gems.Value), CommaFormat(data.Gems.Value - StartStats.Gems))
        desc = desc..string.format("☠️ **Bounty:** %s (+%s)\n", Abbreviate(bounty), Abbreviate(bounty - StartStats.Bounty))
    end
    desc = desc.."\n"
    local function isAllowed(name)
        local r = Modules.ItemRarity and Modules.ItemRarity.Items[name] or "Common"
        return rarityFilter[r] == true
    end
    if selected["New Items"] and next(NewItemsBuffer) then
        local filtered = {}; for n, q in pairs(NewItemsBuffer) do if isAllowed(n) then filtered[n] = q end end
        if next(filtered) then desc = desc.."✨ **New Items**\n"..GetFormattedItemSections(filtered, true).."\n" end
    end
    if selected["All Items"] then
        local filtered = {}
        for _, item in pairs(Shared.Cached_Inv or {}) do if isAllowed(item.name) then table.insert(filtered, item) end end
        if #filtered > 0 then desc = desc.."---\n🎒 **Inventory**\n"..GetFormattedItemSections(filtered, false) end
    end
    local payload = {embeds = {{
        description = desc,
        color = tonumber("ffff77", 16),
        footer = {text = "fk taolao • Session: "..GetSessionTime().." • "..os.date("%x %X")},
        thumbnail = {url = fire[math.random(1, #fire)]}
    }}}
    if Toggles.PingUser and Toggles.PingUser.Value then
        payload["content"] = (Options.UID ~= "" and "<@"..Options.UID..">") or "@everyone"
    end
    task.spawn(function()
        pcall(function()
            request({Url=url, Method="POST", Headers={["Content-Type"]="application/json"}, Body=HttpService:JSONEncode(payload)})
            NewItemsBuffer = {}
        end)
    end)
end

local function Func_WebhookLoop()
    while Toggles.SendWebhook and Toggles.SendWebhook.Value do
        PostToWebhook(); task.wait(math.max(Options.WebhookDelay or 5, 0.5) * 60)
    end
end
]]
-- QUESTLINE
local function UniversalPuzzleSolver(puzzleType)
    local moduleMap = {
        Dungeon  = RS.Modules:FindFirstChild("DungeonConfig"),
        Slime    = RS.Modules:FindFirstChild("SlimePuzzleConfig"),
        Demonite = RS.Modules:FindFirstChild("DemoniteCoreQuestConfig"),
        Hogyoku  = RS.Modules:FindFirstChild("HogyokuQuestConfig"),
    }
    local hogyokuOrder = {"Snow","Shibuya","HuecoMundo","Shinjuku","Slime","Judgement"}
    local mod = moduleMap[puzzleType]; if not mod then return end
    local data = require(mod)
    local settings = data.PuzzleSettings or data.PieceSettings
    local pieces   = data.Pieces or settings.IslandOrder
    local pieceName = settings and settings.PieceModelName or "DungeonPuzzlePiece"
    window:Notify({Title="Puzzle", Description="Starting "..puzzleType.."...", Duration=5})
    for i, islandOrPiece in ipairs(pieces) do
        local tpTarget
        if puzzleType == "Demonite" then tpTarget = "Academy"
        elseif puzzleType == "Hogyoku" then tpTarget = hogyokuOrder[i]
        else
            tpTarget = islandOrPiece:gsub("Island",""):gsub("Station","")
            if islandOrPiece == "HuecoMundo" then tpTarget = "HuecoMundo" end
        end
        if tpTarget then Remotes.TP_Portal:FireServer(tpTarget); task.wait(2.5) end
        local piece
        if puzzleType == "Demonite" or puzzleType == "Hogyoku" then
            piece = workspace:FindFirstChild(islandOrPiece, true)
        else
            local folder = workspace:FindFirstChild(islandOrPiece)
            piece = (folder and folder:FindFirstChild(pieceName, true)) or workspace:FindFirstChild(pieceName, true)
        end
        if piece then
            HybridMove(piece:GetPivot() * CFrame.new(0,3,0)); task.wait(0.5)
            local prompt = piece:FindFirstChildOfClass("ProximityPrompt") or piece:FindFirstChild("ProximityPrompt", true)
            if prompt then fireproximityprompt(prompt); window:Notify({Title="Puzzle", Description=string.format("Piece %d/%d collected", i, #pieces), Duration=2}); task.wait(1.5)
            else window:Notify({Title="Puzzle", Description="No prompt on piece "..i, Duration=3}) end
        else window:Notify({Title="Puzzle", Description="Piece "..i.." not found on "..tostring(tpTarget), Duration=3}) end
    end
    window:Notify({Title="Puzzle", Description=puzzleType.." completed!", Duration=5})
end

local function AutoQuestlineLoop()
    while Toggles.AutoQuestline and Toggles.AutoQuestline.Value do
        task.wait(0.1)
        local selId = Options.SelectedQuestline
        if not selId then continue end
        local qData = Modules.Quests.Questlines[selId]
        if not qData then continue end
        local questUI = PGui.QuestUI.Quest
        local isMatchingStage = false
        for _, stage in ipairs(qData.stages) do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then isMatchingStage = true break end
        end
        if not questUI.Visible or not isMatchingStage then
            Remotes.QuestAccept:FireServer(qData.npcName); task.wait(1.5); continue
        end
        local curStage = nil
        for _, stage in ipairs(qData.stages) do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then curStage = stage break end
        end
        if curStage then
            local tt = curStage.trackingType
            if tt:find("Kills") and not tt:find("Boss") and tt ~= "PlayerKills" then
                local mobName = tt:gsub("Kills","")
                if mobName == "AnyNPC" then if Toggles.LevelFarm then Toggles.LevelFarm.Value = true end
                else Options.SelectedMob = {[mobName]=true}; if Toggles.MobFarm then Toggles.MobFarm.Value = true end end
            elseif tt:find("BossKills") or tt == "AnyBossKills" then
                if tt == "AnyBossKills" then if Toggles.AllBossesFarm then Toggles.AllBossesFarm.Value = true end end
            end
        end
    end
end

-- ===== ANTI-AFK & MISC =====
task.spawn(function()
    DisableIdled()
    while true do
        task.wait(60)
        if Toggles.AntiAFK and Toggles.AntiAFK.Value then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame); task.wait(0.2)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

local _DR = GetRemote(RS, "RemoteEvents.DashRemote")
local _FS = _DR and _DR.FireServer
local function ACThing(state)
    if Connections.Dash then Connections.Dash:Disconnect() end
    if not (state and _DR and _FS) then return end
    Connections.Dash = RunService.Heartbeat:Connect(function()
        task.spawn(function() pcall(_FS, _DR, vector.create(0,0,0), 0, false) end)
    end)
end
--[[
-- ===== DISCORD NOTIFICATION =====
local hasJoinedFile = "fk taolao_DiscordJoined.txt"
if Support.FileIO and not isfile(hasJoinedFile) then
    window:Notify({Title="Discord", Description="Join discord.gg/mcMEkVdebJ for updates!", Duration=5})
    pcall(function() if setclipboard then setclipboard("[discord.gg](https://discord.gg/mcMEkVdebJ)") end end)
    if request then
        task.spawn(function()
            pcall(function()
                request({Url="[127.0.0.1](http://127.0.0.1:6463/rpc?v=1)", Method="POST",
                    Headers={["Content-Type"]="application/json", ["Origin"]="[discord.com](https://discord.com)"},
                    Body=HttpService:JSONEncode({cmd="INVITE_BROWSER", args={code="mcMEkVdebJ"}, nonce=HttpService:GenerateGUID(false)})})
            end)
        end)
    end
    pcall(function() writefile(hasJoinedFile, "Joined") end)
end]]

-- ===== BUILD UI =====

UpdateNPCLists()
UpdateAllEntities()

local executorDisplayName = identifyexecutor and identifyexecutor() or "Unknown"
local statusText = isLimitedExecutor and "Semi-Working" or "Working"

-- ===========================
-- SECTION: INFORMATION
-- ===========================
local InfoSection = window:CreateSection("Information")
local InfoTab = InfoSection:CreateTab("Info", "rbxassetid://10734898355")
InfoTab:CreateSection("Player & Script")
InfoTab:CreateParagraph({Title="Executor", Content=executorDisplayName.." | Status: "..statusText})
InfoTab:CreateParagraph({Title="Note", Content=isLimitedExecutor and "May experience bugs for some features!" or "All features should work properly."})
InfoTab:CreateButton({Name="Redeem All Codes", Callback=function()
    for code, data in pairs(Modules.Codes.Codes) do
        if Plr.Data.Level.Value >= (data.LevelReq or 0) then
            window:Notify({Title="Code", Description="Redeeming: "..code, Duration=3})
            Remotes.UseCode:InvokeServer(code); task.wait(2)
        end
    end
end})
--[[
InfoTab:CreateButton({Name="Copy Discord Invite", Callback=function()
    if setclipboard then setclipboard("[discord.gg](https://discord.gg/mcMEkVdebJ)") end
    window:Notify({Title="Copied", Description="discord.gg/mcMEkVdebJ", Duration=3})
end})
InfoTab:CreateButton({Name="Join Discord Server", Callback=function()
    if request then
        pcall(function()
            request({Url="[127.0.0.1](http://127.0.0.1:6463/rpc?v=1)", Method="POST",
                Headers={["Content-Type"]="application/json",["Origin"]="[discord.com](https://discord.com)"},
                Body=HttpService:JSONEncode({cmd="INVITE_BROWSER",args={code="mcMEkVdebJ"},nonce=HttpService:GenerateGUID(false)})})
        end)
    end
end})
]]
-- PRIORITY SECTION REMOVED
-- ===========================
-- SECTION: AUTOFARM - MOB
-- ===========================
local AutofarmSection = window:CreateSection("Autofarm")
local MobFarmTab = AutofarmSection:CreateTab("Mob Farm", "rbxassetid://10734898355")
MobFarmTab:CreateSection("Mob Selection")
MobFarmTab:CreateDropdown({Name="Select Mob(s)", Options=Tables.MobList, Default=Tables.MobList[1] or "", MultiSelect=true, Flag="SelectedMob",
    Callback=function(v) Options.SelectedMob = ToSet(v) end})
Options.SelectedMob = Tables.MobList[1] and {[Tables.MobList[1]] = true} or {}
MobFarmTab:CreateButton({Name="Refresh Mob List", Callback=function() UpdateNPCLists(); window:Notify({Title="Refreshed", Description="Mob list updated.", Duration=2}) end})
MobFarmTab:CreateSection("Farm Mode")
MobFarmTab:CreateToggle({Name="Autofarm Selected Mob", Default=false, Flag="MobFarm",
    Callback=function(v) Toggles.MobFarm = {Value=v} if not v then Shared.MobIdx = 1 end end})
MobFarmTab:CreateToggle({Name="Autofarm All Mobs", Default=false, Flag="AllMobFarm",
    Callback=function(v) Toggles.AllMobFarm = {Value=v} end})
MobFarmTab:CreateToggle({Name="Autofarm Level (Quest)", Default=false, Flag="LevelFarm",
    Callback=function(v) Toggles.LevelFarm = {Value=v}; if not v then Shared.QuestNPC = "" end end})

-- ===========================
-- SECTION: AUTOFARM - BOSS
-- ===========================
local BossFarmTab = AutofarmSection:CreateTab("Boss Farm", "rbxassetid://10734898355")
BossFarmTab:CreateSection("World Bosses")
BossFarmTab:CreateDropdown({Name="Select Boss(es)", Options=Tables.BossList, Default="", MultiSelect=true, Flag="SelectedBosses",
    Callback=function(v) Options.SelectedBosses = ToSet(v) end})
BossFarmTab:CreateToggle({Name="Autofarm Selected Boss", Default=false, Flag="BossesFarm", Callback=function(v) Toggles.BossesFarm={Value=v} end})
BossFarmTab:CreateToggle({Name="Autofarm All Bosses",    Default=false, Flag="AllBossesFarm", Callback=function(v) Toggles.AllBossesFarm={Value=v} end})
BossFarmTab:CreateSection("Summon Boss")
BossFarmTab:CreateDropdown({Name="Select Summon Boss", Options=Tables.SummonList, Default=Tables.SummonList[1] or "", Flag="SelectedSummon",
    Callback=function(v) Options.SelectedSummon = v end})
BossFarmTab:CreateDropdown({Name="Summon Difficulty", Options=Tables.DiffList, Default="Normal", Flag="SelectedSummonDiff",
    Callback=function(v) Options.SelectedSummonDiff = v end})
BossFarmTab:CreateToggle({Name="Auto Summon", Default=false, Flag="AutoSummon", Callback=function(v) Toggles.AutoSummon={Value=v} end})
BossFarmTab:CreateToggle({Name="Autofarm Summon Boss", Default=false, Flag="SummonBossFarm", Callback=function(v) Toggles.SummonBossFarm={Value=v} end})
BossFarmTab:CreateSection("Pity System")
BossFarmTab:CreateDropdown({Name="Build Pity Boss(es)", Options=Tables.AllBossList, Default="", MultiSelect=true, Flag="SelectedBuildPity",
    Callback=function(v) Options.SelectedBuildPity = ToSet(v) end})
BossFarmTab:CreateDropdown({Name="Use Pity Boss",       Options=Tables.AllBossList, Default="", Flag="SelectedUsePity",   Callback=function(v) Options.SelectedUsePity = v end})
BossFarmTab:CreateDropdown({Name="Pity Difficulty",     Options=Tables.DiffList,    Default="Normal", Flag="SelectedPityDiff", Callback=function(v) Options.SelectedPityDiff = v end})
BossFarmTab:CreateToggle({Name="Autofarm Pity Boss", Default=false, Flag="PityBossFarm", Callback=function(v) Toggles.PityBossFarm={Value=v} end})
BossFarmTab:CreateSection("Other Summons")
BossFarmTab:CreateDropdown({Name="Other Summon Boss",   Options=Tables.OtherSummonList, Default="", Flag="SelectedOtherSummon",     Callback=function(v) Options.SelectedOtherSummon = v end})
BossFarmTab:CreateDropdown({Name="Other Difficulty",    Options=Tables.DiffList,        Default="Normal", Flag="SelectedOtherSummonDiff", Callback=function(v) Options.SelectedOtherSummonDiff = v end})
BossFarmTab:CreateToggle({Name="Auto Summon (Other)", Default=false, Flag="AutoOtherSummon", Callback=function(v) Toggles.AutoOtherSummon={Value=v} end})
BossFarmTab:CreateToggle({Name="Autofarm Other Summon", Default=false, Flag="OtherSummonFarm", Callback=function(v) Toggles.OtherSummonFarm={Value=v} end})
BossFarmTab:CreateSection("Alt Help")
BossFarmTab:CreateDropdown({Name="Target Boss (Alt)", Options=Tables.AllBossList, Default="", Flag="SelectedAltBoss", Callback=function(v) Options.SelectedAltBoss=v end})
BossFarmTab:CreateDropdown({Name="Alt Difficulty",    Options=Tables.DiffList,    Default="Normal", Flag="SelectedAltDiff", Callback=function(v) Options.SelectedAltDiff=v end})
for i = 1, 5 do
    BossFarmTab:CreateDropdown({Name="Alt Player #"..i, Options={}, Default="", Flag="SelectedAlt_"..i,
        Callback=function(v) Options["SelectedAlt_"..i] = v end})
end
BossFarmTab:CreateToggle({Name="Auto Help Alt", Default=false, Flag="AltBossFarm", Callback=function(v) Toggles.AltBossFarm={Value=v} end})

-- ===========================
-- SECTION: AUTOFARM - CONFIG
-- ===========================
local FarmConfigTab = AutofarmSection:CreateTab("Farm Config", "rbxassetid://10734898355")
FarmConfigTab:CreateSection("Weapon Settings")
FarmConfigTab:CreateDropdown({
    Name = "Select Weapons",
    Options = GetAllWeapons(),
    Default = {},
    MultiSelect = true,
    Flag = "SelectedWeapons",
    Callback = function(v)
        local s = ToSet(v)
        Options.SelectedWeapons = s
        print("SELECTED WEAPONS:", game:GetService("HttpService"):JSONEncode(s))
    end
})

FarmConfigTab:CreateToggle({
    Name = "Auto Equip Weapon",
    Default = false,
    Flag = "AutoWeapon",

    Callback = function(v)
        Toggles.AutoWeapon = {Value = v}

        if v then
            task.spawn(function()
                while Toggles.AutoWeapon and Toggles.AutoWeapon.Value do
                    AutoEquipWeapon()
                    task.wait(Options.SwitchWeaponCD or 2)
                end
            end)
        end
    end
})
FarmConfigTab:CreateSlider({Name="Weapon Switch Delay", Min=1, Max=20, Default=4, Flag="SwitchWeaponCD",
    Callback=function(v) Options.SwitchWeaponCD = v end})
FarmConfigTab:CreateSection("Movement")
FarmConfigTab:CreateToggle({Name="Island TP", Default=true, Flag="IslandTP", Callback=function(v) Toggles.IslandTP={Value=v} end})
FarmConfigTab:CreateSlider({Name="Island TP CD", Min=0, Max=2.5, Default=0.67, Flag="IslandTPCD",
    Callback=function(v) Options.IslandTPCD = v end})
FarmConfigTab:CreateSlider({Name="Target TP CD", Min=0, Max=5, Default=0, Flag="TargetTPCD",
    Callback=function(v) Options.TargetTPCD = v end})
FarmConfigTab:CreateSlider({Name="Target Distance (Tween)", Min=0, Max=100, Default=0, Flag="TargetDistTP",
    Callback=function(v) Options.TargetDistTP = v end})
FarmConfigTab:CreateDropdown({Name="Movement Type", Options={"Teleport","Tween"}, Default="Tween", Flag="SelectedMovementType",
    Callback=function(v) Options.SelectedMovementType = v end})
FarmConfigTab:CreateDropdown({Name="Farm Position", Options={"Behind","Above","Below"}, Default="Behind", Flag="SelectedFarmType",
    Callback=function(v) Options.SelectedFarmType = v end})
FarmConfigTab:CreateSlider({Name="Farm Distance", Min=0, Max=30, Default=12, Flag="Distance",
    Callback=function(v) Options.Distance = v end})
FarmConfigTab:CreateSlider({Name="Tween Speed", Min=0, Max=500, Default=160, Flag="TweenSpeed",
    Callback=function(v) Options.TweenSpeed = v end})
FarmConfigTab:CreateSection("Instant Kill")
FarmConfigTab:CreateToggle({Name="Instant Kill", Default=false, Flag="InstaKill", Callback=function(v) Toggles.InstaKill={Value=v} end})
FarmConfigTab:CreateDropdown({Name="IK Type", Options={"V1","V2"}, Default="V1", Flag="InstaKillType",
    Callback=function(v) Options.InstaKillType = v end})
FarmConfigTab:CreateSlider({Name="IK HP Threshold %", Min=1, Max=100, Default=90, Flag="InstaKillHP",
    Callback=function(v) Options.InstaKillHP = v end})
FarmConfigTab:CreateTextBox({Name="Min MaxHP for IK", Default="100000", Placeholder="Number..", Flag="InstaKillMinHP",
    Callback=function(v) Options.InstaKillMinHP = tonumber(v) or 100000 end})

-- ===========================
-- SECTION: COMBAT
-- ===========================
local CombatSection = window:CreateSection("Combat")
local HakiTab = CombatSection:CreateTab("Haki", "rbxassetid://10734898355")
HakiTab:CreateSection("Haki Settings")
HakiTab:CreateToggle({Name="Auto Observation Haki", Default=false, Flag="ObserHaki",
    Callback=function(v) Toggles.ObserHaki={Value=v}; Thread("AutoHaki", Func_AutoHaki, v) end})
HakiTab:CreateToggle({Name="Auto Armament Haki", Default=false, Flag="ArmHaki",
    Callback=function(v) Toggles.ArmHaki={Value=v}; Thread("AutoHaki", Func_AutoHaki, v) end})
HakiTab:CreateToggle({Name="Auto Conqueror Haki", Default=false, Flag="ConquerorHaki",
    Callback=function(v) Toggles.ConquerorHaki={Value=v}; Thread("AutoHaki", Func_AutoHaki, v) end})
HakiTab:CreateToggle({Name="Target Only (Conqueror)", Default=false, Flag="OnlyTarget",
    Callback=function(v) Toggles.OnlyTarget={Value=v} end})

local SkillTab = CombatSection:CreateTab("Skills", "rbxassetid://10734898355")
SkillTab:CreateSection("Auto Attack")
SkillTab:CreateParagraph({Title="Note", Content="Autofarm already has Auto-M1 built in. Only enable this if you have issues."})
SkillTab:CreateSlider({Name="M1 Attack Speed", Min=0, Max=1, Default=0.2, Flag="M1Speed",
    Callback=function(v) Options.M1Speed = v end})
SkillTab:CreateToggle({Name="Auto Attack (M1)", Default=false, Flag="AutoM1",
    Callback=function(v) Toggles.AutoM1={Value=v}; Thread("AutoM1", SafeLoop("Auto M1", Func_AutoM1), v) end})
SkillTab:CreateSection("Kill Aura")
SkillTab:CreateSlider({Name="Kill Aura CD", Min=0.1, Max=1, Default=0.1, Flag="KillAuraCD",
    Callback=function(v) Options.KillAuraCD = v end})
SkillTab:CreateSlider({Name="Kill Aura Range", Min=0, Max=200, Default=200, Flag="KillAuraRange",
    Callback=function(v) Options.KillAuraRange = v end})
SkillTab:CreateToggle({Name="Kill Aura", Default=false, Flag="KillAura",
    Callback=function(v) Toggles.KillAura={Value=v}; Thread("KillAura", Func_KillAura, v) end})
SkillTab:CreateSection("Auto Skill")
SkillTab:CreateParagraph({Title="Mode", Content="Normal: checks cooldowns\nInstant: no cooldown check (may affect performance)"})
SkillTab:CreateDropdown({
    Name = "Select Skills",
    Options = {"Z","X","C","V","F"},
    Default = {"Z"},
    MultiSelect = true,
    Flag = "SelectedSkills",

    Callback = function(v)
        local s = ToSet(v)
        print("SKILLS SELECTED:", game:GetService("HttpService"):JSONEncode(s))
        Options.SelectedSkills = s
    end
})

Options.SelectedSkills = {["Z"] = true}
SkillTab:CreateDropdown({Name="Skill Mode", Options={"Normal","Instant"}, Default="Normal", Flag="AutoSkillType",
    Callback=function(v) Options.AutoSkillType = v end})
SkillTab:CreateToggle({Name="Boss Only", Default=false, Flag="AutoSkill_BossOnly",
    Callback=function(v) Toggles.AutoSkill_BossOnly={Value=v} end})
SkillTab:CreateSlider({Name="Boss HP% Threshold", Min=1, Max=100, Default=100, Flag="AutoSkill_BossHP",
    Callback=function(v) Options.AutoSkill_BossHP = v end})
SkillTab:CreateToggle({Name="Auto Use Skills", Default=false, Flag="AutoSkill",
    Callback=function(v) Toggles.AutoSkill={Value=v}; Thread("AutoSkill", SafeLoop("Auto Skill", Func_AutoSkill), v) end})

local ComboTab = CombatSection:CreateTab("Combo", "rbxassetid://10734898355")
ComboTab:CreateSection("Skill Combo")
ComboTab:CreateParagraph({Title="Format", Content="Example: Z > X > C > 0.5 > V > F\nUse numbers for delays (seconds)."})
ComboTab:CreateTextBox({Name="Combo Pattern", Default="Z > X > C > V > F", Placeholder="combo pattern...", Flag="ComboPattern",
    Callback=function(v) Options.ComboPattern = v end})
ComboTab:CreateDropdown({Name="Combo Mode", Options={"Normal","Instant"}, Default="Normal", Flag="ComboMode",
    Callback=function(v) Options.ComboMode = v end})
ComboTab:CreateToggle({Name="Boss Only", Default=false, Flag="ComboBossOnly",
    Callback=function(v) Toggles.ComboBossOnly={Value=v} end})
ComboTab:CreateToggle({Name="Auto Skill Combo", Default=false, Flag="AutoCombo",
    Callback=function(v)
        Toggles.AutoCombo={Value=v}
        if v and Toggles.AutoSkill and Toggles.AutoSkill.Value then
            Toggles.AutoSkill.Value = false
            window:Notify({Title="Notice", Description="Auto Skill disabled. Combo needs exclusive skill control.", Duration=4})
        end
        Thread("AutoCombo", SafeLoop("Skill Combo", Func_AutoCombo), v)
    end})
ComboTab:CreateSection("Combo Switch (Title/Rune for F move)")
ComboTab:CreateDropdown({Name="Title (F move)", Options=CombinedTitleList, Default="None", Flag="Title_Combo",
    Callback=function(v) Options.Title_Combo = v end})
ComboTab:CreateDropdown({Name="Rune (F move)", Options=Tables.RuneList, Default="None", Flag="Rune_Combo",
    Callback=function(v) Options.Rune_Combo = v end})

-- ===========================
-- SECTION: AUTO SWITCH
-- ===========================
local SwitchSection = window:CreateSection("Auto Switch")
local TitleSwitchTab = SwitchSection:CreateTab("Title", "rbxassetid://10734898355")
TitleSwitchTab:CreateSection("Auto Title Switch")
TitleSwitchTab:CreateToggle({Name="Enable Auto Switch Title", Default=false, Flag="AutoTitle",
    Callback=function(v) Toggles.AutoTitle={Value=v} end})
TitleSwitchTab:CreateDropdown({Name="Default Title",        Options=CombinedTitleList, Default="None", Flag="DefaultTitle",     Callback=function(v) Options.DefaultTitle=v end})
TitleSwitchTab:CreateDropdown({Name="Title [Mob]",          Options=CombinedTitleList, Default="None", Flag="Title_Mob",        Callback=function(v) Options.Title_Mob=v end})
TitleSwitchTab:CreateDropdown({Name="Title [Boss]",         Options=CombinedTitleList, Default="None", Flag="Title_Boss",       Callback=function(v) Options.Title_Boss=v end})
TitleSwitchTab:CreateDropdown({Name="Title [Boss HP%]",     Options=CombinedTitleList, Default="None", Flag="Title_BossHP",     Callback=function(v) Options.Title_BossHP=v end})
TitleSwitchTab:CreateSlider({Name="Change at Boss HP%", Min=0, Max=100, Default=15, Flag="Title_BossHPAmt",
    Callback=function(v) Options.Title_BossHPAmt = v end})

local RuneSwitchTab = SwitchSection:CreateTab("Rune", "rbxassetid://10734898355")
RuneSwitchTab:CreateSection("Auto Rune Switch")
RuneSwitchTab:CreateToggle({Name="Enable Auto Switch Rune", Default=false, Flag="AutoRune",
    Callback=function(v) Toggles.AutoRune={Value=v} end})
RuneSwitchTab:CreateDropdown({Name="Default Rune",     Options=Tables.RuneList, Default="None", Flag="DefaultRune",   Callback=function(v) Options.DefaultRune=v end})
RuneSwitchTab:CreateDropdown({Name="Rune [Mob]",       Options=Tables.RuneList, Default="None", Flag="Rune_Mob",      Callback=function(v) Options.Rune_Mob=v end})
RuneSwitchTab:CreateDropdown({Name="Rune [Boss]",      Options=Tables.RuneList, Default="None", Flag="Rune_Boss",     Callback=function(v) Options.Rune_Boss=v end})
RuneSwitchTab:CreateDropdown({Name="Rune [Boss HP%]",  Options=Tables.RuneList, Default="None", Flag="Rune_BossHP",   Callback=function(v) Options.Rune_BossHP=v end})
RuneSwitchTab:CreateSlider({Name="Change at Boss HP%", Min=0, Max=100, Default=15, Flag="Rune_BossHPAmt",
    Callback=function(v) Options.Rune_BossHPAmt = v end})

local BuildSwitchTab = SwitchSection:CreateTab("Build", "rbxassetid://10734898355")
BuildSwitchTab:CreateSection("Auto Build Switch")
BuildSwitchTab:CreateToggle({Name="Enable Auto Switch Build", Default=false, Flag="AutoBuild",
    Callback=function(v) Toggles.AutoBuild={Value=v} end})
BuildSwitchTab:CreateDropdown({Name="Default Build",    Options=Tables.BuildList, Default="None", Flag="DefaultBuild",  Callback=function(v) Options.DefaultBuild=v end})
BuildSwitchTab:CreateDropdown({Name="Build [Mob]",      Options=Tables.BuildList, Default="None", Flag="Build_Mob",     Callback=function(v) Options.Build_Mob=v end})
BuildSwitchTab:CreateDropdown({Name="Build [Boss]",     Options=Tables.BuildList, Default="None", Flag="Build_Boss",    Callback=function(v) Options.Build_Boss=v end})
BuildSwitchTab:CreateDropdown({Name="Build [Boss HP%]", Options=Tables.BuildList, Default="None", Flag="Build_BossHP",  Callback=function(v) Options.Build_BossHP=v end})
BuildSwitchTab:CreateSlider({Name="Change at Boss HP%", Min=0, Max=100, Default=15, Flag="Build_BossHPAmt",
    Callback=function(v) Options.Build_BossHPAmt = v end})

-- ===========================
-- SECTION: AUTOMATION
-- ===========================
local AutoSection = window:CreateSection("Automation")
local AscendTab = AutoSection:CreateTab("Ascend", "rbxassetid://10734898355")
AscendTab:CreateSection("Auto Ascend")
AscendTab:CreateToggle({Name="Auto Ascend", Default=false, Flag="AutoAscend",
    Callback=function(v)
        Toggles.AutoAscend={Value=v}
        if v then Remotes.ReqAscend:InvokeServer()
        else Remotes.CloseAscend:FireServer() end
    end})

local StatsTab = AutoSection:CreateTab("Stats", "rbxassetid://10734898355")
StatsTab:CreateSection("Allocate Stat Points")
StatsTab:CreateDropdown({Name="Select Stats", Options={"Melee","Defense","Sword","Power"}, Default={"Melee"}, MultiSelect=true, Flag="SelectedStats",
    Callback=function(v) Options.SelectedStats = ToSet(v) end})
Options.SelectedStats = {["Melee"] = true}
StatsTab:CreateToggle({Name="Auto UP Stats", Default=false, Flag="AutoStats",
    Callback=function(v) Toggles.AutoStats={Value=v}; Thread("AutoStats", SafeLoop("Auto Stats", Func_AutoStats), v) end})
StatsTab:CreateSection("Gem Stat Reroll")
StatsTab:CreateParagraph({Title="Note", Content="Reroll once first for this to work.\nIncrease delay based on ping."})
StatsTab:CreateDropdown({Name="Select Gem Stats", Options=Tables.GemStat, Default="", MultiSelect=true, Flag="SelectedGemStats",
    Callback=function(v) Options.SelectedGemStats = ToSet(v) end})
StatsTab:CreateDropdown({Name="Target Rank(s)", Options=Tables.GemRank, Default="", MultiSelect=true, Flag="SelectedRank",
    Callback=function(v) Options.SelectedRank = ToSet(v) end})
StatsTab:CreateSlider({Name="Roll Delay", Min=0.01, Max=1, Default=0.1, Flag="StatsRollCD",
    Callback=function(v) Options.StatsRollCD = v end})
StatsTab:CreateToggle({Name="Auto Roll Stats", Default=false, Flag="AutoRollStats",
    Callback=function(v) Toggles.AutoRollStats={Value=v}; Thread("AutoRollStats", SafeLoop("Stat Roll", AutoRollStatsLoop), v) end})
StatsTab:CreateSection("Skill Tree & Milestones")
StatsTab:CreateToggle({Name="Auto Skill Tree", Default=false, Flag="AutoSkillTree",
    Callback=function(v) Toggles.AutoSkillTree={Value=v} end})
StatsTab:CreateToggle({Name="Auto Artifact Milestone", Default=false, Flag="ArtifactMilestone",
    Callback=function(v) Toggles.ArtifactMilestone={Value=v}; Thread("ArtifactMilestone", Func_ArtifactMilestone, v) end})

local RollTab = AutoSection:CreateTab("Rolls", "rbxassetid://10734898355")
RollTab:CreateSection("Roll Settings")
RollTab:CreateSlider({Name="Roll Delay", Min=0.01, Max=1, Default=0.3, Flag="RollCD",
    Callback=function(v) Options.RollCD = v end})
RollTab:CreateSection("Trait")
RollTab:CreateDropdown({Name="Target Trait(s)", Options=Tables.TraitList, Default="", MultiSelect=true, Flag="SelectedTrait",
    Callback=function(v) Options.SelectedTrait = ToSet(v); SyncTraitAutoSkip() end})
RollTab:CreateToggle({Name="Auto Roll Trait", Default=false, Flag="AutoTrait",
    Callback=function(v) Toggles.AutoTrait={Value=v}; EnsureRollManager() end})
RollTab:CreateSection("Race")
RollTab:CreateDropdown({Name="Target Race(s)", Options=Tables.RaceList, Default="", MultiSelect=true, Flag="SelectedRace",
    Callback=function(v) Options.SelectedRace = ToSet(v); SyncRaceSettings() end})
RollTab:CreateToggle({Name="Auto Roll Race", Default=false, Flag="AutoRace",
    Callback=function(v) Toggles.AutoRace={Value=v}; EnsureRollManager() end})
RollTab:CreateSection("Clan")
RollTab:CreateDropdown({Name="Target Clan(s)", Options=Tables.ClanList, Default="", MultiSelect=true, Flag="SelectedClan",
    Callback=function(v) Options.SelectedClan = ToSet(v); SyncClanSettings() end})
RollTab:CreateToggle({Name="Auto Roll Clan", Default=false, Flag="AutoClan",
    Callback=function(v) Toggles.AutoClan={Value=v}; EnsureRollManager() end})

local TradeTab = AutoSection:CreateTab("Trade", "rbxassetid://10734898355")
TradeTab:CreateSection("Trade Settings")
TradeTab:CreateDropdown({Name="Target Player", Options={}, Default="", Flag="SelectedTradePlr",
    Callback=function(v) Options.SelectedTradePlr = Players:FindFirstChild(tostring(v)) end})
TradeTab:CreateDropdown({Name="Items to Trade", Options=Tables.OwnedItem, Default="", MultiSelect=true, Flag="SelectedTradeItems",
    Callback=function(v) Options.SelectedTradeItems = ToSet(v) end})
TradeTab:CreateToggle({Name="Auto Send Request", Default=false, Flag="ReqTrade",      Callback=function(v) Toggles.ReqTrade={Value=v} end})
TradeTab:CreateToggle({Name="Auto Accept Request", Default=false, Flag="ReqTradeAccept", Callback=function(v) Toggles.ReqTradeAccept={Value=v} end})
TradeTab:CreateToggle({Name="Auto Accept Trade",   Default=false, Flag="AutoAccept",    Callback=function(v) Toggles.AutoAccept={Value=v} end})

local EnchantTab = AutoSection:CreateTab("Enchant/Bless", "rbxassetid://10734898355")
EnchantTab:CreateSection("Enchant Accessory")
EnchantTab:CreateDropdown({Name="Select Accessory", Options=Tables.OwnedAccessory, Default="", MultiSelect=true, Flag="SelectedEnchant",
    Callback=function(v) Options.SelectedEnchant = ToSet(v) end})
EnchantTab:CreateToggle({Name="Auto Enchant",     Default=false, Flag="AutoEnchant",
    Callback=function(v) Toggles.AutoEnchant={Value=v}; Thread("AutoEnchant", SafeLoop("Enchant", function() AutoUpgradeLoop("Enchant") end), v) end})
EnchantTab:CreateToggle({Name="Auto Enchant All", Default=false, Flag="AutoEnchantAll",
    Callback=function(v) Toggles.AutoEnchantAll={Value=v}; Thread("AutoEnchantAll", SafeLoop("EnchantAll", function() AutoUpgradeLoop("Enchant") end), v) end})
EnchantTab:CreateSection("Bless Weapon")
EnchantTab:CreateDropdown({Name="Select Weapon", Options=Tables.OwnedWeapon, Default="", MultiSelect=true, Flag="SelectedBlessing",
    Callback=function(v) Options.SelectedBlessing = ToSet(v) end})
EnchantTab:CreateToggle({Name="Auto Blessing",     Default=false, Flag="AutoBlessing",
    Callback=function(v) Toggles.AutoBlessing={Value=v}; Thread("AutoBlessing", SafeLoop("Blessing", function() AutoUpgradeLoop("Blessing") end), v) end})
EnchantTab:CreateToggle({Name="Auto Blessing All", Default=false, Flag="AutoBlessingAll",
    Callback=function(v) Toggles.AutoBlessingAll={Value=v}; Thread("AutoBlessingAll", SafeLoop("BlessingAll", function() AutoUpgradeLoop("Blessing") end), v) end})
EnchantTab:CreateSection("Spec Passive")
EnchantTab:CreateDropdown({Name="Select Weapon(s)", Options=Tables.AllOwnedWeapons, Default="", MultiSelect=true, Flag="SelectedPassive",
    Callback=function(v) Options.SelectedPassive = ToSet(v) end})
EnchantTab:CreateDropdown({Name="Target Passive(s)", Options=Tables.SpecPassive, Default="", MultiSelect=true, Flag="SelectedSpec",
    Callback=function(v) Options.SelectedSpec = ToSet(v); SyncSpecPassiveAutoSkip() end})
EnchantTab:CreateSlider({Name="Roll Delay", Min=0.01, Max=1, Default=0.1, Flag="SpecRollCD",
    Callback=function(v) Options.SpecRollCD = v end})
EnchantTab:CreateToggle({Name="Auto Reroll Passive", Default=false, Flag="AutoSpec",
    Callback=function(v) Toggles.AutoSpec={Value=v}; Thread("AutoSpecPassive", SafeLoop("Spec Passive", AutoSpecPassiveLoop), v) end})

-- ===========================
-- SECTION: ARTIFACT
-- ===========================
local ArtifactSection = window:CreateSection("Artifact")
local ArtifactTab = ArtifactSection:CreateTab("Artifact", "rbxassetid://10734898355")
ArtifactTab:CreateSection("⚠️ Heavy Development - Use at your own risk")
ArtifactTab:CreateSection("Upgrade")
ArtifactTab:CreateSlider({Name="Upgrade Level Limit", Min=0, Max=15, Default=0, Flag="UpgradeLimit",
    Callback=function(v) Options.UpgradeLimit = v end})
ArtifactTab:CreateDropdown({Name="Main Stat Filter [Upgrade]", Options=allStats, Default="", MultiSelect=true, Flag="Up_MS",
    Callback=function(v) Options.Up_MS = ToSet(v) end})
ArtifactTab:CreateToggle({Name="Auto Upgrade", Default=false, Flag="ArtifactUpgrade",
    Callback=function(v) Toggles.ArtifactUpgrade={Value=v}; Thread("Artifact.Upgrade", SafeLoop("ArtifactLogic", Func_ArtifactAutomation), v) end})
ArtifactTab:CreateToggle({Name="Upgrade in Stages", Default=false, Flag="UpgradeStage",
    Callback=function(v) Toggles.UpgradeStage={Value=v} end})
ArtifactTab:CreateSection("Lock")
ArtifactTab:CreateDropdown({Name="Type Filter [Lock]", Options=Modules.ArtifactConfig and Modules.ArtifactConfig.Categories or {}, Default="", MultiSelect=true, Flag="Lock_Type",
    Callback=function(v) Options.Lock_Type = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Set Filter [Lock]",  Options=allSets,  Default="", MultiSelect=true, Flag="Lock_Set",  Callback=function(v) Options.Lock_Set = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Lock]",   Options=allStats, Default="", MultiSelect=true, Flag="Lock_MS",   Callback=function(v) Options.Lock_MS = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Sub Stat [Lock]",    Options=allStats, Default="", MultiSelect=true, Flag="Lock_SS",   Callback=function(v) Options.Lock_SS = ToSet(v) end})
ArtifactTab:CreateSlider({Name="Min Sub-Stats [Lock]", Min=0, Max=4, Default=0, Flag="Lock_MinSS",
    Callback=function(v) Options.Lock_MinSS = v end})
ArtifactTab:CreateToggle({Name="Auto Lock", Default=false, Flag="ArtifactLock",
    Callback=function(v) Toggles.ArtifactLock={Value=v}; Thread("Artifact.Lock", SafeLoop("ArtifactLogic", Func_ArtifactAutomation), v) end})
ArtifactTab:CreateSection("Delete")
ArtifactTab:CreateDropdown({Name="Type Filter [Delete]",    Options=Modules.ArtifactConfig and Modules.ArtifactConfig.Categories or {}, Default="", MultiSelect=true, Flag="Del_Type",
    Callback=function(v) Options.Del_Type = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Set Filter [Delete]",     Options=allSets,  Default="", MultiSelect=true, Flag="Del_Set",  Callback=function(v) Options.Del_Set = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Helmet]",      Options={"FlatDefense","Defense"}, Default="", MultiSelect=true, Flag="Del_MS_Helmet",  Callback=function(v) Options.Del_MS_Helmet = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Gloves]",      Options={"Damage"},    Default="", MultiSelect=true, Flag="Del_MS_Gloves",  Callback=function(v) Options.Del_MS_Gloves = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Body]",        Options=allStats, Default="", MultiSelect=true, Flag="Del_MS_Body",    Callback=function(v) Options.Del_MS_Body = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Boots]",       Options=allStats, Default="", MultiSelect=true, Flag="Del_MS_Boots",   Callback=function(v) Options.Del_MS_Boots = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Sub Stat [Delete]",       Options=allStats, Default="", MultiSelect=true, Flag="Del_SS",         Callback=function(v) Options.Del_SS = ToSet(v) end})
ArtifactTab:CreateSlider({Name="Min Sub-Stats [Delete]", Min=0, Max=4, Default=0, Flag="Del_MinSS",
    Callback=function(v) Options.Del_MinSS = v end})
ArtifactTab:CreateToggle({Name="Auto Delete",          Default=false, Flag="ArtifactDelete",
    Callback=function(v) Toggles.ArtifactDelete={Value=v}; Thread("Artifact.Delete", SafeLoop("ArtifactLogic", Func_ArtifactAutomation), v) end})
ArtifactTab:CreateToggle({Name="Auto Delete Unlocked", Default=false, Flag="DeleteUnlock",
    Callback=function(v) Toggles.DeleteUnlock={Value=v} end})
ArtifactTab:CreateSection("Auto Equip")
ArtifactTab:CreateDropdown({Name="Type [Equip]",    Options=Modules.ArtifactConfig and Modules.ArtifactConfig.Categories or {}, Default="", MultiSelect=true, Flag="Eq_Type",
    Callback=function(v) Options.Eq_Type = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Main Stat [Equip]", Options=allStats, Default="", MultiSelect=true, Flag="Eq_MS",
    Callback=function(v) Options.Eq_MS = ToSet(v) end})
ArtifactTab:CreateDropdown({Name="Sub Stat [Equip]",  Options=allStats, Default="", MultiSelect=true, Flag="Eq_SS",
    Callback=function(v) Options.Eq_SS = ToSet(v) end})
ArtifactTab:CreateToggle({Name="Auto Equip Artifact", Default=false, Flag="ArtifactEquip",
    Callback=function(v) Toggles.ArtifactEquip={Value=v} end})

-- ===========================
-- SECTION: DUNGEON
-- ===========================
local DungeonSection = window:CreateSection("Dungeon")
local DungeonTab = DungeonSection:CreateTab("Auto Dungeon", "rbxassetid://10734898355")
DungeonTab:CreateSection("Dungeon Settings")
DungeonTab:CreateParagraph({Title="Note", Content="BossRush is supported."})
DungeonTab:CreateDropdown({Name="Select Dungeon", Options=Tables.DungeonList, Default=Tables.DungeonList[1], Flag="SelectedDungeon",
    Callback=function(v) Options.SelectedDungeon = v end})
DungeonTab:CreateToggle({Name="Auto Join Dungeon", Default=false, Flag="AutoDungeon",
    Callback=function(v) Toggles.AutoDungeon={Value=v}; Thread("AutoDungeon", Func_AutoDungeon, v) end})

    

-- ===========================
-- SECTION: PLAYER
-- ===========================
local PlayerSection = window:CreateSection("Player")
local MovementTab = PlayerSection:CreateTab("Movement", "rbxassetid://10734898355")
MovementTab:CreateSection("Speed & Jump")
MovementTab:CreateToggle({Name="Speed Boost", Default=false, Flag="WS",
    Callback=function(v) Toggles.WS={Value=v} end})
MovementTab:CreateSlider({Name="Walk Speed", Min=16, Max=250, Default=16, Flag="WSValue",
    Callback=function(v) Options.WSValue = v
        if Toggles.WS and Toggles.WS.Value then
            local hum = Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = v end
        end
    end})
MovementTab:CreateToggle({Name="Jump Power Boost", Default=false, Flag="JP",
    Callback=function(v) Toggles.JP={Value=v} end})
MovementTab:CreateSlider({Name="Jump Power", Min=0, Max=500, Default=50, Flag="JPValue",
    Callback=function(v) Options.JPValue = v
        if Toggles.JP and Toggles.JP.Value then
            local hum = Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.JumpPower = v; hum.UseJumpPower = true end
        end
    end})
MovementTab:CreateToggle({Name="Hip Height Boost", Default=false, Flag="HH",
    Callback=function(v) Toggles.HH={Value=v} end})
MovementTab:CreateSlider({Name="Hip Height", Min=0, Max=10, Default=2, Flag="HHValue",
    Callback=function(v) Options.HHValue = v end})
MovementTab:CreateToggle({Name="TPWalk", Default=false, Flag="TPW",
    Callback=function(v) Toggles.TPW={Value=v}; Thread("TPW", FuncTPW, v) end})
MovementTab:CreateSlider({Name="TPWalk Speed", Min=1, Max=10, Default=1, Flag="TPWValue",
    Callback=function(v) Options.TPWValue = v end})
MovementTab:CreateSection("Physics")
MovementTab:CreateToggle({Name="Gravity Modifier", Default=false, Flag="Grav",
    Callback=function(v) Toggles.Grav={Value=v} end})
MovementTab:CreateSlider({Name="Gravity", Min=0, Max=500, Default=196, Flag="GravValue",
    Callback=function(v) Options.GravValue = v; if Toggles.Grav and Toggles.Grav.Value then workspace.Gravity = v end end})
MovementTab:CreateToggle({Name="Noclip", Default=false, Flag="Noclip",
    Callback=function(v) Toggles.Noclip={Value=v}; Thread("Noclip", FuncNoclip, v) end})
MovementTab:CreateToggle({Name="Anti Knockback", Default=false, Flag="AntiKnockback",
    Callback=function(v) Toggles.AntiKnockback={Value=v}; Thread("AntiKnockback", Func_AntiKnockback, v) end})
MovementTab:CreateSection("Camera")
MovementTab:CreateToggle({Name="Camera Zoom Override", Default=false, Flag="Zoom",
    Callback=function(v) Toggles.Zoom={Value=v} end})
MovementTab:CreateSlider({Name="Zoom Distance", Min=128, Max=10000, Default=128, Flag="ZoomValue",
    Callback=function(v) Options.ZoomValue = v; if Toggles.Zoom and Toggles.Zoom.Value then Plr.CameraMaxZoomDistance = v end end})
MovementTab:CreateToggle({Name="FOV Override", Default=false, Flag="FOV",
    Callback=function(v) Toggles.FOV={Value=v} end})
MovementTab:CreateSlider({Name="Field of View", Min=30, Max=120, Default=70, Flag="FOVValue",
    Callback=function(v) Options.FOVValue = v; if Toggles.FOV and Toggles.FOV.Value then workspace.CurrentCamera.FieldOfView = v end end})

local GraphicsTab = PlayerSection:CreateTab("Graphics", "rbxassetid://10734898355")
GraphicsTab:CreateSection("FPS")
GraphicsTab:CreateToggle({Name="FPS Cap", Default=false, Flag="LimitFPS",
    Callback=function(v) Toggles.LimitFPS={Value=v}; if not v and setfpscap then setfpscap(999) end end})
GraphicsTab:CreateSlider({Name="Max FPS", Min=5, Max=360, Default=60, Flag="LimitFPSValue",
    Callback=function(v) Options.LimitFPSValue = v; if Toggles.LimitFPS and Toggles.LimitFPS.Value and setfpscap then setfpscap(v) end end})
GraphicsTab:CreateToggle({Name="FPS Boost",           Default=false, Flag="FPSBoost",    Callback=function(v) Toggles.FPSBoost={Value=v};    ApplyFPSBoost(v) end})
GraphicsTab:CreateToggle({Name="FPS Boost [Autofarm]",Default=false, Flag="FPSBoost_AF", Callback=function(v) Toggles.FPSBoost_AF={Value=v}; if v then ApplyIslandWipe() end end})
GraphicsTab:CreateSection("World")
GraphicsTab:CreateToggle({Name="Fullbright",       Default=false, Flag="Fullbright",    Callback=function(v) Toggles.Fullbright={Value=v} end})
GraphicsTab:CreateToggle({Name="No Fog",           Default=false, Flag="NoFog",         Callback=function(v) Toggles.NoFog={Value=v} end})
GraphicsTab:CreateToggle({Name="Disable 3D Render",Default=false, Flag="Disable3DRender",Callback=function(v) Toggles.Disable3DRender={Value=v}; RunService:Set3dRenderingEnabled(not v) end})
GraphicsTab:CreateToggle({Name="Time Override",    Default=false, Flag="OverrideTime",  Callback=function(v) Toggles.OverrideTime={Value=v} end})
GraphicsTab:CreateSlider({Name="Time of Day", Min=0, Max=24, Default=12, Flag="OverrideTimeValue",
    Callback=function(v) Options.OverrideTimeValue = v; if Toggles.OverrideTime and Toggles.OverrideTime.Value then Lighting.ClockTime = v end end})

local ServerTab = PlayerSection:CreateTab("Server", "rbxassetid://10734898355")
ServerTab:CreateSection("Server Management")
ServerTab:CreateToggle({Name="Anti AFK", Default=true, Flag="AntiAFK", Callback=function(v) Toggles.AntiAFK={Value=v} end})
ServerTab:CreateToggle({Name="Anti Kick (Client)", Default=false, Flag="AntiKick", Callback=function(v) Toggles.AntiKick={Value=v} end})
ServerTab:CreateToggle({Name="Auto Reconnect", Default=false, Flag="AutoReconnect",
    Callback=function(v) Toggles.AutoReconnect={Value=v}; if v then Func_AutoReconnect() end end})
ServerTab:CreateToggle({Name="No Gameplay Paused", Default=false, Flag="NoGameplayPaused",
    Callback=function(v) Toggles.NoGameplayPaused={Value=v}; Thread("NoGameplayPaused", SafeLoop("Anti-Pause", Func_NoGameplayPaused), v) end})
ServerTab:CreateButton({Name="Rejoin", Callback=function() TeleportService:Teleport(game.PlaceId, Plr) end})
ServerTab:CreateSection("Prompt")
ServerTab:CreateToggle({Name="Instant Proximity Prompt", Default=false, Flag="InstantPP",
    Callback=function(v) Toggles.InstantPP={Value=v} end})

local SafetyTab = PlayerSection:CreateTab("Safety", "rbxassetid://10734898355")
SafetyTab:CreateSection("Auto Kick")
SafetyTab:CreateToggle({Name="Auto Kick", Default=true, Flag="AutoKick",
    Callback=function(v) Toggles.AutoKick={Value=v}; if v then InitAutoKick() end end})
SafetyTab:CreateDropdown({Name="Kick Type(s)", Options={"Mod","Player Join","Public Server"}, Default={"Mod"}, MultiSelect=true, Flag="SelectedKickType",
    Callback=function(v) Options.SelectedKickType = ToSet(v); CheckServerTypeSafety() end})
Options.SelectedKickType = {["Mod"] = true}
SafetyTab:CreateSection("Panic")
SafetyTab:CreateKeybind({Name="Panic Key", Default=Enum.KeyCode.P, Flag="PanicKeybind",
    Callback=function() PanicStop() end})
SafetyTab:CreateButton({Name="Panic Now", Callback=PanicStop})

-- ===========================
-- SECTION: TELEPORT
-- ===========================
local TeleportSection = window:CreateSection("Teleport")
local IslandTPTab = TeleportSection:CreateTab("Islands", "rbxassetid://10734898355")
IslandTPTab:CreateSection("Island Teleport")
IslandTPTab:CreateDropdown({Name="Select Island", Options=Tables.IslandList, Default=Tables.IslandList[1], Flag="SelectedIsland",
    Callback=function(v) if v then Remotes.TP_Portal:FireServer(v) end end})

local NPCTPTab = TeleportSection:CreateTab("NPCs", "rbxassetid://10734898355")
NPCTPTab:CreateSection("Quest NPCs")
NPCTPTab:CreateDropdown({Name="Quest NPC", Options=Tables.NPC_QuestList, Default="", Flag="SelectedQuestNPC",
    Callback=function(v)
        local map = {DungeonUnlock="DungeonPortalsNPC", SlimeKeyUnlock="SlimeCraftNPC"}
        SafeTeleportToNPC(tostring(v), map)
    end})
NPCTPTab:CreateSection("Moveset & Mastery NPCs")
NPCTPTab:CreateDropdown({Name="Moveset NPC", Options=Tables.NPC_MovesetList, Default="", Flag="SelectedMovesetNPC",
    Callback=function(v) if v then SafeTeleportToNPC(tostring(v)) end end})
NPCTPTab:CreateDropdown({Name="Mastery NPC", Options=Tables.NPC_MasteryList, Default="", Flag="SelectedMasteryNPC",
    Callback=function(v) if v then SafeTeleportToNPC(tostring(v)) end end})
NPCTPTab:CreateSection("Misc NPCs")
NPCTPTab:CreateDropdown({Name="Misc NPC", Options=Tables.NPC_MiscList, Default="", Flag="SelectedMiscNPC",
    Callback=function(v)
        local map = {ArmHaki="HakiQuest", Observation="ObservationBuyer"}
        SafeTeleportToNPC(tostring(v), map)
    end})
NPCTPTab:CreateDropdown({Name="All NPCs", Options=Tables.AllNPCList, Default="", Flag="SelectedMiscAllNPC",
    Callback=function(v) if v then SafeTeleportToNPC(tostring(v)) end end})

-- ===========================
-- SECTION: MERCHANT
-- ===========================
local MerchantSection = window:CreateSection("Merchant")
local MerchantTab = MerchantSection:CreateTab("Auto Merchant", "rbxassetid://10734898355")
MerchantTab:CreateSection("Merchant Settings")
MerchantTab:CreateDropdown({Name="Select Item(s)", Options=Tables.MerchantList, Default="", MultiSelect=true, Flag="SelectedMerchantItems",
    Callback=function(v) Options.SelectedMerchantItems = ToSet(v) end})
MerchantTab:CreateToggle({Name="Auto Buy Merchant Items", Default=false, Flag="AutoMerchant",
    Callback=function(v) Toggles.AutoMerchant={Value=v}; Thread("AutoMerchant", SafeLoop("Merchant", Func_AutoMerchant), v) end})

-- ===========================
-- SECTION: MISC / PUZZLES
-- ===========================
local MiscSection = window:CreateSection("Misc")
local ChestCraftTab = MiscSection:CreateTab("Chests & Craft", "rbxassetid://10734898355")
ChestCraftTab:CreateSection("Auto Open Chests")
ChestCraftTab:CreateDropdown({Name="Select Chest(s)", Options=Tables.Rarities, Default="", MultiSelect=true, Flag="SelectedChests",
    Callback=function(v) Options.SelectedChests = ToSet(v) end})
ChestCraftTab:CreateToggle({Name="Auto Open Chest", Default=false, Flag="AutoChest",
    Callback=function(v) Toggles.AutoChest={Value=v}; Thread("AutoChest", SafeLoop("Chest", Func_AutoChest), v) end})
ChestCraftTab:CreateSection("Auto Craft")
ChestCraftTab:CreateDropdown({Name="Select Item(s) to Craft", Options=Tables.CraftItemList, Default="", MultiSelect=true, Flag="SelectedCraftItems",
    Callback=function(v) Options.SelectedCraftItems = ToSet(v) end})
ChestCraftTab:CreateToggle({Name="Auto Craft Item", Default=false, Flag="AutoCraftItem",
    Callback=function(v) Toggles.AutoCraftItem={Value=v}; Thread("AutoCraft", SafeLoop("Craft", Func_AutoCraft), v) end})

local PuzzleTab = MiscSection:CreateTab("Puzzles", "rbxassetid://10734898355")
PuzzleTab:CreateSection("Puzzle Solvers")
PuzzleTab:CreateButton({Name="Complete Dungeon Puzzle",
    Callback=function()
        if not Support.Proximity then window:Notify({Title="Error", Description="fireproximityprompt not supported.", Duration=3}) return end
        if Plr.Data.Level.Value >= 5000 then UniversalPuzzleSolver("Dungeon")
        else window:Notify({Title="Error", Description="Level 5000 required!", Duration=3}) end
    end})
PuzzleTab:CreateButton({Name="Complete Slime Key Puzzle",
    Callback=function()
        if not Support.Proximity then window:Notify({Title="Error", Description="Not supported.", Duration=3}) return end
        UniversalPuzzleSolver("Slime")
    end})
PuzzleTab:CreateButton({Name="Complete Demonite Puzzle",
    Callback=function()
        if not Support.Proximity then window:Notify({Title="Error", Description="Not supported.", Duration=3}) return end
        UniversalPuzzleSolver("Demonite")
    end})
PuzzleTab:CreateButton({Name="Complete Hogyoku Puzzle",
    Callback=function()
        if not Support.Proximity then window:Notify({Title="Error", Description="Not supported.", Duration=3}) return end
        if Plr.Data.Level.Value >= 8500 then UniversalPuzzleSolver("Hogyoku")
        else window:Notify({Title="Error", Description="Level 8500 required!", Duration=3}) end
    end})

local QuestlineTab = MiscSection:CreateTab("Questlines", "rbxassetid://10734898355")
QuestlineTab:CreateSection("Auto Questline [BETA]")
QuestlineTab:CreateParagraph({Title="Warning",
    Content="Experimental feature.\nMay change other settings.\nStore race/clan before using.\nReport bugs in Discord!"})
QuestlineTab:CreateDropdown({Name="Select Questline", Options=Tables.QuestlineList, Default="", Flag="SelectedQuestline",
    Callback=function(v) Options.SelectedQuestline = v end})
QuestlineTab:CreateDropdown({Name="Target Player (for PvP tasks)", Options={}, Default="", Flag="SelectedQuestline_Player",
    Callback=function(v) Options.SelectedQuestline_Player = v end})
QuestlineTab:CreateDropdown({Name="Target Mob (for Damage tasks)", Options=Tables.AllEntitiesList, Default="", Flag="SelectedQuestline_DMGTaken",
    Callback=function(v) Options.SelectedQuestline_DMGTaken = v end})
QuestlineTab:CreateButton({Name="Refresh Entity List", Callback=function() UpdateAllEntities() end})
QuestlineTab:CreateToggle({Name="Auto Questline [BETA]", Default=false, Flag="AutoQuestline",
    Callback=function(v) Toggles.AutoQuestline={Value=v}; Thread("AutoQuestline", SafeLoop("Questline", AutoQuestlineLoop), v) end})

local NotifTab = MiscSection:CreateTab("Notifications", "rbxassetid://10734898355")
NotifTab:CreateSection("Notification Filter")
NotifTab:CreateToggle({Name="Auto Hide Junk Notifications", Default=false, Flag="AutoDeleteNotif",
    Callback=function(v) Toggles.AutoDeleteNotif={Value=v} end})

    
-- ===========================
-- SECTION: SETTINGS / CONFIG
-- ===========================
local SettingsSection = window:CreateSection("Settings")
local ConfigTab = SettingsSection:CreateTab("Config", "rbxassetid://10734898355")
ConfigTab:CreateSection("Script Settings")
ConfigTab:CreateKeybind({Name="Toggle UI", Default=Enum.KeyCode.RightControl, Flag="MenuKeybind",
    Callback=function() end})
ConfigTab:CreateButton({Name="Unload Script", Callback=function()
    getgenv().taolao_Running = false
    Cleanup(Connections); Cleanup(Flags)
    window:Notify({Title="Unloaded", Description="Script has been unloaded.", Duration=3})
end})
ConfigTab:CreateConfigSection()

-- ===========================
-- CORE MAIN LOOPS
-- ===========================

-- Lighting / visual loop
task.spawn(function()
    while task.wait() do
        if not getgenv().taolao_Running then break end
        if Toggles.Fullbright and Toggles.Fullbright.Value then
            Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
        elseif Toggles.OverrideTime and Toggles.OverrideTime.Value then
            Lighting.ClockTime = Options.OverrideTimeValue or 12
        end
        if Toggles.NoFog and Toggles.NoFog.Value then Lighting.FogEnd = 9e9 end
    end
end)

-- Player stats loop
Connections.Player_General = RunService.Stepped:Connect(function()
    local hum = Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if Toggles.WS  and Toggles.WS.Value  then hum.WalkSpeed  = Options.WSValue  or 16   end
        if Toggles.JP  and Toggles.JP.Value   then hum.JumpPower  = Options.JPValue  or 50; hum.UseJumpPower = true end
        if Toggles.HH  and Toggles.HH.Value   then hum.HipHeight  = Options.HHValue  or 2    end
    end
    workspace.Gravity = (Toggles.Grav and Toggles.Grav.Value) and (Options.GravValue or 196) or 192
    if Toggles.FOV  and Toggles.FOV.Value  then workspace.CurrentCamera.FieldOfView = Options.FOVValue  or 70  end
    if Toggles.Zoom and Toggles.Zoom.Value then Plr.CameraMaxZoomDistance = Options.ZoomValue or 128 end
end)

-- Noclip during farm loop
RunService.Stepped:Connect(function()
    if Shared.Farm and Shared.Target then
        local char = GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
            end
        end
    end
end)

-- Prompt instant
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if Toggles.InstantPP and Toggles.InstantPP.Value then prompt.HoldDuration = 0 end
end)

-- Notification filter
local NotifFrame = PGui:WaitForChild("NotificationUI"):WaitForChild("NotificationsFrame")
local NotificationBlacklist = {"You don't have this item!", "Not enough "}
local function ProcessNotification(frame)
    task.delay(0.01, function()
        if not (Toggles.AutoDeleteNotif and Toggles.AutoDeleteNotif.Value) then return end
        if not frame or not frame.Parent then return end
        local lbl = frame:FindFirstChild("Txt", true)
        if lbl and lbl:IsA("TextLabel") then
            local txt = lbl.Text:lower()
            for _, phrase in ipairs(NotificationBlacklist) do
                if txt:find(phrase:lower()) then frame.Visible = false break end
            end
        end
    end)
end
NotifFrame.ChildAdded:Connect(ProcessNotification)
for _, c in pairs(NotifFrame:GetChildren()) do ProcessNotification(c) end

-- M1 + IK core loop
task.spawn(function()
    while getgenv().taolao_Running do
        task.wait()
        if Shared.AltActive or not Shared.Farm or Shared.MerchantBusy or not Shared.Target then continue end
        pcall(function()
            local char = GetCharacter()
            local target = Shared.Target
            if not char or not target then return end
            local npcHum  = target:FindFirstChildOfClass("Humanoid")
            local npcRoot = target:FindFirstChild("HumanoidRootPart")
            local root    = char:FindFirstChild("HumanoidRootPart")
            if not (npcHum and npcRoot and root) then return end
            local dist = (root.Position - npcRoot.Position).Magnitude
            local minMaxHP = Options.InstaKillMinHP or 0
            local ikThresh = Options.InstaKillHP    or 90
            local hpPct    = (npcHum.Health / npcHum.MaxHealth) * 100
            if Toggles.InstaKill and Toggles.InstaKill.Value and npcHum.MaxHealth >= minMaxHP and hpPct < ikThresh then
                npcHum.Health = 0
                if not target:FindFirstChild("IK_Active") then
                    local tag = Instance.new("Folder"); tag.Name = "IK_Active"
                    tag:SetAttribute("TriggerTime", tick()); tag.Parent = target
                end
            end
            if dist < 35 then
                local m1Delay = Options.M1Speed or 0.2
                if tick() - Shared.LastM1 >= m1Delay then
                    EquipWeapon(); Remotes.M1:FireServer()
                    Shared.LastM1 = tick()
                end
            end
        end)
    end
end)

-- Main autofarm priority loop
task.spawn(function()
    while task.wait() do
        if not Shared.Farm or Shared.MerchantBusy then Shared.Target = nil continue end
        local char = GetCharacter()
        if not char or Shared.Recovering then continue end
        if Shared.TargetValid and (not Shared.Target or not Shared.Target.Parent or
           (Shared.Target:FindFirstChildOfClass("Humanoid") and Shared.Target:FindFirstChildOfClass("Humanoid").Health <= 0)) then
            Shared.KillTick = tick(); Shared.TargetValid = false
        end
        if tick() - Shared.KillTick < (Options.TargetTPCD or 0) then continue end
        HandleSummons()
        local cur, max = GetCurrentPity()
        local isPityReady = (Toggles.PityBossFarm and Toggles.PityBossFarm.Value) and cur >= (max - 1)
        local found = false
        if isPityReady then
            local t, isl, ft = GetPityTarget()
            if t then found = true; Shared.Target = t; Shared.TargetValid = true; UpdateSwitchState(t, ft); ExecuteFarmLogic(t, isl, ft) end
        end
        if not found then
            for i = 1, #DefaultPriority do
                local taskName = DefaultPriority[i]
                if not taskName then continue end
                if isPityReady and (taskName == "Boss" or taskName == "All Mob Farm" or taskName == "Mob") then continue end
                local result = CheckTask(taskName)
                if result then
                    found = true
                    local t, isl, ft
                    if type(result) == "table" then t = result[1]; isl = result[2]; ft = result[3]
                    else t = result end
                    Shared.Target = typeof(t) == "Instance" and t or nil
                    Shared.TargetValid = true
                    UpdateSwitchState(t, ft)
                    if taskName ~= "Merchant" and t then ExecuteFarmLogic(t, isl, ft) end
                    break
                end
                
            end
        end
        if not found then Shared.Target = nil; UpdateSwitchState(nil, "None") end
    end
end)

-- Out of bounds recovery loop
task.spawn(function()
    while task.wait(1) do
        if not getgenv().taolao_Running then break end
        local char = GetCharacter()
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root and not Shared.MovingIsland then
            local pos = root.Position
            if pos.Y > 5000 or math.abs(pos.X) > 10000 or math.abs(pos.Z) > 10000 then
                Shared.Recovering = true
                window:Notify({Title="Recovery", Description="Out of bounds detected! Resetting...", Duration=5})
                root.AssemblyLinearVelocity  = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
                if IslandCrystals["Starter"] then
                    root.CFrame = IslandCrystals["Starter"]:GetPivot() * CFrame.new(0,5,0); task.wait(1)
                end
                Shared.Recovering = false
            end
        end
    end
end)

-- Auto trade always running
task.spawn(Func_AutoTrade)

-- AC thing
ACThing(true)

-- Periodic inventory sync
task.spawn(function()
    while getgenv().taolao_Running do
        if Remotes.ReqInventory then Remotes.ReqInventory:FireServer() end
        task.wait(30)
    end
end)

-- Initial sync
task.spawn(function()
    if Remotes.ReqInventory then Remotes.ReqInventory:FireServer() end
    local timeout = 0
    while not Shared.InventorySynced and timeout < 5 do task.wait(0.15); timeout += 0.15 end
end)

getgenv().taolao_Running = true

window:Notify({Title="Loaded", Description=assetName.." script loaded!\nPress RightCtrl to toggle UI.", Duration=5})





