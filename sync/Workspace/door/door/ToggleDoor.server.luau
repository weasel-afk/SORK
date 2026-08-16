local tweenservice = game:GetService("TweenService")
local roundmanager = require(game.ReplicatedStorage.Shared.modules.roundManager)
local doorpart = script.Parent
local hingeside = -1
local halfwidth = doorpart.Size.X / 2
local closedcframe = doorpart.CFrame
local hingepos = closedcframe:PointToWorldSpace(Vector3.new(hingeside * halfwidth, 0, 0))
local isopen = false
local isanimating = false
local clickdetector = Instance.new("ClickDetector")
local characterManager = require(game.ReplicatedStorage.Shared.modules.CharacterManager)

clickdetector.MaxActivationDistance = 15
clickdetector.Parent = doorpart
--sigma
local anglevalue = Instance.new("NumberValue")
anglevalue.Changed:Connect(function(theta)
	local hingecframe = CFrame.new(hingepos)
	doorpart.CFrame = hingecframe * CFrame.Angles(0, math.rad(theta), 0) * hingecframe:Inverse() * closedcframe
end)

clickdetector.MouseClick:Connect(function(player)
	if characterManager.playerCharTable[player.UserId] ~= "Char1" or "Char2" and roundmanager.Status ~= 2 then return end
	if isanimating then return end
	isanimating = true
	local target = isopen and 0 or 90
	local tween = tweenservice:Create(anglevalue, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = target})
	tween.Completed:Once(function()
		isanimating = false
		isopen = not isopen
	end)
	tween:Play()
end)