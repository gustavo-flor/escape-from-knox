require 'Items/ProceduralDistributions'

function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

setProceduralDistribution("ArmyStorageMedical", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("ArmyStorageMedical", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("ArmyStorageMedical", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("BathroomCabinet", "EFK.EsmarchTourniquet", 4)
setProceduralDistribution("BathroomCabinet", "EFK.HemostaticTourniquet", 4)
setProceduralDistribution("BathroomCabinet", "EFK.HemostaticApplicator", 4)

setProceduralDistribution("BathroomCounter", "EFK.EsmarchTourniquet", 4)
setProceduralDistribution("BathroomCounter", "EFK.HemostaticTourniquet", 4)
setProceduralDistribution("BathroomCounter", "EFK.HemostaticApplicator", 4)

setProceduralDistribution("BathroomShelf", "EFK.EsmarchTourniquet", 4)
setProceduralDistribution("BathroomShelf", "EFK.HemostaticTourniquet", 4)
setProceduralDistribution("BathroomShelf", "EFK.HemostaticApplicator", 4)

setProceduralDistribution("MedicalClinicDrugs", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("MedicalClinicDrugs", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("MedicalClinicDrugs", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("MedicalClinicOutfit", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("MedicalClinicOutfit", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("MedicalClinicOutfit", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("MedicalClinicTools", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("MedicalClinicTools", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("MedicalClinicTools", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("MedicalStorageDrugs", "EFK.EsmarchTourniquet", 16)
setProceduralDistribution("MedicalStorageDrugs", "EFK.HemostaticTourniquet", 16)
setProceduralDistribution("MedicalStorageDrugs", "EFK.HemostaticApplicator", 16)

setProceduralDistribution("MedicalStorageOutfit", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("MedicalStorageOutfit", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("MedicalStorageOutfit", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("MedicalStorageTools", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("MedicalStorageTools", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("MedicalStorageTools", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("PrisonCellRandom", "EFK.EsmarchTourniquet", 0.16)
setProceduralDistribution("PrisonCellRandom", "EFK.HemostaticTourniquet", 0.16)
setProceduralDistribution("PrisonCellRandom", "EFK.HemostaticApplicator", 0.16)

setProceduralDistribution("SafehouseMedical", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("SafehouseMedical", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("SafehouseMedical", "EFK.HemostaticApplicator", 8)

setProceduralDistribution("TestingLab", "EFK.EsmarchTourniquet", 8)
setProceduralDistribution("TestingLab", "EFK.HemostaticTourniquet", 8)
setProceduralDistribution("TestingLab", "EFK.HemostaticApplicator", 8)
