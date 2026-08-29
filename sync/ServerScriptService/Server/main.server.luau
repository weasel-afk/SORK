game.Players.PlayerAdded:Connect(function(plr)
	plr.Team = game.Teams.lobby

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = plr

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 1000
	coins.Parent = leaderstats
end)

task.wait(3) -- just because ui shows like 3 seconds early, maybe bc of initialization?
local TimeToStart = os.time() + 10
local modulesRS = game.ReplicatedStorage.Shared.modules
local charactermanager = require(modulesRS.CharacterManager)
local re = game.ReplicatedStorage.RE
local timeupdate = re.timeupdate
local maploader = require(modulesRS.MapLoader)
local roundManager = require(modulesRS.roundManager)
re.CharSelect.OnServerEvent:Connect(function(player, s1or1k, char)
	charactermanager.ChangeChar(s1or1k, char, player)
end)
local map = nil

while true do -- just like brod cast uh time till start / end yk
	timeupdate:FireAllClients(TimeToStart)
	task.wait(1)
	if TimeToStart <= os.time() then
		if roundManager.Status == 0 then
			map = roundManager.startRound()
			TimeToStart = os.time() + 30
		elseif roundManager.Status ~= 0 then
			roundManager.stopRound(map)
			TimeToStart = os.time() + 20
		end
	else
		if roundManager.Status ~= 0 then
			if math.random(0, 5) == 5 then
				roundManager.changeStatus(math.random(1, 4))
			end
		end
	end
end
