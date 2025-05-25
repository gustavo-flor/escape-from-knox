EFKBodyDamageUtil = {}

function EFKBodyDamageUtil.getHeavyBleedingBodyParts(bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()
    local heavyBleedingBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        if bodyPart:bleeding() and bodyPart:deepWounded() then
            table.insert(heavyBleedingBodyParts, bodyPart)
        end
    end
    return heavyBleedingBodyParts
end

function EFKBodyDamageUtil.getDamagedBodyParts(bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()
    local damagedBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        local health = bodyPart:getHealth()
        if health > 0 and health < 100 then
            table.insert(damagedBodyParts, bodyPart)
        end
    end
    return damagedBodyParts
end

function EFKBodyDamageUtil.getFracturedBodyParts(bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()
    local fracturedBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        if bodyPart:getFractureTime() > 0 and bodyPart:getHealth() > 0 then
            table.insert(fracturedBodyParts, bodyPart)
        end
    end
    return fracturedBodyParts
end

function EFKBodyDamageUtil.getDeadBodyParts(bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()
    local deadBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        if bodyPart:getHealth() == 0 then
            table.insert(deadBodyParts, bodyPart)
        end
    end
    return deadBodyParts
end

function EFKBodyDamageUtil.addHealthOnDamagedBodyParts(bodyDamage, amount)
    local damagedBodyParts = EFKBodyDamageUtil.getDamagedBodyParts(bodyDamage)
    if #damagedBodyParts == 0 then 
        return 
    end
    for _,bodyPart in ipairs(damagedBodyParts) do
        bodyPart:AddHealth(amount)
    end
end