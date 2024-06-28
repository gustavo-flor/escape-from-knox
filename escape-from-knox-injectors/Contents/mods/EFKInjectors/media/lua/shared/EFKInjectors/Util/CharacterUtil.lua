EFKInjectorsCharacterUtil = {}

function EFKInjectorsCharacterUtil.addThirst(character, amount)
    character:getStats():setThirst(character:getStats():getThirst() + amount)
end

function EFKInjectorsCharacterUtil.addHunger(character, amount)
    character:getStats():setHunger(character:getStats():getHunger() + amount)
end
