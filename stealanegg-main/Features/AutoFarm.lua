--==================================================
-- XENONBYTE HUB | FEATURE | Auto Farm
-- Check Egg + Display Card + Select + Send to Teleport
-- ✅ Register ជាមួយ CharacterSystem
--==================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Container = workspace:WaitForChild("AreaEggSlotsClient")

--==================================================
-- VARIABLES
--==================================================
local AutoFarmEnabled = false
local SelectedEgg = nil
local EggList = {}

--==================================================
-- ASSETS
--==================================================
local Assets = ReplicatedStorage:WaitForChild("Data"):WaitForChild("Assets")
local Configs = Assets:WaitForChild("Configs")
local EggModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("Eggs")

--==================================================
-- MESHID MAP
--==================================================
local MeshIdToCategory = {}

local function BuildMeshIdMap()
    for _, Config in ipairs(Configs:GetChildren()) do
        local Success, Module = pcall(function()
            return require(Config)
        end)
        if Success and Module and Module.Egg then
            local ModelName = Module.Egg.ModelName or Config.Name
            local EggTemplate = EggModels:FindFirstChild(ModelName)
            if EggTemplate then
                for _, descendant in ipairs(EggTemplate:GetDescendants()) do
                    if descendant:IsA("MeshPart") and descendant.MeshId ~= "" then
                        MeshIdToCategory[descendant.MeshId] = Config.Name
                    end
                    if descendant:IsA("SpecialMesh") and descendant.MeshId ~= "" then
                        MeshIdToCategory[descendant.MeshId] = Config.Name
                    end
                end
            end
        end
    end
end

BuildMeshIdMap()

--==================================================
-- GET PET DATA
--==================================================
local function GetPetData(AssetCategory)
    local Config = Configs:FindFirstChild(AssetCategory)
    if not Config then return nil end
    
    local Data = {
        Name = AssetCategory,
        DisplayName = AssetCategory,
        EarningRate = 0,
        Icon = nil,
        Rarity = nil
    }
    
    local Success, Module = pcall(function()
        return require(Config)
    end)
    
    if Success and Module then
        Data.DisplayName = Module.DisplayName or AssetCategory
        Data.EarningRate = Module.EarningRate or 0
        Data.Icon = Module.Icon
        if type(Module.Rarity) == "table" then
            Data.Rarity = Module.Rarity._id or Module.Rarity.RarityId or Module.Rarity.Name
        elseif type(Module.Rarity) == "string" then
            Data.Rarity = Module.Rarity
        end
    end
    
    return Data
end

--==================================================
-- FORMAT MONEY
--==================================================
local function FormatMoney(Amount)
    if type(Amount) ~= "number" then return tostring(Amount) end
    if Amount >= 1e12 then
        return string.format("%.2fT", Amount / 1e12)
    elseif Amount >= 1e9 then
        return string.format("%.2fB", Amount / 1e9)
    elseif Amount >= 1e6 then
        return string.format("%.2fM", Amount / 1e6)
    elseif Amount >= 1e3 then
        return string.format("%.2fK", Amount / 1e3)
    else
        return tostring(math.floor(Amount))
    end
end

--==================================================
-- CALCULATE REAL RATE
--==================================================
local function CalculateRatePerSecond(EarningRate, Scale, Mutations)
    -- The game's Config EarningRate is the authoritative displayed rate.
    -- Do not invent a multiplier from client-side scale/mutation data.
    return math.max(0, tonumber(EarningRate) or 0)
end

--==================================================
-- FIND ASSET CATEGORY
--==================================================
local function FindAssetCategory(EggModel)
    for _, descendant in ipairs(EggModel:GetDescendants()) do
        if descendant:IsA("MeshPart") and descendant.MeshId ~= "" then
            local Category = MeshIdToCategory[descendant.MeshId]
            if Category then return Category end
        end
        if descendant:IsA("SpecialMesh") and descendant.MeshId ~= "" then
            local Category = MeshIdToCategory[descendant.MeshId]
            if Category then return Category end
        end
    end
    return nil
end

--==================================================
-- SCAN EGGS
--==================================================
local function ScanEggs()
    EggList = {}
    
    for _, child in ipairs(Container:GetChildren()) do
        if child:IsA("Model") then
            local AssetCategory = FindAssetCategory(child)
            if AssetCategory then
                local Data = GetPetData(AssetCategory)
                if Data then
                    local Scale = child:GetAttribute("AssetScale") or 1
                    local Mutations = child:GetAttribute("Mutations") or {}
                    local RealRate = CalculateRatePerSecond(Data.EarningRate, Scale, Mutations)
                    
                    table.insert(EggList, {
                        Id = child.Name,
                        Category = AssetCategory,
                        DisplayName = Data.DisplayName,
                        Icon = Data.Icon,
                        EarningRate = RealRate,
                        Rarity = Data.Rarity,
                        Model = child
                    })
                end
            end
        end
    end
    
    local RarityPriority = { Divine = 1, Eternal = 2, Secret = 3 }
    table.sort(EggList, function(a, b)
        local ar = RarityPriority[a.Rarity] or 999
        local br = RarityPriority[b.Rarity] or 999
        if ar ~= br then return ar < br end
        return a.EarningRate > b.EarningRate
    end)
    
    return EggList
end

--==================================================
-- ENABLE / DISABLE
--==================================================
local function EnableAutoFarm()
    AutoFarmEnabled = true
    print("[XENONBYTE] Auto Farm: ON")
end

local function DisableAutoFarm()
    AutoFarmEnabled = false
    print("[XENONBYTE] Auto Farm: OFF")
end

--==================================================
-- SELECT EGG (Save only, NO Teleport)
--==================================================
local function SelectEgg(EggData)
    SelectedEgg = EggData
    print("[XENONBYTE] Selected Egg: " .. EggData.DisplayName .. " ($" .. FormatMoney(EggData.EarningRate) .. "/s)")
end

--==================================================
-- START TELEPORT (Called on Start button)
--==================================================
local function StartTeleport()
    if not SelectedEgg then
        warn("[XENONBYTE] No Egg Selected")
        return
    end

    local Method = _G.XENONBYTE_SelectedMethod or "TeleportFly"
    local Speed = _G.XENONBYTE_TeleportSpeed or 300

    print("[XENONBYTE] Start Teleport | Method: " .. Method .. " | Speed: " .. tostring(Speed) .. " | Target: " .. SelectedEgg.Id)

    if _G.XENONBYTE_TeleportSystem then
        _G.XENONBYTE_TeleportSystem.SetMethod(Method)
        _G.XENONBYTE_TeleportSystem.SetSpeed(Speed)
        _G.XENONBYTE_TeleportSystem.SetTargetId(SelectedEgg.Id)
        _G.XENONBYTE_TeleportSystem.Enable()
    end
end

--==================================================
-- STOP TELEPORT (Called on Stop button)
--==================================================
local function StopTeleport()
    if _G.XENONBYTE_TeleportSystem then
        _G.XENONBYTE_TeleportSystem.Disable()
    end
    print("[XENONBYTE] Stop Teleport")
end

--==================================================
-- EXPORT
--==================================================
_G.XENONBYTE_AutoFarm = {
    Enable = EnableAutoFarm,
    Disable = DisableAutoFarm,
    IsEnabled = function() return AutoFarmEnabled end,
    ScanEggs = ScanEggs,
    GetEggList = function() return EggList end,
    SelectEgg = SelectEgg,
    StartTeleport = StartTeleport,
    StopTeleport = StopTeleport,
    GetSelectedEgg = function() return SelectedEgg end,
    FormatMoney = FormatMoney
}

print("✅ AutoFarm Feature Loaded (Register)")
