-- Krazor V-Powers: Hardcore Edition
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Mouse = LP:GetMouse()

local flyActive = false
local function findDamageEvent()
    for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("damage") or v.Name:lower():find("hit")) then return v end
    end
end
local damageEvent = findDamageEvent()

-- Управління польотом (через CFrame, ігнорує гравітацію)
RS.RenderStepped:Connect(function()
    local char = LP.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    
    if flyActive then
        local cam = workspace.CurrentCamera.CFrame
        hrp.CFrame = hrp.CFrame + (cam.LookVector * 2) -- Швидкість
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) -- Обнуляємо гравітацію
    end
end)

-- Управління лазером та вбивством
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.E then flyActive = not flyActive end -- Натисни E для польоту
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if damageEvent and Mouse.Target and Mouse.Target.Parent:FindFirstChild("Humanoid") then
            damageEvent:FireServer(Mouse.Target.Parent) -- Кілл
        end
    end
end)
