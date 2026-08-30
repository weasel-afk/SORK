local Knit = require(game.ReplicatedStorage.Packages.knit)

-- Initialize player data on join
game.Players.PlayerAdded:Connect(function(plr)
	plr.Team = game.Teams.lobby

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = plr

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 1000
	coins.Parent = leaderstats
end)

-- Load all services from ServerStorage
local CharacterSelectionService = require(game.ServerStorage.Services.CharacterSelectionService)
local PlayerDataService = require(game.ServerStorage.Services.PlayerDataService)
local GameTimerService = require(game.ServerStorage.Services.GameTimerService)
local RoundService = require(game.ServerStorage.Services.RoundService)

-- Start Knit
Knit.Start():catch(function(err)
	error("Knit failed to start: " .. tostring(err))
end)

print("Main server script initialized with Knit")
