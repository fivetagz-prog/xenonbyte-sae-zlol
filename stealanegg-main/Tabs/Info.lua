--==================================================
-- XENONBYTE HUB | TAB | Info
-- ✅ BLACK / WHITE GRADIENT UI
--==================================================

local TabsManager = _G.XENONBYTE_TabsManager
local TweenService = game:GetService("TweenService")

local InfoTab, InfoPage = TabsManager:RegisterTab("Info", 1, "INFO")

--==================================================
-- INFO CONTENT
--==================================================
CreateSectionTitle(
    InfoPage,
    "XENONBYTE HUB | Steal An Egg",
    1
)

--==================================================
-- TITLE
--==================================================
local TitleHolder = Instance.new("Frame")
TitleHolder.Size = UDim2.new(1, 0, 0, 48)
TitleHolder.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
TitleHolder.BorderSizePixel = 0
TitleHolder.LayoutOrder = 2
TitleHolder.Parent = InfoPage

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 9)
TitleCorner.Parent = TitleHolder

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = Color3.fromRGB(80, 80, 80)
TitleStroke.Thickness = 1
TitleStroke.Transparency = 0.2
TitleStroke.Parent = TitleHolder

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleHolder

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -24, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "XenonByte Hub"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 245)
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleHolder

--==================================================
-- GROUP DISCORD
--==================================================
local GroupLabel = Instance.new("TextLabel")
GroupLabel.Size = UDim2.new(1, 0, 0, 24)
GroupLabel.BackgroundTransparency = 1
GroupLabel.Text = "Join My Discord Server"
GroupLabel.TextColor3 = Color3.fromRGB(205, 205, 205)
GroupLabel.TextSize = 13
GroupLabel.TextXAlignment = Enum.TextXAlignment.Left
GroupLabel.Font = Enum.Font.GothamMedium
GroupLabel.LayoutOrder = 3
GroupLabel.Parent = InfoPage

--==================================================
-- DISCORD LINK
--==================================================
local LinkBtn = Instance.new("TextButton")
LinkBtn.Size = UDim2.new(1, 0, 0, 36)
LinkBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LinkBtn.BorderSizePixel = 0
LinkBtn.Text = "Link : https://discord.gg/tFgmr4H5Qn"
LinkBtn.TextColor3 = Color3.fromRGB(235, 235, 235)
LinkBtn.TextSize = 12
LinkBtn.TextXAlignment = Enum.TextXAlignment.Left
LinkBtn.Font = Enum.Font.GothamMedium
LinkBtn.AutoButtonColor = false
LinkBtn.LayoutOrder = 4
LinkBtn.Parent = InfoPage

local LinkCorner = Instance.new("UICorner")
LinkCorner.CornerRadius = UDim.new(0, 8)
LinkCorner.Parent = LinkBtn

local LinkStroke = Instance.new("UIStroke")
LinkStroke.Color = Color3.fromRGB(105, 105, 105)
LinkStroke.Thickness = 1
LinkStroke.Transparency = 0.15
LinkStroke.Parent = LinkBtn

local LinkGradient = Instance.new("UIGradient")
LinkGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))
})
LinkGradient.Rotation = 90
LinkGradient.Parent = LinkBtn

local LinkPadding = Instance.new("UIPadding")
LinkPadding.PaddingLeft = UDim.new(0, 12)
LinkPadding.PaddingRight = UDim.new(0, 12)
LinkPadding.Parent = LinkBtn

--==================================================
-- COPY BUTTON
--==================================================
local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 120, 0, 34)
CopyBtn.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
CopyBtn.BorderSizePixel = 0
CopyBtn.Text = "COPY LINK"
CopyBtn.TextColor3 = Color3.fromRGB(10, 10, 10)
CopyBtn.TextSize = 12
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.AutoButtonColor = false
CopyBtn.LayoutOrder = 5
CopyBtn.Parent = InfoPage

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyBtn

local CopyStroke = Instance.new("UIStroke")
CopyStroke.Color = Color3.fromRGB(255, 255, 255)
CopyStroke.Thickness = 1
CopyStroke.Transparency = 0.2
CopyStroke.Parent = CopyBtn

local CopyGradient = Instance.new("UIGradient")
CopyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 185, 185))
})
CopyGradient.Rotation = 90
CopyGradient.Parent = CopyBtn

--==================================================
-- COPY FUNCTION
--==================================================
local DISCORD_LINK = "https://discord.gg/tFgmr4H5Qn"

local function CopyDiscord()

    local Success = pcall(function()
        setclipboard(DISCORD_LINK)
    end)

    if Success then

        CopyBtn.Text = "COPIED!"
        CopyBtn.BackgroundColor3 =
            Color3.fromRGB(225, 225, 225)

        task.delay(1.5, function()

            CopyBtn.Text = "COPY LINK"
            CopyBtn.BackgroundColor3 =
                Color3.fromRGB(225, 225, 225)

        end)

        print(
            "[XENONBYTE] Discord Link Copied: "
            .. DISCORD_LINK
        )

    else

        CopyBtn.Text = "FAILED!"
        CopyBtn.BackgroundColor3 =
            Color3.fromRGB(70, 70, 70)

        task.delay(1.5, function()

            CopyBtn.Text = "COPY LINK"
            CopyBtn.BackgroundColor3 =
                Color3.fromRGB(225, 225, 225)

        end)

        warn(
            "[XENONBYTE] Failed to copy Discord link"
        )
    end
end

--==================================================
-- BUTTON EVENTS
--==================================================
CopyBtn.MouseButton1Click:Connect(CopyDiscord)
LinkBtn.MouseButton1Click:Connect(CopyDiscord)

--==================================================
-- COPY HOVER
--==================================================
CopyBtn.MouseEnter:Connect(function()

    if CopyBtn.Text == "COPY LINK" then

        TweenService:Create(
            CopyBtn,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(250, 250, 250)
            }
        ):Play()

    end
end)

CopyBtn.MouseLeave:Connect(function()

    if CopyBtn.Text == "COPY LINK" then

        TweenService:Create(
            CopyBtn,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 =
                    Color3.fromRGB(225, 225, 225)
            }
        ):Play()

    end
end)

--==================================================
-- LINK HOVER
--==================================================
LinkBtn.MouseEnter:Connect(function()

    TweenService:Create(
        LinkBtn,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 =
                Color3.fromRGB(42, 42, 42)
        }
    ):Play()

end)

LinkBtn.MouseLeave:Connect(function()

    TweenService:Create(
        LinkBtn,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 =
                Color3.fromRGB(20, 20, 20)
        }
    ):Play()

end)

print("✅ Info Tab Loaded")
