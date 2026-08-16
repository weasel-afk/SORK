local characterManager = {}
characterManager.Survivers = {Char1 = {Name = "Noob", Health = 100, tools = "Soda", Passive = "Speed", Speed = 20}, Char2 = {Name = "Poopy Man", Health = 75, Passive = "Speed", Speed = 20}} -- char2 has no tools field, may cause issues
-- I know it doesnt have a tool field. i bet ai told you about that.
characterManager.Typesofplayers = {Surviver = characterManager.Survivers, Killer = nil}
characterManager.playerCharTable = {}
local tools = game.ReplicatedStorage.tools
function characterManager.ChangeChar(SORK, selection, player) --SORK means survivers or killer
	if SORK == "Surviver" then
		local playerselection = characterManager.Survivers[selection]
		if not playerselection then return end
		characterManager.playerCharTable[player.UserId] = playerselection
	else
	end-- add killer system
end

local function passiveeffectfunction(selection, passive)
	if passive == "Speed" then
		return selection
	end
	return nil
end

function characterManager.roundStart(player)
	if not player then return end
	local selection = characterManager.playerCharTable[player.UserId]
	if not selection then return end
	local Char = player.Character
	if not Char then return end
	local Humanoid = Char.Humanoid
	if not Humanoid then return end
	Humanoid.DisplayName = selection["Name"]
	Humanoid.MaxHealth = selection["Health"]
	local toolselection = selection["tools"]
	local passive = selection["Passive"]
	local passiveeffect = passiveeffectfunction(selection[passive], passive)
	if passive == "Speed" then
		Humanoid.WalkSpeed = passiveeffect
	end
	local clone = tools:FindFirstChild(toolselection)
	if not clone then return end
	local cloned = clone:Clone()
	cloned.Parent = player.Backpack
end

return characterManager
