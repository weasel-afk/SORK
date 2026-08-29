local roundmanager = {}
roundmanager.Status = 0
local rs = game.ReplicatedStorage
local ss = game.ServerStorage 
local maps = ss.Maps:GetChildren()
local re = rs.RE
local RoundstartEvent = re.roundStart
local roundEndEvent = re.roundEnd
local charmanager = require(rs.Shared.modules.CharacterManager)
local spawnpoint = game.Workspace:FindFirstChild("RoundSpawn")
local maploader = require(rs.Shared.modules.MapLoader)
--0 = lobby, 1 = ingame, 2 = survivor can open door
local function setPlayerUp(player, killer)
	charmanager.roundStart(player, killer)
end

function roundmanager.startRound()
	roundmanager.Status = 1
	RoundstartEvent:FireAllClients(roundmanager.Status)
	local killer = charmanager.GetKillerNumber()
	local map = math.random(1, #maps)
	map = maps[map]
	print(map)
	map = map.Name
	print(map)
	local spawnpoint = maploader.loadMap(map)
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["ingame"]
		v:LoadCharacter()
		task.wait()
		if spawnpoint then
			v.Character:WaitForChild("HumanoidRootPart").CFrame = spawnpoint.CFrame + Vector3.new(0, 3, 0)
		end
		setPlayerUp(v, killer)
	end
	return map
end


function roundmanager.stopRound(mapName)
	roundmanager.Status = 0
	roundEndEvent:FireAllClients(roundmanager.Status)
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["lobby"]
		v:LoadCharacter()
	end
	maploader.DestroyMap(mapName)
end

function roundmanager.changeStatus(status)
	roundmanager.Status = status
	RoundstartEvent:FireAllClients(status)
end

return roundmanager
--ife. I love my world. I love my universe. I love my everything. I love you all.