local animation = script.Parent
local humanoid = script.Parent.Parent.Parent.Parent.Humanoid
local animator = humanoid.Animator
local animationTrack = animator:LoadAnimation(animation)

animationTrack:Play()