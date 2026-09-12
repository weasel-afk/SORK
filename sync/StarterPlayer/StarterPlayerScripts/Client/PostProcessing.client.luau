local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RE = ReplicatedStorage.RE
local PostProcessingCall = RE:WaitForChild("PostProcessing")

PostProcessingCall.OnClientEvent:Connect(function(Effect)
	print(Effect)
	if Effect == "dark" then
		warn("dark")
		Lighting.ClockTime = 0
	end
end)