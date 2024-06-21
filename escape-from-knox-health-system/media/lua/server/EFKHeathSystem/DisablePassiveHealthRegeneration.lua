local function disablePassiveHealthRegeneration(playerIndex, player)
	local bodyDamage = player:getBodyDamage()
    bodyDamage:setStandardHealthAddition(0)
    bodyDamage:setReducedHealthAddition(0)
    bodyDamage:setSeverlyReducedHealthAddition(0)
    bodyDamage:setSleepingHealthAddition(0)
    bodyDamage:setHealthFromFood(0)
end

Events.OnCreatePlayer.Add(disablePassiveHealthRegeneration)
