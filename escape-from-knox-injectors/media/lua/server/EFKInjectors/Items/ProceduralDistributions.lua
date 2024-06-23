require "Items/ProceduralDistributions"
require "EFKInjectors/Injectors"

local function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

for itemName, item in pairs(Injectors.items) do
    setProceduralDistribution("ArmyStorageMedical", itemName, item.spawnChance)
    setProceduralDistribution("MedicalClinicDrugs", itemName, item.spawnChance)
    setProceduralDistribution("MedicalClinicOutfit", itemName, item.spawnChance)
    setProceduralDistribution("MedicalClinicTools", itemName, item.spawnChance)
    setProceduralDistribution("MedicalStorageDrugs", itemName, item.spawnChance)
    setProceduralDistribution("MedicalStorageOutfit", itemName, item.spawnChance)
    setProceduralDistribution("MedicalStorageTools", itemName, item.spawnChance)
    setProceduralDistribution("SafehouseMedical", itemName, item.spawnChance)
    setProceduralDistribution("TestingLab", itemName, item.spawnChance)
end
