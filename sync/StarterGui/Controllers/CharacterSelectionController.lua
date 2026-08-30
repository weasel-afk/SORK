local Knit = require(game.ReplicatedStorage.Packages.knit)

local CharacterSelectionController = Knit.CreateController {
	Name = "CharacterSelectionController",
}

local CharacterSelectionService

function CharacterSelectionController:SelectCharacter(charType, charName)
	CharacterSelectionService:SelectCharacter(charType, charName)
end

function CharacterSelectionController:KnitInit()
	print("CharacterSelectionController initialized")
end

function CharacterSelectionController:KnitStart()
	CharacterSelectionService = Knit:WaitForService("CharacterSelectionService")
	
	-- Connect to your UI buttons here
	-- Example: GuiButton.MouseButton1Click:Connect(function()
	--     self:SelectCharacter("Survivor", "Noob")
	-- end)
	
	print("CharacterSelectionController started")
end

return CharacterSelectionController
