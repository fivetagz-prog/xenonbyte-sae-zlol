-- ==================================================
-- XENONBYTE HUB | LOADER
-- ==================================================

local BASE_URL =
    "https://raw.githubusercontent.com/fivetagz-prog/xenonbyte-sae-zlol/main/stealanegg-main/"

-- ==================================================
-- GLOBAL CACHE
-- ==================================================

_G.XENONBYTE_Cache = _G.XENONBYTE_Cache or {}

-- ==================================================
-- HTTP GET
-- ==================================================

local function GetScript(Path)
    local URL = BASE_URL .. Path

    if _G.XENONBYTE_Cache[URL] then
        return _G.XENONBYTE_Cache[URL]
    end

    local Success, Result = pcall(function()
        return game:HttpGet(URL)
    end)

    if not Success then
        error(
            "[XENONBYTE] HTTP GET FAILED\n\n"
            .. "File: "
            .. Path
            .. "\nURL: "
            .. URL
            .. "\n\n"
            .. tostring(Result)
        )
    end

    if not Result or Result == "" then
        error(
            "[XENONBYTE] EMPTY RESPONSE\n\n"
            .. "File: "
            .. Path
            .. "\nURL: "
            .. URL
        )
    end

    _G.XENONBYTE_Cache[URL] = Result

    return Result
end

-- ==================================================
-- LOAD SCRIPT
-- ==================================================

local function LoadScript(Path)
    print("[XENONBYTE] Downloading: " .. Path)

    local Source = GetScript(Path)

    print("[XENONBYTE] Compiling: " .. Path)

    local CompileSuccess, ScriptFunction = pcall(function()
        return loadstring(Source)
    end)

    if not CompileSuccess then
        error(
            "[XENONBYTE] COMPILE ERROR\n\n"
            .. "File: "
            .. Path
            .. "\n\n"
            .. tostring(ScriptFunction)
        )
    end

    if type(ScriptFunction) ~= "function" then
        error(
            "[XENONBYTE] LOADSTRING FAILED\n\n"
            .. "File: "
            .. Path
            .. "\n\nloadstring did not return a function."
        )
    end

    print("[XENONBYTE] Executing: " .. Path)

    local ExecuteSuccess, Result = pcall(function()
        return ScriptFunction()
    end)

    if not ExecuteSuccess then
        error(
            "[XENONBYTE] EXECUTION ERROR\n\n"
            .. "File: "
            .. Path
            .. "\n\n"
            .. tostring(Result)
        )
    end

    print("[XENONBYTE] Loaded successfully: " .. Path)

    return Result
end

-- ==================================================
-- START LOADING
-- ==================================================

print("==================================================")
print("XENONBYTE HUB")
print("Starting loader...")
print("==================================================")

-- ==================================================
-- CONFIG
-- ==================================================

LoadScript("Config.lua")

-- ==================================================
-- UI
-- ==================================================

LoadScript("UI.lua")

-- ==================================================
-- COMPONENTS
-- MUST LOAD BEFORE TABS/INIT.LUA
-- ==================================================

LoadScript("Components.lua")

-- ==================================================
-- COMPONENT VERIFICATION
-- ==================================================

if type(CreateTab) ~= "function" then
    error(
        "[XENONBYTE] CreateTab is missing after Components.lua loaded.\n\n"
        .. "Components.lua loaded but did not create the global CreateTab function.\n\n"
        .. "Expected:\n"
        .. "function CreateTab(Name, Order)"
    )
end

if type(CreatePage) ~= "function" then
    error(
        "[XENONBYTE] CreatePage is missing after Components.lua loaded.\n\n"
        .. "Components.lua loaded but did not create the global CreatePage function.\n\n"
        .. "Expected:\n"
        .. "function CreatePage(Name)"
    )
end

print("✅ CreateTab verified")
print("✅ CreatePage verified")

-- ==================================================
-- TABS MANAGER
-- ==================================================

LoadScript("Tabs/Init.lua")

-- ==================================================
-- VERIFY TABS MANAGER
-- ==================================================

if not _G.XENONBYTE_TabsManager then
    error(
        "[XENONBYTE] Tabs Manager failed to initialize."
    )
end

print("✅ Tabs Manager verified")

-- ==================================================
-- TABS
-- ==================================================

LoadScript("Tabs/Info.lua")
LoadScript("Tabs/Farming.lua")
LoadScript("Tabs/Combat.lua")
LoadScript("Tabs/AutoFarming.lua")
LoadScript("Tabs/Event.lua")
LoadScript("Tabs/HopServer.lua")
LoadScript("Tabs/Setting.lua")

-- ==================================================
-- FEATURES
-- ==================================================

LoadScript("Features/VIPTP.lua")
LoadScript("Features/AntiTrap.lua")
LoadScript("Features/EggCheckPremium.lua")
LoadScript("Features/AttackDrone.lua")
LoadScript("Features/AutoFarm.lua")
LoadScript("Features/WalkSpeed.lua")
LoadScript("Features/CharacterSystem.lua")
LoadScript("Features/FarmingManager.lua")
LoadScript("Features/ConfigSystem.lua")
LoadScript("Features/AFKSystem.lua")
LoadScript("Features/AutoAttack.lua")
LoadScript("Features/AntiAFK.lua")
LoadScript("Features/ManagerDrone.lua")
LoadScript("Features/TeleportSystem.lua")
LoadScript("Features/BypassAntiCheat.lua")
LoadScript("Features/GodMode.lua")
LoadScript("Features/ManualFastClick.lua")

-- ==================================================
-- DEFAULT TAB
-- ==================================================

if _G.XENONBYTE_TabsManager then
    _G.XENONBYTE_TabsManager:SelectTabByName("Info")
end

-- ==================================================
-- BYPASS ANTI CHEAT
-- ==================================================

task.wait(0.5)

if _G.XENONBYTE_BypassAntiCheat then
    pcall(function()
        _G.XENONBYTE_BypassAntiCheat()
    end)
end

-- ==================================================
-- CONFIG LOAD
-- ==================================================

task.wait(2)

if _G.XENONBYTE_ConfigSystem then
    pcall(function()
        if _G.XENONBYTE_ConfigSystem.Load then
            _G.XENONBYTE_ConfigSystem:Load()
        end
    end)
end

-- ==================================================
-- FINISHED
-- ==================================================

print("==================================================")
print("✅ XENONBYTE HUB LOADED SUCCESSFULLY")
print("==================================================")
