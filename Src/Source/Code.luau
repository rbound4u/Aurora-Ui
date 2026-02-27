--[[
    AuroraUI Library
    A modern, customizable Roblox UI Library
    Version: 1.0.0
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

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
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
        Shadow = Color3.fromRGB(0, 0, 0)
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
        Shadow = Color3.fromRGB(150, 150, 155)
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
        Shadow = Color3.fromRGB(0, 0, 10)
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
        Shadow = Color3.fromRGB(20, 5, 10)
    }
}

-- Default Configuration
AuroraUI.Config = {
    Theme = "Dark",
    AnimationSpeed = 0.3,
    CornerRadius = 8,
    Font = Enum.Font.Gotham,
    TitleFont = Enum.Font.GothamBold,
    Scale = 1.0
}

-- Initialize Library
function AuroraUI:Init(config)
    local newConfig = {}
    for key, value in pairs(self.Config) do
        newConfig[key] = config and config[key] or value
    end
    self.Config = newConfig
    self.CurrentTheme = self.Themes[self.Config.Theme] or self.Themes.Dark
    return self
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

-- Create Window
function AuroraUI:CreateWindow(title, size)
    local window = {}
    window.Title = title or "AuroraUI"
    window.Size = size or UDim2.new(0, 600, 0, 400)
    window.Tabs = {}
    window.ActiveTab = nil
    
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
        Size = UDim2.new(1, -100, 1, 0),
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
        Position = UDim2.new(1, -70, 0, 5),
        BackgroundColor3 = self.CurrentTheme.TertiaryBackground,
        Text = "−",
        TextColor3 = self.CurrentTheme.Text,
        TextSize = 20,
        Font = self.Config.TitleFont,
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.MinimizeBtn
    })
    
    -- Close Button
    window.CloseBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = self.CurrentTheme.Error,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        Font = self.Config.TitleFont,
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.CloseBtn
    })
    
    -- Tab Container
    window.TabContainer = Create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 140, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Parent = window.MainFrame
    })
    
    local tabList = Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = window.TabContainer
    })
    
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
        Text = "AU",
        TextColor3 = self.CurrentTheme.Accent,
        TextSize = 20,
        Font = self.Config.TitleFont,
        Visible = false,
        Parent = window.ScreenGui
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = window.MinimizedIcon
    })
    
    self:CreateShadow(window.MinimizedIcon, 0.5)
    
    -- Dragging
    MakeDraggable(window.MainFrame, window.TitleBar)
    MakeDraggable(window.MinimizedIcon, window.MinimizedIcon)
    
    -- Minimize/Maximize Logic
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
    
    window.CloseBtn.MouseButton1Click:Connect(function()
        window.ScreenGui:Destroy()
    end)
    
    -- Hover Effects
    window.MinimizeBtn.MouseEnter:Connect(function()
        Tween(window.MinimizeBtn, {BackgroundColor3 = self.CurrentTheme.Border}, 0.2)
    end)
    window.MinimizeBtn.MouseLeave:Connect(function()
        Tween(window.MinimizeBtn, {BackgroundColor3 = self.CurrentTheme.TertiaryBackground}, 0.2)
    end)
    
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
        
        -- Tab Selection
        tab.Button.MouseButton1Click:Connect(function()
            if window.ActiveTab == tab then return end
            
            -- Deselect current
            if window.ActiveTab then
                Tween(window.ActiveTab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                Tween(window.ActiveTab.Label, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                Tween(window.ActiveTab.Icon, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                window.ActiveTab.Content.Visible = false
            end
            
            -- Select new
            window.ActiveTab = tab
            Tween(tab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
            Tween(tab.Label, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            Tween(tab.Icon, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
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
            
            -- Element Creation Functions
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
                
                local optionContainer = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 36),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
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
                
                dropdown.UpdateOptions = function(self, newOptions)
                    -- Clear existing
                    for _, child in ipairs(optionContainer:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    options = newOptions
                    -- Rebuild (simplified - would need to rebuild UI)
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
                
                -- Listen for keybind activation
                UserInputService.InputBegan:Connect(function(input)
                    if not waiting and currentKey and input.KeyCode == currentKey then
                        if callback then callback(currentKey, true) end
                    end
                end)
                
                return keybind
            end
            
            function section:AddColorPicker(text, defaultColor, callback)
                local colorPicker = {}
                defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
                local isOpen = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -40, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local preview = Create("TextButton", {
                    Size = UDim2.new(0, 32, 0, 26),
                    Position = UDim2.new(1, -32, 0.5, -13),
                    BackgroundColor3 = defaultColor,
                    Text = "",
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = preview
                })
                
                local pickerFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 180),
                    Position = UDim2.new(0, 0, 0, 36),
                    BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
                    BorderSizePixel = 0,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = pickerFrame
                })
                
                -- Simple RGB sliders
                local rSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 10),
                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local gSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(0, 255, 0),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local bSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 70),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 255),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local r, g, b = defaultColor.R * 255, defaultColor.G * 255, defaultColor.B * 255
                
                local function updateColor()
                    local newColor = Color3.fromRGB(r, g, b)
                    preview.BackgroundColor3 = newColor
                    if callback then callback(newColor) end
                end
                
                preview.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    Tween(container, {Size = UDim2.new(1, 0, 0, isOpen and 220 or 32)}, 0.3)
                end)
                
                colorPicker.Set = function(self, color)
                    preview.BackgroundColor3 = color
                    r, g, b = color.R * 255, color.G * 255, color.B * 255
                    if callback then callback(color) end
                end
                
                return colorPicker
            end
            
            return section
        end
        
        table.insert(window.Tabs, tab)
        
        -- Auto-select first tab
        if #window.Tabs == 1 then
            task.spawn(function()
                task.wait(0.1)
                tab.Button.MouseButton1Click:Fire()
            end)
        end
        
        return tab
    end
    
    -- Notification System
    function window:Notify(title, message, duration, type)
        duration = duration or 3
        type = type or "Info" -- Info, Success, Warning, Error
        
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
        
        -- Slide in
        Tween(notif, {Position = UDim2.new(1, -300, 1, -100)}, 0.4)
        
        task.wait(duration)
        
        -- Slide out
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
        -- Would need to recursively update all UI elements here
        -- For now, applies to new elements only
        return true
    end
    return false
end

return AuroraUI
