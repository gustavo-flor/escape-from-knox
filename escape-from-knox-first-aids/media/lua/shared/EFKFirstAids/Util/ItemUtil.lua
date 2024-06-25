EFKFirstAidsItemUtil = {}

function EFKFirstAidsItemUtil.getInventoryItemsByTag(items, tag)
    local inventoryItems = {}
    for _,item in ipairs(items) do
        if instanceof(item, "InventoryItem") and item:hasTag(tag) then
            table.insert(inventoryItems, item)
        end
    end
    return inventoryItems
end
