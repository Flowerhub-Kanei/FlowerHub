local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
repeat task.wait() until character:FindFirstChild("HumanoidRootPart") -- Wait for HumanoidRootPart
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

local enemyFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Enemies")

local teleportCooldown = 0.5
local lastTeleportTime = 0
local autoTeleportEnabled = false
local autoAttackEnabled = false
local noClipEnabled = false
local selectedEnemyName = nil

-- GUI Loader
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

local Status = Instance.new("TextLabel")
Status.Name = "Status"
Status.Size = UDim2.new(0, 350, 0, 30)
Status.Position = UDim2.new(0.5, 0, 0.5, 0)
Status.AnchorPoint = Vector2.new(0.5, 0)
Status.BackgroundTransparency = 1
Status.Text = "0%"
Status.TextColor3 = Color3.fromRGB(255, 255, 255)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 14
Status.Parent = LoaderMain

local ProgressBar = Instance.new("Frame")
ProgressBar.Name = "ProgressBar"
ProgressBar.Size = UDim2.new(0, 350, 0, 10)
ProgressBar.Position = UDim2.new(0.5, 0, 0.7, 0)
ProgressBar.AnchorPoint = Vector2.new(0.5, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBar.BackgroundTransparency = 0.5
ProgressBar.BorderSizePixel = 0
ProgressBar.ClipsDescendants = true
ProgressBar.Parent = LoaderMain

local ProgressFill = Instance.new("Frame")
ProgressFill.Name = "ProgressFill"
ProgressFill.Size = UDim2.new(0, 0, 0, 10)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBar

local function UpdateStatus(percentage)
    Status.Text = percentage .. "%"
    ProgressFill.Size = UDim2.new(percentage / 100, 0, 1, 0)
end

local function AnimateLoader()
    for i = 0, 100, 5 do
        UpdateStatus(i)
        task.wait(0.1)
    end
    task.wait(1)
    Loader:Destroy()
end

AnimateLoader()

-- Library GUI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()
local FloralHub = library:Window("Floral Hub V3")

local enemyNames = {}
for _, enemy in pairs(enemyFolder:GetChildren()) do
    table.insert(enemyNames, enemy.Name)
end

FloralHub:Dropdown("Select Mob", enemyNames, function(mobName)
    selectedEnemyName = mobName
    print("Selected Mob:", mobName)
end)

local function toggleNoClip(enabled)
    noClipEnabled = enabled
    if enabled then
        spawn(function()
            while noClipEnabled do
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait()
            end
        end)
    end
end

local function teleportToEnemy()
    if not selectedEnemyName then
        warn("No enemy selected!")
        return
    end
    if tick() - lastTeleportTime < teleportCooldown then return end

    local closestEnemy = nil
    local shortestDistance = math.huge

    for _, enemy in pairs(enemyFolder:GetChildren()) do
        local enemyPart = enemy.PrimaryPart or enemy:FindFirstChildWhichIsA("BasePart")
        if enemy.Name == selectedEnemyName and enemyPart then
            local distance = (humanoidRootPart.Position - enemyPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestEnemy = enemyPart
            end
        end
    end

    if closestEnemy then
        toggleNoClip(true)
        local tweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = closestEnemy.CFrame})
        tween.Completed:Connect(function()
            toggleNoClip(false)
        end)
        tween:Play()
        lastTeleportTime = tick()
    else
        warn("Enemy not found!")
    end
end

FloralHub:Toggle("Auto Teleport to Enemy", false, function(state)
    autoTeleportEnabled = state
    while autoTeleportEnabled do
        teleportToEnemy()
        task.wait(0.5)
    end
end)

FloralHub:Toggle("Auto Attack (Click)", false, function(state)
    autoAttackEnabled = state
    print("Auto Attack:", autoAttackEnabled)
end)

spawn(function()
    while true do
        task.wait()
        if autoAttackEnabled then
            ReplicatedStorage:WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack")
        end
    end
end)

spawn(function()
    while true do
        task.wait(3)
        enemyNames = {}
        for _, enemy in pairs(enemyFolder:GetChildren()) do
            if not table.find(enemyNames, enemy.Name) then
                table.insert(enemyNames, enemy.Name)
            end
        end
    end
end)

FloralHub:Label("Credits to Floral Hub", Color3.fromRGB(127, 143, 166))
