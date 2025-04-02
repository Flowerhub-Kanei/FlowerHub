
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local window = library:CreateWindow("Floral Hub V3") -- Creates the window

local fold = window:CreateFolder("Main") -- Creates the folder(U will put here your buttons,etc)

local function attack()
local args = {
    [1] = "attack"
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("events"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
end

flod:Toggle("Auto Attack (Click)",function(bool)
    attackk = bool
    print("Auto Attack:", attackk) --
end)

spawn(function()
 while task.wait() do
   pcall(function()
    if attackk then
       attack()
    end
end)
end
end)
fold:Label("Auto Farm",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
}) 

b:Button("Button",function()
    print("Elym Winning")
end)

local rs = game:GetService("ReplicatedStorage")
local enf = rs:WaitForChild("Assets"):WaitForChild("Enemies")

local enemyNames = {}

local function updateEnemies()
    enemyNames = {} -- มันต้องป่าววะไม่รู้
    for _, enemy in pairs(enf:GetChildren()) do
        table.insert(enemyNames, enemy.Name)
    end
end
updateEnemies()

enf.ChildAdded:Connect(updateEnemies)
enf.ChildRemoved:Connect(updateEnemies)

task.wait(1)

fold:Dropdown("Select Mob", enemyNames, true, function(selectedEnemy)
    print("Selected Mob:", selectedEnemy)
end) 



--[[
How to refresh a dropdown:
1)Create the dropdown and save it in a variable
local yourvariable = b:Dropdown("Hi",yourtable,function(a)
    print(a)
end)
2)Refresh it using the function
yourvariable:Refresh(yourtable)
How to refresh a label:
1)Create your label and save it in a variable
local yourvariable = b:Label("Pretty Useless NGL",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(69,69,69);
})
2)Refresh it using the function
yourvariable:Refresh("Hello") It will only change the text ofc
]]
