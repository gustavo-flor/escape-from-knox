Injectors = {}

Injectors.items = {
    ["EFK.ZagustinInjector"] = {
        spawnChance = 0.5,
        perform = function(character)
            local bodyParts = character:getBodyDamage():getBodyParts()
            for i=0, bodyParts:size()-1 do
                local bodyPart = bodyParts:get(i)
                if bodyPart:bleeding() then
                    bodyPart:setBleedingTime(0)
                end
                if bodyPart:deepWounded() then
                    bodyPart:setDeepWoundTime(0)
                    bodyPart:setDeepWounded(false)
                end
            end
        end
    },
    ["EFK.SJ1Injector"] = {
        spawnChance = 0.5,
        perform = function(character)
            local stats = character:getStats()
            stats:setStress(stats:getStress() - 0.2)
            if stats:getStress() < 0 then
                stats:setStress(0)
            end
            stats:setFatigue(stats:getFatigue() - 0.2)
            if stats:getFatigue() < 0 then
                stats:setFatigue(0)
            end
            stats:setEndurance(stats:getEndurance() + 0.2)
        end
    },
    ["EFK.PropitalInjector"] = {
        spawnChance = 0.5,
        perform = function(character)
            -- health regeneration
            local regenMaxDuration = 30
            local regenDuration = 0
            local regenAmount = 2.4
            local function healthRegeneration()
                local heal = regenAmount
                character:getBodyDamage():AddGeneralHealth(heal)
                regenDuration = regenDuration + 1
                if regenDuration >= regenMaxDuration then
                    Events.EveryOneMinute.Remove(healthRegeneration)
                    regenDuration = 0
                end
            end
            Events.EveryOneMinute.Add(healthRegeneration)
        
            -- on painkillers
            local painkillersMaxDuration = 24
            local painkillersDuration = 0
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
                painkillersDuration = painkillersDuration + 1
                if painkillersDuration >= painkillersMaxDuration then
                    Events.EveryOneMinute.Remove(onPainkillers)
                    painkillersDuration = 0
                end
            end
            Events.EveryOneMinute.Add(onPainkillers)
        end
    },
    ["EFK.MorphineInjector"] = {
        spawnChance = 0.5,
        perform = function(character)        
            -- on painkillers
            local painkillersMaxDuration = 30
            local painkillersDuration = 0
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
                painkillersDuration = painkillersDuration + 1
                if painkillersDuration >= painkillersMaxDuration then
                    Events.EveryOneMinute.Remove(onPainkillers)
                    painkillersDuration = 0
                end
            end
            Events.EveryOneMinute.Add(onPainkillers)
        end
    }
}
