local gui = script.Parent
local frame = gui.Frame
local dark = frame.dark
local bright = frame.bright
local desaturate = frame.desaturate
local oversaturate = frame.oversaturate
local RE = game.ReplicatedStorage.RE
local postrequest = RE:WaitForChild("PostRequest")
local killerIdEvent = RE:WaitForChild("KillerId")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Disable GUI by default, enable only if local player is the killer
gui.Enabled = false
warn("[PostGui] Script loaded, LocalPlayer.UserId = " .. tostring(localPlayer.UserId) .. ", GUI started disabled")

killerIdEvent.OnClientEvent:Connect(function(killerId)
	warn("[PostGui] KillerId event received: killerId = " .. tostring(killerId) .. ", localPlayer.UserId = " .. tostring(localPlayer.UserId))
	if killerId then
		local isKiller = (localPlayer.UserId == killerId)
		warn("[PostGui] isKiller = " .. tostring(isKiller) .. ", setting gui.Enabled = " .. tostring(isKiller))
		gui.Enabled = isKiller
	else
		warn("[PostGui] killerId is nil, setting gui.Enabled = false")
		gui.Enabled = false
	end
end)

local function connectButtons(button, effect)
	button.MouseButton1Click:Connect(function()
		postrequest:FireServer(effect)
	end)
end

connectButtons(dark, "dark")
connectButtons(bright, "bright")
connectButtons(desaturate, "desaturate")
connectButtons(oversaturate, "oversaturate")
