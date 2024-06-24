require "Util/CharacterUtil"
require "Util/EventUtil"

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
            local function healthRegeneration()
                character:getBodyDamage():AddGeneralHealth(2.4)
            end
            EventUtil.EveryOneMinuteUntil(healthRegeneration, 30)
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
            end
            EventUtil.EveryOneMinuteUntil(onPainkillers, 24)
        end
    },
    ["EFK.MorphineInjector"] = {
        spawnChance = 0.5,
        perform = function(character)
            CharacterUtil.addHunger(character, 0.1)
            CharacterUtil.addThirst(character, 0.15)
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
            end
            EventUtil.EveryOneMinuteUntil(onPainkillers, 30)
        end
    }
}
