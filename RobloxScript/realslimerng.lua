local Library = loadstring(game:HttpGet('https://pastefy.app/50VL9o2U/raw'))()
local gameName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name
local window = Library.new('Zen Hub -' .. "<font color='rgb(127, 255, 212)'> " .. gameName .. ' </font>', 'SlimeRNGConfigs')

window:SetToggleKey(Enum.KeyCode.RightControl)
window:Notify({
    Title = 'Slime RNG Hub',
    Description = 'Loaded successfully!',
    Duration = 3,
    Icon = 'rbxassetid://10709775704',
})

local existingGui = game:GetService('CoreGui'):FindFirstChild('Alc')

if existingGui then
    existingGui:Destroy()
end

local TweenService = game:GetService('TweenService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local RunService = game:GetService('RunService')
local TeleportService = game:GetService('TeleportService')
local LocalPlayer = Players.LocalPlayer

function getRemote(serviceName)
    return ReplicatedStorage:WaitForChild('Packages'):WaitForChild('_Index'):WaitForChild('leifstout_networker@0.3.1'):WaitForChild('networker'):WaitForChild('_remotes'):WaitForChild(serviceName):WaitForChild('RemoteFunction')
end

local DataService = require(ReplicatedStorage.Packages.DataService).client
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RollService
local RollServiceAvailable = false
local success, result = pcall(function()
    RollService = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
end)

if success then
    RollServiceAvailable = true

    warn('RollService loaded successfully!')
else
    warn('Executor does not support RollService, skipping... | ' .. tostring(result))
end

local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SettingsServiceClient = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceClient)
local GoopGunServiceUtils = require(ReplicatedStorage.Source.Features.GoopGun.GoopGunServiceUtils)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local GameplayServiceClient = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

function getZonesFromWorkspace()
    local zonesFolder = workspace:FindFirstChild('Zones')
    local names, map = {}, {}

    if zonesFolder then
        for _, child in pairs(zonesFolder:GetChildren())do
            local zNum = tonumber(child.Name)

            if zNum then
                local key = tostring(zNum)

                if not map[key] then
                    table.insert(names, key)

                    map[key] = zNum
                end
            end
        end
    end

    table.sort(names, function(a, b)
        return tonumber(a) < tonumber(b)
    end)

    if #names == 0 then
        names = {
            '1',
        }
        map = {
            ['1'] = 1,
        }
    end

    return names, map
end
function teleportToZone(zoneNumber)
    pcall(function()
        getRemote('ZonesService'):InvokeServer('requestTeleportZone', zoneNumber)
    end)
end

function getplayermaxzone()
    local zone = DataService:get('maxZone') or 1

    return math.max(zone, 1)
end

function getplayercurrentzone()
    local currentZone = DataService:get('zone') or 1

    currentZone = math.max(currentZone, 1)

    return currentZone
end

function getHighestZoneNumber()
    local zonesFolder = workspace:FindFirstChild('Zones')

    if not zonesFolder then
        return 1
    end

    local highest = 1

    for _, child in pairs(zonesFolder:GetChildren())do
        local zNum = tonumber(child.Name)

        if zNum and zNum > highest then
            highest = zNum
        end
    end

    return highest
end
function getZoneFolder(zoneNumber)
    local zonesFolder = workspace:FindFirstChild('Zones')

    if not zonesFolder then
        return nil
    end

    return zonesFolder:FindFirstChild(tostring(zoneNumber))
end
function getGameplayFolder()
    for _, child in pairs(workspace:GetChildren())do
        if child.Name:lower():find('gameplay') then
            return child
        end
    end
end
function getEnemiesInZone(zoneFolder)
    local roots = {}

    if not zoneFolder then
        return roots
    end

    function scan(folder)
        for _, child in pairs(folder:GetChildren())do
            local root = child:FindFirstChild('RootPart') or child:FindFirstChild('HumanoidRootPart')

            if root then
                table.insert(roots, root)
            elseif child:IsA('Folder') or child:IsA('Model') then
                scan(child)
            end
        end
    end

    scan(zoneFolder)

    return roots
end
function getEnemiesForCurrentZone()
    local currentZone = getplayermaxzone()
    local zoneFolder = getZoneFolder(currentZone)

    if zoneFolder then
        local enemies = getEnemiesInZone(zoneFolder)

        if #enemies > 0 then
            return enemies
        end
    end

    local enemies = {}
    local gf = getGameplayFolder()

    if gf then
        local ef = gf:FindFirstChild('Enemies')

        if ef then
            for _, enemy in pairs(ef:GetChildren())do
                local r = enemy:FindFirstChild('RootPart') or enemy:FindFirstChild('HumanoidRootPart')

                if r then
                    table.insert(enemies, r)
                end
            end
        end
    end

    return enemies
end
function getClosestEnemyInZone(maxDist)
    local character = LocalPlayer.Character

    if not character then
        return nil
    end

    local rootPart = character:FindFirstChild('HumanoidRootPart')

    if not rootPart then
        return nil
    end

    local closest, closestDist = nil, maxDist or math.huge

    for _, enemyRoot in pairs(getEnemiesForCurrentZone())do
        local dist = (rootPart.Position - enemyRoot.Position).Magnitude

        if dist < closestDist then
            closestDist = dist
            closest = enemyRoot
        end
    end

    return closest
end

_G.Roll = false
_G.Equip = false
_G.Items = false
_G.Area = false
_G.BuyZone = false
_G.Upgrade = false
_G.Rebirth = false
_G.Boost = false
_G.TransferXP = false
_G.UnlockRecipe = false
_G.ClaimIndex = false
_G.FeedSlime = false
_G.FeedEquipped = false
_G.InfJump = false
_G.Noclip = false
_G.Fly = false
_G.AntiAFK = false
_G.AutoFarmZone = false
_G.KillAura = false

local _opRapidRollActive = false
local _opAutoFireActive = false
local _opSkipScreensActive = false
local _origFireRate = nil
local _origRange = nil
local _origDamage = nil
local _origOwnsUpgrade = nil
local _origNormalizeQueue = nil
local _origApplyToRollResults = nil

local slimeNames = {
    'None',
    'guest',
    'ninja',
    'buzz',
    'stormy',
    'bucky',
    'frankenSlime',
    'buggy',
    'mushy',
    'leafy',
    'orca',
    'brutis',
    'spidey',
    'random',
    'rocky',
    'lucky',
    'stump',
    'lily',
    'icy',
    'orbit',
    'aegis',
    'wicked',
    'king',
    'goopy',
    'sunset',
    'fin',
    'cat',
    'axolotl',
    'glo',
    'spike',
    'boomy',
    'pokey',
    'slimeSlime',
    'unicorn',
    'wizzy',
    'flour',
    'shelly',
    'derpy',
    'otto',
    'halo',
    'bomber',
    'ufo',
    'witchy',
    'blackhole',
    'ember',
    'crafty',
    'thorn',
    'geode',
    'slimeSlimeSlime',
    'astro',
    'puffy',
    'pumpkin',
    'ouchy',
    'sharky',
    'dino',
    'sunny',
    'monke',
    'prickly',
    'zoomy',
    'waxie',
    'drakey',
    'germy',
    'palmy',
    'snazzy',
    'frosty',
    'melly',
    'mato',
    'bemmy',
}
local slimeServerIds = {}

for _, name in pairs(slimeNames)do
    if name ~= 'None' then
        slimeServerIds[name] = '-' .. name
    end
end

local allFoodItems = {
    'drumstick',
    'apple',
    'avocado',
    'banana',
    'watermelon',
    'cherries',
    'carrot',
    'pizza',
    'broccoli',
    'chicken',
    'grapes',
}
local foodNames = {
    'None',
}

for _, f in pairs(allFoodItems)do
    table.insert(foodNames, f)
end

local knownCodes = {
    'SLIMERGY',
    'RELEASE',
    'UPDATE1',
    'SORRYFORBUGS',
    'FREEBOOST',
    '1MVISITS',
    'THANKYOU',
    'SORRY',
    'BUGFIX',
    'LAUNCH',
    'SLIME',
    'BOOST',
    'LUCK',
    'ROLL',
    'UPDATE2',
    'UPDATE3',
    'HOTFIX',
    'DISCORD',
    'TWITTER',
    '100K',
    '500K',
    '1M',
    '2M',
    '5M',
}
local upgradeCategories = {
    ['Main - Rolls'] = {
        'rollSpeed1',
        'rollSpeed2',
        'rollSpeed3',
        'rollSpeed4',
        'rollSpeed5',
        'rollSpeed6',
        'goldenRolls',
        'goldenRolls2',
        'goldenRolls3',
        'goldenRolls4',
        'diamondRolls',
        'diamondRolls2',
        'diamondRolls3',
        'diamondRolls4',
        'voidRolls',
        'voidRolls2',
        'voidRolls3',
        'voidRolls4',
        'cloverRolls1',
        'cloverRolls2',
        'cloverRolls3',
        'cloverRolls4',
        'cloverRolls5',
        'bonusRolls1',
        'bonusRolls2',
        'bonusRolls3',
        'extraRollChance1',
        'extraRollChance2',
        'extraRollChance3',
        'autoRoll',
    },
    ['Main - Luck'] = {
        'luck1',
        'luck2',
        'luck3',
        'luck4',
        'luck5',
        'luck6',
        'luck7',
        'luck8',
        'luck9',
        'luck10',
        'luck11',
        'luck12',
        'luck13',
        'luck14',
        'luck15',
        'friendLuck1',
        'friendLuck2',
        'friendLuck3',
        'friendLuck4',
        'friendLuck5',
        'friendLuck6',
        'friendLuckBoost1',
        'friendLuckBoost2',
        'friendLuckBoost3',
        'friendLuckBoost4',
        'shinySlimes',
        'shinyEnemies',
        'shinyEnemyChance1',
    },
    ['Main - Enemies'] = {
        'bigEnemies',
        'bigSlimes',
        'hugeEnemies',
        'hugeSlimes',
        'hugeEnemyChance1',
        'bigEnemyChance1',
        'invertedEnemies',
        'invertedSlimes',
        'invertedEnemyChance1',
        'enemyCount2',
        'enemyCount3',
        'enemyCount4',
        'enemyCount5',
        'enemyCount6',
        'enemyCount7',
        'enemySpawnSpeed1',
        'enemySpawnSpeed2',
        'enemySpawnSpeed3',
        'slimeTargetRange1',
        'slimeTargetRange2',
        'slimeTargetRange3',
    },
    ['Main - Slots & Goop'] = {
        'slots2',
        'slots3',
        'slots4',
        'slots5',
        'slots6',
        'backpack',
        'goop',
        'goopDropRate1',
        'goopDropRate2',
        'goopDropRate3',
        'goopDropRate4',
        'goopDropRate5',
        'goopDropRate6',
    },
    ['Player Tree'] = {
        'walkSpeed1',
        'walkSpeed2',
        'walkSpeed3',
        'magnet1',
        'magnet2',
        'magnet3',
        'teleporter',
    },
    ['Loot Tree - Coins'] = {
        'coinIncome1',
        'coinIncome2',
        'coinIncome3',
        'coinIncome4',
        'coinIncome5',
        'coinIncome6',
        'coinIncome7',
        'coinIncome8',
        'coinIncome9',
        'coinIncome10',
        'coinIncome11',
        'coinIncome12',
        'coinIncome13',
        'lootCurrency',
        'lootLuck',
    },
    ['Loot Tree - Overkill'] = {
        'overkill1',
        'overkill2',
        'overkill3',
        'overkill4',
        'overkill5',
        'overkill6',
    },
    ['Loot Tree - Food'] = {
        'lootApple',
        'lootBanana',
        'lootCarrot',
        'lootCherries',
        'lootChicken',
        'lootDrumstick',
        'lootGrapes',
        'lootPizza',
        'lootWatermelon',
        'lootRollSpeed',
        'lootUltraLuck',
    },
    ['Loot Tree - Offline'] = {
        'offlineLootAmount1',
        'offlineLootAmount2',
        'offlineLootAmount3',
        'offlineLootAmount4',
        'offlineLootAmount5',
    },
}
local allUpgrades = {}

for _, upgrades in pairs(upgradeCategories)do
    for _, v in pairs(upgrades)do
        table.insert(allUpgrades, v)
    end
end

local categoryNames = {
    'ALL',
}

for k in pairs(upgradeCategories)do
    table.insert(categoryNames, k)
end

local InfoSection = window:CreateSection('Information')
local MainSection = window:CreateSection('Main')
local MiscSection = window:CreateSection('Misc')
local ConfigSection = window:CreateSection('Settings')
local InfoTab = InfoSection:CreateTab('Info', 'rbxassetid://97650943483989')

InfoTab:CreateInfoSection({
    PlayerGreeting = 'Hello, {Player}!',
    PlayerSubtitle = '{Player} - Zen Hub',
    ServerLabel = 'Server',
    ServerDesc = "Information on the session you're currently in",
    ServerStats = {
        {
            Label = 'Players',
            Value = tostring(#Players:GetPlayers()),
        },
        {
            Label = 'Maximum Players',
            Value = tostring(Players.MaxPlayers),
        },
        {
            Label = 'Latency',
            Value = math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()) .. 'ms',
        },
        {
            Label = 'Server Region',
            Value = 'US',
        },
        {
            Label = 'In server for',
            Value = '00:00:00',
        },
        {
            Label = 'Join Script',
            Value = 'Tap to copy',
        },
    },
    Discord = 'Tap to join the Discord Server',
    DiscordUrl = 'https://discord.gg/GGuxzmmG8A',
    JoinCallback = function()
        setclipboard('https://discord.gg/GGuxzmmG8A')
    end,
    WaveTitle = 'Executor : ' .. identifyexecutor(),
    WaveBody = 'Your executor seems to support this script.',
    WaveColor = Color3.fromRGB(160, 30, 30),
    FriendsTitle = 'Friends',
    FriendsDesc = 'Find out what your friends are currently doing',
    Friends = {
        {
            Label = 'In Server',
            Value = '0',
        },
        {
            Label = 'Offline',
            Value = '0',
        },
        {
            Label = 'Online',
            Value = '0',
        },
        {
            Label = 'All',
            Value = '0',
        },
    },
})

local FarmTab = MainSection:CreateTab('Farm', 'rbxassetid://76457336832864')

FarmTab:CreateSection('Roll & Equip')

local rollMode = 'Game Roll'

FarmTab:CreateDropdown({
    Name = 'Roll Mode',
    Options = {
        'Game Roll',
        'Script Roll',
    },
    Default = 'Game Roll',
    Flag = 'RollMode',
    Callback = function(selected)
        rollMode = selected
    end,
})
FarmTab:CreateToggle({
    Name = 'Auto Roll',
    Default = false,
    Flag = 'AutoRoll',
    Callback = function(enabled)
        _G.Roll = enabled

        if enabled then
            task.spawn(function()
                while _G.Roll do
                    task.wait(0.1)
                    pcall(function()
                        if rollMode == 'Game Roll' and RollServiceAvailable then
                            RollService:activateRollButton()
                        else
                            getRemote('RollService'):InvokeServer('requestRoll')
                        end
                    end)
                end
            end)
        end
    end,
})

_G.MasterRollFarm = false

local connections = {}

FarmTab:CreateToggle({
    Name = 'Unlock Gamepasses (Luck,Fast Roll,lucky Roll)',
    Default = false,
    Flag = 'MasterRollFarm',
    Callback = function(enabled)
        _G.MasterRollFarm = enabled

        for _, conn in pairs(connections)do
            if conn then
                conn:Disconnect()
            end
        end

        connections = {}

        local RollSlice = require(game:GetService('ReplicatedStorage').Source.Features.Roll.RollSlice)
        local RollUtils = require(game:GetService('ReplicatedStorage').Source.Features.Roll.RollServiceUtils)
        local RollServiceClient = require(game:GetService('ReplicatedStorage').Source.Features.Roll.RollServiceClient)

        if enabled then
            RollSlice.instantRevealRoll(true)
            RollSlice.rollSpeed(999)
            RollSlice.hiddenRoll(false)

            local oldResult = RollUtils.getRollResult

            RollUtils.getRollResult = function()
                return {
                    result = 6,
                    isBonus = true,
                    bonusStreak = 999,
                }
            end
            connections.autoRoll = task.spawn(function()
                while _G.MasterRollFarm do
                    task.wait(0.01)
                    pcall(function()
                        RollServiceClient:rollDice()
                    end)
                    pcall(function()
                        local remote = getRemote('RollService')

                        if remote then
                            remote:FireServer('Roll')
                        end
                    end)
                end
            end)
            connections.luckRain = task.spawn(function()
                while _G.MasterRollFarm do
                    task.wait(0.1)
                    pcall(function()
                        RollSlice.actions.triggerLuckRain(100)
                    end)
                end
            end)
        else
            RollSlice.instantRevealRoll(true)
            RollSlice.rollSpeed(10)
            RollSlice.hiddenRoll(true)

            if oldResult then
                RollUtils.getRollResult = oldResult
            end
        end
    end,
})
FarmTab:CreateToggle({
    Name = 'Auto Equip Best Slime',
    Default = false,
    Flag = 'AutoEquip',
    Callback = function(enabled)
        _G.Equip = enabled

        if enabled then
            task.spawn(function()
                while _G.Equip do
                    task.wait(1)
                    pcall(function()
                        getRemote('InventoryService'):InvokeServer('requestEquipBest')
                    end)
                end
            end)
        end
    end,
})
FarmTab:CreateSection('Slimes Mob (Zone-Aware)')

local mobHeightOffset = 3
local mobTweenSpeed = 100
local auraRadius = 50

FarmTab:CreateSlider({
    Name = 'Mob Height Offset',
    Min = 0,
    Max = 20,
    Default = 3,
    Flag = 'MobHeightOffset',
    Callback = function(v)
        mobHeightOffset = v
    end,
})
FarmTab:CreateSlider({
    Name = 'Mob Tween Distance',
    Min = 10,
    Max = 500,
    Default = 100,
    Flag = 'MobTweenDist',
    Callback = function(v)
        mobTweenSpeed = v
    end,
})
FarmTab:CreateToggle({
    Name = 'Auto Kill Slimes (Current Zone)',
    Default = false,
    Flag = 'AutoFarmZone',
    Callback = function(enabled)
        _G.AutoFarmZone = enabled

        if not enabled then
            return
        end

        task.spawn(function()
            while _G.AutoFarmZone do
                task.wait()
                pcall(function()
                    local currentZone = getplayercurrentzone()
                    local maxZone = getplayermaxzone()

                    if currentZone ~= maxZone then
                        teleportToZone(maxZone)

                        return
                    end

                    local character = LocalPlayer.Character

                    if not character then
                        return
                    end

                    local rootPart = character:FindFirstChild('HumanoidRootPart')

                    if not rootPart then
                        return
                    end

                    local mobRoot = getClosestEnemyInZone(math.huge)

                    if not mobRoot then
                        return
                    end

                    local targetCFrame = mobRoot.CFrame * CFrame.new(0, mobHeightOffset, 0)
                    local distance = (rootPart.Position - targetCFrame.Position).Magnitude
                    local tweenInfo = TweenInfo.new(distance / mobTweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})

                    tween:Play()
                    tween.Completed:Wait()
                end)
            end
        end)
    end,
})
FarmTab:CreateSection('Kill Aura (Zone-Aware)')
FarmTab:CreateSlider({
    Name = 'Aura Radius (studs)',
    Min = 5,
    Max = 500,
    Default = 50,
    Flag = 'AuraRadius',
    Callback = function(v)
        auraRadius = v
    end,
})
FarmTab:CreateToggle({
    Name = 'Auto Kill Aura',
    Default = false,
    Flag = 'KillAura',
    Callback = function(enabled)
        _G.KillAura = enabled

        if not enabled then
            return
        end

        task.spawn(function()
            while _G.KillAura do
                task.wait()
                pcall(function()
                    local character = LocalPlayer.Character

                    if not character then
                        return
                    end

                    local rootPart = character:FindFirstChild('HumanoidRootPart')

                    if not rootPart then
                        return
                    end

                    local enemies = getEnemiesForCurrentZone()

                    for _, enemyRoot in pairs(enemies)do
                        if not _G.KillAura then
                            break
                        end

                        local dist = (rootPart.Position - enemyRoot.Position).Magnitude

                        if dist <= auraRadius then
                            local targetCFrame = enemyRoot.CFrame * CFrame.new(0, mobHeightOffset, 0)
                            local tweenInfo = TweenInfo.new(dist / mobTweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                            local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = targetCFrame})

                            tween:Play()
                            tween.Completed:Wait()
                        end
                    end
                end)
            end
        end)
    end,
})
FarmTab:CreateSection('Area')
FarmTab:CreateToggle({
    Name = 'Auto Buy Next Zone',
    Default = false,
    Flag = 'AutoBuyZone',
    Callback = function(enabled)
        _G.BuyZone = enabled

        if enabled then
            task.spawn(function()
                while _G.BuyZone do
                    task.wait(3)
                    pcall(function()
                        getRemote('ZonesService'):InvokeServer('requestPurchaseZone')
                    end)
                end
            end)
        end
    end,
})
FarmTab:CreateToggle({
    Name = 'Auto Area (TP Best Zone)',
    Default = false,
    Flag = 'AutoArea',
    Callback = function(enabled)
        _G.Area = enabled

        if enabled then
            task.spawn(function()
                while _G.Area do
                    task.wait(3)
                    pcall(function()
                        local currentZone = getplayercurrentzone()
                        local maxZone = getplayermaxzone()

                        if currentZone ~= maxZone then
                            teleportToZone(maxZone)
                        end
                    end)
                end
            end)
        end
    end,
})

local TeleportTab = MainSection:CreateTab('Teleport', 'rbxassetid://14477598542')

TeleportTab:CreateSection('Zone Teleporter')

local selectedZone = '1'
local zoneNames, zoneMap = getZonesFromWorkspace()

TeleportTab:CreateDropdown({
    Name = 'Select Zone',
    Options = zoneNames,
    Default = zoneNames[1] or '1',
    Flag = 'SelectedZone',
    Callback = function(selected)
        selectedZone = selected
    end,
})
TeleportTab:CreateButton({
    Name = 'Teleport to Selected Zone',
    Callback = function()
        local zoneNum = zoneMap[selectedZone] or tonumber(selectedZone)

        if zoneNum then
            teleportToZone(zoneNum)
        end
    end,
})

local AutoTab = MainSection:CreateTab('Auto', 'rbxassetid://10723405360')

AutoTab:CreateSection('Loot & Crafting')
AutoTab:CreateToggle({
    Name = 'Auto Collect Loot',
    Default = false,
    Flag = 'AutoCollectLoot',
    Callback = function(enabled)
        _G.Items = enabled

        if enabled then
            task.spawn(function()
                while _G.Items do
                    task.wait(0.1)
                    pcall(function()
                        local character = LocalPlayer.Character

                        if not character then
                            return
                        end

                        local rootPart = character:FindFirstChild('HumanoidRootPart')

                        if not rootPart then
                            return
                        end

                        local lootFolder = workspace:FindFirstChild('Loot')

                        if not lootFolder then
                            return
                        end

                        for _, item in pairs(lootFolder:GetDescendants())do
                            if not _G.Items then
                                break
                            end
                            if item:IsA('BasePart') then
                                rootPart.CFrame = item.CFrame + Vector3.new(0, 3, 0)

                                task.wait(0.05)
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end,
})
AutoTab:CreateToggle({
    Name = 'Auto Unlock Recipes',
    Default = false,
    Flag = 'AutoUnlockRecipes',
    Callback = function(enabled)
        _G.UnlockRecipe = enabled

        if enabled then
            task.spawn(function()
                while _G.UnlockRecipe do
                    task.wait(2)
                    pcall(function()
                        getRemote('CraftingService'):InvokeServer('requestUnlockRecipe')
                    end)
                end
            end)
        end
    end,
})

local _claimedRecipes = {}

AutoTab:CreateToggle({
    Name = 'Auto Claim Recipes (Zone Walk)',
    Default = false,
    Flag = 'AutoClaimRecipes',
    Callback = function(enabled)
        _G.AutoRecipe = enabled

        if enabled then
            task.spawn(function()
                while _G.AutoRecipe do
                    task.wait(1)

                    if not _G.IsTeleporting then
                        pcall(function()
                            local character = LocalPlayer.Character
                            local rootPart = character and character:FindFirstChild('HumanoidRootPart')
                            local zonesFolder = workspace:FindFirstChild('Zones')

                            if not rootPart or not zonesFolder then return end

                            local maxZone = getplayermaxzone()

                            for zoneIndex = 1, maxZone do
                                if not _claimedRecipes[zoneIndex] then
                                    local zoneFolder = zonesFolder:FindFirstChild(tostring(zoneIndex))
                                        or zonesFolder:FindFirstChild('Zone' .. tostring(zoneIndex))

                                    if zoneFolder then
                                        local recipeObj = zoneFolder:FindFirstChild('Recipe')

                                        if recipeObj then
                                            local recipePart = (recipeObj:IsA('BasePart') and recipeObj)
                                                or recipeObj:FindFirstChildWhichIsA('BasePart', true)

                                            if recipePart then
                                                _G.IsTeleporting = true

                                                local distance = (rootPart.Position - recipePart.Position).Magnitude
                                                local tweenInfo = TweenInfo.new(distance / 200, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                                local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = recipePart.CFrame })
                                                tween:Play()
                                                tween.Completed:Wait()

                                                task.wait((distance / 200) + 1.5)

                                                pcall(function()
                                                    local recipeId = recipeObj:GetAttribute('id')
                                                        or recipeObj:GetAttribute('RecipeId')
                                                        or recipeObj.Name

                                                    if recipeId == 'Recipe' then
                                                        recipeId = 'sweetie'
                                                    end

                                                    getRemote('CraftingService'):InvokeServer('requestClaimRecipe', recipeId, recipeObj)

                                                    local prompt = recipeObj:FindFirstChildWhichIsA('ProximityPrompt', true)
                                                    if prompt then
                                                        fireproximityprompt(prompt)
                                                    end
                                                end)

                                                _claimedRecipes[zoneIndex] = true
                                                task.wait(1)
                                                _G.IsTeleporting = false
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end,
})
AutoTab:CreateToggle({
    Name = 'Auto Claim Index',
    Default = false,
    Flag = 'AutoClaimIndex',
    Callback = function(enabled)
        _G.ClaimIndex = enabled

        if enabled then
            task.spawn(function()
                local remote = game:GetService('ReplicatedStorage')
                    :WaitForChild('Packages')
                    :WaitForChild('_Index')
                    :WaitForChild('leifstout_networker@0.3.1')
                    :WaitForChild('networker')
                    :WaitForChild('_remotes')
                    :WaitForChild('IndexService')
                    :WaitForChild('RemoteFunction')

                while _G.ClaimIndex do
                    task.wait(0.1)
                    for _, categoryId in pairs({ 'base', 'big', 'huge', 'shiny', 'inverted' }) do
                        pcall(function()
                            remote:InvokeServer('requestClaimReward', categoryId)
                        end)
                    end
                end
            end)
        end
    end,
})
AutoTab:CreateSection('Feed Food')

local selectedFood = {}
local feedSlimeName = {}
local feedDelay = 1

AutoTab:CreateDropdown({
    Name = 'Select Food',
    Options = foodNames,
    Default = 'None',
    MultiSelect = true,
    Flag = 'FeedFood',
    Callback = function(selected)
        selectedFood = selected
    end,
})
AutoTab:CreateDropdown({
    Name = 'Select Slime',
    Options = slimeNames,
    Default = 'None',
    MultiSelect = true,
    Flag = 'FeedSlimeName',
    Callback = function(selected)
        feedSlimeName = selected
    end,
})
AutoTab:CreateSlider({
    Name = 'Feed Delay (seconds)',
    Min = 0.1,
    Max = 10,
    Default = 1,
    Rounding = 1,
    Flag = 'FeedDelay',
    Callback = function(value)
        feedDelay = value
    end,
})

_G.FeedSlime = false

AutoTab:CreateToggle({
    Name = 'Auto Feed Selected Slime',
    Default = false,
    Flag = 'AutoFeedSlime',
    Callback = function(enabled)
        _G.FeedSlime = enabled

        if enabled and (#selectedFood == 0 or #feedSlimeName == 0) then
            window:Notify({
                Title = '\u{274c} Error',
                Description = 'Select Food AND Slime first!',
                Duration = 4,
            })

            _G.FeedSlime = false

            return
        end
        if enabled then
            task.spawn(function()
                while _G.FeedSlime do
                    task.wait(feedDelay)

                    if #selectedFood == 0 or #feedSlimeName == 0 then
                        window:Notify({
                            Title = '\u{26a0}\u{fe0f} Stopped',
                            Description = 'Food/Slime selection cleared!',
                            Duration = 3,
                        })

                        _G.FeedSlime = false

                        break
                    end

                    local InventoryUtils = require(game:GetService('ReplicatedStorage').Source.Features.Inventory.InventoryServiceUtils)
                    for _, slimeName in pairs(feedSlimeName) do
                        for _, food in pairs(selectedFood) do
                            local ok, err = pcall(function()
                                local slimeId = slimeServerIds[slimeName] or slimeName
                                InventoryUtils.feedSlime(slimeId, food)
                            end)
                            if not ok then
                                print('\u{274c} Feed failed:', tostring(err))
                            end
                        end
                    end
                end
            end)
        else
            print('\u{23f9}\u{fe0f} Auto-feed STOPPED')
        end
    end,
})
AutoTab:CreateToggle({
    Name = 'Auto Feed EQUIPPED Slime',
    Default = false,
    Flag = 'AutoFeedEquipped',
    Callback = function(enabled)
        _G.FeedEquipped = enabled

        if enabled and #selectedFood == 0 then
            window:Notify({
                Title = '\u{274c} Error',
                Description = 'Select Food first!',
                Duration = 3,
            })

            return
        end
        if enabled then
            task.spawn(function()
                while _G.FeedEquipped do
                    task.wait(feedDelay)

                    if #selectedFood == 0 then
                        window:Notify({
                            Title = '\u{26a0}\u{fe0f} Warning',
                            Description = 'Food selection cleared!',
                            Duration = 3,
                        })

                        break
                    end

                    for _, food in pairs(selectedFood) do
                        pcall(function()
                            getRemote('InventoryService'):InvokeServer('requestUseFoodEquipped', food, 1)
                        end)
                    end
                end
            end)
        else
            print('\u{23f9}\u{fe0f} Equipped auto-feed stopped')
        end
    end,
})
AutoTab:CreateSection('Transfer XP')

local sourceSlime = {}
local targetSlime = {}
local transferDelay = 1

AutoTab:CreateDropdown({
    Name = 'Source Slime (FROM)',
    Options = slimeNames,
    Default = 'None',
    MultiSelect = true,
    Flag = 'SourceSlime',
    Callback = function(selected)
        sourceSlime = selected
    end,
})
AutoTab:CreateDropdown({
    Name = 'Target Slime (TO)',
    Options = slimeNames,
    Default = 'None',
    MultiSelect = true,
    Flag = 'TargetSlime',
    Callback = function(selected)
        targetSlime = selected
    end,
})
AutoTab:CreateSlider({
    Name = 'Transfer Delay (s)',
    Min = 1,
    Max = 10,
    Default = 1,
    Flag = 'TransferDelay',
    Callback = function(value)
        transferDelay = value
    end,
})
AutoTab:CreateToggle({
    Name = 'Auto Transfer XP',
    Default = false,
    Flag = 'AutoTransferXP',
    Callback = function(enabled)
        _G.TransferXP = enabled

        if enabled then
            task.spawn(function()
                while _G.TransferXP do
                    task.wait(transferDelay)

                    if #sourceSlime == 0 or #targetSlime == 0 then
                        window:Notify({
                            Title = 'Transfer XP',
                            Description = 'Select Source and Target slimes!',
                            Duration = 3,
                        })
                        task.wait(3)
                    else
                        for _, src in pairs(sourceSlime) do
                            for _, tgt in pairs(targetSlime) do
                                pcall(function()
                                    getRemote('XpTransferService'):InvokeServer('requestTransfer', src, tgt)
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end,
})
AutoTab:CreateSection('Boost')

local boostOptions = {
    'currency',
    'luck',
    'rollSpeed',
    'ultraLuck',
}
local selectedBoost = {}

AutoTab:CreateDropdown({
    Name = 'Boost Type',
    Options = boostOptions,
    Default = 'ultraLuck',
    MultiSelect = true,
    Flag = 'BoostType',
    Callback = function(selected)
        selectedBoost = selected
    end,
})
AutoTab:CreateToggle({
    Name = 'Auto Use Boost',
    Default = false,
    Flag = 'AutoBoost',
    Callback = function(enabled)
        _G.Boost = enabled

        if enabled then
            task.spawn(function()
                while _G.Boost do
                    task.wait(1)

                    for _, boost in pairs(selectedBoost) do
                        pcall(function()
                            getRemote('BoostService'):InvokeServer('requestUseBoost', boost)
                        end)
                    end
                end
            end)
        end
    end,
})
AutoTab:CreateSection('Codes')

local redeemMessages = {
    [0] = 'Invalid!',
    [1] = 'Expired!',
    [2] = 'Out of uses!',
    [3] = 'Already redeemed!',
    [4] = 'Error!',
    [5] = 'Success!',
    [6] = 'Invalid UserId!',
}

AutoTab:CreateToggle({
    Name = 'Auto Redeem All Codes',
    Default = false,
    Flag = 'AutoRedeemCodes',
    Callback = function(enabled)
        if enabled then
            task.spawn(function()
                local remote = getRemote('CodeService')

                window:Notify({
                    Title = 'Auto Redeem',
                    Description = 'Trying ' .. #knownCodes .. ' codes...',
                    Duration = 3,
                })

                local successCount = 0

                for _, code in pairs(knownCodes)do
                    task.wait(0.5)

                    local ok, result = pcall(function()
                        return remote:InvokeServer('redeem', code)
                    end)

                    if ok and result == 5 then
                        successCount += 1

                        window:Notify({
                            Title = 'Code Redeemed! \u{2713}',
                            Description = code,
                            Duration = 2,
                        })
                    end
                end

                window:Notify({
                    Title = 'Auto Redeem Done',
                    Description = 'Redeemed ' .. successCount .. ' new codes!',
                    Duration = 4,
                })
            end)
        end
    end,
})
AutoTab:CreateTextBox({
    Name = 'Manual Code',
    Default = '',
    Placeholder = 'Enter code and press Enter...',
    Flag = 'ManualCode',
    Callback = function(text, enterPressed)
        if enterPressed and text ~= '' then
            local ok, result = pcall(function()
                return getRemote('CodeService'):InvokeServer('redeem', text)
            end)

            window:Notify({
                Title = 'Code: ' .. text,
                Description = (ok and redeemMessages[result]) or 'Failed to connect!',
                Duration = 3,
            })
        end
    end,
})

local UpgradeTab = MainSection:CreateTab('Upgrades', 'rbxassetid://10734950020')

UpgradeTab:CreateSection('Upgrade Settings')

local selectedCategory = {}

UpgradeTab:CreateDropdown({
    Name = 'Upgrade Category',
    Options = categoryNames,
    Default = 'ALL',
    MultiSelect = true,
    Flag = 'UpgradeCategory',
    Callback = function(selected)
        selectedCategory = selected
    end,
})
UpgradeTab:CreateToggle({
    Name = 'Auto Upgrade',
    Default = false,
    Flag = 'AutoUpgrade',
    Callback = function(enabled)
        _G.Upgrade = enabled

        if enabled then
            task.spawn(function()
                local remote = getRemote('UpgradeService')

                while _G.Upgrade do
                    task.wait(0.3)
                    pcall(function()
                        local list = {}
                        for _, cat in pairs(selectedCategory) do
                            if cat == 'ALL' then
                                list = allUpgrades
                                break
                            end
                            local catList = upgradeCategories[cat]
                            if catList then
                                for _, v in pairs(catList) do
                                    table.insert(list, v)
                                end
                            end
                        end

                        if #list == 0 then
                            return
                        end

                        for _, upgradeName in pairs(list) do
                            pcall(function()
                                remote:InvokeServer('requestUnlock', upgradeName)
                            end)
                            task.wait(0.05)
                        end
                    end)
                end
            end)
        end
    end,
})
UpgradeTab:CreateSection('Rebirth')
UpgradeTab:CreateToggle({
    Name = 'Auto Rebirth',
    Default = false,
    Flag = 'AutoRebirth',
    Callback = function(enabled)
        _G.Rebirth = enabled

        if enabled then
            task.spawn(function()
                while _G.Rebirth do
                    task.wait(2)

                    local success = pcall(function()
                        getRemote('RebirthService'):InvokeServer('requestRebirth')
                    end)

                    if not success then
                        window:Notify({
                            Title = 'Rebirth Failed',
                            Description = 'Not enough progress yet.',
                            Duration = 3,
                        })
                        task.wait(5)
                    else
                    end
                end
            end)
        end
    end,
})

local PlayerTab = MainSection:CreateTab('Player', 'rbxassetid://10709770431')

PlayerTab:CreateSection('Movement')

local walkSpeedConnections = {}
local targetWalkSpeed = 16

function applyWalkSpeed(humanoid)
    if humanoid then
        humanoid.WalkSpeed = targetWalkSpeed
    end
end
function setupWalkSpeed(character)
    local humanoid = character:FindFirstChildWhichIsA('Humanoid')

    if not humanoid then
        return
    end

    applyWalkSpeed(humanoid)

    if walkSpeedConnections.wsLoop then
        walkSpeedConnections.wsLoop:Disconnect()
    end

    walkSpeedConnections.wsLoop = humanoid:GetPropertyChangedSignal('WalkSpeed'):Connect(function()
        applyWalkSpeed(humanoid)
    end)
end

PlayerTab:CreateSlider({
    Name = 'Walk Speed',
    Min = 16,
    Max = 500,
    Default = 16,
    Flag = 'WalkSpeed',
    Callback = function(value)
        targetWalkSpeed = value

        local character = LocalPlayer.Character

        if character then
            setupWalkSpeed(character)
        end
    end,
})

if walkSpeedConnections.wsCA then
    walkSpeedConnections.wsCA:Disconnect()
end

walkSpeedConnections.wsCA = LocalPlayer.CharacterAdded:Connect(setupWalkSpeed)

local targetJumpPower = 50

PlayerTab:CreateSlider({
    Name = 'Jump Power',
    Min = 50,
    Max = 500,
    Default = 50,
    Flag = 'JumpPower',
    Callback = function(value)
        targetJumpPower = value

        local character = LocalPlayer.Character

        if character then
            local humanoid = character:FindFirstChildWhichIsA('Humanoid')

            if humanoid then
                humanoid.JumpPower = value
            end
        end
    end,
})
PlayerTab:CreateSection('Jump & Air')

local infJumpConn = nil

PlayerTab:CreateToggle({
    Name = 'Infinite Jump',
    Default = false,
    Flag = 'InfJump',
    Callback = function(enabled)
        _G.InfJump = enabled

        if enabled then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                if not _G.InfJump then
                    return
                end

                local character = LocalPlayer.Character

                if character then
                    local humanoid = character:FindFirstChildWhichIsA('Humanoid')

                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
        else
            if infJumpConn then
                infJumpConn:Disconnect()

                infJumpConn = nil
            end
        end
    end,
})

local flySpeed = 50
local flyBodyVelocity = nil
local flyBodyGyro = nil
local flyRunConn = nil

function stopFly()
    _G.Fly = false

    if flyBodyVelocity then
        flyBodyVelocity:Destroy()

        flyBodyVelocity = nil
    end
    if flyBodyGyro then
        flyBodyGyro:Destroy()

        flyBodyGyro = nil
    end
    if flyRunConn then
        flyRunConn:Disconnect()

        flyRunConn = nil
    end

    local character = LocalPlayer.Character

    if character then
        local humanoid = character:FindFirstChildWhichIsA('Humanoid')

        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end
function startFly()
    _G.Fly = true

    local character = LocalPlayer.Character

    if not character then
        return
    end

    local rootPart = character:FindFirstChild('HumanoidRootPart')

    if not rootPart then
        return
    end

    local humanoid = character:FindFirstChildWhichIsA('Humanoid')

    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Flying)
    end

    flyBodyGyro = Instance.new('BodyGyro', rootPart)
    flyBodyGyro.P = 9e4
    flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBodyGyro.CFrame = rootPart.CFrame
    flyBodyVelocity = Instance.new('BodyVelocity', rootPart)
    flyBodyVelocity.Velocity = Vector3.zero
    flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyRunConn = RunService.Heartbeat:Connect(function()
        if not _G.Fly then
            stopFly()

            return
        end

        local cam = workspace.CurrentCamera
        local move = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            move = move + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            move = move - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            move = move - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            move = move + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            move = move + Vector3.yAxis
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            move = move - Vector3.yAxis
        end

        flyBodyVelocity.Velocity = move.Magnitude > 0 and move.Unit * flySpeed or Vector3.zero
        flyBodyGyro.CFrame = cam.CFrame
    end)
end

PlayerTab:CreateSlider({
    Name = 'Fly Speed',
    Min = 10,
    Max = 300,
    Default = 50,
    Flag = 'FlySpeed',
    Callback = function(value)
        flySpeed = value
    end,
})
PlayerTab:CreateToggle({
    Name = 'Fly (W/A/S/D + Space/LCtrl)',
    Default = false,
    Flag = 'Fly',
    Callback = function(enabled)
        if enabled then
            startFly()
        else
            stopFly()
        end
    end,
})
PlayerTab:CreateSection('Noclip & Misc')

local noclipConn = nil

PlayerTab:CreateToggle({
    Name = 'Noclip',
    Default = false,
    Flag = 'Noclip',
    Callback = function(enabled)
        _G.Noclip = enabled

        if enabled then
            noclipConn = RunService.Stepped:Connect(function()
                if not _G.Noclip then
                    if noclipConn then
                        noclipConn:Disconnect()

                        noclipConn = nil
                    end

                    return
                end

                local character = LocalPlayer.Character

                if not character then
                    return
                end

                for _, part in pairs(character:GetDescendants())do
                    if part:IsA('BasePart') and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end)
        else
            if noclipConn then
                noclipConn:Disconnect()

                noclipConn = nil
            end

            local character = LocalPlayer.Character

            if character then
                for _, part in pairs(character:GetDescendants())do
                    if part:IsA('BasePart') then
                        part.CanCollide = true
                    end
                end
            end
        end
    end,
})

local antiAFKConn = nil

PlayerTab:CreateToggle({
    Name = 'Anti-AFK',
    Default = false,
    Flag = 'AntiAFK',
    Callback = function(enabled)
        _G.AntiAFK = enabled

        if enabled then
            local VIM = game:GetService('VirtualInputManager')

            antiAFKConn = RunService.Heartbeat:Connect(function()
                if not _G.AntiAFK then
                    if antiAFKConn then
                        antiAFKConn:Disconnect()

                        antiAFKConn = nil
                    end
                end
            end)

            LocalPlayer.Idled:Connect(function()
                if _G.AntiAFK then
                    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.wait(0.1)
                    VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                end
            end)
        else
            if antiAFKConn then
                antiAFKConn:Disconnect()

                antiAFKConn = nil
            end
        end
    end,
})

local gravityDefault = workspace.Gravity

PlayerTab:CreateSlider({
    Name = 'Gravity',
    Min = 0,
    Max = 200,
    Default = 196,
    Flag = 'Gravity',
    Callback = function(value)
        workspace.Gravity = value
    end,
})
PlayerTab:CreateButton({
    Name = 'Reset Gravity',
    Callback = function()
        workspace.Gravity = gravityDefault
    end,
})
PlayerTab:CreateSection('Quick Actions')
PlayerTab:CreateButton({
    Name = 'Reset Character',
    Callback = function()
        LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').Health = 0
    end,
})
PlayerTab:CreateButton({
    Name = 'Bring Camera to Character',
    Callback = function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
    end,
})

local ServerTab = MiscSection:CreateTab('Server', 'rbxassetid://10734932295')

ServerTab:CreateSection('Server Tools')
ServerTab:CreateButton({
    Name = 'Hop Server',
    Callback = function()
        window:Notify({
            Title = 'Server Hop',
            Description = 'Hopping to a new server...',
            Duration = 3,
        })
        task.spawn(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end,
})
ServerTab:CreateButton({
    Name = 'Rejoin',
    Callback = function()
        window:Notify({
            Title = 'Rejoining',
            Description = 'Rejoining game...',
            Duration = 2,
        })
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})
ServerTab:CreateSection('Gameplay')
ServerTab:CreateToggle({
    Name = 'No Gameplay Pause',
    Default = false,
    Flag = 'NoGameplayPause',
    Callback = function(enabled)
        if enabled then
            pcall(function()
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            end)
        end
    end,
})

local FpsTab = MiscSection:CreateTab('FPS', 'rbxassetid://10734950020')

FpsTab:CreateSection('FPS Boost')
FpsTab:CreateSlider({
    Name = 'FPS Cap',
    Min = 30,
    Max = 240,
    Default = 60,
    Flag = 'FPSCap',
    Callback = function(value)
        if setfpscap then
            pcall(setfpscap, value)
        elseif syn and syn.set_fps_cap then
            pcall(syn.set_fps_cap, value)
        end
    end,
})
FpsTab:CreateSection('Reduce Lag')
FpsTab:CreateToggle({
    Name = 'Remove Particles',
    Default = false,
    Flag = 'RemoveParticles',
    Callback = function(enabled)
        for _, desc in pairs(workspace:GetDescendants())do
            if desc:IsA('ParticleEmitter') or desc:IsA('Trail') or desc:IsA('Smoke') or desc:IsA('Sparkles') or desc:IsA('Fire') then
                desc.Enabled = not enabled
            end
        end
    end,
})
FpsTab:CreateToggle({
    Name = 'No Shadows',
    Default = false,
    Flag = 'NoShadows',
    Callback = function(enabled)
        pcall(function()
            game:GetService('Lighting').GlobalShadows = not enabled
        end)
    end,
})
FpsTab:CreateToggle({
    Name = 'Low Quality Rendering',
    Default = false,
    Flag = 'LowQuality',
    Callback = function(enabled)
        pcall(function()
            settings().Rendering.QualityLevel = enabled and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
        end)
    end,
})
FpsTab:CreateToggle({
    Name = 'Hide Decorations',
    Default = false,
    Flag = 'HideDecorations',
    Callback = function(enabled)
        pcall(function()
            for _, child in pairs(workspace:GetChildren())do
                if child.Name:lower():find('deco') or child.Name:lower():find('prop') or child.Name:lower():find('ambient') then
                    child.Parent = enabled and ReplicatedStorage or workspace
                end
            end
        end)
    end,
})
FpsTab:CreateToggle({
    Name = 'Remove Textures',
    Default = false,
    Flag = 'RemoveTextures',
    Callback = function(enabled)
        for _, desc in pairs(workspace:GetDescendants())do
            if desc:IsA('Texture') or desc:IsA('Decal') then
                desc.Transparency = enabled and 1 or 0
            end
        end
    end,
})

local OPTab = MainSection:CreateTab('OP Tools', 'rbxassetid://10734950020')

OPTab:CreateSection('Roll & Luck')

local opLuckValue = 999999

OPTab:CreateSlider({
    Name = 'Luck Override Value',
    Min = 1,
    Max = 999999,
    Default = 999999,
    Flag = 'OPLuckValue',
    Callback = function(value)
        opLuckValue = value
    end,
})

local opRollSpeed = 3

OPTab:CreateSlider({
    Name = 'Roll Speed (lower = faster, default 3)',
    Min = 0,
    Max = 3,
    Default = 3,
    Flag = 'OPRollSpeed',
    Callback = function(value)
        opRollSpeed = value
        pcall(function()
            RollSlice.rollTime(value)
            RollSlice.rollSpeed(value)
        end)
    end,
})

local opLuckRainMult = 999

OPTab:CreateSlider({
    Name = 'Luck Rain Multiplier',
    Min = 1,
    Max = 999,
    Default = 999,
    Flag = 'OPLuckRainMult',
    Callback = function(value)
        opLuckRainMult = value
    end,
})
local _opLuckRainActive = false

local opRapidInterval = 0.1

OPTab:CreateSlider({
    Name = 'Rapid Roll Interval (seconds)',
    Min = 0,
    Max = 2,
    Default = 0,
    Flag = 'OPRapidInterval',
    Callback = function(value)
        opRapidInterval = value
    end,
})

OPTab:CreateToggle({
    Name = 'Max Luck Override',
    Default = false,
    Flag = 'OPMaxLuck',
    Callback = function(enabled)
        pcall(function()
            SettingsServiceClient:set('luckOverrideEnabled', enabled)
            if enabled then
                SettingsServiceClient:set('luckOverrideValue', opLuckValue)
            end
        end)
    end,
})
OPTab:CreateToggle({
    Name = 'Force All Special Rolls (Galaxy/Void/Diamond/Golden)',
    Default = false,
    Flag = 'OPForceSpecialRolls',
    Callback = function(enabled)
        pcall(function()
            if enabled then
                RollSlice.activeSpecialRolls({ galaxy = true, void = true, diamond = true, golden = true })
            else
                RollSlice.activeSpecialRolls({})
            end
        end)
    end,
})

OPTab:CreateToggle({
    Name = 'Trigger Luck Rain',
    Default = false,
    Flag = 'OPLuckRain',
    Callback = function(enabled)
        _opLuckRainActive = enabled
        if enabled then
            task.spawn(function()
                while _opLuckRainActive do
                    pcall(function()
                        RollSlice.luckRainMultiplier(opLuckRainMult)
                        RollSlice.actions.triggerLuckRain(opLuckRainMult)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end,
})
OPTab:CreateToggle({
    Name = 'Instant Roll Reveal (Skip Animation)',
    Default = false,
    Flag = 'OPInstantReveal',
    Callback = function(enabled)
        pcall(function()
            RollSlice.actions.setInstantRevealRoll(enabled)
        end)
    end,
})
OPTab:CreateToggle({
    Name = 'Auto Skip Cutscenes & Jackpot Screens',
    Default = false,
    Flag = 'OPSkipScreens',
    Callback = function(enabled)
        _opSkipScreensActive = enabled
        if enabled then
            task.spawn(function()
                while _opSkipScreensActive do
                    pcall(function()
                        RollSlice.actions.clearRareRollCutscene()
                        RollSlice.actions.clearJackpotPresentation()
                        RollSlice.jackpotScreenShown(false)
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end,
})

OPTab:CreateToggle({
    Name = 'Rapid Roll Loop',
    Default = false,
    Flag = 'OPRapidRoll',
    Callback = function(enabled)
        _opRapidRollActive = enabled
        pcall(function()
            RollSlice.autoRoll(enabled)
        end)
        if enabled then
            task.spawn(function()
                while _opRapidRollActive do
                    pcall(function()
                        RollSlice.actions.clearRareRollCutscene()
                        RollSlice.actions.clearJackpotPresentation()
                        RollSlice.jackpotScreenShown(false)
                    end)
                    task.wait(opRapidInterval)
                end
            end)
        end
    end,
})

OPTab:CreateSection('Slime Gun')

OPTab:CreateToggle({
    Name = 'Patch Gun: Zero Cooldown + Infinite Range + 999x Damage',
    Default = false,
    Flag = 'OPPatchGun',
    Callback = function(enabled)
        pcall(function()
            if enabled then
                _origFireRate = _origFireRate or GoopGunServiceUtils.getFireRate
                _origRange = _origRange or GoopGunServiceUtils.getRange
                _origDamage = _origDamage or GoopGunServiceUtils.getDamageMultiplier
                GoopGunServiceUtils.getFireRate = function() return 0 end
                GoopGunServiceUtils.getRange = function() return math.huge end
                GoopGunServiceUtils.getDamageMultiplier = function() return 999 end
            else
                if _origFireRate then
                    GoopGunServiceUtils.getFireRate = _origFireRate
                    GoopGunServiceUtils.getRange = _origRange
                    GoopGunServiceUtils.getDamageMultiplier = _origDamage
                    _origFireRate = nil
                    _origRange = nil
                    _origDamage = nil
                end
            end
        end)
    end,
})
OPTab:CreateToggle({
    Name = 'Force Unlock Slime Gun (Bypass Upgrade Check)',
    Default = false,
    Flag = 'OPUnlockGun',
    Callback = function(enabled)
        pcall(function()
            if enabled then
                _origOwnsUpgrade = _origOwnsUpgrade or UpgradeServiceUtils.ownsUpgrade
                UpgradeServiceUtils.ownsUpgrade = function(key, upgrades)
                    if key == 'slimeGun' then return true end
                    return _origOwnsUpgrade(key, upgrades)
                end
            else
                if _origOwnsUpgrade then
                    UpgradeServiceUtils.ownsUpgrade = _origOwnsUpgrade
                    _origOwnsUpgrade = nil
                end
            end
        end)
    end,
})

local opAutoFireInterval = 0.05

OPTab:CreateSlider({
    Name = 'Auto Fire Interval (seconds)',
    Min = 0,
    Max = 1,
    Default = 0,
    Flag = 'OPAutoFireInterval',
    Callback = function(value)
        opAutoFireInterval = value
    end,
})
OPTab:CreateToggle({
    Name = 'Auto Fire at Nearest Enemy',
    Default = false,
    Flag = 'OPAutoFire',
    Callback = function(enabled)
        _opAutoFireActive = enabled
        if enabled then
            task.spawn(function()
                while _opAutoFireActive do
                    pcall(function()
                        local gameplay = GameplayServiceClient.gameplay
                        if gameplay then
                            for uniqueId, enemy in gameplay.enemies do
                                if not enemy.dead then
                                    local ok, GoopGunSC = pcall(function()
                                        return require(ReplicatedStorage.Source.Features.GoopGun.GoopGunServiceClient)
                                    end)
                                    if ok and GoopGunSC and GoopGunSC.wrapper then
                                        GoopGunSC.wrapper.stickyTargetId = uniqueId
                                        GoopGunSC.wrapper:onActivated()
                                    end
                                    break
                                end
                            end
                        end
                    end)
                    task.wait(opAutoFireInterval)
                end
            end)
        end
    end,
})

OPTab:CreateSection('Special Dice')

local opJackpotCount = 5

OPTab:CreateSlider({
    Name = 'Jackpot Queue Display Count',
    Min = 1,
    Max = 20,
    Default = 5,
    Flag = 'OPJackpotCount',
    Callback = function(value)
        opJackpotCount = value
    end,
})
OPTab:CreateToggle({
    Name = 'Force Jackpot Queue Display',
    Default = false,
    Flag = 'OPForceJackpot',
    Callback = function(enabled)
        pcall(function()
            if enabled then
                _origNormalizeQueue = _origNormalizeQueue or SpecialDiceServiceUtils.normalizeQueue
                local count = opJackpotCount
                SpecialDiceServiceUtils.normalizeQueue = function()
                    local result = {}
                    for i = 1, count do
                        table.insert(result, 'jackpotSpin')
                    end
                    return result
                end
            else
                if _origNormalizeQueue then
                    SpecialDiceServiceUtils.normalizeQueue = _origNormalizeQueue
                    _origNormalizeQueue = nil
                end
            end
        end)
    end,
})

local opSelectedMutation = {}

OPTab:CreateDropdown({
    Name = 'Force Mutation Type',
    Options = { 'huge', 'shiny', 'inverted', 'big' },
    Default = 'huge',
    MultiSelect = true,
    Flag = 'OPMutationType',
    Callback = function(selected)
        opSelectedMutation = selected
    end,
})
OPTab:CreateToggle({
    Name = 'Force Mutation on All Roll Results',
    Default = false,
    Flag = 'OPForceMutation',
    Callback = function(enabled)
        pcall(function()
            if enabled then
                _origApplyToRollResults = _origApplyToRollResults or SpecialDiceServiceUtils.applyToRollResults
                local mutations = opSelectedMutation
                SpecialDiceServiceUtils.applyToRollResults = function(results, _)
                    local out = results
                    for _, mutation in pairs(mutations) do
                        out = _origApplyToRollResults(out, mutation)
                    end
                    return out
                end
            else
                if _origApplyToRollResults then
                    SpecialDiceServiceUtils.applyToRollResults = _origApplyToRollResults
                    _origApplyToRollResults = nil
                end
            end
        end)
    end,
})

OPTab:CreateSection('Master Controls')

OPTab:CreateButton({
    Name = 'Enable ALL OP Features',
    Callback = function()
        pcall(function()
            SettingsServiceClient:set('luckOverrideEnabled', true)
            SettingsServiceClient:set('luckOverrideValue', opLuckValue)
            RollSlice.activeSpecialRolls({ galaxy = true, void = true, diamond = true, golden = true })
            RollSlice.rollTime(0.05)
            RollSlice.rollSpeed(0.05)
            RollSlice.luckRainMultiplier(999)
            RollSlice.actions.triggerLuckRain(999)
            RollSlice.actions.setInstantRevealRoll(true)
            RollSlice.autoRoll(true)
            _origFireRate = _origFireRate or GoopGunServiceUtils.getFireRate
            _origRange = _origRange or GoopGunServiceUtils.getRange
            _origDamage = _origDamage or GoopGunServiceUtils.getDamageMultiplier
            GoopGunServiceUtils.getFireRate = function() return 0 end
            GoopGunServiceUtils.getRange = function() return math.huge end
            GoopGunServiceUtils.getDamageMultiplier = function() return 999 end
            _origOwnsUpgrade = _origOwnsUpgrade or UpgradeServiceUtils.ownsUpgrade
            UpgradeServiceUtils.ownsUpgrade = function(key, upgrades)
                if key == 'slimeGun' then return true end
                return _origOwnsUpgrade(key, upgrades)
            end
            _origNormalizeQueue = _origNormalizeQueue or SpecialDiceServiceUtils.normalizeQueue
            SpecialDiceServiceUtils.normalizeQueue = function()
                local result = {}
                for i = 1, 10 do table.insert(result, 'jackpotSpin') end
                return result
            end
            _origApplyToRollResults = _origApplyToRollResults or SpecialDiceServiceUtils.applyToRollResults
            SpecialDiceServiceUtils.applyToRollResults = function(results, _)
                return _origApplyToRollResults(results, 'huge')
            end
        end)
        window:Notify({ Title = 'OP Mode', Description = 'All OP features enabled!', Duration = 3, Icon = 'rbxassetid://10709775704' })
    end,
})
OPTab:CreateButton({
    Name = 'Reset ALL OP Features',
    Callback = function()
        pcall(function()
            SettingsServiceClient:set('luckOverrideEnabled', false)
            RollSlice.activeSpecialRolls({})
            RollSlice.rollTime(3)
            RollSlice.rollSpeed(3)
            RollSlice.autoRoll(false)
            RollSlice.actions.setInstantRevealRoll(false)
            _opRapidRollActive = false
            _opAutoFireActive = false
            _opSkipScreensActive = false
            if _origFireRate then
                GoopGunServiceUtils.getFireRate = _origFireRate
                GoopGunServiceUtils.getRange = _origRange
                GoopGunServiceUtils.getDamageMultiplier = _origDamage
                _origFireRate, _origRange, _origDamage = nil, nil, nil
            end
            if _origOwnsUpgrade then
                UpgradeServiceUtils.ownsUpgrade = _origOwnsUpgrade
                _origOwnsUpgrade = nil
            end
            if _origNormalizeQueue then
                SpecialDiceServiceUtils.normalizeQueue = _origNormalizeQueue
                _origNormalizeQueue = nil
            end
            if _origApplyToRollResults then
                SpecialDiceServiceUtils.applyToRollResults = _origApplyToRollResults
                _origApplyToRollResults = nil
            end
        end)
        window:Notify({ Title = 'Reset', Description = 'All OP features have been reset.', Duration = 3 })
    end,
})

local ConfigTab = ConfigSection:CreateTab('Config', 'rbxassetid://10734898355')

ConfigTab:CreateConfigSection()
