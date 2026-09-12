local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RE = ReplicatedStorage.RE
local PostProcessingCall = RE:WaitForChild("PostProcessing")
local RoundEndCall = RE:WaitForChild("roundEnd")
local previousClockTime = nil

local function restoreClockTime()
	if previousClockTime ~= nil then
		Lighting.ClockTime = previousClockTime
		previousClockTime = nil
	end
end

PostProcessingCall.OnClientEvent:Connect(function(Effect)
	print(Effect)
	if Effect == "dark" then
		warn("dark")
		if previousClockTime == nil then
			previousClockTime = Lighting.ClockTime
		end
		Lighting.ClockTime = 0
	elseif Effect == "bright" then
		restoreClockTime()
	end
end)

RoundEndCall.OnClientEvent:Connect(restoreClockTime)
