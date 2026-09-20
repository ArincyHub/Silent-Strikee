-- // Start // --
local LocalPlayer = game:GetService('Players').LocalPlayer;
local TextService = game:GetService('TextService')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local HttpService = game:GetService('HttpService')

local Core = game:GetService("CoreGui")
local Plrs = game:GetService("Players")
local Lplr = Plrs.LocalPlayer;
local UIS = game:GetService("UserInputService")
local TWS = game:GetService("TweenService")
local Run = game:GetService("RunService")
local Mouse = Lplr:GetMouse()
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local HTTP = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local SGui = game:GetService("StarterGui")

local function GetChar()
	return Lplr.Character or Lplr.CharacterAdded:Wait()
end;
local function GetHum()
	return GetChar():FindFirstChild("Humanoid")
end;
local function GetRoot()
	return GetChar():FindFirstChild("HumanoidRootPart")
end;
local function Notify(title, text, Time)
	SGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = Time
	})
end;
--------------------------------------------------------------------------------------
local pairs = pairs;
local ipairs = ipairs;
--------------------------------------------------------------------------------------

local LocalPlayer = game:GetService('Players').LocalPlayer
local TextService = game:GetService('TextService')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local HttpService = game:GetService('HttpService')

local Core = game:GetService("CoreGui")
local Plrs = game:GetService("Players")
local Lplr = Plrs.LocalPlayer
local UIS = game:GetService("UserInputService")
local TWS = game:GetService("TweenService")
local Run = game:GetService("RunService")
local Mouse = Lplr:GetMouse()
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local HTTP = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TeleportService")
local SGui = game:GetService("StarterGui")

local function GetChar()
	return Lplr.Character or Lplr.CharacterAdded:Wait()
end

local function GetHum()
	return GetChar():FindFirstChild("Humanoid")
end

local function GetRoot()
	return GetChar():FindFirstChild("HumanoidRootPart")
end

local function Notify(title, text, Time)
	SGui:SetCore("SendNotification", {
		Title = title,
		Text = text,
		Duration = Time
	})
end


local executorName = identifyexecutor()
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zenhubtop/zen_hub_pr/refs/heads/main/bbg"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenHubbScript/Main/refs/heads/main/log"))()
_G.Title = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local Window = ui:NewWindow('', "Executor : " .. executorName, 'rbxassetid://17775417459')
local MenuFunctions = Window:AddMenu('' .. _G.Title, "", 'ticket', 'tab')

local Tab_1 = MenuFunctions:AddTab("Information", 10723415903,"changelog,credits,etc..")
local Tab_Setting = MenuFunctions:AddTab("Configs Farm", 10734950020,"distance,bringmob")
local Tab_2 = MenuFunctions:AddTab("Main Farm", 10723407389,"farm,bossess,etc.")
local Tab_3 = MenuFunctions:AddTab("Items Farm", 15557776256,"items,swords.etc..")
local Stats = MenuFunctions:AddTab("Local Player", 10709770431,"stats,fake,etc")
local Events = MenuFunctions:AddTab("Sea Events", 10734941354,"mirrage,auto boat")
local dragons = MenuFunctions:AddTab("Dragon Events", 105643281470017,"auto dojo,belt,etc")
local Racev4 = MenuFunctions:AddTab("Race V4", 14477517268,"racev4,moons,etc.")
local Tab_4 = MenuFunctions:AddTab("Dungeon Raid", 10734932295,"autoraid,boss")
local Tab_5 = MenuFunctions:AddTab("Island Travel", 10734886004,"teleport,hop,etc..")
local Tab_6 = MenuFunctions:AddTab("Stores", 10734952479,"melee,swords,guns")
local Tab_7 = MenuFunctions:AddTab("Miscellaneous", 10734949856,"auto open,auto switch")
local Tab_8 = MenuFunctions:AddTab("Fun Visual", 6034467796,"auto v4 any race,rainfruit")

local Players = game:GetService("Players")
local player = Players.LocalPlayer 
local userId = player.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420

local imageUrl, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)

local Home_Left = Tab_1:AddSection('Info',''..player.Name.."  [ User Id : "..player.UserId.." ]",'Join Zen Hub Discord For Updates! \nuse at your own risk.',''..imageUrl)


local Home_Right = Tab_1:AddSection('Changelog','Script Made By jay#0050 Fix By Imrane','Join Zen Hub Discord For Updates! \nuse at your own risk.','http://www.roblox.com/asset/?id=6031233840')

local TimeGame = Home_Right:AddLabel("Time")
function UpdateTime()
	local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
	local Hour = math.floor(GameTime / (60 ^ 2)) % 24;
	local Minute = math.floor(GameTime / (60 ^ 1)) % 60;
	local Second = math.floor(GameTime / (60 ^ 0)) % 60;
	local FormatTime = string.format("%02d.%02d.%02d", Hour, Minute, Second)
	TimeGame:Set("Game Time : " .. FormatTime)
end;
spawn(function()
	while task.wait() do
		UpdateTime()
	end
end)
local plyserv = Home_Right:AddLabel("Players")  -- Assuming Home_Right is the correct parent

spawn(function()
    while true do
        pcall(function()
            local playerCount = #Plrs:GetPlayers()
            local maxPlayers = 12
            
            if playerCount == maxPlayers then
                plyserv:Set("Players: " .. playerCount .. " / " .. maxPlayers .. " (Max)")
            elseif playerCount == 1 then
                plyserv:Set("Player: " .. playerCount .. " / " .. maxPlayers)
            else
                plyserv:Set("Players: " .. playerCount .. " / " .. maxPlayers)
            end
        end)
        task.wait(1)  -- Adjust the delay as needed (e.g., 1 for 1 second)
    end
end)

local Mirragecheckq = Home_Right:AddLabel("")
local FrozenIsland1 = Home_Right:AddLabel("Frozen Dimension")

spawn(function()
	pcall(function()
		while task.wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') then
				Mirragecheckq:Set('Mirage Island Status :  Found')
			else
				Mirragecheckq:Set("Mirage Island Status : Not Found")
			end
		end
	end)
end)

spawn(function()
	pcall(function()
		while task.wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
				FrozenIsland1:Set('Frozen Dimension Status : Found')
			else
				FrozenIsland1:Set("Frozen Dimension Status : Not Found")
			end
		end
	end)
end)
local kitsuneisalnd = Home_Right:AddLabel("Kitsune Island Status : Not Found")
task.spawn(function()
	while task.wait() do
		pcall(function()
			if game.Workspace._WorldOrigin.Locations:FindFirstChild('Kitsune Island') then
				kitsuneisalnd:Set("Kitsune Island Status : Found")
			else
				kitsuneisalnd:Set("Kitsune Island Status : Not Found")
			end
		end)
	end
end)
local FM = Home_Right:AddLabel('Third World')
task.spawn(function()
	while task.wait() do
		pcall(function()
			if Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				FM:Set("Full Moon Status : 100%")
			elseif Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				FM:Set("Full Moon Status : 75%")
			elseif Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				FM:Set("Full Moon Status : 50%")
			elseif Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				FM:Set("Full Moon Status : 25%")
			elseif Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				FM:Set("Full Moon Status : 15%")
			else
				FM:Set("Wait For Moon")
			end
		end)
	end
end)

local Elite_Hunter_Status = Home_Right:AddLabel("Status")
spawn(function()
	while task.wait() do
		pcall(function()
			if RS:FindFirstChild("Diablo") or RS:FindFirstChild("Deandre") or RS:FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
				Elite_Hunter_Status:Set("Elite Status : Spawn")
			else
				Elite_Hunter_Status:Set("Elite Status : Not Found")
			end
		end)
	end
end)
local MobKilled2 = Home_Right:AddLabel("")
spawn(function()
	while task.wait() do
		pcall(function()
			if string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
				MobKilled2:Set("Dimension Kill : " .. string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41))
			elseif string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
				MobKilled2:Set("Dimension Kill : " .. string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40))
			elseif string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
				MobKilled2:Set("Dimension Kill : " .. string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39))
			else
				MobKilled2:Set("Dimension Boss Is Spawning")
			end
		end)
	end
end)


Home_Left:Button('Copy Zen Hub Discord Link', function(Value)
	
end)

local changelog = Tab_1:AddSection('Changelog','Update Log','all the update in zen hub','rbxassetid://6034467796')

changelog:AddLabel('- Fixed Some bug issued')
changelog:AddLabel('- Fix Auto Collect Amber')
changelog:AddLabel('- Fixed Level Auto Farms')
changelog:AddLabel('- Fixed Auto Sea Events')
changelog:AddLabel('- Improve Functions')
changelog:AddLabel('- Fixed Some bug issued')
changelog:AddLabel('- Fix Auto Sail Boat')

-- // Configs // --
local Home_Right = Tab_Setting:AddSection('Tabs','Weapons Setting','Select Weapons, Adjust fast attack,skills.etc..','rbxassetid://10734975692')
local WeaponList = {
	"Melee",
	"Blox Fruit",
	"Sword"
}
spawn(function()
	while task.wait() do
		for i, v in pairs(Lplr.Backpack:GetChildren()) do
			if v.ToolTip == SelectWeaponFarm then
				SelectWeaponFarm = v.Name
			end
		end
	end
end)

local AutoFarmType = {
    "Above",
    "Beside",
    "Lower"
}

local DisFarm = 20  -- Default distance
local DisFarm1 = "20"  -- Default value as string for dropdown

-- Update Farm_Mode based on AutoFarmType
spawn(function()
    while task.wait() do
        if AutoFarmType == "Above" then
            Farm_Mode = CFrame.new(0, DisFarm, 0) * CFrame.Angles(math.rad(-90), 0, 0)
        elseif AutoFarmType == "Beside" then
            Farm_Mode = CFrame.new(0, 2, DisFarm) * CFrame.Angles(0, 0, 0)
        elseif AutoFarmType == "Lower" then
            Farm_Mode = CFrame.new(DisFarm, 2, 0) * CFrame.Angles(0, 0, 0)
        end
    end
end)

-- Update DisFarm based on DisFarm1
spawn(function()
    while task.wait() do
        DisFarm = tonumber(DisFarm1) or 20  -- Convert string to number
    end
end)

Home_Right:AddDropdown("Farm Position", AutoFarmType, "Above", function(value)
    AutoFarmType = value
    print(value)
end)

Home_Right:AddDropdown("Farm Distance", { "5", "10", "15", "20", "25", "30" }, "20", function(value)
    DisFarm1 = value  -- Use the correct variable name
end)


Home_Right:AddDropdown("Select Weapon", WeaponList, "Melee", function(weaponfunc)
	SelectWeaponFarm = weaponfunc
    print(weaponfunc)
end)

--[[function FastM1()
    local plr = game:GetService("Players").LocalPlayer
    local getHeadPositionAttack = getHeadPosition()
    for i = 1, #getHeadPositionAttack do
        if #getHeadPositionAttack > 0 then
            call(function()
                if plr.Character:FindFirstChild("Dragon-Dragon") then
                    plr.Character["Dragon-Dragon"].LeftClickRemote:FireServer(getHeadPositionAttack[i], 1)
                    plr.Character["Dragon-Dragon"].RemoteEvent:FireServer(false)
                    sethiddenproperty(plr, "SimulationRadius", math.huge)
                    return
                end
            end)
        end
    end
end]]

-- Function to get valid enemy targets within range
function getTargets()
    local returnTable = {}
    local plr = game:GetService("Players").LocalPlayer
    local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")

    if not enemies then return returnTable end -- Return empty if "Enemies" folder doesn't exist

    for _, enemy in pairs(enemies:GetChildren()) do
        local humanoid = enemy:FindFirstChild("Humanoid")
        local head = enemy:FindFirstChild("Head")

        if humanoid and humanoid.Health > 0 and head then
            local distance = (head.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if distance < 70 then
                table.insert(returnTable, enemy.HumanoidRootPart)
            end
        end
    end

    return returnTable
end


function attackEnemies(enemyTarget)
    local plr = game:GetService("Players").LocalPlayer
    local RegisterAttack = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]
    local RegisterHit = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterHit"]
    local ReceivedHit = game:GetService("ReplicatedStorage").Modules.Net["RE/ReceivedHit"]
    local ShootGunEvent = game:GetService("ReplicatedStorage").Modules.Net["RE/ShootGunEvent"]
    local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")

    --local RemoteEvent = game.Players.LocalPlayer.Characters["Dragon-Dragon"].RemoteEvent
    --local LeftClickRemote = workspace.Characters.Players["Dragon-Dragon"].LeftClickRemote

    if enemyTarget and (enemyTarget.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 60 then
        if (toolEquiped.ToolTip == "Melee" or toolEquiped.ToolTip == "Sword") and not RaidAura then
            RegisterAttack:FireServer(0)
            RegisterHit:FireServer(enemyTarget, {})
            ReceivedHit:FireServer(enemyTarget, {})
        end

        if toolEquiped.ToolTip == "Gun" and not RaidAura then
            ShootGunEvent:FireServer(enemyTarget.Position, {[1] = enemyTarget})
        end
    end
end

function FastAttacked()
    local plr = game:GetService("Players").LocalPlayer

    for k, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        attackEnemies(v.Head)
        attackEnemies(v.HumanoidRootPart)
    end

    for k, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
        if v:FindFirstChild('HumanoidRootPart') then
            attackEnemies(v.HumanoidRootPart)
        end
    end

    for k, v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
        if v ~= plr.Character then
            attackEnemies(v.Head)
        end
    end
end



function FastShooted()
    local plr = game:GetService("Players").LocalPlayer
    local ShootGunEvent = game:GetService("ReplicatedStorage").Modules.Net["RE/ShootGunEvent"]
    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
            local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")
            if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 50 then
                local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")
                if toolEquiped.ToolTip == "Gun" and RaidAura == false then
                    --plr.Character[SelectWeaponFarm].RemoteFunctionShoot:InvokeServer(v.HumanoidRootPart.Position, v.HumanoidRootPart)
                    ShootGunEvent:FireServer(v.HumanoidRootPart.Position, {[1] = v.HumanoidRootPart})
                end
            end
        end
    end
end

FastAttack = false
Home_Right:AddToggle('Fast Attack', FastAttack, function(Value)
    FastAttack = Value
end)
task.spawn(function()
    while task.wait() do
        if FastAttack then
            pcall(function()
                repeat task.wait()
                    FastAttacked()
                    CameraShakerR:Stop()
                until not FastAttack
            end)
        end
    end
end)
_G.AutoAttack = true
Home_Right:AddToggle('Fast Attack 2', _G.AutoAttack, function(Value)
    _G.AutoAttack = Value
end)

task.spawn(function()
    while task.wait(0.0001) do
        -- Só executa se o toggle estiver ativado
        if _G.AutoAttack then
            local _Character = game.Players.LocalPlayer.Character
            local v13

            if _Character then
                v13 = _Character:FindFirstChild('HumanoidRootPart')
            else
                v13 = _Character
            end

            local v14, v15, v16 = ipairs({
                workspace.Enemies,
                workspace.Characters,
            })
            local u17 = {}

            while true do
                local v18

                v16, v18 = v14(v15, v16)

                if v16 == nil then
                    break
                end

                local v19, v20, v21 = ipairs(v18 and v18:GetChildren() or {})

                while true do
                    local v22

                    v21, v22 = v19(v20, v21)

                    if v21 == nil then
                        break
                    end

                    local _HumanoidRootPart = v22:FindFirstChild('HumanoidRootPart')
                    local _Humanoid = v22:FindFirstChild('Humanoid')

                    if v22 ~= _Character and (_HumanoidRootPart and (_Humanoid and (_Humanoid.Health > 0 and (_HumanoidRootPart.Position - v13.Position).Magnitude <= 60))) then
                        local v25, v26, v27 = ipairs(v22:GetChildren())

                        while true do
                            local v28

                            v27, v28 = v25(v26, v27)

                            if v27 == nil then
                                break
                            end
                            if v28:IsA('BasePart') and (_HumanoidRootPart.Position - v13.Position).Magnitude <= 60 then
                                u17[#u17 + 1] = {v22, v28}
                            end
                        end
                    end
                end
            end

            local _Tool = _Character:FindFirstChildOfClass('Tool')

            if #u17 > 0 and (_Tool and (_Tool:GetAttribute('WeaponType') == 'Melee' or _Tool:GetAttribute('WeaponType') == 'Sword')) then
                pcall(function()
                    require(game.ReplicatedStorage.Modules.Net):RemoteEvent('RegisterHit', true)
                    game.ReplicatedStorage.Modules.Net['RE/RegisterAttack']:FireServer()

                    local _Head = u17[1][1]:FindFirstChild('Head')

                    if _Head then
                        game.ReplicatedStorage.Modules.Net['RE/RegisterHit']:FireServer(_Head, u17, {}, tostring(game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15))
                        cloneref(u4):FireServer(string.gsub('RE/RegisterHit', '.', function(p31)
                            return string.char(bit32.bxor(string.byte(p31), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
                        end), bit32.bxor(u5 + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), _Head, u17)
                    end
                end)
            end
        end
    end
end)

Home_Right:AddToggle('Fast Shot Gun', FastShot, function(Value)
    FastShot = Value
end)
spawn(function()
    while task.wait() do
        if FastShot then
            pcall(function()
                local plr = game:GetService("Players").LocalPlayer
                local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
                repeat task.wait()
                    FastShooted()
                    CameraShakerR:Stop()
                until not FastShot
            end)
        end
    end
end)

function AttackToPlayers()
    local plr = game:GetService("Players").LocalPlayer
    local RegisterAttack = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]
    local RegisterHit = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterHit"]
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health > 0 then
            if (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 50 then
                local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")
                if toolEquiped.ToolTip == "Melee" or toolEquiped.ToolTip == "Sword" then
                    RegisterAttack:FireServer(0.1)
                    RegisterHit:FireServer(v.Character.Head, {})
                end
            end
        end
    end
end
Home_Right:AddToggle('Attack Player (Disturb Farming)', AttackToPlayersNow, function(Value)
    AttackToPlayersNow = Value
end)
spawn(function()
    while task.wait() do
        if AttackToPlayersNow then
            local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
            CameraShakerR:Stop()

            pcall(function()
                repeat task.wait()
                    AttackToPlayers()
                until not AttackToPlayersNow
            end)
        end
    end
end)

--[[
spawn(function()
	while wait() do
		if _G.FastAttack and not LevelFarmQuestFruitMastery and not LevelFarmQuestGunMastery then
			pcall(function()
				AttackNoCD()
				AutoClick()
			end)
		end
	end
end)


PBlade = game.Players.LocalPlayer
local QBlade = getupvalues(require(PBlade.PlayerScripts.CombatFramework))
local RBlade = QBlade[2]
function GetCurrentBlade()
local S = RBlade.activeController
local T = S.blades[1]
if not T then
	return
end
while T.Parent ~= game.Players.LocalPlayer.Character do
	T = T.Parent
end
return T
end

function AttackNoCD()
if not LevelFarmQuestFruitMastery or not LevelFarmQuestGunMastery then
	if _G.FastAttack then
		local U = RBlade.activeController
		for h = 1, 1 do
			local V =
				require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
				PBlade.Character,
				{PBlade.Character.HumanoidRootPart},
				60
			)
			local W = {}
			local X = {}
			for k, i in pairs(V) do
				if i.Parent:FindFirstChild("HumanoidRootPart") and not X[i.Parent] then
					table.insert(W, i.Parent.HumanoidRootPart)
					X[i.Parent] = true
				end
			end
			V = W
			if #V > 0 then
				local Y = debug.getupvalue(U.attack, 5)
				local Z = debug.getupvalue(U.attack, 6)
				local _ = debug.getupvalue(U.attack, 4)
				local a0 = debug.getupvalue(U.attack, 7)
				local a1 = (Y * 798405 + _ * 727595) % Z
				local a2 = _ * 798405
				(function()
					a1 = (a1 * Z + a2) % 1099511627776
					Y = math.floor(a1 / Z)
					_ = a1 - Y * Z
				end)()
				a0 = a0 + 1
				debug.setupvalue(U.attack, 5, Y)
				debug.setupvalue(U.attack, 6, Z)
				debug.setupvalue(U.attack, 4, _)
				debug.setupvalue(U.attack, 7, a0)
				pcall(
					function()
						if PBlade.Character:FindFirstChildOfClass("Tool") and U.blades and U.blades[1] then
							U.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
								"weaponChange",
								tostring(GetCurrentBlade())
							)
							game.ReplicatedStorage.Remotes.Validator:FireServer(
								math.floor(a1 / 1099511627776 * 16777215),
								a0
							)
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", V, h, "")
						end
					end
				)
			end
		end
	else
		game:GetService'VirtualUser':CaptureController()
		game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
	end
end
end

]]

function InstancePos(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end

function TP3(pos)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end

spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.AutoClick or Fastattack then
            pcall(function()
                game:GetService 'VirtualUser':CaptureController()
                game:GetService 'VirtualUser':Button1Down(Vector2.new(0, 1, 0, 1))
            end)
        end
    end)
end)


task.spawn(function()
	while wait() do
		pcall(function()
			if _G.SelectWeaponFarm == "Melee" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Melee" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeaponFarm == "Sword" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Sword" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			elseif _G.SelectWeaponFarm == "Blox Fruit" then
				for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v.ToolTip == "Blox Fruit" then
						if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
							_G.SelectWeapon = v.Name
						end
					end
				end
			end
		end)
	end
    end)


local spinAngle = 0 -- global rotation value

function BringMonster(TargetName, TargetCFrame)
    local mobs = {}

    -- Collect valid mobs
    for i, v in ipairs(workspace.Enemies:GetChildren()) do
        if v.Name == TargetName then
            if v:FindFirstChild("Humanoid") 
            and v:FindFirstChild("HumanoidRootPart") 
            and v.Humanoid.Health > 0 then
                
                if (v.HumanoidRootPart.Position - GetRoot().Position).Magnitude < tonumber(bringfrec) then
                    table.insert(mobs, v)
                end
            end
        end
    end

    local radius = 12
    local total = #mobs
    
    spinAngle += 0.5 -- control spin speed (increase = faster)

    for i, v in ipairs(mobs) do
        local hrp = v.HumanoidRootPart
        local humanoid = v.Humanoid

        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
        
        if humanoid:FindFirstChild("Animator") then
            humanoid.Animator:Destroy()
        end

        if i == 1 then
            -- Main mob stays in center
            hrp.CFrame = TargetCFrame
        else
            -- Rotating circle math
            local angle = (i / total) * math.pi * 2 + spinAngle
            local offset = Vector3.new(
                math.cos(angle) * radius,
                0,
                math.sin(angle) * radius
            )

            hrp.CFrame = TargetCFrame + offset
        end

        hrp.CanCollide = false
        hrp.Size = Vector3.new(60,60,60)
        hrp.Transparency = 1

        sethiddenproperty(Lplr, "SimulationRadius", math.huge)
    end
end
bringfrec = 250;
local BringMobs = true;
Home_Right:AddToggle("Bring Mob", BringMobs, function(Value)
	BringMobs = Value
end)
spawn(function()
	while task.wait() do
		if BringMobs and (LevelFarmQuest or LevelFarmNoQuest) then
			pcall(function()
				BringMonster(Level_Farm_Name, Level_Farm_CFrame)
			end)
		elseif BringMobs and Farm_Bone then
			pcall(function()
				BringMonster(Bone_Farm_Name, Bone_Farm_CFrame)
			end)
		elseif BringMobs and Farm_Ectoplasm then
			pcall(function()
				BringMonster(Ecto_Farm_Name, Ecto_Farm_CFrame)
			end)
		elseif BringMobs and _G.AutoPirateRaid then
			pcall(function()
				BringMonster(piratename, pirateframe)
			end)
		elseif BringMobs and Nearest_Farm then
			pcall(function()
				BringMonster(Nearest_Farm_Name, Nearest_Farm_CFrame)
			end)
		elseif BringMobs and (SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm) then
			pcall(function()
				BringMonster(SelectMonster_Farm_Name, SelectMonster_Farm_CFrame)
			end)
		elseif BringMobs and Auto_Farm_Material then
			pcall(function()
				BringMonster(Material_Farm_Name, Material_Farm_CFrame)
			end)
		elseif BringMobs and (GunMastery_Farm or DevilMastery_Farm) then
			pcall(function()
				BringMonster(Mastery_Farm_Name, Mastery_Farm_CFrame)
			end)
		elseif BringMobs and AutoRengoku then
			pcall(function()
				BringMonster(Rengoku_Farm_Name, Rengoku_Farm_CFrame)
			end)
		elseif BringMobs and AutoCakePrince then
			pcall(function()
				BringMonster(CakePrince_Farm_Name, CakePrince_Farm_CFrame)
			end)
		elseif BringMobs and _G.AutoDoughKing then
			pcall(function()
				BringMonster(DoughKing_Farm_Name, DoughKing_Farm_CFrame)
			end)
		elseif BringMobs and AutoCitizen then
			pcall(function()
				BringMonster(Citizen_Farm_Name, Citizen_Farm_CFrame)
			end)
		elseif BringMobs and AutoEvoRace then
			pcall(function()
				BringMonster(EvoV2_Farm_Name, EvoV2_Farm_CFrame)
			end)
		elseif BringMobs and AutoBartilo then
			pcall(function()
				BringMonster(Bartilo_Farm_Name, Bartilo_Farm_CFrame)
			end)
		elseif BringMobs and AutoSoulGuitar then
			pcall(function()
				BringMonster(SoulGuitar_Farm_Name, SoulGuitar_Farm_CFrame)
			end)
		elseif BringMobs and AutoMusketeer then
			pcall(function()
				BringMonster(Musketere_Farm_Name, Musketere_Farm_CFrame)
			end)
		end
	end
end)
local ByPassTP = true;
Home_Right:AddToggle("Bypass Teleport", ByPassTP, function(Value)
	ByPassTP = Value
end)
local AutoSetSpawn = true;
Home_Right:AddToggle('Set Spawn Point', AutoSetSpawn, function(Value)
	AutoSetSpawn = Value
end)
spawn(function()
	while task.wait() do
		if AutoSetSpawn then
			RS.Remotes.CommF_:InvokeServer("SetSpawnPoint")
		end
	end
end)
local Home_left = Tab_Setting:AddSection('','Mob Misc','remove animation,hides ui','rbxassetid://10723396107')
local BusoHaki = true;
Home_left:AddToggle("Buso Haki", BusoHaki, function(Value)
	BusoHaki = Value
end)
spawn(function()
	while task.wait() do
		if BusoHaki then
			if not GetChar():FindFirstChild("HasBuso") then
				RS.Remotes.CommF_:InvokeServer("Buso")
			end
		end
	end
end)
Home_left:AddToggle("Disable Audio Effect", DeleteAudioEffect, function(Value)
	DeleteAudioEffect = Value
end)
spawn(function()
	while task.wait() do
		if DeleteAudioEffect then
			for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"]:GetChildren()) do
				if v.Name == "Sounds" then
					for i2, v2 in pairs(v:GetChildren()) do
						if v2:IsA("Part") then
							v2:Destroy()
						end
					end
				end;
				if v.Name == ("CurvedRing") or v.Name == ("SlashHit") or v.Name == ("SwordSlash") or v.Name == ("SlashTail") then
					v:Destroy()
				end
			end
		end
	end
end)
Home_left:AddToggle('Hide Notification', HideNotification, function(Value)
	HideNotification = Value
end)
spawn(function()
	while task.wait() do
		if HideNotification then
			Lplr.PlayerGui.Notifications.Enabled = false
		else
			Lplr.PlayerGui.Notifications.Enabled = true
		end
	end
end)

Home_left:AddToggle('Hide Text Damage', _G.KobenHeegeen, function(Value)
	_G.KobenHeegeen = Value
end)

spawn(function()
	while wait() do
		if _G.KobenHeegeen then
			game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
		else
			game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
		end
	end
end)

Home_left:AddToggle("Destroy Effect Animation",false, function()
	RS.Assets.Models:Destroy()
	RS.Assets.GUI:Destroy()
	RS.Assets.SlashHit:Destroy()
	for i, v in pairs(RS.Effect.Container.Death:GetChildren()) do
		v:Destroy()
	end;
	for i, v in pairs(RS.Effect.Container.Respawn:GetChildren()) do
		v:Destroy()
	end
end)

Home_left:AddToggle("Black Screen",false,function(v)
	_G.StartBlackScreen = v
		print(v)
	end)


spawn(function()
	while wait() do
		if _G.StartBlackScreen then
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(500, 0, 500, 500)
		else
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Blackscreen.Size = UDim2.new(1, 0, 500, 500)
		end
	end
end)
   


if _G.WhiteScreen == true then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
elseif _G.WhiteScreen == false then
    game:GetService("RunService"):Set3dRenderingEnabled(true)
end



local Skill_Setting = Tab_Setting:AddSection('','Skill Seetings','auto use skill z,x.c.v','rbxassetid://10709770431')
_G.SkillZ = true;
Skill_Setting:AddToggle('Use Skill Z', _G.SkillZ, function(Value)
	_G.SkillZ = Value
end)
_G.SkillX = true;
Skill_Setting:AddToggle('Use Skill X', _G.SkillX, function(Value)
	_G.SkillX = Value
end)
_G.SkillC = true;
Skill_Setting:AddToggle('Use Skill C', _G.SkillC, function(Value)
	_G.SkillC = Value
end)
_G.SkillV = true;
Skill_Setting:AddToggle('Use Skill V', _G.SkillV, function(Value)
	_G.SkillV = Value
end)
_G.SkillF = true;
Skill_Setting:AddToggle('Use Skill F', _G.SkillF, function(Value)
	_G.SkillF = Value
end)
if Lplr.PlayerGui.Main:FindFirstChild("ChooseTeam") then
	repeat
		task.wait()
		if Lplr.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
			if _G.Team == "Pirate" then
				for i, v in pairs(getconnections(Lplr.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do
					v.Function()
				end
			elseif _G.Team == "Marine" then
				for i, v in pairs(getconnections(Lplr.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Activated)) do
					v.Function()
				end
			else
				for i, v in pairs(getconnections(Lplr.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do
					v.Function()
				end
			end
		end
	until Lplr.Team ~= nil and game:IsLoaded()
end;
First_Sea = false;
Second_Sea = false;
Third_Sea = false;
local placeId = game.PlaceId;
if placeId == 2753915549 then
	First_Sea = true
elseif placeId == 4442272183 then
	Second_Sea = true
elseif placeId == 7449423635 then
	Third_Sea = true
end;
--// CHECK MONSTER
function CheckLevel()
    local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
    if First_Sea then
        if Lv == 1 or Lv <= 9 or _G.SelectMonster == "Bandit [Lv. 5]" then -- Bandit
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif Lv == 10 or Lv <= 14 or _G.SelectMonster == "Monkey [Lv. 14]" then -- Monkey
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
        elseif Lv == 15 or Lv <= 29 or _G.SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
            Ms = "Gorilla"
            NameQuest = "JungleQuest"
            QuestLv = 2
            NameMon = "Gorilla"
            CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
        elseif Lv == 30 or Lv <= 39 or _G.SelectMonster == "Pirate [Lv. 35]" then -- Pirate
            Ms = "Pirate"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            NameMon = "Pirate"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
        elseif Lv == 40 or Lv <= 59 or _G.SelectMonster == "Brute [Lv. 45]" then -- Brute
            Ms = "Brute"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            NameMon = "Brute"
            CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
        elseif Lv == 60 or Lv <= 74 or _G.SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
            Ms = "Desert Bandit"
            NameQuest = "DesertQuest"
            QuestLv = 1
            NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        elseif Lv == 75 or Lv <= 89 or _G.SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
            Ms = "Desert Officer"
            NameQuest = "DesertQuest"
            QuestLv = 2
            NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        elseif Lv == 90 or Lv <= 99 or _G.SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
            Ms = "Snow Bandit"
            NameQuest = "SnowQuest"
            QuestLv = 1
            NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
        elseif Lv == 100 or Lv <= 119 or _G.SelectMonster == "Snowman [Lv. 100]" then -- Snowman
            Ms = "Snowman"
            NameQuest = "SnowQuest"
            QuestLv = 2
            NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
            CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
        elseif Lv == 120 or Lv <= 149 or _G.SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
            Ms = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            QuestLv = 1
            NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
        elseif Lv == 150 or Lv <= 174 or _G.SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
            Ms = "Sky Bandit"
            NameQuest = "SkyQuest"
            QuestLv = 1
            NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
        elseif Lv == 175 or Lv <= 189 or _G.SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
            Ms = "Dark Master"
            NameQuest = "SkyQuest"
            QuestLv = 2
            NameMon = "Dark Master"
            CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
            CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
        elseif Lv == 190 or Lv <= 209 or _G.SelectMonster == "Prisoner [Lv. 190]" then -- Prisoner
            Ms = "Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 1
            NameMon = "Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, -0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)
        elseif Lv == 210 or Lv <= 249 or _G.SelectMonster == "Dangerous Prisoner [Lv. 210]" then -- Dangerous Prisoner
            Ms = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 2
            NameMon = "Dangerous Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, -0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)
        elseif Lv == 250 or Lv <= 274 or _G.SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
            Ms = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
        elseif Lv == 275 or Lv <= 299 or _G.SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
            Ms = "Gladiator"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            NameMon = "Gladiator"
            CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
            CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
        elseif Lv == 300 or Lv <= 324 or _G.SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
            Ms = "Military Soldier"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            NameMon = "Military Soldier"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
        elseif Lv == 325 or Lv <= 374 or _G.SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
            Ms = "Military Spy"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            NameMon = "Military Spy"
            CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
        elseif Lv == 375 or Lv <= 399 or _G.SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
            Ms = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif Lv == 400 or Lv <= 449 or _G.SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
            Ms = "Fishman Commando"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif Lv == 450 or Lv <= 474 or _G.SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
            Ms = "God's Guard"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            NameMon = "God's Guard"
            CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
            CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif Lv == 475 or Lv <= 524 or _G.SelectMonster == "Shanda [Lv. 475]" then -- Shanda
            Ms = "Shanda"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            NameMon = "Shanda"
            CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
            CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif Lv == 525 or Lv <= 549 or _G.SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
            Ms = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            NameMon = "Royal Squad"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
        elseif Lv == 550 or Lv <= 624 or _G.SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
            Ms = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
            CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
        elseif Lv == 625 or Lv <= 649 or _G.SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
            Ms = "Galley Pirate"
            NameQuest = "FountainQuest"
            QuestLv = 1
            NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
        elseif Lv >= 650 or _G.SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
            Ms = "Galley Captain"
            NameQuest = "FountainQuest"
            QuestLv = 2
            NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
        end
    end
    if Second_Sea then
        if Lv == 700 or Lv <= 724 or _G.SelectMonster == "Raider [Lv. 700]" then -- Raider
            Ms = "Raider"
            NameQuest = "Area1Quest"
            QuestLv = 1
            NameMon = "Raider"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif Lv == 725 or Lv <= 774 or _G.SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
            Ms = "Mercenary"
            NameQuest = "Area1Quest"
            QuestLv = 2
            NameMon = "Mercenary"
            CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
        elseif Lv == 775 or Lv <= 799 or _G.SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
            Ms = "Swan Pirate"
            NameQuest = "Area2Quest"
            QuestLv = 1
            NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif Lv == 800 or Lv <= 874 or _G.SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
            Ms = "Factory Staff"
            NameQuest = "Area2Quest"
            QuestLv = 2
            NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif Lv == 875 or Lv <= 899 or _G.SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
            Ms = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
        elseif Lv == 900 or Lv <= 949 or _G.SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
            Ms = "Marine Captain"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            NameMon = "Marine Captain"
            CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
            CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
        elseif Lv == 950 or Lv <= 974 or _G.SelectMonster == "Zombie [Lv. 950]" then -- Zombie
            Ms = "Zombie"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            NameMon = "Zombie"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
        elseif Lv == 975 or Lv <= 999 or _G.SelectMonster == "Vampire [Lv. 975]" then -- Vampire
            Ms = "Vampire"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            NameMon = "Vampire"
            CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
            CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
        elseif Lv == 1000 or Lv <= 1049 or _G.SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
            Ms = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
        elseif Lv == 1050 or Lv <= 1099 or _G.SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
            Ms = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
            CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
        elseif Lv == 1100 or Lv <= 1124 or _G.SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
            Ms = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
        elseif Lv == 1125 or Lv <= 1174 or _G.SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
            Ms = "Horned Warrior"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
            CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
        elseif Lv == 1175 or Lv <= 1199 or _G.SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
            Ms = "Magma Ninja"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
        elseif Lv == 1200 or Lv <= 1249 or _G.SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
            Ms = "Lava Pirate"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
            CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
        elseif Lv == 1250 or Lv <= 1274 or _G.SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
            Ms = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1275 or Lv <= 1299 or _G.SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
            Ms = "Ship Engineer"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1300 or Lv <= 1324 or _G.SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
            Ms = "Ship Steward"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1325 or Lv <= 1349 or _G.SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
            Ms = "Ship Officer"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif Lv == 1350 or Lv <= 1374 or _G.SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
            Ms = "Arctic Warrior"
            NameQuest = "FrostQuest"
            QuestLv = 1
            NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
            if (LevelFarmQuest or LevelFarmNoQuest or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or DevilMastery_Farm) and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            end
        elseif Lv == 1375 or Lv <= 1424 or _G.SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
            Ms = "Snow Lurker"
            NameQuest = "FrostQuest"
            QuestLv = 2
            NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
            CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
        elseif Lv == 1425 or Lv <= 1449 or _G.SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
            Ms = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
        elseif Lv >= 1450 or _G.SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
            Ms = "Water Fighter"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            NameMon = "Water Fighter"
            CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
            CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
        end
    end
    if Third_Sea then
        if Lv == 1500 or Lv <= 1524 or _G.SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
            Ms = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
        elseif Lv == 1525 or Lv <= 1574 or _G.SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
            Ms = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
            CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
        elseif Lv == 1575 or Lv <= 1599 or _G.SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
            Ms = "Dragon Crew Warrior"
            NameQuest = "Dragon Crew Warrior"
            QuestLv = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(6735.11083984375, 126.99000549316406, -711.0980224609375)
            CFrameMon = CFrame.new(6709.76416015625, 52.343994140625, -1139.030029296875)
        elseif Lv == 1600 or Lv <= 1624 or _G.SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
            Ms = "Dragon Crew Archer"
            NameQuest = "AmazonQuest"
            QuestLv = 2
            NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(6735.11083984375, 126.99000549316406, -711.0980224609375)
            CFrameMon = CFrame.new(6818.5888671875, 482.8789978027344, 512.7269897460938)
        elseif Lv == 1625 or Lv <= 1649 or _G.SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
            Ms = "Female Islander"
            NameQuest = "AmazonQuest"
            QuestLv = 1
            NameMon = "Female Islander"
            CFrameQ = CFrame.new(5214.3388671875, 1000.468017578125, 759.5070190429688)
            CFrameMon = CFrame.new(4462.65283203125, 1005.1019897460938, 551.0059814453125)
        elseif Lv == 1650 or Lv <= 1699 or _G.SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
            Ms = "Giant Islander"
            NameQuest = "AmazonQuest"
            QuestLv = 2
            NameMon = "Giant Islander"
            CFrameQ = CFrame.new(5214.3388671875, 1000.468017578125, 759.5070190429688)
            CFrameMon = CFrame.new(4637.8837890625, 1078.7860107421875, 882.4199829101562)
        elseif Lv == 1700 or Lv <= 1724 or _G.SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
            Ms = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
        elseif Lv == 1725 or Lv <= 1774 or _G.SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
            Ms = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
        elseif Lv == 1775 or Lv <= 1799 or _G.SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
            Ms = "Fishman Raider"
            NameQuest = "DeepForestIsland3"
            QuestLv = 1
            NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
            CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
        elseif Lv == 1800 or Lv <= 1824 or _G.SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
            Ms = "Fishman Captain"
            NameQuest = "DeepForestIsland3"
            QuestLv = 2
            NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
            CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
        elseif Lv == 1825 or Lv <= 1849 or _G.SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
            Ms = "Forest Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 1
            NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
        elseif Lv == 1850 or Lv <= 1899 or _G.SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
            Ms = "Mythological Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 2
            NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
            CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
        elseif Lv == 1900 or Lv <= 1924 or _G.SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
            Ms = "Jungle Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 1
            NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
        elseif Lv == 1925 or Lv <= 1974 or _G.SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
            Ms = "Musketeer Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 2
            NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
            CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
        elseif Lv == 1975 or Lv <= 1999 or _G.SelectMonster == "Reborn Skeleton [Lv. 1975]" then
            Ms = "Reborn Skeleton"
            NameQuest = "HauntedQuest1"
            QuestLv = 1
            NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
        elseif Lv == 2000 or Lv <= 2024 or _G.SelectMonster == "Living Zombie [Lv. 2000]" then
            Ms = "Living Zombie"
            NameQuest = "HauntedQuest1"
            QuestLv = 2
            NameMon = "Living Zombie"
            CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
            CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
        elseif Lv == 2025 or Lv <= 2049 or _G.SelectMonster == "Demonic Soul [Lv. 2025]" then
            Ms = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
        elseif Lv == 2050 or Lv <= 2074 or _G.SelectMonster == "Posessed Mummy [Lv. 2050]" then
            Ms = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
        elseif Lv == 2075 or Lv <= 2099 or _G.SelectMonster == "Peanut Scout [Lv. 2075]" then
            Ms = "Peanut Scout"
            NameQuest = "NutsIslandQuest"
            QuestLv = 1
            NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
        elseif Lv == 2100 or Lv <= 2124 or _G.SelectMonster == "Peanut President [Lv. 2100]" then
            Ms = "Peanut President"
            NameQuest = "NutsIslandQuest"
            QuestLv = 2
            NameMon = "Peanut President"
            CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-2150.587890625, 122.49767303467, -10358.994140625)
        elseif Lv == 2125 or Lv <= 2149 or _G.SelectMonster == "Ice Cream Chef [Lv. 2125]" then
            Ms = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
        elseif Lv == 2150 or Lv <= 2199 or _G.SelectMonster == "Ice Cream Commander [Lv. 2150]" then
            Ms = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
            CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
        elseif Lv == 2200 or Lv <= 2224 or _G.SelectMonster == "Cookie Crafter [Lv. 2200]" then
            Ms = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            QuestLv = 1
            NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
        elseif Lv == 2225 or Lv <= 2249 or _G.SelectMonster == "Cake Guard [Lv. 2225]" then
            Ms = "Cake Guard"
            NameQuest = "CakeQuest1"
            QuestLv = 2
            NameMon = "Cake Guard"
            CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
            CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
        elseif Lv == 2250 or Lv <= 2274 or _G.SelectMonster == "Baking Staff [Lv. 2250]" then
            Ms = "Baking Staff"
            NameQuest = "CakeQuest2"
            QuestLv = 1
            NameMon = "Baking Staff"
            CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
        elseif Lv == 2275 or Lv <= 2299 or _G.SelectMonster == "Head Baker [Lv. 2275]" then
            Ms = "Head Baker"
            NameQuest = "CakeQuest2"
            QuestLv = 2
            NameMon = "Head Baker"
            CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-2251.5791, 52.2714615, -13033.3965, -0.991971016, 0, -0.126466095, 0, 1, 0, 0.126466095, 0, -0.991971016)
        elseif Lv == 2300 or Lv <= 2324 or _G.SelectMonster == "Cocoa Warrior [Lv. 2300]" then
            Ms = "Cocoa Warrior"
            NameQuest ="ChocQuest1"
            QuestLv = 1
            NameMon = "Cocoa Warrior"
            CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            CFrameMon = CFrame.new(167.978516, 26.2254658, -12238.874, -0.939700961, 0, 0.341998369, 0, 1, 0, -0.341998369, 0, -0.939700961)
        elseif Lv == 2325 or Lv <= 2349 or _G.SelectMonster == "Chocolate Bar Battler [Lv. 2325]" then
            Ms = "Chocolate Bar Battler"
            NameQuest = "ChocQuest1"
            QuestLv = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQ = CFrame.new(231.75, 23.9003029, -12200.292, -1, 0, 0, 0, 1, 0, 0, 0, -1)
            CFrameMon = CFrame.new(701.312073, 25.5824986, -12708.2148, -0.342042685, 0, -0.939684391, 0, 1, 0, 0.939684391, 0, -0.342042685)
        elseif Lv == 2350 or Lv <= 2374 or _G.SelectMonster == "Sweet Thief [Lv. 2350]" then
            Ms = "Sweet Thief"
            NameQuest = "ChocQuest2"
            QuestLv = 1
            NameMon = "Sweet Thief"
            CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(-140.258301, 25.5824986, -12652.3115, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
        elseif Lv == 2375 or Lv <= 2400 or _G.SelectMonster == "Candy Rebel [Lv. 2375]" then
            Ms = "Candy Rebel"
            NameQuest = "ChocQuest2"
            QuestLv = 2
            NameMon = "Candy Rebel"
            CFrameQ = CFrame.new(151.198242, 23.8907146, -12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(47.9231453, 25.5824986, -13029.2402, -0.819156051, 0, -0.573571265, 0, 1, 0, 0.573571265, 0, -0.819156051)
        elseif Lv == 2400 or Lv <= 2424 or _G.SelectMonster == "Candy Pirate [Lv. 2400]" then
            Ms = "Candy Pirate"
            NameQuest = "CandyQuest1"
            QuestLv = 1
            NameMon = "Candy Pirate"
            CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
            CFrameMon = CFrame.new(-1437.56348, 17.1481285, -14385.6934, 0.173624337, -0, -0.984811902, 0, 1, -0, 0.984811902, 0, 0.173624337)
        elseif Lv == 2425 or Lv <= 2449 or _G.SelectMonster == "Snow Demon [Lv. 2425]" then
            Ms = "Snow Demon"
            NameQuest = "CandyQuest1"
            QuestLv = 2
            NameMon = "Snow Demon"
            CFrameQ = CFrame.new(-1149.328, 13.5759039, -14445.6143, -0.156446099, 0, -0.987686574, 0, 1, 0, 0.987686574, 0, -0.156446099)
            CFrameMon = CFrame.new(-916.222656, 17.1481285, -14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)

        elseif Lv == 2450 or Lv <= 2474 or _G.SelectMonster == "Isle Outlaw [Lv. 2450]" then
            Ms = "Isle Outlaw"
            NameQuest = "TikiQuest1"
            QuestLv = 1
            NameMon = "Isle Outlaw"
            CFrameQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
            CFrameMon = CFrame.new(-16122.4062, 10.6328173, -257.351685, -0.630029082, 0, 0.776571631, 0, 1, 0, -0.776571631, 0, -0.630029082)
        elseif Lv == 2475 or Lv <= 2499 or _G.SelectMonster == "Island Boy [2475]" then
            Ms = "Island Boy"
            NameQuest = "TikiQuest1"
            QuestLv = 2
            NameMon = "Island Boy"
            CFrameQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566)
            CFrameMon = CFrame.new(-16736.2266, 20.533947, -131.718811, 0.546393692, 0, 0.837528467, 0, 1, 0, -0.837528467, 0, 0.546393692)
        elseif Lv == 2500 or Lv <= 2524 or _G.SelectMonster == "Sun-kissed Warrior [Lv. 2500]" then
            Ms = "Sun-kissed Warrior"
            NameQuest = "TikiQuest2"
            QuestLv = 1
            NameMon = "Sun-"
            CFrameQ = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
            CFrameMon = CFrame.new(-16413.5078, 54.6350479, 1054.43555, -0.999391913, 0, -0.034868788, 0, 1, 0, 0.034868788, 0, -0.999391913)
        elseif Lv == 2525 or Lv <= 2549 or _G.SelectMonster == "Isle Champion [Lv. 2525]" then
            Ms = "Isle Champion"
            NameQuest = "TikiQuest2"
            QuestLv = 2
            NameMon = "Isle Champion"
            CFrameQ = CFrame.new(-16541.0215, 54.770813, 1051.46118, 0.0410757065, -0, -0.999156058, 0, 1, -0, 0.999156058, 0, 0.0410757065)
            CFrameMon = CFrame.new(-16787.3203, 20.6350517, 992.131836, -0.775471091, 0, 0.631383121, 0, 1, 0, -0.631383121, 0, -0.775471091)
        elseif Lv == 2550 or Lv <= 2574 or _G.SelectMonster == "Serpent Hunter [Lv. 2550]" then
            Ms = "Serpent Hunter"
            NameQuest = "TikiQuest3"
            QuestLv = 1
            NameMon = "Serpent Hunter"
            CFrameQ = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(-16654.7754, 105.286232, 1579.67444, 0.999096751, 4.45934489e-08, 0.0424928814, -4.38822667e-08, 1, -1.76692847e-08, -0.0424928814, 1.57886415e-08, 0.999096751)
elseif (Lv >= 2575 and Lv <= 2599) 
or _G.SelectMonster == "Skull Slayer [Lv. 2575]" then
    Ms = "Skull Slayer"
    NameQuest = "TikiQuest3"
    QuestLv = 2
    NameMon = "Skull Slayer"
    CFrameQ = CFrame.new(-16665.1914, 104.596405, 1579.69434, 0.951068401, 0, -0.308980465, 0, 1, 0, 0.308980465, 0, 0.951068401)
    CFrameMon = CFrame.new(-16654.7754, 105.286232, 1579.67444, 0.999096751, 4.45934489e-08, 0.0424928814, -4.38822667e-08, 1, -1.76692847e-08, -0.0424928814, 1.57886415e-08, 0.999096751)

-- 2600 - 2624
elseif Lv >= 2600 and Lv <= 2624 then
    Ms = "Reef Bandit"
    NameQuest = "SubmergedQuest1"
    QuestLv = 1
    NameMon = "Reef Bandit"
    CFrameQ = CFrame.new(10882.264, -2086.322, 10034.226)
    CFrameMon = CFrame.new(10736.6191, -2087.8439, 9338.4882)

-- 2625 - 2649
elseif Lv >= 2625 and Lv <= 2649 then
    Ms = "Coral Pirate"
    NameQuest = "SubmergedQuest1"
    QuestLv = 2
    NameMon = "Coral Pirate"
    CFrameQ = CFrame.new(10882.264, -2086.322, 10034.226)
    CFrameMon = CFrame.new(10965.1025, -2158.8842, 9177.2597)

-- 2650 - 2674
elseif Lv >= 2650 and Lv <= 2674 then
    Ms = "Sea Chanter"
    NameQuest = "SubmergedQuest2"
    QuestLv = 1
    NameMon = "Sea Chanter"
    CFrameQ = CFrame.new(10882.264, -2086.322, 10034.226)
    CFrameMon = CFrame.new(10621.0342, -2087.8440, 10102.0332)

-- 2675 - 2699
elseif Lv >= 2675 and Lv <= 2699 then
    Ms = "Ocean Prophet"
    NameQuest = "SubmergedQuest2"
    QuestLv = 2
    NameMon = "Ocean Prophet"
    CFrameQ = CFrame.new(10882.264, -2086.322, 10034.226)
    CFrameMon = CFrame.new(11056.1445, -2001.6717, 10117.4493)

-- 2700 - 2724
elseif Lv >= 2700 and Lv <= 2724 then
    Ms = "High Disciple"
    NameQuest = "SubmergedQuest3"
    QuestLv = 1
    NameMon = "High Disciple"
    CFrameQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
    CFrameMon = CFrame.new(9828.087890625, -1940.908935546875, 9693.0634765625)

-- 2725 - 2800
elseif Lv >= 2725 and Lv <= 2800 then
    Ms = "Grand Devotee"
    NameQuest = "SubmergedQuest3"
    QuestLv = 2
    NameMon = "Grand Devotee"
    CFrameQ = CFrame.new(9636.52441, -1992.19507, 9609.52832)
    CFrameMon = CFrame.new(9557.5849609375, -1928.0404052734375, 9859.1826171875)
		end
    end
end;

--// Select Monster
if First_Sea then
    tableMon = {"Bandit [Lv. 5]","Monkey [Lv. 14]","Gorilla [Lv. 20]","Pirate [Lv. 35]","Brute [Lv. 45]","Desert Bandit [Lv. 60]","Desert Officer [Lv. 70]","Snow Bandit [Lv. 90]","Snowman [Lv. 100]","Chief Petty Officer [Lv. 120]","Sky Bandit [Lv. 150]","Dark Master [Lv. 175]","Prisoner [Lv. 190]", "Dangerous Prisoner [Lv. 210]","Toga Warrior [Lv. 250]","Gladiator [Lv. 275]","Military Soldier [Lv. 300]","Military Spy [Lv. 325]","Fishman Warrior [Lv. 375]","Fishman Commando [Lv. 400]","God's Guard [Lv. 450]","Shanda [Lv. 475]","Royal Squad [Lv. 525]","Royal Soldier [Lv. 550]","Galley Pirate [Lv. 625]","Galley Captain [Lv. 650]"}
elseif Second_Sea then
    tableMon = {"Raider [Lv. 700]","Mercenary [Lv. 725]","Swan Pirate [Lv. 775]","Factory Staff [Lv. 800]","Marine Lieutenant [Lv. 875]","Marine Captain [Lv. 900]","Zombie [Lv. 950]","Vampire [Lv. 975]","Snow Trooper [Lv. 1000]","Winter Warrior [Lv. 1050]","Lab Subordinate [Lv. 1100]","Horned Warrior [Lv. 1125]","Magma Ninja [Lv. 1175]","Lava Pirate [Lv. 1200]","Ship Deckhand [Lv. 1250]","Ship Engineer [Lv. 1275]","Ship Steward [Lv. 1300]","Ship Officer [Lv. 1325]","Arctic Warrior [Lv. 1350]","Snow Lurker [Lv. 1375]","Sea Soldier [Lv. 1425]","Water Fighter [Lv. 1450]"}
elseif Third_Sea then
    tableMon = {"Pirate Millionaire [Lv. 1500]","Dragon Crew Warrior [Lv. 1575]","Dragon Crew Archer [Lv. 1600]","Female Islander [Lv. 1625]","Giant Islander [Lv. 1650]","Marine Commodore [Lv. 1700]","Marine Rear Admiral [Lv. 1725]","Fishman Raider [Lv. 1775]","Fishman Captain [Lv. 1800]","Forest Pirate [Lv. 1825]","Mythological Pirate [Lv. 1850]","Jungle Pirate [Lv. 1900]","Musketeer Pirate [Lv. 1925]","Reborn Skeleton [Lv. 1975]","Living Zombie [Lv. 2000]","Demonic Soul [Lv. 2025]","Posessed Mummy [Lv. 2050]", "Peanut Scout [Lv. 2075]", "Peanut President [Lv. 2100]", "Ice Cream Chef [Lv. 2125]", "Ice Cream Commander [Lv. 2150]", "Cookie Crafter [Lv. 2200]", "Cake Guard [Lv. 2225]", "Baking Staff [Lv. 2250]", "Head Baker [Lv. 2275]", "Cocoa Warrior [Lv. 2300]", "Chocolate Bar Battler [Lv. 2325]", "Sweet Thief [Lv. 2350]", "Candy Rebel [Lv. 2375]", "Candy Pirate [Lv. 2400]", "Snow Demon [Lv. 2425]",
        "Isle Outlaw [Lv. 2450]", "Island Boy [2475]", "Sun-kissed Warrior [Lv. 2500]", "Isle Champion [Lv. 2525]", "Serpent Hunter [Lv. 2550]", "Skull Slayer [Lv. 2575]"
    }
end
function CheckBossQuest()
	if First_Sea then
		if SelectBoss == "The Gorilla King" then
			BossMon = "The Gorilla King [Lv. 25] [Boss]"
			NameBoss = 'The Gorrila King'
			NameQuestBoss = "JungleQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$2,000\n7,000 Exp."
			CFrameQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
			CFrameBoss = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
		elseif SelectBoss == "Bobby" then
			BossMon = "Bobby [Lv. 55] [Boss]"
			NameBoss = 'Bobby'
			NameQuestBoss = "BuggyQuest1"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$8,000\n35,000 Exp."
			CFrameQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
			CFrameBoss = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
		elseif SelectBoss == "The Saw" then
			BossMon = "The Saw [Lv. 100] [Boss]"
			NameBoss = 'The Saw'
			CFrameBoss = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
		elseif SelectBoss == "Yeti" then
			BossMon = "Yeti [Lv. 110] [Boss]"
			NameBoss = 'Yeti'
			NameQuestBoss = "SnowQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$10,000\n180,000 Exp."
			CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
			CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
		elseif SelectBoss == "Mob Leader" then
			BossMon = "Mob Leader [Lv. 120] [Boss]"
			NameBoss = 'Mob Leader'
			CFrameBoss = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
		elseif SelectBoss == "Vice Admiral" then
			BossMon = "Vice Admiral [Lv. 130] [Boss]"
			NameBoss = 'Vice Admiral'
			NameQuestBoss = "MarineQuest2"
			QuestLvBoss = 2;
			RewardBoss = "Reward:\n$10,000\n180,000 Exp."
			CFrameQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
			CFrameBoss = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
		elseif SelectBoss == "Saber Expert" then
			NameBoss = 'Saber Expert'
			BossMon = "Saber Expert [Lv. 200] [Boss]"
			CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
		elseif SelectBoss == "Warden" then
			BossMon = "Warden [Lv. 220] [Boss]"
			NameBoss = 'Warden'
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 1;
			RewardBoss = "Reward:\n$6,000\n850,000 Exp."
			CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
			CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif SelectBoss == "Chief Warden" then
			BossMon = "Chief Warden [Lv. 230] [Boss]"
			NameBoss = 'Chief Warden'
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 2;
			RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
			CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
			CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif SelectBoss == "Swan" then
			BossMon = "Swan [Lv. 240] [Boss]"
			NameBoss = 'Swan'
			NameQuestBoss = "ImpelQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
			CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
			CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
		elseif SelectBoss == "Magma Admiral" then
			BossMon = "Magma Admiral [Lv. 350] [Boss]"
			NameBoss = 'Magma Admiral'
			NameQuestBoss = "MagmaQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
			CFrameQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
			CFrameBoss = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
		elseif SelectBoss == "Fishman Lord" then
			BossMon = "Fishman Lord [Lv. 425] [Boss]"
			NameBoss = 'Fishman Lord'
			NameQuestBoss = "FishmanQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
			CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
			CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
		elseif SelectBoss == "Wysper" then
			BossMon = "Wysper [Lv. 500] [Boss]"
			NameBoss = 'Wysper'
			NameQuestBoss = "SkyExp1Quest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
			CFrameQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
			CFrameBoss = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
		elseif SelectBoss == "Thunder God" then
			BossMon = "Thunder God [Lv. 575] [Boss]"
			NameBoss = 'Thunder God'
			NameQuestBoss = "SkyExp2Quest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
			CFrameQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
			CFrameBoss = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
		elseif SelectBoss == "Cyborg" then
			BossMon = "Cyborg [Lv. 675] [Boss]"
			NameBoss = 'Cyborg'
			NameQuestBoss = "FountainQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
			CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
			CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
		elseif SelectBoss == "Ice Admiral" then
			BossMon = "Ice Admiral [Lv. 700] [Boss]"
			NameBoss = 'Ice Admiral'
			CFrameBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
		elseif SelectBoss == "Greybeard" then
			BossMon = "Greybeard [Lv. 750] [Raid Boss]"
			NameBoss = 'Greybeard'
			CFrameBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
		end
	end;
	if Second_Sea then
		if SelectBoss == "Diamond" then
			BossMon = "Diamond [Lv. 750] [Boss]"
			NameBoss = 'Diamond'
			NameQuestBoss = "Area1Quest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
			CFrameQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
			CFrameBoss = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
		elseif SelectBoss == "Jeremy" then
			BossMon = "Jeremy [Lv. 850] [Boss]"
			NameBoss = 'Jeremy'
			NameQuestBoss = "Area2Quest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
			CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
			CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
		elseif SelectBoss == "Fajita" then
			BossMon = "Fajita [Lv. 925] [Boss]"
			NameBoss = 'Fajita'
			NameQuestBoss = "MarineQuest3"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
			CFrameQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
			CFrameBoss = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
		elseif SelectBoss == "Don Swan" then
			BossMon = "Don Swan [Lv. 1000] [Boss]"
			NameBoss = 'Don Swan'
			CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
		elseif SelectBoss == "Smoke Admiral" then
			BossMon = "Smoke Admiral [Lv. 1150] [Boss]"
			NameBoss = 'Smoke Admiral'
			NameQuestBoss = "IceSideQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
			CFrameQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
			CFrameBoss = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
		elseif SelectBoss == "Awakened Ice Admiral" then
			BossMon = "Awakened Ice Admiral [Lv. 1400] [Boss]"
			NameBoss = 'Awakened Ice Admiral'
			NameQuestBoss = "FrostQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
			CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
			CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
		elseif SelectBoss == "Tide Keeper" then
			BossMon = "Tide Keeper [Lv. 1475] [Boss]"
			NameBoss = 'Tide Keeper'
			NameQuestBoss = "ForgottenQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
			CFrameQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
			CFrameBoss = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
		elseif SelectBoss == "Darkbeard" then
			BossMon = "Darkbeard [Lv. 1000] [Raid Boss]"
			NameBoss = 'Darkbeard'
			CFrameMon = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
		elseif SelectBoss == "Cursed Captain" then
			BossMon = "Cursed Captain [Lv. 1325] [Raid Boss]"
			NameBoss = 'Cursed Captain'
			CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
		elseif SelectBoss == "Order" then
			BossMon = "Order [Lv. 1250] [Raid Boss]"
			NameBoss = 'Order'
			CFrameBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
		end
	end;
	if Third_Sea then
		if SelectBoss == "Stone" then
			BossMon = "Stone [Lv. 1550] [Boss]"
			NameBoss = 'Stone'
			NameQuestBoss = "PiratePortQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
			CFrameQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
			CFrameBoss = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
		elseif SelectBoss == "Island Empress" then
			BossMon = "Island Empress [Lv. 1675] [Boss]"
			NameBoss = 'Island Empress'
			NameQuestBoss = "AmazonQuest2"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
			CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
			CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
		elseif SelectBoss == "Kilo Admiral" then
			BossMon = "Kilo Admiral [Lv. 1750] [Boss]"
			NameBoss = 'Kilo Admiral'
			NameQuestBoss = "MarineTreeIsland"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
			CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
			CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
		elseif SelectBoss == "Captain Elephant" then
			BossMon = "Captain Elephant [Lv. 1875] [Boss]"
			NameBoss = 'Captain Elephant'
			NameQuestBoss = "DeepForestIsland"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
			CFrameQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
			CFrameBoss = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
		elseif SelectBoss == "Beautiful Pirate" then
			BossMon = "Beautiful Pirate [Lv. 1950] [Boss]"
			NameBoss = 'Beautiful Pirate'
			NameQuestBoss = "DeepForestIsland2"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
			CFrameQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
			CFrameBoss = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
		elseif SelectBoss == "Cake Queen" then
			BossMon = "Cake Queen [Lv. 2175] [Boss]"
			NameBoss = 'Cake Queen'
			NameQuestBoss = "IceCreamIslandQuest"
			QuestLvBoss = 3;
			RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
			CFrameQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
			CFrameBoss = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
		elseif SelectBoss == "Longma" then
			BossMon = "Longma [Lv. 2000] [Boss]"
			NameBoss = 'Longma'
			CFrameBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
		elseif SelectBoss == "Soul Reaper" then
			BossMon = "Soul Reaper [Lv. 2100] [Raid Boss]"
			NameBoss = 'Soul Reaper'
			CFrameBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
		elseif SelectBoss == "rip_indra True Form" then
			BossMon = "rip_indra True Form [Lv. 5000] [Raid Boss]"
			NameBoss = 'rip_indra True Form'
			CFrameBoss = CFrame.new(-5415.3920898438, 505.74133300781, -2814.0166015625)
		end
	end
end;
function MaterialMon()
	if SelectMaterial == "Radioactive Material" then
		MMon = "Factory Staff"
		MPos = CFrame.new(295, 73, -56)
		SP = "Default"
	elseif SelectMaterial == "Mirage Droplet" then
		MMon = "Water Fighter"
		MPos = CFrame.new(-3385, 239, -10542)
		SP = "Default"
	elseif SelectMaterial == "Magma Ore" then
		if First_Sea then
			MMon = "Military Spy"
			MPos = CFrame.new(-5815, 84, 8820)
			SP = "Default"
		elseif Second_Sea then
			MMon = "Magma Ninja"
			MPos = CFrame.new(-5428, 78, -5959)
			SP = "Default"
		end
	elseif SelectMaterial == "Angel Wings" then
		MMon = "God's Guard"
		MPos = CFrame.new(-4698, 845, -1912)
		SP = "Default"
		if (GetRoot().Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000 then
			RS.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7859.09814, 5544.19043, -381.476196))
		end
	elseif SelectMaterial == "Leather" then
		if First_Sea then
			MMon = "Brute"
			MPos = CFrame.new(-1145, 15, 4350)
			SP = "Default"
		elseif Second_Sea then
			MMon = "Marine Captain"
			MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
			SP = "Default"
		elseif Third_Sea then
			MMon = "Jungle Pirate"
			MPos = CFrame.new(-11975.78515625, 331.7734069824219, -10620.0302734375)
			SP = "Default"
		end
	elseif SelectMaterial == "Scrap Metal" then
		if First_Sea then
			MMon = "Brute"
			MPos = CFrame.new(-1145, 15, 4350)
			SP = "Default"
		elseif Second_Sea then
			MMon = "Swan Pirate"
			MPos = CFrame.new(878, 122, 1235)
			SP = "Default"
		elseif Third_Sea then
			MMon = "Jungle Pirate"
			MPos = CFrame.new(-12107, 332, -10549)
			SP = "Default"
		end
	elseif SelectMaterial == "Fish Tail" then
		if Third_Sea then
			MMon = "Fishman Raider"
			MPos = CFrame.new(-10993, 332, -8940)
			SP = "Default"
		elseif First_Sea then
			MMon = "Fishman Warrior"
			MPos = CFrame.new(61123, 19, 1569)
			SP = "Default"
			if (GetRoot().Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
				RS.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
			end
		end
	elseif SelectMaterial == "Demonic Wisp" then
		MMon = "Demonic Soul"
		MPos = CFrame.new(-9507, 172, 6158)
		SP = "Default"
	elseif SelectMaterial == "Vampire Fang" then
		MMon = "Vampire"
		MPos = CFrame.new(-6033, 7, -1317)
		SP = "Default"
	elseif SelectMaterial == "Conjured Cocoa" then
		MMon = "Chocolate Bar Battler"
		MPos = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
		SP = "Default"
	elseif SelectMaterial == "Dragon Scale" then
		MMon = "Dragon Crew Archer"
		MPos = CFrame.new(6594, 383, 139)
		SP = "Default"
	elseif SelectMaterial == "Gunpowder" then
		MMon = "Pistol Billionaire"
		MPos = CFrame.new(-469, 74, 5904)
		SP = "Default"
	elseif SelectMaterial == "Mini Tusk" then
		MMon = "Mythological Pirate"
		MPos = CFrame.new(-13545, 470, -6917)
		SP = "Default"
	end
end;
function EquipTool(Tool)
	pcall(function()
		GetHum():EquipTool(Lplr.Backpack[Tool])
	end)
end;

local stoppos = {}
    function topos(Pos)
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        tween = game:GetService("TweenService"):Create(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/TweenSpeed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        ):Play()

        function stoppos:Stop()
            tween:Cancel()
        end
    
        return stoppos
end

    function fastpos(Pos)
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        Speed = 1000
        game:GetService("TweenService"):Create(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        ):Play()
    end

    function slowpos(Pos)
        Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        Speed = 150
        game:GetService("TweenService"):Create(
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = Pos}
        ):Play()
    end

    -- or (game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark) or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark) or (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha) or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew)
    
    local stopboat = {}
function TPB(pos, boat)
	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((boat.CFrame.Position - pos.Position).Magnitude/BoatSpeed, Enum.EasingStyle.Linear)
	tween = tween_s:Create(boat, info, {CFrame = pos})

    if (boat.CFrame.Position - pos.Position).Magnitude <= 25 then
        tween:Cancel()
    else
        tween:Play()
    end


	function stopboat:Stop()
		tween:Cancel()
	end

	return stopboat
end

function TPP(CFgo)
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then tween:Cancel() repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return end
	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/TweenSpeed, Enum.EasingStyle.Linear)
	tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
	tween:Play()

	local tweenfunc = {}

	function tweenfunc:Stop()
		tween:Cancel()
	end

	return tweenfunc
end


function Tween(P1)
    local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance > 1 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Play()
    if _G.StopTween then
        game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Cancel()
    end
end

function TP2(P1)
    local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance > 1 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Play()
    if _G.StopTween2 then
        game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1}):Cancel()
    end
    _G.Clip2 = true
    wait(Distance/Speed)
    _G.Clip2 = false
end

function CancelTween(target)
    if not target then
        _G.StopTween = true
        wait(.1)
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait(.1)
        _G.StopTween = false
    end
end

function BTP(Tarpos)
    if (Tarpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
        game.Players.LocalPlayer.Character.Head:Destroy()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Tarpos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
        wait(1)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Tarpos
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
        wait(7)
    elseif (Tarpos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
        Tween(Tarpos)
    end
end

function AutoClick()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
end

function AutoClick2()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
end
task.spawn(function()
    while wait() do
        local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
        CameraShakerR:Stop()
    end
end)
--[[
spawn(function()
    while task.wait() do
        pcall(function()
            if EventLocation or DragonTalonUpgrade or TreeDestroyFarm or TeleportPrehistoric or PurpleBeltF or WhiteBeltF or BlazeEmberFarm or AttackFish or AttackTerrorshark or AttackGhostship or AutoSeabeastFarm or AutoSeaFarm or DojoClaimQuest or DojoRequestQuest or DojoQuestEnable or AutoSTartRaids or TeleporttoFruitDealer or _G.TeleportFruit or TeleporttoKitsune or CollectAzureAmber or AutoTrain or AutoKillHuman or AutoPirateCastle or TweenToPlayer or AutoSail or AutoFarmTerrorShark or AutoFarmFish or AutoFarmSeaBeast or AutoFarmGhostBoats or LevelFarmNoQuest or LevelFarmQuest or Farm_Bone or Farm_Ectoplasm or Nearest_Farm or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or Auto_Farm_Material or AutoFarmBossNoQuest or AutoFarmBossQuest or GunMastery_Farm or DevilMastery_Farm or AutoKenV2 or AutoFarmKen or AutoNextIsland or BossRaid or _G.Teleport_to_Player or _G.Clip or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or TeleporttoMirage or TeleporttoGear or _G.Auto_Teleport_Fruit or AutoSecondWorld or AutoThirdWorld or AutoDeathStep or AutoSuperhuman or AutoSharkman or AutoElectricClaw or AutoDragonTalon or AutoGodhuman or AutoSaber or AutoRengoku or AutoBuddySword or AutoPole or AutoYama or AutoCavander or AutoTushita or Auto_Cursed_Dual_Katana or Auto_Quest_Yama_1 or Auto_Quest_Yama_2 or Auto_Quest_Yama_3 or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoEliteHunter or AutoCakePrince or _G.AutoDoughKing or AutoDarkDagger or AutoHallowSycthe or AutoCitizen or AutoEvoRace or AutoBartilo or AutoFactory or _G.SwanGlasses or RipIndra or AutoRainbowHaki or AutoTorch or AutoSoulGuitar or AutoTryLuck or AutoPray or AutoAdvanceDungeon or AutoMusketeer or Auto_Serpent_Bow then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000,100000,100000)
                    Noclip.Velocity = Vector3.new(0,0,0)
                end
            else
                if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
                end
            end
        end)
    end
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if EventLocation or DragonTalonUpgrade or TreeDestroyFarm or TeleportPrehistoric or PurpleBeltF or WhiteBeltF or BlazeEmberFarm or AttackFish or AttackTerrorshark or AttackGhostship or AutoSeabeastFarm or AutoSeaFarm or DojoClaimQuest or DojoRequestQuest or DojoQuestEnable or AutoSTartRaids or TeleporttoFruitDealer or _G.TeleportFruit or TeleporttoKitsune or CollectAzureAmber or AutoTrain or AutoKillHuman or AutoPirateCastle or TweenToPlayer or AutoSail or AutoFarmTerrorShark or AutoFarmFish or AutoFarmSeaBeast or AutoFarmGhostBoats or LevelFarmNoQuest or LevelFarmQuest or Farm_Bone or Farm_Ectoplasm or Nearest_Farm or SelectMonster_Quest_Farm or SelectMonster_NoQuest_Farm or Auto_Farm_Material or AutoFarmBossNoQuest or AutoFarmBossQuest or GunMastery_Farm or DevilMastery_Farm or AutoKenV2 or AutoFarmKen or AutoNextIsland or BossRaid or _G.Teleport_to_Player or _G.Clip or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or TeleporttoMirage or TeleporttoGear or _G.Auto_Teleport_Fruit or AutoSecondWorld or AutoThirdWorld or AutoDeathStep or AutoSuperhuman or AutoSharkman or AutoElectricClaw or AutoDragonTalon or AutoGodhuman or AutoSaber or AutoRengoku or AutoBuddySword or AutoPole or AutoYama or AutoCavander or AutoTushita or Auto_Cursed_Dual_Katana or Auto_Quest_Yama_1 or Auto_Quest_Yama_2 or Auto_Quest_Yama_3 or Auto_Quest_Tushita_1 or Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoEliteHunter or AutoCakePrince or _G.AutoDoughKing or AutoDarkDagger or AutoHallowSycthe or AutoCitizen or AutoEvoRace or AutoBartilo or AutoFactory or _G.SwanGlasses or RipIndra or AutoRainbowHaki or AutoTorch or AutoSoulGuitar or AutoTryLuck or AutoPray or AutoAdvanceDungeon or AutoMusketeer or Auto_Serpent_Bow then
                for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)]]

function fastpos(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	Speed = 1000
	game:GetService("TweenService"):Create(
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = Pos}
	):Play()
end

function slowpos(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	Speed = 150
	game:GetService("TweenService"):Create(
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = Pos}
	):Play()
end

-- or (game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark) or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark) or (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha) or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew)

local stopboat = {}
function TPB(pos, boat)
local tween_s = game:service"TweenService"
local info = TweenInfo.new((boat.CFrame.Position - pos.Position).Magnitude/BoatSpeed, Enum.EasingStyle.Linear)
tween = tween_s:Create(boat, info, {CFrame = pos})

if (boat.CFrame.Position - pos.Position).Magnitude <= 25 then
	tween:Cancel()
else
	tween:Play()
end


function stopboat:Stop()
	tween:Cancel()
end

return stopboat
end

function TPP(CFgo)
if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then tween:Cancel() repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return end
local tween_s = game:service"TweenService"
local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/TweenSpeed, Enum.EasingStyle.Linear)
tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
tween:Play()

local tweenfunc = {}

function tweenfunc:Stop()
	tween:Cancel()
end

return tweenfunc
end


function AutoClick()
	VU:CaptureController()
	VU:Button1Down(Vector2.new(1280, 672))
end;

function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function UnEquipWeapon(Weapon)
    if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
        _G.NotAutoEquip = true
        wait(.5)
        game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
        wait(.1)
        _G.NotAutoEquip = false
    end
end

function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(.1)
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
        end
    end
end

local function shouldEnableNoclip()
    return BlazeEmberFarm or AttackFish or AttackTerrorshark or AttackGhostship or 
           AutoSeabeastFarm or AutoSeaFarm or DojoClaimQuest or DojoRequestQuest or 
           DojoQuestEnable or AutoSTartRaids or TeleporttoFruitDealer or 
           _G.TeleportFruit or TeleporttoKitsune or CollectAzureAmber or 
           AutoTrain or AutoKillHuman or AutoPirateCastle or TweenToPlayer or 
           AutoSail or AutoFarmTerrorShark or AutoFarmFish or AutoFarmSeaBeast or 
           AutoFarmGhostBoats or LevelFarmNoQuest or LevelFarmQuest or 
           Farm_Bone or Farm_Ectoplasm or Nearest_Farm or SelectMonster_Quest_Farm or 
           SelectMonster_NoQuest_Farm or Auto_Farm_Material or AutoFarmBossNoQuest or 
           AutoFarmBossQuest or GunMastery_Farm or DevilMastery_Farm or 
           AutoKenV2 or AutoFarmKen or AutoNextIsland or BossRaid or 
           _G.Teleport_to_Player or _G.Clip or _G.Auto_Kill_Player_Melee or 
           _G.Auto_Kill_Player_Gun or TeleporttoMirage or TeleporttoGear or 
           _G.Auto_Teleport_Fruit or AutoSecondWorld or AutoThirdWorld or 
           AutoDeathStep or AutoSuperhuman or AutoSharkman or AutoElectricClaw or 
           AutoDragonTalon or AutoGodhuman or AutoSaber or AutoRengoku or 
           AutoBuddySword or AutoPole or AutoYama or AutoCavander or 
           AutoTushita or Auto_Cursed_Dual_Katana or Auto_Quest_Yama_1 or 
           Auto_Quest_Yama_2 or Auto_Quest_Yama_3 or Auto_Quest_Tushita_1 or 
           Auto_Quest_Tushita_2 or Auto_Quest_Tushita_3 or AutoEliteHunter or 
           AutoCakePrince or _G.AutoDoughKing or AutoDarkDagger or 
           AutoHallowSycthe or AutoCitizen or AutoEvoRace or AutoBartilo or 
           AutoFactory or _G.SwanGlasses or RipIndra or AutoRainbowHaki or 
           AutoTorch or AutoSoulGuitar or AutoTryLuck or AutoPray or 
           AutoAdvanceDungeon or AutoMusketeer or Auto_Serpent_Bow
end

local function noclip()
    local humanoidRootPart = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    if shouldEnableNoclip() then
        if not humanoidRootPart:FindFirstChild("BodyClip") then
            local Noclip = Instance.new("BodyVelocity")
            Noclip.Name = "BodyClip"
            Noclip.Parent = humanoidRootPart
            Noclip.MaxForce = Vector3.new(100000, 100000, 100000)
            Noclip.Velocity = Vector3.new(0, 0, 0)
        end
    else
        if humanoidRootPart:FindFirstChild("BodyClip") then
            humanoidRootPart:FindFirstChild("BodyClip"):Destroy()
        end
    end
end

spawn(function()
    while wait() do
        pcall(noclip)
    end
end)

-- Farming Clip Tween
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if shouldEnableNoclip() then
                for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)

spawn(function()
    while task.wait() do
        pcall(function()
            noclip()
        end)
    end
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if shouldEnableNoclip() then
                for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)
end)

spawn(function()
    while task.wait() do
        if _G.Auto_StartRaid or AutoNextIsland or AutoSTartRaids or _G.Auto_Next_Island or 
           AutoKillTial or _G.Farmfast or _G.AutoFarmAllBoss or _G.AutoPirateRaid or 
           AutoQuestRace or StardFarm or _G.TeleportKitsune or _G.Kill_Aura or 
           _G.Auto_Start_Law_Dungeon or _G.AutoHakiSpam or LevelFarmQuest or 
           LevelFarmQuestFruitMastery or LevelFarmQuestSwanGlasses or 
           LevelFarmQuestBossHallow or _G.AutoRaid or _G.BoneFarm or 
           _G.AutoRemover or _G.AutoSail or _G.TerShark or _G.Sharky or 
           _G.Piranas or _G.FishBoat or _G.BrigadeShip or _G.BrigadeShips or 
           _G.Beast then
            pcall(function()
                AutoHaki()
            end)
        end
    end
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Auto_StartRaid or AutoNextIsland or AutoSTartRaids or _G.Auto_Next_Island or 
               _G.Kill_Aura or _G.Farmfast or _G.AutoFarmAllBoss or _G.SailBoat or 
               _G.AutoPirateRaid or AutoKillTial or AutoQuestRace or StardFarm or 
               _G.TeleportKitsune or _G.Auto_Start_Law_Dungeon or _G.BoneFarm or 
               _G.AutoRemover or _G.AutoSail or _G.TerShark or _G.Sharky or 
               _G.Piranas or _G.FishBoat or _G.BrigadeShip or _G.BrigadeShips or 
               _G.Beast then
                if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
                    setfflag("CrashUploadToBacktracePercentage", "0")
                    setfflag("CrashUploadToBacktraceBlackholeToken", "")
                    setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")
                    GetHum():ChangeState(11)
                end
            end
        end)
    end)
end)

local Level_Farm = Tab_2:AddSection('','Main Farm','auto farm level,auto sea,farm near, etc..','rbxassetid://10734975692')
Level_Farm:AddToggle('Auto Farm Level', LevelFarmQuest, function(Value)
	LevelFarmQuest = Value;
	_G.SelectMonster = nil;
	CancelTween(LevelFarmQuest)
end)

Level_Farm:AddToggle('Auto Farm Level No Quest', LevelFarmNoQuest, function(Value)
	LevelFarmNoQuest = Value;
	_G.SelectMonster = nil;
	CancelTween(LevelFarmNoQuest)
end)
Level_Farm:AddToggle('Farm Near Monster', Nearest_Farm, function(Value)
	Nearest_Farm = Value;
	CancelTween(Nearest_Farm)
end)
if First_Sea then
	Level_Farm:AddToggle('Auto Second World [Lv. 700]', AutoSecondWorld, function(Value)
		AutoSecondWorld = Value;
		CancelTween(AutoSecondWorld)
	end)
elseif Second_Sea then
	Level_Farm:AddToggle('Auto Third World [Lv. 1500]', AutoThirdWorld, function(Value)
		AutoThirdWorld = Value;
		CancelTween(AutoThirdWorld)
	end)
end;

if Third_Sea then 
	Level_Farm:AddToggle('Auto Pirate Raid', _G.AutoPirateRaid, function(Value)
		_G.AutoPirateRaid = Value;
		CancelTween(_G.AutoPirateRaid)
	end)
end
 
spawn(function()
    while wait() do
        if _G.AutoPirateRaid then
            pcall(function()
                local CFrameBoss = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09,
                    0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)
                if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
                    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if _G.AutoPirateRaid and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
                                repeat
                                    wait()
                                    if (Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 100 then
                                        EquipTool(SelectWeaponFarm)
                                    end
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										piratename = v.Name;
										pirateframe = v.HumanoidRootPart.CFrame;
										AutoClick()
                                until v.Humanoid.Health <= 0 or not v.Parent or _G.AutoPirateRaid == false
                            end
                        end
                    end
                else
                    if ((CFrameBoss).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 1500 then
                        Tween(CFrameBoss)
                    else
                        BTP(CFrameBoss)
                    end
                end
            end)
        end
    end
end)


spawn(function()
    while task.wait() do
        if LevelFarmQuest then
            pcall(function()
                CheckLevel()
                if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    if ByPassTP then
                        BTP(CFrameQ)
                    elseif not ByPassTP then
                        Tween(CFrameQ)
                    end
                    if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end

                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                        Level_Farm_Name = v.Name
                                        Level_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        AutoClick()
                                    until not LevelFarmQuest or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    else
                        Tween(CFrameMon)
                    end
                end
            end)
        end
    end
end)

spawn(function()
    while task.wait() do
        if LevelFarmNoQuest then
            pcall(function()
                CheckLevel()
                if game.Workspace.Enemies:FindFirstChild(Ms) then
                    for i,v in pairs (game.Workspace.Enemies:GetChildren()) do
                        if v.Name == Ms then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    Level_Farm_Name = v.Name
                                    Level_Farm_CFrame = v.HumanoidRootPart.CFrame
                                    AutoClick()
                                until not LevelFarmNoQuest or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    if ByPassTP then
                        BTP(CFrameMon)
                    elseif not ByPassTP then
                        Tween(CFrameMon)
                    end
                end
            end)
        end
    end
end)

local candytab = Tab_2:AddSection('','Christmas Event','Auto collect gifts,auto buy','rbxassetid://79775211258613')


local EventTimes = candytab:AddLabel('')
spawn(function()
    while task.wait() do
        local times = game.Workspace.Countdown.SurfaceGui.TextLabel.Text
        EventTimes:Set('Event Countdown : '.. tostring(times))
    end
end)

candytab:AddToggle('Auto Claim Gift', AutoClaimGift, function()
    AutoClaimGift = Value
end)
spawn(function()
    while task.wait() do
        if AutoClaimGift then
            pcall(function()
                for i,v in pairs(game.Workspace._WorldOrigin:GetChildren()) do
                    if v.Name == 'Present' then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Root.CFrame
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
                        wait(.1)
                        game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
                    end
                end
            end)
        end
    end
end)
candytab:AddToggle('Auto Store Gift', AutoStoreGift, function()
    AutoStoreGift = Value
end)
spawn(function()
    while task.wait() do
        if AutoStoreGift then
            pcall(function()
                function EquipTool(Tool)
                    pcall(function()
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack[Tool])
                    end)
                end
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA('Tool') then
                        if string.find(v.Name, 'Gift') then
                            EquipTool(v.Name)
                        end
                    end
                end
                wait(.1)
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v:IsA('Tool') then
                        if string.find(v.Name, 'Gift') then
                            game.Players.LocalPlayer.Character:FindFirstChild(v.Name).ConsumeEvent:InvokeServer('Display')
                            wait(.1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreHolidayGift")
                        end
                    end
                end
            end)
        end
    end
end)



candytab:AddToggle('Auto Buy 2x Candies', false, function(Value)
    autoBuyX2 = Value
    if autoBuyX2 then
        spawn(function()
            while autoBuyX2 do
                local args = {
                    [1] = "Candies",
                    [2] = "Buy",
                    [3] = 1,
                    [4] = 1
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                task.wait(1) -- Adjust wait time to control the buying frequency
            end
        end)
    end
end)

candytab:AddToggle('Auto Buy 200 Fragments', false, function(Value)
    autoBuyFragments = Value
    if autoBuyFragments then
        spawn(function()
            while autoBuyFragments do
                local args = {
                    [1] = "Candies",
                    [2] = "Buy",
                    [3] = 2,
                    [4] = 1
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
                task.wait(1) -- Adjust wait time to control the buying frequency
            end
        end)
    end
end)

candytab:Button('Teleport to Events', function()
    Tween(CFrame.new(-1095.96472, 64.4006958, -14519.3809, 0.763202608, 7.23753928e-08, 0.646159291, -2.14145039e-08, 1, -8.671514e-08, -0.646159291, 5.23440384e-08, 0.763202608))
end)


candytab:AddLabel("Shops")

candytab:Button("Buy 2xp [50 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 1,
		[4] = 1
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
	
end)

candytab:Button("Buy Stat Reset [75 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 1,
		[4] = 2
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
	
end)


candytab:Button("Race Reroll [100 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 1,
		[4] = 3
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
	
end)


candytab:Button("200 Fragments [50 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 2,
		[4] = 1
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
	
end)


candytab:Button("500 Fragments [100 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 2,
		[4] = 2
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
end)

candytab:Button("Elf Hat [250 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 3,
		[4] = 1
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))	
end)

candytab:Button("Santa Hat [500 Candy]",function(value)
local args = {
    [1] = "Candies",
    [2] = "Buy",
    [3] = 3,
    [4] = 2
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))

end)

candytab:Button("Sleigh [1000 Candy]",function(value)
	local args = {
		[1] = "Candies",
		[2] = "Buy",
		[3] = 3,
		[4] = 3
	}
	
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
	
end)



local Other_Farm = Tab_2:AddSection('','Other Farm','Auto Bones,Ectoplasm','rbxassetid://10709781605')
if Third_Sea then
BoneCheck = Other_Farm:AddLabel("Your Bone: Third World ")
spawn(function()
	while task.wait() do
		pcall(function()
			BoneCheck:Set("Your Bone: " .. (RS.Remotes.CommF_:InvokeServer("Bones", "Check")))
		end)
	end
end)

Other_Farm:AddToggle("Buy Random Surprise (Bone)", Auto_Trade_Bone, function(Value)
	Auto_Trade_Bone = Value;
	while Auto_Trade_Bone do
		task.wait()
		local args = {
			[1] = "Bones",
			[2] = "Buy",
			[3] = 1,
			[4] = 1
		}
		RS.Remotes.CommF_:InvokeServer(unpack(args))
	end
end)
Other_Farm:AddToggle('Auto Farm Bones', Farm_Bone, function(Value)
	Farm_Bone = Value;
	CancelTween(Farm_Bone)
end)
end

spawn(function()
	while task.wait() do
		if Farm_Bone then
			pcall(function()
				local boneframe = CFrame.new(-9508.5673828125, 142.1398468017578, 5737.3603515625)
				if ByPassTP then
					BTP(boneframe)
				elseif not ByPassTP then
					Tween(boneframe)
				end;
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						if v.Name == "Reborn Skeleton" or v.Name == "Living Zombie" or v.Name == "Demonic Soul" or v.Name == "Posessed Mummy" then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.Transparency = 1;
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
								Bone_Farm_Name = v.Name;
								Bone_Farm_CFrame = v.HumanoidRootPart.CFrame;
								AutoClick()
							until not Farm_Bone or not v.Parent or v.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
						end
					end
				end;
				for i, v in pairs(RS:GetChildren()) do
					if v.Name == "Reborn Skeleton" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Living Zombie" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Demonic Soul" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Posessed Mummy" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					end
				end
			end)
		end
	end
end)

if Second_Sea then

	Ectoplasm12 = Other_Farm:AddLabel("Your Ectoplasm: ")
spawn(function()
	while task.wait() do
		pcall(function()
			Ectoplasm12:Set("Your Ectoplasm: " .. (RS.Remotes.CommF_:InvokeServer("Ectoplasm", "Check")))
		end)
	end
end)

Other_Farm:AddToggle('Auto Farm Ectoplasm', Farm_Ectoplasm, function(Value)
	Farm_Ectoplasm = Value;
	CancelTween(Farm_Ectoplasm)
end)

Other_Farm:Button('Auto Buy Midnight Blade [100 Ectoplasm]', function()
	local A_1 = "Ectoplasm"
	local A_2 = "Buy"
	local A_3 = 3
	local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
	Event:InvokeServer(A_1, A_2, A_3) 
end)

Other_Farm:Button('Auto Buy Ghoul Mask [50 Ectoplasm]', function()
	local A_1 = "Ectoplasm"
	local A_2 = "Buy"
	local A_3 = 2
	local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
	Event:InvokeServer(A_1, A_2, A_3) 
end)

Other_Farm:Button('Auto Buy Bizzare Rifle [100 Ectoplasm]', function()
	local A_1 = "Ectoplasm"
	local A_2 = "Buy"
	local A_3 = 1
	local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
	Event:InvokeServer(A_1, A_2, A_3) 
end)
end

spawn(function()
	while task.wait() do
		if Farm_Ectoplasm then
			pcall(function()
				local EctoMob = CFrame.new(904.4072265625, 181.05767822266, 33341.38671875)
				if ByPassTP then
					BTP(EctoMob)
				elseif not ByPassTP then
					Tween(EctoMob)
				end;
				local Distance = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - GetRoot().Position).Magnitude;
				if Distance > 20000 then
					RS.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end;
				for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						if v.Name == "Ship Steward" or v.Name == "Ship Engineer" or v.Name == "Ship Deckhand" or v.Name == "Ship Officer" then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.Transparency = 1;
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
								Ecto_Farm_Name = v.Name;
								Ecto_Farm_CFrame = v.HumanoidRootPart.CFrame;
								AutoClick()
							until not Farm_Ectoplasm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end;
				for i, v in pairs(RS:GetChildren()) do
					if v.Name == "Ship Steward" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Ship Engineer" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Ship Deckhand" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					elseif v.Name == "Ship Officer" then
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		if Nearest_Farm then
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						if v.Name then
							if (GetRoot().Position - v.HumanoidRootPart.Position).Magnitude <= 1000 then
								repeat
									task.wait()
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									Nearest_Farm_Name = v.Name;
									Nearest_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								until not Nearest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(v.Name)
							end
						end
					end
				end
			end)
		end
	end
end)

local SelectMonster_Farm = Tab_2:AddSection('','Mob Farm','auto farm select monster quest/no quest','rbxassetid://10747372992')
SelectMonster_Farm:AddDropdown("Select Monster", tableMon, "",function(Value)
	_G.SelectMonster = Value
end)
SelectMonster_Farm:AddToggle('Auto Farm Select (Quest)', SelectMonster_Quest_Farm, function(Value)
	SelectMonster_Quest_Farm = Value;
	CancelTween(SelectMonster_Quest_Farm)
end)
spawn(function()
	while task.wait() do
		if SelectMonster_Quest_Farm then
			pcall(function()
				CheckLevel(_G.SelectMonster)
				if not string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == false then
					RS.Remotes.CommF_:InvokeServer("AbandonQuest")
					if ByPassTP then
						BTP(CFrameQ)
					elseif not ByPassTP then
						Tween(CFrameQ)
					end;
					if (CFrameQ.Position - GetRoot().Position).Magnitude <= 5 then
						RS.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
					end
				elseif string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == Ms then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										SelectMonster_Farm_Name = v.Name;
										SelectMonster_Farm_CFrame = v.HumanoidRootPart.CFrame;
										AutoClick()
									until not SelectMonster_Quest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or Lplr.PlayerGui.Main.Quest.Visible == false
								end
							end
						end
					else
						Tween(CFrameMon)
					end
				end
			end)
		end
	end
end)
SelectMonster_Farm:AddToggle('Auto Farm Select (No Quest)', SelectMonster_NoQuest_Farm, function(Value)
	SelectMonster_NoQuest_Farm = Value;
	CancelTween(SelectMonster_NoQuest_Farm)
end)
spawn(function()
	while task.wait() do
		if SelectMonster_NoQuest_Farm then
			pcall(function()
				CheckLevel(_G.SelectMonster)
				if ByPassTP then
					BTP(CFrameQ)
				elseif not ByPassTP then
					Tween(CFrameQ)
				end;
				if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
					for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							if v.Name == Ms then
								repeat
									task.wait()
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									SelectMonster_Farm_Name = v.Name;
									SelectMonster_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								until not SelectMonster_NoQuest_Farm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
							end
						end
					end
				else
					Tween(CFrameMon)
				end
			end)
		end
	end
end)

local Material_Farm = Tab_2:AddSection('','Material Farm','auto farm any materials any sea','rbxassetid://10734907933')
if First_Sea then
	MaterialList = {
		"Scrap Metal",
		"Leather",
		"Angel Wings",
		"Magma Ore",
		"Fish Tail"
	}
elseif Second_Sea then
	MaterialList = {
		"Scrap Metal",
		"Leather",
		"Radioactive Material",
		"Mirage Droplet",
		"Magma Ore",
		"Vampire Fang"
	}
elseif Third_Sea then
	MaterialList = {
		"Scrap Metal",
		"Leather",
		"Demonic Wisp",
		"Conjured Cocoa",
		"Dragon Scale",
		"Gunpowder",
		"Fish Tail",
		"Mini Tusk"
	}
end;
Material_Farm:AddDropdown('Select Material', MaterialList, "",function(Value)
	SelectMaterial = Value
end)
Material_Farm:AddToggle('Auto Farm Material', Auto_Farm_Material, function(Value)
	Auto_Farm_Material = Value;
	CancelTween(Auto_Farm_Material)
end)
spawn(function()
	while task.wait() do
		if Auto_Farm_Material then
			pcall(function()
				MaterialMon(SelectMaterial)
				if ByPassTP then
					BTP(MPos)
				elseif not ByPassTP then
					Tween(MPos)
				end;
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						if v.Name == MMon then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.Transparency = 1;
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
								Material_Farm_Name = v.Name;
								Material_Farm_CFrame = v.HumanoidRootPart.CFrame;
								AutoClick()
							until not Auto_Farm_Material or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end
			end)
		end
	end
end)
local Mastery_Farm = Tab_2:AddSection('','Mastery Farm','auto mastery gun and fruit','rbxassetid://10734932295')
local KillPercent = 25

Mastery_Farm:Slider('Health To Kill', 0, 100, KillPercent, function(Value)
    KillPercent = Value
end)

local MasteryType = {
	'Quest',
	'No Quest',
	'Nearest'
}
SelectedMethodMastery = "Quest"
Mastery_Farm:AddDropdown('Select Method', MasteryType, "Quest",function(Value)
	SelectedMethodMastery = Value
end)
Mastery_Farm:AddToggle('Auto Farm Devil Mastery', DevilMastery_Farm, function(Value)
	DevilMastery_Farm = Value;
	CancelTween(DevilMastery_Farm)
end)


spawn(function()
	while task.wait() do
		if UseSkill then
			pcall(function()
				for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if v.Name == Mastery_Farm_Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
						repeat
							task.wait()
							EquipTool(Lplr.Data.DevilFruit.Value)
							PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position;
							if GetChar():FindFirstChild(Lplr.Data.DevilFruit.Value) then
								GetChar():FindFirstChild(Lplr.Data.DevilFruit.Value).MousePos.Value = PositionSkillMasteryDevilFruit;
								local DevilFruitMastery = GetChar():FindFirstChild(Lplr.Data.DevilFruit.Value).Level.Value;
								if _G.SkillZ and DevilFruitMastery >= 1 then
									VIM:SendKeyEvent(true, "Z", false, game)
									task.wait(.1)
									VIM:SendKeyEvent(false, "Z", false, game)
								end;
								if _G.SkillX and DevilFruitMastery >= 1 then
									VIM:SendKeyEvent(true, "X", false, game)
									task.wait(.1)
									VIM:SendKeyEvent(false, "X", false, game)
								end;
								if _G.SkillC and DevilFruitMastery >= 1 then
									VIM:SendKeyEvent(true, "C", false, game)
									task.wait(.1)
									VIM:SendKeyEvent(false, "C", false, game)
								end;
								if _G.SkillV and DevilFruitMastery >= 1 then
									VIM:SendKeyEvent(true, "V", false, game)
									task.wait(.1)
									VIM:SendKeyEvent(false, "V", false, game)
								end;
								if _G.SkillF and DevilFruitMastery >= 1 then
									VIM:SendKeyEvent(true, "F", false, game)
									task.wait(.1)
									VIM:SendKeyEvent(false, "F", false, game)
								end
							end
						until not DevilMastery_Farm or not UseSkill or v.Humanoid.Health == 0
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		if DevilMastery_Farm and SelectedMethodMastery == "Quest" then
			pcall(function()
				CheckLevel()
				if not string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == false then
					UseSkill = false;
					RS.Remotes.CommF_:InvokeServer("AbandonQuest")
					if ByPassTP then
						BTP(CFrameQ)
					elseif not ByPassTP then
						Tween(CFrameQ)
					end;
					if (CFrameQ.Position - GetRoot().Position).Magnitude <= 5 then
						RS.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
					end
				elseif string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
								if v.Name == Ms then
									repeat
										task.wait()
										if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
											UseSkill = true
										else
											UseSkill = false;
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											Mastery_Farm_Name = v.Name;
											Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										end
									until not DevilMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or Lplr.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
								end
							end
						end
					else
						Tween(CFrameMon)
					end
				end
			end)
		elseif DevilMastery_Farm and SelectedMethodMastery == "No Quest" then
			UseSkill = false;
			pcall(function()
				CheckLevel()
				if ByPassTP then
					BTP(CFrameQ)
				elseif not ByPassTP then
					Tween(CFrameQ)
				end;
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
						if v.Name == Ms then
							repeat
								task.wait()
								if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
									UseSkill = true
								else
									UseSkill = false;
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									Mastery_Farm_Name = v.Name;
									Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								end
							until not DevilMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end
			end)
		elseif DevilMastery_Farm and SelectedMethodMastery == "Nearest" then
			UseSkill = false;
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
						if (GetRoot().Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 2000 then
							repeat
								task.wait()
								if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
									UseSkill = true
								else
									UseSkill = false;
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									Mastery_Farm_Name = v.Name;
									Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								end
							until not DevilMastery_Farm or not SelectedMethodMastery == 'Nearest' or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end
			end)
		else
			UseSkill = false
		end
	end
end)
Mastery_Farm:AddToggle('Auto Farm Gun Mastery', GunMastery_Farm, function(Value)
	GunMastery_Farm = Value;
	CancelTween(GunMastery_Farm)
end)
spawn(function()
	pcall(function()
		while task.wait() do
			for i, v in pairs(Lplr.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v:FindFirstChild("RemoteFunctionShoot") then
						CurrentEquipGun = v.Name
					end
				end
			end
		end
	end)
end)
spawn(function()
	Run.RenderStepped:Connect(function()
		if UseGunMastery then
			pcall(function()
				CheckLevel()
				for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if v.Name == Ms then
						GetChar()[CurrentEquipGun].RemoteFunctionShoot:InvokeServer(v.HumanoidRootPart.Position, v.HumanoidRootPart)
						GetChar()[CurrentEquipGun].Cooldown.Value = 0
					end;
					if v.Name == _G.SelectMonster then
						GetChar()[CurrentEquipGun].RemoteFunctionShoot:InvokeServer(v.HumanoidRootPart.Position, v.HumanoidRootPart)
						GetChar()[CurrentEquipGun].Cooldown.Value = 0
					end
				end
			end)
		end
	end)
end)
spawn(function()
	while task.wait() do
		if GunMastery_Farm and SelectedMethodMastery == "Quest" then
			pcall(function()
				CheckLevel()
				if not string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == false then
					UseGunMastery = false;
					RS.Remotes.CommF_:InvokeServer("AbandonQuest")
					if ByPassTP then
						BTP(CFrameQ)
					elseif not ByPassTP then
						Tween(CFrameQ)
					end;
					if (CFrameQ.Position - GetRoot().Position).Magnitude <= 5 then
						RS.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
					end
				elseif string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or Lplr.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
								if v.Name == Ms then
									repeat
										task.wait()
										if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
											EquipTool(CurrentEquipGun)
											GetChar()[CurrentEquipGun].Cooldown.Value = 0;
											UseGunMastery = true;
											AutoClick()
										else
											UseGunMastery = false;
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											Mastery_Farm_Name = v.Name;
											Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										end
									until not GunMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or Lplr.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
								end
							end
						end
					else
						Tween(CFrameMon)
					end
				end
			end)
		elseif GunMastery_Farm and SelectedMethodMastery == "No Quest" then
			UseGunMastery = false;
			pcall(function()
				CheckLevel()
				if ByPassTP then
					BTP(CFrameQ)
				elseif not ByPassTP then
					Tween(CFrameQ)
				end;
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
						if v.Name == Ms then
							repeat
								task.wait()
								if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
									EquipTool(CurrentEquipGun)
									GetChar()[CurrentEquipGun].Cooldown.Value = 0;
									UseGunMastery = true;
									AutoClick()
								else
									UseGunMastery = false;
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									Mastery_Farm_Name = v.Name;
									Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								end
							until not GunMastery_Farm or not SelectedMethodMastery == "Quest" or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end
			end)
		elseif GunMastery_Farm and SelectedMethodMastery == "Nearest" then
			UseGunMastery = false;
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
						if (GetRoot().Position - v:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 2000 then
							repeat
								task.wait()
								if v.Humanoid.Health <= v.Humanoid.MaxHealth * KillPercent / 100 then
									EquipTool(CurrentEquipGun)
									GetChar()[CurrentEquipGun].Cooldown.Value = 0;
									UseGunMastery = true;
									AutoClick()
								else
									UseGunMastery = false;
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									Mastery_Farm_Name = v.Name;
									Mastery_Farm_CFrame = v.HumanoidRootPart.CFrame;
									AutoClick()
								end
							until not GunMastery_Farm or not SelectedMethodMastery == 'Nearest' or not v.Parent or v.Humanoid.Health == 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
						end
					end
				end
			end)
		else
			UseGunMastery = false
		end
	end
end)
local Boss_Farm = Tab_2:AddSection('','Bosses','auto farms boss in any sea','rbxassetid://10734962068')
local BossNameStorage = {
    "The Gorrila King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral",
    "Saber Expert", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord",
    "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard", "Diamond",
    "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Awakened Ice Admiral",
    "Tide Keeper", "Darkbeard", "Cursed Captain", "Order", "Stone", "Island Empress",
    "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen", "Longma",
    "Soul Reaper", "rip_indra True Form"
}

local BossList = {}
for _, v in pairs(RS:GetChildren()) do
    if table.find(BossNameStorage, v.Name) then
        table.insert(BossList, v.Name)
    end
end

local Refresh_Boss = Boss_Farm:AddDropdown('Select Boss', BossList, "", function(Value)
    SelectBoss = Value
end)

Boss_Farm:Button('Refresh Boss', function()
    local NewBossList = {}
    for _, v in pairs(RS:GetChildren()) do
        if table.find(BossNameStorage, v.Name) then
            table.insert(NewBossList, v.Name)
        end
    end
    
    -- Clear existing items before adding new ones
    Refresh_Boss:Clear()
    
    -- Add each boss in the new list to the dropdown
    for _, boss in ipairs(NewBossList) do
        Refresh_Boss:Add(boss)
    end
end)

Boss_Farm:AddToggle('Auto Farm Boss (Quest)', AutoFarmBossQuest, function(Value)
    AutoFarmBossQuest = Value
    CancelTween(AutoFarmBossQuest)
end)

spawn(function()
    while task.wait() do
        if AutoFarmBossQuest then
            pcall(function()
                CheckBossQuest(SelectBoss)
                
                if not string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) or not Lplr.PlayerGui.Main.Quest.Visible then
                    RS.Remotes.CommF_:InvokeServer("AbandonQuest")
                    if ByPassTP then
                        BTP(CFrameQBoss)
                    else
                        Tween(CFrameQBoss)
                    end
                    
                    if (CFrameQBoss.Position - GetRoot().Position).Magnitude <= 5 then
                        RS.Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, QuestLvBoss)
                    end
                elseif string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) or Lplr.PlayerGui.Main.Quest.Visible then
                    if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
                        local enemy = game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss)
                        if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                EquipTool(SelectWeaponFarm)
                                Tween(enemy.HumanoidRootPart.CFrame * Farm_Mode)
                                enemy.HumanoidRootPart.CanCollide = false
                                enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                enemy.HumanoidRootPart.Transparency = 1
                                enemy.Humanoid:ChangeState(11)
                                enemy.Humanoid:ChangeState(14)
                                AutoClick()
                            until not AutoFarmBossQuest or not enemy.Parent or enemy.Humanoid.Health <= 0
                        end
                    else
                        Tween(CFrameBoss)
                    end
                end
            end)
        end
    end
end)

Boss_Farm:AddToggle('Auto Farm Boss (No Quest)', AutoFarmBossNoQuest, function(Value)
    AutoFarmBossNoQuest = Value
    CancelTween(AutoFarmBossNoQuest)
end)

spawn(function()
    while task.wait() do
        if AutoFarmBossNoQuest then
            pcall(function()
                CheckBossQuest(SelectBoss)
                if ByPassTP then
                    BTP(CFrameBoss)
                else
                    Tween(CFrameBoss)
                end
                
                local enemy = game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss)
                if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    repeat
                        task.wait()
                        EquipTool(SelectWeaponFarm)
                        Tween(enemy.HumanoidRootPart.CFrame * Farm_Mode)
                        enemy.HumanoidRootPart.CanCollide = false
                        enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        enemy.HumanoidRootPart.Transparency = 1
                        enemy.Humanoid:ChangeState(11)
                        enemy.Humanoid:ChangeState(14)
                        AutoClick()
                    until not AutoFarmBossNoQuest or not enemy.Parent or enemy.Humanoid.Health <= 0
                end
            end)
        end
    end
end)

local BossNameStorage = {
    "The Gorrila King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral",
    "Saber Expert", "Warden", "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord",
    "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard", "Diamond",
    "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Awakened Ice Admiral",
    "Tide Keeper", "Darkbeard", "Cursed Captain", "Order", "Stone", "Island Empress",
    "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen", "Longma",
    "Soul Reaper", "rip_indra True Form"
}

_G.AutoFarmAllBoss = false

Boss_Farm:AddToggle("Auto Farm All Boss", false, function(value)
    _G.AutoFarmAllBoss = value
end)

spawn(function()
    while task.wait(1) do
        if _G.AutoFarmAllBoss then
            for _, bossName in ipairs(BossNameStorage) do
                local enemy = game:GetService("Workspace").Enemies:FindFirstChild(bossName)
                if enemy then
                   
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        
                        repeat
                            task.wait()
                            EquipTool(SelectWeaponFarm)
							enemy.HumanoidRootPart.CanCollide = false
                            enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            enemy.HumanoidRootPart.Transparency = 1
                            enemy.Humanoid:ChangeState(11)
                            enemy.Humanoid:ChangeState(14)
                            Tween(enemy.HumanoidRootPart.CFrame * Farm_Mode)
                            AutoClick()
                        until enemy.Humanoid.Health <= 0 or not _G.AutoFarmAllBoss
                    else
                        
                    end
                else
                    
                    local bossCFrame = RS:FindFirstChild(bossName) and RS[bossName].HumanoidRootPart.CFrame
                    if bossCFrame then
                        Tween(bossCFrame * CFrame.new(5, 10, 2))
                    end
                end
            end
        end
    end
end)



local Chest_Farm = Tab_2:AddSection('','Chest Farm','auto teleport to chest [no kick]','rbxassetid://10709782582')

function AutoGrabChest()
    local player = game.Players.LocalPlayer.Character
    for i,v in pairs(game:GetService("Workspace").ChestModels:GetChildren()) do 
        if v.Name == "SilverChest" or v.Name == "GoldChest" or v.Name == "DiamondChest" or v.Name == "FragmentChest" or v.Name == "MirageChest" then
            player.HumanoidRootPart.CFrame = v.PushBox.CFrame
            wait(.15)
        end
    end
    for i,v in pairs(game.Workspace.ChestModels:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            wait(.15)
            firetouchinterest(player.HumanoidRootPart, v.Parent, 0) -- 0 is touch
            wait(.15)
            firetouchinterest(player.HumanoidRootPart, v.Parent, 1) -- 1 is not touch
        end
    end
end

function CooldownDeath(times)
    wait(times)
    game.Players.LocalPlayer.Character.Head:Destroy()
    wait(times)
end

Chest_Farm:AddToggle('Auto Grab Chest (Stop if have items)', _G.GrabChested, function(Value)
    _G.GrabChested = Value
end)
spawn(function()
    while task.wait() do
        if _G.GrabChested then
            pcall(function()
                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("God's Chalice") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") then
                    pcall(function()
                        AutoGrabChest()
                    end)
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G.GrabChested then
            pcall(function()
                CooldownDeath(10)
            end)
        end
    end
end)

Chest_Farm:AddToggle('Auto Grab Chest + Hop (Stop if have items)', _G.GrabChestedHop, function(Value)
    _G.GrabChestedHop = Value
end)
spawn(function()
    while wait() do
        if _G.GrabChestedHop then
            pcall(function()
                if game.Workspace:FindFirstChild("SilverChest") or game.Workspace:FindFirstChild("DiamondChest") or game.Workspace:FindFirstChild("GoldChest") or game.Workspace:FindFirstChild("FragmentChest") or game.Workspace:FindFirstChild("MirageChest") then
                    if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("God's Chalice") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") then
                        pcall(function()
                            AutoGrabChest()
                        end)
                    end
                else
                    pcall(function()
                        Hop()
                    end)
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G.GrabChestedHop then
            pcall(function()
                CooldownDeath(10)
            end)
        end
    end
end)

local Observation_Farm = Tab_2:AddSection('','Observation Farm','auto increase observation','rbxassetid://10734974689')
local ObservationRange = Observation_Farm:AddLabel("")
    spawn(function()
        while wait() do
            pcall(function()
                ObservationRange:Set("Observation Range : "..math.floor(game:GetService("Players").LocalPlayer.VisionRadius.Value))
            end)
        end
    end)
Observation_Farm:AddToggle("Auto Farm Observation", AutoFarmKen, function(Value)
	AutoFarmKen = Value;
	CancelTween(AutoFarmKen)
end)
spawn(function()
	while task.wait() do
		if AutoFarmKen then
			pcall(function()
				if Lplr.VisionRadius.Value >= 3000 then
					Notify("Observation", "Your points observation is max.", 3)
				else
					if Second_Sea then
						if game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate [Lv. 1200]") then
							if Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
								until AutoFarmKen == false or not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0) + task.wait(1)
									if not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
										TS:Teleport(game.PlaceId, Lplr)
									end
								until AutoFarmKen == false or Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							Tween(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
						end
					elseif First_Sea then
						if game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
							if Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
								until AutoFarmKen == false or not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
									task.wait(1)
									if not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
										TS:Teleport(game.PlaceId, Lplr)
									end
								until AutoFarmKen == false or Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							Tween(CFrame.new(5533.29785, 88.1079102, 4852.3916))
						end
					elseif Third_Sea then
						if game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander [Lv. 1650]") then
							if Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
								until AutoFarmKen == false or not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat
									task.wait()
									GetRoot().CFrame = game:GetService("Workspace").Enemies:FindFirstChild("Giant Islander").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
									task.wait(1)
									if not Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
										TS:Teleport(game.PlaceId, Lplr)
									end
								until AutoFarmKen == false or Lplr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							Tween(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
						end
					end
				end
			end)
		end
	end
end)
Observation_Farm:AddToggle("Auto Observation V2", AutoKenV2, function(Value)
	AutoKenV2 = Value;
	CancelTween(AutoKenV2)
end)
spawn(function()
	while task.wait() do
		if AutoKenV2 then
			pcall(function()
				if RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 then
					if Lplr.Backpack:FindFirstChild("Banana") and Lplr.Backpack:FindFirstChild("Apple") and Lplr.Backpack:FindFirstChild("Pineapple") then
						repeat
							task.wait()
							Tween(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625))
						until not AutoKenV2 or (GetRoot().Position - Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10;
						task.wait(.5)
						RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
					elseif Lplr.Backpack:FindFirstChild("Fruit Bowl") or GetChar():FindFirstChild("Fruit Bowl") then
						repeat
							task.wait()
							Tween(CFrame.new(-10920.125, 624.20275878906, -10266.995117188))
						until not AutoKenV2 or (GetRoot().Position - Vector3.new(-10920.125, 624.20275878906, -10266.995117188)).Magnitude <= 10;
						task.wait(.5)
						RS.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
						task.wait(1)
						RS.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
					else
						for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
							if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Pineapple" then
								v.Handle.CFrame = GetRoot().CFrame * CFrame.new(0, 1, 10)
								task.wait()
								firetouchinterest(GetRoot(), v.Handle, 0)
								task.wait()
							end
						end
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		if AutoSecondWorld then
			pcall(function()
				if Lplr.Data.Level.Value >= 700 then
					if RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").UsedKey == false then
						if not Lplr.Backpack:FindFirstChild("Key") or not GetChar():FindFirstChild("Key") then
							RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
						elseif Lplr.Backpack:FindFirstChild("Key") or GetChar():FindFirstChild("Key") then
							GetHum():EquipTool(Lplr.Backpack["Key"])
							if ByPassTP then
								BTP(CFrame.new(1349.697265625, 37.34928512573242, -1328.8309326171875))
								game:GetService("Workspace").Map.Ice.Door.Size = Vector3.new(30, 30, 30)
							elseif not ByPassTP then
								Tween(CFrame.new(1349.697265625, 37.34928512573242, -1328.8309326171875))
								game:GetService("Workspace").Map.Ice.Door.Size = Vector3.new(30, 30, 30)
							end
						end
					elseif RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").UsedKey == true then
						if RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").KilledIceBoss == false then
							for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v.Name == "Ice Admiral" then
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									AutoClick()
								end
							end;
							for i, v in pairs(RS:GetChildren()) do
								if v.Name == "Ice Admiral" then
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								end
							end
						elseif RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress").KilledIceBoss == true then
							RS.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		if AutoThirdWorld then
			pcall(function()
				if Lplr.Data.Level.Value >= 1500 then
					if RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
						if RS.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
							if RS.Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == nil then
								if game.Workspace.Enemies:FindFirstChild("rip_indra") then
									for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
										if v.Name == "rip_indra" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
										end
									end
								else
									Tween(CFrame.new(-26952.2891, 21.5294781, 329.351562, -0.453972578, 0, -0.891015649, 0, 1, 0, 0.891015649, 0, -0.453972578))
								end
							elseif RS.Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
								if game.Workspace.Enemies:FindFirstChild("Don Swan") then
									for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
										if v.Name == "Don Swan" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
										end
									end
								else
									if ByPassTP then
										BTP(CFrame.new(2288.802, 15.1870775, 863.034607))
									else
										Tween(CFrame.new(2288.802, 15.1870775, 863.034607))
									end
								end
							end;
							TabelDevilFruitStore = {}
							TabelDevilFruitOpen = {}
							for i, v in pairs(RS.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
								for i1, v1 in pairs(v) do
									if i1 == "Name" then
										table.insert(TabelDevilFruitStore, v1)
									end
								end
							end;
							for i, v in next, RS:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
								if v.Price >= 1000000 then
									table.insert(TabelDevilFruitOpen, v.Name)
								end
							end;
							for i, DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
								for i1, DevilFruitStore in pairs(TabelDevilFruitStore) do
									if DevilFruitOpenDoor == DevilFruitStore and RS.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
										if not Lplr.Backpack:FindFirstChild(DevilFruitStore) then
											RS.Remotes.CommF_:InvokeServer("LoadFruit", DevilFruitStore)
										else
											RS.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
											RS.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
											RS.Remotes.CommF_:InvokeServer("TalkTrevor", "3")
										end
									end
								end
							end;
							RS.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
							RS.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
							RS.Remotes.CommF_:InvokeServer("TalkTrevor", "3")
						elseif RS.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == true then
							RS.Remotes.CommF_:InvokeServer("TravelZou")
						end
					elseif RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
						if string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and Lplr.PlayerGui.Main.Quest.Visible == true then
							if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Swan Pirate" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											AutoClick()
										until not v.Parent or v.Humanoid.Health <= 0 or Lplr.PlayerGui.Main.Quest.Visible == false or not AutoThirdWorld
									end
								end
							else
								if ByPassTP then
									BTP(CFrame.new(1057.92761, 137.614319, 1242.08069))
								else
									Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
								end
							end
						else
							RS.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
						end
					elseif RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
						RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
						if game.Workspace.Enemies:FindFirstChild("Jeremy") then
							for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									if v.Name == "Jeremy" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											AutoClick()
										until not v.Parent or v.Humanoid.Health <= 0 or not AutoThirdWorld
									end
								end
							end
						else
							if ByPassTP then
								BTP(CFrame.new(2099.88159, 448.931, 648.997375))
							else
								Tween(CFrame.new(2099.88159, 448.931, 648.997375))
							end
						end
					elseif RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
						if (GetRoot().Position - CFrameThird.Position).Magnitude > 1500 then
							if ByPassTP then
								BTP(CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375))
							else
								Tween(CFrame.new(-1836.1412353515625, 10.458294868469238, 1692.491943359375))
							end
						else
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
							task.wait(1)
							GetRoot().CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
						end
					end
				end
			end)
		end
	end
end)

if First_Sea then
	_G.sesas = "First Sea"
elseif Second_Sea then
	_G.sesas = "Second Sea"
elseif Third_Sea then
	_G.sesas = "Third Sea"
end
local Sword_Wuest = Tab_3:AddSection('',_G.sesas..' Farms','auto quest swords, items, boss, etc..','rbxassetid://6034744057')

if First_Sea then
	Sword_Wuest:AddToggle("Auto Trident Sword",false,function(v)
		_G.Auto_Trident = v
		CancelTween(_G.Auto_Trident)
			print(v)
end)

Sword_Wuest:AddToggle("Auto Shark Saw",false,function(v)
	_G.Autosaw = v
	CancelTween(_G.Autosaw)
		print(v)
end)

Sword_Wuest:AddToggle("Auto Warden Sword",false,function(v)
	_G.Autowaden = v
	CancelTween(_G.Autowaden)
		print(v)
end) 

Sword_Wuest:AddToggle("Auto Graybeard",false, function(v)
	_G.Autogay = v
	CancelTween(_G.Autogay)
		print(v)
end)

Sword_Wuest:AddToggle('Auto Saber [Fully]', AutoSaber, function(Value)
	AutoSaber = Value;
	CancelTween(AutoSaber)
end)
end

spawn(function()
	while task.wait() do
		if AutoSaber and Lplr.Data.Level.Value >= 200 and not Lplr.Backpack:FindFirstChild("Saber") and not GetChar():FindFirstChild("Saber") then
			pcall(function()
				if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then
					if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0 then
						if (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - GetRoot().Position).Magnitude <= 100 then
							Tween(GetRoot().CFrame)
							task.wait(1)
							GetRoot().CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame;
							task.wait(1)
							GetRoot().CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame;
							task.wait(1)
							GetRoot().CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame;
							task.wait(1)
							GetRoot().CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame;
							task.wait(1)
							GetRoot().CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame;
							task.wait(1)
						else
							Tween(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
						end
					else
						if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0 then
							if Lplr.Backpack:FindFirstChild("Torch") or GetChar():FindFirstChild("Torch") then
								EquipTool("Torch")
								Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
							else
								Tween(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
							end
						else
							if RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
								RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
								task.wait(0.5)
								EquipTool("Cup")
								task.wait(0.5)
								RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", GetChar().Cup)
								task.wait(0)
								RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
							else
								if RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
									RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
								elseif RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
									if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") then
										for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												if v.Name == "Mob Leader" then
													repeat
														task.wait()
														EquipTool(SelectWeaponFarm)
														Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
														v.HumanoidRootPart.CanCollide = false;
														v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
														v.HumanoidRootPart.Transparency = 1;
														v.Humanoid:ChangeState(11)
														v.Humanoid:ChangeState(14)
														AutoClick()
													until v.Humanoid.Health <= 0 or AutoSaber == false or not v.Parent
												end
											end
										end
									else
										Tween(RS:FindFirstChild("Mob Leader").HumanoidRootPart.CFrame)
									end
								elseif RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
									RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
									task.wait(0.5)
									EquipTool("Relic")
									task.wait(0.5)
									Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
								end
							end
						end
					end
				else
					if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Saber Expert" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until v.Humanoid.Health <= 0 or AutoSaber == false;
									if v.Humanoid.Health <= 0 then
										RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
									end
								end
							end
						end
					else
						Tween(RS:FindFirstChild("Saber Expert").HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)


	local TridentPos1 = CFrame.new(3993.227783203125, -1.3182750940322876, -1835.6097412109375)
		spawn(function()
			while wait() do
				if  _G.Auto_Trident  then
					pcall(function()
						if game:GetService("Workspace").Enemies:FindFirstChild("Fishman Lord") then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == "Fishman Lord" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat task.wait()
											AutoHaki()
											EquipTool(SelectWeaponFarm)
											v.HumanoidRootPart.CanCollide = false
											v.Humanoid.WalkSpeed = 0
											v.HumanoidRootPart.Size = Vector3.new(50,50,50)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											AutoClick()
											-- sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
										until not  _G.Auto_Trident or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							end
						else
						if BypassTP then
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TridentPos1.Position).Magnitude > 1500 then
						BTP(TridentPos1)
						elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TridentPos1.Position).Magnitude < 1500 then
						Tween(TridentPos1)
						end
					else
						Tween(TridentPos1)
					end
						---UnEquipWeapon(SelectWeaponFarm)
						Tween(CFrame.new(-3914.830322265625, 123.29389190673828, -11516.8642578125))
							if game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Lord") then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Fishman Lord").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
						   
							end
						end
					end)
				end
			end
		end)
		
		
		local NamfonPos = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562)
		spawn(function()
			while wait() do
				if  _G.Autowaden and First_Sea then
					pcall(function()
						if game:GetService("Workspace").Enemies:FindFirstChild("Chief Warden") then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == "Chief Warden" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat task.wait()
											AutoHaki()
											EquipTool(SelectWeaponFarm)
											v.HumanoidRootPart.CanCollide = false
											v.Humanoid.WalkSpeed = 0
											v.HumanoidRootPart.Size = Vector3.new(50,50,50)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											AutoClick()
											-- sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
										until not  _G.Autowaden or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							end
						else
						if BypassTP then
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TridentPos.Position).Magnitude > 1500 then
						BTP(TridentPos)
						elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - TridentPos.Position).Magnitude < 1500 then
						Tween(TridentPos)
						end
					else
						Tween(TridentPos)
					end
						---UnEquipWeapon(SelectWeaponFarm)
						Tween(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562))
							if game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden") then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
						   
							end
						end
					end)
				end
			end
		end)
		
		
		local GayMakPos = CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375)
		spawn(function()
			while wait() do
				if  _G.Autogay and First_Sea then
					pcall(function()
						if game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == "Greybeard" then
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat task.wait()
											AutoHaki()
											EquipTool(SelectWeaponFarm)
											v.HumanoidRootPart.CanCollide = false
											v.Humanoid.WalkSpeed = 0
											v.HumanoidRootPart.Size = Vector3.new(50,50,50)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											AutoClick()
											-- sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
										until not  _G.Autogay or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							end
						else
						if BypassTP then
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - GayMakPos.Position).Magnitude > 1500 then
						BTP(GayMakPos)
						elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - GayMakPos.Position).Magnitude < 1500 then
						Tween(GayMakPos)
						end
					else
						Tween(GayMakPos)
					end
						---UnEquipWeapon(SelectWeaponFarm)
						Tween(CFrame.new(-5023.38330078125, 28.65203285217285, 4332.3818359375))
							if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") then
								Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
						   
							end
						end
					end)
				end
			end
		end)

		   
			
			 
		local PolePos = CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625)
			spawn(function()
				while wait() do
					if  _G.Autopole and First_Sea then
						pcall(function()
							if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Thunder God" then
										if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat task.wait()
												AutoHaki()
												EquipTool(SelectWeaponFarm)
												v.HumanoidRootPart.CanCollide = false
												v.Humanoid.WalkSpeed = 0
												v.HumanoidRootPart.Size = Vector3.new(50,50,50)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												AutoClick()
												-- sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
											until not  _G.Autopole or not v.Parent or v.Humanoid.Health <= 0
										end
									end
								end
							else
							if BypassTP then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - PolePos.Position).Magnitude > 1500 then
							BTP(PolePos)
							elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - PolePos.Position).Magnitude < 1500 then
							Tween(PolePos)
							end
						else
							Tween(TridentPos)
						end
							---UnEquipWeapon(SelectWeaponFarm)
							Tween(CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625))
								if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
									Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(2,20,2))
								end
							end
						end)
					end
				end
			end)



if Second_Sea then
	
	Sword_Wuest:AddToggle('Auto Buy Legendary Sword', AutoLegendarySword, function(Value)
		AutoLegendarySword = Value
	end)
	spawn(function()
		while task.wait() do
			if AutoLegendarySword then
				pcall(function()
					RS.Remotes.CommF_:InvokeServer("LegendarySworldDealer", "1")
					RS.Remotes.CommF_:InvokeServer("LegendarySworldDealer", "2")
					RS.Remotes.CommF_:InvokeServer("LegendarySworldDealer", "2")
				end)
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Rengoku', AutoRengoku, function(Value)
		AutoRengoku = Value;
		CancelTween(AutoRengoku)
	end)
	spawn(function()
		while task.wait() do
			if AutoRengoku then
				pcall(function()
					if Lplr.Backpack:FindFirstChild("Hidden Key") or GetChar():FindFirstChild("Hidden Key") then
						EquipTool("Hidden Key")
						loc1 = CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875)
						if ByPassTP then
							BTP(loc1)
						else
							Tween(loc1)
						end
					elseif game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Snow Lurker" or v.Name == "Arctic Warrior" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										Rengoku_Farm_Name = v.Name;
										Rengoku_Farm_CFrame = v.HumanoidRootPart.CFrame;
										AutoClick()
									until Lplr.Backpack:FindFirstChild("Hidden Key") or AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						end
					else
						Tween(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
					end
				end)
			else
				RengokuMagnet = false
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Evo Race V2', AutoEvoRace, function(Value)
		AutoEvoRace = Value;
		CancelTween(AutoEvoRace)
	end)
	spawn(function()
		while task.wait() do
			if AutoEvoRace then
				pcall(function()
					if not Lplr.Data.Race:FindFirstChild("Evolved") then
						if RS.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							Tween(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 6.39014104e-08, -0.68292886, 3.59963224e-08, 1, 5.50667032e-08, 0.68292886, 1.56424669e-08, -0.730484903))
							if (Vector3.new(-2779.83521, 72.9661407, -3574.02002) - GetRoot().Position).Magnitude <= 4 then
								task.wait(1.1)
								RS.Remotes.CommF_:InvokeServer("Alchemist", "2")
							end
						elseif RS.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							if not Lplr.Backpack:FindFirstChild("Flower 1") and not GetChar():FindFirstChild("Flower 1") then
								Tween(game.Workspace.Flower1.CFrame)
							elseif not Lplr.Backpack:FindFirstChild("Flower 2") and not GetChar():FindFirstChild("Flower 2") then
								Tween(game.Workspace.Flower2.CFrame)
							elseif not Lplr.Backpack:FindFirstChild("Flower 3") and not GetChar():FindFirstChild("Flower 3") then
								if game:GetService("Workspace").Enemies:FindFirstChild("Zombie") then
									for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if v.Name == "Zombie" then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												EvoV2_Farm_Name = v.Name;
												EvoV2_Farm_CFrame = v.HumanoidRootPart.CFrame;
												AutoClick()
											until Lplr.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
										end
									end
								else
									if ByPassTP then
										BTP(CFrame.new(-5854.39014, 145.093857, -686.942017, 0.379233211, -1.41975844e-08, -0.925301135, -3.77265719e-10, 1, -1.5498367e-08, 0.925301135, 6.2265797e-09, 0.379233211))
									else
										Tween(CFrame.new(-5854.39014, 145.093857, -686.942017, 0.379233211, -1.41975844e-08, -0.925301135, -3.77265719e-10, 1, -1.5498367e-08, 0.925301135, 6.2265797e-09, 0.379233211))
									end
								end
							end
						elseif RS.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							RS.Remotes.CommF_:InvokeServer("Alchemist", "3")
						end
					end
				end)
			end
		end
	end)
	Sword_Wuest:AddToggle('Auto Bartilo', AutoBartilo, function(Value)
		AutoBartilo = Value;
		CancelTween(AutoBartilo)
		if Lplr.Backpack:FindFirstChild("Warrior Helmet") then
			Success = true
		elseif GetChar():FindFirstChild("Warrior Helmet") then
			Success = true
		end
	end)
	spawn(function()
		while task.wait() do
			if AutoBartilo then
				pcall(function()
					if Lplr.Data.Level.Value >= 850 and RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
						if string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and Lplr.PlayerGui.Main.Quest.Visible == true then
							if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Swan Pirate" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											Bartilo_Farm_Name = v.Name;
											Bartilo_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false or Lplr.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							else
								if ByPassTP then
									BTP(CFrame.new(1057.92761, 137.614319, 1242.08069))
								else
									Tween(CFrame.new(1057.92761, 137.614319, 1242.08069))
								end
							end
						else
							Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
							if (Vector3.new(-456.28952, 73.0200958, 299.895966) - GetRoot().Position).Magnitude <= 30 then
								task.wait(1.1)
								RS.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
							end
						end
					elseif Lplr.Data.Level.Value >= 850 and RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
						if QuestBartilo == nil then
							Tween(CFrame.new(-456.28952, 73.0200958, 299.895966))
						end;
						if (Vector3.new(-456.28952, 73.0200958, 299.895966) - GetRoot().Position).Magnitude <= 30 then
							task.wait(1.1)
							RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
							QuestBartilo = 1
						end;
						if game.Workspace.Enemies:FindFirstChild("Jeremy") then
							for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v.Name == "Jeremy" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not v.Parent or v.Humanoid.Health <= 0 or AutoBartilo == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
								end
							end
						else
							Tween(CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172))
							if QuestBartilo == 1 then
								Tween(CFrame.new(1931.5931396484, 402.67391967773, 956.52215576172))
							end
						end
					elseif Lplr.Data.Level.Value >= 850 and RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
						Tween(game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.CFrame)
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.CFrame;
						task.wait(1)
						GetRoot().CFrame = game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.CFrame;
						task.wait(1)
					end
				end)
			end
		end
	end)
	Sword_Wuest:AddToggle('Auto Factory', AutoFactory, function(Value)
		AutoFactory = Value;
		CancelTween(AutoFactory)
	end)
	spawn(function()
		while task.wait() do
			if AutoFactory then
				if game.Workspace.Enemies:FindFirstChild("Core") then
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v.Name == "Core" and v.Humanoid.Health > 0 then
							repeat
								task.wait()
								Tween(CFrame.new(448.46756, 199.356781, -441.389252))
								EquipTool(SelectWeaponFarm)
								AutoClick()
							until not v.Parent or v.Humanoid.Health <= 0 or AutoFactory == false
						end
					end
				elseif RS:FindFirstChild("Core") then
					repeat
						Tween(CFrame.new(448.46756, 199.356781, -441.389252))
						task.wait()
					until not AutoFactory or (GetRoot().Position - Vector3.new(448.46756, 199.356781, -441.389252)).Magnitude <= 10
				end
			end
		end
	end)
	Sword_Wuest:AddToggle('Auto Don Swan', _G.SwanGlasses, function(Value)
		_G.SwanGlasses = Value;
		CancelTween(_G.SwanGlasses)
	end)
	spawn(function()
		while task.wait() do
			if _G.SwanGlasses then
				if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan") then
					for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v.Name == "Don Swan" and v.Humanoid.Health > 0 and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.Transparency = 1;
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
								AutoClick()
							until _G.SwanGlasses == false or v.Humanoid.Health <= 0 or not v.Parent
						end
					end
				else
					if ByPassTP then
						BTP(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
					else
						Tween(CFrame.new(2191.1674804688, 15.177842140198, 694.69873046875))
					end
				end
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Buy Haki Color', AutoColorHaki, function(Value)
		AutoColorHaki = Value
	end)
	spawn(function()
		while task.wait() do
			if AutoColorHaki then
				pcall(function()
					RS.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
				end)
			end
		end
	end)
end

if Third_Sea then
	Sword_Wuest:AddToggle('Auto Citizen', AutoCitizen, function(Value)
		AutoCitizen = Value;
		CancelTween(AutoCitizen)
		if Lplr.Backpack:FindFirstChild("Musketeer Hat") then
			CTCH = true
		elseif GetChar():FindFirstChild("Musketeer Hat") then
			CTCH = true
		end;
		if CTCH and CheckCitizen then
			Notify("Auto Quest Citizen", "Musketeer Hat Successfully", 3)
		elseif RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3 and CheckCitizen then
			Notify("Auto Quest Citizen", "Citizen Quest Completed", 3)
		end
	end)
	spawn(function()
		while task.wait() do
			if AutoCitizen then
				pcall(function()
					if Lplr.Data.Level.Value >= 1800 and RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits == false then
						if string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and Lplr.PlayerGui.Main.Quest.Visible == true then
							if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Forest Pirate" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											Citizen_Farm_Name = v.Name;
											Citizen_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										until AutoCitizen == false or not v.Parent or v.Humanoid.Health <= 0 or Lplr.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							else
								if ByPassTP then
									BTP(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
								else
									Tween(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
								end
							end
						else
							Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
							if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - GetRoot().Position).Magnitude <= 30 then
								task.wait(1.5)
								RS.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
							end
						end
					elseif Lplr.Data.Level.Value >= 1800 and RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss == false then
						if Lplr.PlayerGui.Main.Quest.Visible and string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and Lplr.PlayerGui.Main.Quest.Visible == true then
							if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Captain Elephant" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											AutoClick()
										until AutoCitizen == false or v.Humanoid.Health <= 0 or not v.Parent or Lplr.PlayerGui.Main.Quest.Visible == false or not gamr:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							else
								if ByPassTP then
									BTP(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
								else
									Tween(CFrame.new(-13459.065429688, 412.68927001953, -7783.1860351563))
								end
							end
						else
							Tween(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
							if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - GetRoot().Position).Magnitude <= 4 then
								task.wait(1.5)
								RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
							end
						end
					elseif Lplr.Data.Level.Value >= 1800 and RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
						Tween(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
					end
				end)
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Buy Haki Color', AutoColorHaki, function(Value)
		AutoColorHaki = Value
	end)
	spawn(function()
		while task.wait() do
			if AutoColorHaki then
				pcall(function()
					RS.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
				end)
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Musketer', AutoMusketeer, function(Value)
		AutoMusketeer = Value;
		CancelTween(AutoMusketeer)
	end)
	spawn(function()
		while task.wait() do
			pcall(function()
				if AutoMusketeer then
					if Lplr.PlayerGui.Main.Quest.Visible == false then
						repeat
							Tween(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625))
							task.wait(2)
						until not AutoMusketeer or (GetRoot().Position - Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10;
						task.wait(.5)
						RS.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
						task.wait(1)
						RS.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
					elseif string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
						if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
							for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == "Forest Pirate" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										Musketere_Farm_Name = v.Name;
										Musketere_Farm_CFrame = v.HumanoidRootPart.CFrame;
										AutoClick()
									until not AutoMusketeer or v.Humanoid.Health <= 0 or not v.Parent
								end
							end
						else
							Tween(RS:FindFirstChild('Forest Pirate').HumanoidRootPart.CFram)
						end
					end
				end
			end)
		end
	end)

	Sword_Wuest:AddToggle('Auto Serpent Bow', Auto_Serpent_Bow, function(Value)
		Auto_Serpent_Bow = Value;
		CancelTween(Auto_Serpent_Bow)
	end)
	spawn(function()
		while task.wait() do
			pcall(function()
				if Auto_Serpent_Bow then
					if game.Workspace.Enemies:FindFirstChild("Island Empress") then
						for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Island Empress" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until v.Humanoid.Health <= 0 or not v.Parent or not Auto_Serpent_Bow
								end
							end
						end
					else
						Tween(RS:FindFirstChild("Island Empress").HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end)

	Sword_Wuest:AddToggle("Auto ArenaTrainer",false,function(v)
		_G.Namfon = v
		CancelTween(_G.Namfon)
			print(v)
		end) 
	
			
			local GGPos = CFrame.new(3757.732421875, 91.99540710449219, 253.65066528320312)
			spawn(function()
				while wait() do
					if _G.Namfon and Third_Sea then
						pcall(function()
							if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
								if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Training Dummy") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Training Dummy") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Training Dummy") then
									if game:GetService("Workspace").Enemies:FindFirstChild("Training Dummy") or game:GetService("Workspace").Enemies:FindFirstChild("Training Dummy") or game:GetService("Workspace").Enemies:FindFirstChild("Training Dummy") then
										for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if v.Name == "Training Dummy" or v.Name == "Training Dummy" or v.Name == "Training Dummy" then
												if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat wait()
														AutoHaki()
														EquipTool(SelectWeaponFarm)
														Fastattack = true
														v.HumanoidRootPart.CanCollide = false
														v.Humanoid.WalkSpeed = 0
														v.HumanoidRootPart.Size = Vector3.new(50,50,50)
														Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
														AutoClick()
													until _G.Namfon == false or v.Humanoid.Health <= 0 or not v.Parent
													Fastattack = false
												end
											end
										end
									else
									if BypassTP then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - GGPos.Position).Magnitude > 1500 then
									BTP(GGPos)
									elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - GGPos.Position).Magnitude < 1500 then
									Tween(GGPos)
									end
								else
									Tween(GGPos)
								end
										Tween(CFrame.new(3757.732421875, 91.99540710449219, 253.65066528320312))
										if game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy") then
											Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy").HumanoidRootPart.CFrame * MethodFarm)
										elseif game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy") then
											Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy").HumanoidRootPart.CFrame * MethodFarm)
										elseif game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy") then
											Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Training Dummy").HumanoidRootPart.CFrame * MethodFarm)
										end
									end                    
								end
							else
								if _G.AutoArenaTrainerHop and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ArenaTrainer") == "I don't have anything for you right now. Come back later." then
									hop()
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ArenaTrainer")
								end
							end
						end)
					end
				end
			end)

		Sword_Wuest:AddToggle("Auto Press Haki Color Button",false,function(v)
			Open_Color_Haki = v
			CancelTween(Open_Color_Haki)
				print(v)
	     end) 
		
			
			spawn(function()
				while wait(.3) do
					pcall(function()
						if Open_Color_Haki then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
							wait(0.5)
							repeat Tween(CFrame.new(-5420.16602, 1084.9657, -2666.8208)) wait() 
							until _G.CancelTween == true or Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5420.16602, 1084.9657, -2666.8208)).Magnitude <= 10
							wait(0.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
							wait(0.5)
							repeat Tween(CFrame.new(-5414.41357, 309.865753, -2212.45776)) wait() 
							until _G.CancelTween == true or Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-5414.41357, 309.865753, -2212.45776)).Magnitude <= 10
							wait(0.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
							wait(0.5)
							repeat Tween(CFrame.new(-4971.47559, 331.565765, -3720.02954)) wait() 
							until _G.CancelTween == true or Open_Color_Haki == false or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-4971.47559, 331.565765, -3720.02954)).Magnitude <= 10
							wait(0.5)
							game:GetService'VirtualUser':Button1Down(Vector2.new(1280,600))
							wait(3)
							game:GetService'VirtualUser':Button1Down(Vector2.new(1280,600))
						end
					end) 
				end
			end)

	Sword_Wuest:AddToggle('Auto Yama', AutoYama, function(Value)
		AutoYama = Value;
		CancelTween(AutoYama)
	end)
	spawn(function()
		while task.wait() do
			if AutoYama then
				if RS.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
					repeat
						task.wait()
						fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
					until Lplr.Backpack:FindFirstChild("Yama") or not AutoYama
				end
			end
		end
	end)
	

	Sword_Wuest:AddToggle('Auto Dark Dagger', AutoDarkDagger, function(Value)
		AutoDarkDagger = Value;
		CancelTween(AutoDarkDagger)
	end)
	spawn(function()
		while task.wait() do
			if AutoDarkDagger then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "rip_indra True Form" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not AutoDarkDagger or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						end
					else
						Tween(RS:FindFirstChild("rip_indra True Form").HumanoidRootPart.CFrame)
					end
				end)
			end
		end
	end)
	Sword_Wuest:AddToggle('Auto Hallow Sycthe', AutoHallowSycthe, function(Value)
		AutoHallowSycthe = Value;
		CancelTween(AutoHallowSycthe)
	end)
	spawn(function()
		while task.wait() do
			if AutoHallowSycthe then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Soul Reaper" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until v.Humanoid.Health <= 0 or not AutoHallowSycthe or not v.Parent
								end
							end
						end
					else
						loc3 = CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125)
						if Lplr.Backpack:FindFirstChild("Hallow Essence") or GetChar():FindFirstChild("Hallow Essence") then
							repeat
								task.wait()
								Tween(loc3)
								task.wait()
							until (loc3.Position - GetRoot().Position).Magnitude <= 8;
							EquipTool("Hallow Essence")
						else
							Tween(RS:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Cavander', AutoCavander, function(Value)
		AutoCavander = Value;
		CancelTween(AutoCavander)
	end)
	spawn(function()
		while task.wait() do
			if AutoCavander then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Beautiful Pirate" then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not AutoCavander or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						end
					else
						if ByPassTP then
							BTP(RS:FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame)
						else
							Tween(RS:FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)
	Sword_Wuest:AddToggle('Auto Tushita', AutoTushita, function(Value)
		AutoTushita = Value;
		CancelTween(AutoTushita)
	end)
	function enemyrip()
		Tween(CFrame.new(-5332.30371, 423.985413, -2673.48218))
		task.wait()
		if game.Workspace.Enemies:FindFirstChild("rip_indra True Form") then
			local mobs = game.Workspace.Enemies:GetChildren()
			for i, v in pairs(mobs) do
				if v.Name == "rip_indra True Form" and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					return v
				end
			end
		end;
		return RS:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")
	end;
	function enemyEliteBoss()
		if game.Workspace.Enemies:FindFirstChild("Deandre") or game.Workspace.Enemies:FindFirstChild("Urban") or game.Workspace.Enemies:FindFirstChild("Diablo") then
			local mobs = game.Workspace.Enemies:GetChildren()
			for i, v in pairs(mobs) do
				if v.Name == "Deandre" or v.Name == "Diablo" or v.Name == "Urban" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					return v
				end
			end
		end;
		return RS:FindFirstChild("Deandre") or RS:FindFirstChild("Urban") or RS:FindFirstChild("Diablo")
	end;
	function enemylongma()
		Tween(CFrame.new(-10171.7051, 406.981995, -9552.31738))
		if game.Workspace.Enemies:FindFirstChild("Longma") then
			local mobs = game.Workspace.Enemies:GetChildren()
			for i, v in pairs(mobs) do
				if v.Name == "Longma" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					return v
				end
			end
		end;
		return RS:FindFirstChild("Longma")
	end;
	function autoTushita()
		if not Lplr.Backpack:FindFirstChild("God's Chalice") and not GetChar():FindFirstChild("God's Chalice") then
			if game.Workspace.Enemies:FindFirstChild("Deandre") or game.Workspace.Enemies:FindFirstChild("Urban") or game.Workspace.Enemies:FindFirstChild("Diablo") or RS:FindFirstChild("Deandre") or RS:FindFirstChild("Urban") or RS:FindFirstChild("Diablo") then
				if Lplr.PlayerGui.Main.Quest.Visible == false then
					repeat
						Tween(CFrame.new(5420.49219, 314.446045, -2823.07373))
						task.wait()
					until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
					task.wait(1)
					repeat
						Tween(CFrame.new(5420.49219, 314.446045, -2823.07373))
						task.wait()
					until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
					task.wait(1.1)
					RS.Remotes.CommF_:InvokeServer("EliteHunter")
					task.wait(1)
				elseif Lplr.PlayerGui.Main.Quest.Visible == true then
					CheckLevel()
					pcall(function()
						local v = enemyEliteBoss()
						v.HumanoidRootPart.CanCollide = false;
						v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
						EquipTool(SelectWeaponFarm)
						Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
						AutoClick()
					end)
				end
			else
				Tween(CFrame.new(-12554.9443, 337.194092, -7501.44727))
			end
		elseif Lplr.Backpack:FindFirstChild("God's Chalice") or GetChar():FindFirstChild("God's Chalice") then
			RS.Remotes.CommF_:InvokeServer("activateColor", "Winter Sky")
			task.wait(0.5)
			repeat
				Tween(CFrame.new(-5420.16602, 1084.9657, -2666.8208))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(-5420.16602, 1084.9657, -2666.8208)).Magnitude <= 10;
			task.wait(0.5)
			RS.Remotes.CommF_:InvokeServer("activateColor", "Pure Red")
			task.wait(0.5)
			repeat
				Tween(CFrame.new(-5414.41357, 309.865753, -2212.45776))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(-5414.41357, 309.865753, -2212.45776)).Magnitude <= 10;
			task.wait(0.5)
			RS.Remotes.CommF_:InvokeServer("activateColor", "Snow White")
			task.wait(0.5)
			repeat
				Tween(CFrame.new(-4971.47559, 331.565765, -3720.02954))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(-4971.47559, 331.565765, -3720.02954)).Magnitude <= 10;
			task.wait(0.5)
			EquipTool("God's Chalice")
			task.wait(0.5)
			repeat
				Tween(CFrame.new(-5560.27295, 313.915466, -2663.89795))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(-5560.27295, 313.915466, -2663.89795)).Magnitude <= 10;
			task.wait(0.5)
			repeat
				Tween(CFrame.new(-5561.37451, 313.342529, -2663.4948))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(1)
			repeat
				Tween(CFrame.new(5154.17676, 141.786423, 911.046326))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(0.2)
			repeat
				Tween(CFrame.new(5148.03613, 162.352493, 910.548218))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(1)
			EquipTool("Holy Torch")
			task.wait(1)
			task.wait(0.4)
			repeat
				Tween(CFrame.new(-10752.7695, 412.229523, -9366.36328))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(0.4)
			repeat
				Tween(CFrame.new(-11673.4111, 331.749023, -9474.34668))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(0.4)
			repeat
				Tween(CFrame.new(-12133.3389, 519.47522, -10653.1904))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(0.4)
			repeat
				Tween(CFrame.new(-13336.5, 485.280396, -6983.35254))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(0.4)
			repeat
				Tween(CFrame.new(-13487.4131, 334.84845, -7926.34863))
				task.wait()
			until not AutoTushita or (GetRoot().Position - Vector3.new(5420.49219, 314.446045, -2823.07373)).Magnitude <= 10;
			task.wait(1)
		elseif game.Workspace.Enemies:FindFirstChild("Longma") or RS:FindFirstChild("Longma") then
			pcall(function()
				local v = enemylongma()
				v.HumanoidRootPart.CanCollide = false;
				v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
				EquipTool(SelectWeaponFarm)
				Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
				Click()
			end)
		elseif game.Workspace.Enemies:FindFirstChild("rip_indra True Form") or RS:FindFirstChild("rip_indra True Form") then
			pcall(function()
				local v = enemyrip()
				v.HumanoidRootPart.CanCollide = false;
				v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
				EquipTool(SelectWeaponFarm)
				Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
				AutoClick()
			end)
		else
			Tween(CFrame.new(-12554.9443, 337.194092, -7501.44727))
		end
	end;
	spawn(function()
		while task.wait() do
			if AutoTushita then
				pcall(function()
					autoTushita()
				end)
			end
		end
	end)
	function GetWeaponInventory(Sword)
		for i, v in pairs(RS.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v) == "table" then
				if v.Type == "Sword" then
					if v.Name == Sword then
						return true
					end
				end
			end
		end;
		return false
	end;
	Sword_Wuest:AddToggle('Auto CDK', Auto_Cursed_Dual_Katana, function(Value)
		Auto_Cursed_Dual_Katana = Value;
		CancelTween(Auto_Cursed_Dual_Katana)
	end)
	spawn(function()
		while task.wait() do
			pcall(function()
				if Auto_Cursed_Dual_Katana then
					if GetChar():FindFirstChild("Tushita") or Lplr.Backpack:FindFirstChild("Tushita") or GetChar():FindFirstChild("Yama") or Lplr.Backpack:FindFirstChild("Yama") then
						if GetChar():FindFirstChild("Tushita") or Lplr.Backpack:FindFirstChild("Tushita") then
							if Lplr.Backpack:FindFirstChild("Tushita") then
								EquipTool("Tushita")
							end
						elseif GetChar():FindFirstChild("Yama") or Lplr.Backpack:FindFirstChild("Yama") then
							if Lplr.Backpack:FindFirstChild("Yama") then
								EquipTool("Yama")
							end
						end
					else
						RS.Remotes.CommF_:InvokeServer("LoadItem", "Tushita")
					end;
					if CheckMaterial("Alucard Fragment") == 0 then
						Auto_Quest_Yama_1 = true;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					elseif CheckMaterial("Alucard Fragment") == 1 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = true;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					elseif CheckMaterial("Alucard Fragment") == 2 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = true;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					elseif CheckMaterial("Alucard Fragment") == 3 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = true;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = false;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
					elseif CheckMaterial("Alucard Fragment") == 4 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = true;
						Auto_Quest_Tushita_3 = false;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
					elseif CheckMaterial("Alucard Fragment") == 5 then
						Auto_Quest_Yama_1 = false;
						Auto_Quest_Yama_2 = false;
						Auto_Quest_Yama_3 = false;
						Auto_Quest_Tushita_1 = false;
						Auto_Quest_Tushita_2 = false;
						Auto_Quest_Tushita_3 = true;
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
						RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
					elseif CheckMaterial("Alucard Fragment") == 6 then
						if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss") or game:GetService("Workspace").ReplicatedStorage:FindFirstChild("Cursed Skeleton Boss") then
							Auto_Quest_Yama_1 = false;
							Auto_Quest_Yama_2 = false;
							Auto_Quest_Yama_3 = false;
							Auto_Quest_Tushita_1 = false;
							Auto_Quest_Tushita_2 = false;
							Auto_Quest_Tushita_3 = false;
							if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton Boss" or v.Name == "Cursed Skeleton" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											AutoClick()
										until not Auto_Cursed_Dual_Katana or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							end
						else
							if (CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875).Position - GetRoot().Position).Magnitude <= 100 then
								RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
								task.wait(1)
								RS.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
								task.wait(1)
								Tween(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875))
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(CFrame.new(-12253.5419921875, 598.8999633789062, -6546.8388671875))
							else
								Tween(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875))
							end
						end
					end
				end
			end)
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Yama_1 then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Mythological Pirate" then
								repeat
									task.wait()
									EquipTool(SelectWeaponFarm)
									Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
									v.HumanoidRootPart.CanCollide = false;
									v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									v.HumanoidRootPart.Transparency = 1;
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									AutoClick()
								until Auto_Cursed_Dual_Katana == false or Auto_Quest_Yama_1 == false;
								RS.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
							end
						end
					else
						Tween(CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875))
					end
				end)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Yama_2 then
				pcall(function()
					for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							v.HazeESP.Size = UDim2.new(50, 50, 50, 50)
							v.HazeESP.MaxDistance = "inf"
						end
					end;
					for i, v in pairs(RS:GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							v.HazeESP.Size = UDim2.new(50, 50, 50, 50)
							v.HazeESP.MaxDistance = "inf"
						end
					end;
					for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v:FindFirstChild("HazeESP") and (v.HumanoidRootPart.Position - PosMonsEsp.Position).magnitude <= 300 then
							v.HumanoidRootPart.CFrame = PosMonsEsp;
							v.HumanoidRootPart.CanCollide = false;
							v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
							if not v.HumanoidRootPart:FindFirstChild("BodyVelocity") then
								local vc = Instance.new("BodyVelocity", v.HumanoidRootPart)
								vc.MaxForce = Vector3.new(1, 1, 1) * math.huge;
								vc.Velocity = Vector3.new(0, 0, 0)
							end
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Yama_2 then
				pcall(function()
					for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v:FindFirstChild("HazeESP") then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
								v.HumanoidRootPart.CanCollide = false;
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.Transparency = 1;
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
								AutoClick()
							until Auto_Cursed_Dual_Katana == false or Auto_Quest_Yama_2 == false or not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("HazeESP")
						else
							for x, y in pairs(RS:GetChildren()) do
								if y:FindFirstChild("HazeESP") then
									if (y.HumanoidRootPart.Position - GetRoot().Position).Magnitude > 2000 then
										BTP(y.HumanoidRootPart.CFrameMon * Farm_Mode)
									else
										Tween(y.HumanoidRootPart.CFrame * Farm_Mode)
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Yama_3 then
				pcall(function()
					if Lplr.Backpack:FindFirstChild("Hallow Essence") then
						Tween(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
					elseif game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
						repeat
							task.wait()
							if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Hell's Messenger") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton" or v.Name == "Hell's Messenger" then
										if v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until v.Humanoid.Health <= 0 or not v.Parent or Auto_Quest_Yama_3 == false
										end
									end
								end
							else
								task.wait(5)
								Tween(game:GetService("Workspace").Map.HellDimension.Torch1.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HellDimension.Torch2.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HellDimension.Torch3.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
							end
						until Auto_Cursed_Dual_Katana == false or Auto_Quest_Yama_3 == false or CheckMaterial("Alucard Fragment") == 3
					else
						if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") or RS:FindFirstChild("Soul Reaper") then
							if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Soul Reaper" then
										if v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until Auto_Cursed_Dual_Katana == false or Auto_Quest_Yama_3 == false or game:GetService("Workspace").Map:FindFirstChild("HellDimension")
										end
									end
								end
							else
								Tween(CFrame.new(-9570.033203125, 315.9346923828125, 6726.89306640625))
							end
						else
							RS.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Tushita_1 then
				Tween(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125))
				task.wait(5)
				Tween(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625))
				task.wait(5)
				Tween(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875))
				task.wait(5)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Tushita_2 then
				pcall(function()
					if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - GetRoot().Position).Magnitude <= 500 then
						Tween(CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125))
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if Auto_Quest_Tushita_2 and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								if (v.HumanoidRootPart.Position - GetRoot().Position).Magnitude < 2000 then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until v.Humanoid.Health <= 0 or not v.Parent or Auto_Quest_Tushita_2 == false
								end
							end
						end
					end
				end)
			end
		end
	end)
	spawn(function()
		while task.wait() do
			if Auto_Quest_Tushita_3 then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") or RS:FindFirstChild("Cake Queen") then
						for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Cake Queen" then
								if v.Humanoid.Health > 0 then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until Auto_Cursed_Dual_Katana == false or Auto_Quest_Tushita_3 == false or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension")
								end
							end
						end;
						Tween(CFrame.new(-709.3132934570312, 381.6005859375, -11011.396484375))
					elseif game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
						repeat
							task.wait()
							if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Heaven's Guardian") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Cursed Skeleton" or v.Name == "Heaven's Guardian" then
										if v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until v.Humanoid.Health <= 0 or not v.Parent or Auto_Quest_Tushita_3 == false
										end
									end
								end
							else
								task.wait(5)
								Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch1.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch2.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch3.CFrame)
								task.wait(1.5)
								VIM:SendKeyEvent(true, "E", false, game)
								task.wait(1.5)
								Tween(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
							end
						until Auto_Cursed_Dual_Katana == false or Auto_Quest_Tushita_3 == false or CheckMaterial("Alucard Fragment") == 6
					end
				end)
			end
		end
	end)

	Sword_Wuest:AddToggle('Auto Buddy Sword', AutoBuddySword, function(Value)
		AutoBuddySword = Value
		CancelTween(AutoBuddySword)
	end)
	spawn(function()
		while task.wait() do
			if AutoBuddySword then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Cake Queen [Lv. 2175] [Boss]" then
									repeat game:GetService("RunService").Heartbeat:wait()
										EquipTool(SelectWeapon)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(60,60,60)
										v.HumanoidRootPart.Transparency = 1
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not AutoBuddySword or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						end
					else
						Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]").HumanoidRootPart.CFrame)
					end
				end)
			end
		end
	end)
	
	Sword_Wuest:AddToggle('Auto Pole', AutoPole, function(Value)
		AutoPole = Value
		CancelTween(AutoPole)
	end)
	spawn(function()
		while task.wait() do
			if AutoPole then
				pcall(function()
					if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								if v.Name == "Thunder God" then
									repeat game:GetService("RunService").Heartbeat:wait()
										EquipTool(SelectWeapon)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(60,60,60)
										v.HumanoidRootPart.Transparency = 1
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not AutoPole or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						end
					else
						if ByPassTP then
							BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame)
						else
							Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)

	local Elite_Hunter_Quest = Tab_3:AddSection('','Elite Hunter','Auto kill elite hunter when its spawn','rbxassetid://10747375281')
	local EliteProgress = Elite_Hunter_Quest:AddLabel("")
	local Elite_Hunter_Status = Elite_Hunter_Quest:AddLabel("")
	spawn(function()
		while task.wait() do
			local progelit = RS.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
			EliteProgress:Set("Elite Boss Killed : " .. progelit)
			if RS:FindFirstChild('Diablo') or RS:FindFirstChild('Deandre') or RS:FindFirstChild('Urban') then
			elseif not RS:FindFirstChild('Diablo') or not RS:FindFirstChild('Deandre') or not RS:FindFirstChild('Urban') then
			end
		end
	end)
	
	spawn(function()
		while wait() do
			pcall(function()
				if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
					Elite_Hunter_Status:Set("Status : Elite Spawn!")	
				else
					Elite_Hunter_Status:Set("Status : Elite Not Spawn")	
				end
			end)
		end
	end)
	
	Elite_Hunter_Quest:AddToggle('Auto Elite Hunter', AutoEliteHunter, function(Value)
		AutoEliteHunter = Value;
		CancelTween(AutoEliteHunter)
	end)
	spawn(function()
		while task.wait() do
			if AutoEliteHunter then
				pcall(function()
					if Lplr.PlayerGui.Main.Quest.Visible == true then
						if string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") then
							if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
								for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until AutoEliteHunter == false or v.Humanoid.Health <= 0 or not v.Parent
										end
									end
								end
							else
								if RS:FindFirstChild("Diablo") then
									if ByPassTP then
										BTP(RS:FindFirstChild("Diablo").HumanoidRootPart.CFrame)
									else
										Tween(RS:FindFirstChild("Diablo").HumanoidRootPart.CFrame)
									end
								elseif RS:FindFirstChild("Deandre") then
									if ByPassTP then
										BTP(RS:FindFirstChild("Deandre").HumanoidRootPart.CFrame)
									else
										Tween(RS:FindFirstChild("Deandre").HumanoidRootPart.CFrame)
									end
								elseif RS:FindFirstChild("Urban") then
									if ByPassTP then
										BTP(RS:FindFirstChild("Urban").HumanoidRootPart.CFrame)
									else
										Tween(RS:FindFirstChild("Urban").HumanoidRootPart.CFrame)
									end
								end
							end
						end
					else
						RS.Remotes.CommF_:InvokeServer("EliteHunter")
					end
				end)
			end
		end
	end)
	local Cake_Prince_Quest = Tab_3:AddSection('','Dought King','auto do quest to kill cake prince','rbxassetid://6034467796')
	
		MobKilled = Cake_Prince_Quest:AddLabel("มอปคิวอีดี"
		)
			
			spawn(function()
				while wait() do
					pcall(function()
						if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
							KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41)) - 500)
						elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
							KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),40,41)) - 500)
						elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
							KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),41,41)) - 500)
						end
					end)
				end
			end)
			
			spawn(function()
				while wait() do
					pcall(function()
						if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
							MobKilled:Set("You Need to Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41))
						elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
							MobKilled:Set("You Need to Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40))
						elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
							MobKilled:Set("You Need to Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39))
						else
							MobKilled:Set("Boss Is Spawning")
						end
					end)
				end
			end)
	Cake_Prince_Quest:AddToggle('Auto Cake Prince', AutoCakePrince, function(Value)
		AutoCakePrince = Value;
		CancelTween(AutoCakePrince)
	end)
	spawn(function()
		while task.wait() do
			if AutoCakePrince then
				pcall(function()
					RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					if RS:FindFirstChild("Cake Prince") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
						if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
							for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoCakePrince and v.Name == "Cake Prince" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat
										task.wait()
										EquipTool(SelectWeaponFarm)
										Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
										v.HumanoidRootPart.CanCollide = false;
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										v.HumanoidRootPart.Transparency = 1;
										v.Humanoid:ChangeState(11)
										v.Humanoid:ChangeState(14)
										AutoClick()
									until not AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						else
							if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 and (CFrame.new(-1990.672607421875, 4532.99951171875, -14973.6748046875).Position - GetRoot().Position).Magnitude >= 2000 then
								Tween(CFrame.new(-2151.82153, 149.315704, -12404.9053))
							end
						end
					else
						if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
							for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									if (v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											CakePrince_Farm_Name = v.Name;
											CakePrince_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										until not AutoCakePrince or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							end
						else
							local cakepos = CFrame.new(-2077, 252, -12373)
							if ByPassTP then
								BTP(cakepos)
							else
								Tween(cakepos)
							end
						end
					end
				end)
			end
		end
	end)
	Cake_Prince_Quest:AddToggle('Auto Dough King (Need Sweet Chalice)', _G.AutoDoughKing, function(Value)
		_G.AutoDoughKing = Value;
		CancelTween(_G.AutoDoughKing)
	end)
	spawn(function()
		while task.wait(.1) do
			if _G.AutoDoughKing then
				local Place_1 = CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)
				pcall(function()
					if game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
						if GetChar():FindFirstChild("Red Key") or Lplr.Backpack:FindFirstChild("Red Key") then
							RS.Remotes.CommF_:InvokeServer("CakeScientist", "Check")
							task.wait(1)
							RS.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
							Tween(Place_1)
							if (Place_1.Position - GetRoot().Position).magnitude <= 5 then
								GetRoot().CFrame = CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)
								task.wait(0.5)
								EquipTool("Red Key")
								task.wait(0.5)
							end
						elseif game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King") or RS:FindFirstChild("Dough King") then
							if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
								for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Dough King" then
										if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												AutoClick()
											until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
										end
									end
								end
							else
								if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
									local BigMirrorPlace = CFrame.new(-2151.82153, 149.315704, -12404.9053)
									Tween(BigMirrorPlace)
									if (BigMirrorPlace.Position - GetRoot().Position).magnitude <= 300 then
										GetRoot().CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
										task.wait(1)
									end
								end
							end
						elseif GetChar():FindFirstChild("Sweet Chalice") or Lplr.Backpack:FindFirstChild("Sweet Chalice") then
							if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker") then
								for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Cookie Crafter" or v.Name == "Cake Guard" or v.Name == "Baking Staff" or v.Name == "Head Baker" then
										if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat
												task.wait()
												EquipTool(SelectWeaponFarm)
												Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
												v.HumanoidRootPart.CanCollide = false;
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
												v.HumanoidRootPart.Transparency = 1;
												v.Humanoid:ChangeState(11)
												v.Humanoid:ChangeState(14)
												DoughKing_Farm_Name = v.Name;
												DoughKing_Farm_CFrame = v.HumanoidRootPart.CFrame;
												AutoClick()
												RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
												RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
											until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
										end
									end
								end
							else
								Tween(CFrame.new(-2077, 252, -12373))
								if (CFrame.new(-2077, 252, -12373).Position - GetRoot().Position).magnitude <= 300 then
									GetRoot().CFrame = CFrame.new(-2077, 252, -12373)
								end
							end
						elseif (Lplr.Backpack:FindFirstChild("God's Chalice") or GetChar():FindFirstChild("God's Chalice")) and GetMaterial("Conjured Cocoa") >= 10 then
							RS.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
							task.wait(0.2)
						elseif not Lplr.Backpack:FindFirstChild("God's Chalice") and not GetChar():FindFirstChild("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre") or game.Workspace.Enemies:FindFirstChild("Urban") or game.Workspace.Enemies:FindFirstChild("Diablo") or RS:FindFirstChild("Deandre") or RS:FindFirstChild("Urban") or RS:FindFirstChild("Diablo")) then
							if Lplr.PlayerGui.Main.Quest.Visible == true then
								if string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(Lplr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
									if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
										for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "Diablo" or v.Name == "Urban" or v.Name == "Deandre" then
												if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
													repeat
														task.wait()
														EquipTool(SelectWeaponFarm)
														Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
														v.HumanoidRootPart.CanCollide = false;
														v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
														v.HumanoidRootPart.Transparency = 1;
														v.Humanoid:ChangeState(11)
														v.Humanoid:ChangeState(14)
														AutoClick()
													until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
												end
											end
										end
									else
										if RS:FindFirstChild("Diablo") then
											if ByPassTP then
												BTP(RS:FindFirstChild("Diablo").HumanoidRootPart.CFrame)
											else
												Tween(RS:FindFirstChild("Diablo").HumanoidRootPart.CFrame)
											end
										elseif RS:FindFirstChild("Deandre") then
											if ByPassTP then
												BTP(RS:FindFirstChild("Deandre").HumanoidRootPart.CFrame)
											else
												Tween(RS:FindFirstChild("Deandre").HumanoidRootPart.CFrame)
											end
										elseif RS:FindFirstChild("Urban") then
											if ByPassTP then
												BTP(RS:FindFirstChild("Urban").HumanoidRootPart.CFrame)
											else
												Tween(RS:FindFirstChild("Urban").HumanoidRootPart.CFrame)
											end
										end
									end
								end
							else
								RS.Remotes.CommF_:InvokeServer("EliteHunter")
							end
						else
							if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior") then
								for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
									if (v.Name == "Candy Rebel" or v.Name == "Sweet Thief" or v.Name == "Chocolate Bar Battler" or v.Name == "Cocoa Warrior") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											DoughKing_Farm_Name = v.Name;
											DoughKing_Farm_CFrame = v.HumanoidRootPart.CFrame;
											AutoClick()
										until not _G.AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							else
								Tween(CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625))
								if (CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625).Position - GetRoot().Position).magnitude <= 150 then
									GetRoot().CFrame = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
								end
							end
						end
					end
				end)
			end
		end
	end)
end

local Fighting_Quest = Tab_3:AddSection('','Auto FightingStyle','auto get any fightingstyle','rbxassetid://6031233841')
Fighting_Quest:AddToggle('Auto DeathStep', AutoDeathStep, function(Value)
	AutoDeathStep = Value;
	CancelTween(AutoDeathStep)
	if AutoDeathStep then
		RS.Remotes.CommF_:InvokeServer("BuyBlackLeg")
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if AutoDeathStep then
				if GetChar():FindFirstChild("Black Leg") and GetChar():FindFirstChild("Black Leg").Level.Value >= 400 or Lplr.Backpack:FindFirstChild("Black Leg") and Lplr.Backpack:FindFirstChild("Black Leg").Level.Value >= 400 then
					if game:GetService("Workspace").Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
						Tween(CFrame.new(6372.57275, 302.194611, -6838.97461, 0.838541508, -8.27643453e-05, 0.544837654, 8.27643453e-05, 1, 2.45265783e-05, -0.544837654, 2.45265783e-05, 0.838541508))
						RS.Remotes.CommF_:InvokeServer("BuyDeathStep")
						if GetChar():FindFirstChild("Library Key") or Lplr.Backpack:FindFirstChild("Library Key") then
							EquipTool("Library Key")
							repeat
								task.wait()
								if ByPassTP then
									BTP(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375))
								else
									Tween(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375))
								end
							until (CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position - GetRoot().Position).Magnitude <= 3 or not AutoDeathStep;
							if (CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position - GetRoot().Position).Magnitude <= 3 then
								task.wait(1.2)
								RS.Remotes.CommF_:InvokeServer("BuyDeathStep")
								task.wait(0.5)
							end
						else
							if RS:FindFirstChild("Awakened Ice Admiral") or game:GetService("Workspace").Enemies:FindFirstChild("Awakened Ice Admiral") then
								if game:GetService("Workspace").Enemies:FindFirstChild("Awakened Ice Admiral") then
									for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											if v.Name == "Awakened Ice Admiral" then
												repeat
													task.wait()
													EquipTool(SelectWeaponFarm)
													Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
													v.HumanoidRootPart.CanCollide = false;
													v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
													v.HumanoidRootPart.Transparency = 1;
													v.Humanoid:ChangeState(11)
													v.Humanoid:ChangeState(14)
													AutoClick()
												until not v.Parent or v.Humanoid.Health <= 0 or AutoDeathStep == false or GetChar():FindFirstChild("Library Key") or Lplr.Backpack:FindFirstChild("Library Key")
											end
										end
									end
								end
							else
								if ByPassTP then
									BTP(RS:FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]").HumanoidRootPart.CFrame)
								else
									Tween(RS:FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]").HumanoidRootPart.CFrame)
								end
							end
						end
					end
				else
					RS.Remotes.CommF_:InvokeServer("BuyBlackLeg")
				end
			end
		end)
	end
end)
Fighting_Quest:AddToggle('Auto SuperHuman', AutoSuperhuman, function(Value)
	AutoSuperhuman = Value;
	CancelTween(AutoSuperhuman)
	if AutoSuperhuman then
		RS.Remotes.CommF_:InvokeServer("BuySuperhuman")
	end
end)
spawn(function()
	while task.wait() do
		if AutoSuperhuman then
			pcall(function()
				if Lplr:FindFirstChild("WeaponAssetCache") then
					if Lplr.Backpack:FindFirstChild("Combat") or GetChar():FindFirstChild("Combat") and Lplr.Data.Beli.Value >= 150000 then
						RS.Remotes.CommF_:InvokeServer("BuyBlackLeg")
					end;
					if GetChar():FindFirstChild("Superhuman") or Lplr.Backpack:FindFirstChild("Superhuman") then
						SelectWeapon = "Superhuman"
						EquipTool(SelectWeapon)
					end;
					if Lplr.Backpack:FindFirstChild("Black Leg") or GetChar():FindFirstChild("Black Leg") or Lplr.Backpack:FindFirstChild("Electro") or GetChar():FindFirstChild("Electro") or Lplr.Backpack:FindFirstChild("Fishman Karate") or GetChar():FindFirstChild("Fishman Karate") or Lplr.Backpack:FindFirstChild("Dragon Claw") or GetChar():FindFirstChild("Dragon Claw") then
						if Lplr.Backpack:FindFirstChild("Black Leg") and Lplr.Backpack:FindFirstChild("Black Leg").Level.Value <= 299 then
							SelectWeapon = "Black Leg"
							EquipTool(SelectWeapon)
						end;
						if Lplr.Backpack:FindFirstChild("Electro") and Lplr.Backpack:FindFirstChild("Electro").Level.Value <= 299 then
							SelectWeapon = "Electro"
							EquipTool(SelectWeapon)
						end;
						if Lplr.Backpack:FindFirstChild("Fishman Karate") and Lplr.Backpack:FindFirstChild("Fishman Karate").Level.Value <= 299 then
							SelectWeapon = "Fishman Karate"
							EquipTool(SelectWeapon)
						end;
						if Lplr.Backpack:FindFirstChild("Dragon Claw") and Lplr.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 299 then
							SelectWeapon = "Dragon Claw"
							EquipTool(SelectWeapon)
						end;
						if Lplr.Backpack:FindFirstChild("Black Leg") and Lplr.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 and Lplr.Data.Beli.Value >= 300000 then
							RS.Remotes.CommF_:InvokeServer("BuyElectro")
						end;
						if GetChar():FindFirstChild("Black Leg") and GetChar():FindFirstChild("Black Leg").Level.Value >= 300 and Lplr.Data.Beli.Value >= 300000 then
							RS.Remotes.CommF_:InvokeServer("BuyElectro")
						end;
						if Lplr.Backpack:FindFirstChild("Electro") and Lplr.Backpack:FindFirstChild("Electro").Level.Value >= 300 and Lplr.Data.Beli.Value >= 750000 then
							RS.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end;
						if GetChar():FindFirstChild("Electro") and GetChar():FindFirstChild("Electro").Level.Value >= 300 and Lplr.Data.Beli.Value >= 750000 then
							RS.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end;
						if Lplr.Backpack:FindFirstChild("Fishman Karate") and Lplr.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300 and Lplr.Data.Fragments.Value >= 1500 then
							RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
							RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						end;
						if GetChar():FindFirstChild("Fishman Karate") and GetChar():FindFirstChild("Fishman Karate").Level.Value >= 300 and Lplr.Data.Fragments.Value >= 1500 then
							RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
							RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
						else
							local Fragment = Lplr.Data.Fragments.Value;
							if Fragment <= 1499 then
								AutoSuperhuman = true
							else
								AutoSuperhuman = false
							end
						end;
						if Lplr.Backpack:FindFirstChild("Dragon Claw") and Lplr.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 and Lplr.Data.Beli.Value >= 3000000 then
							RS.Remotes.CommF_:InvokeServer("BuySuperhuman")
						end;
						if GetChar():FindFirstChild("Dragon Claw") and GetChar():FindFirstChild("Dragon Claw").Level.Value >= 300 and Lplr.Data.Beli.Value >= 3000000 then
							RS.Remotes.CommF_:InvokeServer("BuySuperhuman")
						end
					end
				end
			end)
		end
	end
end)
Fighting_Quest:AddToggle('Auto Sharkman Karate', AutoSharkman, function(Value)
	AutoSharkman = Value;
	CancelTween(AutoSharkman)
	if AutoSharkman then
		RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if AutoSharkman then
				if GetChar():FindFirstChild("Fishman Karate") and GetChar():FindFirstChild("Fishman Karate").Level.Value >= 400 or Lplr.Backpack:FindFirstChild("Fishman Karate") and Lplr.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 400 then
					Tween(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
					RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
					if GetChar():FindFirstChild("Water Key") or Lplr.Backpack:FindFirstChild("Water Key") then
						repeat
							task.wait()
							Tween(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))
						until (CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position - GetRoot().Position).Magnitude <= 3 or not AutoSharkman;
						if (CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position - GetRoot().Position).Magnitude <= 3 then
							task.wait(1.2)
							RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
							task.wait(0.5)
						end
					else
						if game:GetService("Workspace").Enemies:FindFirstChild("Tide Keeper") then
							for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									if v.Name == "Tide Keeper" then
										repeat
											task.wait()
											EquipTool(SelectWeaponFarm)
											Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
											v.HumanoidRootPart.CanCollide = false;
											v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
											v.HumanoidRootPart.Transparency = 1;
											v.Humanoid:ChangeState(11)
											v.Humanoid:ChangeState(14)
											AutoClick()
										until not v.Parent or v.Humanoid.Health <= 0 or AutoSharkman == false or GetChar():FindFirstChild("Library Key") or Lplr.Backpack:FindFirstChild("Library Key")
									end
								end
							end
						else
							if ByPassTP then
								BTP(RS:FindFirstChild("Tide Keeper").HumanoidRootPart.CFrame)
							else
								Tween(RS:FindFirstChild("Tide Keeper").HumanoidRootPart.CFrame)
							end
						end
					end
				else
					RS.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
				end
			end
		end)
	end
end)
Fighting_Quest:AddToggle('Auto Electric Claw', AutoElectricClaw, function(Value)
	AutoElectricClaw = Value;
	CancelTween(AutoElectricClaw)
	if AutoElectricClaw then
		RS.Remotes.CommF_:InvokeServer("BuyElectro")
	end
end)
spawn(function()
	while task.wait(.1) do
		if AutoElectricClaw then
			pcall(function()
				if Lplr.Backpack:FindFirstChild("Electro") or GetChar():FindFirstChild("Electro") then
					if Lplr.Backpack:FindFirstChild("Electro") or GetChar():FindFirstChild("Electro") and Lplr.Backpack:FindFirstChild("Electro").Level.Value >= 400 or GetChar():FindFirstChild("Electro").Level.Value >= 400 then
						Tween(CFrame.new(-10371.4717, 330.764496, -10131.4199))
						if (CFrame.new(-10371.4717, 330.764496, -10131.4199).Position - GetRoot().Position).Magnitude <= 10 then
							RS.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
							task.wait(2)
						end;
						task.wait(1)
						Tween(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
						if (CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position - GetRoot().Position).Magnitude <= 10 then
							task.wait(1)
						end;
						task.wait(1)
						Tween(CFrame.new(-10371.4717, 330.764496, -10131.4199))
						if (CFrame.new(-10371.4717, 330.764496, -10131.4199).Position - GetRoot().Position).Magnitude <= 10 then
							task.wait(1)
							RS.Remotes.CommF_:InvokeServer("BuyElectricClaw")
						end;
						task.wait(1)
						Tween(CFrame.new(-10371.4717, 330.764496, -10131.4199))
						if (CFrame.new(-10371.4717, 330.764496, -10131.4199).Position - GetRoot().Position).Magnitude <= 10 then
							task.wait(1)
							RS.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
						end;
						task.wait(1)
						Tween(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
						if (CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position - GetRoot().Position).Magnitude <= 10 then
							task.wait(1)
						end;
						task.wait(1)
						Tween(CFrame.new(-10371.4717, 330.764496, -10131.4199))
						if (CFrame.new(-10371.4717, 330.764496, -10131.4199).Position - GetRoot().Position).Magnitude <= 10 then
							task.wait(1)
							RS.Remotes.CommF_:InvokeServer("BuyElectricClaw")
						end;
						SelectWeapon = "Electric Claw"
						EquipTool(SelectWeapon)
						task.wait(.1)
					end
				end
			end)
		end
	end
end)
Fighting_Quest:AddToggle('Auto Dragon Talon', AutoDragonTalon, function(Value)
	AutoDragonTalon = Value;
	CancelTween(AutoDragonTalon)
	if AutoDragonTalon then
		RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
		RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
	end
end)
spawn(function()
	while task.wait(.1) do
		if AutoDragonTalon then
			pcall(function()
				if Lplr:FindFirstChild("WeaponAssetCache") then
					if Lplr.Backpack:FindFirstChild("Dragon Claw") and Lplr.Backpack:FindFirstChild("Dragon Claw").Level.Value <= 399 and GetHum().Health > 0 then
						SelectWeapon = "Dragon Claw"
						EquipTool(SelectWeapon)
					end;
					if GetChar():FindFirstChild("Dragon Claw") and GetChar():FindFirstChild("Dragon Claw").Level.Value <= 399 and GetHum().Health > 0 then
						SelectWeapon = "Dragon Claw"
						EquipTool(SelectWeapon)
					end;
					if Lplr.Backpack:FindFirstChild("Dragon Claw") and Lplr.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 400 and GetHum().Health > 0 then
						SelectWeapon = "Dragon Claw"
						EquipTool(SelectWeapon)
						if RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
							RS.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
						elseif RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						else
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						end
					end;
					if GetChar():FindFirstChild("Dragon Claw") and GetChar():FindFirstChild("Dragon Claw").Level.Value >= 400 and GetHum().Health > 0 then
						SelectWeapon = "Dragon Claw"
						EquipTool(SelectWeapon)
						if RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
							RS.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
						elseif RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						else
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						end
					end
				end
			end)
		end
	end
end)
Fighting_Quest:AddToggle('Auto God Human', AutoGodhuman, function(Value)
	AutoGodhuman = Value;
	CancelTween(AutoGodhuman)
	if AutoGodhuman then
		RS.Remotes.CommF_:InvokeServer("BuyGodhuman")
	end
end)

Fighting_Quest:AddToggle('Auto Sanguine Art [Beta]', false, function(Value)
print("auto Sanguine Art still in progress!")
end)

function CheckMaterial(item)
	for i, v in pairs(RS.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v) == "table" then
			if v.Type == "Material" then
				if v.Name == item then
					return v.Count
				end
			end
		end
	end
end;
spawn(function()
	while task.wait(.1) do
		if AutoGodhuman then
			pcall(function()
				if GetChar():FindFirstChild("Superhuman") or Lplr.Backpack:FindFirstChild("Superhuman") or Lplr.Backpack:FindFirstChild("Black Leg") or GetChar():FindFirstChild("Black Leg") or Lplr.Backpack:FindFirstChild("Death Step") or GetChar():FindFirstChild("Death Step") or Lplr.Backpack:FindFirstChild("Fishman Karate") or GetChar():FindFirstChild("Fishman Karate") or Lplr.Backpack:FindFirstChild("Sharkman Karate") or GetChar():FindFirstChild("Sharkman Karate") or Lplr.Backpack:FindFirstChild("Electro") or GetChar():FindFirstChild("Electro") or Lplr.Backpack:FindFirstChild("Electric Claw") or GetChar():FindFirstChild("Electric Claw") or Lplr.Backpack:FindFirstChild("Dragon Claw") or GetChar():FindFirstChild("Dragon Claw") or Lplr.Backpack:FindFirstChild("Dragon Talon") or GetChar():FindFirstChild("Dragon Talon") or GetChar():FindFirstChild("Godhuman") or Lplr.Backpack:FindFirstChild("Godhuman") then
					if RS.Remotes.CommF_:InvokeServer("BuySuperhuman", true) == 1 then
						if Lplr.Backpack:FindFirstChild("Superhuman") and Lplr.Backpack:FindFirstChild("Superhuman").Level.Value >= 400 or GetChar():FindFirstChild("Superhuman") and GetChar():FindFirstChild("Superhuman").Level.Value >= 400 then
							RS.Remotes.CommF_:InvokeServer("BuyDeathStep")
						end
					else
						Notify("Notification", "Not Have Superhuman", 3)
					end;
					if RS.Remotes.CommF_:InvokeServer("BuyDeathStep", true) == 1 then
						if Lplr.Backpack:FindFirstChild("Death Step") and Lplr.Backpack:FindFirstChild("Death Step").Level.Value >= 400 or GetChar():FindFirstChild("Death Step") and GetChar():FindFirstChild("Death Step").Level.Value >= 400 then
							RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
						end
					else
						Notify("Notification", "Not Have Death Step", 3)
					end;
					if RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) == 1 then
						if Lplr.Backpack:FindFirstChild("Sharkman Karate") and Lplr.Backpack:FindFirstChild("Sharkman Karate").Level.Value >= 400 or GetChar():FindFirstChild("Sharkman Karate") and GetChar():FindFirstChild("Sharkman Karate").Level.Value >= 400 then
							RS.Remotes.CommF_:InvokeServer("BuyElectricClaw")
						end
					else
						Notify("Notification", "Not Have SharkMan Karate", 3)
					end;
					if RS.Remotes.CommF_:InvokeServer("BuyElectricClaw", true) == 1 then
						if Lplr.Backpack:FindFirstChild("Electric Claw") and Lplr.Backpack:FindFirstChild("Electric Claw").Level.Value >= 400 or GetChar():FindFirstChild("Electric Claw") and GetChar():FindFirstChild("Electric Claw").Level.Value >= 400 then
							RS.Remotes.CommF_:InvokeServer("BuyDragonTalon")
						end
					else
						Notify("Notification", "Not Have Electric Claw", 3)
					end;
					if RS.Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
						if Lplr.Backpack:FindFirstChild("Dragon Talon") and Lplr.Backpack:FindFirstChild("Dragon Talon").Level.Value >= 400 or GetChar():FindFirstChild("Dragon Talon") and GetChar():FindFirstChild("Dragon Talon").Level.Value >= 400 then
							if string.find(RS.Remotes.CommF_:InvokeServer("BuyGodhuman", true), "Bring") then
								Notify("Notification", "Not Have Enough Material", 3)
							else
								RS.Remotes.CommF_:InvokeServer("BuyGodhuman")
							end
						end
					else
						Notify("Notification", "Not Have Dragon Talon", 3)
					end
				else
					RS.Remotes.CommF_:InvokeServer("BuySuperhuman")
				end
			end)
		end
	end
end)

local Combat = Stats:AddSection('','Combat','auto teleport/kill player/bounty','rbxassetid://6022668882')
local plyserv = Combat:AddLabel("Players")
spawn(function()
	while task.wait() do
		pcall(function()
			for i, v in pairs(Plrs:GetPlayers()) do
				if i == 12 then
					plyserv:Set("Players :" .. " " .. i .. " " .. "/" .. " " .. "12" .. " " .. "(Max)")
				elseif i == 1 then
					plyserv:Set("Player :" .. " " .. i .. " " .. "/" .. " " .. "12")
				else
					plyserv:Set("Players :" .. " " .. i .. " " .. "/" .. " " .. "12")
				end
			end
		end)
	end
end)
Playerslist = {}
for i, v in pairs(Plrs:GetChildren()) do
	table.insert(Playerslist, v.Name)
end;
local SelectedPly = Combat:AddDropdown("Select Players", Playerslist, "",function(value)
	_G.SelectPly = value
end)
Combat:Button("Refresh Player", function()
	Playerslist = {}
	SelectedPly:Clear()
	for i, v in pairs(Plrs:GetChildren()) do
		SelectedPly:Add(v.Name)
	end
end)
Combat:AddToggle("Spectate Player", false, function(value)
	SpectatePlys = value;
	local plr1 = GetHum()
	local plr2 = Plrs:FindFirstChild(_G.SelectPly)
	repeat
		task.wait(.1)
		game:GetService("Workspace").Camera.CameraSubject = Plrs:FindFirstChild(_G.SelectPly).Character.Humanoid
	until SpectatePlys == false;
	game:GetService("Workspace").Camera.CameraSubject = GetHum()
end)
Combat:AddToggle("Teleport", false, function(value)
	_G.TeleportPly = value;
	pcall(function()
		if _G.TeleportPly then
			repeat
				Tween(Plrs[_G.SelectPly].Character.HumanoidRootPart.CFrame)
				task.wait()
			until _G.TeleportPly == false
		end;
		CancelTween(_G.TeleportPly)
	end)
end)
Combat:AddToggle("Auto Farm Player", false, function(value)
	_G.Auto_Kill_Ply = value;
	CancelTween(_G.Auto_Kill_Ply)
end)
spawn(function()
	while task.wait() do
		if _G.Auto_Kill_Ply then
			pcall(function()
				if _G.SelectPly ~= nil then
					if Plrs:FindFirstChild(_G.SelectPly) then
						if Plrs:FindFirstChild(_G.SelectPly).Character.Humanoid.Health > 0 then
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								Plrs:FindFirstChild(_G.SelectPly).Character.HumanoidRootPart.CanCollide = false;
								Tween(Plrs:FindFirstChild(_G.SelectPly).Character.HumanoidRootPart.CFrame * CFrame.new(0, 35, 0))
								spawn(function()
									pcall(function()
										if SelectWeaponFarm == SelectWeaponSword then
											local args = {
												[1] = Plrs:FindFirstChild(_G.SelectPly).Character.HumanoidRootPart.Position,
												[2] = Plrs:FindFirstChild(_G.SelectPly).Character.HumanoidRootPart
											}
											GetChar()[SelectWeaponMelee].RemoteFunctionShoot:InvokeServer(unpack(args))
										else
											VU:CaptureController()
											VU:Button1Down(Vector2.new(1280, 672))
										end
									end)
								end)
							until Plrs:FindFirstChild(_G.SelectPly).Character.Humanoid.Health <= 0 or not Plrs:FindFirstChild(_G.SelectPly) or not _G.Auto_Kill_Ply
						end
					end
				end
			end)
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			local MaxDistance = math.huge;
			for i, v in pairs(Plrs:GetPlayers()) do
				if v.Name ~= Lplr.Name then
					local Distance = v:DistanceFromCharacter(GetRoot().Position)
					if Distance < MaxDistance then
						MaxDistance = Distance;
						PlayerSelectAimbot = v.Name
					end
				end
			end
		end)
	end
end)
Combat:AddToggle("Aimbot Gun", false, function(value)
	_G.Aimbot_Gun = value
end)
spawn(function()
	while task.wait() do
		if _G.Aimbot_Gun and GetChar():FindFirstChild(SelectWeaponMelee) then
			pcall(function()
				GetChar()[SelectWeaponMelee].Cooldown.Value = 0;
				local args = {
					[1] = Plrs:FindFirstChild(PlayerSelectAimbot).Character.HumanoidRootPart.Position,
					[2] = Plrs:FindFirstChild(PlayerSelectAimbot).Character.HumanoidRootPart
				}
				GetChar()[SelectWeaponMelee].RemoteFunctionShoot:InvokeServer(unpack(args))
				VU:CaptureController()
				VU:Button1Down(Vector2.new(1280, 672))
			end)
		end
	end
end)
Combat:AddToggle("Aimbot Skill", false, function(value)
	_G.Aimbot_Skill = value
end)
spawn(function()
	pcall(function()
		while task.wait() do
			if _G.Aimbot_Skill and PlayerSelectAimbot ~= nil and GetChar():FindFirstChildOfClass("Tool") and GetChar()[GetChar():FindFirstChildOfClass("Tool").Name]:FindFirstChild("MousePos") then
				local args = {
					[1] = Plrs:FindFirstChild(PlayerSelectAimbot).Character.HumanoidRootPart.Position
				}
				GetChar():FindFirstChild(GetChar():FindFirstChildOfClass("Tool").Name).RemoteEvent:FireServer(unpack(args))
			end
		end
	end)
end)
Combat:AddToggle("Enabled PvP", false, function(value)
	_G.EnabledPvP = value
end)
spawn(function()
	pcall(function()
		while task.wait(.1) do
			if _G.EnabledPvP then
				if Lplr.PlayerGui.Main.PvpDisabled.Visible == true then
					RS.Remotes.CommF_:InvokeServer("EnablePvp")
				end
			end
		end
	end)
end)
Combat:AddToggle("Safe Mode", false, function(value)
	_G.Safe_Mode = value;
	CancelTween(_G.Safe_Mode)
end)
spawn(function()
	pcall(function()
		while task.wait() do
			if _G.Safe_Mode then
				GetRoot().CFrame = GetRoot().CFrame
			end
		end
	end)
end)
Combat:Button("Respawn", function()
	RS.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
	task.wait()
end)
local Current = Combat:AddLabel("Current Bounties :")
local Bounty = tostring(Lplr.leaderstats["Bounty/Honor"].Value)
local sub = string.sub;
local len = string.len;
spawn(function()
	while task.wait() do
		pcall(function()
			if len(Bounty) == 4 then
				Bounty1 = sub(Bounty, 1, 1) .. "." .. sub(Bounty, 2, 3) .. "K"
			elseif len(Bounty) == 5 then
				Bounty1 = sub(Bounty, 1, 2) .. "." .. sub(Bounty, 3, 4) .. "K"
			elseif len(Bounty) == 6 then
				Bounty1 = sub(Bounty, 1, 3) .. "." .. sub(Bounty, 4, 5) .. "K"
			elseif len(Bounty) == 7 then
				Bounty1 = sub(Bounty, 1, 1) .. "." .. sub(Bounty, 2, 3) .. "M"
			elseif len(Bounty) == 8 then
				Bounty1 = sub(Bounty, 1, 2) .. "." .. sub(Bounty, 3, 4) .. "M"
			elseif len(Bounty) <= 3 then
				Bounty1 = Bounty
			end;
			if tonumber(Bounty) == 25000000 then
				Current:Set("Current Bounties : " .. Bounty1 .. " [ Max ]")
			elseif tonumber(Bounty) < 25000000 then
				Current:Set("Current Bounties : " .. Bounty1)
			end
		end)
	end
end)
local Earn = Combat:AddLabel("Earned")
local OldBounty = Lplr.leaderstats["Bounty/Honor"].Value;
local Bounty = tostring(Lplr.leaderstats["Bounty/Honor"].Value)
local Earned = tostring(Lplr.leaderstats["Bounty/Honor"].Value - OldBounty)
local sub = string.sub;
local len = string.len;
spawn(function()
	while task.wait() do
		pcall(function()
			if len(Earned) == 4 then
				Earned1 = sub(Earned, 1, 1) .. "." .. sub(Earned, 2, 3) .. "K"
			elseif len(Earned) == 5 then
				Earned1 = sub(Earned, 1, 2) .. "." .. sub(Earned, 3, 4) .. "K"
			elseif len(Earned) == 6 then
				Earned1 = sub(Earned, 1, 3) .. "." .. sub(Earned, 4, 5) .. "K"
			elseif len(Earned) == 7 then
				Earned1 = sub(Earned, 1, 1) .. "." .. sub(Earned, 2, 3) .. "M"
			elseif len(Earned) == 8 then
				Earned1 = sub(Earned, 1, 2) .. "." .. sub(Earned, 3, 4) .. "M"
			elseif len(Earned) <= 3 then
				Earned1 = Earned
			end;
			Earn:Set("Earned : " .. tonumber(Earned1))
		end)
	end
end)
Combat:AddToggle("Auto Farm Bounty", LevelFarmQuestBounty, function(value)
	LevelFarmQuestBounty = value;
	CancelTween(LevelFarmQuestBounty)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if LevelFarmQuestBounty then
				for i, v in pairs(GetChar():GetChildren()) do
					if v:IsA("Shirt") then
						v:Destroy()
					end;
					if v:IsA("Pants") then
						v:Destroy()
					end;
					if v:IsA("Accessory") then
						v:Destroy()
					end
				end
			end
		end)
	end
end)
spawn(function()
	pcall(function()
		if LevelFarmQuestBounty then
			while task.wait() do
				if GetHum().Health > 0 then
					RS.Remotes.CommF_:InvokeServer("SetSpawnPoint")
				end
			end
		end
	end)
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if LevelFarmQuestBounty then
				if not GetChar():FindFirstChild("HasBuso") then
					RS.Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if LevelFarmQuestBounty then
				GetChar()[SelectWeaponMelee].Cooldown.Value = 0;
				spawn(function()
					Lplr.PlayerGui.Main.Beli.Visible = true;
					Lplr.PlayerGui.Main.HP.Visible = true;
					Lplr.PlayerGui.Main.Energy.Visible = true;
					Lplr.PlayerGui.Main.StatsButton.Visible = true;
					Lplr.PlayerGui.Main.ShopButton.Visible = true;
					Lplr.PlayerGui.Main.Skills.Visible = false;
					Lplr.PlayerGui.Main.Level.Visible = true;
					Lplr.PlayerGui.Main.MenuButton.Visible = true;
					Lplr.PlayerGui.Main.Code.Visible = false;
					Lplr.PlayerGui.Main.Settings.Visible = false;
					Lplr.PlayerGui.Main.Mute.Visible = false;
					Lplr.PlayerGui.Main.CrewButton.Visible = false;
					GetChar().Animate.Disabled = true
				end)
			end
		end)
	end
end)
CastlePostoMansion = CFrame.new(-5084.8447265625, 316.48101806641, -3145.3752441406)
MansiontoCastlePos = CFrame.new(-12464.596679688, 376.30590820312, -7567.2626953125)
Castletophydra = CFrame.new(-5095.33984375, 316.48101806641, -3168.3134765625)
HydratoCastle = CFrame.new(5741.869140625, 611.94750976562, -282.61154174805)
spawn(function()
	while task.wait() do
		pcall(function()
			if LevelFarmQuestBounty then
				for i, v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
					if v.Name ~= Lplr.Name then
						if v:WaitForChild("Humanoid").Health > 0 and (GetRoot().Position - v.HumanoidRootPart.Position).Magnitude <= 17000 then
							plyselecthunthelpold = v.Humanoid.Health;
							repeat
								task.wait()
								EquipTool(SelectWeaponFarm)
								NameTarget = v.Name;
								if tostring(Lplr.Team) == "Pirates" then
									Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 60, -20))
								elseif tostring(Lplr.Team) == "Marines" then
									if Plrs[NameTarget].Team ~= Lplr.Team then
									end;
									Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 60, -20))
								end;
								spawn(function()
									if (v.HumanoidRootPart.Position - GetRoot().Position).Magnitude <= 150 then
										StartCheckTarget = true
									end
								end)
								v.HumanoidRootPart.CanCollide = false;
								spawn(function()
									pcall(function()
										local args = {
											[1] = v.HumanoidRootPart.Position,
											[2] = v.HumanoidRootPart
										}
										GetChar()[SelectWeaponMelee].RemoteFunctionShoot:InvokeServer(unpack(args))
									end)
								end)
								TargetSelectHunt = v.Humanoid
							until LevelFarmQuestBounty == false or v.Humanoid.Health == 0 or not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or not v.Parent or NextplySelect == true;
							NextplySelect = false;
							StartCheckTarget = false
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	pcall(function()
		while task.wait() do
			if LevelFarmQuestBounty then
				Lplr.PlayerGui.Main.InCombat.Visible = false;
				Lplr.PlayerGui.Main.SafeZone.Visible = false
			end
		end
	end)
end)
spawn(function()
	pcall(function()
		while task.wait() do
			if LevelFarmQuestBounty then
				if TargetSelectHunt ~= nil then
					if StartCheckTarget then
						task.wait(6.5)
						if TargetSelectHunt.Health == TargetSelectHunt.MaxHealth or TargetSelectHunt.Health >= plyselecthunthelpold then
							NextplySelect = true;
							TargetSelectHunt = nil
						end
					end
				end
			end
		end
	end)
end)
spawn(function()
	pcall(function()
		while task.wait(.1) do
			if LevelFarmQuestBounty then
				if Lplr.PlayerGui.Main.PvpDisabled.Visible == true then
					RS.Remotes.CommF_:InvokeServer("EnablePvp")
				end
			end
		end
	end)
end)
Combat:AddToggle("Auto Farm Bounty Hop", LevelFarmQuestBounty_Hop, function(value)
	LevelFarmQuestBounty_Hop = value
end)
spawn(function()
	while task.wait() do
		if LevelFarmQuestBounty then
			if LevelFarmQuestBounty_Hop then
				pcall(function()
					task.wait(120)
					Hop()
				end)
			end
		end
	end
end)
Combat:Button("Next Player", function()
	NextplySelect = true;
	task.wait(.1)
	NextplySelect = false
end)
Combat:Slider("Lock Bounty", 1, 25000000, 750000, function(value)
	_G.BountyLock = value
end)
Combat:AddToggle("Start Bounty Lock", false, function(value)
	_G.StartBountyLock = value
end)
spawn(function()
	while task.wait() do
		if _G.StartBountyLock then
			pcall(function()
				if Lplr.leaderstats["Bounty/Honor"].Value >= _G.BountyLock then
					Lplr:Kick("Successfully! Bounty Farm")
				end
			end)
		end
	end
end)

local sune = Events:AddSection('','Kitsune Section','auto collect azure, teleport kitsune','rbxassetid://10709805942')
sune:AddToggle("Teleport to Kitsune Island",false,function(value)
		_G.TeleportKitsune = value
			CancelTween(_G.TeleportKitsune)
end)

spawn(function()
	while wait() do
		if _G.TeleportKitsune then
			if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
				Tween(game.Workspace.Map.KitsuneIsland.ShrineActive.NeonShrinePart.CFrame * CFrame.new(0,0,10))
			end
		end
	end
end)

sune:AddToggle("Auto Collect Azure Ember",false,function (value)
		_G.CollectAzure = value
	end
)

spawn(function()
	while wait() do
		if _G.CollectAzure then
			pcall(function()
				if game:GetService("Workspace"):FindFirstChild("AttachedAzureEmber") then
					Tween(game:GetService("Workspace"):WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
				end
			end)
		end
	end
end)


sune:AddToggle("Auto Collect Azure Ember",false,function (value)
		_G.CollectAzure = value
	end
)

spawn(function()
	while wait() do
		if _G.CollectAzure then
			pcall(function()
				if game:GetService("Workspace"):FindFirstChild("AttachedAzureEmber") then
					Tween(game:GetService("Workspace"):WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
				end
			end)
		end
	end
end)


sune:AddToggle("Auto Trade Azure",false,function (state)
		_G.TradeAureEmber = state
end)

sune:Slider("Set Amount to Trade", 0, 25, 20, function(value)
	_G.SetToTradeAureEmber = value
end)

function GetCountMaterials(MaterialName)
	local Inventory = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
	for i, v in pairs(Inventory) do
		if v.Name == MaterialName then
			return v["Count"]
		end
	end
end

spawn(function()
	while wait() do
		if _G.TradeAureEmber then
			pcall(function()
				local AzureAvilable = GetCountMaterials("Azure Ember")
				if AzureAvilable >= _G.SetToTradeAureEmber then
					game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KitsuneStatuePray")
				end
			end)
		end
	end
end)


local Seass = Events:AddSection('','Rough Sea','auto sail,auto kill shark, piranha','rbxassetid://6035078898')
spawn(function()
	pcall(function()
		while task.wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') then
				FrozenIsland:Set('✅: Frozen Dimension Spawning')
			else
				FrozenIsland:Set('❌: Frozen Dimension Not Found')
			end
		end
	end)
end)
FrozenIsland = Seass:AddLabel("")

local ListSeaBoat = {
	"Guardian",
	"PirateGrandBrigade",
	"MarineGrandBrigade",
	"PirateBrigade",
	"MarineBrigade",
	"PirateSloop",
	"MarineSloop",
	"BeastHunter",
}

local ListSeaZone = {
	"Zone 1",
	"Zone 2",
	"Zone 3",
	"Zone 4",
	"Zone 5",
	"Zone 6"
}

_G.SelectedBoat = "Guardian"
Seass:AddDropdown("Boat",ListSeaBoat,"Guardian",function(v)
_G.SelectedBoat = v
	print(v)
end)
_G.SelectedZone = "Zone 5"
Seass:AddDropdown("Zone",ListSeaZone,"Zone 5",function(v)
_G.SelectedZone = v
	print(v)
end)

Seass:Slider("Boat Tween Speed",0,500,325,function(v)
	BoatSpeed = v
	print(v)
end)


spawn(function()
	pcall(function()
		while wait() do
			if _G.SelectedZone == "Zone 1" then
				CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143, 0.120013528, 0.00690158736, 0.99274826, -0.0574118942, 0.998350561, -2.36509201e-10, -0.991110802, -0.0569955558, 0.120211802)
			elseif _G.SelectedZone == "Zone 2" then
				CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032, 0.307457417, 0.019647358, 0.951358974, -0.0637726262, 0.997964442, -4.15334017e-10, -0.949422479, -0.0606706589, 0.308084518)
			elseif _G.SelectedZone == "Zone 3" then
				CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774, 0.37637493, 0.0150483791, 0.926345229, -0.0399504974, 0.999201655, 2.70896673e-11, -0.925605655, -0.0370079502, 0.376675636)
			elseif _G.SelectedZone == "Zone 4" then
				CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012, 0.0935864747, -0.00122954219, 0.995610416, 0.0624034069, 0.998040259, -0.00463332096, -0.993653536, 0.062563099, 0.0934797972)
			elseif _G.SelectedZone == "Zone 5" then
				CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023, -0.188895494, -0.00704088295, 0.981971979, -0.0372481011, 0.999306023, -1.39882339e-09, -0.981290519, -0.0365765914, -0.189026669)
			elseif _G.SelectedZone == "Zone 6" then
				CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584, -0.0844199061, -0.00553312758, 0.9964149, -0.0654025897, 0.997858942, 2.02319411e-10, -0.99428153, -0.0651681125, -0.0846010372)
			end
		end
	end)
end)

Seass:AddToggle(
"Auto Sail Boat",
---dis = "Auto Sail Boat Sea",
false,
function(v)
_G.SailBoat = v
--CancelTween(_G.SailBoat)
	--stopboat:Stop()
	--print(v)
end
)


function CheckBoat()
    for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
        if v.Name == _G.SelectedBoat then
            for _, child in pairs(v:GetChildren()) do
                if child.Name == "MyBoatEsp" then
                    return v
                end
            end
        end
    end
    return false
end

    function CheckSeaBeast()
        if game:GetService("Workspace"):FindFirstChild("SeaBeasts") then
            for i,v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                if v:FindFirstChild("Humanoid") or v:FindFirstChild("HumanoidRootPart") or v.Health.Value < 0 then
                    return true
                end
            end
        end
        return false
    end

function AddEsp(Name, Parent)
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")

    BillboardGui.Parent = Parent
    BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    BillboardGui.Active = true
    BillboardGui.Name = Name
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 1.000
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)

    TextLabel.Parent = BillboardGui
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    spawn(function()
            while wait() do
                pcall(function()
                    wait(0.1) 
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 0, 0)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 155, 0)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 255, 0)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(0, 255, 0)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(0, 255, 255)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(0, 155, 255)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 0, 255)}
                    ):Play() 
                    wait(.5)            
                    game:GetService('TweenService'):Create(
                        TextLabel,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),
                        {TextColor3 = Color3.fromRGB(255, 0, 155)}
                    ):Play() 
                    wait(.5)
                end)
            end
        end)
    TextLabel.TextSize = 15
    TextLabel.Text = "MyBoat"
end
    
    
    spawn(function()
        while wait() do
            pcall(function()
                if _G.SailBoat then
                        if not CheckBoat() then
                            local BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781)
                            if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
                                BTP(BuyBoatCFrame)
                            else
                                buyb = Tween(BuyBoatCFrame)
                            end
                            if (CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                                if buyb then buyb:Stop() end
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
                                for i, v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                    if v.Name == _G.SelectedBoat then
                                        if (v.VehicleSeat.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                                            AddEsp('MyBoatEsp', v)
                                        end
                                    end
                                end
                            end
                        elseif CheckBoat() then
                            for i,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
                                if v.Name == _G.SelectedBoat then
                                    if v:FindFirstChild("MyBoatEsp") then
                                    if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false then
                                        if ((game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark) or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark) or (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha) or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew) or (workspace.Enemies:FindFirstChild("PirateBrigade") or workspace.Enemies:FindFirstChild("PirateGrandBrigade") or workspace.Enemies:FindFirstChild("FishBoat") and _G.RelzFishBoat) or (CheckSeaBeast() and _G.AutoSeaBest)) then
                                            if stoppos then stoppos:Stop() end
                                        else
                                            local stoppos = Tween(v.VehicleSeat.CFrame * CFrame.new(0,1,0))
                                        end
                                    else
                                        repeat wait()
                                            local stopboat = Tween(CFrameSelectedZone, v.VehicleSeat)
                                        until ((game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark) or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark) or (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha) or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew) or (workspace.Enemies:FindFirstChild("PirateBrigade") or workspace.Enemies:FindFirstChild("PirateGrandBrigade") or workspace.Enemies:FindFirstChild("FishBoat") and _G.RelzFishBoat) or (CheckSeaBeast() and _G.AutoSeaBest)) or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false or _G.SailBoat == false
                                        if stopboat then stopboat:Stop() end
                                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                                        wait(0.1)
                                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                                    end
                                    end
                                end
                            end
                        end
                end
            end)
        end
    end)

            spawn(function()
                pcall(function()
                    while wait() do
                        if _G.SailBoat then
                            if ((game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark) or (game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark) or (game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha) or (game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew) or (game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") and _G.RelzFishBoat) or (CheckSeaBeast() and _G.AutoSeaBest)) then
                                if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                                    wait(0.1)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                                end
                            end
                        end
                    end
                end)
            end)

    spawn(function()
        while wait() do
            pcall(function()
                if _G.SailBoat then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") and _G.AutoKillFishCrew then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
                                if v.Name == "Fish Crew Member" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        AutoHaki()
                                        EquipTool(SelectWeaponFarm)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        AutoClick()
                                        _G.SeaSkill = false
                                    until not _G.AutoKillFishCrew or not v.Parent or v.Humanoid.Health <= 0
                                    StartBring = false
                                    end
                                end
                            end
                        end
                    elseif workspace.Enemies:FindFirstChild("PirateBrigade") or workspace.Enemies:FindFirstChild("PirateGrandBrigade") or workspace.Enemies:FindFirstChild("FishBoat") and _G.RelzFishBoat then
                        for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if workspace.Enemies:FindFirstChild("PirateBrigade") or workspace.Enemies:FindFirstChild("PirateGrandBrigade") or workspace.Enemies:FindFirstChild("FishBoat") then
                                repeat task.wait()
                                    local BoatCFrame = v.VehicleSeat.CFrame
                                    if (BoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                                        _G.SeaSkill = true
                                    else
                                        _G.SeaSkill = false
                                    end
                                    topos(BoatCFrame * CFrame.new(0, 30, -20))
                                    Skillaimbot = true
                                    AimBotSkillPosition = BoatCFrame.Position
                                until not v.Parent or v.Health.Value < 0 or not game:GetService("Workspace").Enemies:FindFirstChild("FishBoat") or not v:FindFirstChild("Engine") or not _G.RelzFishBoat
                                Skillaimbot = false
                                _G.SeaSkill = false
                            end
                        end
                    elseif CheckSeaBeast() and _G.AutoSeaBest then
                        if game:GetService("Workspace"):FindFirstChild("SeaBeasts") then
                            for i,v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                                if CheckSeaBeast() then
                                repeat wait()
                                    CFrameSeaBeast = v.HumanoidRootPart.CFrame
                                    if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude <= 200 then
                                        _G.SeaSkill = true
                                    else
                                        _G.SeaSkill = false
                                    end
                                    Skillaimbot = true
                                    AimBotSkillPosition = v.HumanoidRootPart.CFrame.Position
                                    topos(CFrameSeaBeast * CFrame.new(0,500,0))
                                until not _G.AutoSeaBest or CheckSeaBeast() == false or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Health.Value < 0 or not v.Parent
                                Skillaimbot = false
                                _G.SeaSkill = false
                                else
                                Skillaimbot = false
                                _G.SeaSkill = false
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") and _G.AutoTerrorshark then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
                                if v.Name == "Terrorshark" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait(0.15)
                                            AutoHaki()
                                            EquipTool(SelectWeaponFarm)
                                            AutoClick()
                                            _G.SeaSkill = false
                                            topos(v.HumanoidRootPart.CFrame * CFrame.new(0, 60, 0))
                                        until not  _G.AutoTerrorshark or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Piranha") and _G.AutoKillPiranha then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if game:GetService("Workspace").Enemies:FindFirstChild("Piranha") then
                                if v.Name == "Piranha" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        AutoHaki()
                                        EquipTool(SelectWeaponFarm)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        AutoClick()
                                        _G.SeaSkill = false
                                    until not _G.AutoKillPiranha or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    elseif game:GetService("Workspace").Enemies:FindFirstChild("Shark") and _G.AutoKillShark then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if game:GetService("Workspace").Enemies:FindFirstChild("Shark") then
                                if v.Name == "Shark" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        AutoHaki()
                                        EquipTool(SelectWeaponFarm)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        AutoClick()
                                        _G.SeaSkill = false
                                    until not _G.AutoKillShark or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        end
                    else
                        Skillaimbot = false
                        _G.SeaSkill = false
                        ---UnEquipWeapon(SelectWeaponFarm)
                    end
                end
            end)
        end
    end)

Seass:AddToggle(
"Auto Farm Shark",
---dis = "Kill Shark",
false,
function(v)
_G.AutoKillShark = v
CancelTween(_G.AutoKillShark)
	print(v)
end
)

Seass:AddToggle(
"Auto Farm Piranha",
---dis = "ออโต้ตีpiranha",
false,
function(v)
_G.AutoKillPiranha = v
CancelTween(_G.AutoKillPiranha)
	print(v)
end
)


Seass:AddToggle(
"Auto Farm Ghost Ship",
---dis = "Farm Ghost Ship",
false,
function(v)
_G.RelzFishBoat = v
CancelTween(_G.RelzFishBoat)
	print(v)
end
)
if not _G.RelzFishBoat then
	_G.SeaSkill = false
	Skillaimbot = false
end



Seass:AddToggle(
"Auto Terrorshark",
---dis = "Kill Terrorshark",
false,
function(v)
_G.AutoTerrorshark = v
CancelTween(_G.AutoTerrorshark)
	print(v)
end
)



Seass:AddToggle(
"Auto Seabeast",
---dis = "Kill Sea Beast",
false,
function(v)
_G.AutoSeaBest = v
CancelTween(_G.AutoSeaBest)
	print(v)
end
)
	if not _G.AutoSeaBest then
		_G.SeaSkill = false
		Skillaimbot = false
	end


	Seass:AddToggle(
		"Set Brightness", false, function(v)
			game:GetService("Lighting").Brightness = v and 100 or 1
		end
	)
	

Seass:AddToggle(
"Speed Boat",
---dis = "Speed Boat 400",
false,
function(v)
_G.IncreaseBoatSpeed = v
	print(v)
end
)
	

		spawn(function()
			while wait() do 
				pcall(function()
					local vehicleSeats = {}
					for i, v in pairs(game.Workspace.Boats:GetDescendants()) do
						if v:IsA("VehicleSeat") then
							table.insert(vehicleSeats, v)
						end
					end
					if _G.IncreaseBoatSpeed then
						for _, v in pairs(vehicleSeats) do
							v.MaxSpeed = 350
						end
					else
						for _, v in pairs(vehicleSeats) do
							v.MaxSpeed = 150
						end
					end
				end)
			end
		end)   
Seass:AddToggle(
"Noclip Rock",
---dis = "Noclip Boat",
false,
function(v)
_G.NoClipRock = v
	print(v)
end
)
	 
		spawn(function()
			while wait() do
				pcall(function()
				for i, boat in pairs(game:GetService("Workspace").Boats:GetChildren()) do
					for _, v in pairs(game:GetService("Workspace").Boats[boat.Name]:GetDescendants()) do
						if v:IsA("BasePart") then
							if _G.NoClipRock or _G.SailBoat then
								v.CanCollide = false
							else
								v.CanCollide = true
							end
						end
					end
				end
				end)
			end
		end)
	
Seass:AddToggle(
"Auto Drive Forward",
---dis = "Drive Forward",
false,
function(v)
_G.AutoPressW = v
	print(v)
end
)
		spawn(function()
			while wait() do
				pcall(function()
					if _G.AutoPressW then
						if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
						game:GetService("VirtualInputManager"):SendKeyEvent(true,"W",false,game)
					end
					end
				end)
			end
		end)

		DoneSkillGun = false
		DoneSkillSword = false
		DoneSkillFruit = false
		DoneSkillMelee = false
		spawn(function()
			while wait() do
				pcall(function()
					if _G.SeaSkill then
						if _G.UseSeaFruitSkill and DoneSkillFruit == false then
							for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
								if v:IsA("Tool") then
									if v.ToolTip == "Blox Fruit" then
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
									end
								end
							end
						if _G.SkillFruitZ then
							game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
							wait(_G.HoldSKillC)
							game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
						end
		
						if _G.SkillFruitX then
						game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
						wait(_G.HoldSKillC)
						game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
						end
						
						if _G.SkillFruitC then
						game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
						wait(_G.HoldSKillC)
						game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
						end
		
						if _G.SkillFruitV then
						game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
						wait(_G.HoldSKillC)
						game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
						end
		
						if _G.SkillFruitF then
						game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
						wait(_G.HoldSKillC)
						game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
						end

						DoneSkillFruit = true
						end
		
						if _G.UseSeaMeleeSkill and DoneSkillMelee == false then 
							for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
								if v:IsA("Tool") then
									if v.ToolTip == "Melee" then
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
									end
								end
							end
							if _G.SkillMeleeZ then
							game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
							end
			
							if _G.SkillMeleeX then
							game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
							end
							
							if _G.SkillMeleeC then
							game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
							end
			
							if _G.SkillMeleeV then
							game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
							end

							DoneSkillMelee = true
						end

						if _G.UseSeaSwordSkill and DoneSkillSword == false then 
							for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
								if v:IsA("Tool") then
									if v.ToolTip == "Sword" then
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
									end
								end
							end
							if _G.SkillSwordZ then
							game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
							end
			
							if _G.SkillSwordX then
							game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
							wait(0)
							game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
							end

							DoneSkillSword = true
						end

						if _G.UseSeaGunSkill and DoneSkillGun == false then 
							for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
								if v:IsA("Tool") then
									if v.ToolTip == "Gun" then
										game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
									end
								end
							end
							if _G.SkillGunZ then
							game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
							wait(.1)
							game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
							end
			
							if _G.SkillGunX then
							game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
							wait(.1)
							game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
							end

							DoneSkillGun = true
						end
		
						DoneSkillGun = false
						DoneSkillSword = false
						DoneSkillFruit = false
						DoneSkillMelee = false
					end
				end)
			end
		end)

		local otherrough = Events:AddSection('','Settings Rough Sea','auto skill on melee,sword,fruit,gun','rbxassetid://6035078898')

otherrough:AddToggle(
"Use Skill Fruit",
---dis = "EquippFruit ",
true,
function(v)
_G.UseSeaFruitSkill = v
	print(v)
end
)

otherrough:AddToggle(
"Use Skill Melee",
---dis = "Use Melee",
true,
function(v)
_G.UseSeaMeleeSkill = v
	print(v)
end
)

otherrough:AddToggle(
"Use Skill Sword",
---dis = "Equipp Sword",
true,
function(v)
_G.UseSeaSwordSkill = v
	print(v)
end
)

otherrough:AddToggle(
"Use Skill Gun",
---dis = "Equipp Gun",
true,
function(v)
_G.UseSeaGunSkill = v
	print(v)
end
)


otherrough:AddLabel(
"Skill Fruit"
)

otherrough:AddToggle(
"Skill Z",
---dis = "Use Z",
true,
function(v)
_G.SkillFruitZ = v
	print(v)
end
)

otherrough:AddToggle(
"Skill X",
---dis = "Use X",
true,
function(v)
_G.SkillFruitX = v
	print(v)
end
)

otherrough:AddToggle(
"Skill C",
---dis = "Use C",
true,
function(v)
_G.SkillFruitC = v
	print(v)
end
)

otherrough:AddToggle(
"Skill V",
---dis = "Use V",
true,
function(v)
_G.SkillFruitV = v
	print(v)
end
)

otherrough:AddToggle(
"Skill F",
---dis = "Use F",
true,
function(v)
_G.SkillFruitF = v
	print(v)
end
)

otherrough:AddLabel(
"Skill Melee"
)

otherrough:AddToggle(
"Skill Z",
---dis = "Use Z",
true,
function(v)
_G.SkillMeleeZ = v
	print(v)
end
)

otherrough:AddToggle(
"Skill X",
---dis = "Use X",
true,
function(v)
_G.SkillMeleeX = v
	print(v)
end
)

otherrough:AddToggle(
"Skill C",
---dis = "Use C",
true,
function(v)
_G.SkillMeleeC = v
	print(v)
end
)

otherrough:AddToggle(
"Skill V",
---dis = "Ues V",
true,
function(v)
_G.SkillMeleeV = v
	print(v)
end
)



otherrough:AddLabel(
"Skill Sword"
)

otherrough:AddToggle(
"Skill Z",
---dis = "Use Z",
true,
function(v)
_G.SkillSwordZ = v
	print(v)
end
)

otherrough:AddToggle(
"Skill X",
---dis = "Use X",
true,
function(v)
_G.SkillSwordX = v
	print(v)
end
)

otherrough:AddLabel(
"Skill Gun"
)

otherrough:AddToggle(
"Skill Z",
---dis = "Use Z",
true,
function(v)
_G.SkillGunZ = v
	print(v)
end
)

otherrough:AddToggle(
"Skill X",
---dis = "Use X",
true,
function(v)
_G.SkillGunX = v
	print(v)
end
)



function EquipAllWeapon()
pcall(function()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA('Tool') and not (v.Name == "Summon Sea Beast" or v.Name == "Water Body" or v.Name == "Awakening") then
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name) 
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
			wait(1)
		end
	end
end)
end
spawn(function()
while wait() do
	pcall(function()
		if UseSkill then
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Kill_At / 100 then
			if _G.SkillZ then
				game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
				wait(_G.HoldSKillZ)
				game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
			end
			if _G.SkillX then
				game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
				wait(_G.HoldSKillX)
				game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
			end
			if _G.SkillC then
				game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
				wait(_G.HoldSKillC)
				game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
			end
			if _G.SkillV then
				game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
				wait(_G.HoldSKillV)
				game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
			end
			if _G.SkillF then
				game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
				wait(_G.HoldSKillF)
				game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
			end
		end
		end
		end
	end)
end
end)


spawn(function()
while wait() do
	pcall(function()
		if UseGunSkill then
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if v.Name == MonFarm and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health <= v.Humanoid.MaxHealth * _G.Kill_At / 100 then
			if _G.SkillZ then
				game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
				wait(0.5)
				game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
			end
			if _G.SkillX then
				game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
				wait(0.5)
				game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
			end
		end
		end
		end
	end)
end
end)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Main UI Components
local Statspoints = Stats:AddSection('', 'Player Stats', 'auto stats melee, sword, fruit, gun', 'rbxassetid://6022668882')
local Pointstat = Statspoints:AddLabel("Stat Points")

-- Initialize PointStats with a default value
local PointStats = 1

-- Update Pointstat label with player's points
spawn(function()
    while wait() do
        pcall(function()
            Pointstat:Set("Stat Points: " .. tostring(game.Players.LocalPlayer.Data.Points.Value))
        end)
    end
end)

-- Toggle options for each stat
local melee, defense, sword, gun, demonfruit = false, false, false, false, false

Statspoints:AddToggle("Melee", false, function(v)
    melee = v
    print("Melee:", v)
end)

Statspoints:AddToggle("Defense", false, function(v)
    defense = v
    print("Defense:", v)
end)

Statspoints:AddToggle("Sword", false, function(v)
    sword = v
    print("Sword:", v)
end)

Statspoints:AddToggle("Gun", false, function(v)
    gun = v
    print("Gun:", v)
end)

Statspoints:AddToggle("Devil Fruit", false, function(v)
    demonfruit = v
    print("Devil Fruit:", v)
end)

-- Slider for setting points
Statspoints:Slider("Point", 0, 100, PointStats, function(v)
    PointStats = v
    print("Points to allocate:", v)
end)

-- Allocate points based on player stats
spawn(function()
    while wait() do
        if game.Players.LocalPlayer.Data.Points.Value >= PointStats then
            if melee then
                local args = {"AddPoint", "Melee", PointStats}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if defense then
                local args = {"AddPoint", "Defense", PointStats}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if sword then
                local args = {"AddPoint", "Sword", PointStats}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if gun then
                local args = {"AddPoint", "Gun", PointStats}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
            if demonfruit then
                local args = {"AddPoint", "Devil Fruit", PointStats}
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    end
end)

spawn(function()
		while wait() do
			if game.Players.localPlayer.Data.Points.Value >= PointStats then
				if melee then
					local args = {
						[1] = "AddPoint",
						[2] = "Melee",
						[3] = PointStats
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end 
				if defense then
					local args = {
						[1] = "AddPoint",
						[2] = "Defense",
						[3] = PointStats
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end 
				if sword then
					local args = {
						[1] = "AddPoint",
						[2] = "Sword",
						[3] = PointStats
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end 
				if gun then
					local args = {
						[1] = "AddPoint",
						[2] = "Gun",
						[3] = PointStats
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end 
				if demonfruit then
					local args = {
						[1] = "AddPoint",
						[2] = "Demon Fruit",
						[3] = PointStats
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
	end)

	local DojoQuest = dragons:AddSection("","Dragon Hunter","auto dojo auto collect blaze amber","rbxassetid://105643281470017")

--// Boats Body Velocity
spawn(function()
    while task.wait() do
        pcall(function()
            if DojoQuestEnable then
                game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(100000,100000,100000)
                game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.Velocity = Vector3.new(0,0,0)
            else
                game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
                game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.BodyVelocity.Velocity = Vector3.new(0,0,0)
            end
        end)
    end
end)

--// Boat Tween Anchor
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if DojoQuestEnable then
                if game:GetService("Workspace").Boats:FindFirstChild('PirateBrigade') then
                    for _,v in pairs(game:GetService("Workspace").Boats.PirateBrigade:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false
                        end
                    end
                end
            end
        end)
    end)
end)

function getAcc(BeltName)
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v) == "table" then
			if v.Type == "Wear" then
				if v.Name == BeltName then
					return true
				end
			end
		end
	end
	return false
end

--// CANCEL TWEEN BOATS
function StopBoats(target)
    if not target then
        _G.StopTweenBoat = true
        wait(.1)
        TPB(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame)
        wait(.1)
        _G.StopTweenBoat = false
    end
end

local DojoQuestNpc = CFrame.new(5855.19629, 1208.32178, 872.713501, 0.606994748, -1.81058823e-09, -0.794705868, 5.72712722e-09, 1, 2.09605577e-09, 0.794705868, -5.82367621e-09, 0.606994748)

local DojoProgessCheck = DojoQuest:AddLabel('Status: Waiting to get quest...')
local DojoInfoCheck = DojoQuest:AddLabel('')

--[[task.spawn(function()
    while wait() do
        if getAcc("Dojo Belt (White)") == false and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (White)")
            DojoInfoCheck:Refresh("Kill 20 NPC on Quest")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Yellow)")
            DojoInfoCheck:Refresh("Kill 5 Shark/Piranha/Fishcrew Member")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Orange)")
            DojoInfoCheck:Refresh("Complete 1 Trade with another Player")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Green)")
            DojoInfoCheck:Refresh("Travel to Sea Danger Level 4-6 \n and stay there for 5 minutes.")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (true)") == false and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Blue)")
            DojoInfoCheck:Refresh("Collect a fruit dropped by another player")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Purple)")
            DojoInfoCheck:Refresh("Kill 3 Elite Pirates")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == true and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Red)")
            DojoInfoCheck:Refresh("Defeat a Terrorshark or Rumbling Waters Sea Event.")

        elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == true and getAcc("Dojo Belt (Red)") == true and getAcc("Dojo Belt (Black)") == false then
            DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Black)")
            DojoInfoCheck:Refresh("Complete Prehistoric Island event \n and collect 3 Dinosaur bones")

        end
    end
end)]]
DojoQuest:AddToggle('Request Dojo Trainer Quest', DojoRequestQuest, function(Value)
    DojoRequestQuest = Value
    CancelTween(DojoRequestQuest)
end)
spawn(function()
    while task.wait() do
        if DojoRequestQuest then
            pcall(function()
                if ByPassTP then
                    BTP(DojoQuestNpc)
                elseif not ByPassTP then
                    Tween(DojoQuestNpc)
                end
            
                if (DojoQuestNpc.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    local ohTable1 = {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "RequestQuest"
                    }
                    
                    game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)

                    wait(1)

                    if getAcc("Dojo Belt (White)") == false and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (White)")
                        DojoInfoCheck:Refresh("Kill 20 NPC on Quest")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Yellow)")
                        DojoInfoCheck:Refresh("Kill 5 Shark/Piranha/Fishcrew Member")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Orange)")
                        DojoInfoCheck:Refresh("Complete 1 Trade with another Player")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Green)")
                        DojoInfoCheck:Refresh("Travel to Sea Danger Level 4-6 \n and stay there for 5 minutes.")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Blue)")
                        DojoInfoCheck:Refresh("Collect a fruit dropped by another player")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Purple)")
                        DojoInfoCheck:Refresh("Kill 3 Elite Pirates")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == true and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Red)")
                        DojoInfoCheck:Refresh("Defeat a Terrorshark or Rumbling Waters Sea Event.")
            
                    elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == true and getAcc("Dojo Belt (Red)") == true and getAcc("Dojo Belt (Black)") == false then
                        DojoProgessCheck:Refresh("Dojo Progress : Get Dojo Belt (Black)")
                        DojoInfoCheck:Refresh("Complete Prehistoric Island event \n and collect 3 Dinosaur bones")
            
                    end
                end
            end)
        end
    end
end)

DojoQuest:AddToggle('Claim Dojo Trainer Quest', DojoClaimQuest, function(Value)
    DojoClaimQuest = Value
    CancelTween(DojoClaimQuest)
end)
spawn(function()
    while task.wait() do
        if DojoClaimQuest then
            pcall(function()
                if ByPassTP then
                    BTP(DojoQuestNpc)
                elseif not ByPassTP then
                    Tween(DojoQuestNpc)
                end
            
                if (DojoQuestNpc.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                    local ohTable1 = {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "ClaimQuest"
                    }
                    
                    game:GetService("ReplicatedStorage").Modules.Net["RF/InteractDragonQuest"]:InvokeServer(ohTable1)
                end

            end)
        end
    end
end)

DojoQuest:AddToggle("Start Dojo Trainer Quest", DojoQuestEnable, function(Value)
    DojoQuestEnable = Value
    StopBoats(DojoQuestEnable)
    CancelTween(DojoQuestEnable)
end)

spawn(function()
    while task.wait() do
        if DojoQuestEnable then
             
            pcall(function()
                
                if getAcc("Dojo Belt (White)") == false and getAcc("Dojo Belt (Yellow)") == false and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then
                    
                    CheckLevel()
                    if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                        if ByPassTP then
                            BTP(CFrameQ)
                        elseif not ByPassTP then
                            Tween(CFrameQ)
                        end
                        if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        end

                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    if v.Name == Ms then
                                        repeat game:GetService("RunService").Heartbeat:wait()
                                            EquipTool(SelectWeapon)
                                            Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            Dojo_Farm_Name = v.Name
                                            Dojo_Farm_CFrame = v.HumanoidRootPart.CFrame
                                        until not DojoQuestEnable or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    end
                                end
                            end
                        else
                            Tween(CFrameMon)
                        end
                    end

                elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == false and getAcc("Dojo Belt (Green)") == false and getAcc("Dojo Belt (Blue)") == false and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then

                    Tween(CFrame.new(-12575.7666, 336.955719, -7556.80029, 0.0528766066, -7.96442023e-08, -0.998601079, 2.11768718e-08, 1, -7.86344501e-08, 0.998601079, -1.69893237e-08, 0.0528766066))

                elseif getAcc("Dojo Belt (White)") == true and getAcc("Dojo Belt (Yellow)") == true and getAcc("Dojo Belt (Orange)") == true and getAcc("Dojo Belt (Green)") == true and getAcc("Dojo Belt (Blue)") == true and getAcc("Dojo Belt (Purple)") == false and getAcc("Dojo Belt (Red)") == false and getAcc("Dojo Belt (Black)") == false then

                    if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                if v.Name == "Diablo" or v.Name == "Deandre" or v.Name == "Urban" then
                                    repeat game:GetService("RunService").Heartbeat:wait()
                                        EquipTool(SelectWeapon)
                                        Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                        v.HumanoidRootPart.Transparency = 1
                                    until DojoQuestEnable == false or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        end
                    else
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                            if ByPassTP then
                                BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                            else
                                Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame)
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                            if ByPassTP then
                                BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                            else
                                Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame)
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                            if ByPassTP then
                                BTP(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                            else
                                Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame)
                            end
                        end
                    end
                    
                end
            end)
        end
    end
end)

DojoQuest:AddToggle("Auto Kill Ghost/Hydra/Venomous", BlazeEmberFarm, function(Value)
    BlazeEmberFarm = Value
    CancelTween(BlazeEmberFarm)
end)
spawn(function()
    while task.wait() do
        if BlazeEmberFarm then
            pcall(function()
                if game:GetService('Workspace').Enemies:FindFirstChild('Ghost') or game:GetService('Workspace').Enemies:FindFirstChild('Hydra Enforcer') or game:GetService('Workspace').Enemies:FindFirstChild('Venomous Assailant') then
                    for i,v in pairs(game:GetService('Workspace').Enemies:GetChildren()) do
                        if v.Name == 'Ghost' or v.Name == 'Hydra Enforcer' or v.Name == 'Venomous Assailant' then
                            if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 then
                                repeat game:GetService("RunService").Heartbeat:wait()
                                    
                                    EquipTool(SelectWeapon)
                                    Tween(v.HumanoidRootPart.CFrame * Farm_Mode)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.Transparency = 1
                                    BlazeEmber_Farm_Name = v.Name
                                    BlazeEmber_Farm_CFrame = v.HumanoidRootPart.CFrame
                                   
                                until not BlazeEmberFarm or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
                            end
                        end
                    end
                else
                    Tween(CFrame.new(5394.36475, 1082.71057, 561.993958, -0.62453711, 3.17826405e-08, -0.780995131, 6.77530991e-08, 1, -1.34849545e-08, 0.780995131, -6.13366922e-08, -0.62453711))
                end
            end)
        end
    end
end)

DojoQuest:AddToggle("Auto Collect Blaze Ember", ColectBlazeEmber, function(Value)
    ColectBlazeEmber = Value
end)

spawn(function()
    while task.wait() do
        if ColectBlazeEmber then
            pcall(function()
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v.Name == 'EmberTemplate' then
                        v.Part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end
end)

DojoQuest:Button('Teleport to Dragon Hunter', function()
    Tween(CFrame.new(5865.80811, 1209.50269, 811.746582, -0.675207436, -6.76664627e-08, 0.737627923, 8.33632186e-09, 1, 9.93661047e-08, -0.737627923, 7.32418357e-08, -0.675207436))
end)

DojoQuest:Button('Teleport to Dragon Wizard', function()
    Tween(CFrame.new(5775.35059, 1209.50269, 805.679993, -0.696588516, -7.57756808e-08, 0.717470825, -7.6549334e-08, 1, 3.12936663e-08, -0.717470825, -3.31231078e-08, -0.696588516))
end)

local race1 = Racev4:AddSection('','Races','auto compplte race quest/teleport','rbxassetid://14477517268')



-- Define the teleport locations
local Islandplace = {
    "Top Of GreatTree",
    "Temple Of Time",
    "Lever Pull",
    "Ancient One",
    "Cyborg Door",
    "Fish Door",
    "Ghoul Door",
    "Human Door",
    "Mink Door",
    "Sky Door"
}

-- Variable to store the selected place
_G.SelectIslandRace = nil

-- Dropdown for selecting teleport location
race1:AddDropdown("Select Place", Islandplace, "", function(selectedPlace)
    _G.SelectIslandRace = selectedPlace
end)

-- Button to activate teleport
race1:Button("Teleport", function()
    local teleportPositions = {
        ["Top Of GreatTree"] = CFrame.new(2947.56, 2281.63, -7213.55),
        ["Temple Of Time"] = CFrame.new(28286.36, 14895.30, 102.62),
        ["Lever Pull"] = CFrame.new(28575.18, 14936.63, 72.32),
        ["Ancient One"] = CFrame.new(28981.55, 14888.43, -120.25),
        ["Cyborg Door"] = CFrame.new(28492.41, 14894.43, -422.11),
        ["Fish Door"] = CFrame.new(28224.06, 14889.43, -210.59),
        ["Ghoul Door"] = CFrame.new(28672.72, 14889.13, 454.60),
        ["Human Door"] = CFrame.new(29237.29, 14889.43, -206.95),
        ["Mink Door"] = CFrame.new(29020.66, 14889.43, -379.27),
        ["Sky Door"] = CFrame.new(28967.41, 14918.08, 234.31)
    }

    -- Check if a place is selected and teleport
    if _G.SelectIslandRace then
        Tween(teleportPositions[_G.SelectIslandRace])
    else
        print("Please select a place to teleport.")
    end
end)

-- Other functionalities remain unchanged...

-- Remove Clock Access
race1:AddToggle("Clock Access",false ,function()
    local temple = game:GetService("Workspace").Map["Temple of Time"]
    temple.DoNotEnter:Remove()
    temple.ClockRoomExit:Remove()
end)

-- Auto Buy Gear Toggle
race1:AddToggle("Auto Buy Gear", false, function(v)
    _G.Auto_Farm_Bone4 = v
    print(v)
end)

-- Auto Look Moon Toggle
race1:AddToggle("Auto Look Moon", false, function(v)
    _G.AutoDooHee = v
    print(v)
end)

-- Auto Active Race v3 Toggle
race1:AddToggle("Auto Active Race v3", false, function(v)
    _G.AutoAgility = v
    print(v)
end)

-- Auto Ancient One Quest Toggle
race1:AddToggle("Auto Ancient One Quest", false, function(v)
    _G.AutoRace = v
    StardFarm = v
    CancelTween(_G.AutoRace)
    print(v)
end)

-- Auto Kill Player Toggle
race1:AddToggle("Auto Kill Player", false, function(v)
    _G.AutoKillTial = v
    CancelTween(_G.AutoKillTial)
    print(v)
end)

-- Helper Functions for Auto-Farming
local function farmEnemies()
    if StardFarm and World3 then
        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if enemy.Name == "Cocoa Warrior" or enemy.Name == "Chocolate Bar Battler" or 
               enemy.Name == "Sweet Thief" or enemy.Name == "Candy Rebel" then
                if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                    repeat
                        task.wait()
                        AutoHaki()
                        EquipTool(SelectWeaponFarm)
                        enemy.HumanoidRootPart.CanCollide = false
                        enemy.Humanoid.WalkSpeed = 0
                        enemy.Head.CanCollide = false
                        StartBring = true
                        PosMon = enemy.HumanoidRootPart.CFrame
                        MonFarm = enemy.Name
                        Tween(enemy.HumanoidRootPart.CFrame * Farm_Mode)
                        AutoClick()
                    until not StardFarm or not enemy.Parent or enemy.Humanoid.Health <= 0
                    StartBring = false
                end
            end
        end
    end
end

spawn(function()
    while wait() do
        if _G.AutoRace then
            local player = game.Players.LocalPlayer
            if player.Character.RaceTransformed.Value then
                StardFarm = false
                Tween(CFrame.new(216.21, 126.94, -12599.07))
            else
                StardFarm = true
            end
        end
    end
end)

spawn(function()
    while wait() do
        if _G.AutoQuestRace then
            local playerRace = game:GetService("Players").LocalPlayer.Data.Race.Value
            if playerRace == "Human" then
                for _, enemy in pairs(game.Workspace.Enemies:GetDescendants()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                        repeat
                            wait(0.1)
                            enemy.Humanoid.Health = 0
                            enemy.HumanoidRootPart.CanCollide = false
                        until not _G.AutoQuestRace or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            elseif playerRace == "Skypiea" then
                -- Handle Skypiea logic here
            elseif playerRace == "Fishman" then
                -- Handle Fishman logic here
            elseif playerRace == "Cyborg" then
                Tween(CFrame.new(28654, 14898.78, -30))
            elseif playerRace == "Ghoul" then
                -- Handle Ghoul logic here
            elseif playerRace == "Mink" then
                -- Handle Mink logic here
            end
        end
    end
end)

-- Trial Completion Buttons
race1:Button("Complete Angel Trial", function()
    Tween(game.Workspace.Map.SkyTrial.Model.FinishPart.CFrame)
end)

race1:Button("Complete Rabit Trial", function()
    Tween(game:GetService("Workspace").Map.MinkTrial.Ceiling.CFrame * CFrame.new(0, -5, 0))
end)

race1:Button("Complete Cyborg Trial", function()
    Tween(CFrame.new(0, 300, 0))
end)


spawn(function()
    while wait() do
        if _G.AutoKillTial then
            for _, player in pairs(game:GetService("Players"):GetChildren()) do
                if player.Name ~= game.Players.LocalPlayer.Name and 
                   (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                    if player.Character.Humanoid.Health > 0 then
                        repeat
                            wait()
                            EquipTool(SelectWeaponFarm)
									Tween(player.HumanoidRootPart.CFrame * Farm_Mode)
									player.HumanoidRootPart.CanCollide = false;
									player.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
									player.HumanoidRootPart.Transparency = 1;
									player.Humanoid:ChangeState(11)
									player.Humanoid:ChangeState(14)
                        until not _G.AutoKillTial or not player.Parent or player.Humanoid.Health <= 0
                    end
                end
            end
        end
    end
end)

-- Skill Usage Logic
spawn(function()
    while wait() do
        if UseskillKill then
            for _, key in pairs({"Z", "X", "C", "V"}) do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game)
                wait(0.1)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game)
            end
        end
    end
end)


local Raids = Tab_4:AddSection('','Dungeon Raid','auto raid, auto awake, auto buy chip','rbxassetid://10734932295')
local Chips = {
	"Flame",
	"Ice",
	"Quake",
	"Light",
	"Dark",
	"Spider",
	"Rumble",
	"Magma",
	"Buddha",
	"Sand",
	"Phoenix",
	"Dough"
}


Raids:AddDropdown("Select Chips", Chips, "", function(Value)
	SelectChip = Value
end)


Raids:AddToggle("Auto Buy Microchips", AutoBuySpecialChip, function(Value)
	AutoBuySpecialChip = Value
end)
spawn(function()
	while task.wait() do
		if AutoBuySpecialChip then
			if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") or not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", SelectChip)
			end
		end
	end
end)



Raids:AddToggle("Auto Start Raids", AutoSTartRaids, function(Value)
	AutoSTartRaids = Value
end)
spawn(function()
	while task.wait() do
		if AutoSTartRaids then
			if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") then
				if Second_Sea then
					fireclickdetector(game.Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
				elseif Third_Sea then
					local plr = game:GetService("Players").LocalPlayer
					local RaidLab = CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469)
					if (RaidLab.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 10 then
						Tween(RaidLab)
					elseif (RaidLab.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10 then
						wait(1)
						fireclickdetector(game.Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
					end
				end
			end
		end
	end
end)

Raids:AddToggle('Kill Raid Aura', RaidAura, function(Value)
	RaidAura = Value
end)
spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		if RaidAura then
			local RegisterAttack = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterAttack"]
			local RegisterHit = game:GetService("ReplicatedStorage").Modules.Net["RE/RegisterHit"]
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetDescendants()) do
						if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							if v.Name then
								repeat
									game:GetService("RunService").Heartbeat:wait()
									EquipTool(SelectWeaponRaid)
									v.Humanoid.Health = 0
									v.HumanoidRootPart.CanCollide = false
									sethiddenproperty(game:GetService('Players').LocalPlayer, "SimulationRadius", math.huge)
								until not RaidAura or not v.Parent or not game.Workspace.Enemies:FindFirstChild(v.Name)
							end
						end
					end
				end)
			end
		end
	end)
end)

Raids:AddToggle('Auto Next Island', AutoNextIsland, function(Value)
	AutoNextIsland = Value
	CancelTween(AutoNextIsland)
end)
spawn(function()
	while wait() do
		if AutoNextIsland then
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible == true then
				if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
					if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
						Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame * CFrame.new(0, DisRaid, 0))
					end
				elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
					if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
						Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame * CFrame.new(0, DisRaid, 0))
					end
				elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
					if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
						Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame * CFrame.new(0, DisRaid, 0))
					end
				elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
					if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
						Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame * CFrame.new(0, DisRaid, 0))
					end
				elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
					if (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
						Tween(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame * CFrame.new(0, DisRaid, 0))
					end
				end
			end
		end
	end
end)

Raids:AddToggle('Auto Awaken', AutoAwakenAbilities, function(Value)
	AutoAwakenAbilities = Value
end)
spawn(function()
	while wait() do
		if AutoAwakenAbilities then
			local args1 = {
				[1] = "Awakener",
				[2] = "Check"
			}
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))
			local args2 = {
				[1] = "Awakener",
				[2] = "Awaken"
			}
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args2))
		end
	end
end)


Raids:Button("Teleport to Raid Lab", function()
    if Second_Sea then
        Tween(CFrame.new(-6449.68896, 249.56958, -4497.59326, 0.69785428, 5.60444446e-09, -0.71623975, -2.18662333e-09, 1, 5.69432235e-09, 0.71623975, -2.40766074e-09, 0.69785428))
    elseif Third_Sea then
        Tween(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
    end
end)

Raids:Slider("Set low price Fruit",0,1000000,5000,function(Value)
	_G.UnstoreFruitPrice = Value
end)

Raids:AddToggle("Auto Unstore Fruit", false,function(Value)
_G.UnstoreBadFruit = Value
end)


function HasFruits()
local function CheckContainer(container)
	for _, v in pairs(container:GetChildren()) do
		if string.find(v.Name, "Fruit") then
			return true
		end
	end
	return false
end
local plyr = game:GetService("Players").LocalPlayer
return CheckContainer(plyr.Backpack) or CheckContainer(plyr.Character)
end

spawn(function()
while wait() do
	pcall(function()
		if getgenv().UnstoreBadFruit then
			local fruits = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryFruits")
			for _, v in pairs(fruits) do
				if v["Price"] < getgenv().UnstoreFruitPrice then
					if not HasFruits() then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", v["Name"])
					end
				end
			end
		end
	end)
end
end)
local Law_Raids = Tab_4:AddSection('','Law Raid','auto law Raid,auto buy chip','rbxassetid://10709753149')
local WeaponLaw = {}
for i, v in pairs(Lplr.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(WeaponLaw, v.Name)
	end
end;
local SelectWeaponLaw = Law_Raids:AddDropdown("Select Weapon Law", WeaponLaw, "",function(Value)
	Select_Weapon_Law_Raid = Value
end)
Law_Raids:Button('Refresh Weapon Law', function()
	local WeaponLaw = {}
for i, v in pairs(Lplr.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(v.Name)
	end
end;
Select_Weapon_Law_Raid:Clear()

for i, v in pairs(Lplr.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		Select_Weapon_Law_Raid:Add(WeaponLaw, v.Name)
	end
end;
end)
Law_Raids:AddToggle("Buy Law Chips", Auto_Buy_Law_Chip, function(Value)
	Auto_Buy_Law_Chip = Value
end)
spawn(function()
	while task.wait() do
		if Auto_Buy_Law_Chip then
			if Lplr.Backpack:FindFirstChild("Microchip") or GetChar():FindFirstChild("Microchip") or game:GetService("Workspace").Enemies:FindFirstChild("Order") or RS:FindFirstChild("Order") then
			else
				local args = {
					[1] = "BlackbeardReward",
					[2] = "Microchip",
					[3] = "2"
				}
				RS.Remotes.CommF_:InvokeServer(unpack(args))
			end
		end
	end
end)
Law_Raids:AddToggle("Start Law Raid", Auto_Start_Law_Dungeon, function(Value)
	Auto_Start_Law_Dungeon = Value
end)
spawn(function()
	while task.wait() do
		if Auto_Start_Law_Dungeon then
			pcall(function()
				if GetChar():FindFirstChild("Microchip") or Lplr.Backpack:FindFirstChild("Microchip") then
					fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				end
			end)
		end
	end
end)
Law_Raids:AddToggle('Auto Kill Law Raid', BossRaid, function(Value)
	BossRaid = Value;
	CancelTween(BossRaid)
end)
spawn(function()
	while task.wait() do
		if BossRaid then
			pcall(function()
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v.Name == "Order" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						repeat
							task.wait()
							EquipTool(Select_Weapon_Law_Raid)
							v.HumanoidRootPart.CanCollide = false;
							v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
							Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							VU:CaptureController()
							VU:Button1Down(Vector2.new(1280, 672))
						until not BossRaid or v.Humanoid.Health <= 0 or not v.Parent
					end
				end;
				for i, v in pairs(RS:GetChildren()) do
					if v.Name == "Order" then
						Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
					end
				end
			end)
		end
	end
end)



local TeleportStatus_Left = Tab_5:AddSection('','Island Travel','travel any islands on every sea','rbxassetid://6034407069')
TeleportStatus_Left:Button("Travel to First Sea", function()
	RS.Remotes.CommF_:InvokeServer("TravelMain")
end)
TeleportStatus_Left:Button("Travel to Second Sea", function()
	RS.Remotes.CommF_:InvokeServer("TravelDressrosa")
end)
TeleportStatus_Left:Button("Travel to Third Sea", function()
	RS.Remotes.CommF_:InvokeServer("TravelZou")
end)
if First_Sea then
	IslandCheck = {
		"Start Island";
		"Marine Start";
		"Middle Town";
		"Jungle";
		"Pirate Village";
		"Desert";
		"Frozen Village";
		"Marine Ford";
		"Colosseum 1";
		"Sky island 1";
		"Sky island 2";
		"Sky island 3";
		"Sky island 4";
		"Prison";
		"Magma Village";
		"UndeyWater City";
		"Fountain City";
		"House Cyborgs";
		"Shanks Room";
		"Mob Island";
		"Sea Beast"
	}
elseif Second_Sea then
	IslandCheck = {
		"Dock";
		"Kingdom of Rose";
		"Mansion 1";
		"Flamingo Room";
		"Green Zone";
		"Cafe";
		"Factory";
		"Colosseum 2";
		"Grave Island";
		"Snow Mountain";
		"Cold Island";
		"Hot Island";
		"Cursed Ship";
		"Ice Castle";
		"Forgotten Island";
		"Usoapp Island";
		"Minisky Island";
		"Sea Beast"
	}
elseif Third_Sea then
	IslandCheck = {
		"Port Town";
		"Hydra Island";
		"Great Tree";
		"Castle on the Sea";
		"Floating Turtle";
		"Mansion 2";
		"Secret Temple";
		"Friendly Arena";
		"Beautiful Pirate Domain";
		"Teler Park";
		"Peanut Island";
		"Chocolate Island";
		"Ice Cream Island";
		"Haunted Castle";
		"Cake Loaf";
		"Candy Cane";
		"Tiki Outpost";
		"Raid Lab";
		"Mini Sky";
		"Sea Beast"
	}
end;
TeleportStatus_Left:AddDropdown("Select Island", IslandCheck, "",function(Value)
	SelectedIsland = Value
end)
TeleportStatus_Left:Button("Teleport to Island", function()
	if SelectedIsland == "Start Island" then
		if BypassTeleport then
			BTP(CFrame.new(1071.2832, 16.3085976, 1426.86792))
		else
			Tween(CFrame.new(1071.2832, 16.3085976, 1426.86792))
		end
	elseif SelectedIsland == "Marine Start" then
		if BypassTeleport then
			BTP(CFrame.new(-2573.3374, 6.88881969, 2046.99817))
		else
			Tween(CFrame.new(-2573.3374, 6.88881969, 2046.99817))
		end
	elseif SelectedIsland == "Middle Town" then
		if BypassTeleport then
			BTP(CFrame.new(-655.824158, 7.88708115, 1436.67908))
		else
			Tween(CFrame.new(-655.824158, 7.88708115, 1436.67908))
		end
	elseif SelectedIsland == "Jungle" then
		if BypassTeleport then
			BTP(CFrame.new(-1249.77222, 11.8870859, 341.356476))
		else
			Tween(CFrame.new(-1249.77222, 11.8870859, 341.356476))
		end
	elseif SelectedIsland == "Pirate Village" then
		if BypassTeleport then
			BTP(CFrame.new(-1122.34998, 4.78708982, 3855.91992))
		else
			Tween(CFrame.new(-1122.34998, 4.78708982, 3855.91992))
		end
	elseif SelectedIsland == "Desert" then
		if BypassTeleport then
			BTP(CFrame.new(1094.14587, 6.47350502, 4192.88721))
		else
			Tween(CFrame.new(1094.14587, 6.47350502, 4192.88721))
		end
	elseif SelectedIsland == "Frozen Village" then
		if BypassTeleport then
			BTP(CFrame.new(1198.00928, 27.0074959, -1211.73376))
		else
			Tween(CFrame.new(1198.00928, 27.0074959, -1211.73376))
		end
	elseif SelectedIsland == "Marine Ford" then
		if BypassTeleport then
			BTP(CFrame.new(-4505.375, 20.687294, 4260.55908))
		else
			Tween(CFrame.new(-4505.375, 20.687294, 4260.55908))
		end
	elseif SelectedIsland == "Colosseum 1" then
		if BypassTeleport then
			BTP(CFrame.new(-1428.35474, 7.38933945, -3014.37305))
		else
			Tween(CFrame.new(-1428.35474, 7.38933945, -3014.37305))
		end
	elseif SelectedIsland == "Sky island 1" then
		if BypassTeleport then
			BTP(CFrame.new(-4970.21875, 717.707275, -2622.35449))
		else
			Tween(CFrame.new(-4970.21875, 717.707275, -2622.35449))
		end
	elseif SelectedIsland == "Sky island 2" then
		if BypassTeleport then
			BTP(CFrame.new(-4813.0249, 903.708557, -1912.69055))
		else
			Tween(CFrame.new(-4813.0249, 903.708557, -1912.69055))
		end
	elseif SelectedIsland == "Sky island 3" then
		if BypassTeleport then
			BTP(CFrame.new(-7952.31006, 5545.52832, -320.704956))
		else
			Tween(CFrame.new(-7952.31006, 5545.52832, -320.704956))
		end
	elseif SelectedIsland == "Sky island 4" then
		if BypassTeleport then
			BTP(CFrame.new(-7793.43896, 5607.22168, -2016.58362))
		else
			Tween(CFrame.new(-7793.43896, 5607.22168, -2016.58362))
		end
	elseif SelectedIsland == "Prison" then
		if BypassTeleport then
			BTP(CFrame.new(4854.16455, 5.68742752, 740.194641))
		else
			Tween(CFrame.new(4854.16455, 5.68742752, 740.194641))
		end
	elseif SelectedIsland == "Magma Village" then
		if BypassTeleport then
			BTP(CFrame.new(-5231.75879, 8.61593437, 8467.87695))
		else
			Tween(CFrame.new(-5231.75879, 8.61593437, 8467.87695))
		end
	elseif SelectedIsland == "UndeyWater City" then
		if BypassTeleport then
			BTP(CFrame.new(61163.8516, 11.7796879, 1819.78418))
		else
			Tween(CFrame.new(61163.8516, 11.7796879, 1819.78418))
		end
	elseif SelectedIsland == "Fountain City" then
		if BypassTeleport then
			TP2(CFrame.new(5132.7124, 4.53632832, 4037.8562))
		else
			Tween(CFrame.new(5132.7124, 4.53632832, 4037.8562))
		end
	elseif SelectedIsland == "House Cyborgs" then
		if BypassTeleport then
			BTP(CFrame.new(6262.72559, 71.3003616, 3998.23047))
		else
			Tween(CFrame.new(6262.72559, 71.3003616, 3998.23047))
		end
	elseif SelectedIsland == "Shanks Room" then
		if BypassTeleport then
			BTP(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
		else
			Tween(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
		end
	elseif SelectedIsland == "Mob Island" then
		if BypassTeleport then
			BTP(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
		else
			Tween(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
		end
	elseif SelectedIsland == "Dock" then
		if BypassTeleport then
			BTP(CFrame.new(82.9490662, 18.0710983, 2834.98779))
		else
			Tween(CFrame.new(82.9490662, 18.0710983, 2834.98779))
		end
	elseif SelectedIsland == "Kingdom of Rose" then
		if BypassTeleport then
			BTP(CFrame.new(-394.983521, 118.503128, 1245.8446))
		else
			Tween(CFrame.new(-394.983521, 118.503128, 1245.8446))
		end
	elseif SelectedIsland == "Mansion 1" then
		if BypassTeleport then
			BTP(CFrame.new(-390.096313, 331.886475, 673.464966))
		else
			Tween(CFrame.new(-390.096313, 331.886475, 673.464966))
		end
	elseif SelectedIsland == "Flamingo Room" then
		if BypassTeleport then
			BTP(CFrame.new(2302.19019, 15.1778421, 663.811035))
		else
			Tween(CFrame.new(2302.19019, 15.1778421, 663.811035))
		end
	elseif SelectedIsland == "Green Zone" then
		if BypassTeleport then
			BTP(CFrame.new(-2372.14697, 72.9919434, -3166.51416))
		else
			Tween(CFrame.new(-2372.14697, 72.9919434, -3166.51416))
		end
	elseif SelectedIsland == "Cafe" then
		if BypassTeleport then
			BTP(CFrame.new(-385.250916, 73.0458984, 297.388397))
		else
			Tween(CFrame.new(-385.250916, 73.0458984, 297.388397))
		end
	elseif SelectedIsland == "Factory" then
		if BypassTeleport then
			BTP(CFrame.new(430.42569, 210.019623, -432.504791))
		else
			Tween(CFrame.new(430.42569, 210.019623, -432.504791))
		end
	elseif SelectedIsland == "Colosseum 2" then
		if BypassTeleport then
			BTP(CFrame.new(-1836.58191, 44.5890656, 1360.30652))
		else
			Tween(CFrame.new(-1836.58191, 44.5890656, 1360.30652))
		end
	elseif SelectedIsland == "Grave Island" then
		if BypassTeleport then
			BTP(CFrame.new(-5411.47607, 48.8234024, -721.272522))
		else
			Tween(CFrame.new(-5411.47607, 48.8234024, -721.272522))
		end
	elseif SelectedIsland == "Snow Mountain" then
		if BypassTeleport then
			BTP(CFrame.new(511.825226, 401.765198, -5380.396))
		else
			Tween(CFrame.new(511.825226, 401.765198, -5380.396))
		end
	elseif SelectedIsland == "Cold Island" then
		if BypassTeleport then
			BTP(CFrame.new(-6026.96484, 14.7461271, -5071.96338))
		else
			Tween(CFrame.new(-6026.96484, 14.7461271, -5071.96338))
		end
	elseif SelectedIsland == "Hot Island" then
		if BypassTeleport then
			BTP(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
		else
			Tween(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
		end
	elseif SelectedIsland == "Cursed Ship" then
		if BypassTeleport then
			BTP(CFrame.new(902.059143, 124.752518, 33071.8125))
		else
			Tween(CFrame.new(902.059143, 124.752518, 33071.8125))
		end
	elseif SelectedIsland == "Ice Castle" then
		if BypassTeleport then
			BTP(CFrame.new(5400.40381, 28.21698, -6236.99219))
		else
			Tween(CFrame.new(5400.40381, 28.21698, -6236.99219))
		end
	elseif SelectedIsland == "Forgotten Island" then
		if BypassTeleport then
			BTP(CFrame.new(-3043.31543, 238.881271, -10191.5791))
		else
			Tween(CFrame.new(-3043.31543, 238.881271, -10191.5791))
		end
	elseif SelectedIsland == "Usoapp Island" then
		if BypassTeleport then
			BTP(CFrame.new(4748.78857, 8.35370827, 2849.57959))
		else
			Tween(CFrame.new(4748.78857, 8.35370827, 2849.57959))
		end
	elseif SelectedIsland == "Minisky Island" then
		if BypassTeleport then
			BTP(CFrame.new(-260.358917, 49325.7031, -35259.3008))
		else
			Tween(CFrame.new(-260.358917, 49325.7031, -35259.3008))
		end
	elseif SelectedIsland == "Port Town" then
		if BypassTeleport then
			BTP(CFrame.new(-610.309692, 57.8323097, 6436.33594))
		else
			Tween(CFrame.new(-610.309692, 57.8323097, 6436.33594))
		end
	elseif SelectedIsland == "Hydra Island" then
		if BypassTeleport then
			BTP(CFrame.new(5404.4541015625, 1003.4010009765625, 506.20697021484375))
		else
			Tween(CFrame.new(5404.4541015625, 1003.4010009765625, 506.20697021484375))
		end
	elseif SelectedIsland == "Great Tree" then
		if BypassTeleport then
			BTP(CFrame.new(2174.94873, 28.7312393, -6728.83154))
		else
			Tween(CFrame.new(2174.94873, 28.7312393, -6728.83154))
		end
	elseif SelectedIsland == "Castle on the Sea" then
		if BypassTeleport then
			BTP(CFrame.new(-5477.62842, 313.794739, -2808.4585))
		else
			Tween(CFrame.new(-5477.62842, 313.794739, -2808.4585))
		end
	elseif SelectedIsland == "Floating Turtle" then
		if BypassTeleport then
			BTP(CFrame.new(-10919.2998, 331.788452, -8637.57227))
		else
			Tween(CFrame.new(-10919.2998, 331.788452, -8637.57227))
		end
	elseif SelectedIsland == "Mansion 2" then
		if BypassTeleport then
			BTP(CFrame.new(-12553.8125, 332.403961, -7621.91748))
		else
			Tween(CFrame.new(-12553.8125, 332.403961, -7621.91748))
		end
	elseif SelectedIsland == "Secret Temple" then
		if BypassTeleport then
			BTP(CFrame.new(5217.35693, 6.56511116, 1100.88159))
		else
			Tween(CFrame.new(5217.35693, 6.56511116, 1100.88159))
		end
	elseif SelectedIsland == "Friendly Arena" then
		if BypassTeleport then
			BTP(CFrame.new(5220.28955, 72.8193436, -1450.86304))
		else
			Tween(CFrame.new(5220.28955, 72.8193436, -1450.86304))
		end
	elseif SelectedIsland == "Beautiful Pirate Domain" then
		if BypassTeleport then
			BTP(CFrame.new(5310.8095703125, 21.594484329224, 129.39053344727))
		else
			Tween(CFrame.new(5310.8095703125, 21.594484329224, 129.39053344727))
		end
	elseif SelectedIsland == "Teler Park" then
		if BypassTeleport then
			BTP(CFrame.new(-9512.3623046875, 142.13258361816, 5548.845703125))
		else
			Tween(CFrame.new(-9512.3623046875, 142.13258361816, 5548.845703125))
		end
	elseif SelectedIsland == "Peanut Island" then
		if BypassTeleport then
			BTP(CFrame.new(-2142, 48, -10031))
		else
			Tween(CFrame.new(-2142, 48, -10031))
		end
	elseif SelectedIsland == "Chocolate Island" then
		if BypassTeleport then
			BTP(CFrame.new(156.896484, 30.5935211, -12662.7031, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219))
		else
			Tween(CFrame.new(156.896484, 30.5935211, -12662.7031, -0.573599219, 0, 0.81913656, 0, 1, 0, -0.81913656, 0, -0.573599219))
		end
	elseif SelectedIsland == "Ice Cream Island" then
		if BypassTeleport then
			BTP(CFrame.new(-949, 59, -10907))
		else
			Tween(CFrame.new(-949, 59, -10907))
		end
	elseif SelectedIsland == "Haunted Castle" then
		if BypassTeleport then
			BTP(CFrame.new(-9530.61035, -132.860657, 5763.13477))
		else
			Tween(CFrame.new(-9530.61035, -132.860657, 5763.13477))
		end
	elseif SelectedIsland == "Cake Loaf" then
		if BypassTeleport then
			BTP(CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574))
		else
			Tween(CFrame.new(-2099.33154, 66.9970703, -12128.585, 0.997561574, 0, 0.0697919354, 0, 1, 0, -0.0697919354, 0, 0.997561574))
		end
	elseif SelectedIsland == "Candy Cane" then
		if BypassTeleport then
			BTP(CFrame.new(-1530.97144, 13.728817, -14770.0889, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359))
		else
			Tween(CFrame.new(-1530.97144, 13.728817, -14770.0889, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359))
		end
	elseif SelectedIsland == "Tiki Outpost" then
		if BypassTeleport then
			BTP(CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566))
		else
			Tween(CFrame.new(-16548.8164, 55.6059914, -172.8125, 0.213092566, -0, -0.977032006, 0, 1, -0, 0.977032006, 0, 0.213092566))
		end
	elseif SelectedIsland == "Raid Lab" then
		if BypassTeleport then
			BTP(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
		else
			Tween(CFrame.new(-5057.146484375, 314.54132080078, -2934.7995605469))
		end
	elseif SelectedIsland == "Mini Sky" then
		if BypassTeleport then
			BTP(CFrame.new(-263.66668701172, 49325.49609375, -35260))
		else
			Tween(CFrame.new(-263.66668701172, 49325.49609375, -35260))
		end
	elseif SelectedIsland == "Sea Beast" then
		Tween(game:GetService("Workspace")["_WorldOrigin"].Locations["Sea of Treats"].CFrame)
	end
end)
TeleportStatus_Left:AddToggle("Bypass Teleport", BypassTeleport, function(Value)
	BypassTeleport = Value
end)
local TeleportStatus_Right = Tab_5:AddSection('','NPC TELEPORT','auto teleport to any npc and every sea','rbxassetid://10723396542')
if First_Sea then
	TeleportStatus_Right:AddDropdown("Select NPC", {
		"Random Devil Fruit",
		"Blox Fruits Dealer",
		"Remove Devil Fruit",
		"Ability Teacher",
		"Dark Step",
		"Electro",
		"Fishman Karate"
	}, "",function(value)
		_G.SelectNPC = value
	end)
end;
if Second_Sea then
	TeleportStatus_Right:AddDropdown("Select NPC", {
		"Dargon Berath",
		"Mtsterious Man",
		"Mysterious Scientist",
		"Awakening Expert",
		"Nerd",
		"Bar Manager",
		"Blox Fruits Dealer",
		"Trevor",
		"Enhancement Editor",
		"Pirate Recruiter",
		"Marines Recruiter",
		"Chemist",
		"Cyborg",
		"Ghoul Mark",
		"Guashiem",
		"El Admin",
		"El Rodolfo",
		"Arowe"
	}, "",function(value)
		_G.SelectNPC = value
	end)
end;
if Third_Sea then
	TeleportStatus_Right:AddDropdown("Select NPC", {
		"Blox Fruits Dealer",
		"Remove Devil Fruit",
		"Horned Man",
		"Hungey Man",
		"Previous Hero",
		"Butler",
		"Lunoven",
		"Trevor",
		"Elite Hunter",
		"Player Hunter",
		"Uzoth"
	}, "",function(value)
		_G.SelectNPC = value
	end)
end;
TeleportStatus_Right:AddToggle("Teleport", _G.TeleportNPC, "Teleport to npc selected", function(value)
	_G.TeleportNPC = value;
	if _G.TeleportNPC == true then
		repeat
			task.wait()
			if _G.SelectNPC == "Dargon Berath" then
				Tween(CFrame.new(703.372986, 186.985519, 654.522034, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Mtsterious Man" then
				Tween(CFrame.new(-2574.43335, 1627.92371, -3739.35767, 0.378697902, -9.06400288e-09, 0.92552036, -8.95582009e-09, 1, 1.34578926e-08, -0.92552036, -1.33852689e-08, 0.378697902))
			elseif _G.SelectNPC == "Mysterious Scientist" then
				Tween(CFrame.new(-6437.87793, 250.645355, -4498.92773, 0.502376854, -1.01223634e-08, -0.864648759, 2.34106086e-08, 1, 1.89508653e-09, 0.864648759, -2.11940012e-08, 0.502376854))
			elseif _G.SelectNPC == "Awakening Expert" then
				Tween(CFrame.new(-408.098846, 16.0459061, 247.432846, 0.028394036, 6.17599138e-10, 0.999596894, -5.57905944e-09, 1, -4.59372484e-10, -0.999596894, -5.56376767e-09, 0.028394036))
			elseif _G.SelectNPC == "Nerd" then
				Tween(CFrame.new(-401.783722, 73.0859299, 262.306702, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Bar Manager" then
				Tween(CFrame.new(-385.84726, 73.0458984, 316.088806, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				Tween(CFrame.new(-450.725464, 73.0458984, 355.636902, -0.780352175, -2.7266168e-08, 0.625340283, 9.78516468e-09, 1, 5.58128797e-08, -0.625340283, 4.96727601e-08, -0.780352175))
			elseif _G.SelectNPC == "Trevor" then
				Tween(CFrame.new(-341.498322, 331.886444, 643.024963, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Plokster" then
				Tween(CFrame.new(-1885.16016, 88.3838196, -1912.28723, -0.513468027, 0, 0.858108759, 0, 1, 0, -0.858108759, 0, -0.513468027))
			elseif _G.SelectNPC == "Enhancement Editor" then
				Tween(CFrame.new(-346.820221, 72.9856339, 1194.36218, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Pirate Recruiter" then
				Tween(CFrame.new(-428.072998, 72.9495239, 1445.32422, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Marines Recruiter" then
				Tween(CFrame.new(-1349.77295, 72.9853363, -1045.12964, 0.866493046, 0, -0.499189168, 0, 1, 0, 0.499189168, 0, 0.866493046))
			elseif _G.SelectNPC == "Chemist" then
				Tween(CFrame.new(-2777.45288, 72.9919434, -3572.25732, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Ghoul Mark" then
				Tween(CFrame.new(635.172546, 125.976357, 33219.832, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Cyborg" then
				Tween(CFrame.new(629.146851, 312.307373, -531.624146, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Guashiem" then
				Tween(CFrame.new(937.953003, 181.083359, 33277.9297, 1, -8.60126406e-08, 3.81773896e-17, 8.60126406e-08, 1, -1.89969598e-16, -3.8177373e-17, 1.89969598e-16, 1))
			elseif _G.SelectNPC == "El Admin" then
				Tween(CFrame.new(1322.80835, 126.345039, 33135.8789, 0.988783717, -8.69797603e-08, -0.149354503, 8.62223786e-08, 1, -1.15461916e-08, 0.149354503, -1.46101409e-09, 0.988783717))
			elseif _G.SelectNPC == "El Rodolfo" then
				Tween(CFrame.new(941.228699, 40.4686775, 32778.9922, -0.818029106, -1.19524382e-08, 0.575176775, -1.28741648e-08, 1, 2.47053866e-09, -0.575176775, -5.38394795e-09, -0.818029106))
			elseif _G.SelectNPC == "Arowe" then
				Tween(CFrame.new(-1994.51038, 125.519142, -72.2622986, -0.16715166, -6.55417338e-08, -0.985931218, -7.13315558e-08, 1, -5.43836585e-08, 0.985931218, 6.12376851e-08, -0.16715166))
			elseif _G.SelectNPC == "Random Devil Fruit" then
				Tween(CFrame.new(-1436.19727, 61.8777695, 4.75247526, -0.557794094, 2.74216543e-08, 0.829979479, 5.83273234e-08, 1, 6.16037932e-09, -0.829979479, 5.18467118e-08, -0.557794094))
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				Tween(CFrame.new(-923.255066, 7.67800522, 1608.61011, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Remove Devil Fruit" then
				Tween(CFrame.new(5664.80469, 64.677681, 867.85907, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Ability Teacher" then
				Tween(CFrame.new(-1057.67822, 9.65220833, 1799.49146, -0.865874112, -9.26330159e-08, 0.500262439, -7.33759435e-08, 1, 5.816689e-08, -0.500262439, 1.36579752e-08, -0.865874112))
			elseif _G.SelectNPC == "Dark Step" then
				Tween(CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Electro" then
				Tween(CFrame.new(-5389.49561, 13.283, -2149.80151, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Fishman Karate" then
				Tween(CFrame.new(61581.8047, 18.8965912, 987.832703, 1, 0, 0, 0, 1, 0, 0, 0, 1))
			elseif _G.SelectNPC == "Random Devil Fruit" then
				Tween(CFrame.new(-12491, 337, -7449))
			elseif _G.SelectNPC == "Blox Fruits Dealer" then
				Tween(CFrame.new(-12511, 337, -7448))
			elseif _G.SelectNPC == "Remove Devil Fruit" then
				Tween(CFrame.new(-5571, 1089, -2661))
			elseif _G.SelectNPC == "Horned Man" then
				Tween(CFrame.new(-11890, 931, -8760))
			elseif _G.SelectNPC == "Hungey Man" then
				Tween(CFrame.new(-10919, 624, -10268))
			elseif _G.SelectNPC == "Previous Hero" then
				Tween(CFrame.new(-10368, 332, -10128))
			elseif _G.SelectNPC == "Butler" then
				Tween(CFrame.new(-5125, 316, -3130))
			elseif _G.SelectNPC == "Lunoven" then
				Tween(CFrame.new(-5117, 316, -3093))
			elseif _G.SelectNPC == "Elite Hunter" then
				Tween(CFrame.new(-5420, 314, -2828))
			elseif _G.SelectNPC == "Player Hunter" then
				Tween(CFrame.new(-5559, 314, -2840))
			elseif _G.SelectNPC == "Uzoth" then
				Tween(CFrame.new(-9785, 852, 6667))
			end
		until not _G.TeleportNPC
	end
end)
local TeleportStatus_Rigdhtmys = Tab_5:AddSection('','Mirage Islands','auto summon,teleport,auto advance fruit dealer','rbxassetid://10734897665')
spawn(function()
	pcall(function()
		while task.wait() do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') then
				Mirragecheck:Set('🏝️: Mirage Island Spawning')
			else
				Mirragecheck:Set('❌: Mirage Island Not Found ')
			end
		end
	end)
end)
Mirragecheck = TeleportStatus_Rigdhtmys:AddLabel("")
TeleportStatus_Rigdhtmys:AddToggle("Teleport to Mirage", TeleporttoMirage, function(Value)
    TeleporttoMirage = Value
    CancelTween(TeleporttoMirage)
end)
spawn(function()
    while task.wait() do
        if TeleporttoMirage then
            if game:GetService("Workspace").Map:FindFirstChild("MirageIsland") then
                _G.CenterMI = game:GetService("Workspace").Map.MirageIsland.Center.Position
                Tween(CFrame.new(_G.CenterMI))
            end
        end
    end
end)

TeleportStatus_Rigdhtmys:AddToggle("Teleport to Gear", TeleporttoGear, function(Value)
    TeleporttoGear = Value
    CancelTween(TeleporttoGear)
end)
spawn(function()
    while task.wait() do
        if TeleporttoGear then
            if game:GetService("Workspace").Map:FindFirstChild("MirageIsland") then
                for i,v in pairs(game:GetService("Workspace").Map.MirageIsland:GetChildren()) do 
                    if v:IsA("MeshPart")then 
                        if v.Material ==  Enum.Material.Neon then  
                            Tween(v.CFrame)
                        end
                    end
                end
            end
        end
    end
end)

TeleportStatus_Rigdhtmys:AddToggle("Teleport to Advance Fruit Dealer", TeleporttoFruitDealer, function(Value)
    TeleporttoFruitDealer = Value
    CancelTween(TeleporttoFruitDealer)
end)
spawn(function()
    while wait() do
        if TeleporttoFruitDealer then
            if game:GetService("Workspace").NPCs:FindFirstChild("Advanced Fruit Dealer") then
                Tween(CFrame.new(game:GetService("Workspace").NPCs["Advanced Fruit Dealer"].HumanoidRootPart.CFrame))
            end
        end
    end
end)

TeleportStatus_Rigdhtmys:AddToggle("Summon Mirage Island", _G.dao, function(state)
	if state then
		_G.dao = true
	else
		_G.dao = false
	end;
	if _G.dao then
		local args = {
			[1] = "requestEntrance",
			[2] = Vector3.new(-12463.6025390625, 378.3270568847656, -7566.0830078125)
		}
		RS.Remotes.CommF_:InvokeServer(unpack(args))
		task.wait(1)
		GetRoot().CFrame = CFrame.new(-5411.22021, 778.609863, -2682.27759, 0.927179396, 0, 0.374617696, 0, 1, 0, -0.374617696, 0, 0.927179396)
		task.wait(2)
		GetRoot().CFrame = CFrame.new(-4526.32177734375, 16.446531295776367, -2648.96484375)
		task.wait(2)
		local args = {
			[1] = "BuyBoat",
			[2] = "PirateBrigade"
		}
		RS.Remotes.CommF_:InvokeServer(unpack(args))
		function two(gotoCFrame)
			pcall(function()
				GetHum().Sit = false;
				GetRoot().Anchored = false
			end)
			if (GetRoot().Position - gotoCFrame.Position).Magnitude <= 200 then
				pcall(function()
					tweenz:Cancel()
				end)
				GetRoot().CFrame = gotoCFrame
			else
				local tween_s = game:service"TWS"
				local info = TweenInfo.new((GetRoot().Position - gotoCFrame.Position).Magnitude / 325, Enum.EasingStyle.Linear)
				tween, err = pcall(function()
					tweenz = tween_s:Create(GetChar()["HumanoidRootPart"], info, {
						CFrame = gotoCFrame
					})
					tweenz:Play()
				end)
				if not tween then
					return err
				end
			end;
			function _TweenCanCle()
				tweenz:Cancel()
			end
		end;
		two(CFrame.new(-5100.7085, 29.968586, -6792.45459, -0.33648631, -0.0396691673, 0.940852463, -6.40461678e-07, 0.999112308, 0.0421253517, -0.941688359, 0.0141740013, -0.336187631))
		task.wait(13)
		for _, v in next, workspace.Boats.PirateBrigade:GetDescendants() do
			if v.Name:find("VehicleSeat") then
				GetRoot().CFrame = v.CFrame;
				if game:GetService("Workspace").Map:FindFirstChild("MirageIsland") then
					HyperCahaya(game:GetService("Workspace").Map:FindFirstChild("MirageIsland").HumanoidRootPart.CFrame * CFrame.new(0, 500, -100))
				end
			end
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.dao then
				local batuLaut = {
					"SmallGroup",
					"SmallCluster",
					"MediumGroup",
					"MediumFlat",
					"Large",
					"Largest"
				}
				for _, v in pairs(workspace:GetChildren()) do
					if table.find(batuLaut, v.Name) and v:IsA("Model") then
						for _, part in pairs(v:GetDescendants()) do
							if part:IsA("BasePart") then
								part.CanCollide = false
							end
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.dao then
				task.wait(0.5)
				local model = workspace.Boats.PirateBrigade;
				if model then
					local speed = 11;
					local forwardDirection = model.PrimaryPart.CFrame.lookVector;
					local targetPosition = model.PrimaryPart.Position + forwardDirection * 10;
					while (model.PrimaryPart.Position - targetPosition).Magnitude > 0.1 do
						model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame + forwardDirection * speed)
						task.wait()
						if not _G.BiirTrax then
							break
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.dao then
				if game:GetService("Workspace").Map:FindFirstChild("MirageIsland") then
					local bigTreePart = game.Workspace.Map.MirageIsland.BigTree.Part;
					HyperCahaya(CFrame.new(bigTreePart.Position))
					repeat
						task.wait()
					until (GetChar():FindFirstChild("HumanoidRootPart").Position - bigTreePart.Position).Magnitude < 5;
					_G.LockCamToMoon = true;
					task.wait(5)
					if game:GetService("Workspace").Map:FindFirstChild("MirageIsland") then
						for i, v in pairs(game:GetService("Workspace").Map.MirageIsland:GetChildren()) do
							if v:IsA("MeshPart") and v.Material == Enum.Material.Neon then
								HyperCahaya(v.CFrame)
							end
						end
					end
				end
			end
		end)
	end
end)

local Shop_Right = Tab_6:AddSection('','Devil Fruits','auto buy fruit on sale, auto bring fruit','rbxassetid://10709790875')
local Remote_GetFruits = RS:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits")
local ShopDevilSell = {}
for i, v in next, Remote_GetFruits do
	if v.OnSale then
		table.insert(ShopDevilSell, v.Name .. " [ " .. v.Price .. " Beli ]")
	end
end;
local DevilShopsRefresh = Shop_Right:AddDropdown('Devil Fruit on Sale', ShopDevilSell, "", function(Value)
	Select_Devil_Fruit = Value
end)
Shop_Right:Button("Refresh Fruit on Sale", function()
	local ShopDevilSell = {}
	for i, v in next, Remote_GetFruits do
		if v.OnSale then
			table.insert(ShopDevilSell, v.Name .. " [ " .. v.Price .. " Beli ]")
		end
	end;

	Select_Devil_Fruit:Clear()

	local ShopDevilSell = {}
for i, v in next, Remote_GetFruits do
	if v.OnSale then
		Select_Devil_Fruit:Add(v.Name .. " [ " .. v.Price .. " Beli ]")
	end
end;
end)
Shop_Right:Button("Buy Devil Fruit on Sale", function()
	RS.Remotes.CommF_:InvokeServer("GetFruits")
	RS.Remotes.CommF_:InvokeServer("PurchaseRawFruit", Select_Devil_Fruit)
end)
Shop_Right:AddToggle('Buy Random Fruit', AutoBuyFruitZioles, function(Value)
	AutoBuyFruitZioles = Value
end)
spawn(function()
	while task.wait() do
		if AutoBuyFruitZioles then
			pcall(function()
				RS.Remotes.CommF_:InvokeServer("Cousin", "Buy")
			end)
		end
	end
end)
Shop_Right:AddToggle('Auto Bring Fruit', AutoBringFruit, function(Value)
	AutoBringFruit = Value
end)
spawn(function()
	while task.wait() do
		if AutoBringFruit then
			pcall(function()
				for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
					if v:IsA("Tool") and string.find(v.Name, "Fruit") then
						task.wait(2)
						firetouchinterest(GetRoot(), v.Handle, 0)
						task.wait()
						firetouchinterest(GetRoot(), v.Handle, 1)
					end
				end
			end)
		end
	end
end)
_G.Sele_Teleport_Fruit = "Tween"
Shop_Right:AddToggle('Teleport to Fruit', _G.Auto_Teleport_Fruit, function(Value)
	_G.Auto_Teleport_Fruit = Value;
	CancelTween(_G.Auto_Teleport_Fruit)
end)
spawn(function()
	while task.wait() do
		if _G.Auto_Teleport_Fruit then
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v:IsA("Tool") and v:FindFirstChild('Handle') then
						if _G.Sele_Teleport_Fruit == "Bring" and _G.Auto_Teleport_Fruit then
							firetouchinterest(GetRoot(), v.Handle, 0)
							firetouchinterest(GetRoot(), v.Handle, 1)
						end;
						if _G.Sele_Teleport_Fruit == "Tween" and _G.Settings.Devil_Fruit["Bring Fruit"] then
							_G.BringFound = true;
							Tween(v.Handle.CFrame)
						end
					end;
					if v.Name == "Fruit " and v:FindFirstChild("Handle") then
						if _G.Sele_Teleport_Fruit == "Bring" and _G.Auto_Teleport_Fruit then
							firetouchinterest(GetRoot(), v.Handle, 0)
							firetouchinterest(GetRoot(), v.Handle, 1)
							GetRoot().CFrame = v.Handle.CFrame
						end;
						if _G.Sele_Teleport_Fruit == "Tween" and _G.Auto_Teleport_Fruit then
							Tween(v.Handle.CFrame)
						end
					end
				end;
				local i = game.Workspace:FindFirstChildOfClass('Tool')
				if _G.BringFound and not i then
					_G.BringFound = false
				end
			end)
		end
	end
end)
Shop_Right:AddToggle('Auto Stored Fruit', AutoStoreFruit, function(Value)
	AutoStoreFruit = Value
end)
spawn(function()
	while task.wait() do
		if AutoStoreFruit then
			pcall(function()
				if GetChar():FindFirstChild("Bomb Fruit") or Lplr.Backpack:FindFirstChild("Bomb Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Bomb-Bomb", Lplr.Backpack:FindFirstChild("Bomb Fruit"))
				end;
				if GetChar():FindFirstChild("Spike Fruit") or Lplr.Backpack:FindFirstChild("Spike Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Spike-Spike", Lplr.Backpack:FindFirstChild("Spike Fruit"))
				end;
				if GetChar():FindFirstChild("Chop Fruit") or Lplr.Backpack:FindFirstChild("Chop Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Chop-Chop", Lplr.Backpack:FindFirstChild("Chop Fruit"))
				end;
				if GetChar():FindFirstChild("Spring Fruit") or Lplr.Backpack:FindFirstChild("Spring Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Spring-Spring", Lplr.Backpack:FindFirstChild("Spring Fruit"))
				end;
				if GetChar():FindFirstChild("Kilo Fruit") or Lplr.Backpack:FindFirstChild("Kilo Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Kilo-Kilo", Lplr.Backpack:FindFirstChild("Kilo Fruit"))
				end;
				if GetChar():FindFirstChild("Smoke Fruit") or Lplr.Backpack:FindFirstChild("Smoke Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Smoke-Smoke", Lplr.Backpack:FindFirstChild("Smoke Fruit"))
				end;
				if GetChar():FindFirstChild("Spin Fruit") or Lplr.Backpack:FindFirstChild("Spin Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Spin-Spin", Lplr.Backpack:FindFirstChild("Spin Fruit"))
				end;
				if GetChar():FindFirstChild("Flame Fruit") or Lplr.Backpack:FindFirstChild("Flame Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Flame-Flame", Lplr.Backpack:FindFirstChild("Flame Fruit"))
				end;
				if GetChar():FindFirstChild("Bird: Falcon Fruit") or Lplr.Backpack:FindFirstChild("Bird: Falcon Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Bird-Bird: Falcon", Lplr.Backpack:FindFirstChild("Bird: Falcon Fruit"))
				end;
				if GetChar():FindFirstChild("Ice Fruit") or Lplr.Backpack:FindFirstChild("Ice Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Ice-Ice", Lplr.Backpack:FindFirstChild("Ice Fruit"))
				end;
				if GetChar():FindFirstChild("Sand Fruit") or Lplr.Backpack:FindFirstChild("Sand Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Sand-Sand", Lplr.Backpack:FindFirstChild("Sand Fruit"))
				end;
				if GetChar():FindFirstChild("Dark Fruit") or Lplr.Backpack:FindFirstChild("Dark Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Dark-Dark", Lplr.Backpack:FindFirstChild("Dark Fruit"))
				end;
				if GetChar():FindFirstChild("Revive Fruit") or Lplr.Backpack:FindFirstChild("Revive Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Revive-Revive", Lplr.Backpack:FindFirstChild("Revive Fruit"))
				end;
				if GetChar():FindFirstChild("Revive Fruit") or Lplr.Backpack:FindFirstChild("Revive Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Revive-Revive", Lplr.Backpack:FindFirstChild("Revive Fruit"))
				end;
				if GetChar():FindFirstChild("Diamond Fruit") or Lplr.Backpack:FindFirstChild("Diamond Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Diamond-Diamond", Lplr.Backpack:FindFirstChild("Diamond Fruit"))
				end;
				if GetChar():FindFirstChild("Light Fruit") or Lplr.Backpack:FindFirstChild("Light Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Light-Light", Lplr.Backpack:FindFirstChild("Light Fruit"))
				end;
				if GetChar():FindFirstChild("Love Fruit") or Lplr.Backpack:FindFirstChild("Love Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Love-Love", Lplr.Backpack:FindFirstChild("Love Fruit"))
				end;
				if GetChar():FindFirstChild("Rubber Fruit") or Lplr.Backpack:FindFirstChild("Rubber Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Rubber-Rubber", Lplr.Backpack:FindFirstChild("Rubber Fruit"))
				end;
				if GetChar():FindFirstChild("Barrier Fruit") or Lplr.Backpack:FindFirstChild("Barrier Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Barrier-Barrier", Lplr.Backpack:FindFirstChild("Barrier Fruit"))
				end;
				if GetChar():FindFirstChild("Magma Fruit") or Lplr.Backpack:FindFirstChild("Magma Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Magma-Magma", Lplr.Backpack:FindFirstChild("Magma Fruit"))
				end;
				if GetChar():FindFirstChild("Quake Fruit") or Lplr.Backpack:FindFirstChild("Quake Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Quake-Quake", Lplr.Backpack:FindFirstChild("Quake Fruit"))
				end;
				if GetChar():FindFirstChild("Human: Buddha Fruit") or Lplr.Backpack:FindFirstChild("Human: Buddha Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Human-Human: Buddha", Lplr.Backpack:FindFirstChild("Human: Buddha Fruit"))
				end;
				if GetChar():FindFirstChild("String Fruit") or Lplr.Backpack:FindFirstChild("String Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "String-String", Lplr.Backpack:FindFirstChild("String Fruit"))
				end;
				if GetChar():FindFirstChild("Bird: Phoenix Fruit") or Lplr.Backpack:FindFirstChild("Bird: Phoenix Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Bird-Bird: Phoenix", Lplr.Backpack:FindFirstChild("Bird: Phoenix Fruit"))
				end;
				if GetChar():FindFirstChild("Portal Fruit") or Lplr.Backpack:FindFirstChild("Portal Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Portal-Portal", Lplr.Backpack:FindFirstChild("Portal Fruit"))
				end;
				if GetChar():FindFirstChild("Rumble Fruit") or Lplr.Backpack:FindFirstChild("Rumble Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Rumble-Rumble", Lplr.Backpack:FindFirstChild("Rumble Fruit"))
				end;
				if GetChar():FindFirstChild("Paw Fruit") or Lplr.Backpack:FindFirstChild("Paw Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Paw-Paw", Lplr.Backpack:FindFirstChild("Paw Fruit"))
				end;
				if GetChar():FindFirstChild("Blizzard Fruit") or Lplr.Backpack:FindFirstChild("Blizzard Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Blizzard-Blizzard", Lplr.Backpack:FindFirstChild("Blizzard Fruit"))
				end;
				if GetChar():FindFirstChild("Gravity Fruit") or Lplr.Backpack:FindFirstChild("Gravity Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Gravity-Gravity", Lplr.Backpack:FindFirstChild("Gravity Fruit"))
				end;
				if GetChar():FindFirstChild("Dough Fruit") or Lplr.Backpack:FindFirstChild("Dough Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Dough-Dough", Lplr.Backpack:FindFirstChild("Dough Fruit"))
				end;
				if GetChar():FindFirstChild("Shadow Fruit") or Lplr.Backpack:FindFirstChild("Shadow Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Shadow-Shadow", Lplr.Backpack:FindFirstChild("Shadow Fruit"))
				end;
				if GetChar():FindFirstChild("Venom Fruit") or Lplr.Backpack:FindFirstChild("Venom Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Venom-Venom", Lplr.Backpack:FindFirstChild("Venom Fruit"))
				end;
				if GetChar():FindFirstChild("Control Fruit") or Lplr.Backpack:FindFirstChild("Control Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Control-Control", Lplr.Backpack:FindFirstChild("Control Fruit"))
				end;
				if GetChar():FindFirstChild("Spirit Fruit") or Lplr.Backpack:FindFirstChild("Spirit Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Spirit-Spirit", Lplr.Backpack:FindFirstChild("Spirit Fruit"))
				end;
				if GetChar():FindFirstChild("Dragon Fruit") or Lplr.Backpack:FindFirstChild("Dragon Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Dragon-Dragon", Lplr.Backpack:FindFirstChild("Dragon Fruit"))
				end;
				if GetChar():FindFirstChild("Leopard Fruit") or Lplr.Backpack:FindFirstChild("Leopard Fruit") then
					RS.Remotes.CommF_:InvokeServer("StoreFruit", "Leopard-Leopard", Lplr.Backpack:FindFirstChild("Leopard Fruit"))
				end
			end)
		end
	end
end)

local Shop = Tab_6:AddSection('','Shop','auto buy abilities, fighting style, swords','rbxassetid://10734952479')

Shop:AddLabel("Abilities")
local AbilityList = {'Geppo ($10,000)', 'Buso Haki ($25,000)', 'Soru ($100,000)', 'Observation Haki ($750,000)'}
local BuyAbility = Shop:AddDropdown("Select Ability",AbilityList,"",function(value)
    _G.BuyAbility = value
end)

Shop:Button("Buy Abilities", function()
    if _G.BuyAbility == "Geppo ($10,000)" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
    elseif _G.BuyAbility == "Buso Haki ($25,000)" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
    elseif _G.BuyAbility == "Soru ($100,000)" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
    elseif _G.BuyAbility == "Observation Haki ($750,000)" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
    end
end)

Shop:AddLabel("Fighting Styles")
local BuyFightSe = {'Black Leg ($150,000)', 'Electro ($500,000)', 'Water Kung Fu ($750,000)', 'Dragon Claw ($1,500,000)', 'Death Step ($2,500,000)', 'Sharkman Karate ($3,000,000)', 'Electric Claw ($3,500,000)', 'Dragon Talon ($4,500,000)', 'Superhuman ($5,000,000)', 'God Human ($5,000,000)', 'Sanguine Art ($6,000,000)'}
local BuyFight = Shop:AddDropdown("Select Fighting",BuyFightSe,"",function(value)
    _G.BuyFighting = value
end)

Shop:Button("Buy Fighting Style", function()
    if _G.BuyFighting == "Black Leg ($150,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    elseif _G.BuyFighting == "Electro ($500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    elseif _G.BuyFighting == "Water Kung Fu ($750,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    elseif _G.BuyFighting == "Dragon Claw ($1,500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
    elseif _G.BuyFighting == "Death Step ($2,500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    elseif _G.BuyFighting == "Sharkman Karate ($3,000,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    elseif _G.BuyFighting == "Electric Claw ($3,500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    elseif _G.BuyFighting == "Dragon Talon ($4,500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    elseif _G.BuyFighting == "Superhuman ($5,000,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    elseif _G.BuyFighting == "God Human ($5,000,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    elseif _G.BuyFighting == "Sanguine Art ($6,000,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
end)

Shop:AddLabel("Swords")
local SwordList = {'Cutlass ($5,000)', 'Katana ($10,000)', 'Iron Mace ($25,000)', 'Dual Katana ($30,000)', 'Triple Katana ($50,000)', 'Pipe ($100,000)', 'Dual-Headed Blade ($200,000)', 'Bisento ($1,000,000)', 'Soul Cane ($750,000)', 'Pole v.2 ($2,000,000)'}

local BuySwordSE = Shop:AddDropdown("Select Sword",SwordList,"",function(value)
    _G.BuySwordSE = value
end)

Shop:Button("Buy Sword", function()
    if _G.BuySwordSE == "Cutlass ($5,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
    elseif _G.BuySwordSE == "Katana ($10,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
    elseif _G.BuySwordSE == "Iron Mace ($25,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
    elseif _G.BuySwordSE == "Dual Katana ($30,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
    elseif _G.BuySwordSE == "Triple Katana ($50,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
    elseif _G.BuySwordSE == "Pipe ($100,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
    elseif _G.BuySwordSE == "Dual-Headed Blade ($200,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
    elseif _G.BuySwordSE == "Bisento ($1,000,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
    elseif _G.BuySwordSE == "Soul Cane ($750,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
    elseif _G.BuySwordSE == "Pole v.2 ($2,000,000)" then
        wait(0.5)
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end
end)

Shop:AddLabel("Guns")
local GunList = {'Slingshot ($5,000)', 'Musket ($10,000)', 'Flintlock ($25,000)', 'Refined Slingshot ($50,000)', 'Refined Flintlock ($75,000)', 'Cannon ($100,000)', 'Kabucha ($500,000)', 'Bizarre Rifle (100 Ectoplasm)'}

local GunSelect = Shop:AddDropdown("Select Gun",GunList,"",function(value)
    _G.GunSelect = value
end)

Shop:Button("Buy Gun", function()
    if _G.GunSelect == "Slingshot ($5,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
    elseif _G.GunSelect == "Musket ($10,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
    elseif _G.GunSelect == "Flintlock ($25,000)" then
    elseif _G.GunSelect == "Flintlock ($25,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
    elseif _G.GunSelect == "Refined Slingshot ($50,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Slingshot")
    elseif _G.GunSelect == "Refined Flintlock ($75,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
    elseif _G.GunSelect == "Cannon ($100,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
    elseif _G.GunSelect == "Kabucha ($500,000)" then
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
    elseif _G.GunSelect == "Bizarre Rifle (100 Ectoplasm)" then
        wait(0.5)
        local A_1 = "Ectoplasm"
        local A_2 = "Buy"
        local A_3 = 1
        local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
        Event:InvokeServer(A_1, A_2, A_3) 
    end
end)

Shop:AddLabel("Accessories")

local BuyAccessories = Shop:AddDropdown("Select Accessory", {'Black Cape ($100,000)', 'Swordsman Hat ($150,000)', 'Tomoe Ring ($250,000)'}, "", function(value)
    _G.BuyAccessories = value
end)

Shop:Button("Buy Accessory", function()
    if _G.BuyAccessories == "Black Cape ($100,000)" then
        local args = {
            [1] = "BuyItem",
            [2] = "Black Cape"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    elseif _G.BuyAccessories == "Swordsman Hat ($150,000)" then
        local args = {
            [1] = "BuyItem",
            [2] = "Swordsman Hat"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    elseif _G.BuyAccessories == "Tomoe Ring ($250,000)" then
        local args = {
            [1] = "BuyItem",
            [2] = "Tomoe Ring"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    end
end)

Shop:AddLabel("Others")

local BuyLengendSword = Shop:AddToggle("Auto Buy Legendary Sword", false,function(value)
    _G.BuyLegendSword = value
end)

task.spawn(function()
    while wait() do
        pcall(function()
            if _G.BuyLegendSword then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
            end
        end)
    end
end)

local BuyTTK = Shop:AddToggle("Buy True Triple Katana",false, function(value)
    _G.BuyTTK = value
end)

task.spawn(function()
    while wait() do
        pcall(function()
            if _G.BuyTTK then
                local A_1 = "MysteriousMan"
                local A_2 = "2"
                local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
                Event:InvokeServer(A_1, A_2)
            end
        end)
    end
end)

local Misc_Left = Tab_7:AddSection('','Misc','infinite geppo,soru MIGHT LAG','rbxassetid://10723396542')
Misc_Left:AddToggle('Infinite Geppo', InfiniteGeppo, function(Value)
	InfiniteGeppo = Value
end)
spawn(function()
	while task.wait(1) do
		if InfiniteGeppo then
			pcall(function()
				for i, v in next, getgc() do
					if getfenv(v).script == GetChar():WaitForChild("Geppo") then
						for i2, v2 in next, getupvalues(v) do
							if tostring(v2) == "0" then
								repeat
									task.wait(.1)
									setupvalue(v, i2, 0)
								until not InfiniteGeppo or GetHum().Health <= 0
							end
						end
					end
				end
			end)
		end
	end
end)
Misc_Left:AddToggle('Infinite Soru', InfiniteSoru, function(Value)
	InfiniteSoru = Value
end)
spawn(function()
	while task.wait(1) do
		if InfiniteSoru and GetChar():FindFirstChild("HumanoidRootPart") ~= nil then
			pcall(function()
				for i, v in next, getgc() do
					if getfenv(v).script == GetChar():WaitForChild("Soru") then
						for i2, v2 in pairs(debug.getupvalues(v)) do
							if type(v2) == 'table' then
								if v2.LastUse then
									repeat
										task.wait(.1)
										setupvalue(v, i2, {
											LastAfter = 0,
											LastUse = 0
										})
									until not InfiniteSoru or GetHum().Health <= 0
								end
							end
						end
					end
				end
			end)
		end
	end
end)
Misc_Left:AddToggle('Walk on Water', true, function(Value)
	WalkOnWater = Value
end)
spawn(function()
	while task.wait(1) do
		if WalkOnWater then
			pcall(function()
				if not nelzkie then
					game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
				else
					game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
				end
			end)
		end
	end
end)
Misc_Left:AddToggle('Remove Fog', _G.Remove_Fog, function(Value)
	_G.Remove_Fog = Value;
	if not _G.Remove_Fog then
		return
	end;
	while _G.Remove_Fog do
		task.wait()
		game.Lighting.FogEnd = 9e9;
		if not _G.Remove_Fog then
			game.Lighting.FogEnd = 2500
		end
	end
end)
Misc_Left:AddToggle('White Screen', _G.White_Screen, function(Value)
	_G.White_Screen = Value;
	if _G.White_Screen then
		Run:Set3dRenderingEnabled(false)
	else
		Run:Set3dRenderingEnabled(true)
	end
end)
Misc_Left:Button("Inventory", function()
	RS.Remotes.CommF_:InvokeServer("getInventoryWeapons")
	Lplr.PlayerGui.Main.Inventory.Visible = true
end)
Misc_Left:Button("Devil Fruit Inventory", function()
	local args = {
		[1] = "getInventoryFruits"
	}
	RS.Remotes.CommF_:InvokeServer("getInventoryFruits")
	Lplr.PlayerGui.Main.FruitInventory.Visible = true
end)
Misc_Left:Button("Title Name", function()
	RS.Remotes.CommF_:InvokeServer("getTitles")
	Lplr.PlayerGui.Main.Titles.Visible = true
end)
Misc_Left:Button("Color Haki", function()
	Lplr.PlayerGui.Main.Colors.Visible = true
end)
Misc_Left:Button("Join Pirates Team", function()
	RS.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end)
Misc_Left:Button("Join Marines Team", function()
	RS.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end)
local Misc_Right = Tab_7:AddSection('','Other Misc','esp island,fruit,player,flower','rbxassetid://6031233840')
Misc_Right:AddToggle('Chest ESP', ChestESP, function(Value)
	ChestESP = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if ChestESP then
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.Name == "GoldChest" or v.Name == "DiamondChest" or v.Name == "SilverChest" then
						if not v:FindFirstChild("ChestESP") then
							local BillboardGui = Instance.new("BillboardGui")
							local TextLabel = Instance.new("TextLabel")
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "ChestESP"
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1.000;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50)
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.BackgroundTransparency = 1.000;
							TextLabel.Size = UDim2.new(0, 200, 0, 50)
							TextLabel.Font = Enum.Font.GothamMedium;
							TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.Text.Size = 35;
							TextLabel.TextStrokeTransparency = 0.000;
							TextLabel.TextWrapped = true
						end;
						local Dis = math.floor((GetRoot().Position - v.Position).Magnitude)
						v.ChestESP.TextLabel.Text = v.Name .. "\n" .. Dis .. " M."
						if v.Name == "GoldChest" then
							v:FindFirstChild("ChestESP").TextLabel.TextColor3 = Color3.new(255, 255, 255)
						elseif v.Name == "DiamondChest" then
							v:FindFirstChild("ChestESP").TextLabel.TextColor3 = Color3.new(255, 255, 255)
						elseif v.Name == "SilverChest" then
							v:FindFirstChild("ChestESP").TextLabel.TextColor3 = Color3.new(255, 255, 255)
						end
					end
				end
			else
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.Name == "GoldChest" or v.Name == "DiamondChest" or v.Name == "SilverChest" then
						if v:FindFirstChild("ChestESP") then
							v.ChestESP:Destroy()
						end
					end
				end
			end
		end)
	end
end)
Misc_Right:AddToggle('Devil Fruit ESP', _G.ESPDF, function(Value)
	_G.ESPDF = Value
end)
spawn(function()
	while task.wait() do
		if _G.ESPDF then
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v:IsA("Tool") and v:FindFirstChild("Handle") then
						if not v.Handle:FindFirstChild("DFESP") then
							local BillboardGui = Instance.new("BillboardGui")
							local TextLabel = Instance.new("TextLabel")
							BillboardGui.Parent = v.Handle;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "DFESP"
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1.000;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50)
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.BackgroundTransparency = 1.000;
							TextLabel.Size = UDim2.new(0, 200, 0, 50)
							TextLabel.Font = Enum.Font.GothamMedium;
							TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
							TextLabel.Text.Size = 35;
							TextLabel.TextStrokeTransparency = 0.000;
							TextLabel.TextWrapped = true
						end;
						Dis = math.floor((GetRoot().Position - v.Handle.Position).Magnitude)
						v.Handle.DFESP.TextLabel.Text = v.Name .. "\n" .. Dis .. " M."
					end
				end
			end)
		else
			for i, v in pairs(game.Workspace:GetChildren()) do
				if v:IsA("Tool") and v:FindFirstChild("Handle") then
					if v.Handle:FindFirstChild("DFESP") then
						v:Destroy()
					end
				end
			end
		end
	end
end)
Misc_Right:AddToggle('Fruit ESP', FruitESPe, function(Value)
	FruitESPe = Value
end)
spawn(function()
	while task.wait() do
		if FruitESPe then
			pcall(function()
				for a, b in pairs(game.Workspace:GetChildren()) do
					if b.Name == 'PineappleSpawner' or b.Name == 'BananaSpawner' or b.Name == 'AppleSpawner' then
						for i, v in pairs(b:GetChildren()) do
							if v:IsA('Tool') then
								if v:FindFirstChild("Handle") then
									repeat
										task.wait(.1)
										if not v.Handle:FindFirstChild("FruitESP") then
											local BillboardGui = Instance.new("BillboardGui")
											local TextLabel = Instance.new("TextLabel")
											BillboardGui.Parent = v.Handle;
											BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
											BillboardGui.Active = true;
											BillboardGui.Name = "FruitESP"
											BillboardGui.AlwaysOnTop = true;
											BillboardGui.LightInfluence = 1.000;
											BillboardGui.Size = UDim2.new(0, 200, 0, 50)
											BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
											TextLabel.Parent = BillboardGui;
											TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
											TextLabel.BackgroundTransparency = 1.000;
											TextLabel.Size = UDim2.new(0, 200, 0, 50)
											TextLabel.Font = Enum.Font.GothamMedium;
											TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
											TextLabel.Text.Size = 35;
											TextLabel.TextStrokeTransparency = 0.000;
											TextLabel.TextWrapped = true
										end;
										local Dis = math.floor((GetRoot().Position - v.Handle.Position).Magnitude)
										v.Handle.FruitESP.TextLabel.Text = v.Name .. "\n" .. Dis .. " M."
									until not FruitESPe
								end
							end
						end
					end
				end
			end)
		else
			for a, b in pairs(game.Workspace:GetChildren()) do
				if b.Name == 'PineappleSpawner' or b.Name == 'BananaSpawner' or b.Name == 'AppleSpawner' then
					for i, v in pairs(b:GetChildren()) do
						if v:IsA('Tool') then
							if v:FindFirstChild("Handle") then
								if v.Handle:FindFirstChild("FruitESP") then
									v.Handle.FruitESP:Destroy()
								end
							end
						end
					end
				end
			end
		end
	end
end)
Misc_Right:AddToggle('Flower ESP', FlowerESP, function(Value)
	FlowerESP = Value
end)
spawn(function()
	while task.wait() do
		if FlowerESP then
			pcall(function()
				for i, v in pairs(game.Workspace:GetChildren()) do
					if v.Name == "Flower2" or v.Name == "Flower1" then
						if not v:FindFirstChild("FindFlower") then
							local BillboardGui = Instance.new("BillboardGui")
							local TextLabel = Instance.new("TextLabel")
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "FindFlower"
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1.000;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50)
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.BackgroundTransparency = 1.000;
							TextLabel.Size = UDim2.new(0, 200, 0, 50)
							TextLabel.Font = Enum.Font.GothamMedium;
							TextLabel.TextColor3 = Color3.fromRGB(250, 250, 30)
							TextLabel.Text.Size = 75;
							TextLabel.TextStrokeTransparency = 0.000;
							TextLabel.TextWrapped = true
						end;
						local Dis = math.floor((GetRoot().Position - v.Position).Magnitude)
						v.FindFlower.TextLabel.Text = v.Name .. " - [" .. Dis .. " M]"
						if v.Name == "Flower1" then
							v.FindFlower.TextLabel.TextColor3 = Color3.new(255, 120, 120)
						elseif v.Name == "Flower2" then
							v.FindFlower.TextLabel.TextColor3 = Color3.new(120, 120, 255)
						end
					end
				end
			end)
		else
			for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v:FindFirstChild("FindFlower") then
					v.FindFlower:Destroy()
				end
			end
		end
	end
end)
Misc_Right:AddToggle('Island ESP', IslandESP, function(Value)
	IslandESP = Value
end)
spawn(function()
	while task.wait() do
		if IslandESP then
			pcall(function()
				for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
					if not v:FindFirstChild("IslandEsp") then
						local BillboardGui = Instance.new("BillboardGui")
						local TextLabel = Instance.new("TextLabel")
						BillboardGui.Parent = v;
						BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
						BillboardGui.Active = true;
						BillboardGui.Name = "IslandEsp"
						BillboardGui.AlwaysOnTop = true;
						BillboardGui.LightInfluence = 1.000;
						BillboardGui.Size = UDim2.new(0, 200, 0, 50)
						BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
						TextLabel.Parent = BillboardGui;
						TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextLabel.BackgroundTransparency = 1.000;
						TextLabel.Size = UDim2.new(0, 200, 0, 50)
						TextLabel.Font = Enum.Font.GothamMedium;
						TextLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
						TextLabel.Text.Size = 75;
						TextLabel.TextStrokeTransparency = 0.000;
						TextLabel.TextWrapped = true
					end;
					local Dis = math.floor((GetRoot().Position - v.Position).Magnitude / 10)
					v.IslandEsp.TextLabel.Text = v.Name .. "\n" .. "[" .. Dis .. "]"
				end
			end)
		else
			for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
				if v:FindFirstChild("IslandEsp") then
					v.IslandEsp:Destroy()
				end
			end
		end
	end
end)
Misc_Right:AddToggle('Npc ESP', NpcESP, function(Value)
	NpcESP = Value
end)
spawn(function()
	while task.wait() do
		if NpcESP then
			pcall(function()
				for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
					if v:FindFirstChild('HumanoidRootPart') then
						if not v:FindFirstChild("NpcEspes") then
							local BillboardGui = Instance.new("BillboardGui")
							local TextLabel = Instance.new("TextLabel")
							BillboardGui.Parent = v;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "NpcEspes"
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1.000;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50)
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.BackgroundTransparency = 1.000;
							TextLabel.Size = UDim2.new(0, 200, 0, 50)
							TextLabel.Font = Enum.Font.GothamMedium;
							TextLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
							TextLabel.Text.Size = 35
						end;
						local Dis = math.floor((GetRoot().Position - v.HumanoidRootPart.Position).Magnitude)
						v.NpcEspes.TextLabel.Text = v.Name .. " - [" .. Dis .. " M]"
					end
				end
			end)
		else
			for i, v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
				if v:FindFirstChild("NpcEspes") then
					v.NpcEspes:Destroy()
				end
			end
		end
	end
end)
Misc_Right:AddToggle("ESP Player", _G.ESPPlayer, function(Value)
	_G.ESPPlayer = Value
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.ESPPlayer then
				for i, v in pairs(Plrs:GetChildren()) do
					if v.Name ~= Lplr.Name then
						if not v.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
							local BillboardGui = Instance.new("BillboardGui")
							local TextLabel = Instance.new("TextLabel")
							BillboardGui.Parent = v.Character.HumanoidRootPart;
							BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
							BillboardGui.Active = true;
							BillboardGui.Name = "PlayerESP"
							BillboardGui.AlwaysOnTop = true;
							BillboardGui.LightInfluence = 1.000;
							BillboardGui.Size = UDim2.new(0, 200, 0, 50)
							BillboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
							TextLabel.Parent = BillboardGui;
							TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.BackgroundTransparency = 1.000;
							TextLabel.Size = UDim2.new(0, 200, 0, 50)
							TextLabel.Font = Enum.Font.GothamMedium;
							TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel.Text.Size = 35;
							TextLabel.TextStrokeTransparency = 0.000;
							TextLabel.TextWrapped = true
						end;
						local Dis = math.floor((GetRoot().Position - v.Character.HumanoidRootPart.Position).Magnitude)
						v.Character.HumanoidRootPart:FindFirstChild("PlayerESP").TextLabel.Text = v.Name .. "\n\n" .. Dis .. " M."
						if v.Team == Lplr.Team then
							v.Character.HumanoidRootPart:FindFirstChild("PlayerESP").TextLabel.TextColor3 = Color3.new(255, 0, 0)
						else
							v.Character.HumanoidRootPart:FindFirstChild("PlayerESP").TextLabel.TextColor3 = Color3.new(0, 255, 0)
						end
					end
				end
			else
				for i, v in pairs(Plrs:GetChildren()) do
					if v.Name ~= Lplr.Name then
						if v.Character.HumanoidRootPart:FindFirstChild("PlayerESP") then
							v.Character.HumanoidRootPart.PlayerESP:Destroy()
						end
					end
				end
			end
		end)
	end
end)
Misc_Right:AddToggle('Currently Broken', DodgewithoutCool, function(Value)
	print("What Did i just say")
end)
local CodeList = {
	"EXP_5B",
	"CONTROL",
	"UPDATE11",
	"XMASEXP",
	"1BILLION",
	"ShutDownFix2",
	"UPD14",
	"STRAWHATMAINE",
	"TantaiGaming",
	"Colosseum",
	"Axiore",
	"Sub2Daigrock",
	"Sky Island 3",
	"Sub2OfficialNoobie",
	"SUB2NOOBMASTER123",
	"THEGREATACE",
	"Fountain City",
	"BIGNEWS",
	"FUDD10",
	"SUB2GAMERROBOT_EXP1",
	"UPD15",
	"2BILLION",
	"UPD16",
	"3BVISITS",
	"fudd10_v2",
	"Starcodeheo",
	"Magicbus",
	"JCWK",
	"Bluxxy",
	"Bluxxy",
	"Sub2Fer999",
	"Enyu_is_Pro"
}
Misc_Right:Button('Redeem X2 Code', function()
	local function RedeemCode(value)
		RS.Remotes.Redeem:InvokeServer(value)
	end;
	for i, v in ipairs(CodeList) do
		RedeemCode(v)
	end
end)
Misc_Right:Button("Always Day", function()
	while task.wait() do
		Lighting.ClockTime = 12
	end
end)
Misc_Right:Button("Remove Lave", function()
	for i, v in ipairs(game.Workspace:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end;
	for i, v in ipairs(RS:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end
end)

local Fun = Tab_8:AddSection('','Fun Visual','auto transform v4 any race visual only,auto max all','rbxassetid://6034467796')
--Fun/Visual Section

Fun:Button("Rain Fruit",function()
		for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
			v.Parent = game.Workspace.Map
			v:MoveTo(game.Players.LocalPlayer.Character.PrimaryPart.Position +
				Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))
			if v.Fruit:FindFirstChild("AnimationController") then
				v.Fruit:FindFirstChild("AnimationController"):LoadAnimation(v.Fruit:FindFirstChild("Idle")):Play()
			end
			v.Handle.Touched:Connect(function(otherPart)
				if otherPart.Parent == game.Players.LocalPlayer.Character then
					v.Parent = game.Players.LocalPlayer.Backpack
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
				end
			end)
		end
	end
)



Fun:Button("Instant Max All Beli, Level, Exp",function()
		local plr = game:GetService("Players").LocalPlayer
		local Notification = require(game:GetService("ReplicatedStorage").Notification)
		local Data = plr:WaitForChild("Data")
		local EXPFunction = require(game.ReplicatedStorage:WaitForChild("EXPFunction"))
		local LevelUp = require(game:GetService("ReplicatedStorage").Effect.Container.LevelUp)
		local Sound = require(game:GetService("ReplicatedStorage").Util.Sound)
		local LevelUpSound = game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild(
				"LevelUp_Proxy") or
			game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp")
		function v129(p15)
			local v130 = p15;
			while true do
				local v131, v132 = string.gsub(v130, "^(-?%d+)(%d%d%d)", "%1,%2");
				v130 = v131;
				if v132 == 0 then
					break;
				end;
			end;
			return v130;
		end;

		Notification.new("<Color=Yellow>QUEST COMPLETED!<Color=/>"):Display()
		Notification.new("Earned <Color=Yellow>9,999,999,999,999 Exp.<Color=/> (+ None)"):Display()
		Notification.new("Earned <Color=Green>$9,999,999,999,999<Color=/>"):Display()
		plr.Data.Exp.Value = 999999999999
		plr.Data.Beli.Value = plr.Data.Beli.Value + 999999999999

		delay = 0
		count = 0
		while plr.Data.Exp.Value - EXPFunction(Data.Level.Value) > 0 do
			plr.Data.Exp.Value = plr.Data.Exp.Value - EXPFunction(Data.Level.Value)
			plr.Data.Level.Value = plr.Data.Level.Value + 1
			plr.Data.Points.Value = plr.Data.Points.Value + 3
			LevelUp({ plr })
			Sound.Play(Sound, LevelUpSound.Value)
			Notification.new("<Color=Green>LEVEL UP!<Color=/> (" .. plr.Data.Level.Value .. ")"):Display()
			count = count + 1
			if count >= 10 then
				delay = tick()
				count = 0
				wait(1)
			end
		end
	end
)

Fun:Button("Human V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Human V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(166, 0, 0),
			Color2 = Color3.fromRGB(166, 0, 0),
			Color3 = Color3.fromRGB(166, 0, 0),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end)

Fun:Button("Mink V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Mink V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(102, 255, 153),
			Color2 = Color3.fromRGB(102, 255, 153),
			Color3 = Color3.fromRGB(102, 255, 153),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end)

Fun:Button("Fishman V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Fishman V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(5, 115, 166),
			Color2 = Color3.fromRGB(5, 115, 166),
			Color3 = Color3.fromRGB(5, 115, 166),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end
)

Fun:Button("Skypiean V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Skypeian V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(222, 222, 0),
			Color2 = Color3.fromRGB(222, 222, 0),
			Color3 = Color3.fromRGB(222, 222, 0),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end)

Fun:Button("Ghoul V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Ghoul V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(155, 155, 155),
			Color2 = Color3.fromRGB(0, 0, 0),
			Color3 = Color3.fromRGB(155, 155, 155),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end)

Fun:Button("Cyborg V4 Transformation",function()
		require(game:GetService("ReplicatedStorage").Notification).new("Cyborg V4 Transformation!"):Display();
		wait()
		setthreadcontext(5)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Player = game:GetService("Players").LocalPlayer
		local ArgsTransform = {
			Character = game.Players.LocalPlayer.Character,
			CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
			Color1 = Color3.fromRGB(166, 0, 111),
			Color2 = Color3.fromRGB(166, 0, 111),
			Color3 = Color3.fromRGB(166, 0, 111),
		}
		Player.Character.Humanoid:LoadAnimation(ReplicatedStorage.Util.Anims.Storage["2"].RaceTransform):Play()
		delay(1, function()
			pcall(function() require(ReplicatedStorage.Effect.Container.RaceTransformation.Main)(ArgsTransform) end)
		end)
	end)
	spawn(function()
		local gameMetaTable = getrawmetatable(game)
		local originalNamecall = gameMetaTable.__namecall
	
		-- Allow modification of the metatable
		setreadonly(gameMetaTable, false)
	
		-- Override the __namecall method
		gameMetaTable.__namecall = newcclosure(function(...)
			local methodName = getnamecallmethod()
			local arguments = {...}
	
			-- Intercept only "FireServer" calls
			if tostring(methodName) == "FireServer" then
				local event = tostring(arguments[1])
				local eventData = arguments[2]
	
				-- Check if the event name matches and we want to modify the data
				if event == "RemoteEvent" and UseSkill then
					-- Adjust the event data based on its type
					if type(eventData) == "vector" then
						arguments[2] = PositionSkillMasteryDevilFruit
					elseif type(eventData) == "CFrame" then
						arguments[2] = CFrame.new(PositionSkillMasteryDevilFruit)
					end
	
					-- Call the original method with the modified arguments
					return originalNamecall(unpack(arguments))
				end
			end
	
			-- Default: call the original method without changes
			return originalNamecall(...)
		end)
	
		-- Restore the metatable to read-only
		setreadonly(gameMetaTable, true)
	end)

	
local gg = getrawmetatable(game)
local old = gg.__namecall
setreadonly(gg,false)
gg.__namecall = newcclosure(function(...)
local method = getnamecallmethod()
local args = {...}
if tostring(method) == "FireServer" then
	if tostring(args[1]) == "RemoteEvent" then
		if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
			if Skillaimbot then
				args[2] = AimBotSkillPosition
				return old(unpack(args))
			end
		end
	end
end
return old(...)
end)


