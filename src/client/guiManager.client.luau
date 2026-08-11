local re = game.ReplicatedStorage.RE
local roundstart = re.roundStart
local roundend = re.roundEnd
local player = script.Parent.Parent.Parent

print(player)
local state = player.PlayerGui:WaitForChild("ScreenGui").Frame.state
local time = player.PlayerGui:WaitForChild("ScreenGui").Frame.time
local charFrame = player.PlayerGui:WaitForChild("ScreenGui").charFrame
charFrame.Select1.MouseButton1Click:Connect(function()
	re.CharSelect:FireServer("Surviver", "Char1") 
	-->? Point to object : Rather than having this in a string, make it point to the object for simplicity.
	charFrame.Select1.BackgroundColor3 = Color3.fromRGB(85, 255, 0)
end)

roundstart.OnClientEvent:Connect(function(status)
	print(status)
	state.Text = status
end)
roundend.OnClientEvent:Connect(function(status)
	print(status)
	state.Text = status
end)

game.ReplicatedStorage.RE.timeupdate.OnClientEvent:Connect(function(dih)
	local timetil = dih - os.time()
	local rtt = math.round(timetil)
	time.Text = rtt
	
end)