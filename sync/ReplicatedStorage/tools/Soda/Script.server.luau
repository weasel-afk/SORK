local tool = script.Parent
local playersSRV = game:GetService("Players")
local player = tool.Parent.Parent
local char = game.Workspace:WaitForChild(player.Name)
print(char)
local humanoid = char:FindFirstChild("Humanoid")
print(humanoid)

function toolActivated()
	humanoid.WalkSpeed = 30
	tool.ManualActivationOnly = true
	task.wait(5)
	tool.ManualActivationOnly = false
	humanoid.WalkSpeed = 16
end

tool.Activated:Connect(toolActivated)
tool.Unequipped:Connect(function()
	humanoid.WalkSpeed = 16
end)