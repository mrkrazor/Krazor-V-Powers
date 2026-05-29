-- Krazor V-Powers: KILL MODE
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local char = LP.Character or LP.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- 1. Створення лазерів (два парти)
local function createPart()
    local p = Instance.new("Part", workspace); p.Size = Vector3.new(0.5, 0.5, 50); p.Anchored = true; p.CanCollide = false
    p.Color = Color3.new(1, 0, 0); p.Material = Enum.Material.Neon
    return p
end
local laser1, laser2 = createPart(), createPart()

-- 2. Функція вбивства (Шукаємо RemoteEvent автоматично)
local function killPlayer(target)
    for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("damage") or v.Name:lower():find("hit")) then
            v:FireServer(target) -- Спроба нанести урон
        end
    end
end

-- 3. Основний цикл: Лазери + Кілл
RS.RenderStepped:Connect(function()
    if not char:FindFirstChild("Head") then return end
    local headPos = char.Head.Position
    
    -- Наведення лазерів (два парти)
    local targetPos = LP:GetMouse().Hit.Position
    laser1.CFrame = CFrame.new(headPos + Vector3.new(0.5, 0, 0), targetPos) * CFrame.new(0, 0, -25)
    laser2.CFrame = CFrame.new(headPos + Vector3.new(-0.5, 0, 0), targetPos) * CFrame.new(0, 0, -25)
    
    -- Перевірка на вбивство (дистанція до гравців)
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - targetPos).Magnitude
            if dist < 5 then -- Якщо приціл на гравцеві
                killPlayer(plr.Character)
            end
        end
    end
end)
