local Library = loadstring(game:HttpGet('https://pastefy.app/8h0lIBDj/raw', true))()
local MarketplaceService = game:GetService('MarketplaceService')
local gameName = 'Unknown'

pcall(function()
    local info = MarketplaceService:GetProductInfo(game.PlaceId)

    gameName = info.Name
end)

local LibWindow = Library:Window({
    Title = 'Zen Hub',
    SubTitle = gameName,
    WelcomeTitle = 'Zen Hub',
    Developer = {
        Name = 'jay0050[KaiZen]',
        Role = 'Script Developer',
        Avatar = 12345678,
    },
    SecondOwner = {
        Name = 'Co-Dev [Npg]',
        Role = 'UI/Helper Dev',
        Avatar = 12345678,
    },
})

local Status = LibWindow:NewPage({
    Title = 'Info & Server',
    Desc = 'Status & Info',
    Icon = 7040410130,
})

local EasterEvent = LibWindow:NewPage({
    Title = 'Easter Event',
    Desc = 'auto collect egg, auto buy stocks',
    Icon = 79775211258613,
})

local Farm = LibWindow:NewPage({
    Title = 'Tab Farming',
    Desc = 'Auto Farm',
    Icon = 127561653320876,
})
local Others = LibWindow:NewPage({
    Title = 'Stack Farm',
    Desc = 'Stack Features',
    Icon = 10723405360,
})
local Maestry = LibWindow:NewPage({
    Title = 'Farm Mastery',
    Desc = 'Mastery Farm',
    Icon = 10709782497,
})
local Event = LibWindow:NewPage({
    Title = 'Sea Event',
    Desc = 'Sea Events',
    Icon = 10709783577,
})
local Race = LibWindow:NewPage({
    Title = 'Upgrade V4',
    Desc = 'Race & V4',
    Icon = 115164375298022,
})
local Dojo = LibWindow:NewPage({
    Title = 'Dojo & Drago Race',
    Desc = 'Dojo Features',
    Icon = 91920478152016,
})
local Get = LibWindow:NewPage({
    Title = 'Get Item & Upgrade',
    Desc = 'Items & Upgrades',
    Icon = 13075622619,
})
local Fruit = LibWindow:NewPage({
    Title = 'Raid & Fruit',
    Desc = 'Raid & Fruits',
    Icon = 11155986081,
})
local Player = LibWindow:NewPage({
    Title = 'Local Player',
    Desc = 'Player Options',
    Icon = 13075651575,
})
local Shop = LibWindow:NewPage({
    Title = 'Local Shop',
    Desc = 'Shop',
    Icon = 6031265976,
})
local Esp = LibWindow:NewPage({
    Title = 'Stats & ESP',
    Desc = 'ESP Features',
    Icon = 11155851001,
})
local Teleport = LibWindow:NewPage({
    Title = 'Tab Teleport',
    Desc = 'Teleports',
    Icon = 10734886004,
})
local Setting = LibWindow:NewPage({
    Title = 'Setting & UI',
    Desc = 'Settings',
    Icon = 7734053495,
})


local function GetStockList()
    local list = {}
    local store = game:GetService("ReplicatedStorage").Remotes.Celebration:InvokeServer("GetStore")

    local function scan(tbl)
        for _, item in pairs(tbl) do
            if type(item) == "table" then
                -- check if it's an item
                if item.Key then
                    print("FOUND:", item.Key) -- debug
                    table.insert(list, item.Key)
                end

                -- go deeper
                scan(item)
            end
        end
    end

    scan(store)

    return list
end

EasterEvent:Toggle({
    Title = 'Auto Collect Egg',
    Desc = 'auto tween to egg',
    Value = false,
    Callback = function(v)
        collect = v
    end,
})

EasterEvent:Toggle({
    Title = 'Infinite EGG [PATCHED]',
    Desc = 'inf egg',
    Value = false,
    Callback = function(v)
        inf = v
    end,
})

EasterEvent:Section('Easter Shop')

local SelectedStock = nil

local list = GetStockList()

local StockDropdown = EasterEvent:Dropdown({
    Title = 'Select Stock',
    Desc = 'select item',
    List = (#list > 0 and list) or {"No Items"},
    Value = list[1],
    Callback = function(v)
        SelectedStock = v
    end,
})

EasterEvent:Button({
    Title = 'Refresh Stock',
    Callback = function()
        local newList = GetStockList()

        print("NEW LIST:", #newList)

        if #newList > 0 then
            StockDropdown:Refresh(newList, true)
        else
            warn("Still empty!")
        end
    end,
})

EasterEvent:Button({
    Title = 'Buy Selected',
    Desc = 'buy selected stock',
    Callback = function()
        if SelectedStock then
            game:GetService("ReplicatedStorage").Remotes.Celebration:InvokeServer(
                "Purchase",
                SelectedStock
            )
        else
            warn("No stock selected")
        end
    end,
})
local AutoBuy = false

EasterEvent:Toggle({
    Title = 'Auto Buy',
    Desc = 'auto buy selected stock',
    Value = false,
    Callback = function(v)
        AutoBuy = v

        task.spawn(function()
            while AutoBuy do
                task.wait(2)

                local store = game:GetService("ReplicatedStorage").Remotes.Celebration:InvokeServer("GetStore")

                for _, item in pairs(store) do
                    if type(item) == "table" and item.Key then
                        if item.Key == SelectedStock then
                            print("Buying:", item.Key)

                            game:GetService("ReplicatedStorage").Remotes.Celebration:InvokeServer(
                                "Purchase",
                                item.Key
                            )
                        end
                    end
                end
            end
        end)
    end,
})