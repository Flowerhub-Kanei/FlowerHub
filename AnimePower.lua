
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
local selectedEnemyName = nil
local teleportCooldown = 0.5
local lastTeleportTime = 0

local replicatedStorage = game:GetService("ReplicatedStorage")
local enemyFolder = replicatedStorage:WaitForChild("Assets"):WaitForChild("Enemies")
local localPlayer = game:GetService("Players").LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local tweenService = game:GetService("TweenService")
local noClipEnabled = false

local enemyNames = {}
for _, enemy in pairs(enemyFolder:GetChildren()) do
  table.insert(enemyNames, enemy.Name)
end

local autoAttackEnabled = false
FloralHub:Toggle("Auto Attack (Click)", false, function(state)
  autoAttackEnabled = state
  print("Auto Attack:", autoAttackEnabled)
end)

spawn(function()
  while true do
    task.wait()
    if autoAttackEnabled then
      replicatedStorage:WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack")
    end
  end
end)

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
          if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
          end
        end
        task.wait()
      end
    end)
  end
end

local function teleportToEnemy()
  if not selectedEnemyName then return end
  if os.time() - lastTeleportTime < teleportCooldown then return end

  local closestEnemy = nil
  local shortestDistance = math.huge

  for _, enemy in pairs(enemyFolder:GetChildren()) do
    if enemy.Name == selectedEnemyName and enemy.PrimaryPart then
      local distance = (humanoidRootPart.Position - enemy.PrimaryPart.Position).Magnitude
      if distance < shortestDistance then
        shortestDistance = distance
        closestEnemy = enemy
      end
    end
  end

  if closestEnemy then
    toggleNoClip(true)
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
    local tween = tweenService:Create(humanoidRootPart, tweenInfo, {CFrame = closestEnemy.PrimaryPart.CFrame})
    tween:Play()
    tween.Completed:Wait()
    toggleNoClip(false)
    lastTeleportTime = os.time()
  else
    warn("Enemy Not Found")
  end
end

local autoTeleportEnabled = false
FloralHub:Toggle("Auto Teleport to Enemy", false, function(state)
  autoTeleportEnabled = state
  while autoTeleportEnabled do
    teleportToEnemy()
    task.wait(0.1)
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
