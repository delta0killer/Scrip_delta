local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local GUI_NAME = "DeltaAnimeZombieArena" 

if LocalPlayer.PlayerGui:FindFirstChild(GUI_NAME) then
    LocalPlayer.PlayerGui[GUI_NAME]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 240)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -120) -- Появляется ровно по центру
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 1
TitleBar.BorderColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.Active = true 
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -70, 1, 0)
TitleLabel.Position = UDim2.new(0, 8, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "delta – anime zombie"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 12
TitleLabel.Parent = TitleBar

local DragArea = Instance.new("TextButton")
DragArea.Size = UDim2.new(1, -70, 1, 0)
DragArea.BackgroundTransparency = 1
DragArea.Text = ""
DragArea.Active = true
DragArea.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -70, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 16
MinimizeBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TitleBar

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -12, 1, -44) 
ContentFrame.Position = UDim2.new(0, 6, 0, 38)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 3 
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 4)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentFrame

local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 24, 0, 24)
ResizeBtn.Position = UDim2.new(1, -24, 1, -24)
ResizeBtn.BackgroundTransparency = 1
ResizeBtn.Text = "◢"
ResizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ResizeBtn.TextSize = 14
ResizeBtn.Active = true
ResizeBtn.Parent = MainFrame

local function CreateToggle(name, desc, callback)
    local TFrame = Instance.new("Frame")
    TFrame.Size = UDim2.new(1, 0, 0, 44)
    TFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TFrame.BorderSizePixel = 1
    TFrame.BorderColor3 = Color3.fromRGB(55, 55, 55)
    TFrame.Parent = ContentFrame

    local NLabel = Instance.new("TextLabel")
    NLabel.Size = UDim2.new(1, -60, 0, 16)
    NLabel.Position = UDim2.new(0, 6, 0, 4)
    NLabel.BackgroundTransparency = 1
    NLabel.Text = name
    NLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    NLabel.TextXAlignment = Enum.TextXAlignment.Left
    NLabel.Font = Enum.Font.GothamBold
    NLabel.TextSize = 11
    NLabel.Parent = TFrame

    local DLabel = Instance.new("TextLabel")
    DLabel.Size = UDim2.new(1, -60, 0, 14)
    DLabel.Position = UDim2.new(0, 6, 0, 20)
    DLabel.BackgroundTransparency = 1
    DLabel.Text = desc
    DLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    DLabel.TextXAlignment = Enum.TextXAlignment.Left
    DLabel.Font = Enum.Font.Gotham
    DLabel.TextSize = 9
    DLabel.Parent = TFrame

    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(0, 45, 0, 22)
    TBtn.Position = UDim2.new(1, -51, 0.5, -11)
    TBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TBtn.BorderSizePixel = 1
    TBtn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    TBtn.Text = "OFF"
    TBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 11
    TBtn.Parent = TFrame

    local state = false
    TBtn.MouseButton1Click:Connect(function()
        state = not state
        TBtn.Text = state and "ON" or "OFF"
        TBtn.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        callback(state)
    end)
end

local function CreateSlider(name, min, max, default, callback)
    local SFrame = Instance.new("Frame")
    SFrame.Size = UDim2.new(1, 0, 0, 44)
    SFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SFrame.BorderSizePixel = 1
    SFrame.BorderColor3 = Color3.fromRGB(55, 55, 55)
    SFrame.Parent = ContentFrame

    local NLabel = Instance.new("TextLabel")
    NLabel.Size = UDim2.new(1, -40, 0, 16)
    NLabel.Position = UDim2.new(0, 6, 0, 2)
    NLabel.BackgroundTransparency = 1
    NLabel.Text = name
    NLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    NLabel.TextXAlignment = Enum.TextXAlignment.Left
    NLabel.Font = Enum.Font.GothamBold
    NLabel.TextSize = 11
    NLabel.Parent = SFrame

    local VLabel = Instance.new("TextLabel")
    VLabel.Size = UDim2.new(0, 30, 0, 16)
    VLabel.Position = UDim2.new(1, -36, 0, 2)
    VLabel.BackgroundTransparency = 1
    VLabel.Text = tostring(default)
    VLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    VLabel.TextXAlignment = Enum.TextXAlignment.Right
    VLabel.Font = Enum.Font.GothamBold
    VLabel.TextSize = 11
    VLabel.Parent = SFrame

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -12, 0, 6)
    Bar.Position = UDim2.new(0, 6, 0, 26)
    Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Bar.BorderSizePixel = 0
    Bar.Parent = SFrame

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    Fill.BorderSizePixel = 0
    Fill.Parent = Bar

    local Knob = Instance.new("TextButton")
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.Position = UDim2.new(((default - min) / (max - min)), -6, 0.5, -6)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.Text = ""
    Knob.Parent = Bar

    local dragging = false
    local function update(input)
        local p = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(min + (max - min) * p + 0.5)
        Fill.Size = UDim2.new(p, 0, 1, 0)
        Knob.Position = UDim2.new(p, -6, 0.5, -6)
        VLabel.Text = tostring(v)
        callback(v)
    end

    Knob.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
    Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true update(i) end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    callback(default)
end

local undergroundActive, platform, camPart, camConn = false, nil, nil, nil
local killAuraActive, combatRemote = false, nil
local currentRadius = 50
local espActive, espHighlights = false, {}

for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") and obj.Name == "Combat" then combatRemote = obj break end
end

local function Underground_Enable()
    if undergroundActive then return end
    local char = LocalPlayer.Character
    if not (char and char:FindFirstChild("HumanoidRootPart")) then return end
    undergroundActive = true
    local hrp = char.HumanoidRootPart
    
    platform = Instance.new("Part")
    platform.Size = Vector3.new(15, 2, 15)
    platform.Position = Vector3.new(hrp.Position.X, -26, hrp.Position.Z)
    platform.Anchored, platform.CanCollide, platform.Transparency = true, true, 0.5
    platform.Color = Color3.fromRGB(0, 255, 0)
    platform.Parent = workspace

    camPart = Instance.new("Part")
    camPart.Size = Vector3.new(1, 1, 1)
    camPart.Transparency, camPart.CanCollide, camPart.Anchored = 1, false, true
    camPart.Position = Vector3.new(hrp.Position.X, 25, hrp.Position.Z)
    camPart.Parent = workspace
    workspace.CurrentCamera.CameraSubject = camPart

    camConn = RunService.Heartbeat:Connect(function()
        if hrp and hrp.Parent and platform then
            platform.CFrame = CFrame.new(hrp.Position.X, -26, hrp.Position.Z)
            camPart.CFrame = CFrame.new(hrp.Position.X, 25, hrp.Position.Z)
            if hrp.Velocity.Y < -10 then hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z) end
        end
    end)
end

local function Underground_Disable()
    if not undergroundActive then return end
    undergroundActive = false
    if camConn then camConn:Disconnect() camConn = nil end
    if platform then platform:Destroy() platform = nil end
    if camPart then camPart:Destroy() camPart = nil end
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then workspace.CurrentCamera.CameraSubject = char.Humanoid end
end

local function NoClip_Enable()
    task.spawn(function()
        while undergroundActive or killAuraActive do
            task.wait(0.1)
            local char = LocalPlayer.Character
            if char then for _, v in ipairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
        end
    end)
end

local function KillAura_Loop()
    while killAuraActive do
        RunService.Heartbeat:Wait() 
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and combatRemote then
            local root = char.HumanoidRootPart
            local closest, dist = nil, math.huge
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj ~= char then
                    local hum = obj:FindFirstChildOfClass("Humanoid")
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hum and hrp and hum.Health > 0 and Players:GetPlayerFromCharacter(obj) == nil then
                        local d = (hrp.Position - root.Position).Magnitude
                        if d <= currentRadius and d < dist then closest, dist = obj, d end
                    end
                end
            end
            if closest then
                local targetHrp = closest:FindFirstChild("HumanoidRootPart")
                if targetHrp then combatRemote:FireServer("M1", (targetHrp.Position - root.Position).Unit) end
            else
                for i = 0, 315, 45 do combatRemote:FireServer("M1", (root.CFrame * CFrame.Angles(0, math.rad(i), 0)).LookVector) end
            end
        end
    end
end

local function ESP_Loop()
    while espActive do
        task.wait(0.5)
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChildOfClass("Humanoid")
                local n = string.lower(obj.Name)
                if (hum and hum.Health > 0) or string.find(n, "zombie") or string.find(n, "enemy") or string.find(n, "mob") then
                    if Players:GetPlayerFromCharacter(obj) == nil and not espHighlights[obj] then
                        local h = Instance.new("Highlight")
                        h.FillColor, h.FillTransparency, h.OutlineColor = Color3.fromRGB(255, 0, 0), 0.4, Color3.fromRGB(255, 255, 255)
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        h.Parent = obj
                        espHighlights[obj] = h
                    end
                end
            end
        end
    end
end

CreateToggle("Underground", "Платформа + Камера", function(s) if s then NoClip_Enable() Underground_Enable() else Underground_Disable() end end)
CreateSlider("Aura Radius", 20, 100, 50, function(v) currentRadius = v end)
CreateToggle("Kill Aura", "Быстрый удар по зомби", function(s) if s and combatRemote then killAuraActive = true task.spawn(KillAura_Loop) else killAuraActive = false end end)
CreateToggle("ESP", "Подсветка зомби", function(s) if s then espActive = true task.spawn(ESP_Loop) else espActive = false for o, h in pairs(espHighlights) do h:Destroy() end espHighlights = {} end end)

-- ================== ФИКС: ОГРАНИЧЕНИЕ ПЕРЕТАСКИВАНИЯ ==================
local drag, rsize = false, false
local dStart, rStart, sPos, sSize = nil, nil, nil, nil

DragArea.InputBegan:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
        drag, dStart, sPos = true, i.Position, MainFrame.Position 
    end 
end)

ResizeBtn.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        rsize, rStart, sSize = true, i.Position, MainFrame.Size
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dStart
        local newX = sPos.X.Offset + d.X
        local newY = sPos.Y.Offset + d.Y
        
        -- НЕ ДАЕМ УТАЩИТЬ ОКНО ЗА ЭКРАН (Защита от "Проеба")
        local screenX = workspace.CurrentCamera.ViewportSize.X
        local screenY = workspace.CurrentCamera.ViewportSize.Y
        
        newX = math.clamp(newX, -MainFrame.AbsoluteSize.X + 50, screenX - 50)
        newY = math.clamp(newY, 0, screenY - 32)
        
        MainFrame.Position = UDim2.new(0, newX, 0, newY)
    end
    
    if rsize and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - rStart
        local newW = math.max(200, sSize.X.Offset + d.X)
        local newH = math.max(150, sSize.Y.Offset + d.Y)
        MainFrame.Size = UDim2.new(0, newW, 0, newH)
    end
end)

UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag, rsize = false, false end end)

local isMin = false
local lastH = 240
MinimizeBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    if isMin then
        lastH = MainFrame.Size.Y.Offset
        MainFrame.Size = UDim2.new(MainFrame.Size.X.Scale, MainFrame.Size.X.Offset, 0, 32)
        ContentFrame.Visible = false
        ResizeBtn.Visible = false
        MinimizeBtn.Text = "□"
    else
        MainFrame.Size = UDim2.new(MainFrame.Size.X.Scale, MainFrame.Size.X.Offset, 0, lastH)
        ContentFrame.Visible = true
        ResizeBtn.Visible = true
        MinimizeBtn.Text = "-"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    if undergroundActive then Underground_Disable() end
    killAuraActive, espActive = false, false
    for o, h in pairs(espHighlights) do h:Destroy() end
    ScreenGui:Destroy()
end)
