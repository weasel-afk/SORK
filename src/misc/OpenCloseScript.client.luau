local re = game.ReplicatedStorage.RE.ShopProximity
local gui = script.Parent

re.OnClientEvent:Connect(function(isopen)
	gui.Enabled = isopen
end)