
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Loader = Instance.new("ScreenGui")
Loader.Name = "Loader"
Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Loader.Parent = game:GetService("CoreGui")

local LoaderMain = Instance.new("Frame")
LoaderMain.Name = "LoaderMain"
LoaderMain.Size = UDim2.new(0, 400, 0, 200)
LoaderMain.Position = UDim2.new(0.5, 0, 0.5, 0)
LoaderMain.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30) 
LoaderMain.BackgroundTransparency = 0.5 
LoaderMain.BorderSizePixel = 0
LoaderMain.ClipsDescendants = true
LoaderMain.Parent = Loader

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = LoaderMain

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 112, 219)) 
})
UIGradient.Rotation = 45 
UIGradient.Parent = LoaderMain

local Info = Instance.new("TextLabel")
Info.Name = "Info"
Info.Size = UDim2.new(0, 350, 0, 50)
Info.Position = UDim2.new(0.5, 0, 0.2, 0)
Info.AnchorPoint = Vector2.new(0.5, 0)
Info.BackgroundTransparency = 1
Info.Text = "Loading Flower Hub 3.0 Beta"
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Info.TextSize = 18
Info.TextTransparency = 0.5
Info.Parent = LoaderMain

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(0, 350, 0, 30)
Status.Position = UDim2.new(0.5, 0, 0.5, 0)
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.BackgroundTransparency = 1
Status.Text = "0%"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
Status.TextSize = 14
Status.TextTransparency = 0.5
Status.Parent = LoaderMain

local UF = Instance.new("Frame")
UF.Name = "UF"
UF.Size = UDim2.new(0, 350, 0, 10) 
UF.Position = UDim2.new(0.5, 0, 0.7, 0)
UF.AnchorPoint = Vector2.new(0.5, 0)
UF.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
UF.BackgroundTransparency = 0.5
UF.BorderSizePixel = 0
UF.ClipsDescendants = true
UF.Parent = LoaderMain

local B_UICorner = Instance.new("UICorner")
B_UICorner.CornerRadius = UDim.new(0, 5)
B_UICorner.Parent = UF

local GS = Instance.new("Frame")
GS.Name = "GS"
GS.Size = UDim2.new(0, 0, 0, 10)
GS.BackgroundColor3 = Color3.fromRGB(255, 105, 180) 
GS.BorderSizePixel = 0
GS.Parent = UF

local A_UICorner = Instance.new("UICorner")
A_UICorner.CornerRadius = UDim.new(0, 5)
A_UICorner.Parent = GS

local UIGradient_1 = Instance.new("UIGradient")
UIGradient_1.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(147, 112, 219)) 
})
UIGradient_1.Rotation = 45
UIGradient_1.Parent = GS

local function UpdateStatus(percentage)
    Status.Text = percentage .. "%"
    GS.Size = UDim2.new(0, 350 * (percentage / 100), 0, 10)
end

local function AnimateLoader()
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    TweenService:Create(Info, tweenInfo, { TextTransparency = 0 }):Play()
    TweenService:Create(Status, tweenInfo, { TextTransparency = 0 }):Play()
    wait(0.5)
    
    for i = 0, 100, 5 do
        UpdateStatus(i)
        wait(0.1)
    end
    
    TweenService:Create(LoaderMain, tweenInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Info, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(Status, tweenInfo, { TextTransparency = 1 }):Play()
    TweenService:Create(UF, tweenInfo, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(GS, tweenInfo, { BackgroundTransparency = 1 }):Play()
    wait(1)
    
    Loader:Destroy()
end

AnimateLoader()

-----------under is code upper is loader
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()
local FloralHub = library:Window("Floral Hub V3")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local EnemyFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Enemies")
local SelectedEnemy = nil
local EnemyNames = {}
local TeleportCooldown = 0.3
local LastTeleport = 0

for _, enemy in pairs(EnemyFolder:GetChildren()) do
    table.insert(EnemyNames, enemy.Name)
end

FloralHub:Toggle("Auto Attack (Click)", false, function(state)
    AutoAttack = state
    print("Auto Attack:", state)
end)

spawn(function()
    while task.wait() do
        if AutoAttack then
            ReplicatedStorage:WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack")
        end
    end
end)

FloralHub:Dropdown("Select Mob", EnemyNames, function(mobName)
    SelectedEnemy = mobName
    print("Selected Mob:", mobName)
end)

local function TeleportToEnemy()
    if not SelectedEnemy then return end
    
    local currentTime = os.time()
    if currentTime - LastTeleport < TeleportCooldown then return end
    
    local closestEnemy = nil
    local shortestDistance = math.huge
    
    for _, enemy in pairs(EnemyFolder:GetChildren()) do
        if enemy.Name == SelectedEnemy and enemy:FindFirstChild("PrimaryPart") then
            local distance = (HumanoidRootPart.Position - enemy.PrimaryPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestEnemy = enemy
            end
        end
    end
    
    if closestEnemy then
        HumanoidRootPart.CFrame = closestEnemy.PrimaryPart.CFrame
        LastTeleport = currentTime
    else
        warn("Target enemy not found!")
    end
end

FloralHub:Toggle("Auto Teleport to Enemy", false, function(state)
    AutoTeleport = state
    while AutoTeleport do
        TeleportToEnemy()
        task.wait(0.1)
    end
end)

spawn(function()
    while task.wait(3) do
        local newEnemyList = {}
        for _, enemy in pairs(EnemyFolder:GetChildren()) do
            if not table.find(newEnemyList, enemy.Name) then
                table.insert(newEnemyList, enemy.Name)
            end
        end
        EnemyNames = newEnemyList
    end
end)

FloralHub:Label("Credits to Floral Hub", Color3.fromRGB(127, 143, 166))

print("Floral Hub V3 loaded successfully!")
