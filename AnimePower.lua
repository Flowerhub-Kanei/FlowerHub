
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
