local RunService = game:GetService("RunService") --hehehe
local Camera = workspace.CurrentCamera
local TargetPart = game.Workspace.map:WaitForChild("Verity") -- Replace with your target object

-- Lock the camera so default player controls don't override it
Camera.CameraType = Enum.CameraType.Scriptable

-- Continuously update the camera position/orientation every frame
RunService.RenderStepped:Connect(function()
	-- Keeps the camera at its current position, but rotates it to face the target part
	Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, TargetPart.Position)
end)
