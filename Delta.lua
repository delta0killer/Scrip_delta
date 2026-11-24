local Players           = game:GetService("Players")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local GUI_NAME = "DeltaAnimeZombieArena" 

local oldGui = LocalPlayer.PlayerGui:FindFirstChild(GUI_NAME)
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 380)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Шапка окна
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 1
TitleBar.BorderColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.Active = true 
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0) -- Оставили место для двух кнопок
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "delta – anime zombie arena"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.Active = false
TitleLabel.Parent = TitleBar

-- Невидимая область для перетаскивания (не перекрывает кнопки)
local DragArea = Instance.new("TextButton")
DragArea.Size = UDim2.new(1, -80, 1, 0)
DragArea.BackgroundTransparency = 1
DragArea.Text = ""
DragArea.Active = true
DragArea.Parent = TitleBar

-- Кнопка Свернуть/Развернуть (Квадратик/Минус)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 36, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -72, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-" -- По умолчанию показываем минус
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 16
MinimizeBtn.Active = true
MinimizeBtn.Parent = TitleBar

MinimizeBtn.MouseEnter:Connect(function()
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)
MinimizeBtn.MouseLeave:Connect(function()
    MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

-- Кнопка закрытия (Крестик)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 36, 1, 0)
CloseBtn.Position = UDim2.new(1, -36, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Active = true
CloseBtn.Parent = TitleBar

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

-- Область с прокруткой (Ползунок)
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -16, 1, -50) 
ContentFrame.Position = UDim2.new(0, 8, 0, 44)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 4 
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 5)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentFrame

-- Функция создания тумблеров
local function CreateToggle(name, description, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 1
    ToggleFrame.BorderColor3 = Color3.fromRGB(55, 55, 55)
    ToggleFrame.Parent = ContentFrame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -80, 0, 18)
    NameLabel.Position = UDim2.new(0, 8, 0, 4)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 12
    NameLabel.Parent = ToggleFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -80, 0, 16)
    DescLabel.Position = UDim2.new(0, 8, 0, 22)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 10
    DescLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 55, 0, 24)
    ToggleBtn.Position = UDim2.new(1, -63, 0.5, -12)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.BorderSizePixel = 1
    ToggleBtn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.Parent = ToggleFrame

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        ToggleBtn.Text = state and "ON" or "OFF"
        ToggleBtn.TextColor3 = state and Color3.fromRGB(100, 255, 100)
                                        or Color3.fromRGB(255, 100, 100)
        callback(state)
    end)
end

-- Логика скриптов
local undergroundActive = false
local savedCFrame = nil
local UNDERGROUND_Y = -25

local function UndergroundKill_Enable()
    if undergroundActive then return end
    local character = LocalPlayer.Character
    if not (character and character:FindFirstChild("HumanoidRootPart")) then return end
    undergroundActive = true
    local hrp = character.HumanoidRootPart
    savedCFrame = hrp.CFrame
    hrp.Anchored = true
    hrp.CFrame = CFrame.new(hrp.Position.X, UNDERGROUND_Y, hrp.Position.Z)
end

local function UndergroundKill_Disable()
    if not undergroundActive then return end
    undergroundActive = false
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") and savedCFrame then
        local hrp = character.HumanoidRootPart
        hrp.CFrame = savedCFrame
        hrp.Anchored = false
    end
    savedCFrame = nil
end

local noclipConnection = nil
local function NoClip_Enable()
    if noclipConnection then return end
    noclipConnection = RunService.Stepped:Connect(function()
        local character = LocalPlayer.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function NoClip_Disable()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    local character = LocalPlayer.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local zombieRemote = ReplicatedStorage:FindFirstChild("ZombieDamageRemote")
local killAuraActive = false
local killAuraConnection = nil
local ATTACK_RADIUS   = 30
local ATTACK_COOLDOWN = 0.4
local lastAttack      = 0

local function KillAura_Loop()
    if not killAuraActive then return end
    local now = tick()
    if now - lastAttack < ATTACK_COOLDOWN then return end
    lastAttack = now

    local character = LocalPlayer.Character
    if not (character and character:FindFirstChild("HumanoidRootPart")) then return end
    local root = character.HumanoidRootPart
    local bestTarget, bestDist = nil, math.huge

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= character then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 and Players:GetPlayerFromCharacter(obj) == nil then
                local d = (hrp.Position - root.Position).Magnitude
                if d <= ATTACK_RADIUS and d < bestDist then
                    bestTarget, bestDist = obj, d
                end
            end
        end
    end

    if bestTarget and zombieRemote then
        zombieRemote:FireServer(bestTarget)
    end
end

local function KillAura_Enable()
    if killAuraActive then return end
    killAuraActive = true
    killAuraConnection = RunService.Heartbeat:Connect(KillAura_Loop)
end

local function KillAura_Disable()
    killAuraActive = false
    if killAuraConnection then
        killAuraConnection:Disconnect()
        killAuraConnection = nil
    end
end

local testActive = false
local function TestFunction_Toggle(state)
    testActive = state
    print("[delta] Test Function: " .. (state and "ON" or "OFF"))
end

CreateToggle("Underground Kill", "Телепорт под карту", function(state)
    if state then UndergroundKill_Enable() else UndergroundKill_Disable() end
end)

CreateToggle("NoClip", "Проходить сквозь стены", function(state)
    if state then NoClip_Enable() else NoClip_Disable() end
end)

CreateToggle("Kill Aura", "Атака зомби (радиус 30)", function(state)
    if state then KillAura_Enable() else KillAura_Disable() end
end)

CreateToggle("Test Function", "Демонстрационный переключатель", TestFunction_Toggle)
CreateToggle("Empty Slot 1", "Для теста прокрутки", function() end)
CreateToggle("Empty Slot 2", "Для теста прокрутки", function() end)

-- Уголок для изменения размера
local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 28, 0, 28)
ResizeBtn.Position = UDim2.new(1, -28, 1, -28)
ResizeBtn.BackgroundTransparency = 1
ResizeBtn.Text = "◢"
ResizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ResizeBtn.TextSize = 14
ResizeBtn.Active = true
ResizeBtn.Parent = MainFrame

-- Логика перетаскивания и ресайза
local dragging, dragStart, startPos = false, nil, nil
local resizing, resizeStart, startSize = false, nil, nil

DragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.Size
    end
end)

local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newWidth = math.max(220, startSize.X.Offset + delta.X)
        local newHeight = math.max(180, startSize.Y.Offset + delta.Y)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        resizing = false
    end
end)

-- ЛОГИКА СВОРАЧИВАНИЯ ОКНА
local isMinimized = false
local lastHeight = 380

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        -- Запоминаем текущую высоту и сворачиваем
        lastHeight = MainFrame.Size.Y.Offset
        MainFrame.Size = UDim2.new(MainFrame.Size.X.Scale, MainFrame.Size.X.Offset, 0, 36)
        ContentFrame.Visible = false
        ResizeBtn.Visible = false
        MinimizeBtn.Text = "□" -- Меняем иконку на квадратик
    else
        -- Возвращаем прежнюю высоту
        MainFrame.Size = UDim2.new(MainFrame.Size.X.Scale, MainFrame.Size.X.Offset, 0, lastHeight)
        ContentFrame.Visible = true
        ResizeBtn.Visible = true
        MinimizeBtn.Text = "-" -- Меняем иконку обратно на минус
    end
end)

-- Кнопка Insert для скрытия/показа
local insertConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

-- Очистка при закрытии
CloseBtn.MouseButton1Click:Connect(function()
    if undergroundActive then UndergroundKill_Disable() end
    if noclipConnection  then NoClip_Disable()          end
    if killAuraActive    then KillAura_Disable()        end
    if testActive        then TestFunction_Toggle(false) end

    if insertConnection  then insertConnection:Disconnect()  end
    if inputChangedConn  then inputChangedConn:Disconnect()  end
    if inputEndedConn    then inputEndedConn:Disconnect()    end

    ScreenGui:Destroy()
    print("[delta] GUI destroyed.")
end)

print("[delta] GUI loaded.")
