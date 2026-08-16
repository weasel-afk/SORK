local frame = script.Parent
local tabBar = frame.TabBar
local contentHolder = frame.ContentHolder

local tabButtons = {}
for _, btn in ipairs(tabBar:GetChildren()) do
	if btn:IsA("TextButton") then
		table.insert(tabButtons, btn)
	end
end
table.sort(tabButtons, function(a, b) return a.LayoutOrder < b.LayoutOrder end)

local tabContents = {}
for _, content in ipairs(contentHolder:GetChildren()) do
	if content:IsA("ScrollingFrame") then
		table.insert(tabContents, content)
	end
end
table.sort(tabContents, function(a, b)
	local ao = tonumber(a.Name:match("(%d+)$")) or 0
	local bo = tonumber(b.Name:match("(%d+)$")) or 0
	return ao < bo
end)

local function selectTab(index)
	for i = 1, #tabContents do
		tabContents[i].Visible = (i == index)
		tabButtons[i].BackgroundColor3 = (i == index) and Color3.fromRGB(255, 221, 0) or Color3.fromRGB(50, 50, 50)
		tabButtons[i].TextColor3 = (i == index) and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(255, 255, 255)
	end
end

for index = 1, #tabButtons do
	local capturedIndex = index
	tabButtons[index].MouseButton1Click:Connect(function()
		selectTab(capturedIndex)
	end)
end

selectTab(1)

-- force the scrollbar track to always render, even with no content to scroll
for _, content in ipairs(tabContents) do
	content.AutomaticCanvasSize = Enum.AutomaticSize.None
	local layout = content:FindFirstChildOfClass("UIListLayout")
	local function updateCanvas()
		local contentHeight = layout.AbsoluteContentSize.Y + 16
		local minHeight = content.AbsoluteSize.Y + 1
		content.CanvasSize = UDim2.new(0, 0, 0, math.max(contentHeight, minHeight))
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
	content:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateCanvas)
	updateCanvas()
end