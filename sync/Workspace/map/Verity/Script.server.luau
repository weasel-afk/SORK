local verity_lol = script.Parent -- just for teh funny

-- Optional: Force server ownership to prevent network rubber-banding
if verity_lol:IsA("BasePart") then
	verity_lol:SetNetworkOwner(nil) 
end

while true do
	-- Multiplying by mass keeps the jump height consistent regardless of part size
	local force = Vector3.new(math.random(-500,500), math.random(-50,50), math.random(-500,500)) * verity_lol:GetMass()
	verity_lol:ApplyImpulse(force)

	task.wait(0.5)
end
