local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/turtle"))()

local OwO = library:Window("Floral Hub V3") local atkTgl = false local autoTP = false local selEn = nil

spawn(function() while task.wait() do if atkTgl then game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack") end end end)

local rs = game:GetService("ReplicatedStorage") local enf = rs:WaitForChild("Assets"):WaitForChild("Enemies") local py = game:GetService("Players").LocalPlayer local char = py.Character or py.CharacterAdded:Wait() local hrp = char:WaitForChild("HumanoidRootPart")

local enList = {} for _, en in pairs(enf:GetChildren()) do table.insert(enList, en.Name) end

OwO:Dropdown("Select Mob", enList, function(mob) 
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

OwO:Toggle("Auto Teleport to Enemy", false, function(state) 
        autoTP = state 
        while autoTP do killmontp() 
            task.wait(1) 
        end 
    end)

OwO:Label("Credits to Floral Hub", Color3.fromRGB(127, 143, 166))
