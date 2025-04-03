local lib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local win = lib:CreateWindow("Floral Hub V3")
local fld = win:CreateFolder("Main")

local function atk()
    local args = { [1] = "attack" }
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

fld:Toggle("Auto Attack (Click)", function(state)
    atkTgl = state
    print("Auto Attack:", atkTgl)
end)

spawn(function()
    while task.wait() do
        if atkTgl then atk() end
    end
end)

local rs = game:GetService("ReplicatedStorage")
local enf = rs:WaitForChild("Assets"):WaitForChild("Enemies")
local py = game:GetService("Players").LocalPlayer
local char = py.Character or py.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local enList = {}
for _, en in pairs(enf:GetChildren()) do
    table.insert(enList, en.Name)
end

local selEn = nil
local enDrop = fld:Dropdown("Select Mob", enList, true, function(mob)
    selEn = mob
    print("Selected Mob:", mob)
end)

local function killmontp()
    if selEn then
        for _, en in pairs(enf:GetChildren()) do
            if en.Name == selEn and en.PrimaryPart then
                hrp.CFrame = en.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                return
            end
        end
    end
end

fld:Toggle("Auto Teleport to Enemy", function(state)
    autoTP = state
    while autoTP do
        killmontp()
        task.wait(1)
    end
end)
