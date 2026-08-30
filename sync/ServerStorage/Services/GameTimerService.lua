local Knit = require(game.ReplicatedStorage.Packages.knit)

local GameTimerService = Knit.CreateService {
	Name = "GameTimerService",
	Client = {},
}

function GameTimerService:KnitInit()
	print("GameTimerService initialized")
end

function GameTimerService:KnitStart()
	print("GameTimerService started")
end

return GameTimerService
