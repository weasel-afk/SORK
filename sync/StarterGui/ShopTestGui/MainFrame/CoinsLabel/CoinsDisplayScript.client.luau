local player = game.Players.LocalPlayer
local label = script.Parent

local function updateCoins()
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")
	if coins then
		label.Text = "Coins: " .. coins.Value
		coins.Changed:Connect(function()
			label.Text = "Coins: " .. coins.Value
		end)
	end
end

if player:FindFirstChild("leaderstats") then
	updateCoins()
else
	player.ChildAdded:Connect(function(child)
		if child.Name == "leaderstats" then
			updateCoins()
		end
	end)
end
