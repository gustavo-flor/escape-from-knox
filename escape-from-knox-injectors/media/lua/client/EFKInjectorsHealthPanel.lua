require "TimedActions/EFKApplyInjector"

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
        local option = context:addOption("Apply " .. item:getName(), player, queueApplyInjector, item)
    end
end

Events.OnFillInventoryObjectContextMenu.Add(AddApplyInjectorOption)
