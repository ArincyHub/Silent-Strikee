local Library = loadstring(game:HttpGet('https://pastefy.app/50VL9o2U/raw'))()
local gameName = game:GetService('MarketplaceService'):GetProductInfo(game.PlaceId).Name
local window = Library.new('Zen Hub -' .. "<font color='rgb(127, 255, 212)'> " .. gameName .. ' </font>', 'SlimeRNGConfigs')

window:SetToggleKey(Enum.KeyCode.RightControl)
window:Notify({
    Title = 'Zen Hub Loaded',
    Description = 'Loaded successfully!',
    Duration = 3,
    Icon = 'rbxassetid://10709775704',
})

local existingGui = game:GetService('CoreGui'):FindFirstChild('Alc')

if existingGui then
    existingGui:Destroy()
end