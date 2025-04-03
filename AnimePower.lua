
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

local OwO = library:Window("Floral Hub V3") local atkTgl = false local autoTP = false local selEn = nil

spawn(function() while task.wait() do if atkTgl then game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack") end end end)

local rs = game:GetService("ReplicatedStorage") local enf = rs:WaitForChild("Assets"):WaitForChild("Enemies") local py = game:GetService("Players").LocalPlayer local char = py.Character or py.CharacterAdded:Wait() local hrp = char:WaitForChild("HumanoidRootPart")

local enList = {} for _, en in pairs(enf:GetChildren()) do table.insert(enList, en.Name) end

OwO:Toggle("Auto Attack (Click)", false, function(state)
    atkTgl = state
    print("Auto Attack:", atkTgl)
end)

spawn(function()
    while task.wait() do
        if atkTgl then
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer("attack")
        end
    end
end)

OwO:Dropdown("Select Mob", enList, function(mob) 
        selEn = mob 
        print("Selected Mob:", mob) 
end)

local function killmontp() 
    if selEn then 
        for _, en in pairs(enf:GetChildren()) do 
            if en.Name == selEn and en.PrimaryPart then 
                hrp.CFrame = en.PrimaryPart.CFrame
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
