local roundmanager = {}

roundmanager.Status = 0
local rs = game.ReplicatedStorage
local re = rs.RE
local RoundstartEvent = re.roundStart
local roundEndEvent = re.roundEnd
local charmanager = require(rs.Shared.modules.CharacterManager)
local spawnpoint = game.Workspace:FindFirstChild("RoundSpawn")
--0 = lobby, 1 = ingame, 2 = survivor can open door
local function setPlayerUp(player)
	charmanager.roundStart(player)
end

function roundmanager.startRound()
	roundmanager.Status = 1
	RoundstartEvent:FireAllClients(roundmanager.Status)
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["ingame"]
		v:LoadCharacter()
		if spawnpoint then
			v.Character:WaitForChild("HumanoidRootPart").CFrame = spawnpoint.CFrame + Vector3.new(0, 3, 0)
		end
		setPlayerUp(v)
		print(v.Team)
	end
end


function roundmanager.stopRound()
	roundmanager.Status = 0
	roundEndEvent:FireAllClients(roundmanager.Status)
	for i, v in pairs(game.Players:GetChildren()) do
		v.Team = game.Teams["lobby"]
		v:LoadCharacter()
		print(v.Team)
	end
end

function roundmanager.changeStatus(status)
	roundmanager.Status = status
	RoundstartEvent:FireAllClients(status)
end

return roundmanager
--ife. I love my world. I love my universe. I love my everything. I love you all.