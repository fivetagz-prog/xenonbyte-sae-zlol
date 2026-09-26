-- ==================================================
-- XENONBYTE HUB | STEAL AN EGG | MODERN BUBBLE UI
-- ==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Settings = _G.XENONBYTE
local Theme = Settings.UI.Theme

local GuiParent = CoreGui

pcall(function()
    if type(gethui) == "function" then
        local hui = gethui()

        if hui then
            GuiParent = hui
        end
    end
end)

-- ==================================================
-- REMOVE OLD UI
-- ==================================================

local function destroyOld()

    for _, name in ipairs({
        "XENONBYTE_HUB",
        "ToggleGUI"
    }) do

        local old = GuiParent:FindFirstChild(name)

        if old then
            old:Destroy()
        end

    end

end

destroyOld()

-- ==================================================
-- UI HELPERS
-- ==================================================

local function Corner(parent, radius)

    local c = Instance.new("UICorner")

    c.CornerRadius = UDim.new(
        0,
        radius or 10
    )

    c.Parent = parent

    return c

end

local function Stroke(
    parent,
    color,
    thickness,
    transparency
)

    local s = Instance.new("UIStroke")

    s.Color =
        color
        or Color3.fromRGB(
            70,
            70,
            70
        )

    s.Thickness =
        thickness
        or 1

    s.Transparency =
        transparency
        or 0

    s.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    s.Parent = parent

    return s

end

local function Gradient(
    parent,
    a,
    b,
    rotation
)

    local g = Instance.new("UIGradient")

    g.Color = ColorSequence.new({

        ColorSequenceKeypoint.new(
            0,
            a
        ),

        ColorSequenceKeypoint.new(
            1,
            b
        )

    })

    g.Rotation =
        rotation
        or 90

    g.Parent = parent

    return g

end

local function Tween(
    object,
    info,
    properties
)

    local tween =
        TweenService:Create(
            object,
            info,
            properties
        )

    tween:Play()

    return tween

end

-- ==================================================
-- FLOATING BUBBLE TOGGLE
-- ==================================================

local ToggleGui =
    Instance.new("ScreenGui")

ToggleGui.Name =
    "ToggleGUI"

ToggleGui.ResetOnSpawn =
    false

ToggleGui.IgnoreGuiInset =
    true

ToggleGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ToggleGui.DisplayOrder =
    2000

ToggleGui.Parent =
    GuiParent

-- ==================================================
-- BUBBLE
-- ==================================================

local Toggle =
    Instance.new("TextButton")

Toggle.Name =
    "X"

Toggle.Size =
    UDim2.fromOffset(
        50,
        50
    )

Toggle.Position =
    UDim2.new(
        0,
        16,
        0.5,
        -25
    )

Toggle.BackgroundColor3 =
    Color3.fromRGB(
        12,
        12,
        12
    )

Toggle.BorderSizePixel =
    0

Toggle.Text =
    "X"

Toggle.TextColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Toggle.TextSize =
    20

Toggle.Font =
    Enum.Font.GothamBlack

Toggle.AutoButtonColor =
    false

Toggle.Parent =
    ToggleGui

Corner(
    Toggle,
    16
)

Stroke(
    Toggle,
    Color3.fromRGB(
        245,
        245,
        245
    ),
    1.5,
    0.15
)

Gradient(
    Toggle,
    Color3.fromRGB(
        42,
        42,
        42
    ),
    Color3.fromRGB(
        5,
        5,
        5
    ),
    135
)

-- ==================================================
-- MAIN WINDOW
-- ==================================================

local ScreenGui =
    Instance.new("ScreenGui")

ScreenGui.Name =
    "XENONBYTE_HUB"

ScreenGui.ResetOnSpawn =
    false

ScreenGui.IgnoreGuiInset =
    true

ScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ScreenGui.DisplayOrder =
    1500

ScreenGui.Parent =
    GuiParent

-- ==================================================
-- MAIN
-- ==================================================

local Main =
    Instance.new("Frame")

Main.Name =
    "Main"

Main.Size =
    UDim2.fromOffset(
        Settings.UI.Width,
        Settings.UI.Height
    )

Main.Position =
    UDim2.new(
        0.5,
        -Settings.UI.Width / 2,
        0.5,
        -Settings.UI.Height / 2
    )

Main.BackgroundColor3 =
    Theme.Background

Main.BorderSizePixel =
    0

Main.ClipsDescendants =
    true

Main.Active =
    true

Main.Parent =
    ScreenGui

Corner(
    Main,
    18
)

Stroke(
    Main,
    Color3.fromRGB(
        100,
        100,
        100
    ),
    1.25,
    0.12
)

Gradient(
    Main,
    Color3.fromRGB(
        18,
        18,
        18
    ),
    Color3.fromRGB(
        4,
        4,
        4
    ),
    135
)

-- ==================================================
-- TOP HIGHLIGHT
-- ==================================================

local Highlight =
    Instance.new("Frame")

Highlight.Size =
    UDim2.new(
        1,
        -2,
        0,
        1
    )

Highlight.Position =
    UDim2.fromOffset(
        1,
        1
    )

Highlight.BackgroundColor3 =
    Color3.fromRGB(
        255,
        255,
        255
    )

Highlight.BackgroundTransparency =
    0.78

Highlight.BorderSizePixel =
    0

Highlight.Parent =
    Main

-- ==================================================
-- HEADER
-- ==================================================

local TopBar =
    Instance.new("Frame")

TopBar.Name =
    "TopBar"

TopBar.Size =
    UDim2.new(
        1,
        0,
        0,
        70
    )

TopBar.BackgroundColor3 =
    Theme.TopBar

TopBar.BorderSizePixel =
    0

TopBar.Active =
    true

TopBar.ZIndex =
    20

TopBar.Parent =
    Main

Gradient(
    TopBar,
    Color3.fromRGB(
        34,
        34,
        34
    ),
    Color3.fromRGB(
        10,
        10,
        10
    ),
    90
)

-- ==================================================
-- HEADER ICON
-- ==================================================

local HeaderIcon =
    Instance.new("TextLabel")

HeaderIcon.Size =
    UDim2.fromOffset(
        42,
        42
    )

HeaderIcon.Position =
    UDim2.fromOffset(
        14,
        14
    )

HeaderIcon.BackgroundColor3 =
    Color3.fromRGB(
        245,
        245,
        245
    )

HeaderIcon.Text =
    "X"

HeaderIcon.TextColor3 =
    Color3.fromRGB(
        8,
        8,
        8
    )

HeaderIcon.TextSize =
    20

HeaderIcon.Font =
    Enum.Font.GothamBlack

HeaderIcon.ZIndex =
    22

HeaderIcon.Parent =
    TopBar

Corner(
    HeaderIcon,
    12
)

-- ==================================================
-- TITLE
-- ==================================================

local Title =
    Instance.new("TextLabel")

Title.Size =
    UDim2.new(
        1,
        -175,
        0,
        25
    )

Title.Position =
    UDim2.fromOffset(
        68,
        10
    )

Title.BackgroundTransparency =
    1

Title.Text =
    "XENONBYTE"

Title.TextColor3 =
    Theme.Text

Title.TextSize =
    18

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Font =
    Enum.Font.GothamBold

Title.ZIndex =
    22

Title.Parent =
    TopBar

-- ==================================================
-- SUBTITLE
-- ==================================================

local Subtitle =
    Instance.new("TextLabel")

Subtitle.Size =
    UDim2.new(
        1,
        -175,
        0,
        18
    )

Subtitle.Position =
    UDim2.fromOffset(
        68,
        36
    )

Subtitle.BackgroundTransparency =
    1

Subtitle.Text =
    "STEAL AN EGG  •  VIP UNLOCKED"

Subtitle.TextColor3 =
    Theme.SubText

Subtitle.TextSize =
    9

Subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

Subtitle.Font =
    Enum.Font.GothamMedium

Subtitle.ZIndex =
    22

Subtitle.Parent =
    TopBar

-- ==================================================
-- STATUS
-- ==================================================

local Status =
    Instance.new("TextLabel")

Status.Size =
    UDim2.fromOffset(
        72,
        24
    )

Status.Position =
    UDim2.new(
        1,
        -122,
        0,
        12
    )

Status.BackgroundColor3 =
    Color3.fromRGB(
        24,
        24,
        24
    )

Status.Text =
    "●  ONLINE"

Status.TextColor3 =
    Color3.fromRGB(
        235,
        235,
        235
    )

Status.TextSize =
    8

Status.Font =
    Enum.Font.GothamBold

Status.ZIndex =
    22

Status.Parent =
    TopBar

Corner(
    Status,
    12
)

Stroke(
    Status,
    Color3.fromRGB(
        100,
        100,
        100
    ),
    1,
    0.25
)

-- ==================================================
-- CLOSE
-- ==================================================

local Close =
    Instance.new("TextButton")

Close.Size =
    UDim2.fromOffset(
        28,
        24
    )

Close.Position =
    UDim2.new(
        1,
        -40,
        0,
        12
    )

Close.BackgroundTransparency =
    1

Close.Text =
    "×"

Close.TextColor3 =
    Color3.fromRGB(
        180,
        180,
        180
    )

Close.TextSize =
    20

Close.Font =
    Enum.Font.GothamMedium

Close.AutoButtonColor =
    false

Close.ZIndex =
    25

Close.Parent =
    TopBar

-- ==================================================
-- HEADER LINE
-- ==================================================

local TopLine =
    Instance.new("Frame")

TopLine.Size =
    UDim2.new(
        1,
        0,
        0,
        1
    )

TopLine.Position =
    UDim2.new(
        0,
        0,
        1,
        -1
    )

TopLine.BackgroundColor3 =
    Color3.fromRGB(
        90,
        90,
        90
    )

TopLine.BackgroundTransparency =
    0.35

TopLine.BorderSizePixel =
    0

TopLine.ZIndex =
    23

TopLine.Parent =
    TopBar

-- ==================================================
-- SIDEBAR
-- ==================================================

local Sidebar =
    Instance.new("Frame")

Sidebar.Name =
    "Sidebar"

Sidebar.Size =
    UDim2.new(
        0,
        Settings.UI.SidebarWidth,
        1,
        -70
    )

Sidebar.Position =
    UDim2.fromOffset(
        0,
        70
    )

Sidebar.BackgroundColor3 =
    Theme.Sidebar

Sidebar.BorderSizePixel =
    0

Sidebar.ZIndex =
    5

Sidebar.Parent =
    Main

Gradient(
    Sidebar,
    Color3.fromRGB(
        22,
        22,
        22
    ),
    Color3.fromRGB(
        7,
        7,
        7
    ),
    90
)

-- ==================================================
-- NAVIGATION TITLE
-- ==================================================

local SideTitle =
    Instance.new("TextLabel")

SideTitle.Size =
    UDim2.new(
        1,
        -24,
        0,
        20
    )

SideTitle.Position =
    UDim2.fromOffset(
        12,
        12
    )

SideTitle.BackgroundTransparency =
    1

SideTitle.Text =
    "NAVIGATION"

SideTitle.TextColor3 =
    Color3.fromRGB(
        115,
        115,
        115
    )

SideTitle.TextSize =
    8

SideTitle.Font =
    Enum.Font.GothamBold

SideTitle.TextXAlignment =
    Enum.TextXAlignment.Left

SideTitle.ZIndex =
    7

SideTitle.Parent =
    Sidebar

-- ==================================================
-- TAB SCROLL
-- ==================================================

local TabScroll =
    Instance.new("ScrollingFrame")

TabScroll.Name =
    "TabScroll"

TabScroll.Size =
    UDim2.new(
        1,
        0,
        1,
        -42
    )

TabScroll.Position =
    UDim2.fromOffset(
        0,
        36
    )

TabScroll.BackgroundTransparency =
    1

TabScroll.BorderSizePixel =
    0

TabScroll.CanvasSize =
    UDim2.new(
        0,
        0,
        0,
        0
    )

TabScroll.AutomaticCanvasSize =
    Enum.AutomaticSize.Y

TabScroll.ScrollingDirection =
    Enum.ScrollingDirection.Y

TabScroll.ScrollBarThickness =
    0

TabScroll.Active =
    true

TabScroll.ZIndex =
    6

TabScroll.Parent =
    Sidebar

-- ==================================================
-- TAB PADDING
-- ==================================================

local TabPadding =
    Instance.new("UIPadding")

TabPadding.PaddingTop =
    UDim.new(
        0,
        4
    )

TabPadding.PaddingBottom =
    UDim.new(
        0,
        8
    )

TabPadding.PaddingLeft =
    UDim.new(
        0,
        9
    )

TabPadding.PaddingRight =
    UDim.new(
        0,
        9
    )

TabPadding.Parent =
    TabScroll

-- ==================================================
-- TAB LIST
-- ==================================================

local TabList =
    Instance.new("UIListLayout")

TabList.Padding =
    UDim.new(
        0,
        6
    )

TabList.SortOrder =
    Enum.SortOrder.LayoutOrder

TabList.Parent =
    TabScroll

-- ==================================================
-- CONTENT
-- ==================================================

local Content =
    Instance.new("Frame")

Content.Name =
    "Content"

Content.Size =
    UDim2.new(
        1,
        -Settings.UI.SidebarWidth,
        1,
        -70
    )

Content.Position =
    UDim2.new(
        0,
        Settings.UI.SidebarWidth,
        0,
        70
    )

Content.BackgroundColor3 =
    Theme.Background

Content.BorderSizePixel =
    0

Content.ZIndex =
    5

Content.Parent =
    Main

Gradient(
    Content,
    Color3.fromRGB(
        14,
        14,
        14
    ),
    Color3.fromRGB(
        3,
        3,
        3
    ),
    135
)

-- ==================================================
-- CONTENT PADDING
-- ==================================================

local ContentPadding =
    Instance.new("UIPadding")

ContentPadding.PaddingTop =
    UDim.new(
        0,
        5
    )

ContentPadding.PaddingBottom =
    UDim.new(
        0,
        5
    )

ContentPadding.PaddingLeft =
    UDim.new(
        0,
        5
    )

ContentPadding.PaddingRight =
    UDim.new(
        0,
        5
    )

ContentPadding.Parent =
    Content

-- ==================================================
-- GLOBAL REFERENCES
-- ==================================================

_G.XENONBYTE_Main =
    Main

_G.XENONBYTE_TopBar =
    TopBar

_G.XENONBYTE_Sidebar =
    Sidebar

_G.XENONBYTE_TabScroll =
    TabScroll

_G.XENONBYTE_Content =
    Content

_G.XENONBYTE_ScreenGui =
    ScreenGui

_G.XENONBYTE_Toggle =
    Toggle

_G.XENONBYTE_GuiParent =
    GuiParent

-- ==================================================
-- DRAG SYSTEM
-- ==================================================

local function BindDrag(
    handle,
    target
)

    local dragging = false
    local dragStart
    local startPos
    local activeTouch

    handle.InputBegan:Connect(
        function(input)

            if
                input.UserInputType
                    == Enum.UserInputType.MouseButton1
                or
                input.UserInputType
                    == Enum.UserInputType.Touch
            then

                dragging = true

                activeTouch =
                    input.UserInputType
                        == Enum.UserInputType.Touch
                    and input
                    or nil

                dragStart =
                    input.Position

                startPos =
                    target.Position

            end

        end
    )

    UserInputService.InputChanged:Connect(
        function(input)

            if not dragging then
                return
            end

            if
                input.UserInputType
                    == Enum.UserInputType.Touch
                and activeTouch
                and input ~= activeTouch
            then
                return
            end

            if
                input.UserInputType
                    ~= Enum.UserInputType.MouseMovement
                and
                input.UserInputType
                    ~= Enum.UserInputType.Touch
            then
                return
            end

            local delta =
                input.Position
                - dragStart

            target.Position =
                UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset
                        + delta.X,

                    startPos.Y.Scale,
                    startPos.Y.Offset
                        + delta.Y
                )

        end
    )

    UserInputService.InputEnded:Connect(
        function(input)

            if
                input.UserInputType
                    == Enum.UserInputType.MouseButton1
                or
                (
                    activeTouch
                    and input == activeTouch
                )
            then

                dragging = false
                activeTouch = nil

            end

        end
    )

end

BindDrag(
    TopBar,
    Main
)

-- ==================================================
-- SHOW / HIDE
-- ==================================================

local isVisible = true

local function SetVisible(value)

    isVisible = value

    ScreenGui.Enabled =
        value

end

Toggle.MouseButton1Click:Connect(
    function()

        SetVisible(
            not isVisible
        )

        Tween(
            Toggle,

            TweenInfo.new(
                0.12,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),

            {
                Rotation =
                    isVisible
                    and 0
                    or 90
            }
        )

    end
)

Close.MouseButton1Click:Connect(
    function()

        SetVisible(false)

    end
)

-- ==================================================
-- CLOSE HOVER
-- ==================================================

Close.MouseEnter:Connect(
    function()

        Tween(
            Close,
            TweenInfo.new(0.1),
            {
                TextColor3 =
                    Color3.fromRGB(
                        255,
                        255,
                        255
                    )
            }
        )

    end
)

Close.MouseLeave:Connect(
    function()

        Tween(
            Close,
            TweenInfo.new(0.1),
            {
                TextColor3 =
                    Color3.fromRGB(
                        180,
                        180,
                        180
                    )
            }
        )

    end
)

-- ==================================================
-- BUBBLE DRAGGING
-- ==================================================

local toggleDragging = false
local toggleStart
local togglePos
local toggleTouch

Toggle.InputBegan:Connect(
    function(input)

        if
            input.UserInputType
                == Enum.UserInputType.MouseButton1
            or
            input.UserInputType
                == Enum.UserInputType.Touch
        then

            toggleDragging = true

            toggleTouch =
                input.UserInputType
                    == Enum.UserInputType.Touch
                and input
                or nil

            toggleStart =
                input.Position

            togglePos =
                Toggle.Position

        end

    end
)

UserInputService.InputChanged:Connect(
    function(input)

        if not toggleDragging then
            return
        end

        if
            input.UserInputType
                == Enum.UserInputType.Touch
            and toggleTouch
            and input ~= toggleTouch
        then
            return
        end

        if
            input.UserInputType
                ~= Enum.UserInputType.MouseMovement
            and
            input.UserInputType
                ~= Enum.UserInputType.Touch
        then
            return
        end

        local delta =
            input.Position
            - toggleStart

        Toggle.Position =
            UDim2.new(
                togglePos.X.Scale,
                togglePos.X.Offset
                    + delta.X,

                togglePos.Y.Scale,
                togglePos.Y.Offset
                    + delta.Y
            )

    end
)

UserInputService.InputEnded:Connect(
    function(input)

        if
            input.UserInputType
                == Enum.UserInputType.MouseButton1
            or
            (
                toggleTouch
                and input == toggleTouch
            )
        then

            toggleDragging = false
            toggleTouch = nil

        end

    end
)

print(
    "XenonByte modern bubble UI loaded"
)
