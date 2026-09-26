-- ==================================================
-- XENONBYTE HUB | COMPONENTS
-- ==================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Settings = _G.XENONBYTE
local Theme = Settings.UI.Theme

local Components = {}

-- ==================================================
-- HELPERS
-- ==================================================

local function Corner(parent, radius)

    local c = Instance.new("UICorner")

    c.CornerRadius =
        UDim.new(0, radius or 8)

    c.Parent = parent

    return c

end

local function Stroke(parent, color, thickness, transparency)

    local s = Instance.new("UIStroke")

    s.Color =
        color or Color3.fromRGB(70, 70, 70)

    s.Thickness =
        thickness or 1

    s.Transparency =
        transparency or 0

    s.Parent = parent

    return s

end

local function Gradient(parent, color1, color2, rotation)

    local g = Instance.new("UIGradient")

    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })

    g.Rotation =
        rotation or 90

    g.Parent = parent

    return g

end

local function Tween(object, properties, duration)

    local tween =
        TweenService:Create(
            object,

            TweenInfo.new(
                duration or 0.15,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),

            properties
        )

    tween:Play()

    return tween

end

-- ==================================================
-- SECTION
-- ==================================================

function Components.Section(parent, title)

    local Section =
        Instance.new("Frame")

    Section.Name =
        title or "Section"

    Section.Size =
        UDim2.new(
            1,
            0,
            0,
            42
        )

    Section.BackgroundColor3 =
        Color3.fromRGB(
            16,
            16,
            16
        )

    Section.BorderSizePixel =
        0

    Section.Parent =
        parent

    Corner(
        Section,
        10
    )

    Stroke(
        Section,
        Color3.fromRGB(
            65,
            65,
            65
        ),
        1,
        0.4
    )

    Gradient(
        Section,
        Color3.fromRGB(
            25,
            25,
            25
        ),
        Color3.fromRGB(
            12,
            12,
            12
        ),
        90
    )

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -20,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(
            10,
            0
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        tostring(title or "SECTION")

    Label.TextColor3 =
        Theme.Text

    Label.TextSize =
        11

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Font =
        Enum.Font.GothamBold

    Label.Parent =
        Section

    return Section

end

-- ==================================================
-- LABEL
-- ==================================================

function Components.Label(parent, text)

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -4,
            0,
            28
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        tostring(text or "")

    Label.TextColor3 =
        Theme.SubText

    Label.TextSize =
        10

    Label.TextWrapped =
        true

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Font =
        Enum.Font.GothamMedium

    Label.Parent =
        parent

    return Label

end

-- ==================================================
-- BUTTON
-- ==================================================

function Components.Button(
    parent,
    text,
    callback
)

    local Button =
        Instance.new("TextButton")

    Button.Name =
        tostring(text or "Button")

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            36
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            24,
            24,
            24
        )

    Button.BorderSizePixel =
        0

    Button.AutoButtonColor =
        false

    Button.Text =
        tostring(text or "Button")

    Button.TextColor3 =
        Theme.Text

    Button.TextSize =
        10

    Button.Font =
        Enum.Font.GothamBold

    Button.Parent =
        parent

    Corner(
        Button,
        9
    )

    local border =
        Stroke(
            Button,
            Color3.fromRGB(
                65,
                65,
                65
            ),
            1,
            0.35
        )

    Gradient(
        Button,
        Color3.fromRGB(
            34,
            34,
            34
        ),
        Color3.fromRGB(
            14,
            14,
            14
        ),
        90
    )

    Button.MouseEnter:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Color3.fromRGB(
                            48,
                            48,
                            48
                        )
                }
            )

            Tween(
                border,
                {
                    Transparency = 0
                }
            )

        end
    )

    Button.MouseLeave:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Color3.fromRGB(
                            24,
                            24,
                            24
                        )
                }
            )

            Tween(
                border,
                {
                    Transparency = 0.35
                }
            )

        end
    )

    Button.MouseButton1Down:Connect(
        function()

            Tween(
                Button,
                {
                    Size =
                        UDim2.new(
                            1,
                            -2,
                            0,
                            34
                        )
                },
                0.08
            )

        end
    )

    Button.MouseButton1Up:Connect(
        function()

            Tween(
                Button,
                {
                    Size =
                        UDim2.new(
                            1,
                            0,
                            0,
                            36
                        )
                },
                0.08
            )

        end
    )

    if callback then

        Button.MouseButton1Click:Connect(
            function()

                task.spawn(
                    function()

                        local success, err =
                            pcall(callback)

                        if not success then
                            warn(
                                "[XenonByte] Button error:",
                                err
                            )
                        end

                    end
                )

            end
        )

    end

    return Button

end

-- ==================================================
-- TOGGLE
-- ==================================================

function Components.Toggle(
    parent,
    text,
    default,
    callback
)

    local enabled =
        default == true

    local Holder =
        Instance.new("Frame")

    Holder.Name =
        tostring(text or "Toggle")

    Holder.Size =
        UDim2.new(
            1,
            0,
            0,
            40
        )

    Holder.BackgroundColor3 =
        Color3.fromRGB(
            18,
            18,
            18
        )

    Holder.BorderSizePixel =
        0

    Holder.Parent =
        parent

    Corner(
        Holder,
        9
    )

    Stroke(
        Holder,
        Color3.fromRGB(
            55,
            55,
            55
        ),
        1,
        0.45
    )

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -65,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(
            12,
            0
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        tostring(text or "Toggle")

    Label.TextColor3 =
        Theme.Text

    Label.TextSize =
        10

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Font =
        Enum.Font.GothamMedium

    Label.Parent =
        Holder

    local Switch =
        Instance.new("TextButton")

    Switch.Size =
        UDim2.fromOffset(
            42,
            22
        )

    Switch.Position =
        UDim2.new(
            1,
            -52,
            0.5,
            -11
        )

    Switch.BackgroundColor3 =
        Color3.fromRGB(
            42,
            42,
            42
        )

    Switch.BorderSizePixel =
        0

    Switch.Text =
        ""

    Switch.AutoButtonColor =
        false

    Switch.Parent =
        Holder

    Corner(
        Switch,
        12
    )

    local Knob =
        Instance.new("Frame")

    Knob.Size =
        UDim2.fromOffset(
            16,
            16
        )

    Knob.Position =
        UDim2.fromOffset(
            3,
            3
        )

    Knob.BackgroundColor3 =
        Color3.fromRGB(
            180,
            180,
            180
        )

    Knob.BorderSizePixel =
        0

    Knob.Parent =
        Switch

    Corner(
        Knob,
        8
    )

    local function Update(value)

        enabled =
            value == true

        if enabled then

            Tween(
                Switch,
                {
                    BackgroundColor3 =
                        Color3.fromRGB(
                            230,
                            230,
                            230
                        )
                }
            )

            Tween(
                Knob,
                {
                    Position =
                        UDim2.new(
                            1,
                            -19,
                            0,
                            3
                        ),

                    BackgroundColor3 =
                        Color3.fromRGB(
                            15,
                            15,
                            15
                        )
                }
            )

        else

            Tween(
                Switch,
                {
                    BackgroundColor3 =
                        Color3.fromRGB(
                            42,
                            42,
                            42
                        )
                }
            )

            Tween(
                Knob,
                {
                    Position =
                        UDim2.fromOffset(
                            3,
                            3
                        ),

                    BackgroundColor3 =
                        Color3.fromRGB(
                            180,
                            180,
                            180
                        )
                }
            )

        end

    end

    Switch.MouseButton1Click:Connect(
        function()

            Update(
                not enabled
            )

            if callback then

                task.spawn(
                    function()

                        local success, err =
                            pcall(
                                callback,
                                enabled
                            )

                        if not success then
                            warn(
                                "[XenonByte] Toggle error:",
                                err
                            )
                        end

                    end
                )

            end

        end
    )

    Update(
        enabled
    )

    return {

        Instance = Holder,

        Button = Switch,

        Get = function()
            return enabled
        end,

        Set = function(value)

            Update(
                value
            )

            if callback then
                callback(
                    enabled
                )
            end

        end

    }

end

-- ==================================================
-- SLIDER
-- ==================================================

function Components.Slider(
    parent,
    text,
    min,
    max,
    default,
    callback
)

    min =
        tonumber(min)
        or 0

    max =
        tonumber(max)
        or 100

    default =
        math.clamp(
            tonumber(default)
                or min,
            min,
            max
        )

    local value =
        default

    local Holder =
        Instance.new("Frame")

    Holder.Size =
        UDim2.new(
            1,
            0,
            0,
            58
        )

    Holder.BackgroundColor3 =
        Color3.fromRGB(
            18,
            18,
            18
        )

    Holder.BorderSizePixel =
        0

    Holder.Parent =
        parent

    Corner(
        Holder,
        9
    )

    Stroke(
        Holder,
        Color3.fromRGB(
            55,
            55,
            55
        ),
        1,
        0.45
    )

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -80,
            0,
            22
        )

    Label.Position =
        UDim2.fromOffset(
            12,
            5
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        tostring(text or "Slider")

    Label.TextColor3 =
        Theme.Text

    Label.TextSize =
        10

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Font =
        Enum.Font.GothamMedium

    Label.Parent =
        Holder

    local ValueLabel =
        Instance.new("TextLabel")

    ValueLabel.Size =
        UDim2.fromOffset(
            55,
            22
        )

    ValueLabel.Position =
        UDim2.new(
            1,
            -65,
            0,
            5
        )

    ValueLabel.BackgroundTransparency =
        1

    ValueLabel.TextColor3 =
        Theme.SubText

    ValueLabel.TextSize =
        9

    ValueLabel.TextXAlignment =
        Enum.TextXAlignment.Right

    ValueLabel.Font =
        Enum.Font.GothamBold

    ValueLabel.Parent =
        Holder

    local Bar =
        Instance.new("Frame")

    Bar.Size =
        UDim2.new(
            1,
            -24,
            0,
            6
        )

    Bar.Position =
        UDim2.fromOffset(
            12,
            37
        )

    Bar.BackgroundColor3 =
        Color3.fromRGB(
            40,
            40,
            40
        )

    Bar.BorderSizePixel =
        0

    Bar.Parent =
        Holder

    Corner(
        Bar,
        5
    )

    local Fill =
        Instance.new("Frame")

    Fill.Size =
        UDim2.new(
            0,
            0,
            1,
            0
        )

    Fill.BackgroundColor3 =
        Color3.fromRGB(
            230,
            230,
            230
        )

    Fill.BorderSizePixel =
        0

    Fill.Parent =
        Bar

    Corner(
        Fill,
        5
    )

    local function SetValue(newValue)

        value =
            math.clamp(
                newValue,
                min,
                max
            )

        local alpha =
            (value - min)
            / (max - min)

        if max == min then
            alpha = 0
        end

        Fill.Size =
            UDim2.new(
                alpha,
                0,
                1,
                0
            )

        ValueLabel.Text =
            string.format(
                "%.2f",
                value
            )

        if callback then

            task.spawn(
                function()
                    pcall(
                        callback,
                        value
                    )
                end
            )

        end

    end

    local function FromInput(input)

        local x =
            input.Position.X

        local relative =
            math.clamp(
                x - Bar.AbsolutePosition.X,
                0,
                Bar.AbsoluteSize.X
            )

        local alpha =
            relative
            / Bar.AbsoluteSize.X

        SetValue(
            min
            + (
                max - min
            ) * alpha
        )

    end

    Bar.InputBegan:Connect(
        function(input)

            if
                input.UserInputType
                    == Enum.UserInputType.MouseButton1
                or
                input.UserInputType
                    == Enum.UserInputType.Touch
            then

                FromInput(
                    input
                )

            end

        end
    )

    UserInputService.InputChanged:Connect(
        function(input)

            if
                input.UserInputType
                    == Enum.UserInputType.MouseMovement
                or
                input.UserInputType
                    == Enum.UserInputType.Touch
            then

                if
                    UserInputService:IsMouseButtonPressed(
                        Enum.UserInputType.MouseButton1
                    )
                then

                    FromInput(
                        input
                    )

                end

            end

        end
    )

    SetValue(
        value
    )

    return {

        Instance = Holder,

        Get = function()
            return value
        end,

        Set = function(newValue)
            SetValue(
                newValue
            )
        end

    }

end

-- ==================================================
-- DROPDOWN
-- ==================================================

function Components.Dropdown(
    parent,
    text,
    options,
    default,
    callback
)

    options =
        options
        or {}

    local selected =
        default
        or options[1]

    local Holder =
        Instance.new("Frame")

    Holder.Size =
        UDim2.new(
            1,
            0,
            0,
            42
        )

    Holder.BackgroundColor3 =
        Color3.fromRGB(
            18,
            18,
            18
        )

    Holder.BorderSizePixel =
        0

    Holder.ClipsDescendants =
        true

    Holder.Parent =
        parent

    Corner(
        Holder,
        9
    )

    Stroke(
        Holder,
        Color3.fromRGB(
            55,
            55,
            55
        ),
        1,
        0.45
    )

    local Button =
        Instance.new("TextButton")

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            42
        )

    Button.BackgroundTransparency =
        1

    Button.Text =
        tostring(text or "Dropdown")
        .. "  •  "
        .. tostring(selected or "None")

    Button.TextColor3 =
        Theme.Text

    Button.TextSize =
        10

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.Parent =
        Holder

    local Padding =
        Instance.new("UIPadding")

    Padding.PaddingLeft =
        UDim.new(
            0,
            12
        )

    Padding.Parent =
        Button

    local Open = false

    for index, option in ipairs(options) do

        local Option =
            Instance.new("TextButton")

        Option.Size =
            UDim2.new(
                1,
                -12,
                0,
                30
            )

        Option.Position =
            UDim2.new(
                0,
                6,
                0,
                42
                    + (
                        index - 1
                    ) * 32
            )

        Option.BackgroundColor3 =
            Color3.fromRGB(
                28,
                28,
                28
            )

        Option.BorderSizePixel =
            0

        Option.Text =
            tostring(option)

        Option.TextColor3 =
            Theme.SubText

        Option.TextSize =
            9

        Option.Font =
            Enum.Font.GothamMedium

        Option.Parent =
            Holder

        Corner(
            Option,
            7
        )

        Option.MouseButton1Click:Connect(
            function()

                selected =
                    option

                Button.Text =
                    tostring(text or "Dropdown")
                    .. "  •  "
                    .. tostring(selected)

                Open = false

                Holder.Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        42
                    )

                if callback then
                    callback(
                        selected
                    )
                end

            end
        )

    end

    Button.MouseButton1Click:Connect(
        function()

            Open =
                not Open

            if Open then

                Holder.Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        44
                        + (
                            #options
                            * 32
                        )
                    )

            else

                Holder.Size =
                    UDim2.new(
                        1,
                        0,
                        0,
                        42
                    )

            end

        end
    )

    return {

        Instance = Holder,

        Get = function()
            return selected
        end,

        Set = function(option)

            selected =
                option

            Button.Text =
                tostring(text or "Dropdown")
                .. "  •  "
                .. tostring(selected)

        end

    }

end

-- ==================================================
-- TAB BUTTON
-- ==================================================

function Components.TabButton(
    parent,
    text,
    icon,
    callback
)

    local Button =
        Instance.new("TextButton")

    Button.Name =
        tostring(text or "Tab")

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            Settings.UI.TabHeight
        )

    Button.BackgroundColor3 =
        Color3.fromRGB(
            20,
            20,
            20
        )

    Button.BackgroundTransparency =
        1

    Button.BorderSizePixel =
        0

    Button.AutoButtonColor =
        false

    Button.Text =
        ""

    Button.Parent =
        parent

    Corner(
        Button,
        8
    )

    local Icon =
        Instance.new("TextLabel")

    Icon.Size =
        UDim2.fromOffset(
            26,
            32
        )

    Icon.Position =
        UDim2.fromOffset(
            5,
            0
        )

    Icon.BackgroundTransparency =
        1

    Icon.Text =
        tostring(icon or "•")

    Icon.TextColor3 =
        Theme.SubText

    Icon.TextSize =
        11

    Icon.Font =
        Enum.Font.GothamBold

    Icon.Parent =
        Button

    local Label =
        Instance.new("TextLabel")

    Label.Size =
        UDim2.new(
            1,
            -36,
            1,
            0
        )

    Label.Position =
        UDim2.fromOffset(
            34,
            0
        )

    Label.BackgroundTransparency =
        1

    Label.Text =
        tostring(text or "Tab")

    Label.TextColor3 =
        Theme.SubText

    Label.TextSize =
        9

    Label.TextXAlignment =
        Enum.TextXAlignment.Left

    Label.Font =
        Enum.Font.GothamMedium

    Label.Parent =
        Button

    local function SetActive(active)

        if active then

            Tween(
                Button,
                {
                    BackgroundTransparency = 0,
                    BackgroundColor3 =
                        Color3.fromRGB(
                            42,
                            42,
                            42
                        )
                }
            )

            Tween(
                Icon,
                {
                    TextColor3 =
                        Theme.Text
                }
            )

            Tween(
                Label,
                {
                    TextColor3 =
                        Theme.Text
                }
            )

        else

            Tween(
                Button,
                {
                    BackgroundTransparency = 1
                }
            )

            Tween(
                Icon,
                {
                    TextColor3 =
                        Theme.SubText
                }
            )

            Tween(
                Label,
                {
                    TextColor3 =
                        Theme.SubText
                }
            )

        end

    end

    Button.MouseEnter:Connect(
        function()

            if Button:GetAttribute(
                "Active"
            ) ~= true then

                Tween(
                    Button,
                    {
                        BackgroundTransparency =
                            0.65
                    }
                )

            end

        end
    )

    Button.MouseLeave:Connect(
        function()

            if Button:GetAttribute(
                "Active"
            ) ~= true then

                Tween(
                    Button,
                    {
                        BackgroundTransparency =
                            1
                    }
                )

            end

        end
    )

    Button.MouseButton1Click:Connect(
        function()

            if callback then
                callback()
            end

        end
    )

    return {

        Instance = Button,

        SetActive = function(active)

            Button:SetAttribute(
                "Active",
                active
            )

            SetActive(
                active
            )

        end

    }

end

-- ==================================================
-- CARD
-- ==================================================

function Components.Card(
    parent,
    title,
    description
)

    local Card =
        Instance.new("Frame")

    Card.Name =
        tostring(title or "Card")

    Card.Size =
        UDim2.new(
            1,
            0,
            0,
            70
        )

    Card.BackgroundColor3 =
        Color3.fromRGB(
            18,
            18,
            18
        )

    Card.BorderSizePixel =
        0

    Card.Parent =
        parent

    Corner(
        Card,
        11
    )

    Stroke(
        Card,
        Color3.fromRGB(
            65,
            65,
            65
        ),
        1,
        0.35
    )

    Gradient(
        Card,
        Color3.fromRGB(
            27,
            27,
            27
        ),
        Color3.fromRGB(
            12,
            12,
            12
        ),
        90
    )

    local Title =
        Instance.new("TextLabel")

    Title.Size =
        UDim2.new(
            1,
            -24,
            0,
            23
        )

    Title.Position =
        UDim2.fromOffset(
            12,
            9
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        tostring(title or "Card")

    Title.TextColor3 =
        Theme.Text

    Title.TextSize =
        11

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.Font =
        Enum.Font.GothamBold

    Title.Parent =
        Card

    local Description =
        Instance.new("TextLabel")

    Description.Size =
        UDim2.new(
            1,
            -24,
            0,
            25
        )

    Description.Position =
        UDim2.fromOffset(
            12,
            32
        )

    Description.BackgroundTransparency =
        1

    Description.Text =
        tostring(description or "")

    Description.TextColor3 =
        Theme.SubText

    Description.TextSize =
        9

    Description.TextWrapped =
        true

    Description.TextXAlignment =
        Enum.TextXAlignment.Left

    Description.Font =
        Enum.Font.GothamMedium

    Description.Parent =
        Card

    return Card

end

-- ==================================================
-- EXPORT
-- ==================================================

_G.XENONBYTE_Components =
    Components

return Components
