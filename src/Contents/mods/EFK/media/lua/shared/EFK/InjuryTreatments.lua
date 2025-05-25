InjuryTreatments = {}

local ticksPerSecond = 60

InjuryTreatments.hemostatics = {
    ["EFK.EsmarchTourniquet"] = {
        useTime = 5 * ticksPerSecond,
        spawnChance = {
            common = 10,
            uncommon = 5,
            rare = 3,
            exotic = 0.1
        }
    },
    ["EFK.HemostaticTourniquet"] = {
        useTime = 3 * ticksPerSecond,
        spawnChance = {
            common = 10,
            uncommon = 5,
            rare = 3,
            exotic = 0.1
        }
    },
    ["EFK.HemostaticApplicator"] = {
        useTime = 3 * ticksPerSecond,
        spawnChance = {
            common = 10,
            uncommon = 5,
            rare = 3,
            exotic = 0.1
        }
    }
}

InjuryTreatments.splints = {
    ["EFK.ImmobilizingSplint"] = {
        useTime = 5 * ticksPerSecond,
        spawnChance = {}
    },
    ["EFK.AluminumSplint"] = {
        useTime = 3 * ticksPerSecond,
        spawnChance = {}
    }
}

InjuryTreatments.bandages = {
    ["EFK.AsepticBandage"] = {
        spawnChance = {}
    },
    ["EFK.ArmyBandage"] = {
        spawnChance = {}
    }
}

InjuryTreatments.painkillers = {
    ["EFK.AnalginPainkillers"] = {
        spawnChance = {}
    },
    ["EFK.AugmentinAntibioticPills"] = {
        spawnChance = {}
    },
    ["EFK.IbuprofenPainkillers"] = {
        spawnChance = {}
    },
    ["EFK.GoldenStarBalm"] = {
        spawnChance = {}
    }
}

InjuryTreatments.surgicalKits = {
    ["EFK.CMSSurgicalKit"] = {
        useTime = 16 * ticksPerSecond,
        spawnChance = {}
    },
    ["EFK.Surv12FieldSurgicalKit"] = {
        useTime = 20 * ticksPerSecond,
        spawnChance = {}
    }
}
