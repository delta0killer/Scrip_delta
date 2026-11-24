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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 480)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Включаем Active для TitleBar, чтобы за него можно было таскать окно на телефоне
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 1
TitleBar.BorderColor3 = Color3.fromRGB(60, 60, 60)
TitleBar.Active = true 
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "delta – anime zombie arena"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 15
TitleLabel.Parent = TitleBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -24, 1, -100)
ContentFrame.Position = UDim2.new(0, 12, 0, 54)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentFrame

local function CreateToggle(name, description, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 58)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 1
    ToggleFrame.BorderColor3 = Color3.fromRGB(55, 55, 55)
    ToggleFrame.Parent = ContentFrame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -100, 0, 20)
    NameLabel.Position = UDim2.new(0, 10, 0, 6)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 13
    NameLabel.Parent = ToggleFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -100, 0, 18)
    DescLabel.Position = UDim2.new(0, 10, 0, 26)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(170, 170, 170)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 11
    DescLabel.Parent = ToggleFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 64, 0, 28)
    ToggleBtn.Position = UDim2.new(1, -74, 0.5, -14)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleBtn.BorderSizePixel = 1
    ToggleBtn.BorderColor3 = Color3.fromRGB(80, 80, 80)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 13
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

-- ---------- Underground Kill (Y = -25) ----------
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

-- ---------- NoClip ----------
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

-- ---------- Kill Aura (Zombies) ----------
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
            if hum and hrp and hum.Health > 0
               and Players:GetPlayerFromCharacter(obj) == nil then
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
    if not zombieRemote then
        warn("[delta] Ошибка: RemoteEvent 'ZombieDamageRemote' не найден в игре!")
    end
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

-- ---------- Test Function ----------
local testActive = false
local function TestFunction_Toggle(state)
    testActive = state
    print("[delta] Test Function: " .. (state and "ON" or "OFF"))
end

CreateToggle("Underground Kill", "Телепорт под карту (Y = -25)", function(state)
    if state then UndergroundKill_Enable() else UndergroundKill_Disable() end
end)

CreateToggle("NoClip", "Проходить сквозь объекты", function(state)
    if state then NoClip_Enable() else NoClip_Disable() end
end)

CreateToggle("Kill Aura (Zombies)", "Атака NPC-зомби (-25 HP, радиус 30)", function(state)
    if state then KillAura_Enable() else KillAura_Disable() end
end)

CreateToggle("Test Function", "Демонстрационный переключатель", TestFunction_Toggle)

local DestroyBtn = Instance.new("TextButton")
DestroyBtn.Size = UDim2.new(1, -50, 0, 34) -- Сделали чуть короче, чтобы не мешал кнопке ресайза
DestroyBtn.Position = UDim2.new(0, 12, 1, -46)
DestroyBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
DestroyBtn.BorderSizePixel = 1
DestroyBtn.BorderColor3 = Color3.fromRGB(120, 50, 50)
DestroyBtn.Text = "DestroyGUI"
DestroyBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
DestroyBtn.Font = Enum.Font.GothamBold
DestroyBtn.TextSize = 14
DestroyBtn.Parent = MainFrame

-- ============================================================
-- НОВАЯ ФУНКЦИЯ: Кнопка изменения размера (в правом нижнем углу)
-- ============================================================
local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 24, 0, 24)
ResizeBtn.Position = UDim2.new(1, -24, 1, -24)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResizeBtn.BorderSizePixel = 0
ResizeBtn.Text = "◢"
ResizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
ResizeBtn.TextSize = 14
ResizeBtn.Active = true
ResizeBtn.Parent = MainFrame

local resizing = false
local resizeStart = nil
local startSize = nil
local resizeChangedConn = nil
local resizeEndedConn = nil

ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.Size
        
        resizeChangedConn = UserInputService.InputChanged:Connect(function(input)
            if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - resizeStart
                -- Минимальная ширина 250, минимальная высота 200
                local newWidth = math.max(250, startSize.X.Offset + delta.X)
                local newHeight = math.max(200, startSize.Y.Offset + delta.Y)
                MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
            end
        end)
        
        resizeEndedConn = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                resizing = false
                if resizeChangedConn then resizeChangedConn:Disconnect() end
                if resizeEndedConn then resizeEndedConn:Disconnect() end
            end
        end)
    end
end)

-- ============================================================
-- ПЕРЕТАСКИВАНИЕ ОКНА
-- ============================================================
local dragging  = false
local dragStart = nil
local startPos  = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        dragStart = input.Position
        startPos  = MainFrame.Position
    end
end)

local inputChangedConn = UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                     or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local inputEndedConn = UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
       or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local insertConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

DestroyBtn.MouseButton1Click:Connect(function()
    if undergroundActive then UndergroundKill_Disable() end
    if noclipConnection  then NoClip_Disable()          end
    if killAuraActive    then KillAura_Disable()        end
    if testActive        then TestFunction_Toggle(false) end

    if insertConnection  then insertConnection:Disconnect()  end
    if inputChangedConn  then inputChangedConn:Disconnect()  end
    if inputEndedConn    then inputEndedConn:Disconnect()    end
    if resizeChangedConn then resizeChangedConn:Disconnect() end
    if resizeEndedConn   then resizeEndedConn:Disconnect()   end

    ScreenGui:Destroy()
    print("[delta] GUI destroyed.")
end)

print("[delta] GUI loaded. Press Insert to toggle.")
