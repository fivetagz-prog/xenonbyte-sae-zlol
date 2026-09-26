-- ==================================================
-- XENONBYTE HUB | STEAL AN EGG | Loader
-- ==================================================

local BASE_URL = "https://raw.githubusercontent.com/fivetagz-prog/xenonbyte-sae-zlol/main/stealanegg-main/"

_G.XENONBYTE_EnablePrint = false

local oldPrint = print
print = function(...)
    if _G.XENONBYTE_EnablePrint then
        oldPrint(...)
    end
end

oldPrint("Loading XenonByte...")

-- ==================================================
-- CACHE SYSTEM
-- ==================================================
_G.XENONBYTE_Cache = _G.XENONBYTE_Cache or {}

local function GetScript(path)
    local fullPath = BASE_URL .. path

    if _G.XENONBYTE_Cache[fullPath] then
        return _G.XENONBYTE_Cache[fullPath]
    end

    local Success, Result = pcall(function()
        return game:HttpGet(fullPath)
    end)

    if not Success then
        error("[XENONBYTE] Failed to download: " .. path .. "\n" .. tostring(Result))
    end

    if not Result or Result == "" then
        error("[XENONBYTE] Empty response: " .. path)
    end

    _G.XENONBYTE_Cache[fullPath] = Result

    return Result
end

local function LoadScript(path)
    oldPrint("[XENONBYTE] Loading: " .. path)

    local Source = GetScript(path)

    local Success, Result = pcall(function()
        local Function = loadstring(Source)

        if not Function then
            error("loadstring returned nil")
        end

        return Function()
    end)

    if not Success then
        error(
            "[XENONBYTE] Failed loading " ..
            path ..
            "\n" ..
            tostring(Result)
        )
    end

    oldPrint("[XENONBYTE] Loaded: " .. path)

    return Result
end

-- ==================================================
-- WAIT UNTIL GAME IS LOADED
-- ==================================================
repeat
    task.wait()
until game:IsLoaded() and game.Players.LocalPlayer

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

oldPrint("Game loaded, Player: " .. Player.Name)

-- ==================================================
-- CREATE LOADING SCREEN
-- ==================================================
local function CreateLoadingScreen()

    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "LoadingScreen"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LoadingGui.DisplayOrder = 9999
    LoadingGui.Parent = CoreGui

    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 280, 0, 110)
    Container.Position = UDim2.new(0.5, -140, 0.5, -55)
    Container.BackgroundColor3 = Color3.fromRGB(16, 17, 23)
    Container.BackgroundTransparency = 0.1
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Parent = LoadingGui

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 14)
    ContainerCorner.Parent = Container

    local ContainerBorder = Instance.new("UIStroke")
    ContainerBorder.Color = Color3.fromRGB(210, 210, 210)
    ContainerBorder.Thickness = 2
    ContainerBorder.Transparency = 0.2
    ContainerBorder.Parent = Container

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -30, 0, 28)
    Title.Position = UDim2.new(0, 15, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = "XENONBYTE HUB"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Center
    Title.TextYAlignment = Enum.TextYAlignment.Center
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Container

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(1, -30, 0, 14)
    Subtitle.Position = UDim2.new(0, 15, 0, 36)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Steal An Egg • Free and Keyless"
    Subtitle.TextColor3 = Color3.fromRGB(145, 145, 175)
    Subtitle.TextSize = 9
    Subtitle.TextXAlignment = Enum.TextXAlignment.Center
    Subtitle.TextYAlignment = Enum.TextYAlignment.Center
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.Parent = Container

    local BarBg = Instance.new("Frame")
    BarBg.Name = "BarBg"
    BarBg.Size = UDim2.new(0.75, 0, 0, 4)
    BarBg.Position = UDim2.new(0.125, 0, 0.5, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    BarBg.BorderSizePixel = 0
    BarBg.Parent = Container

    local BarBgCorner = Instance.new("UICorner")
    BarBgCorner.CornerRadius = UDim.new(1, 0)
    BarBgCorner.Parent = BarBg

    local Bar = Instance.new("Frame")
    Bar.Name = "Bar"
    Bar.Size = UDim2.new(0, 0, 1, 0)
    Bar.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
    Bar.BorderSizePixel = 0
    Bar.Parent = BarBg

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = Bar

    local Percent = Instance.new("TextLabel")
    Percent.Name = "Percent"
    Percent.Size = UDim2.new(1, -30, 0, 22)
    Percent.Position = UDim2.new(0, 15, 0.7, 0)
    Percent.BackgroundTransparency = 1
    Percent.Text = "0%"
    Percent.TextColor3 = Color3.fromRGB(210, 210, 210)
    Percent.TextSize = 18
    Percent.TextXAlignment = Enum.TextXAlignment.Center
    Percent.TextYAlignment = Enum.TextYAlignment.Center
    Percent.Font = Enum.Font.GothamBold
    Percent.Parent = Container

    local function UpdateProgress(percent)
        percent = math.clamp(percent, 0, 100)

        Bar.Size = UDim2.new(percent / 100, 0, 1, 0)
        Percent.Text = math.floor(percent) .. "%"
    end

    return {
        Gui = LoadingGui,

        Update = UpdateProgress,

        Destroy = function()
            if LoadingGui then
                LoadingGui:Destroy()
            end
        end
    }
end

-- ==================================================
-- CREATE LOADING SCREEN
-- ==================================================
local Loading = CreateLoadingScreen()

Loading.Update(5)

-- ==================================================
-- LOAD CORE FILES
-- ==================================================
Loading.Update(10)
LoadScript("Config.lua")

Loading.Update(15)
LoadScript("UI.lua")

Loading.Update(20)
LoadScript("Components.lua")

-- ==================================================
-- VERIFY COMPONENTS
-- ==================================================
if type(CreateTab) ~= "function" then
    error(
        "[XENONBYTE] CreateTab is missing after Components.lua loaded.\n" ..
        "Components.lua did not load correctly."
    )
end

if type(CreatePage) ~= "function" then
    error(
        "[XENONBYTE] CreatePage is missing after Components.lua loaded.\n" ..
        "Components.lua did not load correctly."
    )
end

oldPrint("[XENONBYTE] Components verified.")

-- ==================================================
-- LOAD TABS MANAGER
-- ==================================================
Loading.Update(25)
LoadScript("Tabs/Init.lua")

if not _G.XENONBYTE_TabsManager then
    error("[XENONBYTE] Tabs Manager failed to initialize.")
end

-- ==================================================
-- LOAD FEATURES
-- ==================================================
Loading.Update(28)
LoadScript("Features/AntiAFK.lua")

Loading.Update(30)
LoadScript("Features/WalkSpeed.lua")

Loading.Update(33)
LoadScript("Features/AntiTrap.lua")

Loading.Update(36)
LoadScript("Features/GodMode.lua")

Loading.Update(39)
LoadScript("Features/TeleportSystem.lua")

Loading.Update(42)
LoadScript("Features/AutoFarm.lua")

Loading.Update(45)
LoadScript("Features/AutoAttack.lua")

Loading.Update(48)
LoadScript("Features/AFKSystem.lua")

Loading.Update(50)
LoadScript("Features/VIPTP.lua")

Loading.Update(51)
LoadScript("Features/AttackDrone.lua")

Loading.Update(54)
LoadScript("Features/ManagerDrone.lua")

Loading.Update(57)
LoadScript("Features/ManualFastClick.lua")

Loading.Update(59)
LoadScript("Features/FarmingManager.lua")

Loading.Update(60)
LoadScript("Features/ConfigSystem.lua")

-- ==================================================
-- LOAD TABS
-- ==================================================
Loading.Update(62)
LoadScript("Tabs/Info.lua")

Loading.Update(65)
LoadScript("Tabs/Farming.lua")

Loading.Update(70)
LoadScript("Tabs/Combat.lua")

Loading.Update(75)
LoadScript("Tabs/AutoFarming.lua")

Loading.Update(80)
LoadScript("Tabs/Event.lua")

Loading.Update(85)
LoadScript("Tabs/HopServer.lua")

Loading.Update(90)
LoadScript("Tabs/Setting.lua")

-- ==================================================
-- SELECT DEFAULT TAB
-- ==================================================
Loading.Update(92)

if _G.XENONBYTE_TabsManager then
    _G.XENONBYTE_TabsManager:SelectTabByName("Info")
end

Loading.Update(95)

-- ==================================================
-- LOAD ANTI CHEAT
-- ==================================================
Loading.Update(98)
LoadScript("Features/BypassAntiCheat.lua")

-- ==================================================
-- WAIT BEFORE CONFIG
-- ==================================================
oldPrint("Waiting 2 seconds before applying config...")

task.wait(2)

if _G.XENONBYTE_ConfigSystem then
    oldPrint("Applying Config...")

    local Success, ErrorMessage = pcall(function()
        _G.XENONBYTE_ConfigSystem.Load()
    end)

    if not Success then
        warn(
            "[XENONBYTE] Config Load Error: " ..
            tostring(ErrorMessage)
        )
    end
end

-- ==================================================
-- FINISH
-- ==================================================
Loading.Update(100)

task.wait(0.3)

Loading.Destroy()

oldPrint("Loading Screen Closed!")
oldPrint("XENONBYTE HUB | Ready!")
