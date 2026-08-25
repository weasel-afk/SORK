local characterManager = {}
characterManager.Survivers = {Char1 = {Name = "Noob", Health = 100, tools = "Soda"}, Char2 = {Name = "Pro", Health = 75, Passive = "Speed", Speed = 18}} -- char2 has no tools field, may cause issues
-- I know it doesnt have a tool field. i bet ai told you about that.
characterManager.Typesofplayers = {Surviver = characterManager.Survivers, Killer = nil}
characterManager.Killers = {Killer1 = {Name = "Sword Man", Health = 500, tools = "ClassicSword"}}
local shopManager =require(game.ReplicatedStorage.Shared.modules.ShopManager) 
characterManager.playerCharTable = {}
characterManager.playerKillTable = {} -- This is the killer equvialnt of playerCharTable, so that both characters can be stored
local tools = game.ReplicatedStorage.tools
function characterManager.ChangeChar(SORK, selection, player) --SORK means survivers or killer
	if SORK == "Surviver" then
		local playerselection = characterManager.Survivers[selection]
		if not playerselection then return end
		if shopManager.DoesOwn(player, playerselection) ~= true then return
		end
		characterManager.playerCharTable[player.UserId] = playerselection
	elseif SORK == "Killer" then
		local playerselection = characterManager.Killers[selection]
		if not playerselection then warn("nope :(") return end
		if shopManager.DoesOwn(player, playerselection) ~= true then print("rin tin tin") return
		end
		characterManager.playerKillTable[player.UserId] = playerselection
	end
end

local function passiveeffectfunction(selection, passive)
	if passive == "Speed" then
		return selection
	end
	return nil
end

local function ifnotthen(table)
	for k, v in pairs(table) do
		if not v then
			return false
		end
	end
	return true
end

local Players = game:GetService("Players")

function characterManager.GetKillerNumber()
	local killerUserIds = {}

	for _, player in ipairs(Players:GetPlayers()) do
		if characterManager.playerKillTable[player.UserId] then
			table.insert(killerUserIds, player.UserId)
		end
	end
	
	if #killerUserIds == 0 then
		return nil
	end
	return killerUserIds[math.random(1, #killerUserIds)]
end

local function tool(selection, player)
	local toolselection = selection["tools"]
	if not toolselection then return end
	local clone = tools:FindFirstChild(toolselection)
	if not clone then return end
	local cloned = clone:Clone()
	cloned.Parent = player.Backpack
end

function characterManager.roundStart(player, killer)
	local selection = characterManager.playerCharTable[player.UserId]
	local KillerSelection = characterManager.playerKillTable[player.UserId]
	local Char = player.Character
	local Humanoid = Char.Humanoid
	if not ifnotthen({selection, KillerSelection, Char, Humanoid}) then -- top ten most innovative things in diddys life:
		warn(" is nil and cannot move on") -- shh dont tell anyone but this doesnt really work
		return -- 🤫🤫🤫🤫🤫🤫🤫
	end
	if player.UserId == killer then
		warn("bro is killa")
		Humanoid.DisplayName = KillerSelection["Name"]
		Humanoid.MaxHealth = KillerSelection["Health"]
		Humanoid.Health = KillerSelection["Health"]
		local passive = KillerSelection["Passive"]
		local passiveeffect = passiveeffectfunction(KillerSelection[passive], passive)
		if passive == "Speed" then
			Humanoid.WalkSpeed = passiveeffect
		end
		tool(KillerSelection, player)
	else
		warn("nah bro aint lucky")
		Humanoid.DisplayName = selection["Name"]
		Humanoid.MaxHealth = selection["Health"]
		Humanoid.Health = selection["Health"]
		local passive = selection["Passive"]
		local passiveeffect = passiveeffectfunction(selection[passive], passive)
		if passive == "Speed" then
			Humanoid.WalkSpeed = passiveeffect
		end
		tool(selection, player)
	end
end

return characterManager
