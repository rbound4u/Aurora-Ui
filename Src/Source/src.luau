--[[
    AuroraUI v2.2 - Resizable & Auto-Fit
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

-- Load Lucide Icons from external source
AuroraUI.LucideURL = "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/lucide_icons.lua"
AuroraUI.LucideIcons = {}

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
        ["maximize-2"] = "rbxassetid://7733955740",
        ["minimize-2"] = "rbxassetid://7733955740",
        ["check"] = "rbxassetid://7733715400",
        ["chevron-down"] = "rbxassetid://7733717447",
        ["chevron-up"] = "rbxassetid://7733717651",
        ["search"] = "rbxassetid://7734053426",
        ["bell"] = "rbxassetid://7733710707",
        ["moon"] = "rbxassetid://7733955086",
        ["sun"] = "rbxassetid://7734066296",
        ["sliders"] = "rbxassetid://7734066296",
        ["filter"] = "rbxassetid://7733960981",
        ["arrow-up"] = "rbxassetid://7733717651",
        ["arrow-down"] = "rbxassetid://7733717447",
        ["arrow-left"] = "rbxassetid://7733717651",
        ["arrow-right"] = "rbxassetid://7733717651",
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
        Acrylic = Color3.fromRGB(30, 30, 35),
        ResizeHandle = Color3.fromRGB(100, 100, 110)
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
        Acrylic = Color3.fromRGB(245, 245, 250),
        ResizeHandle = Color3.fromRGB(180, 180, 190)
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
        Acrylic = Color3.fromRGB(20, 20, 30),
        ResizeHandle = Color3.fromRGB(80, 80, 100)
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
        Acrylic = Color3.fromRGB(35, 20, 25),
        ResizeHandle = Color3.fromRGB(90, 50, 60)
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
    UseLucide = true,
    Resizable = true,
    MinSize = Vector2.new(400, 300),
    MaxSize = Vector2.new(1200, 800)
}

-- Screen Size Calculator
function AuroraUI:CalculateOptimalSize(preferredSize)
    local viewportSize = workspace.CurrentCamera.ViewportSize
    
    -- Calculate safe area (leave margins)
    local safeWidth = viewportSize.X - 40
    local safeHeight = viewportSize.Y - 40
    
    -- Start with preferred or default
    local width = preferredSize and preferredSize.X.Offset or 600
    local height = preferredSize and preferredSize.Y.Offset or 400
    
    -- Apply min/max constraints
    width = math.clamp(width, self.Config.MinSize.X, math.min(self.Config.MaxSize.X, safeWidth))
    height = math.clamp(height, self.Config.MinSize.Y, math.min(self.Config.MaxSize.Y, safeHeight))
    
    -- Auto-scale for small screens
    if viewportSize.X < 800 then
        width = math.min(width, viewportSize.X - 20)
        height = math.min(height, viewportSize.Y - 20)
    end
    
    -- Center position
    local posX = (viewportSize.X - width) / 2
    local posY = (viewportSize.Y - height) / 2
    
    return UDim2.new(0, width, 0, height), UDim2.new(0, posX, 0, posY)
end

-- Initialize Library
function AuroraUI:Init(config)
    local newConfig = {}
    for key, value in pairs(self.Config) do
        newConfig[key] = config and config[key] or value
    end
    self.Config = newConfig
    self.CurrentTheme = self.Themes[self.Config.Theme] or self.Themes.Dark
    
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

-- Create Resize Handles
function AuroraUI:CreateResizeHandles(window)
    if not self.Config.Resizable then return {} end
    
    local handles = {}
    local mainFrame = window.MainFrame
    local minSize = self.Config.MinSize
    local maxSize = self.Config.MaxSize
    
    -- Corner handles (diagonal resize)
    local corners = {
        {name = "BottomRight", pos = UDim2.new(1, -10, 1, -10), cursor = "rbxasset://SystemCursors/SizeNWSE", 
         resizeFunc = function(delta, origSize, origPos)
            return 
                UDim2.new(0, math.clamp(origSize.X.Offset + delta.X, minSize.X, maxSize.X), 0, math.clamp(origSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)),
                origPos
        end},
        {name = "BottomLeft", pos = UDim2.new(0, 0, 1, -10), cursor = "rbxasset://SystemCursors/SizeNESW",
         resizeFunc = function(delta, origSize, origPos)
            local newWidth = math.clamp(origSize.X.Offset - delta.X, minSize.X, maxSize.X)
            local widthDiff = origSize.X.Offset - newWidth
            return 
                UDim2.new(0, newWidth, 0, math.clamp(origSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)),
                UDim2.new(0, origPos.X.Offset + widthDiff, 0, origPos.Y.Offset)
        end},
        {name = "TopRight", pos = UDim2.new(1, -10, 0, 0), cursor = "rbxasset://SystemCursors/SizeNESW",
         resizeFunc = function(delta, origSize, origPos)
            local newHeight = math.clamp(origSize.Y.Offset - delta.Y, minSize.Y, maxSize.Y)
            local heightDiff = origSize.Y.Offset - newHeight
            return 
                UDim2.new(0, math.clamp(origSize.X.Offset + delta.X, minSize.X, maxSize.X), 0, newHeight),
                UDim2.new(0, origPos.X.Offset, 0, origPos.Y.Offset + heightDiff)
        end},
        {name = "TopLeft", pos = UDim2.new(0, 0, 0, 0), cursor = "rbxasset://SystemCursors/SizeNWSE",
         resizeFunc = function(delta, origSize, origPos)
            local newWidth = math.clamp(origSize.X.Offset - delta.X, minSize.X, maxSize.X)
            local newHeight = math.clamp(origSize.Y.Offset - delta.Y, minSize.Y, maxSize.Y)
            local widthDiff = origSize.X.Offset - newWidth
            local heightDiff = origSize.Y.Offset - newHeight
            return 
                UDim2.new(0, newWidth, 0, newHeight),
                UDim2.new(0, origPos.X.Offset + widthDiff, 0, origPos.Y.Offset + heightDiff)
        end}
    }
    
    -- Edge handles
    local edges = {
        {name = "Right", pos = UDim2.new(1, -6, 0.5, -15), size = UDim2.new(0, 6, 0, 30), cursor = "rbxasset://SystemCursors/SizeWE",
         resizeFunc = function(delta, origSize, origPos)
            return 
                UDim2.new(0, math.clamp(origSize.X.Offset + delta.X, minSize.X, maxSize.X), 0, origSize.Y.Offset),
                origPos
        end},
        {name = "Left", pos = UDim2.new(0, 0, 0.5, -15), size = UDim2.new(0, 6, 0, 30), cursor = "rbxasset://SystemCursors/SizeWE",
         resizeFunc = function(delta, origSize, origPos)
            local newWidth = math.clamp(origSize.X.Offset - delta.X, minSize.X, maxSize.X)
            local widthDiff = origSize.X.Offset - newWidth
            return 
                UDim2.new(0, newWidth, 0, origSize.Y.Offset),
                UDim2.new(0, origPos.X.Offset + widthDiff, 0, origPos.Y.Offset)
        end},
        {name = "Bottom", pos = UDim2.new(0.5, -15, 1, -6), size = UDim2.new(0, 30, 0, 6), cursor = "rbxasset://SystemCursors/SizeNS",
         resizeFunc = function(delta, origSize, origPos)
            return 
                UDim2.new(0, origSize.X.Offset, 0, math.clamp(origSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)),
                origPos
        end},
        {name = "Top", pos = UDim2.new(0.5, -15, 0, 0), size = UDim2.new(0, 30, 0, 6), cursor = "rbxasset://SystemCursors/SizeNS",
         resizeFunc = function(delta, origSize, origPos)
            local newHeight = math.clamp(origSize.Y.Offset - delta.Y, minSize.Y, maxSize.Y)
            local heightDiff = origSize.Y.Offset - newHeight
            return 
                UDim2.new(0, origSize.X.Offset, 0, newHeight),
                UDim2.new(0, origPos.X.Offset, 0, origPos.Y.Offset + heightDiff)
        end}
    }
    
    local allHandles = {}
    
    -- Create corner handles
    for _, corner in ipairs(corners) do
        local handle = Create("Frame", {
            Name = "Resize" .. corner.name,
            Size = UDim2.new(0, 10, 0, 10),
            Position = corner.pos,
            BackgroundColor3 = self.CurrentTheme.ResizeHandle,
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            ZIndex = 100,
            Parent = mainFrame
        })
        
        local cornerRadius = Create("UICorner", {
            CornerRadius = UDim.new(0, 2),
            Parent = handle
        })
        
        local dragging = false
        local startPos, startSize, startFramePos
        
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                startPos = input.Position
                startSize = mainFrame.Size
                startFramePos = mainFrame.Position
                
                -- Change cursor
                UserInputService.MouseIcon = corner.cursor
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - startPos
                local newSize, newPos = corner.resizeFunc(delta, startSize, startFramePos)
                
                mainFrame.Size = newSize
                mainFrame.Position = newPos
                
                -- Update window size reference
                window.Size = newSize
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
                dragging = false
                UserInputService.MouseIcon = ""
            end
        end)
        
        handle.MouseEnter:Connect(function()
            if not dragging then
                UserInputService.MouseIcon = corner.cursor
                Tween(handle, {BackgroundTransparency = 0.2}, 0.1)
            end
        end)
        
        handle.MouseLeave:Connect(function()
            if not dragging then
                UserInputService.MouseIcon = ""
                Tween(handle, {BackgroundTransparency = 0.5}, 0.1)
            end
        end)
        
        table.insert(allHandles, handle)
    end
    
    -- Create edge handles
    for _, edge in ipairs(edges) do
        local handle = Create("Frame", {
            Name = "Resize" .. edge.name,
            Size = edge.size,
            Position = edge.pos,
            BackgroundColor3 = self.CurrentTheme.ResizeHandle,
            BackgroundTransparency = 0.8,
            BorderSizePixel = 0,
            ZIndex = 100,
            Parent = mainFrame
        })
        
        local dragging = false
        local startPos, startSize, startFramePos
        
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                startPos = input.Position
                startSize = mainFrame.Size
                startFramePos = mainFrame.Position
                
                UserInputService.MouseIcon = edge.cursor
                Tween(handle, {BackgroundTransparency = 0.3}, 0.1)
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - startPos
                local newSize, newPos = edge.resizeFunc(delta, startSize, startFramePos)
                
                mainFrame.Size = newSize
                mainFrame.Position = newPos
                window.Size = newSize
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
                dragging = false
                UserInputService.MouseIcon = ""
                Tween(handle, {BackgroundTransparency = 0.8}, 0.1)
            end
        end)
        
        handle.MouseEnter:Connect(function()
            if not dragging then
                UserInputService.MouseIcon = edge.cursor
                Tween(handle, {BackgroundTransparency = 0.5}, 0.1)
            end
        end)
        
        handle.MouseLeave:Connect(function()
            if not dragging then
                UserInputService.MouseIcon = ""
                Tween(handle, {BackgroundTransparency = 0.8}, 0.1)
            end
        end)
        
        table.insert(allHandles, handle)
    end
    
    return allHandles
end

-- Create Window with Auto-Fit and Resizing
function AuroraUI:CreateWindow(title, preferredSize)
    local window = {}
    window.Title = title or "AuroraUI"
    window.DragConnections = {}
    window.ResizeHandles = {}
    
    -- Calculate optimal size and position
    window.Size, window.Position = self:CalculateOptimalSize(preferredSize)
    
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
        Position = window.Position,
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
    
    -- Dragging
    table.insert(window.DragConnections, MakeDraggable(window.MainFrame, window.TitleBar))
    table.insert(window.DragConnections, MakeDraggable(window.MinimizedIcon, window.MinimizedIcon))
    
    -- Resize Handles
    window.ResizeHandles = self:CreateResizeHandles(window)
    
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
        Tween(window.MainFrame, {Size = window.Size}, 0.3)
    end)
    
    -- Maximize Logic
    window.MaximizeBtn.MouseButton1Click:Connect(function()
        if window.IsMaximized then
            -- Restore
            window.IsMaximized = false
            if window.PreviousSize and window.PreviousPosition then
                Tween(window.MainFrame, {
                    Size = window.PreviousSize,
                    Position = window.PreviousPosition
                }, 0.3)
                window.Size = window.PreviousSize
            end
            if self.Config.UseLucide then
                local icon = window.MaximizeBtn:FindFirstChildOfClass("ImageLabel")
                if icon then icon.Image = self.LucideIcons["maximize"] end
            else
                window.MaximizeBtn.Text = "□"
            end
            -- Show resize handles
            for _, handle in ipairs(window.ResizeHandles) do
                handle.Visible = true
            end
        else
            -- Maximize
            window.IsMaximized = true
            window.PreviousSize = window.MainFrame.Size
            window.PreviousPosition = window.MainFrame.Position
            
            local viewportSize = workspace.CurrentCamera.ViewportSize
            local maxSize = UDim2.new(0, viewportSize.X - 40, 0, viewportSize.Y - 40)
            local maxPos = UDim2.new(0, 20, 0, 20)
            
            Tween(window.MainFrame, {
                Size = maxSize,
                Position = maxPos
            }, 0.3)
            window.Size = maxSize
            
            if self.Config.UseLucide then
                local icon = window.MaximizeBtn:FindFirstChildOfClass("ImageLabel")
                if icon then icon.Image = self.LucideIcons["minimize"] end
            else
                window.MaximizeBtn.Text = "❐"
            end
            -- Hide resize handles when maximized
            for _, handle in ipairs(window.ResizeHandles) do
                handle.Visible = false
            end
        end
    end)
    
    window.CloseBtn.MouseButton1Click:Connect(function()
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
    
    -- Auto-fit on screen size change
    local function onViewportChanged()
        if not window.IsMaximized then
            local newSize, newPos = self:CalculateOptimalSize(window.Size)
            -- Only adjust if window is significantly larger than screen
            local viewportSize = workspace.CurrentCamera.ViewportSize
            if window.Size.X.Offset > viewportSize.X - 20 or window.Size.Y.Offset > viewportSize.Y - 20 then
                Tween(window.MainFrame, {Size = newSize, Position = newPos}, 0.3)
                window.Size = newSize
            end
        end
    end
    
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportChanged)
    
    -- Tab Creation Function (abbreviated for space)
    function window:CreateTab(tabName, icon)
        local tab = {}
        tab.Name = tabName
        tab.Sections = {}
        
        tab.Button = Create("TextButton", {
            Name = tabName .. "Tab",
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
            Text = "",
            AutoButtonColor = false,
            Parent = window.TabContainer
        })
        
        Create("UICorner", {
            CornerRadius = UDim.new(0, 6),
            Parent = tab.Button
        })
        
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
        
        tab.Button.MouseButton1Click:Connect(function()
            if window.ActiveTab == tab then return end
            
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
            
            tab.Content.Position = UDim2.new(0.02, 0, 0, 0)
            Tween(tab.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
        end)
        
        -- Section Creation (abbreviated)
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
                Create("TextLabel", {
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
            
            -- Element functions (AddToggle, AddSlider, etc.) same as before...
            -- [Include all the element creation functions from previous version]
            
            return section
        end
        
        table.insert(window.Tabs, tab)
        
        -- Auto-select first tab
        if #window.Tabs == 1 then
            task.spawn(function()
                task.wait(0.1)
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
        
        Create("Frame", {
            Size = UDim2.new(0, 4, 1, 0),
            Position = UDim2.new(0, 2, 0, 0),
            BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0,
            Parent = notif
        })
        
        Create("TextLabel", {
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
        
        Create("TextLabel", {
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
    
    -- Auto-fit button in settings
    function window:AutoFit()
        local newSize, newPos = AuroraUI:CalculateOptimalSize(nil)
        Tween(self.MainFrame, {Size = newSize, Position = newPos}, 0.3)
        self.Size = newSize
        self.Position = newPos
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
