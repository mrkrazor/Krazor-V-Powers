-- Krazor V-Powers GUI: Full Control
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")

-- Створюємо GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150); Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(0, 0, 0); Frame.Active = true; Frame.Draggable = true

local FlyBtn = Instance.new("TextButton", Frame)
FlyBtn.Size = UDim2.new(1, 0, 0, 50); FlyBtn.Text = "FLY (E to Toggle)"
FlyBtn.MouseButton1Click:Connect(function() flyEnabled = not flyEnabled end)

local LaserBtn = Instance.new("TextButton", Frame); LaserBtn.Position = UDim2.new(0, 0, 0, 60)
LaserBtn.Size = UDim2.new(1, 0, 0, 50); LaserBtn.Text = "LASER ON"

-- Фізика
local bodyVel = Instance.new("BodyVelocity")
bodyVel.MaxForce = Vector3.new(1/0, 1/0, 1/0)
flyEnabled = false

game:GetService("RunService").RenderStepped:Connect(function()
    if flyEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        bodyVel.Parent = LP.Character.HumanoidRootPart
        bodyVel.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
    else
        bodyVel.Parent = nil
    end
end)
