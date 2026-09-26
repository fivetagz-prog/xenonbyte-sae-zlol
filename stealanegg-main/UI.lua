-- ==================================================
-- XENONBYTE | CUSTOM MONOCHROME BUBBLE UI
-- ==================================================

local Services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UserInputService = game:GetService("UserInputService"),
    ContentProvider = game:GetService("ContentProvider"),
    CoreGui = game:GetService("CoreGui"),
}

local Settings = _G.XENONBYTE
local Theme = Settings.UI.Theme

local GuiParent = Services.CoreGui

pcall(function()
    if type(gethui) == "function" then
        local HUI = gethui()

        if HUI then
            GuiParent = HUI
        end
    end
end)

--==================================================
-- CLEAN OLD GUI
--==================================================

pcall(function()

    for _, Name in ipairs({
        "XENONBYTE_HUB",
        "ToggleGUI"
    }) do

        local Old =
            GuiParent:FindFirstChild(Name)

        if Old then
            Old:Destroy()
        end

    end

end)

--==================================================
-- UI HELPERS
--==================================================

local function Corner(parent, radius)

    local c =
        Instance.new("UICorner")

    c.CornerRadius =
        UDim.new(
            0,
            radius or 8
        )

    c.Parent = parent

    return c

end

local function Circle(parent)

    local c =
        Instance.new("UICorner")

    c.CornerRadius =
        UDim.new(
            1,
            0
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

    local st =
        Instance.new("UIStroke")

    st.Color =
        color or
        Color3.fromRGB(
            70,
            70,
            70
        )

    st.Thickness =
        thickness or 1

    st.Transparency =
        transparency or 0

    st.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    st.Parent = parent

    return st

end

local function Gradient(
    parent,
    a,
    b,
    rotation
)

    local g =
        Instance.new("UIGradient")

    g.Color =
        ColorSequence.new({

            ColorSequenceKeypoint.new(
                0,
                a
            ),

            ColorSequenceKeypoint.new(
                1,
                b
            ),

        })

    g.Rotation =
        rotation or 90

    g.Parent = parent

    return g

end

--==================================================
-- OPEN GUI / FLOATING LOGO
--==================================================

local ToggleScreenGui =
    Instance.new("ScreenGui")

ToggleScreenGui.Name =
    "ToggleGUI"

ToggleScreenGui.ResetOnSpawn =
    false

ToggleScreenGui.IgnoreGuiInset =
    true

ToggleScreenGui.ZIndexBehavior =
    Enum.ZIndexBehavior.Sibling

ToggleScreenGui.DisplayOrder =
    1001

ToggleScreenGui.Parent =
    GuiParent

--==================================================
-- LOGO BUBBLE
--==================================================

local Toggle =
    Instance.new("ImageButton")

Toggle.Name =
    "OpenGUI"

Toggle.Size =
    UDim2.new(
        0,
        58,
        0,
        58
    )

Toggle.Position =
    UDim2.new(
        0.02,
        0,
        0.5,
        -29
    )

Toggle.BackgroundColor3 =
    Color3.fromRGB(
        8,
        8,
        8
    )

Toggle.BackgroundTransparency =
    0

Toggle.BorderSizePixel =
    0

Toggle.AutoButtonColor =
    false

Toggle.Image =
    "rbxassetid://126314624782419"

Toggle.ScaleType =
    Enum.ScaleType.Fit

Toggle.ImageTransparency =
    0

Toggle.ZIndex =
    100

Toggle.Parent =
    ToggleScreenGui

-- Perfect circular outer bubble
Circle(Toggle)

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

--==================================================
-- LOGO HOLDER
--==================================================

local LogoHolder =
    Instance.new("Frame")

LogoHolder.Name =
    "LogoHolder"

LogoHolder.Size =
    UDim2.new(
        0,
        48,
        0,
        48
    )

LogoHolder.Position =
    UDim2.new(
        0.5,
        -24,
        0.5,
        -24
    )

LogoHolder.BackgroundTransparency =
    1

LogoHolder.BorderSizePixel =
    0

LogoHolder.ZIndex =
    101

LogoHolder.Parent =
    Toggle

--==================================================
-- LOGO IMAGE
--==================================================

local Logo =
    Instance.new("ImageLabel")

Logo.Name =
    "Logo"

Logo.Size =
    UDim2.new(
        1,
        0,
        1,
        0
    )

Logo.Position =
    UDim2.new(
        0,
        0,
        0,
        0
    )

Logo.BackgroundTransparency =
    1

Logo.BorderSizePixel =
    0

Logo.Image =
    "rbxassetid://126314624782419"

Logo.ScaleType =
    Enum.ScaleType.Fit

Logo.ImageTransparency =
    0

Logo.ZIndex =
    102

Logo.Parent =
    LogoHolder

--==================================================
-- MAIN WINDOW
--==================================================

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
    999

ScreenGui.Parent =
    GuiParent

--==================================================
-- MAIN
--==================================================

local Main =
    Instance.new("Frame")

Main.Name =
    "Main"

Main.Size =
    UDim2.new(
        0,
        Settings.UI.Width,
        0,
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
    14
)

Stroke(
    Main,
    Color3.fromRGB(
        90,
        90,
        90
    ),
    1.5,
    0.1
)

Gradient(
    Main,
    Color3.fromRGB(
        15,
        15,
        15
    ),
    Color3.fromRGB(
        4,
        4,
        4
    ),
    135
)

--==================================================
-- HEADER
--==================================================

local TopBar =
    Instance.new("Frame")

TopBar.Name =
    "TopBar"

TopBar.Size =
    UDim2.new(
        1,
        0,
        0,
        62
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

--==================================================
-- HEADER LOGO
--==================================================

local HeaderLogoHolder =
    Instance.new("Frame")

HeaderLogoHolder.Size =
    UDim2.new(
        0,
        38,
        0,
        38
    )

HeaderLogoHolder.Position =
    UDim2.new(
        0,
        12,
        0,
        12
    )

HeaderLogoHolder.BackgroundColor3 =
    Color3.fromRGB(
        245,
        245,
        245
    )

HeaderLogoHolder.BorderSizePixel =
    0

HeaderLogoHolder.ZIndex =
    22

HeaderLogoHolder.Parent =
    TopBar

Circle(
    HeaderLogoHolder
)

local HeaderLogo =
    Instance.new("ImageLabel")

HeaderLogo.Size =
    UDim2.new(
        1,
        -6,
        1,
        -6
    )

HeaderLogo.Position =
    UDim2.new(
        0,
        3,
        0,
        3
    )

HeaderLogo.BackgroundTransparency =
    1

HeaderLogo.BorderSizePixel =
    0

HeaderLogo.Image =
    "rbxassetid://126314624782419"

HeaderLogo.ScaleType =
    Enum.ScaleType.Fit

HeaderLogo.ZIndex =
    23

HeaderLogo.Parent =
    HeaderLogoHolder

--==================================================
-- TITLE
--==================================================

local Title =
    Instance.new("TextLabel")

Title.Name =
    "Title"

Title.Size =
    UDim2.new(
        1,
        -65,
        0,
        26
    )

Title.Position =
    UDim2.new(
        0,
        58,
        0,
        9
    )

Title.BackgroundTransparency =
    1

Title.Text =
    Settings.Name

Title.TextColor3 =
    Theme.Text

Title.TextSize =
    17

Title.TextXAlignment =
    Enum.TextXAlignment.Left

Title.Font =
    Enum.Font.GothamBold

Title.ZIndex =
    21

Title.Parent =
    TopBar

--==================================================
-- SUBTITLE
--==================================================

local Subtitle =
    Instance.new("TextLabel")

Subtitle.Name =
    "Subtitle"

Subtitle.Size =
    UDim2.new(
        1,
        -65,
        0,
        18
    )

Subtitle.Position =
    UDim2.new(
        0,
        58,
        0,
        34
    )

Subtitle.BackgroundTransparency =
    1

Subtitle.Text =
    Settings.Version

Subtitle.TextColor3 =
    Theme.SubText

Subtitle.TextSize =
    9

Subtitle.TextXAlignment =
    Enum.TextXAlignment.Left

Subtitle.Font =
    Enum.Font.GothamMedium

Subtitle.ZIndex =
    21

Subtitle.Parent =
    TopBar

--==================================================
-- HEADER LINE
--==================================================

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
        120,
        120,
        120
    )

TopLine.BorderSizePixel =
    0

TopLine.ZIndex =
    23

TopLine.Parent =
    TopBar

--==================================================
-- SIDEBAR
--==================================================

local Sidebar =
    Instance.new("Frame")

Sidebar.Name =
    "Sidebar"

Sidebar.Size =
    UDim2.new(
        0,
        Settings.UI.SidebarWidth,
        1,
        -62
    )

Sidebar.Position =
    UDim2.new(
        0,
        0,
        0,
        62
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
        20,
        20,
        20
    ),
    Color3.fromRGB(
        8,
        8,
        8
    ),
    90
)

--==================================================
-- MENU TITLE
--==================================================

local SideTitle =
    Instance.new("TextLabel")

SideTitle.Size =
    UDim2.new(
        1,
        -20,
        0,
        22
    )

SideTitle.Position =
    UDim2.new(
        0,
        10,
        0,
        9
    )

SideTitle.BackgroundTransparency =
    1

SideTitle.Text =
    "MENU"

SideTitle.TextColor3 =
    Color3.fromRGB(
        125,
        125,
        125
    )

SideTitle.TextSize =
    9

SideTitle.Font =
    Enum.Font.GothamBold

SideTitle.TextXAlignment =
    Enum.TextXAlignment.Left

SideTitle.ZIndex =
    7

SideTitle.Parent =
    Sidebar

--==================================================
-- TAB SCROLL
--==================================================

local TabScroll =
    Instance.new("ScrollingFrame")

TabScroll.Name =
    "TabScroll"

TabScroll.Size =
    UDim2.new(
        1,
        0,
        1,
        -38
    )

TabScroll.Position =
    UDim2.new(
        0,
        0,
        0,
        32
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
        6
    )

TabPadding.PaddingLeft =
    UDim.new(
        0,
        7
    )

TabPadding.PaddingRight =
    UDim.new(
        0,
        7
    )

TabPadding.Parent =
    TabScroll

local TabList =
    Instance.new("UIListLayout")

TabList.Padding =
    UDim.new(
        0,
        5
    )

TabList.SortOrder =
    Enum.SortOrder.LayoutOrder

TabList.Parent =
    TabScroll

--==================================================
-- CONTENT
--==================================================

local Content =
    Instance.new("Frame")

Content.Name =
    "Content"

Content.Size =
    UDim2.new(
        1,
        -Settings.UI.SidebarWidth,
        1,
        -62
    )

Content.Position =
    UDim2.new(
        0,
        Settings.UI.SidebarWidth,
        0,
        62
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
        12,
        12,
        12
    ),
    Color3.fromRGB(
        3,
        3,
        3
    ),
    135
)

--==================================================
-- GLOBAL REFERENCES
--==================================================

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

_G.XENONBYTE_OpenGuiLogo =
    Logo

--==================================================
-- MAIN WINDOW DRAG
--==================================================

local function BindDrag(
    handle,
    target
)

    local dragging = false
    local dragStart = nil
    local startPos = nil
    local activeTouch = nil

    handle.InputBegan:Connect(
        function(input)

            if
                input.UserInputType ==
                    Enum.UserInputType.MouseButton1
                or
                input.UserInputType ==
                    Enum.UserInputType.Touch
            then

                dragging = true

                activeTouch =
                    input.UserInputType ==
                        Enum.UserInputType.Touch
                    and input
                    or nil

                dragStart =
                    input.Position

                startPos =
                    target.Position

            end

        end
    )

    Services.UserInputService.InputChanged:Connect(
        function(input)

            if not dragging then
                return
            end

            if
                input.UserInputType ==
                    Enum.UserInputType.Touch
                and
                activeTouch
                and
                input ~= activeTouch
            then

                return

            end

            if
                input.UserInputType ~=
                    Enum.UserInputType.MouseMovement
                and
                input.UserInputType ~=
                    Enum.UserInputType.Touch
            then

                return

            end

            local delta =
                input.Position -
                dragStart

            target.Position =
                UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset +
                        delta.X,

                    startPos.Y.Scale,
                    startPos.Y.Offset +
                        delta.Y
                )

        end
    )

    Services.UserInputService.InputEnded:Connect(
        function(input)

            if
                input.UserInputType ==
                    Enum.UserInputType.MouseButton1
                or
                (
                    activeTouch
                    and
                    input == activeTouch
                )
            then

                dragging = false
                dragStart = nil
                startPos = nil
                activeTouch = nil

            end

        end
    )

end

BindDrag(
    TopBar,
    Main
)

--==================================================
-- OPEN GUI BUBBLE DRAG
--==================================================

local toggleDragging = false
local toggleStart = nil
local togglePos = nil
local toggleTouch = nil

Toggle.InputBegan:Connect(
    function(input)

        if
            input.UserInputType ==
                Enum.UserInputType.MouseButton1
            or
            input.UserInputType ==
                Enum.UserInputType.Touch
        then

            toggleDragging = true

            toggleTouch =
                input.UserInputType ==
                    Enum.UserInputType.Touch
                and input
                or nil

            toggleStart =
                input.Position

            togglePos =
                Toggle.Position

        end

    end
)

Services.UserInputService.InputChanged:Connect(
    function(input)

        if not toggleDragging then
            return
        end

        if
            input.UserInputType ==
                Enum.UserInputType.Touch
            and
            toggleTouch
            and
            input ~= toggleTouch
        then

            return

        end

        if
            input.UserInputType ~=
                Enum.UserInputType.MouseMovement
            and
            input.UserInputType ~=
                Enum.UserInputType.Touch
        then

            return

        end

        local delta =
            input.Position -
            toggleStart

        Toggle.Position =
            UDim2.new(
                togglePos.X.Scale,
                togglePos.X.Offset +
                    delta.X,

                togglePos.Y.Scale,
                togglePos.Y.Offset +
                    delta.Y
            )

    end
)

Services.UserInputService.InputEnded:Connect(
    function(input)

        if
            input.UserInputType ==
                Enum.UserInputType.MouseButton1
            or
            (
                toggleTouch
                and
                input == toggleTouch
            )
        then

            toggleDragging = false
            toggleStart = nil
            togglePos = nil
            toggleTouch = nil

        end

    end
)

--==================================================
-- OPEN / CLOSE GUI
--==================================================

local isUIVisible = true

Toggle.MouseButton1Click:Connect(
    function()

        isUIVisible =
            not isUIVisible

        ScreenGui.Enabled =
            isUIVisible

        -- Press animation
        Services.TweenService:Create(
            Toggle,
            TweenInfo.new(
                0.12,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    UDim2.new(
                        0,
                        50,
                        0,
                        50
                    )
            }
        ):Play()

        task.wait(0.12)

        Services.TweenService:Create(
            Toggle,
            TweenInfo.new(
                0.12,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    UDim2.new(
                        0,
                        58,
                        0,
                        58
                    )
            }
        ):Play()

    end
)

--==================================================
-- PRELOAD LOGO
--==================================================

pcall(function()

    Services.ContentProvider:PreloadAsync({
        Logo,
        HeaderLogo,
    })

end)

--==================================================
-- FINAL
--==================================================

print(
    "XenonByte custom bubble UI loaded"
)

print(
    "Open GUI Logo: rbxassetid://126314624782419"
)
