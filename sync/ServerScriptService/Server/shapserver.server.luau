local shop = require(game.ReplicatedStorage.Shared.modules.ShopManager)
local buyItem = game.ReplicatedStorage.RE.BuyItem
local buyResult = game.ReplicatedStorage.RE.BuyResult

local function findItem(itemName)
	for _, item in ipairs(shop.Items) do
		if item.Name == itemName then
			return item
		end
	end
	return nil
end

buyItem.OnServerEvent:Connect(function(player, itemName)
	local item = findItem(itemName)
	if not item then
		buyResult:FireClient(player, itemName, false, "item doesnt exist")
		return
	end

	if shop.DoesOwn(player, itemName) then
		buyResult:FireClient(player, itemName, false, "already owned")
		return
	end

	local leaderstats = player:FindFirstChild("leaderstats")
	local coins = leaderstats and leaderstats:FindFirstChild("Coins")
	if not coins then
		buyResult:FireClient(player, itemName, false, "no coins found")
		return
	end

	if coins.Value < item.Price then
		buyResult:FireClient(player, itemName, false, "not enough coins")
		return
	end

	coins.Value -= item.Price
	shop.Buy(player, itemName)
	buyResult:FireClient(player, itemName, true, "bought")
end)