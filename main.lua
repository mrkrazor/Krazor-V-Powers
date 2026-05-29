-- Krazor V-Powers: Final Physics Control
local LP = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Mouse = LP:GetMouse()

-- Створення фізики польоту
local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
local att = Instance.new("Attachment", root)
local lv = Instance.new("LinearVelocity", root)
lv.Attachment0 = att
lv.MaxForce = 100000
lv.VectorVelocity = Vector3.new(0, 0, 0)

-- Політ (активація)
local flying = false
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        flying = not flying
    end
end)

-- Основний цикл: політ + лазер-кіл
RS.RenderStepped:Connect(function()
    if not root then root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") return end
    
    if flying then
        local cam = workspace.CurrentCamera.CFrame.LookVector
        lv.VectorVelocity = cam * 100 -- Швидкість
    else
        lv.VectorVelocity = Vector3.new(0, 0, 0)
    end

    -- Лазер-кіл (просто пробуємо атакувати)
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local target = Mouse.Target
        if target and target.Parent:FindFirstChild("Humanoid") then
            -- Спробуймо змінити здоров'я напряму
            target.Parent.Humanoid.Health = 0 
        end
    end
end)
