local PostManager = {}

local rs = game.ReplicatedStorage
local modules = rs.Shared.modules
local roundmanager = require(modules.roundManager)

function PostManager.PostRequestCheck(player)
	local KillerId = roundmanager.KillerId
	local UserId = player.UserId
	if roundmanager.Status ~= 0 and KillerId == UserId then
		return true
	else
		return false
	end
end


return PostManager
