--==================================================
-- XENONBYTE HUB | TAB | Event
--==================================================

local TabsManager = _G.XENONBYTE_TabsManager

local EventTab, EventPage =
    TabsManager:RegisterTab(
        "Event",
        6,
        "EVENT"
    )

--==================================================
-- EVENT SECTION
--==================================================

CreateSectionTitle(
    EventPage,
    "Event",
    1
)

local EventInfo = Instance.new("TextLabel")

EventInfo.Size =
    UDim2.new(1, 0, 0, 55)

EventInfo.BackgroundTransparency = 1

EventInfo.Text =
    "Event features and event-related controls."

EventInfo.TextColor3 =
    Color3.fromRGB(190, 190, 200)

EventInfo.TextSize = 12

EventInfo.TextWrapped = true

EventInfo.Font =
    Enum.Font.Gotham

EventInfo.LayoutOrder = 2

EventInfo.Parent =
    EventPage

--==================================================
-- STATUS CARD
--==================================================

local StatusCard =
    Instance.new("Frame")

StatusCard.Size =
    UDim2.new(1, 0, 0, 55)

StatusCard.BackgroundColor3 =
    Color3.fromRGB(28, 29, 42)

StatusCard.BorderSizePixel = 0

StatusCard.LayoutOrder = 3

StatusCard.Parent =
    EventPage

local StatusCorner =
    Instance.new("UICorner")

StatusCorner.CornerRadius =
    UDim.new(0, 8)

StatusCorner.Parent =
    StatusCard

local StatusStroke =
    Instance.new("UIStroke")

StatusStroke.Color =
    Color3.fromRGB(100, 100, 110)

StatusStroke.Thickness = 1

StatusStroke.Transparency = 0.35

StatusStroke.Parent =
    StatusCard

local StatusTitle =
    Instance.new("TextLabel")

StatusTitle.Size =
    UDim2.new(1, -24, 0, 20)

StatusTitle.Position =
    UDim2.new(0, 12, 0, 7)

StatusTitle.BackgroundTransparency = 1

StatusTitle.Text =
    "Event Status"

StatusTitle.TextColor3 =
    Color3.fromRGB(255, 255, 255)

StatusTitle.TextSize = 12

StatusTitle.TextXAlignment =
    Enum.TextXAlignment.Left

StatusTitle.Font =
    Enum.Font.GothamBold

StatusTitle.Parent =
    StatusCard

local StatusText =
    Instance.new("TextLabel")

StatusText.Size =
    UDim2.new(1, -24, 0, 18)

StatusText.Position =
    UDim2.new(0, 12, 0, 29)

StatusText.BackgroundTransparency = 1

StatusText.Text =
    "No active event detected"

StatusText.TextColor3 =
    Color3.fromRGB(160, 160, 170)

StatusText.TextSize = 10

StatusText.TextXAlignment =
    Enum.TextXAlignment.Left

StatusText.Font =
    Enum.Font.Gotham

StatusText.Parent =
    StatusCard

--==================================================
-- REFRESH EVENT
--==================================================

local RefreshEvent =
    Instance.new("TextButton")

RefreshEvent.Size =
    UDim2.new(1, 0, 0, 42)

RefreshEvent.BackgroundColor3 =
    Color3.fromRGB(35, 35, 35)

RefreshEvent.BorderSizePixel = 0

RefreshEvent.Text =
    "↻  Refresh Event"

RefreshEvent.TextColor3 =
    Color3.fromRGB(255, 255, 255)

RefreshEvent.TextSize = 12

RefreshEvent.Font =
    Enum.Font.GothamBold

RefreshEvent.AutoButtonColor = false

RefreshEvent.LayoutOrder = 4

RefreshEvent.Parent =
    EventPage

local RefreshCorner =
    Instance.new("UICorner")

RefreshCorner.CornerRadius =
    UDim.new(0, 8)

RefreshCorner.Parent =
    RefreshEvent

local RefreshStroke =
    Instance.new("UIStroke")

RefreshStroke.Color =
    Color3.fromRGB(100, 100, 100)

RefreshStroke.Thickness = 1

RefreshStroke.Transparency = 0.25

RefreshStroke.Parent =
    RefreshEvent

RefreshEvent.MouseEnter:Connect(
    function()

        RefreshEvent.BackgroundColor3 =
            Color3.fromRGB(55, 55, 55)

    end
)

RefreshEvent.MouseLeave:Connect(
    function()

        RefreshEvent.BackgroundColor3 =
            Color3.fromRGB(35, 35, 35)

    end
)

RefreshEvent.MouseButton1Click:Connect(
    function()

        RefreshEvent.Text =
            "↻  Checking..."

        task.wait(0.25)

        -- Event detection can be connected
        -- to the project's event system here.

        RefreshEvent.Text =
            "✓  Checked"

        StatusText.Text =
            "Event status refreshed"

        StatusText.TextColor3 =
            Color3.fromRGB(150, 255, 150)

        task.wait(0.75)

        RefreshEvent.Text =
            "↻  Refresh Event"

    end
)

return EventTab
