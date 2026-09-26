--==================================================
-- XENONBYTE HUB | TAB | Event
-- Feature: Auto Attack Drone
-- ✅ DYNAMIC STATE SYNC
-- ✅ NO CONFIG SAVE
-- ✅ BLACK / WHITE GRADIENT UI
--==================================================

local TabsManager = _G.XENONBYTE_TabsManager
local TweenService = game:GetService("TweenService")

local EventTab, EventPage = TabsManager:RegisterTab("Event", 5, "EVENT")

--==================================================
-- CONTENT
--==================================================
CreateSectionTitle(EventPage, "Event", 1)

--==================================================
-- FEATURE: AUTO ATTACK DRONE
--==================================================
local ManagerHolder = Instance.new("Frame")
ManagerHolder.Size = UDim2.new(1, 0, 0, 62)
ManagerHolder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
ManagerHolder.BorderSizePixel = 0
ManagerHolder.LayoutOrder = 2
ManagerHolder.Parent = EventPage

local HolderCorner = Instance.new("UICorner")
HolderCorner.CornerRadius = UDim.new(0, 9)
HolderCorner.Parent = ManagerHolder

local HolderStroke = Instance.new("UIStroke")
HolderStroke.Color = Color3.fromRGB(80, 80, 80)
HolderStroke.Thickness = 1
HolderStroke.Transparency = 0.2
HolderStroke.Parent = ManagerHolder

local HolderGradient = Instance.new("UIGradient")
HolderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
})
HolderGradient.Rotation = 90
HolderGradient.Parent = ManagerHolder

--==================================================
-- LABEL
--==================================================
local ManagerLabel = Instance.new("TextLabel")
ManagerLabel.Size = UDim2.new(1, -65, 0, 21)
ManagerLabel.Position = UDim2.new(0, 12, 0, 8)
ManagerLabel.BackgroundTransparency = 1
ManagerLabel.Text = "Auto Attack Drone"
ManagerLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
ManagerLabel.TextSize = 13
ManagerLabel.TextXAlignment = Enum.TextXAlignment.Left
ManagerLabel.TextYAlignment = Enum.TextYAlignment.Center
ManagerLabel.Font = Enum.Font.GothamBold
ManagerLabel.Parent = ManagerHolder

local ManagerSub = Instance.new("TextLabel")
ManagerSub.Size = UDim2.new(1, -65, 0, 18)
ManagerSub.Position = UDim2.new(0, 12, 0, 32)
ManagerSub.BackgroundTransparency = 1
ManagerSub.Text = "AFK Farm Drone"
ManagerSub.TextColor3 = Color3.fromRGB(150, 150, 160)
ManagerSub.TextSize = 10
ManagerSub.TextXAlignment = Enum.TextXAlignment.Left
ManagerSub.Font = Enum.Font.Gotham
ManagerSub.Parent = ManagerHolder

--==================================================
-- TOGGLE BUTTON
--==================================================
local ManagerButton = Instance.new("TextButton")
ManagerButton.Size = UDim2.new(0, 28, 0, 28)
ManagerButton.Position = UDim2.new(1, -40, 0.5, -14)
ManagerButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
ManagerButton.BorderSizePixel = 0
ManagerButton.Text = ""
ManagerButton.AutoButtonColor = false
ManagerButton.Parent = ManagerHolder

local ManagerCorner = Instance.new("UICorner")
ManagerCorner.CornerRadius = UDim.new(0, 7)
ManagerCorner.Parent = ManagerButton

local ManagerStroke = Instance.new("UIStroke")
ManagerStroke.Color = Color3.fromRGB(165, 165, 165)
ManagerStroke.Thickness = 1.25
ManagerStroke.Transparency = 0.15
ManagerStroke.Parent = ManagerButton

local ManagerCheck = Instance.new("TextLabel")
ManagerCheck.Size = UDim2.new(1, 0, 1, 0)
ManagerCheck.BackgroundTransparency = 1
ManagerCheck.Text = "✓"
ManagerCheck.TextColor3 = Color3.fromRGB(10, 10, 10)
ManagerCheck.TextSize = 18
ManagerCheck.Font = Enum.Font.GothamBold
ManagerCheck.Visible = false
ManagerCheck.Parent = ManagerButton

--==================================================
-- UPDATE UI
--==================================================
local function UpdateManagerUI(State)

    ManagerCheck.Visible = State

    if State then

        ManagerButton.BackgroundColor3 =
            Color3.fromRGB(235, 235, 235)

        ManagerStroke.Color =
            Color3.fromRGB(255, 255, 255)

    else

        ManagerButton.BackgroundColor3 =
            Color3.fromRGB(24, 24, 24)

        ManagerStroke.Color =
            Color3.fromRGB(165, 165, 165)

    end
end

--==================================================
-- BUTTON
--==================================================
ManagerButton.MouseButton1Click:Connect(function()

    if not _G.XENONBYTE_ManagerDrone then

        warn("[XENONBYTE] ManagerDrone not loaded!")

        return
    end

    local NewState =
        not _G.XENONBYTE_ManagerDrone.IsEnabled()

    UpdateManagerUI(NewState)

    if NewState then

        _G.XENONBYTE_ManagerDrone.Enable()

    else

        _G.XENONBYTE_ManagerDrone.Disable()

    end
end)

--==================================================
-- HOVER
--==================================================
ManagerButton.MouseEnter:Connect(function()

    TweenService:Create(
        ManagerButton,
        TweenInfo.new(0.12),
        {
            BackgroundColor3 =
                ManagerCheck.Visible
                and Color3.fromRGB(250, 250, 250)
                or Color3.fromRGB(45, 45, 45)
        }
    ):Play()

end)

ManagerButton.MouseLeave:Connect(function()

    TweenService:Create(
        ManagerButton,
        TweenInfo.new(0.12),
        {
            BackgroundColor3 =
                ManagerCheck.Visible
                and Color3.fromRGB(235, 235, 235)
                or Color3.fromRGB(24, 24, 24)
        }
    ):Play()

end)

--==================================================
-- SYNC STATE ON LOAD
--==================================================
task.spawn(function()

    task.wait(1)

    if _G.XENONBYTE_ManagerDrone then

        local State =
            _G.XENONBYTE_ManagerDrone.IsEnabled()

        UpdateManagerUI(State)

    end
end)

--==================================================
-- REFRESH FUNCTION
--==================================================
_G.XENONBYTE_RefreshEventUI = function()

    if _G.XENONBYTE_ManagerDrone then

        local State =
            _G.XENONBYTE_ManagerDrone.IsEnabled()

        UpdateManagerUI(State)

        print(
            "[XENONBYTE] Event Tab UI Refreshed | State: "
            .. tostring(State)
        )
    end
end

--==================================================
-- PERIODIC SYNC
--==================================================
task.spawn(function()

    while task.wait(1) do

        if _G.XENONBYTE_ManagerDrone then

            local CurrentState =
                _G.XENONBYTE_ManagerDrone.IsEnabled()

            local UIState =
                ManagerCheck.Visible

            if CurrentState ~= UIState then

                UpdateManagerUI(CurrentState)

                print(
                    "[XENONBYTE] Event UI Sync | State: "
                    .. tostring(CurrentState)
                )
            end
        end
    end
end)

print("✅ Event Tab Loaded")
