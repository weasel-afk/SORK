local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData_v1")
local shop = require(game.ReplicatedStorage.Shared.modules.ShopManager)

local function loadData(player)
	local success, data = pcall(function()
		return playerDataStore:GetAsync("Player_" .. player.UserId)
	end)
	if success and data then
		return data
	end
	return { Coins = 0, Owned = {} }
end

local function saveData(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")
	local coinsValue = coins and coins.Value or 0
	local owned = shop.OwnerLog[player.UserId] or {}
	local data = { Coins = coinsValue, Owned = owned }

	local success, err = pcall(function()
		playerDataStore:SetAsync("Player_" .. player.UserId, data)
	end)
	if not success then
		warn("failed to save data for " .. player.Name .. ": " .. tostring(err))
	end
end

game.Players.PlayerAdded:Connect(function(player)
	task.spawn(function()
		local leaderstats = player:WaitForChild("leaderstats")
		local coins = leaderstats:WaitForChild("Coins")
		local data = loadData(player)
		coins.Value = data.Coins
		shop.OwnerLog[player.UserId] = data.Owned
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	saveData(player)
end)

game:BindToClose(function()
	for _, player in ipairs(game.Players:GetPlayers()) do
		saveData(player)
	end
end)
