local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Net = require(ReplicatedStorage.Modules.Net)

local function GetClosestEnemy()
    local character = Player.Character
    if not character then return nil end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    local closest
    local distance = 65

    for _,enemy in pairs(Workspace.Enemies:GetChildren()) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local hum = enemy:FindFirstChild("Humanoid")

        if hrp and hum and hum.Health > 0 then
            local dist = (root.Position - hrp.Position).Magnitude
            if dist < distance then
                distance = dist
                closest = enemy
            end
        end
    end

    return closest
end


local function AttackSword(enemy)
    local head = enemy:FindFirstChild("Head")
    local root = enemy:FindFirstChild("HumanoidRootPart")

    if head and root then
        Net:RemoteEvent("RegisterAttack"):FireServer(0)
        Net:RemoteEvent("RegisterHit"):FireServer(head, {{enemy,root}})
    end
end


local function AttackGun(enemy)
    local root = enemy:FindFirstChild("HumanoidRootPart")
    if not root then return end

    ReplicatedStorage.Modules.Net:RemoteEvent("ShootGunEvent"):FireServer(root.Position)
end


local function AttackFruit(enemy,tool)
    local root = enemy:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local character = Player.Character
    local dir = (root.Position - character.HumanoidRootPart.Position).Unit

    tool.LeftClickRemote:FireServer(dir,1)
end


RunService.Stepped:Connect(function()

    local character = Player.Character
    if not character then return end

    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end

    local enemy = GetClosestEnemy()
    if not enemy then return end

    local tooltip = tool.ToolTip

    if tooltip == "Gun" then
        AttackGun(enemy)

    elseif tooltip == "Blox Fruit" then
        if tool:FindFirstChild("LeftClickRemote") then
            AttackFruit(enemy,tool)
        end

    else
        AttackSword(enemy)
    end

end)

local Config = {
    AttackDistance = 65,
    AttackMobs = true,
    AttackPlayers = true,
    AttackCooldown = 0, -- CHỈNH: Loại bỏ cooldown nội tại
    ComboResetTime = 0.4,
    MaxCombo = 4,
    HitboxLimbs = {"RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm", "RightHand", "LeftHand"},
    AutoClickEnabled = true
}

local FastAttack = {}
FastAttack.__index = FastAttack

function FastAttack.new()
    local self = setmetatable({
        Debounce = 0,
        ComboDebounce = 0,
        ShootDebounce = 0,
        M1Combo = 0,
        EnemyRootPart = nil,
        Connections = {},
        Overheat = {Dragonstorm = {MaxOverheat = 3, Cooldown = 0, TotalOverheat = 0, Distance = 350, Shooting = false}},
        ShootsPerTarget = {["Dual Flintlock"] = 2},
        SpecialShoots = {["Skull Guitar"] = "TAP", ["Bazooka"] = "Position", ["Cannon"] = "Position", ["Dragonstorm"] = "Overheat"}
    }, FastAttack)
    
    pcall(function()
        self.CombatFlags = require(Modules.Flags).COMBAT_REMOTE_THREAD
        self.ShootFunction = getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
        local LocalScript = Player:WaitForChild("PlayerScripts"):FindFirstChildOfClass("LocalScript")
        if LocalScript and getsenv then
            self.HitFunction = getsenv(LocalScript)._G.SendHitsToServer
        end
    end)
    
    return self
end

function FastAttack:IsEntityAlive(entity)
    local humanoid = entity and entity:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

function FastAttack:CheckStun(Characterss, Humanoid, ToolTip)
    local Stun = Characterss:FindFirstChild("Stun")
    local Busy = Characterss:FindFirstChild("Busy")
    if Humanoid.Sit and (ToolTip == "Sword" or ToolTip == "Melee" or ToolTip == "Blox Fruit") then
        return false
    elseif Stun and Stun.Value > 0 or Busy and Busy.Value then
        return false
    end
    return true
end

function FastAttack:GetBladeHits(Characterss, Distance)
    local Position = Characterss:GetPivot().Position
    local BladeHits = {}
    Distance = Distance or Config.AttackDistance
    
    local function ProcessTargets(Folder, CanAttack)
        for _, Enemy in ipairs(Folder:GetChildren()) do
            if Enemy ~= Characterss and self:IsEntityAlive(Enemy) then
                local BasePart = Enemy:FindFirstChild(Config.HitboxLimbs[math.random(#Config.HitboxLimbs)]) or Enemy:FindFirstChild("HumanoidRootPart")
                if BasePart and (Position - BasePart.Position).Magnitude <= Distance then
                    if not self.EnemyRootPart then
                        self.EnemyRootPart = BasePart
                    else
                        table.insert(BladeHits, {Enemy, BasePart})
                    end
                end
            end
        end
    end
    
    if Config.AttackMobs then ProcessTargets(Workspace.Enemies) end
    if Config.AttackPlayers then ProcessTargets(Workspace.Charactersss, true) end
    
    return BladeHits
end

function FastAttack:GetClosestEnemy(Characterss, Distance)
    local BladeHits = self:GetBladeHits(Characterss, Distance)
    local Closest, MinDistance = nil, math.huge
    
    for _, Hit in ipairs(BladeHits) do
        local Magnitude = (Characterss:GetPivot().Position - Hit[2].Position).Magnitude
        if Magnitude < MinDistance then
            MinDistance = Magnitude
            Closest = Hit[2]
        end
    end
    return Closest
end

function FastAttack:GetCombo()
    local Combo = (tick() - self.ComboDebounce) <= Config.ComboResetTime and self.M1Combo or 0
    Combo = Combo >= Config.MaxCombo and 1 or Combo + 1
    self.ComboDebounce = tick()
    self.M1Combo = Combo
    return Combo
end

function FastAttack:ShootInTarget(TargetPosition)
    local Characterss = Player.Characterss
    if not self:IsEntityAlive(Characterss) then return end
    
    local Equipped = Characterss:FindFirstChildOfClass("Tool")
    if not Equipped or Equipped.ToolTip ~= "Gun" then return end
    
    local Cooldown = 0 -- CHỈNH: Ép cooldown súng về 0
    if (tick() - self.ShootDebounce) < Cooldown then return end
    
    local ShootType = self.SpecialShoots[Equipped.Name] or "Normal"
    if ShootType == "Position" or (ShootType == "TAP" and Equipped:FindFirstChild("RemoteEvent")) then
        Equipped:SetAttribute("LocalTotalShots", (Equipped:GetAttribute("LocalTotalShots") or 0) + 1)
        GunValidator:FireServer(self:GetValidator2())
        
        if ShootType == "TAP" then
            Equipped.RemoteEvent:FireServer("TAP", TargetPosition)
        else
            ShootGunEvent:FireServer(TargetPosition)
        end
        self.ShootDebounce = tick()
    else
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait() -- CHỈNH: Giảm delay click súng
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        self.ShootDebounce = tick()
    end
end

function FastAttack:GetValidator2()
    local v1 = getupvalue(self.ShootFunction, 15)
    local v2 = getupvalue(self.ShootFunction, 13)
    local v3 = getupvalue(self.ShootFunction, 16)
    local v4 = getupvalue(self.ShootFunction, 17)
    local v5 = getupvalue(self.ShootFunction, 14)
    local v6 = getupvalue(self.ShootFunction, 12)
    local v7 = getupvalue(self.ShootFunction, 18)
    
    local v8 = v6 * v2
    local v9 = (v5 * v2 + v6 * v1) % v3
    v9 = (v9 * v3 + v8) % v4
    v5 = math.floor(v9 / v3)
    v6 = v9 - v5 * v3
    v7 = v7 + 1
    
    setupvalue(self.ShootFunction, 15, v1)
    setupvalue(self.ShootFunction, 13, v2)
    setupvalue(self.ShootFunction, 16, v3)
    setupvalue(self.ShootFunction, 17, v4)
    setupvalue(self.ShootFunction, 14, v5)
    setupvalue(self.ShootFunction, 12, v6)
    setupvalue(self.ShootFunction, 18, v7)
    
    return math.floor(v9 / v4 * 16777215), v7
end

function FastAttack:UseNormalClick(Characterss, Humanoid, Cooldown)
    self.EnemyRootPart = nil
    local BladeHits = self:GetBladeHits(Characterss)
    
    if self.EnemyRootPart then
        RegisterAttack:FireServer(0) -- CHỈNH: Gửi cooldown 0 lên server
        if self.CombatFlags and self.HitFunction then
            self.HitFunction(self.EnemyRootPart, BladeHits)
        else
            RegisterHit:FireServer(self.EnemyRootPart, BladeHits)
        end
    end
end

function FastAttack:UseFruitM1(Characterss, Equipped, Combo)
    local Targets = self:GetBladeHits(Characterss)
    if not Targets[1] then return end
    
    local Direction = (Targets[1][2].Position - Characterss:GetPivot().Position).Unit
    Equipped.LeftClickRemote:FireServer(Direction, Combo)
end

function FastAttack:Attack()
    -- CHỈNH: Loại bỏ kiểm tra tick() để đánh liên tục
    local Characterssss = Player.Character
    if not Characterssss or not self:IsEntityAlive(Characterss) then return end
    
    local Humanoid = Characterss.Humanoid
    local Equipped = Characterss:FindFirstChildOfClass("Tool")
    if not Equipped then return end
    
    local ToolTip = Equipped.ToolTip
    if not table.find({"Melee", "Blox Fruit", "Sword", "Gun"}, ToolTip) then return end
    
    -- CHỈNH: Cooldown nội tại ép về 0
    local Cooldown = 0 
    if not self:CheckStun(Characterss, Humanoid, ToolTip) then return end
    
    local Combo = self:GetCombo()
    -- CHỈNH: Loại bỏ cộng thêm giây khi đạt MaxCombo
    self.Debounce = tick()
    
    if ToolTip == "Blox Fruit" and Equipped:FindFirstChild("LeftClickRemote") then
        self:UseFruitM1(Characterss, Equipped, Combo)
    elseif ToolTip == "Gun" then
        local Target = self:GetClosestEnemy(Characterss, 120)
        if Target then
            self:ShootInTarget(Target.Position)
        end
    else
        self:UseNormalClick(Characterss, Humanoid, Cooldown)
    end
end

local AttackInstance = FastAttack.new()
table.insert(AttackInstance.Connections, RunService.Stepped:Connect(function()
    AttackInstance:Attack()
end))

for _, v in pairs(getgc(true)) do
    if typeof(v) == "function" and iscclosure(v) then
        local name = debug.getinfo(v).name
        if name == "Attack" or name == "attack" or name == "RegisterHit" then
            hookfunction(v, function(...)
                AttackInstance:Attack()
                return v(...)
            end)
        end
    end
end