require "TimedActions/EFKApplyInjector"

local function QueueApplyInjector(player, item)
    ISTimedActionQueue.add(EFKApplyInjector:new(player, item))
end

local function AddApplyOption(playerId, context, items)
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
        local option = context:addOption("Apply " .. item:getName(), player, QueueApplyHemostatic, item)
    end
end

Events.OnFillInventoryObjectContextMenu.Add(AddApplyOption)
