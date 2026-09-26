--==================================================
-- XENONBYTE HUB | FEATURE | Auto Farm
-- Check Egg + Display Card + Select + Send to Teleport
-- Supports: Secret / Eternal / Divine
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

local DataFolder = ReplicatedStorage:WaitForChild("Data")
local Assets = DataFolder:WaitForChild("Assets")
local Configs = Assets:WaitForChild("Configs")

local EggModels = ReplicatedStorage
    :WaitForChild("Assets")
    :WaitForChild("Models")
    :WaitForChild("Eggs")

--==================================================
-- MESHID MAP
--==================================================

local MeshIdToCategory = {}

local function BuildMeshIdMap()
    MeshIdToCategory = {}

    for _, Config in ipairs(Configs:GetChildren()) do
        local Success, Module = pcall(function()
            return require(Config)
        end)

        if Success and Module and Module.Egg then
            local ModelName = Module.Egg.ModelName or Config.Name
            local EggTemplate = EggModels:FindFirstChild(ModelName)

            if EggTemplate then
                for _, Descendant in ipairs(EggTemplate:GetDescendants()) do

                    if Descendant:IsA("MeshPart") then
                        local MeshId = Descendant.MeshId

                        if MeshId and MeshId ~= "" then
                            MeshIdToCategory[MeshId] = Config.Name
                        end
                    end

                    if Descendant:IsA("SpecialMesh") then
                        local MeshId = Descendant.MeshId

                        if MeshId and MeshId ~= "" then
                            MeshIdToCategory[MeshId] = Config.Name
                        end
                    end

                end
            end
        end
    end
end

BuildMeshIdMap()

--==================================================
-- GET RARITY
--==================================================

local function GetRarity(Module)
    if not Module then
        return nil
    end

    if Module.Rarity then

        if type(Module.Rarity) == "table" then
            return Module.Rarity._id
                or Module.Rarity.RarityId
                or Module.Rarity.Name
        end

        if type(Module.Rarity) == "string" then
            return Module.Rarity
        end
    end

    return nil
end

--==================================================
-- GET PET / EGG DATA
--==================================================

local function GetPetData(AssetCategory)
    local Config = Configs:FindFirstChild(AssetCategory)

    if not Config then
        return nil
    end

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

    if not Success or not Module then
        return nil
    end

    Data.DisplayName = Module.DisplayName or AssetCategory
    Data.EarningRate = tonumber(Module.EarningRate) or 0
    Data.Icon = Module.Icon
    Data.Rarity = GetRarity(Module)

    return Data
end

--==================================================
-- FORMAT MONEY
--==================================================

local function FormatMoney(Amount)
    if type(Amount) ~= "number" then
        return tostring(Amount)
    end

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

    EarningRate = tonumber(EarningRate) or 0
    Scale = tonumber(Scale) or 1

    local PayoutFactor

    if Scale <= 5 then
        PayoutFactor = Scale ^ 1.85
    else
        PayoutFactor =
            (Scale / 5) ^ 1.2
            * 19.637875755794113
    end

    local MutationMultiplier = 1

    if Mutations and type(Mutations) == "table" and #Mutations > 0 then

        local Success, MutationsModule = pcall(function()
            return require(
                ReplicatedStorage.Shared.Modules.Mutations
            )
        end)

        if Success and MutationsModule then
            local MutationSuccess, Result = pcall(function()
                return MutationsModule.EarningsFor(Mutations)
            end)

            if MutationSuccess and type(Result) == "number" then
                MutationMultiplier = Result
            end
        end
    end

    return math.round(
        EarningRate
        * PayoutFactor
        * MutationMultiplier
    )
end

--==================================================
-- FIND ASSET CATEGORY
--==================================================

local function FindAssetCategory(EggModel)

    -- First try the model's direct attributes.
    local AttributeCategory =
        EggModel:GetAttribute("AssetCategory")
        or EggModel:GetAttribute("Category")
        or EggModel:GetAttribute("EggCategory")

    if AttributeCategory then
        if Configs:FindFirstChild(tostring(AttributeCategory)) then
            return tostring(AttributeCategory)
        end
    end

    -- Then identify by MeshId.
    for _, Descendant in ipairs(EggModel:GetDescendants()) do

        if Descendant:IsA("MeshPart") then
            local MeshId = Descendant.MeshId

            if MeshId and MeshId ~= "" then
                local Category = MeshIdToCategory[MeshId]

                if Category then
                    return Category
                end
            end
        end

        if Descendant:IsA("SpecialMesh") then
            local MeshId = Descendant.MeshId

            if MeshId and MeshId ~= "" then
                local Category = MeshIdToCategory[MeshId]

                if Category then
                    return Category
                end
            end
        end
    end

    return nil
end

--==================================================
-- FIND RARITY DIRECTLY FROM MODEL
--==================================================

local function GetModelRarity(EggModel)

    local Rarity =
        EggModel:GetAttribute("Rarity")
        or EggModel:GetAttribute("EggRarity")

    if Rarity then
        return tostring(Rarity)
    end

    return nil
end

--==================================================
-- CHECK SPECIAL RARITY
--==================================================

local function IsSpecialRarity(Rarity)
    return Rarity == "Secret"
        or Rarity == "Eternal"
        or Rarity == "Divine"
end

--==================================================
-- SCAN EGGS
--==================================================

local function ScanEggs()

    EggList = {}

    -- Rebuild so newly loaded egg configs are detected.
    BuildMeshIdMap()

    for _, Child in ipairs(Container:GetChildren()) do

        if Child:IsA("Model") then

            local AssetCategory =
                FindAssetCategory(Child)

            if AssetCategory then

                local Data =
                    GetPetData(AssetCategory)

                if Data then

                    -- Prefer the model's rarity when available.
                    local Rarity =
                        GetModelRarity(Child)
                        or Data.Rarity

                    local Scale =
                        tonumber(
                            Child:GetAttribute("AssetScale")
                        )
                        or 1

                    local Mutations =
                        Child:GetAttribute("Mutations")

                    if type(Mutations) ~= "table" then
                        Mutations = {}
                    end

                    local RealRate =
                        CalculateRatePerSecond(
                            Data.EarningRate,
                            Scale,
                            Mutations
                        )

                    table.insert(EggList, {
                        Id = Child.Name,

                        Category = AssetCategory,

                        DisplayName =
                            Data.DisplayName,

                        Icon = Data.Icon,

                        Rarity = Rarity,

                        EarningRate = RealRate,

                        Model = Child
                    })
                end
            end
        end
    end

    --==================================================
    -- SORT
    -- Divine > Eternal > Secret > everything else
    --==================================================

    local RarityPriority = {
        Divine = 1,
        Eternal = 2,
        Secret = 3
    }

    table.sort(EggList, function(A, B)

        local APriority =
            RarityPriority[A.Rarity] or 999

        local BPriority =
            RarityPriority[B.Rarity] or 999

        if APriority ~= BPriority then
            return APriority < BPriority
        end

        return
            (A.EarningRate or 0)
            >
            (B.EarningRate or 0)
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
-- SELECT EGG
--==================================================

local function SelectEgg(EggData)

    if not EggData then
        return
    end

    SelectedEgg = EggData

    print(
        "[XENONBYTE] Selected Egg: "
        .. tostring(EggData.DisplayName)
        .. " ["
        .. tostring(EggData.Rarity or "Unknown")
        .. "] ($"
        .. FormatMoney(EggData.EarningRate)
        .. "/s)"
    )
end

--==================================================
-- START TELEPORT
--==================================================

local function StartTeleport()

    if not SelectedEgg then
        warn("[XENONBYTE] No Egg Selected")
        return
    end

    local Method =
        _G.XENONBYTE_SelectedMethod
        or "TeleportFly"

    local Speed =
        _G.XENONBYTE_TeleportSpeed
        or 300

    print(
        "[XENONBYTE] Start Teleport"
        .. " | Method: "
        .. tostring(Method)
        .. " | Speed: "
        .. tostring(Speed)
        .. " | Target: "
        .. tostring(SelectedEgg.Id)
        .. " | Rarity: "
        .. tostring(SelectedEgg.Rarity or "Unknown")
    )

    if _G.XENONBYTE_TeleportSystem then

        _G.XENONBYTE_TeleportSystem.SetMethod(Method)

        _G.XENONBYTE_TeleportSystem.SetSpeed(Speed)

        _G.XENONBYTE_TeleportSystem.SetTargetId(
            SelectedEgg.Id
        )

        _G.XENONBYTE_TeleportSystem.Enable()
    end
end

--==================================================
-- STOP TELEPORT
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

    IsEnabled = function()
        return AutoFarmEnabled
    end,

    ScanEggs = ScanEggs,

    GetEggList = function()
        return EggList
    end,

    SelectEgg = SelectEgg,

    StartTeleport = StartTeleport,

    StopTeleport = StopTeleport,

    GetSelectedEgg = function()
        return SelectedEgg
    end,

    FormatMoney = FormatMoney
}

print("✅ AutoFarm Feature Loaded (Secret / Eternal / Divine supported)")
