require "TimedActions/EFKApplyHemostatic"
require "TimedActions/EFKUseMedkit"
require "TimedActions/EFKSurgery"

-- hemostatics

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
        local option = context:addOption(getText("ContextMenu_Apply_Hemostatic"), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)
        for _,bodyPart in ipairs(heavyBleedingBodyParts) do
            local label = BodyPartType.getDisplayName(bodyPart:getType())
            subMenu:addOption(label, player, queueApplyHemostatic, item, bodyPart)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addApplyHemostaticOption)

-- medkits

local function queueUseMedkit(player, item, bodyPart)
    ISTimedActionQueue.add(EFKUseMedkit:new(player, item, bodyPart))
end

local function addUseMedkitOption(playerId, context, items)
    local hasMedkit = false
    local medkitItems = {}
    for _,item in ipairs(items) do
        if instanceof(item, "InventoryItem") and item:hasTag("Medkit") then
            hasMedkit = true
            table.insert(medkitItems, item)
        end
    end

    if not hasMedkit then 
        return 
    end

    local player = getSpecificPlayer(playerId)
    local bodyParts = player:getBodyDamage():getBodyParts()
    local maxHealth = 100
    local hasDamage = false
    local damagedBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        local health = bodyPart:getHealth()
        if health > 0 and health < maxHealth then
            hasDamage = true
            table.insert(damagedBodyParts, bodyPart)
        end
    end

    if not hasDamage then 
        return 
    end

    for _,item in ipairs(medkitItems) do
        local option = context:addOption(getText("ContextMenu_Apply_Medkit"), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)
        for _,bodyPart in ipairs(damagedBodyParts) do
            local label = BodyPartType.getDisplayName(bodyPart:getType())
            subMenu:addOption(label, player, queueUseMedkit, item, bodyPart)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addUseMedkitOption)

-- surgical kits

local function queueSurgery(player, item, bodyPart)
    ISTimedActionQueue.add(EFKSurgery:new(player, item, bodyPart))
end

local function addSurgeryOption(playerId, context, items)
    local hasSurgicalKit = false
    local surgicalKitItems = {}
    for _,item in ipairs(items) do
        if instanceof(item, "InventoryItem") and item:hasTag("SurgicalKit") then
            hasSurgicalKit = true
            table.insert(surgicalKitItems, item)
        end
    end

    if not hasSurgicalKit then 
        return 
    end

    local player = getSpecificPlayer(playerId)
    local bodyParts = player:getBodyDamage():getBodyParts()
    local hasDeadPart = false
    local deadBodyParts = {}
    for i=0, BodyPartType.ToIndex(BodyPartType.MAX)-1 do
        local bodyPart = bodyParts:get(i)
        local health = bodyPart:getHealth()
        if bodyPart:getHealth() == 0 then
            hasDeadPart = true
            table.insert(deadBodyParts, bodyPart)
        end
    end

    if not hasDeadPart then 
        return 
    end

    for _,item in ipairs(surgicalKitItems) do
        local option = context:addOption(getText("ContextMenu_Surgery"), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)
        for _,bodyPart in ipairs(deadBodyParts) do
            local label = BodyPartType.getDisplayName(bodyPart:getType())
            subMenu:addOption(label, player, queueSurgery, item, bodyPart)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addSurgeryOption)

