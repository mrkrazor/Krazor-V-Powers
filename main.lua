-- Krazor V-Powers: Professional Edition
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 220, 0, 160); Frame.Position = UDim2.new(0.5, -110, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Frame.BorderSizePixel = 0
local UICorner = Instance.new("UICorner", Frame); UICorner.CornerRadius = UDim.new(0, 8)

-- Dragging Logic
local dragging, dragInput, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Frame.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UIS.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

-- Buttons
local function createBtn(name, pos)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 200, 0, 40); btn.Position = pos; btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    return btn
end

local LaserBtn = createBtn("Laser Eyes: OFF", UDim2.new(0, 10, 0, 10))
local FlyBtn = createBtn("Flight: OFF", UDim2.new(0, 10, 0, 60))

-- Logic
local laserOn, flyOn = false, false
local beam, att0, att1, bv

LaserBtn.MouseButton1Click:Connect(function()
    laserOn = not laserOn
    LaserBtn.Text = laserOn and "Laser Eyes: ON" or "Laser Eyes: OFF"
    if laserOn then
        att0 = Instance.new("Attachment", LP.Character.Head)
        att1 = Instance.new("Attachment", workspace.Terrain)
        beam = Instance.new("Beam", workspace.Terrain)
        beam.Attachment0 = att0; beam.Attachment1 = att1; beam.Color = ColorSequence.new(Color3.new(1,0,0))
    else
        if beam then beam:Destroy(); att0:Destroy(); att1:Destroy() end
    end
end)

FlyBtn.MouseButton1Click:Connect(function()
    flyOn = not flyOn
    FlyBtn.Text = flyOn and "Flight: ON" or "Flight: OFF"
    if flyOn then
        bv = Instance.new("BodyVelocity", LP.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    else
        if bv then bv:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    if laserOn and LP.Character and LP.Character:FindFirstChild("Head") then
        att1.WorldPosition = Mouse.Hit.Position
    end
    if flyOn and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60
    end
end)
