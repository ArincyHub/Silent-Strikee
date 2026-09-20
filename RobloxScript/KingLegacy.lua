CreateToggle(this will be tab name, "name", false, 2, function(v)
    print("[ZenHub] Auto Mine:", v) 
end)

Tab:AddToggle({
    Name = "Auto Farm Level",
    Description = "Farm Level",
    Default = false,
    Callback = function(state)
        _G.AutoFarm = state
        StopTween(_G.AutoFarm)
    end
})
