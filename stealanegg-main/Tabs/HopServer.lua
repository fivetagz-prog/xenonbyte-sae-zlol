-- ==================================================
-- XENONBYTE HUB | TAB | Hop Server
-- Feature: Auto Hop To 1 Player Public Server
-- ==================================================

local TabsManager = _G.XENONBYTE_TabsManager
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local PLACE_ID = 107778070777162

local HopServerTab, HopServerPage = TabsManager:RegisterTab("Hop Server", 6, "HOP_SERVER")

-- ==================================================
-- CONTENT
-- ==================================================
CreateSectionTitle(HopServerPage, "Hop Server", 1)

-- ==================================================
-- FEATURE: Auto Hop To 1 Player
-- ==================================================
local FeatureHolder = Instance.new("Frame")
FeatureHolder.Size = UDim2.new(1, 0, 0, 60)
FeatureHolder.BackgroundColor3 = Color3.fromRGB(28, 29, 42)
FeatureHolder.BorderSizePixel = 0
FeatureHolder.LayoutOrder = 2
FeatureHolder.Parent = HopServerPage

local FeatureCorner = Instance.new("UICorner")
FeatureCorner.CornerRadius = UDim.new(0, 8)
FeatureCorner.Parent = FeatureHolder

local FeatureStroke = Instance.new("UIStroke")
FeatureStroke.Color = Color3.fromRGB(210, 210, 210)
FeatureStroke.Thickness = 1.5
FeatureStroke.Transparency = 0.4
FeatureStroke.Parent = FeatureHolder

local FeatureName = Instance.new("TextLabel")
FeatureName.Size = UDim2.new(1, -100, 0, 20)
FeatureName.Position = UDim2.new(0, 12, 0, 10)
FeatureName.BackgroundTransparency = 1
FeatureName.Text = "Hop To 1 Player Server"
FeatureName.TextColor3 = Color3.fromRGB(255, 255, 255)
FeatureName.TextSize = 13
FeatureName.TextXAlignment = Enum.TextXAlignment.Left
FeatureName.Font = Enum.Font.GothamBold
FeatureName.Parent = FeatureHolder

local FeatureStatus = Instance.new("TextLabel")
FeatureStatus.Size = UDim2.new(1, -100, 0, 16)
FeatureStatus.Position = UDim2.new(0, 12, 0, 32)
FeatureStatus.BackgroundTransparency = 1
FeatureStatus.Text = "Click to find a public server with 1 player"
FeatureStatus.TextColor3 = Color3.fromRGB(150, 150, 170)
FeatureStatus.TextSize = 10
FeatureStatus.TextXAlignment = Enum.TextXAlignment.Left
FeatureStatus.Font = Enum.Font.Gotham
FeatureStatus.Parent = FeatureHolder

local ClickBtn = Instance.new("TextButton")
ClickBtn.Size = UDim2.new(0, 70, 0, 30)
ClickBtn.Position = UDim2.new(1, -82, 0.5, -15)
ClickBtn.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
ClickBtn.BorderSizePixel = 0
ClickBtn.Text = "Hop"
ClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClickBtn.TextSize = 12
ClickBtn.Font = Enum.Font.GothamBold
ClickBtn.AutoButtonColor = false
ClickBtn.Parent = FeatureHolder

local ClickCorner = Instance.new("UICorner")
ClickCorner.CornerRadius = UDim.new(0, 6)
ClickCorner.Parent = ClickBtn

local ClickStroke = Instance.new("UIStroke")
ClickStroke.Color = Color3.fromRGB(140, 125, 240)
ClickStroke.Thickness = 1.5
ClickStroke.Transparency = 0.3
ClickStroke.Parent = ClickBtn

ClickBtn.MouseEnter:Connect(function()
    TweenService:Create(ClickBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(125, 110, 220)
    }):Play()
end)

ClickBtn.MouseLeave:Connect(function()
    TweenService:Create(ClickBtn, TweenInfo.new(0.15), {
        BackgroundColor3 = Color3.fromRGB(210, 210, 210)
    }):Play()
end)

-- ==================================================
-- FETCH ONE PLAYER PUBLIC SERVER
-- ==================================================
local function FindOnePlayerServer()
    local cursor = ""
    local seen = {}
    local maxPages = 5

    for page = 1, maxPages do
        local url = string.format(
            "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&cursor=%s",
            PLACE_ID,
            cursor
        )

        local success, response = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(url))
        end)

        if not success or not response or not response.data then
            return nil
        end

        for _, server in ipairs(response.data) do
            if server.playing == 1
                and server.maxPlayers > 1
                and server.playing < server.maxPlayers
                and server.id ~= game.JobId
                and not seen[server.id] then

                seen[server.id] = true
                return server
            end
        end

        cursor = response.next_cursor or ""

        if cursor == "" then
            break
        end

        task.wait(0.15)
    end

    return nil
end

-- ==================================================
-- HOP
-- ==================================================
ClickBtn.MouseButton1Click:Connect(function()

    ClickBtn.Active = false
    ClickBtn.AutoButtonColor = false

    FeatureStatus.Text = "Searching for a 1-player public server..."
    FeatureStatus.TextColor3 = Color3.fromRGB(150, 150, 170)

    local server = FindOnePlayerServer()

    if not server then
        FeatureStatus.Text = "No 1-player public server found."
        FeatureStatus.TextColor3 = Color3.fromRGB(255, 80, 80)

        ClickBtn.Active = true
        return
    end

    FeatureStatus.Text = "Found 1-player server. Teleporting..."
    FeatureStatus.TextColor3 = Color3.fromRGB(0, 255, 105)

    local success, err = pcall(function()
        TeleportService:TeleportToPlaceInstance(
            PLACE_ID,
            server.id,
            game.Players.LocalPlayer
        )
    end)

    if not success then
        FeatureStatus.Text = "Teleport failed: " .. tostring(err)
        FeatureStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
        ClickBtn.Active = true
    end
end)

print("✅ Hop Server Tab Loaded")
