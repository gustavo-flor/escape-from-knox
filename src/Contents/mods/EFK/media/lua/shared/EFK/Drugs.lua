Drugs = {}

local ticksPerSecond = 60

Drugs.painkillers = {
    ["EFK.AnalginPainkillers"] = {
        useTime = 3 * ticksPerSecond,
        duration = 9,
        spawnChance = {
            common = 10,
            uncommon = 5,
            rare = 3,
            exotic = 0.1
        }
    },
    ["EFK.AugmentinAntibioticPills"] = {
        useTime = 5 * ticksPerSecond,
        duration = 15,
        spawnChance = {
            common = 10,
            uncommon = 5,
            rare = 3,
            exotic = 0.1
        }
    },
    ["EFK.IbuprofenPainkillers"] = {
        useTime = 5 * ticksPerSecond,
        duration = 29,
        spawnChance = {
            common = 5,
            uncommon = 2.5,
            rare = 1.5,
            exotic = 0.05
        }
    },
    ["EFK.GoldenStarBalm"] = {
        useTime = 7 * ticksPerSecond,
        duration = 37,
        spawnChance = {
            common = 2.5,
            uncommon = 1.25,
            rare = 0.75,
            exotic = 0.025
        }
    }
}
