local GenesisX = {}
GenesisX.__index = GenesisX

-- --- SERVICOS -----------------------------------------------------------------
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- --- ICONES LUCIDE / GENESIS X ----------------------------------------------
local LucideAssets = {}
pcall(function()
    local raw = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/mainloadergg/Library/refs/heads/main/Icons.lua"
    ))()
    if raw and raw.assets then
        LucideAssets = raw.assets
    end
end)
GenesisX.Icons = LucideAssets

local CustomIcons = {
    ["lucide-dog-nerd"] = "rbxassetid://137941939602314",
    ["lucide-dog-dente"] = "rbxassetid://86545657821911",
    ["lucide-dog-chupetao"] = "rbxassetid://111009574293053",
    ["lucide-discord"] = "rbxassetid://18913863763",
    ["lucide-spectrumx"] = "rbxassetid://132158481306586",
    ["lucide-genesis-hub"] = "rbxassetid://134769377797538",
}
for name, assetId in pairs(CustomIcons) do
    if not LucideAssets[name] then
        LucideAssets[name] = assetId
    end
end

-- --- FONT SYSTEM --------------------------------------------------------------
GenesisX.Font = "Gotham"

local FontMap = {
    Arcade = Enum.Font.Arcade,
    Fantasy = Enum.Font.Fantasy,
    GothamBlack = Enum.Font.GothamBlack,
    LuckiestGuy = Enum.Font.LuckiestGuy,
}

function GenesisX:GetFont()
    return FontMap[self.Font] or Enum.Font.Gotham
end

function GenesisX:GetFontBold()
    local mapped = FontMap[self.Font]
    if mapped then return mapped end
    if (self.Font or "Gotham") == "Gotham" then return Enum.Font.GothamBold end
    return Enum.Font.GothamBold
end

function GenesisX:GetFontSemibold()
    local mapped = FontMap[self.Font]
    if mapped then return mapped end
    if (self.Font or "Gotham") == "Gotham" then return Enum.Font.GothamSemibold end
    return Enum.Font.GothamSemibold
end

function GenesisX:GetFontBlack()
    local mapped = FontMap[self.Font]
    if mapped then return mapped end
    if (self.Font or "Gotham") == "Gotham" then return Enum.Font.GothamBlack end
    return Enum.Font.GothamBlack
end
function GenesisX:_EnsureTheme()
    if not self.Theme then
        if not self.Themes then
            self.Themes = {
                Dark = {
                    Background = Color3.fromRGB(8, 8, 8), Header = Color3.fromRGB(12, 12, 12),
                    Sidebar = Color3.fromRGB(10, 10, 10), Card = Color3.fromRGB(16, 16, 16),
                    CardHover = Color3.fromRGB(24, 24, 24), Input = Color3.fromRGB(22, 22, 22),
                    InputHover = Color3.fromRGB(30, 30, 30), Accent = Color3.fromRGB(150, 80, 230),
                    AccentHover = Color3.fromRGB(180, 110, 255), AccentSecondary = Color3.fromRGB(210, 160, 255),
                    AccentDark = Color3.fromRGB(90, 40, 160), Text = Color3.fromRGB(255, 255, 255),
                    TextSecondary = Color3.fromRGB(190, 190, 190), TextMuted = Color3.fromRGB(120, 120, 120),
                    Success = Color3.fromRGB(220, 190, 255), Warning = Color3.fromRGB(190, 130, 255),
                    Info = Color3.fromRGB(140, 90, 220), Error = Color3.fromRGB(80, 40, 140),
                    Border = Color3.fromRGB(40, 35, 50), BorderBright = Color3.fromRGB(75, 65, 90),
                    ToggleOff = Color3.fromRGB(35, 30, 45), ToggleOn = Color3.fromRGB(150, 80, 230),
                },
                Light = {
                    Background = Color3.fromRGB(245, 242, 250), Header = Color3.fromRGB(235, 232, 242),
                    Sidebar = Color3.fromRGB(240, 237, 247), Card = Color3.fromRGB(255, 255, 255),
                    CardHover = Color3.fromRGB(248, 245, 252), Input = Color3.fromRGB(235, 232, 242),
                    InputHover = Color3.fromRGB(225, 220, 235), Accent = Color3.fromRGB(130, 60, 210),
                    AccentHover = Color3.fromRGB(150, 80, 230), AccentSecondary = Color3.fromRGB(100, 40, 180),
                    AccentDark = Color3.fromRGB(80, 30, 160), Text = Color3.fromRGB(30, 30, 35),
                    TextSecondary = Color3.fromRGB(80, 75, 90), TextMuted = Color3.fromRGB(130, 125, 140),
                    Success = Color3.fromRGB(100, 60, 180), Warning = Color3.fromRGB(140, 90, 40),
                    Info = Color3.fromRGB(100, 60, 180), Error = Color3.fromRGB(160, 40, 60),
                    Border = Color3.fromRGB(210, 205, 220), BorderBright = Color3.fromRGB(180, 175, 195),
                    ToggleOff = Color3.fromRGB(200, 195, 210), ToggleOn = Color3.fromRGB(130, 60, 210),
                }
            }
        end
        self.Theme = self.Themes.Dark
    end
end

-- --- THEME SYSTEM -------------------------------------------------------------
GenesisX.Themes = {
    Dark = {
        Background = Color3.fromRGB(8, 8, 8),
        Header = Color3.fromRGB(12, 12, 12),
        Sidebar = Color3.fromRGB(10, 10, 10),
        Card = Color3.fromRGB(16, 16, 16),
        CardHover = Color3.fromRGB(24, 24, 24),
        Input = Color3.fromRGB(22, 22, 22),
        InputHover = Color3.fromRGB(30, 30, 30),
        Accent = Color3.fromRGB(150, 80, 230),
        AccentHover = Color3.fromRGB(180, 110, 255),
        AccentSecondary = Color3.fromRGB(210, 160, 255),
        AccentDark = Color3.fromRGB(90, 40, 160),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(190, 190, 190),
        TextMuted = Color3.fromRGB(120, 120, 120),
        Success = Color3.fromRGB(220, 190, 255),
        Warning = Color3.fromRGB(190, 130, 255),
        Info = Color3.fromRGB(140, 90, 220),
        Error = Color3.fromRGB(80, 40, 140),
        Border = Color3.fromRGB(40, 35, 50),
        BorderBright = Color3.fromRGB(75, 65, 90),
        ToggleOff = Color3.fromRGB(35, 30, 45),
        ToggleOn = Color3.fromRGB(150, 80, 230),
    },
    Light = {
        Background = Color3.fromRGB(245, 242, 250),
        Header = Color3.fromRGB(235, 232, 242),
        Sidebar = Color3.fromRGB(240, 237, 247),
        Card = Color3.fromRGB(255, 255, 255),
        CardHover = Color3.fromRGB(248, 245, 252),
        Input = Color3.fromRGB(235, 232, 242),
        InputHover = Color3.fromRGB(225, 220, 235),
        Accent = Color3.fromRGB(130, 60, 210),
        AccentHover = Color3.fromRGB(150, 80, 230),
        AccentSecondary = Color3.fromRGB(100, 40, 180),
        AccentDark = Color3.fromRGB(80, 30, 160),
        Text = Color3.fromRGB(30, 30, 35),
        TextSecondary = Color3.fromRGB(80, 75, 90),
        TextMuted = Color3.fromRGB(130, 125, 140),
        Success = Color3.fromRGB(100, 60, 180),
        Warning = Color3.fromRGB(140, 90, 40),
        Info = Color3.fromRGB(100, 60, 180),
        Error = Color3.fromRGB(160, 40, 60),
        Border = Color3.fromRGB(210, 205, 220),
        BorderBright = Color3.fromRGB(180, 175, 195),
        ToggleOff = Color3.fromRGB(200, 195, 210),
        ToggleOn = Color3.fromRGB(130, 60, 210),
    },
    Iron = {
    Background = Color3.fromRGB(32, 33, 36),
    Header = Color3.fromRGB(38, 39, 43),
    Sidebar = Color3.fromRGB(35, 36, 40),
    Card = Color3.fromRGB(42, 43, 48),
    CardHover = Color3.fromRGB(52, 54, 60),
    Input = Color3.fromRGB(45, 46, 52),
    InputHover = Color3.fromRGB(55, 57, 64),
    Accent = Color3.fromRGB(176, 186, 196),
    AccentHover = Color3.fromRGB(200, 210, 220),
    AccentSecondary = Color3.fromRGB(140, 150, 165),
    AccentDark = Color3.fromRGB(110, 118, 130),
    Text = Color3.fromRGB(248, 249, 250),
    TextSecondary = Color3.fromRGB(200, 203, 210),
    TextMuted = Color3.fromRGB(160, 163, 170),
    Success = Color3.fromRGB(130, 180, 140),
    Warning = Color3.fromRGB(200, 170, 120),
    Info = Color3.fromRGB(140, 160, 190),
    Error = Color3.fromRGB(180, 100, 100),
    Border = Color3.fromRGB(82, 85, 92),
    BorderBright = Color3.fromRGB(110, 112, 118),
    ToggleOff = Color3.fromRGB(55, 57, 64),
    ToggleOn = Color3.fromRGB(176, 186, 196),
    }
}

GenesisX.Theme = GenesisX.Themes.Dark

-- --- CONFIGURACOES ------------------------------------------------------------
GenesisX.Config = {
    AnimationSpeed = 0.2,
    CornerRadius = 6,
    ShadowEnabled = true,
    ShadowIntensity = 0.7,
    Transparency = 0,
    BorderEnabled = false,
}

-- --- INTERNAL SAVE/LOAD FOR THEME & FONT ------------------------------------
GenesisX._configFolder = "GenesisX/Config"

function GenesisX:_SaveConfigFile(filename, value)
    if not (writefile and isfolder and makefolder and HttpService) then return end
    pcall(function()
        if not isfolder("GenesisX") then makefolder("GenesisX") end
        if not isfolder(self._configFolder) then makefolder(self._configFolder) end
        local path = self._configFolder .. "/" .. filename
        writefile(path, HttpService:JSONEncode({value = value}))
    end)
end

function GenesisX:_LoadConfigFile(filename, defaultValue)
    if not (readfile and isfile and HttpService) then return defaultValue end
    local ok, data = pcall(function()
        local path = self._configFolder .. "/" .. filename
        if not isfile(path) then return nil end
        return HttpService:JSONDecode(readfile(path))
    end)
    if ok and data and data.value ~= nil then
        return data.value
    end
    -- Se nao existe, cria com o default
    self:_SaveConfigFile(filename, defaultValue)
    return defaultValue
end

-- --- ESCALA RESPONSIVA --------------------------------------------------------
local ScaleData = {
    IsMobile = false,
    ScaleFactor = 1,
    BaseResolution = Vector2.new(1920, 1080)
}

function GenesisX:UpdateScale()
    local success, camera = pcall(function() return workspace.CurrentCamera end)
    if not success or not camera then return end
    local viewport = camera.ViewportSize
    if viewport.X == 0 then return end
    ScaleData.IsMobile = UserInputService.TouchEnabled and (viewport.X < 1200 or viewport.Y < 700)
    local scale = math.min(viewport.X / ScaleData.BaseResolution.X, viewport.Y / ScaleData.BaseResolution.Y)
    if ScaleData.IsMobile then
        ScaleData.ScaleFactor = math.clamp(scale, 0.85, 1.2)
    else
        ScaleData.ScaleFactor = math.clamp(scale, 0.7, 1.1)
    end
end

function GenesisX:S(value)
    if type(value) == "number" then
        return math.floor(value * ScaleData.ScaleFactor)
    elseif typeof(value) == "UDim2" then
        return UDim2.new(
            value.X.Scale, math.floor(value.X.Offset * ScaleData.ScaleFactor),
            value.Y.Scale, math.floor(value.Y.Offset * ScaleData.ScaleFactor)
        )
    elseif typeof(value) == "UDim" then
        return UDim.new(value.Scale, math.floor(value.Offset * ScaleData.ScaleFactor))
    end
    return value
end

-- --- UTILITARIOS BASICOS ------------------------------------------------------
function GenesisX:Tween(obj, props, time, style, direction)
    if not obj or not obj.Parent then return nil end
    local tweenInfo = TweenInfo.new(
        time or self.Config.AnimationSpeed,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

function GenesisX:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = radius or UDim.new(0, self.Config.CornerRadius)
    corner.Parent = parent
    -- Apply transparency to the parent if it's a frame with background
    if parent and parent:IsA("GuiObject") and parent.BackgroundTransparency < 1 and self.Config.Transparency > 0 then
        local skipNames = {
            Ripple = true, Knob = true, Fill = true, Bar = true, BarBg = true,
            Shadow = true, SimpleShadow = true, IconGlow = true, IconBg = true,
            Checkbox = true, ValueBg = true, CountBadge = true, LeftBar = true,
            Track = true, RippleHolder = true, HoverFill = true, IconArea = true,
            Separator = true, Line = true, SidebarLine = true, Divider = true,
            HeaderCover = true, BgCard = true
        }
        if not skipNames[parent.Name] and not parent:IsA("TextBox") then
            parent.BackgroundTransparency = self.Config.Transparency
        end
    end
    return corner
end

function GenesisX:CreateStroke(parent, color, thickness, transparency)
    if self.Config.BorderEnabled == false then return nil end
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or self.Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function GenesisX:CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(color1 or Color3.new(1,1,1), color2 or Color3.new(0,0,0))
    gradient.Rotation = rotation or 0
    gradient.Parent = parent
    return gradient
end

-- --- SISTEMA DE SOMBRAS -------------------------------------------------------
function GenesisX:CreateShadow(parent, size, intensity)
    if not self.Config.ShadowEnabled then return nil end
    size = size or 20
    intensity = intensity or self.Config.ShadowIntensity
    local shadowFolder = Instance.new("Folder")
    shadowFolder.Name = "Shadow"
    shadowFolder.Parent = parent
    local layers = 4
    for i = 1, layers do
        local layer = Instance.new("Frame")
        layer.Name = "Layer" .. i
        layer.AnchorPoint = Vector2.new(0.5, 0.5)
        layer.BackgroundColor3 = Color3.new(0, 0, 0)
        layer.BackgroundTransparency = intensity + ((1 - intensity) * (i / layers) * 0.5)
        layer.BorderSizePixel = 0
        layer.Position = UDim2.new(0.5, 0, 0.5, 0)
        layer.Size = UDim2.new(1, size + (i * 3), 1, size + (i * 3))
        layer.ZIndex = math.max(0, parent.ZIndex - 1)
        layer.Parent = shadowFolder
        self:CreateCorner(layer, UDim.new(0, (self.Config.CornerRadius or 8) + i))
    end
    return shadowFolder
end

function GenesisX:CreateSimpleShadow(parent, size, transparency)
    if not self.Config.ShadowEnabled then return nil end
    local shadow = Instance.new("Frame")
    shadow.Name = "SimpleShadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BackgroundTransparency = transparency or 0.75
    shadow.BorderSizePixel = 0
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, size or 16, 1, size or 16)
    shadow.ZIndex = math.max(0, parent.ZIndex - 1)
    shadow.Parent = parent
    self:CreateCorner(shadow)
    return shadow
end

-- --- DRAGGABLE ----------------------------------------------------------------
function GenesisX:MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- --- RIPPLE EFFECT ------------------------------------------------------------
function GenesisX:CreateRipple(parent, position)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.BackgroundColor3 = Color3.new(1, 1, 1)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.ZIndex = parent.ZIndex + 10
    local maxSize = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 1.2
    local startX, startY
    if position then
        startX = position.X - parent.AbsolutePosition.X
        startY = position.Y - parent.AbsolutePosition.Y
    else
        startX = parent.AbsoluteSize.X / 2
        startY = parent.AbsoluteSize.Y / 2
    end
    ripple.Position = UDim2.new(0, startX, 0, startY)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Parent = parent
    self:CreateCorner(ripple, UDim.new(1, 0))
    self:Tween(ripple, {
        Size = UDim2.new(0, maxSize, 0, maxSize),
        BackgroundTransparency = 1
    }, 0.4)
    task.delay(0.4, function()
        if ripple and ripple.Parent then ripple:Destroy() end
    end)
end

-- --- HELPERS DE ICONE ---------------------------------------------------------
function GenesisX:IsAssetId(value)
    if type(value) ~= "string" and type(value) ~= "number" then return false end
    local s = tostring(value)
    if s:match("^rbxassetid://") ~= nil or s:match("^%d+$") ~= nil then return true end
    -- Tambem aceita nomes de icones registrados
    if LucideAssets and LucideAssets[s] then return true end
    return false
end

function GenesisX:FormatAssetId(value)
    if type(value) == "number" then
        return "rbxassetid://" .. value
    elseif type(value) == "string" then
        -- Prioridade: nome de icone Lucide registrado
        if LucideAssets and LucideAssets[value] then
            return LucideAssets[value]
        end
        if value:match("^rbxassetid://") then
            return value
        elseif value:match("^%d+$") then
            return "rbxassetid://" .. value
        end
    end
    return nil
end

function GenesisX:CreateIcon(parent, iconData, size, color)
    size = size or UDim2.new(0, 20, 0, 20)
    color = color or self.Theme.Text
    local assetId = self:FormatAssetId(iconData)
    if assetId then
        local img = Instance.new("ImageLabel")
        img.Name = "Icon"
        img.BackgroundTransparency = 1
        img.Size = size
        img.Image = assetId
        img.ImageColor3 = color
        img.Parent = parent
        local aspect = Instance.new("UIAspectRatioConstraint")
        aspect.Parent = img
        return img, "image"
    else
        local lbl = Instance.new("TextLabel")
        lbl.Name = "Icon"
        lbl.BackgroundTransparency = 1
        lbl.Size = size
        lbl.Font = self:GetFontBold()
        lbl.Text = tostring(iconData):sub(1, 2)
        lbl.TextColor3 = color
        lbl.TextSize = size.Y.Offset or 16
        lbl.Parent = parent
        return lbl, "text"
    end
end

-- --- REGISTRO DE DROPDOWNS ----------------------------------------------------
function GenesisX:_RegisterDropdown(list, button, closeFunction)
    if not self._dropdowns then self._dropdowns = {} end
    table.insert(self._dropdowns, { List = list, Button = button, Close = closeFunction })
    if not self.Dropdowns then self.Dropdowns = {} end
    table.insert(self.Dropdowns, list)
end

function GenesisX:_CloseDropdownsOnClick(position)
    if not self._dropdowns then return end
    for _, dropdown in ipairs(self._dropdowns) do
        if dropdown.List and dropdown.List.Visible then
            local listPos = dropdown.List.AbsolutePosition
            local listSize = dropdown.List.AbsoluteSize
            local btnPos = dropdown.Button.AbsolutePosition
            local btnSize = dropdown.Button.AbsoluteSize
            local inList = position.X >= listPos.X and position.X <= listPos.X + listSize.X and
                           position.Y >= listPos.Y and position.Y <= listPos.Y + listSize.Y
            local inBtn = position.X >= btnPos.X and position.X <= btnPos.X + btnSize.X and
                          position.Y >= btnPos.Y and position.Y <= btnPos.Y + btnSize.Y
            if not inList and not inBtn then
                task.spawn(dropdown.Close)
            end
        end
    end
end

-- --- CREATE WINDOW ------------------------------------------------------------
function GenesisX:CreateWindow(config)
    self:_EnsureTheme()
    config = config or {}
    local window = setmetatable({}, self)
    self:UpdateScale()
    -- Theme & Font setup
    if not self.Themes then
        self.Themes = { Dark = { Background = Color3.fromRGB(8,8,8), Header = Color3.fromRGB(12,12,12), Sidebar = Color3.fromRGB(10,10,10), Card = Color3.fromRGB(16,16,16), CardHover = Color3.fromRGB(24,24,24), Input = Color3.fromRGB(22,22,22), InputHover = Color3.fromRGB(30,30,30), Accent = Color3.fromRGB(150,80,230), AccentHover = Color3.fromRGB(180,110,255), AccentSecondary = Color3.fromRGB(210,160,255), AccentDark = Color3.fromRGB(90,40,160), Text = Color3.fromRGB(255,255,255), TextSecondary = Color3.fromRGB(190,190,190), TextMuted = Color3.fromRGB(120,120,120), Success = Color3.fromRGB(220,190,255), Warning = Color3.fromRGB(190,130,255), Info = Color3.fromRGB(140,90,220), Error = Color3.fromRGB(80,40,140), Border = Color3.fromRGB(40,35,50), BorderBright = Color3.fromRGB(75,65,90), ToggleOff = Color3.fromRGB(35,30,45), ToggleOn = Color3.fromRGB(150,80,230) } }
    end
    if not self.Theme then
        self.Theme = self.Themes.Dark
    end
    -- Load saved theme/font or use config defaults (and save them)
    -- If config explicitly provides Theme/Font, it OVERRIDES saved config
    local configTheme = config.Theme
    local configFont  = config.Font
    local savedTheme  = self:_LoadConfigFile("theme.json", configTheme or "Dark")
    local savedFont   = self:_LoadConfigFile("font.json", configFont or "Gotham")
    local savedTransparency = self:_LoadConfigFile("transparency.json", config.Transparency or 0)
    self.Config.Transparency = math.clamp(savedTransparency, 0, 1)

    -- Override: if config explicitly set Theme/Font, use it and save
    local themeName = savedTheme
    if configTheme then
        themeName = configTheme
        self:_SaveConfigFile("theme.json", configTheme)
    end
    local fontName = savedFont
    if configFont then
        fontName = configFont
        self:_SaveConfigFile("font.json", configFont)
    end
    self.Font = fontName
    if themeName == "Light" then
        self.Theme = self.Themes.Light
    else
        self.Theme = self.Themes.Dark
    end

    -- SideMode: optional docked side panel UI (chevron handle + large side window)
    self.SideMode = config.SideMode == true
    self._sideExpanded = false
    -- SideWidth: % da viewport (largura do painel lateral). Padrao = 48 (~48% da tela).
    -- Ex: SideWidth = 50 estica um pouco mais; SideWidth = 60 bem largo.
    -- Min efetivo ~620px, max ~92% no desktop (clamp interno).
    self._sideWidthPct = tonumber(config.SideWidth) or 48

    if PlayerGui:FindFirstChild("GenesisX") then
        PlayerGui.GenesisX:Destroy()
    end

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "GenesisX"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.DisplayOrder = 999999

    -- Parent no CoreGui se possivel (fica por cima da UI do Roblox)
    local parentSuccess = pcall(function()
        self.ScreenGui.Parent = CoreGui
    end)

    -- Se falhar (executor nao permite), usa PlayerGui
    if not parentSuccess then
        self.ScreenGui.Parent = PlayerGui
    end



    self._notifications = {}
    self.Dropdowns = {}
    self._dropdowns = {}
    self.Tabs = {}
    self.CurrentTab = nil

    local windowWidth, windowHeight
    if self.SideMode then
        local cam = workspace.CurrentCamera
        local vw = (cam and cam.ViewportSize.X) or 1366
        local pct = math.clamp((self._sideWidthPct or 48) / 100, 0.25, 0.92)
        if ScaleData.IsMobile then
            windowWidth = math.floor(math.clamp(vw * math.max(pct, 0.85), 300, math.floor(vw * 0.95)))
            windowHeight = self:S(540)
        else
            -- SideWidth = % da viewport. Padrao 48. SideWidth=80 => ~80% da tela.
            local minW, maxW = 420, math.floor(vw * 0.92)
            windowWidth = math.floor(math.clamp(vw * pct, minW, maxW))
            windowHeight = self:S(560)
        end
    else
        windowWidth = ScaleData.IsMobile and self:S(440) or self:S(700)
        windowHeight = ScaleData.IsMobile and self:S(580) or self:S(460)
    end

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.BackgroundColor3 = self.Theme.Background
    self.MainFrame.BorderSizePixel = 0
    if self.SideMode then
        self.MainFrame.AnchorPoint = Vector2.new(1, 0.5)
        self.MainFrame.Position = config.Position or UDim2.new(1, -56, 0.5, 0)
        self.MainFrame.Visible = false -- starts collapsed; opened via side handle
    else
        self.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        self.MainFrame.Position = config.Position or UDim2.new(0.5, 0, 0.5, 0)
        self.MainFrame.Visible = true
    end
    self.MainFrame.Size = config.Size or UDim2.new(0, windowWidth, 0, windowHeight)
    self.MainFrame.Active = true
    self.MainFrame.ZIndex = 10
    self.MainFrame.ClipsDescendants = true
    self.MainFrame.Parent = self.ScreenGui
    self:CreateCorner(self.MainFrame, UDim.new(0, 12))
    if self.Config.BorderEnabled then
        self:CreateStroke(self.MainFrame, self.Theme.Accent, 1.5, 0)
    end
    self.MainFrame.BackgroundTransparency = self.Config.Transparency

    -- --- HEADER -----------------------------------------------------------------
    local headerHeight = self:S(56)

    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.BackgroundColor3 = self.Theme.Header
    self.Header.BorderSizePixel = 0
    self.Header.Size = UDim2.new(1, 0, 0, headerHeight)
    self.Header.ZIndex = 12
    self.Header.Parent = self.MainFrame
    self.Header.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(self.Header, UDim.new(0, 8))

    local iconX = self:S(16)
    -- FIX: Detectar asset ID corretamente para o icone do header (agora inclui nomes Lucide)
    local headerIconAsset = config.IconAssetId and self:FormatAssetId(config.IconAssetId)
                         or (config.Icon and self:FormatAssetId(config.Icon))

    if headerIconAsset then
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "HeaderIcon"
        iconImg.BackgroundTransparency = 1
        iconImg.Position = UDim2.new(0, iconX, 0.5, -self:S(16))
        iconImg.Size = UDim2.new(0, self:S(32), 0, self:S(32))
        iconImg.Image = headerIconAsset
        iconImg.ScaleType = Enum.ScaleType.Stretch
        iconImg.ZIndex = 14
        iconImg.Parent = self.Header
    else
        local iconBg = Instance.new("Frame")
        iconBg.Name = "IconBg"
        iconBg.BackgroundColor3 = self.Theme.Accent
        iconBg.Position = UDim2.new(0, iconX, 0.5, -self:S(15))
        iconBg.Size = UDim2.new(0, self:S(30), 0, self:S(30))
        iconBg.ZIndex = 14
        iconBg.Parent = self.Header
        self:CreateCorner(iconBg, UDim.new(0, 6))

        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "IconLabel"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBlack()
        iconLabel.Text = config.Icon or "S"
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.TextSize = self:S(16)
        iconLabel.ZIndex = 15
        iconLabel.Parent = iconBg
    end

    local titleX = iconX + self:S(44)
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, titleX, 0, 0)
    titleLabel.Size = UDim2.new(0, self:S(300), 1, 0)
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = config.Title or "GenesisX"
    titleLabel.TextColor3 = self.Theme.Text
    titleLabel.TextSize = self:S(18)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 14
    titleLabel.Parent = self.Header
    self:CreateGradient(titleLabel, self.Theme.Text, self.Theme.AccentSecondary, 0)

    if config.Subtitle then
        titleLabel.Size = UDim2.new(0, self:S(300), 0, self:S(28))
        titleLabel.Position = UDim2.new(0, titleX, 0, self:S(6))
        local subtitleLabel = Instance.new("TextLabel")
        subtitleLabel.Name = "Subtitle"
        subtitleLabel.BackgroundTransparency = 1
        subtitleLabel.Position = UDim2.new(0, titleX, 0, self:S(30))
        subtitleLabel.Size = UDim2.new(0, self:S(300), 0, self:S(16))
        subtitleLabel.Font = self:GetFont()
        subtitleLabel.Text = config.Subtitle
        subtitleLabel.TextColor3 = self.Theme.TextMuted
        subtitleLabel.TextSize = self:S(10)
        subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        subtitleLabel.ZIndex = 14
        subtitleLabel.Parent = self.Header
    end

    -- Header buttons registry (right -> left)
    self._headerButtonList = {}
    self._headerBtnW = self:S(34)
    self._headerBtnH = self:S(32)
    self._headerBtnGap = self:S(8)
    self._headerBtnPad = self:S(14)

    local function rebuildHeaderButtonLayout()
        local btnW = self._headerBtnW
        local btnH = self._headerBtnH
        local gap = self._headerBtnGap
        local pad = self._headerBtnPad
        for i, entry in ipairs(self._headerButtonList) do
            if entry.Button and entry.Button.Parent then
                local offsetX = pad + (i - 1) * (btnW + gap)
                entry.Button.Position = UDim2.new(1, -(offsetX + btnW), 0.5, -btnH/2)
                entry.Button.Size = UDim2.new(0, btnW, 0, btnH)
            end
        end
    end
    self._rebuildHeaderButtons = rebuildHeaderButtonLayout

    local function spawnHeaderButton(btnData)
        local btnW, btnH = self._headerBtnW, self._headerBtnH
        local btn = Instance.new("ImageButton")
        btn.Name = (btnData.Type or "custom") .. "Btn"
        btn.BackgroundColor3 = self.Theme.Input
        btn.Size = UDim2.new(0, btnW, 0, btnH)
        btn.Image = self:FormatAssetId(btnData.Icon) or ""
        btn.ImageColor3 = self.Theme.Accent
        btn.AutoButtonColor = false
        btn.ZIndex = 14
        btn.Parent = self.Header
        self:CreateCorner(btn, UDim.new(0, 6))

        btn.MouseEnter:Connect(function()
            self:Tween(btn, {BackgroundColor3 = self.Theme.Accent, ImageColor3 = Color3.new(1,1,1)}, 0.15)
        end)
        btn.MouseLeave:Connect(function()
            self:Tween(btn, {BackgroundColor3 = self.Theme.Input, ImageColor3 = self.Theme.Accent}, 0.15)
        end)
        btn.MouseButton1Click:Connect(function()
            if btnData.Action then
                pcall(btnData.Action)
            end
        end)

        table.insert(self._headerButtonList, {
            Button = btn,
            Type = btnData.Type or "custom",
            Data = btnData,
        })
        rebuildHeaderButtonLayout()
        return btn
    end
    self._spawnHeaderButton = spawnHeaderButton

    -- Built-in: Theme
    if config.ThemeBtn == true then
        spawnHeaderButton({Type = "theme", Icon = "lucide-sun-moon", Action = function()
            local newTheme = (self.Theme == self.Themes.Dark) and "Light" or "Dark"
            self:SetTheme(newTheme)
        end})
    end

    -- Built-in: Discord
    local discordLink = nil
    if type(config.DiscordBtn) == "string" and config.DiscordBtn ~= "" then
        discordLink = config.DiscordBtn
    elseif config.DiscordBtn == true and type(config.DiscordLink) == "string" and config.DiscordLink ~= "" then
        discordLink = config.DiscordLink
    end
    if discordLink then
        spawnHeaderButton({Type = "discord", Icon = "lucide-discord", Action = function()
            if setclipboard then setclipboard(discordLink) end
        end})
    end

    -- Built-in: Minimize
    if config.MinimizeBtn == true then
        spawnHeaderButton({Type = "minimize", Icon = "lucide-minus", Action = function()
            self.MainFrame.Visible = false
        end})
    end

    -- Custom header buttons from CreateWindow config
    -- HeaderButtons = { { Icon = "lucide-trash", Callback = function() end }, ... }
    if type(config.HeaderButtons) == "table" then
        for _, hb in ipairs(config.HeaderButtons) do
            if type(hb) == "table" and (hb.Icon or hb.Callback or hb.Action) then
                spawnHeaderButton({
                    Type = hb.Type or "custom",
                    Icon = hb.Icon or "lucide-circle",
                    Action = hb.Callback or hb.Action or function() end,
                })
            end
        end
    end

    -- --- SIDEBAR ----------------------------------------------------------------
    local sidebarWidth = self.SideMode and self:S(118) or self:S(64)
    self._sidebarWidth = sidebarWidth

    local sidebarWrap = Instance.new("Frame")
    sidebarWrap.Name = "SidebarWrap"
    sidebarWrap.BackgroundColor3 = self.Theme.Sidebar
    sidebarWrap.BorderSizePixel = 0
    sidebarWrap.Position = UDim2.new(0, 0, 0, headerHeight + 2)
    sidebarWrap.Size = UDim2.new(0, sidebarWidth, 1, -(headerHeight + 2))
    sidebarWrap.ClipsDescendants = true
    sidebarWrap.ZIndex = 11
    sidebarWrap.Parent = self.MainFrame
    sidebarWrap.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(sidebarWrap, UDim.new(0, 8))

    local sidebarLine = Instance.new("Frame")
    sidebarLine.Name = "SidebarLine"
    sidebarLine.BackgroundColor3 = self.Theme.Border
    sidebarLine.BorderSizePixel = 0
    sidebarLine.Position = UDim2.new(1, -1, 0, 0)
    sidebarLine.Size = UDim2.new(0, 1, 1, 0)
    sidebarLine.ZIndex = 12
    sidebarLine.Parent = sidebarWrap

    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.BackgroundTransparency = 1
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.Position = UDim2.new(0, 0, 0, 0)
    self.Sidebar.Size = UDim2.new(1, 0, 1, 0)
    self.Sidebar.ScrollBarThickness = 2
    self.Sidebar.ScrollBarImageColor3 = self.Theme.Accent
    self.Sidebar.ScrollBarImageTransparency = 0.6
    self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Sidebar.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Sidebar.ZIndex = 11
    self.Sidebar.Parent = sidebarWrap

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, self:S(8))
    sidebarLayout.HorizontalAlignment = self.SideMode and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Center
    sidebarLayout.Parent = self.Sidebar

    local sidebarPadding = Instance.new("UIPadding")
    sidebarPadding.PaddingTop = UDim.new(0, self:S(12))
    sidebarPadding.PaddingBottom = UDim.new(0, self:S(12))
    if self.SideMode then
        sidebarPadding.PaddingLeft = UDim.new(0, self:S(10))
        sidebarPadding.PaddingRight = UDim.new(0, self:S(10))
    end
    sidebarPadding.Parent = self.Sidebar

    sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarLayout.AbsoluteContentSize.Y + self:S(24))
    end)

    -- --- CONTENT AREA -----------------------------------------------------------
    local contentX = sidebarWidth + self:S(10)

    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.BackgroundTransparency = 1
    self.ContentArea.Position = UDim2.new(0, contentX, 0, headerHeight + self:S(10))
    self.ContentArea.Size = UDim2.new(1, -(contentX + self:S(14)), 1, -(headerHeight + self:S(20)))
    self.ContentArea.ZIndex = 11
    self.ContentArea.ClipsDescendants = true
    self.ContentArea.Parent = self.MainFrame

    if self.SideMode then
        self:_CreateSideHandle(config)
    else
        self:_CreateFloatingButton(config)
    end

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            self:_CloseDropdownsOnClick(input.Position)
        end
    end)

    local success, camera = pcall(function() return workspace.CurrentCamera end)
    if success and camera then
        camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            self:UpdateScale()
        end)
    end

    if not self.SideMode then
        self:MakeDraggable(self.MainFrame, self.Header)
    end
    return window
end

-- --- SIDE MODE HANDLE -------------------------------------------------------
function GenesisX:_CreateSideHandle(config)
    config = config or {}
    local HANDLE_W = self:S(36)
    local HANDLE_H = self:S(96)
    local EDGE_PAD = self:S(12)
    local GAP = self:S(10)
    local SCREEN_PAD = 10

    self._sideHandleW = HANDLE_W
    self._sideEdgePad = EDGE_PAD
    self._sideGap = GAP

    local function viewportSize()
        local cam = workspace.CurrentCamera
        if cam then return cam.ViewportSize end
        return Vector2.new(1366, 768)
    end

    local function safeClamp(value, minV, maxV)
        if minV > maxV then
            return (minV + maxV) * 0.5
        end
        return math.clamp(value, minV, maxV)
    end

    -- Load last handle position (0..1 scale Y)
    local savedY = self:_LoadConfigFile("sidehandle_y.json", 0.5)
    if type(savedY) ~= "number" then savedY = 0.5 end
    savedY = math.clamp(savedY, 0.05, 0.95)
    self._sideCenterY = savedY

    local function clampHandleScale(scale)
        local vh = math.max(viewportSize().Y, 1)
        local half = HANDLE_H * 0.5
        local minS = (half + SCREEN_PAD) / vh
        local maxS = 1 - minS
        return safeClamp(scale, minS, maxS)
    end

    -- Panel size: SideWidth = % da viewport (padrao 48). Expansao usa isso de verdade.
    local function getPanelSize()
        local vs = viewportSize()
        local vw = math.max(vs.X, 1)
        local vh = math.max(vs.Y, 1)
        local pct = math.clamp((self._sideWidthPct or 48) / 100, 0.25, 0.92)
        local baseW
        if ScaleData.IsMobile then
            baseW = math.floor(math.clamp(vw * math.max(pct, 0.85), 300, math.floor(vw * 0.95)))
        else
            -- sem teto artificial de 620 — SideWidth controla a largura
            local minW = 420
            local maxW = math.floor(vw * 0.92)
            baseW = math.floor(math.clamp(vw * pct, minW, maxW))
        end
        local baseH = ScaleData.IsMobile and self:S(540) or self:S(560)
        local maxH = math.max(220, vh - SCREEN_PAD * 2)
        local h = math.clamp(baseH, 220, maxH)
        return baseW, h
    end

    -- Panel always opens vertically centered (and clamped), independent of handle Y
    local function getPanelCenterScale(panelH)
        local vh = math.max(viewportSize().Y, 1)
        local half = panelH * 0.5
        local minS = (half + SCREEN_PAD) / vh
        local maxS = 1 - minS
        return safeClamp(0.5, minS, maxS)
    end

    self._sideCenterY = clampHandleScale(self._sideCenterY)

    -- Floating chevron handle on the right edge
    self.SideHandle = Instance.new("TextButton")
    self.SideHandle.Name = "SideHandle"
    self.SideHandle.BackgroundColor3 = self.Theme.Header
    self.SideHandle.BorderSizePixel = 0
    self.SideHandle.AnchorPoint = Vector2.new(1, 0.5)
    self.SideHandle.Position = UDim2.new(1, -EDGE_PAD, self._sideCenterY, 0)
    self.SideHandle.Size = UDim2.new(0, HANDLE_W, 0, HANDLE_H)
    self.SideHandle.Text = ""
    self.SideHandle.AutoButtonColor = false
    self.SideHandle.ZIndex = 120
    self.SideHandle.Parent = self.ScreenGui
    self:CreateCorner(self.SideHandle, UDim.new(0, 10))

    local stroke = Instance.new("UIStroke")
    stroke.Name = "HandleStroke"
    stroke.Color = self.Theme.Accent
    stroke.Thickness = 1.4
    stroke.Transparency = 0.3
    stroke.Parent = self.SideHandle
    self._sideHandleStroke = stroke

    local chevron = Instance.new("ImageLabel")
    chevron.Name = "Chevron"
    chevron.BackgroundTransparency = 1
    chevron.Size = UDim2.new(0, self:S(18), 0, self:S(18))
    chevron.Position = UDim2.new(0.5, 0, 0.5, 0)
    chevron.AnchorPoint = Vector2.new(0.5, 0.5)
    chevron.Image = self:FormatAssetId("lucide-chevron-left") or "rbxassetid://6031091004"
    chevron.ImageColor3 = self.Theme.Accent
    chevron.ZIndex = 121
    chevron.Parent = self.SideHandle
    self._sideChevron = chevron

    local function placeHandle()
        self._sideCenterY = clampHandleScale(self._sideCenterY)
        self.SideHandle.Position = UDim2.new(1, -EDGE_PAD, self._sideCenterY, 0)
    end

    local function placePanelCentered(panelH)
        if not self.MainFrame then return end
        local offset = EDGE_PAD + HANDLE_W + GAP
        local cy = getPanelCenterScale(panelH)
        self.MainFrame.AnchorPoint = Vector2.new(1, 0.5)
        self.MainFrame.Position = UDim2.new(1, -offset, cy, 0)
        return cy
    end

    function self:SetSideExpanded(state)
        self._sideExpanded = state and true or false
        if not self.MainFrame then return end

        local w, h = getPanelSize()
        local offset = EDGE_PAD + HANDLE_W + GAP

        if self._sideExpanded then
            placePanelCentered(h)
            self.MainFrame.Visible = true
            self.MainFrame.Size = UDim2.new(0, 0, 0, h)
            self:Tween(self.MainFrame, {
                Size = UDim2.new(0, w, 0, h)
            }, 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            if self._sideChevron then
                self:Tween(self._sideChevron, {Rotation = 180}, 0.28)
            end
            if self._sideHandleStroke then
                self._sideHandleStroke.Transparency = 0.12
            end
        else
            self:Tween(self.MainFrame, {
                Size = UDim2.new(0, 0, 0, h)
            }, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            if self._sideChevron then
                self:Tween(self._sideChevron, {Rotation = 0}, 0.28)
            end
            if self._sideHandleStroke then
                self._sideHandleStroke.Transparency = 0.3
            end
            task.delay(0.3, function()
                if self.MainFrame and not self._sideExpanded then
                    self.MainFrame.Visible = false
                    local ww, wh = getPanelSize()
                    self.MainFrame.Size = UDim2.new(0, ww, 0, wh)
                end
            end)
        end
    end

    function self:ToggleSide()
        self:SetSideExpanded(not self._sideExpanded)
    end

    -- Click to toggle (ignore if drag)
    self.SideHandle.MouseButton1Click:Connect(function()
        if self.SideHandle:GetAttribute("WasDragging") then
            self.SideHandle:SetAttribute("WasDragging", false)
            return
        end
        self:ToggleSide()
    end)

    self.SideHandle.MouseEnter:Connect(function()
        self:Tween(self.SideHandle, {BackgroundColor3 = self.Theme.Card}, 0.15)
        if self._sideChevron then
            self:Tween(self._sideChevron, {ImageColor3 = self.Theme.AccentHover}, 0.15)
        end
    end)
    self.SideHandle.MouseLeave:Connect(function()
        self:Tween(self.SideHandle, {BackgroundColor3 = self.Theme.Header}, 0.15)
        if self._sideChevron then
            self:Tween(self._sideChevron, {ImageColor3 = self.Theme.Accent}, 0.15)
        end
    end)

    -- Drag handle vertically + save position
    -- Mobile-friendly: require hold + meaningful move before treating as drag
    -- so analog/walk touches don't slide the button by accident
    local dragging = false
    local dragArmed = false -- true only after hold threshold
    local dragActive = false -- true only after move threshold while armed
    local dragStartY = 0
    local startScale = 0.5
    local pressClock = 0
    local HOLD_TO_DRAG = 0.28 -- seconds of hold before drag can start
    local MOVE_TO_DRAG = 14 -- pixels before counting as drag

    self.SideHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragArmed = false
            dragActive = false
            dragStartY = input.Position.Y
            startScale = self._sideCenterY
            pressClock = os.clock()
            self.SideHandle:SetAttribute("WasDragging", false)

            -- arm drag after hold (does not move yet)
            task.delay(HOLD_TO_DRAG, function()
                if dragging and not dragActive then
                    dragArmed = true
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position.Y - dragStartY
            local heldLongEnough = (os.clock() - pressClock) >= HOLD_TO_DRAG or dragArmed

            -- Desktop mouse: allow drag sooner (smaller hold), mobile touch uses full hold
            local isTouch = input.UserInputType == Enum.UserInputType.Touch
            local moveNeed = isTouch and MOVE_TO_DRAG or 8
            local holdNeed = isTouch and HOLD_TO_DRAG or 0.12
            heldLongEnough = (os.clock() - pressClock) >= holdNeed or dragArmed

            if heldLongEnough and math.abs(delta) >= moveNeed then
                dragActive = true
                dragArmed = true
                self.SideHandle:SetAttribute("WasDragging", true)
            end

            if dragActive then
                local vh = math.max(viewportSize().Y, 1)
                self._sideCenterY = clampHandleScale(startScale + (delta / vh))
                placeHandle()
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging and dragActive then
                self:_SaveConfigFile("sidehandle_y.json", self._sideCenterY)
            end
            dragging = false
            dragArmed = false
            dragActive = false
        end
    end)

    -- Reclamp on resolution change
    local function reclampAll()
        placeHandle()
        if self._sideExpanded and self.MainFrame then
            local _, h = getPanelSize()
            placePanelCentered(h)
            local w = getPanelSize()
            -- keep size fitted
            local ww, wh = getPanelSize()
            self.MainFrame.Size = UDim2.new(0, ww, 0, wh)
        end
    end
    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(reclampAll)
    end

    -- subtle intro bounce
    task.delay(1.0, function()
        if self.SideHandle and self.SideHandle.Parent then
            self:Tween(self.SideHandle, {
                Position = UDim2.new(1, -(EDGE_PAD + 6), self._sideCenterY, 0)
            }, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            task.wait(0.28)
            if self.SideHandle and self.SideHandle.Parent then
                self:Tween(self.SideHandle, {
                    Position = UDim2.new(1, -EDGE_PAD, self._sideCenterY, 0)
                }, 0.25)
            end
        end
    end)
end

function GenesisX:_CreateFloatingButton(config)
    config = config or {}
    local btnSize = self:S(64)

    self.FloatBtn = Instance.new("ImageButton")
    self.FloatBtn.Name = "FloatBtn"
    self.FloatBtn.BackgroundColor3 = self.Theme.Accent
    self.FloatBtn.Position = UDim2.new(0, 20, 0.5, 0)
    self.FloatBtn.Size = UDim2.new(0, btnSize, 0, btnSize)
    self.FloatBtn.AutoButtonColor = false
    self.FloatBtn.ZIndex = 100
    self.FloatBtn.Parent = self.ScreenGui
    self:CreateCorner(self.FloatBtn, UDim.new(1, 0))
    if self.Config.BorderEnabled then
        self:CreateStroke(self.FloatBtn, self.Theme.Accent, 2, 0.4)
    end

    -- FIX: Detectar asset ID para icone do botao flutuante (agora suporta nomes Lucide)
    -- Suporta icone unico ou array de icones rotativos
    local floatIcons = {}
    local rawFloat = config.FloatIcon or config.FloatIconAssetId or config.IconAssetId or config.Icon or "S"
    if type(rawFloat) == "table" then
        for _, icon in ipairs(rawFloat) do
            local asset = self:FormatAssetId(icon)
            if asset then table.insert(floatIcons, asset) end
        end
    else
        local asset = self:FormatAssetId(rawFloat)
        if asset then table.insert(floatIcons, asset) end
    end

    -- Fallback text label (if no valid icons)
    local iconLabel = nil
    if #floatIcons == 0 then
        iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "Icon"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBlack()
        -- If rawFloat is a table, show first char of first element or default "G"
        local fallbackText = "G"
        if type(rawFloat) == "table" and rawFloat[1] then
            fallbackText = tostring(rawFloat[1]):sub(1, 1)
        elseif type(rawFloat) == "string" then
            fallbackText = rawFloat:sub(1, 1)
        end
        iconLabel.Text = fallbackText
        iconLabel.TextColor3 = Color3.new(1, 1, 1)
        iconLabel.TextSize = self:S(22)
        iconLabel.ZIndex = 102
        iconLabel.Parent = self.FloatBtn
    elseif #floatIcons == 1 then
        -- Single icon: apply directly
        self.FloatBtn.Image = floatIcons[1]
        self.FloatBtn.ScaleType = Enum.ScaleType.Crop
    else
        -- Multiple icons: rotate between them
        self.FloatBtn.Image = floatIcons[1]
        self.FloatBtn.ScaleType = Enum.ScaleType.Crop
        local changeSpeed = math.clamp(config.FloatIconChangeSpeed or 2, 0.5, 10)
        local currentIndex = 1
        task.spawn(function()
            while self.FloatBtn and self.FloatBtn.Parent do
                task.wait(changeSpeed)
                if not self.FloatBtn or not self.FloatBtn.Parent then break end
                currentIndex = currentIndex + 1
                if currentIndex > #floatIcons then currentIndex = 1 end
                -- Smooth fade transition
                self:Tween(self.FloatBtn, {ImageTransparency = 1}, 0.15)
                task.wait(0.15)
                if not self.FloatBtn or not self.FloatBtn.Parent then break end
                self.FloatBtn.Image = floatIcons[currentIndex]
                self:Tween(self.FloatBtn, {ImageTransparency = 0}, 0.15)
            end
        end)
    end

    self.FloatBtn.MouseEnter:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.AccentHover}, 0.15)
    end)
    self.FloatBtn.MouseLeave:Connect(function()
        self:Tween(self.FloatBtn, {BackgroundColor3 = self.Theme.Accent}, 0.15)
    end)

    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    local lastDelta = Vector2.new(0, 0)
    local velocity = Vector2.new(0, 0)
    local damping = 0.7  -- Heavy feel

    self.FloatBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.FloatBtn.Position
            velocity = Vector2.new(0, 0)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    self.FloatBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            lastDelta = delta
            velocity = Vector2.new(delta.X - lastDelta.X, delta.Y - lastDelta.Y) * damping
            self.FloatBtn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    self.FloatBtn.MouseButton1Click:Connect(function()
        if not dragging then
            self.MainFrame.Visible = not self.MainFrame.Visible
        end
    end)
end

-- --- CREATE TAB ---------------------------------------------------------------
function GenesisX:CreateTab(config)
    config = config or {}
    local tabId = config.Name or "Tab"
    local btnSize = self:S(46)
    local sideMode = self.SideMode == true
    local tabW = sideMode and (self._sidebarWidth and (self._sidebarWidth - self:S(20)) or self:S(120)) or btnSize
    local tabH = sideMode and self:S(40) or btnSize

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = tabId .. "Tab"
    tabBtn.BackgroundColor3 = self.Theme.Card
    tabBtn.Size = UDim2.new(0, tabW, 0, tabH)
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.ZIndex = 13
    tabBtn.Parent = self.Sidebar
    self:CreateCorner(tabBtn, UDim.new(0, 8))

    -- FIX: Detectar corretamente se Icon e asset ID ou nome Lucide
    local iconRaw = config.Icon or config.IconAssetId
    local iconAssetId = iconRaw and self:FormatAssetId(iconRaw)

    if iconAssetId then
        -- E um asset ID ou nome Lucide valido - renderizar como ImageLabel
        local iconImg = Instance.new("ImageLabel")
        iconImg.Name = "Icon"
        iconImg.BackgroundTransparency = 1
        if sideMode then
            iconImg.AnchorPoint = Vector2.new(0, 0.5)
            iconImg.Position = UDim2.new(0, self:S(10), 0.5, 0)
            iconImg.Size = UDim2.new(0, self:S(18), 0, self:S(18))
        else
            iconImg.AnchorPoint = Vector2.new(0.5, 0.5)
            iconImg.Position = UDim2.new(0.5, 0, 0.5, 0)
            iconImg.Size = UDim2.new(0, self:S(24), 0, self:S(24))
        end
        iconImg.Image = iconAssetId
        iconImg.ImageColor3 = self.Theme.TextMuted
        iconImg.ScaleType = Enum.ScaleType.Stretch
        iconImg.ZIndex = 14
        iconImg.Parent = tabBtn
    else
        -- E texto/emoji - renderizar como TextLabel
        local fallback = iconRaw or tabId:sub(1, 1)
        local iconLabel = Instance.new("TextLabel")
        iconLabel.Name = "Icon"
        iconLabel.BackgroundTransparency = 1
        iconLabel.Size = UDim2.new(1, 0, 1, 0)
        iconLabel.Font = self:GetFontBold()
        iconLabel.Text = tostring(fallback)
        iconLabel.TextColor3 = self.Theme.TextMuted
        iconLabel.TextSize = self:S(16)
        iconLabel.ZIndex = 14
        iconLabel.Parent = tabBtn
    end

    -- SideMode: show tab name beside icon (no hover tooltip needed)
    if sideMode then
        local nameLbl = Instance.new("TextLabel")
        nameLbl.Name = "TabName"
        nameLbl.BackgroundTransparency = 1
        nameLbl.Position = UDim2.new(0, self:S(34), 0, 0)
        nameLbl.Size = UDim2.new(1, -self:S(40), 1, 0)
        nameLbl.Font = self:GetFontSemibold()
        nameLbl.Text = tabId
        nameLbl.TextColor3 = self.Theme.TextMuted
        nameLbl.TextSize = self:S(12)
        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
        nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
        nameLbl.ZIndex = 14
        nameLbl.Parent = tabBtn
        tabBtn:SetAttribute("SideMode", true)
    end

    -- Tooltip (normal mode only)
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.BackgroundColor3 = self.Theme.Card
    tooltip.BorderSizePixel = 0
    tooltip.Position = UDim2.new(1, self:S(10), 0.5, -self:S(11))
    tooltip.Size = UDim2.new(0, 0, 0, self:S(22))
    tooltip.AutomaticSize = Enum.AutomaticSize.X
    tooltip.Font = self:GetFontSemibold()
    tooltip.Text = "  " .. tabId .. "  "
    tooltip.TextColor3 = self.Theme.Text
    tooltip.TextSize = self:S(11)
    tooltip.Visible = false
    tooltip.ZIndex = 1000
    tooltip.Parent = tabBtn
    self:CreateCorner(tooltip, UDim.new(0, 4))
    self:CreateStroke(tooltip, self.Theme.Border, 1, 0.3)

    tabBtn.MouseEnter:Connect(function()
        if self.CurrentTab ~= tabId then
            self:Tween(tabBtn, {BackgroundColor3 = self.Theme.CardHover}, 0.15)
        end
        if not sideMode then
            tooltip.Visible = true
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if self.CurrentTab ~= tabId then
            self:Tween(tabBtn, {BackgroundColor3 = self.Theme.Card}, 0.15)
        end
        tooltip.Visible = false
    end)

    local page = Instance.new("Frame")
    page.Name = tabId .. "Page"
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.Visible = false
    page.ZIndex = 11
    page.Parent = self.ContentArea

    -- Background card for the tab content (covers the game background)
    local bgCard = Instance.new("Frame")
    bgCard.Name = "BgCard"
    bgCard.BackgroundColor3 = self.Theme.Background
    bgCard.BorderSizePixel = 0
    bgCard.Size = UDim2.new(1, 0, 1, 0)
    bgCard.ZIndex = 10
    bgCard.Parent = page
    bgCard.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(bgCard, UDim.new(0, 6))

    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.BackgroundColor3 = self.Theme.Border
    divider.BackgroundTransparency = 0.7
    divider.BorderSizePixel = 0
    divider.Position = UDim2.new(0.5, -1, 0, 0)
    divider.Size = UDim2.new(0, 1, 1, 0)
    divider.ZIndex = 11
    divider.Parent = page

    local function createSide(position, size, name)
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Name = name
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.Position = position
        scrollFrame.Size = size
        scrollFrame.ScrollBarThickness = 3
        scrollFrame.ScrollBarImageColor3 = self.Theme.Accent
        scrollFrame.ScrollBarImageTransparency = 0.5
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        scrollFrame.ZIndex = 11
        scrollFrame.Parent = page

        -- Heavy scroll feel for mobile
        scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Never
        scrollFrame.ScrollingEnabled = true

        -- Heavy scroll feel (desktop + mobile)
        scrollFrame.ScrollBarThickness = 4

        -- Add weight/inertia to scrolling
        local lastScrollPos = 0
        local scrollVelocity = 0
        local isScrolling = false

        scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            local currentPos = scrollFrame.CanvasPosition.Y
            scrollVelocity = currentPos - lastScrollPos
            lastScrollPos = currentPos
            isScrolling = true
        end)

        RunService.Heartbeat:Connect(function()
            if not isScrolling then return end
            if math.abs(scrollVelocity) < 0.5 then
                isScrolling = false
                return
            end
            -- Heavy damping - slows down faster
            scrollVelocity = scrollVelocity * 0.85
        end)
        self:CreateCorner(scrollFrame, UDim.new(0, 8))

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, self.SideMode and self:S(10) or self:S(8))
        layout.Parent = scrollFrame

        local padding = Instance.new("UIPadding")
        local sidePad = self.SideMode and self:S(12) or self:S(8)
        padding.PaddingLeft   = UDim.new(0, sidePad)
        padding.PaddingRight  = UDim.new(0, sidePad)
        padding.PaddingBottom = UDim.new(0, self:S(10))
        padding.PaddingTop    = UDim.new(0, self.SideMode and self:S(4) or 0)
        padding.Parent = scrollFrame

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + self:S(20))
        end)

        return scrollFrame
    end

    local left = createSide(UDim2.new(0, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Left")
    local right = createSide(UDim2.new(0.51, 0, 0, 0), UDim2.new(0.49, 0, 1, 0), "Right")

    local tabData = { Button = tabBtn, Container = page, Left = left, Right = right, Id = tabId }
    self.Tabs[tabId] = tabData

    tabBtn.MouseButton1Click:Connect(function()
        self:SelectTab(tabId)
    end)

    if not self.CurrentTab then
        self:SelectTab(tabId)
    end

    return tabData
end

-- --- SELECT TAB ---------------------------------------------------------------
function GenesisX:SelectTab(tabId)
    if self.CurrentTab == tabId then return end

    local oldTab = self.CurrentTab and self.Tabs[self.CurrentTab]
    local newTab = self.Tabs[tabId]
    if not newTab then return end

    -- Hide old tab
    if oldTab and oldTab.Container then
        oldTab.Container.Visible = false
    end

    -- Show new tab
    newTab.Container.Visible = true

    -- Update sidebar buttons with smooth tween
    for id, data in pairs(self.Tabs) do
        local icon = data.Button:FindFirstChild("Icon")
        local nameLbl = data.Button:FindFirstChild("TabName")
        if id == tabId then
            self:Tween(data.Button, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            if icon then
                if icon:IsA("TextLabel") then
                    self:Tween(icon, {TextColor3 = Color3.new(1, 1, 1)}, 0.2)
                elseif icon:IsA("ImageLabel") then
                    self:Tween(icon, {ImageColor3 = Color3.new(1, 1, 1)}, 0.2)
                end
            end
            if nameLbl and nameLbl:IsA("TextLabel") then
                self:Tween(nameLbl, {TextColor3 = Color3.new(1, 1, 1)}, 0.2)
            end
        else
            self:Tween(data.Button, {BackgroundColor3 = self.Theme.Card}, 0.2)
            if icon then
                if icon:IsA("TextLabel") then
                    self:Tween(icon, {TextColor3 = self.Theme.TextMuted}, 0.2)
                elseif icon:IsA("ImageLabel") then
                    self:Tween(icon, {ImageColor3 = self.Theme.TextMuted}, 0.2)
                end
            end
            if nameLbl and nameLbl:IsA("TextLabel") then
                self:Tween(nameLbl, {TextColor3 = self.Theme.TextMuted}, 0.2)
            end
        end
    end

    self.CurrentTab = tabId
end

-- --- CREATE SECTION -----------------------------------------------------------
function GenesisX:CreateSection(parent, textOrConfig, color, icon)
    -- Compat antigo: CreateSection(parent, "Titulo", color, icon)  -> so o header
    -- Novo:          CreateSection(parent, { Text, Icon, Locked }) -> container + Content
    -- Locked e OPCIONAL: nil/false = desbloqueada
    local isConfig = type(textOrConfig) == "table"
    local text, iconName, wantLocked

    if isConfig then
        text       = textOrConfig.Text or "Section"
        iconName   = textOrConfig.Icon
        wantLocked = textOrConfig.Locked == true
    else
        text       = textOrConfig or "Section"
        iconName   = icon
        wantLocked = false
    end

    local accentCol = self.Theme.Accent
    local iconSize  = self:S(20)
    local headerH   = self:S(36)
    local lockAsset = "rbxassetid://10723434711"

    -- ========== MODO ANTIGO (so header, 100% compatível) ==========
    if not isConfig then
        local wrap = Instance.new("Frame")
        wrap.Name = "Section_" .. text
        wrap.BackgroundTransparency = 1
        wrap.Size = UDim2.new(1, 0, 0, headerH)
        wrap.ZIndex = 12
        wrap.Parent = parent

        local labelBg = Instance.new("Frame")
        labelBg.Name = "LabelBg"
        labelBg.BackgroundTransparency = 1
        labelBg.AutomaticSize = Enum.AutomaticSize.X
        labelBg.Position = UDim2.new(0, self:S(4), 0, 0)
        labelBg.Size = UDim2.new(0, 0, 1, 0)
        labelBg.ZIndex = 13
        labelBg.Parent = wrap

        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.Padding = UDim.new(0, self:S(8))
        layout.Parent = labelBg

        local pad = Instance.new("UIPadding")
        pad.PaddingLeft  = UDim.new(0, self:S(2))
        pad.PaddingRight = UDim.new(0, self:S(6))
        pad.Parent = labelBg

        if iconName then
            local assetId = self:FormatAssetId(iconName)
            if assetId then
                local img = Instance.new("ImageLabel")
                img.Name = "Icon"
                img.BackgroundTransparency = 1
                img.Size = UDim2.fromOffset(iconSize, iconSize)
                img.Image = assetId
                img.ImageColor3 = accentCol
                img.ZIndex = 14
                img.Parent = labelBg
            end
        end

        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.BackgroundTransparency = 1
        label.AutomaticSize = Enum.AutomaticSize.X
        label.Size = UDim2.new(0, 0, 1, 0)
        label.Font = self:GetFontBold()
        label.Text = text
        label.TextColor3 = accentCol
        label.TextSize = self:S(14)
        label.ZIndex = 14
        label.Parent = labelBg

        return wrap
    end

    -- ========== MODO NOVO (config table: Content + Locked) ==========
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Name = "Section_" .. text
    sectionFrame.BackgroundTransparency = 1
    sectionFrame.Size = UDim2.new(1, 0, 0, 0)
    sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    sectionFrame.ClipsDescendants = false
    sectionFrame.ZIndex = 12
    sectionFrame.Parent = parent

    local mainLayout = Instance.new("UIListLayout")
    mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
    mainLayout.Padding = UDim.new(0, self:S(8))
    mainLayout.Parent = sectionFrame

    local wrap = Instance.new("Frame")
    wrap.Name = "Header"
    wrap.BackgroundTransparency = 1
    wrap.Size = UDim2.new(1, 0, 0, headerH)
    wrap.LayoutOrder = 1
    wrap.ZIndex = 13
    wrap.Parent = sectionFrame

    local labelBg = Instance.new("Frame")
    labelBg.Name = "LabelBg"
    labelBg.BackgroundTransparency = 1
    labelBg.AutomaticSize = Enum.AutomaticSize.X
    labelBg.Position = UDim2.new(0, self:S(4), 0, 0)
    labelBg.Size = UDim2.new(0, 0, 1, 0)
    labelBg.ZIndex = 14
    labelBg.Parent = wrap

    local hLayout = Instance.new("UIListLayout")
    hLayout.FillDirection = Enum.FillDirection.Horizontal
    hLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    hLayout.Padding = UDim.new(0, self:S(8))
    hLayout.Parent = labelBg

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft  = UDim.new(0, self:S(2))
    pad.PaddingRight = UDim.new(0, self:S(6))
    pad.Parent = labelBg

    if iconName then
        local assetId = self:FormatAssetId(iconName)
        if assetId then
            local img = Instance.new("ImageLabel")
            img.Name = "Icon"
            img.BackgroundTransparency = 1
            img.Size = UDim2.fromOffset(iconSize, iconSize)
            img.Image = assetId
            img.ImageColor3 = accentCol
            img.ZIndex = 15
            img.Parent = labelBg
        end
    end

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.AutomaticSize = Enum.AutomaticSize.X
    label.Size = UDim2.new(0, 0, 1, 0)
    label.Font = self:GetFontBold()
    label.Text = text
    label.TextColor3 = accentCol
    label.TextSize = self:S(14)
    label.ZIndex = 15
    label.Parent = labelBg

    -- Cadeado no header (só aparece se Locked)
    local headerLock = Instance.new("ImageLabel")
    headerLock.Name = "HeaderLock"
    headerLock.BackgroundTransparency = 1
    headerLock.AnchorPoint = Vector2.new(1, 0.5)
    headerLock.Position = UDim2.new(1, -self:S(8), 0.5, 0)
    headerLock.Size = UDim2.fromOffset(self:S(14), self:S(14))
    headerLock.Image = lockAsset
    headerLock.ImageColor3 = accentCol
    headerLock.ImageTransparency = wantLocked and 0 or 1
    headerLock.Visible = wantLocked
    headerLock.ZIndex = 15
    headerLock.Parent = wrap

    local body = Instance.new("Frame")
    body.Name = "Body"
    body.BackgroundTransparency = 1
    body.Size = UDim2.new(1, 0, 0, 0)
    body.AutomaticSize = Enum.AutomaticSize.Y
    body.ClipsDescendants = true
    body.LayoutOrder = 2
    body.ZIndex = 12
    body.Parent = sectionFrame

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Size = UDim2.new(1, 0, 0, 0)
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.ClipsDescendants = false
    content.ZIndex = 12
    content.Parent = body

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, self:S(8))
    contentLayout.Parent = content

    local overlay = Instance.new("Frame")
    overlay.Name = "LockOverlay"
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = wantLocked and 0.5 or 1
    overlay.BorderSizePixel = 0
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.Size = UDim2.new(1, 0, 0, 0)
    overlay.ZIndex = 100
    overlay.Visible = wantLocked
    overlay.Active = wantLocked
    overlay.Parent = body

    local overlayCorner = Instance.new("UICorner")
    overlayCorner.CornerRadius = UDim.new(0, 6)
    overlayCorner.Parent = overlay

    local lockSize = self:S(56)
    local lockIcon = Instance.new("ImageLabel")
    lockIcon.Name = "LockIcon"
    lockIcon.BackgroundTransparency = 1
    lockIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    lockIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    lockIcon.Size = UDim2.fromOffset(lockSize, lockSize)
    lockIcon.Image = lockAsset
    lockIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    lockIcon.ImageTransparency = wantLocked and 0 or 1
    lockIcon.ScaleType = Enum.ScaleType.Fit
    lockIcon.ZIndex = 101
    lockIcon.Parent = overlay

    local function syncOverlaySize()
        local h = content.AbsoluteSize.Y
        if h < 1 then h = 0 end
        overlay.Size = UDim2.new(1, 0, 0, h)
    end

    content:GetPropertyChangedSignal("AbsoluteSize"):Connect(syncOverlaySize)
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        task.defer(syncOverlaySize)
    end)
    task.defer(syncOverlaySize)

    local isLocked = wantLocked

    local function setLocked(state, instant)
        state = state == true
        if isLocked == state and not instant then return end
        isLocked = state
        syncOverlaySize()

        headerLock.Visible = state
        if instant then
            headerLock.ImageTransparency = state and 0 or 1
        else
            self:Tween(headerLock, { ImageTransparency = state and 0 or 1 }, 0.2)
        end

        if state then
            overlay.Visible = true
            overlay.Active = true
            if instant then
                overlay.BackgroundTransparency = 0.5
                lockIcon.ImageTransparency = 0
            else
                overlay.BackgroundTransparency = 1
                lockIcon.ImageTransparency = 1
                self:Tween(overlay, { BackgroundTransparency = 0.5 }, 0.3)
                self:Tween(lockIcon, { ImageTransparency = 0 }, 0.35)
            end
        else
            overlay.Active = false
            if instant then
                overlay.BackgroundTransparency = 1
                lockIcon.ImageTransparency = 1
                overlay.Visible = false
            else
                self:Tween(overlay, { BackgroundTransparency = 1 }, 0.3)
                self:Tween(lockIcon, { ImageTransparency = 1 }, 0.25)
                task.delay(0.32, function()
                    if overlay and overlay.Parent and not isLocked then
                        overlay.Visible = false
                    end
                end)
            end
        end
    end

    return {
        Frame     = sectionFrame,
        Header    = wrap,
        Content   = content,
        Overlay   = overlay,
        IsLocked  = function() return isLocked end,
        SetLocked = function(v, instant) setLocked(v, instant) end,
        Unlock    = function(instant) setLocked(false, instant) end,
        Lock      = function(instant) setLocked(true, instant) end,
    }
end

function GenesisX:CreateToggle(parent, config)
    config = config or {}
    local text = config.Text or "Toggle"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local height = self:S(46)

    local frame = Instance.new("Frame")
    frame.Name = "Toggle_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.5)

    local hoverFill = Instance.new("Frame")
    hoverFill.Name = "HoverFill"
    hoverFill.BackgroundColor3 = Color3.new(1, 1, 1)
    hoverFill.BackgroundTransparency = 1
    hoverFill.BorderSizePixel = 0
    hoverFill.Size = UDim2.new(1, 0, 1, 0)
    hoverFill.ZIndex = 0
    hoverFill.Parent = frame
    self:CreateCorner(hoverFill)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, 0)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(13)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 13
    label.Parent = frame

    local trackWidth, trackHeight = self:S(46), self:S(24)
    local track = Instance.new("TextButton")
    track.Name = "Track"
    track.AutoButtonColor = false
    track.BackgroundColor3 = default and self.Theme.ToggleOn or self.Theme.ToggleOff
    track.Position = UDim2.new(1, -trackWidth - self:S(14), 0.5, -trackHeight/2)
    track.Size = UDim2.new(0, trackWidth, 0, trackHeight)
    track.Text = ""
    track.ZIndex = 14
    track.Parent = frame
    self:CreateCorner(track, UDim.new(1, 0))
    self:CreateStroke(track, default and self.Theme.Accent or self.Theme.Border, 1, default and 0.2 or 0.5)

    local trackStroke = track:FindFirstChildOfClass("UIStroke")
    local knobSize = self:S(18)

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Position = default and UDim2.new(1, -knobSize - self:S(3), 0.5, -knobSize/2)
                              or UDim2.new(0, self:S(3), 0.5, -knobSize/2)
    knob.Size = UDim2.new(0, knobSize, 0, knobSize)
    knob.ZIndex = 15
    knob.Parent = track
    self:CreateCorner(knob, UDim.new(1, 0))
    self:CreateStroke(knob, Color3.fromRGB(200, 200, 200), 1, 0.3)

    local state = default

    local function update(newState, animated)
        local time = animated == false and 0 or 0.2
        state = newState
        if state then
            self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOn}, time)
            if trackStroke then self:Tween(trackStroke, {Color = self.Theme.Accent, Transparency = 0.2}, time) end
            self:Tween(knob, {Position = UDim2.new(1, -knobSize - self:S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        else
            self:Tween(track, {BackgroundColor3 = self.Theme.ToggleOff}, time)
            if trackStroke then self:Tween(trackStroke, {Color = self.Theme.Border, Transparency = 0.5}, time) end
            self:Tween(knob, {Position = UDim2.new(0, self:S(3), 0.5, -knobSize/2)}, time, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end
    end

    track.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        update(state)
    end)
    frame.MouseEnter:Connect(function() self:Tween(hoverFill, {BackgroundTransparency = 0.97}, 0.15) end)
    frame.MouseLeave:Connect(function() self:Tween(hoverFill, {BackgroundTransparency = 1}, 0.15) end)

    return {
        Frame = frame,
        GetState = function() return state end,
        SetState = function(s) state = s; callback(state); update(state) end,
    }
end

-- --- CREATE BUTTON ------------------------------------------------------------
function GenesisX:CreateButton(parent, config)
    config = config or {}
    local text     = config.Text     or "Button"
    local style    = config.Style    or "default"
    local callback = config.Callback or function() end
    local height   = self:S(40)

    local frame = Instance.new("Frame")
    frame.Name = "Button_" .. text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent

    -- padding pra nao cortar nas laterais
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft  = UDim.new(0, self:S(4))
    pad.PaddingRight = UDim.new(0, self:S(4))
    pad.Parent = frame

    local bgColor, bgHover, strokeColor, textColor
    if style == "accent" then
        bgColor     = self.Theme.AccentDark
        bgHover     = self.Theme.Accent
        strokeColor = self.Theme.Accent
        textColor   = Color3.new(1, 1, 1)
    elseif style == "warning" then
        bgColor     = Color3.fromRGB(40, 25, 5)
        bgHover     = Color3.fromRGB(55, 35, 8)
        strokeColor = Color3.fromRGB(200, 130, 30)
        textColor   = Color3.new(1, 1, 1)
    elseif style == "info" then
        bgColor     = Color3.fromRGB(10, 20, 45)
        bgHover     = Color3.fromRGB(15, 28, 60)
        strokeColor = Color3.fromRGB(80, 140, 230)
        textColor   = Color3.new(1, 1, 1)
    elseif style == "danger" then
        bgColor     = Color3.fromRGB(45, 10, 10)
        bgHover     = Color3.fromRGB(60, 15, 15)
        strokeColor = Color3.fromRGB(210, 60, 60)
        textColor   = Color3.new(1, 1, 1)
    elseif style == "success" then
        bgColor     = Color3.fromRGB(10, 40, 20)
        bgHover     = Color3.fromRGB(15, 55, 28)
        strokeColor = Color3.fromRGB(60, 200, 100)
        textColor   = Color3.new(1, 1, 1)
    else
        -- Default: theme-aware (adapts to Dark/Light automatically)
        bgColor     = self.Theme.Card
        bgHover     = self.Theme.CardHover
        strokeColor = self.Theme.Accent
        textColor   = self.Theme.Text
    end

    local btn = Instance.new("TextButton")
    btn.Name = "Button"
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Font = self:GetFontBold()
    btn.Text = text
    btn.TextSize = self:S(13)
    btn.TextColor3 = textColor
    btn.BackgroundColor3 = bgColor
    btn.ZIndex = 13
    btn.Parent = frame
    self:CreateCorner(btn)
    self:CreateStroke(btn, strokeColor, 1.2, 0.2)

    local rippleHolder = Instance.new("Frame")
    rippleHolder.Name = "RippleHolder"
    rippleHolder.BackgroundTransparency = 1
    rippleHolder.BorderSizePixel = 0
    rippleHolder.Size = UDim2.new(1, 0, 1, 0)
    rippleHolder.ClipsDescendants = true
    rippleHolder.ZIndex = btn.ZIndex + 1
    rippleHolder.Parent = btn
    self:CreateCorner(rippleHolder)

    btn.MouseEnter:Connect(function()
        local targetHover = bgHover
        if style == "default" then
            targetHover = self.Theme.CardHover
        end
        self:Tween(btn, {BackgroundColor3 = targetHover}, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        local targetBg = bgColor
        if style == "default" then
            targetBg = self.Theme.Card
        end
        self:Tween(btn, {BackgroundColor3 = targetBg}, 0.15)
    end)
    btn.MouseButton1Click:Connect(function()
        callback()
    end)

    return {
        Frame  = frame,
        Button = btn,
        SetText     = function(t)  btn.Text = t end,
        SetCallback = function(cb) callback  = cb end,
    }
end

-- --- CREATE INPUT -------------------------------------------------------------
function GenesisX:CreateInput(parent, config)
    config = config or {}
    local labelText = config.Label or "Input"
    local default = config.Default or ""
    local placeholder = config.Placeholder or "Digite aqui..."
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Input_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = true
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    local stroke = self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(16))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.BackgroundColor3 = self.Theme.Input
    textBox.Position = UDim2.new(0, self:S(12), 0, self:S(28))
    textBox.Size = UDim2.new(1, -self:S(24), 0, self:S(26))
    textBox.Font = self:GetFont()
    textBox.Text = tostring(default)
    textBox.PlaceholderText = placeholder
    textBox.PlaceholderColor3 = self.Theme.TextMuted
    textBox.TextColor3 = self.Theme.Text
    textBox.TextSize = self:S(13)
    textBox.ClearTextOnFocus = false
    textBox.TextTruncate = Enum.TextTruncate.AtEnd
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.ClipsDescendants = true
    textBox.ZIndex = 14
    textBox.Parent = frame
    self:CreateCorner(textBox, UDim.new(0, 5))

    local textPad = Instance.new("UIPadding")
    textPad.PaddingLeft = UDim.new(0, self:S(8))
    textPad.PaddingRight = UDim.new(0, self:S(8))
    textPad.Parent = textBox

    textBox.Focused:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Accent, Transparency = 0.1}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.Accent}, 0.2)
    end)
    textBox.FocusLost:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.TextMuted}, 0.2)
        callback(textBox.Text)
    end)

    return {
        Frame = frame,
        TextBox = textBox,
        GetText = function() return textBox.Text end,
        SetText = function(t) textBox.Text = t end,
    }
end

-- --- CREATE NUMBER INPUT ------------------------------------------------------
function GenesisX:CreateNumberInput(parent, config)
    config = config or {}
    local labelText = config.Label or "Number"
    local default = config.Default or 0
    local min = config.Min or -math.huge
    local max = config.Max or math.huge
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "NumberInput_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = true
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    local stroke = self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(16))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.BackgroundColor3 = self.Theme.Input
    textBox.Position = UDim2.new(0, self:S(12), 0, self:S(28))
    textBox.Size = UDim2.new(1, -self:S(24), 0, self:S(26))
    textBox.Font = self:GetFontBold()
    textBox.Text = tostring(default)
    textBox.TextColor3 = self.Theme.Text
    textBox.TextSize = self:S(13)
    textBox.ClearTextOnFocus = false
    textBox.TextTruncate = Enum.TextTruncate.AtEnd
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.ClipsDescendants = true
    textBox.ZIndex = 14
    textBox.Parent = frame
    self:CreateCorner(textBox, UDim.new(0, 5))

    local textPad = Instance.new("UIPadding")
    textPad.PaddingLeft = UDim.new(0, self:S(8))
    textPad.PaddingRight = UDim.new(0, self:S(8))
    textPad.Parent = textBox

    textBox.Focused:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Accent, Transparency = 0.1}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.Accent}, 0.2)
    end)
    textBox.FocusLost:Connect(function()
        self:Tween(stroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        self:Tween(label, {TextColor3 = self.Theme.TextMuted}, 0.2)
        local value = tonumber(textBox.Text)
        if value then
            value = math.clamp(value, min, max)
            textBox.Text = tostring(value)
            callback(value)
        else
            textBox.Text = tostring(default)
        end
    end)

    return {
        Frame = frame,
        TextBox = textBox,
        GetValue = function() return tonumber(textBox.Text) end,
        SetValue = function(v)
            v = math.clamp(v, min, max)
            textBox.Text = tostring(v)
        end,
    }
end

-- --- CREATE SLIDER ------------------------------------------------------------
function GenesisX:CreateSlider(parent, config)
    config = config or {}
    local text     = config.Text      or "Slider"
    local min      = config.Min       or 0
    local max      = config.Max       or 100
    local default  = config.Default   or min
    local increment = config.Increment or nil
    local callback = config.Callback  or function() end
    local height   = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Slider_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(0.6, 0, 0, self:S(18))
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(12)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    -- -- Valor clicavel (vira TextBox ao clicar) ----------------------------
    local valueBg = Instance.new("Frame")
    valueBg.Name = "ValueBg"
    valueBg.BackgroundColor3 = self.Theme.Accent
    valueBg.Position = UDim2.new(1, -self:S(42), 0, self:S(8))
    valueBg.Size = UDim2.new(0, self:S(36), 0, self:S(22))
    valueBg.ZIndex = 14
    valueBg.Parent = frame
    self:CreateCorner(valueBg, UDim.new(0, 4))

    -- Label de display (visivel normalmente)
    local valueLabel = Instance.new("TextButton")
    valueLabel.Name = "ValueLabel"
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(1, 0, 1, 0)
    valueLabel.Font = self:GetFontBold()
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.new(1, 1, 1)
    valueLabel.TextSize = self:S(11)
    valueLabel.AutoButtonColor = false
    valueLabel.ZIndex = 16
    valueLabel.Parent = valueBg

    -- TextBox de input (invisivel por padrao)
    local valueInput = Instance.new("TextBox")
    valueInput.Name = "ValueInput"
    valueInput.BackgroundTransparency = 1
    valueInput.Size = UDim2.new(1, 0, 1, 0)
    valueInput.Font = self:GetFontBold()
    valueInput.Text = ""
    valueInput.PlaceholderText = ""
    valueInput.TextColor3 = Color3.new(1, 1, 1)
    valueInput.TextSize = self:S(11)
    valueInput.ClearTextOnFocus = true
    valueInput.Visible = false
    valueInput.ZIndex = 17
    valueInput.Parent = valueBg

    -- -- Track --------------------------------------------------------------
    local trackHeight = self:S(6)
    local trackBg = Instance.new("Frame")
    trackBg.Name = "TrackBg"
    trackBg.BackgroundColor3 = self.Theme.Input
    trackBg.Position = UDim2.new(0, self:S(14), 1, -self:S(20))
    trackBg.Size = UDim2.new(1, -self:S(28), 0, trackHeight)
    trackBg.ZIndex = 13
    trackBg.Parent = frame
    self:CreateCorner(trackBg, UDim.new(1, 0))

    local fill = Instance.new("Frame")
    fill.Name = "Fill"
    fill.BackgroundColor3 = self.Theme.Accent
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.ZIndex = 14
    fill.Parent = trackBg
    self:CreateCorner(fill, UDim.new(1, 0))

    local knobSize = self:S(16)
    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Position = UDim2.new((default - min) / (max - min), -knobSize/2, 0.5, -knobSize/2)
    knob.Size = UDim2.new(0, knobSize, 0, knobSize)
    knob.ZIndex = 15
    knob.Parent = trackBg
    self:CreateCorner(knob, UDim.new(1, 0))
    self:CreateStroke(knob, self.Theme.Accent, 2, 0)

    local dragging = false
    local currentValue = default

    local function snapValue(v)
        if increment then
            v = math.floor((v - min) / increment + 0.5) * increment + min
        end
        return math.floor(math.clamp(v, min, max) * 100) / 100
    end

    local function applyValue(v)
        currentValue = snapValue(v)
        local percent = (currentValue - min) / (max - min)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -knobSize/2, 0.5, -knobSize/2)
        valueLabel.Text = tostring(currentValue)
        callback(currentValue)
    end

    local function updateFromDrag(input)
        local percent = math.clamp(
            (input.Position.X - trackBg.AbsolutePosition.X) / trackBg.AbsoluteSize.X, 0, 1
        )
        applyValue(min + (max - min) * percent)
    end

    trackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromDrag(input)
        end
    end)
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch) then
            updateFromDrag(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- -- Clique no valor -> vira input ---------------------------------------
    valueLabel.MouseButton1Click:Connect(function()
        valueLabel.Visible = false
        valueInput.Visible = true
        valueInput.Text = tostring(currentValue)
        valueInput:CaptureFocus()
    end)

    valueInput.FocusLost:Connect(function(enterPressed)
        local typed = tonumber(valueInput.Text)
        if typed then
            applyValue(typed)
        end
        valueInput.Visible = false
        valueLabel.Visible = true
        valueLabel.Text = tostring(currentValue)
    end)

    -- highlight ao hover no valor
    valueBg.MouseEnter:Connect(function()
        self:Tween(valueBg, {BackgroundColor3 = self.Theme.AccentHover}, 0.15)
    end)
    valueBg.MouseLeave:Connect(function()
        self:Tween(valueBg, {BackgroundColor3 = self.Theme.Accent}, 0.15)
    end)

    return {
        Frame    = frame,
        GetValue = function() return currentValue end,
        SetValue = function(v) applyValue(v) end,
    }
end

-- --- HELPER: POSICAO DO DROPDOWN ----------------------------------------------
local function getDropdownPosition(button, layout, maxHeight)
    local btnPos = button.AbsolutePosition
    local btnSize = button.AbsoluteSize
    local contentHeight = layout.AbsoluteContentSize.Y + 12
    local targetHeight = math.min(contentHeight, maxHeight)
    local success, camera = pcall(function() return workspace.CurrentCamera end)
    local screenHeight = (success and camera) and camera.ViewportSize.Y or 768
    local targetY = btnPos.Y + btnSize.Y + 4
    if targetY + targetHeight > screenHeight then
        targetY = btnPos.Y - targetHeight - 4
    end
    return UDim2.fromOffset(btnPos.X, targetY), targetHeight, contentHeight
end

-- --- CREATE DROPDOWN ----------------------------------------------------------
function GenesisX:CreateDropdown(parent, config)
    config = config or {}
    local labelText = config.Label or "Dropdown"
    local options = config.Options or {}
    local default = config.Default
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "Dropdown_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = false
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(14))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local dropBtn = Instance.new("TextButton")
    dropBtn.Name = "DropBtn"
    dropBtn.BackgroundColor3 = self.Theme.Input
    dropBtn.AutoButtonColor = false
    dropBtn.Position = UDim2.new(0, self:S(12), 0, self:S(26))
    dropBtn.Size = UDim2.new(1, -self:S(24), 0, self:S(28))
    dropBtn.Font = self:GetFontSemibold()
    dropBtn.Text = "  " .. (default or "Selecionar...")
    dropBtn.TextColor3 = default and self.Theme.Text or self.Theme.TextMuted
    dropBtn.TextSize = self:S(12)
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.ZIndex = 14
    dropBtn.Parent = frame
    self:CreateCorner(dropBtn, UDim.new(0, 6))
    local dropStroke = self:CreateStroke(dropBtn, self.Theme.Border, 1, 0.4)

    -- SETA LUCIDE (chevron-down)
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "Arrow"
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -self:S(28), 0, 0)
    arrow.Size = UDim2.new(0, self:S(26), 1, 0)
    arrow.Image = self:FormatAssetId("lucide-chevron-down") or ""
    arrow.ImageColor3 = self.Theme.Accent
    arrow.ZIndex = 15
    arrow.Parent = dropBtn

    local selected = default
    local isOpen = false

    local overlay = Instance.new("Frame")
    overlay.Name = "DropdownOverlay"
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 500
    overlay.Visible = false
    overlay.Parent = self.ScreenGui

    local listContainer = Instance.new("Frame")
    listContainer.Name = "ListContainer"
    listContainer.BackgroundColor3 = self.Theme.Card
    listContainer.BorderSizePixel = 0
    listContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    listContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    listContainer.Size = UDim2.new(0, 0, 0, 0)
    listContainer.ZIndex = 501
    listContainer.Visible = false
    listContainer.Parent = overlay
    self:CreateCorner(listContainer, UDim.new(0, 10))
    self:CreateStroke(listContainer, self.Theme.Accent, 1.5, 0.3)

    local listTitle = Instance.new("TextLabel")
    listTitle.Name = "Title"
    listTitle.BackgroundTransparency = 1
    listTitle.Position = UDim2.new(0, self:S(16), 0, self:S(12))
    listTitle.Size = UDim2.new(1, -self:S(32), 0, self:S(22))
    listTitle.Font = self:GetFontBold()
    listTitle.Text = labelText
    listTitle.TextColor3 = self.Theme.Text
    listTitle.TextSize = self:S(14)
    listTitle.TextXAlignment = Enum.TextXAlignment.Left
    listTitle.ZIndex = 502
    listTitle.Parent = listContainer

    local dropList = Instance.new("ScrollingFrame")
    dropList.Name = "DropList"
    dropList.BackgroundTransparency = 1
    dropList.BorderSizePixel = 0
    dropList.Position = UDim2.new(0, self:S(12), 0, self:S(40))
    dropList.Size = UDim2.new(1, -self:S(24), 1, -self:S(52))
    dropList.ScrollBarThickness = 4
    dropList.ScrollBarImageColor3 = self.Theme.Accent
    dropList.ScrollBarImageTransparency = 0.4
    dropList.ZIndex = 502
    dropList.Parent = listContainer

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, self:S(4))
    listLayout.Parent = dropList

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop    = UDim.new(0, self:S(4))
    listPadding.PaddingBottom = UDim.new(0, self:S(4))
    listPadding.PaddingLeft   = UDim.new(0, self:S(4))
    listPadding.PaddingRight  = UDim.new(0, self:S(4))
    listPadding.Parent = dropList

    local function closeDropdown()
        if not isOpen then return end
        isOpen = false
        self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
        self:Tween(listContainer, {Size = UDim2.new(0, self:S(320), 0, 0)}, 0.2)
        self:Tween(arrow, {Rotation = 0}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        end
        task.wait(0.2)
        overlay.Visible = false
        listContainer.Visible = false
    end

    local function populate()
        for _, child in ipairs(dropList:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for _, option in ipairs(options) do
            local isSelected = option == selected

            local row = Instance.new("Frame")
            row.BackgroundColor3 = isSelected and self.Theme.AccentDark or self.Theme.Input
            row.Size = UDim2.new(1, 0, 0, self:S(36))
            row.ZIndex = 503
            row.Parent = dropList
            self:CreateCorner(row, UDim.new(0, 6))

            if isSelected then
                self:CreateStroke(row, self.Theme.Accent, 1, 0.2)
                -- CHECKMARK LUCIDE (check)
                local check = Instance.new("ImageLabel")
                check.Name = "Check"
                check.BackgroundTransparency = 1
                check.Position = UDim2.new(0, self:S(10), 0.5, -self:S(8))
                check.Size = UDim2.new(0, self:S(16), 0, self:S(16))
                check.Image = self:FormatAssetId("lucide-check") or ""
                check.ImageColor3 = Color3.new(1, 1, 1)
                check.ZIndex = 504
                check.Parent = row
            end

            local rowBtn = Instance.new("TextButton")
            rowBtn.BackgroundTransparency = 1
            rowBtn.Size = UDim2.new(1, 0, 1, 0)
            rowBtn.Font = self:GetFontSemibold()
            rowBtn.Text = (isSelected and "    " or "  ") .. option
            rowBtn.TextColor3 = isSelected and Color3.new(1, 1, 1) or self.Theme.TextSecondary
            rowBtn.TextSize = self:S(12)
            rowBtn.TextXAlignment = Enum.TextXAlignment.Left
            rowBtn.ZIndex = 504
            rowBtn.Parent = row

            local rowPad = Instance.new("UIPadding")
            rowPad.PaddingLeft = UDim.new(0, isSelected and self:S(32) or self:S(12))
            rowPad.Parent = rowBtn

            rowBtn.MouseButton1Click:Connect(function()
                selected = option
                dropBtn.Text = "  " .. option
                dropBtn.TextColor3 = self.Theme.Text
                callback(option)
                closeDropdown()
            end)
            rowBtn.MouseEnter:Connect(function()
                if not isSelected then
                    self:Tween(row, {BackgroundColor3 = self.Theme.CardHover}, 0.1)
                end
            end)
            rowBtn.MouseLeave:Connect(function()
                if not isSelected then
                    self:Tween(row, {BackgroundColor3 = self.Theme.Input}, 0.1)
                end
            end)
        end
    end

    dropBtn.MouseEnter:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.InputHover}, 0.15)
    end)
    dropBtn.MouseLeave:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.Input}, 0.15)
    end)

    dropBtn.MouseButton1Click:Connect(function()
        if isOpen then closeDropdown(); return end
        populate()
        local contentHeight = listLayout.AbsoluteContentSize.Y + self:S(60)
        local targetHeight = math.min(contentHeight, self:S(360))
        local targetWidth = self:S(320)
        overlay.Visible = true
        listContainer.Visible = true
        overlay.BackgroundTransparency = 1
        listContainer.Size = UDim2.new(0, targetWidth, 0, 0)
        self:Tween(overlay, {BackgroundTransparency = 0.45}, 0.25)
        self:Tween(listContainer, {
            Size = UDim2.new(0, targetWidth, 0, targetHeight)
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        self:Tween(arrow, {Rotation = 180}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2)
        end
        dropList.CanvasSize = UDim2.new(0, 0, 0,
            listLayout.AbsoluteContentSize.Y + self:S(16))
        isOpen = true
    end)

    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position
            local listPos = listContainer.AbsolutePosition
            local listSize = listContainer.AbsoluteSize
            local inList = pos.X >= listPos.X and pos.X <= listPos.X + listSize.X
                       and pos.Y >= listPos.Y and pos.Y <= listPos.Y + listSize.Y
            if not inList then closeDropdown() end
        end
    end)

    return {
        Frame    = frame,
        GetValue = function() return selected end,
        SetValue = function(v)
            selected = v
            dropBtn.Text = "  " .. (v or "Selecionar...")
            dropBtn.TextColor3 = v and self.Theme.Text or self.Theme.TextMuted
        end,
        SetOptions = function(newOptions) options = newOptions end,
    }
end

function GenesisX:CreateMultiDropdown(parent, config)
    config = config or {}
    local labelText = config.Label or "Multi Select"
    local options = config.Options or {}
    local default = config.Default or {}
    local callback = config.Callback or function() end
    local height = self:S(62)

    local frame = Instance.new("Frame")
    frame.Name = "MultiDropdown_" .. labelText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ClipsDescendants = false
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    label.Size = UDim2.new(1, -self:S(28), 0, self:S(14))
    label.Font = self:GetFontSemibold()
    label.Text = labelText
    label.TextColor3 = self.Theme.TextMuted
    label.TextSize = self:S(10)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = frame

    local dropBtn = Instance.new("TextButton")
    dropBtn.Name = "DropBtn"
    dropBtn.BackgroundColor3 = self.Theme.Input
    dropBtn.AutoButtonColor = false
    dropBtn.Position = UDim2.new(0, self:S(12), 0, self:S(26))
    dropBtn.Size = UDim2.new(1, -self:S(24), 0, self:S(28))
    dropBtn.Font = self:GetFontSemibold()
    dropBtn.Text = "  Selecionar..."
    dropBtn.TextColor3 = self.Theme.TextMuted
    dropBtn.TextSize = self:S(12)
    dropBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropBtn.ZIndex = 14
    dropBtn.Parent = frame
    self:CreateCorner(dropBtn, UDim.new(0, 6))
    local dropStroke = self:CreateStroke(dropBtn, self.Theme.Border, 1, 0.4)

    -- SETA LUCIDE (chevron-down)
    local arrow = Instance.new("ImageLabel")
    arrow.Name = "Arrow"
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1, -self:S(28), 0, 0)
    arrow.Size = UDim2.new(0, self:S(26), 1, 0)
    arrow.Image = self:FormatAssetId("lucide-chevron-down") or ""
    arrow.ImageColor3 = self.Theme.Accent
    arrow.ZIndex = 15
    arrow.Parent = dropBtn

    local selected = {}
    for _, v in ipairs(default) do table.insert(selected, v) end
    local isOpen = false

    local overlay = Instance.new("Frame")
    overlay.Name = "MultiDropdownOverlay"
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.ZIndex = 500
    overlay.Visible = false
    overlay.Parent = self.ScreenGui

    local listContainer = Instance.new("Frame")
    listContainer.Name = "ListContainer"
    listContainer.BackgroundColor3 = self.Theme.Card
    listContainer.BorderSizePixel = 0
    listContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    listContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    listContainer.Size = UDim2.new(0, 0, 0, 0)
    listContainer.ZIndex = 501
    listContainer.Visible = false
    listContainer.Parent = overlay
    self:CreateCorner(listContainer, UDim.new(0, 10))
    self:CreateStroke(listContainer, self.Theme.Accent, 1.5, 0.3)

    local listTitle = Instance.new("TextLabel")
    listTitle.Name = "Title"
    listTitle.BackgroundTransparency = 1
    listTitle.Position = UDim2.new(0, self:S(16), 0, self:S(12))
    listTitle.Size = UDim2.new(0.6, 0, 0, self:S(22))
    listTitle.Font = self:GetFontBold()
    listTitle.Text = labelText
    listTitle.TextColor3 = self.Theme.Text
    listTitle.TextSize = self:S(14)
    listTitle.TextXAlignment = Enum.TextXAlignment.Left
    listTitle.ZIndex = 502
    listTitle.Parent = listContainer

    local countBadge = Instance.new("TextLabel")
    countBadge.Name = "CountBadge"
    countBadge.BackgroundColor3 = self.Theme.Accent
    countBadge.Position = UDim2.new(1, -self:S(48), 0, self:S(10))
    countBadge.Size = UDim2.new(0, self:S(36), 0, self:S(22))
    countBadge.Font = self:GetFontBold()
    countBadge.Text = "0"
    countBadge.TextColor3 = Color3.new(1, 1, 1)
    countBadge.TextSize = self:S(11)
    countBadge.ZIndex = 502
    countBadge.Parent = listContainer
    self:CreateCorner(countBadge, UDim.new(0, 4))

    local dropList = Instance.new("ScrollingFrame")
    dropList.Name = "DropList"
    dropList.BackgroundTransparency = 1
    dropList.BorderSizePixel = 0
    dropList.Position = UDim2.new(0, self:S(12), 0, self:S(42))
    dropList.Size = UDim2.new(1, -self:S(24), 1, -self:S(56))
    dropList.ScrollBarThickness = 4
    dropList.ScrollBarImageColor3 = self.Theme.Accent
    dropList.ScrollBarImageTransparency = 0.4
    dropList.ZIndex = 502
    dropList.Parent = listContainer

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, self:S(4))
    listLayout.Parent = dropList

    local listPadding = Instance.new("UIPadding")
    listPadding.PaddingTop    = UDim.new(0, self:S(4))
    listPadding.PaddingBottom = UDim.new(0, self:S(4))
    listPadding.PaddingLeft   = UDim.new(0, self:S(4))
    listPadding.PaddingRight  = UDim.new(0, self:S(4))
    listPadding.Parent = dropList

    local function updateText()
        if #selected == 0 then
            dropBtn.Text = "  Selecionar..."
            dropBtn.TextColor3 = self.Theme.TextMuted
        elseif #selected == 1 then
            dropBtn.Text = "  " .. selected[1]
            dropBtn.TextColor3 = self.Theme.Text
        else
            dropBtn.Text = "  " .. #selected .. " selecionados"
            dropBtn.TextColor3 = self.Theme.Text
        end
        countBadge.Text = tostring(#selected)
    end

    local function closeDropdown()
        if not isOpen then return end
        isOpen = false
        self:Tween(overlay, {BackgroundTransparency = 1}, 0.2)
        self:Tween(listContainer, {Size = UDim2.new(0, self:S(320), 0, 0)}, 0.2)
        self:Tween(arrow, {Rotation = 0}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2)
        end
        task.wait(0.2)
        overlay.Visible = false
        listContainer.Visible = false
    end

    local function isSelectedFn(name)
        for _, v in ipairs(selected) do
            if v == name then return true end
        end
        return false
    end

    local function toggle(name)
        for i, v in ipairs(selected) do
            if v == name then
                table.remove(selected, i)
                return false
            end
        end
        table.insert(selected, name)
        return true
    end

    local function populate()
        for _, child in ipairs(dropList:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end

        for _, option in ipairs(options) do
            local sel = isSelectedFn(option)

            local row = Instance.new("Frame")
            row.BackgroundColor3 = sel and self.Theme.AccentDark or self.Theme.Input
            row.Size = UDim2.new(1, 0, 0, self:S(38))
            row.ZIndex = 503
            row.Parent = dropList
            self:CreateCorner(row, UDim.new(0, 6))

            local cbSize = self:S(18)
            local checkbox = Instance.new("Frame")
            checkbox.Name = "Checkbox"
            checkbox.BackgroundColor3 = sel and self.Theme.Accent or self.Theme.Border
            checkbox.Position = UDim2.new(0, self:S(10), 0.5, -cbSize/2)
            checkbox.Size = UDim2.new(0, cbSize, 0, cbSize)
            checkbox.ZIndex = 504
            checkbox.Parent = row
            self:CreateCorner(checkbox, UDim.new(0, 4))

            if sel then
                -- CHECKMARK LUCIDE (check)
                local check = Instance.new("ImageLabel")
                check.Name = "Check"
                check.BackgroundTransparency = 1
                check.Size = UDim2.new(1, 0, 1, 0)
                check.Image = self:FormatAssetId("lucide-check") or ""
                check.ImageColor3 = Color3.new(1, 1, 1)
                check.ZIndex = 505
                check.Parent = checkbox
            end

            local rowBtn = Instance.new("TextButton")
            rowBtn.BackgroundTransparency = 1
            rowBtn.Size = UDim2.new(1, 0, 1, 0)
            rowBtn.Font = self:GetFontSemibold()
            rowBtn.Text = "      " .. option
            rowBtn.TextColor3 = sel and Color3.new(1, 1, 1) or self.Theme.TextSecondary
            rowBtn.TextSize = self:S(12)
            rowBtn.TextXAlignment = Enum.TextXAlignment.Left
            rowBtn.ZIndex = 504
            rowBtn.Parent = row

            local rowPad = Instance.new("UIPadding")
            rowPad.PaddingLeft = UDim.new(0, self:S(12))
            rowPad.Parent = rowBtn

            rowBtn.MouseButton1Click:Connect(function()
                toggle(option)
                callback(selected)
                updateText()
                populate()
            end)
            rowBtn.MouseEnter:Connect(function()
                if not sel then
                    self:Tween(row, {BackgroundColor3 = self.Theme.CardHover}, 0.1)
                end
            end)
            rowBtn.MouseLeave:Connect(function()
                if not sel then
                    self:Tween(row, {BackgroundColor3 = self.Theme.Input}, 0.1)
                end
            end)
        end
    end

    dropBtn.MouseEnter:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.InputHover}, 0.15)
    end)
    dropBtn.MouseLeave:Connect(function()
        self:Tween(dropBtn, {BackgroundColor3 = self.Theme.Input}, 0.15)
    end)

    dropBtn.MouseButton1Click:Connect(function()
        if isOpen then closeDropdown(); return end
        populate()
        local contentHeight = listLayout.AbsoluteContentSize.Y + self:S(64)
        local targetHeight = math.min(contentHeight, self:S(360))
        local targetWidth = self:S(320)
        overlay.Visible = true
        listContainer.Visible = true
        overlay.BackgroundTransparency = 1
        listContainer.Size = UDim2.new(0, targetWidth, 0, 0)
        self:Tween(overlay, {BackgroundTransparency = 0.45}, 0.25)
        self:Tween(listContainer, {
            Size = UDim2.new(0, targetWidth, 0, targetHeight)
        }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        self:Tween(arrow, {Rotation = 180}, 0.2)
        if dropStroke then
            self:Tween(dropStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2)
        end
        dropList.CanvasSize = UDim2.new(0, 0, 0,
            listLayout.AbsoluteContentSize.Y + self:S(16))
        isOpen = true
    end)

    overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            local pos = input.Position
            local listPos = listContainer.AbsolutePosition
            local listSize = listContainer.AbsoluteSize
            local inList = pos.X >= listPos.X and pos.X <= listPos.X + listSize.X
                       and pos.Y >= listPos.Y and pos.Y <= listPos.Y + listSize.Y
            if not inList then closeDropdown() end
        end
    end)

    updateText()

    return {
        Frame     = frame,
        GetValues = function() return selected end,
        SetValues = function(v)
            selected = {}
            for _, val in ipairs(v) do table.insert(selected, val) end
            updateText()
            -- Refresh UI if dropdown is open
            if isOpen then
                populate()
            end
        end,
        SetOptions = function(newOptions) options = newOptions end,
    }
end

-- --- CREATE CHECKBOX ----------------------------------------------------------
function GenesisX:CreateCheckbox(parent, config)
    config = config or {}
    local text = config.Text or "Checkbox"
    local default = config.Default or false
    local callback = config.Callback or function() end
    local height = self:S(42)

    local frame = Instance.new("Frame")
    frame.Name = "Checkbox_" .. text
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local cbSize = self:S(20)
    local checkbox = Instance.new("ImageButton")
    checkbox.Name = "Checkbox"
    checkbox.BackgroundColor3 = default and self.Theme.Accent or self.Theme.Input
    checkbox.AutoButtonColor = false
    checkbox.Position = UDim2.new(0, self:S(14), 0.5, -cbSize/2)
    checkbox.Size = UDim2.new(0, cbSize, 0, cbSize)
    checkbox.Image = default and (self:FormatAssetId("lucide-check") or "") or ""
    checkbox.ImageColor3 = Color3.new(1, 1, 1)
    checkbox.ZIndex = 14
    checkbox.Parent = frame
    self:CreateCorner(checkbox, UDim.new(0, 4))
    self:CreateStroke(checkbox, default and self.Theme.Accent or self.Theme.Border, 1.5, default and 0.2 or 0.4)

    local cbStroke = checkbox:FindFirstChildOfClass("UIStroke")

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, self:S(42), 0, 0)
    label.Size = UDim2.new(1, -self:S(56), 1, 0)
    label.Font = self:GetFontSemibold()
    label.Text = text
    label.TextColor3 = self.Theme.Text
    label.TextSize = self:S(13)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.ZIndex = 13
    label.Parent = frame

    local state = default

    checkbox.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        if state then
            self:Tween(checkbox, {BackgroundColor3 = self.Theme.Accent}, 0.2)
            if cbStroke then self:Tween(cbStroke, {Color = self.Theme.Accent, Transparency = 0.2}, 0.2) end
            checkbox.Image = self:FormatAssetId("lucide-check") or ""
        else
            self:Tween(checkbox, {BackgroundColor3 = self.Theme.Input}, 0.2)
            if cbStroke then self:Tween(cbStroke, {Color = self.Theme.Border, Transparency = 0.4}, 0.2) end
            checkbox.Image = ""
        end
    end)

    return {
        Frame = frame,
        GetState = function() return state end,
        SetState = function(s)
            state = s
            callback(state)
            self:Tween(checkbox, {BackgroundColor3 = state and self.Theme.Accent or self.Theme.Input}, 0.2)
            checkbox.Image = state and (self:FormatAssetId("lucide-check") or "") or ""
        end,
    }
end


-- --- CREATE LABEL -------------------------------------------------------------
function GenesisX:CreateLabel(parent, config)
    config = config or {}
    local function normalizeText(t)
        t = tostring(t or "")
        t = t:gsub("\r\n", "\n"):gsub("\r", "\n")
        -- literal backslash-n (from some serializers / remote strings)
        t = t:gsub("\\n", "\n")
        return t
    end

    local text      = normalizeText(config.Text or "Label")
    local color     = config.Color or self.Theme.TextSecondary
    local wrapped   = (config.Wrapped ~= false)
    local padV      = self:S(10)
    local padH      = self:S(14)
    local minHeight = self:S(36)
    local textSize  = self:S(12)
    local font      = self:GetFontSemibold()

    local frame = Instance.new("Frame")
    frame.Name = "LabelFrame"
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, minHeight)
    frame.ClipsDescendants = false
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.5)

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft   = UDim.new(0, padH)
    pad.PaddingRight  = UDim.new(0, padH)
    pad.PaddingTop    = UDim.new(0, padV)
    pad.PaddingBottom = UDim.new(0, padV)
    pad.Parent = frame

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = font
    label.Text = text
    label.TextColor3 = color
    label.TextSize = textSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = wrapped
    label.TextTruncate = Enum.TextTruncate.None
    label.RichText = config.RichText == true
    label.ZIndex = 13
    label.Parent = frame

    local function measureHeight(str)
        str = normalizeText(str)
        local width = frame.AbsoluteSize.X - (padH * 2)
        if width < 8 then
            -- parent may not be laid out yet; estimate from grandparent
            local p = parent
            if p and p.AbsoluteSize and p.AbsoluteSize.X > 0 then
                width = math.max(40, p.AbsoluteSize.X - (padH * 2) - self:S(8))
            else
                width = self:S(260)
            end
        end
        local ok, bounds = pcall(function()
            return TextService:GetTextSize(str, textSize, font, Vector2.new(width, 10000))
        end)
        if ok and bounds and bounds.Y then
            return math.max(textSize, math.ceil(bounds.Y))
        end
        -- fallback: count lines
        local lines = 1
        for _ in str:gmatch("\n") do lines = lines + 1 end
        -- rough wrap estimate
        local charsPerLine = math.max(8, math.floor(width / (textSize * 0.55)))
        local extra = 0
        for line in (str .. "\n"):gmatch("(.-)\n") do
            extra = extra + math.max(0, math.ceil(#line / charsPerLine) - 1)
        end
        return (lines + extra) * (textSize + 2)
    end

    local function updateHeight()
        if not label or not label.Parent or not frame or not frame.Parent then return end
        label.TextWrapped = wrapped
        label.TextTruncate = Enum.TextTruncate.None
        local textH = measureHeight(label.Text)
        -- also prefer TextBounds when available and larger
        local tb = label.TextBounds
        if tb and tb.Y and tb.Y > textH then
            textH = tb.Y
        end
        frame.Size = UDim2.new(1, 0, 0, math.max(minHeight, textH + padV * 2))
    end

    label:GetPropertyChangedSignal("TextBounds"):Connect(updateHeight)
    label:GetPropertyChangedSignal("Text"):Connect(function()
        task.defer(updateHeight)
    end)
    frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        task.defer(updateHeight)
    end)
    if parent and parent.GetPropertyChangedSignal then
        pcall(function()
            parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                task.defer(updateHeight)
            end)
        end)
    end

    task.defer(updateHeight)
    task.delay(0.05, updateHeight)
    task.delay(0.2, updateHeight)

    return {
        Frame    = frame,
        Label    = label,
        SetText  = function(t)
            label.Text = normalizeText(t)
            task.defer(updateHeight)
            task.delay(0.05, updateHeight)
        end,
        SetColor = function(c)
            label.TextColor3 = c
        end,
    }
end

function GenesisX:CreateLabelToggleSubTitle(parent, config)
    config = config or {}
    local titleText = config.Title or "Title"
    local subtitles = config.Subtitles or {}
    local buttons = config.Buttons or {}
    local titleColor = config.TitleColor or self.Theme.Accent

    local subtitleCount = #subtitles
    local buttonCount = #buttons
    local baseHeight = self:S(46)
    local extraHeight = (subtitleCount * self:S(18)) + (buttonCount * self:S(34)) + self:S(16)
    local totalHeight = baseHeight + extraHeight

    local frame = Instance.new("Frame")
    frame.Name = "LabelToggleSubTitle_" .. titleText
    frame.BackgroundColor3 = self.Theme.Card
    frame.Size = UDim2.new(1, 0, 0, totalHeight)
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame)
    self:CreateStroke(frame, self.Theme.Border, 1, 0.4)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, self:S(14), 0, self:S(10))
    titleLabel.Size = UDim2.new(1, -self:S(28), 0, self:S(20))
    titleLabel.Font = self:GetFontBold()
    titleLabel.Text = titleText
    titleLabel.TextColor3 = titleColor
    titleLabel.TextSize = self:S(13)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 13
    titleLabel.Parent = frame

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.BackgroundTransparency = 1
    contentFrame.Position = UDim2.new(0, self:S(14), 0, self:S(32))
    contentFrame.Size = UDim2.new(1, -self:S(28), 1, -self:S(40))
    contentFrame.ZIndex = 13
    contentFrame.Parent = frame

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, self:S(6))
    contentLayout.Parent = contentFrame

    local subtitleLabels = {}
    for i, subText in ipairs(subtitles) do
        local subLabel = Instance.new("TextLabel")
        subLabel.Name = "Subtitle_" .. i
        subLabel.BackgroundTransparency = 1
        subLabel.Size = UDim2.new(1, 0, 0, 0)
        subLabel.AutomaticSize = Enum.AutomaticSize.Y
        subLabel.Font = self:GetFont()
        subLabel.Text = tostring(subText or ""):gsub("\\n", "\n")
        subLabel.TextColor3 = self.Theme.TextSecondary
        subLabel.TextSize = self:S(11)
        subLabel.TextXAlignment = Enum.TextXAlignment.Left
        subLabel.TextYAlignment = Enum.TextYAlignment.Top
        subLabel.TextWrapped = true
        subLabel.TextTruncate = Enum.TextTruncate.None
        subLabel.ZIndex = 14
        subLabel.Parent = contentFrame
        table.insert(subtitleLabels, subLabel)
    end

    local buttonObjects = {}
    for i, btnConfig in ipairs(buttons) do
        local btnText     = btnConfig.Text     or "Button"
        local btnCallback = btnConfig.Callback or function() end
        local btnStyle    = btnConfig.Style    or "default"

        local btnFrame = Instance.new("Frame")
        btnFrame.Name = "ButtonFrame_" .. i
        btnFrame.BackgroundTransparency = 1
        btnFrame.Size = UDim2.new(1, 0, 0, self:S(32))
        btnFrame.ZIndex = 14
        btnFrame.Parent = contentFrame

        local btn = Instance.new("TextButton")
        btn.Name = "Button"
        btn.AutoButtonColor = false
        btn.BorderSizePixel = 0
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.Font = self:GetFontBold()
        btn.Text = btnText
        btn.TextSize = self:S(12)
        btn.ZIndex = 15
        btn.Parent = btnFrame
        self:CreateCorner(btn, UDim.new(0, 6))

        -- Cor solida, sem borda, sem gradiente
        local bgColor, hoverColor, textColor
        if btnStyle == "accent" then
            bgColor    = self.Theme.Accent
            hoverColor = self.Theme.AccentHover
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "danger" then
            bgColor    = Color3.fromRGB(120, 30, 30)
            hoverColor = Color3.fromRGB(150, 40, 40)
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "warning" then
            bgColor    = Color3.fromRGB(120, 70, 0)
            hoverColor = Color3.fromRGB(150, 90, 0)
            textColor  = Color3.new(1, 1, 1)
        elseif btnStyle == "info" then
            bgColor    = Color3.fromRGB(30, 60, 120)
            hoverColor = Color3.fromRGB(40, 80, 150)
            textColor  = Color3.new(1, 1, 1)
        else
            bgColor    = self.Theme.Card
            hoverColor = self.Theme.CardHover
            textColor  = self.Theme.Text
        end

        btn.BackgroundColor3 = bgColor
        btn.TextColor3 = textColor

        local rippleHolder = Instance.new("Frame")
        rippleHolder.Name = "RippleHolder"
        rippleHolder.BackgroundTransparency = 1
        rippleHolder.BorderSizePixel = 0
        rippleHolder.Size = UDim2.new(1, 0, 1, 0)
        rippleHolder.ClipsDescendants = true
        rippleHolder.ZIndex = btn.ZIndex + 1
        rippleHolder.Parent = btn
        self:CreateCorner(rippleHolder, UDim.new(0, 5))

        local btnData = {
            Button          = btn,
            Frame           = btnFrame,
            CurrentCallback = btnCallback,
            CurrentStyle    = btnStyle,
            CurrentBg       = bgColor,
            CurrentHover    = hoverColor,
            CurrentText     = textColor,
        }

        btn.MouseEnter:Connect(function()
            self:Tween(btn, {BackgroundColor3 = btnData.CurrentHover}, 0.15)
        end)
        btn.MouseLeave:Connect(function()
            self:Tween(btn, {BackgroundColor3 = btnData.CurrentBg}, 0.15)
        end)
        btn.MouseButton1Click:Connect(function()
            self:CreateRipple(btn, UserInputService:GetMouseLocation())
            btnData.CurrentCallback()
        end)

        table.insert(buttonObjects, btnData)
    end

    return {
        Frame = frame,
        Title = titleLabel,

        SetTitle = function(t) titleLabel.Text = t end,
        SetTitleColor = function(c) titleLabel.TextColor3 = c end,

        SetSubtitles = function(newSubtitles)
            for i, subLabel in ipairs(subtitleLabels) do
                subLabel.Text = newSubtitles[i] or ""
            end
        end,

        SetSubtitle = function(index, text)
            if subtitleLabels[index] then
                subtitleLabels[index].Text = text or ""
            end
        end,

        SetButtonText = function(index, text)
            local bd = buttonObjects[index]
            if bd then bd.Button.Text = text or "" end
        end,

        SetButtonCallback = function(index, callback)
            local bd = buttonObjects[index]
            if bd then bd.CurrentCallback = callback or function() end end
        end,

        SetButtonStyle = function(index, style)
            local bd = buttonObjects[index]
            if not bd then return end

            local newBg, newHover, newText
            if style == "accent" then
                newBg    = self.Theme.Accent
                newHover = self.Theme.AccentHover
                newText  = Color3.new(1, 1, 1)
            elseif style == "danger" then
                newBg    = Color3.fromRGB(120, 30, 30)
                newHover = Color3.fromRGB(150, 40, 40)
                newText  = Color3.new(1, 1, 1)
            elseif style == "warning" then
                newBg    = Color3.fromRGB(120, 70, 0)
                newHover = Color3.fromRGB(150, 90, 0)
                newText  = Color3.new(1, 1, 1)
            elseif style == "info" then
                newBg    = Color3.fromRGB(30, 60, 120)
                newHover = Color3.fromRGB(40, 80, 150)
                newText  = Color3.new(1, 1, 1)
            else
                newBg    = self.Theme.Card
                newHover = self.Theme.CardHover
                newText  = self.Theme.Text
            end

            bd.CurrentStyle = style
            bd.CurrentBg    = newBg
            bd.CurrentHover = newHover
            bd.CurrentText  = newText

            bd.Button.BackgroundColor3 = newBg
            bd.Button.TextColor3       = newText
        end,

        SetVisible = function(visible)
            frame.Visible = visible
        end,

        Subtitles = subtitleLabels,
        Buttons   = buttonObjects,
    }
end

-- --- CREATE SEPARATOR ---------------------------------------------------------
function GenesisX:CreateSeparator(parent)
    local wrap = Instance.new("Frame")
    wrap.Name = "Separator"
    wrap.BackgroundTransparency = 1
    wrap.Size = UDim2.new(1, 0, 0, self:S(12))
    wrap.ZIndex = 12
    wrap.Parent = parent

    local line = Instance.new("Frame")
    line.Name = "Line"
    line.BackgroundColor3 = self.Theme.Border
    line.BorderSizePixel = 0
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.ZIndex = 12
    line.Parent = wrap
    self:CreateGradient(line, Color3.new(0, 0, 0), self.Theme.BorderBright, 0)

    return wrap
end

-- --- CREATE STATUS CARD -------------------------------------------------------
function GenesisX:CreateStatusCard(parent, config)
    config = config or {}
    local title = config.Title or "Status"
    local height = self:S(110)

    local frame = Instance.new("Frame")
    frame.Name = "StatusCard"
    frame.BackgroundColor3 = self.Theme.Card
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 0, height)
    frame.Active = true
    frame.ZIndex = 12
    frame.Parent = parent
    frame.BackgroundTransparency = self.Config.Transparency
    self:CreateCorner(frame, UDim.new(0, 8))

    local stroke = self:CreateStroke(frame, self.Theme.Accent, 1.5, 0)
    spawn(function()
        while frame and frame.Parent do
            self:Tween(stroke, {Transparency = 0.1}, 1)
            task.wait(1)
            if not frame or not frame.Parent then break end
            self:Tween(stroke, {Transparency = 0.6}, 1)
            task.wait(1)
        end
    end)

    local leftBar = Instance.new("Frame")
    leftBar.Name = "LeftBar"
    leftBar.BackgroundColor3 = self.Theme.Accent
    leftBar.BorderSizePixel = 0
    leftBar.Position = UDim2.new(0, 0, 0, 0)
    leftBar.Size = UDim2.new(0, 3, 1, 0)
    leftBar.ZIndex = 13
    leftBar.Parent = frame
    self:CreateCorner(leftBar, UDim.new(0, 10))

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.BackgroundColor3 = self.Theme.Header
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, self:S(34))
    header.Parent = frame
    self:CreateCorner(header, UDim.new(0, 10))

    local headerCover = Instance.new("Frame")
    headerCover.BackgroundColor3 = self.Theme.Header
    headerCover.BorderSizePixel = 0
    headerCover.Size = UDim2.new(1, 0, 0, 10)
    headerCover.Position = UDim2.new(0, 0, 1, -10)
    headerCover.Parent = header

    local headerTitle = Instance.new("TextLabel")
    headerTitle.Name = "Title"
    headerTitle.BackgroundTransparency = 1
    headerTitle.Position = UDim2.new(0, self:S(16), 0, 0)
    headerTitle.Size = UDim2.new(1, -self:S(16), 1, 0)
    headerTitle.Font = self:GetFontBold()
    headerTitle.Text = title
    headerTitle.TextColor3 = self.Theme.Text
    headerTitle.TextSize = self:S(12)
    headerTitle.TextXAlignment = Enum.TextXAlignment.Left
    headerTitle.ZIndex = 14
    headerTitle.Parent = header

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Position = UDim2.new(0, self:S(14), 0, self:S(38))
    content.Size = UDim2.new(1, -self:S(28), 1, -self:S(48))
    content.ZIndex = 13
    content.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.BackgroundTransparency = 1
    statusLabel.Size = UDim2.new(1, 0, 0, self:S(20))
    statusLabel.Font = self:GetFontSemibold()
    statusLabel.Text = "* Idle"
    statusLabel.TextColor3 = self.Theme.TextMuted
    statusLabel.TextSize = self:S(12)
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.ZIndex = 14
    statusLabel.Parent = content

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "Info"
    infoLabel.BackgroundTransparency = 1
    infoLabel.Position = UDim2.new(0, 0, 0, self:S(22))
    infoLabel.Size = UDim2.new(1, 0, 0, self:S(16))
    infoLabel.Font = self:GetFont()
    infoLabel.Text = "Aguardando..."
    infoLabel.TextColor3 = self.Theme.TextMuted
    infoLabel.TextSize = self:S(10)
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.ZIndex = 14
    infoLabel.Parent = content

    local barBg = Instance.new("Frame")
    barBg.Name = "BarBg"
    barBg.BackgroundColor3 = self.Theme.Input
    barBg.Position = UDim2.new(0, 0, 1, -self:S(6))
    barBg.Size = UDim2.new(1, 0, 0, self:S(5))
    barBg.ClipsDescendants = true
    barBg.ZIndex = 13
    barBg.Parent = content
    self:CreateCorner(barBg, UDim.new(1, 0))

    local bar = Instance.new("Frame")
    bar.Name = "Bar"
    bar.BackgroundColor3 = self.Theme.Accent
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BorderSizePixel = 0
    bar.ZIndex = 14
    bar.Parent = barBg
    self:CreateCorner(bar, UDim.new(1, 0))
    self:CreateGradient(bar, self.Theme.Accent, self.Theme.AccentDark, 0)

    self:MakeDraggable(frame, header)

    return {
        Frame = frame,
        SetStatus = function(status, color)
            statusLabel.Text = "* " .. status
            statusLabel.TextColor3 = color or self.Theme.TextMuted
        end,
        SetInfo = function(info) infoLabel.Text = info end,
        SetProgress = function(percent) bar.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0) end,
        AnimateLoading = function(active, duration)
            if active then
                spawn(function()
                    while active and frame and frame.Parent do
                        bar.Size = UDim2.new(0, 0, 1, 0)
                        local tween = self:Tween(bar, {Size = UDim2.new(1, 0, 1, 0)}, duration or 1.5)
                        tween.Completed:Wait()
                        task.wait(0.1)
                    end
                end)
            else
                bar.Size = UDim2.new(0, 0, 1, 0)
            end
        end,
    }
end

-- ===============================================================================
-- --- NOTIFICATIONS - REDESIGN GENESISX ---------------------------------------
-- ===============================================================================
-- --- HEADER BUTTON (runtime) ------------------------------------------------
-- Window:CreateHeaderButton({ Icon = "lucide-trash", Callback = function() end })
function GenesisX:CreateHeaderButton(config)
    config = config or {}
    if not self.Header or not self._spawnHeaderButton then
        warn("[GenesisX] CreateHeaderButton: window/header not ready")
        return nil
    end
    local icon = config.Icon or config.IconAssetId or "lucide-circle"
    local action = config.Callback or config.Action or function() end
    local btn = self._spawnHeaderButton({
        Type = config.Type or "custom",
        Icon = icon,
        Action = action,
    })
    return {
        Button = btn,
        SetIcon = function(newIcon)
            if btn then
                btn.Image = self:FormatAssetId(newIcon) or btn.Image
            end
        end,
        SetCallback = function(fn)
            -- replace click by destroying connections is hard; store on attribute
            if type(fn) == "function" then
                config.Callback = fn
            end
        end,
        Destroy = function()
            if not self._headerButtonList then return end
            for i = #self._headerButtonList, 1, -1 do
                local e = self._headerButtonList[i]
                if e.Button == btn then
                    table.remove(self._headerButtonList, i)
                    if btn and btn.Parent then btn:Destroy() end
                    if self._rebuildHeaderButtons then self._rebuildHeaderButtons() end
                    break
                end
            end
        end,
    }
end

-- --- DIALOG / CONFIRM MODAL -------------------------------------------------
-- Window:CreateDialog({
--   Title = "Delete settings?",
--   Description = "Are you sure...",
--   ConfirmText = "Delete",  -- or Yes =
--   CancelText = "Hell Nah", -- or No =
--   OnConfirm = function() end,
--   OnCancel = function() end,
-- })
function GenesisX:CreateDialog(config)
    config = config or {}
    if not self.ScreenGui then
        warn("[GenesisX] CreateDialog: no ScreenGui")
        return nil
    end

    local title = config.Title or "Confirm"
    local desc = config.Description or config.Desc or config.Text or ""
    local confirmText = config.ConfirmText or config.Yes or "Yes"
    local cancelText = config.CancelText or config.No or "No"
    local onConfirm = config.OnConfirm or config.Callback or function() end
    local onCancel = config.OnCancel or function() end
    local closeOnBackdrop = config.CloseOnBackdrop ~= false

    -- destroy previous dialog if any
    if self._activeDialog and self._activeDialog.Parent then
        self._activeDialog:Destroy()
        self._activeDialog = nil
    end

    local overlay = Instance.new("Frame")
    overlay.Name = "GX_DialogOverlay"
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.Position = UDim2.fromScale(0, 0)
    overlay.ZIndex = 9000
    overlay.Parent = self.ScreenGui
    self._activeDialog = overlay

    local dim = Instance.new("TextButton")
    dim.Name = "Dim"
    dim.AutoButtonColor = false
    dim.Text = ""
    dim.BackgroundColor3 = Color3.new(0, 0, 0)
    dim.BackgroundTransparency = 1
    dim.Size = UDim2.fromScale(1, 1)
    dim.ZIndex = 9000
    dim.Parent = overlay

    self:Tween(dim, {BackgroundTransparency = 0.45}, 0.2)

    local panelW = self:S(ScaleData.IsMobile and 300 or 360)
    local panel = Instance.new("Frame")
    panel.Name = "DialogPanel"
    panel.BackgroundColor3 = self.Theme.Background
    panel.BorderSizePixel = 0
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = UDim2.new(0.5, 0, 0.5, 12)
    panel.Size = UDim2.new(0, panelW, 0, 0)
    panel.AutomaticSize = Enum.AutomaticSize.Y
    panel.ZIndex = 9001
    panel.Parent = overlay
    self:CreateCorner(panel, UDim.new(0, 12))
    self:CreateStroke(panel, self.Theme.Accent, 1.2, 0.35)

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, self:S(18))
    pad.PaddingBottom = UDim.new(0, self:S(16))
    pad.PaddingLeft = UDim.new(0, self:S(18))
    pad.PaddingRight = UDim.new(0, self:S(18))
    pad.Parent = panel

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, self:S(12))
    layout.Parent = panel

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Name = "Title"
    titleLbl.BackgroundTransparency = 1
    titleLbl.Size = UDim2.new(1, 0, 0, 0)
    titleLbl.AutomaticSize = Enum.AutomaticSize.Y
    titleLbl.Font = self:GetFontBold()
    titleLbl.Text = tostring(title)
    titleLbl.TextColor3 = self.Theme.Text
    titleLbl.TextSize = self:S(16)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.TextWrapped = true
    titleLbl.LayoutOrder = 1
    titleLbl.ZIndex = 9002
    titleLbl.Parent = panel

    local descLbl = Instance.new("TextLabel")
    descLbl.Name = "Description"
    descLbl.BackgroundTransparency = 1
    descLbl.Size = UDim2.new(1, 0, 0, 0)
    descLbl.AutomaticSize = Enum.AutomaticSize.Y
    descLbl.Font = self:GetFont()
    descLbl.Text = tostring(desc)
    descLbl.TextColor3 = self.Theme.TextSecondary
    descLbl.TextSize = self:S(13)
    descLbl.TextXAlignment = Enum.TextXAlignment.Left
    descLbl.TextWrapped = true
    descLbl.LayoutOrder = 2
    descLbl.ZIndex = 9002
    descLbl.Parent = panel

    local btnRow = Instance.new("Frame")
    btnRow.Name = "Buttons"
    btnRow.BackgroundTransparency = 1
    btnRow.Size = UDim2.new(1, 0, 0, self:S(40))
    btnRow.LayoutOrder = 3
    btnRow.ZIndex = 9002
    btnRow.Parent = panel

    local btnLayout = Instance.new("UIListLayout")
    btnLayout.FillDirection = Enum.FillDirection.Horizontal
    btnLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    btnLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    btnLayout.Padding = UDim.new(0, self:S(10))
    btnLayout.Parent = btnRow

    local function makeBtn(text, style, order)
        local b = Instance.new("TextButton")
        b.Name = "Btn_" .. tostring(order)
        b.AutoButtonColor = false
        b.Size = UDim2.new(0, self:S(110), 0, self:S(36))
        b.Font = self:GetFontSemibold()
        b.Text = tostring(text)
        b.TextSize = self:S(13)
        b.ZIndex = 9003
        b.LayoutOrder = order
        b.Parent = btnRow
        self:CreateCorner(b, UDim.new(0, 8))

        if style == "confirm" then
            b.BackgroundColor3 = self.Theme.Accent
            b.TextColor3 = Color3.new(1, 1, 1)
            self:CreateStroke(b, self.Theme.AccentHover, 1, 0.4)
        else
            b.BackgroundColor3 = self.Theme.Input
            b.TextColor3 = self.Theme.Text
            self:CreateStroke(b, self.Theme.Border, 1, 0.4)
        end

        b.MouseEnter:Connect(function()
            if style == "confirm" then
                self:Tween(b, {BackgroundColor3 = self.Theme.AccentHover}, 0.12)
            else
                self:Tween(b, {BackgroundColor3 = self.Theme.CardHover}, 0.12)
            end
        end)
        b.MouseLeave:Connect(function()
            if style == "confirm" then
                self:Tween(b, {BackgroundColor3 = self.Theme.Accent}, 0.12)
            else
                self:Tween(b, {BackgroundColor3 = self.Theme.Input}, 0.12)
            end
        end)
        return b
    end

    -- order: cancel left, confirm right (right-aligned row)
    local cancelBtn = makeBtn(cancelText, "cancel", 1)
    local confirmBtn = makeBtn(confirmText, "confirm", 2)

    local closed = false
    local function close(result)
        if closed then return end
        closed = true
        self:Tween(dim, {BackgroundTransparency = 1}, 0.18)
        self:Tween(panel, {Position = UDim2.new(0.5, 0, 0.5, 20)}, 0.18)
        task.delay(0.2, function()
            if overlay and overlay.Parent then overlay:Destroy() end
            if self._activeDialog == overlay then self._activeDialog = nil end
        end)
        if result == true then
            pcall(onConfirm)
        else
            pcall(onCancel)
        end
    end

    confirmBtn.MouseButton1Click:Connect(function() close(true) end)
    cancelBtn.MouseButton1Click:Connect(function() close(false) end)

    if closeOnBackdrop then
        dim.MouseButton1Click:Connect(function()
            close(false)
        end)
    end

    -- entrance
    panel.Position = UDim2.new(0.5, 0, 0.5, 24)
    self:Tween(panel, {Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

    return {
        Close = function() close(false) end,
        Confirm = function() close(true) end,
        Overlay = overlay,
        Panel = panel,
    }
end

-- alias
function GenesisX:Dialog(config)
    return self:CreateDialog(config)
end

function GenesisX:Notify(config)
    config = config or {}
    local function normalizeText(t)
        if t == nil then return nil end
        t = tostring(t)
        t = t:gsub("\r\n", "\n"):gsub("\r", "\n"):gsub("\\n", "\n")
        return t
    end
    local message   = normalizeText(config.Text) or "Notificacao"
    local title     = normalizeText(config.Title)
    local subtitle  = normalizeText(config.Subtitle)
    local subtitles = config.Subtitles or nil
    if type(subtitles) == "table" then
        local fixed = {}
        for i, s in ipairs(subtitles) do fixed[i] = normalizeText(s) end
        subtitles = fixed
    end
    local ntype     = config.Type     or "info"
    local duration  = config.Duration or 4

    self:UpdateScale()

    -- -- Dimensoes --------------------------------------------------------------
    local W  = self:S(ScaleData.IsMobile and 320 or 380)
    local PAD_RIGHT  = self:S(16)
    local PAD_BOTTOM = self:S(16)
    local GAP        = self:S(10)

    -- -- Cores do tipo ---------------------------------------------------------
    local typeColors = {
        success = self.Theme.Success,
        warning = self.Theme.Warning,
        error   = self.Theme.Error,
        info    = self.Theme.Info,
        genesis = self.Theme.Accent,
    }
    local typeIcons = {
        success = "lucide-check-circle",
        warning = "lucide-alert-triangle",
        error   = "lucide-x-circle",
        info    = "lucide-info",
        genesis = "lucide-genesis-hub",
    }
    local accentColor = typeColors[ntype] or self.Theme.Info
    local iconName    = typeIcons[ntype]  or "lucide-info"

    -- -- Viewport helper -------------------------------------------------------
    local function viewport()
        local ok, cam = pcall(function() return workspace.CurrentCamera end)
        return (ok and cam) and cam.ViewportSize or Vector2.new(1366, 768)
    end

    -- -- Calcular altura dinamica ----------------------------------------------
    local iconAreaW = self:S(70)
    local contentX = iconAreaW + self:S(12)
    local contentW = W - contentX - self:S(36) -- espaco pro X
    local baseH = self:S(72)
    local totalH = baseH

    -- Se tiver subtitles array, calcular altura extra
    if subtitles and #subtitles > 0 then
        totalH = baseH + (#subtitles * self:S(18))
    elseif subtitle then
        totalH = baseH + self:S(18)
    end

    -- -- Criar frame principal -------------------------------------------------
    local notif = Instance.new("Frame")
    notif.Name               = "GX_Notification"
    notif.BackgroundColor3   = self.Theme.Background
    notif.BorderSizePixel    = 0
    notif.Size               = UDim2.fromOffset(W, totalH)
    notif.ClipsDescendants   = true
    notif.ZIndex             = 5000
    notif.Parent             = self.ScreenGui
    self:CreateCorner(notif, UDim.new(0, self:S(10)))
    self:CreateStroke(notif, accentColor, 1.5, 0.3)

    -- -- Area do icone (esquerda) ----------------------------------------------
    local iconArea = Instance.new("Frame")
    iconArea.Name             = "IconArea"
    iconArea.BackgroundTransparency = 1
    iconArea.Size             = UDim2.new(0, iconAreaW, 1, -self:S(4))
    iconArea.Position         = UDim2.new(0, 0, 0, 0)
    iconArea.ZIndex           = 5001
    iconArea.Parent           = notif

    -- Background do icone com glow sutil
    local iconBg = Instance.new("Frame")
    iconBg.Name             = "IconBg"
    iconBg.BackgroundColor3 = accentColor
    iconBg.BackgroundTransparency = 0.85
    iconBg.BorderSizePixel  = 0
    iconBg.Size             = UDim2.fromOffset(self:S(46), self:S(46))
    iconBg.Position         = UDim2.new(0.5, 0, 0.5, 0)
    iconBg.AnchorPoint      = Vector2.new(0.5, 0.5)
    iconBg.ZIndex           = 5001
    iconBg.Parent           = iconArea
    self:CreateCorner(iconBg, UDim.new(1, 0))

    -- Glow mais forte atras
    local iconGlow = Instance.new("Frame")
    iconGlow.Name             = "IconGlow"
    iconGlow.BackgroundColor3 = accentColor
    iconGlow.BackgroundTransparency = 0.92
    iconGlow.BorderSizePixel  = 0
    iconGlow.Size             = UDim2.fromOffset(self:S(56), self:S(56))
    iconGlow.Position         = UDim2.new(0.5, 0, 0.5, 0)
    iconGlow.AnchorPoint      = Vector2.new(0.5, 0.5)
    iconGlow.ZIndex           = 5000
    iconGlow.Parent           = iconArea
    self:CreateCorner(iconGlow, UDim.new(1, 0))

    -- Icone Lucide
    local iconImg = Instance.new("ImageLabel")
    iconImg.Name                = "Icon"
    iconImg.BackgroundTransparency = 1
    iconImg.Size                = UDim2.new(0.55, 0, 0.55, 0)
    iconImg.Position            = UDim2.new(0.225, 0, 0.225, 0)
    iconImg.Image               = self:FormatAssetId(iconName) or ""
    iconImg.ImageColor3         = accentColor
    iconImg.ZIndex              = 5002
    iconImg.Parent              = iconBg

    -- -- Separador vertical ---------------------------------------------------
    local separator = Instance.new("Frame")
    separator.Name             = "Separator"
    separator.BackgroundColor3 = accentColor
    separator.BackgroundTransparency = 0.4
    separator.BorderSizePixel  = 0
    separator.Size             = UDim2.new(0, self:S(2), 0.7, 0)
    separator.Position         = UDim2.new(0, iconAreaW, 0.5, 0)
    separator.AnchorPoint      = Vector2.new(0, 0.5)
    separator.ZIndex           = 5001
    separator.Parent           = notif

    -- -- Area de conteudo (texto) ---------------------------------------------
    local contentArea = Instance.new("Frame")
    contentArea.Name             = "ContentArea"
    contentArea.BackgroundTransparency = 1
    contentArea.Position         = UDim2.new(0, contentX, 0, self:S(10))
    contentArea.Size             = UDim2.new(0, contentW, 1, -self:S(14))
    contentArea.ZIndex           = 5001
    contentArea.Parent           = notif

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name             = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size             = UDim2.new(1, 0, 0, 0)
    titleLabel.AutomaticSize    = Enum.AutomaticSize.Y
    titleLabel.Font             = self:GetFontBold()
    titleLabel.Text             = title or message
    titleLabel.TextColor3       = accentColor
    titleLabel.TextSize         = self:S(13)
    titleLabel.TextXAlignment   = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment   = Enum.TextYAlignment.Top
    titleLabel.TextWrapped      = true
    titleLabel.TextTruncate     = Enum.TextTruncate.None
    titleLabel.ZIndex           = 5002
    titleLabel.Parent           = contentArea

    -- Subtitles container
    local subtitleY = self:S(22)
    local subtitleTexts = {}

    if subtitles and #subtitles > 0 then
        for i, subText in ipairs(subtitles) do
            local subLabel = Instance.new("TextLabel")
            subLabel.Name             = "Subtitle_" .. i
            subLabel.BackgroundTransparency = 1
            subLabel.Position         = UDim2.new(0, 0, 0, subtitleY + ((i-1) * self:S(18)))
            subLabel.Size             = UDim2.new(1, 0, 0, 0)
            subLabel.AutomaticSize    = Enum.AutomaticSize.Y
            subLabel.Font             = self:GetFont()
            subLabel.Text             = subText
            subLabel.TextColor3       = self.Theme.TextSecondary
            subLabel.TextSize         = self:S(11)
            subLabel.TextXAlignment   = Enum.TextXAlignment.Left
            subLabel.TextYAlignment   = Enum.TextYAlignment.Top
            subLabel.TextWrapped      = true
            subLabel.TextTruncate     = Enum.TextTruncate.None
            subLabel.ZIndex           = 5002
            subLabel.Parent           = contentArea
            table.insert(subtitleTexts, subLabel)
        end
    elseif subtitle then
        local subLabel = Instance.new("TextLabel")
        subLabel.Name             = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position         = UDim2.new(0, 0, 0, subtitleY)
        subLabel.Size             = UDim2.new(1, 0, 0, 0)
        subLabel.AutomaticSize    = Enum.AutomaticSize.Y
        subLabel.Font             = self:GetFont()
        subLabel.Text             = subtitle
        subLabel.TextColor3       = self.Theme.TextSecondary
        subLabel.TextSize         = self:S(11)
        subLabel.TextXAlignment   = Enum.TextXAlignment.Left
        subLabel.TextYAlignment   = Enum.TextYAlignment.Top
        subLabel.TextWrapped      = true
        subLabel.TextTruncate     = Enum.TextTruncate.None
        subLabel.ZIndex           = 5002
        subLabel.Parent           = contentArea
    elseif not title then
        -- Se nao tiver title, a mensagem e o title (ja setado acima)
        -- e nao precisa de subtitle
    else
        -- Se tiver title mas nao subtitle, usar message como subtitle
        local subLabel = Instance.new("TextLabel")
        subLabel.Name             = "Subtitle"
        subLabel.BackgroundTransparency = 1
        subLabel.Position         = UDim2.new(0, 0, 0, subtitleY)
        subLabel.Size             = UDim2.new(1, 0, 0, 0)
        subLabel.AutomaticSize    = Enum.AutomaticSize.Y
        subLabel.Font             = self:GetFont()
        subLabel.Text             = message
        subLabel.TextColor3       = self.Theme.TextSecondary
        subLabel.TextSize         = self:S(11)
        subLabel.TextXAlignment   = Enum.TextXAlignment.Left
        subLabel.TextYAlignment   = Enum.TextYAlignment.Top
        subLabel.TextWrapped      = true
        subLabel.TextTruncate     = Enum.TextTruncate.None
        subLabel.ZIndex           = 5002
        subLabel.Parent           = contentArea
    end

    -- -- Reflow altura (TextService + TextBounds) para wrap/\n -----------------
    local function measureLabel(lbl, sizePx, fontEnum)
        if not lbl then return sizePx end
        local w = contentW
        local ok, bounds = pcall(function()
            return TextService:GetTextSize(lbl.Text or "", sizePx, fontEnum, Vector2.new(w, 10000))
        end)
        local h = sizePx
        if ok and bounds then h = math.max(h, math.ceil(bounds.Y)) end
        if lbl.TextBounds and lbl.TextBounds.Y > h then h = lbl.TextBounds.Y end
        return h
    end

    local function reflowNotif()
        if not notif or not notif.Parent then return end
        local padT, padB = self:S(10), self:S(12)
        local h = padT + padB
        local y = 0
        if titleLabel and titleLabel.Parent then
            local th = measureLabel(titleLabel, self:S(13), self:GetFontBold())
            titleLabel.Size = UDim2.new(1, 0, 0, th)
            titleLabel.Position = UDim2.new(0, 0, 0, y)
            y = y + th + self:S(4)
            h = h + th + self:S(4)
        end
        for _, lbl in ipairs(subtitleTexts) do
            if lbl and lbl.Parent then
                local sh = measureLabel(lbl, self:S(11), self:GetFont())
                lbl.Size = UDim2.new(1, 0, 0, sh)
                lbl.Position = UDim2.new(0, 0, 0, y)
                y = y + sh + self:S(2)
                h = h + sh + self:S(2)
            end
        end
        local single = contentArea:FindFirstChild("Subtitle")
        if single and single:IsA("TextLabel") and not subtitleTexts[1] then
            local sh = measureLabel(single, self:S(11), self:GetFont())
            single.Size = UDim2.new(1, 0, 0, sh)
            single.Position = UDim2.new(0, 0, 0, y)
            h = h + sh + self:S(2)
        end
        local minH = self:S(72)
        local maxH = self:S(260)
        notif.Size = UDim2.fromOffset(W, math.clamp(math.max(minH, h + self:S(8)), minH, maxH))
    end

    task.defer(reflowNotif)
    task.delay(0.05, reflowNotif)

    -- -- Botao fechar (X) -------------------------------------------------------
    local closeSize = self:S(18)
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Name               = "CloseBtn"
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position           = UDim2.new(1, -self:S(26), 0, self:S(10))
    closeBtn.Size               = UDim2.fromOffset(closeSize, closeSize)
    closeBtn.Image              = self:FormatAssetId("lucide-x") or ""
    closeBtn.ImageColor3        = self.Theme.TextMuted
    closeBtn.ImageTransparency  = 0
    closeBtn.ZIndex             = 5003
    closeBtn.AutoButtonColor    = false
    closeBtn.Parent             = notif

    closeBtn.MouseEnter:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = Color3.new(1, 1, 1)}, 0.1)
    end)
    closeBtn.MouseLeave:Connect(function()
        self:Tween(closeBtn, {ImageColor3 = self.Theme.TextMuted}, 0.1)
    end)

    -- -- Registrar e posicionar -----------------------------------------------
    table.insert(self._notifications, notif)
    local myIndex = #self._notifications

    local function targetX()
        return viewport().X - W - PAD_RIGHT
    end
    local function offscreenX()
        return viewport().X + W + 60
    end
    local function bottomY(index)
        return viewport().Y - (totalH + PAD_BOTTOM) * index - GAP * (index - 1)
    end

    local function restack(animated)
        local count = 0
        for i = 1, #self._notifications do
            if self._notifications[i] and self._notifications[i].Parent then
                count = count + 1
                local idx = count
                local yPos = bottomY(idx)
                local xPos = targetX()
                if animated then
                    self:Tween(self._notifications[i], {Position = UDim2.fromOffset(xPos, yPos)}, 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                else
                    self._notifications[i].Position = UDim2.fromOffset(xPos, yPos)
                end
            end
        end
    end

    -- Posicao inicial (fora da tela a direita)
    do
        local yPos = bottomY(#self._notifications)
        notif.Position = UDim2.fromOffset(offscreenX(), yPos)
    end

    -- Animacao de entrada
    self:Tween(notif, {
        Position = UDim2.fromOffset(targetX(), bottomY(#self._notifications))
    }, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    restack(true)

    -- -- Dismiss ---------------------------------------------------------------
    local dismissed = false
    local function dismiss()
        if dismissed then return end
        dismissed = true

        for i = #self._notifications, 1, -1 do
            if self._notifications[i] == notif then
                table.remove(self._notifications, i)
                break
            end
        end

        self:Tween(notif, {
            Position = UDim2.fromOffset(offscreenX(), notif.AbsolutePosition.Y),
        }, 0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

        task.delay(0.05, function() restack(true) end)

        task.delay(0.32, function()
            if notif and notif.Parent then notif:Destroy() end
        end)
    end

    closeBtn.MouseButton1Click:Connect(dismiss)

    -- Click no corpo tambem descarta
    notif.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            if not dismissed then dismiss() end
        end
    end)

    -- Auto-dismiss
    task.delay(duration, function()
        if not dismissed then dismiss() end
    end)

    -- API de retorno
    return {
        Destroy = dismiss,
        SetTitle = function(t)
            if titleLabel then titleLabel.Text = t end
        end,
        SetSubtitle = function(index, text)
            if subtitleTexts[index] then
                subtitleTexts[index].Text = text
            end
        end,
        SetSubtitles = function(newSubs)
            for i, lbl in ipairs(subtitleTexts) do
                lbl.Text = newSubs[i] or ""
            end
        end,
    }
end

-- --- TRANSPARENCY -----------------------------------------------------------
function GenesisX:SetTransparency(value)
    value = math.clamp(value, 0, 1)
    self.Config.Transparency = value
    self:_SaveConfigFile("transparency.json", value)
    if self.ScreenGui then
        for _, obj in ipairs(self.ScreenGui:GetDescendants()) do
            -- Skip internal/effect elements that should stay opaque or have their own transparency
            local skipNames = {
                Ripple = true, Knob = true, Fill = true, Bar = true, BarBg = true,
                Shadow = true, SimpleShadow = true, IconGlow = true, IconBg = true,
                Checkbox = true, ValueBg = true, CountBadge = true, LeftBar = true,
                Track = true, RippleHolder = true, HoverFill = true, IconArea = true,
                Separator = true, Line = true, SidebarLine = true, Divider = true,
                HeaderCover = true, BgCard = true
            }
            if obj:IsA("Frame") and not skipNames[obj.Name] then
                if obj.BackgroundTransparency < 1 then
                    -- Don't make textboxes transparent
                    if not obj:IsA("TextBox") then
                        obj.BackgroundTransparency = value
                    end
                end
            end
            -- Also apply to ImageLabels and ImageButtons that have backgrounds
            if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and not skipNames[obj.Name] then
                if obj.BackgroundTransparency < 1 then
                    obj.BackgroundTransparency = value
                end
            end
            -- Apply to TextLabels that have backgrounds (rare but possible)
            if obj:IsA("TextLabel") and obj.BackgroundTransparency < 1 and not skipNames[obj.Name] then
                obj.BackgroundTransparency = value
            end
        end
    end
end

-- --- DESTROY ------------------------------------------------------------------
function GenesisX:Destroy()
    if self.ScreenGui then self.ScreenGui:Destroy() end
end

function GenesisX:GetWindow()
    return self.MainFrame
end

function GenesisX:SetVisible(visible)
    if self.MainFrame then self.MainFrame.Visible = visible end
end

function GenesisX:Toggle()
    if self.MainFrame then self:SetVisible(not self.MainFrame.Visible) end
end

function GenesisX:SetPosition(position)
    if self.MainFrame then self.MainFrame.Position = position end
end

function GenesisX:SetSize(size)
    if self.MainFrame then self.MainFrame.Size = size end
end

function GenesisX:SetTheme(newTheme)
    local oldTheme = self.Theme
    local targetTheme
    local themeString = "Dark"

    if type(newTheme) == "string" then
        if newTheme == "Light" and self.Themes and self.Themes.Light then
            targetTheme = self.Themes.Light
            themeString = "Light"
        elseif self.Themes and self.Themes.Dark then
            targetTheme = self.Themes.Dark
            themeString = "Dark"
        elseif self.Themes and self.Themes.Iron then
            targetTheme = self.Themes.Iron
            themeString = "Iron"
        end
    elseif type(newTheme) == "table" then
        targetTheme = newTheme
    end

    if not targetTheme or not oldTheme then return end
    self:_SaveConfigFile("theme.json", themeString)

    -- Mapa: cor antiga (string) -> cor nova
    local colorMap = {}
    for key, oldColor in pairs(oldTheme) do
        if targetTheme[key] and typeof(oldColor) == "Color3" and typeof(targetTheme[key]) == "Color3" then
            colorMap[tostring(oldColor)] = targetTheme[key]
        end
    end

    -- Atualizar tema
    self.Theme = targetTheme

    -- Atualizar header buttons
    if self.Header then
        for _, child in ipairs(self.Header:GetChildren()) do
            if child:IsA("ImageButton") then
                child.BackgroundColor3 = self.Theme.Input
                child.ImageColor3 = self.Theme.Accent
                local stroke = child:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Color = self.Theme.Accent
                end
            end
        end
    end

    -- Atualizar todos os elementos da UI
    if self.ScreenGui then
        for _, obj in ipairs(self.ScreenGui:GetDescendants()) do
            -- BackgroundColor3
            if obj:IsA("GuiObject") and colorMap[tostring(obj.BackgroundColor3)] then
                obj.BackgroundColor3 = colorMap[tostring(obj.BackgroundColor3)]
            end
            -- TextColor3
            if (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) and colorMap[tostring(obj.TextColor3)] then
                obj.TextColor3 = colorMap[tostring(obj.TextColor3)]
            end
            -- ImageColor3: proteger icones brancos (Color3.new(1,1,1)) e icones que usam TextMuted
            if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) and colorMap[tostring(obj.ImageColor3)] then
                local current = obj.ImageColor3
                local white = Color3.new(1, 1, 1)
                -- Se for branco puro, mantem branco (icones devem permanecer brancos)
                if current == white then
                    obj.ImageColor3 = white
                else
                    obj.ImageColor3 = colorMap[tostring(current)]
                end
            end
            -- UIStroke Color
            if obj:IsA("UIStroke") and colorMap[tostring(obj.Color)] then
                obj.Color = colorMap[tostring(obj.Color)]
            end
            -- UIGradient
            if obj:IsA("UIGradient") and obj.Color then
                local newKeypoints = {}
                for _, kp in ipairs(obj.Color.Keypoints) do
                    local newColor = colorMap[tostring(kp.Value)] or kp.Value
                    table.insert(newKeypoints, ColorSequenceKeypoint.new(kp.Time, newColor))
                end
                obj.Color = ColorSequence.new(newKeypoints)
            end
            -- ScrollBarImageColor3
            if obj:IsA("ScrollingFrame") and colorMap[tostring(obj.ScrollBarImageColor3)] then
                obj.ScrollBarImageColor3 = colorMap[tostring(obj.ScrollBarImageColor3)]
            end
        end
    end
end

function GenesisX:SetFont(fontName)
    self.Font = fontName or "Gotham"
    self:_SaveConfigFile("font.json", self.Font)
    local newFont = self:GetFont()
    local newBold = self:GetFontBold()
    local newSemi = self:GetFontSemibold()
    local newBlack = self:GetFontBlack()

    -- Update all text elements in the UI
    if self.ScreenGui then
        for _, obj in ipairs(self.ScreenGui:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                -- Determine which font weight to use based on current font
                local current = obj.Font
                if current == Enum.Font.GothamBold or current == Enum.Font.Arcade or current == Enum.Font.Fantasy or current == Enum.Font.GothamBlack then
                    obj.Font = newBold
                elseif current == Enum.Font.GothamSemibold then
                    obj.Font = newSemi
                elseif current == Enum.Font.GothamBlack then
                    obj.Font = newBlack
                else
                    obj.Font = newFont
                end
            end
        end
    end
end

-- --- RESET CONFIG COMMAND -----------------------------------------------------
local env = (getgenv and getgenv()) or _G or {}

env.G = env.G or {}
env.G.reset = function()
    local filesToDelete = {
        "GenesisX/Config/theme.json",
        "GenesisX/Config/font.json",
        "GenesisX/Config/transparency.json"
    }
    for _, path in ipairs(filesToDelete) do
        pcall(function()
            if delfile and isfile then
                if isfile(path) then
                    delfile(path)
                end
            end
        end)
    end
    -- Notify user
    if GenesisX.ScreenGui then
        GenesisX:Notify({
            Title = "Config Reset",
            Text = "Settings reset successfully!",
            Subtitle = "Theme, Font, and Transparency have been restored.",
            Type = "success",
            Duration = 4
        })
    end
    return true
end

env.SpectrumX = GenesisX
env.Notify = function(...) return GenesisX:Notify(...) end

return GenesisX
