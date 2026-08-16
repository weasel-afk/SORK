local shop = {}
-- local charactermanager = require(script.Parent.CharacterManager)
--[[ Add centural table that contains who owns what (later on we will add datastore managaer, 
and when its time to check if someone owns the character, 
Character manager will call a funtion in shopmanager to check if they own it)
]]
shop.OwnerLog = {}

shop.Items = {
	{Name = "Test", Price = 25}
}

function shop.Buy(player, charname)
	-- makeing a new list for the player if theynot having one
	local owned = shop.OwnerLog[player.UserId]
	if not owned then
		owned = {}
		shop.OwnerLog[player.UserId] = owned
	end
	if table.find(owned, charname) then
		return false
	end
	table.insert(owned, charname)
	return true
end
--test azul
function shop.DoesOwn(player, charname)
	-- it checks if chararcter is already owned
	local owned = shop.OwnerLog[player.UserId]
	if not owned then
		return false
	end
	return table.find(owned, charname) ~= nil
end

function shop.GetMenu()
	return shop.Items
end
return shop