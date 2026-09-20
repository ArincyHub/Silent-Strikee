local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))
Players = cloneref(game:GetService("Players"))
if not game:IsLoaded() then
	local notLoaded = Instance.new("Message")
	notLoaded.Parent = COREGUI
	notLoaded.Text = "Waiting for game to load"
	game.Loaded:Wait()
	notLoaded:Destroy()
end
local getText = function(Text, delayTime)
	delay(delayTime or 1, function()
		game:GetService("ReplicatedStorage").Chest.Remotes.Bindables.TextAlert:Fire("Custom Text", {
			Name = "No Force", 
			Overlay = true, 
			Message = Text or "Zen Hub Loading Script .", 
			Color = Color3.fromRGB(255, 255, 255)
		});
	end)
end
_G.NowExec = true
local AUTO_EXEC_URL = "https://pastefy.app/esX3AUtH/raw"
local Players = game.Players
repeat
	Client = Players.LocalPlayer
	wait()
until Client
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")
function runAutoAccept()
    local args = {
        [1] = "EnterTheGame",
        [2] = {}
    }
    local success, result = pcall(function()
        game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction:InvokeServer(unpack(args))
    end)

    if not success then
        warn("Failed to execute AutoAccept: ", result)
        return false
    end
    return true
end

local q = queue_on_teleport 
    or (syn and syn.queue_on_teleport) 
    or (fluxus and fluxus.queue_on_teleport)

if q then
    q("loadstring(game:HttpGet('"..AUTO_EXEC_URL.."'))()")
    print("Auto-exec queued for next teleport")
else
    warn("Your executor does not support queue_on_teleport")
end


runAutoAccept()
wait(1)
Config = Config or {
	['Select Weapon'] = "Melee&Sword",
	['Safe Mode'] = false,
	['Select You HP (%)'] = 45,
	['Select You HP Max (%)'] = 75,
	['Setting Server Time'] = 60,
	['Setting Sea Monster Time (for Hop)'] = 15,
	['Bring_Mon'] = true,
	['Auto Use Skill'] = true,
	['Select Skill'] = {"Z","X","C","V","E"},
	['Drop if have'] = true,
	['RawStand'] = 8.5,
	['Show Limited'] = true,
	['Show Mythical'] = true,
	['Show Legendary'] = true,
	['Select Stast'] = {"Melee","Sword"},
	['Auto UpStast'] = true
}
getgenv().Config = Config
local foldername = "ZenHub";
local filename = game.Players.LocalPlayer.Name.."Config.json"
local GameId = game.GameId
getgenv().Config = Config
local foldername = "ZenHub";
local filename = game.Players.LocalPlayer.Name.."Config.json"
local GameId = game.GameId
function SaveSettings()
	local json = HttpService:JSONEncode(Config)
	if writefile then
		if isfolder(foldername) then
			if isfolder(foldername.."/ ".. GameId) then
				writefile(foldername.."/ ".. GameId .."/"..filename, json)
			else
				makefolder(foldername.."/ ".. GameId .."/")
				writefile(foldername.."/ ".. GameId .."/"..filename, json)
			end
		else
			makefolder(foldername)
			makefolder(foldername.."/ ".. GameId .."/")
			writefile(foldername.."/ ".. GameId .."/"..filename, json)
		end
	end
end
function LoadSettings()
	local HttpService = game:GetService("HttpService")
	if isfile(foldername.."/ ".. GameId .."/"..filename) then
		for _i, value in pairs(HttpService:JSONDecode(readfile(foldername.."/ ".. GameId .."/"..filename)) or Config ) do
			Config[_i] = value
		end
	end
end
local StarterGui = game:GetService("StarterGui")
local clickBindable = Instance.new("BindableFunction")
clickBindable.OnInvoke = function(button)
	if button == 'OK' then
		delfile(foldername.."/ ".. GameId .."/"..filename)
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")
		local player = Players.LocalPlayer
		if player then
			TeleportService:Teleport(game.PlaceId, player)
		end
	end
	clickBindable:Destroy()
end
LoadSettings()
Client.Idled:connect(function()
	vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1)
	vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
local CloseChat = function()
	return nil
end
do 
	AllMaterial = {
		['Sea1'] = {
			['Rusted Scrap'] = {
				"Clown Swordman [Lv. 50]"
			},
			['Leather'] = {
				"Clown Pirates [Lv. 10]",
				"Commander [Lv. 100]"
			},
			['Fresh Fish'] = {
				"Karate Fishman [Lv. 200]",
				"Shark Man [Lv. 230]",
				"Karate Fishman [Lv. 200]"
			},
			["Thief's rag"] = {
				"Desert Marauder [Lv. 675]",
				"Sand Bandit [Lv. 575]",
				"King of Sand [Lv. 725]"
			},
			["Angellic's Feather"] = {
				"Ball Man [Lv. 850]",
				"Sky Soldier [Lv. 800]"
			},
			['Gunpowder'] = {
				"Naval personnel [Lv. 1200]",
				"Nautical soldier [Lv. 1350]",
				"Naval soldier [Lv. 1400]"
			},
			["Undead's Ooze"] = {
				"Zombie [Lv. 1500]",
				"Elite Zombie [Lv. 1550]",
				"Revenant [Lv. 1600]"
			},
			["Vampire's Vital fluid"] = {
				"Shadow Master [Lv. 1650]"
			},
			["Twilight's Orb"] = {
				"Shadow Master [Lv. 1650]"
			}
		},
		['Sea2'] = {
			['Carrot'] = {
				"Elite Beast Pirate [Lv. 2700]",
				"Beast Pirate [Lv. 2250]",
				"Powerful Beast Pirate [Lv. 2450]",
				"Bandit Beast Pirate [Lv. 2400]"
			},
			['Iron ingot'] = {
				"Elite Beast Pirate [Lv. 2700]",
				"Beast Pirate [Lv. 2250]",
				"Powerful Beast Pirate [Lv. 2450]",
				"Bandit Beast Pirate [Lv. 2400]"
			},
			["Samurai's Bandage"] = {
				"Violet Samurai [Lv. 2500]",
				"Kitsune Samurai [Lv. 2650]",
				"Kappa [Lv. 2950]"
			},
			['Ice Crystal'] = {
				"Azlan [Lv. 3300]"
			},
			['Magma Crystal'] = {
				"The Volcano [Lv. 3325]"
			},
			["Thief's rag"] = {
				"Desert Thief [Lv. 3125]"
			},
			['Lost Ruby'] = {
				"Anubis [Lv. 3150]"
			},
			["Lucidus's Totem"] = {
				"Pondere [Lv. 3525]",
				"Vice Admiral [Lv. 3500]",
				"Hefty [Lv. 3550]"
			},
			["Dark Beard's Totem"] = {
				"Dark Beard Servant [Lv. 3400]",
				"Supreme Swordman [Lv. 3425]",
				"Sally [Lv. 3450]",
			},
			['Pile of Bones'] = {
				"Skull Pirate [Lv. 3050]",
				"Elite Skeleton [Lv. 3100]",
			},
			["Dragon' Orb"] = {
				"Elite Skeleton [Lv. 3100]",
			},
			['Essence of fire'] = {
				"Flame User [Lv. 3200]"
			},
		},
		['Sea3'] = {
			["Shark's Fin"] = {
				"Fishman Guards [Lv. 4200]",
			},
			['Essence of fire'] = {
				"Inferno Diver [Lv. 4650]",
			},
			['Coral'] ={
				"Fugitive [Lv.4050]",
			},
			['Pearl'] ={
				"Fugitive [Lv.4050]",
			},
		}
	}
	QuestMaterial = {
		['3350'] = {
			['Material'] = 'Ice Crystal',
			['Kills'] = 'Azlan [Lv. 3300]',
			['QuestTitle'] = 'Kill 4 Azlan',
			['Level'] = 3300
		},
		['3375'] = {
			['Material'] = 'Magma Crystal',
			['Kills'] = 'The Volcano [Lv. 3325]',
			['QuestTitle'] = 'Kill 4 The Volcano',
			['Level'] = 3325
		},
		['3475'] = {
			['Material'] = "Dark Beard's Totem",
			['Kills'] = 'Sally [Lv. 3450]',
			['QuestTitle'] = 'Kill 1 Sally',
			['Level'] = 3450
		},
		['3575'] = {
			['Material'] = "Lucidus's Totem",
			['Kills'] = 'Vice Admiral [Lv. 3500]',
			['QuestTitle'] = 'Kill 5 Vice Admiral',
			['Level'] = 3500
		}
	}
	FF = {}
	t = {}
	DFLits = {}
	DailyQuestTable = {}
	for i,v in pairs(require(game:GetService("ReplicatedStorage").Chest.Modules.DFGiftRobux)) do
		table.insert(DFLits, i)
	end
	MaterialSea1 = {}
	for i,v in pairs(AllMaterial['Sea1']) do
		table.insert(MaterialSea1, i)
	end
	MaterialSea2 = {}
	for i,v in pairs(AllMaterial['Sea2']) do
		table.insert(MaterialSea2, i)
	end
	MaterialSea3 = {}
	for i,v in pairs(AllMaterial['Sea3']) do
		table.insert(MaterialSea3, i)
	end
end
do
	Char = Client.Character
	vu = game:GetService("VirtualUser")
	Sea1 = game.PlaceId == 4520749081 
	Sea2 =  game.PlaceId == 6381829480
	Sea3 = game.PlaceId == 15759515082
	InRaid = game.PlaceId == 5931540094
	NumSea = 0
	TitleSea = ""
	if Sea1 then
		NumSea = 1
		TitleSea = "Sea 1"
	elseif Sea2 then
		NumSea = 2
		TitleSea = "SecondSea"
	elseif Sea3 then
		NumSea = 3
		TitleSea = "Sea 3"
	end
	RespawnTime = 5
	RecentlySpawn = 0
	myWeapon = { ["Melee"] = "",  ["Sword"] = "",["Fruit"] = ""}
	addSkill = "?"
	queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
	request = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
	TeleportService = game:GetService("TeleportService")
	HttpService = game:GetService("HttpService")
	monsterPot = {
		["Soldier [Lv. 1]"] = CFrame.new(-1938.2655029296875, 49.9901123046875, -4537.6279296875),
		["Clown Pirate [Lv. 10]"] = CFrame.new(-1797.624755859375, 50.42641830444336, -4506.5888671875),
		["Smoky [Lv. 20]"] = CFrame.new(-2107.3642578125, 49.621116638183594, -4788.24853515625),
		["Tashi [Lv. 30]"] = CFrame.new(-2355.483642578125, 49.990108489990234, -4561.212890625),
		["Elite Zombie [Lv. 1550]"] = CFrame.new(-2789.22583, 15.8071957, 3992.1416, 0.876517415, -0, -0.481370181, 0, 1, -0, 0.481370181, 0, 0.876517415),
		["Zombie [Lv. 1500]"] = CFrame.new(-2651.12183, 15.8724337, 4063.79907, -0.481315136, 0, -0.876547575, 0, 1, 0, 0.876547575, 0, -0.481315136),
		["Revenant [Lv. 1600]"] = CFrame.new(-2931.4707, 20.1082973, 4209.03027, -0.876517773, 0, 0.481370181, 0, 1, 0, -0.481370181, 0, -0.876517773),
		["Shadow Master [Lv. 1650]"] = CFrame.new(-2762.20312, 20.1082973, 4362.58691, 0.481315196, 0, 0.876547575, 0, 1, 0, -0.876547575, 0, 0.481315196),
		["Commander [Lv. 100]"] = CFrame.new(-2228.49927, 49.1775322, -2641.9812, -0.999992132, 0, 0.00397080462, 0, 1, 0, -0.00397080462, 0, -0.999992132),
		["The Barbaric [Lv. 145]"] = CFrame.new(-2354.20703, 102.871887, -2477.68677, 0.396801293, 0, 0.917904556, 0, 1, 0, -0.917904556, 0, 0.396801293),
		["Captain [Lv. 120]"] = CFrame.new(-2194.55103, 49.1591415, -2466.27295, 0.917908311, -0, -0.39679262, 0, 1, -0, 0.39679262, 0, 0.917908311),
		["Clown Swordman [Lv. 50]"] = CFrame.new(-871.928162, 51.382988, -3468.08374, 0.613133192, -0, -0.789979577, 0, 1, -0, 0.789979577, 0, 0.613133192),
		["The Clown [Lv. 75]"] = CFrame.new(-456.58371, 73.724205, -3542.24292, -0.613133192, 0, 0.789979577, 0, 1, 0, -0.789979577, 0, -0.613133192),
		["Desert Marauder [Lv. 675]"] = CFrame.new(-2694.6438, 41.3204842, -601.154602, -0.146888629, 0, 0.989153206, 0, 1, 0, -0.989153206, 0, -0.146888629),
		["Sand Bandit [Lv. 575]"] = CFrame.new(-2918.80225, 41.3095436, -744.920288, 0.669109941, -0, -0.743163466, 0, 1, -0, 0.743163466, 0, 0.669109941),
		["Bomb Man [Lv. 625]"] = CFrame.new(-3061.60352, 92.1220322, -639.511353, 0.0228189845, 0, -0.999739647, 0, 1, 0, 0.999739766, 0, 0.0228189826),
		["Candle Man [Lv. 525]"] = CFrame.new(-2929.52002, 92.1304169, -493.22229, 0.985171437, -0, -0.171572819, 0, 1, -0, 0.171572819, 0, 0.985171437),
		["King of Sand [Lv. 725]"] = CFrame.new(-3088.7334, 96.9583893, -481.598022, 0.669109941, -0, -0.743163466, 0, 1, -0, 0.743163466, 0, 0.669109941),
		["Soldier Fishman [Lv. 2150]"] = CFrame.new(-1743.89148, 44.9945412, 6607.4873, 0.25875926, 0, 0.965941846, 0, 1, 0, -0.965941846, 0, 0.25875926),
		["Fishman [Lv. 2000]"] = CFrame.new(-1577.39526, 40.4922066, 6125.9209, -0.866007447, 0, 0.500031352, 0, 1, 0, -0.500031412, 0, -0.866007328),
		["Seasoned Fishman [Lv. 2200]"] = CFrame.new(-1865.43445, 45.2734604, 6722.85107, 0.965929627, 0, -0.258804768, 0, 1, 0, 0.258804798, 0, 0.965929568),
		["Combat Fishman [Lv. 2050]"] = CFrame.new(-1959.18079, 40.4917526, 6149.45801, -0.222916365, 0, -0.974837601, 0, 1, 0, 0.974837601, 0, -0.222916365),
		["Sword Fishman [Lv. 2100]"] = CFrame.new(-1502.49609, 40.4917488, 6698.15723, 0.866007268, -0, -0.500031412, 0, 1, -0, 0.500031412, 0, 0.866007268),
		["High-class Soldier [Lv. 1050]"] = CFrame.new(1528.86011, 17.8554668, 850.628357, 0.743457139, 0, 0.668783784, 0, 1, 0, -0.668783784, 0, 0.743457198),
		["Elite Soldier [Lv. 1000]"] = CFrame.new(1658.59839, 17.8554668, 876.416443, -0.590721786, 0, -0.806875169, 0, 1, 0, 0.806875169, 0, -0.590721786),
		["Pasta [Lv. 1150]"] = CFrame.new(1852.99268, 43.740715, 874.354553, 0.359550685, 0, 0.933125973, 0, 1, 0, -0.933125973, 0, 0.359550685),
		["Leader [Lv. 1100]"] = CFrame.new(1686.62683, 17.8557377, 737.273499, -0.806858182, 0, 0.59074682, 0, 1, 0, -0.59074676, 0, -0.806858301),
		["Minion"] = CFrame.new(1845.797, 43.6974335, 989.163025, -0.138637424, 0, 0.990343153, 0, 1, 0, -0.990343153, 0, -0.138637424),
		["Boss"] = CFrame.new(1872.797, 45.6248779, 954.163025, 0.55750668, 0, 0.830172479, 0, 1, 0, -0.830172479, 0, 0.55750668),
		["Cutlass Pirate [Lv. 1750]"] = CFrame.new(2076.62598, 7.95052242, -2040.71191, 0.392051369, 0, -0.919943869, 0, 1, 0, 0.919943929, 0, 0.392051369),
		["Rear Admiral [Lv. 1800]"] = CFrame.new(2331.73755, 55.0576286, -2167.06934, -1, 0, 0, 0, 1, 0, 0, 0, -1),
		["New World Pirate [Lv. 1700]"] = CFrame.new(2328.94263, 55.0575752, -1729.4364, -0.963031292, 0, -0.26938957, 0, 1, 0, 0.26938957, 0, -0.963031292),
		["True Karate Fishman [Lv. 1850]"] = CFrame.new(2333.49634, 55.0575981, -1937.72095, 0, 0, 1, 0, 1, -0, -1, 0, 0),
		["Quake Woman [Lv. 1925]"] = CFrame.new(2177.84839, 6.3174305, -1931.75208, -0.00341546535, 0, 0.999994159, 0, 1, 0, -0.999994159, 0, -0.00341546535),
		["Sky Soldier [Lv. 800]"] = CFrame.new(-4239.25098, 383.627625, 1324.44775, -0.944315553, 0, 0.329042405, 0, 1, 0, -0.329042405, 0, -0.944315553),
		["Cloud Warrior [Lv. 900]"] = CFrame.new(-4516.74707, 383.628296, 1355.80933, 0.799218535, -0, -0.601040542, 0, 1, -0, 0.601040542, 0, 0.799218535),
		["Ball Man [Lv. 850]"] = CFrame.new(-4863.36768, 441.400879, 1335.09753, 0.998014569, -0, -0.062983796, 0, 1, -0, 0.062983796, 0, 0.998014569),
		["Rumble Man [Lv. 950]"] = CFrame.new(-4816.02148, 441.399323, 1197.22339, -0.664600611, 0, -0.747198939, 0, 1, 0, 0.747198939, 0, -0.664600611),
		["Trainer Chef [Lv. 250]"] = CFrame.new(-4283.79883, 15.2736998, -3186.98193, 0.8819893, -0, -0.471269488, 0, 1, -0, 0.471269488, 0, 0.8819893),
		["Dory [Lv. 350]"] = CFrame.new(-4378.0376, 15.2898245, -2592.63477, 0.795978308, 0, -0.60532546, 0, 1, 0, 0.60532546, 0, 0.795978248),
		["Dark Leg [Lv. 300]"] = CFrame.new(-4235.36719, 18.0044079, -2860.39014, 0.880348146, -0, -0.47432813, 0, 1, -0, 0.47432813, 0, 0.880348146),
		["Fighter Fishman [Lv. 180]"] = CFrame.new(-822.877319, 23.0661411, -1519.73474, -0.953755021, 0, 0.300585002, 0, 1, 0, -0.300585002, 0, -0.953755021),
		["Karate Fishman [Lv. 200]"] = CFrame.new(-889.472412, 23.0661411, -1526.54822, -0.667140841, 0, -0.744931638, 0, 1, 0, 0.744931638, 0, -0.667140841),
		["Shark Man [Lv. 230]"] = CFrame.new(-615.809021, 24.8977966, -1574.07483, 0.58861047, 0, 0.808416784, 0, 1, 0, -0.808416784, 0, 0.58861047),
		["Naval personnel [Lv. 1200]"] = CFrame.new(-1311.34045, 20.9497528, 2222.91309, -1, 0, 0, 0, 1, 0, 0, 0, -1),
		["Naval soldier [Lv. 1400]"] = CFrame.new(-1352.56116, 7.65845919, 2566.44458, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Nautical soldier [Lv. 1350]"] = CFrame.new(-1081.04932, 20.9442577, 2173.31152, -0.999991417, 0, -0.00414344762, 0, 1, 0, 0.00414344762, 0, -0.999991417),
		["Leo [Lv. 1450]"] = CFrame.new(-1161.16113, 7.65845919, 2519.49658, 0, 0, 1, 0, 1, -0, -1, 0, 0),
		["Giraffe [Lv. 1300]"] = CFrame.new(-1081.19861, 20.9497566, 2056.34912, 0, 0, 1, 0, 1, -0, -1, 0, 0),
		["Wolf [Lv. 1250]"] = CFrame.new(-1418.70764, 20.9497547, 2107.16064, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["Snow Soldier [Lv. 400]"] = CFrame.new(-5425.90576, 28.9225521, -1190.73608, 0.631957054, 0.000152036344, -0.775003374, -3.91563663e-06, 1, 0.000192982174, 0.775003374, -0.000118921809, 0.631957054),
		["King Snow [Lv. 450]"] = CFrame.new(-5420.73486, 28.9310017, -1512.58521, -0.997069001, 0, 0.0765115097, 0, 1, 0, -0.0765115097, 0, -0.997069001),
		["Little Dear [Lv. 500]"] = CFrame.new(-5318.77051, 21.3643284, -1105.60718, 0.750579536, 0, 0.660780132, 0, 1, 0, -0.660780132, 0, 0.750579536),
		["Gazelle Man [Lv. 2350]"] = CFrame.new(-4352.5293, 57.4362717, 351.498688, 0.515122414, 0, -0.857116818, 0, 1, 0, 0.857116818, 0, 0.515122414),
		["Beast Swordman [Lv. 2300]"] = CFrame.new(-4071.53516, 98.5303879, -363.117371, 0.0704936981, -0, -0.997512221, 0, 1, -0, 0.997512221, 0, 0.0704936981),
		["Beast Pirate [Lv. 2250]"] = CFrame.new(-4083.30859, 57.4468498, 62.3574524, 0.972028613, 0, 0.234862581, 0, 1, 0, -0.234862581, 0, 0.972028613),
		["Elite Skeleton [Lv. 3100]"] = CFrame.new(-5892.70898, 98.6613922, 7244.94385, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Bear Man [Lv. 2750]"] = CFrame.new(-4407.75146, 29.352726, 912.104736, -0.731005847, 0, 0.682372808, 0, 1, 0, -0.682372808, 0, -0.731005847),
		["Bean [Lv. 2800]"] = CFrame.new(-4097.95703, 29.3527241, 1068.71606, -0.0390424803, 0, 0.999237835, 0, 1, 0, -0.999237835, 0, -0.0390424803),
		["Magician [Lv. 2600]"] = CFrame.new(-4921.67725, 57.4362717, -133.051682, -0.933304012, 0, -0.359086961, 0, 1, 0, 0.359086961, 0, -0.933304012),
		["Powerful Beast Pirate [Lv. 2450]"] = CFrame.new(-4656.84229, 135.983505, -677.437805, 0.996259332, 0, 0.0864137262, 0, 1, 0, -0.0864137262, 0, 0.996259332),
		["Bandit Beast Pirate [Lv. 2400]"] = CFrame.new(-4454.60742, 135.991943, -990.836426, 0.97968632, 0, -0.200535655, 0, 1, 0, 0.200535655, 0, 0.97968632),
		["Violet Samurai [Lv. 2500]"] = CFrame.new(-5115.22021, 85.7235947, -1014.93927, -0.99116385, 0, -0.132641897, 0, 1, 0, 0.132641897, 0, -0.99116385),
		["Duke [Lv. 2550]"] = CFrame.new(-5516.89014, 99.888176, -270.133698, -1, 0, 0, 0, 1, 0, 0, 0, -1),
		["Kitsune Samurai [Lv. 2650]"] = CFrame.new(-5503.09033, 100.305733, 39.4565315, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["Meji [Lv. 2850]"] = CFrame.new(-5363.93506, 57.4320679, 1086.57812, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Petra [Lv. 2900]"] = CFrame.new(-5738.5542, 57.4320679, 1245.74536, 0.00341540575, -0, -0.999994159, 0, 1, -0, 0.999994159, 0, 0.00341540575),
		["Elite Beast Pirate [Lv. 2700]"] = CFrame.new(-4619.33838, 29.3027363, 1237.81311, -0.887911141, 0, 0.460017413, 0, 1, 0, -0.460017413, 0, -0.887911141),
		["Kappa [Lv. 2950]"] = CFrame.new(-4845.67432, 57.4362717, 2008.89441, -0.999994159, 0, -0.00336655322, 0, 1, 0, 0.00336655322, 0, -0.999994159),
		["Dragon [Lv. 5000]"] = CFrame.new(-5876.89258, 452.774353, 7665.27246, 0.902560592, 0, 0.430562854, 0, 1, 0, -0.430562854, 0, 0.902560592),
		["Joey [Lv. 3000]"] = CFrame.new(-5198.30566, 57.4362717, 2060.62207, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["Minion"] = CFrame.new(-5796.11719, 86.2090912, 893.690979, -0.960622549, 0, 0.277856469, 0, 1, 0, -0.277856469, 0, -0.960622549),
		["Boss"] = CFrame.new(-5808.00928, 88.0514832, 906.396606, 0.483159244, -0.000966370862, -0.875531971, 0.000966370862, 0.999999344, -0.000570463715, 0.875531971, -0.000570463715, 0.4831599),
		["Dough Master [Lv. 3275]"] = CFrame.new(30326.0762, 24.8858681, 93404.9062, 0.964679062, 0, 0.263428092, 0, 1, 0, -0.263428092, 0, 0.964679062),
		["Azlan [Lv. 3300]"] = CFrame.new(-809.533447, 56.9929924, -2709.21802, 0.498836577, -0, -0.86669606, 0, 1, -0, 0.86669606, 0, 0.498836577),
		["The Volcano [Lv. 3325]"] = CFrame.new(-70.0344467, 130.43222, -3565.27393, 0.668266773, -0, -0.743921757, 0, 1, -0, 0.743921757, 0, 0.668266773),
		["Vice Admiral [Lv. 3500]"] = CFrame.new(-9949.1416, 37.9372559, 601.663147, -0.999625921, 0, -0.0273615234, 0, 1, 0, 0.0273615234, 0, -0.999625921),
		["Pondere [Lv. 3525]"] = CFrame.new(-10077.7842, 37.828701, 1411.36133, 0.69566083, -0, -0.718370378, 0, 1, -0, 0.718370378, 0, 0.69566083),
		["Fiore Fighter [Lv. 3625]"] = CFrame.new(5282.61816, 71.8926849, -2491.41064, -0.407749772, 0, -0.913094103, 0, 1, 0, 0.913094103, 0, -0.407749772),
		["Fiore Gladiator [Lv. 3600]"] = CFrame.new(5224.81348, 71.8926849, -2852.61426, 0.368119061, -0, -0.929778576, 0, 1, -0, 0.929778576, 0, 0.368119061),
		["Fiore Pirate [Lv. 3650]"] = CFrame.new(5995.33691, 71.8926849, -3129.45215, -0.640278697, 0, -0.768143177, 0, 1, 0, 0.768143177, 0, -0.640278697),
		["Lomeo [Lv. 3675]"] = CFrame.new(6623.50488, 73.1001358, -2153.8457, -0.100727081, 0, 0.994914114, 0, 1, 0, -0.994914114, 0, -0.100727081),
		["Devastate [Lv. 3725]"] = CFrame.new(7425.17529, 81.5684357, -2543.26416, 0.396896064, 0, 0.917863548, 0, 1, 0, -0.917863548, 0, 0.396896064),
		["Floffy [Lv. 3775]"] = CFrame.new(7897.11963, 452.951691, -2397.4585, 0.907340109, 0, 0.420397371, 0, 1, 0, -0.420397371, 0, 0.907340109),
		["Prince Aria [Lv. 3700]"] = CFrame.new(6859.66699, 150.065475, -3715.26245, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909),
		["Physicus [Lv. 3750]"] = CFrame.new(8017.04639, 178.497406, -4311.56934, -0.982889652, 0, 0.184195086, 0, 1, 0, -0.184195086, 0, -0.982889652),
		["Dead Troupe [Lv. 3800]"] = CFrame.new(9514.68359, 71.9882507, -4183.10107, 0.980187833, 0, 0.198070183, 0, 1, 0, -0.198070183, 0, 0.980187833),
		["Ryu [Lv. 3975]"] = CFrame.new(9953.72266, 71.9659195, -4682.64795, -0.147114038, 0, 0.989119589, 0, 1, 0, -0.989119589, 0, -0.147114038),
		["Dead Troupe Captain [Lv. 3850]"] = CFrame.new(10242.4277, 71.9659195, -4124.33643, -0.824617147, 0, 0.565691829, 0, 1, 0, -0.565691829, 0, -0.824617147),
		["Skull Pirate [Lv. 3050]"] = CFrame.new(-6375.71387, 58.2057152, 6227.89355, -0.440631479, 0, -0.897687972, 0, 1, 0, 0.897687972, 0, -0.440631479),
		["Hefty [Lv. 3550]"] = CFrame.new(-10793.5664, 83.411087, 968.418335, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["Dark Beard Servant [Lv. 3400]"] = CFrame.new(-9253.66113, 59.3366013, -4593.94824, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Supreme Swordman [Lv. 3425]"] = CFrame.new(-9682.13965, 59.3449936, -4557.25195, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Sally [Lv. 3450]"] = CFrame.new(-9598.53613, 59.371769, -5271.25391, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["Anubis [Lv. 3150]"] = CFrame.new(2107.67383, 18.1082363, 961.752563, -0.981289029, 0, 0.192540601, 0, 1, 0, -0.192540601, 0, -0.981289029),
		["Desert Thief [Lv. 3125]"] = CFrame.new(1386.36902, 14.566987, 1431.29907, 0.946567714, 0, 0.322505146, 0, 1, 0, -0.322505146, 0, 0.946567714),
		["Flame User [Lv. 3200]"] = CFrame.new(2031.16675, 14.5540771, 1354.40967, -0.0956259966, 0, 0.995417356, 0, 1, 0, -0.995417356, 0, -0.0956259966),
		["Pharaoh [Lv. 3175]"] = CFrame.new(1886.95374, 52.4840164, 1713.79773, 0.576146007, -0, -0.817346811, 0, 1, -0, 0.817346811, 0, 0.576146007),
		["Wilderness Gorilla [Lv. 4325]"] = CFrame.new(4713.2915, 45.9615059, 10027.7393, 0.227107644, -0, -0.973869681, 0, 1, -0, 0.973869681, 0, 0.227107644),
		["Fishman Guardian [Lv. 4150]"] = CFrame.new(1779.84155, 35.7863388, 295.48291, 0.353282869, -0, -0.935516536, 0, 1, -0, 0.935516536, 0, 0.353282869),
		["Tidal Warrior [Lv. 4450]"] = CFrame.new(-69.491478, 85.7819901, -8250.5918, 0.527286053, 0, 0.849687874, 0, 1, 0, -0.849687874, 0, 0.527286053),
		["Ripcurrent Raider [Lv. 4400]"] = CFrame.new(-727.171143, -0.25442481, -8676.30176, -0.985774636, 0, -0.168072283, 0, 1, 0, 0.168072283, 0, -0.985774636),
		["Abyssal Swordsman [Lv. 4750]"] = CFrame.new(-8249.53223, 178.978973, 234.335327, 0.589236498, -0, -0.807960689, 0, 1, -0, 0.807960689, 0, 0.589236498),
		["Jungle Gorilla [Lv. 4300]"] = CFrame.new(4301.4082, 45.8396301, 9286.09863, 0.264738023, 0, -0.964320362, 0, 1, 0, 0.964320362, 0, 0.264738023),
		["Dummy Regen"] = CFrame.new(2346.25317, 377.368469, 10580.1475, 0.472131133, 0, 0.881528318, 0, 1, 0, -0.881528318, 0, 0.472131133),
		["Jungle Ape [Lv. 4350]"] = CFrame.new(5294.69775, 46.0493813, 9550.98145, 0.00195235002, 0, -0.999998093, 0, 1, 0, 0.999998093, 0, 0.00195235002),
		["Cyborg Gorilla [Lv. 4375]"] = CFrame.new(5877.31689, 45.9800491, 9377.1377, -0.115598917, 0, 0.993295968, 0, 1, 0, -0.993295968, 0, -0.115598917),
		["Minion"] = CFrame.new(3926.98706, 46.1233559, 11016.6387, -0.927014589, 0, 0.375025213, 0, 1, 0, -0.375025213, 0, -0.927014589),
		["Boss"] = CFrame.new(3912.98706, 47.8118591, 10984.6387, -0.953941345, 0, -0.299993038, 0, 1, 0, 0.299993038, 0, -0.953941345),
		["Deepfire Combatant [Lv. 4550]"] = CFrame.new(-5075.45996, 23.1201668, -50.5900536, -0.999481618, 0, -0.0321939401, 0, 1, 0, 0.0321939401, 0, -0.999481618),
		["Inferno Diver [Lv. 4650]"] = CFrame.new(-5905.98584, 22.7747993, 439.847412, -0.0528740883, 0, -0.998601198, 0, 1, 0, 0.998601198, 0, -0.0528740883),
		["Electro Abyss Warrior [Lv. 4600]"] = CFrame.new(-5146.31592, 22.7747993, 1065.25537, 0.995012462, 0, 0.0997499526, 0, 1, 0, -0.0997499526, 0, 0.995012462),
		["Tempest Tidebreaker [Lv. 4700]"] = CFrame.new(-7406.17627, 42.5638351, 503.945374, 0.854742408, -0, -0.519052505, 0, 1, -0, 0.519052505, 0, 0.854742408),
		["Fishman King's Guard [Lv. 4250]"] = CFrame.new(1942.78271, 35.7138901, -251.114716, 0.671773016, 0, -0.740757287, 0, 1, 0, 0.740757287, 0, 0.671773016),
		["Lord of Saber [Lv. 8500]"] = CFrame.new(1541.40796, 289.019043, -1164.43665, 0, 0, -1, 0, 1, 0, 1, 0, 0),
		["The deep one [Lv. 4200]"] = CFrame.new(2929.89258, 35.7716904, 84.7306671, -0.369380146, 0, 0.929278553, 0, 1, 0, -0.929278553, 0, -0.369380146),
		["Deep Diver [Lv. 4000]"] = CFrame.new(1625.37769, 35.7500153, 989.33252, 0.312101781, 0, 0.950048685, 0, 1, 0, -0.950048685, 0, 0.312101781),
		["Deep one Villager [Lv. 4100]"] = CFrame.new(3338.16089, 203.650482, 848.167725, -0.449453235, 0, -0.893304229, 0, 1, 0, 0.893304229, 0, -0.449453235),
		["Fugitive [Lv. 4050]"] = CFrame.new(2838.67188, 35.9670029, 1114.6604, 0.585472524, 0, 0.810692251, 0, 1, 0, -0.810692251, 0, 0.585472524),
		["Jack o lantern [Lv. 10000]"] = CFrame.new(2758.08179, 81.05233, 5074.54834, -0.712657332, 0, 0.701512218, 0, 1, 0, -0.701512218, 0, -0.712657332),
		['Rogue Prisoner [Lv. 4825]'] = CFrame.new(11072.8720703125, 78.40628814697266, 169.3360137939453),
		['Prisoner Buccaneer [Lv. 4850]'] = CFrame.new(11624.0673828125, 79.29161071777344, 543.0653076171875),
		['Prisoner of Gravity [Lv. 4875]'] = CFrame.new(12296.998046875, 79.28910064697266, 955.4613647460938),
		['Obsidian Seeker [Lv. 5000]'] = CFrame.new(-7720.30078125, 99.53910827636719, 11780.224609375),
		['Forgotten Delver [Lv. 5050]'] = CFrame.new(-8495.833984375, 100.62565612792969, 10727.0263671875),
		['Blackreach Scout [Lv. 5100]'] = CFrame.new(-8317.6650390625, 49.42082595825195, 12689.0908203125),
		['Nightbound Explorer [Lv. 5150]'] = CFrame.new(-8556.078125, 98.5545654296875, 11326.00390625),
		['Ruinstep Nomad [Lv. 5200]'] = CFrame.new(-8816.23046875, 50.390647888183594, 13225.537109375),
		['Ancient Wayfarer [Lv. 5250]'] = CFrame.new(-9131.97265625, 49.089298248291016, 11791.2294921875),
		['Depths Voyager [Lv. 5300]'] = CFrame.new(-9904.560546875, 52.18997573852539, 12271.849609375),
		['Allosaurus [Lv. 5350]'] = CFrame.new(-10548.89453125, 133.9193572998047, 12148.3388671875),
		['Spinosaurus [Lv. 5400]'] = CFrame.new(-10611.544921875, 118.8052978515625, 10424.27734375),
	}
	MonsterList = {}
	for bossId, bossData in pairs(monsterPot) do
		local levelStr = bossId:match("Lv. (%d+)")
		local level = levelStr and tonumber(levelStr)
		if level then
			if (level >= 1 and level <= 2250 and Sea1) or 
				(level >= 2000 and level <= 4000 and Sea2) or 
				(level >= 4000 and Sea3) then
				table.insert(MonsterList, bossId)
			end
		end
	end
end
if InRaid then
	game:GetService("ReplicatedStorage"):WaitForChild("ChooseMapRemote"):FireServer(Config["Select Difficulty"] or "Normal")
end
if Sea1 then
	DailyQuestTable = {'Forget and Forgot', 'Venture Lagoons!', 'Kill 4 King Snow', 'Kill 10 Soldier Fishman', 'Find Chicken Quest'}
elseif Sea2 then
	DailyQuestTable = {'Box Box', 'Disobey', 'Daily Quest [Lv. 3000]', 'Daily Quest [Lv. 3500]', 'Dead Above', 'Daily Quest [Lv. 3800]', 'Lore Sea Madness', 'Lore Sea Sick!', 'Lore Sea Diving', 'Lore Sea Creature'}
elseif Sea3 then
	DailyQuestTable = {'Lore Puzzle First','Lore Lost Fugitive', 'Lore Kraken Codex Easy', 'Lore Kraken Codex Hard', 'Lore Into the Bubble-Verse', 'Lore The Pillar', 'Lore the Depth'}
end
do
	GUI = Client.PlayerGui
	Repli = game:GetService("ReplicatedStorage")
	QuestManager = Repli.Chest.Modules.QuestManager
end
do
	task.spawn(function()
		while task.wait(1.5) do
			pcall(function()
				if Client.Character and Client.Character.Services and Client.Character.Services.Haki and Client.Character.Services.Haki.Value ~= 1 then
					game:GetService("ReplicatedStorage").Chest.Remotes.Events.Armament:FireServer()
					task.wait(1.5)
				end
			end)
		end
	end)
	task.spawn(function()
		local _noclipClock = 0
		while task.wait(0.05) do
			pcall(function()
				local _now = os.clock()
				if _G.NeedNoClip then
					local _char = Client and Client.Character
					if not _char then return end
					local _hum = _char:FindFirstChild("Humanoid")
					if _hum and _hum.Sit then _hum.Sit = false end
					if _now - _noclipClock >= 0.15 then
						_noclipClock = _now
						for _, v in ipairs(_char:GetDescendants()) do
							if v:IsA("BasePart") then v.CanCollide = false end
						end
					end
					local _torso = _char:FindFirstChild("UpperTorso")
					if not _torso then return end
					local _clip = _torso:FindFirstChild("BodyClip")
					if not _clip then
						local Noclip = Instance.new("BodyVelocity")
						Noclip.Name = "BodyClip"
						Noclip.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						Noclip.Velocity = Vector3.new(0, 1, 0)
						Noclip.Parent = _torso
					else
						_clip.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						_clip.Velocity = Vector3.new(0, 0, 0)
					end
				else
					local _char = Client and Client.Character
					if _char then
						local _torso = _char:FindFirstChild("UpperTorso")
						if _torso then
							local _clip = _torso:FindFirstChild("BodyClip")
							if _clip then _clip:Destroy() end
						end
					end
				end
			end)
		end
	end)
end
local playerTool;
local playerToolTip;
getTool = function()
	for _i, _v in pairs(Client.Character:GetChildren()) do
		if _v:IsA("Tool") then
			if _v.ToolTip == "Fruit Power" then
				addSkill = "DF"
			end
			playerTool = tostring(_v.Name)
			playerToolTip = _v.ToolTip
		end
	end
	return playerTool
end
local Item = {}
Item.CheckOnCooldown = function(Skill)
	getTool()
	local sk = string.upper(Skill) or "Z"
	local SkillCooldown = Client.PlayerGui:FindFirstChild("SkillCooldown")
	if not SkillCooldown then return false end
	if playerToolTip == "Sword" then
		local SwordFrame = SkillCooldown:FindFirstChild("SWFrame")
		if not SwordFrame or not SwordFrame:FindFirstChild(sk) then return true end
		local slot = SwordFrame[sk]
		if slot.Frame.Frame.Size.X.Scale < 0.73 and not slot:FindFirstChild("Locked").Visible then
			return slot.Frame.Frame.AbsoluteSize.X > 0
		end
	elseif playerToolTip == "Combat" then
		local FSFrame = SkillCooldown:FindFirstChild("FSFrame")
		if not FSFrame or not FSFrame:FindFirstChild(sk) then return true end
		local slot = FSFrame[sk]
		if slot.Frame.Frame.Size.X.Scale < 0.73 and not slot:FindFirstChild("Locked").Visible then
			return slot.Frame.Frame.AbsoluteSize.X > 0
		end
	elseif playerToolTip == "Fruit Power" then
		local FruitFrame = SkillCooldown:FindFirstChild("DFFrame")
		if not FruitFrame or not FruitFrame:FindFirstChild(sk) then return true end
		local slot = FruitFrame[sk]
		if slot.Frame.Frame.Size.X.Scale < 0.73 and not slot:FindFirstChild("Locked").Visible then
			return slot.Frame.Frame.AbsoluteSize.X > 0
		end
	end
	return false
end
Item.CheckSkillLock = function(Skill)
	getTool()
	local sk = string.upper(Skill) or "Z"
	local SkillCooldown = Client.PlayerGui:FindFirstChild("SkillCooldown")
	if not SkillCooldown then return true end
	if playerToolTip == "Sword" then
		local SwordFrame = SkillCooldown:FindFirstChild("SWFrame")
		if not SwordFrame or not SwordFrame:FindFirstChild(sk) then return true end
		if not SwordFrame[sk]:FindFirstChild("Locked").Visible then return false end
	elseif playerToolTip == "Combat" then
		local FSFrame = SkillCooldown:FindFirstChild("FSFrame")
		if not FSFrame or not FSFrame:FindFirstChild(sk) then return true end
		if not FSFrame[sk]:FindFirstChild("Locked").Visible then return false end
	elseif playerToolTip == "Fruit Power" then
		local FruitFrame = SkillCooldown:FindFirstChild("DFFrame")
		if not FruitFrame or not FruitFrame:FindFirstChild(sk) then return true end
		if not FruitFrame[sk]:FindFirstChild("Locked").Visible then return false end
	end
	return true
end
local getFarthestEffectFromPlayer = function()
	local character = Client.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return nil, 0 end
	local origin = character.HumanoidRootPart.Position
	local farthestObject = nil
	local maxDistance = 0
	for _, obj in ipairs(workspace.Effects:GetDescendants()) do
		local objPosition = nil
		if obj:IsA("BasePart") then
			objPosition = obj.Position
		elseif obj:IsA("Model") then
			local success, cframe = pcall(function()
				return obj:GetPivot()
			end)
			if success then
				objPosition = cframe.Position
			end
		end
		if objPosition then
			local distance = (objPosition - origin).Magnitude
			if distance > maxDistance then
				maxDistance = distance
				farthestObject = obj
			end
		end
	end
	return farthestObject, maxDistance
end
tp = function(options)
	if not Client.Character or Client.Character.Humanoid.Health <= 0 then return end
	local Character = Client.Character
	local HRP = Character:FindFirstChild("HumanoidRootPart")
	if not HRP then return end
	local Humanoid = Character:FindFirstChild("Humanoid")
	if Humanoid and Humanoid.Sit then
		Humanoid.Sit = false
	end
	for _, v in ipairs(Character:GetDescendants()) do
		if v:IsA("BasePart") or v:IsA("MeshPart") then
			v.CanCollide = false
		end
	end
	local farthest, _ = getFarthestEffectFromPlayer()
	_G.NeedNoClip = true
	local targetCFrame = options.Target or nil
	local modCFrame = options.Mod or CFrame.new(0, 0, 0)
	if not targetCFrame then
		warn("Target CFrame is missing.")
		return
	end
	if Config['Auto New Clear Dungeon'] then
		local shouldUseFarthest = false
		if farthest then
			if farthest:IsA("BasePart") then
				if dist(farthest.Position) < 300 then
					shouldUseFarthest = true
				end
			elseif farthest:IsA("Model") then
				local success, cframe = pcall(function()
					return farthest:GetPivot()
				end)
				if success and dist(cframe.Position) < 300 then
					shouldUseFarthest = true
				end
			end
		end	
		if shouldUseFarthest and farthest then
			local targetPos = nil
			if farthest:IsA("BasePart") then
				targetPos = farthest.CFrame
			elseif farthest:IsA("Model") then
				local success, cframe = pcall(function()
					return farthest:GetPivot()
				end)
				if success then
					targetPos = cframe
				end
			end
			if targetPos then
				HRP.CFrame = targetPos * CFrame.new(-300, 0, 0)
				return
			end
		end
	end
	HRP.CFrame = targetCFrame * modCFrame
end
function sendwebhook(url, data)
	local HttpService = game:GetService("HttpService")
	local success, newdata = pcall(function()
		return HttpService:JSONEncode(data)
	end)
	if not success then
		print("Error encoding data to JSON:", newdata)
		return
	end
	local headers = {
		["Content-Type"] = "application/json"
	}
	local success, response = pcall(function()
		return request({
			Url = url,
			Body = newdata,
			Method = "POST",
			Headers = headers
		})
	end)
	return successF
end
EquipTools = function(ToolSe)
	if Client.Backpack:FindFirstChild(ToolSe) then
		local Tool = Client.Backpack:FindFirstChild(ToolSe)
		Client.Character.Humanoid:EquipTool(Tool)
	end
end
UnEquipTools = function(Weapon)
	local _w = Client.Character:FindFirstChild(Weapon)
	if _w then
		task.wait(0.5)
		_w.Parent = Client.Backpack
		task.wait(0.1)
	end
end
Attack = function()
	if Client.PlayerGui:FindFirstChild('EatFruitBecky') and Config['Auto Store Fruit'] then return end
	if Config['Select Weapon'] == "Melee" then
		addSkill = "FS"
		Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("FS_".._G.Weapon.."_M1")
		EquipTools(_G.Weapon)
	elseif Config['Select Weapon'] == "Sword" then
		addSkill = "SW"
		Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("SW_".._G.Weapon.."_M1")
	elseif Config['Select Weapon'] == "Melee&Sword" then
		addSkill = "SW"
		delay(.1, function()
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("SW_"..myWeapon["Sword"].."_M1")
		end)
		Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("FS_"..myWeapon["Melee"].."_M1")
		EquipTools(myWeapon["Sword"])
	elseif Config['Select Weapon'] == "Fruit" then
		EquipTools(myWeapon["Fruit"])
	elseif Config['Select Weapon'] == "Melee&Fruit" then
		Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("FS_"..myWeapon["Melee"].."_M1")
		EquipTools(myWeapon["Fruit"])
	elseif Config['Select Weapon'] == "Sword&Fruit" then
		local t = tick() % 1.0
		local doEquip = (t < 0.5) and myWeapon["Sword"] or myWeapon["Fruit"]
		if doEquip and doEquip ~= "" then
			EquipTools(doEquip)
		end
		if myWeapon["Sword"] and myWeapon["Sword"] ~= "" then
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("SW_"..myWeapon["Sword"].."_M1")
		end
		if myWeapon["Fruit"] and myWeapon["Fruit"] ~= "" then
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("DF_"..myWeapon["Fruit"].."_M1")
		end
	elseif Config['Select Weapon'] == "All for One" then
		local t = tick() % 1.5
		local doEquip = ""
		if t < 0.5 then
			doEquip = myWeapon["Melee"]
		elseif t < 1.0 then
			doEquip = myWeapon["Sword"]
		else
			doEquip = myWeapon["Fruit"]
		end
		if doEquip and doEquip ~= "" then
			EquipTools(doEquip)
		end
		if myWeapon["Melee"] and myWeapon["Melee"] ~= "" then
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("FS_"..myWeapon["Melee"].."_M1")
		end
		if myWeapon["Sword"] and myWeapon["Sword"] ~= "" then
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("SW_"..myWeapon["Sword"].."_M1")
		end
		if myWeapon["Fruit"] and myWeapon["Fruit"] ~= "" then
			Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("DF_"..myWeapon["Fruit"].."_M1")
		end
	else
		Repli.Chest.Remotes.Functions.SkillAction:InvokeServer("FS_".._G.Weapon.."_M1")
	end;if Config['Select Weapon'] == nil and Config['Select Weapon'] ~= "Melee&Sword" and Config['Select Weapon'] ~= "Sword&Fruit" and Config['Select Weapon'] ~= "All for One" then
		EquipTools(_G.Weapon)
	end
	if myWeapon["Fruit"] == 'DragonDragon' then
		game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("SkillAction"):InvokeServer('DF_DragonDragon_M1')
	end
	
	local sel = Config['Select Weapon']
	if sel ~= "Sword&Fruit" and sel ~= "All for One" then
		local equippedTool = Client.Character:FindFirstChildOfClass("Tool")
		if equippedTool then
			equippedTool.Parent = Client.LocalPlayer.Backpack
		end
	end
	if _G.Debug then
		warn('[DEBUG]', 'NOW ATTACK')
	end
end
UseSkillRemote = function(Skill, SkillPos, Delaysend, TypeTool)
	local Tool = Client.Character and Client.Character:FindFirstChildOfClass("Tool")
	if not Tool then return end
	local SkillPos = SkillPos or Client.Character:FindFirstChild("HumanoidRootPart").CFrame
	local TypeSkill = "SW"
	if Tool.ToolTip == "Fruit Power" then
		TypeSkill = "DF"
	elseif Tool.ToolTip == "Combat" then
		TypeSkill = "FS"
	end
	Repli.Chest.Remotes.Functions.SkillAction:InvokeServer(TypeSkill.."_"..Tool.Name.."_"..Skill,{
		["Type"] = "Up",
		["MouseHit"] = SkillPos * CFrame.Angles(-0, 0, -0)
	})
	task.wait(Delaysend or 0)
	Repli.Chest.Remotes.Functions.SkillAction:InvokeServer(TypeSkill.."_"..Tool.Name.."_"..Skill,{
		["Type"] = "Down",
		["MouseHit"] = SkillPos * CFrame.Angles(-0, 0, -0)
	})
end
useSkill = function()
	if Config['Auto Use Skill'] and Client.Character.Humanoid.Health > 0 then
		for _i, _v in next,Config['Select Skill'] do
			if _v == "V" and Client.Character:FindFirstChild("Dragon") then return end
			if type(_v) == 'string' and not Item.CheckOnCooldown(_v) and not Item.CheckSkillLock(_v) then
				game:service('VirtualInputManager'):SendKeyEvent(true, _v, false, game)
				game:service('VirtualInputManager'):SendKeyEvent(false, _v, false, game)
			end
		end
	end
end
click = function(t)
	for i = 1, t or 3 do
		game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
		game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
	end
end
dist = function(a,b,noHeight)
	local Character = Client and Client.Character
	if not b then
		b = Character.HumanoidRootPart.Position
	end
	return (Vector3.new(a.X,not noHeight and a.Y,a.Z) - Vector3.new(b.X,not noHeight and b.Y,b.Z)).magnitude
end
local function GetIsland(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end
	local ReturnValue
	local CheckInOut = math.huge;
	for i,v in pairs(workspace.Island:GetChildren()) do
		if v:IsA("Model") then
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude < CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue = v.Name
			end
		end
	end
	if ReturnValue then
		return ReturnValue
	end
end
local getIslandResults = {}
local function getNPCPos(Pos)
	for _, v in pairs(workspace.AllNPC:GetChildren()) do
		local islandName = GetIsland(v.CFrame)
		local playerIslandName = GetIsland(Pos)
		if islandName == playerIslandName then
			if not getIslandResults[islandName] then
				getIslandResults[islandName] = {}
			end
			table.insert(getIslandResults[islandName], v.CFrame)
		end
	end
end
local tpToPos = function(Data, NpcPos)
	if Data['LevelRequired'] == 3250 then
		tp({Target = CFrame.new(-1383.8770751953125, 202.27455139160156, 8899.5986328125) * CFrame.new(0, 20, 0)})
	elseif Data['LevelRequired'] == 3750 then
		tp({Target = workspace.Island["H - Fiore"].Lab.Lab.Base.CFrame * CFrame.new(0, 20, 0)})
	elseif Data['LevelRequired'] == 3775 then
		tp({Target = workspace.Island["H - Fiore"].Italian.Base.Mountain.Model:GetChildren()[9].CFrame * CFrame.new(0, 20, 0)})
	elseif Data['LevelRequired'] == 4750 then
		tp({Target = workspace.Island["Forgotten Coliseum"].Vacuus.Base:GetChildren()[179].CFrame * CFrame.new(0, 20, 0)})
	else
		getNPCPos(NpcPos)
		loadIslandForAllNPCs(GetIsland(NpcPos), Data['Mob'])
	end
end
local Tween = function(target)
	local tweenService = game:GetService('TweenService')
	local Distance = (target.Position - Client.Character.HumanoidRootPart.Position).Magnitude
	if Client and Client.Character and Client.Character:FindFirstChild("HumanoidRootPart") then
		local humanoidRootPart = Client.Character.HumanoidRootPart
		local tween = tweenService:Create(
			humanoidRootPart,
			TweenInfo.new(Distance/9000, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{CFrame = target}
		)
		tween:Play()
		tween.Completed:Wait()
	else
		warn("HumanoidRootPart not found on Client's character")
	end
end
TackTime = tick()
local LLAL = 0
getQuestOld = function(Position, UiName, doeswarp, die)
	doeswarp = doeswarp or true
	if Position == nil then if Sea1 then Position = "Elite Pirate" elseif Sea3 then Position = "The Squid" end end
	if UiName == 1 and Sea2 then Position = "Elite Pirate" end
	if UiName == 3 and Sea2 then Position = "The Squid" end
	if Position == "Elite Pirate" then
		Position = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame
	elseif Position == "The Squid" then
		Position = workspace.AllNPC:FindFirstChild("The Squid").CFrame
	end
	if doeswarp then
		Tween(Position)
		Client.Character:FindFirstChild('HumanoidRootPart').CFrame = Position
	end
	local getNpc = function()
		for i,v in pairs(workspace.AllNPC:GetChildren()) do
			if v and (v.Position - Position.Position).Magnitude < 5 then
				return v
			end
		end
		return nil
	end
	local getNewQuest = function(name)
		for i,v in pairs(require(game:GetService("ReplicatedStorage").Chest.Modules.ChatDialogue)) do
			if i == name then
				return true
			end
		end 
		return false
	end
	game:GetService("ReplicatedStorage"):WaitForChild("Chest")
		:WaitForChild("Remotes"):WaitForChild("Functions")
		:WaitForChild("CheckQuest"):InvokeServer(getNpc())
	local s = false
	if getNewQuest(getNpc().Name) then
		game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
		game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
		s = true
	end
	local timeSet = 20
	if Client.PlayerGui:FindFirstChild('Elite Pirate') then
		if UiName == 1 or UiName == 2 then
			UiName = "Confirm"
		elseif UiName == 3 then
			UiName = "Sea 3"
		end
	elseif Client.PlayerGui:FindFirstChild("The Squid") then
		if UiName == 1 and Sea3 then
			UiName = "Sea 1"
		elseif UiName == 2 or (UiName == 1 and Sea2) or (Sea2 and UiName == 3) then
			UiName = "Confirm"
		end
	end
	if not Position then warn("Position not found") return end
	local getButton = function()
		for _, value in pairs(Client.PlayerGui:GetChildren()) do
			for _, value in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
				if s and value.Name == "Main" then
					for _, value2 in pairs(value:GetChildren()) do
						if value2.Name == 'Dialogue'  then
							if value2:FindFirstChild(UiName or 'Button1') and value2.Size.X.Scale > 0 then
								return value2[UiName or 'Button1']
							end
						end
					end
				else
					if value:FindFirstChild('Dialogue') then
						if value.Dialogue:FindFirstChild(UiName or 'Accept') and not value.Dialogue:FindFirstChild('ContinueLabel') then
							return value.Dialogue[UiName or 'Accept']
						else
							local VirtualInputManager = game:GetService("VirtualInputManager")
							VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
							VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
						end
					end
				end
			end
		end
		return nil
	end
	local buttonAccept = getButton()
	if buttonAccept then
		GuiService.SelectedObject = buttonAccept
		VirtualInputManager:SendKeyEvent(true, "Return", false, game)
		VirtualInputManager:SendKeyEvent(false, "Return", false, game) wait(.5)
		GuiService.SelectedObject = nil
	end
end
noobExechop = function() 
	repeat
		local Players = game:GetService("Players")
		local GuiService = game:GetService("GuiService")
		local VirtualInputManager = game:GetService("VirtualInputManager")
		local LocalPlayer = Players.LocalPlayer
		local GUI = LocalPlayer.PlayerGui
		local ServerBrowserFrame = GUI.MainGui.StarterFrame.ServerBrowserFrame
		local ServerFrame = ServerBrowserFrame.ServerFrame
		if not ServerBrowserFrame.Visible then
			GuiService.SelectedObject = GUI.TopbarPlus.TopbarContainer.ServerBrowser.IconButton
			VirtualInputManager:SendKeyEvent(true, "Return", false, game)
			VirtualInputManager:SendKeyEvent(false, "Return", false, game)
		else
			local servers = ServerFrame:GetChildren()
			if #servers == 1 then
				GuiService.SelectedObject = ServerBrowserFrame.RefreshButton
				VirtualInputManager:SendKeyEvent(true, "Return", false, game)
				VirtualInputManager:SendKeyEvent(false, "Return", false, game)
			else
				GuiService.SelectedObject = servers[math.random(2, #servers - 1)].JoinButton
				VirtualInputManager:SendKeyEvent(true, "Return", false, game)
				VirtualInputManager:SendKeyEvent(false, "Return", false, game)
			end
		end
		wait()
	until game.PlaceId ~= game.PlaceId
end
Serverhop = function()
	local Http = game:GetService("HttpService")
	local Api = "https://games.roblox.com/v1/games/"
	local _place = game.PlaceId
	local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
	function ListServers(cursor)
		local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
		return Http:JSONDecode(Raw)
	end
	local Server, Next; repeat
		local Servers = ListServers(Next)
		Server = Servers.data[1]
		Next = Servers.nextPageCursor
	until Server
	game:GetService("TeleportService"):TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end
HopServer = function(FullServer, d) 
	spawn(Serverhop)
end
local Zenfunc = setmetatable({}, {})
Zenfunc.__index = function(table, key)
	return "nil"
end
Zenfunc['Entity'] = setmetatable({}, {})
Zenfunc['Entity'].__index = function(table, key)
	return "nil"
end
Zenfunc['getPlayerMaterial'] = function(Material)
	local HttpService = game:GetService("HttpService")
	for gatMaterial, numMaterial in pairs(HttpService:JSONDecode(Client.PlayerStats.Material.Value)) do
		if gatMaterial == Material then
			return numMaterial
		end
	end
	return 0
end
local IsBossList = require(game.ReplicatedStorage.Chest.Modules.RaidBossList)
function Isboss(NameBoss)
	for i,v in pairs(IsBossList) do
		if i == NameBoss then
			return true
		end
	end
end
Zenfunc['GetQuestData'] = function(Level, NotAttackBoss)
	local Quests = {}
	local playerLevel = Client.PlayerStats.lvl.Value
	for QuestTitle, Quest in pairs(require(QuestManager)) do
		if not Quest['DailyQuest'] then
			local firstLv = Quest["Level"] == 0 and 1
			local MobLevel = tonumber(Quest['Mob']:match("Lv%. (%d+)"))
			if Quest['Mob']:match('Lv') and (playerLevel >= Quest['Level']) then
				table.insert(Quests, {
					LevelRequired = Quest['Level'] or 1,
					Mob = (function()
						if playerLevel >= 3300 and playerLevel < 3375 then
							return 'Azlan [Lv. 3300]'
						end
						return Quest['Mob']
					end)(),
					QuestTitle = (function()
						if playerLevel >= 3300 and playerLevel < 3375 then
							return 'Kill 4 Azlan'
						end
						return QuestTitle
					end)(),
					NPC = (function()
						local npclist = {}
						for _, npc in pairs(game:GetService("Workspace"):FindFirstChild("AllNPC"):GetChildren()) do
							if npc:GetAttribute("LevelMin") then
								if Quest['Level'] >= npc:GetAttribute("LevelMin") then
									npclist[#npclist+1] = {
										Level = npc:GetAttribute("LevelMin"),
										CFrame = npc.CFrame
									}
								end
							end
						end
						table.sort(npclist, function(a,b)
							return a.Level > b.Level
						end)
						return npclist[1]
					end)()
				})
			end
		end
	end
	local function GetQuest()
		table.sort(Quests, function(Table1, Table2) 
			return Table1.LevelRequired > Table2.LevelRequired  
		end)
		return Quests
	end
	Quests = GetQuest()
	if NotAttackBoss then
		if Isboss(Quests[1]['Mob']) then
			for i=1,#Quests do
				if not Isboss(Quests[i]['Mob']) then
					Quests = Quests[i]
					break
				end
			end
		else
			Quests = Quests[1]
		end
	else
		Quests = Quests[1]
	end
	if (playerLevel >= MaxLevelOfSea) and Sea2 then
		Quests['Mob'] = "Ryu [Lv. 3975]"
		Quests['LevelRequired'] = 3950
		Quests['QuestTitle'] = 'Kill 1 Ryu'
	elseif playerLevel >= MaxLevelOfSea and Sea1 then
		Quests['Mob'] = "Seasoned Fishman [Lv. 2200]"
		Quests['LevelRequired'] = 2200
		Quests['QuestTitle'] = 'Kill 1 Seasoned Fishman'
	elseif playerLevel >= 4900 and playerLevel < 5000 and Sea3 then
		Quests['Mob'] = "Prisoner of Gravity [Lv. 4875]"
		Quests['LevelRequired'] = 4875
		Quests['QuestTitle'] = 'Kill 1 Prisoner of Gravity'
	end
	for qml, valuaqml in pairs(QuestMaterial) do
		if Quests['LevelRequired'] == tonumber(qml) then
			local findMon;
			for __, checkmon in pairs(workspace.Monster.Mon:GetChildren()) do
				if checkmon.Name == Quests['Mob']  and checkmon:FindFirstChild("Humanoid") and checkmon:FindFirstChild("HumanoidRootPart") and checkmon.Humanoid.Health > 0 then
					findMon = true
				end
			end
			for __, checkmon in pairs(workspace.Monster.Boss:GetChildren()) do
				if checkmon.Name == Quests['Mob']  and checkmon:FindFirstChild("Humanoid") and checkmon:FindFirstChild("HumanoidRootPart") and checkmon.Humanoid.Health > 0 then
					findMon = true
				end
			end
			for __, checkmon in pairs(Repli.MOB:GetChildren()) do
				if checkmon.Name == Quests['Mob']  and checkmon:FindFirstChild("Humanoid") and checkmon:FindFirstChild("HumanoidRootPart") and checkmon.Humanoid.Health > 0 then
					findMon = true
				end
			end
			if Zenfunc['getPlayerMaterial'](valuaqml['Material']) <= 0 and not findMon then
				Quests['Mob'] = valuaqml['Kills']
				Quests['LevelRequired'] = valuaqml['Level']
				Quests['QuestTitle'] = valuaqml['QuestTitle']
			elseif Zenfunc['getPlayerMaterial'](valuaqml['Material']) > 0 and not findMon then
				local args = {
					[1] = "QuestSpawnBoss",
					[2] = {
						["SuccessQuest"] = "Quest Accepted.",
						["BossName"] = Quests['Mob'],
						["LevelNeed"] =  Quests['LevelRequired'],
						["QuestName"] = Quests['QuestTitle'],
						["MaterialNeed"] = valuaqml['Material'],
					}
				}
				Repli:WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(args))
			end
		end
	end
	return Quests
end
for _, npc in pairs(game:GetService("Workspace"):FindFirstChild("AllNPC"):GetChildren()) do
	if npc:GetAttribute("LevelMax") then
		lvmax = npc:GetAttribute("LevelMax")
		if not MaxLevelOfSea or lvmax > MaxLevelOfSea then
			MaxLevelOfSea = lvmax
		end
	end
	if npc:GetAttribute("LevelMin") then
		lvmin = npc:GetAttribute("LevelMin")
		if not MinLevelOfSea or lvmin < MinLevelOfSea then
			MinLevelOfSea = lvmax
		end
	end
end
if InRaid then
	MaxLevelOfSea = 4800
end
local blacklistD = {
	"Boss",
	"Minion"
}
local MonsertBringPos = {}
Zenfunc['Entity']['Bring'] = function(_v, cf)
end
function UpdateStandMethond()
	if Config['FlightAt'] == "Above" then
		Config['standmethod'] =  CFrame.new(0,Config["RawStand"] or 8.5,0.15) * CFrame.Angles(math.rad(-90),0,0)
	elseif Config['FlightAt'] == "Beside" then
		Config['standmethod'] =  CFrame.new(0, 0, Config["RawStand"]) 
	elseif Config['FlightAt'] == "Below" then
		Config['standmethod'] =  CFrame.new(0,-Config["RawStand"] or 8.5,-1) * CFrame.Angles(math.rad(90),0,0)
	else
		Config['standmethod'] =  CFrame.new(0,Config["RawStand"] or 8.5,0.15) * CFrame.Angles(math.rad(-90),0,0)
	end
end;UpdateStandMethond()
comma_value = function(Value)
	local Calculated = Value
	while true do
		local Text, Amount = string.gsub(Calculated, "^(-?%d+)(%d%d%d)", "%1,%2")
		Calculated = Text
		if Amount == 0 then break end
	end
	return Calculated
end
--[[local NeedAttack = false
local FakeString = 0
local SetString = ""
Zenfunc['Instance Damage'] = function(target)
end
local _heartbeatClock = 0
game:GetService("RunService").Heartbeat:Connect(function()
	local _now = os.clock()
	if _now - _heartbeatClock < 0.05 then return end
	_heartbeatClock = _now
	pcall(function()
		local _comboFrame = Client.PlayerGui.MainGui.StarterFrame.ComboFrame
		local FakeDmg = _comboFrame:FindFirstChild("Zen Hub")
		if FakeDmg then
			_comboFrame.TextLabelDmg.Visible = false
			FakeDmg.Visible = true
			FakeDmg.TextColor = _comboFrame.TextLabelHit.TextColor
			FakeDmg.Text = SetString
			if _comboFrame.TextLabelDmg.Text == "0" then
				FakeString = 0
			end
		end
	end)
end)]]
local lp = {}
local IsFarm = false

-- updateLabel: module-level so it can be called from anywhere
function updateLabel(target, questData)
	if target and target:FindFirstChild("Humanoid") then
		local hp  = target.Humanoid.Health
		local max = target.Humanoid.MaxHealth
		local percent = max > 0 and math.floor((hp / max) * 100) or 0
		local status  = hp > 0 and "Alive" or "Dead"
		_G.LabelAutoFarm = "Farming: " .. target.Name
		_G.Questname     = "Quest: " .. (questData and questData["QuestTitle"] or "None")
		_G.LabelHealth   = "Status: " .. status .. " | Health: " .. percent .. "%"
	else
		_G.LabelAutoFarm = "No target detected"
		_G.LabelHealth   = ""
	end
end

Zenfunc['Entity']['attack'] = function(inTable, Expression, PositionM, unt)
	local Data = nil
	if Config['Not Accept Boss'] then
		Data = Zenfunc['GetQuestData'](nil, true)
	else
		Data = Zenfunc['GetQuestData']()
	end
	local SeaMonster, CheckGhost
	if Sea2 then
		SeaMonster, CheckGhost = game:GetService("Workspace").SeaMonster:GetChildren(), game.Workspace:FindFirstChild("GhostMonster"):GetChildren()
	elseif Sea3 then
		SeaMonster, CheckGhost = game:GetService("Workspace").SeaMonster:GetChildren(), Repli.MOB:GetChildren()
	else
		SeaMonster, CheckGhost = Repli.MOB:GetChildren(), Repli.MOB:GetChildren()
	end


	local attackTarget = function(target)
		if (Expression == "Auto Farm Level" and
			Client.CurrentQuest.Value ~= Data["QuestTitle"]) 
			or not Config[Expression] then return 
		end
		if target.Name == "Tentacle" then
			if not target:FindFirstChild("Next") then
				repeat
					task.wait()
					if target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") and 
						target.Humanoid.Health > 0 and 
						(target.HumanoidRootPart.Position.Y > -100 and target.HumanoidRootPart.Position.Y < 1500) 
					then
						if PositionM and type(PositionM) == 'number' and PositionM > 1 then
							tp({
								Target = target.HumanoidRootPart.CFrame * CFrame.new(0, PositionM or 8.5,0.15) * CFrame.Angles(math.rad(-90),0,0),
							})
						else
							if game.Players.LocalPlayer.PlayerGui:FindFirstChild('EatFruitBecky') then
								tp({
									Target = target.HumanoidRootPart.CFrame * CFrame.new(0, 500, 100) * CFrame.Angles(math.rad(-90),0,0),
								})
							else
								tp({
									Target = target.HumanoidRootPart.CFrame * Config['standmethod'],
								})
							end
						end
						updateLabel(target, Data)
						local run = function()
							Attack()
							getgenv().PosMonSkill = target.HumanoidRootPart.CFrame
							useSkill()
						end
						lp[#lp+1] = task.spawn(pcall, run)
						delay(25, function()
							local Make = Instance.new("Folder", target)
							Make.Name = "Next"
							delay(10, function()
								Make:Destroy()
							end)
						end)
					end
				until target:FindFirstChild("Next")
					or not Config[Expression] 
					or not target.Parent 
					or target.Humanoid.Health <= 0
					or not target:FindFirstChild("HumanoidRootPart") 
					or target:FindFirstChild("HumanoidRootPart").Position.Y < -100 
					or target:FindFirstChild("HumanoidRootPart").Position.Y > 1500
				if #lp >= 1 then
					for i,v in pairs(lp) do
						pcall(task.cancel, v)
					end
					table.clear(lp)
				end
			end
		else
			local Old = target.HumanoidRootPart
			repeat
				task.wait()
				local healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
				if target:FindFirstChild("Humanoid") and target:FindFirstChild("HumanoidRootPart") and 
					target.Humanoid.Health > 0 and 
					(target.HumanoidRootPart.Position.Y > -100 and target.HumanoidRootPart.Position.Y < 1500)
					and Client.Character.Humanoid.Health > 0
				then
					updateLabel(target, Data)
					if not Config['Safe Mode'] then
						local brig = function()
							if Config['Bring_Mon'] then
								Zenfunc['Entity']['Bring'](target, Old)
							end
						end
						if target.Parent == workspace.Monster.Mon then
							if Config['Instance Damage'] and not table.find(blacklistD, target.Name) and target:FindFirstChild("Head") and (target:FindFirstChild("Humanoid").Health / target:FindFirstChild("Humanoid").MaxHealth)*100 <= 80 then
								Zenfunc['Instance Damage'](target)
							end
						else
							if target.Name == "Dragon [Lv. 5000]" then
								if Config['Instance Damage'] and not table.find(blacklistD, target.Name) and target:FindFirstChild("Head") and (target:FindFirstChild("Humanoid").Health / target:FindFirstChild("Humanoid").MaxHealth)*100 <= 80 then
									Zenfunc['Instance Damage'](target)
								end
							end
						end
						lp[#lp+1] = task.spawn(pcall, brig)
						if PositionM and PositionM > 1 then
							tp({
								Target = target.HumanoidRootPart.CFrame * CFrame.new(0, PositionM or 8.5,0.15) * CFrame.Angles(math.rad(-90),0,0),
							})
						else
							if game.Players.LocalPlayer.PlayerGui:FindFirstChild('EatFruitBecky') then
								tp({
									Target = target.HumanoidRootPart.CFrame * CFrame.new(0, 500, 100) * CFrame.Angles(math.rad(-90),0,0),
								})
							else
								tp({
									Target = target.HumanoidRootPart.CFrame * Config['standmethod'],
								})
							end
						end
						if _G.Debug then
							warn('[DEBUG]', Config['standmethod'], 'standmethod')
						end
						if target.Parent == workspace.Monster.Mon then
							local MonHp = Client.Character.Humanoid.Health
							delay(1, function()
								if MonHp == Client.Character.Humanoid.Health and target:FindFirstChild("Head") then
									Zenfunc['Instance Damage'](target)
								end
							end)
						end
						local run = function()
							getgenv().PosMonSkill = target.HumanoidRootPart.CFrame
							useSkill()
							Attack()
						end
						lp[#lp+1] = task.spawn(pcall, run)
						NeedAttack = true
					else
						-- Safe Mode: if HP <= 50%, teleport 200 studs above the target
						if healthPercentage <= 50 then
							if target:FindFirstChild("HumanoidRootPart") then
								tp({ Target = target.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0) })
							end
							repeat task.wait()
								healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
							until not Config[Expression] or healthPercentage > (Config['Select You HP Max (%)'] or 75)
						elseif healthPercentage > Config['Select You HP (%)'] then
							local brig = function()
								if Config['Bring_Mon'] then
									Zenfunc['Entity']['Bring'](target, Old)
								end
							end
							lp[#lp+1] = task.spawn(pcall, brig)
							tp({
								Target = target.HumanoidRootPart.CFrame * Config['standmethod'],
							})
							local run = function()
								getgenv().PosMonSkill = target.HumanoidRootPart.CFrame
								useSkill()
								Attack()
							end
							lp[#lp+1] = task.spawn(pcall, run)
							NeedAttack = true
						else
							tp({
								Target = workspace.SpawnPoints.Spawn1.CFrame,
							})
							if Client.Character:FindFirstChild('Cyborg') or Client.Backpack:FindFirstChild('Cyborg') then
								repeat
									healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
									if not Client.Character:FindFirstChild('Cyborg') then
										EquipTools('Cyborg')
									end
									if Client.Character:FindFirstChild('Cyborg') and not Item.CheckOnCooldown("E") and not Item.CheckSkillLock("E") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
									end
									if Client.Character:FindFirstChild('Cyborg') and Item.CheckOnCooldown("E") and not Item.CheckSkillLock("E") then
										game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
									end
									task.wait()
								until not Config[Expression] or healthPercentage > (Config['Select You HP Max (%)'] or 75)
							else
								repeat task.wait()
									healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
								until not Config[Expression] or healthPercentage > (Config['Select You HP Max (%)'] or 75)
							end
						end
					end
				end
			until (
				Expression == "Auto Farm Level" and
					not IsFarm
			) or (
				Expression == "Auto Farm Level" and
					Client.CurrentQuest.Value ~= Data["QuestTitle"]
			) 
				or ( unt and unt.Monster and unt.get == "have" and Zenfunc['Entity']['find'](unt.Monster) )
				or ( unt and unt.Monster and unt.get == "not" and not Zenfunc['Entity']['find'](unt.Monster) )
				or not Config[Expression] 
				or not target.Parent 
				or target.Humanoid.Health <= 0
				or Client.Character.Humanoid.Health <= 0
				or not target:FindFirstChild("HumanoidRootPart") 
				or target:FindFirstChild("HumanoidRootPart").Position.Y < -100 
				or target:FindFirstChild("HumanoidRootPart").Position.Y > 1500
			if #lp >= 1 then
				for i,v in pairs(lp) do
					pcall(task.cancel, v)
				end
				table.clear(lp)
			end
			if MonsertBringPos[target.Name] then
				table.clear(MonsertBringPos)
			end
		end
	end
	for _, category in ipairs({workspace.Monster.Boss:GetChildren(), 
		workspace.Monster.Mon:GetChildren(), 
		CheckGhost, 
		SeaMonster, 
		Repli.MOB:GetChildren()}) do
		for _, target in ipairs(category) do
			if table.find(inTable, target.Name) then
				if Config[Expression] then
					attackTarget(target)
				else
					repeat
						task.wait()
						if not target.Parent or 
							target.Humanoid.Health <= 0 or 
							not target:FindFirstChild("HumanoidRootPart")
							or target.HumanoidRootPart.Position.Y < -100 then
							break
						end
						attackTarget(target)
					until false
				end
			elseif category == Repli.MOB:GetChildren() then
				if table.find(inTable, target.Name) and 
					target:FindFirstChild("Humanoid") and 
					target:FindFirstChild("HumanoidRootPart") and 
					target.Humanoid.Health > 0 then
					tp({Target = target.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0)})
				end
			end
		end
	end
end
Zenfunc['Entity']['find'] = function(EnemiesName)
	local SeaMonster, CheckGhost
	if Sea2 then
		SeaMonster, CheckGhost = game:GetService("Workspace").SeaMonster:GetChildren(),
		game.Workspace:FindFirstChild("GhostMonster"):GetChildren()
	elseif Sea3 then
		SeaMonster, CheckGhost = game:GetService("Workspace").SeaMonster:GetChildren(),
		Repli.MOB:GetChildren()
	else
		SeaMonster, CheckGhost = Repli.MOB:GetChildren(),
		Repli.MOB:GetChildren()
	end
	local function isValidEnemy(enemy)
		return enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0
	end
	local function checkEnemies(enemies)
		for _, enemy in pairs(enemies) do
			if table.find(EnemiesName, enemy.Name) and isValidEnemy(enemy) then
				return true
			end
		end
		return false
	end
	return checkEnemies(workspace.Monster.Mon:GetChildren()) or checkEnemies(workspace.Monster.Boss:GetChildren()) or checkEnemies(CheckGhost) or checkEnemies(SeaMonster) or checkEnemies(Repli.MOB:GetChildren())
end
checkloop = {}
Zenfunc['getPcall'] = function(fetch, fun)
	checkloop[fetch] = checkloop[fetch] or {}
	checkloop[fetch].Value = checkloop[fetch].Value or 0
	local success, debugfun = pcall(fun)
	if not success and _G.Debug then
		local info = debug.getinfo(3, "Sl")
		local line = info.currentline or -1
		local function_name = info.name or "Unknown Function"
		local timestamp = os.date("%Y-%m-%d %H:%M:%S")
		warn('\n[DEBUG - ERROR]')
		warn('-----------------------------')
		warn('Time:', timestamp)
		warn('Function Name :', fetch .. ' ( ' .. function_name .. ' )' .. ' : Function Line : ' .. line)
		warn('Error Message:', debugfun)
		warn('-----------------------------\n')
		return
	end
end
local pos = {}
local Notyyy = false
local Data = Zenfunc['GetQuestData']()
Zenfunc['Auto Farm Level'] = function()
	local fetch = 'Auto Farm Level'
	IsFarm = Config[fetch]
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if not IsFarm then return end
			local playerLevel = Client.PlayerStats.lvl.Value
			if playerLevel >= 4900 and not Notyyy then
				Notyyy = true
				Windown.Notify('error', { text = "If you are Lv 4.9k or higher,just Clear new Dungeon but it so hart farm", time = 10 })
			end
			local Data = nil
			if Config['Not Accept Boss'] then
				Data = Zenfunc['GetQuestData'](nil, true)
			else
				Data = Zenfunc['GetQuestData']()
			end
			local NpcPos = Data['NPC'].CFrame
			if (Client.CurrentQuest.Value ~= Data["QuestTitle"]) or Client.CurrentQuest.Value == "" then
				tp({Target = NpcPos})
				Repli:WaitForChild("Chest").Remotes.Functions.Quest:InvokeServer("take", Data['QuestTitle'])
			elseif Client.CurrentQuest.Value == Data["QuestTitle"] then
				if Data['Mob'] == 'Dough Master [Lv. 3275]' and Data['LevelRequired'] == 3275 then
					tp({Target = CFrame.new(30279.0625, 69.36441802978516, 93166.2734375)})
				else
					local mobModel = Repli.MOB:FindFirstChild(Data['Mob'])
					if monsterPot[Data['Mob']]then
						tp({Target =  monsterPot[Data['Mob']] * CFrame.new(0, 30, 0)})
					else
						if mobModel then
							tp({Target = mobModel:GetModelCFrame() * CFrame.new(0, 20, 0)})
						else 
							if Data['LevelRequired'] >= 3250 and not pos[Data['Mob']] then
								tpToPos(Data, NpcPos)
							else
								tp({Target = pos[Data['Mob']] or NpcPos})
							end
						end
					end
				end
				if Zenfunc['Entity']['find']({Data['Mob']}) then
					Zenfunc['Entity']['attack']({
						Data['Mob']
					}, fetch)
					if not pos[Data['Mob']] then
						pos[Data['Mob']] = Client.Character.HumanoidRootPart.CFrame
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Second Sea'] = function()
	local fetch = 'Auto Second Sea'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Sea1 and Client.PlayerStats.lvl.Value >= 2250 and Client.PlayerStats.lvl.Value < 4000 then
				if IsFarm then repeat wait() IsFarm = false until not Config[fetch] or not IsFarm end
				if Client.PlayerStats.SecondSeaProgression.Value == "Yes" then
					getQuestOld(FF['Teleport To Sea 2'], 2)
				else
					if Zenfunc['getPlayerMaterial']('Map') > 0 then
						getQuestOld(workspace.AllNPC.Traveler.CFrame) wait(.5)
					else
						if not GUI.MainGui.QuestFrame.QuestBoard.Visible then
							getQuestOld(workspace.AllNPC.Traveler.CFrame) wait(.5)
						else
							if Repli.MOB:FindFirstChild("Seasoned Fishman [Lv. 2200]") then
								tp({Target = Repli.MOB:FindFirstChild("Seasoned Fishman [Lv. 2200]"):GetPivot()})
							else
								tp({Target = CFrame.new(-1865.43481, 45.2696266, 6722.8501, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)})
							end
							if Zenfunc['Entity']['find']({"Seasoned Fishman [Lv. 2200]"}) then
								Zenfunc['Entity']['attack']({
									"Seasoned Fishman [Lv. 2200]"
								}, fetch)
							end
						end
					end
				end
			end
		end)
	end
end

local visitedServers = {}


HopServer = function()
    local funcx = "auto_hop"
    if not (Config and Config[funcx]) then return end

    local Http = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")

    local Api = "https://games.roblox.com/v1/games/"
    local PlaceId = game.PlaceId

    local cursor = ""
    local foundServer = nil

    local function ListServers(cur)
        if not Config[funcx] then return end

        local url = Api .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        if cur and cur ~= "" then
            url = url .. "&cursor=" .. cur
        end

        local success, result = pcall(function()
            return Http:JSONDecode(game:HttpGet(url))
        end)

        if success and result then
            return result
        end
    end

    -- 🔍 Find best server
    repeat
        if not Config[funcx] then return end

        local Servers = ListServers(cursor)
        if not Servers then break end

        for _, v in pairs(Servers.data) do
            if not Config[funcx] then return end

            if v.id ~= game.JobId
            and v.playing < v.maxPlayers
            and not visitedServers[v.id] then

                visitedServers[v.id] = true
                foundServer = v.id
                break
            end
        end

        cursor = Servers.nextPageCursor
    until foundServer or not cursor

    -- 🚀 Teleport
    if foundServer and Config[funcx] then
        print("Smart Hop → Joining new server:", foundServer)

        -- 🔥 ADD THIS PART HERE
        local q = queue_on_teleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport
        if q then
            q("loadstring(game:HttpGet('"..AUTO_EXEC_URL.."'))()")
            print("Queued auto-exec")
        else
            warn("queue_on_teleport not supported")
        end
        -- 🔥 END HERE

        pcall(function()
            TeleportService:TeleportToPlaceInstance(PlaceId, foundServer, game.Players.LocalPlayer)
        end)
    else
        warn("No available server found.")
    end
end


-- Entity display mapping (keep this)
local entityNameMapping = {
    ["FuryTentacle"] = "Chaos Kraken",
    ["ThirdSeaEldritch Crab"] = "Deepsea Crusher",
    ["ThirdSeaDragon"] = "Drakenfyr the Inferno King",
    ["SeaDragon"] = "Abyssal Tyrant",
    ["Skull King"] = "Skull King",
    ["Ghost Ship"] = "Ghost Ship",
    ["HydraSeaKing"] = "Hydra Sea King",
    ["SeaKing"] = "Sea King",
}

local function getEntityDisplayName(entityName)
    return entityNameMapping[entityName] or entityName
end

Zenfunc['auto_hop'] = function()
    local funcx = 'auto_hop'

    while (Config and Config[funcx]) and task.wait(0.5) do
        Zenfunc['getPcall'](funcx, function()

            local selected = Config.SelectedSeaMonsters or {}

            if #selected == 0 then
                warn("No entities selected for auto hop.")
                return
            end

            local found = false

            for _, entityName in pairs(selected) do
                if Zenfunc['Entity']['find']({entityName}) then
                    local displayName = getEntityDisplayName(entityName)

                    print("Entity found:", displayName, "→ stopping hop")
                    Config[funcx] = false
                    found = true
                    break
                end
            end

            -- 🚀 If none found → hop
            if not found then
                local delay = Config.HopDelay or 15

                print("No entity found → hopping in", delay, "seconds")
                task.wait(delay)

                if Config[funcx] then
                    HopServer()
                end
            end

        end)
    end
end

Zenfunc['Auto_Farm_Nearest_Mob'] = function()
    local funcx = 'Auto_Farm_Nearest_Mob'

    while (Config and Config[funcx]) and task.wait(0.2) do
        Zenfunc['getPcall'](funcx, function()

            if InRaid then return end

            local player = game:GetService("Players").LocalPlayer
            local char = player.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end

            local myPos = char.HumanoidRootPart.Position
            local nearestEnemy = nil
            local shortestDistance = math.huge
            for _, enemy in pairs(workspace.Monster.Mon:GetChildren()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local hrp = enemy:FindFirstChild("HumanoidRootPart")

                if humanoid and hrp and humanoid.Health > 0 then
                    local dist = (myPos - hrp.Position).Magnitude

                    if dist < shortestDistance then
                        shortestDistance = dist
                        nearestEnemy = enemy
                    end
                end
            end

            -- 🔥 attack only nearest
            if nearestEnemy and shortestDistance <= 1000 then
                if Zenfunc['Entity']['find']({nearestEnemy.Name}) then
                    Zenfunc['Entity']['attack']({nearestEnemy.Name}, funcx)
                end
            end

        end)
    end
end
local oldBeli = 0
local Keep = false
seaChest = function(Hop)
	local ChetLegacyIsland = function()
		if Config['Auto Sea King'] or Hop then
			local islands = {"Legacy Island1", "Legacy Island2", "Legacy Island3", "Legacy Island4"}
			for _, islandName in ipairs(islands) do
				local island = game:GetService("Workspace").Island:FindFirstChild(islandName)
				if island then
					return island
				end
			end
		end
		return nil
	end
	local getHydaIsland = function()
		if Config['Auto Hydra Sea King'] or Hop then
			for _, v in pairs(workspace:FindFirstChild("Island"):GetChildren()) do
				if v.Name:match("Sea King") then
					return true
				end
			end
		end
		return false
	end
	local Chetcheck = function()
		if Config['Auto Ghost Ship'] then
			for _,cheats in pairs(game.Workspace:GetChildren())do 
				if cheats.Name:match("Chest") and not cheats:FindFirstChild('Zen Hub') then 
					warn('[DEBUG] : Find Chest')
					return true
				end
			end
		end
		return false
	end
	local Chetcheck2 = function(v)
		for _,cheats in pairs(v:GetChildren())do 
			if cheats.Name:match("Chest") then 
				warn('[DEBUG] : Find Chest')
				return true
			end
		end
		return false
	end
	local Hopp = function()
		if Config["Monter_Hop"] or Config["Auto Third World"] or Hop then 
			if Keep then
				task.wait(3.5) 
				HopServer(true)
				delay(5, function()
					HopServer()
				end)
				return
			end
			local hours, minutes, seconds = game:GetService('ReplicatedStorage'):GetAttribute('SeaMonsterSpawnText'):match("(%d+):(%d+):(%d+)")
			hours = tonumber(hours) or 0
			minutes = tonumber(minutes) or 0
			seconds = tonumber(seconds) or 0
			local totalMinutes = hours * 60 + minutes + seconds / 60
			if _G.Debug then
				warn('[Debug] :\n', Config['Setting Sea Monster Time (for Hop)'], "\ntotalMinutes =", totalMinutes, "\nHOP =", Hop, "\n(checkNeedHop Sea 2)")
			end
			if totalMinutes > Config['Setting Sea Monster Time (for Hop)'] then
				task.wait(3.5) 
				HopServer(true)
				delay(5, function()
					HopServer()
				end)
			end
		end
	end
	if not game:GetService("Workspace").SeaMonster:FindFirstChild("HydraSeaKing") and getHydaIsland() then
		print('HydraSeaKing')
		for _, v in pairs(workspace:FindFirstChild("Island"):GetChildren()) do
			if v.Name:match("Sea King") then
				if Chetcheck2(v) then
					tp({Target = v.HydraStand.CFrame})
					Client.PlayerStats.beli.Value = Client.PlayerStats.beli.Value + 50
					wait(3)
					if dist(v:FindFirstChild('SeaBeastChest').ChestTop.Position, Client.Character.HumanoidRootPart.Position) < 10 and Client.PlayerStats.beli.Value > oldBeli + 1 then
						print(oldBeli, ' : ', Client.PlayerStats.beli.Value )
						Keep = true
						Hopp()
					end
				else
					tp({Target = v.HydraStand.CFrame})
				end
			end
		end
	else
		if not workspace.SeaMonster:FindFirstChild("SeaKing") and ChetLegacyIsland() then
			local islands = {"Legacy Island1", "Legacy Island2", "Legacy Island3", "Legacy Island4"}
			for _, islandName in ipairs(islands) do
				local island = game:GetService("Workspace").Island:FindFirstChild(islandName)
				if island and Chetcheck2(island.ChestSpawner) then
					tp({Target = island.ChestSpawner.CFrame}) 
					Client.PlayerStats.beli.Value = Client.PlayerStats.beli.Value + 50
					wait(3)
					if dist(island.ChestSpawner.Position, Client.Character.HumanoidRootPart.Position) < 10 and Client.PlayerStats.beli.Value > oldBeli + 1 then
						print(oldBeli, ' : ', Client.PlayerStats.beli.Value )
						Keep = true
						Hopp()
					end
				else
					if island then
						tp({Target = island.ChestSpawner.CFrame * CFrame.new(0, 50, 0)})
					end
				end
			end
		else
			if not workspace.SeaMonster:FindFirstChild("Ghost Ship") and Chetcheck() then
				print('Ghost Ship')
				for _,cheats in pairs(game.Workspace:GetChildren())do 
					if cheats.Name:match("Chest") and not cheats:FindFirstChild('Zen Hub') then 
						tp({Target = cheats.PrimaryPart.CFrame})
						if dist(cheats.PrimaryPart.Position, Client.Character.HumanoidRootPart.Position) < 10 then
							if not cheats:FindFirstChild('Zen Hub') then
								local recheck = Instance.new('Folder', cheats)
								recheck.Name = 'Zen Hub'
							end
							wait(1.5)
						end
					end
				end
			else
				print('Run Hop')
				Hopp()
			end
		end
	end
end
Zenfunc['Auto Third World'] = function()
	local fetch = 'Auto Third World'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.PlayerStats.lvl.Value >= 4000 and not Sea3 then
				if IsFarm then repeat wait() IsFarm = false until not Config[fetch] or not IsFarm end
				if Zenfunc['getPlayerMaterial']("Kraken's Cache") > 0 then
					for i = 1,15 do wait(.3)
						getQuestOld(workspace.AllNPC:FindFirstChild("The Squid").CFrame)
					end
				else
					if Zenfunc['Entity']['find']({"Tentacle"}) then
						Zenfunc['Entity']['attack']({
							"Tentacle",
						}, fetch)
					else
						if Zenfunc['getPlayerMaterial']("Heart of Sea") > 0 then
							if Client.PlayerGui:FindFirstChild("CraftingMaterialUI") then
								Client.PlayerGui:FindFirstChild("CraftingMaterialUI"):Destroy()
								Client.Character.Humanoid:ChangeState(15)
							else
								getQuestOld(workspace.AllNPC:FindFirstChild("Summon Tentacle").CFrame)
							end
						else
							if Zenfunc['getPlayerMaterial']("Kraken's Cache")  > 0 then
								return
							end
							if not Zenfunc['Entity']['find']({"Tentacle"}) then
								local NeedMateria = {
									['Log'] = 50,
									['Pile of Bones'] = 10,
									["Fresh Fish"] = 50,
									["Angellic's Feather"] = 14,
									["Undead's Ooze"] = 10,
									["Sea King's Blood"] = 1
								}
								local seax2 = {
									['Sea1'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame,
									['Sea2'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame
								}
								if Zenfunc['getPlayerMaterial']("Log") < NeedMateria['Log']  then
									if not Sea2 then
										getQuestOld(seax2['Sea2'])
										return
									end
									for _i, _v in pairs(game:GetService("Workspace"):GetDescendants()) do
										if string.find(_v.Name, "Tree") and _v:FindFirstChild("Part") and _v.Part.Transparency == 0 then task.wait(1.5)
											if Config[fetch] or Zenfunc['getPlayerMaterial']("Log") <= NeedMateria['Log'] or not Zenfunc['Entity']['find']({"Tentacle"}) then
												repeat wait()
													local Tree = _v:GetModelCFrame()
													tp({Target = Tree})
													if not Client.Backpack:FindFirstChild('Bisento') and not Client.Character:FindFirstChild('Bisento') then
														local args = {
															[1] = "Bisento"
														}
														game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer(unpack(args))
													end
													EquipTools("Bisento")
													if not Item.CheckOnCooldown("Z") or not Item.CheckOnCooldown("X") then
														if not Item.CheckSkillLock("Z") then
															game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
															game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
														end
														if not Item.CheckSkillLock("X") then
															game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
															game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
														end 
													end
												until not Config[fetch] or Item.CheckOnCooldown("Z") or Item.CheckOnCooldown("X") or Zenfunc['Entity']['find']({"Tentacle"}) or Zenfunc['getPlayerMaterial']("Kraken's Cache") > 0
											end
										end
										if not  Config[fetch]  or Zenfunc['getPlayerMaterial']("Log") >= NeedMateria['Log'] or Zenfunc['Entity']['find']({"Tentacle"}) or Zenfunc['getPlayerMaterial']("Kraken's Cache") > 0 then
											break
										end
									end
								elseif Zenfunc['getPlayerMaterial']("Pile of Bones") < NeedMateria['Pile of Bones'] then
									if not Sea2 then
										getQuestOld(seax2['Sea2'])
									else
										if Zenfunc['Entity']['find']({"Skull Pirate [Lv. 3050]"}) then
											Zenfunc['Entity']['attack']({
												"Skull Pirate [Lv. 3050]",
											},  fetch)
										else
											tp({Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)})
										end
									end
								elseif Zenfunc['getPlayerMaterial']("Fresh Fish") < NeedMateria['Fresh Fish'] then
									if not Sea1 then
										getQuestOld(seax2['Sea1'])
									else
										if  Zenfunc['Entity']['find']({"Karate Fishman [Lv. 200]","Fighter Fishman [Lv. 180]","Shark Man [Lv. 230]"}) then
											Zenfunc['Entity']['attack']({
												"Karate Fishman [Lv. 200]",
												"Fighter Fishman [Lv. 180]",
												"Shark Man [Lv. 230]",
											}, fetch)
										else
											tp({Target = workspace.Island["D - Shark Island"].D.Base:GetChildren()[57].CFrame * CFrame.new(0 ,50, 0)})
										end
									end
								elseif Zenfunc['getPlayerMaterial']("Angellic's Feather") < NeedMateria["Angellic's Feather"] then
									if not Sea1 then
										getQuestOld(seax2['Sea1'])
									else
										if Zenfunc['Entity']['find']({"Sky Soldier [Lv. 800]", "Ball Man [Lv. 850]"}) then
											Zenfunc['Entity']['attack']({
												"Sky Soldier [Lv. 800]",
												"Ball Man [Lv. 850]"
											}, fetch)
										else
											tp({Target = workspace.Island["H - Skyland"].Sky.Base:GetChildren()[4].CFrame})
										end
									end
								elseif Zenfunc['getPlayerMaterial']("Undead's Ooze") < NeedMateria["Undead's Ooze"] then
									if not Sea1 then
										getQuestOld(seax2['Sea1'])
									else
										if Zenfunc['Entity']['find']({"Zombie [Lv. 1500]"}) then
											Zenfunc['Entity']['attack']({
												"Zombie [Lv. 1500]"
											}, fetch)
										else
											if monsterPot["Zombie [Lv. 1500]"]then
												tp({Target =  monsterPot["Zombie [Lv. 1500]"] * CFrame.new(0, 30, 0)})
											end
										end
									end
								elseif Zenfunc['getPlayerMaterial']("Sea King's Blood") < NeedMateria["Sea King's Blood"] then
									if not Sea2 then
										getQuestOld(seax2['Sea2'])
									else
										if Zenfunc['Entity']['find']({"SeaKing", "HydraSeaKing"}) then
											Zenfunc['Entity']['attack']({
												"SeaKing",
												"HydraSeaKing"
											}, fetch)
										else
											seaChest(true)
										end
									end
								else
									if not Sea2 then
										getQuestOld(seax2['Sea2'])
									else
										getQuestOld(workspace.AllNPC:FindFirstChild("Jack Stones").CFrame)
										for _i, _v in pairs(Client.PlayerGui:GetChildren()) do
											if _v.Name == "CraftingMaterialUI" then
												if _v:FindFirstChild("Frame") and _v.Frame.OrbName.Text ~= "Heart of Sea" then
													_v.Frame.Materials.AnchorPoint = Vector2.new(0, 0)
													_v.Frame.Materials.Position = UDim2.new(0, 0, 0, 0)
													_v.Frame.Materials.Visible = true
													if _v.Frame.Materials:FindFirstChild("ScrollingFrame") then
														_v.Frame.Materials:FindFirstChild("ScrollingFrame").ClipsDescendants = false
														if _v.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("UIGridLayout") then
															_v.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("UIGridLayout").CellSize = UDim2.new(1001, 0, 1001, 0)
														end
														if _v.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("Diamond Key") then
															_v.Frame.Materials:FindFirstChild("ScrollingFrame"):FindFirstChild("Diamond Key").Visible = false
														end
														-- resize CraftButton then click like Heart of Sea
														if _v.Frame:FindFirstChild("CraftButton") then
															_v.Frame.CraftButton.Size = UDim2.new(1001, 0, 1001, 0)
														end
														game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
														game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
														-- fallback Auto close popup in 3 sec if stuck
														task.delay(3, function() if _v and _v.Parent then _v:Destroy() end end)
													end
												elseif _v.Frame.OrbName.Text == "Heart of Sea" then
													_v.Frame.CraftButton.Size = UDim2.new(1001, 0, 1001, 0)
													game:GetService("VirtualUser"):Button1Down(Vector2.new(1, 1))
													game:GetService("VirtualUser"):Button1Up(Vector2.new(1, 1))
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Dupe In KL'] = function()
	local fetch = 'Dupe In KL'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			for Code,Value in pairs(require(game:GetService("ReplicatedStorage").Chest.Modules.Config)) do
				task.spawn(function() game:GetService("ReplicatedStorage").Chest.Remotes.Functions.redeemcode:InvokeServer(Code) end)
			end
		end)
	end
end
local CurrentQuestKioru = function(num)
	return Client.CurrentQuest.Value ~= "Kioru Quest " .. num
end
local CheckQuestKioru = function(num)
	return Client.CurrentQuest.Value == "Kioru Quest " .. num
end
local isCurrentQuestKioru = function()
	return not Client.CurrentQuest.Value:find("Kioru Quest")
end
Zenfunc['Auto Kioru 1'] = function()
	local fetch = 'Auto Kioru 1'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.Inventory:FindFirstChild("Kioru") then return end
			if isCurrentQuestKioru() then
				getQuestOld(workspace.AllNPC.QuestKioru.CFrame)
			else
				local quests = {
					{"Kappa [Lv. 2950]", CFrame.new(-4845.7, 53.9, 2005)},
					{"Anubis [Lv. 3150]", CFrame.new(2108, 11, 958)},
					{"Flame User [Lv. 3200]", CFrame.new(2031.2, 14.6, 1354.4)},
					{"Sunken Vessel [Lv. 3225]", CFrame.new(-1102, 50.9, 8234.8)},
					{"Biscuit Man [Lv. 3250]", CFrame.new(-1532.7, 188.6, 8864.6)},
					{"Dough Master [Lv. 3275]", CFrame.new(30279.0, 69.3, 93166.2)}
				}
				for i, quest in ipairs(quests) do
					if CheckQuestKioru(i) then
						if Zenfunc['Entity']['find']({quest[1]}) then
							Zenfunc['Entity']['attack']({quest[1]}, fetch)
						else
							tp({Target = quest[2]})
						end
						break
					end
				end
			end
		end)
	end
end
Zenfunc['getPlayerFruitStore'] = function(fruit)
	local HttpService = game:GetService("HttpService")
	for getfruit, numfruit in pairs(HttpService:JSONDecode(Client.PlayerStats.FruitStore.Value )) do
		if getfruit == fruit then
			return {
				['Num'] = numfruit,
				['Value'] = true
			}
		end
	end
	return {
		['Num'] = 0,
		['Value'] = false
	}
end
local tweenService = game:GetService("TweenService")
local info = TweenInfo.new()
tweenModel = function(model, CF)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()
	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)
	local tween = tweenService:Create(CFrameValue, info, {Value = CF})
	tween:Play()
	tween.Completed:Connect(function()
		CFrameValue:Destroy()
	end)
end
checkTitle = function(Title)
	local HttpService = game:GetService("HttpService")
	for gatDailyQuest, v in pairs(HttpService:JSONDecode(Client.PlayerStats.TitleStore.Value)) do
		if gatDailyQuest == Title  then
			return true
		end
	end
	return false
end
local Debug = function(...)
	if _G.Debug then
		local args = {...}
		if #args > 0 then
			warn('[Debug]', unpack(args))
		end
	end
end
_G.D = nil
spin = function(power)
	if _G.D then
		_G.D:Disconnect()
	end
	_G.D = game:GetService('RunService').Stepped:Connect(function()
		game.Players.LocalPlayer.Character.Head.CanCollide = false
		game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
		game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
	end)
	local bambam = Instance.new("BodyThrust")
	bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
	bambam.Force = Vector3.new(power,0,power)
	bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
local checkNeedHop = function(timeString, Time, HOp)
	HOp = HOp or false
	if timeString.Text == "Peaceful Sea" then
		delay(5, function()
			if timeString.Text == "Peaceful Sea" then
				HopServer(true)
				delay(15, function()
					HopServer()
				end)
			end
		end)
		return
	elseif  timeString.Text == "Set sail!" then
		Debug('Now Sea =', 'Set sail!') 
		tp({ Target = CFrame.new(-5730.40625, 0.6850849390029907, 6110.42431640625)})
		return
	end
	local hours, minutes, seconds = timeString.Text:match("(%d+):(%d+):(%d+)")
	hours = tonumber(hours)
	minutes = tonumber(minutes)
	seconds = tonumber(seconds)
	local totalMinutes = hours * 60 + minutes + seconds / 60
	if _G.Debug then
		warn('[Debug] :\n', Config['Setting Sea Monster Time (for Hop)'], "\ntotalMinutes =", totalMinutes, "\nHOP =", HOp, "\n(checkNeedHop)")
	end
	if totalMinutes > Time and HOp then
		HopServer(true)
		delay(15, function()
			HopServer()
		end)
	end
end
Zenfunc['Auto Kioru 2'] = function()
	local fetch = 'Auto Kioru 2'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.Inventory:FindFirstChild("Kioru V2") then return end
			if _G.Debug then
				warn("[DEBUG]", "checkTitle =", checkTitle("Tyrant Slayer"), 'Tyrant Slayer')
				warn("[DEBUG]", "checkTitle =", checkTitle("Krakenbane"), 'Krakenbane')
				warn("[DEBUG]", "checkTitle =", checkTitle("Shellbreaker"), 'Shellbreaker')
				warn("[DEBUG]", "checkTitle =", checkTitle("Dragonbane"), 'Dragonbane')
			end
			if checkTitle("Tyrant Slayer") and checkTitle("Krakenbane") and checkTitle("Shellbreaker") and checkTitle("Dragonbane") then
				repeat wait()
					getQuestOld(workspace.AllNPC["Kioru V2 Quest"].CFrame, 'Button1')
					getQuestOld(workspace.AllNPC["Kioru V2 Quest"].CFrame)
				until not Config[fetch] or Client.Inventory:FindFirstChild("Kioru V2")
				repeat wait() IsFarm = true until not Config[fetch] or IsFarm
			else
				if Zenfunc['Entity']['find']({ "ThirdSeaDragon", "ThirdSeaEldritch Crab", "SeaDragon", "FuryTentacle" }) then
					if IsFarm then repeat wait() IsFarm = false until not Config[fetch] or not IsFarm end
					Zenfunc['Entity']['attack']({
						"ThirdSeaDragon",
						"ThirdSeaEldritch Crab",
						"SeaDragon",
						"FuryTentacle"
					}, fetch)
				else
					checkNeedHop(GUI.MainGui.StarterFrame.LegacyPoseFrame.ThirdSea.TextLabel, Config["Setting Sea Monster Time (for Hop)"], true)
				end
			end
		end)
	end
end
local HopSeaKingThird = function()
	local c = {}
	c['Third Sea Dragon'] = function()
		if Config['Third Sea Dragon Hop'] then
			if not Zenfunc['Entity']['find']({"ThirdSeaDragon"}) then
				return true
			end
		end
		return false
	end
	c['Deepsea Crusher'] = function()
		if Config['Deepsea Crusher Hop'] then
			if not Zenfunc['Entity']['find']({"ThirdSeaEldritch Crab"}) then
				return true
			end
		end
		return false
	end
	c['Sea Dragon'] = function()
		if Config['Sea Dragon Hop'] then
			if not Zenfunc['Entity']['find']({"SeaDragon"}) then
				return true
			end
		end
		return false
	end
	c['Chaos Kraken'] = function()
		if Config['Chaos Kraken Hop'] then
			if not Zenfunc['Entity']['find']({"FuryTentacle"}) then
				return true
			end
		end
		return false
	end
	c['Shark Galleon Boss'] = function()
		if Config['Shark Galleon Boss Hop'] then
			if not Zenfunc['Entity']['find']({"Shark Galleon Boss"}) then
				return true
			end
		end
		return false
	end
	c['Serpent'] = function()
		if Config['Serpent Hop'] then
			if not Zenfunc['Entity']['find']({"Serpent"}) then
				return true
			end
		end
		return false
	end
	if c['Third Sea Dragon']() and c['Deepsea Crusher']() and c['Sea Dragon']() and c['Chaos Kraken']() and c['Shark Galleon Boss']() and c['Serpent']() then
		Debug('Not Have Sea Monster Wait For Hop')
		checkNeedHop(GUI.MainGui.StarterFrame.LegacyPoseFrame.ThirdSea.TextLabel, Config["Setting Sea Monster Time (for Hop)"], true)
	else
		if Config['Chaos Kraken Hop'] or Config['Deepsea Crusher Hop'] or Config['Sea Dragon Hop'] or Config['Third Sea Dragon Hop'] then
			checkNeedHop(GUI.MainGui.StarterFrame.LegacyPoseFrame.ThirdSea.TextLabel, Config["Setting Sea Monster Time (for Hop)"], true)
		end
	end
end
Zenfunc['Auto Third Sea Dragon'] = function()
	local fetch = 'Auto Third Sea Dragon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"ThirdSeaDragon"}) then
				Zenfunc['Entity']['attack']({
					"ThirdSeaDragon",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end
Zenfunc['Auto Deepsea Crusher'] = function()
	local fetch = 'Auto Deepsea Crusher'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"ThirdSeaEldritch Crab"}) then
				Zenfunc['Entity']['attack']({
					"ThirdSeaEldritch Crab",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end


Zenfunc["autothirdseabosses"] = function()
    local fetch = "autothirdseabosses"

    local bossList = {
        "ThirdSeaEldritch Crab",
        "FuryTentacle",
        "SeaDragon",
        "ThirdSeaDragon",
    }

    while (Config and Config[fetch]) and task.wait(0.5) do
        Zenfunc['getPcall'](fetch, function()

            if InRaid then return end 
            local foundAny = false

            for _, bossName in pairs(bossList) do
                if Zenfunc['Entity']['find']({bossName}) then
                    foundAny = true

                    Zenfunc['Entity']['attack']({bossName}, fetch)
                    break
                end
            end

            if not foundAny then
                HopSeaKingThird()
            end

        end)
    end
end


Zenfunc["hopserver"] = function()
    local Http = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")

    local PlaceID = game.PlaceId
    local JobID = game.JobId

    local Api = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"

    local function ListServers(cursor)
        local url = Api .. (cursor and "&cursor=" .. cursor or "")
        local res = game:HttpGet(url)
        return Http:JSONDecode(res)
    end

    local lowestServer = nil
    local lowestPlayers = math.huge
    local nextCursor = nil

    repeat
        local data = ListServers(nextCursor)

        for _, server in pairs(data.data) do
            if server.id ~= JobID and server.playing < server.maxPlayers then
                if server.playing < lowestPlayers then
                    lowestPlayers = server.playing
                    lowestServer = server
                end
            end
        end

        nextCursor = data.nextPageCursor
    until not nextCursor or lowestPlayers <= 1 -- stop early if very low

    if lowestServer then
        TeleportService:TeleportToPlaceInstance(PlaceID, lowestServer.id, Players.LocalPlayer)
    end
end

HopServer1 = function()
    local Http = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")

    local PlaceID = game.PlaceId
    local JobID = game.JobId

    local Api = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"

    local function ListServers(cursor)
        local url = Api .. (cursor and "&cursor=" .. cursor or "")
        local res = game:HttpGet(url)
        return Http:JSONDecode(res)
    end

    local lowestServer = nil
    local lowestPlayers = math.huge
    local nextCursor = nil

    repeat
        local data = ListServers(nextCursor)

        for _, server in pairs(data.data) do
            if server.id ~= JobID and server.playing < server.maxPlayers then
                if server.playing < lowestPlayers then
                    lowestPlayers = server.playing
                    lowestServer = server
                end
            end
        end

        nextCursor = data.nextPageCursor
    until not nextCursor or lowestPlayers <= 1 -- stop early if very low

    if lowestServer then
        TeleportService:TeleportToPlaceInstance(PlaceID, lowestServer.id, Players.LocalPlayer)
    end
end

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local hopping = false

function SafeHop()
    if hopping then return end
    hopping = true

    for i = 1, 5 do -- retry 5 times
        local success, err = pcall(function()
            HopServer1()
        end)

        if success then
            break
        else
            warn("Hop failed, retrying...", i, err)
            task.wait(2) -- wait before retry
        end
    end

    hopping = false
end


Zenfunc["autobosess"] = function()
    local fetch = "autobosess"

    local bossList = {
        "Bushido Ape [Lv. 5000]",
        "Lord of Saber [Lv. 8500]",
        "Expert Swordman [Lv. 3000]",
        "King Samurai [Lv. 3500]",
		"Pteranodon [Lv. 12500]",
		"Ms. Mother [Lv. 7500]",
    }

    while (Config and Config[fetch]) and task.wait(0.5) do
        Zenfunc['getPcall'](fetch, function()

            if InRaid then return end 
            local foundAny = false

            for _, bossName in pairs(bossList) do
                if Zenfunc['Entity']['find']({bossName}) then
                    foundAny = true

                    Zenfunc['Entity']['attack']({bossName}, fetch)
                    break
                end
            end

            if not foundAny then
                HopServer()
            end

        end)
    end
end


Zenfunc["galleonshipboss"] = function()
    local fetch = "galleonshipboss"

    local bossList = {
        "Royal Galleon Boss",
        "Whale Galleon Boss",
        "Shark Galleon Boss",
        "Kraken Galleon Boss",
        "Ghost Galleon Boss",
    }

    while (Config and Config[fetch]) and task.wait(0.5) do
        Zenfunc['getPcall'](fetch, function()

            if InRaid then return end 

            local foundAny = false

            for _, bossName in pairs(bossList) do
                if Zenfunc['Entity']['find']({bossName}) then
                    foundAny = true

                    Zenfunc['Entity']['attack']({bossName}, fetch)
                    break
                end
            end

            if not foundAny then
                HopSeaKingThird()
            end

        end)
    end
end
Zenfunc['Auto Shark Galleon Boss'] = function()
	local fetch = 'Auto Shark Galleon Boss'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Shark Galleon Boss"}) then
				Zenfunc['Entity']['attack']({
					"Shark Galleon Boss",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end



Zenfunc['Auto Chaos Kraken'] = function()
	local fetch = 'Auto Chaos Kraken'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"FuryTentacle"}) then
				Zenfunc['Entity']['attack']({
					"FuryTentacle",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end
Zenfunc['Auto Sea Dragon'] = function()
	local fetch = 'Auto Sea Dragon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"SeaDragon"}) then
				Zenfunc['Entity']['attack']({
					"SeaDragon",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end

Zenfunc['Autobushido'] = function()
	local fetch = 'Autobushido'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Bushido Ape [Lv. 5000]"}) then
				Zenfunc['Entity']['attack']({
					"Bushido Ape [Lv. 5000]",
				}, fetch)
			else
				HopServer()
			end
		end)
	end
end

Zenfunc['Autolordsaber'] = function()
	local fetch = 'Autolordsaber'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Lord of Saber [Lv. 8500]"}) then
				Zenfunc['Entity']['attack']({
					"Lord of Saber [Lv. 8500]",
				}, fetch)
			else
				HopServer()
			end
		end)
	end
end

Zenfunc['Auto Shark Galleon Boss'] = function()
	local fetch = 'Auto Shark Galleon Boss'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Shark Galleon Boss"}) then
				Zenfunc['Entity']['attack']({
					"Shark Galleon Boss",
				}, fetch)
			else
				HopSeaKingThird()
			end
		end)
	end
end
local Fishgg = {}
local OldWeapon = nil

function GetCurrentWeapon()
	for _,v in pairs(Client.Character:GetChildren()) do
		if v:IsA("Tool") then
			return v.Name
		end
	end
	return nil
end

Zenfunc['Auto Serpent'] = function()
	local fetch = 'Auto Serpent'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end

			local hasRodEquipped = Client.Character:FindFirstChild("Basic Rod")
			local hrp = Client.Character:FindFirstChild("HumanoidRootPart")

			if Zenfunc['Entity']['find']({"Serpent"}) then
				
				if hasRodEquipped and OldWeapon then
					game:GetService("ReplicatedStorage").Chest.Remotes.Functions.InventoryEq:InvokeServer(OldWeapon)
				end

				Zenfunc['Entity']['attack']({
					"Serpent",
				}, fetch)

			else
				if workspace.Effects:FindFirstChild('SerpentWhirlpool') then

					local whirl = workspace.Effects.SerpentWhirlpool:GetPivot()

					if not Client.Character:FindFirstChild('Basic Rod') then
						OldWeapon = GetCurrentWeapon()
						game:GetService("ReplicatedStorage").Chest.Remotes.Functions.InventoryEq:InvokeServer("Basic Rod")
					end

					if Client.PlayerGui:FindFirstChild('FishingUI') then
						for i,v in next, Fishgg do
							task.cancel(v)
						end
						Client.PlayerGui.FishingUI.FishingBackground.FishingBar.Size = UDim2.new(1, 0, 1.4, 0)
					else
						Fishgg[#Fishgg + 1] = task.spawn(function()
							local args = {
								"SW_Basic Rod_M1",
								{
									Charge = math.huge,
									MouseHit = whirl
								}
							}
							game:GetService("ReplicatedStorage").Chest.Remotes.Functions.SkillAction:InvokeServer(unpack(args))
						end)
					end

					EquipTools('Basic Rod')

					if hrp then
						hrp.CFrame = whirl + Vector3.new(0, 12, 0)
					end

				else
					HopSeaKingThird()
				end
			end
		end)
	end
end
local touchedChests = {}

Zenfunc['Auto Kill Minion'] = function()
    local funcx = 'Auto Kill Minion'

    local function GetNearbyTargets(pos, range)
        local result = {}

        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                if string.find(v.Name, "Minion") or string.find(v.Name, "Boss") then
                    local dist = (v.HumanoidRootPart.Position - pos).Magnitude
                    if dist <= range then
                        table.insert(result, v.Name)
                    end
                end
            end
        end

        return result
    end

    while Config[funcx] and task.wait() do
        Zenfunc['getPcall'](funcx, function()
            if InRaid then return end

            local found = false

            for _, spawnPart in pairs(workspace.EventSpawns:GetChildren()) do
                if spawnPart.Name == "Spawn" then

                    Client.Character.HumanoidRootPart.CFrame = spawnPart.CFrame
                    task.wait(0.5)

                    local targets = GetNearbyTargets(spawnPart.Position, 200)

                    if #targets > 0 then
                        found = true
                        Zenfunc['Entity']['attack'](targets, funcx)
                        break
                    end

                    if spawnPart:FindFirstChild("Chest") then
                        local chest = spawnPart.Chest
                        local chestCFrame = chest.RootPart.CFrame

                        if not touchedChests[chestCFrame] then
                            touchedChests[chestCFrame] = true
                            tp({Target = chestCFrame})
                        end
                    end
                end
            end

            if not found then
                task.wait(1)
            end
        end)
    end
end

local CFrameBossM = {}
local touchedChests = {}

Zenfunc['Auto Kill Minion1'] = function()
    local funcx = 'Auto Kill Minion1'

    local function GetTargets()
        local result = {}
        local entities = Zenfunc['Entity']['find']({"Bandit"}, true)

        for _,v in pairs(entities or {}) do
            local name = v.Name or ""

            if string.find(name, "Bandit Minion") or string.find(name, "Bandit Boss") then
                local tier = tonumber(string.match(name, "Tier%s*(%d+)"))

                if tier then
                    if string.find(name, "Bandit Minion") and tier == Config["Minion Tier"] then
                        table.insert(result, name)
                    elseif string.find(name, "Bandit Boss") and tier == Config["Boss Tier"] then
                        table.insert(result, name)
                    end
                end
            end
        end

        return result
    end

    while Config[funcx] and task.wait() do
        Zenfunc['getPcall'](funcx, function()
            if InRaid then return end

            local eventSpawns = workspace.EventSpawns:GetChildren()
            local minionFound = false

            for _, v in pairs(eventSpawns) do
                if v.Name == "Spawn" and v:FindFirstChild("Chest") then
                    local chest = v.Chest
                    local chestCFrame = chest.RootPart.CFrame

                    if not touchedChests[chestCFrame] then
                        touchedChests[chestCFrame] = true
                        tp({Target = chestCFrame})

                        for i = 1, 7 do
                            local chestPart = workspace:FindFirstChild("Chest"..i)
                            if chestPart and chestPart:FindFirstChild("RootPart") then
                                Client.Character.HumanoidRootPart.CFrame = chestPart.RootPart.CFrame
                            end
                        end
                    end
                end

                local targets = GetTargets()

                if #targets > 0 then
                    minionFound = true
                    Zenfunc['Entity']['attack'](targets, funcx)
                    break
                end
            end

            if not minionFound then
                for _, spawnPart in pairs(eventSpawns) do
                    if spawnPart.Name == "Spawn" then
                        Client.Character.HumanoidRootPart.CFrame = spawnPart.CFrame
                        task.wait(1)

                        local targets = GetTargets()

                        if #targets > 0 then
                            minionFound = true
                            Zenfunc['Entity']['attack'](targets, funcx)
                            break
                        end
                    end
                end
            end
        end)
    end
end
Zenfunc['Auto Expert Swordman'] = function()
	local fetch = 'Auto Expert Swordman'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Expert Swordman [Lv. 3000]"}) then
				Zenfunc['Entity']['attack']({
					"Expert Swordman [Lv. 3000]"
				}, fetch)
			else
				if Config['Auto Expert Swordman (HOP)'] then
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
			end
		end)
	end
end
Zenfunc['Auto Sea King'] = function() 
	local fetch = 'Auto Sea King'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"SeaKing"}) then
				Zenfunc['Entity']['attack']({
					"SeaKing",
				}, fetch)
			else
				seaChest()
			end
		end)
	end
end
Zenfunc['Auto Hydra Sea King'] = function() 
	local fetch = 'Auto Hydra Sea King'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
				if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
					Zenfunc['Entity']['attack']({
						"HydraSeaKing",
					}, fetch, 50)
				else
					Zenfunc['Entity']['attack']({
						"HydraSeaKing",
					}, fetch)
				end
			else
				seaChest()
			end
		end)
	end
end
local function updateCam(target)
	local camera = game.Workspace.CurrentCamera
	if target and target:FindFirstChild("HumanoidRootPart") then
		local aimPart = target:FindFirstChild("HumanoidRootPart")
		local velocityOffset = Vector3.new(0, 0, 0)
		local predictionValue = 0
		if aimPart:FindFirstChild("Velocity") and predictionValue > 0 then
			velocityOffset = aimPart.Velocity / predictionValue
		end
		local mainCFrame = CFrame.new(camera.CFrame.p, aimPart.Position + velocityOffset)
		camera.CFrame = camera.CFrame:Lerp(mainCFrame, 0.2)
	end
end
vv = nil
ShiftLock = false
local _camHeartbeatClock = 0
game:GetService('RunService').Heartbeat:Connect(function()
	local _now = os.clock()
	if _now - _camHeartbeatClock < 0.05 then return end
	_camHeartbeatClock = _now
	pcall(function()
		if vv then
			updateCam(vv)
		end
	end)
end)
task.spawn(function()
	local _vim = game:GetService("VirtualInputManager")
	while task.wait(0.3) do
		pcall(function()
			if Config["Auto Clear Dungeon"] then
				_vim:SendKeyEvent(true, "I", false, game)
			end
		end)
	end
end)
Zenfunc['Auto Clear Dungeon'] = function()
	local fetch = 'Auto Clear Dungeon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if not InRaid then return end
			if Client.PlayerGui:FindFirstChild("GoldenArena GUI") and Client.PlayerGui:WaitForChild('GoldenArena GUI'):FindFirstChild("StartButton") then
				repeat wait() 
					if Client.PlayerGui:FindFirstChild("GoldenArena GUI") and Client.PlayerGui:FindFirstChild("GoldenArena GUI").StartButton.Visible then
						if Client.PlayerGui:WaitForChild("GoldenArena GUI"):FindFirstChild("StartButton") then
							GuiService.SelectedObject = Client.PlayerGui:FindFirstChild("GoldenArena GUI").StartButton
							VirtualInputManager:SendKeyEvent(true, "Return", false, game)
							VirtualInputManager:SendKeyEvent(false, "Return", false, game)
						end
					end
				until not Client.PlayerGui:FindFirstChild("GoldenArena GUI").StartButton.Visible
			end
			if not ShiftLock and game.UserInputService:GetPlatform() ~= Enum.Platform.Windows then
				ShiftLock = true
				game:service('VirtualInputManager'):SendKeyEvent(true, "LeftShift", false, game) wait(1)
				game:service('VirtualInputManager'):SendKeyEvent(false, "LeftShift", false, game)
			end
			for i,v in pairs(workspace.MOB:GetChildren()) do
				if v and v.Parent and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					repeat
						local healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
						if healthPercentage > 45 then
							game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
							if Config['Select Type Mode'] == "Magma" then
								tp({
									Target = v.HumanoidRootPart.CFrame * CFrame.new( -15, 170, 5) * CFrame.Angles(math.rad(-90),0,0),
								})
								local run = function()
									getgenv().PosMonSkill = v.HumanoidRootPart.CFrame
									vv = v
									if not Item.CheckOnCooldown("Z") and not Item.CheckSkillLock("Z") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
									end
									if not Item.CheckOnCooldown("X") and not Item.CheckSkillLock("X") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
									end
									if not Item.CheckOnCooldown("V") and not Item.CheckSkillLock("V") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end
									if not Item.CheckOnCooldown("C") and not Item.CheckSkillLock("C") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
									end
									if not Item.CheckOnCooldown("E") and not Item.CheckSkillLock("E") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
									end
								end
								EquipTools('MagmaMagma')
								lp[#lp+1] = task.spawn(pcall, run)
							else
								local brig = function()
									Attack()
								end
								lp[#lp+1] = task.spawn(pcall, brig)
								getgenv().PosMonSkill = v.HumanoidRootPart.CFrame
								tp({
									Target = v.HumanoidRootPart.CFrame * CFrame.new( 0, 8, 3) * CFrame.Angles(math.rad(-90),0,0),
								})
								local run = function()
									useSkill()
								end
								lp[#lp+1] = task.spawn(pcall, run)
							end
						else
							repeat
								healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
								tp({ Target = CFrame.new(-5, 21, 89) * CFrame.new(0,1500,0), })
								if not Client.Character:FindFirstChild('Cyborg') then
									EquipTools('Cyborg')
								end
								if Client.Character:FindFirstChild('Cyborg') and not Item.CheckOnCooldown("E") then
									game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
								end
								if Client.Character:FindFirstChild('Cyborg') and Item.CheckOnCooldown("E") then
									game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
								end
								task.wait()
							until not Config[fetch] or (Item.CheckOnCooldown("E") and healthPercentage > 75)
						end
						task.wait()
					until not Config[fetch] or not v or not v.Parent or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 
					if #lp >= 1 then
						for i,v in pairs(lp) do
							pcall(task.cancel, v)
						end
						table.clear(lp)
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Rejoin Dungeon'] = function()
	local fetch = 'Auto Rejoin Dungeon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			tp({ Target = workspace.CircleBeam.CFrame * CFrame.new(0, 10, 0) })
		end)
	end
end
Zenfunc['Auto Kill Jack o lantern'] = function()
	local fetch = 'Auto Kill Jack o lantern'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Jack o lantern [Lv. 10000]"}) then
				Zenfunc['Entity']['attack']({
					"Jack o lantern [Lv. 10000]",
				}, fetch)
			else
				if not Config['Auto Kill Jack o lantern Fully'] then
					if not Config['Auto Kill Jack o lantern Hop'] then
						if Sea3 then
							tp({ Target = CFrame.new(2828.4, 78.1, 4865.1) })
						elseif Sea2 then
							tp({ Target = CFrame.new(-6070.5, 17, 3787.9) })
						end
					else
						HopServer(true)
						delay(15, function()
							HopServer()
						end)
					end
				else
					if Sea3 then
						if Zenfunc['getPlayerMaterial']('Candy') < 50 then
							if Zenfunc['Entity']['find']({"Wilderness Gorilla [Lv. 4325]"}) then
								Zenfunc['Entity']['attack']({
									"Wilderness Gorilla [Lv. 4325]",
								}, fetch, nil, {
									Monster = {
										"Jack o lantern [Lv. 10000]"
									},get = "have"
								})
							else
								tp({ Target = CFrame.new(4861, 48.5, 10181.4) })
							end
						else
							for i = 1,3 do wait(1)
								getQuestOld(workspace.AllNPC.SummonJackolantern.CFrame)
							end
						end
					elseif Sea2 then
						if Zenfunc['getPlayerMaterial']('Candy') < 50 then
							if Zenfunc['Entity']['find']({"Skull Pirate [Lv. 3050]"}) then
								Zenfunc['Entity']['attack']({
									"Skull Pirate [Lv. 3050]",
								}, fetch, nil, {
									Monster = {
										"Jack o lantern [Lv. 10000]"
									},get = "have"
								})
							else
								tp({ Target = CFrame.new(-6263.1, 88, 6904.4) })
							end
						else
							for i = 1,3 do wait(1)
								getQuestOld(workspace.AllNPC.SummonJackolantern.CFrame)
							end
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Kill Skull King'] = function()
	local fetch = 'Auto Kill Skull King'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Skull King"}) then
				Zenfunc['Entity']['attack']({
					"Skull King",
				}, fetch)
			else
				if not Config['Skull King Hop'] then
					if not Config['Auto Farm Level'] then
						tp({ Target = CFrame.new(2828.4, 78.1, 4865.1) })
					end
				else
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
			end
		end)
	end
end
Zenfunc['Auto Kill King Samurai'] = function()
	local fetch = 'Auto Kill King Samurai'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"King Samurai [Lv. 3500]"}) then
				Zenfunc['Entity']['attack']({
					"King Samurai [Lv. 3500]",
				}, fetch)
			else
				if Config['King Samurai Hop'] then
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
			end
		end)
	end
end

Zenfunc['Auto Kill Pteranodon'] = function()
	local fetch = 'Auto Kill Pteranodon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Pteranodon [Lv. 12500]"}) then
				Zenfunc['Entity']['attack']({
					"Pteranodon [Lv. 12500]",
				}, fetch)
			else
				if Config['King Samurai Hop'] then
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
			end
		end)
	end
end

local CheckASF = false
local DropTime = tick()
Zenfunc['Auto Store Fruit'] = function()
	local fetch = 'Auto Store Fruit'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			CheckASF = true
			local ListFruit = {}
			for Name,Stock in pairs(game:GetService("ReplicatedStorage").Chest.Remotes.Functions.GetDFShop:InvokeServer()) do
				if Stock == true then
					table.insert(ListFruit, Name)
				end
			end
			if table.find(ListFruit, Config['Select Fruit Stock']) and Config['Auto Eat Fruit'] then return end
			local GuiService = game:GetService("GuiService")
			local VirtualInputManager = game:GetService("VirtualInputManager")
			local backpack = Client.Backpack
			local character = Client.Character
			local playerGui = game.Players.LocalPlayer.PlayerGui
			local tool
			for i,v in pairs(backpack:GetChildren()) do
				if v:IsA('Tool') and v.Name ~= "LegacyPose" and v:GetAttribute('LegacyFruit') then
					tool = v
				end
			end
			for i,v in pairs(character:GetChildren()) do
				if v:IsA('Tool') and v.Name ~= "LegacyPose" and v:GetAttribute('LegacyFruit') then
					tool = v
				end
			end
			local toolName = tool.Name
			print(toolName)
			if tool then
				repeat
					task.wait()
					if character:FindFirstChildOfClass('Tool') then
						tool = character:FindFirstChildOfClass('Tool')
					else
						EquipTools(toolName)
					end
					playerGui = game.Players.LocalPlayer.PlayerGui
					if tool and tool:GetAttribute('LegacyFruit') then
						print(playerGui:FindFirstChild('EatFruitBecky'))
						if not playerGui:FindFirstChild('EatFruitBecky') then
							print('123')
							tool:Activate()
						else
							local fruitStore = Zenfunc['getPlayerFruitStore'](playerGui.EatFruitBecky.OldToolFruit.Value)['Value']
							local dialogue = playerGui.EatFruitBecky.Dialogue
							local actionButton = (fruitStore and Config['Drop if have'] and dialogue:FindFirstChild('Drop')) or dialogue:FindFirstChild('Collect')
							if actionButton then
								GuiService.SelectedObject = actionButton
								VirtualInputManager:SendKeyEvent(true, "Return", false, game)
								VirtualInputManager:SendKeyEvent(false, "Return", false, game)
							end
							if not tool:FindFirstChild('Zen Hub') then
								local Normal = Instance.new('Folder', tool)
								Normal.Name = 'Zen Hub'
							end
						end
					end
				until ( tool.Parent ~= character ) or not Config[fetch]
				if playerGui:FindFirstChild('EatFruitBecky') then
					playerGui:FindFirstChild('EatFruitBecky'):Destroy()
				end
				GuiService.SelectedObject = nil
			end
		end)
	end
end
Zenfunc['Auto Bring Fruits'] = function()
	local fetch = 'Auto Bring Fruits'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			function bringFuits(o, p)
				for i,v in pairs(workspace.AllDroppedFruit:GetDescendants()) do
					if v.Name == "Handle" and not v.Parent:FindFirstChild('Zen Hub') then
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, o)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, p)
					end
				end
				for i,v in pairs(workspace.AllspawnDF:GetDescendants()) do
					if v.Name == "Handle" and not v.Parent:FindFirstChild('Zen Hub') then
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, o)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, p)
					end
				end
			end
			local s, e = pcall(function()
				bringFuits(0,1)
			end)
			if not s then
				if e:find('got number') then
					bringFuits(true, false)
				end
			end
		end)
	end
end
Zenfunc['Auto Enemies Aura'] = function()
	local fetch = 'Auto Enemies Aura'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local groups = {workspace.Monster.Mon, workspace.Monster.Boss, workspace.SeaMonster}
			for _, group in pairs(groups) do
				for _, v in pairs(group:GetChildren()) do
					if v and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - Client.Character.HumanoidRootPart.Position).magnitude <= Config['Enemies Aura'] then
						Zenfunc['Entity']['attack']({
							tostring(v.Name)
						}, fetch)
					end
				end
			end
		end)
	end
end
Zenfunc['getFruitInBackpack'] = function(vv)
	local FruitTable = {}
	for i,v in pairs(Client.Backpack:GetChildren()) do
		if v.Name:find('Fruit') then
			table.insert(FruitTable, string.gsub(v.Name, 'Fruit', '') .. string.gsub(v.Name, 'Fruit', ''))
		end
	end
	for i,v in pairs(Client.Character:GetChildren()) do
		if v.Name:find('Fruit') then
			table.insert(FruitTable, string.gsub(v.Name, 'Fruit', '') .. string.gsub(v.Name, 'Fruit', ''))
		end
	end
	return {
		FruitTable,
	}
end
Zenfunc['makeToIDk'] = function(v)
	return string.gsub(v, 'Fruit', '') .. string.gsub(v, 'Fruit', '')
end
Zenfunc['Auto Eat Fruit'] = function()
	local fetch = 'Auto Eat Fruit'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local tool
			local getAllFruit = Zenfunc['getFruitInBackpack']()
			if Client.PlayerStats.DFName.Value == Config['Select Fruit Stock'] then return end
			local playerGui = Client.PlayerGui
			for i,v in pairs(getAllFruit[1]) do
				if Config['Select Fruit Stock']:find(v) then
					for _,_c in pairs(Client.Backpack:GetChildren()) do
						if v == Zenfunc['makeToIDk'](_c.Name) then
							tool = _c
						end
					end
					for _,_c in pairs(Client.Character:GetChildren()) do
						if v == Zenfunc['makeToIDk'](_c.Name) then
							tool = _c
						end
					end
				end
			end
			if tool then
				EquipTools(tool.Name)
				if not playerGui:FindFirstChild('EatFruitBecky') then
					tool:Activate()
				else
					repeat task.wait()
						local fruitStore = Zenfunc['getPlayerFruitStore'](playerGui.EatFruitBecky.OldToolFruit.Value)['Value']
						local dialogue = playerGui.EatFruitBecky.Dialogue
						local actionButton = dialogue:FindFirstChild('Accept')
						if actionButton then
							GuiService.SelectedObject = actionButton
							VirtualInputManager:SendKeyEvent(true, "Return", false, game)
							VirtualInputManager:SendKeyEvent(false, "Return", false, game)
						end
					until not tool or not tool:FindFirstChild('DevilFruit') or not Config[fetch]
					if CheckASF then
						if not Config['Auto Store Fruit'] then
							Config['Auto Store Fruit'] = true
						end
					end
				end
			else
				local ListFruit = {}
				for Name,Stock in pairs(game:GetService("ReplicatedStorage").Chest.Remotes.Functions.GetDFShop:InvokeServer()) do
					if Stock == true then
						table.insert(ListFruit, Name)
					end
				end
				warn(CheckASF)
				if table.find(ListFruit, Config['Select Fruit Stock']) then
					if Config['Auto Store Fruit'] then
						for i = 1, 5 do wait()
							Config['Auto Store Fruit'] = false
						end
					end
					game:GetService("ReplicatedStorage").Chest.Remotes.Functions.BuyFruitStock:InvokeServer(Config['Select Fruit Stock'])
					wait(1)
				end
			end
		end)
	end
end
Zenfunc['Auto Ally Accept All'] = function()
	local fetch = 'Auto Ally Accept All'
	while Config[fetch] and task.wait(.25) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			for i,v in pairs(game.Players:GetChildren()) do task.wait()
				game:GetService("ReplicatedStorage").Chest.Remotes.Functions.Ally:InvokeServer({["Action"] = "Confirm",["Target"] = tostring(v.Name)})
			end
		end)
	end
end
Zenfunc['Auto Kill Dragon'] = function()
	local fetch = 'Auto Kill Dragon'
	while Config[fetch] and task.wait(0.1) do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Dragon [Lv. 5000]"}) then
				Zenfunc['Entity']['attack']({
					"Dragon [Lv. 5000]",
				}, fetch)
			else
				if Config['Dragon Hop'] then
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
					return
				end
				if Zenfunc['getPlayerMaterial']("Dragon's Orb") > 0 and Config['Spawn Dragon'] then
					getQuestOld(workspace.AllNPC:FindFirstChild("SummonDragon").CFrame)
				else
					if Zenfunc['Entity']['find']({"Elite Skeleton [Lv. 3100]"}) and not Config['Auto Farm Level'] then
						Zenfunc['Entity']['attack']({
							"Elite Skeleton [Lv. 3100]",
						}, fetch, nil, {
							Monster = {
								"Dragon [Lv. 5000]"
							},get = "have"
						})
					else
						if not Config['Auto Farm Level'] then
							tp({Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)})
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Kill BigMom'] = function()
	local fetch = 'Auto Kill BigMom'
	while Config[fetch] and wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({"Ms. Mother [Lv. 7500]"}) then
				Zenfunc['Entity']['attack']({
					"Ms. Mother [Lv. 7500]",
				}, fetch)
			else
				if Config['BigMom Hop'] then
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
			end
		end)
	end
end
Zenfunc['Start Select Monster Farm'] = function()
	local fetch = 'Start Select Monster Farm'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['Entity']['find']({Config['Select Monster']}) then
				Zenfunc['Entity']['attack']({
					Config['Select Monster'],
				}, fetch)
			else
				local mobModel = Repli.MOB:FindFirstChild(Data['Mob'])
				if monsterPot[Config['Select Monster']]then
					tp({Target =  monsterPot[Config['Select Monster']] * CFrame.new(0, 30, 0)})
				end
			end
		end)
	end
end
local NeedSending = {}
Zenfunc['Sending if have new Sword'] = function()
	local fetch = 'Sending if have new Sword'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Config['Sending WebHook'] then return end
			if Config['Webhook'] == "" then return end
			if not NeedSending['Sword'] then
				NeedSending['Sword'] = game:GetService("Players").LocalPlayer.Inventory.ChildAdded:Connect(function(Child)
					local PlayerSwords = {}
					local tierOrder = {Common = 7, Uncommon = 6, Rare = 5, Epic = 4, Legendary = 3, Mythical = 2, Limited = 1}
					for _, v in pairs(game:GetService("Players").LocalPlayer.Inventory:GetChildren()) do
						local swordData = require(game:GetService("ReplicatedStorage").Chest.Modules.SwordList)[v.Name]
						if swordData and swordData.Tier then
							table.insert(PlayerSwords, {Name = v.Name, Tier = swordData.Tier})
						end
					end
					table.sort(PlayerSwords, function(a, b)
						return tierOrder[a.Tier] < tierOrder[b.Tier]
					end)
					local DataSword = require(game:GetService("ReplicatedStorage").Chest.Modules.SwordList)
					local swordTier = DataSword[Child.Name] and DataSword[Child.Name].Tier
					if swordTier and not Config["Show " .. swordTier] then return end
					local formatted = "\n"
					for _, sword in pairs(PlayerSwords) do
						if Config["Show " .. sword.Tier] then
							formatted = formatted .. (Child.Name == sword.Name and _G.greencircle.." : " or "🔵 : ") .. sword.Name .. ' [' .. sword.Tier .. ']' .. (Child.Name == sword.Name and " (NEW)" or "") .. "\n"
						end
					end
					if formatted ~= "\n" then
						sendwebhook(Config['Webhook'], {
							["content"] = ((Config['Ping Discord Id'] and Config['Discord Id Ping'] ~= "") and "<@"..Config['Discord Id Ping']..">") or "",
							["embeds"] = {{
								["id"] = 661605297,
								["title"] = "Zen Hub Notify NEW SWORD!!",
								["description"] = '```\n' .. formatted .. ' \n```',
								["color"] = 8646911,
								["footer"] = {
									["text"] = "Zen Hub Notify KL",
									["icon_url"] = "https://cdn.discordapp.com/attachments/971367335405449246/1259442279672844308/Profile_1.png"
								}
							}}
						})
					end
				end)
			end
		end)
	end
end


Zenfunc['Sending if have new Accessories'] = function()
	local fetch = 'Sending if have new Accessories'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Config['Sending WebHook'] then return end
			if Config['Webhook'] == "" then return end
			if not NeedSending['Accessories'] then
				NeedSending['Accessories'] = game:GetService("Players").LocalPlayer.Accessories.ChildAdded:Connect(function(Child)
					local PlayerAccessories = {}
					local tierOrder = {
						Common = 7,
						Uncommon = 6,
						Rare = 5,
						Epic = 4,
						Legendary = 3,
						Mythical = 2,
						Limited = 1
					}
					for _i, _v in pairs(game:GetService("Players").LocalPlayer.Accessories:GetChildren()) do
						for i, v in pairs(require(game:GetService("ReplicatedStorage").Chest.Modules.AccessoriesList)) do
							if v and v.Tier then
								if _v.Name == i then
									table.insert(PlayerAccessories, {Name = i, Tier = v.Tier})
								end
							end
						end
					end
					table.sort(PlayerAccessories, function(a, b)
						return tierOrder[a.Tier] < tierOrder[b.Tier]
					end)
					local DataAccessories = require(game:GetService("ReplicatedStorage").Chest.Modules.SwordList)
					local AccessoriesTier = DataAccessories[Child.Name] and DataAccessories[Child.Name].Tier
					if AccessoriesTier and not Config["Show " .. AccessoriesTier] then return end
					local formatted = "\n"
					for _, accessories in pairs(PlayerAccessories) do
						if Config["Show " .. accessories.Tier] then
							formatted = formatted .. (Child.Name == accessories.Name and _G.greencircle.." : " or "🔵 : ") .. accessories.Name .. ' [' .. accessories.Tier .. ']' .. (Child.Name == accessories.Name and " (NEW)" or "") .. "\n"
						end
					end
					if formatted ~= "\n" then
						local SendingSuccess = sendwebhook( Config['Webhook'], {
							["content"] = ((Config['Ping Discord Id'] and Config['Discord Id Ping'] ~= "") and "<@"..Config['Discord Id Ping']..">") or "",
							["embeds"] = {{
								["id"]= 661605297,
								["title"]= "Zen Hub Notify NEW ".. string.upper('Accessories') .."!!",
								["description"] = '```\n '.. formatted ..' \n```',
								["color"]= 8646911,
								["fields"]= {},
								["footer"]= {
									["text"]  = "Zen Hub Notify KL",
									["icon_url"] = "https://cdn.discordapp.com/attachments/971367335405449246/1259442279672844308/Profile_1.png?ex=66fbc206&is=66fa7086&hm=0b8898eb98938e100ad3cede12d0a526d344cd3ba7d4f737f728ca188a1af027&"
								}
							}}
						})
					end
				end)
			end
		end)
	end
end
local previousFruits = game:GetService("HttpService"):JSONDecode(game.Players.LocalPlayer.PlayerStats.FruitStore.Value)
Zenfunc['Sending if have new Fruit'] = function()
	local fetch = 'Sending if have new Fruit'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Config['Sending WebHook'] then return end
			if Config['Webhook'] == "" then return end
			if not NeedSending['Fruit'] then
				NeedSending['Fruit'] = game.Players.LocalPlayer.PlayerStats.FruitStore.Changed:Connect(function()
					local HttpService = game:GetService("HttpService")
					local currentFruits = HttpService:JSONDecode(game.Players.LocalPlayer.PlayerStats.FruitStore.Value)
					local FruitTier = require(game:GetService("ReplicatedStorage").Chest.Modules.DFTier)
					local formatted = "\n"
					local function shouldShowTier(fruit)
						for tier, fruits in pairs(FruitTier) do
							if table.find(fruits, fruit) then
								return Config["Show " .. tier]
							end
						end
						return true
					end
					local function getTier(fruit)
						for tier, fruits in pairs(FruitTier) do
							if table.find(fruits, fruit) then
								return tier
							end
						end
						return "Unknown"
					end
					for getfruit, numfruit in pairs(currentFruits) do
						if shouldShowTier(getfruit) then
							if not previousFruits[getfruit] then
								formatted = formatted .. _G.greencircle.." : " .. getfruit .. " [ " .. getTier(getfruit) .. " ] [ " .. numfruit .. " ] (NEW)\n"
							else
								formatted = formatted .. "🔵 : " .. getfruit .. " [ " .. getTier(getfruit) .. " ] [ " .. numfruit .. " ]\n"
							end
						end
					end
					if formatted ~= "\n" then
						local SendingSuccess = sendwebhook(Config['Webhook'], {
							["content"] = (Config['Ping Discord Id'] and Config['Discord Id Ping'] ~= "") and "<@"..Config['Discord Id Ping']..">" or "",
							["embeds"] = {{
								["id"] = 661605297,
								["title"] = "Zen Hub Notify NEW " .. string.upper('Fruit') .. "!!",
								["description"] = '```\n' .. formatted .. ' \n```',
								["color"] = 8646911,
								["footer"] = {
									["text"] = "Zen Hub Notify KL",
									["icon_url"] = "https://cdn.discordapp.com/attachments/971367335405449246/1259442279672844308/Profile_1.png?ex=66fbc206&is=66fa7086&hm=0b8898eb98938e100ad3cede12d0a526d344cd3ba7d4f737f728ca188a1af027&"
								}
							}}
						})
					end
					previousFruits = currentFruits
					wait(1.5)
				end)
				wait(1)
			end
		end)
	end
end
cheatKey = {}
KeepcheatKey = 0
Zenfunc['Auto Ghost Ship'] = function()
	local fetch = 'Auto Ghost Ship'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Sea2 then
				if Zenfunc['Entity']['find']({"Ghost Ship"}) then
					Zenfunc['Entity']['attack']({
						"Ghost Ship",
					}, fetch)
				else
					seaChest()
				end
			end
		end)
	end
end
Zenfunc['Auto UpStast'] = function()
	local fetch = 'Auto UpStast'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			for _, stat in ipairs(Config['Select Stast']) do task.wait()
				if Client.PlayerStats.Points.Value >= 1 then
					local args = {
						[1] = stat,
						[2] = 1
					}
					Client.PlayerGui.MainGui.StarterFrame.StatsFrame.RemoteEvent:FireServer(unpack(args))
				end
			end 
		end)
	end
end
Zenfunc['getQuestProgression'] = function(Quest)
	for i,v in pairs(game:GetService("HttpService"):JSONDecode(game:GetService("Players").LocalPlayer.PlayerStats.QuestProgression.Value)) do
		if i == Quest then
			return {
				['index'] = i,
				['value'] = v
			}
		end
	end
	return {
		['index'] = nil,
		['value'] = nil
	}
end
Zenfunc['Auto Authentic Triple Katana V2'] = function()
	local fetch = 'Auto Authentic Triple Katana V2'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if not Client.Inventory:FindFirstChild("Authentic Triple Katana") then return end
			if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then
				game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Authentic Triple Katana")
			end
			local QuestProgression = Zenfunc['getQuestProgression']('ATKV2')
			if QuestProgression['index'] and QuestProgression['value'] == 1 then
				if Zenfunc['Entity']['find']({"Floffy [Lv. 3775]"}) then
					if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then return end
					Zenfunc['Entity']['attack']({
						"Floffy [Lv. 3775]",
					}, fetch)
				else
					if monsterPot["Floffy [Lv. 3775]"]then
						tp({Target =  monsterPot["Floffy [Lv. 3775]"] * CFrame.new(0, 30, 0)})
					end
				end
			elseif QuestProgression['index'] and QuestProgression['value'] == 2 then
				if Zenfunc['getPlayerMaterial']('Diverse Sphere') then
					tp({Target = CFrame.new(5448.47852, 188.625977, -3692.90161, -0.373638391, -0, -0.927574396, 0, -1, 0, -0.927574396, 0, 0.373638451)})
					fireproximityprompt(workspace.Island["H - Fiore"]["Campfire 1"].ProximityPrompt, 1)
				end
			elseif QuestProgression['index'] and QuestProgression['value'] == 3 then
				getQuestOld(workspace.AllNPC["ATK Progression 2"].CFrame)
				delay(1.5, function()
					Client.Character.Humanoid.Health = 0
				end)
			elseif QuestProgression['index'] and QuestProgression['value'] == 4 then
				if Zenfunc['Entity']['find']({"Dragon [Lv. 5000]"}) then
					if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then return end
					Zenfunc['Entity']['attack']({
						"Dragon [Lv. 5000]",
					}, fetch)
				else
					if Zenfunc['getPlayerMaterial']("Dragon's Orb") > 0 then
						getQuestOld(workspace.AllNPC:FindFirstChild("SummonDragon").CFrame)
					else
						if Zenfunc['Entity']['find']({"Elite Skeleton [Lv. 3100]"}) then
							if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then return end
							Zenfunc['Entity']['attack']({
								"Elite Skeleton [Lv. 3100]",
							}, fetch, nil, {
								Monster = {
									"Dragon [Lv. 5000]"
								},get = "have"
							})
						else
							tp({Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)})
						end
					end
				end
			elseif QuestProgression['index'] and QuestProgression['value'] == 5 then
				tp({Target = CFrame.new(6045.31445, 70.1999969, -2116.23779, 1.78813934e-06, 0.0193333924, 0.99981308, -1, 1.78813934e-06, 1.78813934e-06, -1.78813934e-06, -0.99981308, 0.0193334222)})
				fireproximityprompt(workspace.Island["H - Fiore"]["Campfire 2"].ProximityPrompt, 1)
			elseif QuestProgression['index'] and QuestProgression['value'] == 6 then
				getQuestOld(workspace.AllNPC["ATK Progression 3"].CFrame)
				delay(1.5, function()
					Client.Character.Humanoid.Health = 0
				end)
			elseif QuestProgression['index'] and QuestProgression['value'] == 7 then
				if Zenfunc['Entity']['find']({"Lucidus [Lv. 3575]"}) then
					if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then return end
					Zenfunc['Entity']['attack']({
						"Lucidus [Lv. 3575]",
					}, fetch)
				else
					if Zenfunc['getPlayerMaterial']("Lucidus's Totem") > 0 then
						local args = {
							[1] = "QuestSpawnBoss",
							[2] = {
								["SuccessQuest"] = "Quest Accepted.",
								["BossName"] = "Lucidus [Lv. 3575]",
								["LevelNeed"] =  3575,
								["QuestName"] = "",
								["MaterialNeed"] = "Lucidus's Totem",
							}
						}
						game.ReplicatedStorage:WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(args))
					else
						if Zenfunc['Entity']['find']({"Hefty [Lv. 3550]"}) then
							if not Client.Backpack:FindFirstChild('Authentic Triple Katana') and not Client.Character:FindFirstChild('Authentic Triple Katana') and Client.Character.Humanoid.Health > 0 then return end
							Zenfunc['Entity']['attack']({
								"Hefty [Lv. 3550]",
							}, fetch, nil, {
								Monster = {
									"Lucidus [Lv. 3575]"
								},get = "have"
							})
						else
							if monsterPot["Hefty [Lv. 3550]"]then
								tp({Target =  monsterPot["Hefty [Lv. 3550]"] * CFrame.new(0, 30, 0)})
							end
						end
					end
				end
			elseif QuestProgression['index'] and QuestProgression['value'] == 8 then
				tp({Target = CFrame.new(7014.82470703125, 131.63641357421875, -2872.841796875)})
				fireproximityprompt(workspace.Island["H - Fiore"]["Campfire 3"].ProximityPrompt, 1)
			elseif QuestProgression['index'] and QuestProgression['value'] == 9 then
				getQuestOld(workspace.AllNPC["ATK Progression 4"].CFrame)
				delay(1.5, function()
					Client.Character.Humanoid.Health = 0
				end)
			elseif QuestProgression['index'] and QuestProgression['value'] == 10 then
				if Zenfunc['getPlayerMaterial']("Hydra's Tail") > 0 and Zenfunc['getPlayerMaterial']("Sea King's Fin") > 2 then
					getQuestOld(workspace.AllNPC["ATK Progression 5"].CFrame)
				else
					if Config['Auto Authentic Triple Katana V2 Fully'] then
						if Zenfunc['Entity']['find']({"SeaKing"}) then
							Zenfunc['Entity']['attack']({
								"SeaKing",
							}, fetch)
						else
							if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
								if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
									Zenfunc['Entity']['attack']({
										"HydraSeaKing",
									}, fetch, 50)
								else
									Zenfunc['Entity']['attack']({
										"HydraSeaKing",
									}, fetch)
								end
							else
								seaChest(true)
							end
						end
					end
				end
			else
				getQuestOld(workspace.AllNPC["ATK Progression 1"].CFrame)
				delay(1.5, function()
					Client.Character.Humanoid.Health = 0
				end)
			end
		end)
	end
end
Zenfunc['getRace'] = function()
	local level = 0
	local Race = ""
	for i,v in pairs(game:GetService("HttpService"):JSONDecode(game:GetService("Players").LocalPlayer.PlayerStats.RaceTbl.Value)) do
		if i == "Appearance" then
			level = v
		end
		if i == "Race" then
			Race = v
		end
	end
	return {
		['Level'] = level,
		['Race'] = Race
	}
end
Zenfunc['Auto Race Shark V2 Fully'] = function()
	local fetch = 'Auto Race Shark V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local QuestProgression = Zenfunc['getQuestProgression']('FishV2')
			local seax2 = {
				['Sea1'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame,
				['Sea2'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame
			}
			if QuestProgression['index'] and QuestProgression['value'] >= 7 then
				if not Sea2 then
					getQuestOld(seax2['Sea2'])
				else 
					getQuestOld(workspace.AllNPC["Fish Progression 2"].CFrame)
				end
			elseif QuestProgression['index'] and QuestProgression['value'] >= 6 then
				if not Sea2 then
					getQuestOld(seax2['Sea2'])
				else 
					getQuestOld(workspace.AllNPC["Fish Progression 1"].CFrame)
				end
			elseif QuestProgression['index'] and QuestProgression['value'] >= 1 then
				if not Client.Backpack:FindFirstChild('Demon Trident') and not Client.Character:FindFirstChild('Demon Trident') then
					game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Demon Trident")
				end
				if not Sea2 then
					getQuestOld(seax2['Sea2'])
				else
					if Zenfunc['Entity']['find']({"SeaKing"}) then
						Zenfunc['Entity']['attack']({
							"SeaKing",
						}, fetch)
					else
						if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
							if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch, 50)
							else
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch)
							end
						else
							seaChest(true)
						end
					end
				end
			else
				if Sea2 and Zenfunc['getPlayerMaterial']("Sea King's Fin") > 0 and Zenfunc['getPlayerMaterial']("Sea King's Blood") > 2 and Zenfunc['getPlayerMaterial']("Fresh Fish") > 99 then
					getQuestOld(workspace.AllNPC["Fish Progression 1"].CFrame)
				else
					if Zenfunc['getPlayerMaterial']("Fresh Fish") < 100 then
						if not Sea1 then
							getQuestOld(seax2['Sea1'])
						else
							if  Zenfunc['Entity']['find']({"Karate Fishman [Lv. 200]","Fighter Fishman [Lv. 180]","Shark Man [Lv. 230]"}) then
								Zenfunc['Entity']['attack']({
									"Karate Fishman [Lv. 200]",
									"Fighter Fishman [Lv. 180]",
									"Shark Man [Lv. 230]",
								}, fetch)
							else
								tp({Target = workspace.Island["D - Shark Island"].D.Base:GetChildren()[57].CFrame * CFrame.new(0 ,50, 0)})
							end
						end
					elseif Zenfunc['getPlayerMaterial']("Sea King's Fin") < 1 and Zenfunc['getPlayerMaterial']("Sea King's Blood") < 3 then
						if not Sea2 then
							getQuestOld(seax2['Sea2'])
						else
							if Zenfunc['Entity']['find']({"SeaKing"}) then
								Zenfunc['Entity']['attack']({
									"SeaKing",
								}, fetch)
							else
								if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
									if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
										Zenfunc['Entity']['attack']({
											"HydraSeaKing",
										}, fetch, 50)
									else
										Zenfunc['Entity']['attack']({
											"HydraSeaKing",
										}, fetch)
									end
								else
									seaChest(true)
								end
							end
						end
					elseif not Client.Inventory:FindFirstChild("Demon Trident") then
						if Repli.MOB:FindFirstChild("Seasoned Fishman [Lv. 2200]") then
							tp({Target = Repli.MOB:FindFirstChild("Seasoned Fishman [Lv. 2200]"):GetPivot()})
						else
							tp({Target = CFrame.new(-1865.43481, 45.2696266, 6722.8501, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)})
						end
						if Zenfunc['Entity']['find']({"Seasoned Fishman [Lv. 2200]"}) then
							Zenfunc['Entity']['attack']({
								"Seasoned Fishman [Lv. 2200]"
							}, fetch)
						end
					else
						if not Sea2 then
							getQuestOld(seax2['Sea2'])
						else 
							getQuestOld(workspace.AllNPC["Fish Progression 1"].CFrame)
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Race Mink V2 Fully'] = function()
	local fetch = 'Auto Race Mink V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local QuestProgression = Zenfunc['getQuestProgression']('MinkV2')
			if QuestProgression['value'] == 11 then
			elseif QuestProgression['value'] == 10 then
				getQuestOld(workspace.AllNPC["Mink Progression 11"].CFrame) wait(1)
			elseif QuestProgression['value'] == 9 then
				getQuestOld(workspace.AllNPC["Mink Progression 10"].CFrame) wait(1)
			elseif QuestProgression['value'] == 8 then
				getQuestOld(workspace.AllNPC["Mink Progression 9"].CFrame) wait(1)
			elseif QuestProgression['value'] == 7 then
				getQuestOld(workspace.AllNPC["Mink Progression 8"].CFrame) wait(1)
			elseif QuestProgression['value'] == 6 then
				getQuestOld(workspace.AllNPC["Mink Progression 7"].CFrame) wait(1)
			elseif QuestProgression['value'] == 5 then
				getQuestOld(workspace.AllNPC["Mink Progression 6"].CFrame) wait(1)
			elseif QuestProgression['value'] == 4 then
				getQuestOld(workspace.AllNPC["Mink Progression 5"].CFrame) wait(1)
			elseif QuestProgression['value'] == 3 then
				getQuestOld(workspace.AllNPC["Mink Progression 4"].CFrame) wait(1)
			elseif QuestProgression['value'] == 2 then
				getQuestOld(workspace.AllNPC["Mink Progression 3"].CFrame) wait(1)
			elseif QuestProgression['value'] == 1 then
				getQuestOld(workspace.AllNPC["Mink Progression 2"].CFrame) wait(1)
			else
				if not Sea2 then getQuestOld(FF['Teleport To Sea 2'], 2) return end
				if Zenfunc['getPlayerMaterial']('Carrot') > 8199 then
					getQuestOld(workspace.AllNPC["Mink Progression 1"].CFrame)
				else
					if Zenfunc['Entity']['find']({"Beast Pirate [Lv. 2250]", "Powerful Beast Pirate [Lv. 2450]", "Bandit Beast Pirate [Lv. 2400]"}) then
						Zenfunc['Entity']['attack']({
							"Beast Pirate [Lv. 2250]",
							"Powerful Beast Pirate [Lv. 2450]",
							"Bandit Beast Pirate [Lv. 2400]"
						}, fetch)
					else
						if monsterPot["Beast Pirate [Lv. 2250]"]then
							tp({Target =  monsterPot["Beast Pirate [Lv. 2250]"] * CFrame.new(0, 30, 0)})
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Race Skys V2 Fully'] = function()
	local fetch = 'Auto Race Skys V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local QuestProgression = Zenfunc['getQuestProgression']('SkyV2')
			local seax2 = {
				['Sea1'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame,
				['Sea2'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame
			}
			if QuestProgression['value'] == 7 then
				if not Sea2 then
					getQuestOld(seax2['Sea2'])
				else
					getQuestOld(workspace.AllNPC["Sky Progression 2"].CFrame * CFrame.new(0, 0, 10))
					wait(1)
					getQuestOld(workspace.AllNPC["Sky Progression 2"].CFrame)
				end
			elseif QuestProgression['value'] == 6 then
				if not Sea2 then
					getQuestOld(seax2['Sea2'])
				else
					getQuestOld(workspace.AllNPC["Sky Progression 1"].CFrame)
				end
			elseif QuestProgression['value'] < 6 then
				if not Sea1 then
					getQuestOld(seax2['Sea1'])
				else 
					if not Client.Inventory:FindFirstChild("Pole") then
						if Zenfunc['Entity']['find']({"Ball Man [Lv. 850]", "Sky Soldier [Lv. 800]"}) then
							Zenfunc['Entity']['attack']({
								"Ball Man [Lv. 850]",
								"Sky Soldier [Lv. 800]"
							}, fetch)
						else
							if monsterPot["Ball Man [Lv. 850]"]then
								tp({Target =  monsterPot["Ball Man [Lv. 850]"] * CFrame.new(0, 30, 0)})
							end
						end
					else
						if not Client.Backpack:FindFirstChild('Pole') and not Client.Character:FindFirstChild('Pole') then
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Pole")
						end
						if Zenfunc['Entity']['find']({"Rumble Man [Lv. 950]"}) then
							Zenfunc['Entity']['attack']({
								"Rumble Man [Lv. 950]",
							}, fetch)
						else
							if monsterPot["Rumble Man [Lv. 950]"]then
								tp({Target =  monsterPot["Rumble Man [Lv. 950]"] * CFrame.new(0, 30, 0)})
							end
						end
					end
				end
			else
				if Zenfunc['getPlayerMaterial']("Angellic's Feather") < 350 then
					if Zenfunc['Entity']['find']({"Ball Man [Lv. 850]", "Sky Soldier [Lv. 800]"}) then
						Zenfunc['Entity']['attack']({
							"Ball Man [Lv. 850]",
							"Sky Soldier [Lv. 800]"
						}, fetch)
					else
						if monsterPot["Ball Man [Lv. 850]"]then
							tp({Target =  monsterPot["Ball Man [Lv. 850]"] * CFrame.new(0, 30, 0)})
						end
					end
				elseif Zenfunc['getPlayerMaterial']("Lost Ruby") < 3 then
					if Zenfunc['Entity']['find']({"Anubis [Lv. 3150]"}) then
						Zenfunc['Entity']['attack']({
							"Anubis [Lv. 3150]",
						}, fetch)
					else
						if monsterPot["Anubis [Lv. 3150]"]then
							tp({Target =  monsterPot["Anubis [Lv. 3150]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					getQuestOld(workspace.AllNPC["Sky Progression 1"].CFrame)
				end
			end
		end)
	end
end
Zenfunc['Auto Race Human V2'] = function()
	local fetch = 'Auto Race Human V2'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			local seax2 = {
				['Sea1'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame,
				['Sea2'] = workspace.AllNPC:FindFirstChild("Elite Pirate").CFrame
			}
			local QuestProgression = Zenfunc['getQuestProgression']('HumanV2')
			if QuestProgression['value'] == 1 then
				if Zenfunc['getPlayerMaterial']("Phoenix's Tear") > 0 then
					getQuestOld(workspace.AllNPC["Human Progression 2"].CFrame)
				else
					if Zenfunc['Entity']['find']({"Ms. Mother [Lv. 7500]"}) then
						Zenfunc['Entity']['attack']({
							"Ms. Mother [Lv. 7500]",
						}, fetch)
					end
				end
			else
				if Zenfunc['getPlayerMaterial']('Log') > 999 then
					getQuestOld(workspace.AllNPC["Human Progression 1"].CFrame)
				end
			end
		end)
	end
end

-- Puzzle Solver for SBPuzzle
-- Positions extracted from your output
local GRID_POSITIONS = {
    [1]  = Vector3.new(4635.29, 147.82, 11650.33),
    [2]  = Vector3.new(4614.29, 147.82, 11658.86),
    [3]  = Vector3.new(4593.29, 147.82, 11667.39),
    [4]  = Vector3.new(4572.94, 147.82, 11675.92),
    [5]  = Vector3.new(4635.29, 125.15, 11650.33),
    [6]  = Vector3.new(4614.29, 125.15, 11658.86),
    [7]  = Vector3.new(4593.29, 125.15, 11667.39),
    [8]  = Vector3.new(4572.94, 125.15, 11675.92),
    [9]  = Vector3.new(4635.29, 102.49, 11650.33),
    [10] = Vector3.new(4614.29, 102.49, 11658.86),
    [11] = Vector3.new(4593.29, 102.49, 11667.39),
    [12] = Vector3.new(4572.94, 102.49, 11675.92),
    [13] = Vector3.new(4635.29, 79.82,  11650.33),
    [14] = Vector3.new(4614.29, 79.82,  11658.86),
    [15] = Vector3.new(4593.29, 79.82,  11667.39),
    [16] = Vector3.new(4572.94, 79.82,  11675.92),
}

-- Find which grid position index a slot is currently at
local function getSlotGridIndex(slot)
    local pos = slot.Position
    local closest = nil
    local closestDist = math.huge
    for idx, gpos in pairs(GRID_POSITIONS) do
        local dist = (pos - gpos).Magnitude
        if dist < closestDist then
            closestDist = dist
            closest = idx
        end
    end
    return closest
end

-- Read current board state: returns table [gridIndex] = slotName
local function readBoard()
    local board = {}
    local emptySlot = nil
    for _, slot in pairs(workspace.Island.SBPuzzleFolder:GetChildren()) do
        if slot:IsA("BasePart") then
            local gridIdx = getSlotGridIndex(slot)
            local fp = slot:FindFirstChild("FakePlate")
            if fp then
                board[gridIdx] = slot.Name -- piece name in this grid position
            else
                board[gridIdx] = 0 -- empty
                emptySlot = slot.Name
            end
        end
    end
    return board, emptySlot
end

-- Goal state: piece "1" in grid pos 1, piece "2" in grid pos 2, etc
-- piece "16" is the empty slot
local function isGoalState(board)
    for i = 1, 15 do
        if tostring(board[i]) ~= tostring(i) then
            return false
        end
    end
    return true
end

-- Get neighbors (slots adjacent to empty in 4x4 grid)
local function getNeighbors(emptyIdx)
    local neighbors = {}
    local row = math.ceil(emptyIdx / 4)
    local col = ((emptyIdx - 1) % 4) + 1
    -- up
    if row > 1 then table.insert(neighbors, emptyIdx - 4) end
    -- down
    if row < 4 then table.insert(neighbors, emptyIdx + 4) end
    -- left
    if col > 1 then table.insert(neighbors, emptyIdx - 1) end
    -- right
    if col < 4 then table.insert(neighbors, emptyIdx + 1) end
    return neighbors
end

-- Manhattan distance heuristic
local function heuristic(board)
    local dist = 0
    for gridIdx, piece in pairs(board) do
        if piece ~= 0 then
            local pieceNum = tonumber(piece)
            if pieceNum and pieceNum ~= 16 then
                local goalRow = math.ceil(pieceNum / 4)
                local goalCol = ((pieceNum - 1) % 4) + 1
                local curRow = math.ceil(gridIdx / 4)
                local curCol = ((gridIdx - 1) % 4) + 1
                dist = dist + math.abs(goalRow - curRow) + math.abs(goalCol - curCol)
            end
        end
    end
    return dist
end

-- Serialize board to string for visited check
local function serializeBoard(board)
    local t = {}
    for i = 1, 16 do
        t[i] = tostring(board[i] or 0)
    end
    return table.concat(t, ",")
end

-- A* solver - returns list of grid indices to click
local function solvePuzzle(initialBoard)
    -- find empty position
    local emptyIdx = nil
    for i, v in pairs(initialBoard) do
        if v == 0 then emptyIdx = i break end
    end

    local openSet = {}
    local visited = {}

    local startNode = {
        board = initialBoard,
        emptyIdx = emptyIdx,
        moves = {},
        g = 0,
        h = heuristic(initialBoard)
    }
    table.insert(openSet, startNode)

    local iterations = 0
    while #openSet > 0 and iterations < 50000 do
        iterations = iterations + 1

        -- find lowest f = g + h
        local bestIdx = 1
        for i = 2, #openSet do
            if (openSet[i].g + openSet[i].h) < (openSet[bestIdx].g + openSet[bestIdx].h) then
                bestIdx = i
            end
        end

        local current = table.remove(openSet, bestIdx)
        local key = serializeBoard(current.board)

        if visited[key] then continue end
        visited[key] = true

        if isGoalState(current.board) then
            print("[Puzzle] Solved in", #current.moves, "moves!")
            return current.moves
        end

        -- expand neighbors
        for _, neighborIdx in pairs(getNeighbors(current.emptyIdx)) do
            local newBoard = {}
            for k, v in pairs(current.board) do newBoard[k] = v end
            -- swap empty with neighbor
            newBoard[current.emptyIdx] = newBoard[neighborIdx]
            newBoard[neighborIdx] = 0

            local newKey = serializeBoard(newBoard)
            if not visited[newKey] then
                local newMoves = {}
                for _, m in pairs(current.moves) do table.insert(newMoves, m) end
                table.insert(newMoves, neighborIdx) -- click this grid position

                table.insert(openSet, {
                    board = newBoard,
                    emptyIdx = neighborIdx,
                    moves = newMoves,
                    g = current.g + 1,
                    h = heuristic(newBoard)
                })
            end
        end
    end

    print("[Puzzle] Could not solve in time, iterations:", iterations)
    return nil
end

-- Get slot part by grid position
local function getSlotAtGridPos(targetIdx)
    for _, slot in pairs(workspace.Island.SBPuzzleFolder:GetChildren()) do
        if slot:IsA("BasePart") then
            local gridIdx = getSlotGridIndex(slot)
            if gridIdx == targetIdx then
                return slot
            end
        end
    end
    return nil
end

-- Main solve and execute function
local function executeSolve()
    print("[Puzzle] Reading board...")
    local board = readBoard()

    if isGoalState(board) then
        print("[Puzzle] Already solved!")
        return true
    end

    print("[Puzzle] Solving...")
    local moves = solvePuzzle(board)

    if not moves then
        print("[Puzzle] Failed to find solution!")
        return false
    end

    print("[Puzzle] Executing", #moves, "moves...")
    for i, gridIdx in pairs(moves) do
        local slot = getSlotAtGridPos(gridIdx)
        if slot then
            local cd = slot:FindFirstChild("ClickDetector")
            if cd then
                fireclickdetector(cd)
                print("[Puzzle] Move", i, "- Clicked slot at grid pos", gridIdx)
                task.wait(0.3) -- wait between clicks
            end
        end
        -- re-read board after each move since pieces move
    end

    task.wait(0.5)
    local finished = workspace.Island.SBPuzzlePart:FindFirstChild("Finished")
    if finished and finished.Value then
        print("[Puzzle] PUZZLE COMPLETE!")
        return true
    else
        print("[Puzzle] Moves done but not finished, retrying solve...")
        return executeSolve() -- recursive retry if needed
    end
end

-- Integration into your existing function
Zenfunc['Auto Race Sea King V1 Fully'] = function()
    local fetch = 'Auto Race Sea King V1 Fully'
    while Config[fetch] and task.wait() do
        Zenfunc['getPcall'](fetch, function()
            if InRaid then return end
            local QuestProgression = Zenfunc['getQuestProgression']('Sea Beast Puzzle')
            if QuestProgression['value'] == 3 then
                -- quest done
            elseif QuestProgression['value'] == 2 then
                getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, "Button1")
            elseif QuestProgression['value'] == 1 and 
                game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('Popup') and 
                game:GetService("Players").LocalPlayer.PlayerGui.Popup.Frame:FindFirstChild("SB Puzzle Quest Time") then

                tp({Target = CFrame.new(4585.78809, 67.5307617, 11632.6035, 
                    -0.981508315, -0.0295521915, -0.189124018, 
                    -0.00891497731, 0.993995786, -0.109053552, 
                    0.191211164, -0.105350919, -0.975878775)})
                task.wait(1)

                repeat
                    task.wait(0.5)
                    local finished = workspace.Island.SBPuzzlePart:FindFirstChild("Finished")
                    if finished and finished.Value then break end
                    executeSolve()
                until not Config[fetch] 
                    or not game:GetService("Players").LocalPlayer.PlayerGui.Popup.Frame:FindFirstChild("SB Puzzle Quest Time") 
                    or (workspace.Island.SBPuzzlePart.Finished.Value == true)

            else
                if Zenfunc['getPlayerMaterial']('Sea Artifact') < 100 then
                    if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
                        Zenfunc['Entity']['attack']({
                            "Fishman Guardian [Lv. 4150]",
                        }, fetch)
                    else
                        if monsterPot["Fishman Guardian [Lv. 4150]"] then
                            tp({Target = monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
                        end
                    end
                else
                    getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, "Button1")
                end
            end
        end)
    end
end

Zenfunc['Auto Race Sea King V2 Fully'] = function()
	local fetch = 'Auto Race Sea King V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if not Sea3 then return end
			local QuestProgression = Zenfunc['getQuestProgression']('Sea Beast V2')
			if not QuestProgression['value'] then 
				if Zenfunc['getPlayerMaterial']('Sea Artifact') < 50 then
					if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
						Zenfunc['Entity']['attack']({
							"Fishman Guardian [Lv. 4150]",
						}, fetch)
					else
						if monsterPot["Fishman Guardian [Lv. 4150]"]then
							tp({Target =  monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
				end
			elseif QuestProgression['value'] == 1 then 
				if Zenfunc['getPlayerMaterial']('Coral') < 25 then
					if Zenfunc['Entity']['find']({"Fugitive [Lv. 4050]"}) then
						Zenfunc['Entity']['attack']({
							"Fugitive [Lv. 4050]",
						}, fetch)
					else
						if monsterPot["Fugitive [Lv. 4050]"]then
							tp({Target =  monsterPot["Fugitive [Lv. 4050]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
				end
			elseif QuestProgression['value'] == 2 then 
				if Zenfunc['getPlayerMaterial']("Shark's Fin") < 10 then
					if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
						Zenfunc['Entity']['attack']({
							"Fishman Guardian [Lv. 4150]",
						}, fetch)
					else
						if monsterPot["Fishman Guardian [Lv. 4150]"]then
							tp({Target =  monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
				end
			elseif QuestProgression['value'] == 3 then 
				if Zenfunc['getPlayerMaterial']("Shark's Fin") < 10 then
					if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
						Zenfunc['Entity']['attack']({
							"Fishman Guardian [Lv. 4150]",
						}, fetch)
					else
						if monsterPot["Fishman Guardian [Lv. 4150]"]then
							tp({Target =  monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
				end
			elseif QuestProgression['value'] == 4 then
				if Zenfunc['getPlayerMaterial']("Aqua Gem") < 1 then
					if Zenfunc['getPlayerMaterial']('Sea Artifact') < 25 then
						if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
							Zenfunc['Entity']['attack']({
								"Fishman Guardian [Lv. 4150]",
							}, fetch)
						else
							if monsterPot["Fishman Guardian [Lv. 4150]"]then
								tp({Target =  monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getPlayerMaterial']('Coral') < 10 then
						if Zenfunc['Entity']['find']({"Fugitive [Lv. 4050]"}) then
							Zenfunc['Entity']['attack']({
								"Fugitive [Lv. 4050]",
							}, fetch)
						else
							if monsterPot["Fugitive [Lv. 4050]"]then
								tp({Target =  monsterPot["Fugitive [Lv. 4050]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getPlayerMaterial']("Shark's Fin") < 10 then
						if Zenfunc['Entity']['find']({"Fishman Guardian [Lv. 4150]"}) then
							Zenfunc['Entity']['attack']({
								"Fishman Guardian [Lv. 4150]",
							}, fetch)
						else
							if monsterPot["Fishman Guardian [Lv. 4150]"]then
								tp({Target =  monsterPot["Fishman Guardian [Lv. 4150]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getPlayerMaterial']("Pearl") < 1 then
						if Zenfunc['Entity']['find']({"Fugitive [Lv. 4050]"}) then
							Zenfunc['Entity']['attack']({
								"Fugitive [Lv. 4050]",
							}, fetch)
						else
							if monsterPot["Fugitive [Lv. 4050]"]then
								tp({Target =  monsterPot["Fugitive [Lv. 4050]"] * CFrame.new(0, 30, 0)})
							end
						end
					else
						getQuestOld(workspace.AllNPC.CraftAquaGem.CFrame)
						game:GetService("ReplicatedStorage").Chest.Remotes.Functions.CraftMaterial:InvokeServer("Aqua Gem") wait(1)
					end
				else
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
					getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
				end
			elseif QuestProgression['value'] == 5 then
				getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame, 'Button1')
				getQuestOld(workspace.AllNPC.SeaBeastRaceNPC.CFrame)
			elseif QuestProgression['value'] == 6 then
			end
		end)
	end
end
Zenfunc['Auto Muramasa V2'] = function()
	local fetch = 'Auto Muramasa V2'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if game:GetService("Players").LocalPlayer.PlayerStats.MuramasaAwake.Value <= 0 then return end
			if game:GetService("Players").LocalPlayer.PlayerStats.MuramasaAwake.Value < 10 then
				if not Sea2 then
					getQuestOld(FF['Teleport To Sea 2'], 2)
				else
					if Zenfunc['Entity']['find']({"SeaKing"}) then
						Zenfunc['Entity']['attack']({
							"SeaKing",
						}, fetch)
					else
						if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
							if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch, 50)
							else
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch)
							end
						else
							if Config['Auto Muramasa V2 Fully'] then
								seaChest(true)
							end
						end
					end
				end
			else
				if workspace.AllNPC:FindFirstChild('Surgit') then
					getQuestOld(workspace.AllNPC.Surgit.CFrame)
				else
					if Config['Auto Muramasa V2 Fully'] then
						HopServer(true)
						delay(15, function()
							HopServer()
						end)
					end
				end
			end
		end)
	end
end
Zenfunc['questChicking'] = function(b, v)
	if string.upper(b) == 'ARENULL' then
		return Client.CurrentQuest.Value == ""
	elseif string.upper(b) == 'HAVE' then
		return Client.CurrentQuest.Value ~= ""
	elseif v and string.upper(b) == "DAILY" then
		if Client.PlayerGui.MainGui.QuestFrame.QuestBoard.TextFrame.Frame.BattlepassExp.Visible == false then
			return false
		end
		if not Client.PlayerGui.MainGui.QuestFrame.QuestBoard.TextFrame.QuestName.Text:find(v) then
			return false
		end
		return true
	end
end
Zenfunc['CheckDailyQuest'] = function(Value)
	local HttpService = game:GetService("HttpService")
	for gatDailyQuest, _tick in pairs(HttpService:JSONDecode(game:GetService("Players").LocalPlayer.PlayerStats.DailyQuest.Value)) do
		if gatDailyQuest == Value  then
			if _G.Debug then
				warn('[DEBUG]', 'Check Daily Quest : ', tick() - tonumber(_tick))
			end
			if tick() - tonumber(_tick) > 0 then
				return true
			end
		end
	end
	return false
end
local tweenService = game:GetService("TweenService")
local info = TweenInfo.new()
tweenModel = function(model, CF)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()
	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)
	local tween = tweenService:Create(CFrameValue, info, {Value = CF})
	tween:Play()
	tween.Completed:Connect(function()
		CFrameValue:Destroy()
	end)
end
Zenfunc['Auto Daily Quest'] = function()
	local fetch = 'Auto Daily Quest'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Config['Select Daily Quest'] == 'Forget and Forgot' and not Zenfunc['CheckDailyQuest']('Forget and Forgot') then
				if not Zenfunc['questChicking']('Daily', "Find out Where's 'Old Man'") then
					GuiService.SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame:FindFirstChild('QuestBoard') and game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame.QuestBoard.Close
					VirtualInputManager:SendKeyEvent(true, "Return", false, game)
					VirtualInputManager:SendKeyEvent(false, "Return", false, game)
				end
				if Zenfunc['questChicking']('areNull') then
					if not Zenfunc['questChicking']('areNull') then
						return
					end
					getQuestOld(workspace.AllNPC["Lore Venturer"].CFrame) wait(.2)
					Client.Character.Humanoid.Health = 0
				else
					getQuestOld(workspace.AllNPC["Civilian Old"].CFrame)
				end
			elseif Config['Select Daily Quest'] == 'Venture Lagoons!' and not Zenfunc['CheckDailyQuest']('Venture Lagoons!') then
				if not Zenfunc['questChicking']('Daily', "Sea Explored") then
					GuiService.SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame:FindFirstChild('QuestBoard') and game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame.QuestBoard.Close
					VirtualInputManager:SendKeyEvent(true, "Return", false, game)
					VirtualInputManager:SendKeyEvent(false, "Return", false, game)
				end
				if Zenfunc['questChicking']('areNull') then
					if not Zenfunc['questChicking']('areNull') then
						return
					end
					getQuestOld(workspace.AllNPC["Lore Venturer"].CFrame) wait(.2)
					Client.Character.Humanoid.Health = 0
				else
					if workspace.Ships:FindFirstChild(Client.Name ..' Ship') then
						if Client.Character.Humanoid.Sit == false then
							tp({ Target = workspace.Ships:WaitForChild(Client.Name ..' Ship'):FindFirstChild('VehicleSeat').CFrame})
						else
							if workspace.SpawnItem:FindFirstChild('Venture Lagoons!') then
								for i,v in pairs(workspace.SpawnItem:GetChildren()) do
									if v.Name == "Venture Lagoons!" then
										tweenModel(workspace.Ships:FindFirstChild(Client.Name ..' Ship'), v.CFrame)
										wait(.2)
									end
								end
							end
						end
					else
						if workspace.Ships:FindFirstChild(Client.Name ..' Ship') then return end
						local args = {
							[1] = "Rowboat",
							[2] = "ShipA"
						}
						game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("Ship"):FireServer(unpack(args))
						wait(1)
					end
				end
			elseif Config['Select Daily Quest'] == 'Kill 4 King Snow' and not Zenfunc['CheckDailyQuest']('Kill 4 King Snow') then
				if not Zenfunc['questChicking']('Daily', "King Snow") then
					GuiService.SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame:FindFirstChild('QuestBoard') and game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame.QuestBoard.Close
					VirtualInputManager:SendKeyEvent(true, "Return", false, game)
					VirtualInputManager:SendKeyEvent(false, "Return", false, game)
				end
				if Zenfunc['questChicking']('areNull') then
					if not Zenfunc['questChicking']('areNull') then
						return
					end
					getQuestOld(workspace.AllNPC["Daily QuestLvl500"].CFrame)
					Client.Character.Humanoid.Health = 0
				else
					if Zenfunc['Entity']['find']({"King Snow [Lv. 450]"}) then
						Zenfunc['Entity']['attack']({
							"King Snow [Lv. 450]",
						}, fetch)
					else
						if monsterPot["King Snow [Lv. 450]"]then
							tp({Target =  monsterPot["King Snow [Lv. 450]"] * CFrame.new(0, 30, 0)})
						end
					end
				end
			elseif Config['Select Daily Quest'] == 'Kill 10 Soldier Fishman' and not Zenfunc['CheckDailyQuest']('Kill 10 Soldier Fishman') then
				if not Zenfunc['questChicking']('Daily', "Soldier Fishman") then
					GuiService.SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame:FindFirstChild('QuestBoard') and game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame.QuestBoard.Close
					VirtualInputManager:SendKeyEvent(true, "Return", false, game)
					VirtualInputManager:SendKeyEvent(false, "Return", false, game)
				end
				if Zenfunc['questChicking']('areNull') then
					if not Zenfunc['questChicking']('areNull') then
						return
					end
					getQuestOld(workspace.AllNPC["Daily QuestLvl2000"].CFrame)
					Client.Character.Humanoid.Health = 0
				else
					if Zenfunc['Entity']['find']({"Soldier Fishman [Lv. 2150]"}) then
						Zenfunc['Entity']['attack']({
							"Soldier Fishman [Lv. 2150]",
						}, fetch)
					else
						if monsterPot["Soldier Fishman [Lv. 2150]"]then
							tp({Target =  monsterPot["Soldier Fishman [Lv. 2150]"] * CFrame.new(0, 30, 0)})
						end
					end
				end
			elseif Config['Select Daily Quest'] == 'Find Chicken Quest' and not Zenfunc['CheckDailyQuest']('Find Chicken Quest') then
				if not Zenfunc['questChicking']('Daily', "Fry Chicken") then
					GuiService.SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame:FindFirstChild('QuestBoard') and game:GetService("Players").LocalPlayer.PlayerGui.MainGui.QuestFrame.QuestBoard.Close
					VirtualInputManager:SendKeyEvent(true, "Return", false, game)
					VirtualInputManager:SendKeyEvent(false, "Return", false, game)
				end
				if Zenfunc['questChicking']('areNull') then
					if not Zenfunc['questChicking']('areNull') then
						return
					end
					getQuestOld(workspace.AllNPC["Daily QuestLvl2000"].CFrame)
					Client.Character.Humanoid.Health = 0
				else
					for i,v in pairs(workspace.SpawnItem:GetDescendants()) do
						if v.Name == 'Fry Chicken' then
							fireclickdetector(v.ClickDetector, math.huge)
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Farm Candy'] = function()
	local fetch = 'Auto Farm Candy'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Sea3 then
				if Zenfunc['Entity']['find']({"Wilderness Gorilla [Lv. 4325]"}) then
					Zenfunc['Entity']['attack']({
						"Wilderness Gorilla [Lv. 4325]",
					}, fetch)
				else
					tp({ Target = CFrame.new(4861, 48.5, 10181.4) })
				end
			elseif Sea2 then
				if Zenfunc['Entity']['find']({"Skull Pirate [Lv. 3050]"}) then
					Zenfunc['Entity']['attack']({
						"Skull Pirate [Lv. 3050]",
					}, fetch)
				else
					tp({ Target = CFrame.new(-6263.1, 88, 6904.4) })
				end
			elseif Sea1 then
				if Zenfunc['Entity']['find']({"Zombie [Lv. 1500]"}) then
					Zenfunc['Entity']['attack']({
						"Elite Zombie [Lv. 1550]",
					}, fetch)
				else
					tp({ Target = CFrame.new(-2751, 23.3, 4111.2) })
				end
			end
		end)
	end
end
Zenfunc['checkAwakeClient'] = function(v)
	if HttpService:JSONDecode(game:GetService("Players").LocalPlayer.PlayerStats.Misc.Value)[v] then
		return true
	end
	return false
end
Zenfunc['Auto Buso V2 Fully'] = function()
	local fetch = 'Auto Buso V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['checkAwakeClient']('Pung Proof') and Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Pung Diamond') then
				if not Zenfunc['checkAwakeClient']('Armament') then
					if Client.CurrentQuest.Value ~= "Back to Lee" then
						Tween(workspace.AllNPC.Pung.CFrame)
						getQuestOld(workspace.AllNPC.Pung.CFrame)
					else
						Tween(workspace.AllNPC.Lee.CFrame)
						getQuestOld(workspace.AllNPC.Lee.CFrame)
					end
				end
			elseif Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Find Pung') and not Zenfunc['checkAwakeClient']('Pung Diamond') then
				if Client.CurrentQuest.Value ~= "Back to Lee" then
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				else
					Tween(workspace.AllNPC.Lee.CFrame)
					getQuestOld(workspace.AllNPC.Lee.CFrame)
				end
			elseif not Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Find Pung') then
				if Client.CurrentQuest.Value ~= "Find Pung" then
					if Zenfunc['Entity']['find']({"Dark Beard [Lv. 3475]"}) then
						Zenfunc['Entity']['attack']({
							"Dark Beard [Lv. 3475]",
						}, fetch)
					else
						if Zenfunc['getPlayerMaterial']("Dark Beard's Totem") > 0 then
							local args = {
								[1] = "QuestSpawnBoss",
								[2] = {
									["SuccessQuest"] = "Quest Accepted.",
									["BossName"] = "Dark Beard [Lv. 3475]",
									["LevelNeed"] =  3475,
									["QuestName"] = "",
									["MaterialNeed"] = "Dark Beard's Totem",
								}
							}
							game.ReplicatedStorage:WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(args))
						else
							if Zenfunc['Entity']['find']({"Sally [Lv. 3450]"}) then
								Zenfunc['Entity']['attack']({
									"Sally [Lv. 3450]",
								}, fetch, nil, {
									Monster = {
										"Dark Beard [Lv. 3475]"
									},get = "have"
								})
							else
								if monsterPot["Sally [Lv. 3450]"]then
									tp({Target =  monsterPot["Sally [Lv. 3450]"] * CFrame.new(0, 30, 0)})
								end
							end
						end
					end
				else
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				end
			else
				if Client.CurrentQuest.Value ~= "Find Pung" then
					Tween(workspace.AllNPC.Lee.CFrame)
					getQuestOld(workspace.AllNPC.Lee.CFrame)
				else
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				end
			end
		end)
	end
end
Zenfunc['Auto Ken V2 Fully'] = function()
	local fetch = 'Auto Ken V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Zenfunc['checkAwakeClient']('Observation') then
			elseif Zenfunc['Entity']['find']({"LeePung [Lv. 5000]"}) then
				Zenfunc['Entity']['attack']({
					"LeePung [Lv. 5000]",
				}, fetch)
			else
				Tween(workspace.AllNPC["Stranger Uncle"].CFrame)
				getQuestOld(workspace.AllNPC["Stranger Uncle"].CFrame)
			end
		end)
	end
end
Zenfunc['Auto Combat Electro V2 Fully'] = function()
	local fetch = 'Auto Combat Electro V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.PlayerStats.lvl.Value < 3000 then return end
			if Zenfunc['getQuestProgression']('MinkV2')['value'] ~= 11 then 
				local QuestProgression = Zenfunc['getQuestProgression']('MinkV2')
				if QuestProgression['value'] == 11 then
				elseif QuestProgression['value'] == 10 then
					getQuestOld(workspace.AllNPC["Mink Progression 11"].CFrame) wait(1)
				elseif QuestProgression['value'] == 9 then
					getQuestOld(workspace.AllNPC["Mink Progression 10"].CFrame) wait(1)
				elseif QuestProgression['value'] == 8 then
					getQuestOld(workspace.AllNPC["Mink Progression 9"].CFrame) wait(1)
				elseif QuestProgression['value'] == 7 then
					getQuestOld(workspace.AllNPC["Mink Progression 8"].CFrame) wait(1)
				elseif QuestProgression['value'] == 6 then
					getQuestOld(workspace.AllNPC["Mink Progression 7"].CFrame) wait(1)
				elseif QuestProgression['value'] == 5 then
					getQuestOld(workspace.AllNPC["Mink Progression 6"].CFrame) wait(1)
				elseif QuestProgression['value'] == 4 then
					getQuestOld(workspace.AllNPC["Mink Progression 5"].CFrame) wait(1)
				elseif QuestProgression['value'] == 3 then
					getQuestOld(workspace.AllNPC["Mink Progression 4"].CFrame) wait(1)
				elseif QuestProgression['value'] == 2 then
					getQuestOld(workspace.AllNPC["Mink Progression 3"].CFrame) wait(1)
				elseif QuestProgression['value'] == 1 then
					getQuestOld(workspace.AllNPC["Mink Progression 2"].CFrame) wait(1)
				else
					if not Sea2 then getQuestOld(FF['Teleport To Sea 2'], 2) return end
					if Zenfunc['getPlayerMaterial']('Carrot') > 8199 then
						getQuestOld(workspace.AllNPC["Mink Progression 1"].CFrame)
					else
						if Zenfunc['Entity']['find']({"Beast Pirate [Lv. 2250]", "Powerful Beast Pirate [Lv. 2450]", "Bandit Beast Pirate [Lv. 2400]"}) then
							Zenfunc['Entity']['attack']({
								"Beast Pirate [Lv. 2250]",
								"Powerful Beast Pirate [Lv. 2450]",
								"Bandit Beast Pirate [Lv. 2400]"
							}, fetch)
						else
							if monsterPot["Beast Pirate [Lv. 2250]"]then
								tp({Target =  monsterPot["Beast Pirate [Lv. 2250]"] * CFrame.new(0, 30, 0)})
							end
						end
					end
				end 
			elseif not Client.Backpack:FindFirstChild('Electro') and not Client.Character:FindFirstChild('Electro') then
				getQuestOld(workspace.AllNPC.ElectroShop.CFrame)
			else
				if not Zenfunc['getQuestProgression']('ElectroV2')['value'] and Zenfunc['getPlayerMaterial']("Carrot") >= 300 then
					getQuestOld(workspace.AllNPC["Electro Progression 1"].CFrame)
				elseif not Zenfunc['getQuestProgression']('ElectroV2')['value'] and Zenfunc['getPlayerMaterial']("CarrotCarrot") < 300 then
					if Zenfunc['Entity']['find']({"Beast Pirate [Lv. 2250]", "Powerful Beast Pirate [Lv. 2450]", "Bandit Beast Pirate [Lv. 2400]"}) then
						Zenfunc['Entity']['attack']({
							"Beast Pirate [Lv. 2250]",
							"Powerful Beast Pirate [Lv. 2450]",
							"Bandit Beast Pirate [Lv. 2400]"
						}, fetch)
					else
						if monsterPot["Beast Pirate [Lv. 2250]"]then
							tp({Target =  monsterPot["Beast Pirate [Lv. 2250]"] * CFrame.new(0, 30, 0)})
						end
					end
				else
					if Zenfunc['getQuestProgression']('ElectroV2')['value'] == 1 then
						if Zenfunc['Entity']['find']({"Duke [Lv. 2550]"}) then
							Zenfunc['Entity']['attack']({
								"Duke [Lv. 2550]"
							}, fetch)
						else
							if monsterPot["Duke [Lv. 2550]"]then
								tp({Target =  monsterPot["Duke [Lv. 2550]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] == 2 then
						if Zenfunc['Entity']['find']({"Bean [Lv. 2800]"}) then
							Zenfunc['Entity']['attack']({
								"Bean [Lv. 2800]"
							}, fetch)
						else
							if monsterPot["Bean [Lv. 2800]"]then
								tp({Target =  monsterPot["Bean [Lv. 2800]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] == 3 then
						if Zenfunc['Entity']['find']({"Meji [Lv. 2850]"}) then
							Zenfunc['Entity']['attack']({
								"Meji [Lv. 2850]"
							}, fetch)
						else
							if monsterPot["Meji [Lv. 2850]"]then
								tp({Target =  monsterPot["Meji [Lv. 2850]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] == 4 then
						if Zenfunc['Entity']['find']({"Petra [Lv. 2900]"}) then
							Zenfunc['Entity']['attack']({
								"Petra [Lv. 2900]"
							}, fetch)
						else
							if monsterPot["Petra [Lv. 2900]"]then
								tp({Target =  monsterPot["Petra [Lv. 2900]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] == 5 then
						if Zenfunc['Entity']['find']({"Joey [Lv. 3000]"}) then
							Zenfunc['Entity']['attack']({
								"Joey [Lv. 3000]"
							}, fetch)
						else
							if monsterPot["Joey [Lv. 3000]"]then
								tp({Target =  monsterPot["Joey [Lv. 3000]"] * CFrame.new(0, 30, 0)})
							end
						end
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] >= 12 then
						getQuestOld(workspace.AllNPC["Electro Progression 2"].CFrame)
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] >= 11 then
						getQuestOld(workspace.AllNPC["Electro Progression 1"].CFrame)
					elseif Zenfunc['getQuestProgression']('ElectroV2')['value'] > 5 then
						if Zenfunc['Entity']['find']({"Dragon [Lv. 5000]"}) then
							Zenfunc['Entity']['attack']({
								"Dragon [Lv. 5000]",
							}, fetch)
						else
							if Zenfunc['getPlayerMaterial']("Dragon's Orb") > 0 then
								getQuestOld(workspace.AllNPC:FindFirstChild("SummonDragon").CFrame)
							else
								if Zenfunc['Entity']['find']({"Elite Skeleton [Lv. 3100]"}) then
									Zenfunc['Entity']['attack']({
										"Elite Skeleton [Lv. 3100]",
									}, fetch, nil, {
										Monster = {
											"Dragon [Lv. 5000]"
										},get = "have"
									})
								else
									tp({Target = CFrame.new(-5996.76953125, 462.4600524902344, 7296.43115234375) * CFrame.new(0, -50, 0)})
								end
							end
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Combat DarkLeg V2 Fully'] = function()
	local fetch = 'Auto Combat DarkLeg V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc[' '](fetch, function()
			if InRaid then return end
			if Client.PlayerStats.lvl.Value < 3600 then return end
			if Zenfunc['checkAwakeClient']('Pung Proof') and Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Pung Diamond') then
				if Zenfunc['checkAwakeClient']('Armament') then
					if Zenfunc['checkAwakeClient']('Observation') then
						getQuestOld(workspace.AllNPC["Master Of Dark Leg"].CFrame)
					elseif Zenfunc['Entity']['find']({"LeePung [Lv. 5000]"}) then
						Zenfunc['Entity']['attack']({
							"LeePung [Lv. 5000]",
						}, fetch)
					else
						Tween(workspace.AllNPC["Stranger Uncle"].CFrame)
						getQuestOld(workspace.AllNPC["Stranger Uncle"].CFrame)
					end
				else
					if Client.CurrentQuest.Value ~= "Back to Lee" then
						Tween(workspace.AllNPC.Pung.CFrame)
						getQuestOld(workspace.AllNPC.Pung.CFrame)
					else
						Tween(workspace.AllNPC.Lee.CFrame)
						getQuestOld(workspace.AllNPC.Lee.CFrame)
					end
				end
			elseif Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Find Pung') and not Zenfunc['checkAwakeClient']('Pung Diamond') then
				if Client.CurrentQuest.Value ~= "Back to Lee" then
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				else
					Tween(workspace.AllNPC.Lee.CFrame)
					getQuestOld(workspace.AllNPC.Lee.CFrame)
				end
			elseif not Zenfunc['checkAwakeClient']('Pung Happy') and Zenfunc['checkAwakeClient']('Find Pung') then
				if Client.CurrentQuest.Value ~= "Find Pung" then
					if Zenfunc['Entity']['find']({"Dark Beard [Lv. 3475]"}) then
						Zenfunc['Entity']['attack']({
							"Dark Beard [Lv. 3475]",
						}, fetch)
					else
						if Zenfunc['getPlayerMaterial']("Dark Beard's Totem") > 0 then
							local args = {
								[1] = "QuestSpawnBoss",
								[2] = {
									["SuccessQuest"] = "Quest Accepted.",
									["BossName"] = "Dark Beard [Lv. 3475]",
									["LevelNeed"] =  3475,
									["QuestName"] = "",
									["MaterialNeed"] = "Dark Beard's Totem",
								}
							}
							game.ReplicatedStorage:WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer(unpack(args))
						else
							if Zenfunc['Entity']['find']({"Sally [Lv. 3450]"}) then
								Zenfunc['Entity']['attack']({
									"Sally [Lv. 3450]",
								}, fetch, nil, {
									Monster = {
										"Dark Beard [Lv. 3475]"
									},get = "have"
								})
							else
								if monsterPot["Sally [Lv. 3450]"]then
									tp({Target =  monsterPot["Sally [Lv. 3450]"] * CFrame.new(0, 30, 0)})
								end
							end
						end
					end
				else
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				end
			else
				if Client.CurrentQuest.Value ~= "Find Pung" then
					Tween(workspace.AllNPC.Lee.CFrame)
					getQuestOld(workspace.AllNPC.Lee.CFrame)
				else
					Tween(workspace.AllNPC.Pung.CFrame)
					getQuestOld(workspace.AllNPC.Pung.CFrame)
				end
			end
		end)
	end
end
Zenfunc['Auto Combat DragonClaw V2 Fully'] = function()
	local fetch = 'Auto Combat DragonClaw V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.PlayerStats.lvl.Value < 3600 then return end
		end)
	end
end
local Fuck = nil
Zenfunc['Auto Combat WaterStyle V2 Fully'] = function()
	local fetch = 'Auto Combat WaterStyle V2 Fully'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if InRaid then return end
			if Client.PlayerStats.lvl.Value < 3600 then return end
			if game:GetService("Players").LocalPlayer.Character:GetAttribute('Race') ~= "Fish" or not Zenfunc['getQuestProgression']('FishV2')['value'] then
				getText('Changed Ur Race To Fish')
				return
			end
			if Zenfunc['getQuestProgression']('WaterStyleV2')['value'] then
				if Zenfunc['getQuestProgression']('WaterStyleV2')['value'] < 3 then
					if not Fuck then
						Fuck = true
						Config["Select Difficulty"] = "Hard"
						Config["Auto Clear Dungeon"] = true
						Config['Auto Rejoin Dungeon'] = true
						Config['Auto Rejoin Dungeon Full Mode'] = true
						Zenfunc['Auto Clear Dungeon']()
					end
				else
					if Zenfunc['getQuestProgression']('WaterStyleV2')['value'] == 3 then
						getQuestOld(workspace.AllNPC.Karamba.CFrame)
					end
				end
			elseif Zenfunc['getPlayerMaterial']("Hydra's Tail") >= 2 and Zenfunc['getPlayerMaterial']("Fresh Fish") >= 1500 then
				getQuestOld(workspace.AllNPC.Salmorn.CFrame)
			else
				if Zenfunc['getPlayerMaterial']("Hydra's Tail") < 2 and Sea2 then 
					if Zenfunc['Entity']['find']({"SeaKing"}) then
						Zenfunc['Entity']['attack']({
							"SeaKing",
						}, fetch)
					else
						if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
							if workspace.SeaMonster.HydraSeaKing:GetAttribute('CustomName') == "Hydra" then
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch, 50)
							else
								Zenfunc['Entity']['attack']({
									"HydraSeaKing",
								}, fetch)
							end
						else
							seaChest(true)
						end
					end
				else
					if Zenfunc['getPlayerMaterial']("Hydra's Tail") < 2 and not Sea2 then
						getQuestOld(FF['Teleport To Sea 2'], 2)
					end
				end
				if Zenfunc['getPlayerMaterial']("Fresh Fish") < 100 and Sea1 then 
					if  Zenfunc['Entity']['find']({"Karate Fishman [Lv. 200]","Fighter Fishman [Lv. 180]","Shark Man [Lv. 230]"}) then
						Zenfunc['Entity']['attack']({
							"Karate Fishman [Lv. 200]",
							"Fighter Fishman [Lv. 180]",
							"Shark Man [Lv. 230]",
						}, fetch)
					else
						tp({Target = workspace.Island["D - Shark Island"].D.Base:GetChildren()[57].CFrame * CFrame.new(0 ,50, 0)})
					end
				else
					if Zenfunc['getPlayerMaterial']("Fresh Fish") < 100 and not Sea1 then
						local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "FirstSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
					end
				end
			end
		end)
	end
end
Zenfunc['Start Material Farm Sea1'] = function()
	local fetch = 'Start Material Farm Sea1'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Sea1 then
				local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "FirstSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
			else
				if Zenfunc['Entity']['find'](AllMaterial['Sea1'][Config['Select Material Sea1']]) then
					Zenfunc['Entity']['attack'](AllMaterial['Sea1'][Config['Select Material Sea1']], fetch)
				else
					if monsterPot[AllMaterial['Sea1'][Config['Select Material Sea1']][1]] then
						tp({Target =  monsterPot[AllMaterial['Sea1'][Config['Select Material Sea1']][1]] * CFrame.new(0, 30, 0)})
					end
				end
			end
		end)
	end
end
Zenfunc['Start Material Farm Sea2'] = function()
	local fetch = 'Start Material Farm Sea2'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Sea2 then
				getQuestOld(FF['Teleport To Sea 2'], 2)
			else
				if Zenfunc['Entity']['find'](AllMaterial['Sea2'][Config['Select Material Sea2']]) then
					Zenfunc['Entity']['attack'](AllMaterial['Sea2'][Config['Select Material Sea2']], fetch)
				else
					if monsterPot[AllMaterial['Sea2'][Config['Select Material Sea2']][1]] then
						tp({Target =  monsterPot[AllMaterial['Sea2'][Config['Select Material Sea2']][1]] * CFrame.new(0, 30, 0)})
					end
				end
			end
		end)
	end
end
Zenfunc['Start Material Farm Sea3'] = function()
	local fetch = 'Start Material Farm Sea3'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Sea3 then
				local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "ThirdSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
			else
				if Zenfunc['Entity']['find'](AllMaterial['Sea3'][Config['Select Material Sea3']]) then
					Zenfunc['Entity']['attack'](AllMaterial['Sea3'][Config['Select Material Sea3']], fetch)
				else
					if monsterPot[AllMaterial['Sea3'][Config['Select Material Sea3']][1]] then
						tp({Target =  monsterPot[AllMaterial['Sea3'][Config['Select Material Sea3']][1]] * CFrame.new(0, 30, 0)})
					end
				end
			end
		end)
	end
end
Zenfunc['CDK'] = function(v)
	local args = {
		[1] = "AddQuestProgress",
		[2] = {
			["QuestChapter"] = v,
			["QuestProgressName"] = "Bloodmoon Twins Quest"
		} 
	}
	game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction:InvokeServer(unpack(args))
end
Zenfunc['Auto New Clear Dungeon'] = function()
	local fetch = 'Auto New Clear Dungeon'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if Client.PlayerGui:FindFirstChild('DungeonUI') then
				for i,v in pairs(workspace.MOB:GetChildren()) do
					if v and v.Parent and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						repeat
							local healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
							if healthPercentage > 45 then
								game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
								local brig = function() Attack() end
								lp[#lp+1] = task.spawn(pcall, brig)
								getgenv().PosMonSkill = v.HumanoidRootPart.CFrame
								tp({
									Target = v.HumanoidRootPart.CFrame * Config['standmethod'],
								})
								local run = function()
									useSkill()
								end
								lp[#lp+1] = task.spawn(pcall, run)
							else
								local dr = workspace.Island:FindFirstChild("(Real) Hard Dungeon") or workspace.Island:FindFirstChild("(Fake) Normal Dungeon") or workspace.Island:FindFirstChild("(Fake) Easy Dungeon")
								repeat
									local originalText = game:GetService("Players").LocalPlayer.PlayerGui.DungeonUI.DungeonFrame.Frame.FloorsFrame.TextLabel.Text
									local currentFloor = string.match(originalText, "^%d+")
									game:GetService("Players").LocalPlayer.PlayerGui.DungeonUI.DungeonFrame.Frame.FloorsFrame.TextLabel.Text = currentFloor
									healthPercentage = (Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth) * 100
									tp({ Target = dr:WaitForChild('Floor'..currentFloor).CFrame * CFrame.new(-100, -70 ,0), })
									if not Client.Character:FindFirstChild('Cyborg') then
										EquipTools('Cyborg')
									end
									if Client.Character:FindFirstChild('Cyborg') and not Item.CheckOnCooldown("E") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "E", false, game)
									end
									if Client.Character:FindFirstChild('Cyborg') and Item.CheckOnCooldown("E") then
										game:service('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
									end
									task.wait()
								until not Config[fetch] or (Item.CheckOnCooldown("E") and healthPercentage > 60)
							end
							task.wait()
						until not Config[fetch] or not v or not v.Parent or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 
						if #lp >= 1 then
							for i,v in pairs(lp) do
								pcall(task.cancel, v)
							end
							table.clear(lp)
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Rejoin New Dungeon'] = function()
	local fetch = 'Auto Rejoin New Dungeon'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not workspace.Dungeon.BillboardGui.Time.Text:find('Dungeon will end') then
				tp({Target = CFrame.new(10961.427734375, 130.90005493164062, 1250.9140625) })
			end
		end)
	end
end
getgc = getgc or function() end
Zenfunc['Auto Bloodmoon Twins'] = function()
	local fetch = 'Auto Bloodmoon Twins'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()

			-- ── Requirements check (always update) ─────────────────────────
			local hasHellSword    = Client.Inventory:FindFirstChild("Hell Sword") ~= nil
			local hasEthereal     = Client.Inventory:FindFirstChild("Ethereal")   ~= nil
			local hasBloodmoon    = Client.Inventory:FindFirstChild("Bloodmoon Twins") ~= nil
			local questVal        = Zenfunc['getQuestProgression']('Bloodmoon Twins Quest')['value'] or 0
			local monkeyVal       = Zenfunc['getQuestProgression']('Bloodmoon Monkey')['value'] or 0

			local reqLines = {}
			reqLines[#reqLines+1] = (hasHellSword and "Already Have" or "Not Have") .. " Hell Sword"
			reqLines[#reqLines+1] = (hasEthereal   and "Already Have" or "Not Have") .. " Ethereal"
			reqLines[#reqLines+1] = "Quest Step: " .. tostring(questVal)
			if questVal == 5 then
				reqLines[#reqLines+1] = "Monkey Progress: " .. tostring(monkeyVal) .. "/100"
			end
			_G.BloodmoonReqs = table.concat(reqLines, "  |  ")

			-- ── Already done ────────────────────────────────────────────────
			if hasBloodmoon then
				_G.BloodmoonStatus = "Bloodmoon Twins already owned!"
				return
			end

			-- ── Step: need Hell Sword ────────────────────────────────────────
			if not hasHellSword then
				if not Sea2 then
					_G.BloodmoonStatus = "Traveling to Sea 2 to get Hell Sword…"
					getQuestOld(FF['Teleport To Sea 2'], 2)
					return
				end
				if Zenfunc['Entity']['find']({"King Samurai [Lv. 3500]"}) then
					_G.BloodmoonStatus = "Farming King Samurai [Lv.3500] for Hell Sword…"
					Zenfunc['Entity']['attack']({
						"King Samurai [Lv. 3500]",
					}, fetch)
				else
					_G.BloodmoonStatus = "🔍 King Samurai not found – hopping server…"
					HopServer(true)
					delay(15, function()
						HopServer()
					end)
				end
				return
			end

			-- ── Step: need Ethereal ──────────────────────────────────────────
			if not hasEthereal then
				if not Sea3 then
					_G.BloodmoonStatus = "Traveling to Sea 3 to get Ethereal…"
					local A_1 = "TeleportSea"
local A_2 =
{
	["SeaName"] = "ThirdSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
					return
				end
				if Zenfunc['Entity']['find']({"Bushido Ape [Lv. 5000]"}) then
					_G.BloodmoonStatus = "Farming Bushido Ape [Lv.5000] for Ethereal…"
					Zenfunc['Entity']['attack']({
						"Bushido Ape [Lv. 5000]",
					}, fetch)
				else
					local imageUrl = game:GetService("Lighting").Sky.MoonTextureId
					local assetId = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
					if assetId ~= "5250084176" then
						_G.BloodmoonStatus = "Wrong moon – hopping for Bloodmoon…"
						HopServer(true)
						delay(15, function()
							HopServer()
						end)
					else
						_G.BloodmoonStatus = "Bloodmoon active – waiting for Bushido Ape to spawn…"
						if assetId == "5250084176" and not ( game:GetService("Lighting").ClockTime >= 6 and game:GetService("Lighting").ClockTime <= 18 ) then
							delay(60*3, function()
								if not Zenfunc['Entity']['find']({"Bushido Ape [Lv. 5000]"}) then
									HopServer(true)
									delay(15, function()
										HopServer()
									end)
								end
							end)
						end
					end
				end
				return
			end

			-- ── Main quest flow ──────────────────────────────────────────────
			if getgc then
				for i, v, next in getgc() do
					if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.PlayerGui.MainGui.Dialogue.DialogueModule then
						if debug.getinfo(v).name == "CloseChat" then
							CloseChat = v
						end
					end
				end
			end

			if questVal == 1 then
				_G.BloodmoonStatus = "Step 1 – Entering Bloodmoon Crater (CDK 2)…"
				Zenfunc['CDK'](2)
			elseif questVal == 2 then
				_G.BloodmoonStatus = "Step 2 – Confirming Bloodmoon quest (CDK 3)…"
				Zenfunc['CDK'](3)
			elseif questVal == 3 and not Client.PlayerGui.Popup.Frame:FindFirstChild('Torch Quest Time') then
				_G.BloodmoonStatus = "Step 3 – Accepting torch quest from BTQuest2 NPC…"
				getQuestOld(workspace.AllNPC.BTQuest2.CFrame, 'Button1')
			elseif questVal == 3 and Client.PlayerGui.Popup.Frame:FindFirstChild('Torch Quest Time') then
				_G.BloodmoonStatus = "Step 3 – Lighting torches with Ethereal (Phase 1)…"
				local torches = {"Torch1", "Torch2", "Torch3", "Torch4", "Torch5", "Torch6", "Torch7", "Torch8", "Torch9", "Torch10"}
				for _, torchName in ipairs(torches) do
					local torch = workspace.Torches:FindFirstChild(torchName)
					if torch and not torch.FlamePart:FindFirstChild('Attachment').FlameFlame.Enabled then
						if not Client.Backpack:FindFirstChild('Ethereal') and not Client.Character:FindFirstChild('Ethereal') and Client.Character.Humanoid.Health > 0 then
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Ethereal")
						end
						CloseChat()
						EquipTools('Ethereal')
						tp({ Target = torch.FlamePart.CFrame * CFrame.new(0, 0, 10) })
						getgenv().PosMonSkill = torch.FlamePart.CFrame
						wait(0.5)
						local virtualInput = game:service('VirtualInputManager')
						virtualInput:SendKeyEvent(true, "Z", false, game)
						virtualInput:SendKeyEvent(false, "Z", false, game)
						break
					end
				end
			elseif questVal == 4 then
				_G.BloodmoonStatus = "Step 4 – Talking to BTQuest3 NPC…"
				if workspace.AllNPC:FindFirstChild('BTQuest3') then
					getQuestOld(workspace.AllNPC.BTQuest3.CFrame, 'Button1')
				end
			elseif questVal == 5 then
				local imageUrl = game:GetService("Lighting").Sky.MoonTextureId
				local assetId = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
				if monkeyVal and monkeyVal > 0 and monkeyVal < 100 then
					if assetId == "5250084176" and not ( game:GetService("Lighting").ClockTime >= 6 and game:GetService("Lighting").ClockTime <= 18 ) then
						if Zenfunc['Entity']['find']({"Wilderness Gorilla [Lv. 4325]"}) then
							_G.BloodmoonStatus = "Step 5 – Farming Wilderness Gorilla (" .. tostring(monkeyVal) .. "/100)…"
							Zenfunc['Entity']['attack']({
								"Wilderness Gorilla [Lv. 4325]",
							}, fetch)
						else
							_G.BloodmoonStatus = "Step 5 – Traveling to Wilderness Gorilla spawn…"
							tp({ Target = CFrame.new(4861, 48.5, 10181.4) })
						end
					else
						_G.BloodmoonStatus = "Step 5 – Waiting for Bloodmoon night to farm gorilla…"
					end
				else
					if monkeyVal and monkeyVal >= 100 then
						_G.BloodmoonStatus = "Step 5 – Monkey quest complete! Talking to BTQuest3…"
						if workspace.AllNPC:FindFirstChild('BTQuest3') then
							getQuestOld(workspace.AllNPC.BTQuest3.CFrame, 'Button1')
						end
					else
						if Zenfunc['Entity']['find']({"Wilderness Gorilla [Lv. 4325]"}) then
							_G.BloodmoonStatus = "Step 5 – Farming Wilderness Gorilla…"
							Zenfunc['Entity']['attack']({
								"Wilderness Gorilla [Lv. 4325]",
							}, fetch)
						else
							_G.BloodmoonStatus = "Step 5 – Traveling to Wilderness Gorilla spawn…"
							tp({ Target = CFrame.new(4861, 48.5, 10181.4) })
						end
					end
				end
			elseif questVal == 6 and not Client.PlayerGui.Popup.Frame:FindFirstChild('Torch Quest Time') then
				_G.BloodmoonStatus = "Step 6 – Accepting second torch quest…"
				getQuestOld(workspace.AllNPC.BTQuest2.CFrame, 'Button1')
			elseif questVal == 6 and Client.PlayerGui.Popup.Frame:FindFirstChild('Torch Quest Time') then
				Config['Safe Mode'] = true
				if Zenfunc['Entity']['find']({"Samurai Soul [Lv. 7500]"}) then
					_G.BloodmoonStatus = "Step 6 – Fighting Samurai Soul [Lv.7500] (Boss)…"
					Zenfunc['Entity']['attack']({
						"Samurai Soul [Lv. 7500]",
					}, fetch)
				else
					_G.BloodmoonStatus = "Step 6 – Lighting torches with Ethereal (Phase 2)…"
					local torches = {"Torch1", "Torch2", "Torch3", "Torch4", "Torch5", "Torch6", "Torch7", "Torch8", "Torch9", "Torch10"}
					for _, torchName in ipairs(torches) do
						local torch = workspace.Torches:FindFirstChild(torchName)
						if torch and not torch.FlamePart:FindFirstChild('Attachment').FlameFlame.Enabled then
							CloseChat()
							if not Client.Backpack:FindFirstChild('Ethereal') and not Client.Character:FindFirstChild('Ethereal') and Client.Character.Humanoid.Health > 0 then
								game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Ethereal")
							end
							EquipTools('Ethereal')
							tp({ Target = torch.FlamePart.CFrame * CFrame.new(0, 0, 10) })
							getgenv().PosMonSkill = torch.FlamePart.CFrame
							wait(0.5)
							local virtualInput = game:service('VirtualInputManager')
							virtualInput:SendKeyEvent(true, "Z", false, game)
							virtualInput:SendKeyEvent(false, "Z", false, game)
							break
						end
					end
				end
			elseif questVal == 7 then
				_G.BloodmoonStatus = "Step 7 – Buying Bloodmoon Twins from NPC…"
				game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction:InvokeServer("Buy Bloodmoon Twins", "<AnimateStyle=Rainbow>Successfully purchased a sword.");
				if CloseChat ~= nil then
					Client.Character.Humanoid.Health = 0
				end
				wait(1)
			else
				_G.BloodmoonStatus = "Starting quest – talking to CDK NPC (Step 1)…"
				Zenfunc['CDK'](1)
			end
		end)
	end
	_G.BloodmoonStatus = "..."
	_G.BloodmoonReqs   = ""
end
Zenfunc['Auto Craft Rod'] = function()
	local fetch = 'Auto Craft Rod'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			local NeedMateria = {
				['Log'] = 30,
				['Rusted Scrap'] = 10
			}
			if Zenfunc['getPlayerMaterial']("Log") >= NeedMateria['Log'] and Zenfunc['getPlayerMaterial']("Rusted Scrap") >= NeedMateria['Rusted Scrap'] then
				if not Sea3 then
					local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "ThirdSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
				else
					game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("CraftSword"):InvokeServer("Basic Rod", "CraftingUI2")
				end
				return
			end
			if Zenfunc['getPlayerMaterial']("Log") < NeedMateria['Log'] then
				for _i, _v in pairs(game:GetService("Workspace"):GetDescendants()) do
					if string.find(_v.Name, "Tree") and _v:FindFirstChild("Part") and _v.Part.Transparency == 0 then
						if Config[fetch] and Zenfunc['getPlayerMaterial']("Log") <= NeedMateria['Log'] then
							repeat wait()
								if not Client.Backpack:FindFirstChild('Electro') and not Client.Character:FindFirstChild('Electro') then
									game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer("EquipFightingStyle", { FightingStyleName = "Electro" })
								end
								EquipTools("Electro")
								local Tree = _v:GetModelCFrame()
								getgenv().PosMonSkill = Tree
								if not Item.CheckOnCooldown("X") or not Item.CheckOnCooldown("V") then
									tp({Target = Tree})
									if not Item.CheckSkillLock("X") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
									end
									if not Item.CheckSkillLock("V") then
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end 
								end
							until not Config[fetch] or _v.Part.Transparency == 1
						end
					end
					if not  Config[fetch]  or Zenfunc['getPlayerMaterial']("Log") >= NeedMateria['Log'] then
						break
					end
				end
			elseif Zenfunc['getPlayerMaterial']("Rusted Scrap") < NeedMateria['Rusted Scrap'] then
				if not Sea1 then
					local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "FirstSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
				else
					if Zenfunc['Entity']['find'](AllMaterial['Sea1']['Rusted Scrap']) then
						Zenfunc['Entity']['attack'](AllMaterial['Sea1']['Rusted Scrap'], fetch)
					else
						if monsterPot[AllMaterial['Sea1']['Rusted Scrap'][1]] then
							tp({Target =  monsterPot[AllMaterial['Sea1']['Rusted Scrap'][1]] * CFrame.new(0, 30, 0)})
						end
					end
				end
			end
		end)
	end
end
Zenfunc['Auto Fishing'] = function()
	local fetch = 'Auto Fishing'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Client.Backpack:FindFirstChild('Basic Rod') and not Client.Character:FindFirstChild('Basic Rod') then
				game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Basic Rod")
			end
			if Client.PlayerGui:FindFirstChild('FishingUI') then
				for i,v in next, Fishgg do
					task.cancel(v)
				end
				Client.PlayerGui:FindFirstChild('FishingUI'):WaitForChild('FishingBackground').FishingBar.Size = UDim2.new(1, 0, 1.4, 0)
			else
				Fishgg[#Fishgg + 1 ] = task.spawn(function()
					local args = {
						"SW_Basic Rod_M1",
						{
							Charge = math.huge,
							MouseHit = CFrame.new(2251.24658203125, 32.17567443847656, 1355.826904296875, 1, 0, 0, 0, 1, 0, 0, 0, 1)
						}
					}
					game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("SkillAction"):InvokeServer(unpack(args))
				end)
			end
			EquipTools('Basic Rod')
            local spot = Config["Fishing Spot"]

if spot == "Serpent Whirlpool" then
    if workspace.Effects:FindFirstChild("SerpentWhirlpool") then
        tp({ Target = workspace.Effects.SerpentWhirlpool:GetPivot() })
    end

elseif spot == "Disire Position" then
    if Config["Lock TP Pos"] then
        tp({ Target = Config["Lock TP Pos"] })
    end

elseif spot == "Player Position" then
    local char = Client.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        tp({ Target = char.HumanoidRootPart.CFrame })
    end

elseif spot == "Default Spot" then
	if Sea1 then
    tp({ Target = CFrame.new(-2109.80908, 17.1106377, -4050.32251, -0.999293268, 1.55275863e-08, 0.0375901535, 1.71704517e-08, 1, 4.33818421e-08, -0.0375901535, 4.39966215e-08, -0.999293268) })
	elseif Sea2 then
		 tp({ Target = CFrame.new(-3475.67212, 33.0279121, 165.187912, 0.0361400321, 6.69935929e-08, -0.999346733, 1.12908687e-08, 1, 6.74457041e-08, 0.999346733, -1.37209826e-08, 0.0361400321) })
	elseif Sea3 then
 tp({ Target = CFrame.new(2188.97095, 35.6102448, 1321.28784, -0.999913692, -2.96750358e-09, -0.013138067, -2.71891332e-09, 1, -1.89392448e-08, 0.013138067, -1.89018881e-08, -0.999913692) })
	end
end

		end)
	end
end

Zenfunc['Auto Combat Striker V1'] = function()
	local fetch = 'Auto Combat Striker V1'
	while Config[fetch] and task.wait() do
		Zenfunc['getPcall'](fetch, function()
			if not Zenfunc['getQuestProgression']('Striker')['value'] then
				getQuestOld(workspace.AllNPC["Tiki Taka"].CFrame, 'Button1')
			else
				if Zenfunc['getQuestProgression']('Striker')['value'] == 1 then
					local monterkk = {
						'Fugitive [Lv. 4050]'
					}
					if Zenfunc['Entity']['find'](monterkk) then
						Zenfunc['Entity']['attack'](monterkk, fetch)
					else
						if monsterPot[monterkk[1]] then
							tp({Target =  monsterPot[monterkk[1]] * CFrame.new(0, 30, 0)})
						end
					end
				elseif Zenfunc['getQuestProgression']('Striker')['value'] == 2 then
					local monterkk = {
						'The deep one [Lv. 4200]'
					}
					if Zenfunc['Entity']['find'](monterkk) then
						Zenfunc['Entity']['attack'](monterkk, fetch)
					else
						if monsterPot[monterkk[1]] then
							tp({Target =  monsterPot[monterkk[1]] * CFrame.new(0, 30, 0)})
						end
					end
				elseif Zenfunc['getQuestProgression']('Striker')['value'] == 3 then
					local monterkk = {
						"Fishman King's Guard [Lv. 4250]"
					}
					if Zenfunc['Entity']['find'](monterkk) then
						Zenfunc['Entity']['attack'](monterkk, fetch)
					else
						if monsterPot[monterkk[1]] then
							tp({Target =  monsterPot[monterkk[1]] * CFrame.new(0, 30, 0)})
						end
					end
				elseif Zenfunc['getQuestProgression']('Striker')['value'] == 4 then
					local monterkk = {
						"Lord of Saber [Lv. 8500]"
					}
					if Zenfunc['Entity']['find'](monterkk) then
						Zenfunc['Entity']['attack'](monterkk, fetch)
					else
						if monsterPot[monterkk[1]] then
							tp({Target =  monsterPot[monterkk[1]] * CFrame.new(0, 30, 0)})
						end
					end
				elseif Zenfunc['getQuestProgression']('Striker')['value'] == 5 then
					if Client.Backpack:FindFirstChild('BombFruit') then
						getQuestOld(workspace.AllNPC["Tiki Taka"].CFrame, 'Button1',nil, true)
					else
						if Zenfunc['getPlayerFruitStore']('Bomb')['Value'] then
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("CollectFruit"):FireServer("BombFruit")
						else
							if Zenfunc['getPlayerMaterial']("Copper Key") then
								game:GetService("ReplicatedStorage").Chest.Remotes.Functions.UseKey:InvokeServer('Copper Key',"Open1") task.wait(1)
							else
								game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("BuyKey"):InvokeServer("Copper Key")
							end
						end
					end
				elseif Zenfunc['getQuestProgression']('Striker')['value'] == 6 then
					if Zenfunc['getPlayerMaterial']("Pebblefish") >= 10 and Zenfunc['getPlayerMaterial']("Lunafin") >= 10 and Zenfunc['getPlayerMaterial']("Solray") >= 5 and Zenfunc['getPlayerMaterial']("Longtooth") >= 2 and Zenfunc['getPlayerMaterial']("Sapphire Razer") >= 1 then
						getQuestOld(workspace.AllNPC["Tiki Taka"].CFrame, 'Button1')
					elseif Client.Inventory:FindFirstChild("Basic Rod") then
						tp({ Target = CFrame.new(-3883.30005, 77.0054169, 6217.52148, 0.781414568, 1.27741275e-08, -0.624012232, -1.56534483e-08, 1, 8.69044448e-10, 0.624012232, 9.08885944e-09, 0.781414568) })
						if not Client.Backpack:FindFirstChild('Basic Rod') and not Client.Character:FindFirstChild('Basic Rod') then
							game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("InventoryEq"):InvokeServer("Basic Rod")
						end
						if Client.PlayerGui:FindFirstChild('FishingUI') then
							for i,v in next, Fishgg do
								task.cancel(v)
							end
							Client.PlayerGui:FindFirstChild('FishingUI'):WaitForChild('FishingBackground').FishingBar.Size = UDim2.new(1, 0, 1.4, 0)
						else
							Fishgg[#Fishgg + 1 ] = task.spawn(function()
								local args = {
									"SW_Basic Rod_M1",
									{
										Charge = math.huge,
										MouseHit = CFrame.new(2251.24658203125, 32.17567443847656, 1355.826904296875, 1, 0, 0, 0, 1, 0, 0, 0, 1)
									}
								}
								game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("SkillAction"):InvokeServer(unpack(args))
							end)
						end
						EquipTools('Basic Rod')
					else
						local NeedMateria = {
							['Log'] = 30,
							['Rusted Scrap'] = 10
						}
						if Zenfunc['getPlayerMaterial']("Log") >= NeedMateria['Log'] and Zenfunc['getPlayerMaterial']("Rusted Scrap") >= NeedMateria['Rusted Scrap'] then
							if not Sea3 then
								local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "ThirdSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
							else
								game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("CraftSword"):InvokeServer("Basic Rod", "CraftingUI2")
							end
							return
						end
						if Zenfunc['getPlayerMaterial']("Log") < NeedMateria['Log'] then
							for _i, _v in pairs(game:GetService("Workspace"):GetDescendants()) do
								if string.find(_v.Name, "Tree") and _v:FindFirstChild("Part") and _v.Part.Transparency == 0 then
									if Config[fetch] and Zenfunc['getPlayerMaterial']("Log") <= NeedMateria['Log'] then
										repeat wait()
											if not Client.Backpack:FindFirstChild('Electro') and not Client.Character:FindFirstChild('Electro') then
												game:GetService("ReplicatedStorage"):WaitForChild("Chest"):WaitForChild("Remotes"):WaitForChild("Functions"):WaitForChild("EtcFunction"):InvokeServer("EquipFightingStyle", { FightingStyleName = "Electro" })
											end
											EquipTools("Electro")
											local Tree = _v:GetModelCFrame()
											getgenv().PosMonSkill = Tree
											if not Item.CheckOnCooldown("X") or not Item.CheckOnCooldown("V") then
												tp({Target = Tree})
												if not Item.CheckSkillLock("X") then
													game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
													game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
												end
												if not Item.CheckSkillLock("V") then
													game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
													game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
												end 
											end
										until not Config[fetch] or _v.Part.Transparency == 1
									end
								end
								if not  Config[fetch]  or Zenfunc['getPlayerMaterial']("Log") >= NeedMateria['Log'] then
									break
								end
							end
						elseif Zenfunc['getPlayerMaterial']("Rusted Scrap") < NeedMateria['Rusted Scrap'] then
							if not Sea1 then
								local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "FirstSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
							else
								if Zenfunc['Entity']['find'](AllMaterial['Sea1']['Rusted Scrap']) then
									Zenfunc['Entity']['attack'](AllMaterial['Sea1']['Rusted Scrap'], fetch)
								else
									if monsterPot[AllMaterial['Sea1']['Rusted Scrap'][1]] then
										tp({Target =  monsterPot[AllMaterial['Sea1']['Rusted Scrap'][1]] * CFrame.new(0, 30, 0)})
									end
								end
							end
						end
					end
				else
					getQuestOld(workspace.AllNPC["Tiki Taka"].CFrame, 'Button1')
				end
			end
		end)
	end
end
function loadIslandForAllNPCs(Pos, Mob)
	local islandData = getIslandResults[Pos]
	if not Config['Auto Farm Level'] or Zenfunc['Entity']['find']({Mob}) then return "Entity Spawn" end
	if islandData and #islandData > 0 then
		for _, pos in pairs(islandData) do
			if not Config['Auto Farm Level'] or Zenfunc['Entity']['find']({Mob}) then break end
			Client.Character.HumanoidRootPart.CFrame = pos * CFrame.new(0, 50, -math.random(5,10))
			wait(0.5)
		end
		return "Loaded all NPC positions on island: " .. Pos
	else
		return "No NPCs found on island: " .. Pos
	end
end
LegacyPoseTitle = "Sea King (Next)"
task.spawn(function()
	while task.wait(1) do
		Zenfunc['getPcall']('Loop All', function()
			local backpack = Client.Backpack
			local playerGui = Client.PlayerGui.MainGui.StarterFrame.StatsFrame.RemoteEvent
			if Sea2 then
				local imageUrl
				if Client.PlayerGui.MainGui.StarterFrame.LegacyPoseFrame.SecondSea.SKImage.Visible then
					imageUrl = '7788782004'
					LegacyPoseTitle = "Sea king Spawning"
				elseif GUI.MainGui.StarterFrame.LegacyPoseFrame.SecondSea.SKTimeLabel.Text == "00:00:00" then
					imageUrl = '7788782004'
					LegacyPoseTitle = "Waiting for reset"
				else
					imageUrl = '11518150703'
					LegacyPoseTitle = "Hydra King Spawning"
				end
				LegacyPoseGS:Set('Ghost Ship Time Spawn : '.. game:GetService('ReplicatedStorage'):GetAttribute('GhostShipSpawnText'))
				LegacyPose:UpdateImage(imageUrl)
				LegacyPose:UpdateTitle(LegacyPoseTitle)
				LegacyPose:UpdateDis('Time Spawn : '.. game:GetService('ReplicatedStorage'):GetAttribute('SeaMonsterSpawnText'))
			elseif Sea3 then
				local imageUrl = game:GetService("Lighting").Sky.MoonTextureId
				local assetId = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
				MoodDis = (assetId == '5250084176' and "Bloodmoon") or  "Normal Moon"
				LegacyPose:Set("Legacy Pose: " .. GUI.MainGui.StarterFrame.LegacyPoseFrame.ThirdSea.TextLabel.Text)
				if not ( game:GetService("Lighting").ClockTime >= 6 and game:GetService("Lighting").ClockTime <= 18 ) then
					MoonImage:UpdateImage(assetId)
					MoonImage:UpdateTitle('Moon Texture')
					MoonImage:UpdateDis(MoodDis .. " ( Spawn ) ")
				else
					local imageUrl = game:GetService("Lighting").Sky.SunTextureId
					local assetId = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
					MoonImage:UpdateImage(assetId)
					MoonImage:UpdateTitle(' ( Next Is "' .. MoodDis .. '" )')
					MoonImage:UpdateDis("🌙 Wait For Night 🌙")
				end
			end
			if Config['Select Weapon'] == "Melee" or Config['Select Weapon'] == "Sword" then
				local toolType
				if Config['Select Weapon'] == "Melee" then
					toolType = "Combat"
				elseif Config['Select Weapon'] == "Sword" then
					toolType = "Sword"
				else
					toolType = "Fruit Power"
				end
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ClassName == "Tool" and tool.ToolTip == toolType then
						_G.Weapon = tostring(tool.Name)
					end
				end
			elseif Config['Select Weapon'] == "Fruit" then
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ToolTip == "Fruit Power" then
						if tool.ClassName == "Tool" then
							myWeapon["Fruit"] = tostring(tool.Name)
						end
					end
				end
			elseif Config['Select Weapon'] == "Melee&Fruit" then
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ToolTip == "Fruit Power" then
						if tool.ClassName == "Tool" then
							myWeapon["Fruit"] = tostring(tool.Name)
						end
					elseif tool.ToolTip == "Combat" then
						if tool.ClassName == "Tool" then
							myWeapon["Melee"] = tostring(tool.Name)
						end
					end
				end
			elseif Config['Select Weapon'] == "Melee&Sword" then
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ClassName == "Tool" then
						if tool.ToolTip == "Sword" then
							myWeapon["Sword"] = tostring(tool.Name)
						elseif tool.ToolTip == "Combat" then
							myWeapon["Melee"] = tostring(tool.Name)
						end
					end
				end
			elseif Config['Select Weapon'] == "Sword&Fruit" then
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ClassName == "Tool" then
						if tool.ToolTip == "Sword" then
							myWeapon["Sword"] = tostring(tool.Name)
						elseif tool.ToolTip == "Fruit Power" then
							myWeapon["Fruit"] = tostring(tool.Name)
						end
					end
				end
			elseif Config['Select Weapon'] == "All for One" then
				for _, tool in pairs(backpack:GetChildren()) do
					if tool.ClassName == "Tool" then
						if tool.ToolTip == "Combat" then
							myWeapon["Melee"] = tostring(tool.Name)
						elseif tool.ToolTip == "Sword" then
							myWeapon["Sword"] = tostring(tool.Name)
						elseif tool.ToolTip == "Fruit Power" then
							myWeapon["Fruit"] = tostring(tool.Name)
						end
					end
				end
			else
				Config['Select Weapon'] = "Melee"
			end

			for _, tool in pairs(backpack:GetChildren()) do
				if tool.ToolTip == "Fruit Power" then
					if tool.ClassName == "Tool" then
						myWeapon["Fruit"] = tostring(tool.Name)
					end
				end
			end

			if _G.Debug then
				warn('[DEBUG]',  IsFarm, " : IsFarm")
			end
		end)
	end
end)

local function getTextoforLabel()
	task.spawn(function()
		while task.wait() do
			Zenfunc['getPcall']('Loop All (2)', function()
				if Config['Walk On Water'] and workspace:FindFirstChild('SeaFolder') and workspace:FindFirstChild('SeaFolder'):FindFirstChild('Sea') then
					workspace:FindFirstChild('SeaFolder'):FindFirstChild('Sea').CanCollide = Config['Walk On Water']
				end
				if Config['Noclip Toggle'] then
					for _, v in pairs(Client.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							v.CanCollide = false    
						end
					end
				end
				UpdateStandMethond()
				if Config['Romove Fog'] then
					game:GetService("Lighting").FogEnd = math.huge
				end
				if Config['daytimd'] then
					game:GetService("Lighting").TimeOfDay = '12:00:00'
				end
				if Zenfunc['Entity']['find']({"Minion","Boss"}) then
					t['Minion Spawn']:Set("Minion Spawn : ".._G.greencircle)
				else
					t['Minion Spawn']:Set("Minion Spawn : ".._G.redcircle)
				end
				t['Player Candy']:Set("🍭 Player Candy : ".. Zenfunc['getPlayerMaterial']("Candy") .. " 🍭")
				if Sea1 then
					if Zenfunc['Entity']['find']({"Expert Swordman [Lv. 3000]"}) then
						t['Expert Swordman']:Set("Expert Swordman : ".._G.greencircle)
					else
						t['Expert Swordman']:Set("Expert Swordman : ".._G.redcircle)
					end
				end
				if Zenfunc['Entity']['find']({"Jack o lantern [Lv. 10000]"}) then
					t['Jack o lantern']:Set('Jack o lantern : 🟢')
				else
					t['Jack o lantern']:Set('Jack o lantern : 🔴')
				end
				if Zenfunc['Entity']['find']({"SeaKing"}) then
					t['Sea King']:Set("Sea King : ".._G.greencircle)
				else
					t['Sea King']:Set("Sea King : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({"HydraSeaKing"}) then
					t['Hydra Sea King']:Set("Hydra Sea King : ".._G.greencircle)
				else
					t['Hydra Sea King']:Set("Hydra Sea King : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({"Skull King"}) then
					t['Skull King']:Set("Skull King : ".._G.greencircle)
				else
					t['Skull King']:Set("Skull King : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'ThirdSeaDragon'}) then
					t['Third Sea Dragon']:Set("Third Sea Dragon : ".._G.greencircle)
				else
					t['Third Sea Dragon']:Set("Sea 3 Dragon : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'SeaDragon'}) then
					t['Sea Dragon']:Set("Sea Dragon : ".._G.greencircle)
				else
					t['Sea Dragon']:Set("Sea Dragon : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'Shark Galleon Boss'}) then
					t['Shark Galleon Boss']:Set("Shark Galleon Boss : ".._G.greencircle)
				else
					t['Shark Galleon Boss']:Set("Shark Galleon Boss : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'Serpent'}) then
					t['Serpent']:Set("Serpent : ".._G.greencircle)
				else
					if workspace.Effects:FindFirstChild('SerpentWhirlpool') then
						t['Serpent']:Set("Serpent Whirl Pool : ".._G.greencircle)	
					else
						t['Serpent']:Set("Serpent : ".._G.redcircle)
					end
				end 
				if workspace.Effects:FindFirstChild('SerpentWhirlpool') then
					t['Serpent Whirl Pool']:Set("Serpent Whirl Pool : ".._G.greencircle)	
				else
					t['Serpent Whirl Pool']:Set("Snake Spawn : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'ThirdSeaEldritch Crab'}) then
					t['Deepsea Crusher']:Set("Deepsea Crusher : ".._G.greencircle)
				else
					t['Deepsea Crusher']:Set("Deepsea Crusher : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'FuryTentacle'}) then
					t['Chaos Kraken']:Set("Chaos Kraken : ".._G.greencircle)
				else
					t['Chaos Kraken']:Set("Chaos Kraken : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'King Samurai [Lv. 3500]'}) then
					t['King Samurai']:Set("King Samurai : ".._G.greencircle)
				else
					t['King Samurai']:Set("King Samurai : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'Dragon [Lv. 5000]'}) then
					t['Dragon']:Set("Dragon : ".._G.greencircle)
				else
					t['Dragon']:Set("Dragon : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'Ms. Mother [Lv. 7500]'}) then
					t['BigMom']:Set("Ms. Mother : ".._G.greencircle)
				else
					t['BigMom']:Set("Ms. Mother : ".._G.redcircle)
				end
				if workspace.AllNPC:FindFirstChild('PassiveTree') then
					t['Passive Tree']:Set("Passive Tree : ".._G.greencircle)
				else
					t['Passive Tree']:Set("Passive Tree : ".._G.redcircle)
				end
				if Zenfunc['Entity']['find']({'Ghost Ship'}) then
					t['Ghost Ship']:Set('Ghost Ship : 🟢')
				else
					t['Ghost Ship']:Set('Ghost Ship : 🔴')
				end
				if InRaid then
					if workspace:FindFirstChild('Surface') then
						t['Rejoin The Dungeon']:Set(workspace.Surface.SurfaceGui.TextLabel.Text)
					end
					t['Need Kill The Dungeon']:Set(Client.PlayerGui["GoldenArena GUI"]:FindFirstChild("Lefts").Text)
				end
				local getTable = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.GetDFShop:InvokeServer()
				local formatted = Client.PlayerGui.MainGui.StarterFrame.FruitFrame.TextLabel.Text .. "\n"
				for key, value in pairs(getTable) do
					if value == true then
						formatted = formatted .. "( 🟢 ): " .. key .. "\n"
					end
				end
				formatted = formatted:sub(1, -3)
				formatted = formatted .. "\n"
				t['GetDFShop']:Set(formatted)
			end)
		end
	end)
end
loadstring(game:HttpGet("https://pastebin.com/raw/x3bw9KF2", true))()
local Alc = loadstring(game:HttpGet("https://pastefy.app/dWANwOyy/raw",true))()
local MarketplaceService = game:GetService("MarketplaceService")
local gameName = "Unknown"
pcall(
    function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        gameName = info.Name
    end
)
local Window = Alc:NewWindow("Version : 2.1 / " .. gameName, "rbxassetid://116422175458617")

local MenuFunctions = Window:AddMenu()


function Toggle(options, CallBack, SettingName)
    local Section = options.Section
    local Title = options.Title
    local Locker = options.Locker
    local tasks

    if type(CallBack) == 'string' then
        if not SettingName then
            SettingName = CallBack
        end
        CallBack = nil
    end    

    if not SettingName then
        SettingName = Title
    end

    local mainToggle = Section:AddToggle({
        Name = Title,
        Description = options.Dis or "",
        Default = Config[SettingName] or false,

        Callback = CallBack or function(v)
            Config[SettingName] = v
            SaveSettings()

            -- 🔥 AUTO EXEC (ONLY FOR auto_hop)
            local q = queue_on_teleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport

            if SettingName == "auto_hop" then
                if v then
                    if q then
                        q("loadstring(game:HttpGet('"..AUTO_EXEC_URL.."'))()")
                        print("Auto-exec enabled")
                    else
                        warn("queue_on_teleport not supported")
                    end
                else
                    print("Auto-exec disabled")
                end
            end

            -- 🔧 RUN ZENFUNC
            local Success, Error = pcall(function()
                tasks = task.spawn(function() 
                    if Zenfunc[SettingName] then 
                        Zenfunc[SettingName](SettingName) 
                    end 
                end)

                if (not v) and tasks then 
                    task.cancel(tasks) 
                end
            end)

            if not Success then
                warn(SettingName.." Error:", Error)
            end

            -- 🛑 CLEANUP WHEN OFF
            if not v then
                delay(0.2, function()
                    _G.NeedNoClip = false
                    NeedAttack = false
                end)
            end
        end
    })

    if Locker then
        -- mainToggle:Lock()
    end

    return mainToggle
end

function Label(options)
    local Section = options.Section
    local Title = options.Title

    return Section:AddLabel(Title)
end

function Button(options, CallBack, SettingName)
    local Section = options.Section
    local Title = options.Title

    if type(CallBack) == 'string' then
        if not SettingName then
            SettingName = CallBack
        end
        CallBack = nil
    end

    return Section:AddButton({
        Name = Title,
        Callback = CallBack or function()
            --print("Kuy")
        end
    })
end

function Dropdown(options, CallBack, DropName)
    local Section = options.Section
    local Title = options.Title
    local List = options.List
    local Multi = options.Multi or false
    local Value = options.Value

    -- Handle string CallBack as DropName
    if type(CallBack) == 'string' then
        DropName = DropName or CallBack
        CallBack = nil
    end

    return Section:AddDropdown({
        Name = Title,
        Description = options.Dis or "",
        Option = List,
        Multi = Multi,
        Default = Config[DropName] or Value or (Multi and {} or (List and List[1])),

        Callback = CallBack or function(v)
            Config[DropName] = v
            SaveSettings()
        end
    })
end

function TextBox(options, CallBack, TextBoxName)
    local Section = options.Section
    local Title = options.Title
    local Placeholder = options.Placeholder or ""
    local Value = options.Value or ""

    if type(CallBack) == 'string' then
        if not TextBoxName then
            TextBoxName = CallBack
        end
        CallBack = nil
    end

    return Section:Textbox(
        Title,
        Placeholder,
        CallBack or function(v)
            Config[TextBoxName] = v
            SaveSettings()
        end
    )
end

function Slider(options, CallBack, SliderName)
    local Section = options.Section
    local Title = options.Title
    local Value = options.Value
    local Floor = options.Floor or false

    if type(CallBack) == 'string' then
        if not SliderName then
            SliderName = CallBack
        end
        CallBack = nil
    end

    return Section:AddSlider({
        Name = Title,
        min = options.Min,
        max = options.Max,
        Default = Config[SliderName] or Value or 0,

        Callback = CallBack or function(v)
            Config[SliderName] = v
            SaveSettings()
        end
    })
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local requestFunc = http_request or request or HttpPost or syn.request
local sent, sent1, sent2 = {}, {}, {}

local function timeNow()
    local t = os.date("*t")
    return string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
end

local function getSea()
    local id = game.PlaceId
    if id == 4520749081 then return "First Sea"
    elseif id == 6381829480 then return "Second Sea"
    elseif id == 15759515082 then return "Third Sea"
    end
    return ""
end

local function enemies()
    local id = game.PlaceId
    if id == 6381829480 then
        return Workspace.SeaMonster:GetChildren(),
        (Workspace:FindFirstChild("GhostMonster") and Workspace.GhostMonster:GetChildren()) or {}
    elseif id == 15759515082 then
        return Workspace.SeaMonster:GetChildren(),
        ReplicatedStorage.MOB:GetChildren()
    end
    local mob = ReplicatedStorage.MOB:GetChildren()
    return mob, mob
end

local function alive(e)
    local h = e:FindFirstChild("Humanoid")
    return h and h.Health > 0
end

local function findEnemy(names)
    local sea, ghost = enemies()
    local function scan(list)
        for i = 1, #list do
            local v = list[i]
            if alive(v) and table.find(names, v.Name) then
                return true
            end
        end
    end
    return scan(sea) or scan(ghost)
    or scan(Workspace.Monster.Mon:GetChildren())
    or scan(Workspace.Monster.Boss:GetChildren())
end

local function send(url, boss, extra)
    local data = {
        username = "Zen Hub",
        avatar_url = "https://images-ext-1.discordapp.net/external/u9tnnmDGBDMO0KB-7X7byaucIZOhnrAxuygvQVVvGFc/%3Fsize%3D1024/https/cdn.discordapp.com/icons/1189265387217490051/a_d21c49868a7545872e18696c32ac346e.gif",
        embeds = {{
            description = "**__King Legacy Notifier__**",
            color = 0xEEEEEE,
            fields = {
                {name="[👥] Players Active",value="```"..#Players:GetPlayers().."/12```",inline=true},
                {name="[🌊] World",value="```"..getSea().."```",inline=true},
                {name="[⏱️] Server Time",value="```"..timeNow().."```",inline=true},
                {name="[🌐] Boss Found",value="```"..boss.."```",inline=true},
                extra or {name="[📁] Join Server",value="```ZenHub_"..game.JobId.."```"}
            },
            footer = {text="Zen Hub | Webhook"},
            timestamp = DateTime.now():ToIsoDate()
        }}
    }
    requestFunc({
        Url = url,
        Body = HttpService:JSONEncode(data),
        Method = "POST",
        Headers = {["content-type"]="application/json"}
    })
end

local seaBoss = {
    [4520749081] = {
        url = "https://discord.com/api/webhooks/1486372125425270905/f9EBNxdG5W7ohFfsx9hga_YqfahLIIrB1-sGJqwK9lo3Bt69DLv6bHAlkeYBTbQLpQ0E",
        list = {["Skull King"]="Skull King",["Serpent"]="Sea Serpent"}
    },
    [6381829480] = {
        url = "https://discord.com/api/webhooks/1486354353630744616/gKEYz4IzdpjH_ecVL7lLDh4KmDKec_1aWAdhsz1pthwIq3T1Chr2sfxArUpWXuGaawwY",
        list = {
            ["Skull King"]="Skull King",
            ["Ghost Ship"]="Ghost Ship",
            ["Serpent"]="Sea Serpent",
            ["HydraSeaKing"]="Hydra Sea King",
            ["SeaKing"]="Sea King"
        }
    },
    [15759515082] = {
        url = "https://discord.com/api/webhooks/1486354517300609144/oMT4bItn-NwlULuXKv8Z6qnjcUNDNqeCACQ085LyeQ3oha5Pgqv7NfnlZlDPxfu3dZFg",
        list = {
            ["FuryTentacle"]="Chaos Kraken",
            ["ThirdSeaEldritch Crab"]="Deepsea Crusher",
            ["ThirdSeaDragon"]="Drakenfyr the Inferno King",
            ["Serpent"]="Sea Serpent",
            ["SeaDragon"]="Abyssal Tyrant",
            ["Skull King"]="Skull King"
        }
    }
}

local world = {
    url = "https://discord.com/api/webhooks/1486354735203094559/mHQphEjwUAaPD5Pr8Mzm5oLfQAqb2LWHjXk1IO7qLFVSqKG6WCdpdGQsoqXW-9EqtbHS",
    list = {
        ["Jack o lantern [Lv. 10000]"]="Jack o lantern",
        ["King Samurai [Lv. 3500]"]="King Samurai",
        ["Dragon [Lv. 5000]"]="Dragon",
        ["Ms. Mother [Lv. 7500]"]="Ms. Mother",
        ["Lord of Saber [Lv. 8500]"]="Lord of Saber",
        ["Pteranodon [Lv. 12500]"]="Pteranodon",
        ["Bushido Ape [Lv. 5000]"]="Bushido Ape"
    }
}

local ships = {
    url = "https://discord.com/api/webhooks/1486387545666359419/kwXDp26-s8Yhd5Om1WyMavzIEMWivEto3o-R8XwOTLbzSt221vd4QO61t5LbDSXH1f0E",
    list = {
        ["Royal Galleon Boss"]="Royal Galleon Boss",
        ["Whale Galleon Boss"]="Whale Galleon Boss",
        ["Shark Galleon Boss"]="Shark Galleon Boss",
        ["Kraken Galleon Boss"]="Kraken Galleon Boss",
        ["Ghost Galleon Boss"]="Ghost Galleon Boss"
    }
}

local function scanSet(set, cache)
    for name, boss in pairs(set.list) do
        if not cache[name] and findEnemy({name}) then
            send(set.url, boss.." Spawned ✅")
            cache[name] = true
        end
    end
end

task.spawn(function()
    while task.wait(5) do
        local s = seaBoss[game.PlaceId]
        if s then scanSet(s, sent) end
        scanSet(world, sent1)
        scanSet(ships, sent2)
    end
end)

local seaText = ReplicatedStorage:GetAttribute("ThirdSeaMonsterSpawnText")
local spawnTime = ReplicatedStorage:GetAttribute("ThirdSeaMonsterSpawnTime")

local sentSail, sentWarn = false, false

local function sendTime(name, t)
    send(
        "https://discord.com/api/webhooks/1486372586307715123/-lKUDGPeuo9Ey0i56DQ-NHSuX_OaL4-CjsKbAlZbVXeKJDapRKozaQuHq_vMNPA91Ud3",
        name,
        {name="[⏱️] Time Remaining",value="```"..math.floor(t/60).." minutes```",inline=true}
    )
end

task.spawn(function()
    while task.wait(5) do
        if spawnTime then
            local r = spawnTime - os.time()
            if r > 60 and r <= 600 and not sentWarn then
                sendTime("Spawn approaching", r)
                sentWarn = true
            end
        end
        if seaText == "Set sail!" and not sentSail then
            sendTime("Set sail!", 0)
            sentSail = true
        end
    end
end)


local Configs    = MenuFunctions:AddTab("Configs Farm",  110972640593735, "distance,bringmob")
local Mains      = MenuFunctions:AddTab("Main Farm",     6035153656,  "farm,bossess,etc.")
local Bosses     = MenuFunctions:AddTab("Automatic",  10734949856, "farm,bossess,etc.")
local Seas       = MenuFunctions:AddTab("Sea Event",     6034754442,  "farm,bossess,etc.")
local statplayer = MenuFunctions:AddTab("Local Player",  10709770431, "auto stats melee,sword,fruit")
local Travelsea  = MenuFunctions:AddTab("Travel Seas",   14477598542, "teleport sea,hop")
local Store      = MenuFunctions:AddTab("Shops",         10734952479, "auto buy sword,fruit")
local Raids      = MenuFunctions:AddTab("Dungeon",       10734932295, "auto raid,autoskill")
local Misc       = MenuFunctions:AddTab("Misc",          14477663692, "other,config")


local Settings = Configs:AddSection("Config Farms")
Settings:PlayerInfo(game.Players.LocalPlayer)
Settings:AddSeparator({ Label = "⚔  Weapon & Skills" })

Dropdown({
    Section = Settings,
    Title   = "Select Weapon",
    List    = { "Melee", "Sword", "Fruit", "Melee&Fruit", "Melee&Sword", "Sword&Fruit", "All for One" },
    Value   = Config["Select Weapon"]
}, "Select Weapon")

Dropdown({
    Section = Settings,
    Title   = "Select Distance Mode",
    List    = { "Above", "Biside", "Below" },
    Value   = Config["FlightAt"]
}, "FlightAt")

Dropdown({
    Section = Settings,
    Title   = "Select Skill",
    List    = { "Z", "X", "C", "V", "B","E"},
    Multi   = true,
    Value   = Config["Select Skill"]
}, "Select Skill")

Slider({
    Section = Settings,
    Title   = "Select Distance",
    Max     = 300,
    Min     = 1,
}, "RawStand")

Toggle({
    Section = Settings,
    Title   = "Auto Use Skill"
}, "Auto Use Skill")

local VIM = game:GetService("VirtualInputManager")
local Player = game.Players.LocalPlayer

Toggle({
    Section = Settings,
    Title   = "Auto Ken",
    Value   = Config["Auto Ken"]
}, function(v)
    Config["Auto Ken"] = v
    SaveSettings()
end)

task.spawn(function()
    while task.wait(0.5) do
        if Config["Auto Ken"] then
            local charFolder = workspace:FindFirstChild("PlayerCharacters")
            local char = charFolder and charFolder:FindFirstChild(Player.Name)

            if char then
                local ken = char:FindFirstChild("ObservationHighlightUsed")

                -- ONLY activate if OFF
                if not ken then
                    VIM:SendKeyEvent(true, "Y", false, game)
                    task.wait(0.1)
                    VIM:SendKeyEvent(false, "Y", false, game)

                    task.wait(0.3) -- debounce (no spam)
                end
            end
        end
    end
end)

Toggle({
    Section = Settings,
    Title   = "Legacy Pose",
    Value   = Config["Legacy Pose"]
}, function(v)
    Config["Legacy Pose"] = v
    SaveSettings()

    if v then
        CloneLegacyPose(game.Players.LocalPlayer)
    else
        RemoveLegacyPose(game.Players.LocalPlayer)
    end
end)

Toggle({
    Section = Settings,
    Title   = "Black Screen",
    Value   = Config["Black Screen"]
}, function(v)
    Config["Black Screen"] = v
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
    if not v and COREGUI:FindFirstChild("Black Screen") then
        COREGUI:FindFirstChild("Black Screen"):Destroy()
    end
    if v and not Client.PlayerGui:FindFirstChild("Black Screen") then
        local Par = Instance.new("ScreenGui")
        Par.Name           = "Black Screen"
        Par.IgnoreGuiInset = true
        Par.Parent         = COREGUI
        local ui = Instance.new("Frame")
        ui.BackgroundColor3       = Color3.new(0, 0, 0)
        ui.BackgroundTransparency = 0
        ui.Size   = UDim2.fromScale(1, 1)
        ui.ZIndex = -999
        ui.Parent = Par
    end
    SaveSettings()
end)

Toggle({
    Section = Settings,
    Title   = "White Screen",
    Value   = Config["White Screen"]
}, function(v)
    Config["White Screen"] = v
    game:GetService("RunService"):Set3dRenderingEnabled(not v)
    SaveSettings()
end)

Toggle({
    Section = Settings,
    Title   = "Ignore Boss quest when farm"
}, "Not Accept Boss")

Toggle({
    Section = Settings,
    Title   = "Safe Mode For Health",
    Value   = Config["Safe Mode"]
}, "Safe Mode")

Toggle({
    Section = Settings,
    Title   = "Auto accept ally",
    Value   = Config["Auto Ally Accept All"]
}, "Auto Ally Accept All")


Settings:AddSeparator({ Label = "❤  Health" })

Slider({
    Section = Settings,
    Title   = "Your HP (%)",
    Max     = 100,
    Min     = 1,
}, "Select You HP (%)")

Slider({
    Section = Settings,
    Title   = "Your HP Max (%)",
    Max     = 100,
    Min     = 1,
}, "Select You HP Max (%)")

--[[
Slider({
    Section = Settings,
    Title   = "Sea Monster Hop Timer (sec)",
    Max     = 60,
    Min     = 1,
}, "Setting Sea Monster Time (for Hop)")]]


local FarmsLv = Mains:AddSection("Level Farm")

local labelAutoFarm = FarmsLv:AddLabel("Auto Farming: Inactive")
local questname     = FarmsLv:AddLabel("Quest: N/A")
local labelHealth   = FarmsLv:AddLabel("Health: N/A")

-- Wire the _G label globals into the UI labels every 0.3s
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            if labelAutoFarm then
                labelAutoFarm:Set(_G.LabelAutoFarm or "Auto Farming: Inactive")
            end
            if questname then
                local q = _G.Questname or ""
                -- strip a leading "Quest: " prefix if updateLabel already added it
                if q:sub(1,7) == "Quest: " then q = q:sub(8) end
                questname:Set("Quest: " .. (q ~= "" and q or "N/A"))
            end
            if labelHealth then
                labelHealth:Set(_G.LabelHealth or "Health: N/A")
            end
        end)
    end
end)


Toggle({ Section = FarmsLv, Title = "Auto Farm Level" }, "Auto Farm Level")
Toggle({ Section = FarmsLv, Title = "Auto Farm Near Mob" }, "Auto_Farm_Nearest_Mob")
if Sea1 then
Toggle({ Section = FarmsLv, Title = "Auto Second Sea"  }, "Auto Second Sea")
elseif Sea2 then
Toggle({ Section = FarmsLv, Title = "Auto Third World" }, "Auto Third World")
end

local dailyquest = Mains:AddSection("Daily Quest")

		dailyquest:AddLabel("Work only in Sea 1, Will be added Sea 2 and 3 Soon!")
		Dropdown({
			Section = dailyquest,
			Title = 'Select Daily Quest',
			List = DailyQuestTable,
		}, 'Select Daily Quest')
		Toggle({
			Section = dailyquest,
			Title = "Auto Daily Quest",
			Value = Config['Auto Daily Quest']
		}, "Auto Daily Quest")


local Othermob = Mains:AddSection("Other Mob")

Dropdown({
    Section = Othermob,
    Title   = "Select Monster",
    List    = MonsterList,
}, "Select Monster")

Toggle({
    Section = Othermob,
    Title   = "Start Select Monster Farm",
    Value   = Config["Start Select Monster Farm"]
}, "Start Select Monster Farm")

local Fishing = Mains:AddSection("Auto Fishing")

local FightingPos = Fishing:AddLabel("Disired Spot Pos : N/A")

local FishingSpotList = {
    "Default Spot",
    "Disire Position",
    "Player Position",
    "Serpent Whirlpool"
}

Fishing:AddDropdown({
    Name = "Select Fishing Spot",
    Option = FishingSpotList,
    Default = "Default Spot",
    Callback = function(v)
        Config["Fishing Spot"] = v
    end
})

Toggle({ Section = Fishing, Title = "Auto Craft Rod" }, "Auto Craft Rod")
Toggle({ Section = Fishing, Title = "Auto Fishing"   }, "Auto Fishing")
Button({ Section = Fishing, Title = "Save Disired Spot Position" }, function()
    Config["Lock TP Pos"] = Client.Character.HumanoidRootPart.CFrame
    local pos = Client.Character.HumanoidRootPart.Position
    FightingPos:Set(("Pos: %.1f, %.1f, %.1f"):format(pos.X, pos.Y, pos.Z))
end)

local Materials = Mains:AddSection("Auto Materials")

if Sea1 then
    Dropdown({ Section = Materials, Title = "Select Material Sea1", List = MaterialSea1 }, "Select Material Sea1")
    Toggle({ Section = Materials, Title = "Start Material Farm", Value = Config["Start Material Farm Sea1"] }, "Start Material Farm Sea1")
elseif Sea2 then
    Dropdown({ Section = Materials, Title = "Select Material Sea2", List = MaterialSea2 }, "Select Material Sea2")
    Toggle({ Section = Materials, Title = "Start Material Farm", Value = Config["Start Material Farm Sea2"] }, "Start Material Farm Sea2")
elseif Sea3 then
    Dropdown({ Section = Materials, Title = "Select Material Sea3", List = MaterialSea3 }, "Select Material Sea3")
    Toggle({ Section = Materials, Title = "Start Material Farm", Value = Config["Start Material Farm Sea3"] }, "Start Material Farm Sea3")
end

local PassiveTree = Mains:AddSection("Auto Passive Tree")

t["Passive Tree"] = PassiveTree:AddLabel("Passive Tree : ".._G.redcircle)

Button({ Title = "Tp To Passive Tree", Section = PassiveTree }, function()
    if workspace.AllNPC:FindFirstChild("PassiveTree") then
        for i = 1, 50 do
            wait()
            getQuestOld(workspace.AllNPC.PassiveTree.CFrame)
        end
        wait(0.2)
        _G.NeedNoClip = false
    end
end)

local Minion = Bosses:AddSection("Minions & Chest")

Toggle({ Section = Minion, Title = "Auto Kill Minion" }, "Auto Kill Minion")
Toggle({ Section = Minion, Title = "Auto Get Chest"  }, "Auto Keep Chest")


local allbosesss = Bosses:AddSection("Bosses in "..TitleSea)

local BossLabels = {}

function GetBossList()
	if Sea1 then
		return {
			{name = "Expert Swordman [Lv. 3000]", label = "Expert Swordman"},
		}
	elseif Sea2 then
		return {
			{name = "Ms. Mother [Lv. 7500]", label = "Big Mom"},
			{name = "King Samurai [Lv. 3500]", label = "King Samurai"},
		}
	elseif Sea3 then
		return {
			{name = "Bushido Ape [Lv. 5000]", label = "Bushido Ape"},
			{name = "Lord of Saber [Lv. 8500]", label = "Lord Of Saber"},
			{name = "Pteranodon [Lv. 12500]", label = "Pteranodon"},
		}
	end
	return {}
end

function SetupBossUI()
	local Bosses = GetBossList()

	for _, boss in ipairs(Bosses) do
		local label = allbosesss:AddLabel(boss.label .. ": Checking...")
		BossLabels[boss.name] = label

		Toggle({
			Section = allbosesss,
			Title = "Auto Kill " .. boss.label,
			Value = Config["Auto Kill " .. boss.label]
		}, "Auto Kill " .. boss.label)

		Toggle({
			Section = allbosesss,
			Title = boss.label .. " ( Hop )",
			Value = Config[boss.label .. " Hop"]
		}, boss.label .. " Hop")

		allbosesss:AddSeparator()
	end
end

SetupBossUI()

task.spawn(function()
	while task.wait(0.5) do
		local Bosses = GetBossList()

		for _, boss in ipairs(Bosses) do
			local alive = Zenfunc["Entity"]["find"]({ boss.name })
			local status = alive and _G.greencircle or _G.redcircle

			if BossLabels[boss.name] then
				BossLabels[boss.name]:Set(boss.label .. ": " .. status)
			end

			if alive and Config["Auto Kill " .. boss.label] then
				Zenfunc["Entity"]["attack"]({boss.name}, "Auto Kill " .. boss.label)
			end

			if not alive and Config[boss.label .. " Hop"] then
				HopSeaKingThird()
			end
		end
	end
end)

if Sea2 then
local kaidodrag = Bosses:AddSection("Auto Kill Dragon ( Kaido )")
t["Dragon"] = kaidodrag:AddLabel("Dragon Kaido")
Toggle({ Section = kaidodrag, Title = "Auto Kill Dragon", Value = Config["Auto Kill Dragon"] }, "Auto Kill Dragon")
Toggle({ Section = kaidodrag, Title = "Spawn Dragon",     Value = Config["Spawn Dragon"]     }, "Spawn Dragon")
Toggle({ Section = kaidodrag, Title = "Dragon ( Hop )",   Value = Config["Dragon Hop"]       }, "Dragon Hop")
end

local ckdss = Bosses:AddSection("Blood Moon Twin")

local bmStatusLabel = ckdss:AddLabel("Bloodmoon: Inactive")
local bmReqsLabel   = ckdss:AddLabel("Requirements: N/A")

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if bmStatusLabel then
                bmStatusLabel:Set(_G.BloodmoonStatus or "Bloodmoon: Loadingg..")
            end
            if bmReqsLabel then
                local reqs = _G.BloodmoonReqs or ""
                bmReqsLabel:Set(reqs ~= "" and reqs or "Requirements: N/A")
            end
        end)
    end
end)
Toggle({ Section = ckdss, Title = "Auto Bloodmoon Twins (Fully)" }, "Auto Bloodmoon Twins")

local swords = Bosses:AddSection("Auto Get Swords")
Toggle({ Section = swords, Title = "Auto Triple Katana V2",         Value = Config["Auto Authentic Triple Katana V2"]    }, "Auto Authentic Triple Katana V2")
Toggle({Section = swords,Title = "Auto Kill Kioru V1",}, "Auto Kioru 1")
Toggle({Section = swords,Title = "Auto Kill Kioru V2",}, "Auto Kioru 2")
Toggle({ Section = swords, Title = "Auto Muramasa V2",      Value = Config["Auto Muramasa V2"]    }, "Auto Muramasa V2")

local busken = Bosses:AddSection("Auto Ability V2")

Toggle({ Section = busken, Title = "Auto Haki V2", Value = Config["Auto Buso V2 Fully"] }, "Auto Buso V2 Fully")
Toggle({ Section = busken, Title = "Auto Observation Haki V2",  Value = Config["Auto Ken V2 Fully"]  }, "Auto Ken V2 Fully")

local racing = Bosses:AddSection("Auto Race V1/V2")

Toggle({ Section = racing, Title = "Auto Race Shark V2", Value = Config["Auto Race Shark V2 Fully"] }, "Auto Race Shark V2 Fully")
Toggle({ Section = racing, Title = "Auto Race Mink V2",  Value = Config["Auto Race Mink V2 Fully"]  }, "Auto Race Mink V2 Fully")
Toggle({ Section = racing, Title = "Auto Race Skys V2",  Value = Config["Auto Race Skys V2 Fully"]  }, "Auto Race Skys V2 Fully")
Toggle({ Section = racing, Title = "Auto Race Human V2",         Value = Config["Auto Race Human V2"]        }, "Auto Race Human V2")
Toggle({ Section = racing, Title = "Auto Race Sea King V1",         Value = Config["Auto Race Sea King V1 Fully"] }, "Auto Race Sea King V1 Fully")
Toggle({ Section = racing, Title = "Auto Race Sea King V2", Value = Config["Auto Race Sea King V2 Fully"] }, "Auto Race Sea King V2 Fully")

local melees = Bosses:AddSection("Auto Fighting Style V2")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style Electro V2",
    Dis     = "If You Don't Have Mink V2 I make it",
    Value   = Config["Auto Combat Electro V2 Fully"]
}, "Auto Combat Electro V2 Fully")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style DarkLeg V2",
    Value   = Config["Auto Combat DarkLeg V2 Fully"]
}, "Auto Combat DarkLeg V2 Fully")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style WaterStyle V2",
    Value   = Config["Auto Combat WaterStyle V2 Fully"]
}, "Auto Combat WaterStyle V2 Fully")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style DragonClaw V2",
    Dis     = "Hard Work",
    Value   = Config["Auto Combat DragonClaw V2 Fully"]
}, "Auto Combat DragonClaw V2 Fully")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style Cyborg V2",
    Dis     = "Hard Work",
    Value   = Config["Auto Combat Cyborg V2 Fully"]
}, "Auto Combat Cyborg V2 Fully")

Toggle({
    Section = melees,
    Title   = "Auto Fighting Style Striker V1",
    Value   = Config["Auto Combat Striker V1"]
}, "Auto Combat Striker V1")

local access = Bosses:AddSection("Auto Get Accessories")

local NpcListName    = {}
local raidBossList   = require(game:GetService("ReplicatedStorage").Chest.Modules.RaidBossList)
local AccessoriesList = require(game:GetService("ReplicatedStorage").Chest.Modules.AccessoriesList)

local blacklist = {
    "Expert Swordman [Lv. 3000]",
    "King Samurai [Lv. 3500]",
    "Jack o lantern [Lv. 10000]",
    "Ms. Mother [Lv. 7500]",
    "Dragon [Lv. 5000]"
}

monsterPot["Bushido Ape [Lv. 5000]"] = CFrame.new(5069.79150390625, 387.6021728515625, 8792.142578125)

for bossId, bossData in pairs(raidBossList) do
    local levelStr = bossId:match("Lv. (%d+)")
    local level    = levelStr and tonumber(levelStr)

    if level and bossData.Drops then
        local droppedItems = {}

        for item in pairs(bossData.Drops) do
            if not table.find(blacklist, bossId) then
                if  (level >= 1    and level <= 2250 and Sea1)
                 or (level >= 2000 and level <= 4000 and Sea2)
                 or (level >= 4000 and Sea3)
                then
                    if AccessoriesList[item] then
                        table.insert(droppedItems, item)
                    end
                end
            end
        end

        if InRaid then
            for item in pairs(bossData.Drops) do
                if not table.find(blacklist, bossId) and AccessoriesList[item] then
                    table.insert(droppedItems, item)
                end
            end
        end

        if #droppedItems > 0 then
            local funName  = "Auto Get Accessories ( " .. table.concat(droppedItems, ", ") .. " )"
            local funName2 = funName

            Zenfunc[funName] = function()
                while Config[funName] and task.wait() do
                    local ok, err = pcall(function()
                        if Zenfunc["Entity"]["find"]({ bossId }) then
                            Zenfunc["Entity"]["attack"]({ bossId }, funName)
                        else
                            if monsterPot[bossId] then
                                tp({ Target = monsterPot[bossId] * CFrame.new(0, 30, 0) })
                            end
                            if Config[bossData.Name:gsub(" %[Lv. %d+%]", "") .. " Hop"] then
                                delay(4, function()
                                    if Zenfunc["Entity"]["find"]({ bossId }) then
                                        HopServer(true)
                                        delay(15, function() HopServer() end)
                                    end
                                end)
                            end
                        end
                    end)
                    if not ok then warn(err, ": " .. funName) end
                end
            end

            NpcListName[bossData.Name] = access:AddLabel(bossData.Name .. " : ".._G.redcircle)

            spawn(function()
                while task.wait(1) do
                    NpcListName[bossData.Name]:Set(
                        bossData.Name .. (Zenfunc["Entity"]["find"]({ bossId }) and " : ".._G.greencircle or " : ".._G.redcircle)
                    )
                end
            end)

            Toggle({
                Section = access,
                Title   = funName2,
                Dis     = "( " .. droppedItems[1] .. " )"
            }, funName)

            access:AddSeparator()
        end
    end
end


-- ==========================================
-- SEA EVENT TAB
-- ==========================================

local status = Seas:AddSection("Event Status")

if Sea3 then
    LegacyPose = status:CreateImage1({
        Title = "Legacy Pose",
        Dis   = "Time Spawn : 0:0:0",
        Image = 6886064327
    })
    local imageUrl = game:GetService("Lighting").Sky.MoonTextureId
    local assetId  = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
    MoodDis   = (assetId == "5250084176") and "Bloodmoon" or "Normal Moon"
    MoonImage = status:CreateImage1({
        Title = "Moon Texture",
        Dis   = MoodDis,
        Image = assetId
    })

elseif Sea2 then
status:AddSeparator({ Label = "🌊  Legacy Pose" })

    local imageUrl = "http://www.roblox.com/asset/?id=8620146789"
    local assetId  = string.match(imageUrl, "id=(%d+)") 
                  or string.match(imageUrl, "rbxassetid://(%d+)")

    LegacyPoseGS = status:CreateImage1({
        Title = "Ghost Ship",
        Dis   = "Time Spawn : 0:0:0",
        Image = assetId
    })

    local imageUrl = Players.LocalPlayer.PlayerGui.MainGui.StarterFrame.LegacyPoseFrame.SecondSea.SKImage.Image
    local assetId  = string.match(imageUrl, "id=(%d+)") or string.match(imageUrl, "rbxassetid://(%d+)")
    LegacyPose = status:CreateImage1({
        Title = "Legacy Pose — Hydra / Sea King Stats",
        Dis   = "Time Spawn : 0:0:0",
        Image = assetId
    })

	local seahop = Seas:AddSection("Server Hop Sea Monster")

	seahop:AddLabel("Best for afk sea monster farm, also set up your auto execute")

Dropdown({
    Section = seahop,
    Title = "Select Sea Monster to Hop",
    List = {
        getEntityDisplayName("SeaKing"),
        getEntityDisplayName("HydraSeaKing"),
        getEntityDisplayName("Ghost Ship"),
		getEntityDisplayName("Serpent"),
    },
    Multi = true,
    Value = Config.SelectedSeaMonsters or {}
}, function(selected)
    Config.SelectedSeaMonsters = selected
    print("Selected entities:", table.concat(selected, ", "))
    SaveSettings()
end, "SelectedSeaMonsters")

Slider({
    Section = seahop,
    Title   = "Hop Delay (seconds)",
    Min     = 1,
    Max     = 60,
    Value   = Config.HopDelay or 15
}, function(value)
    Config.HopDelay = value
    SaveSettings()
end, "HopDelay")


Toggle({
    Section = seahop,
    Title = "Auto Hop Until Found Sea Monster"
}, "auto_hop")

status:AddSeparator()

Toggle({ Section = status, Title = "Auto Kill Sea King"       }, "Auto Sea King")
Toggle({ Section = status, Title = "Auto Kill Hydra Sea King" }, "Auto Hydra Sea King")
Toggle({ Section = status, Title = "Auto Kill Ghost Ship"          }, "Auto Ghost Ship")
end

if Sea3 then

local seahop = Seas:AddSection("Server Hop")

Dropdown({
    Section = seahop,
    Title = "Select Sea Monster to Hop",
    List = {
        getEntityDisplayName("SeaDragon"),
        getEntityDisplayName("FuryTentacle"),
        getEntityDisplayName("ThirdSeaEldritch Crab"),
        getEntityDisplayName("ThirdSeaDragon"),
		getEntityDisplayName("Serpent"),
    },
    Multi = true,
    Value = Config.SelectedSeaMonsters or {}
}, function(selected)
    Config.SelectedSeaMonsters = selected
    print("Selected entities:", table.concat(selected, ", "))
    SaveSettings()
end, "SelectedSeaMonsters")

Slider({
    Section = seahop,
    Title   = "Hop Delay (seconds)",
    Min     = 1,
    Max     = 60,
    Value   = Config.HopDelay or 15
}, function(value)
    Config.HopDelay = value
    SaveSettings()
end, "HopDelay")


Toggle({
    Section = seahop,
    Title = "Auto Hop Until Found Sea Monster"
}, "auto_hop")

local seaMonsters = Seas:AddSection("Third Sea Monster")


local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local BossPairs = {
    {
        boss1 = {name = "SeaDragon", label = "Abyssal Tyrant", folder = "AbyssalTyrantKills"},
        boss2 = {name = "FuryTentacle", label = "Chaos Kraken", folder = "TentacleKills"},
    },
    {
        boss1 = {name = "ThirdSeaEldritch Crab", label = "Deepsea Crusher", folder = "CrabKills"},
        boss2 = {name = "ThirdSeaDragon", label = "Drakenfyr", folder = "3rdDragonKills"},
    }
}

local BossImages = {}

local function getBossData(folderName)
    local statFolder = playerGui
        .MainGui.StarterFrame.StatsFrame.ProfilePage
        .ScrollingFrame:WaitForChild(folderName)

    local iconObj = statFolder:WaitForChild("Icon")
    local killTextObj = statFolder:WaitForChild("DataText")

    local imageUrl = iconObj.Image
    local assetId  = string.match(imageUrl, "id=(%d+)")
                  or string.match(imageUrl, "rbxassetid://(%d+)")

    return assetId, killTextObj
end

local function cleanKills(text)
    local num = tostring(text):match("%d+")
    return num or text
end

for _, pair in ipairs(BossPairs) do

    local img1, killObj1 = getBossData(pair.boss1.folder)
    local img2, killObj2 = getBossData(pair.boss2.folder)

    local UI = seaMonsters:CreateImage({
        Name1 = pair.boss1.label,
        Dis1 = "Loading...",
        Image = img1,

        Name2 = pair.boss2.label,
        Dis2 = "Loading...",
        Image2 = img2
    })

    table.insert(BossImages, UI)

    -- UPDATE LOOP
    task.spawn(function()
        while task.wait(1) do

            local kills1 = cleanKills(killObj1.Text)
            local kills2 = cleanKills(killObj2.Text)

            local spawn1 = Zenfunc['Entity']['find']({pair.boss1.name})
            local spawn2 = Zenfunc['Entity']['find']({pair.boss2.name})

            local status1 = spawn1 and _G.greencircle.." Spawned" or _G.redcircle.." Not Spawned"
            local status2 = spawn2 and _G.greencircle.." Spawned" or _G.redcircle.." Not Spawned"

            UI:Set(
                pair.boss1.label,
                "Kills: "..kills1.."\n"..status1,

                pair.boss2.label,
                "Kills: "..kills2.."\n"..status2
            )
        end
    end)
end

Toggle({ Section = seaMonsters, Title = "Auto Kill Sea Monster Boss" }, "autothirdseabosses")
end

local serpent = Seas:AddSection("Auto Kill Sea Serpent")

local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local serpentFolder = playerGui.MainGui.StarterFrame.StatsFrame.ProfilePage.ScrollingFrame:WaitForChild("SerpentKills") 
local iconObj = serpentFolder:WaitForChild("Icon")
local killTextObj = serpentFolder:WaitForChild("DataText")

local imageUrl = iconObj.Image
local serpentId = string.match(imageUrl, "id=(%d+)")
               or string.match(imageUrl, "rbxassetid://(%d+)")

local function cleanKills(text)
    return tostring(text):match("%d+") or text
end

SerpentUI = serpent:CreateImage1({
    Title = "Sea Serpent",
    Dis = "Loading...",
    Image = serpentId
})

task.spawn(function()
    while task.wait(1) do

        local kills = cleanKills(killTextObj.Text)

        local statusText

        if Zenfunc['Entity']['find']({"Serpent"}) then
            statusText = _G.greencircle.." Found"

        elseif workspace.Effects:FindFirstChild('SerpentWhirlpool') then
            statusText = "🟡 Whirlpool"

        else
            statusText = _G.redcircle.." Not Found"
        end

        SerpentUI:Set(
            "Sea Serpent",
            "Kills: "..kills.."\nStatus: "..statusText
        )
    end
end)


Toggle({ Section = serpent, Title = "Auto Kill Serpent + Auto Hook" }, "Auto Serpent")
Toggle({ Section = serpent, Title = "Serpent (HOP)"     }, "Serpent Hop")

local galleonship = Seas:AddSection("Auto Kill Galleon Ship")

local Ships = {
    {
        Name = "Royal Galleon",
        Boss = "Royal Galleon Boss",
        Image = "rbxassetid://109432643283125"
    },
    {
        Name = "Whale Galleon",
        Boss = "Whale Galleon Boss",
        Image = "rbxassetid://98970065037129"
    },
    {
        Name = "Shark Galleon",
        Boss = "Shark Galleon Boss",
        Image = "rbxassetid://83535226871007"
    },
    {
        Name = "Kraken Galleon",
        Boss = "Kraken Galleon Boss",
        Image = "rbxassetid://131754051911823"
    },
    {
        Name = "Ghost Galleon",
        Boss = "Ghost Galleon Boss",
        Image = "rbxassetid://133344271549377"
    }
}

local UI = galleonship:CreateImage1({
    Title = "Galleon Ship", 
    Image = "131754051911823",
    Dis = "Checking..."
})

spawn(function()
    while task.wait(1) do
        local currentShip = nil

        for _, ship in pairs(Ships) do
            local found = Zenfunc['Entity']['find']({ship.Boss})
            if found then
                currentShip = ship
                break
            end
        end

        if currentShip then
            UI:UpdateImage(currentShip.Image)
            UI:UpdateDis(_G.greencircle.." " .. currentShip.Name)
        else
            for _, ship in pairs(Ships) do
                if ship.Name == "Kraken Galleon" then
                    UI:UpdateImage(ship.Image)
                    UI:UpdateDis(_G.redcircle.." No Ship Found")
                    break
                end
            end
        end
    end
end)

Toggle({ Section = galleonship, Title = "Auto Kill Galleon Ship Boss" }, "galleonshipboss")
Toggle({ Section = galleonship, Title = "Galleon Ship Boss (HOP)"     }, "Serpent Hop")

local statleft = statplayer:AddSection("Stats")

local SetPoint = 1
local MeleePoint, DefensePoint, SwordPoint, PowerFruitPoint = false, false, false, false

local pointsLabel = statleft:AddLabel("")
spawn(function()
    while task.wait() do
        pointsLabel:Set("Your Points: " .. tostring(game:GetService("Players").LocalPlayer.PlayerStats.Points.Value))
    end
end)

spawn(function()
    while task.wait() do
        if UpStast1 then
            for _, stat in ipairs({ "Melee", "Defense", "Sword", "Fruit" }) do
                if  (stat == "Melee"  and MeleePoint)
                 or (stat == "Defense" and DefensePoint)
                 or (stat == "Sword"  and SwordPoint)
                 or (stat == "Fruit"  and PowerFruitPoint)
                then
                    local args = { [1] = stat, [2] = SetPoint }
                    Client.PlayerGui.MainGui.StarterFrame.StatsFrame.RemoteEvent:FireServer(unpack(args))
                end
            end
        end
    end
end)

local StatsLabel = statleft:AddLabel("Loading stats...")

task.spawn(function()
    while task.wait(0.1) do
        local stats = game:GetService("Players").LocalPlayer.PlayerStats
        local text  = string.format(
            "Level: %s   |   Melee: %s   |   Defense: %s   |   Sword: %s   |   Devil Fruit: %s",
            tostring(stats.lvl.Value),
            tostring(stats.Melee.Value),
            tostring(stats.Defense.Value),
            tostring(stats.sword.Value),
            tostring(stats.DF.Value)
        )
        StatsLabel:Set(text)
    end
end)

statleft:AddToggle({
    Name     = "Melee",
    Default  = MeleePoint,
    Callback = function(enabled) MeleePoint = enabled end
})

statleft:AddToggle({
    Name     = "Defense",
    Default  = DefensePoint,
    Callback = function(enabled) DefensePoint = enabled end
})

statleft:AddToggle({
    Name     = "Sword",
    Default  = SwordPoint,
    Callback = function(enabled) SwordPoint = enabled end
})

statleft:AddToggle({
    Name     = "Devil Fruit",
    Default  = PowerFruitPoint,
    Callback = function(enabled) PowerFruitPoint = enabled end
})

local playercombat = statplayer:AddSection("Auto Bounty Player")

local Players = {}
for _, v in pairs(game.Players:GetChildren()) do
    if v.Name ~= Client.Name then
        table.insert(Players, v.Name)
    end
end

local PlayersList = Dropdown({
    Section = playercombat,
    Title   = "Select Player",
    List    = Players
}, "Select Player")

game.Players.PlayerAdded:Connect(function(player)
    Players = {}
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name ~= Client.Name then
            table.insert(Players, v.Name)
        end
    end
    PlayersList:Add(Players)
end)

game.Players.PlayerRemoving:Connect(function(player)
    Players = {}
    for _, v in pairs(game.Players:GetChildren()) do
        if v.Name ~= Client.Name then
            table.insert(Players, v.Name)
        end
    end
    PlayersList:Add(Players)
end)

Button({
    Section = playercombat,
    Title   = "Teleport to Player"
}, function()
    tp({ Target = game.Players:FindFirstChild(Config["Select Player"]).Character.HumanoidRootPart.CFrame })
    wait(0.2)
    _G.NeedNoClip = false
end)

Toggle({ Title = "Aim Bot Player Skills",   Section = playercombat }, "Aim Bot Skill Player")
Toggle({ Title = "Aim Bot FOV",             Section = playercombat }, "Aim Bot FOV")
Slider({ Section = playercombat, Title = "Aimbot FOV Radius", Min = 10, Max = 500 }, "Aim Bot FOV Radius")
Toggle({ Title = "Auto Farm Bounty Hunter", Section = playercombat }, "Auto Farm Bounty Hunter")
Toggle({ Title = "Safe Mode (TP above at 50% HP)", Section = playercombat, Value = Config['Safe Mode'] }, function(v)
    Config['Safe Mode'] = v
    SaveSettings()
end)

-- ==========================================
-- AIMBOT / BOUNTY LOGIC
-- ==========================================

-- FOV circle indicator
local AimFovGui = Instance.new("ScreenGui")
AimFovGui.Name = "ZenAimFOV"
AimFovGui.ResetOnSpawn = false
AimFovGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
AimFovGui.Parent = game:GetService("CoreGui")
local AimFovFrame = Instance.new("Frame")
AimFovFrame.Name = "FOVCircle"
AimFovFrame.BackgroundTransparency = 1
AimFovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
AimFovFrame.Position = UDim2.fromScale(0.5, 0.5)
AimFovFrame.Size = UDim2.fromOffset(200, 200)
AimFovFrame.ZIndex = 100
AimFovFrame.Parent = AimFovGui
local AimFovStroke = Instance.new("UIStroke")
AimFovStroke.Color = Color3.fromRGB(255, 60, 60)
AimFovStroke.Thickness = 1.5
AimFovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
AimFovStroke.Parent = AimFovFrame
local AimFovCorner = Instance.new("UICorner")
AimFovCorner.CornerRadius = UDim.new(1, 0)
AimFovCorner.Parent = AimFovFrame
AimFovFrame.Visible = false

-- Update FOV circle visibility & size from config
task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            local showFov = Config['Aim Bot FOV']
            AimFovFrame.Visible = showFov == true
            if showFov then
                local r = math.max(10, Config['Aim Bot FOV Radius'] or 150)
                AimFovFrame.Size = UDim2.fromOffset(r * 2, r * 2)
            end
        end)
    end
end)

-- Helper: find the closest in-FOV player target
local function getAimbotTarget()
    local camera = workspace.CurrentCamera
    local fovR   = Config['Aim Bot FOV Radius'] or 150
    local bestPlayer, bestDist = nil, math.huge
    local selName = Config['Select Player']
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= Client then
            local useThisPlayer = (selName == nil or selName == "" or plr.Name == selName)
            if useThisPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                local hrp = plr.Character.HumanoidRootPart
                local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                    local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    if dist2D < fovR and dist2D < bestDist then
                        bestDist   = dist2D
                        bestPlayer = plr
                    end
                end
            end
        end
    end
    return bestPlayer
end

-- Aimbot Player Skills: spam skills at nearest player in FOV
task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            if not Config['Aim Bot Skill Player'] then return end
            local target = getAimbotTarget()
            if not target or not target.Character then return end
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            -- aim camera toward target
            workspace.CurrentCamera.CFrame = CFrame.new(
                Client.Character.HumanoidRootPart.Position,
                hrp.Position
            )
            getgenv().PosMonSkill = hrp.CFrame
            useSkill()
            Attack()
        end)
    end
end)

-- Auto Farm Bounty Hunter: continuously attack selected player, spam all-for-one weapon
Zenfunc['Auto Farm Bounty Hunter'] = function()
    local fetch = 'Auto Farm Bounty Hunter'
    while Config[fetch] and task.wait() do
        Zenfunc['getPcall'](fetch, function()
            local selName = Config['Select Player']
            if not selName or selName == '' then return end
            local targetPlr = game.Players:FindFirstChild(selName)
            if not targetPlr or not targetPlr.Character then return end
            local tChar = targetPlr.Character
            local tHrp  = tChar:FindFirstChild('HumanoidRootPart')
            local tHum  = tChar:FindFirstChild('Humanoid')
            if not tHrp or not tHum or tHum.Health <= 0 then return end
            -- Safe Mode: if own HP <= 50% teleport high above target
            local myHp = Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth * 100
            if Config['Safe Mode'] and myHp <= 50 then
                tp({ Target = tHrp.CFrame * CFrame.new(0, 200, 0) })
                repeat task.wait()
                    myHp = Client.Character.Humanoid.Health / Client.Character.Humanoid.MaxHealth * 100
                until not Config[fetch] or myHp > (Config['Select You HP Max (%)'] or 75)
                return
            end
            -- Teleport to target with standmethod offset
            tp({ Target = tHrp.CFrame * (Config['standmethod'] or CFrame.new(0, 8.5, 0.15)) })
            -- Spam all weapons (All for One style)
            getgenv().PosMonSkill = tHrp.CFrame
            -- Use skills
            if Config['Auto Use Skill'] then
                for _, sk in next, Config['Select Skill'] do
                    if type(sk) == 'string' and not Item.CheckOnCooldown(sk) and not Item.CheckSkillLock(sk) then
                        game:service('VirtualInputManager'):SendKeyEvent(true, sk, false, game)
                        game:service('VirtualInputManager'):SendKeyEvent(false, sk, false, game)
                    end
                end
            end
            -- Attack with all weapons (All for One)
            if myWeapon['Melee'] and myWeapon['Melee'] ~= '' then
                Repli.Chest.Remotes.Functions.SkillAction:InvokeServer('FS_'..myWeapon['Melee']..'_M1')
            end
            if myWeapon['Sword'] and myWeapon['Sword'] ~= '' then
                Repli.Chest.Remotes.Functions.SkillAction:InvokeServer('SW_'..myWeapon['Sword']..'_M1')
            end
            if myWeapon['Fruit'] and myWeapon['Fruit'] ~= '' then
                Repli.Chest.Remotes.Functions.SkillAction:InvokeServer('DF_'..myWeapon['Fruit']..'_M1')
            end
            -- Update bounty label
            _G.LabelAutoFarm = 'Bounty: ' .. selName
            _G.LabelHealth   = 'Target HP: ' .. math.floor((tHum.Health / tHum.MaxHealth) * 100) .. '%'
        end)
    end
end


-- ==========================================
-- TRAVEL SEAS TAB
-- ==========================================

local tpsea = Travelsea:AddSection("Teleport Sea")

Button({ Title = "Teleport To Sea 1", Section = tpsea }, function()
local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "FirstSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
Event:InvokeServer(A_1, A_2)
end)

Button({ Title = "Teleport To Sea 2", Section = tpsea }, function()
local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "SecondSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
Event:InvokeServer(A_1, A_2)
end)

Button({ Title = "Teleport To Sea 3", Section = tpsea }, function()
local A_1 = "TeleportSea"
local A_2 = 
{
	["SeaName"] = "ThirdSea"
}
local Event = game:GetService("ReplicatedStorage").Chest.Remotes.Functions.EtcFunction
Event:InvokeServer(A_1, A_2)
end)


tpsea:AddSeparator({ Label = "Teleport" })

if Sea1 or Sea2 then
    for i, v in pairs(workspace.Island:GetChildren()) do
        if v:IsA("Model") then
            if string.split(v.Name, " - ")[2] then
                Button({ Title = string.split(v.Name, " - ")[2], Section = tpsea }, function()
                    tp({ Target = v:GetModelCFrame() })
                    wait(0.2)
                    _G.NeedNoClip = false
                end)
            else
                if not v.Name:find(" - ") then
                    Button({ Title = v.Name, Section = tpsea }, function()
                        tp({ Target = v:GetModelCFrame() })
                        wait(0.2)
                        _G.NeedNoClip = false
                    end)
                end
            end
        end
    end
else
    if Sea3 then
        for i, v in pairs(workspace.Island:GetChildren()) do
            if v:IsA("Model") then
                Button({ Title = v.Name, Section = tpsea }, function()
                    tp({ Target = v:GetModelCFrame() })
                    wait(0.2)
                    _G.NeedNoClip = false
                end)
            end
        end
    end
end

tpsea:AddSeparator({ Label = "Npc Teleport" })

local NPCList = {}
for i, v in pairs(game:GetService("Workspace").AllNPC:GetChildren()) do
    table.insert(NPCList, v.Name)
end
if Colossuem then
    NPCList = { "" }
end

local SelectedNpc = nil

local ListNpc = tpsea:AddDropdown({
    Name     = "Select NPC",
    Option   = NPCList,
    Default  = "",
    Callback = function(selnpcf)
        SelectedNpc = selnpcf
    end
})

function tp1(cframe)
    local player = game.Players.LocalPlayer
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        warn("Player's character or HumanoidRootPart not found!")
        return
    end
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    humanoidRootPart.CFrame = cframe
end


tpsea:AddButton({
    Name     = "Teleport To NPC",
    Callback = function()
        for _, v in pairs(game:GetService("Workspace").AllNPC:GetChildren()) do
            if SelectedNpc == v.Name then
                tp1(v.CFrame)
            end
        end
    end
})

tpsea:AddButton({
    Name     = "Refresh Npc",
    Callback = function()
        local newNPCList = {}
        for _, v in pairs(game:GetService("Workspace").AllNPC:GetChildren()) do
            table.insert(newNPCList, v.Name)
        end
        ListNpc:Add(newNPCList)
    end
})


-- ==========================================
-- SHOPS TAB
-- ==========================================

local shopping = Store:AddSection("Shop")

shopping:AddSeparator({ Label = "Fighting Style" })

Button({ Title = "Buy Dragon Claw", Section = shopping }, function()
    local OldPos = Client.Character.HumanoidRootPart.CFrame
    for i = 1, 30 do wait()
        getQuestOld(workspace.AllNPC.DragonClawShop.CFrame)
    end
    tp({ Target = OldPos })
    wait(0.2)
    _G.NeedNoClip = false
end)

Button({ Title = "Buy Water Style", Section = shopping }, function()
    local OldPos = Client.Character.HumanoidRootPart.CFrame
    for i = 1, 30 do wait()
        getQuestOld(workspace.AllNPC.WaterStyleShop.CFrame)
    end
    tp({ Target = OldPos })
    wait(0.2)
    _G.NeedNoClip = false
end)

Button({ Title = "Buy Cyborg", Section = shopping }, function()
    if not Sea2 and Client.PlayerStats.lvl.Value >= 2250 and Sea3 then
        for i = 1, 500 do wait()
            getQuestOld(FF["Teleport To Sea 2"], 2)
        end
    else
        local OldPos = Client.Character.HumanoidRootPart.CFrame
        for i = 1, 50 do wait()
            getQuestOld(workspace.AllNPC.CyborgShop.CFrame)
        end
        tp({ Target = OldPos })
        wait(0.2)
        _G.NeedNoClip = false
    end
end)

Button({ Title = "Buy Dark Leg", Section = shopping }, function()
    local OldPos = Client.Character.HumanoidRootPart.CFrame
    for i = 1, 50 do wait()
        getQuestOld(workspace.AllNPC.DarkLegShop.CFrame)
    end
    tp({ Target = OldPos })
    wait(0.2)
    _G.NeedNoClip = false
end)

Button({ Title = "Buy Electro", Section = shopping }, function()
    if not Sea2 and Client.PlayerStats.lvl.Value >= 2250 and Sea1 then
        for i = 1, 500 do wait()
            getQuestOld(FF["Teleport To Sea 2"], 2)
        end
    else
        local OldPos = Client.Character.HumanoidRootPart.CFrame
        for i = 1, 50 do wait()
            getQuestOld(workspace.AllNPC.ElectroShop.CFrame)
        end
        tp({ Target = OldPos })
        wait(0.2)
        _G.NeedNoClip = false
    end
end)

shopping:AddSeparator({ Label = "Buy Key" })

Dropdown({
    Section = shopping,
    Title   = "Select Key",
    List    = { "Copper Key", "Iron Key", "Gold Key" }
}, "Select Key For Random")

Button({ Title = "Buy Key",    Section = shopping }, function()
    game:GetService("ReplicatedStorage").Chest.Remotes.Functions.BuyKey:InvokeServer(Config["Select Key For Random"], Config["Select Buy Key"])
end)

Button({ Title = "Use Key x1",  Section = shopping }, function()
    game:GetService("ReplicatedStorage").Chest.Remotes.Functions.UseKey:InvokeServer(Config["Select Key For Random"], "Open1")
end)

Button({ Title = "Use Key x10", Section = shopping }, function()
    game:GetService("ReplicatedStorage").Chest.Remotes.Functions.UseKey:InvokeServer(Config["Select Key For Random"], "Open10")
end)

Slider({
    Section = shopping,
    Title   = "Select Key to Buy",
    Max     = 10,
    Min     = 1,
}, "Select Key to Buy")

Toggle({ Section = shopping, Title = "Auto Store Fruit"     }, "Auto Bring Fruits")
Toggle({ Section = shopping, Title = "Auto Collect Fruit"   }, "Auto Store Fruit")
Toggle({ Section = shopping, Title = "Drop if already have" }, "Drop if have")

shopping:AddSeparator({ Label = "Buy Fruit in Shop" })

Dropdown({
    Section = shopping,
    Title   = "Select Fruit Stock",
    List    = DFLits
}, "Select Fruit Stock")

Button({ Title = "Buy Stored Fruit", Section = shopping }, function()
    game:GetService("ReplicatedStorage").Chest.Remotes.Functions.BuyFruitStock:InvokeServer(Config["Select Fruit Stock"])
end)

Toggle({ Section = shopping, Title = "Auto Eat Fruit" }, "Auto Eat Fruit")

shopping:AddSeparator({ Label = "Skill Teacher" })

Button({ Title = "Buy Observation (Ken)", Section = shopping }, function()
    local OldPos = Client.Character.HumanoidRootPart.CFrame
    for i = 1, 50 do wait()
        getQuestOld(workspace.AllNPC.KenShop.CFrame)
    end
    tp({ Target = OldPos })
    wait(0.2)
    _G.NeedNoClip = false
end)

Button({ Title = "Buy Buso (Haki)", Section = shopping }, function()
    local OldPos = Client.Character.HumanoidRootPart.CFrame
    for i = 1, 50 do wait()
        getQuestOld(workspace.AllNPC.BusoShop.CFrame)
    end
    tp({ Target = OldPos })
    wait(0.2)
    _G.NeedNoClip = false
end)

shopping:AddSeparator({ Label = "Fruit Shop" })

t["GetDFShop"] = shopping:AddLabel("Fruit Shop")

local ShopTable = {}
if workspace:FindFirstChild("AllNPC"):FindFirstChild("SwordShop") then
    for i, v in pairs(workspace:FindFirstChild("AllNPC"):GetChildren()) do
        if v.Name == "SwordShop" and v:FindFirstChild("Setting") then
            if not ShopTable[v:FindFirstChild("Setting").NameWeapon.Value] then
                ShopTable[v:FindFirstChild("Setting").NameWeapon.Value] = "add"
                Button({ Title = "Buy " .. v:FindFirstChild("Setting").NameWeapon.Value, Section = shopping }, function()
                    local OldPos = Client.Character.HumanoidRootPart.CFrame
                    for i = 1, 50 do wait()
                        getQuestOld(v.CFrame)
                    end
                    tp({ Target = OldPos })
                    wait(0.2)
                    _G.NeedNoClip = false
                end)
            end
        end
    end

    for i, v in pairs(game:GetService("ReplicatedStorage"):FindFirstChild("NPC"):GetChildren()) do
        if v.Name == "SwordShop" and v:FindFirstChild("Setting") then
            if not ShopTable[v:FindFirstChild("Setting").NameWeapon.Value] then
                ShopTable[v:FindFirstChild("Setting").NameWeapon.Value] = "add"
                Button({ Title = "Buy " .. v:FindFirstChild("Setting").NameWeapon.Value, Section = shopping }, function()
                    local OldPos = Client.Character.HumanoidRootPart.CFrame
                    for i = 1, 50 do wait()
                        getQuestOld(v.HumanoidRootPart.CFrame)
                    end
                    tp({ Target = OldPos })
                    wait(0.2)
                    _G.NeedNoClip = false
                end)
            end
        end
    end
end


-- ==========================================
-- DUNGEON TAB
-- ==========================================

local dunegeuns = Raids:AddSection("Auto Dungeon")

dunegeuns:AddSeparator({ Label = "[ Auto Dungeon ]" })

if InRaid then
    t["Rejoin The Dungeon"]   = dunegeuns:AddLabel("Wave: 1")
    t["Need Kill The Dungeon"] = dunegeuns:addLabel("Enemies Left : 1")
else
    dunegeuns:AddLabel("Entering New Dungeon!!")
end

Dropdown({
    Section = dunegeuns,
    Title   = "Select Difficulty",
    List    = { "Easy", "Normal", "Hard" }
}, "Select Difficulty")

Dropdown({
    Section = dunegeuns,
    Title   = "Select Type Mode",
    List    = { "Magma", "Normal" }
}, "Select Type Mode")

Toggle({
    Section = dunegeuns,
    Title   = "Auto Clear Dungeon",
    Value   = Config["Auto Clear Dungeon"]
}, "Auto Clear Dungeon")

Toggle({
    Section = dunegeuns,
    Title   = "Auto Enter New Dungeon",
    Value   = Config["Auto Rejoin Dungeon"]
}, "Auto Rejoin Dungeon")

dunegeuns:AddSeparator({ Label = "[ Auto New Dungeon ]" })

local CHECKDUNGEON = dunegeuns:AddLabel("Dungeon Opens In")

Toggle({
    Section = dunegeuns,
    Title   = "Auto Clear New Dungeon",
    Value   = Config["Auto New Clear Dungeon"]
}, "Auto New Clear Dungeon")

Toggle({
    Section = dunegeuns,
    Title   = "Auto Enter New Dungeon",
    Value   = Config["Auto Rejoin New Dungeon"]
}, "Auto Rejoin Dungeon")

spawn(function()
    while wait() do
        pcall(function()
            if workspace.Dungeon.BillboardGui.Time.Text:find("Dungeon will end") then
                CHECKDUNGEON:Set("Dungeon Opens In")
            else
                CHECKDUNGEON:Set("Dungeon Is Close")
            end
        end)
    end
end)


local Hakistage = Misc:AddSection("Haki Stage")

Dropdown({
    Section = Hakistage,
    Title = "Select Haki Stage",
    List = {
        "Stage 1",
        "Stage 2",
        "Stage 3",
        "Stage 4",
        "Stage 5",
        "Stage 6"
    },
    Value = Config.HakiStage or "Stage 1"
}, function(v)
    local stage = tonumber(v:match("%d+")) or 1
    Config.HakiStage = v
    Config.HakiStageNumber = stage
    SaveSettings()
end, "HakiStage")

Button({
    Section = Hakistage,
    Title = "Apply Haki Stage"
}, function()
    local stage = Config.HakiStageNumber or 1

    local args = {
        {
            Type = "SelectArmamentLevel",
            Level = stage
        }
    }

    game:GetService("ReplicatedStorage")
        :WaitForChild("Chest")
        :WaitForChild("Remotes")
        :WaitForChild("Events")
        :WaitForChild("EtcEvent")
        :FireServer(unpack(args))
end)


local HakiColor = Misc:AddSection("Haki Color")

Dropdown({
    Section = HakiColor,
    Title = "Select Haki Color",
    List = {
        "White",
        "Lime",
        "Green",
        "Yellow",
        "Carmine",
        "Fuchsia",
        "Ultramarine",
        "Azure",
        "Apricot",
        "Indigo",
        "Arc"
    },
    Value = Config.HakiColor or "White"
}, function(v)
    Config.HakiColor = v
    SaveSettings()
end, "HakiColor")

Button({
    Section = HakiColor,
    Title = "Apply Haki Color"
}, function()
    local color = Config.HakiColor or "White"

    local args = { color }

    game:GetService("ReplicatedStorage")
        :WaitForChild("Chest")
        :WaitForChild("Remotes")
        :WaitForChild("Functions")
        :WaitForChild("ArmamentColorEquip")
        :InvokeServer(unpack(args))
end)

-- ==========================================
-- MISC TAB
-- ==========================================

local miscko = Misc:AddSection("Misc")

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local placeId = game.PlaceId

miscko:Textbox("Join Server (Join Zen Hub Discord!)", "Enter ZenHub_JobId", function(joinCode)
    if typeof(joinCode) ~= "string" then return end

    joinCode = joinCode:gsub("%s+", "") -- remove spaces

    -- Check format
    if string.sub(joinCode, 1, 7) ~= "ZenHub_" then
        warn("Invalid format! Use: ZenHub_XXXXXXXX")
        return
    end

    -- Extract JobId
    local jobId = string.sub(joinCode, 8)

    if not jobId or jobId == "" then
        warn("Job ID is empty.")
        return
    end

    -- Teleport
    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, jobId, LocalPlayer)
    end)

    if success then
        print("✅ Teleporting to:", jobId)
    else
        warn("❌ Teleport failed:", err)
    end
end)

local BypassScWalkJump = task.spawn(function()
    Client.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("JumpPower"):Connect(function()
        if Config["Set Jump"] then
            Client.Character:FindFirstChild("Humanoid").JumpPower = Config["Set Jump Power"]
        end
    end)
    Client.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if Config["Set Walk"] then
            Client.Character:FindFirstChild("Humanoid").WalkSpeed = Config["Set Walk Speed"]
        end
    end)
end)

spawn(function()
    while wait(1) do
        pcall(function()
            if Config["Set Jump"] then
                Client.Character:FindFirstChild("Humanoid").JumpPower = Config["Set Jump Power"]
            end
            if Config["Set Walk"] then
                Client.Character:FindFirstChild("Humanoid").WalkSpeed = Config["Set Walk Speed"]
            end
        end)
    end
end)

Slider({ Section = miscko, Title = "Walk Speed",  Max = 300, Min = 16 }, "Set Walk Speed")
Toggle({ Section = miscko, Title = "Set Walk Speed"                    }, "Set Walk")
Slider({ Section = miscko, Title = "Jump Power",  Max = 300, Min = 16 }, "Set Jump Power")
Toggle({ Section = miscko, Title = "Set Jump Power"                    }, "Set Jump")

miscko:AddSeparator()

	Toggle({
		Section = miscko,
		Title = "Normal Notifications",
	}, "UseNotiBF")
	Toggle({
		Section = miscko,
		Title = "Hide Notifications",
		Value = Config['Hide Notify']
	}, function(v)
		Config['Hide Notify'] = v
		game:GetService("Players").LocalPlayer.PlayerGui.Popup.Enabled = not v
		SaveSettings()
	end)

Toggle({ Section = miscko, Title = "Walk on Water"                     }, "Walk On Water")
Toggle({ Section = miscko, Title = "Noclip (Walk through walls)"       }, "Noclip Toggle")
Toggle({ Section = miscko, Title = "Remove Fog"                        }, "Romove Fog")
Toggle({ Section = miscko, Title = "Set Day Time"                      }, "daytimd")
Button({ Title = "Redeem All Code", Section = miscko }, function()
    for _, Code in pairs({
        "Serpent10", "FreePterSpin", "SKGames", "RainbowDragon",
        "DragonColorRefund", "WELCOMETOKINGLEGACY", "<3LEEPUNGG",
        "FREESTATSRESET", "2MFAV", "Peodiz", "DinoxLive"
    }) do
        wait(0.5)
        Windown.Notify("success", { text = "Redeem : " .. Code, time = 3 })
        game:GetService("ReplicatedStorage").Chest.Remotes.Functions.redeemcode:InvokeServer(Code)
    end
end)
Button({
    Section = miscko,
    Title   = "Fix Walk/Jump Bug"
}, function()
    task.cancel(BypassScWalkJump)
    BypassScWalkJump = nil
    BypassScWalkJump = task.spawn(function()
        Client.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("JumpPower"):Connect(function()
            if Config["Set Jump"] then
                Client.Character:FindFirstChild("Humanoid").JumpPower = Config["Set Jump Power"]
            end
        end)
        Client.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if Config["Set Walk"] then
                Client.Character:FindFirstChild("Humanoid").WalkSpeed = Config["Set Walk Speed"]
            end
        end)
    end)
end)

local jobSection = Misc:AddSection("Job Id")

Button({ Section = miscko, Title = "Server Hop"             }, function() HopServer()     end)
Button({ Section = miscko, Title = "Server Hop (Low Players)" }, function() HopServer(true) end)

Button({
    Section = miscko,
    Title   = "Rejoin Game"
}, function()
    local TeleportService = game:GetService("TeleportService")
    local Players         = game:GetService("Players")
    local player          = Players.LocalPlayer
    if player then
        TeleportService:Teleport(game.PlaceId, player)
    end
end)

getTextoforLabel();
do 
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt,false)
	mt.__namecall = function(...)
		local args = {...}
		local method = getnamecallmethod()
		if method == "InvokeServer" then
			if tostring(args[1]) == "SkillAction" then
				if getgenv().PosMonSkill then
					if not args[3] then
						return old(...)
					end
					if args[3].Type == "Up" or args[3].Type == "Down" then
						args[3].MouseHit = getgenv().PosMonSkill
						return old(unpack(args))
					end
				end
			end
		end
		return old(...)
	end
end
if not Client.PlayerGui.Backpack.Enabled then
	Client.Character.Humanoid.Health = 0
end