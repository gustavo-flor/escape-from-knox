require "TimedActions/EFKApplyHemostatic"

local function queueApplyHemostatic(player, item, bodyPart)
    ISTimedActionQueue.add(EFKApplyHemostatic:new(player, item, bodyPart))
end

local function addApplyHemostaticOption(playerId, context, items)
    local hasHemostatic = false
    local hemostaticItems = {}
    for _,item in ipairs(items) do
        if instanceof(item, "InventoryItem") and item:hasTag("Hemostatic") then
            hasHemostatic = true
            table.insert(hemostaticItems, item)
        end
    end

    if not hasHemostatic then 
        return 
    end

    local player = getSpecificPlayer(playerId)
    local bodyParts = player:getBodyDamage():getBodyParts()

    local hasHeavyBleeding = false
    local heavyBleedingBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        if bodyPart:bleeding() and bodyPart:deepWounded() then
            hasHeavyBleeding = true
            table.insert(heavyBleedingBodyParts, bodyPart)
        end
    end

    if not hasHeavyBleeding then 
        return 
    end

    for _,item in ipairs(hemostaticItems) do
        local option = context:addOption("Apply " .. item:getName(), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)
        for _,bodyPart in ipairs(heavyBleedingBodyParts) do
            local label = BodyPartType.getDisplayName(bodyPart:getType())
            subMenu:addOption(label, player, queueApplyHemostatic, item, bodyPart)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addApplyHemostaticOption)
