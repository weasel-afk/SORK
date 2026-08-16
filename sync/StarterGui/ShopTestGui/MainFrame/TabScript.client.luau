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

table.sort(tabContents, function(frameA, frameB)
	local frameAOrder = tonumber(frameA.Name:match("(%d+)$")) or 0
	local frameBOrder = tonumber(frameB.Name:match("(%d+)$")) or 0
	return frameAOrder < frameBOrder
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

-- build a card for every item in ShopManager.Items automatically
local shop = require(game.ReplicatedStorage.Shared.modules.ShopManager)
local charactersTab = contentHolder:FindFirstChild("CharactersContent1")

local oldCard = charactersTab:FindFirstChildOfClass("Frame")
if oldCard then
	oldCard:Destroy()
end

for _, item in ipairs(shop.Items) do
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0, 170, 0, 150)
	card.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	card.Parent = charactersTab

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 10)
	cardCorner.Parent = card

	local itemName = Instance.new("TextLabel")
	itemName.Size = UDim2.new(1, 0, 0, 30)
	itemName.Position = UDim2.new(0, 0, 0, 10)
	itemName.BackgroundTransparency = 1
	itemName.Text = item.Name
	itemName.TextColor3 = Color3.fromRGB(255, 255, 255)
	itemName.TextScaled = true
	itemName.Font = Enum.Font.GothamBold
	itemName.Parent = card

	local itemPrice = Instance.new("TextLabel")
	itemPrice.Size = UDim2.new(1, 0, 0, 24)
	itemPrice.Position = UDim2.new(0, 0, 0, 42)
	itemPrice.BackgroundTransparency = 1
	itemPrice.Text = item.Price .. " Coins"
	itemPrice.TextColor3 = Color3.fromRGB(255, 221, 0)
	itemPrice.TextScaled = true
	itemPrice.Font = Enum.Font.Gotham
	itemPrice.Parent = card

	local descButton = Instance.new("TextButton")
	descButton.Size = UDim2.new(1, -20, 0, 32)
	descButton.Position = UDim2.new(0, 10, 0, 70)
	descButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	descButton.Text = "Description"
	descButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	descButton.TextScaled = true
	descButton.Font = Enum.Font.Gotham
	descButton.Parent = card

	local descCorner = Instance.new("UICorner")
	descCorner.CornerRadius = UDim.new(0, 8)
	descCorner.Parent = descButton

	local buyButton = Instance.new("TextButton")
	buyButton.Size = UDim2.new(1, -20, 0, 32)
	buyButton.Position = UDim2.new(0, 10, 0, 104)
	buyButton.BackgroundColor3 = Color3.fromRGB(255, 221, 0)
	buyButton.Text = "Buy"
	buyButton.TextColor3 = Color3.fromRGB(30, 30, 30)
	buyButton.TextScaled = true
	buyButton.Font = Enum.Font.GothamBold
	buyButton.Parent = card

	local buyCorner = Instance.new("UICorner")
	buyCorner.CornerRadius = UDim.new(0, 8)
	buyCorner.Parent = buyButton
end

for _, content in ipairs(tabContents) do
	content.AutomaticCanvasSize = Enum.AutomaticSize.None
	local layout = content:FindFirstChildWhichIsA("UIGridStyleLayout")
	local function updateCanvas()
		local contentHeight = layout.AbsoluteContentSize.Y + 16
		local minHeight = content.AbsoluteSize.Y + 1
		content.CanvasSize = UDim2.new(0, 0, 0, math.max(contentHeight, minHeight))
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
	content:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateCanvas)
	updateCanvas()
end