--[[ This script will handle inputs from GUI, 
and depending on what is selected will call a function to a modulescipt-
that will be able to verify actions depending on the players stats, like cash or more.]]
--|| a bunch of local stuff
local parent = script.Parent.Parent
local stateortime = parent.infoframe
local charframe = parent.charFrame
local rs = game.ReplicatedStorage
local re = rs.RE
local rend = re.roundEnd
local rstart = re.roundStart
local timeupdate = re.timeupdate
local showframe = parent.showframe
local button1 = showframe.button1
local button2 = showframe.button2
local select1 = charframe.Select1
local select2 = charframe.Select2
local charselect = re.CharSelect
local charactermanagermodule = require(rs.Shared.modules.CharacterManager)

local function changeVisability(towhat)
	if towhat.Visible == true then
		towhat.Visible = false
		towhat.Interactable = false
	else
		towhat.Visible = true
		towhat.Interactable = true
	end
end
local function charselectmoment(char, typeofplayer)
	charselect:FireServer(typeofplayer, char)
	print(charactermanagermodule.Typesofplayers["Surviver"])
end
button1.MouseButton1Click:Connect(function()
	changeVisability(stateortime)
end)
button2.MouseButton1Click:Connect(function()
	changeVisability(charframe)
end)
rstart.OnClientEvent:Connect(function(idk1bro1dont1ask1me)
	stateortime.state.Text = tostring(idk1bro1dont1ask1me)
end)
timeupdate.OnClientEvent:Connect(function(dih)
	stateortime.time.Text = tostring(math.round(dih-os.time()))
end)
local function chartypefindandselect(Type, Char)
	local function typefind()
		for k, v in pairs(charactermanagermodule.Typesofplayers) do
			if k == Type then
				return k
			end
		end
	end
	local function charfind()
		for k,v in pairs(charactermanagermodule.Survivers) do
			if k == Char then
				return k
			end
		end
	end
	charselectmoment(charfind(), typefind())
end

select1.MouseButton1Click:Connect(function()
	-- functions bleh and charfind are like unnessicary future proofing
	chartypefindandselect("Surviver", "Char1")
	charselectmoment("Char1", "Surviver")
	--print("yo")
end)
