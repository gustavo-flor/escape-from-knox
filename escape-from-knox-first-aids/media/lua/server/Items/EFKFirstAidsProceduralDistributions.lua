require 'Items/ProceduralDistributions'

function setProceduralDistribution(placeName, itemName, spawnChance)
    local places = ProceduralDistributions["list"]
    table.insert(places[placeName].items, itemName)
    table.insert(places[placeName].items, spawnChance)    
end

setProceduralDistribution("ArmyStorageMedical", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("ArmyStorageMedical", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("ArmyStorageMedical", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("BathroomCabinet", "EFK.EsmarchTourniquet", 3)
setProceduralDistribution("BathroomCabinet", "EFK.HemostaticTourniquet", 3)
setProceduralDistribution("BathroomCabinet", "EFK.HemostaticApplicator", 3)

setProceduralDistribution("BathroomCounter", "EFK.EsmarchTourniquet", 3)
setProceduralDistribution("BathroomCounter", "EFK.HemostaticTourniquet", 3)
setProceduralDistribution("BathroomCounter", "EFK.HemostaticApplicator", 3)

setProceduralDistribution("BathroomShelf", "EFK.EsmarchTourniquet", 3)
setProceduralDistribution("BathroomShelf", "EFK.HemostaticTourniquet", 3)
setProceduralDistribution("BathroomShelf", "EFK.HemostaticApplicator", 3)

setProceduralDistribution("MedicalClinicDrugs", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("MedicalClinicDrugs", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("MedicalClinicDrugs", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("MedicalClinicOutfit", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("MedicalClinicOutfit", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("MedicalClinicOutfit", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("MedicalClinicTools", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("MedicalClinicTools", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("MedicalClinicTools", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("MedicalStorageDrugs", "EFK.EsmarchTourniquet", 10)
setProceduralDistribution("MedicalStorageDrugs", "EFK.HemostaticTourniquet", 10)
setProceduralDistribution("MedicalStorageDrugs", "EFK.HemostaticApplicator", 10)

setProceduralDistribution("MedicalStorageOutfit", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("MedicalStorageOutfit", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("MedicalStorageOutfit", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("MedicalStorageTools", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("MedicalStorageTools", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("MedicalStorageTools", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("PrisonCellRandom", "EFK.EsmarchTourniquet", 0.10)
setProceduralDistribution("PrisonCellRandom", "EFK.HemostaticTourniquet", 0.10)
setProceduralDistribution("PrisonCellRandom", "EFK.HemostaticApplicator", 0.10)

setProceduralDistribution("SafehouseMedical", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("SafehouseMedical", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("SafehouseMedical", "EFK.HemostaticApplicator", 5)

setProceduralDistribution("TestingLab", "EFK.EsmarchTourniquet", 5)
setProceduralDistribution("TestingLab", "EFK.HemostaticTourniquet", 5)
setProceduralDistribution("TestingLab", "EFK.HemostaticApplicator", 5)
