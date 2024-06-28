EFKInjectorsBodyDamageUtil = {}

function EFKInjectorsBodyDamageUtil.getDamagedBodyParts(bodyDamage)
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

function EFKInjectorsBodyDamageUtil.addHealthOnDamagedBodyParts(bodyDamage, amount)
    local damagedBodyParts = EFKInjectorsBodyDamageUtil.getDamagedBodyParts(bodyDamage)
    if #damagedBodyParts == 0 then 
        return 
    end
    for _,bodyPart in ipairs(damagedBodyParts) do
        bodyPart:AddHealth(amount)
    end
end