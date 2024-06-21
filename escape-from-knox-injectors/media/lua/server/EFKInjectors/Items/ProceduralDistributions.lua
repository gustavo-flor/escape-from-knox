require "Items/ProceduralDistributions"

function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

local spawnChanceByItem = {
    ["EFK.PropitalInjector"] = 0.05,
    ["EFK.ZagustinInjector"] = 0.05,
    ["EFK.SJ1Injector"] = 0.05
}

for item, spawnChance in pairs(spawnChanceByItem) do
    setProceduralDistribution("ArmyStorageMedical", item, spawnChance)
    setProceduralDistribution("MedicalClinicDrugs", item, spawnChance)
    setProceduralDistribution("MedicalClinicOutfit", item, spawnChance)
    setProceduralDistribution("MedicalClinicTools", item, spawnChance)
    setProceduralDistribution("MedicalStorageDrugs", item, spawnChance)
    setProceduralDistribution("MedicalStorageOutfit", item, spawnChance)
    setProceduralDistribution("MedicalStorageTools", item, spawnChance)
    setProceduralDistribution("SafehouseMedical", item, spawnChance)
    setProceduralDistribution("TestingLab", item, spawnChance)
end
