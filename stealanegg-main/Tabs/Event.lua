--==================================================
-- XENONBYTE HUB | TAB | Event
-- Feature: Auto Attack Drone
-- Visual update: XenonByte monochrome UI + asset
--==================================================

local TabsManager = _G.XENONBYTE_TabsManager
local TweenService = game:GetService("TweenService")

local ASSET_ID = "rbxassetid://126314624782419"

local EventTab, EventPage = TabsManager:RegisterTab("Event", 5, "EVENT")

--==================================================
-- SECTION
--==================================================

CreateSectionTitle(EventPage, "Event", 1)

--==================================================
-- EVENT HEADER CARD
--==================================================

local Header = Instance.new("Frame")
Header.Name = "EventHeader"
Header.Size = UDim2.new(1, 0, 0, 62)
Header.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Header.BorderSizePixel = 0
Header.LayoutOrder = 2
Header.Parent = EventPage

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local HeaderStroke = Instance.new("UIStroke")
HeaderStroke.Color = Color3.fromRGB(95, 95, 95)
HeaderStroke.Thickness = 1
HeaderStroke.Transparency = 0.25
HeaderStroke.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 32, 32)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

--==================================================
-- EVENT ICON
--==================================================

local Icon = Instance.new("ImageLabel")
Icon.Name = "EventIcon"
Icon.Size = UDim2.new(0, 42, 0, 42)
Icon.Position = UDim2.new(0, 10, 0.5, -21)
Icon.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
Icon.BorderSizePixel = 0
Icon.Image = ASSET_ID
Icon.ImageColor3 = Color3.fromRGB(10, 10, 10)
Icon.ScaleType = Enum.ScaleType.Fit
Icon.Parent = Header

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = Icon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 255, 255)
IconStroke.Thickness = 1
IconStroke.Transparency = 0.2
IconStroke.Parent = Icon

--==================================================
-- EVENT HEADER TEXT
--==================================================

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1, -70, 0, 22)
HeaderTitle.Position = UDim2.new(0, 62, 0, 10)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "EVENT"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 13
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Parent = Header

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Size = UDim2.new(1, -70, 0, 18)
HeaderSub.Position = UDim2.new(0, 62, 0, 32)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "XenonByte Event Features"
HeaderSub.TextColor3 = Color3.fromRGB(155, 155, 165)
HeaderSub.TextSize = 10
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.Font = Enum.Font.Gotham
HeaderSub.Parent = Header

--==================================================
-- AUTO ATTACK DRONE
--==================================================

local ManagerHolder = Instance.new("Frame")
ManagerHolder.Name = "AutoAttackDrone"
ManagerHolder.Size = UDim2.new(1, 0, 0, 58)
ManagerHolder.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ManagerHolder.BorderSizePixel = 0
ManagerHolder.LayoutOrder = 3
ManagerHolder.Parent = EventPage

local ManagerCorner = Instance.new("UICorner")
ManagerCorner.CornerRadius = UDim.new(0, 9)
ManagerCorner.Parent = ManagerHolder

local ManagerGradient = Instance.new("UIGradient")
ManagerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 31, 31)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 7, 7))
})
ManagerGradient.Rotation = 90
ManagerGradient.Parent = ManagerHolder

local ManagerStroke = Instance.new("UIStroke")
ManagerStroke.Color = Color3.fromRGB(75, 75, 75)
ManagerStroke.Thickness = 1
ManagerStroke.Transparency = 0.2
ManagerStroke.Parent = ManagerHolder

--==================================================
-- LABEL
--==================================================

local ManagerLabel = Instance.new("TextLabel")
ManagerLabel.Size = UDim2.new(1, -60, 0, 21)
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
ManagerSub.Size = UDim2.new(1, -60, 0, 17)
ManagerSub.Position = UDim2.new(0, 12, 0, 31)
ManagerSub.BackgroundTransparency = 1
ManagerSub.Text = "AFK Farm Drone"
ManagerSub.TextColor3 = Color3.fromRGB(145, 145, 155)
ManagerSub.TextSize = 10
ManagerSub.TextXAlignment = Enum.TextXAlignment.Left
ManagerSub.Font = Enum.Font.Gotham
ManagerSub.Parent = ManagerHolder

--==================================================
-- CHECK BUTTON
--==================================================

local ManagerButton = Instance.new("TextButton")
ManagerButton.Size = UDim2.new(0, 28, 0, 28)
ManagerButton.Position = UDim2.new(1, -40, 0.5, -14)
ManagerButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ManagerButton.BorderSizePixel = 0
ManagerButton.Text = ""
ManagerButton.AutoButtonColor = false
ManagerButton.Parent = ManagerHolder

local ManagerButtonCorner = Instance.new("UICorner")
ManagerButtonCorner.CornerRadius = UDim.new(0, 7)
ManagerButtonCorner.Parent = ManagerButton

local ManagerButtonStroke = Instance.new("UIStroke")
ManagerButtonStroke.Color = Color3.fromRGB(170, 170, 170)
ManagerButtonStroke.Thickness = 1.25
ManagerButtonStroke.Transparency = 0.2
ManagerButtonStroke.Parent = ManagerButton

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

        ManagerButton.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
        ManagerButtonStroke.Color = Color3.fromRGB(255, 255, 255)

    else

        ManagerButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        ManagerButtonStroke.Color = Color3.fromRGB(170, 170, 170)

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
-- BUTTON HOVER
--==================================================

ManagerButton.MouseEnter:Connect(function()

    TweenService:Create(
        ManagerButton,
        TweenInfo.new(0.12),
        {
            BackgroundColor3 =
                ManagerCheck.Visible
                and Color3.fromRGB(255, 255, 255)
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
                or Color3.fromRGB(25, 25, 25)
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
