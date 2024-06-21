local function isVital(bodyPart)
    return bodyPart:getType() == BodyPartType.Head 
        or bodyPart:getType() == BodyPartType.Neck 
        or bodyPart:getType() == BodyPartType.Torso_Upper
end

local function checkVitalBodyParts(player)
    local bodyDamage = player:getBodyDamage()
    local bodyParts = bodyDamage:getBodyParts()
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        if isVital(bodyPart) and bodyPart:getHealth() == 0 then
            player:setHealth(0);
        end
    end
end

Events.OnPlayerUpdate.Add(checkVitalBodyParts)
