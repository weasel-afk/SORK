local Knit = require(game.ReplicatedStorage.Packages.knit)

local GameTimerService = Knit.CreateService {
	Name = "GameTimerService",
	Client = {},
}

function GameTimerService.Client:OnTimeUpdate(player, callback)
	-- Client will receive time updates via the signal below
end

function GameTimerService:KnitInit()
	print("GameTimerService initialized")
end

function GameTimerService:KnitStart()
	print("GameTimerService started")
end

return GameTimerService
