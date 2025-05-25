require "Items/ProceduralDistributions"
require "EFK/Injectors"
require "EFK/InjuryTreatments"
require "EFK/Medkits"
require "EFK/Drugs"

local function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

local medicalPlacesByRarity = {
    common = {
        "MedicalStorageDrugs",
    },
    uncommon = {
        "ArmyStorageMedical",
        "MedicalClinicDrugs",
        "MedicalClinicOutfit",
        "MedicalClinicTools",
        "MedicalStorageOutfit",
        "MedicalStorageTools",
        "SafehouseMedical",
        "TestingLab",
    },
    rare = {
        "BathroomCabinet",
        "BathroomCounter",
        "BathroomShelf",
    },
    exotic = {
        "PrisonCellRandom",
    }
}

for rarity, places in pairs(medicalPlacesByRarity) do
    for _, place in pairs(places) do
        for itemName, item in pairs(Injectors.items) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
        for itemName, item in pairs(InjuryTreatments.hemostatics) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
        for itemName, item in pairs(InjuryTreatments.bandages) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
        for itemName, item in pairs(InjuryTreatments.surgicalKits) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
        for itemName, item in pairs(Medkits.items) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
        for itemName, item in pairs(Drugs.painkillers) do
            setProceduralDistribution(place, itemName, item.spawnChance[rarity] or 0)
        end
    end
end
