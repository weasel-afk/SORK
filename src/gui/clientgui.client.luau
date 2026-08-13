--[[ This script will handle inputs from GUI, 
and depending on what is selected will call a function to a modulescipt-
that will be able to verify actions depending on the players stats, like cash or more.]]
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

local function changeVisability(towhat)
	if towhat.Visible == true then
		towhat.Visible = false
		towhat.Interactable = false
	else
		towhat.Visible = true
		towhat.Interactable = true
	end
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