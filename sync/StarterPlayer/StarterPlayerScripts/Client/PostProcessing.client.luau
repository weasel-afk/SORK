local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RE = ReplicatedStorage.RE
local PostProcessingCall = RE:WaitForChild("PostProcessing")
local RoundEndCall = RE:WaitForChild("roundEnd")
local previousClockTime = nil

-- Create the ColorCorrectionEffect once, keep a reference
local colorCorrection = Lighting:FindFirstChild("ColorCorrectionEffect")
if not colorCorrection then
	colorCorrection = Instance.new("ColorCorrectionEffect")
	colorCorrection.Name = "ColorCorrectionEffect"
	colorCorrection.Parent = Lighting
end

local function resetEffects()
	if previousClockTime ~= nil then
		Lighting.ClockTime = previousClockTime
		previousClockTime = nil
	end
	colorCorrection.Saturation = 0
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
		warn("bright")
		resetEffects()
	elseif Effect == "desaturate" then
		warn("desaturate")
		colorCorrection.Saturation = 0.5
	elseif Effect == "oversaturate" then
		warn("oversaturate")
		colorCorrection.Saturation = 1.5
	end
end)

RoundEndCall.OnClientEvent:Connect(resetEffects)
