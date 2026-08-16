--[[ This script will handle inputs from GUI, 
and depending on what is selected will call a function to a modulescipt-
that will be able to verify actions depending on the players stats, like cash or more.]]
--|| a bunch of local stuff
local parent = script.Parent.Parent
local stateortime = parent.infoframe
local charframe = parent.charFrame
local rs = game.ReplicatedStorage
local re = rs.RE
local rend = re.roundEnd -- never listened to below, state label wont update when round ends
local rstart = re.roundStart
local timeupdate = re.timeupdate
local showframe = parent.showframe
local button1 = showframe.button1
local button2 = showframe.button2
local select1 = charframe.Select1
local select2 = charframe.Select2 -- no click handler wired up below, button does nothing rn
local charselect = re.CharSelect
local charactermanagermodule = require(rs.Shared.modules.CharacterManager)

local function changeVisability(towhat)
	towhat.Visible = not towhat.Visible
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
timeupdate.OnClientEvent:Connect(function(TimeToStart)
	stateortime.time.Text = tostring(math.round(TimeToStart-os.time()))
end)

select1.MouseButton1Click:Connect(function()
	-- functions bleh and charfind are like unnessicary future proofing
	charselectmoment("Char1", "Surviver")
	--print("yo")
end)
select2.MouseButton1Click:Connect(function()
	charselectmoment("Char2", "Surviver")
end)