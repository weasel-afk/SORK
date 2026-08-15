local characterManager = {}
characterManager.Survivers = {Char1 = {Name = "Noob", Health = 100, tools = "Soda", Passive = "Speed", Speed = 20}, Char2 = {Name = "Poopy Man", Health = 75, Passive = "Speed", ["Speed"] = 20}}
characterManager.Typesofplayers = {Surviver = characterManager.Survivers, Killer = nil}
characterManager.playerCharTable = {}
local tools = game.ReplicatedStorage.tools
function characterManager.ChangeChar(typee, selection, player)
	print(typee)
	if typee == "Surviver" then
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

local function passiveeffectfunction(selection, passive)
	if passive == "Speed" then
		return selection
	end
end

function characterManager.roundStart(player)
	for playername, selection in pairs(characterManager.playerCharTable) do
		if playername == player.Name then
			print(selection)
			local char = game.Workspace:FindFirstChild(player.Name)
			local humanoid = char.Humanoid
			humanoid.DisplayName = selection["Name"]
			humanoid.MaxHealth = selection["Health"]
			local toolselection = selection["tools"]
			local passive = selection["Passive"]
			print(passive)
			local passiveeffect = passiveeffectfunction(selection[passive], passive)
			print(passiveeffect)  -- should be 20
			if passive == "Speed" then
				humanoid.WalkSpeed = passiveeffect
			end
			local clone = tools:FindFirstChild(toolselection)
			local cloned =clone:Clone()
			cloned.Parent = player.Backpack
		end 
	end
end
--hi
return characterManager