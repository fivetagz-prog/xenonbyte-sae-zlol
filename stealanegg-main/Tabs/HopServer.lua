--==================================================
-- XENONBYTE HUB | TAB | Low Server Hop
-- Finds a PUBLIC server with exactly 1 player
--==================================================

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local TabsManager = _G.XENONBYTE_TabsManager

local HopServerTab, HopServerPage =
    TabsManager:RegisterTab(
        "Hop Server",
        5,
        "HOP_SERVER"
    )

--==================================================
-- SECTION
--==================================================

CreateSectionTitle(
    HopServerPage,
    "Low Server Hop",
    1
)

--==================================================
-- INFO
--==================================================

local Info = Instance.new("TextLabel")

Info.Size =
    UDim2.new(1, 0, 0, 55)

Info.BackgroundTransparency = 1

Info.Text =
    "Finds a PUBLIC server with exactly 1 player.\n" ..
    "This does not join a private/VIP server."

Info.TextColor3 =
    Color3.fromRGB(190, 190, 200)

Info.TextSize = 12
Info.TextWrapped = true
Info.Font = Enum.Font.Gotham
Info.LayoutOrder = 2
Info.Parent = HopServerPage

--==================================================
-- HOP BUTTON
--==================================================

local HopButton = Instance.new("TextButton")

HopButton.Size =
    UDim2.new(1, 0, 0, 44)

HopButton.BackgroundColor3 =
    Color3.fromRGB(35, 35, 35)

HopButton.BorderSizePixel = 0

HopButton.Text =
    "↻  Find 1 Player Server"

HopButton.TextColor3 =
    Color3.fromRGB(255, 255, 255)

HopButton.TextSize = 13

HopButton.Font =
    Enum.Font.GothamBold

HopButton.AutoButtonColor = false

HopButton.LayoutOrder = 3
HopButton.Parent = HopServerPage

local HopCorner = Instance.new("UICorner")

HopCorner.CornerRadius =
    UDim.new(0, 8)

HopCorner.Parent =
    HopButton

local HopStroke = Instance.new("UIStroke")

HopStroke.Color =
    Color3.fromRGB(100, 100, 100)

HopStroke.Thickness = 1

HopStroke.Transparency = 0.25

HopStroke.Parent =
    HopButton

--==================================================
-- STATUS
--==================================================

local Status = Instance.new("TextLabel")

Status.Size =
    UDim2.new(1, 0, 0, 30)

Status.BackgroundTransparency = 1

Status.Text =
    "Ready"

Status.TextColor3 =
    Color3.fromRGB(150, 150, 160)

Status.TextSize = 11

Status.Font =
    Enum.Font.Gotham

Status.LayoutOrder = 4

Status.Parent =
    HopServerPage

--==================================================
-- HOVER
--==================================================

HopButton.MouseEnter:Connect(function()

    HopButton.BackgroundColor3 =
        Color3.fromRGB(55, 55, 55)

end)

HopButton.MouseLeave:Connect(function()

    HopButton.BackgroundColor3 =
        Color3.fromRGB(35, 35, 35)

end)

--==================================================
-- SERVER REQUEST
--==================================================

local function GetOnePlayerServer()

    local PlaceId =
        game.PlaceId

    local Cursor = ""

    for Page = 1, 10 do

        local URL =
            "https://games.roblox.com/v1/games/" ..
            tostring(PlaceId) ..
            "/servers/Public?sortOrder=Asc&limit=100"

        if Cursor ~= "" then
            URL =
                URL ..
                "&cursor=" ..
                HttpService:UrlEncode(Cursor)
        end

        local Success, Result =
            pcall(function()

                return game:HttpGet(URL)

            end)

        if not Success then

            return nil,
                "Failed to request server list."

        end

        local DecodeSuccess, Data =
            pcall(function()

                return HttpService:JSONDecode(
                    Result
                )

            end)

        if not DecodeSuccess
            or not Data
        then

            return nil,
                "Failed to read server list."

        end

        if Data.data then

            for _, Server in ipairs(Data.data) do

                local Playing =
                    tonumber(Server.playing)

                local MaxPlayers =
                    tonumber(Server.maxPlayers)

                local ServerId =
                    Server.id

                -- Exactly 1 player
                -- and it must be a public server
                if Playing == 1
                    and MaxPlayers
                    and MaxPlayers > 1
                    and ServerId
                    and ServerId ~= game.JobId
                then

                    return ServerId

                end

            end

        end

        Cursor =
            Data.nextPageCursor

        if not Cursor
            or Cursor == ""
        then

            break

        end

    end

    return nil,
        "No 1-player public server was found."

end

--==================================================
-- HOP
--==================================================

local Hopping = false

local function HopToOnePlayerServer()

    if Hopping then
        return
    end

    Hopping = true

    HopButton.Text =
        "↻  Searching..."

    Status.Text =
        "Searching public servers..."

    Status.TextColor3 =
        Color3.fromRGB(200, 200, 200)

    local ServerId, ErrorMessage =
        GetOnePlayerServer()

    if not ServerId then

        HopButton.Text =
            "✕  No Server Found"

        Status.Text =
            ErrorMessage or
            "No 1-player public server found."

        Status.TextColor3 =
            Color3.fromRGB(255, 150, 150)

        task.wait(1.5)

        HopButton.Text =
            "↻  Find 1 Player Server"

        Status.Text =
            "Ready"

        Status.TextColor3 =
            Color3.fromRGB(150, 150, 160)

        Hopping = false

        return

    end

    HopButton.Text =
        "✓  Joining..."

    Status.Text =
        "Found public server with 1 player."

    Status.TextColor3 =
        Color3.fromRGB(150, 255, 150)

    task.wait(0.25)

    local TeleportSuccess, TeleportError =
        pcall(function()

            TeleportService:TeleportToPlaceInstance(
                game.PlaceId,
                ServerId,
                Players.LocalPlayer
            )

        end)

    if not TeleportSuccess then

        warn(
            "[XenonByte] Teleport failed:",
            TeleportError
        )

        HopButton.Text =
            "✕  Teleport Failed"

        Status.Text =
            "Could not join the server."

        Status.TextColor3 =
            Color3.fromRGB(255, 150, 150)

        task.wait(1.5)

        HopButton.Text =
            "↻  Find 1 Player Server"

        Status.Text =
            "Ready"

        Status.TextColor3 =
            Color3.fromRGB(150, 150, 160)

    end

    Hopping = false

end

--==================================================
-- BUTTON
--==================================================

HopButton.MouseButton1Click:Connect(
    HopToOnePlayerServer
)

--==================================================
-- GLOBAL
--==================================================

_G.XENONBYTE_HopServer =
    HopToOnePlayerServer

return HopServerTab
