local Knit = require(game.ReplicatedStorage.Packages.knit)
local ShopManager = require(game.ReplicatedStorage.Shared.modules.ShopManager)

local CharacterSelectionService = Knit.CreateService {
	Name = "CharacterSelectionService",
	Client = {},
}

CharacterSelectionService.playerCharTable = {}
CharacterSelectionService.playerKillTable = {}

function CharacterSelectionService.Client:SelectCharacter(player, charType, charName)
	CharacterSelectionService:ChangeCharacter(player, charType, charName)
end

function CharacterSelectionService:ChangeCharacter(player, charType, charName)
	if charType == "Survivor" then
		local characterManager = require(game.ReplicatedStorage.Shared.modules.CharacterManager)
		local playerSelection = characterManager.Survivers[charName]
		
		if not playerSelection then
			warn("Character not found: " .. charName)
			return false
		end
		
		if not ShopManager.DoesOwn(player, playerSelection) then
			warn(player.Name .. " does not own " .. charName)
			return false
		end
		
		self.playerCharTable[player.UserId] = playerSelection
		return true
		
	elseif charType == "Killer" then
		local characterManager = require(game.ReplicatedStorage.Shared.modules.CharacterManager)
		local playerSelection = characterManager.Killers[charName]
		
		if not playerSelection then
			warn("Killer not found: " .. charName)
			return false
		end
		
		if not ShopManager.DoesOwn(player, playerSelection) then
			warn(player.Name .. " does not own " .. charName)
			return false
		end
		
		self.playerKillTable[player.UserId] = playerSelection
		return true
	end
	
	return false
end

function CharacterSelectionService:GetRandomKiller()
	local Players = game:GetService("Players")
	local killerUserIds = {}
	
	for _, player in ipairs(Players:GetPlayers()) do
		if self.playerKillTable[player.UserId] then
			table.insert(killerUserIds, player.UserId)
		end
	end
	
	if #killerUserIds == 0 then
		return nil
	end
	return killerUserIds[math.random(1, #killerUserIds)]
end

function CharacterSelectionService:SetupPlayer(player, killerUserId)
	local characterManager = require(game.ReplicatedStorage.Shared.modules.CharacterManager)
	
	local selection = self.playerCharTable[player.UserId]
	local killerSelection = self.playerKillTable[player.UserId]
	local char = player.Character
	
	if not char then
		warn("Character is nil for " .. player.Name)
		return
	end
	
	local humanoid = char:FindFirstChild("Humanoid")
	if not humanoid then
		warn("Humanoid not found for " .. player.Name)
		return
	end
	
	if player.UserId == killerUserId then
		characterManager.roundStart(player, killerUserId)
	else
		if selection then
			characterManager.roundStart(player, killerUserId)
		end
	end
end

function CharacterSelectionService:CleanupPlayer(player)
	self.playerCharTable[player.UserId] = nil
	self.playerKillTable[player.UserId] = nil
end

function CharacterSelectionService:KnitInit()
	print("CharacterSelectionService initialized")
end

function CharacterSelectionService:KnitStart()
	-- Listen for character selections from clients
	local Players = game:GetService("Players")
	
	Players.PlayerRemoving:Connect(function(player)
		self:CleanupPlayer(player)
	end)
	
	print("CharacterSelectionService started")
end

return CharacterSelectionService
