CharacterUtil = {}

function CharacterUtil.addThirst(character, amount)
    character:getStats():setThirst(character:getStats():getThirst() + amount)
end

function CharacterUtil.addHunger(character, amount)
    character:getStats():setHunger(character:getStats():getHunger() + amount)
end
