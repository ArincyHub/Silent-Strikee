repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.GameId ~= 0

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

cloneref = missing('function', cloneref, function(...) return ... end)
getgc = missing('function', getgc or get_gc_objects)
getconnections = missing('function', getconnections or get_signal_cons)

Services = setmetatable({}, {
    __index = function(self, name)
        local success, cache = pcall(function()
            return cloneref(game:GetService(name))
        end)
        if success then
            rawset(self, name, cache)
            return cache
        else
            error('Invalid Service: ' .. tostring(name))
        end
    end
})

local Players = Services.Players
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local PGui = Plr:WaitForChild('PlayerGui')
local Lighting = game:GetService('Lighting')
local RS = Services.ReplicatedStorage
local RunService = Services.RunService
local HttpService = Services.HttpService
local GuiService = Services.GuiService
local TeleportService = Services.TeleportService
local Marketplace = Services.MarketplaceService
local UIS = Services.UserInputService
local VirtualUser = Services.VirtualUser
local TweenService = game:GetService('TweenService')
local v, Asset = pcall(function() return Marketplace:GetProductInfo(game.PlaceId) end)
local assetName = (v and Asset) and Asset.Name or 'Sailor Piece'

local Support = {
    Webhook = (typeof(request) == 'function' or typeof(http_request) == 'function'),
    Clipboard = (typeof(setclipboard) == 'function'),
    FileIO = (typeof(writefile) == 'function' and typeof(isfile) == 'function'),
    QueueOnTP = (typeof(queue_on_teleport) == 'function'),
    Connections = (typeof(getconnections) == 'function'),
    FPS = (typeof(setfpscap) == 'function'),
    Proximity = (typeof(fireproximityprompt) == 'function')
}

local executorName = (identifyexecutor and identifyexecutor() or 'Unknown'):lower()
local isXeno = string.find(executorName, 'xeno') ~= nil
local isLimitedExecutor = false

for _, name in ipairs({'xeno'}) do
    if string.find(executorName, name) then
        isLimitedExecutor = true
        break
    end
end


local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/dy1zn4t/bmF0dWk-/refs/heads/main/ui.lua"))()
local fnl = loadstring(game:HttpGetAsync 'https://raw.githubusercontent.com/Code1Tech/utils/main/notification.lua')()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local window = WindUI:CreateWindow({
	Title = "Zen Hub - " .. gameName,
	Icon = "rbxassetid://113216930555884",
	Author = "Zen Hub",
	Folder = "ZenHub",
	Size = UDim2.fromOffset(600, 400),
	AutoSave = true,
	FileSaveName = "ZenConfigSP.json",
})

local _original = fnl.MakeNotification
fnl.MakeNotification = function(self, data)
    data.Text = data.Description or data.Text
    return _original(self, data)
end

if getgenv().ZenHub then
    getgenv().ZenHub = false
    task.wait(1)
end


getgenv().ZenHub = true


function GetSafeModule(parent, name)
    local obj = parent:FindFirstChild(name)
    if obj and obj:IsA('ModuleScript') then
        local ok, res = pcall(require, obj)
        if ok then return res end
    end
    return nil
end

function GetRemote(parent, pathString)
    local current = parent
    for _, name in ipairs(pathString:split('.')) do
        if not current then return nil end
        current = current:FindFirstChild(name)
    end
    return current
end

local Remotes = {
    SettingsToggle = GetRemote(RS, 'RemoteEvents.SettingsToggle'),
    SettingsSync = GetRemote(RS, 'RemoteEvents.SettingsSync'),
    UseCode = GetRemote(RS, 'RemoteEvents.CodeRedeem'),
    M1 = GetRemote(RS, 'CombatSystem.Remotes.RequestHit'),
    EquipWeapon = GetRemote(RS, 'Remotes.EquipWeapon'),
    UseSkill = GetRemote(RS, 'AbilitySystem.Remotes.RequestAbility'),
    UseFruit = GetRemote(RS, 'RemoteEvents.FruitPowerRemote'),
    QuestAccept = GetRemote(RS, 'RemoteEvents.QuestAccept'),
    QuestAbandon = GetRemote(RS, 'RemoteEvents.QuestAbandon'),
    UseItem = GetRemote(RS, 'Remotes.UseItem'),
    SlimeCraft = GetRemote(RS, 'Remotes.RequestSlimeCraft'),
    GrailCraft = GetRemote(RS, 'Remotes.RequestGrailCraft'),
    RerollSingleStat = GetRemote(RS, 'Remotes.RerollSingleStat'),
    SkillTreeUpgrade = GetRemote(RS, 'RemoteEvents.SkillTreeUpgrade'),
    Enchant = GetRemote(RS, 'Remotes.EnchantAccessory'),
    Blessing = GetRemote(RS, 'Remotes.BlessWeapon'),
    ArtifactSync = GetRemote(RS, 'RemoteEvents.ArtifactDataSync'),
    ArtifactClaim = GetRemote(RS, 'RemoteEvents.ArtifactMilestoneClaimReward'),
    MassDelete = GetRemote(RS, 'RemoteEvents.ArtifactMassDeleteByUUIDs'),
    MassUpgrade = GetRemote(RS, 'RemoteEvents.ArtifactMassUpgrade'),
    ArtifactLock = GetRemote(RS, 'RemoteEvents.ArtifactLock'),
    ArtifactUnequip = GetRemote(RS, 'RemoteEvents.ArtifactUnequip'),
    ArtifactEquip = GetRemote(RS, 'RemoteEvents.ArtifactEquip'),
    Roll_Trait = GetRemote(RS, 'RemoteEvents.TraitReroll'),
    TraitAutoSkip = GetRemote(RS, 'RemoteEvents.TraitUpdateAutoSkip'),
    TraitConfirm = GetRemote(RS, 'RemoteEvents.TraitConfirm'),
    SpecPassiveReroll = GetRemote(RS, 'RemoteEvents.SpecPassiveReroll'),
    ArmHaki = GetRemote(RS, 'RemoteEvents.HakiRemote'),
    ObserHaki = GetRemote(RS, 'RemoteEvents.ObservationHakiRemote'),
    ConquerorHaki = GetRemote(RS, 'Remotes.ConquerorHakiRemote'),
    PowerRoll = GetRemote(RS, 'RemoteEvents.PowerReroll'),
    PowerSkip = GetRemote(RS, 'RemoteEvents.PowerUpdateAutoSkip'),
    UpPower   = GetRemote(RS, 'RemoteEvents.PowerDataUpdate'),
    TP_Portal = GetRemote(RS, 'Remotes.TeleportToPortal'),
    OpenDungeon = GetRemote(RS, 'Remotes.RequestDungeonPortal'),
    EquipTitle = GetRemote(RS, 'RemoteEvents.TitleEquip'),
    TitleUnequip = GetRemote(RS, 'RemoteEvents.TitleUnequip'),
    EquipRune = GetRemote(RS, 'Remotes.EquipRune'),
    LoadoutLoad = GetRemote(RS, 'RemoteEvents.LoadoutLoad'),
    AddStat = GetRemote(RS, 'RemoteEvents.AllocateStat'),
    OpenMerchant = GetRemote(RS, 'Remotes.MerchantRemotes.OpenMerchantUI'),
    MerchantBuy = GetRemote(RS, 'Remotes.MerchantRemotes.PurchaseMerchantItem'),
    ValentineBuy = GetRemote(RS, 'Remotes.ValentineMerchantRemotes.PurchaseValentineMerchantItem'),
    StockUpdate = GetRemote(RS, 'Remotes.MerchantRemotes.MerchantStockUpdate'),
    SummonBoss = GetRemote(RS, 'Remotes.RequestSummonBoss'),
    JJKSummonBoss = GetRemote(RS, 'Remotes.RequestSpawnStrongestBoss'),
    RimuruBoss = GetRemote(RS, 'RemoteEvents.RequestSpawnRimuru'),
    AnosBoss = GetRemote(RS, 'Remotes.RequestSpawnAnosBoss'),
    TrueAizenBoss = GetRemote(RS, 'RemoteEvents.RequestSpawnTrueAizen'),
    ReqInventory = GetRemote(RS, 'Remotes.RequestInventory'),
    Ascend = GetRemote(RS, 'RemoteEvents.RequestAscend'),
    ReqAscend = GetRemote(RS, 'RemoteEvents.GetAscendData'),
    CloseAscend = GetRemote(RS, 'RemoteEvents.CloseAscendUI'),
    TradeRespond = GetRemote(RS, 'Remotes.TradeRemotes.RespondToRequest'),
    TradeSend = GetRemote(RS, 'Remotes.TradeRemotes.SendTradeRequest'),
    TradeAddItem = GetRemote(RS, 'Remotes.TradeRemotes.AddItemToTrade'),
    TradeReady = GetRemote(RS, 'Remotes.TradeRemotes.SetReady'),
    TradeConfirm = GetRemote(RS, 'Remotes.TradeRemotes.ConfirmTrade'),
    TradeUpdated = GetRemote(RS, 'Remotes.TradeRemotes.TradeUpdated'),
    HakiStateUpdate = GetRemote(RS, 'RemoteEvents.HakiStateUpdate'),
    UpCurrency = GetRemote(RS, 'RemoteEvents.UpdateCurrency'),
    UpInventory = GetRemote(RS, 'Remotes.UpdateInventory'),
    UpPlayerStats = GetRemote(RS, 'RemoteEvents.UpdatePlayerStats'),
    UpAscend = GetRemote(RS, 'RemoteEvents.AscendDataUpdate'),
    UpStatReroll = GetRemote(RS, 'RemoteEvents.StatRerollUpdate'),
    SpecPassiveUpdate = GetRemote(RS, 'RemoteEvents.SpecPassiveDataUpdate'),
    SpecPassiveSkip = GetRemote(RS, 'RemoteEvents.SpecPassiveUpdateAutoSkip'),
    UpSkillTree = GetRemote(RS, 'RemoteEvents.SkillTreeUpdate'),
    BossUIUpdate = GetRemote(RS, 'Remotes.BossUIUpdate'),
    TitleSync = GetRemote(RS, 'RemoteEvents.TitleDataSync')
}

local Modules = {
    BossConfig = GetSafeModule(RS.Modules, 'BossConfig') or {Bosses = {}},
    TimedConfig = GetSafeModule(RS.Modules, 'TimedBossConfig'),
    SummonConfig = GetSafeModule(RS.Modules, 'SummonableBossConfig'),
    Merchant = GetSafeModule(RS.Modules, 'MerchantConfig') or {ITEMS = {}},
    ValentineConfig = GetSafeModule(RS.Modules, 'ValentineMerchantConfig'),
    Title = GetSafeModule(RS.Modules, 'TitlesConfig') or {},
    Quests = GetSafeModule(RS.Modules, 'QuestConfig') or {RepeatableQuests = {}, Questlines = {}},
    WeaponClass = GetSafeModule(RS.Modules, 'WeaponClassification') or {Tools = {}},
    Fruits = GetSafeModule(RS:FindFirstChild('FruitPowerSystem') or game, 'FruitPowerConfig') or {Powers = {}},
    ArtifactConfig = GetSafeModule(RS.Modules, 'ArtifactConfig'),
    Stats = GetSafeModule(RS.Modules, 'StatRerollConfig') or {StatKeys = {}, RankOrder = {}},
    Codes = GetSafeModule(RS, 'CodesConfig') or {Codes = {}},
    ItemRarity = GetSafeModule(RS.Modules, 'ItemRarityConfig'),
    Trait = GetSafeModule(RS.Modules, 'TraitConfig') or {Traits = {}},
    Race = GetSafeModule(RS.Modules, 'RaceConfig') or {Races = {}},
    Clan = GetSafeModule(RS.Modules, 'ClanConfig') or {Clans = {}},
    SpecPassive = GetSafeModule(RS.Modules, 'SpecPassiveConfig')
}

local SummonMap = {}
local Shared = {
    GlobalPrio = 'FARM',
    Farm = true,
    CosmicBossFound = false,
    SeaBossFound    = false,
    Recovering = false,
    MovingIsland = false,
    Island = '',
    Target = nil,
    KillTick = 0,
    TargetValid = false,
    QuestNPC = '',
    MobIdx = 1,
    AllMobIdx = 1,
    WeapRotationIdx = 1,
    ComboIdx = 1,
    ParsedCombo = {},
    ActiveWeap = '',
    ArmHaki = false,
    CurrentPower = { Name = 'None', Buffs = {}, MythicalBuff = 0 },
    LastSummon = 0,
    BossTIMap = {},
    InventorySynced = false,
    Stats = {},
    Settings = {},
    GemStats = {},
    SkillTree = {Nodes = {}, Points = 0},
    Passives = {},
    SpecStatsSlider = {},
    ArtifactSession = {Inventory = {}, Dust = 0},
    UpBlacklist = {},
    MerchantBusy = false,
    LocalMerchantTime = 0,
    LastTimerTick = tick(),
    MerchantExecute = false,
    FirstMerchantSync = false,
    CurrentStock = {},
    LastM1 = 0,
    LastWRSwitch = 0,
    LastSwitch = {Title = '', Rune = ''},
    LastBuildSwitch = 0,
    LastDungeon = 0,
    AltDamage = {},
    AltActive = false,
    TradeState = {}
}

local Script_Start_Time = os.time()
local StartStats = {
    Level = Plr.Data.Level.Value,
    Money = Plr.Data.Money.Value,
    Gems = Plr.Data.Gems.Value,
    Bounty = (Plr:FindFirstChild('leaderstats') and Plr.leaderstats:FindFirstChild('Bounty') and Plr.leaderstats.Bounty.Value) or 0
}

local NewItemsBuffer = {}
local Toggles = {}
local Values = {}
local Options = {} 

local PATH = {
    Mobs = workspace:WaitForChild('NPCs'),
    InteractNPCs = workspace:WaitForChild('ServiceNPCs')
}

local MerchantItemList = Modules.Merchant.ITEMS
local SortedTitleList = Modules.Title.GetSortedTitleIds and Modules.Title:GetSortedTitleIds() or {}

local Tables = {
    AscendLabels = {},
    DiffList = {'Normal', 'Medium', 'Hard', 'Extreme'},
    MobList = {},
    BloodlineList = {},
    MiniBossList = {'ThiefBoss', 'MonkeyBoss', 'DesertBoss', 'SnowBoss', 'PandaMiniBoss'},
    BossList = {},
    AllBossList = {},
    AllNPCList = {},
    AllEntitiesList = {},
    SummonList = {},
    OtherSummonList = {'StrongestHistory', 'StrongestToday', 'Rimuru', 'Anos', 'TrueAizen', 'GreatMage'},
    Weapon = {'Melee', 'Sword', 'Power'},
    ManualWeaponClass = {
        Invisible = 'Power',
        Bomb = 'Power',
        Quake = 'Power',
        ['Soul Reaper'] = 'Sword',
        ['Light'] = 'Power'
    },
    MerchantList = {},
    ValentineMerchantList = {},
    Rarities = {'Common', 'Rare', 'Epic', 'Legendary', 'Mythical', 'Secret', 'Aura Crate', 'Cosmetic Crate'},
    CraftItemList = {'SlimeKey', 'DivineGrail'},
    UnlockedTitle = {},
    TitleCategory = {'None', 'Best EXP', 'Best Money & Gem', 'Best Luck', 'Best DMG'},
    TitleList = {},
    BuildList = {'1', '2', '3', '4', '5', 'None'},
    TraitList = {},
    RarityWeight = {Secret = 1, Mythical = 2, Legendary = 3, Epic = 4, Rare = 5, Uncommon = 6, Common = 7},
    RaceList = {},
    ClanList = {},
    RuneList = {'None'},
    PowerList = {},
    SpecPassive = {},
    GemStat = (Modules.Stats and Modules.Stats.StatKeys) or {},
    GemRank = (Modules.Stats and Modules.Stats.RankOrder) or {},
    OwnedWeapon = {},
    AllOwnedWeapons = {},
    OwnedAccessory = {},
    QuestlineList = {},
    OwnedItem = {},
    IslandList = {
        'Starter', 'Jungle', 'Desert', 'Snow', 'Sailor',
        'Shibuya', 'Hollow', 'Shinjuku', 'Slime', 'Academy',
        'Judgement', 'Soul', 'Ninja', 'Lawless', 'Tower'
    },
    NPC_QuestList = {'DungeonUnlock', 'SlimeKeyUnlock'},
    NPC_MiscList = {'Artifacts', 'Blessing', 'Enchant', 'SkillTree', 'Cupid', 'ArmHaki', 'Observation', 'Conqueror'},
    DungeonList = {'CidDungeon', 'RuneDungeon', 'DoubleDungeon', 'BossRush', 'InfiniteTower'},
    NPC_MovesetList = {},
    NPC_MasteryList = {},
    MobToIsland = {}
}

local DefaultPriority = {
    'Nearest Mob', 'Level Farm', 'Mob', 'All Mob Farm', 'Boss',
    'Pity Boss', 'Summon', 'Merchant', 'Alt Help', 'Sea Boss'
}
local IslandCrystals = {
    Starter = workspace:FindFirstChild('StarterIsland') and workspace.StarterIsland:FindFirstChild('SpawnPointCrystal_Starter'),
    Jungle = workspace:FindFirstChild('JungleIsland') and workspace.JungleIsland:FindFirstChild('SpawnPointCrystal_Jungle'),
    Desert = workspace:FindFirstChild('DesertIsland') and workspace.DesertIsland:FindFirstChild('SpawnPointCrystal_Desert'),
    Snow = workspace:FindFirstChild('SnowIsland') and workspace.SnowIsland:FindFirstChild('SpawnPointCrystal_Snow'),
    Sailor = workspace:FindFirstChild('SailorIsland') and workspace.SailorIsland:FindFirstChild('SpawnPointCrystal_Sailor'),
    Shibuya = workspace:FindFirstChild('ShibuyaStation') and workspace.ShibuyaStation:FindFirstChild('SpawnPointCrystal_Shibuya'),
    HuecoMundo = workspace:FindFirstChild('HuecoMundo') and workspace.HuecoMundo:FindFirstChild('SpawnPointCrystal_HuecoMundo'),
    Boss = workspace:FindFirstChild('BossIsland') and workspace.BossIsland:FindFirstChild('SpawnPointCrystal_Boss'),
    Dungeon = workspace:FindFirstChild('Main Temple') and workspace['Main Temple']:FindFirstChild('SpawnPointCrystal_Dungeon'),
    Shinjuku = workspace:FindFirstChild('ShinjukuIsland') and workspace.ShinjukuIsland:FindFirstChild('SpawnPointCrystal_Shinjuku'),
    Valentine = workspace:FindFirstChild('ValentineIsland') and workspace.ValentineIsland:FindFirstChild('SpawnPointCrystal_Valentine'),
    Slime = workspace:FindFirstChild('SlimeIsland') and workspace.SlimeIsland:FindFirstChild('SpawnPointCrystal_Slime'),
    Academy = workspace:FindFirstChild('AcademyIsland') and workspace.AcademyIsland:FindFirstChild('SpawnPointCrystal_Academy'),
    Judgement = workspace:FindFirstChild('JudgementIsland') and workspace.JudgementIsland:FindFirstChild('SpawnPointCrystal_Judgement'),
    SoulSociety = workspace:FindFirstChild('SoulSocietyIsland') and workspace.SoulSocietyIsland:FindFirstChild('SpawnPointCrystal_SoulSociety')
}

local Connections = {
    Player_General = nil,
    Idled = nil,
    Merchant = nil,
    Dash = nil,
    Knockback = {},
    Reconnect = nil
}

local Flags = {}

pcall(function()
    if Modules.TimedConfig and Modules.TimedConfig.Bosses then
        for _, data in pairs(Modules.TimedConfig.Bosses) do
            table.insert(Tables.BossList, data.displayName)
            local tpName = data.spawnLocation:gsub(' Island', ''):gsub(' Station', '')
            if data.spawnLocation == 'Hueco Mundo Island' then tpName = 'HuecoMundo' end
            if data.spawnLocation == 'Judgement Island' then tpName = 'Judgement' end
            Shared.BossTIMap[data.displayName] = tpName
        end
        table.sort(Tables.BossList)
    end
end)

pcall(function()
    if Modules.SummonConfig and Modules.SummonConfig.Bosses then
        for _, data in pairs(Modules.SummonConfig.Bosses) do
            table.insert(Tables.SummonList, data.displayName)
            SummonMap[data.displayName] = data.bossId
        end
        table.sort(Tables.SummonList)
    end
end)

pcall(function()
    if Modules.BossConfig and Modules.BossConfig.Bosses then
        for bossInternalName in pairs(Modules.BossConfig.Bosses) do
            table.insert(Tables.AllBossList, bossInternalName)
        end
        table.sort(Tables.AllBossList)
    end
end)

pcall(function()
    if MerchantItemList then
        for itemName in pairs(MerchantItemList) do
            table.insert(Tables.MerchantList, itemName)
        end
    end
end)

pcall(function()
    if SortedTitleList then
        for _, v in ipairs(SortedTitleList) do
            table.insert(Tables.TitleList, v)
        end
        local CombinedTitleList = {}
        for _, cat in ipairs(Tables.TitleCategory) do table.insert(CombinedTitleList, cat) end
        for _, t in ipairs(Tables.TitleList) do table.insert(CombinedTitleList, t) end
    end
end)

pcall(function()
    if Modules.Trait and Modules.Trait.Traits then
        for k in pairs(Modules.Trait.Traits) do table.insert(Tables.TraitList, k) end
        table.sort(Tables.TraitList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Trait.Traits[a] and Modules.Trait.Traits[a].Rarity] or 99
            local wb = Tables.RarityWeight[Modules.Trait.Traits[b] and Modules.Trait.Traits[b].Rarity] or 99
            return wa ~= wb and wa < wb or a < b
        end)
    end
end)

pcall(function()
    if Modules.Race and Modules.Race.Races then
        for k in pairs(Modules.Race.Races) do table.insert(Tables.RaceList, k) end
        table.sort(Tables.RaceList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Race.Races[a] and (Modules.Race.Races[a].rarity or Modules.Race.Races[a].Rarity)] or 99
            local wb = Tables.RarityWeight[Modules.Race.Races[b] and (Modules.Race.Races[b].rarity or Modules.Race.Races[b].Rarity)] or 99
            return wa ~= wb and wa < wb or a < b
        end)
    end
end)

pcall(function()
    if Modules.Clan and Modules.Clan.Clans then
        for k in pairs(Modules.Clan.Clans) do table.insert(Tables.ClanList, k) end
        table.sort(Tables.ClanList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Clan.Clans[a] and (Modules.Clan.Clans[a].rarity or Modules.Clan.Clans[a].Rarity)] or 99
            local wb = Tables.RarityWeight[Modules.Clan.Clans[b] and (Modules.Clan.Clans[b].rarity or Modules.Clan.Clans[b].Rarity)] or 99
            return wa ~= wb and wa < wb or a < b
        end)
    end
end)

pcall(function()
    local BloodlineMod = GetSafeModule(RS.Modules, 'BloodlineConfig')
        or GetSafeModule(RS.Modules, 'BloodlineRerollConfig')
    if BloodlineMod then
        local src = BloodlineMod.Bloodlines or BloodlineMod.Clans or {}
        for k in pairs(src) do table.insert(Tables.BloodlineList, k) end
        table.sort(Tables.BloodlineList, function(a, b)
            local wa = Tables.RarityWeight[src[a] and (src[a].rarity or src[a].Rarity)] or 99
            local wb = Tables.RarityWeight[src[b] and (src[b].rarity or src[b].Rarity)] or 99
            return wa ~= wb and wa < wb or a < b
        end)
    end
end)

pcall(function()
    if Modules.SpecPassive and Modules.SpecPassive.Passives then
        for k in pairs(Modules.SpecPassive.Passives) do table.insert(Tables.SpecPassive, k) end
        table.sort(Tables.SpecPassive)
    end
end)

pcall(function()
    local PowerMod = nil
    pcall(function() PowerMod = require(RS.Modules:FindFirstChild('PowerConfig')) end)
    if PowerMod and PowerMod.Powers then
        for k in pairs(PowerMod.Powers) do
            table.insert(Tables.PowerList, k)
        end
        table.sort(Tables.PowerList)
    end
end)

pcall(function()
    if Modules.Quests and Modules.Quests.Questlines then
        for k in pairs(Modules.Quests.Questlines) do table.insert(Tables.QuestlineList, k) end
        table.sort(Tables.QuestlineList)
    end
end)

pcall(function()
    local allSets = {}
    if Modules.ArtifactConfig and Modules.ArtifactConfig.Sets then
        for k in pairs(Modules.ArtifactConfig.Sets) do table.insert(allSets, k) end
    end
    local allStats = {}
    if Modules.ArtifactConfig and Modules.ArtifactConfig.Stats then
        for k in pairs(Modules.ArtifactConfig.Stats) do table.insert(allStats, k) end
    end
end)

for _, v in ipairs(PATH.InteractNPCs:GetChildren()) do
    if not table.find(Tables.AllNPCList, v.Name) then
        table.insert(Tables.AllNPCList, v.Name)
    end
end
table.sort(Tables.AllNPCList)

task.spawn(function()
    task.wait(5)
    local changed = false
    for _, v in ipairs(PATH.InteractNPCs:GetChildren()) do
        if not table.find(Tables.AllNPCList, v.Name) then
            table.insert(Tables.AllNPCList, v.Name)
            changed = true
        end
    end
    if changed then table.sort(Tables.AllNPCList) end
end)

function ToSet(v)
    if type(v) ~= 'table' then return {[v] = true} end
    local s = {}
    for k, val in pairs(v) do
        if type(k) == 'number' then s[val] = true
        else s[k] = val end
    end
    return s
end

function GetSessionTime()
    local s = os.time() - Script_Start_Time
    return string.format('%dh %02dm', math.floor(s / 3600), math.floor((s % 3600) / 60))
end

function CommaFormat(n)
    return tostring(n):reverse():gsub('%d%d%d', '%1,'):reverse():gsub('^,', '')
end

function Abbreviate(n)
    for _, v in ipairs({{1e12, 'T'}, {1e9, 'B'}, {1e6, 'M'}, {1e3, 'K'}}) do
        if n >= v[1] then return string.format('%.1f%s', n / v[1], v[2]) end
    end
    return tostring(n)
end

function Clean(str) return str:gsub('%s+', ''):lower() end

function GetCharacter()
    local c = Plr.Character
    return (c and c:FindFirstChild('HumanoidRootPart') and c:FindFirstChildOfClass('Humanoid')) and c or nil
end

function IsBusy()
    return Plr.Character and Plr.Character:FindFirstChildOfClass('ForceField') ~= nil
end

function GetNearestIsland(targetPos, npcName)
    if npcName and Shared.BossTIMap[npcName] then return Shared.BossTIMap[npcName] end
    local best, minDist = 'Starter', math.huge
    for name, crystal in pairs(IslandCrystals) do
        if crystal then
            local d = (targetPos - crystal:GetPivot().Position).Magnitude
            if d < minDist then minDist = d; best = name end
        end
    end
    return best
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

function IsSmartMatch(npcName, target)
    local n, t = npcName:gsub('%d+$', ''):lower(), target:lower()
    return n == t or t:find(n) == 1 or n:find(t) == 1
end

function IsStrictBossMatch(npcName, displayName)
    local n = npcName:lower():gsub('%s+', '')
    local t = displayName:lower():gsub('%s+', '')
    if n:find('true') and not t:find('true') then return false end
    if t:find('strongest') then
        local era = t:find('history') and 'history' or 'today'
        return n:find('strongest') and n:find(era)
    end
    return n:find(t)
end

function GetRemoteBossArg(name)
    local map = {
        strongestinhistory = 'StrongestHistory',
        strongestoftoday = 'StrongestToday',
        strongesthistory = 'StrongestHistory',
        strongesttoday = 'StrongestToday'
    }
    return map[name:lower()] or name
end

function GetCurrentPity()
    local ok, lbl = pcall(function()
        return PGui.BossUI.MainFrame.BossHPBar.Pity
    end)
    if not ok or not lbl then return 0, 25 end
    local rawText = lbl.Text:gsub('<[^>]+>', '')
    local cur, max = rawText:match('Pity:%s*(%d+)/(%d+)')
    return tonumber(cur) or 0, tonumber(max) or 25
end

function IsBossAlreadySpawned(displayName)
    local searchStr = displayName:lower():gsub('%s+', '')
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        local n = npc.Name:lower():gsub('%s+', '')
        if n:find(searchStr, 1, true) or searchStr:find(n, 1, true) then
            local hum = npc:FindFirstChildOfClass('Humanoid')
            if hum and hum.Health > 0 then return true end
        end
    end
    return false
end
 
function IsSummonable(displayName)
    if table.find(Tables.SummonList, displayName) then return true end
    if table.find(Tables.OtherSummonList, displayName) then return true end
    if table.find(Tables.BossList, displayName) then return true end
    return false
end

function GetCombinedSummonList()
    local combined = {}
    for _, v in ipairs(Tables.SummonList) do table.insert(combined, v) end
    for _, v in ipairs(Tables.OtherSummonList) do
        if not table.find(combined, v) then table.insert(combined, v) end
    end
    return combined
end
 
function FindRemoteDynamic(remoteName)
    for _, folder in pairs({ RS:FindFirstChild('Remotes'), RS:FindFirstChild('RemoteEvents') }) do
        if folder then
            local obj = folder:FindFirstChild(remoteName)
            if obj then return obj end
        end
    end
    return nil
end
 
local _BossRemoteCache = {}

function SafeLoop(name, func)
    return function()
        local ok, err = pcall(func)
        if not ok then
            fnl:MakeNotification({Title = 'Error [' .. name .. ']', Description = tostring(err), Duration = 8})
            warn('Error in [' .. name .. ']: ' .. tostring(err))
        end
    end
end

function Thread(featurePath, featureFunc, isEnabled, ...)
    local parts = featurePath:split('.')
    local cur = Flags
    for i = 1, #parts - 1 do
        local p = parts[i]
        if not cur[p] then cur[p] = {} end
        cur = cur[p]
    end
    local key = parts[#parts]
    local active = cur[key]
    if isEnabled then
        if not active or coroutine.status(active) == 'dead' then
            cur[key] = task.spawn(featureFunc, ...)
        end
    else
        if active and typeof(active) == 'thread' then
            task.cancel(active)
            cur[key] = nil
        end
    end
end

function Cleanup(tbl)
    for k, v in pairs(tbl) do
        if typeof(v) == 'RBXScriptConnection' then
            v:Disconnect(); tbl[k] = nil
        elseif typeof(v) == 'thread' then
            task.cancel(v); tbl[k] = nil
        elseif type(v) == 'table' then
            Cleanup(v)
        end
    end
end

function DisableIdled()
    pcall(function()
        local cons = getconnections or get_signal_cons
        if cons then
            for _, v in pairs(cons(Plr.Idled)) do
                if v.Disable then v:Disable()
                elseif v.Disconnect then v:Disconnect() end
            end
        end
    end)
end

function gsc(guiObject)
    if not guiObject then return false end
    local ok = false
    pcall(function()
        if Services.GuiService and Services.VirtualInputManager then
            Services.GuiService.SelectedObject = guiObject
            task.wait(0.05)
            for _, key in ipairs({Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter, Enum.KeyCode.ButtonA}) do
                Services.VirtualInputManager:SendKeyEvent(true, key, false, game)
                task.wait(0.03)
                Services.VirtualInputManager:SendKeyEvent(false, key, false, game)
                task.wait(0.03)
            end
            Services.GuiService.SelectedObject = nil
            ok = true
        end
    end)
    return ok
end

function GetSecondsFromTimer(text)
    local m, s = text:match('(%d+):(%d+)')
    return m and s and (tonumber(m) * 60 + tonumber(s)) or nil
end

function FormatSecondsToTimer(s)
    return string.format('Refresh: %02d:%02d', math.floor(s / 60), s % 60)
end

Remotes.UpInventory.OnClientEvent:Connect(function(category, data)
    Shared.InventorySynced = true
    if category == 'Items' then
        Shared.Cached_Inv = data or {}
        table.clear(Tables.OwnedItem)
        for _, item in pairs(data) do
            if not table.find(Tables.OwnedItem, item.name) then
                table.insert(Tables.OwnedItem, item.name)
            end
        end
        table.sort(Tables.OwnedItem)
    elseif category == 'Runes' then
        table.clear(Tables.RuneList)
        table.insert(Tables.RuneList, 'None')
        for name in pairs(data) do table.insert(Tables.RuneList, name) end
        table.sort(Tables.RuneList)
    elseif category == 'Accessories' then
        Shared.Cached_Accessories = {}
        table.clear(Tables.OwnedAccessory)
        local seen = {}
        for _, item in ipairs(data) do
            Shared.Cached_Accessories[item.name] = (item.quantity or 0)
            if (item.enchantLevel or 0) < 10 and not seen[item.name] then
                table.insert(Tables.OwnedAccessory, item.name)
                seen[item.name] = true
            end
        end
        table.sort(Tables.OwnedAccessory)
    elseif category == 'Sword' or category == 'Melee' then
        Shared['RawWeap_' .. category] = data or {}
        table.clear(Tables.OwnedWeapon)
        table.clear(Tables.AllOwnedWeapons)
        local seen1, seen2 = {}, {}
        for _, cat in pairs({'Sword', 'Melee'}) do
            for _, item in ipairs(Shared['RawWeap_' .. cat] or {}) do
                if (item.blessingLevel or 0) < 10 and not seen1[item.name] then
                    table.insert(Tables.OwnedWeapon, item.name)
                    seen1[item.name] = true
                end
                if not seen2[item.name] then
                    table.insert(Tables.AllOwnedWeapons, item.name)
                    seen2[item.name] = true
                end
            end
        end
        table.sort(Tables.OwnedWeapon)
        table.sort(Tables.AllOwnedWeapons)
    end
end)

RS.Remotes.NotifyItemDrop.OnClientEvent:Connect(function(data)
    if not data or type(data) ~= 'table' or not data.name then return end
    NewItemsBuffer[data.name] = (NewItemsBuffer[data.name] or 0) + (data.quantity or 1)
end)

Remotes.StockUpdate.OnClientEvent:Connect(function(itemName, stockLeft)
    Shared.CurrentStock[itemName] = tonumber(stockLeft)
end)

Remotes.UpSkillTree.OnClientEvent:Connect(function(data)
    if data then
        Shared.SkillTree.Nodes = data.Nodes or {}
        Shared.SkillTree.SkillPoints = data.SkillPoints or 0
    end
end)

if Remotes.SettingsSync then
    Remotes.SettingsSync.OnClientEvent:Connect(function(data)
        Shared.Settings = data
    end)
end

Remotes.ArtifactSync.OnClientEvent:Connect(function(data)
    Shared.ArtifactSession.Inventory = data.Inventory
    Shared.ArtifactSession.Dust = data.Dust
end)

Remotes.TitleSync.OnClientEvent:Connect(function(data)
    if data and data.unlocked then Tables.UnlockedTitle = data.unlocked end
end)

Remotes.HakiStateUpdate.OnClientEvent:Connect(function(a, b)
    if a == false then Shared.ArmHaki = false; return end
    if a == Plr then Shared.ArmHaki = b end
end)

if Remotes.BossUIUpdate then
    Remotes.BossUIUpdate.OnClientEvent:Connect(function(mode, data)
        if mode == 'DamageStats' and data.stats then
            for _, info in pairs(data.stats) do
                if info.player and info.player:IsA('Player') then
                    Shared.AltDamage[info.player.Name] = tonumber(info.percent) or 0
                end
            end
        end
    end)
end

Remotes.TradeUpdated.OnClientEvent:Connect(function(data)
    Shared.TradeState = data
end)

PATH.Mobs.ChildRemoved:Connect(function(child)
    if child:IsA('Model') and child.Name:lower():find('boss') then
        table.clear(Shared.AltDamage)
        Shared.AltActive = false
    end
end)

Remotes.SpecPassiveUpdate.OnClientEvent:Connect(function(data)
    if type(Shared.Passives) ~= 'table' then Shared.Passives = {} end
    if data and data.Passives then
        for weapName, info in pairs(data.Passives) do
            Shared.Passives[weapName] = type(info) == 'table' and info or {Name = tostring(info), RolledBuffs = {}}
        end
    end
end)


if Remotes.UpPower then
    Remotes.UpPower.OnClientEvent:Connect(function(data)
        if data and data.Current then
            Shared.CurrentPower.Name = data.Current.Name or 'None'
            Shared.CurrentPower.Buffs = data.Current.RolledBuffs or {}
        end
    end)
end

Remotes.UpStatReroll.OnClientEvent:Connect(function(data)
    if data and data.Stats then
        Shared.GemStats = data.Stats
    end
end)


Remotes.UpPlayerStats.OnClientEvent:Connect(function(data)
    if data and data.Stats then Shared.Stats = data.Stats end
end)

Remotes.UpAscend.OnClientEvent:Connect(function(data)
    if not (Toggles.AutoAscend and Toggles.AutoAscend.Value) then return end
    UpdateAscendLabels(data) 
    if data.isMaxed then
        if Toggles.AutoAscend then Toggles.AutoAscend.Value = false end
        return
    end
    if data.allMet then
        fnl:MakeNotification({Title = 'Ascend', Description = 'All requirements met! Ascending to: ' .. tostring(data.nextRankName), Duration = 5})
        Remotes.Ascend:FireServer()
        task.wait(1)
    end
end)

function UpdateNPCLists()
    local special = {'ThiefBoss', 'MonkeyBoss', 'DesertBoss', 'SnowBoss', 'PandaMiniBoss'}
    local current = {}
    for _, n in pairs(Tables.MobList) do current[n] = true end
    for _, v in pairs(PATH.Mobs:GetChildren()) do
        local clean = v.Name:gsub('%d+$', '')
        if (table.find(special, clean) or not clean:find('Boss')) and not current[clean] then
            table.insert(Tables.MobList, clean)
            current[clean] = true
            local best, minD = 'Unknown', math.huge
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

function UpdateAllEntities()
    table.clear(Tables.AllEntitiesList)
    local unique = {}
    for _, v in pairs(PATH.Mobs:GetChildren()) do
        local c = v.Name:gsub('%d+$', '')
        if not unique[c] then
            unique[c] = true
            table.insert(Tables.AllEntitiesList, c)
        end
    end
    table.sort(Tables.AllEntitiesList)
end

function PopulateNPCLists()
    for _, child in ipairs(workspace:GetChildren()) do
        if child.Name:match('^QuestNPC%d+$') and not table.find(Tables.NPC_QuestList, child.Name) then
            table.insert(Tables.NPC_QuestList, child.Name)
        end
    end
    for _, child in ipairs(PATH.InteractNPCs:GetChildren()) do
        if child.Name:match('^QuestNPC%d+$') and not table.find(Tables.NPC_QuestList, child.Name) then
            table.insert(Tables.NPC_QuestList, child.Name)
        end
        local n = child.Name
        if (n:find('Moveset') or n:find('Buyer')) and not n:find('Observation') then
            table.insert(Tables.NPC_MovesetList, n)
        end
        if (n:find('Mastery') or n:find('Questline') or n:find('Craft')) and not (n:find('Grail') or n:find('Slime')) then
            table.insert(Tables.NPC_MasteryList, n)
        end
    end
    table.sort(Tables.NPC_QuestList, function(a, b)
        local na = tonumber(a:match('%d+$')) or 0
        local nb = tonumber(b:match('%d+$')) or 0
        return na == nb and a < b or na < nb
    end)
    table.sort(Tables.NPC_MovesetList)
    table.sort(Tables.NPC_MasteryList)
end

UpdateNPCLists()
UpdateAllEntities()
PopulateNPCLists()

function SafeTeleportToNPC(targetName, customMap)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if not root then return end
    local actual = (customMap and customMap[targetName]) or targetName
    local target = workspace:FindFirstChild(actual) or PATH.InteractNPCs:FindFirstChild(actual)
    if not target then
        for _, v in pairs(PATH.InteractNPCs:GetChildren()) do
            if v.Name:find(actual) then target = v; break end
        end
    end
    if target then
        root.CFrame = target:GetPivot() * CFrame.new(0, 3, 0)
        root.AssemblyLinearVelocity = Vector3.zero
    else
        fnl:MakeNotification({Title = 'TP Failed', Description = 'NPC not found: ' .. tostring(actual), Duration = 3})
    end
end

function HybridMove(targetCF)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if not root then return end
    local dist = (root.Position - targetCF.Position).Magnitude
    local speed = Options.TweenSpeed or 180
    if dist > (Options.TargetDistTP or 0) then
        local tweenTarget = targetCF * CFrame.new(0, 0, 150)
        local duration = (root.Position - tweenTarget.Position).Magnitude / speed
        local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = tweenTarget})
        tw:Play()
        tw.Completed:Wait()
        task.wait(0.1)
    end
    root.CFrame = targetCF
    root.AssemblyLinearVelocity = Vector3.new(0, 0.01, 0)
    task.wait(0.2)
end

function GetWeaponsByType()
    local available = {}
    local enabledTypes = Options.SelectedWeaponType or {}
    local char = GetCharacter()
    local containers = {Plr.Backpack}
    if char then table.insert(containers, char) end
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
    if #list == 0 then Shared.ActiveWeap = ""; return end
    if #list == 1 then
        Shared.ActiveWeap = list[1]
        Shared.WeapRotationIdx = 1
        return
    end
    if Shared.WeapRotationIdx > #list then Shared.WeapRotationIdx = 1 end
    local exists = false
    for _, n in ipairs(list) do
        if n == Shared.ActiveWeap then exists = true; break end
    end
    if not exists then
        Shared.WeapRotationIdx = 1
        Shared.ActiveWeap = list[1]
        Shared.LastWRSwitch = tick()
        return
    end
    local delay = Options.SwitchWeaponCD or 4
    if tick() - Shared.LastWRSwitch >= delay then
        Shared.WeapRotationIdx = Shared.WeapRotationIdx + 1
        if Shared.WeapRotationIdx > #list then Shared.WeapRotationIdx = 1 end
        Shared.ActiveWeap = list[Shared.WeapRotationIdx]
        Shared.LastWRSwitch = tick()
    end
end

function EquipWeapon()
    UpdateWeaponRotation()
    if Shared.ActiveWeap == "" then return end
    local char = GetCharacter()
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if char:FindFirstChild(Shared.ActiveWeap) then return end
    local tool = Plr.Backpack:FindFirstChild(Shared.ActiveWeap)
    if not tool then Shared.ActiveWeap = ""; return end
    local current = char:FindFirstChildOfClass("Tool")
    if current then hum:UnequipTools(); task.wait(0.05) end
    local attempts = 0
    repeat
        hum:EquipTool(tool)
        task.wait(0.05)
        attempts = attempts + 1
    until char:FindFirstChild(Shared.ActiveWeap) or attempts >= 5
end

function CheckArmHaki()
    if Shared.ArmHaki then return true end
    local char = GetCharacter()
    if char then
        local la = char:FindFirstChild('Left Arm') or char:FindFirstChild('LeftUpperArm')
        local ra = char:FindFirstChild('Right Arm') or char:FindFirstChild('RightUpperArm')
        if (la and la:FindFirstChild('Lightning Strike')) or (ra and ra:FindFirstChild('Lightning Strike')) then
            Shared.ArmHaki = true
            return true
        end
    end
    return false
end

function IsSkillReady(key)
    local char = GetCharacter()
    local tool = char and char:FindFirstChildOfClass('Tool')
    if not tool then return true end
    local mainFrame = PGui:FindFirstChild('CooldownUI') and PGui.CooldownUI:FindFirstChild('MainFrame')
    if not mainFrame then return true end
    local cleanTool = Clean(tool.Name)
    for _, frame in pairs(mainFrame:GetChildren()) do
        if not frame:IsA('Frame') then continue end
        local fname = frame.Name:lower()
        if fname:find('cooldown') and (fname:find(cleanTool) or fname:find('skill')) then
            local mapped = 'none'
            if fname:find('skill 1') or fname:find('_z') then mapped = 'Z'
            elseif fname:find('skill 2') or fname:find('_x') then mapped = 'X'
            elseif fname:find('skill 3') or fname:find('_c') then mapped = 'C'
            elseif fname:find('skill 4') or fname:find('_v') then mapped = 'V'
            elseif fname:find('skill 5') or fname:find('_f') then mapped = 'F' end
            if mapped == key then
                local lbl = frame:FindFirstChild('WeaponNameAndCooldown', true)
                return lbl and lbl.Text:find('Ready') or true
            end
        end
    end
    return true
end

function IsValidTarget(npc)
    if not npc or not npc.Parent then return false end
    local hum = npc:FindFirstChildOfClass('Humanoid')
    if not hum then return false end
    if npc:FindFirstChild('IK_Active') then return true end
    local minMaxHP = tonumber(Options.InstaKillMinHP) or 0
    if Toggles.InstaKill and Toggles.InstaKill.Value then
        return hum.MaxHealth >= minMaxHP
    end
    local eligible = (Toggles.InstaKill and Toggles.InstaKill.Value) and hum.MaxHealth >= minMaxHP
    return eligible and (hum.Health > 0 or npc == Shared.Target) or hum.Health > 0
end

function GetBestMobCluster(nameDict)
    local all = {}
    if type(nameDict) ~= 'table' then return nil end
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
            local clean = npc.Name:gsub('%d+$', '')
            if nameDict[clean] and IsValidTarget(npc) then
                table.insert(all, npc)
            end
        end
    end
    if #all == 0 then return nil end
    local best, maxNear = all[1], 0
    for _, a in ipairs(all) do
        local count = 0
        local posA = a:GetPivot().Position
        for _, b in ipairs(all) do
            if (posA - b:GetPivot().Position).Magnitude <= 35 then count = count + 1 end
        end
        if count > maxNear then maxNear = count; best = a end
    end
    return best, maxNear
end

function GetMobTarget()
    if not (Toggles.MobFarm and Toggles.MobFarm.Value) then Shared.MobIdx = 1; return nil end
    local selected = Options.SelectedMob or {}
    local enabled = {}
    for mob, on in pairs(selected) do
        if on then table.insert(enabled, mob) end
    end
    table.sort(enabled)
    if #enabled == 0 then return nil end
    if Shared.MobIdx > #enabled then Shared.MobIdx = 1 end
    local name = enabled[Shared.MobIdx]
    local target = GetBestMobCluster({[name] = true})
    if target then
        return target, GetNearestIsland(target:GetPivot().Position, target.Name), 'Mob'
    else
        Shared.MobIdx = Shared.MobIdx + 1
        return nil
    end
end

function GetAllMobTarget()
    if not (Toggles.AllMobFarm and Toggles.AllMobFarm.Value) then Shared.AllMobIdx = 1; return nil end
    local list = {}
    for _, n in ipairs(Tables.MobList) do
        if n ~= 'TrainingDummy' then table.insert(list, n) end
    end
    if #list == 0 then return nil end
    if Shared.AllMobIdx > #list then Shared.AllMobIdx = 1 end
    local target = GetBestMobCluster({[list[Shared.AllMobIdx]] = true})
    if target then
        return target, GetNearestIsland(target:GetPivot().Position), 'Mob'
    else
        Shared.AllMobIdx = Shared.AllMobIdx + 1
        return nil
    end
end

function GetWorldBossTarget()
    if Toggles.AllBossesFarm and Toggles.AllBossesFarm.Value then
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if npc.Name:find('Boss') and not table.find(Tables.MiniBossList, npc.Name) and IsValidTarget(npc) then
                local island = 'Boss'
                for dName, iName in pairs(Shared.BossTIMap) do
                    if IsStrictBossMatch(npc.Name, dName) then island = iName; break end
                end
                return npc, island, 'Boss'
            end
        end
    end
    if Toggles.BossesFarm and Toggles.BossesFarm.Value then
        local selected = Options.SelectedBosses or {}
        for bossName, on in pairs(selected) do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if IsStrictBossMatch(npc.Name, bossName) and not table.find(Tables.MiniBossList, npc.Name) and IsValidTarget(npc) then
                        return npc, Shared.BossTIMap[bossName] or 'Boss', 'Boss'
                    end
                end
            end
        end
    end
    return nil
end

function GetNearestMobTarget()
    if not (Toggles.NearestMobFarm and Toggles.NearestMobFarm.Value) then return nil end
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if not root then return nil end
    local radius = Options.MobFarmRadius or 500
    local closest, minDist = nil, math.huge
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
            if IsValidTarget(npc) then
                local npcRoot = npc:FindFirstChild('HumanoidRootPart')
                if npcRoot then
                    local dist = (root.Position - npcRoot.Position).Magnitude
                    if dist <= radius and dist < minDist then closest = npc; minDist = dist end
                end
            end
        end
    end
    if closest then return closest, GetNearestIsland(closest:GetPivot().Position), 'Mob' end
    return nil
end

function FireBossRemote(bossDisplayName, diff)
    local low = bossDisplayName:lower():gsub('%s+', '')
    table.clear(Shared.AltDamage)
 
    pcall(function()
        if low:find('rimuru') then
            Remotes.RimuruBoss:FireServer(diff)
        elseif low:find('anos') and not low:find('trueaizen') then
            Remotes.AnosBoss:FireServer('Anos', diff)
        elseif low:find('trueaizen') then
            if Remotes.TrueAizenBoss then Remotes.TrueAizenBoss:FireServer(diff) end
        elseif low:find('greatmage') then
            game:GetService('ReplicatedStorage')
                :WaitForChild('RemoteEvents')
                :WaitForChild('RequestSpawnGreatMage')
                :FireServer('Normal')
        elseif low:find('strongest') then
            local arg = low:find('history') and 'StrongestHistory' or 'StrongestToday'
            Remotes.JJKSummonBoss:FireServer(arg, diff)
        else
            -- Try SummonMap first
            local summonId = SummonMap[bossDisplayName]
            if summonId then
                Remotes.SummonBoss:FireServer(summonId, diff)
                return
            end
            -- Dynamic remote lookup
            local internalId = bossDisplayName:gsub('%s+', '') .. 'Boss'
            if not _BossRemoteCache[internalId] then
                _BossRemoteCache[internalId] =
                    FindRemoteDynamic('RequestSpawn' .. internalId) or
                    FindRemoteDynamic('RequestSpawn' .. bossDisplayName:gsub('%s+', '')) or
                    FindRemoteDynamic('RequestSpawn' .. bossDisplayName:gsub('%s+', '') .. 'Boss')
            end
            if _BossRemoteCache[internalId] then
                _BossRemoteCache[internalId]:FireServer(diff)
            else
                Remotes.SummonBoss:FireServer(internalId, diff)
            end
        end
    end)
end

function GetSummonTarget()
    if not (Toggles.SummonBossFarm and Toggles.SummonBossFarm.Value) then return nil end
    local selected = Options.SelectedSummon
    if not selected then return nil end
    local ls = selected:lower():gsub('%s+', '')
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        local n = npc.Name:lower():gsub('%s+', '')
        local match = false
        if ls:find('strongesthistory') or ls:find('strongestinhistory') then
            match = n:find('strongestinhistory') or n:find('strongesthistory')
        elseif ls:find('strongesttoday') or ls:find('strongestoftoday') then
            match = n:find('strongestoftoday') or n:find('strongesttoday')
        else
            local wName = SummonMap[selected] or (selected:gsub('%s+', '') .. 'Boss')
            match = n:find(wName:lower())
        end
        if match and IsValidTarget(npc) then
            return npc, GetNearestIsland(npc:GetPivot().Position, npc.Name), 'Boss'
        end
    end
    return nil
end

function GetOtherTarget()
    if not (Toggles.OtherSummonFarm and Toggles.OtherSummonFarm.Value) then return nil end
    local selected = Options.SelectedOtherSummon
    if not selected then return nil end
    local ls = selected:lower()
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        local n = npc.Name:lower()
        local match = ls:find('strongest') and n:find('strongest') and ((ls:find('history') and n:find('history')) or (ls:find('today') and n:find('today'))) or n:find(ls)
        if match and IsValidTarget(npc) then
            return npc, GetNearestIsland(npc:GetPivot().Position, npc.Name), 'Boss'
        end
    end
    return nil
end


function GetPityTarget()
    if not (Toggles.PityBossFarm and Toggles.PityBossFarm.Value) then return nil end
    local cur, max = GetCurrentPity()
    local useName = Options.SelectedUsePity
    if not useName then return nil end
    local buildBosses = Options.SelectedBuildPity or {}
    if cur >= (max - 1) then
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if IsStrictBossMatch(npc.Name, useName) and IsValidTarget(npc) then
                return npc, Shared.BossTIMap[useName] or 'Boss', 'Boss'
            end
        end
    else
        for bossName, on in pairs(buildBosses) do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if IsStrictBossMatch(npc.Name, bossName) and IsValidTarget(npc) then
                        return npc, Shared.BossTIMap[bossName] or 'Boss', 'Boss'
                    end
                end
            end
        end
    end
    return nil
end

function GetBestQuestNPC()
    local playerLevel = Plr.Data.Level.Value
    local best, highestLevel = nil, -1
 
    if Modules.Quests and Modules.Quests.RepeatableQuests then
        for npcId, qData in pairs(Modules.Quests.RepeatableQuests) do
            local req = qData.recommendedLevel or 0
            if playerLevel >= req and req > highestLevel then
                highestLevel = req
                best = npcId
            end
        end
    end
 
    if not best then
        for _, v in ipairs(workspace.ServiceNPCs:GetChildren()) do
            if v.Name:lower():find("quest") then
                best = v.Name
                break
            end
        end
    end
    return best or "QuestNPC1"
end

function EnsureQuestSettings()
    local settings = PGui.SettingsUI.MainFrame.Frame.Content.SettingsTabFrame
    local t1 = settings:FindFirstChild('Toggle_EnableQuestRepeat', true)
    if t1 and t1.SettingsHolder.Off.Visible then
        Remotes.SettingsToggle:FireServer('EnableQuestRepeat', true)
        task.wait(0.3)
    end
    local t2 = settings:FindFirstChild('Toggle_AutoQuestRepeat', true)
    if t2 and t2.SettingsHolder.Off.Visible then
        Remotes.SettingsToggle:FireServer('AutoQuestRepeat', true)
    end
end

function UpdateQuest()
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then return end
    pcall(EnsureQuestSettings)
    local target = GetBestQuestNPC()
    local questUI = PGui:FindFirstChild("QuestUI")
    if not questUI then
        --DebugPrint("UpdateQuest", "QuestUI not found in PlayerGui!")
        return
    end
 
    local questFrame = questUI:FindFirstChild("Quest")
    if not questFrame then
       -- DebugPrint("UpdateQuest", "QuestUI.Quest frame not found!")
        return
    end
 
    local innerQuest = questFrame:FindFirstChild("Quest", true)
    local questVisible = innerQuest and innerQuest.Visible or questFrame.Visible
 
    if Shared.QuestNPC ~= target or not questVisible then
       -- DebugPrint("UpdateQuest", "Abandoning old quest, accepting: " .. target)
        Remotes.QuestAbandon:FireServer("repeatable")
 
        local t = 0
        while questVisible and t < 15 do
            task.wait(0.2)
            t = t + 1
            questVisible = innerQuest and innerQuest.Visible or questFrame.Visible
        end
 
        -- Try accept
        Remotes.QuestAccept:FireServer(target)
        t = 0
        while not questVisible and t < 20 do
            task.wait(0.2)
            t = t + 1
            questVisible = innerQuest and innerQuest.Visible or questFrame.Visible
            if t % 5 == 0 then
                Remotes.QuestAccept:FireServer(target)
            end
        end
 
        if questVisible then
            Shared.QuestNPC = target
        else
        end
    end
end

function GetLevelFarmTarget()
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then return nil end
 
    UpdateQuest()
 
    local questUI = PGui:FindFirstChild("QuestUI")
    local questFrame = questUI and questUI:FindFirstChild("Quest")
    local innerQuest = questFrame and questFrame:FindFirstChild("Quest", true)
    local questVisible = innerQuest and innerQuest.Visible or (questFrame and questFrame.Visible)
 
    if not questVisible then
        return nil
    end
 
    -- Try to get mob type from quest config
    local qData = Modules.Quests
        and Modules.Quests.RepeatableQuests
        and Modules.Quests.RepeatableQuests[Shared.QuestNPC]
 
    local targetType = nil
 
    if qData and qData.requirements and qData.requirements[1] then
        targetType = qData.requirements[1].npcType
    end
 
    -- Fallback: read from quest UI text
    if not targetType then
        if questUI then
            for _, lbl in pairs(questUI:GetDescendants()) do
                if lbl:IsA("TextLabel") and lbl.Text ~= "" then
                    local t = lbl.Text
                    -- Look for patterns like "Kill 100 Thief" or "Defeat Monkey"
                    local extracted = t:match("[Kk]ill%s+%d+%s+(%a+)")
                        or t:match("[Dd]efeat%s+%d+%s+(%a+)")
                        or t:match("[Kk]ill%s+(%a+)")
                    if extracted then
                        targetType = extracted
                        break
                    end
                end
            end
        end
    end

    if not targetType then
        return GetNearestMobTarget()
    end
 
    -- Find matching mobs
    local matches = {}
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChildOfClass("Humanoid") then
            if IsSmartMatch(npc.Name, targetType) then
                local clean = npc.Name:gsub("%d+$", "")
                matches[clean] = true
            end
        end
    end
 
    local best = GetBestMobCluster(matches)
    if best then
        return best, GetNearestIsland(best:GetPivot().Position, best.Name), "Mob"
    end
    return GetNearestMobTarget()
end

function ShouldMainWait()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then return false end
    for i = 1, 5 do
        local val = Options['SelectedAlt_' .. i]
        local name = (typeof(val) == 'Instance' and val:IsA('Player')) and val.Name or tostring(val)
        if name and name ~= '' and name ~= 'nil' and name ~= 'None' then
            if (Shared.AltDamage[name] or 0) < 10 then return true end
        end
    end
    return false
end

function GetAltHelpTarget()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then return nil end
    local targetBoss = Options.SelectedAltBoss
    if not targetBoss then return nil end
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if IsStrictBossMatch(npc.Name, targetBoss) and IsValidTarget(npc) then
            Shared.AltActive = ShouldMainWait()
            return npc, Shared.BossTIMap[targetBoss] or 'Boss', 'Boss'
        end
    end
    FireBossRemote(targetBoss, Options.SelectedAltDiff or 'Normal')
    task.wait(0.5)
    return nil
end

function HandleSummons()
    if tick() - Shared.LastSummon < 2 then return end
    if Shared.MerchantBusy then return end
 
    -- 1. Pity
    if Toggles.PityBossFarm and Toggles.PityBossFarm.Value then
        local cur, max = GetCurrentPity()
        local useName = Options.SelectedUsePity
        local buildOpts = Options.SelectedBuildPity or {}
 
        if useName then
            if cur >= (max - 1) then
                if not IsBossAlreadySpawned(useName) and IsSummonable(useName) then
                    FireBossRemote(useName, Options.SelectedPityDiff or 'Normal')
                    Shared.LastSummon = tick()
                    task.wait(0.5)
                    return
                end
            else
                local anySpawned = false
                for bossName, on in pairs(buildOpts) do
                    if on and IsBossAlreadySpawned(bossName) then anySpawned = true; break end
                end
                if not anySpawned then
                    for bossName, on in pairs(buildOpts) do
                        if on and IsSummonable(bossName) then
                            FireBossRemote(bossName, 'Normal')
                            Shared.LastSummon = tick()
                            task.wait(0.5)
                            return
                        end
                    end
                end
            end
        end
    end
 
    -- 2. Auto Summon
    if Toggles.AutoSummon and Toggles.AutoSummon.Value then
        local sel = Options.SelectedSummon
        if sel and not IsBossAlreadySpawned(sel) and IsSummonable(sel) then
            FireBossRemote(sel, Options.SelectedSummonDiff or 'Normal')
            Shared.LastSummon = tick()
            task.wait(0.5)
        end
    end
 
    -- 3. Other Summon
    if Toggles.AutoOtherSummon and Toggles.AutoOtherSummon.Value then
        local sel = Options.SelectedOtherSummon
        if sel then
            local ls = sel:lower():gsub('%s+', '')
            local found = false
            for _, npc in pairs(PATH.Mobs:GetChildren()) do
                if npc.Name:lower():gsub('%s+', ''):find(ls) then found = true; break end
            end
            if not found then
                FireBossRemote(sel, Options.SelectedOtherSummonDiff or 'Normal')
                Shared.LastSummon = tick()
                task.wait(0.5)
            end
        end
    end
end

local SeaBossKeywords = {
    'Sea Serpent',
    'Kraken',
    'kraken',
    'sea serpent'
}

function FindLiveBossAnywhere(keywords)
    if not keywords then return nil end
    for _, obj in ipairs(workspace:GetDescendants()) do
        local hum = obj:FindFirstChildOfClass('Humanoid')
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

local PriorityNameMap = {
    ['Hunt Nearby Mobs']  = 'Nearest Mob',
    ['Quest Level Farm']  = 'Level Farm',
    ['Selected Mob Farm'] = 'Mob',
    ['Farm All Mobs']     = 'All Mob Farm',
    ['World Boss Farm']   = 'Boss',
    ['Pity System Boss']  = 'Pity Boss',
    ['Summon Boss Farm']  = 'Summon',
    ['Auto Merchant']     = 'Merchant',
    ['Sea Beast Farm']    = 'Sea Boss'
}

function CheckTask(taskName)
    local internalName = PriorityNameMap[taskName] or taskName

    if internalName == 'Merchant' then
        return (Toggles.AutoMerchant and Toggles.AutoMerchant.Value and Shared.MerchantBusy) and {true, nil, 'None'} or nil
    elseif internalName == 'Pity Boss' then
        return GetPityTarget()
    elseif internalName == 'Summon' then
        return GetSummonTarget()
    elseif internalName == 'Boss' then
        return GetWorldBossTarget()
    elseif internalName == 'Level Farm' then
        return GetLevelFarmTarget()
    elseif internalName == 'All Mob Farm' then
        return GetAllMobTarget()
    elseif internalName == 'Mob' then
        return GetMobTarget()
    elseif internalName == 'Alt Help' then
        return GetAltHelpTarget()
    elseif internalName == 'Nearest Mob' then
        return GetNearestMobTarget()
    elseif internalName == 'Sea Boss' then
        if not (Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value) then return nil end
        if not SeaBossKeywords then return nil end
        local boss = FindLiveBossAnywhere(SeaBossKeywords)
        if boss then
            return boss, GetNearestIsland(boss:GetPivot().Position), 'Boss'
        end
        return nil
    end

    return nil
end

function GetBestOwnedTitle(category)
    if #Tables.UnlockedTitle == 0 then return nil end
    local statMap = {
        ['Best EXP'] = 'XPPercent',
        ['Best Money & Gem'] = 'MoneyPercent',
        ['Best Luck'] = 'LuckPercent',
        ['Best DMG'] = 'DamagePercent'
    }
    local targetStat = statMap[category]
    if not targetStat then return nil end
    local bestId, highest = nil, -1
    for _, id in ipairs(Tables.UnlockedTitle) do
        local data = Modules.Title.Titles[id]
        if data and data.statBonuses and (data.statBonuses[targetStat] or 0) > highest then
            highest = data.statBonuses[targetStat]
            bestId = id
        end
    end
    return bestId
end

function UpdateSwitchState(target, farmType)
    if Shared.GlobalPrio == 'COMBO' then return end
    local types = {
        {id = 'Title', remote = Remotes.EquipTitle, method = function(v) return v end},
        {id = 'Rune',  remote = Remotes.EquipRune,  method = function(v) return {'Equip', v} end},
        {id = 'Build', remote = Remotes.LoadoutLoad, method = function(v) return tonumber(v) end}
    }
    for _, sw in ipairs(types) do
        local tog = Toggles['Auto' .. sw.id]
        if not (tog and tog.Value) then continue end
        if sw.id == 'Build' and tick() - Shared.LastBuildSwitch < 3.1 then continue end

        local threshold = Options[sw.id .. '_BossHPAmt'] or 15
        local isLow = false


        if farmType == 'Boss' and target and target.Parent then
            local hum = target:FindFirstChildOfClass('Humanoid')
            if hum and hum.MaxHealth > 0 then
                local hpPercent = (hum.Health / hum.MaxHealth) * 100
                     isLow = hpPercent <= threshold and hpPercent > 0
                     print(string.format('Boss HP: %.1f%% | Threshold: %d%% | isLow: %s', 
                     hpPercent, threshold, tostring(isLow)))
            end
        end

        local toEquip = ''

        if not farmType or farmType == 'None' then
            -- not farming anything, use default
            toEquip = Options['Default' .. sw.id] or ''
        elseif farmType == 'Mob' then
            toEquip = Options[sw.id .. '_Mob'] or ''
            -- fallback to default if mob not set
            if toEquip == '' or toEquip == 'None' then
                toEquip = Options['Default' .. sw.id] or ''
            end
        elseif farmType == 'Boss' then
            if isLow then
                -- boss HP is below threshold, use BossHP title
                toEquip = Options[sw.id .. '_BossHP'] or ''
                -- fallback to Boss title if BossHP not set
                if toEquip == '' or toEquip == 'None' then
                    toEquip = Options[sw.id .. '_Boss'] or ''
                end
            else
                -- boss HP is still high, use normal Boss title
                toEquip = Options[sw.id .. '_Boss'] or ''
            end
            -- fallback to default if boss not set
            if toEquip == '' or toEquip == 'None' then
                toEquip = Options['Default' .. sw.id] or ''
            end
        end

        if not toEquip or toEquip == '' or toEquip == 'None' then continue end

        local final = toEquip
        if sw.id == 'Title' and toEquip:find('Best ') then
            final = GetBestOwnedTitle(toEquip)
            if not final then continue end
        end

        local stateKey = sw.id .. '_' .. (farmType or 'None') .. '_' .. tostring(isLow)
        if final ~= Shared.LastSwitch[sw.id] or Shared['_LastFarmType_' .. sw.id] ~= stateKey then
            pcall(function()
                local args = sw.method(final)
                if type(args) == 'table' then
                    sw.remote:FireServer(table.unpack(args))
                else
                    sw.remote:FireServer(args)
                end
            end)
            Shared.LastSwitch[sw.id] = final
            Shared['_LastFarmType_' .. sw.id] = stateKey
            if sw.id == 'Build' then Shared.LastBuildSwitch = tick() end
        end
    end
end
function ForceSwitch(switchType, value)
    if not value or value == '' or value == 'None' then
        fnl:MakeNotification({
            Title = 'Switch Test',
            Description = 'No value selected for ' .. switchType,
            Duration = 3
        })
        return
    end

    Shared.LastSwitch[switchType] = ''
    Shared['_LastFarmType_' .. switchType] = ''

    if switchType == 'Title' then
        local final = value
        if value:find('Best ') then
            final = GetBestOwnedTitle(value)
            if not final then
                fnl:MakeNotification({
                    Title = 'Switch Test',
                    Description = 'No owned title found for: ' .. value,
                    Duration = 3
                })
                return
            end
        end
        local ok, err = pcall(function()
            Remotes.EquipTitle:FireServer(final)
        end)
        fnl:MakeNotification({
            Title = 'Title Test',
            Description = ok and 'Equipped: ' .. tostring(final) or 'Failed: ' .. tostring(err),
            Duration = 4
        })

    elseif switchType == 'Rune' then
        local ok, err = pcall(function()
            Remotes.EquipRune:FireServer('Equip', value)
        end)
        fnl:MakeNotification({
            Title = 'Rune Test',
            Description = ok and 'Equipped: ' .. tostring(value) or 'Failed: ' .. tostring(err),
            Duration = 4
        })

    elseif switchType == 'Build' then
        local num = tonumber(value)
        if not num then
            fnl:MakeNotification({
                Title = 'Switch Test',
                Description = 'Invalid build number: ' .. tostring(value),
                Duration = 3
            })
            return
        end
        local ok, err = pcall(function()
            Remotes.LoadoutLoad:FireServer(num)
        end)
        fnl:MakeNotification({
            Title = 'Build Test',
            Description = ok and 'Loaded Build: ' .. tostring(num) or 'Failed: ' .. tostring(err),
            Duration = 4
        })
    end
end

local ActiveTween = nil
local LastMoveTime = 0
local TWEEN_COOLDOWN = 0.15

function ExecuteFarmLogic(target, island, farmType)
    local char = GetCharacter()
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not target or Shared.Recovering or not root or not hum then return end

    if Shared.MovingIsland then return end
    Shared.Target = target
    Shared.AltActive = (Toggles.AltBossFarm and Toggles.AltBossFarm.Value and farmType == "Boss") and ShouldMainWait() or false

    if Toggles.IslandTP and Toggles.IslandTP.Value then
        if island and island ~= "" and island ~= "Unknown" and island ~= Shared.Island then
            Shared.MovingIsland = true
            Remotes.TP_Portal:FireServer(island)
            task.wait(Options.IslandTPCD or 0.8)
            Shared.Island = island
            Shared.MovingIsland = false
            return
        end
    end

    local targetCF = target:GetPivot()
    local targetPos = targetCF.Position
    local dist = Options.Distance or 5
    local posType = Options.SelectedFarmType or "Behind"
    local finalPos

    if Shared.AltActive then
        finalPos = targetPos + Vector3.new(0, 120, 0)
    elseif posType == "Above" then
        finalPos = targetPos + Vector3.new(0, dist, 0)
    elseif posType == "Below" then
        finalPos = targetPos + Vector3.new(0, -dist, 0)
    else
        finalPos = (targetCF * CFrame.new(0, 0, dist)).Position
    end

    local dest = CFrame.lookAt(finalPos, targetPos)
    local movementType = Options.SelectedMovementType or "Tween"
    local distance = (root.Position - finalPos).Magnitude
    local DEAD_ZONE = 2.5

    if movementType == "Teleport" then
        if distance > DEAD_ZONE then
            if ActiveTween then ActiveTween:Cancel(); ActiveTween = nil end
            root.CFrame = dest
        end
    elseif movementType == "Tween" then
        if distance > DEAD_ZONE and tick() - LastMoveTime > TWEEN_COOLDOWN then
            LastMoveTime = tick()
            if ActiveTween then ActiveTween:Cancel(); ActiveTween = nil end

            local speed = Options.TweenSpeed or 160
            local duration = math.clamp(distance / speed, 0.05, 0.35)

            ActiveTween = TweenService:Create(
                root,
                TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                { CFrame = dest }
            )
            ActiveTween:Play()
            ActiveTween.Completed:Once(function() ActiveTween = nil end)
        end
    end

    root.CFrame = dest
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    root.Velocity = Vector3.zero

    -- InstaKill logic (taolao V1/V2 style)
    local npcHum = target:FindFirstChildOfClass("Humanoid")
    if Toggles.InstaKill and Toggles.InstaKill.Value then
        local minHP = Options.InstaKillMinHP or 0
        local hpThreshold = Options.InstaKillHP or 90
        local ikType = Options.InstaKillType or "V1"

        if npcHum and npcHum.MaxHealth >= minHP then
            local hpPercent = (npcHum.Health / npcHum.MaxHealth) * 100

            if hpPercent < hpThreshold then
                pcall(function() npcHum.Health = 0 end)

                if ikType == "V1" then
                    if not target:GetAttribute("IK_Active") then
                        target:SetAttribute("IK_Active", true)
                        target:SetAttribute("TriggerTime", tick())
                    end
                end

                for i = 1, 5 do
                    pcall(function() Remotes.M1:FireServer() end)
                end
            end
        end
    end
end




local TargetGroupId = 1002185259
local BannedRanks = {255, 254, 175, 150}

function CheckPlayerForSafety(p)
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) or p == Plr then return end
    local types = Options.SelectedKickType or {}
    if types['Player Join'] then
        task.wait(0.5)
        Plr:Kick('\n[Zen Hub]\nReason: Player joined (' .. p.Name .. ')')
        return
    end
    if types.Mod then
        local ok, rank = pcall(function() return p:GetRankInGroup(TargetGroupId) end)
        if ok and table.find(BannedRanks, rank) then
            task.wait(0.5)
            Plr:Kick('\n[Zen Hub]\nReason: Moderator Detected (' .. p.Name .. ')')
        end
    end
end

function CheckServerTypeSafety()
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) then return end
    local types = Options.SelectedKickType or {}
    if not types['Public Server'] then return end
    local ok, serverType = pcall(function()
        local remote = game:GetService('RobloxReplicatedStorage'):WaitForChild('GetServerType', 2)
        return remote and remote:InvokeServer() or 'Unknown'
    end)
    if ok and serverType ~= 'VIPServer' then
        task.wait(0.8)
        Plr:Kick('\n[Zen Hub]\nReason: You are in a public server.')
    end
end

function InitAutoKick()
    CheckServerTypeSafety()
    for _, p in ipairs(Players:GetPlayers()) do CheckPlayerForSafety(p) end
    Players.PlayerAdded:Connect(CheckPlayerForSafety)
end

function PanicStop()
    Shared.Farm = false
    Shared.AltActive = false
    Shared.GlobalPrio = 'FARM'
    Shared.Target = nil
    Shared.MovingIsland = false
    for k, tog in pairs(Toggles) do
        if type(tog) == 'table' and tog.Value ~= nil then tog.Value = false end
    end
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = root.CFrame * CFrame.new(0, 2, 0)
    end
    task.delay(0.5, function() Shared.Farm = true end)
    fnl:MakeNotification({Title = 'Stopped', Description = 'All features paused.', Duration = 5})
end

function ApplyFPSBoost(state)
    if not state then return end
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA('PostProcessEffect') or v:IsA('BloomEffect') or v:IsA('BlurEffect') or v:IsA('SunRaysEffect') then
                v.Enabled = false
            end
        end
        task.spawn(function()
            for i, v in pairs(workspace:GetDescendants()) do
                if Toggles.FPSBoost and not Toggles.FPSBoost.Value then break end
                pcall(function()
                    if v:IsA('BasePart') then
                        v.Material = Enum.Material.SmoothPlastic
                        v.CastShadow = false
                    elseif v:IsA('Decal') or v:IsA('Texture') then
                        v:Destroy()
                    elseif v:IsA('ParticleEmitter') or v:IsA('Trail') or v:IsA('Beam') then
                        v.Enabled = false
                    end
                end)
                if i % 500 == 0 then task.wait() end
            end
        end)
    end)
end

function ApplyIslandWipe()
    if not (Toggles.FPSBoost_AF and Toggles.FPSBoost_AF.Value) then return end
    task.spawn(function()
        local protect = {'SpawnPointCrystal_', 'Portal_'}
        pcall(function()
            for _, folder in pairs(workspace:GetChildren()) do
                local n = folder.Name
                if folder:IsA('Folder') and (n:lower():find('island') or n == 'HuecoMundo' or n == 'ShibuyaStation') then
                    local desc = folder:GetDescendants()
                    for i, obj in ipairs(desc) do
                        if obj:IsA('Model') or obj:IsA('BasePart') then
                            local safe = false
                            for _, kw in ipairs(protect) do
                                if obj.Name:find(kw) then safe = true; break end
                            end
                            if not safe then pcall(function() obj:Destroy() end) end
                        end
                        if i % 300 == 0 then task.wait() end
                    end
                end
            end
            for i, v in ipairs(workspace:GetChildren()) do
                local safe = v.Name:find('TimedBossSpawn_') or v.Name == Plr.Name or v.Name == 'Main Temple' or v.Name == 'NPCs' or v.Name == 'ServiceNPCs' or v.Name:find('QuestNPC') or v:IsA('Camera') or v:IsA('Terrain') or v.Name:find('Portal_')
                if not safe and (v:IsA('Model') or v:IsA('BasePart')) then
                    pcall(function() v:Destroy() end)
                end
                if i % 100 == 0 then task.wait() end
            end
        end)
    end)
end

function FuncTPW()
    while true do
        local delta = RunService.Heartbeat:Wait()
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')
        if char and hum and hum.Health > 0 and hum.MoveDirection.Magnitude > 0 then
            char:TranslateBy(hum.MoveDirection * (Options.TPWValue or 1) * delta * 10)
        end
    end
end

function FuncNoclip()
    while Toggles.Noclip and Toggles.Noclip.Value do
        RunService.Stepped:Wait()
        local char = GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA('BasePart') and part.CanCollide then part.CanCollide = false end
            end
        end
    end
end

function Func_AntiKnockback()
    if type(Connections.Knockback) == 'table' then
        for _, c in pairs(Connections.Knockback) do if c then c:Disconnect() end end
        table.clear(Connections.Knockback)
    else
        Connections.Knockback = {}
    end
    function applyAKB(character)
        if not character then return end
        local root = character:WaitForChild('HumanoidRootPart', 10)
        if root then
            local conn = root.ChildAdded:Connect(function(child)
                if not (Toggles.AntiKnockback and Toggles.AntiKnockback.Value) then return end
                if child:IsA('BodyVelocity') and child.MaxForce == Vector3.new(40000, 40000, 40000) then
                    child:Destroy()
                end
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

function Func_AutoReconnect()
    if Connections.Reconnect then Connections.Reconnect:Disconnect() end
    Connections.Reconnect = GuiService.ErrorMessageChanged:Connect(function()
        if not (Toggles.AutoReconnect and Toggles.AutoReconnect.Value) then return end
        task.delay(2, function()
            pcall(function()
                local promptOverlay = game:GetService('CoreGui'):FindFirstChild('RobloxPromptGui')
                if promptOverlay then
                    local ep = promptOverlay.promptOverlay:FindFirstChild('ErrorPrompt')
                    if ep and ep.Visible then
                        task.wait(5)
                        TeleportService:Teleport(game.PlaceId, Plr)
                    end
                end
            end)
        end)
    end)
end

function Func_NoGameplayPaused()
    while Toggles.NoGameplayPaused and Toggles.NoGameplayPaused.Value do
        pcall(function()
            local p = game:GetService('CoreGui').RobloxGui:FindFirstChild('CoreScripts/NetworkPause')
            if p then p:Destroy() end
        end)
        task.wait(1)
    end
end

function CheckObsHaki()
    local ok, active = pcall(function()
        local mainFrame = Plr.PlayerGui:WaitForChild("DodgeCounterUI"):WaitForChild("MainFrame")
        return mainFrame.Visible
    end)
    return ok and active
end

function Func_AutoHaki()
    while task.wait(0.5) do
        if Toggles.ObserHaki and Toggles.ObserHaki.Value then
            if not CheckObsHaki() then
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
                end)
                task.wait(1)
            end
        end
        if Toggles.ArmHaki and Toggles.ArmHaki.Value then
            if not CheckArmHaki() then
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HakiRemote"):FireServer("Toggle")
                end)
                task.wait(1)
            end
        end
        if Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value then
            if not (Toggles.OnlyTarget and Toggles.OnlyTarget.Value) or (Shared.Farm and Shared.Target and Shared.Target.Parent) then
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ConquerorHakiRemote"):FireServer("Activate")
                end)
            end
        end
    end
end

function ReactivateHaki()
    task.wait(3)
    if Toggles.ObserHaki and Toggles.ObserHaki.Value then
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ObservationHakiRemote"):FireServer("Toggle")
        end)
    end
    task.wait(1)
    if Toggles.ArmHaki and Toggles.ArmHaki.Value then
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HakiRemote"):FireServer("Toggle")
        end)
    end
end

Plr.CharacterAdded:Connect(function() task.spawn(ReactivateHaki) end)

function Func_AutoM1()
    while task.wait(Options.M1Speed or 0.2) do
        if Toggles.AutoM1 and Toggles.AutoM1.Value then Remotes.M1:FireServer() end
    end
end

function Func_KillAura()
    while Toggles.KillAura and Toggles.KillAura.Value do
        if IsBusy() then task.wait(0.1); continue end
 
        local nearest, minDist = nil, Options.KillAuraRange or 200
        local char = Plr.Character
        local root = char and char:FindFirstChild('HumanoidRootPart')
 
        if root then
            for _, v in ipairs(PATH.Mobs:GetChildren()) do
                if v:IsA('Model') then
                    local d = (root.Position - v:GetPivot().Position).Magnitude
                    local hum = v:FindFirstChildOfClass('Humanoid')
                    if d <= minDist and hum and hum.Health > 0 then
                        minDist = d
                        nearest = v
                    end
                end
            end
        end
 
        if nearest then
            EquipWeapon()
            pcall(function() Remotes.M1:FireServer(nearest:GetPivot().Position) end)
        end
 
        task.wait(Options.KillAuraCD or 0.12)
    end
end

local function Func_AutoSkill()
    local keyToSlot = {Z = 1, X = 2, C = 3, V = 4, F = 5}
    local keyToEnum = {Z = Enum.KeyCode.Z, X = Enum.KeyCode.X, C = Enum.KeyCode.C, V = Enum.KeyCode.V, F = Enum.KeyCode.F}
    local priority = {'Z', 'X', 'C', 'V', 'F'}
    while task.wait() do
        if not (Toggles.AutoSkill and Toggles.AutoSkill.Value) then continue end
        local target = Shared.Target
        if not target or not target.Parent then continue end
        local hum = target:FindFirstChildOfClass('Humanoid')
        if not hum or hum.Health <= 0 then continue end
        if (time() - (Shared.LastM1 or 0)) > 0.35 then continue end
        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        local npcRoot = target:FindFirstChild('HumanoidRootPart')
        if not (root and npcRoot) then continue end
        if (root.Position - npcRoot.Position).Magnitude > 40 then continue end
        if Toggles.AutoSkill_BossOnly and Toggles.AutoSkill_BossOnly.Value then
            local isBoss = target.Name:find('Boss') and not table.find(Tables.MiniBossList, target.Name)
            local hp = (hum.Health / hum.MaxHealth * 100)
            if not isBoss or hp > (Options.AutoSkill_BossHP or 100) then continue end
        end
        local tool = char and char:FindFirstChildOfClass('Tool')
        if not tool then continue end
        local selected = Options.SelectedSkills or {}
        local toolType = GetToolTypeFromModule(tool.Name)
        local mode = Options.AutoSkillType or 'Normal'
        for _, key in ipairs(priority) do
            if selected[key] then
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {FruitPower = tool.Name:gsub(' Fruit', ''), KeyCode = keyToEnum[key]})
                else
                    Remotes.UseSkill:FireServer(keyToSlot[key])
                end
                task.wait(mode == 'Instant' and 0.05 or 0.15)
            end
        end
    end
end

function Func_AutoCombo()
    Shared.ComboIdx = 1
    while Toggles.AutoCombo and Toggles.AutoCombo.Value do
        task.wait(0.1)
        local raw = Options.ComboPattern or 'Z>X>C>V>F'
        Shared.ParsedCombo = {}
        for item in raw:upper():gsub('%s+', ''):gmatch('([^,>]+)') do
            table.insert(Shared.ParsedCombo, item)
        end
        if #Shared.ParsedCombo == 0 then continue end
        if Shared.ComboIdx > #Shared.ParsedCombo then Shared.ComboIdx = 1 end
        if IsBusy() then
            local t = tick()
            repeat task.wait(0.1) until not IsBusy() or tick() - t > 8
        end
        task.wait(0.4)
        if Toggles.ComboBossOnly and Toggles.ComboBossOnly.Value then
            if not Shared.Target or not Shared.Target.Parent or not Shared.Target.Name:lower():find('boss') then
                Shared.ComboIdx = 1; task.wait(0.5); continue
            end
        end
        local action = Shared.ParsedCombo[Shared.ComboIdx]
        local waitTime = tonumber(action)
        if waitTime then
            if (Options.ComboMode or 'Normal') == 'Normal' then task.wait(waitTime) end
            Shared.ComboIdx = Shared.ComboIdx + 1
            continue
        end
        if IsSkillReady(action) then
            if action == 'F' then
                Shared.GlobalPrio = 'COMBO'
                local cTitle = Options.Title_Combo
                local cRune = Options.Rune_Combo
                if cTitle and cTitle ~= 'None' then Remotes.EquipTitle:FireServer(cTitle) end
                if cRune and cRune ~= 'None' then Remotes.EquipRune:FireServer('Equip', cRune) end
                Shared.LastSwitch.Title = cTitle
                Shared.LastSwitch.Rune = cRune
                task.wait(0.7)
                local confirmed = false
                repeat
                    EquipWeapon()
                    Remotes.UseSkill:FireServer(5)
                    local t = tick()
                    repeat
                        task.wait(0.1)
                        if not IsSkillReady('F') then confirmed = true end
                    until confirmed or tick() - t > 1
                until confirmed or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)
                local started = false
                local ct = tick()
                repeat
                    task.wait()
                    if IsBusy() then started = true end
                until started or tick() - ct > 2
                if started then
                    local ht = tick()
                    repeat task.wait(0.1) until not IsBusy() or tick() - ht > 15
                else
                    task.wait(2.5)
                end
                Shared.GlobalPrio = 'FARM'
                Shared.LastSwitch.Title = ''
                Shared.LastSwitch.Rune = ''
                Shared.ComboIdx = Shared.ComboIdx + 1
                task.wait(0.3)
            else
                local slot = ({Z = 1, X = 2, C = 3, V = 4})[action] or 1
                local done = false
                repeat
                    Remotes.UseSkill:FireServer(slot)
                    local t = tick()
                    repeat
                        task.wait(0.1)
                        if not IsSkillReady(action) or IsBusy() then done = true end
                    until done or tick() - t > 1.2
                until done or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)
                if done then Shared.ComboIdx = Shared.ComboIdx + 1; task.wait(0.2) end
            end
        else
            task.wait(0.2)
        end
    end
end

function Func_AutoStats()
    local MAX = 11500
    while task.wait(1) do
        if not (Toggles.AutoStats and Toggles.AutoStats.Value) then break end
        local pts = Plr:WaitForChild('Data'):WaitForChild('StatPoints').Value
        if pts > 0 then
            local selected = Options.SelectedStats or {}
            local active = {}
            for stat, on in pairs(selected) do
                if on and (Shared.Stats[stat] or 0) < MAX then table.insert(active, stat) end
            end
            if #active > 0 then
                local perStat = math.floor(pts / #active)
                if perStat > 0 then
                    for _, s in ipairs(active) do Remotes.AddStat:FireServer(s, perStat) end
                else
                    Remotes.AddStat:FireServer(active[1], pts)
                end
            end
        end
    end
end

function Func_AutoSkillTree()
    while Toggles.AutoSkillTree and Toggles.AutoSkillTree.Value do
        task.wait(0.5)
        local points = Shared.SkillTree.SkillPoints or 0
        if points <= 0 then task.wait(1); continue end
 
        local SkillMod = nil
        pcall(function()
            SkillMod = require(RS.Modules:FindFirstChild('SkillTreeConfig') or RS.Modules:FindFirstChild('SkillTree'))
        end)
 
        if SkillMod and SkillMod.Branches then
            for _, branch in pairs(SkillMod.Branches) do
                for _, node in ipairs(branch.Nodes or {}) do
                    if not Shared.SkillTree.Nodes[node.Id] then
                        local cost = node.Cost or 1
                        if points >= cost then
                            pcall(function() Remotes.SkillTreeUpgrade:FireServer(node.Id) end)
                            Shared.SkillTree.SkillPoints = (Shared.SkillTree.SkillPoints or cost) - cost
                            task.wait(0.3)
                        end
                        break
                    end
                end
            end
        else
            -- Fallback: just fire with available points
            pcall(function() Remotes.SkillTreeUpgrade:FireServer('auto', points) end)
            task.wait(1)
        end
    end
end

function Func_AutoPower()
    while Toggles.AutoPower and Toggles.AutoPower.Value do
        local targets = Options.SelectedPower or {}
        local curName = Shared.CurrentPower.Name or 'None'
        local isTarget = (type(targets) == 'table') and targets[curName]
 
        if not isTarget then
            -- Skip lower rarities
            pcall(function()
                if Remotes.PowerSkip then
                    Remotes.PowerSkip:FireServer({ Epic = true, Legendary = true, Mythical = true })
                end
            end)
            pcall(function()
                if Remotes.PowerRoll then
                    Remotes.PowerRoll:FireServer()
                end
            end)
            task.wait(Options.PowerRollCD or 0.3)
        else
            fnl:MakeNotification({ Title = 'Power', Description = 'Got: ' .. curName, Duration = 5 })
            Toggles.AutoPower.Value = false
            break
        end
        task.wait()
    end
end

function AutoRollStatsLoop()
    local selStats = Options.SelectedGemStats or {}
    local selRanks = Options.SelectedRank or {}
    local hasStat, hasRank = false, false
    for _ in pairs(selStats) do hasStat = true; break end
    for _ in pairs(selRanks) do hasRank = true; break end
    if not hasStat or not hasRank then
        fnl:MakeNotification({Title = 'Error', Description = 'Select at least one stat and rank first!', Duration = 5})
        if Toggles.AutoRollStats then Toggles.AutoRollStats.Value = false end
        return
    end
    while Toggles.AutoRollStats and Toggles.AutoRollStats.Value do
        if not next(Shared.GemStats) then task.wait(0.1); continue end
        local done = true
        for _, statName in ipairs(Tables.GemStat) do
            if selStats[statName] then
                local cur = Shared.GemStats[statName]
                if cur and not selRanks[cur.Rank] then
                    done = false
                    pcall(function() Remotes.RerollSingleStat:InvokeServer(statName) end)
                    task.wait(Options.StatsRollCD or 0.1)
                    break
                end
            end
        end
        if done then
            fnl:MakeNotification({Title = 'Done', Description = 'Stats rolled successfully.', Duration = 5})
            if Toggles.AutoRollStats then Toggles.AutoRollStats.Value = false end
            break
        end
        task.wait()
    end
end

function SyncTraitAutoSkip()
    if not (Toggles.AutoTrait and Toggles.AutoTrait.Value) then return end
    pcall(function()
        local selected = Options.SelectedTrait or {}
        local hier = {Epic = 1, Legendary = 2, Mythical = 3, Secret = 4}
        local lowest = 99
        for name, on in pairs(selected) do
            if on then
                local data = Modules.Trait.Traits[name]
                if data then
                    local v = hier[data.Rarity] or 0
                    if v > 0 and v < lowest then lowest = v end
                end
            end
        end
        if lowest == 99 then return end
        Remotes.TraitAutoSkip:FireServer({Epic = 1 < lowest, Legendary = 2 < lowest, Mythical = 3 < lowest, Secret = 4 < lowest})
    end)
end

function SyncRaceSettings()
    if not (Toggles.AutoRace and Toggles.AutoRace.Value) then return end
    pcall(function()
        local selected = Options.SelectedRace or {}
        local hasEpic, hasLeg = false, false
        for name, data in pairs(Modules.Race.Races) do
            local r = data.rarity or data.Rarity
            if r == 'Mythical' then
                local skip = not selected[name]
                if Shared.Settings['SkipRace_' .. name] ~= skip then
                    Remotes.SettingsToggle:FireServer('SkipRace_' .. name, skip)
                end
            end
            if selected[name] then
                if r == 'Epic' then hasEpic = true end
                if r == 'Legendary' then hasLeg = true end
            end
        end
        if Shared.Settings.SkipEpicReroll ~= not hasEpic then
            Remotes.SettingsToggle:FireServer('SkipEpicReroll', not hasEpic)
        end
        if Shared.Settings.SkipLegendaryReroll ~= not hasLeg then
            Remotes.SettingsToggle:FireServer('SkipLegendaryReroll', not hasLeg)
        end
    end)
end

function SyncClanSettings()
    if not (Toggles.AutoClan and Toggles.AutoClan.Value) then return end
    pcall(function()
        local selected = Options.SelectedClan or {}
        local hasEpic, hasLeg = false, false
        for name, data in pairs(Modules.Clan.Clans) do
            local r = data.rarity or data.Rarity
            if r == 'Legendary' then
                local skip = not selected[name]
                if Shared.Settings['SkipClan_' .. name] ~= skip then
                    Remotes.SettingsToggle:FireServer('SkipClan_' .. name, skip)
                end
            end
            if selected[name] then
                if r == 'Epic' then hasEpic = true end
                if r == 'Legendary' then hasLeg = true end
            end
        end
        if Shared.Settings.SkipEpicClan ~= not hasEpic then
            Remotes.SettingsToggle:FireServer('SkipEpicClan', not hasEpic)
        end
        if Shared.Settings.SkipLegendaryClan ~= not hasLeg then
            Remotes.SettingsToggle:FireServer('SkipLegendaryClan', not hasLeg)
        end
    end)
end

function Func_UnifiedRollManager()
    while task.wait() do
        if Toggles.AutoTrait and Toggles.AutoTrait.Value then
            local traitUI = PGui:WaitForChild('TraitRerollUI').MainFrame.Frame.Content.TraitPage.TraitGottenFrame.Holder.Trait.TraitGotten
            local confirmFrame = PGui.TraitRerollUI.MainFrame.Frame.Content:FindFirstChild('AreYouSureYouWantToRerollFrame')
            local current = traitUI.Text
            local selected = Options.SelectedTrait or {}
            if selected[current] then
                fnl:MakeNotification({Title = 'Trait', Description = 'Got: ' .. current, Duration = 5})
                if Toggles.AutoTrait then Toggles.AutoTrait.Value = false end
            else
                pcall(SyncTraitAutoSkip)
                if confirmFrame and confirmFrame.Visible then
                    Remotes.TraitConfirm:FireServer(true); task.wait(0.1)
                end
                Remotes.Roll_Trait:FireServer()
                task.wait(Options.RollCD or 0.3)
            end
            continue
        end
        if Toggles.AutoBloodline and Toggles.AutoBloodline.Value then
    local cur = Plr:GetAttribute('CurrentBloodline')
        or Plr:GetAttribute('Bloodline')
        or Plr:GetAttribute('CurrentClan')
    local sel = Options.SelectedBloodline or {}
    if sel[cur] then
        fnl:MakeNotification({Title = 'Bloodline', Description = 'Got: ' .. tostring(cur), Duration = 5})
        if Toggles.AutoBloodline then Toggles.AutoBloodline.Value = false end
    else
        -- Try to sync skip settings
        pcall(function()
            local settingsUI = PGui:FindFirstChild('BloodlineRerollSettingsUI')
                or PGui:FindFirstChild('LegendaryBloodlineFilterUI')
            if settingsUI then
                local legendary = settingsUI:FindFirstChild('Toggle_SkipLegendaryBloodline', true)
                    or settingsUI:FindFirstChild('Button_LegendaryBloodlineFilter', true)
                -- Check if any selected bloodline is legendary, if not skip legendaries
                local hasLeg = false
                for name in pairs(sel) do
                    local BloodlineMod = GetSafeModule(RS.Modules, 'BloodlineConfig')
                    if BloodlineMod then
                        local data = BloodlineMod.Bloodlines and BloodlineMod.Bloodlines[name]
                        if data and (data.rarity == 'Legendary' or data.Rarity == 'Legendary') then
                            hasLeg = true; break
                        end
                    end
                end
                if Remotes.SettingsToggle then
                    pcall(function() Remotes.SettingsToggle:FireServer('SkipLegendaryBloodline', not hasLeg) end)
                    pcall(function() Remotes.SettingsToggle:FireServer('SkipEpicBloodline', true) end)
                end
            end
        end)
        -- Fire the reroll
        pcall(function()
            Remotes.UseItem:FireServer('Use', 'Bloodline Stone', 1)
        end)
        pcall(function()
            Remotes.UseItem:FireServer('Use', 'Bloodline Reroll', 1)
        end)
        task.wait(Options.RollCD or 0.3)
    end
    continue
end
        if Toggles.AutoRace and Toggles.AutoRace.Value then
            local cur = Plr:GetAttribute('CurrentRace')
            local sel = Options.SelectedRace or {}
            if sel[cur] then
                fnl:MakeNotification({Title = 'Race', Description = 'Got: ' .. tostring(cur), Duration = 5})
                if Toggles.AutoRace then Toggles.AutoRace.Value = false end
            else
                pcall(SyncRaceSettings)
                Remotes.UseItem:FireServer('Use', 'Race Reroll', 1)
                task.wait(Options.RollCD or 0.3)
            end
            continue
        end
        if Toggles.AutoClan and Toggles.AutoClan.Value then
            local cur = Plr:GetAttribute('CurrentClan')
            local sel = Options.SelectedClan or {}
            if sel[cur] then
                fnl:MakeNotification({Title = 'Clan', Description = 'Got: ' .. tostring(cur), Duration = 5})
                if Toggles.AutoClan then Toggles.AutoClan.Value = false end
            else
                pcall(SyncClanSettings)
                Remotes.UseItem:FireServer('Use', 'Clan Reroll', 1)
                task.wait(Options.RollCD or 0.3)
            end
            continue
        end
        task.wait(0.4)
    end
end

function EnsureRollManager()
    local active = (Toggles.AutoTrait and Toggles.AutoTrait.Value) 
        or (Toggles.AutoRace and Toggles.AutoRace.Value) 
        or (Toggles.AutoClan and Toggles.AutoClan.Value)
        or (Toggles.AutoBloodline and Toggles.AutoBloodline.Value)
    Thread('UnifiedRollManager', Func_UnifiedRollManager, active)
end

function SyncSpecPassiveAutoSkip()
    pcall(function()
        if Remotes.SpecPassiveSkip then
            Remotes.SpecPassiveSkip:FireServer({Epic = true, Legendary = true, Mythical = true})
        end
    end)
end

function AutoSpecPassiveLoop()
    pcall(SyncSpecPassiveAutoSkip)
    task.wait(Options.SpecRollCD or 0.1)
    while Toggles.AutoSpec and Toggles.AutoSpec.Value do
        local targetWeapons = Options.SelectedPassive or {}
        local targetPassives = Options.SelectedSpec or {}
        local workDone = false
        if type(Shared.Passives) ~= 'table' then Shared.Passives = {} end
        for weapName, on in pairs(targetWeapons) do
            if not on then continue end
            local cur = Shared.Passives[weapName]
            local curName = (type(cur) == 'table' and cur.Name) or (type(cur) == 'string' and cur) or 'None'
            local curBuffs = (type(cur) == 'table' and cur.RolledBuffs) or {}
            local correct = targetPassives[curName]
            local meetsStats = true
            if correct and type(curBuffs) == 'table' then
                for statKey, val in pairs(curBuffs) do
                    local sid = 'Min_' .. weapName:gsub('%s+', '') .. '_' .. statKey
                    local minReq = Options[sid] or 0
                    if tonumber(val) and val < minReq then meetsStats = false; break end
                end
            end
            if not correct or not meetsStats then
                workDone = true
                Remotes.SpecPassiveReroll:FireServer(weapName)
                local t = tick()
                repeat
                    task.wait()
                    local nd = Shared.Passives[weapName]
                    local nn = (type(nd) == 'table' and nd.Name) or (type(nd) == 'string' and nd) or ''
                until nn ~= curName or tick() - t > 1.5
                break
            end
        end
        if not workDone then
            fnl:MakeNotification({Title = 'Passive', Description = 'Done rolling.', Duration = 5})
            if Toggles.AutoSpec then Toggles.AutoSpec.Value = false end
            break
        end
        task.wait()
    end
end

function AutoUpgradeLoop(mode)
    local toggle = Toggles['Auto' .. mode]
    local allToggle = Toggles['Auto' .. mode .. 'All']
    local remote = (mode == 'Enchant') and Remotes.Enchant or Remotes.Blessing
    local source = (mode == 'Enchant') and Tables.OwnedAccessory or Tables.OwnedWeapon
    while (toggle and toggle.Value) or (allToggle and allToggle.Value) do
        local selection = Options['Selected' .. mode] or {}
        local done = false
        for _, itemName in ipairs(source) do
            if Shared.UpBlacklist[itemName] then continue end
            local sel = (allToggle and allToggle.Value) or selection[itemName] or table.find(selection, itemName)
            if sel then
                done = true
                pcall(function() remote:FireServer(itemName) end)
                task.wait(1.5)
                break
            end
        end
        if not done then
            fnl:MakeNotification({Title = 'Stopping', Description = 'Nothing left to ' .. mode:lower() .. '.', Duration = 5})
            if toggle then toggle.Value = false end
            if allToggle then allToggle.Value = false end
            break
        end
        task.wait(0.1)
    end
end

function EvaluateArtifact(uuid, data)
    local actions = {lock = false, delete = false, upgrade = false}
    function filterStatus(filter, val)
        if not filter or not next(filter) then return nil end
        return filter[val] == true
    end
    function isWhitelisted(filter, val)
        local s = filterStatus(filter, val)
        return s == nil or s
    end
    function getMatches(d, ssFilter)
        local count = 0
        for _, sub in pairs(d.Substats or {}) do
            if ssFilter[sub.Stat] then count = count + 1 end
        end
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
            local setMatch = filterStatus(Options.Del_Set, data.Set)
            local msFilter = Options['Del_MS_' .. data.Category] or {}
            local msMatch = filterStatus(msFilter, data.MainStat.Stat)
            local isTarget = typeMatch ~= false and setMatch ~= false
            if typeMatch == nil and setMatch == nil and msMatch == nil then isTarget = false end
            if isTarget then
                local trash = getMatches(data, Options.Del_SS or {})
                local minT = Options.Del_MinSS or 0
                local maxed = data.Level >= (Options.UpgradeLimit or 0)
                if msMatch == true or minT == 0 or (maxed and trash >= minT) then actions.delete = true end
            end
        end
    end
    return actions
end

function AutoEquipArtifacts()
    if not (Toggles.ArtifactEquip and Toggles.ArtifactEquip.Value) then return end
    local best = {Helmet = nil, Gloves = nil, Body = nil, Boots = nil}
    local scores = {Helmet = -1, Gloves = -1, Body = -1, Boots = -1}
    local tTypes = Options.Eq_Type or {}
    local tMS = Options.Eq_MS or {}
    local tSS = Options.Eq_SS or {}
    function getMatches(d)
        local c = 0
        for _, s in pairs(d.Substats or {}) do if tSS[s.Stat] then c = c + 1 end end
        return c
    end
    function mainOK(d)
        if d.Category == 'Helmet' or d.Category == 'Gloves' then return true end
        return tMS[d.MainStat.Stat] == true
    end
    for uuid, data in pairs(Shared.ArtifactSession.Inventory) do
        if tTypes[data.Category] and mainOK(data) then
            local score = getMatches(data) * 10 + data.Level
            if score > scores[data.Category] then
                scores[data.Category] = score
                best[data.Category] = {UUID = uuid, Equipped = data.Equipped}
            end
        end
    end
    for _, item in pairs(best) do
        if item and not item.Equipped then
            Remotes.ArtifactEquip:FireServer(item.UUID)
            task.wait(0.2)
        end
    end
end

function Func_ArtifactAutomation()
    while task.wait(5) do
        if not Shared.ArtifactSession.Inventory or not next(Shared.ArtifactSession.Inventory) then
            Remotes.ArtifactUnequip:FireServer('')
            task.wait(2)
            continue
        end
        local lockQ, delQ, upQ = {}, {}, {}
        for uuid, data in pairs(Shared.ArtifactSession.Inventory) do
            local res = EvaluateArtifact(uuid, data)
            if res.lock then table.insert(lockQ, uuid) end
            if res.delete then table.insert(delQ, uuid) end
            if res.upgrade then
                local lim = Options.UpgradeLimit or 0
                if Toggles.UpgradeStage and Toggles.UpgradeStage.Value then
                    lim = math.min(math.floor(data.Level / 3) * 3 + 3, lim)
                end
                table.insert(upQ, {UUID = uuid, Levels = lim})
            end
        end
        for _, uuid in ipairs(lockQ) do Remotes.ArtifactLock:FireServer(uuid, true); task.wait(0.1) end
        if #delQ > 0 then
            for i = 1, #delQ, 50 do
                local chunk = {}
                for j = i, math.min(i + 49, #delQ) do table.insert(chunk, delQ[j]) end
                Remotes.MassDelete:FireServer(chunk)
                task.wait(0.6)
            end
            Remotes.ArtifactUnequip:FireServer('')
        end
        if #upQ > 0 then
            for i = 1, #upQ, 50 do
                local chunk = {}
                for j = i, math.min(i + 49, #upQ) do table.insert(chunk, upQ[j]) end
                Remotes.MassUpgrade:FireServer(chunk)
                task.wait(0.6)
            end
        end
        AutoEquipArtifacts()
    end
end

function Func_ArtifactMilestone()
    local m = 1
    while Toggles.ArtifactMilestone and Toggles.ArtifactMilestone.Value do
        Remotes.ArtifactClaim:FireServer(m)
        m = m >= 40 and 1 or m + 1
        task.wait(1)
    end
end

function OpenMerchantInterface()
    if isXeno then
        local npc = workspace:FindFirstChild('ServiceNPCs') and workspace.ServiceNPCs:FindFirstChild('MerchantNPC')
        local prompt = npc and npc:FindFirstChild('HumanoidRootPart') and npc.HumanoidRootPart:FindFirstChild('MerchantPrompt')
        if prompt then
            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            if root then
                local old = root.CFrame
                root.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                task.wait(0.2)
                if Support.Proximity then
                    fireproximityprompt(prompt)
                else
                    prompt:InputHoldBegin()
                    task.wait(prompt.HoldDuration + 0.1)
                    prompt:InputHoldEnd()
                end
                task.wait(0.5)
                root.CFrame = old
            end
        end
    else
        if firesignal then
            firesignal(Remotes.OpenMerchant.OnClientEvent)
        elseif getconnections then
            for _, v in pairs(getconnections(Remotes.OpenMerchant.OnClientEvent)) do
                if v.Function then task.spawn(v.Function) end
            end
        end
    end
end



function Func_AutoTrade()
    while task.wait(0.5) do
        local inTrade = PGui:FindFirstChild('InTradingUI') and PGui.InTradingUI.MainFrame.Visible
        local reqUI = PGui:FindFirstChild('TradeRequestUI') and PGui.TradeRequestUI.TradeRequest.Visible
        if Toggles.ReqTradeAccept and Toggles.ReqTradeAccept.Value and reqUI then
            Remotes.TradeRespond:FireServer(true); task.wait(1)
        end
        if Toggles.ReqTrade and Toggles.ReqTrade.Value and not inTrade and not reqUI then
            local target = Options.SelectedTradePlr
            if target and typeof(target) == 'Instance' then
                Remotes.TradeSend:FireServer(target.UserId); task.wait(3)
            end
        end
        if inTrade and Toggles.AutoAccept and Toggles.AutoAccept.Value then
            local sel = Options.SelectedTradeItems or {}
            local toAdd = {}
            for itemName, on in pairs(sel) do
                if on then
                    local already = false
                    if Shared.TradeState.myItems then
                        for _, ti in pairs(Shared.TradeState.myItems) do
                            if ti.name == itemName then already = true; break end
                        end
                    end
                    if not already then table.insert(toAdd, itemName) end
                end
            end
            if #toAdd > 0 then
                for _, name in ipairs(toAdd) do
                    local qty = 0
                    for _, item in pairs(Shared.Cached_Inv or {}) do
                        if item.name == name then qty = item.quantity; break end
                    end
                    if qty > 0 then Remotes.TradeAddItem:FireServer('Items', name, qty); task.wait(0.5) end
                end
            else
                if not Shared.TradeState.myReady then
                    Remotes.TradeReady:FireServer(true)
                elseif Shared.TradeState.myReady and Shared.TradeState.theirReady then
                    if Shared.TradeState.phase == 'confirming' and not Shared.TradeState.myConfirm then
                        Remotes.TradeConfirm:FireServer()
                    end
                end
            end
        end
    end
end

function Func_AutoChest()
    while task.wait(2) do
        if not (Toggles.AutoChest and Toggles.AutoChest.Value) then break end
        local sel = Options.SelectedChests or {}
        for _, r in ipairs(Tables.Rarities) do
            if sel[r] then
                local fullName = (r == 'Aura Crate') and 'Aura Crate' or (r .. ' Chest')
                pcall(function() Remotes.UseItem:FireServer('Use', fullName, 10000) end)
                task.wait(1)
            end
        end
    end
end

function Func_AutoCraft()
    while task.wait(1) do
        if not (Toggles.AutoCraftItem and Toggles.AutoCraftItem.Value) then break end
        local sel = Options.SelectedCraftItems or {}
        for _, item in pairs(Shared.Cached_Inv or {}) do
            if sel.DivineGrail and item.name == 'Broken Sword' and item.quantity >= 3 then
                pcall(function() Remotes.GrailCraft:InvokeServer('DivineGrail', math.min(math.floor(item.quantity / 3), 99)) end)
                task.wait(0.5)
            end
            if sel.SlimeKey and item.name == 'Slime Shard' and item.quantity >= 2 then
                pcall(function() Remotes.SlimeCraft:InvokeServer('SlimeKey', math.min(math.floor(item.quantity / 2), 99)) end)
            end
        end
    end
end

function GetFormattedItemSections(src, isNew)
    local cats = {Chests = {}, Rerolls = {}, Keys = {}, Materials = {}, Gears = {}, Accessories = {}, Runes = {}, Others = {}}
    local chestOrder = {'Common', 'Rare', 'Epic', 'Legendary', 'Mythical', 'Secret', 'Aura Crate', 'Cosmetic Crate'}
    local matOrder = {Wood = 1, Iron = 2, Obsidian = 3, Mythril = 4, Adamantite = 5}
    local rarOrder = {Common = 1, Rare = 2, Epic = 3, Legendary = 4}
    local gearOrder = {Helmet = 1, Gloves = 2, Body = 3, Boots = 4}
    local totalDust = 0
    for key, data in pairs(src) do
        local name, qty
        if type(data) == 'table' and data.name then
            Title = tostring(data.name); qty = tonumber(data.quantity) or 1
        else
            Title = tostring(key); qty = tonumber(data) or 1
        end
        if name:find('Auto%-deleted') then
            local dv = name:match('%+(%d+) dust')
            if dv then totalDust = totalDust + (qty * tonumber(dv)) end
            continue
        end
        local totalInv = 0
        if isNew then
            for _, item in pairs(Shared.Cached_Inv or {}) do
                if item.name == name then totalInv = item.quantity; break end
            end
        end
        local txt = isNew and string.format('+ [%d] %s [Total: %s]', qty, name, CommaFormat(totalInv)) or string.format('- %s: %s', name, CommaFormat(qty))
        if name:find('Chest') or name == 'Aura Crate' or name == 'Cosmetic Crate' then
            local w = 99
            for i, v in ipairs(chestOrder) do if name:find(v) then w = i; break end end
            table.insert(cats.Chests, {Text = txt, Weight = w})
        elseif name:find('Reroll') then
            table.insert(cats.Rerolls, txt)
        elseif name:find('Key') then
            table.insert(cats.Keys, txt)
        elseif matOrder[name] then
            table.insert(cats.Materials, {Text = txt, Weight = matOrder[name]})
        elseif name:find('Helmet') or name:find('Gloves') or name:find('Body') or name:find('Boots') then
            local rw, tw = 99, 99
            for k, v in pairs(rarOrder) do if name:find(k) then rw = v; break end end
            for k, v in pairs(gearOrder) do if name:find(k) then tw = v; break end end
            table.insert(cats.Gears, {Text = txt, Rarity = rw, Type = tw})
        elseif name:find('Rune') then
            table.insert(cats.Runes, txt)
        else
            table.insert(cats.Others, txt)
        end
    end
    if totalDust > 0 then
        local dt = isNew and string.format('+ [%d] Dust', totalDust) or string.format('- Dust: %s', CommaFormat(totalDust))
        table.insert(cats.Materials, 1, {Text = dt, Weight = 0})
    end
    local result = ''
    function proc(title, tbl, sortFunc)
        if #tbl > 0 then
            if sortFunc then table.sort(tbl, sortFunc) end
            result = result .. '**< ' .. title .. ' >**\n```'
            for _, v in ipairs(tbl) do result = result .. (type(v) == 'table' and v.Text or v) .. '\n' end
            result = result .. '```\n'
        end
    end
    proc('Chests', cats.Chests, function(a, b) return a.Weight < b.Weight end)
    proc('Rerolls', cats.Rerolls)
    proc('Keys', cats.Keys)
    proc('Materials', cats.Materials, function(a, b) return a.Weight < b.Weight end)
    proc('Gears', cats.Gears, function(a, b) return a.Rarity ~= b.Rarity and a.Rarity < b.Rarity or a.Type < b.Type end)
    proc('Runes', cats.Runes)
    proc('Others', cats.Others)
    return result
end

function UniversalPuzzleSolver(puzzleType)
    local moduleMap = {
        Dungeon = RS.Modules:FindFirstChild('DungeonConfig'),
        Slime = RS.Modules:FindFirstChild('SlimePuzzleConfig'),
        Demonite = RS.Modules:FindFirstChild('DemoniteCoreQuestConfig'),
        Hogyoku = RS.Modules:FindFirstChild('HogyokuQuestConfig')
    }
    local hogyokuOrder = {'Snow', 'Shibuya', 'HuecoMundo', 'Shinjuku', 'Slime', 'Judgement'}
    local mod = moduleMap[puzzleType]
    if not mod then return end
    local data = require(mod)
    local settings = data.PuzzleSettings or data.PieceSettings
    local pieces = data.Pieces or settings.IslandOrder
    local pieceName = settings and settings.PieceModelName or 'DungeonPuzzlePiece'
    fnl:MakeNotification({Title = 'Puzzle', Description = 'Starting ' .. puzzleType .. '...', Duration = 5})
    for i, islandOrPiece in ipairs(pieces) do
        local tpTarget
        if puzzleType == 'Demonite' then
            tpTarget = 'Academy'
        elseif puzzleType == 'Hogyoku' then
            tpTarget = hogyokuOrder[i]
        else
            tpTarget = islandOrPiece:gsub('Island', ''):gsub('Station', '')
            if islandOrPiece == 'HuecoMundo' then tpTarget = 'HuecoMundo' end
        end
        if tpTarget then Remotes.TP_Portal:FireServer(tpTarget); task.wait(2.5) end
        local piece
        if puzzleType == 'Demonite' or puzzleType == 'Hogyoku' then
            piece = workspace:FindFirstChild(islandOrPiece, true)
        else
            local folder = workspace:FindFirstChild(islandOrPiece)
            piece = (folder and folder:FindFirstChild(pieceName, true)) or workspace:FindFirstChild(pieceName, true)
        end
        if piece then
            HybridMove(piece:GetPivot() * CFrame.new(0, 3, 0))
            task.wait(0.5)
            local prompt = piece:FindFirstChildOfClass('ProximityPrompt') or piece:FindFirstChild('ProximityPrompt', true)
            if prompt then
                fireproximityprompt(prompt)
                fnl:MakeNotification({Title = 'Puzzle', Description = string.format('Piece %d/%d collected', i, #pieces), Duration = 2})
                task.wait(1.5)
            else
                fnl:MakeNotification({Title = 'Puzzle', Description = 'No prompt on piece ' .. i, Duration = 3})
            end
        else
            fnl:MakeNotification({Title = 'Puzzle', Description = 'Piece ' .. i .. ' not found on ' .. tostring(tpTarget), Duration = 3})
        end
    end
    fnl:MakeNotification({Title = 'Puzzle', Description = puzzleType .. ' completed!', Duration = 5})
end

function FireSkillsWithPositionLock()
    if not (Toggles.AutoSkill and Toggles.AutoSkill.Value) then return end
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    local tool = char and char:FindFirstChildOfClass('Tool')
    if not (tool and root) then return end

    local savedCF = root.CFrame
    local keyToSlot = {Z=1, X=2, C=3, V=4, F=5}
    local keyToEnum = {
        Z = Enum.KeyCode.Z, X = Enum.KeyCode.X,
        C = Enum.KeyCode.C, V = Enum.KeyCode.V, F = Enum.KeyCode.F
    }
    local toolType = GetToolTypeFromModule(tool.Name)
    local selected = Options.SelectedSkills or {}

    for _, key in ipairs({'Z', 'X', 'C', 'V', 'F'}) do
        if selected[key] and IsSkillReady(key) then
            pcall(function()
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {
                        FruitPower = tool.Name:gsub(' Fruit', ''),
                        KeyCode = keyToEnum[key]
                    })
                else
                    Remotes.UseSkill:FireServer(keyToSlot[key])
                end
            end)
            task.wait(0.1)
            if root and root.Parent then
                root.CFrame = savedCF
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end
        end
    end
end



function AutoQuestlineLoop()
    while Toggles.AutoQuestline and Toggles.AutoQuestline.Value do
        task.wait(0.1)
        local selId = Options.SelectedQuestline
        if not selId then continue end
        local qData = Modules.Quests.Questlines[selId]
        if not qData then continue end
        local questUI = PGui.QuestUI.Quest
        local isMatchingStage = false
        for _, stage in ipairs(qData.stages) do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then
                isMatchingStage = true; break
            end
        end
        if not questUI.Visible or not isMatchingStage then
            Remotes.QuestAccept:FireServer(qData.npcName); task.wait(1.5); continue
        end
        local curStage = nil
        for _, stage in ipairs(qData.stages) do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then
                curStage = stage; break
            end
        end
        if curStage then
            local tt = curStage.trackingType
            if tt:find('Kills') and not tt:find('Boss') and tt ~= 'PlayerKills' then
                local mobName = tt:gsub('Kills', '')
                if mobName == 'AnyNPC' then
                    if Toggles.LevelFarm then Toggles.LevelFarm.Value = true end
                else
                    Options.SelectedMob = {[mobName] = true}
                    if Toggles.MobFarm then Toggles.MobFarm.Value = true end
                end
            elseif tt:find('BossKills') or tt == 'AnyBossKills' then
                if tt == 'AnyBossKills' then
                    if Toggles.AllBossesFarm then Toggles.AllBossesFarm.Value = true end
                end
            end
        end
    end
end

task.spawn(function()
    DisableIdled()
    while true do
        task.wait(60)
        if Toggles.AntiAFK and Toggles.AntiAFK.Value then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.2)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

local _DR = GetRemote(RS, 'RemoteEvents.DashRemote')
local _FS = _DR and _DR.FireServer

function ACThing(state)
    if Connections.Dash then Connections.Dash:Disconnect() end
    if not (state and _DR and _FS) then return end
    Connections.Dash = RunService.Heartbeat:Connect(function()
        task.spawn(function() pcall(_FS, _DR, vector.create(0, 0, 0), 0, false) end)
    end)
end

function Func_AutoSecondSea()
    local function Notify(msg)
        fnl:MakeNotification({Title = 'Second Sea', Description = msg, Duration = 4})
    end

    local function GetRoot()
        local char = GetCharacter()
        return char and char:FindFirstChild('HumanoidRootPart')
    end

    local function InteractNPC(npc)
        if not npc then return false end
        local root = GetRoot()
        if not root then return false end
        local ok, piv = pcall(function() return npc:GetPivot() end)
        if ok and piv then
            root.CFrame = piv * CFrame.new(0, 0, 3)
        else
            local bp = npc:FindFirstChildOfClass('BasePart') or npc.PrimaryPart
            if bp then root.CFrame = bp.CFrame * CFrame.new(0, 0, 3) end
        end
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.4)
        for _, desc in pairs(npc:GetDescendants()) do
            if desc:IsA('ProximityPrompt') then
                pcall(function() fireproximityprompt(desc) end)
                task.wait(0.8); return true
            elseif desc:IsA('ClickDetector') then
                pcall(function() fireclickdetector(desc) end)
                task.wait(0.8); return true
            end
        end
        return false
    end

    local function GetQuestNPC()
        return workspace:FindFirstChild('ServiceNPCs')
            and workspace.ServiceNPCs:FindFirstChild('MapQuestNPC')
    end

    -- ── Quest stage detection ────────────────────────────────────
    local function GetQuestStage()
        local questUI = PGui:FindFirstChild('QuestUI')
        if not questUI then return nil, 0, 0, false end
        local title, cur, max = '', 0, 0
        local visible = false
        local questFrame = questUI:FindFirstChild('Quest')
        if questFrame then
            local inner = questFrame:FindFirstChild('Quest', true)
            visible = (inner and inner.Visible) or questFrame.Visible
        end
        for _, lbl in pairs(questUI:GetDescendants()) do
            if lbl:IsA('TextLabel') and lbl.Text ~= '' then
                local t = lbl.Text:lower()
                local c, m = lbl.Text:match('(%d+)%s*/%s*(%d+)')
                if c and m then
                    cur = tonumber(c) or 0
                    max = tonumber(m) or 0
                end
                if t:find('fragment') or t:find('lost') or t:find('ancient') then
                    title = 'fragments'
                elseif t:find('map piece') or t:find('reconstruction') or t:find('map pieces') or (t:find('boss') and t:find('collect')) then
                    title = 'mappieces'
                end
            end
        end
        return title, cur, max, visible
    end

    local function IsQuestVisible()
        local _, _, _, visible = GetQuestStage()
        return visible
    end

    -- ── STAGE 1: Collect Lost Fragments ─────────────────────────

    local function TryCollectFragment(frag)
        if not frag or not frag.Parent then return false end
        local root = GetRoot()
        if not root then return false end
        local fragPos = nil
        pcall(function() fragPos = frag:GetPivot().Position end)
        if not fragPos then
            local bp = frag:FindFirstChildOfClass('BasePart')
            if bp then fragPos = bp.Position end
        end
        if not fragPos then return false end
        root.CFrame = CFrame.new(fragPos) * CFrame.new(0, 0, 3)
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.4)
        local prompt = frag:FindFirstChildOfClass('ProximityPrompt', true)
        if prompt then pcall(function() fireproximityprompt(prompt) end) task.wait(0.6) return true end
        local click = frag:FindFirstChildOfClass('ClickDetector', true)
        if click then pcall(function() fireclickdetector(click) end) task.wait(0.6) return true end
        return false
    end

    local function GetAllFragments()
        local frags = {}
        local searchRoots = {
            workspace:FindFirstChild('Sea2MapQuest'),
            workspace:FindFirstChild('MapFragments'),
            workspace:FindFirstChild('LostFragments'),
            workspace
        }
        local checked = {}
        for _, root in pairs(searchRoots) do
            if root and not checked[root] then
                checked[root] = true
                for _, obj in pairs(root:GetDescendants()) do
                    local n = obj.Name:lower()
                    if (n:find('fragment') or n:find('ancient') or n:find('relic'))
                        and (obj:IsA('Model') or obj:IsA('BasePart') or obj:IsA('MeshPart')) then
                        local hasInteract = obj:FindFirstChildOfClass('ProximityPrompt', true)
                            or obj:FindFirstChildOfClass('ClickDetector', true)
                        if hasInteract then
                            local dup = false
                            for _, f in pairs(frags) do if f == obj then dup = true break end end
                            if not dup then table.insert(frags, obj) end
                        end
                    end
                end
            end
        end
        return frags
    end

    local function GetSpawnPoints()
        local folder = workspace:FindFirstChild('Sea2MapQuest')
        local spawnFolder = folder and folder:FindFirstChild('SpawnPoints')
        if not spawnFolder then return {} end
        local spots = {}
        for _, s in pairs(spawnFolder:GetChildren()) do table.insert(spots, s) end
        table.sort(spots, function(a, b)
            local na = tonumber(a.Name:match('%d+')) or 0
            local nb = tonumber(b.Name:match('%d+')) or 0
            return na < nb
        end)
        return spots
    end

    local AncientFragmentIslands = {
        'Starter', 'Jungle', 'Desert', 'Snow', 'Sailor',
        'Shibuya', 'Hollow', 'Shinjuku', 'Slime', 'Academy',
        'Judgement', 'Soul', 'Ninja', 'Lawless', 'Tower'
    }

    local function SweepAllIslands()
        for _, island in ipairs(AncientFragmentIslands) do
            if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then return end
            local stage = GetQuestStage()
            if stage ~= 'fragments' then return end

            --Notify('Moving to: ' .. island)
            if Remotes.TP_Portal then
                Remotes.TP_Portal:FireServer(island)
                task.wait(2.5)
            end

            local immediateFrags = GetAllFragments()
            if #immediateFrags > 0 then
                --Notify('Fragment on ' .. island .. '! Collecting...')
                for _, frag in pairs(immediateFrags) do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then return end
                    TryCollectFragment(frag)
                    task.wait(0.3)
                end
                continue
            end

            local spawnPoints = GetSpawnPoints()
            if #spawnPoints > 0 then
                for _, spot in pairs(spawnPoints) do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then return end
                    if GetQuestStage() ~= 'fragments' then return end
                    local root = GetRoot()
                    if not root then task.wait(0.5) continue end
                    local spotCF = nil
                    pcall(function() spotCF = spot:GetPivot() end)
                    if not spotCF and spot:IsA('BasePart') then spotCF = spot.CFrame end
                    if not spotCF then continue end
                    root.CFrame = spotCF * CFrame.new(0, 0, 3)
                    root.AssemblyLinearVelocity = Vector3.zero
                    task.wait(0.6)
                    for _, frag in pairs(GetAllFragments()) do
                        if not frag.Parent then continue end
                        local fragPos = nil
                        pcall(function() fragPos = frag:GetPivot().Position end)
                        if not fragPos then
                            local bp = frag:FindFirstChildOfClass('BasePart')
                            if bp then fragPos = bp.Position end
                        end
                        if fragPos and root and (root.Position - fragPos).Magnitude <= 300 then
                            TryCollectFragment(frag)
                            task.wait(0.3)
                        end
                    end
                end
            else
                for _, frag in pairs(GetAllFragments()) do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then return end
                    TryCollectFragment(frag)
                    task.wait(0.3)
                end
            end
            task.wait(0.5)
        end
    end

    local MapPieceBosses = {
    -- World Spawn
    {label='Alucard Boss',  match='AlucardBoss',  island='Sailor',  summon=nil},
    {label='Jinwoo Boss',   match='JinwooBoss',   island='Sailor',  summon=nil},
    {label='Aizen Boss',    match='AizenBoss',    island='Hollow',  summon=nil},
    {label='Gojo Boss',     match='GojoBoss',     island='Shibuya', summon=nil},
    {label='Sukuna Boss',   match='SukunaBoss',   island='Shibuya', summon=nil},
    {label='Yuji Boss',     match='YujiBoss',     island='Boss',    summon=nil},

    -- Summonable
    {
        label='Rimuru Boss', match='Rimuru', island='Slime',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('RemoteEvents')
                    :WaitForChild('RequestSpawnRimuru')
                    :FireServer('Normal')
            end)
        end
    },
    {
        label='Qin Shi Boss', match='QinShi', island='Boss',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('Remotes')
                    :WaitForChild('RequestSummonBoss')
                    :FireServer('QinShiBoss', 'Normal')
            end)
        end
    },
    {
        label='Demon King', match='MoonSlayerBoss', island='Boss',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('Remotes')
                    :WaitForChild('RequestSummonBoss')
                    :FireServer('MoonSlayerBoss', 'Normal')
            end)
        end
    },
    {
        label='Saber Boss', match='SaberBoss', island='Boss',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('Remotes')
                    :WaitForChild('RequestSummonBoss')
                    :FireServer('SaberBoss')
            end)
        end
    },
    {
        label='Ichigo Boss', match='IchigoBoss', island='Hollow',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('Remotes')
                    :WaitForChild('RequestSummonBoss')
                    :FireServer('IchigoBoss')
            end)
        end
    },
    {
        label='Gilgamesh Boss', match='GilgameshBoss', island='Boss',
        summon=function()
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('Remotes')
                    :WaitForChild('RequestSummonBoss')
                    :FireServer('GilgameshBoss', 'Normal')
            end)
        end
    }
}

-- Find a live boss by partial name (case-insensitive)
local function FindLiveBoss(matchStr)
    local key = matchStr:lower():gsub('%s+', '')
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA('Model') then
            local n = npc.Name:lower():gsub('%s+', '')
            if n:find(key, 1, true) then
                local hum = npc:FindFirstChildOfClass('Humanoid')
                if hum and hum.Health > 0 then
                    return npc
                end
            end
        end
    end
    return nil
end

-- Attack a boss for several M1s + skills
local function AttackBoss(boss, island)
    if not boss or not boss.Parent then return false end
    local hum = boss:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then return false end

    ExecuteFarmLogic(boss, island or 'Boss', 'Boss')
    EquipWeapon()

    if Toggles.InstaKill and Toggles.InstaKill.Value then
        pcall(function() hum.Health = 0 end)
    end

    for i = 1, 8 do
        local h2 = boss:FindFirstChildOfClass('Humanoid')
        if not h2 or h2.Health <= 0 then break end
        pcall(function() Remotes.M1:FireServer() end)
        Shared.LastM1 = time()
        task.wait(0.04)
    end

    -- Use skills if enabled
    if Toggles.AutoSkill and Toggles.AutoSkill.Value then
        local char = GetCharacter()
        local tool  = char and char:FindFirstChildOfClass('Tool')
        if tool then
            local keyToSlot = {Z=1,X=2,C=3,V=4,F=5}
            local keyToEnum = {
                Z=Enum.KeyCode.Z, X=Enum.KeyCode.X,
                C=Enum.KeyCode.C, V=Enum.KeyCode.V, F=Enum.KeyCode.F
            }
            local toolType = GetToolTypeFromModule(tool.Name)
            local selected = Options.SelectedSkills or {}
            for _, key in ipairs({'Z','X','C','V','F'}) do
                if selected[key] and IsSkillReady(key) then
                    pcall(function()
                        if toolType == 'Power' then
                            Remotes.UseFruit:FireServer('UseAbility', {
                                FruitPower = tool.Name:gsub(' Fruit',''),
                                KeyCode    = keyToEnum[key]
                            })
                        else
                            Remotes.UseSkill:FireServer(keyToSlot[key])
                        end
                    end)
                    task.wait(0.1)
                end
            end
        end
    end
    return true
end

local function FarmBossForMapPieces()
    local _, cur, max = GetQuestStage()
    cur = cur or 0; max = max or 7

    --Notify(string.format('Stage 2: Map Reconstruction!\nPieces: %d/%d\nCycling all bosses...', cur, max))

    local lastSummonTick  = {}
    local lastIslandTP    = {}
    local lastNotifTick   = 0
    local lastPieceCount  = cur
    local bossIdx         = 1

    -- Track how many kills we've done per boss WITHOUT a piece dropping
    -- If a boss dropped a piece, we mark it as "contributed" and deprioritize it
    local bossKillCount   = {}   -- [label] = kills since last piece
    local bossDropped     = {}   -- [label] = true if this boss already gave a piece
    local MAX_KILLS_BEFORE_SKIP = 20  -- after 5 kills with no piece, consider boss "done"

    for _, e in ipairs(MapPieceBosses) do
        bossKillCount[e.label] = 0
        bossDropped[e.label]   = false
    end

    local function IsBossSkipped(entry)
        return bossDropped[entry.label] == true
    end

    local function AllBossesSkipped()
        for _, e in ipairs(MapPieceBosses) do
            if not IsBossSkipped(e) then return false end
        end
        return true
    end

    local function ResetSkips()
        for _, e in ipairs(MapPieceBosses) do
            bossDropped[e.label]   = false
            bossKillCount[e.label] = 0
        end
        --Notify('All bosses reset — cycling again...')
    end

    local function OnBossKilled(entry, piecesAfter)
        local dropped = piecesAfter > lastPieceCount
        bossKillCount[entry.label] = bossKillCount[entry.label] + 1

        if dropped then
            -- This boss gave us a piece
            bossDropped[entry.label] = true
            lastPieceCount = piecesAfter
          --  Notify(string.format(
              --  '✓ %s gave a piece! Skipping it next.\nTotal: %d/%d',
               -- entry.label, piecesAfter, max
          --  ))
        elseif bossKillCount[entry.label] >= MAX_KILLS_BEFORE_SKIP then
            -- Killed enough times with no piece — treat as done for this cycle
            bossDropped[entry.label] = true
           -- Notify(string.format(
              --  '%s gave no piece after %d kills — skipping.',
           --     entry.label, MAX_KILLS_BEFORE_SKIP
           -- ))
        end
    end

    while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
        task.wait(0.05)

        local stage, newCur, newMax = GetQuestStage()
        if stage ~= 'mappieces' then
            --Notify('Stage changed or quest completed!')
            return
        end
        newCur = newCur or 0
        newMax = newMax or 7

        if newMax > 0 and newCur >= newMax then
           -- Notify(string.format('All %d Map Pieces collected!', newMax))
            return
        end

        -- If all bosses are marked as skipped/done, reset and cycle again
        if AllBossesSkipped() then
            ResetSkips()
        end

        if tick() - lastNotifTick >= 8 then
            local entry = MapPieceBosses[bossIdx]
            local skipStr = IsBossSkipped(entry) and ' [SKIPPED]' or ''
          --  Notify(string.format(
            --    'Pieces: %d/%d  |  Checking: %s%s',
              --  newCur, newMax, entry.label, skipStr
          --  ))
            lastNotifTick = tick()
        end

        -- Find next non-skipped boss index to focus
        local function GetNextValidIdx(startIdx)
            for i = 1, #MapPieceBosses do
                local idx = ((startIdx + i - 2) % #MapPieceBosses) + 1
                if not IsBossSkipped(MapPieceBosses[idx]) then
                    return idx
                end
            end
            return startIdx -- fallback if all skipped (shouldn't happen after reset)
        end

        -- Advance to next valid boss if current is skipped
        if IsBossSkipped(MapPieceBosses[bossIdx]) then
            bossIdx = GetNextValidIdx(bossIdx)
        end

        -- Scan ALL non-skipped bosses for a live one
        local attackedSomething = false
        for i = 1, #MapPieceBosses do
            local idx   = ((bossIdx + i - 2) % #MapPieceBosses) + 1
            local entry = MapPieceBosses[idx]

            if IsBossSkipped(entry) then continue end

            local live = FindLiveBoss(entry.match)
            if live then
                local hpBefore = (live:FindFirstChildOfClass('Humanoid') or {}).Health or 0
                AttackBoss(live, entry.island)
                bossIdx = idx
                attackedSomething = true

                -- Check if boss just died
                local hpAfter = 0
                local h2 = live:FindFirstChildOfClass('Humanoid')
                if h2 then hpAfter = h2.Health end

                if hpAfter <= 0 or not live.Parent then
                    -- Boss died — wait a moment for piece to register then check
                    task.wait(1.5)
                    local _, afterCur = GetQuestStage()
                    afterCur = afterCur or newCur
                    OnBossKilled(entry, afterCur)
                    newCur = afterCur
                end
                break
            end
        end

        if not attackedSomething then
            local entry = MapPieceBosses[bossIdx]

            if IsBossSkipped(entry) then
                bossIdx = GetNextValidIdx(bossIdx)
                task.wait(0.1)
                continue
            end

            if entry.summon then
                local ik = entry.island
                if not lastIslandTP[ik] or tick() - lastIslandTP[ik] >= 8 then
                    lastIslandTP[ik] = tick()
                    if Remotes.TP_Portal then
                        Remotes.TP_Portal:FireServer(ik)
                        task.wait(2.5)
                    end
                end

                local lk = entry.label
                if not lastSummonTick[lk] or tick() - lastSummonTick[lk] >= 6 then
                    lastSummonTick[lk] = tick()
                   -- Notify('Summoning: ' .. entry.label)
                    entry.summon()
                    task.wait(3)
                else
                    task.wait(0.3)
                end

                local live2 = FindLiveBoss(entry.match)
                if live2 then
                    local hpBefore = (live2:FindFirstChildOfClass('Humanoid') or {}).Health or 0
                    AttackBoss(live2, entry.island)

                    task.wait(0.5)
                    local h2 = live2:FindFirstChildOfClass('Humanoid')
                    local hpAfter = h2 and h2.Health or 0
                    if hpAfter <= 0 or not live2.Parent then
                        task.wait(1.5)
                        local _, afterCur = GetQuestStage()
                        afterCur = afterCur or newCur
                        OnBossKilled(entry, afterCur)
                    end
                end
            else
                -- World spawn
                local ik = entry.island
                if not lastIslandTP[ik] or tick() - lastIslandTP[ik] >= 12 then
                    lastIslandTP[ik] = tick()
                    if Remotes.TP_Portal then
                        Remotes.TP_Portal:FireServer(ik)
                        task.wait(2.5)
                    end
                end

                local live2 = FindLiveBoss(entry.match)
                if live2 then
                    AttackBoss(live2, entry.island)
                    task.wait(0.5)
                    local h2 = live2:FindFirstChildOfClass('Humanoid')
                    if (h2 and h2.Health <= 0) or not live2.Parent then
                        task.wait(1.5)
                        local _, afterCur = GetQuestStage()
                        afterCur = afterCur or newCur
                        OnBossKilled(entry, afterCur)
                    end
                else
                    bossIdx = GetNextValidIdx(bossIdx + 1)
                    task.wait(0.2)
                end
            end

            if not FindLiveBoss(entry.match) and not IsBossSkipped(entry) then
                bossIdx = GetNextValidIdx(bossIdx + 1)
            end
        end
    end
end

    -- ── MAIN LOOP ────────────────────────────────────────────────
    while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
        local questNPC = GetQuestNPC()
        if not questNPC then
            --Notify('MapQuestNPC not found!\nMake sure you are on the right server.')
            if Toggles.AutoSecondSea then Toggles.AutoSecondSea.Value = false end
            return
        end

       -- Notify('Talking to MapQuestNPC...')
        InteractNPC(questNPC)
        task.wait(1)

        if not IsQuestVisible() then
            Notify('Quest not active. Retrying NPC...')
            task.wait(1)
            InteractNPC(questNPC)
            task.wait(1)
        end

        local stage, cur, max, visible = GetQuestStage()
      --  Notify('Quest stage detected: ' .. tostring(stage))

        -- ── STAGE 1: Collect Lost Fragments ──
        if stage == 'fragments' or stage == '' or stage == nil then
          --  Notify('Stage 1: Collecting Lost Fragments...')
            local sweepTimer = tick()
            while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
                local s = GetQuestStage()
                if s == 'mappieces' then
                   -- Notify('All fragments collected! Moving to Stage 2...')
                    break
                end
                SweepAllIslands()
                if tick() - sweepTimer > 60 then
                    sweepTimer = tick()
                   -- Notify('Re-interacting with NPC...')
                    questNPC = GetQuestNPC()
                    if questNPC then InteractNPC(questNPC) end
                    task.wait(1)
                end
                task.wait(0.3)
            end
        end

        if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then break end

        -- ── STAGE 2: Farm Bosses for 7 Map Pieces ──
        stage = GetQuestStage()
        if stage == 'mappieces' then
            FarmBossForMapPieces()
        end

        if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then break end

        -- ── HAND IN: Return to NPC ──
       -- Notify('Quest complete! Returning to MapQuestNPC...')
        if Remotes.TP_Portal then
            Remotes.TP_Portal:FireServer('Starter')
            task.wait(2)
        end
        questNPC = GetQuestNPC()
        if questNPC then
            InteractNPC(questNPC)
            task.wait(0.8)
            InteractNPC(questNPC)
            task.wait(1)
          --  Notify('Quest handed in! Starting next cycle in 3s...')
        end

        task.wait(3)
    end

    --Notify('Auto Second Sea stopped.')
end

function IsValidTarget(npc)
    if not npc or not npc.Parent then return false end
    
    -- Check custom boss HP attribute (for Sea bosses like Kraken)
    local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
    if bossHP and tonumber(bossHP) and tonumber(bossHP) > 0 then
        return true
    end
    
    local hum = npc:FindFirstChildOfClass('Humanoid')
    if not hum then return false end
    if npc:FindFirstChild('IK_Active') then return true end
    local minMaxHP = tonumber(Options.InstaKillMinHP) or 0
    if Toggles.InstaKill and Toggles.InstaKill.Value then
        return hum.MaxHealth >= minMaxHP
    end
    local eligible = (Toggles.InstaKill and Toggles.InstaKill.Value) and hum.MaxHealth >= minMaxHP
    return eligible and (hum.Health > 0 or npc == Shared.Target) or hum.Health > 0
end

function AttackTarget(target, island, farmType)
    if not target or not target.Parent then return end
    
    -- Allow if valid target (now includes custom HP bosses)
    local hum = target:FindFirstChildOfClass('Humanoid')
    local bossHP = target:GetAttribute('_BossHP') or target:GetAttribute('BossHP')
    local isAlive = (hum and hum.Health > 0) or (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
    if not isAlive then return end
    
    Shared.Target = target
    EquipWeapon()
    ExecuteFarmLogic(target, island or GetNearestIsland(target:GetPivot().Position), farmType or 'Boss')
    pcall(function() Remotes.M1:FireServer() end)
    Shared.LastM1 = time()
    FireSkillsWithPositionLock()
end

table.sort(Tables.AllBossList)
table.sort(Tables.BossList)
table.sort(Tables.TraitList)
table.sort(Tables.RaceList)
table.sort(Tables.ClanList)
table.sort(Tables.SummonList)
UpdateNPCLists()
UpdateAllEntities()

local executorDisplayName = identifyexecutor and identifyexecutor() or 'Unknown'
local statusText = isLimitedExecutor and 'Semi-Working - [low Executor Detected Some Features might not work!]' or 'Working [Supported]'


--Window:Divider() -- Section: 'Farm Settings'
local PriorityTab = window:Tab({Title = 'Farm Priority', Icon = 'rbxassetid://10734950020'})

PriorityTab:Section({Title = 'Priority Order'})
PriorityTab:Paragraph({
    Title = 'Info',
    Desc = 'Select and order which farm modes to enable.\nTop = highest priority. Unselected = disabled.'
})

local PriorityStatusLabel = PriorityTab:Paragraph({
    Title = 'Current Priority Order',
    Desc = 'Loading...'
})

task.spawn(function()
    while true do
        task.wait(1)
        local order = {}
        for i, v in ipairs(DefaultPriority) do
            table.insert(order, i .. '. ' .. v)
        end
        PriorityStatusLabel:SetDesc(table.concat(order, '\n'))
    end
end)

local PriorityOptions = {
    'Nearest Mob',
    'Level Farm',
    'Mob',
    'All Mob Farm',
    'Boss',
    'Pity Boss',
    'Summon',
    'Merchant',
    'Sea Boss'
}

-- Initialize default
for i, v in ipairs(PriorityOptions) do
    Options['Priority_' .. i] = v
end

function UpdatePriorityOrder()
    local selected = Options.SelectedPriorities or {}
    local newPriority = {}
    -- Keep order based on PriorityOptions order, only include selected
    for _, v in ipairs(PriorityOptions) do
        if selected[v] then
            table.insert(newPriority, v)
        end
    end
    -- Fallback: if nothing selected, use all
    if #newPriority == 0 then
        for _, v in ipairs(PriorityOptions) do
            table.insert(newPriority, v)
        end
    end
    DefaultPriority = newPriority
end

-- Default all selected
Options.SelectedPriorities = {}
for _, v in ipairs(PriorityOptions) do
    Options.SelectedPriorities[v] = true
end

local SlotOptions = {'None'}
for _, v in ipairs(PriorityOptions) do table.insert(SlotOptions, v) end

local PrioritySlotDefaults = {
    'Nearest Mob', 'Level Farm', 'Mob', 'All Mob Farm', 'Boss',
    'Pity Boss', 'Summon', 'Merchant', 'Sea Boss'
}

local function RebuildPriorityFromSlots()
    local seen = {}
    local newOrder = {}
    for i = 1, #PriorityOptions do
        local val = Options['PrioritySlot_' .. i]
        if val and val ~= 'None' and not seen[val] then
            seen[val] = true
            table.insert(newOrder, val)
        end
    end
    if #newOrder == 0 then
        for _, v in ipairs(PriorityOptions) do table.insert(newOrder, v) end
    end
    DefaultPriority = newOrder
end

for i = 1, #PriorityOptions do
    local slotKey = 'PrioritySlot_' .. i
    local defaultVal = PrioritySlotDefaults[i] or 'None'
    Options[slotKey] = defaultVal

    PriorityTab:Dropdown({
        Title = 'Priority ' .. i,
        Values = SlotOptions,
        Default = defaultVal,
        Callback = function(v)
            Options[slotKey] = v
            RebuildPriorityFromSlots()
        end
    })
end

RebuildPriorityFromSlots()
local FarmConfigTab = window:Tab({Title = 'Farm Config', Icon = 'rbxassetid://118337093261572'})

function Func_AutoEquipWeapon()
    while Toggles.AutoEquipWeapon and Toggles.AutoEquipWeapon.Value do
        task.wait(0.5)
        EquipWeapon()
    end
end

FarmConfigTab:Section({Title = 'Weapon Settings'})
Options.SelectedWeaponType = {Melee = true}
FarmConfigTab:Dropdown({Title = "Select Weapon (can be multi)", Values = Tables.Weapon, Default = {"Melee"}, Multi = true,
    Callback = function(v)
        local map = {}
        if type(v) == "table" then
            for k, val in pairs(v) do
                if type(k) == "number" then map[val] = true else map[k] = true end
            end
        else map[v] = true end
        Options.SelectedWeaponType = map
    end
})


FarmConfigTab:Toggle({
    Title = 'Auto Equip Weapon',
    Default = false,
    Callback = function(v)
        Toggles.AutoEquipWeapon = {Value = v}
        Thread('AutoEquipWeapon', SafeLoop('Auto Equip Weapon', Func_AutoEquipWeapon), v)
    end
})

FarmConfigTab:Toggle({Title = 'Auto Attack M1', Default = false,
    Callback = function(v) Toggles.AutoM1 = {Value = v} end
})

FarmConfigTab:Slider({Title = 'Weapon Switch Delay', Value = {Min = 1, Max = 20, Default = 4},
    Callback = function(v) Options.SwitchWeaponCD = v end
})

FarmConfigTab:Section({Title = 'Kill Aura'})
FarmConfigTab:Slider({
    Title = 'Kill Aura Range',
    Value = {Min = 10, Max = 500, Default = 200},
    Callback = function(v) Options.KillAuraRange = v end
})
FarmConfigTab:Slider({
    Title = 'Kill Aura CD',
    Value = {Min = 0.05, Max = 2, Default = 0.12},
    Callback = function(v) Options.KillAuraCD = v end
})
FarmConfigTab:Toggle({
    Title = 'Kill Aura',
    Default = false,
    Callback = function(v)
        Toggles.KillAura = { Value = v }
        Thread('KillAura', SafeLoop('Kill Aura', Func_KillAura), v)
    end
})

FarmConfigTab:Section({Title = 'Instant Kill'})
FarmConfigTab:Paragraph({Title = 'Note', Desc = 'Instantly kills mobs.\nSet Min HP to only kill mobs with that HP or higher.\nSet to 0 to kill all mobs.'})
FarmConfigTab:Slider({Title = 'InstaKill Min HP', Value = {Min = 0, Max = 1000000, Default = 500000},
    Callback = function(v) Options.InstaKillMinHP = v end
})
FarmConfigTab:Toggle({Title = 'Instant Kill', Default = false,
    Callback = function(v)
        Toggles.InstaKill = {Value = v}
        Options.M1Speed = v and 0.05 or 0.15
    end
})
FarmConfigTab:Toggle({Title = 'Anti Stun/ Knockback', Default = false,
    Callback = function(v)
        Toggles.AntiKnockback = {Value = v}
        if v then Func_AntiKnockback() end
    end
})
FarmConfigTab:Section({Title = 'Movement'})
FarmConfigTab:Dropdown({Title = 'Movement Type', Values = {'Teleport', 'Tween'}, Default = 'Teleport',
    Callback = function(v) Options.SelectedMovementType = v end
})
FarmConfigTab:Dropdown({Title = 'Farm Position', Values = {'Behind', 'Above', 'Below'}, Default = 'Behind',
    Callback = function(v) Options.SelectedFarmType = v end
})
FarmConfigTab:Slider({Title = 'Farm Distance', Value = {Min = 0, Max = 30, Default = 5},
    Callback = function(v) Options.Distance = v end
})
FarmConfigTab:Slider({Title = 'Tween Speed', Value = {Min = 0, Max = 500, Default = 160},
    Callback = function(v) Options.TweenSpeed = v end
})
FarmConfigTab:Section({Title = 'Haki Settings'})
FarmConfigTab:Toggle({Title = 'Auto Activate Observation Haki', Default = false,
    Callback = function(v)
        Toggles.ObserHaki = {Value = v}
        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end
})
FarmConfigTab:Toggle({Title = 'Auto Activate Armament Haki', Default = false,
    Callback = function(v)
        Toggles.ArmHaki = {Value = v}
        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end
})
FarmConfigTab:Toggle({Title = 'Auto Activate Conqueror Haki', Default = false,
    Callback = function(v)
        Toggles.ConquerorHaki = {Value = v}
        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end
})
FarmConfigTab:Toggle({Title = 'Target Only (Conqueror)', Default = false,
    Callback = function(v) Toggles.OnlyTarget = {Value = v} end
})
FarmConfigTab:Section({Title = 'Auto Skill'})
FarmConfigTab:Paragraph({Title = 'Mode', Desc = 'Normal: checks cooldowns\nInstant: no cooldown check (may affect performance)'})
FarmConfigTab:Dropdown({Title = 'Select Skills', Values = {'Z', 'X', 'C', 'V', 'F'}, Default = {'Z'}, Multi = true,
    Callback = function(v) Options.SelectedSkills = ToSet(v) end
})
Options.SelectedSkills = {Z = true}
FarmConfigTab:Dropdown({
    Title = 'Skill Mode',
    Values = {'Normal', 'Instant'},
    Default = 'Normal',
    Callback = function(v) Options.AutoSkillType = v end
})
FarmConfigTab:Toggle({Title = 'Auto skill Boss Only', Default = false,
    Callback = function(v) Toggles.AutoSkill_BossOnly = {Value = v} end
})
FarmConfigTab:Toggle({Title = 'Auto Use Skills', Default = false,
    Callback = function(v)
        Toggles.AutoSkill = {Value = v}
        Thread('AutoSkill', SafeLoop('Auto Skill', Func_AutoSkill), v)
    end
})

--Window:Divider() -- Section: 'Main'
local mainfarm = window:Tab({Title = 'Level Farm', Icon = 'rbxassetid://76457336832864'})

mainfarm:Section({Title = 'Main Farm'})

local FarmStatus = mainfarm:Paragraph({Title = 'Auto Farm Status', Desc = 'Status: Idle'})

mainfarm:Toggle({Title = 'Auto Farm Level', Default = false,
    Callback = function(v)
        Toggles.LevelFarm = {Value = v}
        if not v then Shared.QuestNPC = '' end
    end
})

mainfarm:Toggle({
    Title = 'Auto Second Sea (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoSecondSea = {Value = v}
        Thread('AutoSecondSea', SafeLoop('Auto Second Sea', Func_AutoSecondSea), v)
    end
})

mainfarm:Toggle({Title = 'Auto Farm Nearest Mob', Default = false,
    Callback = function(v) Toggles.NearestMobFarm = {Value = v} end
})

mainfarm:Slider({Title = 'Nearest Farm Radius', Value = {Min = 100, Max = 1000, Default = 500},
    Callback = function(v) Options.MobFarmRadius = v end
})

mainfarm:Section({Title = 'Mob Farm'})

mainfarm:Dropdown({Title = 'Select Mob(s)', Values = Tables.MobList, Default = Tables.MobList[1] or '', Multi = true,
    Callback = function(v) Options.SelectedMob = ToSet(v) end
})

Options.SelectedMob = Tables.MobList[1] and {[Tables.MobList[1]] = true} or {}

mainfarm:Button({Title = 'Refresh Mob List',
    Callback = function()
        UpdateNPCLists()
        fnl:MakeNotification({Title = 'Refreshed', Description = 'Mob list updated.', Duration = 2})
    end
})

mainfarm:Toggle({Title = 'Autofarm Selected Mob', Default = false,
    Callback = function(v)
        Toggles.MobFarm = {Value = v}
        if not v then Shared.MobIdx = 1 end
    end
})

mainfarm:Toggle({Title = 'Autofarm All Mobs', Default = false,
    Callback = function(v) Toggles.AllMobFarm = {Value = v} end
})

local easterupdate = window:Tab({Title = 'Easter Event', Icon = 'rbxassetid://119851442975243'})

local EasterMerchantStock = {}
local EasterMerchantItemNames = {} 

local function SyncEasterMerchantStock()
    table.clear(EasterMerchantStock)
    table.clear(EasterMerchantItemNames)

    local merchantUI = PGui:FindFirstChild('EasterMerchantUI')
    if not merchantUI then return end
    local holder = merchantUI:FindFirstChild('Holder', true)
    if not holder then return end

    for _, child in pairs(holder:GetChildren()) do
        if not (child:IsA('Frame') or child:IsA('ImageButton') or child:IsA('TextButton')) then continue end

        local itemName = nil
        local stock = 0

        -- Find item name label
        for _, desc in pairs(child:GetDescendants()) do
            if desc:IsA('TextLabel') and desc.Text ~= '' then
                local t = desc.Text
                -- Skip pure numbers, stock labels
                if not t:match('^%d+$') and not t:lower():find('stock') and not t:lower():find('cost') then
                    if not itemName or #t > #itemName then
                        itemName = t
                    end
                end
            end
        end

        -- Find stock amount
        for _, desc in pairs(child:GetDescendants()) do
            if desc:IsA('TextLabel') then
                local t = desc.Text
                if t == '∞' or t:lower():find('inf') then
                    stock = 999
                    break
                end
                local n = tonumber(t:match('%d+'))
                if n and n ~= tonumber(itemName) then
                    stock = n
                end
            end
        end

        if itemName and itemName ~= '' then
            EasterMerchantStock[itemName] = stock
            if not table.find(EasterMerchantItemNames, itemName) then
                table.insert(EasterMerchantItemNames, itemName)
            end
        end
    end
end

local function OpenEasterMerchantUI()
    pcall(function()
        local openRemote = GetRemote(RS, 'Remotes.EasterMerchantRemotes.OpenEasterMerchantUI')
        if openRemote then openRemote:FireServer() end
    end)
    task.wait(0.3)

    pcall(function()
        local openShop = GetRemote(RS, 'RemoteEvents.OpenEasterShop')
        if openShop then openShop:FireServer() end
    end)
    task.wait(0.3)

    pcall(function()
        local openRemote = GetRemote(RS, 'Remotes.EasterMerchantRemotes.OpenEasterMerchantUI')
        if openRemote then
            if firesignal then
                firesignal(openRemote.OnClientEvent)
            elseif getconnections then
                for _, v in pairs(getconnections(openRemote.OnClientEvent)) do
                    if v.Function then task.spawn(v.Function) end
                end
            end
        end
    end)
    task.wait(0.3)

    pcall(function()
        local shopSync = GetRemote(RS, 'RemoteEvents.EasterShopSync')
        if shopSync then
            if firesignal then firesignal(shopSync.OnClientEvent)
            elseif getconnections then
                for _, v in pairs(getconnections(shopSync.OnClientEvent)) do
                    if v.Function then task.spawn(v.Function) end
                end
            end
        end
    end)

    task.wait(0.5)
    SyncEasterMerchantStock()
end

local function BuyEasterItem(itemName, qty)
    local bought = false
    qty = qty or 1

    local purchaseRemote = GetRemote(RS, 'Remotes.EasterMerchantRemotes.PurchaseEasterMerchantItem')
    if purchaseRemote then
        local ok = pcall(function() purchaseRemote:InvokeServer(itemName, qty) end)
        if not ok then ok = pcall(function() purchaseRemote:FireServer(itemName, qty) end) end
        bought = ok
    end

    if not bought then
        local merchantUI = PGui:FindFirstChild('EasterMerchantUI')
        local holder = merchantUI and merchantUI:FindFirstChild('Holder', true)
        if holder then
            for _, child in pairs(holder:GetChildren()) do
                local foundName = false
                for _, desc in pairs(child:GetDescendants()) do
                    if desc:IsA('TextLabel') and desc.Text == itemName then
                        foundName = true; break
                    end
                end
                if foundName then
                    local btn = child:FindFirstChildWhichIsA('TextButton', true)
                        or child:FindFirstChildWhichIsA('ImageButton', true)
                    if btn then
                        bought = gsc(btn)
                        if not bought then
                            pcall(function() btn.MouseButton1Click:Fire() end)
                            bought = true
                        end
                    end
                    break
                end
            end
        end
    end

    if not bought then
        pcall(function()
            local upgradeRemote = GetRemote(RS, 'Remotes.EasterMerchantRemotes.RequestEasterUpgrade')
            if upgradeRemote then upgradeRemote:FireServer(itemName, qty); bought = true end
        end)
    end

    if not bought then
        if Remotes.ValentineBuy then
            pcall(function() Remotes.ValentineBuy:FireServer(itemName, qty) end)
            bought = true
        elseif Remotes.MerchantBuy then
            pcall(function() Remotes.MerchantBuy:InvokeServer(itemName, qty) end)
            bought = true
        end
    end

    return bought
end

function Func_AutoEasterMerchant()
    local function Notify(msg)
        fnl:MakeNotification({Title = 'Easter Merchant', Description = msg, Duration = 4})
    end

    -- Open and sync stock
    OpenEasterMerchantUI()
    task.wait(1)
    SyncEasterMerchantStock()

    -- Auto-populate dropdown if empty
    if #EasterMerchantItemNames > 0 and EasterMerchDropdown then
        pcall(function()
            EasterMerchDropdown:Refresh(EasterMerchantItemNames, false)
        end)
    end

    while Toggles.AutoEasterMerchant and Toggles.AutoEasterMerchant.Value do
        -- Re-open and sync stock each cycle
        OpenEasterMerchantUI()
        task.wait(1)
        SyncEasterMerchantStock()

        -- Determine what to buy
        local sel = Options.SelectedEasterItems or {}
        local toBuy = {}

        -- If nothing selected, buy everything in stock
        local hasSelection = false
        for _, v in pairs(sel) do if v then hasSelection = true; break end end

        if hasSelection then
            for _, name in ipairs(EasterMerchantItemNames) do
                if sel[name] then table.insert(toBuy, name) end
            end
        else
            -- Auto-select all available items
            for _, name in ipairs(EasterMerchantItemNames) do
                table.insert(toBuy, name)
            end
        end

        local bought = 0
        for _, itemName in ipairs(toBuy) do
            if not (Toggles.AutoEasterMerchant and Toggles.AutoEasterMerchant.Value) then break end

            local stock = EasterMerchantStock[itemName] or 0
            if stock == 0 then continue end

            local qty = (stock == 999) and 1 or stock
            local ok = BuyEasterItem(itemName, qty)
            if ok then bought = bought + 1 end
            task.wait(1.2)
        end

        -- Close UI
        local merchantUI = PGui:FindFirstChild('EasterMerchantUI')
        if merchantUI then
            local mf = merchantUI:FindFirstChild('MainFrame')
            if mf then mf.Visible = false end
        end

        -- Wait for restock
        local waitSec = 35
        local timerLbl = merchantUI and merchantUI:FindFirstChild('RefreshTimerLabel', true)
        if timerLbl and timerLbl.Text ~= '' then
            local s = GetSecondsFromTimer(timerLbl.Text)
            if s and s > 2 then waitSec = s + 2 end
        end

        local elapsed = 0
        while elapsed < waitSec
            and Toggles.AutoEasterMerchant
            and Toggles.AutoEasterMerchant.Value do
            task.wait(1); elapsed = elapsed + 1
        end
    end
end


local function GetAllHiddenEggs()
    local eggs = {}
    local easterFolder = workspace:FindFirstChild('EasterEggs')
    if not easterFolder then return eggs end
    for _, child in pairs(easterFolder:GetChildren()) do
        if child.Name:match('^EasterEgg_HiddenEgg')
        or child.Name:match('^EasterEgg_TimedEgg')
        or child.Name:match('^EasterEgg_BossEgg') then
            table.insert(eggs, child)
        end
    end
    return eggs
end

local function GetEggPosition(egg)
    local ok, piv = pcall(function() return egg:GetPivot() end)
    if ok and piv then return piv.Position end
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA('BasePart') then return desc.Position end
    end
    if egg:IsA('BasePart') then return egg.Position end
    return nil
end

local function GetEasterQuestProgress()
    local cur, max = 0, 0
    local QuestUI = PGui:FindFirstChild('QuestUI')
    if not QuestUI then return cur, max end
    for _, lbl in pairs(QuestUI:GetDescendants()) do
        if lbl:IsA('TextLabel') and lbl.Text ~= '' then
            local c, m = lbl.Text:match('(%d+)%s*/%s*(%d+)')
            if c and m then
                cur = tonumber(c) or 0
                max = tonumber(m) or 0
                if max > 0 then break end
            end
        end
    end
    return cur, max
end

local function IsEasterQuestVisible()
    local QuestUI = PGui:FindFirstChild('QuestUI')
    if not QuestUI then return false end
    local questFrame = QuestUI:FindFirstChild('Quest')
    if questFrame then
        local inner = questFrame:FindFirstChild('Quest', true)
        if inner then return inner.Visible end
        return questFrame.Visible
    end
    return false
end

local CollectedEggIds = {}  -- tracks egg instances already collected this session

local function GetUncollectedEggs()
    local all = GetAllHiddenEggs()
    local result = {}
    for _, egg in ipairs(all) do
        -- An egg is uncollected if:
        -- 1. We haven't marked it collected
        -- 2. It still exists in workspace (parent check)
        if egg and egg.Parent and not CollectedEggIds[egg] then
            table.insert(result, egg)
        end
    end
    return result
end

local function CollectEgg(egg, root)
    if not egg or not egg.Parent then return false end
    local pos = GetEggPosition(egg)
    if not pos then return false end

    -- Teleport directly onto the egg
    root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
    root.AssemblyLinearVelocity = Vector3.zero
    task.wait(0.3)

    -- Try ProximityPrompt (deep search)
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA('ProximityPrompt') then
            pcall(function()
                desc.HoldDuration = 0  -- instant trigger
                fireproximityprompt(desc)
            end)
            task.wait(0.3)
        end
    end

    -- Try ClickDetector (deep search)
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA('ClickDetector') then
            pcall(function() fireclickdetector(desc) end)
            task.wait(0.3)
        end
    end

    -- Try touching each BasePart directly (physical touch trigger)
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA('BasePart') then
            root.CFrame = CFrame.new(desc.Position)
            root.AssemblyLinearVelocity = Vector3.zero
            task.wait(0.15)
        end
    end

    -- Fire any RemoteEvent named collect/pickup/egg related
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA('RemoteEvent') then
            local n = desc.Name:lower()
            if n:find('collect') or n:find('pickup') or n:find('grab') or n:find('egg') then
                pcall(function() desc:FireServer() end)
                task.wait(0.2)
            end
        end
    end

    -- Try using VirtualUser to press E key (common pickup key)
    pcall(function()
        local VU = game:GetService('VirtualUser')
        VU:CaptureController()
        VU:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(0.1)
        VU:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)

    -- Try sending keyboard E input (another common pickup key)
    pcall(function()
        local VIM = game:GetService('VirtualInputManager')
        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.1)
        VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)

    -- Mark collected
    CollectedEggIds[egg] = true
    return true
end

function Func_AutoEasterEggQuest()
    local function Notify(msg)
        fnl:MakeNotification({Title = 'Easter Egg Hunt', Description = msg, Duration = 4})
    end

    local function AcceptEasterQuest()
        local npc = PATH.InteractNPCs:FindFirstChild('EasterQuestNPC')
            or workspace:FindFirstChild('EasterQuestNPC')

        if not npc then
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name:lower():find('easterquest') or
                   (v.Name:lower():find('easter') and v.Name:lower():find('npc')) then
                    npc = v.Parent
                    break
                end
            end
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then return false end

        if npc then
            local ok, piv = pcall(function() return npc:GetPivot() end)
            if ok and piv then
                root.CFrame = piv * CFrame.new(0, 0, 3)
            else
                local bp = npc:FindFirstChildOfClass('BasePart')
                if bp then root.CFrame = bp.CFrame * CFrame.new(0, 0, 3) end
            end
            root.AssemblyLinearVelocity = Vector3.zero
            task.wait(0.4)

            for _, desc in pairs(npc:GetDescendants()) do
                if desc:IsA('ProximityPrompt') then
                    pcall(function() fireproximityprompt(desc) end)
                    task.wait(0.6)
                    break
                elseif desc:IsA('ClickDetector') then
                    pcall(function() fireclickdetector(desc) end)
                    task.wait(0.6)
                    break
                end
            end
        end

        pcall(function() Remotes.QuestAccept:FireServer('EasterQuestNPC') end)
        task.wait(0.8)
        return IsEasterQuestVisible()
    end

    local function TurnInQuest()
        local npc = PATH.InteractNPCs:FindFirstChild('EasterQuestNPC')
            or workspace:FindFirstChild('EasterQuestNPC')
        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then return end

        if npc then
            local ok, piv = pcall(function() return npc:GetPivot() end)
            if ok and piv then
                root.CFrame = piv * CFrame.new(0, 0, 3)
            else
                local bp = npc:FindFirstChildOfClass('BasePart')
                if bp then root.CFrame = bp.CFrame * CFrame.new(0, 0, 3) end
            end
            root.AssemblyLinearVelocity = Vector3.zero
            task.wait(0.4)

            for _, desc in pairs(npc:GetDescendants()) do
                if desc:IsA('ProximityPrompt') then
                    pcall(function() fireproximityprompt(desc) end)
                    task.wait(0.6)
                    break
                elseif desc:IsA('ClickDetector') then
                    pcall(function() fireclickdetector(desc) end)
                    task.wait(0.6)
                    break
                end
            end
        end
    end

    -- Clear collected cache on each fresh start of the toggle
    CollectedEggIds = {}

    -- Accept quest first
    Notify('Accepting Easter Egg Hunt quest...')
    local accepted = AcceptEasterQuest()
    if not accepted then
        Notify('Quest accept attempted.\nCollecting visible eggs...')
    end
    task.wait(0.5)

    -- Listen for new eggs spawning into the folder and collect immediately
    local easterFolder = workspace:FindFirstChild('EasterEggs')
    local newEggConn = nil

    if easterFolder then
        newEggConn = easterFolder.ChildAdded:Connect(function(child)
            if not (Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value) then return end
            if not child.Name:match('^EasterEgg_HiddenEgg') then return end
            if CollectedEggIds[child] then return end

            task.wait(0.1) -- brief wait for the egg to fully load

            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            if not root then return end

            Notify('New egg spawned: ' .. child.Name .. '\nCollecting...')
            CollectEgg(child, root)
        end)
    end

    -- Collect all currently existing uncollected eggs first
    local function SweepUncollected()
        local uncollected = GetUncollectedEggs()
        if #uncollected == 0 then return 0 end

        Notify(string.format('Found %d uncollected egg(s), collecting...', #uncollected))
        local done = 0

        for _, egg in ipairs(uncollected) do
            if not (Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value) then break end

            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            if not root then task.wait(1); continue end

            if not egg.Parent then
                CollectedEggIds[egg] = true
                continue
            end

            CollectEgg(egg, root)
            done = done + 1
            task.wait(0.1)
        end

        return done
    end

    SweepUncollected()

    -- Main idle loop: periodically sweep for any eggs we may have missed,
    -- check quest progress, turn in when complete, re-accept for next round
    local lastSweep = tick()
    local lastProgressCheck = tick()

    while Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value do
        task.wait(0.5)

        -- Sweep every 3 seconds for any eggs not caught by ChildAdded
        if tick() - lastSweep >= 3 then
            lastSweep = tick()
            local found = SweepUncollected()
            if found > 0 then
                local cur, max = GetEasterQuestProgress()
                Notify(string.format('Swept %d egg(s)\nQuest: %d/%d', found, cur, max))
            end
        end

        -- Check if quest is complete and turn in
        if tick() - lastProgressCheck >= 2 then
            lastProgressCheck = tick()
            local cur, max = GetEasterQuestProgress()
            if max > 0 and cur >= max then
                Notify(string.format('All %d/%d eggs collected!\nTurning in quest...', cur, max))
                TurnInQuest()
                task.wait(1)

                -- Clear cache for next quest cycle (new eggs will spawn)
                CollectedEggIds = {}

                -- Re-accept for next cycle immediately
                Notify('Re-accepting quest for next cycle...')
                AcceptEasterQuest()
                task.wait(0.5)

                lastSweep = 0 -- force sweep immediately
            end
        end
    end

    -- Cleanup connection
    if newEggConn then
        newEggConn:Disconnect()
        newEggConn = nil
    end

    Notify('Auto Easter Egg Hunt stopped.')
end

function Func_AutoFarmEggs()

end

function Func_BuyEasterSelectedOnce()
    OpenEasterMerchantUI()
    task.wait(1)
    SyncEasterMerchantStock()

    local sel = Options.SelectedEasterItems or {}
    local hasAny = false
    for _, v in pairs(sel) do if v then hasAny = true; break end end

    local list = hasAny and (function()
        local r = {}
        for _, n in ipairs(EasterMerchantItemNames) do if sel[n] then table.insert(r, n) end end
        return r
    end)() or EasterMerchantItemNames

    for _, name in ipairs(list) do
        local stock = EasterMerchantStock[name] or 0
        if stock == 0 then continue end
        local qty = (stock == 999) and 1 or stock
        BuyEasterItem(name, qty)
        task.wait(1.2)
    end

    fnl:MakeNotification({Title = 'Easter Merchant', Description = 'Purchase complete!', Duration = 3})
end

easterupdate:Section({Title = 'Easter Egg'})

-- Easter Egg Counter Label
local EasterEggCountLabel = easterupdate:Paragraph({
    Title = 'Easter Eggs',
    Desc = 'Easter Eggs: Loading...'
})

task.spawn(function()
    while true do
        task.wait(1)
        local count = 0

        pcall(function()
            for _, gui in pairs(PGui:GetDescendants()) do
                if gui:IsA('TextLabel') then
                    local n = gui.Text:lower()
                    local num = gui.Text:match('[Ee]aster [Ee]ggs?%s*:%s*(%d+)')
                    if num then
                        count = tonumber(num) or 0
                        break
                    end
                end
            end
        end)

        if count == 0 then
            pcall(function()
                local easterEggs = Plr:GetAttribute('EasterEggs')
                    or Plr:GetAttribute('Easter_Eggs')
                    or Plr:GetAttribute('EasterEggCount')
                if easterEggs then
                    count = tonumber(easterEggs) or 0
                end
            end)
        end

        if count == 0 then
            pcall(function()
                local data = Plr:FindFirstChild('Data')
                if data then
                    local eggVal = data:FindFirstChild('EasterEggs')
                        or data:FindFirstChild('Easter_Eggs')
                        or data:FindFirstChild('EasterEggCount')
                    if eggVal then
                        count = tonumber(eggVal.Value) or 0
                    end
                end
            end)
        end

        pcall(function()
            EasterEggCountLabel:SetDesc("Total Easter Egg: "..GetItemQty("Easter Egg"))
        end)
    end
end)

easterupdate:Toggle({
    Title = 'Auto Easter Egg Hunt (Quest)',
    Default = false,
    Callback = function(v)
        Toggles.AutoEasterEggQuest = {Value = v}
        Thread('AutoEasterEggQuest', SafeLoop('Easter Egg Hunt', Func_AutoEasterEggQuest), v)
    end
})

easterupdate:Toggle({
    Title = 'Auto Farm Easter Eggs (Bunny)',
    Default = false,
    Callback = function(v)
        Toggles.AutoFarmEggs = {Value = v}
        Thread('AutoFarmEggs', SafeLoop('Auto Farm Eggs', Func_AutoFarmEggs), v)
    end
})

easterupdate:Section({Title = 'Easter Merchant'})



local EasterMerchDropdown = easterupdate:Dropdown({
    Title = 'Select Items to Buy',
    Values = EasterMerchantItemNames,
    Default = {},
    Multi = true,
    Callback = function(v)
        Options.SelectedEasterItems = ToSet(v)
    end
})

easterupdate:Button({
    Title = 'Buy Selected Once',
    Callback = function()
        task.spawn(Func_BuyEasterSelectedOnce)
    end
})

easterupdate:Toggle({
    Title = 'Auto Buy Easter Merchant',
    Default = false,
    Callback = function(v)
        Toggles.AutoEasterMerchant = {Value = v}
        Thread('AutoEasterMerchant', SafeLoop('Easter Merchant', Func_AutoEasterMerchant), v)
    end
})


local BossFarmTab = window:Tab({Title = 'Boss Farm', Icon = 'rbxassetid://10723405360'})

BossFarmTab:Section({Title = 'World Bosses'})
BossFarmTab:Dropdown({Title = 'Select Boss(es)', Values = Tables.BossList, Default = '', Multi = true,
    Callback = function(v) Options.SelectedBosses = ToSet(v) end
})
BossFarmTab:Toggle({Title = 'Auto farm Selected Boss', Default = false,
    Callback = function(v) Toggles.BossesFarm = {Value = v} end
})
BossFarmTab:Toggle({Title = 'Auto farm All Bosses', Default = false,
    Callback = function(v) Toggles.AllBossesFarm = {Value = v} end
})

BossFarmTab:Section({Title = 'Summon Boss'})
BossFarmTab:Dropdown({
    Title = 'Select Summon Boss',
    Values = GetCombinedSummonList(),
    Default = Tables.SummonList[1] or '',
    Callback = function(v) Options.SelectedSummon = v end
})
BossFarmTab:Dropdown({Title = 'Summon Difficulty', Values = Tables.DiffList, Default = 'Normal',
    Callback = function(v) Options.SelectedSummonDiff = v end
})
BossFarmTab:Toggle({Title = 'Auto Summon', Default = false,
    Callback = function(v) Toggles.AutoSummon = {Value = v} end
})
BossFarmTab:Toggle({Title = 'Autofarm Summon Boss', Default = false,
    Callback = function(v) Toggles.SummonBossFarm = {Value = v} end
})

BossFarmTab:Section({Title = 'Pity System'})
local PityStatusLabel = BossFarmTab:Paragraph({ Title = 'Pity', Desc = '0 / 25' })
task.spawn(function()
    while true do
        task.wait(2)
        local cur, max = GetCurrentPity()
        PityStatusLabel:SetDesc(string.format('%d / %d', cur, max))
    end
end)
BossFarmTab:Dropdown({Title = 'Build Pity Boss(es)', Values = Tables.AllBossList, Default = '', Multi = true,
    Callback = function(v) Options.SelectedBuildPity = ToSet(v) end
})
BossFarmTab:Dropdown({Title = 'Use Pity Boss', Values = Tables.AllBossList, Default = '',
    Callback = function(v) Options.SelectedUsePity = v end
})
BossFarmTab:Dropdown({Title = 'Pity Difficulty', Values = Tables.DiffList, Default = 'Normal',
    Callback = function(v) Options.SelectedPityDiff = v end
})
BossFarmTab:Toggle({Title = 'Autofarm Pity Boss', Default = false,
    Callback = function(v) Toggles.PityBossFarm = {Value = v} end
})

local CosmicBossKeywords = {'CosmicBeingBoss_Normal'}
local CosmicBossIsland = 'Punch'
 
function Func_AutoCosmicBoss()
    
end

local SeaBossKeywords = {'Kraken', 'SeaSerpent', 'seaserpent', 'kraken', 'Sea Serpent'}


 
local SEA_WAIT_CENTER = Vector3.new(-3617.011474609375, -8.301654815673828, -2396.183837890625)
local SEA_ORBIT_RADIUS = 15
local SEA_ORBIT_SPEED = 3

function Func_AutoSeaBossSpawn()
    while Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value do
        task.wait(0.5)

        -- Pause sea boss spawn if cosmic boss is alive and auto kill cosmic is on
        if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
            local cosmic = FindLiveBossAnywhere(CosmicBossKeywords)
            if cosmic then
                -- Wait until cosmic is dead before continuing sea spawn
                repeat
                    task.wait(1)
                    cosmic = FindLiveBossAnywhere(CosmicBossKeywords)
                until not cosmic or not (Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value)
                task.wait(1)
                continue
            end
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then task.wait(1); continue end

        local boss = FindLiveBossAnywhere(SeaBossKeywords)

        if boss then
            task.wait(1)
            continue
        end

        local startPos = SEA_WAIT_CENTER + Vector3.new(SEA_ORBIT_RADIUS, 0, 0)
        local startCF = CFrame.new(startPos, SEA_WAIT_CENTER)
        local dist = (root.Position - startPos).Magnitude

        if dist > 10 then
            local duration = math.clamp(dist / 80, 0.5, 5)
            local tw = TweenService:Create(
                root,
                TweenInfo.new(duration, Enum.EasingStyle.Linear),
                { CFrame = startCF }
            )
            tw:Play()
            tw.Completed:Wait()
        end

        local angle = 0
        while Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value do
            -- Check cosmic again while orbiting
            if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
                local cosmic = FindLiveBossAnywhere(CosmicBossKeywords)
                if cosmic then
                    break
                end
            end

            if FindLiveBossAnywhere(SeaBossKeywords) then
                break
            end

            angle = angle + (math.pi * 2 / SEA_ORBIT_SPEED) * 0.1
            if angle >= math.pi * 2 then angle = angle - math.pi * 2 end

            local orbitX = SEA_WAIT_CENTER.X + math.cos(angle) * SEA_ORBIT_RADIUS
            local orbitZ = SEA_WAIT_CENTER.Z + math.sin(angle) * SEA_ORBIT_RADIUS
            local orbitPos = Vector3.new(orbitX, SEA_WAIT_CENTER.Y, orbitZ)
            local orbitCF = CFrame.new(orbitPos, SEA_WAIT_CENTER)

            local tw2 = TweenService:Create(
                root,
                TweenInfo.new(0.1, Enum.EasingStyle.Linear),
                { CFrame = orbitCF }
            )
            tw2:Play()
            task.wait(0.1)
        end
    end
end


-- Add these options near your other Options
local SEA_BOSS_Y_OFFSET = 150  -- height above kraken head
local SEA_DODGE_ACTIVE = false -- shared state for dodge

function GetSeaBossPosition(boss)
    local pos = nil
    pcall(function() pos = boss:GetPivot().Position end)
    if not pos then
        -- Sea Serpent uses RootPart as PrimaryPart
        local root = boss:FindFirstChild('RootPart')
            or boss.PrimaryPart
            or boss:FindFirstChild('kraken_low')
            or boss:FindFirstChildOfClass('BasePart')
        if root then pos = root.Position end
    end
    return pos
end

function Func_AutoSeaBoss()
   
end

function Func_AutoSeaDodge()
    local function FindAttackObj()
    local SoundService = game:GetService('SoundService')
    for _, child in pairs(SoundService:GetChildren()) do
        local n = child.Name:lower()
        if n:find('soundpart_seaserpentattack') or n:find('seaserpentattack') then
            return child, child.Name
        end
    end
    -- Fallback workspace check for Kraken
    local attackPatterns = {'KkrakenAttack1', 'KkrakenAttack2', 'KkrakenAttack3', 'KrakenAttack'}
    for _, pattern in ipairs(attackPatterns) do
        local obj = workspace:FindFirstChild(pattern)
        if obj then return obj, pattern end
    end
    return nil, nil
end

local function IsAttacking()
    local SoundService = game:GetService('SoundService')
    for _, child in pairs(SoundService:GetChildren()) do
        local n = child.Name:lower()
        if n:find('soundpart_seaserpentattack1')
        or n:find('soundpart_seaserpentattack2')
        or n:find('soundpart_seaserpentattack3') then
            return true, child
        end
    end
    -- Fallback workspace check for Kraken
    local attackPatterns = {'KkrakenAttack1', 'KkrakenAttack2', 'KkrakenAttack3', 'KrakenAttack'}
    for _, pattern in ipairs(attackPatterns) do
        local obj = workspace:FindFirstChild(pattern)
        if obj then return true, obj end
    end
    return false, nil
end

    local function TweenTo(root, targetCF, speed)
        local dist = (root.Position - targetCF.Position).Magnitude
        speed = speed or Options.TweenSpeed or 160
        local duration = math.clamp(dist / speed, 0.05, 0.5)
        local tw = TweenService:Create(
            root,
            TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            { CFrame = targetCF }
        )
        tw:Play()
        tw.Completed:Wait()
    end

    local function GetBossRef()
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if npc:IsA('Model') then
                local n = npc.Name:lower()
                if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                    local hum = npc:FindFirstChildOfClass('Humanoid')
                    local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                    local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                        or (hum and hum.Health > 0)
                    if alive then return npc end
                end
            end
        end
        return nil
    end

    local function GetAboveBossCF(boss, extraHeight)
        local bossPos = GetSeaBossPosition(boss)
        if not bossPos then return nil end
        local yOffset = (Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET) + (extraHeight or 0)
        local pos = bossPos + Vector3.new(0, yOffset, 0)
        return CFrame.new(pos)
    end

    while Toggles.AutoSeaDodge and Toggles.AutoSeaDodge.Value do
        task.wait(0.03)

        if not (Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value) then
            SEA_DODGE_ACTIVE = false
            task.wait(0.5)
            continue
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then task.wait(0.5); continue end

        local attacking, attackObj = IsAttacking()

        if attacking and not SEA_DODGE_ACTIVE then
            SEA_DODGE_ACTIVE = true

            local boss = GetBossRef()
            if not boss then
                SEA_DODGE_ACTIVE = false
                continue
            end

            -- Step 1: Tween UP higher above boss
            local highDodgeCF = GetAboveBossCF(boss, Options.SeaDodgeDistance or 80)
            if highDodgeCF then
                TweenTo(root, highDodgeCF, Options.TweenSpeed or 160)
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end

            -- Wait for attack to end while staying high
            local timeout = tick()
            repeat
                task.wait(0.05)

                if root and root.Parent then
                    local bossPos = GetSeaBossPosition(boss)
                    if bossPos then
                        local yOffset = (Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET) + (Options.SeaDodgeDistance or 80)
                        local lockPos = bossPos + Vector3.new(0, yOffset, 0)
                        root.CFrame = CFrame.new(lockPos)
                        root.AssemblyLinearVelocity = Vector3.zero
                    end
                end

                local stillAttacking = IsAttacking()
                if not stillAttacking then break end
            until tick() - timeout > 4
                or not (Toggles.AutoSeaDodge and Toggles.AutoSeaDodge.Value)

            task.wait(0.1)

            -- Step 2: Tween back DOWN to normal position
            if root and root.Parent then
                local returnCF = GetAboveBossCF(boss, 0)
                if returnCF then
                    TweenTo(root, returnCF, Options.TweenSpeed or 160)
                    root.AssemblyLinearVelocity = Vector3.zero
                    root.AssemblyAngularVelocity = Vector3.zero
                end
            end

            task.wait(0.2)
            SEA_DODGE_ACTIVE = false

        elseif not attacking then
            SEA_DODGE_ACTIVE = false
        end
    end
    SEA_DODGE_ACTIVE = false
end


local DioBossKeywords = {'TheWorldBoss_Normal', 'TheWorldBoss_Medium', 'TheWorldBoss_Hard','TheWorldBoss_Extreme'}
local DioDiffList = {'Normal', 'Medium', 'Hard', 'Extreme'}

function Func_AutoSpawnDio()
    while Toggles.AutoSpawnDio and Toggles.AutoSpawnDio.Value do
        task.wait(3) -- ADD THIS: wait between summon attempts
        local boss = FindLiveBossAnywhere(DioBossKeywords)
        if not boss then
            local diff = Options.SelectedDioDiff or 'Normal'
            pcall(function()
                game:GetService('ReplicatedStorage')
                    :WaitForChild('RemoteEvents')
                    :WaitForChild('RequestSpawnTheWorld')
                    :FireServer(diff)
            end)
            task.wait(3) -- wait after firing before checking again
        end
    end
end

function Func_AutoKillDio()
    
end

local Sea2farm = window:Tab({Title = 'Sea 2 Farm', Icon = 'rbxassetid://10723405360'})

Sea2farm:Section({Title = 'Dio (The World Boss)'})
 
local DioBossStatusLabel = Sea2farm:Paragraph({
	Title = 'Dio Boss',
	Desc = 'Status: Not Found'
})
 
task.spawn(function()
    while true do
        task.wait(1)
        local boss = FindLiveBossAnywhere(DioBossKeywords)
        Shared.DioBossFound = boss ~= nil
        if boss then
            DioBossStatusLabel:SetDesc('Status: Found - ' .. tostring(boss.Name))
        else
            DioBossStatusLabel:SetDesc('Status: Not Found')
        end
    end
end)
 
Sea2farm:Dropdown({
	Title = 'Dio Difficulty',
	Values = DioDiffList,
	Default = 'Normal',
	Callback = function(v) Options.SelectedDioDiff = v end
})
 
Sea2farm:Toggle({
	Title = 'Auto Spawn Dio',
	Default = false,
	Callback = function(v)
		Toggles.AutoSpawnDio = {Value = v}
		Thread('Sea2.SpawnDio', SafeLoop('Auto Spawn Dio', Func_AutoSpawnDio), v)
	end
})
 
Sea2farm:Toggle({
	Title = 'Auto Kill Dio',
	Default = false,
	Callback = function(v)
		Toggles.AutoKillDio = {Value = v}
		Thread('Sea2.KillDio', SafeLoop('Auto Kill Dio', Func_AutoKillDio), v)
	end
})

Sea2farm:Section({Title = 'Cosmic Boss'})

local CosmicBossStatusLabel = Sea2farm:Paragraph({
	Title = 'Cosmic Boss',
	Desc = 'Status: Not Found'
})
 
task.spawn(function()
    while true do
        task.wait(1)
        local boss = FindLiveBossAnywhere(CosmicBossKeywords)
        Shared.CosmicBossFound = boss ~= nil
        if boss then
            CosmicBossStatusLabel:SetDesc('Status: Cosmic Boss Found')
        else
            CosmicBossStatusLabel:SetDesc('Status: Not Found - Waiting...')
        end
    end
end)
 
Sea2farm:Toggle({
	Title = 'Auto Kill Cosmic Boss',
	Default = false,
	Callback = function(v)
		Toggles.AutoCosmicBoss = {Value = v}
		Thread('CosmicBoss.AutoKill', SafeLoop('Auto Cosmic Boss', Func_AutoCosmicBoss), v)
	end
})
 
Sea2farm:Section({Title = 'Sea Beast'})

local SeaBossStatusLabel = Sea2farm:Paragraph({
	Title = 'Sea Boss',
	Desc = 'Status: Not Found'
})
 
task.spawn(function()
	while true do
		task.wait(1)
		if Shared.SeaBossFound then
			SeaBossStatusLabel:SetDesc('Status: '..tostring(boss.Name) .. ' Found')
		else
			SeaBossStatusLabel:SetDesc('Status: Not Found - Waiting at sea...')
		end
	end
end)
 
Sea2farm:Toggle({
	Title = 'Auto Spawn Wait (Stay at Sea)',
	Default = false,
	Callback = function(v)
		Toggles.AutoSeaBossSpawn = {Value = v}
		Thread('SeaBoss.SpawnWait', SafeLoop('Sea Boss Spawn Wait', Func_AutoSeaBossSpawn), v)
	end
})
 
Sea2farm:Toggle({
	Title = 'Auto Kill Sea Boss',
	Default = false,
	Callback = function(v)
		Toggles.AutoSeaBoss = {Value = v}
		Thread('SeaBoss.AutoKill', SafeLoop('Auto Sea Boss', Func_AutoSeaBoss), v)
	end
})

Sea2farm:Section({Title = 'Dodge Attack'})
Sea2farm:Slider({
    Title = 'Dodge Distance',
    Value = {Min = 100, Max = 1000, Default = 600},
    Callback = function(v)
        DODGE_DISTANCE = v
    end
})
Sea2farm:Toggle({
    Title = 'Auto Dodge Sea Beast Attack',
    Default = false,
    Callback = function(v)
        Toggles.AutoSeaDodge = {Value = v}
        Shared_DodgeSavedCF = nil
        Thread('SeaBoss.AutoDodge', SafeLoop('Auto Sea Dodge', Func_AutoSeaDodge), v)
    end
})

--Window:Divider() -- Section: 'Auto Switch'

local CombinedTitleList = {}
for _, cat in ipairs(Tables.TitleCategory) do table.insert(CombinedTitleList, cat) end
for _, t in ipairs(Tables.TitleList) do table.insert(CombinedTitleList, t) end
 
local TitleSwitchTab = window:Tab({Title = 'Title', Icon = 'rbxassetid://10734950020'})
 
TitleSwitchTab:Section({Title = 'Auto Title Switch'})


TitleSwitchTab:Toggle({
    Title = 'Enable Auto Switch Title',
    Default = false,
    Callback = function(v)
        Toggles.AutoTitle = { Value = v }
        if not v then Shared.LastSwitch.Title = '' end
    end
})
TitleSwitchTab:Dropdown({
    Title = 'Default Title',
    Values = CombinedTitleList,
    Default = 'None',
    Callback = function(v) Options.DefaultTitle = v end
})
TitleSwitchTab:Dropdown({
    Title = 'Title [Mob]',
    Values = CombinedTitleList,
    Default = 'None',
    Callback = function(v) Options.Title_Mob = v end
})
TitleSwitchTab:Dropdown({
    Title = 'Title [Boss]',
    Values = CombinedTitleList,
    Default = 'None',
    Callback = function(v) Options.Title_Boss = v end
})
TitleSwitchTab:Dropdown({
    Title = 'Title [Boss HP%]',
    Values = CombinedTitleList,
    Default = 'None',
    Callback = function(v) Options.Title_BossHP = v end
})
TitleSwitchTab:Slider({
    Title = 'Change at Boss HP%',
    Value = {Min = 0, Max = 100, Default = 15},
    Callback = function(v) Options.Title_BossHPAmt = v end
})

local RuneSwitchTab = window:Tab({Title = 'Rune', Icon = 'rbxassetid://11155986081'})

RuneSwitchTab:Section({Title = 'Auto Rune Switch'})
RuneSwitchTab:Toggle({Title = 'Enable Auto Switch Rune', Default = false,
    Callback = function(v) Toggles.AutoRune = {Value = v} end
})
RuneSwitchTab:Dropdown({Title = 'Default Rune', Values = Tables.RuneList, Default = 'None',
    Callback = function(v) Options.DefaultRune = v end
})
RuneSwitchTab:Dropdown({Title = 'Rune [Mob]', Values = Tables.RuneList, Default = 'None',
    Callback = function(v) Options.Rune_Mob = v end
})
RuneSwitchTab:Dropdown({Title = 'Rune [Boss]', Values = Tables.RuneList, Default = 'None',
    Callback = function(v) Options.Rune_Boss = v end
})
RuneSwitchTab:Dropdown({Title = 'Rune [Boss HP%]', Values = Tables.RuneList, Default = 'None',
    Callback = function(v) Options.Rune_BossHP = v end
})
RuneSwitchTab:Slider({Title = 'Change at Boss HP%', Value = {Min = 0, Max = 100, Default = 15},
    Callback = function(v) Options.Rune_BossHPAmt = v end
})

local BuildSwitchTab = window:Tab({Title = 'Build', Icon = 'rbxassetid://13075622619'})

BuildSwitchTab:Section({Title = 'Auto Build Switch'})
BuildSwitchTab:Toggle({Title = 'Enable Auto Switch Build', Default = false,
    Callback = function(v) Toggles.AutoBuild = {Value = v} end
})
BuildSwitchTab:Dropdown({Title = 'Default Build', Values = Tables.BuildList, Default = 'None',
    Callback = function(v) Options.DefaultBuild = v end
})
BuildSwitchTab:Dropdown({Title = 'Build [Mob]', Values = Tables.BuildList, Default = 'None',
    Callback = function(v) Options.Build_Mob = v end
})
BuildSwitchTab:Dropdown({Title = 'Build [Boss]', Values = Tables.BuildList, Default = 'None',
    Callback = function(v) Options.Build_Boss = v end
})
BuildSwitchTab:Dropdown({Title = 'Build [Boss HP%]', Values = Tables.BuildList, Default = 'None',
    Callback = function(v) Options.Build_BossHP = v end
})
BuildSwitchTab:Slider({Title = 'Change at Boss HP%', Value = {Min = 0, Max = 100, Default = 15},
    Callback = function(v) Options.Build_BossHPAmt = v end
})

local R_DungeonWaveVote = GetRemote(RS, 'Remotes.DungeonWaveVote')
local R_DungeonWaveReplay = RS:WaitForChild('Remotes', 5) and RS.Remotes:WaitForChild('DungeonWaveReplayVote', 5)
local R_SetAutoTowerReset = GetRemote(RS, 'RemoteEvents.SetAutoTowerReset')
Shared.InDungeonMode = false

function TryEnterPortal()
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if not root then return false end
    local portal = nil
    local portalPatterns = {'ActiveDungeonPortal', 'DungeonPortal', 'RaidPortal', 'TowerPortal', 'BossRushPortal'}
    for _, n in ipairs(portalPatterns) do portal = workspace:FindFirstChild(n); if portal then break end end
    if not portal then
        for _, obj in pairs(workspace:GetChildren()) do
            local n = obj.Name:lower()
            if n:find('portal') and (n:find('dungeon') or n:find('tower') or n:find('raid')) then portal = obj; break end
        end
    end
    if not portal then return false end
    local pivotCF = nil
    pcall(function() pivotCF = portal:GetPivot() end)
    if not pivotCF then
        local bp = portal:FindFirstChildOfClass('BasePart')
        if bp then pivotCF = bp.CFrame end
    end
    if pivotCF then
        root.CFrame = pivotCF * CFrame.new(0, 2, 0)
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.3)
    end
    local prompt = portal:FindFirstChildOfClass('ProximityPrompt', true) or portal:FindFirstChild('JoinPrompt', true)
    if prompt and Support.Proximity then fireproximityprompt(prompt); task.wait(1); return true end
    return false
end

function OpenDungeon(dungeonId, difficulty)
    if not Remotes.OpenDungeon then return false end
    pcall(function() Remotes.OpenDungeon:FireServer(tostring(dungeonId), tostring(difficulty)) end)
    task.wait(1.5)
    if R_DungeonWaveVote then
        pcall(function() R_DungeonWaveVote:FireServer(tostring(difficulty)) end)
        task.wait(0.3)
        pcall(function() R_DungeonWaveVote:FireServer('start') end)
        task.wait(0.3)
    end
    return true
end

function ReplayVote()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DungeonWaveReplayVote"):FireServer("sponsor")
    end)
end

function GetAllNPCTargets()
    local targets = {}
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA('Model') and npc ~= Plr.Character then
            local hum = npc:FindFirstChildOfClass('Humanoid')
            local root = npc:FindFirstChild('HumanoidRootPart')
            if hum and root and hum.Health > 0 then
                local isPlayer = false
                for _, p in pairs(Players:GetPlayers()) do if p.Character == npc then isPlayer = true; break end end
                if not isPlayer then table.insert(targets, npc) end
            end
        end
    end
    return targets
end

function AttackAllTargets()
    local targets = GetAllNPCTargets()
    if #targets == 0 then return false end
    local nameDict = {}
    for _, npc in ipairs(targets) do
        nameDict[npc.Name:gsub('%d+$', '')] = true
    end
    local best = GetBestMobCluster(nameDict) or targets[1]
    if not best then return false end
    local hum = best:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then return false end
    AttackTarget(best, GetNearestIsland(best:GetPivot().Position), 'Boss')
    return true
end

function Func_AutoDungeon()
    Shared.InDungeonMode = true

    local function StartRun()
        local dungeonId = Options.SelectedDungeonType or 'BossRush'
        local difficulty = Options.SelectedDungeonDiff or 'Easy'
        Remotes.TP_Portal:FireServer('Dungeon')
        task.wait(2.5)
        if Toggles.AutoSelectDungeonDiff and Toggles.AutoSelectDungeonDiff.Value and R_DungeonWaveVote then
            pcall(function() R_DungeonWaveVote:FireServer(tostring(difficulty)) end)
            task.wait(0.3)
        end
        OpenDungeon(dungeonId, difficulty)
        task.wait(2)
        TryEnterPortal()
        task.wait(2)
    end

    StartRun()

    while Toggles.AutoDungeon and Toggles.AutoDungeon.Value do
        task.wait(0.01)
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')
        if not char or not hum or hum.Health <= 0 then task.wait(0.5); continue end

        if not AttackAllTargets() and Toggles.AutoDungeonRetry and Toggles.AutoDungeonRetry.Value then
            local difficulty = Options.SelectedDungeonDiff or 'Easy'
            if Toggles.AutoSelectDungeonDiff and Toggles.AutoSelectDungeonDiff.Value and R_DungeonWaveVote then
                pcall(function() R_DungeonWaveVote:FireServer(tostring(difficulty)) end)
                task.wait(0.3)
            end
            ReplayVote()
            task.wait(3)
            if #GetAllNPCTargets() == 0 then StartRun() end
        end
    end

    Shared.InDungeonMode = false
end

function Func_AutoInfiniteTower()
    Shared.InDungeonMode = true
    if not Remotes.OpenDungeon then return end

    local function StartTower()
        local difficulty = Options.SelectedTowerDiff or 'Easy'
        Remotes.TP_Portal:FireServer('Dungeon')
        task.wait(2.5)
        pcall(function() Remotes.OpenDungeon:FireServer('InfiniteTower', tostring(difficulty)) end)
        task.wait(1.5)
        if R_DungeonWaveVote then
            if Toggles.AutoSelectTowerDiff and Toggles.AutoSelectTowerDiff.Value then
                pcall(function() R_DungeonWaveVote:FireServer(tostring(difficulty)) end)
                task.wait(0.3)
            end
            pcall(function() R_DungeonWaveVote:FireServer('start') end)
        end
        task.wait(2)
        TryEnterPortal()
        task.wait(2)
    end

    StartTower()

    while Toggles.AutoInfiniteTower and Toggles.AutoInfiniteTower.Value do
        task.wait(0.01)
        local difficulty = Options.SelectedTowerDiff or 'Easy'
        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')
        if not char or not hum or hum.Health <= 0 then task.wait(0.5); continue end

        if not AttackAllTargets() and Toggles.AutoTowerStart and Toggles.AutoTowerStart.Value then
            if Toggles.AutoSelectTowerDiff and Toggles.AutoSelectTowerDiff.Value and R_DungeonWaveVote then
                pcall(function() R_DungeonWaveVote:FireServer(tostring(difficulty)) end)
                task.wait(0.3)
            end
            ReplayVote()
            task.wait(2)

            if Toggles.AutoTowerReset and Toggles.AutoTowerReset.Value then
                local floorLimit = Options.TowerResetFloor or 50
                local currentFloor = 0
                pcall(function()
                    for _, gui in pairs(PGui:GetChildren()) do
                        for _, lbl in pairs(gui:GetDescendants()) do
                            if lbl:IsA('TextLabel') then
                                local f = tonumber(lbl.Text:match('Floor%s*(%d+)') or (lbl.Text:match('^(%d+)$') and lbl.Text))
                                if f and f > currentFloor then currentFloor = f end
                            end
                        end
                    end
                end)

                if currentFloor >= floorLimit then
                    StartTower()
                end
            end
        end
    end

    Shared.InDungeonMode = false
end

function Func_ManualDungeonJoin()
    local id = Options.SelectedDungeonType or 'BossRush'
    local diff = Options.SelectedDungeonDiff or 'Easy'
    Remotes.TP_Portal:FireServer('Dungeon')
    task.delay(2.5, function() OpenDungeon(id, diff); task.delay(2, TryEnterPortal) end)
end

function Func_ManualInfiniteTowerStart()
    local diff = Options.SelectedTowerDiff or 'Easy'
    Remotes.TP_Portal:FireServer('Dungeon')
    task.delay(2.5, function()
        pcall(function() Remotes.OpenDungeon:FireServer('InfiniteTower', tostring(diff)) end)
        task.delay(1.5, function()
            local R_DungeonWaveVote = GetRemote(RS, 'Remotes.DungeonWaveVote')
            if R_DungeonWaveVote then
                pcall(function() R_DungeonWaveVote:FireServer(tostring(diff)) end)
                task.wait(0.3)
                pcall(function() R_DungeonWaveVote:FireServer('start') end)
            end
            task.delay(1.5, TryEnterPortal)
        end)
    end)
end

--Window:Divider() -- Section: 'Dungeon'
local DungeonTab = window:Tab({Title = 'Dungeon', Icon = 'rbxassetid://135478075951994'})

DungeonTab:Section({Title = 'Setup'})
DungeonTab:Dropdown({Title = 'Raid Selection', Values = {'BossRush', 'CidDungeon', 'RuneDungeon', 'DoubleDungeon'}, Default = 'BossRush',
    Callback = function(v) Options.SelectedDungeonType = v end
})
Options.SelectedDungeonType = 'BossRush'
DungeonTab:Dropdown({Title = 'Difficulty', Values = {'Easy', 'Medium', 'Hard', 'Extreme'}, Default = 'Easy',
    Callback = function(v) Options.SelectedDungeonDiff = v end
})
Options.SelectedDungeonDiff = 'Easy'
DungeonTab:Section({Title = 'Options'})
DungeonTab:Toggle({Title = 'Auto Select Difficulty', Default = true,
    Callback = function(v) Toggles.AutoSelectDungeonDiff = {Value = v} end
})
Toggles.AutoSelectDungeonDiff = {Value = true}
DungeonTab:Toggle({Title = 'Auto Retry', Default = true,
    Callback = function(v) Toggles.AutoDungeonRetry = {Value = v} end
})
Toggles.AutoDungeonRetry = {Value = true}
DungeonTab:Section({Title = 'Controls'})
DungeonTab:Button({Title = 'Manual Join',
    Callback = function() task.spawn(Func_ManualDungeonJoin) end
})
DungeonTab:Toggle({Title = 'Auto Dungeon', Default = false,
    Callback = function(v)
        Toggles.AutoDungeon = {Value = v}
        Thread('Dungeon.AutoDungeon', SafeLoop('Auto Dungeon', Func_AutoDungeon), v)
    end
})

local InfTowerTab = window:Tab({Title = 'Infinite Tower', Icon = 'rbxassetid://109405442311334'})

Options.SelectedTowerDiff = 'Easy'
InfTowerTab:Section({Title = 'Options'})
InfTowerTab:Toggle({Title = 'Auto Select Difficulty', Default = true,
    Callback = function(v) Toggles.AutoSelectTowerDiff = {Value = v} end
})
Toggles.AutoSelectTowerDiff = {Value = true}
InfTowerTab:Toggle({Title = 'Auto Start Next Wave', Default = true,
    Callback = function(v) Toggles.AutoTowerStart = {Value = v} end
})
Toggles.AutoTowerStart = {Value = true}
InfTowerTab:Section({Title = 'Auto Restart'})
InfTowerTab:Slider({Title = 'Restart After Floor #', Value = {Min = 1, Max = 200, Default = 50},
    Callback = function(v) Options.TowerResetFloor = v end
})
Options.TowerResetFloor = 50
InfTowerTab:Toggle({Title = 'Auto Restart at Floor Limit', Default = false,
    Callback = function(v)
        Toggles.AutoTowerReset = {Value = v}
        if v then pcall(function() if R_SetAutoTowerReset then R_SetAutoTowerReset:FireServer(Options.TowerResetFloor or 50) end end)
        else pcall(function() if R_SetAutoTowerReset then R_SetAutoTowerReset:FireServer(0) end end) end
    end
})
InfTowerTab:Section({Title = 'Controls'})
InfTowerTab:Button({Title = 'Manual Start Tower',
    Callback = function() task.spawn(Func_ManualInfiniteTowerStart) end
})
InfTowerTab:Toggle({Title = 'Auto Infinite Tower', Default = false,
    Callback = function(v)
        Toggles.AutoInfiniteTower = {Value = v}
        Thread('Tower.AutoInfiniteTower', SafeLoop('Auto Infinite Tower', Func_AutoInfiniteTower), v)
    end
})

--Window:Divider() -- Section: 'Automatic'

local ChestCraftTab = window:Tab({Title = 'Merchant & Chest', Icon = 'rbxassetid://11155851001'})
 
local MerchantTimerLabel = ChestCraftTab:Paragraph({
    Title = 'Merchant',
    Desc = 'Refresh: N/A'
})

ChestCraftTab:Section({Title = 'Auto Merchant'})
ChestCraftTab:Dropdown({
    Title = 'Select Merchant Item(s)',
    Values = Tables.MerchantList,
    Default = {},
    Multi = true,
    Callback = function(v)
        Options.SelectedMerchantItems = ToSet(v)
    end
})
ChestCraftTab:Toggle({
    Title = 'Auto Buy Merchant',
    Default = false,
    Callback = function(v)
        Toggles.AutoMerchant = {Value = v}
        Shared.MerchantBusy = v
        Thread('AutoMerchant', SafeLoop('Merchant', Func_AutoMerchant), v)
    end
})

function FormatSecondsToTimer(s)
    return string.format('Refresh: %02d:%02d', math.floor(s / 60), s % 60)
end

function Func_AutoMerchant()
    local MerchUI = PGui:WaitForChild('MerchantUI')
    local Holder = MerchUI:FindFirstChild('Holder', true)
    local LastTimerText = ''

    function StartPurchaseSequence()
        if Shared.MerchantExecute then return end
        Shared.MerchantExecute = true
        if Shared.FirstMerchantSync then
            MerchUI.Enabled = true
            MerchUI.MainFrame.Visible = true
            task.wait(0.5)
            local close = MerchUI:FindFirstChild('CloseButton', true)
            if close then gsc(close); task.wait(1.8) end
        end
        OpenMerchantInterface()
        task.wait(2)

        local withStock = {}
        for _, child in pairs(Holder:GetChildren()) do
            if child:IsA('Frame') and child.Name ~= 'Item' then
                local lbl = child:FindFirstChild('StockAmountForThatItem', true)
                local stock = lbl and tonumber(lbl.Text:match('%d+')) or 0
                Shared.CurrentStock[child.Name] = stock
                if stock > 0 then
                    table.insert(withStock, {Name = child.Name, Stock = stock})
                end
            end
        end

        local sel = Options.SelectedMerchantItems or {}
        for _, item in ipairs(withStock) do
            if sel[item.Name] then
                pcall(function()
                    Remotes.MerchantBuy:InvokeServer(item.Name, 99)
                end)
                task.wait(math.random(11, 17) / 10)
            end
        end

        if MerchUI.MainFrame then
            MerchUI.MainFrame.Visible = false
        end

        Shared.FirstMerchantSync = true
        Shared.MerchantExecute = false
    end

    function SyncClock()
        OpenMerchantInterface()
        task.wait(1)

        local lbl = MerchUI:FindFirstChild('RefreshTimerLabel', true)
        if lbl and lbl.Text:find(':') then
            local s = GetSecondsFromTimer(lbl.Text)
            if s then
                Shared.LocalMerchantTime = s
            end
        end

        if MerchUI.MainFrame then
            MerchUI.MainFrame.Visible = false
        end
    end

    SyncClock()

    while Toggles.AutoMerchant and Toggles.AutoMerchant.Value do
        local lbl = MerchUI:FindFirstChild('RefreshTimerLabel', true)

        if lbl and lbl.Text ~= '' then
            local s = GetSecondsFromTimer(lbl.Text)
            if s then
                Shared.LocalMerchantTime = s
                if lbl.Text ~= LastTimerText then
                    LastTimerText = lbl.Text
                    Shared.LastTimerTick = tick()
                end
            else
                Shared.LocalMerchantTime = math.max(0, Shared.LocalMerchantTime - 1)
            end
        else
            Shared.LocalMerchantTime = math.max(0, Shared.LocalMerchantTime - 1)
        end

        -- ✅ ADD THIS LINE (updates UI every loop)
        MerchantTimerLabel:SetDesc(FormatSecondsToTimer(Shared.LocalMerchantTime))

        if not Shared.FirstMerchantSync or Shared.LocalMerchantTime <= 1 or Shared.LocalMerchantTime >= 1799 then
            task.spawn(StartPurchaseSequence)
        end

        if tick() - Shared.LastTimerTick > 30 then
            task.spawn(SyncClock)
            Shared.LastTimerTick = tick()
        end

        task.wait(1)
    end
end

ChestCraftTab:Section({Title = 'Auto Open Chests'})
ChestCraftTab:Dropdown({Title = 'Select Chest(s)', Values = Tables.Rarities, Default = '', Multi = true,
    Callback = function(v) Options.SelectedChests = ToSet(v) end
})
ChestCraftTab:Toggle({Title = 'Auto Open Chest', Default = false,
    Callback = function(v) Toggles.AutoChest = {Value = v}; Thread('AutoChest', SafeLoop('Chest', Func_AutoChest), v) end
})
ChestCraftTab:Section({Title = 'Auto Craft'})
ChestCraftTab:Dropdown({Title = 'Select Item(s) to Craft', Values = Tables.CraftItemList, Default = '', Multi = true,
    Callback = function(v) Options.SelectedCraftItems = ToSet(v) end
})
ChestCraftTab:Toggle({Title = 'Auto Craft Item', Default = false,
    Callback = function(v) Toggles.AutoCraftItem = {Value = v}; Thread('AutoCraft', SafeLoop('Craft', Func_AutoCraft), v) end
})

local abilitises = window:Tab({Title = "Haki's", Icon = 'rbxassetid://140412115668246'})

function GetHakiLevels()
    local gui = game:GetService("Players").LocalPlayer.PlayerGui
    local arm = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.HakiProgressionFrame.Txts.HakiLevel.Text
    local obs = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text
    local conq = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ConquerorHakiProgressionFrame.Txts.ConquerorHakiLevel.Text
    return arm, obs, conq
end

function GetLevelNumber(txt)
    local num = tonumber(txt:match("%d+"))
    return num or 0
end

function Func_AutoArmHaki()
    local arm = GetHakiLevels()
    local armLv = GetLevelNumber(arm)
    if armLv >= 100 then fnl:MakeNotification({Title = "Armament", Description = "Already unlocked / high level", Duration = 2}); return end
    fnl:MakeNotification({Title = "Armament", Description = "Starting", Duration = 2})
    Remotes.QuestAccept:FireServer("HakiQuestNPC")
    while Toggles.AutoArmHaki do
        task.wait()
        local target = GetBestMobCluster({["Thief"] = true})
        if target then
            ExecuteFarmLogic(target, GetNearestIsland(target:GetPivot().Position), "Mob")
            Remotes.M1:FireServer()
            if IsSkillReady("Z") then Remotes.UseSkill:FireServer(1) end
        end
    end
end

function Func_AutoObsHaki()
    local gui = game:GetService("Players").LocalPlayer.PlayerGui
    local obs = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text
    local obsLv = tonumber(obs:match("%d+")) or 0
    if obsLv > 0 then fnl:MakeNotification({Title = "Observation", Description = "Already unlocked", Duration = 2}); return end
    local plr = game.Players.LocalPlayer
    local money = plr.Data.Money.Value
    local gems = plr.Data.Gems.Value
    if money < 250000 or gems < 300 then
        fnl:MakeNotification({Title = "Observation", Description = "Not enough Money/Gems", Duration = 2}); return
    end
    fnl:MakeNotification({Title = "Observation", Description = "Purchasing...", Duration = 2})
    pcall(function() Remotes.QuestAccept:FireServer("ObservationHakiNPC") end)
end

function Func_AutoGetConquerorHaki()
    function Notify(msg)
        fnl:MakeNotification({Title = 'Conqueror Haki', Description = msg, Duration = 5})
    end

    local gui = Plr.PlayerGui
    local armLv, obsLv, conqLv = 0, 0, 0
    pcall(function()
        armLv  = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.HakiProgressionFrame.Txts.HakiLevel.Text:match('%d+')) or 0
        obsLv  = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text:match('%d+')) or 0
        conqLv = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ConquerorHakiProgressionFrame.Txts.ConquerorHakiLevel.Text:match('%d+')) or 0
    end)

    if conqLv > 0 then
        Notify('Conqueror Haki already unlocked! Level: ' .. conqLv)
        if Toggles.AutoGetConquerorHaki then Toggles.AutoGetConquerorHaki.Value = false end
        return
    end

    local missing = {}
    if armLv < 40 then table.insert(missing, 'Armament Haki Lv40 (have: ' .. armLv .. ')') end
    if obsLv < 25 then table.insert(missing, 'Observation Haki Lv25 (have: ' .. obsLv .. ')') end

    local hasFragment = false
    if Shared.Cached_Inv then
        for _, item in pairs(Shared.Cached_Inv) do
            if item.name and item.name:lower():find('conqueror') and item.name:lower():find('fragment') then
                hasFragment = true
                break
            end
        end
    end
    if not hasFragment then table.insert(missing, 'Conqueror Fragment (farm from tanky high-level NPCs)') end

    if #missing > 0 then
        Notify('Missing requirements:\n' .. table.concat(missing, '\n'))
        if Toggles.AutoGetConquerorHaki then Toggles.AutoGetConquerorHaki.Value = false end
        return
    end

    Notify('All requirements met! Accepting Conqueror Haki quest...\nTeleporting to Shibuya...')
    Remotes.TP_Portal:FireServer('Shibuya')
    task.wait(2.5)

    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('QuestAccept'):FireServer('ConquerorHakiNPC')
    end)
    task.wait(1.5)

    function GetConqQuestProgress()
        local cur, max = 0, 0
        local QuestUI = PGui:FindFirstChild('QuestUI')
        if not QuestUI then return cur, max end
        for _, lbl in pairs(QuestUI:GetDescendants()) do
            if lbl:IsA('TextLabel') and lbl.Text ~= '' then
                local c, m = lbl.Text:match('(%d+)%s*/%s*(%d+)')
                if c and m then
                    cur = tonumber(c) or 0
                    max = tonumber(m) or 0
                    if max > 0 then break end
                end
            end
        end
        return cur, max
    end

    function GetConqQuestTitle()
        local QuestUI = PGui:FindFirstChild('QuestUI')
        if not QuestUI then return '' end
        local best = ''
        for _, v in pairs(QuestUI:GetDescendants()) do
            if v:IsA('TextLabel') and v.Text ~= '' then
                local t = v.Text
                if t:match('^%d+/?%d*$') then continue end
                if t:find('?', 1, true) then continue end
                if #t < 4 then continue end
                if #t > #best then best = t end
            end
        end
        return best:lower()
    end

    function IsQuestVisible()
        local QuestUI = PGui:FindFirstChild('QuestUI')
        if not QuestUI then return false end
        local quest = QuestUI:FindFirstChild('Quest')
        if quest then
            local inner = quest:FindFirstChild('Quest', true)
            if inner then return inner.Visible end
        end
        return GetConqQuestTitle() ~= ''
    end

    function IsDone()
        local c, m = GetConqQuestProgress()
        return m > 0 and c >= m
    end

    local waitT = tick()
    while not IsQuestVisible() and tick() - waitT < 5 do
        task.wait(0.2)
    end

    if not IsQuestVisible() then
        Notify('Failed to accept quest. Make sure you are at Conqueror Haki NPC in Shibuya!')
        if Toggles.AutoGetConquerorHaki then Toggles.AutoGetConquerorHaki.Value = false end
        return
    end

    Notify('Quest accepted! Starting automation...')
    local lastNotif = 0
    local R_DungeonWaveVote = GetRemote(RS, 'Remotes.DungeonWaveVote')

    while Toggles.AutoGetConquerorHaki and Toggles.AutoGetConquerorHaki.Value do
        task.wait(0.1)

        if not IsQuestVisible() then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('QuestAccept'):FireServer('ConquerorHakiNPC')
            end)
            task.wait(1.5)

            pcall(function()
                conqLv = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ConquerorHakiProgressionFrame.Txts.ConquerorHakiLevel.Text:match('%d+')) or 0
            end)
            if conqLv > 0 then
                Notify('Conqueror Haki Unlocked! Level: ' .. conqLv)
                if Toggles.AutoGetConquerorHaki then Toggles.AutoGetConquerorHaki.Value = false end
                break
            end
            continue
        end

        local title = GetConqQuestTitle()
        local cur, max = GetConqQuestProgress()
        cur = tonumber(cur) or 0
        max = tonumber(max) or 0

        if tick() - lastNotif >= 8 then
            Notify('Quest: ' .. title .. '\nProgress: ' .. cur .. '/' .. max)
            lastNotif = tick()
        end

        if title:find('500') and (title:find('dodge') or title:find('observation') or title:find('obs')) then
           if IsDone() then
                Shared._ConqQ2SkillFired = nil
                Notify('Quest 2 Done! (500 dodges)')
                task.wait(1)
                continue
            end

            if not CheckObsHaki() then
                pcall(function()
                    Remotes.ObserHaki:FireServer('Toggle')
                end)
                task.wait(1)
            end

            local bestTarget = nil
            local highestHP = 0

            for _, npc in pairs(PATH.Mobs:GetChildren()) do
                if npc:IsA('Model') then
                    local hum = npc:FindFirstChildOfClass('Humanoid')
                    local npcRoot = npc:FindFirstChild('HumanoidRootPart')
                    local isDummy = npc.Name:lower():find('dummy') or npc.Name:lower():find('training')
                    if hum and hum.Health > 0 and npcRoot and not isDummy then
                        if hum.MaxHealth > highestHP then
                            highestHP = hum.MaxHealth
                            bestTarget = npc
                        end
                    end
                end
            end

            if bestTarget then
                local tRoot = bestTarget:FindFirstChild('HumanoidRootPart')
                local char = GetCharacter()
                local root = char and char:FindFirstChild('HumanoidRootPart')

                if root and tRoot then
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 4)
                    root.AssemblyLinearVelocity = Vector3.zero
                    task.wait(0.3)

                    EquipWeapon()
                    task.wait(0.2)

                    if not Shared._ConqQ2SkillFired then
                        EquipWeapon()
                        task.wait(0.2)
                        local char2 = GetCharacter()
                        local tool = char2 and char2:FindFirstChildOfClass('Tool')
                        if tool then
                            local toolType = GetToolTypeFromModule(tool.Name)
                            pcall(function()
                                if toolType == 'Power' then
                                    Remotes.UseFruit:FireServer('UseAbility', {
                                        FruitPower = tool.Name:gsub(' Fruit', ''),
                                        KeyCode = Enum.KeyCode.Z
                                    })
                                else
                                    Remotes.UseSkill:FireServer(1)
                                end
                            end)
                        end
                        Shared._ConqQ2SkillFired = true
                    end

                    task.wait(1)
                end
            else
                Notify('Quest 2: No NPCs found, waiting...')
                task.wait(2)
            end

        elseif title:find('500') and (title:find('kill') or title:find('npc') or title:find('armament') or title:find('haki')) and not title:find('boss') then
            if IsDone() then Notify('Quest 1 Done! (500 NPC kills)') task.wait(1) continue end

            if not CheckArmHaki() then
                pcall(function()
                    Remotes.ArmHaki:FireServer('Toggle')
                end)
                task.wait(0.5)
            end

            local target = nil
            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            if root then
                local radius = Options.MobFarmRadius or 500
                local closest, minDist = nil, math.huge
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
                        local isDummy = npc.Name:lower():find('dummy') or npc.Name:lower():find('training')
                        local isBoss = npc.Name:find('Boss') and not table.find(Tables.MiniBossList, npc.Name)
                        if not isDummy and not isBoss and IsValidTarget(npc) then
                            local npcRoot = npc:FindFirstChild('HumanoidRootPart')
                            if npcRoot then
                                local dist = (root.Position - npcRoot.Position).Magnitude
                                if dist <= radius and dist < minDist then
                                    closest = npc
                                    minDist = dist
                                end
                            end
                        end
                    end
                end
                target = closest
            end

            if not target then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if npc:IsA('Model') then
                        local hum = npc:FindFirstChildOfClass('Humanoid')
                        local npcRoot = npc:FindFirstChild('HumanoidRootPart')
                        local isDummy = npc.Name:lower():find('dummy') or npc.Name:lower():find('training')
                        local isBoss = npc.Name:find('Boss') and not table.find(Tables.MiniBossList, npc.Name)
                        if hum and hum.Health > 0 and npcRoot and not isDummy and not isBoss then
                            target = npc
                            break
                        end
                    end
                end
            end

            if not target then
                Notify('Quest 1: No mobs found, teleporting to Starter...')
                Remotes.TP_Portal:FireServer('Starter')
                task.wait(2.5)
                continue
            end

            ExecuteFarmLogic(target, GetNearestIsland(target:GetPivot().Position), 'Mob')
            EquipWeapon()
            pcall(function() Remotes.M1:FireServer() end)
            Shared.LastM1 = time()

        elseif title:find('200') and title:find('boss') then
            if IsDone() then Notify('Quest 3 Done! (200 bosses)') task.wait(1) continue end

            local target, island = GetWorldBossTarget()
            if target then
                ExecuteFarmLogic(target, island or 'Boss', 'Boss')
                EquipWeapon()
                for i = 1, 3 do
                    pcall(function() Remotes.M1:FireServer() end)
                    Shared.LastM1 = time()
                    task.wait(0.04)
                end
            else
                Remotes.TP_Portal:FireServer('Boss')
                task.wait(1.5)
                pcall(function() Remotes.SummonBoss:FireServer('ThiefBoss', 'Normal') end)
                task.wait(2)
            end

        elseif title:find('25') and (title:find('dungeon') or title:find('raid') or title:find('complete')) then
            if IsDone() then
                Notify('All quests done! Conqueror Haki unlocked!')
                if Toggles.AutoGetConquerorHaki then Toggles.AutoGetConquerorHaki.Value = false end
                break
            end

            Notify('Quest 4: Running dungeons (' .. cur .. '/25)...')
            Remotes.TP_Portal:FireServer('Dungeon')
            task.wait(2.5)

            pcall(function() Remotes.OpenDungeon:FireServer('BossRush', 'Easy') end)
            task.wait(1.5)
            if R_DungeonWaveVote then
                pcall(function() R_DungeonWaveVote:FireServer('Easy') end)
                task.wait(0.3)
                pcall(function() R_DungeonWaveVote:FireServer('start') end)
                task.wait(0.3)
            end
            task.wait(1.5)

            local portal = nil
            for _, n in ipairs({'ActiveDungeonPortal','DungeonPortal','BossRushPortal'}) do
                portal = workspace:FindFirstChild(n)
                if portal then break end
            end
            if portal and Support.Proximity then
                local char = GetCharacter()
                local root = char and char:FindFirstChild('HumanoidRootPart')
                if root then
                    local pCF = nil
                    pcall(function() pCF = portal:GetPivot() end)
                    if pCF then
                        root.CFrame = pCF * CFrame.new(0, 2, 0)
                        root.AssemblyLinearVelocity = Vector3.zero
                        task.wait(0.3)
                    end
                    local prompt = portal:FindFirstChildOfClass('ProximityPrompt', true)
                    if prompt then fireproximityprompt(prompt) end
                end
            end
            task.wait(2)

            local dungeonTimer = tick()
            while tick() - dungeonTimer < 90 and Toggles.AutoGetConquerorHaki and Toggles.AutoGetConquerorHaki.Value do
                task.wait(0.1)
                local hasEnemies = false
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if npc:IsA('Model') then
                        local hum = npc:FindFirstChildOfClass('Humanoid')
                        if hum and hum.Health > 0 then
                            hasEnemies = true
                            Shared.Target = npc
                            Shared.TargetValid = true
                            local char = GetCharacter()
                            local root = char and char:FindFirstChild('HumanoidRootPart')
                            local nRoot = npc:FindFirstChild('HumanoidRootPart')
                            if root and nRoot then
                                root.CFrame = nRoot.CFrame * CFrame.new(0, 0, 3)
                                root.AssemblyLinearVelocity = Vector3.zero
                            end
                            EquipWeapon()
                            if Toggles.InstaKill and Toggles.InstaKill.Value then
                                pcall(function() hum.Health = 0 end)
                            end
                            for i = 1, 5 do
                                local h2 = npc:FindFirstChildOfClass('Humanoid')
                                if not h2 or h2.Health <= 0 then break end
                                pcall(function() Remotes.M1:FireServer() end)
                                Shared.LastM1 = time()
                                task.wait(0.04)
                            end
                        end
                    end
                end
                if not hasEnemies then break end
            end
            task.wait(1)

        else
            Notify('Unknown stage: "' .. title .. '"\nProgress: ' .. cur .. '/' .. max .. '\nFarming nearby mobs...')
            local t = GetNearestMobTarget()
            if t then
                ExecuteFarmLogic(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
                EquipWeapon()
                pcall(function() Remotes.M1:FireServer() end)
            end
            task.wait(2)
        end
    end
end

abilitises:Toggle({Title = "Auto Armament Haki", Default = false,
    Callback = function(v)
        Toggles.AutoArmHaki = v
        if v then task.spawn(Func_AutoArmHaki) end
    end
})

abilitises:Toggle({Title = "Auto Observation Haki", Default = false,
    Callback = function(v)
        Toggles.AutoObsHaki = v
        if v then task.spawn(Func_AutoObsHaki) end
    end
})

abilitises:Toggle({
    Title = 'Auto Get Conqueror Haki (Full)',
    Default = false,
    Callback = function(v)
        Toggles.AutoGetConquerorHaki = {Value = v}
        Thread('AutoGetConquerorHaki', SafeLoop('Auto Get Conqueror Haki', Func_AutoGetConquerorHaki), v)
    end
})

local fightingstyle = window:Tab({Title = 'Fighting Style', Icon = 'rbxassetid://132019673062808'})

function GetItemQty(itemName)
    if not Shared.Cached_Inv then return 0 end
    local qty = 0
    for _, item in pairs(Shared.Cached_Inv) do
        if item.name == itemName then
            qty = qty + (item.quantity or 1)
        end
    end
    return qty
end

function FindBossByKeyword(keyword)
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc.Name:lower():find(keyword:lower()) then
            local hum = npc:FindFirstChildOfClass('Humanoid')
            if hum and hum.Health > 0 then
                return npc
            end
        end
    end
    return nil
end

function FireQuestSkills(isBoss)
    local keys = isBoss
        and {{key='Z',slot=1},{key='X',slot=2},{key='C',slot=3},{key='V',slot=4},{key='F',slot=5}}
        or  {{key='Z',slot=1},{key='X',slot=2},{key='C',slot=3},{key='V',slot=4}}
    local char = GetCharacter()
    local tool = char and char:FindFirstChildOfClass('Tool')
    if not tool then return end
    local toolType = GetToolTypeFromModule(tool.Name)
    for _, keyData in ipairs(keys) do
        if IsSkillReady(keyData.key) then
            pcall(function()
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {
                        FruitPower = tool.Name:gsub(' Fruit', ''),
                        KeyCode = ({Z=Enum.KeyCode.Z,X=Enum.KeyCode.X,C=Enum.KeyCode.C,V=Enum.KeyCode.V,F=Enum.KeyCode.F})[keyData.key]
                    })
                else
                    Remotes.UseSkill:FireServer(keyData.slot)
                end
            end)
            task.wait(0.1)
        end
    end
end

function GetQuestProgressUI()
    local cur, max = 0, 0
    local QuestUI = PGui:FindFirstChild('QuestUI')
    if QuestUI then
        for _, lbl in pairs(QuestUI:GetDescendants()) do
            if lbl:IsA('TextLabel') and lbl.Text ~= '' then
                local c, m = lbl.Text:match('(%d+)/(%d+)')
                if c and m then
                    cur = tonumber(c) or 0
                    max = tonumber(m) or 0
                    break
                end
            end
        end
    end
    return cur, max
end

function SafeTPToPos(x, y, z)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    if not root then return end
    root.CFrame = CFrame.new(x, y, z)
    root.AssemblyLinearVelocity = Vector3.zero
end

function Func_AutoGojoGetItems()
    local GojoNeeds = {
        {name = 'Void Fragment',  need = 6},
        {name = 'Limitless Ring', need = 3},
        {name = 'Infinity Core',  need = 1}
    }
    function GojoMaterialsDone()
        for _, item in ipairs(GojoNeeds) do
            if GetItemQty(item.name) < item.need then return false end
        end
        return true
    end
    if GojoMaterialsDone() then
        fnl:MakeNotification({Title='Gojo Items', Description='Already have all materials!', Duration=4})
        if Toggles.AutoGojoGetItems then Toggles.AutoGojoGetItems.Value = false end
        return
    end
    fnl:MakeNotification({Title='Gojo Items', Description='Farming GojoBoss for:\n6x Void Fragment | 3x Limitless Ring | 1x Infinity Core', Duration=5})
    local lastNotif = 0
    while Toggles.AutoGojoGetItems and Toggles.AutoGojoGetItems.Value and not GojoMaterialsDone() do
        task.wait(0.05)
        if tick() - lastNotif >= 5 then
            fnl:MakeNotification({Title='Gojo - Farming', Description='Void Fragment: '..GetItemQty('Void Fragment')..'/6\nLimitless Ring: '..GetItemQty('Limitless Ring')..'/3\nInfinity Core: '..GetItemQty('Infinity Core')..'/1', Duration=4})
            lastNotif = tick()
        end
        local boss = GetBestMobCluster({['GojoBoss'] = true})
        if boss then
            AttackTarget(boss, 'Shibuya', 'Boss')
        else
            SafeTeleportToNPC('GojoMovesetNPC')
            task.wait(3)
        end
    end
    if GojoMaterialsDone() then
        fnl:MakeNotification({Title='Gojo Items', Description='All materials collected!', Duration=5})
    end
    if Toggles.AutoGojoGetItems then Toggles.AutoGojoGetItems.Value = false end
end

function Func_AutoGojoQuest()
    EquipWeapon()
    task.wait(0.5)
    local QuestUI    = PGui:WaitForChild('QuestUI')
    local QuestFrame = QuestUI:WaitForChild('Quest'):WaitForChild('Quest')
    local QuestInfo  = QuestFrame:WaitForChild('Holder'):WaitForChild('Content'):WaitForChild('QuestInfo')
    local QuestTitle = QuestInfo:WaitForChild('QuestTitle'):WaitForChild('QuestTitle')
    local QuestDesc  = QuestInfo:WaitForChild('QuestDescription')
    local lastBossHP = math.huge
    function GetTitle()  return QuestTitle and QuestTitle.Text or '' end
    function GetDesc()   return QuestDesc  and QuestDesc.Text  or '' end
    function IsVisible() return QuestFrame and QuestFrame.Visible end
    function IsDone()
        local c, m = GetQuestProgressUI()
        c = tonumber(c) or 0; m = tonumber(m) or 0
        return m > 0 and c >= m
    end
    function WaitAtSpawn() SafeTeleportToNPC('GojoMovesetNPC'); task.wait(3) end
    Remotes.QuestAbandon:FireServer()
    task.wait(0.5)
    Remotes.QuestAccept:FireServer('GojoMovesetNPC')
    task.wait(1.5)
    fnl:MakeNotification({Title='Gojo Quest', Description='Quest started!', Duration=3})
    while Toggles.AutoGojoQuest and Toggles.AutoGojoQuest.Value do
        task.wait(0.05)
        if not IsVisible() then
            Remotes.QuestAbandon:FireServer(); task.wait(0.5)
            Remotes.QuestAccept:FireServer('GojoMovesetNPC'); task.wait(1.5)
            continue
        end
        local titleLow = GetTitle():lower()
        local descLow  = GetDesc():lower()
        local cur, max = GetQuestProgressUI()
        cur = tonumber(cur) or 0; max = tonumber(max) or 0
        if (titleLow:find('training 1') or descLow:find('kill')) and not descLow:find('boss') then
            if IsDone() then fnl:MakeNotification({Title='Gojo Quest', Description='Stage 1 done!', Duration=3}); task.wait(1); continue end
            local t = GetNearestMobTarget()
            if not t then WaitAtSpawn(); continue end
            AttackTarget(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
        elseif descLow:find('ability') or descLow:find('use') or titleLow:find('training 2') then
            if IsDone() then fnl:MakeNotification({Title='Gojo Quest', Description='Stage 2 done!', Duration=3}); task.wait(1); continue end
            local t = GetNearestMobTarget()
            if not t then WaitAtSpawn(); continue end
            AttackTarget(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
        elseif descLow:find('gojo') or descLow:find('boss') or titleLow:find('training 3') then
            if IsDone() then
                fnl:MakeNotification({Title='Gojo Quest', Description='All stages done! Buy Gojo style.', Duration=8})
                if Toggles.AutoGojoQuest then Toggles.AutoGojoQuest.Value = false end
                break
            end
            local boss = GetBestMobCluster({['GojoBoss'] = true})
            if boss then
                local hum = boss:FindFirstChildOfClass('Humanoid')
                local curHP = hum and hum.Health or 0
                if curHP <= 0 and lastBossHP > 0 then
                    fnl:MakeNotification({Title='Gojo Quest', Description='Boss killed! '..cur..'/'..max, Duration=3})
                    lastBossHP = math.huge; task.wait(2); continue
                end
                lastBossHP = curHP
                AttackTarget(boss, 'Shibuya', 'Boss')
            else
                lastBossHP = math.huge
                fnl:MakeNotification({Title='Gojo Quest', Description='Waiting for GojoBoss... ('..cur..'/'..max..')', Duration=4})
                WaitAtSpawn()
            end
        else
            fnl:MakeNotification({Title='Gojo Quest', Description='Unknown stage: '..GetTitle()..'\n'..GetDesc(), Duration=4})
            task.wait(2)
        end
    end
end

function Func_AutoSukunaGetItems()
    local SukunaNeeds = {
        {name = 'Cursed Finger',  need = 6},
        {name = 'Dismantle Fang', need = 3},
        {name = 'Crimson Heart',  need = 1}
    }
    function SukunaMaterialsDone()
        for _, item in ipairs(SukunaNeeds) do
            if GetItemQty(item.name) < item.need then return false end
        end
        return true
    end
    if SukunaMaterialsDone() then
        fnl:MakeNotification({Title='Sukuna Items', Description='Already have all materials!', Duration=4})
        if Toggles.AutoSukunaGetItems then Toggles.AutoSukunaGetItems.Value = false end
        return
    end
    fnl:MakeNotification({Title='Sukuna Items', Description='Farming SukunaBoss for:\n6x Cursed Finger | 3x Dismantle Fang | 1x Crimson Heart', Duration=5})
    local lastNotif = 0
    while Toggles.AutoSukunaGetItems and Toggles.AutoSukunaGetItems.Value and not SukunaMaterialsDone() do
        task.wait(0.05)
        if tick() - lastNotif >= 5 then
            fnl:MakeNotification({Title='Sukuna - Farming', Description='Cursed Finger: '..GetItemQty('Cursed Finger')..'/6\nDismantle Fang: '..GetItemQty('Dismantle Fang')..'/3\nCrimson Heart: '..GetItemQty('Crimson Heart')..'/1', Duration=4})
            lastNotif = tick()
        end
        local boss = GetBestMobCluster({['SukunaBoss'] = true})
        if boss then
            AttackTarget(boss, 'Shibuya', 'Boss')
        else
            SafeTeleportToNPC('SukunaMovesetNPC'); task.wait(3)
        end
    end
    if SukunaMaterialsDone() then fnl:MakeNotification({Title='Sukuna Items', Description='All materials collected!', Duration=5}) end
    if Toggles.AutoSukunaGetItems then Toggles.AutoSukunaGetItems.Value = false end
end

function Func_AutoSukunaQuest()
    local wasInstaKill   = Toggles.InstaKill and Toggles.InstaKill.Value
    local wasInstaKillHP = Options.InstaKillMinHP
    Toggles.InstaKill = {Value = false}; Options.InstaKillMinHP = 0
    function RestoreState() Toggles.InstaKill = {Value = wasInstaKill}; Options.InstaKillMinHP = wasInstaKillHP end
    function WaitAtSpawn() SafeTeleportToNPC('SukunaMovesetNPC'); task.wait(3) end
    EquipWeapon(); task.wait(0.5)
    local QuestUI    = PGui:WaitForChild('QuestUI')
    local QuestFrame = QuestUI:WaitForChild('Quest'):WaitForChild('Quest')
    local QuestInfo  = QuestFrame:WaitForChild('Holder'):WaitForChild('Content'):WaitForChild('QuestInfo')
    local QuestTitle = QuestInfo:WaitForChild('QuestTitle'):WaitForChild('QuestTitle')
    local QuestDesc  = QuestInfo:WaitForChild('QuestDescription')
    local lastBossHP = math.huge
    function GetTitle()  return QuestTitle and QuestTitle.Text or '' end
    function GetDesc()   return QuestDesc  and QuestDesc.Text  or '' end
    function IsVisible() return QuestFrame and QuestFrame.Visible end
    function IsDone()
        local c, m = GetQuestProgressUI(); c = tonumber(c) or 0; m = tonumber(m) or 0
        return m > 0 and c >= m
    end
    Remotes.QuestAbandon:FireServer(); task.wait(0.5)
    Remotes.QuestAccept:FireServer('SukunaMovesetNPC'); task.wait(1.5)
    fnl:MakeNotification({Title='Sukuna Quest', Description='Quest started!', Duration=3})
    while Toggles.AutoSukunaQuest and Toggles.AutoSukunaQuest.Value do
        task.wait(0.05)
        if not IsVisible() then
            Remotes.QuestAbandon:FireServer(); task.wait(0.5)
            Remotes.QuestAccept:FireServer('SukunaMovesetNPC'); task.wait(1.5)
            continue
        end
        local titleLow = GetTitle():lower()
        local descLow  = GetDesc():lower()
        local cur, max = GetQuestProgressUI()
        cur = tonumber(cur) or 0; max = tonumber(max) or 0
        if titleLow:find('training 1') or descLow:find('damage') then
            if IsDone() then fnl:MakeNotification({Title='Sukuna Quest', Description='Stage 1 done!', Duration=3}); task.wait(1); continue end
            local target = GetBestMobCluster({['ThiefBoss']=true}) or GetBestMobCluster({['MonkeyBoss']=true}) or GetNearestMobTarget()
            if not target then WaitAtSpawn(); continue end
            local isBoss = target.Name:find('Boss') and not table.find(Tables.MiniBossList, target.Name)
            AttackTarget(target, GetNearestIsland(target:GetPivot().Position), isBoss and 'Boss' or 'Mob')
        elseif titleLow:find('training 2') or descLow:find('player') then
            if IsDone() then fnl:MakeNotification({Title='Sukuna Quest', Description='Stage 2 done!', Duration=3}); task.wait(1); continue end
            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            local closestPlayer, closestDist = nil, math.huge
            if root then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= Plr and p.Character then
                        local pRoot = p.Character:FindFirstChild('HumanoidRootPart')
                        local pHum  = p.Character:FindFirstChildOfClass('Humanoid')
                        local pvpEnabled = p:GetAttribute('DisablePvP') == false or p:GetAttribute('PvP') == true or p:GetAttribute('DisablePvP') == nil
                        if pRoot and pHum and pHum.Health > 0 and pvpEnabled then
                            local d = (root.Position - pRoot.Position).Magnitude
                            if d < closestDist then closestDist = d; closestPlayer = p end
                        end
                    end
                end
            end
            if closestPlayer and closestPlayer.Character then
                local pRoot = closestPlayer.Character:FindFirstChild('HumanoidRootPart')
                local pHum  = closestPlayer.Character:FindFirstChildOfClass('Humanoid')
                if pRoot and pHum and root then
                    EquipWeapon()
                    root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 3)
                    root.AssemblyLinearVelocity = Vector3.zero
                    local killed, conn = false, nil
                    conn = pHum.Died:Connect(function() killed = true; conn:Disconnect() end)
                    local timeout = tick()
                    while not killed and tick() - timeout < 15 and Toggles.AutoSukunaQuest and Toggles.AutoSukunaQuest.Value do
                        if pHum.Health > 0 then
                            root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 3)
                            root.AssemblyLinearVelocity = Vector3.zero
                            for i = 1, 3 do pcall(function() Remotes.M1:FireServer() end); task.wait(0.05) end
                        end
                        task.wait(0.1)
                    end
                    if not killed and conn then conn:Disconnect() end
                end
            else
                fnl:MakeNotification({Title='Sukuna Quest', Description='No PvP players nearby. ('..cur..'/25)\nWaiting...', Duration=3})
                task.wait(3)
            end
        elseif titleLow:find('training 3') or descLow:find('sukuna') or descLow:find('boss') then
            if IsDone() then
                fnl:MakeNotification({Title='Sukuna Quest', Description='All stages done! Buy Sukuna style.', Duration=8})
                RestoreState(); if Toggles.AutoSukunaQuest then Toggles.AutoSukunaQuest.Value = false end; break
            end
            local boss = GetBestMobCluster({['SukunaBoss'] = true})
            if boss then
                local hum = boss:FindFirstChildOfClass('Humanoid')
                local curHP = hum and hum.Health or 0
                if curHP <= 0 and lastBossHP > 0 then
                    fnl:MakeNotification({Title='Sukuna Quest', Description='Boss killed! '..cur..'/'..max, Duration=3})
                    lastBossHP = math.huge; task.wait(2); continue
                end
                lastBossHP = curHP
                AttackTarget(boss, 'Shibuya', 'Boss')
            else
                lastBossHP = math.huge
                fnl:MakeNotification({Title='Sukuna Quest', Description='Waiting for SukunaBoss... ('..cur..'/'..max..')', Duration=4})
                WaitAtSpawn()
            end
        else
            fnl:MakeNotification({Title='Sukuna Quest', Description='Unknown stage: '..GetTitle()..'\n'..GetDesc(), Duration=4})
            task.wait(2)
        end
    end
    RestoreState()
end

function Func_AutoYujiGetItems()
    local YujiNeeds = {
        {name = 'Energy Core', need = 7}, {name = 'Flash Impact', need = 3}, {name = 'Divergent Pulse', need = 1}
    }
    function YujiMaterialsDone()
        for _, item in ipairs(YujiNeeds) do if GetItemQty(item.name) < item.need then return false end end
        return true
    end
    if YujiMaterialsDone() then
        fnl:MakeNotification({Title='Yuji Items', Description='Already have all materials!', Duration=5})
        if Toggles.AutoYujiGetItems then Toggles.AutoYujiGetItems.Value = false end; return
    end
    local lastNotif = 0
    while Toggles.AutoYujiGetItems and Toggles.AutoYujiGetItems.Value and not YujiMaterialsDone() do
        task.wait(0.05)
        if tick() - lastNotif >= 5 then
            fnl:MakeNotification({Title='Yuji - Farming', Description='Energy Core: '..GetItemQty('Energy Core')..'/7\nFlash Impact: '..GetItemQty('Flash Impact')..'/3\nDivergent Pulse: '..GetItemQty('Divergent Pulse')..'/1', Duration=4})
            lastNotif = tick()
        end
        local boss = GetBestMobCluster({['YujiBoss'] = true})
        if boss then AttackTarget(boss, 'Boss', 'Boss') else task.wait(0.5) end
    end
    if YujiMaterialsDone() then fnl:MakeNotification({Title='Yuji Items ✓', Description='All items collected!', Duration=8}) end
    if Toggles.AutoYujiGetItems then Toggles.AutoYujiGetItems.Value = false end
end

function Func_AutoQinShiFull()
    function NotifyQS(msg) fnl:MakeNotification({Title='Qin Shi', Description=msg, Duration=4}) end
    local needs = {{name='Jade Tablet', need=7}, {name='Imperial Seal', need=3}}
    function ItemsDone() for _, i in ipairs(needs) do if GetItemQty(i.name) < i.need then return false end end return true end
    if not ItemsDone() then
        NotifyQS('Farming Qin Shi Boss for:\n7x Jade Tablet + 3x Imperial Seal...')
        Remotes.TP_Portal:FireServer('Boss'); task.wait(2)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoQinShiFull and Toggles.AutoQinShiFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then
                NotifyQS('Jade Tablet: '..GetItemQty('Jade Tablet')..'/7\nImperial Seal: '..GetItemQty('Imperial Seal')..'/3')
                lastNotif = tick()
            end
            local boss = GetBestMobCluster({['QinShiBoss'] = true})
            if not boss then
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if npc.Name:lower():find('qin') then
                        local hum = npc:FindFirstChildOfClass('Humanoid')
                        if hum and hum.Health > 0 then boss = npc; break end
                    end
                end
            end
            if boss then
                AttackTarget(boss, 'Boss', 'Boss')
            else
                if tick() - lastSummon >= 3 then
                    NotifyQS('Summoning Qin Shi Boss...')
                    pcall(function() Remotes.SummonBoss:FireServer('QinShiBoss', 'Normal') end)
                    lastSummon = tick(); task.wait(3)
                end
            end
        end
    end
    if not (Toggles.AutoQinShiFull and Toggles.AutoQinShiFull.Value) then return end
    NotifyQS('All items collected!\nExchanging for Qin Shi style...')
    task.wait(1)
    local ok, err = pcall(function() RS.Remotes.ExchangeItem:InvokeServer('Qin Shi') end)
    if ok then NotifyQS('Done! Qin Shi style unlocked.') else NotifyQS('Exchange failed: '..tostring(err)) end
    if Toggles.AutoQinShiFull then Toggles.AutoQinShiFull.Value = false end
end


function Func_AutoAlucardFull()
    function NotifyAL(msg) fnl:MakeNotification({Title='Alucard Style', Description=msg, Duration=4}) end
    local money = Plr.Data.Money.Value; local gems = Plr.Data.Gems.Value
    if money < 6500000 then NotifyAL('Not enough Money!\nNeed: 6,500,000\nHave: '..CommaFormat(money)); if Toggles.AutoAlucardFull then Toggles.AutoAlucardFull.Value = false end; return end
    if gems < 10000 then NotifyAL('Not enough Gems!\nNeed: 10,000\nHave: '..CommaFormat(gems)); if Toggles.AutoAlucardFull then Toggles.AutoAlucardFull.Value = false end; return end
    local currentRace = Plr:GetAttribute('CurrentRace') or ''
    if currentRace:lower() ~= 'vampire' then NotifyAL('Vampire Race required!\nCurrent Race: '..tostring(currentRace)); if Toggles.AutoAlucardFull then Toggles.AutoAlucardFull.Value = false end; return end
    local AlucardNeeds = {{name='Soul Amulet', need=5}, {name='Casull', need=1}, {name='Blood Ring', need=1}}
    function AlucardItemsDone() for _, item in ipairs(AlucardNeeds) do if GetItemQty(item.name) < item.need then return false end end return true end
    function HasVampireKingTitle()
        for _, id in ipairs(Tables.UnlockedTitle) do
            local idStr = tostring(id):lower():gsub('%s+', '')
            if idStr:find('vampireking') or idStr:find('vampire_king') then return true end
        end
        return false
    end
    function AllDone() return AlucardItemsDone() and HasVampireKingTitle() end
    if not AllDone() then
        NotifyAL('Phase 1: Farming at Sailor Island\nNeeds: 5x Soul Amulet | 1x Casull | 1x Blood Ring\n+ Vampire King Title')
        Remotes.TP_Portal:FireServer('Sailor'); task.wait(2.5)
        local lastNotif = 0
        while Toggles.AutoAlucardFull and Toggles.AutoAlucardFull.Value and not AllDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then
                NotifyAL('Soul Amulet: '..GetItemQty('Soul Amulet')..'/5\nCasull: '..GetItemQty('Casull')..'/1\nBlood Ring: '..GetItemQty('Blood Ring')..'/1\nVampire King Title: '..(HasVampireKingTitle() and 'Got!' or 'Not yet...'))
                lastNotif = tick()
            end
            local boss = GetBestMobCluster({['AlucardBoss']=true, ['JinwooBoss']=true})
            if boss then AttackTarget(boss, 'Sailor', 'Boss') else task.wait(1) end
        end
    end
    if not (Toggles.AutoAlucardFull and Toggles.AutoAlucardFull.Value) then return end
    NotifyAL('All done!\nPhase 2: Purchasing Alucard style...')
    Remotes.TP_Portal:FireServer('Sailor'); task.wait(2.5); SafeTeleportToNPC('AlucardBuyer'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('AlucardStyle', 1) end)
    if not buyOk then buyOk = pcall(function() Remotes.UseItem:FireServer('Buy', 'Alucard', 1) end) end
    if buyOk then NotifyAL('Done! Alucard fighting style unlocked!') else NotifyAL('Almost there! Interact manually.') end
    if Toggles.AutoAlucardFull then Toggles.AutoAlucardFull.Value = false end
end

local function GenericBossFarm(toggleKey, bossName, island, summonFunc, lastSummonRef, lastNotifRef, needsDone, notifyFn, diff)
    local boss = GetBestMobCluster({[bossName] = true})
    if boss then
        AttackTarget(boss, island, 'Boss')
    else
        if tick() - lastSummonRef[1] >= 3 then
            if summonFunc then summonFunc() end
            lastSummonRef[1] = tick(); task.wait(3)
        end
    end
end

function Func_AutoGojoV2Full()
    function NotifyV2(msg) fnl:MakeNotification({Title='Gojo V2 Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedGojoV2Diff or 'Normal'
    local bossNameMap = {Normal='StrongestofTodayBoss_Normal', Medium='StrongestofTodayBoss_Medium', Hard='StrongestofTodayBoss_Hard', Extreme='StrongestofTodayBoss_Extreme'}
    local targetBossName = bossNameMap[diff] or 'StrongestofTodayBoss_Normal'
    local V2Needs = {{name='Six Eye',need=6},{name='Reversal Pulse',need=9},{name='Blue Singularity',need=3},{name='Infinity Essence',need=1},{name='Strongest Sorcerer',need=1}}
    function V2ItemsDone() for _, item in ipairs(V2Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not V2ItemsDone() then
        NotifyV2('Farming '..targetBossName..' at Shinjuku...')
        Remotes.TP_Portal:FireServer('Shinjuku'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoGojoV2Full and Toggles.AutoGojoV2Full.Value and not V2ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then NotifyV2('Six Eye: '..GetItemQty('Six Eye')..'/6\nReversal Pulse: '..GetItemQty('Reversal Pulse')..'/9'); lastNotif = tick() end
            local boss = GetBestMobCluster({[targetBossName] = true})
            if boss then
                AttackTarget(boss, 'Shinjuku', 'Boss')
            else
                if tick() - lastSummon >= 3 then
                    pcall(function() Remotes.JJKSummonBoss:FireServer('StrongestToday', diff) end)
                    lastSummon = tick(); task.wait(3)
                end
            end
        end
    end
    if not (Toggles.AutoGojoV2Full and Toggles.AutoGojoV2Full.Value) then return end
    NotifyV2('Consuming 6x Six Eyes...')
    for i = 1, 6 do pcall(function() game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseItem'):FireServer('Use', 'Six Eye', 1, false) end); task.wait(0.5) end
    NotifyV2('Teleporting to buyer NPC...')
    Remotes.TP_Portal:FireServer('Shinjuku'); task.wait(2.5); SafeTeleportToNPC('StrongestofTodayBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('GojoV2Style', 1) end)
    if buyOk then NotifyV2('Done! Gojo V2 unlocked!') else NotifyV2('Almost done! Interact manually.') end
    if Toggles.AutoGojoV2Full then Toggles.AutoGojoV2Full.Value = false end
end

function Func_AutoSukunaV2Full()
    function NotifyV2(msg) fnl:MakeNotification({Title='Sukuna V2 Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedSukunaV2Diff or 'Normal'
    local bossNameMap = {Normal='StrongestinHistoryBoss_Normal', Medium='StrongestinHistoryBoss_Medium', Hard='StrongestinHistoryBoss_Hard', Extreme='StrongestinHistoryBoss_Extreme'}
    local targetBossName = bossNameMap[diff] or 'StrongestinHistoryBoss_Normal'
    local V2Needs = {{name='Awakened Cursed Finger',need=20},{name='Vessel Ring',need=7},{name='Malevolent Soul',need=3},{name='Cursed Flesh',need=1},{name='Disgraced One',need=1}}
    function V2ItemsDone() for _, item in ipairs(V2Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not V2ItemsDone() then
        NotifyV2('Farming '..targetBossName..'...')
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoSukunaV2Full and Toggles.AutoSukunaV2Full.Value and not V2ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then NotifyV2('Awakened Cursed Finger: '..GetItemQty('Awakened Cursed Finger')..'/20\nVessel Ring: '..GetItemQty('Vessel Ring')..'/7'); lastNotif = tick() end
            local boss = GetBestMobCluster({[targetBossName] = true})
            if boss then
                AttackTarget(boss, 'Boss', 'Boss')
            else
                if tick() - lastSummon >= 3 then
                    pcall(function() Remotes.JJKSummonBoss:FireServer('StrongestHistory', diff) end)
                    lastSummon = tick(); task.wait(3)
                end
            end
        end
    end
    if not (Toggles.AutoSukunaV2Full and Toggles.AutoSukunaV2Full.Value) then return end
    NotifyV2('Consuming 20x Awakened Cursed Fingers...')
    for i = 1, 20 do pcall(function() game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('UseItem'):FireServer('Use', 'Awakened Cursed Finger', 1, false) end); task.wait(0.5) end
    Remotes.TP_Portal:FireServer('Shinjuku'); task.wait(2.5); SafeTeleportToNPC('StrongestinHistoryBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('SukunaV2Style', 1) end)
    if buyOk then NotifyV2('Done! Sukuna V2 unlocked!') else NotifyV2('Almost done! Interact manually.') end
    if Toggles.AutoSukunaV2Full then Toggles.AutoSukunaV2Full.Value = false end
end

function Func_AutoGilgameshFull()
    function Notify(msg) fnl:MakeNotification({Title='Gilgamesh Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedGilgameshDiff or 'Normal'
    local Needs = {{name='Throne Remnant',need=12},{name='Ancient Shard',need=6},{name='Golden Essence',need=3},{name='Phantasm Core',need=1},{name='Golden King',need=1}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoGilgameshFull and Toggles.AutoGilgameshFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Throne Remnant: '..GetItemQty('Throne Remnant')..'/12\nAncient Shard: '..GetItemQty('Ancient Shard')..'/6'); lastNotif = tick() end
            local boss = GetBestMobCluster({['GilgameshBoss'] = true})
            if boss then
                AttackTarget(boss, 'Boss', 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.SummonBoss:FireServer('GilgameshBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoGilgameshFull and Toggles.AutoGilgameshFull.Value) then return end
    Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5); SafeTeleportToNPC('GilgameshBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('GilgameshStyle', 1) end)
    if buyOk then Notify('Done! Gilgamesh unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoGilgameshFull then Toggles.AutoGilgameshFull.Value = false end
end

function Func_AutoAnosFull()
    function Notify(msg) fnl:MakeNotification({Title='Anos Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedAnosDiff or 'Normal'
    local bossNameMap = {Normal='AnosBoss_Normal', Medium='AnosBoss_Medium', Hard='AnosBoss_Hard', Extreme='AnosBoss_Extreme'}
    local targetBossName = bossNameMap[diff] or 'AnosBoss_Normal'
    local Needs = {{name='Calamity Seal',need=65},{name='Demonic Fragment',need=12},{name='Demonic Shard',need=6},{name='Destruction Eye',need=2},{name='Imperial Mark',need=1},{name='Voldigoat',need=1},{name='Demon King',need=1}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer('Academy'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoAnosFull and Toggles.AutoAnosFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Calamity Seal: '..GetItemQty('Calamity Seal')..'/65\nDemonic Fragment: '..GetItemQty('Demonic Fragment')..'/12'); lastNotif = tick() end
            local boss = GetBestMobCluster({[targetBossName] = true})
            if boss then
                AttackTarget(boss, 'Academy', 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.AnosBoss:FireServer('AnosBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoAnosFull and Toggles.AutoAnosFull.Value) then return end
    Remotes.TP_Portal:FireServer('Academy'); task.wait(2.5); SafeTeleportToNPC('AnosBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('AnosStyle', 1) end)
    if buyOk then Notify('Done! Anos unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoAnosFull then Toggles.AutoAnosFull.Value = false end
end

function Func_AutoBlessedMaidenFull()
    function Notify(msg) fnl:MakeNotification({Title='Blessed Maiden Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedBlessedMaidenDiff or 'Normal'
    local Needs = {{name='Celestial Mark',need=1},{name='Aero Core',need=3},{name='Gale Essence',need=8},{name='Tide Remnant',need=14},{name='Tempest Relic',need=25},{name='Astral Empress',need=1}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoBlessedMaidenFull and Toggles.AutoBlessedMaidenFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Celestial Mark: '..GetItemQty('Celestial Mark')..'/1\nAero Core: '..GetItemQty('Aero Core')..'/3'); lastNotif = tick() end
            local boss = GetBestMobCluster({['BlessedMaidenBoss'] = true})
            if boss then
                AttackTarget(boss, 'Boss', 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.SummonBoss:FireServer('BlessedMaidenBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoBlessedMaidenFull and Toggles.AutoBlessedMaidenFull.Value) then return end
    Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5); SafeTeleportToNPC('BlessedMaidenBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('BlessedMaidenStyle', 1) end)
    if buyOk then Notify('Done! Blessed Maiden unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoBlessedMaidenFull then Toggles.AutoBlessedMaidenFull.Value = false end
end

function Func_AutoSaberAlterFull()
    function Notify(msg) fnl:MakeNotification({Title='Saber Alter Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedSaberAlterDiff or 'Normal'
    local Needs = {{name='Dark Grail',need=25},{name='Morgan Remnant',need=15},{name='Alter Essence',need=8},{name='Corruption Core',need=3},{name='Corrupt Crown',need=1},{name='Corrupt Tyrant',need=1}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoSaberAlterFull and Toggles.AutoSaberAlterFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Dark Grail: '..GetItemQty('Dark Grail')..'/25\nMorgan Remnant: '..GetItemQty('Morgan Remnant')..'/15'); lastNotif = tick() end
            local boss = GetBestMobCluster({['SaberAlterBoss'] = true})
            if boss then
                AttackTarget(boss, 'Boss', 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.SummonBoss:FireServer('SaberAlterBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoSaberAlterFull and Toggles.AutoSaberAlterFull.Value) then return end
    Remotes.TP_Portal:FireServer('Boss'); task.wait(2.5); SafeTeleportToNPC('SaberAlterBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('SaberAlterStyle', 1) end)
    if buyOk then Notify('Done! Saber Alter unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoSaberAlterFull then Toggles.AutoSaberAlterFull.Value = false end
end

function Func_AutoStrongestShinobiFull()
    function Notify(msg) fnl:MakeNotification({Title='Strongest Shinobi Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedStrongestShiobiDiff or 'Normal'
    local Needs = {{name='Battlefield Warlord',need=1},{name='Path Fragment',need=1},{name='Eternal Core',need=3},{name='Battle Sigil',need=8},{name='Power Remnant',need=15}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer('Ninja'); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoStrongestShiobiFull and Toggles.AutoStrongestShiobiFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Battlefield Warlord: '..GetItemQty('Battlefield Warlord')..'/1\nBattle Sigil: '..GetItemQty('Battle Sigil')..'/8'); lastNotif = tick() end
            local boss = GetBestMobCluster({['StrongestShinobiBoss'] = true})
            if boss then
                AttackTarget(boss, 'Ninja', 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.SummonBoss:FireServer('StrongestShinobiBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoStrongestShiobiFull and Toggles.AutoStrongestShiobiFull.Value) then return end
    Remotes.TP_Portal:FireServer('Ninja'); task.wait(2.5); SafeTeleportToNPC('StrongestShinobiBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('StrongestShinobiStyle', 1) end)
    if buyOk then Notify('Done! Strongest Shinobi unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoStrongestShiobiFull then Toggles.AutoStrongestShiobiFull.Value = false end
end

function Func_AutoMoonSlayerFull()
    function Notify(msg) fnl:MakeNotification({Title='Moon Slayer Style', Description=msg, Duration=4}) end
    local diff = Options.SelectedMoonSlayerDiff or 'Normal'
    local bossNameMap = {Normal='MoonSlayerBoss_Normal', Medium='MoonSlayerBoss_Medium', Hard='MoonSlayerBoss_Hard', Extreme='MoonSlayerBoss_Extreme'}
    local targetBossName = bossNameMap[diff] or 'MoonSlayerBoss_Normal'
    local island = Shared.BossTIMap['Moon Slayer'] or 'Boss'
    local Needs = {{name='Six Eyed Demon',need=1},{name='Moon Crest',need=1},{name='Crescent Shard',need=4},{name='Lunar Essence',need=9},{name='Demon Remnant',need=16},{name='Upper Seal',need=25}}
    function ItemsDone() for _, item in ipairs(Needs) do if GetItemQty(item.name) < item.need then return false end end return true end
    if not ItemsDone() then
        Remotes.TP_Portal:FireServer(island); task.wait(2.5)
        local lastNotif, lastSummon = 0, 0
        while Toggles.AutoMoonSlayerFull and Toggles.AutoMoonSlayerFull.Value and not ItemsDone() do
            task.wait(0.05)
            if tick() - lastNotif >= 5 then Notify('Six Eyed Demon: '..GetItemQty('Six Eyed Demon')..'/1\nMoon Crest: '..GetItemQty('Moon Crest')..'/1'); lastNotif = tick() end
            local boss = GetBestMobCluster({[targetBossName] = true})
            if boss then
                AttackTarget(boss, island, 'Boss')
            else
                if tick() - lastSummon >= 3 then pcall(function() Remotes.SummonBoss:FireServer('MoonSlayerBoss', diff) end); lastSummon = tick(); task.wait(3) end
            end
        end
    end
    if not (Toggles.AutoMoonSlayerFull and Toggles.AutoMoonSlayerFull.Value) then return end
    Remotes.TP_Portal:FireServer(island); task.wait(2.5); SafeTeleportToNPC('MoonSlayerBuyerNPC'); task.wait(1)
    local buyOk = pcall(function() Remotes.MerchantBuy:InvokeServer('MoonSlayerStyle', 1) end)
    if buyOk then Notify('Done! Moon Slayer unlocked!') else Notify('Almost done! Interact manually.') end
    if Toggles.AutoMoonSlayerFull then Toggles.AutoMoonSlayerFull.Value = false end
end

fightingstyle:Section({Title = 'Gojo Style'})
fightingstyle:Paragraph({
    Title = 'Gojo Items Required :',
    Desc = '6x Void Fragment, 3x Limitless Ring, 1x Infinity Core'
})
fightingstyle:Paragraph({
    Title = 'Gojo Quest',
    Desc = 'S1: Kill NPCs | S2: Use abilities 350x | S3: Kill GojoBoss 15x'
})
fightingstyle:Toggle({
    Title = 'Auto Get Gojo Items',
    Default = false,
    Callback = function(v)
        Toggles.AutoGojoGetItems = {Value = v}
        Thread('Styles.GojoGetItems', SafeLoop('Gojo Get Items', Func_AutoGojoGetItems), v)
    end
})
fightingstyle:Toggle({
    Title = 'Auto Gojo Quest',
    Default = false,
    Callback = function(v)
        Toggles.AutoGojoQuest = {Value = v}
        Thread('Styles.GojoQuest', SafeLoop('Gojo Quest', Func_AutoGojoQuest), v)
    end
})

fightingstyle:Section({Title = 'Gojo V2 Style'})
fightingstyle:Paragraph({
    Title = 'Gojo V2 Requirements',
    Desc = 'Consume: 6x Six Eyes\nFarm: 9x Reversal Pulse | 3x Blue Singularity | 1x Infinity Essence'
})
fightingstyle:Dropdown({
    Title = 'Summon Difficulty (Gojo V2)',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v)
        Options.SelectedGojoV2Diff = v
    end
})
fightingstyle:Toggle({
    Title = 'Auto Gojo V2 (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoGojoV2Full = {Value = v}
        Thread('Styles.GojoV2Full', SafeLoop('Gojo V2 Full', Func_AutoGojoV2Full), v)
    end
})

fightingstyle:Section({Title = 'Sukuna & Yuji Style'})
fightingstyle:Paragraph({
    Title = 'Sukuna Items Required:',
    Desc = '6x Cursed Finger, 3x Dismantle Fang, 1x Crimson Heart'
})
fightingstyle:Paragraph({
    Title = 'Yuji Items Required:',
    Desc = '7x Energy Core | 3x Flash Impact | 1x Divergent Pulse'
})
fightingstyle:Toggle({
    Title = 'Auto Get Sukuna Items',
    Default = false,
    Callback = function(v)
        Toggles.AutoSukunaGetItems = {Value = v}
        Thread('Styles.SukunaGetItems', SafeLoop('Sukuna Get Items', Func_AutoSukunaGetItems), v)
    end
})
fightingstyle:Toggle({
    Title = 'Auto Sukuna Quest',
    Default = false,
    Callback = function(v)
        Toggles.AutoSukunaQuest = {Value = v}
        Thread('Styles.SukunaQuest', SafeLoop('Sukuna Quest', Func_AutoSukunaQuest), v)
    end
})
fightingstyle:Toggle({
    Title = 'Auto Yuji (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoYujiGetItems = {Value = v}
        Thread('Styles.YujiGetItems', SafeLoop('Yuji Get Items', Func_AutoYujiGetItems), v)
    end
})

fightingstyle:Section({Title = 'Sukuna V2 Style'})
fightingstyle:Paragraph({
    Title = 'Sukuna V2 Requirements',
    Desc = 'Farm & Consume: 20x Awakened Cursed Finger\nFarm: 7x Vessel Ring | 3x Malevolent Soul\n1x Cursed Flesh'
})
fightingstyle:Dropdown({
    Title = 'Summon Difficulty (Sukuna V2)',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v)
        Options.SelectedSukunaV2Diff = v
    end
})
fightingstyle:Toggle({
    Title = 'Auto Sukuna V2 (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoSukunaV2Full = {Value = v}
        Thread('Styles.SukunaV2Full', SafeLoop('Sukuna V2 Full', Func_AutoSukunaV2Full), v)
    end
})

fightingstyle:Section({Title = 'Qin Shi Style'})
fightingstyle:Paragraph({
    Title = 'Qin Shi Requirements',
    Desc = 'Auto farms: 7x Jade Tablet + 3x Imperial Seal or 250 boss tickets'
})
fightingstyle:Toggle({
    Title = 'Auto Qin Shi (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoQinShiFull = {Value = v}
        Thread('Styles.QinShiFull', SafeLoop('Qin Shi Full', Func_AutoQinShiFull), v)
    end
})
fightingstyle:Button({
    Title = 'Exchange 250 Boss Tickets → Qin Shi',
    Callback = function()
        fnl:MakeNotification({Title='Qin Shi', Description='Sending exchange request...', Duration=3})
        local ok, err = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ExchangeItem"):InvokeServer("Qin Shi")
        end)
        if ok then
            fnl:MakeNotification({Title='Qin Shi', Description='Success! Qin Shi style unlocked via Boss Tickets.', Duration=5})
        else
            fnl:MakeNotification({Title='Qin Shi', Description='Exchange failed: '..tostring(err), Duration=5})
        end
    end
})

fightingstyle:Section({Title = 'Alucard Style'})
fightingstyle:Paragraph({
    Title = 'Alucard Requirements',
    Desc = 'Vampire King Title | 5x Soul Amulet | 1x Casull | 1x Blood Ring'
})
fightingstyle:Toggle({
    Title = 'Auto Alucard Style (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoAlucardFull = {Value = v}
        Thread('Styles.AlucardFull', SafeLoop('Alucard Full', Func_AutoAlucardFull), v)
    end
})

fightingstyle:Section({Title = 'Gilgamesh Style'})
fightingstyle:Paragraph({
    Title = 'Gilgamesh Requirements',
    Desc = '12x Throne Remnant | 6x Ancient Shard\n3x Golden Essence | 1x Phantasm Core\n1x Golden King Title (Boss Island)'
})
fightingstyle:Dropdown({
    Title = 'Gilgamesh Difficulty',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v) Options.SelectedGilgameshDiff = v end
})
fightingstyle:Toggle({
    Title = 'Auto Gilgamesh (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoGilgameshFull = {Value = v}
        Thread('Styles.GilgameshFull', SafeLoop('Gilgamesh Full', Func_AutoGilgameshFull), v)
    end
})

fightingstyle:Section({Title = 'Anos Style'})
fightingstyle:Paragraph({
    Title = 'Anos Requirements',
    Desc = '65x Calamity Seal | 12x Demonic Fragment | 6x Demonic Shard \n 2x Destruction Eye | 1x Imperial Mark \n 1x Voldigoat Clan | 1x Demon King Title'
})
fightingstyle:Dropdown({
    Title = 'Anos Difficulty',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v) Options.SelectedAnosDiff = v end
})
fightingstyle:Toggle({
    Title = 'Auto Anos (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoAnosFull = {Value = v}
        Thread('Styles.AnosFull', SafeLoop('Anos Full', Func_AutoAnosFull), v)
    end
})

fightingstyle:Section({Title = 'Blessed Maiden Style'})
fightingstyle:Paragraph({
    Title = 'Blessed Maiden Requirements',
    Desc = '1x Celestial Mark | 3x Aero Core | 8x Gale Essence\n14x Tide Remnant | 25x Tempest Relic\n1x Astral Empress Title'
})
fightingstyle:Dropdown({
    Title = 'Blessed Maiden Difficulty',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v) Options.SelectedBlessedMaidenDiff = v end
})
fightingstyle:Toggle({
    Title = 'Auto Blessed Maiden (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoBlessedMaidenFull = {Value = v}
        Thread('Styles.BlessedMaidenFull', SafeLoop('Blessed Maiden Full', Func_AutoBlessedMaidenFull), v)
    end
})

fightingstyle:Section({Title = 'Saber Alter Style'})
fightingstyle:Paragraph({
    Title = 'Saber Alter Requirements',
    Desc = '25x Dark Grail | 15x Morgan Remnant\n8x Alter Essence | 3x Corruption Core\n1x Corrupt Crown | 1x Corrupt Tyrant Title'
})
fightingstyle:Dropdown({
    Title = 'Saber Alter Difficulty',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v) Options.SelectedSaberAlterDiff = v end
})
fightingstyle:Toggle({
    Title = 'Auto Saber Alter (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoSaberAlterFull = {Value = v}
        Thread('Styles.SaberAlterFull', SafeLoop('Saber Alter Full', Func_AutoSaberAlterFull), v)
    end
})

fightingstyle:Section({Title = 'Strongest Shinobi Style'})
fightingstyle:Paragraph({
    Title = 'Strongest Shinobi Requirements',
    Desc = 'Battlefield Warlord Title | 1x Path Fragment\n3x Eternal Core | 8x Battle Sigil\n15x Power Remnant '
})

fightingstyle:Toggle({
    Title = 'Auto Strongest Shinobi (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoStrongestShiobiFull = {Value = v}
        Thread('Styles.StrongestShinobiFull', SafeLoop('Strongest Shinobi Full', Func_AutoStrongestShinobiFull), v)
    end
})

fightingstyle:Section({Title = 'Moon Slayer Style'})
fightingstyle:Paragraph({
    Title = 'Moon Slayer Requirements',
    Desc = 'Six Eyed Demon Title | 1x Moon Crest\n4x Crescent Shard | 9x Lunar Essence\n16x Demon Remnant | 25x Upper Seal'
})
fightingstyle:Dropdown({
    Title = 'Moon Slayer Difficulty',
    Values = Tables.DiffList,
    Default = 'Normal',
    Callback = function(v)
        Options.SelectedMoonSlayerDiff = v
    end
})
fightingstyle:Toggle({
    Title = 'Auto Moon Slayer (Fully)',
    Default = false,
    Callback = function(v)
        Toggles.AutoMoonSlayerFull = {Value = v}
        Thread('Styles.MoonSlayerFull', SafeLoop('Moon Slayer Full', Func_AutoMoonSlayerFull), v)
    end
})


local PuzzleTab = window:Tab({Title = 'Puzzles', Icon = 'rbxassetid://10734949856'})

PuzzleTab:Section({Title = 'Puzzle Solvers'})
function Func_AutoPuzzle(puzzleType, minLevel)
    while Toggles['Auto'..puzzleType..'Puzzle'] and Toggles['Auto'..puzzleType..'Puzzle'].Value do
        if not Support.Proximity then
            fnl:MakeNotification({
                Title = 'Error',
                Description = 'fireproximityprompt not supported.',
                Duration = 3
            })
            if Toggles['Auto'..puzzleType..'Puzzle'] then
                Toggles['Auto'..puzzleType..'Puzzle'].Value = false
            end
            break
        end

        if minLevel and Plr.Data.Level.Value < minLevel then
            fnl:MakeNotification({
                Title = 'Error',
                Description = 'Level '..minLevel..' required!',
                Duration = 3
            })
            if Toggles['Auto'..puzzleType..'Puzzle'] then
                Toggles['Auto'..puzzleType..'Puzzle'].Value = false
            end
            break
        end

        UniversalPuzzleSolver(puzzleType)

        if Toggles['Auto'..puzzleType..'Puzzle'] then
            Toggles['Auto'..puzzleType..'Puzzle'].Value = false
        end
        break
    end
end

PuzzleTab:Toggle({
    Title = 'Auto Dungeon Puzzle',
    Default = false,
    Callback = function(v)
        Toggles.AutoDungeonPuzzle = {Value = v}
        Thread('AutoDungeonPuzzle', SafeLoop('Dungeon Puzzle', function()
            Func_AutoPuzzle('Dungeon', 5000)
        end), v)
    end
})
PuzzleTab:Toggle({
    Title = 'Auto Slime Key Puzzle',
    Default = false,
    Callback = function(v)
        Toggles.AutoSlimePuzzle = {Value = v}
        Thread('AutoSlimePuzzle', SafeLoop('Slime Puzzle', function()
            Func_AutoPuzzle('Slime', nil)
        end), v)
    end
})
PuzzleTab:Toggle({
    Title = 'Auto Demonite Puzzle',
    Default = false,
    Callback = function(v)
        Toggles.AutoDemonitePuzzle = {Value = v}
        Thread('AutoDemonitePuzzle', SafeLoop('Demonite Puzzle', function()
            Func_AutoPuzzle('Demonite', nil)
        end), v)
    end
})
PuzzleTab:Toggle({
    Title = 'Auto Hogyoku Puzzle',
    Default = false,
    Callback = function(v)
        Toggles.AutoHogyokuPuzzle = {Value = v}
        Thread('AutoHogyokuPuzzle', SafeLoop('Hogyoku Puzzle', function()
            Func_AutoPuzzle('Hogyoku', 8500)
        end), v)
    end
})


--Window:Divider() -- Section: 'Local Player'

local StatsTab = window:Tab({Title = 'Stats', Icon = 'rbxassetid://10709770431'})

StatsTab:Section({Title = 'Allocate Stat Points'})
StatsTab:Dropdown({
    Title = 'Select Stats',
    Values = {
        'Melee',
        'Defense',
        'Sword',
        'Power'
    },
    Default = {
        'Melee'
    },
    Multi = true,
    Callback = function(v)
        Options.SelectedStats = ToSet(v)
    end
})

Options.SelectedStats = {Melee = true}

StatsTab:Toggle({
    Title = 'Auto UP Stats',
    Default = false,
    Callback = function(v)
        Toggles.AutoStats = {Value = v}

        Thread('AutoStats', SafeLoop('Auto Stats', Func_AutoStats), v)
    end
})
StatsTab:Section({Title = 'Gem Stat Reroll'})
StatsTab:Paragraph({
    Title = 'Note',
    Desc = 'Reroll once first for this to work.\nIncrease delay based on ping.'
})
StatsTab:Dropdown({
    Title = 'Select Gem Stats',
    Values = Tables.GemStat,
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedGemStats = ToSet(v)
    end
})
StatsTab:Dropdown({
    Title = 'Target Rank(s)',
    Values = Tables.GemRank,
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedRank = ToSet(v)
    end
})
StatsTab:Slider({
    Title = 'Roll Delay',
    Value = {Min = 0.01, Max = 1, Default = 0.1},
    Callback = function(v)
        Options.StatsRollCD = v
    end
})
StatsTab:Toggle({
    Title = 'Auto Roll Stats',
    Default = false,
    Callback = function(v)
        Toggles.AutoRollStats = {Value = v}

        Thread('AutoRollStats', SafeLoop('Stat Roll', AutoRollStatsLoop), v)
    end
})
StatsTab:Section({Title = 'Auto Ascend'})

local AscendStatusLabel = StatsTab:Paragraph({ Title = 'Ascend Requirements', Desc = 'Enable Auto Ascend to load...' })

local function UpdateAscendLabels(data)
    if not data then return end
    if data.isMaxed then
        AscendStatusLabel:SetTitle('Ascend Requirements')
        AscendStatusLabel:SetDesc('- Max Ascension Reached!')
        return
    end
    local reqs = data.requirements or {}
    local lines = {}
    for i = 1, #reqs do
        local req = reqs[i]
        if req then
            local txt = req.display and req.display:gsub('<[^>]+>', '') or 'Requirement ' .. i
            local status = req.completed and '✅' or '❌'
            local prog = string.format('(%s/%s)', CommaFormat(req.current or 0), CommaFormat(req.needed or 0))
            table.insert(lines, string.format('- %s %s %s', txt, prog, status))
        end
    end
    AscendStatusLabel:SetTitle('Ascend Requirements')
    AscendStatusLabel:SetDesc(table.concat(lines, '\n'))
end
StatsTab:Toggle({
    Title = 'Auto Ascend',
    Default = false,
    Callback = function(v)
        Toggles.AutoAscend = {Value = v}
        if v then
            -- Poll every 3 seconds to keep data fresh
            Thread('AutoAscend.Poll', function()
                while Toggles.AutoAscend and Toggles.AutoAscend.Value do
                    pcall(function()
                        local data = Remotes.ReqAscend:InvokeServer()
                        if data then
                            UpdateAscendLabels(data)
                            if data.isMaxed then
                                Toggles.AutoAscend.Value = false
                                fnl:MakeNotification({Title = 'Ascend', Description = 'Max Ascension Reached!', Duration = 5})
                                return
                            end
                            if data.allMet then
                                fnl:MakeNotification({Title = 'Ascend', Description = 'Ascending to: ' .. tostring(data.nextRankName), Duration = 5})
                                Remotes.Ascend:FireServer()
                                task.wait(2)
                            end
                        end
                    end)
                    task.wait(3)
                end
            end, true)
        else
            Thread('AutoAscend.Poll', nil, false)
            pcall(function() Remotes.CloseAscend:FireServer() end)
        end
    end
})

StatsTab:Section({Title = 'Skill Tree & Milestones'})
StatsTab:Toggle({
    Title = 'Auto Skill Tree',
    Default = false,
    Callback = function(v)
        Toggles.AutoSkillTree = { Value = v }
        Thread('AutoSkillTree', SafeLoop('Skill Tree', Func_AutoSkillTree), v)
    end
})
StatsTab:Toggle({
    Title = 'Auto Artifact Milestone',
    Default = false,
    Callback = function(v)
        Toggles.ArtifactMilestone = { Value = v }
        Thread('ArtifactMilestone', Func_ArtifactMilestone, v)
    end
})
 
StatsTab:Section({Title = 'Auto Power'})
local PowerCurrentLabel = StatsTab:Paragraph({
    Title = 'Current Power',
    Desc = 'None - Reroll once to sync'
})
task.spawn(function()
    while true do
        task.wait(2)
        PowerCurrentLabel:SetDesc(Shared.CurrentPower and Shared.CurrentPower.Name or 'None')
    end
end)
 
StatsTab:Dropdown({
    Title = 'Select Target Power(s)',
    Values = Tables.PowerList,
    Default = {},
    Multi = true,
    Callback = function(v)
        Options.SelectedPower = v
    end
})
StatsTab:Slider({
    Title = 'Power Roll Delay',
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Callback = function(v) Options.PowerRollCD = v end
})
StatsTab:Toggle({
    Title = 'Auto Roll Power',
    Default = false,
    Callback = function(v)
        Toggles.AutoPower = { Value = v }
        Thread('AutoPower', SafeLoop('Auto Power', Func_AutoPower), v)
    end
})

local RollTab = window:Tab({Title = 'Rolls', Icon = 'rbxassetid://6035153656'})

RollTab:Section({Title = 'Roll Settings'})
RollTab:Slider({
    Title = 'Roll Delay',
    Value = {Min = 0.01, Max = 1, Default = 0.3},
    Callback = function(v)
        Options.RollCD = v
    end
})
RollTab:Section({Title = 'Trait'})
RollTab:Dropdown({
    Title = 'Target Trait(s)',
    Values = Tables.TraitList,
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedTrait = ToSet(v)

        SyncTraitAutoSkip()
    end
})
RollTab:Toggle({
    Title = 'Auto Roll Trait',
    Default = false,
    Callback = function(v)
        Toggles.AutoTrait = {Value = v}

        EnsureRollManager()
    end
})
RollTab:Section({Title = 'Race'})
RollTab:Dropdown({
    Title = 'Target Race(s)',
    Values = Tables.RaceList,
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedRace = ToSet(v)

        SyncRaceSettings()
    end
})
RollTab:Toggle({
    Title = 'Auto Roll Race',
    Default = false,
    Callback = function(v)
        Toggles.AutoRace = {Value = v}

        EnsureRollManager()
    end
})
RollTab:Section({Title = 'Clan'})
RollTab:Dropdown({
    Title = 'Target Clan(s)',
    Values = Tables.ClanList,
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedClan = ToSet(v)

        SyncClanSettings()
    end
})
RollTab:Toggle({
    Title = 'Auto Roll Clan',
    Default = false,
    Callback = function(v)
        Toggles.AutoClan = {Value = v}

        EnsureRollManager()
    end
})

RollTab:Section({Title = 'Bloodline'})

RollTab:Dropdown({
    Title = 'Target Bloodline(s)',
    Values = Tables.BloodlineList or {},
    Default = '',
    Multi = true,
    Callback = function(v)
        Options.SelectedBloodline = ToSet(v)
    end
})

RollTab:Toggle({
    Title = 'Auto Roll Bloodline',
    Default = false,
    Callback = function(v)
        Toggles.AutoBloodline = {Value = v}
        EnsureRollManager()
    end
})

--Window:Divider() -- Section: 'Teleport'
local IslandTPTab = window:Tab({Title = 'Islands', Icon = 'rbxassetid://14477598542'})

IslandTPTab:Section({Title = 'Island Teleport'})
IslandTPTab:Dropdown({
    Title = 'Select Island',
    Values = Tables.IslandList,
    Default = Tables.IslandList[1],
    Callback = function(v)
        if v then
            Remotes.TP_Portal:FireServer(v)
        end
    end
})

local SEA1_PLACE_ID = 77747658251236
local SEA2_PLACE_ID = 130167267952199

local function IsInSea2()
    return game.PlaceId == SEA2_PLACE_ID
end

local function IsInSea1()
    return game.PlaceId == SEA1_PLACE_ID
end

function Func_AutoTPSea2()
    while Toggles.AutoTPSea2 and Toggles.AutoTPSea2.Value do
        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then task.wait(0.5); continue end

        if IsInSea2() then
            Toggles.AutoTPSea2.Value = false
            break
        end

        root.CFrame = CFrame.new(-828, 323, -2246)
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.8)

        local prompt = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA('ProximityPrompt') then
                local at = obj.ActionText:lower()
                local n = obj.Name:lower()
                if at:find('sea 2') or at:find('enter sea') or n:find('sea2') then
                    prompt = obj
                    break
                end
            end
        end

        if prompt then
            local promptPart = prompt.Parent
            if promptPart and promptPart:IsA('BasePart') then
                root.CFrame = CFrame.new(promptPart.Position)
                root.AssemblyLinearVelocity = Vector3.zero
                task.wait(0.3)
            end
            pcall(function() fireproximityprompt(prompt) end)
            task.wait(0.3)
            pcall(function()
                prompt.HoldDuration = 0
                prompt:InputHoldBegin()
                task.wait(0.1)
                prompt:InputHoldEnd()
            end)
        end

        task.wait(1)
        Toggles.AutoTPSea2.Value = false
        break
    end
end

function Func_AutoTPSea1()
    while Toggles.AutoTPSea1 and Toggles.AutoTPSea1.Value do
        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if not root then task.wait(0.5); continue end

        if IsInSea1() then
            Toggles.AutoTPSea1.Value = false
            break
        end

        root.CFrame = CFrame.new(-279, 323, -3057)
        root.AssemblyLinearVelocity = Vector3.zero
        task.wait(0.8)

        local prompt = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA('ProximityPrompt') then
                local at = obj.ActionText:lower()
                local n = obj.Name:lower()
                if at:find('sea 1') or at:find('go back') or at:find('enter sea 1') or n:find('sea1') then
                    prompt = obj
                    break
                end
            end
        end

        if prompt then
            local promptPart = prompt.Parent
            if promptPart and promptPart:IsA('BasePart') then
                root.CFrame = CFrame.new(promptPart.Position)
                root.AssemblyLinearVelocity = Vector3.zero
                task.wait(0.3)
            end
            pcall(function() fireproximityprompt(prompt) end)
            task.wait(0.3)
            pcall(function()
                prompt.HoldDuration = 0
                prompt:InputHoldBegin()
                task.wait(0.1)
                prompt:InputHoldEnd()
            end)
        end

        task.wait(1)
        Toggles.AutoTPSea1.Value = false
        break
    end
end

IslandTPTab:Section({Title = 'World Sea Teleport'})
IslandTPTab:Toggle({
    Title = 'Auto TP to Sea 2',
    Default = false,
    Callback = function(v)
        if v and IsInSea2() then
            Toggles.AutoTPSea2 = {Value = false}
            return
        end
        Toggles.AutoTPSea2 = {Value = v}
        Thread('Sea2.AutoTP', SafeLoop('Auto TP Sea 2', Func_AutoTPSea2), v)
    end
})
IslandTPTab:Toggle({
    Title = 'Auto TP to Sea 1',
    Default = false,
    Callback = function(v)
        if v and IsInSea1() then
            Toggles.AutoTPSea1 = {Value = false}
            return
        end
        Toggles.AutoTPSea1 = {Value = v}
        Thread('Sea2.AutoTP1', SafeLoop('Auto TP Sea 1', Func_AutoTPSea1), v)
    end
})

local NPCTPTab = window:Tab({Title = 'NPCs', Icon = 'rbxassetid://10734886004'})

NPCTPTab:Section({Title = 'Quest NPCs'})
NPCTPTab:Dropdown({
    Title = 'Quest NPC',
    Values = Tables.NPC_QuestList,
    Default = '',
    Callback = function(v)
        local map = {
            DungeonUnlock = 'DungeonPortalsNPC',
            SlimeKeyUnlock = 'SlimeCraftNPC'
        }

        SafeTeleportToNPC(tostring(v), map)
    end
})
NPCTPTab:Section({Title = 'Moveset & Mastery NPCs'})
NPCTPTab:Dropdown({
    Title = 'Moveset NPC',
    Values = Tables.NPC_MovesetList,
    Default = '',
    Callback = function(v)
        if v then
            SafeTeleportToNPC(tostring(v))
        end
    end
})
NPCTPTab:Dropdown({
    Title = 'Mastery NPC',
    Values = Tables.NPC_MasteryList,
    Default = '',
    Callback = function(v)
        if v then
            SafeTeleportToNPC(tostring(v))
        end
    end
})
NPCTPTab:Section({Title = 'Misc NPCs'})
NPCTPTab:Dropdown({
    Title = 'Misc NPC',
    Values = Tables.NPC_MiscList,
    Default = '',
    Callback = function(v)
        local map = {
            ArmHaki = 'HakiQuest',
            Observation = 'ObservationBuyer'
        }

        SafeTeleportToNPC(tostring(v), map)
    end
})
NPCTPTab:Dropdown({
    Title = 'All NPCs',
    Values = Tables.AllNPCList,
    Default = '',
    Callback = function(v)
        if v then
            SafeTeleportToNPC(tostring(v))
        end
    end
})

NPCTPTab:Button({
    Title = 'Refresh NPC List',
    Callback = function()
        table.clear(Tables.AllNPCList)
        for _, v in ipairs(PATH.InteractNPCs:GetChildren())do
            table.insert(Tables.AllNPCList, v.Name)
        end
        table.sort(Tables.AllNPCList)
        fnl:MakeNotification({
            Title = 'Refreshed',
            Description = 'NPC list updated. Re-open dropdown to see changes.',
            Duration = 3
        })
    end
})

--Window:Divider() -- Section: 'Misc'
local GraphicsTab = window:Tab({Title = 'Graphics', Icon = 'rbxassetid://7734053495'})

GraphicsTab:Section({Title = 'FPS'})
GraphicsTab:Toggle({
    Title = 'FPS Cap',
    Default = false,
    Callback = function(v)
        Toggles.LimitFPS = {Value = v}

        if not v and setfpscap then
            setfpscap(999)
        end
    end
})
GraphicsTab:Slider({
    Title = 'Max FPS',
    Value = {Min = 5, Max = 360, Default = 60},
    Callback = function(v)
        Options.LimitFPSValue = v

        if Toggles.LimitFPS and Toggles.LimitFPS.Value and setfpscap then
            setfpscap(v)
        end
    end
})
GraphicsTab:Toggle({
    Title = 'FPS Boost',
    Default = false,
    Callback = function(v)
        Toggles.FPSBoost = {Value = v}

        ApplyFPSBoost(v)
    end
})
GraphicsTab:Toggle({
    Title = 'FPS Boost [Autofarm]',
    Default = false,
    Callback = function(v)
        Toggles.FPSBoost_AF = {Value = v}

        if v then
            ApplyIslandWipe()
        end
    end
})
GraphicsTab:Section({Title = 'World'})
GraphicsTab:Toggle({
    Title = 'Fullbright',
    Default = false,
    Callback = function(v)
        Toggles.Fullbright = {Value = v}
    end
})
GraphicsTab:Toggle({
    Title = 'No Fog',
    Default = false,
    Callback = function(v)
        Toggles.NoFog = {Value = v}
    end
})
GraphicsTab:Toggle({
    Title = 'Disable 3D Render',
    Default = false,
    Callback = function(v)
        Toggles.Disable3DRender = {Value = v}

        RunService:Set3dRenderingEnabled(not v)
    end
})
GraphicsTab:Toggle({
    Title = 'Time Override',
    Default = false,
    Callback = function(v)
        Toggles.OverrideTime = {Value = v}
    end
})
GraphicsTab:Slider({
    Title = 'Time of Day',
    Value = {Min = 0, Max = 24, Default = 12},
    Callback = function(v)
        Options.OverrideTimeValue = v

        if Toggles.OverrideTime and Toggles.OverrideTime.Value then
            Lighting.ClockTime = v
        end
    end
})

local ServerTab = window:Tab({Title = 'Server', Icon = 'rbxassetid://10734932295'})

-- Auto Webhook Notifier
local WorldBossWebhook = "https://discord.com/api/webhooks/1495564490471641108/XwLUEpb15gMpT8VRDCIKFTSijkreKX0gve28JuJYLMfdIKRZguN3UlSb-I50mEJqJMgL"
local SeaBossWebhook = "https://discord.com/api/webhooks/1495564534784594101/HEWe__89brw9r7b63sCwXTYO67fD5w6YpBWlrrWva-4kDaMQu8mjYPhJ_j0D9ku1KD15"

local NotifiedBosses = {}
local SeaBossKeywordsWebhook = {'Kraken', 'SeaSerpent', 'seaserpent', 'kraken', 'Sea Serpent'}


local SpecialBossWebhookList = {
    {label = 'Strongest Shinobi Boss', match = 'strongestshinobi',  island = 'Ninja'},
    {label = 'Cosmic Being Boss',      match = 'cosmicbeingboss',   island = 'Boss'},
    {label = 'Alucard Boss',           match = 'alucardBoss',       island = 'Sailor'},
    {label = 'Jinwoo Boss',            match = 'jinwooboss',        island = 'Sailor'},
    {label = 'Aizen Boss',             match = 'aizenboss',         island = 'Hollow'},
    {label = 'Gojo Boss',              match = 'gojoboss',          island = 'Shibuya'},
    {label = 'Sukuna Boss',            match = 'sukunaboss',        island = 'Shibuya'},
    {label = 'Yuji Boss',              match = 'yujiboss',          island = 'Boss'}
}

local function GetJoinCodes()
    local jobId = game.JobId
    local placeId = game.PlaceId
    local cleanId = jobId:gsub('-', '')
    local code = "Zen_" .. cleanId
    local webLink = string.format("https://www.roblox.com/games/%s/game?gameInstanceId=%s", placeId, jobId)
    return code, webLink
end

local function SendWebhook(url, title, description, color)
    local plrCount = #game:GetService('Players'):GetPlayers()
    local maxPlrs = game:GetService('Players').MaxPlayers
    local code, webLink = GetJoinCodes()

    local fullDesc = description ..
        "\n\n**Player Count:** `" .. plrCount .. "/" .. maxPlrs .. "`" ..
        "\n\n**Join Code:**\n```\n" .. code .. "\n```" ..
        "\n> 📋 Copy the join code and paste it in **Zen Hub → Misc → Webhook → Join Code** textbox to teleport to this server!" ..
        "\n**[Click to Join](" .. webLink .. ")**"

    local data = {
        embeds = {{
            title = title,
            description = fullDesc,
            color = color or 16711680,
            footer = { text = "Zen Hub • " .. os.date("%X") }
        }}
    }

    local body = game:GetService("HttpService"):JSONEncode(data)
    local reqFunc = request or http_request
    if typeof(reqFunc) == 'function' then
        pcall(function()
            reqFunc({
                Url = url,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = body
            })
        end)
    end
end

local function IsSeaBoss(npcName)
    local clean = npcName:lower():gsub('%s+', '')
    for _, kw in ipairs(SeaBossKeywordsWebhook) do
        if clean:find(kw:gsub('%s+', ''), 1, true) then
            return true
        end
    end
    return false
end

local function GetSpecialBossEntry(npcName)
    local clean = npcName:lower():gsub('%s+', ''):gsub('_', '')
    for _, entry in ipairs(SpecialBossWebhookList) do
        local matchClean = entry.match:lower():gsub('%s+', ''):gsub('_', '')
        if clean:find(matchClean, 1, true) or matchClean:find(clean, 1, true) then
            return entry
        end
    end
    return nil
end

local IsPublicServer = false
task.spawn(function()
    local ok, serverType = pcall(function()
        local remote = game:GetService('RobloxReplicatedStorage'):WaitForChild('GetServerType', 3)
        return remote and remote:InvokeServer() or 'Unknown'
    end)
    if ok and serverType == 'VIPServer' then
        IsPublicServer = false
    elseif game.PrivateServerId ~= '' then
        IsPublicServer = false
    else
        IsPublicServer = true
    end
end)

local function IsSeaBossModel(npcName)
    local clean = npcName:lower():gsub('%s+', ''):gsub('_', '')
    local seaKeywords = {
        'kraken', 'seaserpent', 'seabeast', 'seaboss',
        'seadragon', 'seaMonster', 'seamonster'
    }
    for _, kw in ipairs(seaKeywords) do
        if clean:find(kw, 1, true) then
            return true
        end
    end
    return false
end

local function JoinByCode(code)
    local cleanCode = code:gsub('^Zen_', ''):gsub('^NTT_', ''):gsub('%s+', '')
    if #cleanCode == 32 then
        local jobId = cleanCode:sub(1,8) .. '-' ..
                      cleanCode:sub(9,12) .. '-' ..
                      cleanCode:sub(13,16) .. '-' ..
                      cleanCode:sub(17,20) .. '-' ..
                      cleanCode:sub(21,32)

        fnl:MakeNotification({Title = 'Joining', Description = 'Teleporting to server...', Duration = 3})

        local success, err = pcall(function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(
                game.PlaceId,
                jobId,
                game.Players.LocalPlayer
            )
        end)

        if not success then
            local ok2, err2 = pcall(function()
                game:GetService('TeleportService'):TeleportToPlaceInstance(
                    game.PlaceId,
                    jobId
                )
            end)

            if not ok2 then
                fnl:MakeNotification({
                    Title = 'Join Failed',
                    Description = 'Server may be full, private, or no longer exists.\nError: ' .. tostring(err2),
                    Duration = 6
                })
            end
        end
    else
        fnl:MakeNotification({
            Title = 'Error',
            Description = 'Invalid code! Must be 32 characters after Zen_\nGot: ' .. #cleanCode .. ' characters',
            Duration = 4
        })
    end
end



-- UI
local WebhookTab = window:Tab({Title = 'Webhook', Icon = 'rbxassetid://10734950020'})

WebhookTab:Section({Title = 'Join Server'})

WebhookTab:Input({
    Title = 'Join Code',
    Default = '',
    Placeholder = 'Enter Zen_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    ClearOnFocus = true,
    NumbersOnly = false,
    Callback = function(text, enterPressed)
        if enterPressed and text and text ~= '' then
            JoinByCode(text)
        end
    end
})

WebhookTab:Section({Title = 'Controls'})


-- Auto Watcher Loop
task.spawn(function()
    -- Wait a moment for IsPublicServer to be determined
    task.wait(4)

    while getgenv().ZenHub do
        task.wait(3)

if not IsPublicServer then
    task.wait(10)
    continue
end

-- Only send webhooks if more than 1 player in server
if #game:GetService('Players'):GetPlayers() <= 1 then
    task.wait(3)
    continue
end

        -- Check PATH.Mobs for world bosses and sea bosses
        for _, npc in pairs(PATH.Mobs:GetChildren()) do
            if not npc:IsA('Model') then continue end
            local hum = npc:FindFirstChildOfClass('Humanoid')
            if not (hum and hum.Health > 0) then continue end

            local key = npc.Name .. tostring(math.floor(hum.MaxHealth))
            if NotifiedBosses[key] then continue end

            local hpPercent = math.floor((hum.Health / hum.MaxHealth) * 100)

            if IsSeaBoss(npc.Name) then
                NotifiedBosses[key] = true
                local island = GetNearestIsland(npc:GetPivot().Position)
                SendWebhook(
                    SeaBossWebhook,
                    "🌊 Sea Boss Spawned!",
                    "**Boss:** `" .. npc.Name .. "`\n**Location:** `" .. island .. "`\n**HP:** `" .. hpPercent .. "%`",
                    3447003
                )
            else
                local entry = GetSpecialBossEntry(npc.Name)
                if entry then
                    NotifiedBosses[key] = true
                    SendWebhook(
                        WorldBossWebhook,
                        "⚔️ " .. entry.label .. " Spawned!",
                        "**Boss:** `" .. entry.label .. "`\n**Location:** `" .. entry.island .. "`\n**HP:** `" .. hpPercent .. "%`",
                        16711680
                    )
                end
            end
        end

        -- Also search all of workspace for Sea Bosses (Kraken/Sea Serpent spawn outside PATH.Mobs)
        if IsPublicServer then
            for _, obj in pairs(workspace:GetDescendants()) do
                if not obj:IsA('Model') then continue end

                local n = obj.Name:lower():gsub('%s+', ''):gsub('_', '')
                if not (n:find('kraken') or n:find('seaserpent') or n:find('seabeast')) then continue end

                local bossHP = obj:GetAttribute('_BossHP') or obj:GetAttribute('BossHP')
                local hum = obj:FindFirstChildOfClass('Humanoid')
                local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                    or (hum and hum.Health > 0)
                if not alive then continue end

                local maxHP = (hum and hum.MaxHealth) or tonumber(bossHP) or 0
                local curHP = (hum and hum.Health) or tonumber(bossHP) or 0
                local hpPct = maxHP > 0 and math.floor((curHP / maxHP) * 100) or 100

                local key = obj.Name .. tostring(math.floor(maxHP))
                if NotifiedBosses[key] then continue end

                NotifiedBosses[key] = true

                local bossPos = nil
                pcall(function() bossPos = obj:GetPivot().Position end)
                if not bossPos then
                    local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart
                    if bp then bossPos = bp.Position end
                end
                local island = bossPos and GetNearestIsland(bossPos) or 'Sea'

                local displayName = obj.Name
                if displayName:lower():find('kraken') then displayName = 'Kraken'
                elseif displayName:lower():find('seaserpent') or displayName:lower():find('sea serpent') then displayName = 'Sea Serpent'
                end

                SendWebhook(
                    SeaBossWebhook,
                    "🌊 Sea Boss Spawned!",
                    "**Boss:** `" .. displayName .. "`\n**Location:** `" .. island .. "`\n**HP:** `" .. hpPct .. "%`",
                    3447003
                )
            end
        end

        -- Cleanup dead entries
        for key in pairs(NotifiedBosses) do
            local alive = false
            for _, npc in pairs(PATH.Mobs:GetChildren()) do
                if npc:IsA('Model') then
                    local h = npc:FindFirstChildOfClass('Humanoid')
                    local k = npc.Name .. tostring(math.floor((h and h.MaxHealth) or 0))
                    if k == key and h and h.Health > 0 then alive = true; break end
                end
            end
            if not alive then
                -- Also check workspace descendants for sea bosses
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA('Model') then
                        local h = obj:FindFirstChildOfClass('Humanoid')
                        local bHP = obj:GetAttribute('_BossHP') or obj:GetAttribute('BossHP')
                        local maxHP = (h and h.MaxHealth) or tonumber(bHP) or 0
                        local k = obj.Name .. tostring(math.floor(maxHP))
                        if k == key then
                            local isAlive = (h and h.Health > 0) or (bHP and tonumber(bHP) and tonumber(bHP) > 0)
                            if isAlive then alive = true; break end
                        end
                    end
                end
            end
            if not alive then NotifiedBosses[key] = nil end
        end
    end
end)

ServerTab:Section({Title = 'Server Management'})

ServerTab:Button({Title="Redeem All Codes", Callback=function()
    for code, data in pairs(Modules.Codes.Codes) do
        if Plr.Data.Level.Value >= (data.LevelReq or 0) then
            fnl:MakeNotification({Title="Code", Description="Redeeming: "..code, Duration=3})
            Remotes.UseCode:InvokeServer(code); task.wait(2)
        end
    end
end})

loadstring(game:HttpGet("https://pastefy.app/HHTpYAfl/raw"))()

task.wait(0.5)

ServerTab:Button({
    Title = 'Hide Boss Status',
    Callback = function()
        local p = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BossStatusGUI")
        if p then
            local panel = p:FindFirstChild("BossPanel")
            if panel then
                panel.Visible = not panel.Visible
            end
        end
    end
})

ServerTab:Toggle({
    Title = 'Anti AFK',
    Default = true,
    Callback = function(v)
        Toggles.AntiAFK = {Value = v}
    end
})
ServerTab:Toggle({
    Title = 'Anti Kick (Client)',
    Default = false,
    Callback = function(v)
        Toggles.AntiKick = {Value = v}
    end
})
ServerTab:Toggle({
    Title = 'Auto Reconnect',
    Default = false,
    Callback = function(v)
        Toggles.AutoReconnect = {Value = v}

        if v then
            Func_AutoReconnect()
        end
    end
})
ServerTab:Toggle({
    Title = 'No Gameplay Paused',
    Default = false,
    Callback = function(v)
        Toggles.NoGameplayPaused = {Value = v}

        Thread('NoGameplayPaused', SafeLoop('Anti-Pause', Func_NoGameplayPaused), v)
    end
})
ServerTab:Button({
    Title = 'Rejoin',
    Callback = function()
        TeleportService:Teleport(game.PlaceId, Plr)
    end
})
ServerTab:Section({Title = 'Prompt'})
ServerTab:Toggle({
    Title = 'Instant Proximity Prompt',
    Default = false,
    Callback = function(v)
        Toggles.InstantPP = {Value = v}
    end
})
ServerTab:Section({Title = 'Auto Kick'})
ServerTab:Toggle({
    Title = 'Auto Kick',
    Default = true,
    Callback = function(v)
        Toggles.AutoKick = {Value = v}

        if v then
            InitAutoKick()
        end
    end
})
ServerTab:Dropdown({
    Title = 'Kick Type(s)',
    Values = {
        'Mod',
        'Player Join',
        'Public Server'
    },
    Default = {
        'Mod'
    },
    Multi = true,
    Callback = function(v)
        Options.SelectedKickType = ToSet(v)

        CheckServerTypeSafety()
    end
})

Options.SelectedKickType = {Mod = true}


task.spawn(function()
    while task.wait() do
        if not getgenv().ZenHub then
            break
        end
        if Toggles.Fullbright and Toggles.Fullbright.Value then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
        elseif Toggles.OverrideTime and Toggles.OverrideTime.Value then
            Lighting.ClockTime = Options.OverrideTimeValue or 12
        end
        if Toggles.NoFog and Toggles.NoFog.Value then
            Lighting.FogEnd = 9e9
        end
    end
end)

Connections.Player_General = RunService.Stepped:Connect(function()
    local hum = Plr.Character and Plr.Character:FindFirstChildOfClass('Humanoid')

    if hum then
        if Toggles.WS and Toggles.WS.Value then
            hum.WalkSpeed = Options.WSValue or 16
        end
        if Toggles.JP and Toggles.JP.Value then
            hum.JumpPower = Options.JPValue or 50
            hum.UseJumpPower = true
        end
        if Toggles.HH and Toggles.HH.Value then
            hum.HipHeight = Options.HHValue or 2
        end
    end

    workspace.Gravity = (Toggles.Grav and Toggles.Grav.Value) and (Options.GravValue or 196) or 192

    if Toggles.FOV and Toggles.FOV.Value then
        workspace.CurrentCamera.FieldOfView = Options.FOVValue or 70
    end
    if Toggles.Zoom and Toggles.Zoom.Value then
        Plr.CameraMaxZoomDistance = Options.ZoomValue or 128
    end
end)

RunService.Stepped:Connect(function()
    if Shared.Farm and Shared.Target then
        local char = GetCharacter()

        if char then
            for _, part in pairs(char:GetDescendants())do
                if part:IsA('BasePart') and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)
game:GetService('ProximityPromptService').PromptButtonHoldBegan:Connect(function(prompt)
    if Toggles.InstantPP and Toggles.InstantPP.Value then
        prompt.HoldDuration = 0
    end
end)

local NotifFrame = PGui:WaitForChild('NotificationUI'):WaitForChild('NotificationsFrame')
local NotificationBlacklist = {
    "You don't have this item!",
    'Not enough '
}

function ProcessNotification(frame)
    task.delay(0.01, function()
        if not (Toggles.AutoDeleteNotif and Toggles.AutoDeleteNotif.Value) then
            return
        end
        if not frame or not frame.Parent then
            return
        end

        local lbl = frame:FindFirstChild('Txt', true)

        if lbl and lbl:IsA('TextLabel') then
            local txt = lbl.Text:lower()

            for _, phrase in ipairs(NotificationBlacklist)do
                if txt:find(phrase:lower()) then
                    frame.Visible = false

                    break
                end
            end
        end
    end)
end

NotifFrame.ChildAdded:Connect(ProcessNotification)

for _, c in pairs(NotifFrame:GetChildren())do
    ProcessNotification(c)
end

task.spawn(function()
    while task.wait() do
        if not Shared.Farm or Shared.MerchantBusy then
            continue
        end
        if not Shared.Target or not Shared.TargetValid then
            continue
        end

        local char = GetCharacter()
        local target = Shared.Target

        if not char or not target then
            continue
        end

        local npcHum = target:FindFirstChildOfClass('Humanoid')
        local npcRoot = target:FindFirstChild('HumanoidRootPart')
        local root = char:FindFirstChild('HumanoidRootPart')

        if not (npcHum and npcRoot and root) then
            continue
        end

        EquipWeapon()

        if npcHum.Health <= 0 and not (Toggles.InstaKill and Toggles.InstaKill.Value) then
            continue
        end

        local dist = (root.Position - npcRoot.Position).Magnitude
        local delay = Options.M1Speed or 0.15

        Shared.LastM1 = Shared.LastM1 or 0

        if dist <= 35 and (time() - Shared.LastM1) >= delay then
            pcall(function()
                Remotes.M1:FireServer()
            end)
            Shared.LastM1 = time()
        end
    end
end)
task.spawn(function()
    while task.wait() do
        if not Shared.Farm or Shared.MerchantBusy then
            Shared.Target = nil
            continue
        end
        local char = GetCharacter()
        if not char or Shared.Recovering then
            continue
        end
        if Shared.TargetValid and (not Shared.Target or not Shared.Target.Parent or (Shared.Target:FindFirstChildOfClass('Humanoid') and Shared.Target:FindFirstChildOfClass('Humanoid').Health <= 0)) then
            Shared.KillTick = tick()
            Shared.TargetValid = false
        end
        if tick() - Shared.KillTick < (Options.TargetTPCD or 0) then
            continue
        end

        HandleSummons()

        local cur, max = GetCurrentPity()
        local isPityReady = (Toggles.PityBossFarm and Toggles.PityBossFarm.Value) and cur >= (max - 1)
        local found = false

        if isPityReady then
            local t, isl, ft = GetPityTarget()
            if t then
                found = true
                Shared.Target = t
                Shared.TargetValid = true
                UpdateSwitchState(t, ft)
                ExecuteFarmLogic(t, isl, ft)
            end
        end

        if not found then
            -- Cosmic Boss
            if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
                local boss = FindLiveBossAnywhere(CosmicBossKeywords)
                if boss then
                    found = true
                    Shared.Target = boss
                    Shared.TargetValid = true
                     EquipWeapon()
                    UpdateSwitchState(boss, 'Boss')
                    ExecuteFarmLogic(boss, 'Boss', 'Boss')
                    pcall(function() Remotes.M1:FireServer() end)
                end
            end

            -- Dio Boss
            if not found and Toggles.AutoKillDio and Toggles.AutoKillDio.Value then
                local boss = GetBestMobCluster({
                    ['TheWorldBoss_Normal'] = true,
                    ['TheWorldBoss_Medium'] = true,
                    ['TheWorldBoss_Hard'] = true,
                    ['TheWorldBoss_Extreme'] = true
                })
                if boss then
                    found = true
                    Shared.Target = boss
                    Shared.TargetValid = true
                     EquipWeapon()
                    UpdateSwitchState(boss, 'Boss')
                    ExecuteFarmLogic(boss, GetNearestIsland(boss:GetPivot().Position), 'Boss')
                    pcall(function() Remotes.M1:FireServer() end)
                end
            end

            -- Sea Boss
            -- Sea Boss
if not found and Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value then
    local boss = nil
    
    -- Search PATH.Mobs first
    for _, npc in pairs(PATH.Mobs:GetChildren()) do
        if npc:IsA('Model') then
            local n = npc.Name:lower():gsub('%s+', ''):gsub('_', '')
            if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                local hum = npc:FindFirstChildOfClass('Humanoid')
                local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                    or (hum and hum.Health > 0)
                if alive then boss = npc; break end
            end
        end
    end
    
    -- Search all of workspace if not found in PATH.Mobs
    if not boss then
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:IsA('Model') then
                local n = npc.Name:lower():gsub('%s+', ''):gsub('_', '')
                if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                    local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                    local hum = npc:FindFirstChildOfClass('Humanoid')
                    local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)
                        or (hum and hum.Health > 0)
                    if alive then boss = npc; break end
                end
            end
        end
    end
    
    if boss then
        found = true
        Shared.Target = boss
        Shared.TargetValid = true
        Shared.SeaBossFound = true
        UpdateSwitchState(boss, 'Boss')
        
        local root = char and char:FindFirstChild('HumanoidRootPart')
        if root then
            local bossPos = GetSeaBossPosition(boss)
            if bossPos then
                local yOffset = Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET
                local targetPos = bossPos + Vector3.new(0, yOffset, 0)
                local dest = CFrame.new(targetPos)
                local dist = (root.Position - targetPos).Magnitude
                
                if dist > 3 then
                    local speed = Options.TweenSpeed or 160
                    local duration = math.clamp(dist / speed, 0.05, 0.4)
                    local tw = TweenService:Create(
                        root,
                        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {CFrame = dest}
                    )
                    tw:Play()
                end
                
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end
        end
        
        EquipWeapon()
        pcall(function() Remotes.M1:FireServer() end)
        Shared.LastM1 = time()
        FireSkillsWithPositionLock()
        
        -- InstaKill attempt
        if Toggles.InstaKill and Toggles.InstaKill.Value then
            local hum = boss:FindFirstChildOfClass('Humanoid')
            if hum then pcall(function() hum.Health = 0 end) end
        end
    else
        Shared.SeaBossFound = false
    end
end

            -- Easter Egg Farm (Bunny)
            if not found and Toggles.AutoFarmEggs and Toggles.AutoFarmEggs.Value then
                local bunnyDict = {}
                for _, npc in pairs(PATH.Mobs:GetChildren()) do
                    if npc:IsA('Model') then
                        local n = npc.Name:lower()
                        if n:find('bunny') or n:find('easter') or n:find('rabbit') then
                            bunnyDict[npc.Name:gsub('%d+$', '')] = true
                        end
                    end
                end
                local target = GetBestMobCluster(bunnyDict)
                if target then
                    found = true
                    Shared.Target = target
                    Shared.TargetValid = true
                     EquipWeapon()
                    UpdateSwitchState(target, 'Mob')
                    ExecuteFarmLogic(target, GetNearestIsland(target:GetPivot().Position), 'Mob')
                    pcall(function() Remotes.M1:FireServer() end)
                end
            end

            -- Normal Priority Order
            if not found then
                for i = 1, #DefaultPriority do
                    local taskName = DefaultPriority[i]
                    if not taskName then continue end

                    if isPityReady and (
                        taskName == 'World Boss Farm' or
                        taskName == 'Farm All Mobs' or
                        taskName == 'Selected Mob Farm' or
                        taskName == 'Boss' or
                        taskName == 'All Mob Farm' or
                        taskName == 'Mob'
                    ) then
                        continue
                    end

                    local t, isl, ft = CheckTask(taskName)
                    if t then
                        found = true
                        Shared.Target = typeof(t) == 'Instance' and t or nil
                        Shared.TargetValid = true
                        UpdateSwitchState(t, ft)
                        if taskName ~= 'Merchant' and taskName ~= 'Auto Merchant' and t then
                            ExecuteFarmLogic(t, isl, ft)
                        end
                        break
                    end
                end
            end
        end

        if not found then
            Shared.Target = nil
            UpdateSwitchState(nil, 'None')
        end
    end
end)
task.spawn(function()
    while task.wait(0.2) do
        if not Shared.Target or not Shared.TargetValid then
            FarmStatus:SetDesc('Status: Idle')

            continue
        end

        local target = Shared.Target
        local hum = target:FindFirstChildOfClass('Humanoid')
        local mobName = target.Name or 'Unknown'
        local hp = hum and math.floor(hum.Health) or 0
        local maxhp = hum and math.floor(hum.MaxHealth) or 0
        local questName = 'None'

        if Shared.QuestNPC and Modules.Quests and Modules.Quests.RepeatableQuests then
            local q = Modules.Quests.RepeatableQuests[Shared.QuestNPC]

            if q and q.requirements and q.requirements[1] then
                questName = q.requirements[1].npcType or 'Unknown'
            end
        end

        FarmStatus:SetDesc('Mob: ' .. mobName .. '\nHP: ' .. hp .. '/' .. maxhp .. '\nQuest: ' .. questName)
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then
            continue
        end
        if not (Toggles.BringMob and Toggles.BringMob.Value) then
            continue
        end
        if not Shared.Target then
            continue
        end

        local target = Shared.Target
        local targetRoot = target:FindFirstChild('HumanoidRootPart')

        if not targetRoot then
            continue
        end

        for _, mob in pairs(PATH.Mobs:GetChildren())do
            if mob ~= target and mob:IsA('Model') then
                local hum = mob:FindFirstChildOfClass('Humanoid')
                local root = mob:FindFirstChild('HumanoidRootPart')

                if hum and root and hum.Health > 0 then
                    if IsSmartMatch(mob.Name, target.Name) then
                        if (root.Position - targetRoot.Position).Magnitude <= 80 then
                            root.CFrame = targetRoot.CFrame * CFrame.new(math.random(-5, 5), 0, math.random(-5, 5))
                            root.AssemblyLinearVelocity = Vector3.zero
                        end
                    end
                end
            end
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        if not getgenv().ZenHub then
            break
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if root and not Shared.MovingIsland then
            local pos = root.Position

            if pos.Y > 5000 or math.abs(pos.X) > 10000 or math.abs(pos.Z) > 10000 then
                Shared.Recovering = true

                fnl:MakeNotification({
                    Title = 'Recovery',
                    Description = 'Out of bounds detected! Resetting...',
                    Duration = 5
                })

                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero

                if IslandCrystals.Starter then
                    root.CFrame = IslandCrystals.Starter:GetPivot() * CFrame.new(0, 5, 0)

                    task.wait(1)
                end

                Shared.Recovering = false
            end
        end
    end
end)
task.spawn(Func_AutoTrade)
ACThing(true)
task.spawn(function()
    while getgenv().ZenHub do
        if Remotes.ReqInventory then
            Remotes.ReqInventory:FireServer()
        end

        task.wait(30)
    end
end)
task.spawn(function()
    if Remotes.ReqInventory then
        Remotes.ReqInventory:FireServer()
    end

    local timeout = 0

    while not Shared.InventorySynced and timeout < 5 do
        task.wait(0.15)

        timeout = timeout + 0.15
    end
end)

getgenv().ZenHub = true

local ConfigName = 'ZenHub_Config.json'

local function SaveConfig()
    pcall(function()
        if not writefile then return end
        if not window._configElements then return end
        local data = {}
        for flag, element in pairs(window._configElements) do
            pcall(function()
                local value = element.getValue()
                if typeof(value) == 'Color3' then
                    value = {R = value.R, G = value.G, B = value.B, _type = 'Color3'}
                elseif typeof(value) == 'EnumItem' then
                    value = {_type = 'EnumItem', _enum = tostring(value.EnumType), _value = value.Name}
                end
                data[flag] = value
            end)
        end
        writefile(ConfigName, HttpService:JSONEncode(data))
    end)
end

local function KillAllThreads()
    local function killTable(tbl)
        for k, v in pairs(tbl) do
            if typeof(v) == 'thread' then
                pcall(task.cancel, v)
                tbl[k] = nil
            elseif type(v) == 'table' then
                killTable(v)
            end
        end
    end
    killTable(Flags)
    for k, v in pairs(Toggles) do
        pcall(function()
            if type(v) == 'table' and v.Value ~= nil then
                v.Value = false
            end
        end)
    end
end

local function LoadConfig()
    pcall(function()
        if not (readfile and isfile) then return end
        if not isfile(ConfigName) then return end
        if not window._configElements then return end
        local raw = readfile(ConfigName)
        if not raw or raw == '' then return end
        local ok, data = pcall(function()
            return HttpService:JSONDecode(raw)
        end)
        if not ok or type(data) ~= 'table' then return end

        KillAllThreads()
        task.wait(0.5)

        for flag, value in pairs(data) do
            pcall(function()
                local element = window._configElements[flag]
                if not element then return end
                if type(value) == 'table' and value._type == 'Color3' then
                    value = Color3.new(value.R, value.G, value.B)
                elseif type(value) == 'table' and value._type == 'EnumItem' then
                    value = Enum[value._enum:gsub('Enum%.', '')][value._value]
                elseif type(value) == 'table' and not value._type then
                    local isArray = false
                    for k in pairs(value) do
                        if type(k) == 'number' then
                            isArray = true
                            break
                        end
                    end
                    if isArray then
                        local set = {}
                        for _, v in ipairs(value) do
                            set[v] = true
                        end
                        value = set
                    end
                end
                element.setValue(value)
            end)
        end

        task.wait(0.3)

        for flag, value in pairs(data) do
            pcall(function()
                if value == false then return end
                local element = window._configElements[flag]
                if not element then return end
                if type(value) == 'table' and value._type == 'Color3' then
                    value = Color3.new(value.R, value.G, value.B)
                elseif type(value) == 'table' and value._type == 'EnumItem' then
                    value = Enum[value._enum:gsub('Enum%.', '')][value._value]
                elseif type(value) == 'table' and not value._type then
                    local isArray = false
                    for k in pairs(value) do
                        if type(k) == 'number' then
                            isArray = true
                            break
                        end
                    end
                    if isArray then
                        local set = {}
                        for _, v in ipairs(value) do
                            set[v] = true
                        end
                        value = set
                    end
                end
                if Toggles[flag] ~= nil then
                    if type(Toggles[flag]) == 'table' then
                        Toggles[flag].Value = value
                    else
                        Toggles[flag] = value
                    end
                end
                Options[flag] = value
                if element.callback then
                    pcall(element.callback, value)
                elseif element.Callback then
                    pcall(element.Callback, value)
                end
            end)
        end
    end)
end

task.spawn(function()
    task.wait(2)
    LoadConfig()
end)

task.spawn(function()
    task.wait(10)
    while getgenv().ZenHub do
        SaveConfig()
        task.wait(30)
    end
end)

Plr.CharacterAdded:Connect(function()
    task.wait(1.5)
    SaveConfig()
end)

local _wasActive = true
game:GetService('RunService').Heartbeat:Connect(function()
    if not getgenv().ZenHub and _wasActive then
        _wasActive = false
        SaveConfig()
    end
end)

fnl:MakeNotification({
    Title = 'Zen Hub',
    Description = 'Script Loaded!',
    Duration = 5
})