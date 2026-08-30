local Knit = require(game.ReplicatedStorage.Packages.knit)

local PlayerDataService = Knit.CreateService {
	Name = "PlayerDataService",
	Client = {},
}

local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData_v1")
local ShopManager = require(game.ReplicatedStorage.Shared.modules.ShopManager)

function PlayerDataService.Client:GetCoins(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local coins = leaderstats:FindFirstChild("Coins")
		if coins then
			return coins.Value
		end
	end
	return 0
end

function PlayerDataService:LoadPlayerData(player)
	local success, data = pcall(function()
		return playerDataStore:GetAsync("Player_" .. player.UserId)
	end)
	
	if success and data then
		return data
	end
	
	return { Coins = 0, Owned = {} }
end

function PlayerDataService:SavePlayerData(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")
	local coinsValue = coins and coins.Value or 0
	local owned = ShopManager.OwnerLog[player.UserId] or {}
	local data = { Coins = coinsValue, Owned = owned }
	
	local success, err = pcall(function()
		playerDataStore:SetAsync("Player_" .. player.UserId, data)
	end)
	
	if not success then
		warn("Failed to save data for " .. player.Name .. ": " .. tostring(err))
	end
end

function PlayerDataService:KnitInit()
	print("PlayerDataService initialized")
end

function PlayerDataService:KnitStart()
	local Players = game:GetService("Players")
	
	Players.PlayerAdded:Connect(function(player)
		task.spawn(function()
			local leaderstats = player:WaitForChild("leaderstats")
			local coins = leaderstats:WaitForChild("Coins")
			local data = self:LoadPlayerData(player)
			coins.Value = data.Coins
			ShopManager.OwnerLog[player.UserId] = data.Owned
		end)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:SavePlayerData(player)
	end)
	
	game:BindToClose(function()
		for _, player in ipairs(Players:GetPlayers()) do
			self:SavePlayerData(player)
		end
	end)
	
	print("PlayerDataService started")
end

return PlayerDataService
