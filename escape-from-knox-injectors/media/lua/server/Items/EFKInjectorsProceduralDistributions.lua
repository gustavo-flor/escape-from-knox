require 'Items/ProceduralDistributions'

function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

setProceduralDistribution("ArmyStorageMedical", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalClinicDrugs", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalClinicOutfit", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalClinicTools", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalStorageDrugs", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalStorageOutfit", "EFK.Propital", 0.10)

setProceduralDistribution("MedicalStorageTools", "EFK.Propital", 0.10)

setProceduralDistribution("SafehouseMedical", "EFK.Propital", 0.10)

setProceduralDistribution("TestingLab", "EFK.Propital", 0.10)
