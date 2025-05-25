require "EFK/TimedActions/EFKApplyInjector"
require "EFK/TimedActions/EFKSurgery"
require "EFK/TimedActions/EFKUseSplint"
require "EFK/Util/ItemUtil"
require "EFK/Util/BodyDamageUtil"

-- injectors

local function queueApplyInjector(player, item)
    ISTimedActionQueue.add(EFKApplyInjector:new(player, item))
end

local function addApplyInjectorOption(playerId, context, items)
    local hasInjector = false
    local injectorItems = {}
    for _,item in ipairs(items) do
        if instanceof(item, "InventoryItem") and item:hasTag("Injector") then
            hasInjector = true
            table.insert(injectorItems, item)
        end
    end

    if not hasInjector then 
        return 
    end

    local player = getSpecificPlayer(playerId)

    for _,item in ipairs(injectorItems) do
        local option = context:addOption(getText("ContextMenu_Apply_Injector"), player, queueApplyInjector, item)
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addApplyInjectorOption)

-- hemostatics

local function queueApplyHemostatic(player, item, bodyPart)
    ISTimedActionQueue.add(EFKApplyHemostatic:new(player, item, bodyPart))
end

local function addApplyHemostaticOption(playerId, context, items)
    local hemostaticItems = EFKItemUtil.getInventoryItemsByTag(items, "Hemostatic")
    if #hemostaticItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local heavyBleedingBodyParts = EFKBodyDamageUtil.getHeavyBleedingBodyParts(player:getBodyDamage())
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
    local medkitItems = EFKItemUtil.getInventoryItemsByTag(items, "Medkit")
    if #medkitItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local damagedBodyParts = EFKBodyDamageUtil.getDamagedBodyParts(player:getBodyDamage())
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
    local surgicalKitItems = EFKItemUtil.getInventoryItemsByTag(items, "SurgicalKit")
    if #surgicalKitItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local deadBodyParts = EFKBodyDamageUtil.getDeadBodyParts(player:getBodyDamage())
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
    local splintItems = EFKItemUtil.getInventoryItemsByTag(items, "Splint")
    if #splintItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    local fracturedBodyParts = EFKBodyDamageUtil.getFracturedBodyParts(player:getBodyDamage())
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

-- painkillers

local function queueUsePainkiller(player, item, bodyPart)
    ISTimedActionQueue.add(EFKUsePainkiller:new(player, item, bodyPart))
end

local function addUsePainkillerOption(playerId, context, items)
    local painkillerItems = EFKItemUtil.getInventoryItemsByTag(items, "Painkiller")
    if #painkillerItems == 0 then 
        return 
    end
    local player = getSpecificPlayer(playerId)
    for _,item in ipairs(painkillerItems) do
        context:addOption(getText("ContextMenu_Use_Painkiller"), player, queueUsePainkiller, item)
    end
end

Events.OnFillInventoryObjectContextMenu.Add(addUsePainkillerOption)
