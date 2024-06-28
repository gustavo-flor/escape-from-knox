EFKHealthSystemBodyDamageUtil = {}

function EFKHealthSystemBodyDamageUtil.getDeadLowerBodyParts(bodyDamage)
    local bodyParts = bodyDamage:getBodyParts()
    local deadLowerBodyParts = {}
    for i=BodyPartType.ToIndex(BodyPartType.UpperLeg_L), BodyPartType.ToIndex(BodyPartType.Foot_R) do
        local bodyPart = bodyParts:get(i)
        if bodyPart:getHealth() == 0 then
            table.insert(deadLowerBodyParts, bodyPart)
        end
    end
    return deadLowerBodyParts
end