require "EFKFirstAids/TimedActions/EFKApplyHemostatic"
require "EFKFirstAids/TimedActions/EFKUseMedkit"
require "EFKFirstAids/TimedActions/EFKSurgery"
require "EFKFirstAids/TimedActions/EFKUseSplint"
require "EFKFirstAids/Util/ItemUtil"
require "EFKFirstAids/Util/BodyDamageUtil"

-- hemostatics

local function queueApplyHemostatic(player, item, bodyPart)
    ISTimedActionQueue.add(EFKApplyHemostatic:new(player, item, bodyPart))
end

local function addApplyHemostaticOption(playerId, context, items)
    local hemostaticItems = EFKFirstAidsItemUtil.getInventoryItemsByTag(items, "Hemostatic")
    if #hemostaticItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local heavyBleedingBodyParts = EFKFirstAidsBodyDamageUtil.getHeavyBleedingBodyParts(player:getBodyDamage())
    if #heavyBleedingBodyParts == 0 then 
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
    local medkitItems = EFKFirstAidsItemUtil.getInventoryItemsByTag(items, "Medkit")
    if #medkitItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local damagedBodyParts = EFKFirstAidsBodyDamageUtil.getDamagedBodyParts(player:getBodyDamage())
    if #damagedBodyParts == 0 then 
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
    local surgicalKitItems = EFKFirstAidsItemUtil.getInventoryItemsByTag(items, "SurgicalKit")
    if #surgicalKitItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local deadBodyParts = EFKFirstAidsBodyDamageUtil.getDeadBodyParts(player:getBodyDamage())
    if #deadBodyParts == 0 then 
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

-- splints

local function queueUseSplint(player, item, bodyPart)
    ISTimedActionQueue.add(EFKUseSplint:new(player, item, bodyPart))
end

local function addUseSplintOption(playerId, context, items)
    local splintItems = EFKFirstAidsItemUtil.getInventoryItemsByTag(items, "Splint")
    if #splintItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local fracturedBodyParts = EFKFirstAidsBodyDamageUtil.getFracturedBodyParts(player:getBodyDamage())
    if #fracturedBodyParts == 0 then 
        return 
    end
    for _,item in ipairs(splintItems) do
        local option = context:addOption(getText("ContextMenu_Use_Splint"), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)
        for _,bodyPart in ipairs(fracturedBodyParts) do
            local label = BodyPartType.getDisplayName(bodyPart:getType())
            subMenu:addOption(label, player, queueUseSplint, item, bodyPart)
        end
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addUseSplintOption)
