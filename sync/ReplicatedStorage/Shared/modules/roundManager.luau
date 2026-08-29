local roundmanager = {}
roundmanager.Status = 0
local rs = game.ReplicatedStorage
local ss = game.ServerStorage 
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
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["ingame"]
		local spawnpoint = maploader.loadMap("map")
		v:LoadCharacter()
		task.wait()
		if spawnpoint then
			v.Character:WaitForChild("HumanoidRootPart").CFrame = spawnpoint.CFrame + Vector3.new(0, 3, 0)
		end
		setPlayerUp(v, killer)
	end
end


function roundmanager.stopRound()
	roundmanager.Status = 0
	roundEndEvent:FireAllClients(roundmanager.Status)
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["lobby"]
		v:LoadCharacter()
	end
end

function roundmanager.changeStatus(status)
	roundmanager.Status = status
	RoundstartEvent:FireAllClients(status)
end

return roundmanager
--ife. I love my world. I love my universe. I love my everything. I love you all.