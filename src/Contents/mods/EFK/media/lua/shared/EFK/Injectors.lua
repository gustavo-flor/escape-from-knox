require "EFK/Util/CharacterUtil"
require "EFK/Util/EventUtil"
require "EFK/Util/BodyDamageUtil"

Injectors = {}

Injectors.items = {
    ["EFK.ZagustinInjector"] = {
        spawnChance = {
            common = 0.025,
            uncommon = 0,
            rare = 0,
            exotic = 0
        },
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
        spawnChance = {
            common = 0.025,
            uncommon = 0,
            rare = 0,
            exotic = 0
        },
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
        spawnChance = {
            common = 0.025,
            uncommon = 0,
            rare = 0,
            exotic = 0
        },
        perform = function(character)
            local function healthRegeneration()
                EFKBodyDamageUtil.addHealthOnDamagedBodyParts(character:getBodyDamage(), 2.4)
            end
            EFKEventUtil.EveryOneMinuteUntil(healthRegeneration, 30)
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
            end
            EFKEventUtil.EveryOneMinuteUntil(onPainkillers, 24)
        end
    },
    ["EFK.MorphineInjector"] = {
        spawnChance = {
            common = 0.025,
            uncommon = 0,
            rare = 0,
            exotic = 0
        },
        perform = function(character)
            EFKCharacterUtil.addHunger(character, 0.1)
            EFKCharacterUtil.addThirst(character, 0.15)
            local function onPainkillers()
                character:getBodyDamage():JustTookPainMeds()
            end
            EFKEventUtil.EveryOneMinuteUntil(onPainkillers, 30)
        end
    }
}
