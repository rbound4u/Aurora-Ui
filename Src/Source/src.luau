--[[
    AuroraUI v2.1 - Modern Roblox UI Library
]]

local AuroraUI = {}
AuroraUI.__index = AuroraUI

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Fetch Lucide icons
AuroraUI.LucideURL = "https://raw.githubusercontent.com/rbound4u/Aurora-Ui/refs/heads/main/Src/Source/Lucid.luau"

-- Fallback empty table (will be populated if fetch succeeds)
AuroraUI.LucideIcons = {}

-- Fetch Lucide Icons (call this before creating UI)
function AuroraUI:LoadLucideIcons(customURL)
    local url = customURL or self.LucideURL
    
    local success, result = pcall(function()
        return game:HttpGet(url, true)
    end)
    
    if success and result then
        local loadSuccess, icons = pcall(function()
            return loadstring(result)()
        end)
        
        if loadSuccess and type(icons) == "table" then
            self.LucideIcons = icons
            print("[AuroraUI] Loaded " .. tostring(#icons) .. " Lucide icons")
            return true
        else
            warn("[AuroraUI] Failed to parse icons, using fallback")
            self:LoadFallbackIcons()
            return false
        end
    else
        warn("[AuroraUI] Failed to fetch icons from URL, using fallback")
        self:LoadFallbackIcons()
        return false
    end
end

-- Minimal fallback icons if fetch fails
function AuroraUI:LoadFallbackIcons()
    self.LucideIcons = {
        ["home"] = "rbxassetid://7733960981",
        ["settings"] = "rbxassetid://7734053495",
        ["user"] = "rbxassetid://7733955511",
        ["shield"] = "rbxassetid://7734056595",
        ["eye"] = "rbxassetid://7733965388",
        ["zap"] = "rbxassetid://7734068321",
        ["menu"] = "rbxassetid://7734063302",
        ["x"] = "rbxassetid://7734060711",
        ["minus"] = "rbxassetid://7733959802",
        ["maximize"] = "rbxassetid://7733955740",
        ["minimize"] = "rbxassetid://7733955740",
        ["check"] = "rbxassetid://7733715400",
        ["chevron-down"] = "rbxassetid://7733717447",
        ["search"] = "rbxassetid://7734053426",
        ["bell"] = "rbxassetid://7733710707",
        ["moon"] = "rbxassetid://7733955086",
        ["sun"] = "rbxassetid://7734066296",
        ["trash"] = "rbxassetid://7734065795",
        ["edit"] = "rbxassetid://7733964719",
        ["plus"] = "rbxassetid://7733954760",
        ["copy"] = "rbxassetid://7733963885",
        ["refresh"] = "rbxassetid://7734056468",
        ["play"] = "rbxassetid://7733954058",
        ["pause"] = "rbxassetid://7733952335",
        ["skip-forward"] = "rbxassetid://7734057257",
        ["volume"] = "rbxassetid://7734073250",
        ["wifi"] = "rbxassetid://7734079055",
        ["battery"] = "rbxassetid://7733710707",
        ["clock"] = "rbxassetid://7733963388",
        ["calendar"] = "rbxassetid://7733917120",
        ["mail"] = "rbxassetid://7733955511",
        ["phone"] = "rbxassetid://7733955511",
        ["map"] = "rbxassetid://7733954088",
        ["camera"] = "rbxassetid://7733917120",
        ["image"] = "rbxassetid://7733960981",
        ["music"] = "rbxassetid://7733954088",
        ["video"] = "rbxassetid://7734073250",
        ["file"] = "rbxassetid://7733960981",
        ["folder"] = "rbxassetid://7733960981",
        ["download"] = "rbxassetid://7733964719",
        ["upload"] = "rbxassetid://7734079055",
        ["share"] = "rbxassetid://7734056595",
        ["link"] = "rbxassetid://7733955740",
        ["lock"] = "rbxassetid://7733955740",
        ["unlock"] = "rbxassetid://7733955740",
        ["key"] = "rbxassetid://7733955740",
        ["star"] = "rbxassetid://7734066296",
        ["heart"] = "rbxassetid://7733960981",
        ["thumbs-up"] = "rbxassetid://7734065795",
        ["thumbs-down"] = "rbxassetid://7734065795",
        ["smile"] = "rbxassetid://7734066296",
        ["frown"] = "rbxassetid://7733964719",
        ["meh"] = "rbxassetid://7733954088",
        ["alert"] = "rbxassetid://7733710707",
        ["alert-circle"] = "rbxassetid://7733710707",
        ["alert-triangle"] = "rbxassetid://7733710707",
        ["info"] = "rbxassetid://7733955740",
        ["help"] = "rbxassetid://7733955740",
        ["terminal"] = "rbxassetid://7734065795",
        ["code"] = "rbxassetid://7733963885",
        ["github"] = "rbxassetid://7733960981",
        ["twitter"] = "rbxassetid://7734065795",
        ["facebook"] = "rbxassetid://7733960981",
        ["instagram"] = "rbxassetid://7733960981",
        ["youtube"] = "rbxassetid://7734079055",
        ["twitch"] = "rbxassetid://7734065795",
        ["discord"] = "rbxassetid://7733963885",
        ["sliders"] = "rbxassetid://7734066296",
        ["filter"] = "rbxassetid://7733960981",
        ["sort-asc"] = "rbxassetid://7734065795",
        ["sort-desc"] = "rbxassetid://7733964719",
        ["arrow-up"] = "rbxassetid://7733717651",
        ["arrow-down"] = "rbxassetid://7733717447",
        ["arrow-left"] = "rbxassetid://7733717651",
        ["arrow-right"] = "rbxassetid://7733717651",
        ["chevron-up"] = "rbxassetid://7733717651",
        ["chevron-left"] = "rbxassetid://7733717651",
        ["chevron-right"] = "rbxassetid://7733717651",
        ["chevrons-up"] = "rbxassetid://7733717651",
        ["chevrons-down"] = "rbxassetid://7733717447",
        ["rotate-cw"] = "rbxassetid://7734056468",
        ["rotate-ccw"] = "rbxassetid://7734056468",
    }
end

-- Utility Functions
local function Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
    local tween = TweenService:Create(instance, TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    ), properties)
    tween:Play()
    return tween
end

-- Improved Dragging System
local function MakeDraggable(frame, handle, onDragStart, onDragEnd)
    local dragging = false
    local dragInput, mousePos, framePos
    
    local connection1 = handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            if onDragStart then onDragStart() end
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if onDragEnd then onDragEnd() end
                end
            end)
        end
    end)
    
    local connection2 = handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    local connection3 = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Return cleanup function
    return function()
        connection1:Disconnect()
        connection2:Disconnect()
        connection3:Disconnect()
    end
end

-- Themes
AuroraUI.Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 35),
        SecondaryBackground = Color3.fromRGB(40, 40, 45),
        TertiaryBackground = Color3.fromRGB(50, 50, 55),
        Accent = Color3.fromRGB(100, 150, 255),
        AccentDark = Color3.fromRGB(80, 120, 220),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(60, 60, 65),
        Success = Color3.fromRGB(80, 200, 120),
        Error = Color3.fromRGB(255, 80, 80),
        Warning = Color3.fromRGB(255, 180, 80),
        Shadow = Color3.fromRGB(0, 0, 0),
        Acrylic = Color3.fromRGB(30, 30, 35)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 250),
        SecondaryBackground = Color3.fromRGB(235, 235, 240),
        TertiaryBackground = Color3.fromRGB(225, 225, 230),
        Accent = Color3.fromRGB(80, 130, 240),
        AccentDark = Color3.fromRGB(60, 110, 220),
        Text = Color3.fromRGB(40, 40, 45),
        SubText = Color3.fromRGB(100, 100, 105),
        Border = Color3.fromRGB(200, 200, 205),
        Success = Color3.fromRGB(60, 180, 100),
        Error = Color3.fromRGB(220, 60, 60),
        Warning = Color3.fromRGB(230, 160, 60),
        Shadow = Color3.fromRGB(150, 150, 155),
        Acrylic = Color3.fromRGB(245, 245, 250)
    },
    Midnight = {
        Background = Color3.fromRGB(20, 20, 30),
        SecondaryBackground = Color3.fromRGB(30, 30, 45),
        TertiaryBackground = Color3.fromRGB(40, 40, 60),
        Accent = Color3.fromRGB(140, 100, 255),
        AccentDark = Color3.fromRGB(120, 80, 235),
        Text = Color3.fromRGB(240, 240, 255),
        SubText = Color3.fromRGB(160, 160, 180),
        Border = Color3.fromRGB(50, 50, 70),
        Success = Color3.fromRGB(100, 220, 150),
        Error = Color3.fromRGB(255, 100, 100),
        Warning = Color3.fromRGB(255, 200, 100),
        Shadow = Color3.fromRGB(0, 0, 10),
        Acrylic = Color3.fromRGB(20, 20, 30)
    },
    Crimson = {
        Background = Color3.fromRGB(35, 20, 25),
        SecondaryBackground = Color3.fromRGB(45, 25, 30),
        TertiaryBackground = Color3.fromRGB(55, 30, 35),
        Accent = Color3.fromRGB(255, 80, 100),
        AccentDark = Color3.fromRGB(235, 60, 80),
        Text = Color3.fromRGB(255, 240, 245),
        SubText = Color3.fromRGB(200, 180, 185),
        Border = Color3.fromRGB(70, 40, 45),
        Success = Color3.fromRGB(100, 220, 140),
        Error = Color3.fromRGB(255, 60, 80),
        Warning = Color3.fromRGB(255, 180, 100),
        Shadow = Color3.fromRGB(20, 5, 10),
        Acrylic = Color3.fromRGB(35, 20, 25)
    }
}

-- Default Configuration
AuroraUI.Config = {
    Theme = "Dark",
    AnimationSpeed = 0.3,
    CornerRadius = 8,
    Font = Enum.Font.Gotham,
    TitleFont = Enum.Font.GothamBold,
    Scale = 1.0,
    Acrylic = true,
    UseLucide = true
}

-- Initialize Library
function AuroraUI:Init(config)
    local newConfig = {}
    for key, value in pairs(self.Config) do
        newConfig[key] = config and config[key] or value
    end
    self.Config = newConfig
    self.CurrentTheme = self.Themes[self.Config.Theme] or self.Themes.Dark
    
    -- Load fallback icons by default, user can call LoadLucideIcons() to override
    if not next(self.LucideIcons) then
        self:LoadFallbackIcons()
    end
    
    return self
end

-- Create Acrylic Effect
function AuroraUI:CreateAcrylic(parent, intensity)
    if not self.Config.Acrylic then return nil end
    
    local acrylic = Create("Frame", {
        Name = "Acrylic",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = self.CurrentTheme.Acrylic,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = parent
    })
    
    local blur = Create("ImageLabel", {
        Name = "Blur",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.Shadow,
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = acrylic
    })
    
    return acrylic
end

-- Create Shadow
function AuroraUI:CreateShadow(parent, intensity)
    local shadow = Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 20, 1, 20),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.Shadow,
        ImageTransparency = 1 - (intensity or 0.5),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = parent
    })
    return shadow
end

-- Create Lucide Icon
function AuroraUI:CreateIcon(name, size, parent)
    local iconId = self.LucideIcons[name] or self.LucideIcons["circle"] or "rbxassetid://7733960981"
    
    local icon = Create("ImageLabel", {
        Name = "Icon_" .. name,
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1,
        Image = iconId,
        ImageColor3 = self.CurrentTheme.Text,
        Parent = parent
    })
    
    return icon
end

-- Create Window
function AuroraUI:CreateWindow(title, size)
    local window = {}
    window.Title = title or "AuroraUI"
    window.Size = size or UDim2.new(0, 600, 0, 400)
    window.Tabs = {}
    window.ActiveTab = nil
    window.IsMaximized = false
    window.PreviousSize = nil
    window.PreviousPosition = nil
    window.DragConnections = {}
    
    -- ScreenGui
    window.ScreenGui = Create("ScreenGui", {
        Name = "AuroraUI_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    -- Main Frame
    window.MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = window.Size,
        Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.5, -window.Size.Y.Offset/2),
        BackgroundColor3 = self.CurrentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = window.ScreenGui
    })
    
    local mainCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, self.Config.CornerRadius),
        Parent = window.MainFrame
    })
    
    -- Acrylic Background
    if self.Config.Acrylic then
        self:CreateAcrylic(window.MainFrame)
    end
    
    self:CreateShadow(window.MainFrame, 0.6)
    
    -- Title Bar
    window.TitleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Parent = window.MainFrame
    })
    
    local titleCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, self.Config.CornerRadius),
        Parent = window.TitleBar
    })
    
    local titleFix = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Parent = window.TitleBar
    })
    
    -- Title Label
    window.TitleLabel = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = window.Title,
        TextColor3 = self.CurrentTheme.Text,
        TextSize = 16,
        Font = self.Config.TitleFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = window.TitleBar
    })
    
    -- Minimize Button
    window.MinimizeBtn = Create("TextButton", {
        Name = "Minimize",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -105, 0, 5),
        BackgroundColor3 = self.CurrentTheme.TertiaryBackground,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.MinimizeBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("minus", 16, window.MinimizeBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.MinimizeBtn.Text = "−"
        window.MinimizeBtn.TextColor3 = self.CurrentTheme.Text
        window.MinimizeBtn.TextSize = 20
        window.MinimizeBtn.Font = self.Config.TitleFont
    end
    
    -- Maximize Button
    window.MaximizeBtn = Create("TextButton", {
        Name = "Maximize",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -70, 0, 5),
        BackgroundColor3 = self.CurrentTheme.TertiaryBackground,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.MaximizeBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("maximize", 16, window.MaximizeBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.MaximizeBtn.Text = "□"
        window.MaximizeBtn.TextColor3 = self.CurrentTheme.Text
        window.MaximizeBtn.TextSize = 16
        window.MaximizeBtn.Font = self.Config.TitleFont
    end
    
    -- Close Button
    window.CloseBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = self.CurrentTheme.Error,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.CloseBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("x", 16, window.CloseBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.CloseBtn.Text = "×"
        window.CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseBtn.TextSize = 20
        window.CloseBtn.Font = self.Config.TitleFont
    end
    
    -- Tab Container
    window.TabContainer = Create("ScrollingFrame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 140, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.CurrentTheme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = window.MainFrame
    })
    
    local tabList = Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = window.TabContainer
    })
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Parent = window.TabContainer
    })
    
    -- Content Container
    window.ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -150, 1, -50),
        Position = UDim2.new(0, 145, 0, 45),
        BackgroundTransparency = 1,
        Parent = window.MainFrame
    })
    
    -- Minimized Icon
    window.MinimizedIcon = Create("TextButton", {
        Name = "MinimizedIcon",
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 20, 0.5, -25),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        Text = "",
        Visible = false,
        Parent = window.ScreenGui
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = window.MinimizedIcon
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("menu", 24, window.MinimizedIcon).Position = UDim2.new(0.5, -12, 0.5, -12)
    else
        window.MinimizedIcon.Text = "AU"
        window.MinimizedIcon.TextColor3 = self.CurrentTheme.Accent
        window.MinimizedIcon.TextSize = 20
        window.MinimizedIcon.Font = self.Config.TitleFont
    end
    
    self:CreateShadow(window.MinimizedIcon, 0.5)
    
    -- Dragging - Store cleanup functions
    table.insert(window.DragConnections, MakeDraggable(window.MainFrame, window.TitleBar))
    table.insert(window.DragConnections, MakeDraggable(window.MinimizedIcon, window.MinimizedIcon))
    
    -- Minimize Logic
    local isMinimized = false
    
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = true
        Tween(window.MainFrame, {Size = UDim2.new(0, window.Size.X.Offset, 0, 0)}, 0.3)
        task.wait(0.3)
        window.MainFrame.Visible = false
        window.MinimizedIcon.Visible = true
        window.MinimizedIcon.Position = window.MainFrame.Position
    end)
    
    window.MinimizedIcon.MouseButton1Click:Connect(function()
        isMinimized = false
        window.MainFrame.Position = window.MinimizedIcon.Position
        window.MainFrame.Visible = true
        window.MinimizedIcon.Visible = false
        Tween(window.MainFrame, {Size = window.IsMaximized and UDim2.new(0, workspace.CurrentCamera.ViewportSize.X - 40, 0, workspace.CurrentCamera.ViewportSize.Y - 40) or window.Size}, 0.3)
    end)
    
    -- Maximize Logic - Fixed
    window.MaximizeBtn.MouseButton1Click:Connect(function()
        if window.IsMaximized then
            -- Restore
            window.IsMaximized = false
            if window.PreviousSize and window.PreviousPosition then
                Tween(window.MainFrame, {
                    Size = window.PreviousSize,
                    Position = window.PreviousPosition
                }, 0.3)
            end
            if self.Config.UseLucide then
                local icon = window.MaximizeBtn:FindFirstChildOfClass("ImageLabel")
                if icon then icon.Image = self.LucideIcons["maximize"] or self.LucideIcons["maximize-2"] end
            else
                window.MaximizeBtn.Text = "□"
            end
        else
            -- Maximize
            window.IsMaximized = true
            window.PreviousSize = window.MainFrame.Size
            window.PreviousPosition = window.MainFrame.Position
            
            local viewportSize = workspace.CurrentCamera.ViewportSize
            Tween(window.MainFrame, {
                Size = UDim2.new(0, viewportSize.X - 40, 0, viewportSize.Y - 40),
                Position = UDim2.new(0, 20, 0, 20)
            }, 0.3)
            if self.Config.UseLucide then
                local icon = window.MaximizeBtn:FindFirstChildOfClass("ImageLabel")
                if icon then icon.Image = self.LucideIcons["minimize"] or self.LucideIcons["minimize-2"] end
            else
                window.MaximizeBtn.Text = "❐"
            end
        end
    end)
    
    window.CloseBtn.MouseButton1Click:Connect(function()
        -- Cleanup drag connections
        for _, cleanup in ipairs(window.DragConnections) do
            if type(cleanup) == "function" then
                cleanup()
            end
        end
        window.ScreenGui:Destroy()
    end)
    
    -- Hover Effects
    local function addHoverEffect(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, 0.2)
        end)
        button.MouseLeave:Connect(function()
            Tween(button, {BackgroundColor3 = normalColor}, 0.2)
        end)
    end
    
    addHoverEffect(window.MinimizeBtn, self.CurrentTheme.TertiaryBackground, self.CurrentTheme.Border)
    addHoverEffect(window.MaximizeBtn, self.CurrentTheme.TertiaryBackground, self.CurrentTheme.Border)
    
    window.CloseBtn.MouseEnter:Connect(function()
        Tween(window.CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    window.CloseBtn.MouseLeave:Connect(function()
        Tween(window.CloseBtn, {BackgroundColor3 = self.CurrentTheme.Error}, 0.2)
    end)
    
    -- Tab Creation Function
    function window:CreateTab(tabName, icon)
        local tab = {}
        tab.Name = tabName
        tab.Sections = {}
        
        -- Tab Button
        tab.Button = Create("TextButton", {
            Name = tabName .. "Tab",
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
            Text = "",
            AutoButtonColor = false,
            Parent = window.TabContainer
        })
        
        local buttonCorner = Create("UICorner", {
            CornerRadius = UDim.new(0, 6),
            Parent = tab.Button
        })
        
        -- Icon
        if AuroraUI.Config.UseLucide and icon then
            tab.Icon = AuroraUI:CreateIcon(icon, 18, tab.Button)
            tab.Icon.Position = UDim2.new(0, 10, 0.5, -9)
        else
            tab.Icon = Create("TextLabel", {
                Size = UDim2.new(0, 25, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = icon or "•",
                TextColor3 = AuroraUI.CurrentTheme.SubText,
                TextSize = 18,
                Font = AuroraUI.Config.Font,
                Parent = tab.Button
            })
        end
        
        tab.Label = Create("TextLabel", {
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 35, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = AuroraUI.CurrentTheme.SubText,
            TextSize = 14,
            Font = AuroraUI.Config.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tab.Button
        })
        
        -- Tab Content
        tab.Content = Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = AuroraUI.CurrentTheme.Accent,
            Visible = false,
            Parent = window.ContentContainer
        })
        
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5),
            Parent = tab.Content
        })
        
        local contentList = Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = tab.Content
        })
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab Selection - Fixed: Use MouseButton1Click properly
        tab.Button.MouseButton1Click:Connect(function()
            if window.ActiveTab == tab then return end
            
            -- Deselect current
            if window.ActiveTab then
                Tween(window.ActiveTab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                Tween(window.ActiveTab.Label, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                if AuroraUI.Config.UseLucide then
                    local icon = window.ActiveTab.Icon
                    if icon and icon:IsA("ImageLabel") then
                        Tween(icon, {ImageColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                    elseif icon then
                        Tween(icon, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                    end
                else
                    Tween(window.ActiveTab.Icon, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                end
                window.ActiveTab.Content.Visible = false
            end
            
            -- Select new
            window.ActiveTab = tab
            Tween(tab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
            Tween(tab.Label, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            if AuroraUI.Config.UseLucide then
                if tab.Icon and tab.Icon:IsA("ImageLabel") then
                    Tween(tab.Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                elseif tab.Icon then
                    Tween(tab.Icon, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                end
            else
                Tween(tab.Icon, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            end
            tab.Content.Visible = true
            
            -- Animation
            tab.Content.Position = UDim2.new(0.02, 0, 0, 0)
            Tween(tab.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
        end)
        
        -- Section Creation
        function tab:CreateSection(sectionTitle)
            local section = {}
            
            section.Container = Create("Frame", {
                Name = sectionTitle .. "Section",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = tab.Content
            })
            
            Create("UICorner", {
                CornerRadius = UDim.new(0, 6),
                Parent = section.Container
            })
            
            Create("UIPadding", {
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                Parent = section.Container
            })
            
            local sectionList = Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = section.Container
            })
            
            if sectionTitle and sectionTitle ~= "" then
                local header = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = sectionTitle,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 14,
                    Font = AuroraUI.Config.TitleFont,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = section.Container
                })
            end
            
            -- Element Creation Functions (same as before, abbreviated for space)
            function section:AddLabel(text)
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Parent = section.Container
                })
                return label
            end
            
            function section:AddButton(text, callback)
                local button = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = AuroraUI.CurrentTheme.Accent,
                    Text = text,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    Parent = section.Container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                button.MouseButton1Click:Connect(function()
                    Tween(button, {Size = UDim2.new(0.98, 0, 0, 32)}, 0.1)
                    task.wait(0.1)
                    Tween(button, {Size = UDim2.new(1, 0, 0, 32)}, 0.1)
                    if callback then callback() end
                end)
                
                button.MouseEnter:Connect(function()
                    Tween(button, {BackgroundColor3 = AuroraUI.CurrentTheme.AccentDark}, 0.2)
                end)
                button.MouseLeave:Connect(function()
                    Tween(button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
                end)
                
                return button
            end
            
            function section:AddToggle(text, default, callback)
                local toggle = {}
                toggle.Value = default or false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -50, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                toggle.Button = Create("TextButton", {
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -40, 0.5, -11),
                    BackgroundColor3 = toggle.Value and AuroraUI.CurrentTheme.Accent or AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "",
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = toggle.Button
                })
                
                toggle.Indicator = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = toggle.Value and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = toggle.Button
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = toggle.Indicator
                })
                
                local function update()
                    if toggle.Value then
                        Tween(toggle.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
                        Tween(toggle.Indicator, {Position = UDim2.new(1, -19, 0.5, -8)}, 0.2)
                    else
                        Tween(toggle.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                        Tween(toggle.Indicator, {Position = UDim2.new(0, 3, 0.5, -8)}, 0.2)
                    end
                    if callback then callback(toggle.Value) end
                end
                
                toggle.Button.MouseButton1Click:Connect(function()
                    toggle.Value = not toggle.Value
                    update()
                end)
                
                toggle.Set = function(self, value)
                    toggle.Value = value
                    update()
                end
                
                return toggle
            end
            
            function section:AddSlider(text, min, max, default, callback)
                local slider = {}
                min = min or 0
                max = max or 100
                default = math.clamp(default or min, min, max)
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(0.7, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local valueLabel = Create("TextLabel", {
                    Size = UDim2.new(0.3, 0, 0, 18),
                    Position = UDim2.new(0.7, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = AuroraUI.CurrentTheme.Accent,
                    TextSize = 13,
                    Font = AuroraUI.Config.TitleFont,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = container
                })
                
                local track = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 6),
                    Position = UDim2.new(0, 0, 0, 28),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    BorderSizePixel = 0,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = track
                })
                
                local fill = Create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = AuroraUI.CurrentTheme.Accent,
                    BorderSizePixel = 0,
                    Parent = track
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = fill
                })
                
                local knob = Create("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = track
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = knob
                })
                
                local dragging = false
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (pos * (max - min)))
                    valueLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, -7, 0.5, -7)
                    if callback then callback(value) end
                end
                
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        update(input)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        update(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                slider.Set = function(self, value)
                    value = math.clamp(value, min, max)
                    local pos = (value - min) / (max - min)
                    valueLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, -7, 0.5, -7)
                    if callback then callback(value) end
                end
                
                return slider
            end
            
            function section:AddDropdown(text, options, callback)
                local dropdown = {}
                options = options or {}
                local isOpen = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local button = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "Select...",
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                local arrow = Create("TextLabel", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 12,
                    Font = AuroraUI.Config.Font,
                    Parent = button
                })
                
                local optionContainer = Create("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 36),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = AuroraUI.CurrentTheme.Accent,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = optionContainer
                })
                
                local optionList = Create("UIListLayout", {
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = optionContainer
                })
                
                optionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    optionContainer.CanvasSize = UDim2.new(0, 0, 0, optionList.AbsoluteContentSize.Y + 10)
                end)
                
                local function toggle()
                    isOpen = not isOpen
                    if isOpen then
                        Tween(arrow, {Rotation = 180}, 0.2)
                        local height = math.min(#options * 28 + 10, 150)
                        Tween(container, {Size = UDim2.new(1, 0, 0, 36 + height)}, 0.2)
                        Tween(optionContainer, {Size = UDim2.new(1, 0, 0, height)}, 0.2)
                    else
                        Tween(arrow, {Rotation = 0}, 0.2)
                        Tween(container, {Size = UDim2.new(1, 0, 0, 32)}, 0.2)
                        Tween(optionContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    end
                end
                
                button.MouseButton1Click:Connect(toggle)
                
                for i, option in ipairs(options) do
                    local optionBtn = Create("TextButton", {
                        Size = UDim2.new(1, -10, 0, 26),
                        Position = UDim2.new(0, 5, 0, 5 + (i-1) * 28),
                        BackgroundTransparency = 1,
                        Text = option,
                        TextColor3 = AuroraUI.CurrentTheme.Text,
                        TextSize = 12,
                        Font = AuroraUI.Config.Font,
                        Parent = optionContainer
                    })
                    
                    optionBtn.MouseButton1Click:Connect(function()
                        button.Text = option
                        button.TextColor3 = AuroraUI.CurrentTheme.Text
                        toggle()
                        if callback then callback(option) end
                    end)
                    
                    optionBtn.MouseEnter:Connect(function()
                        Tween(optionBtn, {BackgroundTransparency = 0.9}, 0.1)
                        optionBtn.BackgroundColor3 = AuroraUI.CurrentTheme.Accent
                    end)
                    optionBtn.MouseLeave:Connect(function()
                        Tween(optionBtn, {BackgroundTransparency = 1}, 0.1)
                    end)
                end
                
                dropdown.Set = function(self, value)
                    button.Text = value
                    button.TextColor3 = AuroraUI.CurrentTheme.Text
                    if callback then callback(value) end
                end
                
                return dropdown
            end
            
            function section:AddTextBox(text, placeholder, callback)
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local box = Create("TextBox", {
                    Size = UDim2.new(1, 0, 0, 32),
                    Position = UDim2.new(0, 0, 0, 22),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "",
                    PlaceholderText = placeholder or "Enter text...",
                    PlaceholderColor3 = AuroraUI.CurrentTheme.SubText,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    ClearTextOnFocus = false,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = box
                })
                
                Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    Parent = box
                })
                
                box.Focused:Connect(function()
                    Tween(box, {BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground}, 0.2)
                end)
                box.FocusLost:Connect(function(enterPressed)
                    Tween(box, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                    if callback then callback(box.Text, enterPressed) end
                end)
                
                return box
            end
            
            function section:AddKeybind(text, defaultKey, callback)
                local keybind = {}
                local currentKey = defaultKey or nil
                local waiting = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -70, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local button = Create("TextButton", {
                    Size = UDim2.new(0, 65, 0, 26),
                    Position = UDim2.new(1, -65, 0.5, -13),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = currentKey and currentKey.Name or "None",
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 12,
                    Font = AuroraUI.Config.Font,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                button.MouseButton1Click:Connect(function()
                    if waiting then return end
                    waiting = true
                    button.Text = "..."
                    button.TextColor3 = AuroraUI.CurrentTheme.Accent
                    
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode ~= Enum.KeyCode.Escape then
                                currentKey = input.KeyCode
                                button.Text = input.KeyCode.Name
                                if callback then callback(input.KeyCode) end
                            else
                                button.Text = currentKey and currentKey.Name or "None"
                            end
                            button.TextColor3 = AuroraUI.CurrentTheme.Text
                            waiting = false
                            connection:Disconnect()
                        end
                    end)
                end)
                
                UserInputService.InputBegan:Connect(function(input)
                    if not waiting and currentKey and input.KeyCode == currentKey then
                        if callback then callback(currentKey, true) end
                    end
                end)
                
                return keybind
            end
            
            return section
        end
        
        table.insert(window.Tabs, tab)
        
        -- Auto-select first tab - Fixed: Use direct selection instead of Fire
        if #window.Tabs == 1 then
            task.spawn(function()
                task.wait(0.1)
                -- Simulate click by calling the logic directly
                tab.Button.BackgroundColor3 = AuroraUI.CurrentTheme.Accent
                tab.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                if AuroraUI.Config.UseLucide and tab.Icon and tab.Icon:IsA("ImageLabel") then
                    tab.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                elseif tab.Icon then
                    tab.Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                tab.Content.Visible = true
                window.ActiveTab = tab
            end)
        end
        
        return tab
    end
    
    -- Notification System
    function window:Notify(title, message, duration, type)
        duration = duration or 3
        type = type or "Info"
        
        local colors = {
            Info = AuroraUI.CurrentTheme.Accent,
            Success = AuroraUI.CurrentTheme.Success,
            Warning = AuroraUI.CurrentTheme.Warning,
            Error = AuroraUI.CurrentTheme.Error
        }
        
        local notif = Create("Frame", {
            Size = UDim2.new(0, 280, 0, 80),
            Position = UDim2.new(1, 300, 1, -100),
            BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0,
            Parent = self.ScreenGui
        })
        
        Create("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = notif
        })
        
        AuroraUI:CreateShadow(notif, 0.4)
        
        local bar = Create("Frame", {
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = colors[type] or colors.Info,
            BorderSizePixel = 0,
            Parent = notif
        })
        
        Create("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = bar
        })
        
        local fix = Create("Frame", {
            Size = UDim2.new(0, 4, 1, 0),
            Position = UDim2.new(0, 2, 0, 0),
            BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0,
            Parent = notif
        })
        
        local titleLabel = Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 22),
            Position = UDim2.new(0, 15, 0, 10),
            BackgroundTransparency = 1,
            Text = title,
            TextColor3 = AuroraUI.CurrentTheme.Text,
            TextSize = 14,
            Font = AuroraUI.Config.TitleFont,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = notif
        })
        
        local msgLabel = Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 40),
            Position = UDim2.new(0, 15, 0, 32),
            BackgroundTransparency = 1,
            Text = message,
            TextColor3 = AuroraUI.CurrentTheme.SubText,
            TextSize = 12,
            Font = AuroraUI.Config.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Parent = notif
        })
        
        Tween(notif, {Position = UDim2.new(1, -300, 1, -100)}, 0.4)
        
        task.wait(duration)
        
        Tween(notif, {Position = UDim2.new(1, 300, 1, -100)}, 0.4)
        task.wait(0.4)
        notif:Destroy()
    end
    
    return window
end

-- Theme Switcher
function AuroraUI:SetTheme(themeName)
    if self.Themes[themeName] then
        self.Config.Theme = themeName
        self.CurrentTheme = self.Themes[themeName]
        return true
    end
    return false
end

return AuroraUI
