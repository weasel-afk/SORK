local Maploader = {}

local ss = game.ServerStorage
local maps = ss.Maps
function Maploader.loadMap(mapName)
	local map = maps:FindFirstChild(mapName)
	if map then
		local MapClone = map:Clone()
		MapClone.Parent = game.Workspace
		local target = game.Workspace.MapPoint.CFrame
		MapClone:PivotTo(target)
		if not MapClone.RoundSpawn then
			return
		end
		local roundspawn = MapClone.RoundSpawn
		local killerSpawn = MapClone.KillerSpawn
		return roundspawn
	end
	return false
end

function Maploader.DestroyMap(mapName)
	local map = game.Workspace:FindFirstChild(mapName)
	if map then
		map:Destroy()
	end
end

return Maploader
