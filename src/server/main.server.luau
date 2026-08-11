game.Players.PlayerAdded:Connect(function(plr)
plr.Team = game.Teams.lobby
end)
local dih = os.time() + 5
local modulesRS = game.ReplicatedStorage.Shared.modules
local charactermanager = require(modulesRS.CharacterManager)
local re = game.ReplicatedStorage.RE
local timeupdate = re.timeupdate
re.CharSelect.OnServerEvent:Connect(function(player, sork, char) 
	-->> Security : This, since it came from a client, can be changed by the client to be incorecct. Make a sanity check to confim they own it.
	charactermanager.ChangeChar(sork, char, player)
end)
local roundManager = require(modulesRS.roundManager)

while true do-- just like brod cast uh time till start / end yk
	timeupdate:FireAllClients(dih)
	task.wait(1)
	if dih <= os.time() then
		if roundManager.Status == 0 then
			roundManager.startRound()
			dih = os.time() + 5
		elseif roundManager.Status ~= 0 then
			roundManager.stopRound()
			dih = os.time() + 5
		end
	end
end
--[[task.wait(5)

task.wait(5)
roundManager.stopRound()
print("round stop")]]