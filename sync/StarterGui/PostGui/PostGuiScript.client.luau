local gui = script.Parent
local dark = gui.Frame.dark
local bright = gui.Frame.bright
local postrequest = game.ReplicatedStorage.RE:WaitForChild("PostRequest")

dark.MouseButton1Click:Connect(function()
	postrequest:FireServer("dark")
end)

bright.MouseButton1Click:Connect(function()
	
end)