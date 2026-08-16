local model = script.Parent
local center = model:GetPivot().Position
--mister yearst go flying
while true do
	local targetPos = center + Vector3.new(
		math.random(-40, 40),
		math.random(0, 40),
		math.random(-40, 40)
	)
	local randomRot = CFrame.Angles(
		math.random(0, 628) / 100,
		math.random(0, 628) / 100,
		math.random(0, 628) / 100
	)

	local startCFrame = model:GetPivot()
	local goalCFrame = CFrame.new(targetPos) * randomRot

	local steps = 15
	for i = 1, steps do
		local alpha = i / steps
		model:PivotTo(startCFrame:Lerp(goalCFrame, alpha))
		task.wait(0.02)
	end
end
