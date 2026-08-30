local Knit = require(game.ReplicatedStorage.Packages.knit)
local CharacterSelectionService = Knit:WaitForService("CharacterSelectionService")
local PlayerDataService = Knit:WaitForService("PlayerDataService")

local RoundService = Knit.CreateService {
	Name = "RoundService",
	Client = {},
}

-- Constants
local ROUND_WAIT_TIME = 10
local ROUND_DURATION = 30
local LOBBY_WAIT_TIME = 20

RoundService.Status = 0 -- 0 = lobby, 1 = ingame, 2 = survivor can open door

-- Signals accessible to clients
function RoundService.Client:GetRoundStatus()
	return RoundService.Status
end

function RoundService:startRound()
	self.Status = 1
	
	local mapLoader = require(game.ReplicatedStorage.Shared.modules.MapLoader)
	local killer = CharacterSelectionService:GetRandomKiller()
	
	local maps = game.ServerStorage.Maps:GetChildren()
	local map = maps[math.random(1, #maps)]
	local spawnpoint = mapLoader.loadMap(map.Name)
	
	self.Client:FireAllClients("RoundStarted", self.Status)
	
	for _, player in pairs(game.Players:GetPlayers()) do
		player.Team = game.Teams["ingame"]
		player:LoadCharacter()
		task.wait()
		
		if spawnpoint then
			player.Character:WaitForChild("HumanoidRootPart").CFrame = spawnpoint.CFrame + Vector3.new(0, 3, 0)
		end
		
		CharacterSelectionService:SetupPlayer(player, killer)
	end
	
	return map.Name
end

function RoundService:stopRound(mapName)
	self.Status = 0
	
	local mapLoader = require(game.ReplicatedStorage.Shared.modules.MapLoader)
	self.Client:FireAllClients("RoundEnded", self.Status)
	
	for _, player in pairs(game.Players:GetPlayers()) do
		player.Team = game.Teams["lobby"]
		player:LoadCharacter()
	end
	
	mapLoader.DestroyMap(mapName)
end

function RoundService:changeStatus(status)
	self.Status = status
	self.Client:FireAllClients("StatusChanged", status)
end

function RoundService:KnitInit()
	print("RoundService initialized")
end

function RoundService:KnitStart()
	-- Start the game loop
	task.wait(3)
	local timeToStart = os.time() + ROUND_WAIT_TIME
	local currentMap = nil
	
	while true do
		-- Broadcast time to clients
		self.Client:FireAllClients("UpdateTime", timeToStart)
		task.wait(1)
		
		if timeToStart <= os.time() then
			if self.Status == 0 then
				currentMap = self:startRound()
				timeToStart = os.time() + ROUND_DURATION
			elseif self.Status ~= 0 then
				self:stopRound(currentMap)
				timeToStart = os.time() + LOBBY_WAIT_TIME
			end
		else
			if self.Status ~= 0 then
				if math.random(0, 5) == 5 then
					self:changeStatus(math.random(1, 4))
				end
			end
		end
	end
end

return RoundService
