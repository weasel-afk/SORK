local Knit = require(game.ReplicatedStorage.Packages.knit)

-- Load all controllers
local GameTimerController = require(script.Parent.Controllers.GameTimerController)
local CharacterSelectionController = require(script.Parent.Controllers.CharacterSelectionController)

-- Start Knit on client
Knit.Start():catch(function(err)
	error("Knit failed to start on client: " .. tostring(err))
end)

print("Client Knit initialized")