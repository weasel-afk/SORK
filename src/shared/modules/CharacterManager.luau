local characterManager = {}
characterManager.Survivers = {Char1 = {Name = "Noob", Health = 100, tools = "Soda"}}
characterManager.Typesofplayers = {Surviver = characterManager.Survivers, Killer = nil}
characterManager.playerCharTable = {}
local tools = game.ReplicatedStorage.tools:GetChildren()

function characterManager.ChangeChar(typee, selection, player)
	print(typee)
	if typee then
		local playerselection = characterManager.Survivers[selection]
		print(playerselection)
		print(player.Name)
		characterManager.playerCharTable[player.Name] = playerselection
		print(characterManager.playerCharTable, "table")
	else
		warn("failed!")
		print(typee)
	end-- add killer system
end

function characterManager.roundStart(player)
	for playername, selection in pairs(characterManager.playerCharTable) do
		if playername == player.Name then
			local humanoid = game.Workspace:FindFirstChild(player.Name).Humanoid
			humanoid.DisplayName = selection["Name"]
			humanoid.MaxHealth = selection["Health"]
			local toolselection = selection["tools"]
			for i,v in tools do
				if v.Name == toolselection then
					local clone = v:Clone()
					clone.Parent= player.Backpack
				end
			end
		end 
	end
end

return characterManager