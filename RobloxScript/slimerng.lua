-- SlimeRNG OP Testing Module
-- Usage: _G.SlimeOP.<functionName>()
-- Run _G.SlimeOP.help() to list all available functions

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Vide = require(ReplicatedStorage.Packages.Vide)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local SettingsServiceClient = require(ReplicatedStorage.Source.Features.Settings.SettingsServiceClient)
local GoopGunServiceUtils = require(ReplicatedStorage.Source.Features.GoopGun.GoopGunServiceUtils)
local SpecialDiceServiceUtils = require(ReplicatedStorage.Source.Features.SpecialDice.SpecialDiceServiceUtils)
local GameplayServiceClient = require(ReplicatedStorage.Source.Features.Gameplay.GameplayServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)

_G.SlimeOP = {}

local _rapidRollActive = false
local _autoFireActive = false
local _origFireRate = nil
local _origRange = nil
local _origDamage = nil
local _origOwnsUpgrade = nil
local _origNormalizeQueue = nil
local _origApplyToRollResults = nil

-- ============================================================
-- SECTION 1: Roll / Luck Features
-- ============================================================

-- 1. Max Luck Override
function _G.SlimeOP.setMaxLuck(value)
	value = value or 999999
	SettingsServiceClient:set("luckOverrideEnabled", true)
	SettingsServiceClient:set("luckOverrideValue", value)
	print("[SlimeOP] Luck override set to:", value)
end

-- 2. Disable Luck Override
function _G.SlimeOP.resetLuck()
	SettingsServiceClient:set("luckOverrideEnabled", false)
	print("[SlimeOP] Luck override disabled")
end

-- 3. Force All Special Rolls Active (galaxy, void, diamond, golden)
function _G.SlimeOP.forceAllSpecialRolls()
	RollSlice.activeSpecialRolls({ galaxy = true, void = true, diamond = true, golden = true })
	print("[SlimeOP] All special rolls forced active")
end

-- 4. Clear Special Rolls
function _G.SlimeOP.clearSpecialRolls()
	RollSlice.activeSpecialRolls({})
	print("[SlimeOP] Special rolls cleared")
end

-- 5. Set Roll Speed (lower = faster, default game value is 3)
function _G.SlimeOP.setRollSpeed(time)
	time = time or 0.05
	RollSlice.rollTime(time)
	RollSlice.rollSpeed(time)
	print("[SlimeOP] Roll time set to:", time)
end

-- 6. Reset Roll Speed to default
function _G.SlimeOP.resetRollSpeed()
	RollSlice.rollTime(3)
	RollSlice.rollSpeed(3)
	print("[SlimeOP] Roll speed reset to default (3)")
end

-- 7. Trigger Luck Rain with custom multiplier
function _G.SlimeOP.triggerLuckRain(multiplier)
	multiplier = multiplier or 999
	RollSlice.luckRainMultiplier(multiplier)
	RollSlice.actions.triggerLuckRain(multiplier)
	print("[SlimeOP] Luck rain triggered with multiplier:", multiplier)
end

-- 8. Instant Roll Reveal (skips roll animation)
function _G.SlimeOP.instantReveal()
	RollSlice.actions.setInstantRevealRoll(true)
	print("[SlimeOP] Instant reveal enabled")
end

-- 9. Skip and clear all cutscene / jackpot screens
function _G.SlimeOP.skipAllScreens()
	RollSlice.actions.clearRareRollCutscene()
	RollSlice.actions.clearJackpotPresentation()
	RollSlice.jackpotScreenShown(false)
	print("[SlimeOP] All cutscene/jackpot screens cleared")
end

-- 10. Enable Auto Roll
function _G.SlimeOP.enableAutoRoll()
	SettingsServiceClient:set("autoRoll", true)
	RollSlice.autoRoll(true)
	print("[SlimeOP] Auto roll enabled")
end

-- 11. Disable Auto Roll
function _G.SlimeOP.disableAutoRoll()
	SettingsServiceClient:set("autoRoll", false)
	RollSlice.autoRoll(false)
	print("[SlimeOP] Auto roll disabled")
end

-- 12. Start rapid roll loop (auto-clears blocking screens each interval)
function _G.SlimeOP.startRapidRoll(interval)
	interval = interval or 0.1
	if _rapidRollActive then
		print("[SlimeOP] Rapid roll is already running")
		return
	end
	_rapidRollActive = true
	RollSlice.autoRoll(true)
	task.spawn(function()
		while _rapidRollActive do
			RollSlice.actions.clearRareRollCutscene()
			RollSlice.actions.clearJackpotPresentation()
			RollSlice.jackpotScreenShown(false)
			task.wait(interval)
		end
	end)
	print("[SlimeOP] Rapid roll loop started (interval:", interval, "s)")
end

-- 13. Stop rapid roll loop
function _G.SlimeOP.stopRapidRoll()
	_rapidRollActive = false
	RollSlice.autoRoll(false)
	print("[SlimeOP] Rapid roll stopped")
end

-- ============================================================
-- SECTION 2: Goop Gun Features
-- ============================================================

-- 14. Patch Goop Gun: zero cooldown, infinite range, max damage
function _G.SlimeOP.patchGoopGun()
	if _origFireRate == nil then
		_origFireRate = GoopGunServiceUtils.getFireRate
		_origRange = GoopGunServiceUtils.getRange
		_origDamage = GoopGunServiceUtils.getDamageMultiplier
	end
	GoopGunServiceUtils.getFireRate = function() return 0 end
	GoopGunServiceUtils.getRange = function() return math.huge end
	GoopGunServiceUtils.getDamageMultiplier = function() return 999 end
	print("[SlimeOP] Goop Gun patched: zero cooldown, infinite range, 999x damage")
end

-- 15. Restore Goop Gun to original values
function _G.SlimeOP.unpatchGoopGun()
	if _origFireRate then
		GoopGunServiceUtils.getFireRate = _origFireRate
		GoopGunServiceUtils.getRange = _origRange
		GoopGunServiceUtils.getDamageMultiplier = _origDamage
		_origFireRate = nil
		_origRange = nil
		_origDamage = nil
		print("[SlimeOP] Goop Gun restored to original values")
	else
		print("[SlimeOP] Goop Gun was not patched")
	end
end

-- 16. Force unlock Slime Gun (bypasses upgrade ownership check)
function _G.SlimeOP.unlockSlimeGun()
	if _origOwnsUpgrade == nil then
		_origOwnsUpgrade = UpgradeServiceUtils.ownsUpgrade
	end
	UpgradeServiceUtils.ownsUpgrade = function(key, upgrades)
		if key == "slimeGun" then return true end
		return _origOwnsUpgrade(key, upgrades)
	end
	print("[SlimeOP] Slime Gun force-unlocked")
end

-- 17. Restore Slime Gun unlock check
function _G.SlimeOP.relockSlimeGun()
	if _origOwnsUpgrade then
		UpgradeServiceUtils.ownsUpgrade = _origOwnsUpgrade
		_origOwnsUpgrade = nil
		print("[SlimeOP] Slime Gun lock restored")
	else
		print("[SlimeOP] Slime Gun was not patched")
	end
end

-- 18. Start auto-fire loop targeting nearest enemy
function _G.SlimeOP.startAutoFire(interval)
	interval = interval or 0.05
	if _autoFireActive then
		print("[SlimeOP] Auto-fire is already running")
		return
	end
	_autoFireActive = true
	task.spawn(function()
		while _autoFireActive do
			local gameplay = GameplayServiceClient.gameplay
			if gameplay then
				for uniqueId, enemy in gameplay.enemies do
					if not enemy.dead then
						local wrapper = _G.SlimeOP._getWrapper()
						if wrapper then
							wrapper.stickyTargetId = uniqueId
							wrapper:onActivated()
						end
						break
					end
				end
			end
			task.wait(interval)
		end
	end)
	print("[SlimeOP] Auto-fire started (interval:", interval, "s)")
end

-- 19. Stop auto-fire loop
function _G.SlimeOP.stopAutoFire()
	_autoFireActive = false
	print("[SlimeOP] Auto-fire stopped")
end

-- Internal helper: get the active GoopGun wrapper from GoopGunServiceClient
function _G.SlimeOP._getWrapper()
	local ok, GoopGunServiceClient = pcall(function()
		return require(ReplicatedStorage.Source.Features.GoopGun.GoopGunServiceClient)
	end)
	if ok and GoopGunServiceClient then
		local Players = game:GetService("Players")
		local char = Players.LocalPlayer.Character
		if char then
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			if humanoid and GoopGunServiceClient.wrapper then
				return GoopGunServiceClient.wrapper
			end
		end
	end
	return nil
end

-- ============================================================
-- SECTION 3: Special Dice Features
-- ============================================================

-- 20. Inject jackpot spin into the armed dice queue display
function _G.SlimeOP.forceJackpotQueue(count)
	count = count or 5
	if _origNormalizeQueue == nil then
		_origNormalizeQueue = SpecialDiceServiceUtils.normalizeQueue
	end
	SpecialDiceServiceUtils.normalizeQueue = function(queue)
		local result = {}
		for i = 1, count do
			table.insert(result, "jackpotSpin")
		end
		return result
	end
	print("[SlimeOP] Jackpot queue forced: " .. count .. " jackpot spins displayed")
end

-- 21. Restore original dice queue
function _G.SlimeOP.resetDiceQueue()
	if _origNormalizeQueue then
		SpecialDiceServiceUtils.normalizeQueue = _origNormalizeQueue
		_origNormalizeQueue = nil
		print("[SlimeOP] Dice queue restored to original")
	else
		print("[SlimeOP] Dice queue was not patched")
	end
end

-- 22. Force best mutation on all displayed roll results (huge > shiny > inverted > big)
function _G.SlimeOP.forceBestMutation(mutationId)
	mutationId = mutationId or "huge"
	if _origApplyToRollResults == nil then
		_origApplyToRollResults = SpecialDiceServiceUtils.applyToRollResults
	end
	SpecialDiceServiceUtils.applyToRollResults = function(results, _)
		return _origApplyToRollResults(results, mutationId)
	end
	print("[SlimeOP] All roll results will display mutation:", mutationId)
end

-- 23. Restore original roll result mutation logic
function _G.SlimeOP.resetMutationPatch()
	if _origApplyToRollResults then
		SpecialDiceServiceUtils.applyToRollResults = _origApplyToRollResults
		_origApplyToRollResults = nil
		print("[SlimeOP] Mutation patch restored")
	else
		print("[SlimeOP] Mutation was not patched")
	end
end

-- ============================================================
-- SECTION 4: Master Controls
-- ============================================================

-- 24. Enable ALL OP features at once
function _G.SlimeOP.enableAll(luckValue, rollSpeed)
	_G.SlimeOP.setMaxLuck(luckValue or 999999)
	_G.SlimeOP.forceAllSpecialRolls()
	_G.SlimeOP.setRollSpeed(rollSpeed or 0.05)
	_G.SlimeOP.triggerLuckRain(999)
	_G.SlimeOP.instantReveal()
	_G.SlimeOP.enableAutoRoll()
	_G.SlimeOP.startRapidRoll(0.1)
	_G.SlimeOP.patchGoopGun()
	_G.SlimeOP.unlockSlimeGun()
	_G.SlimeOP.startAutoFire(0.05)
	_G.SlimeOP.forceJackpotQueue(10)
	_G.SlimeOP.forceBestMutation("huge")
	print("[SlimeOP] Full OP mode ON")
end

-- 25. Reset ALL settings back to default
function _G.SlimeOP.resetAll()
	_G.SlimeOP.stopRapidRoll()
	_G.SlimeOP.disableAutoRoll()
	_G.SlimeOP.resetLuck()
	_G.SlimeOP.clearSpecialRolls()
	_G.SlimeOP.resetRollSpeed()
	_G.SlimeOP.unpatchGoopGun()
	_G.SlimeOP.relockSlimeGun()
	_G.SlimeOP.stopAutoFire()
	_G.SlimeOP.resetDiceQueue()
	_G.SlimeOP.resetMutationPatch()
	print("[SlimeOP] All settings reset to default")
end

-- 26. Print all available functions
function _G.SlimeOP.help()
	print("========== SlimeOP Functions ==========")
	print("--- Roll / Luck ---")
	print("_G.SlimeOP.setMaxLuck(value)        -- Luck override (default 999999)")
	print("_G.SlimeOP.resetLuck()              -- Disable luck override")
	print("_G.SlimeOP.forceAllSpecialRolls()   -- Force galaxy/void/diamond/golden on")
	print("_G.SlimeOP.clearSpecialRolls()      -- Clear all special rolls")
	print("_G.SlimeOP.setRollSpeed(time)       -- Set roll time in seconds (default 0.05)")
	print("_G.SlimeOP.resetRollSpeed()         -- Reset roll speed to 3")
	print("_G.SlimeOP.triggerLuckRain(mult)    -- Trigger luck rain (default 999x)")
	print("_G.SlimeOP.instantReveal()          -- Skip roll animation")
	print("_G.SlimeOP.skipAllScreens()         -- Clear cutscenes & jackpot screens")
	print("_G.SlimeOP.enableAutoRoll()         -- Enable auto roll")
	print("_G.SlimeOP.disableAutoRoll()        -- Disable auto roll")
	print("_G.SlimeOP.startRapidRoll(sec)      -- Start rapid roll loop")
	print("_G.SlimeOP.stopRapidRoll()          -- Stop rapid roll loop")
	print("--- Goop Gun ---")
	print("_G.SlimeOP.patchGoopGun()           -- Zero cooldown + infinite range + 999x damage")
	print("_G.SlimeOP.unpatchGoopGun()         -- Restore gun to original values")
	print("_G.SlimeOP.unlockSlimeGun()         -- Force-unlock slime gun (bypass upgrade check)")
	print("_G.SlimeOP.relockSlimeGun()         -- Restore unlock check")
	print("_G.SlimeOP.startAutoFire(sec)       -- Auto-fire at nearest enemy in a loop")
	print("_G.SlimeOP.stopAutoFire()           -- Stop auto-fire loop")
	print("--- Special Dice ---")
	print("_G.SlimeOP.forceJackpotQueue(n)     -- Show n jackpot spins in dice queue display")
	print("_G.SlimeOP.resetDiceQueue()         -- Restore original dice queue")
	print("_G.SlimeOP.forceBestMutation(id)    -- Force mutation on roll results (default: huge)")
	print("_G.SlimeOP.resetMutationPatch()     -- Restore original mutation logic")
	print("--- Master ---")
	print("_G.SlimeOP.enableAll()              -- Enable ALL OP features")
	print("_G.SlimeOP.resetAll()               -- Reset everything to default")
	print("=======================================")
end

print("[SlimeOP] Module loaded! Run _G.SlimeOP.help() to see all functions.")
