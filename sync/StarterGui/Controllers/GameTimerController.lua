local Knit = require(game.ReplicatedStorage.Packages.knit)

local GameTimerController = Knit.CreateController {
	Name = "GameTimerController",
}

local RoundService

function GameTimerController:KnitInit()
	print("GameTimerController initialized")
end

function GameTimerController:KnitStart()
	RoundService = Knit:WaitForService("RoundService")
	
	-- Listen for time updates from RoundService
	task.spawn(function()
		while true do
			task.wait(1)
			-- Time updates will come through RoundService.Client:FireAllClients("UpdateTime", timeToStart)
			-- You can display this in your UI here
		end
	end)
	
	print("GameTimerController started")
end

return GameTimerController
