game.Players.PlayerAdded:Connect(function(plr)
plr.Team = game.Teams.lobby
end)
task.wait(3) -- just because ui shows like 3 seconds early, maybe bc of initialization?
local dih = os.time() + 10
local modulesRS = game.ReplicatedStorage.Shared.modules
local charactermanager = require(modulesRS.CharacterManager)
local re = game.ReplicatedStorage.RE
local timeupdate = re.timeupdate
re.CharSelect.OnServerEvent:Connect(function(player, s1or1k, char) 
	-->> Security : This, since it came from a client, can be changed by the client to be incorecct. Make a sanity check to confim they own it.
	charactermanager.ChangeChar(s1or1k, char, player)
end)
local roundManager = require(modulesRS.roundManager)

while true do-- just like brod cast uh time till start / end yk
	timeupdate:FireAllClients(dih)
	task.wait(1)
	if dih <= os.time() then
		if roundManager.Status == 0 then
			roundManager.startRound()
			dih = os.time() + 10
		elseif roundManager.Status ~= 0 then
			roundManager.stopRound()
			dih = os.time() + 10
		end
	end
end
--[[task.wait(5)

task.wait(5)
roundManager.stopRound()
print("round stop")]]