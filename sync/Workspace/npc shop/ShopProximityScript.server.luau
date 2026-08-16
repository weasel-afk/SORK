local npc = script.Parent
local hitbox = npc.GlowRing.hitbox
local re = game.ReplicatedStorage.RE.ShopProximity

local near = {}

hitbox.Touched:Connect(function(hit)
	local char = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(char)
	if player and not near[player] then
		near[player] = true
		re:FireClient(player, true)
	end
end)

hitbox.TouchEnded:Connect(function(hit)
	local char = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(char)
	if player and near[player] then
		near[player] = nil
		re:FireClient(player, false)
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if near[player] then
			near[player] = nil
		end
		re:FireClient(player, false)
	end)
end)