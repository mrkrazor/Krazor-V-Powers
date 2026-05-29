-- Krazor Hub: Homelander Edition
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local LaserBtn = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

LaserBtn.Parent = Frame
LaserBtn.Size = UDim2.new(0, 180, 0, 40)
LaserBtn.Position = UDim2.new(0, 10, 0, 10)
LaserBtn.Text = "Laser Eyes (OFF)"

FlyBtn.Parent = Frame
FlyBtn.Size = UDim2.new(0, 180, 0, 40)
FlyBtn.Position = UDim2.new(0, 10, 0, 60)
FlyBtn.Text = "Fly (OFF)"

-- Логіка кнопок
local laserEnabled = false
LaserBtn.MouseButton1Click:Connect(function()
    laserEnabled = not laserEnabled
    LaserBtn.Text = laserEnabled and "Laser Eyes (ON)" or "Laser Eyes (OFF)"
    -- Сюди вставляєш код лазера з попереднього повідомлення
end)

local flyEnabled = false
FlyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    FlyBtn.Text = flyEnabled and "Fly (ON)" or "Fly (OFF)"
    
    local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if flyEnabled then
        hum.PlatformStand = true -- Активуємо політ
    else
        hum.PlatformStand = false -- Вимикаємо
    end
end)
