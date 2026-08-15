local shop = {}
local charactermanager = require(script.Parent.CharacterManager)
--[[ Add centural table that contains who owns what (later on we will add datastore managaer, 
and when its time to check if someone owns the character, 
Character manager will call a funtion in shopmanager to check if they own it)
]]
shop.OwnerLog = {}

function shop.Buy()
	
end

function shop.GetMenu() -- For when GUI requests whats in shop to make it easy to scale
	
end
return shop