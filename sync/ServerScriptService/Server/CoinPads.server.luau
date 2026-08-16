local proximityPromptService = game:GetService("ProximityPromptService")

proximityPromptService.PromptTriggered:Connect(function(prompt, player)
	local pad = prompt.Parent
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")
	if not coins then return end

	if pad.Name == "AddCoinsPad" then
		coins.Value += 50
	elseif pad.Name == "RemoveCoinsPad" then
		coins.Value = math.max(0, coins.Value - 50)
	end
end)