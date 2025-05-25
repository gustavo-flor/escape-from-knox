EFKCharacterUtil = {}

function EFKCharacterUtil.addThirst(character, amount)
    character:getStats():setThirst(character:getStats():getThirst() + amount)
end

function EFKCharacterUtil.addHunger(character, amount)
    character:getStats():setHunger(character:getStats():getHunger() + amount)
end
