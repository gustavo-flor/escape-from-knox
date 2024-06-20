require "TimedActions/ISBaseTimedAction"

EFKApplyInjector = ISBaseTimedAction:derive("EFKApplyInjector")

function EFKApplyInjector:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKApplyInjector:waitToStart()
    return false
end

function EFKApplyInjector:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKApplyInjector:start()
    self:setActionAnim(CharacterActionAnims.Craft)
    self:setOverrideHandModels(nil, self.item)
    self.item:setJobType(getText("ContextMenu_Apply_Injector"))
    self.item:setJobDelta(0.0)
end

function EFKApplyInjector:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

local injectorAppliers = {}

injectorAppliers["EFK.Propital"] = function(character)
    -- health regeneration
    local regenMaxDuration = 30
    local regenDuration = 0
    local totalRegenAmount = 2.4
    local function healthRegeneration()
        character:getBodyDamage():AddGeneralHealth(totalRegenAmount)
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
        local bodyDamage = character:getBodyDamage()
        bodyDamage:JustTookPainMeds()
        painkillersDuration = painkillersDuration + 1
        if painkillersDuration >= painkillersMaxDuration then
            Events.EveryOneMinute.Remove(onPainkillers)
            painkillersDuration = 0
        end
    end
    Events.EveryOneMinute.Add(onPainkillers)
end

injectorAppliers["EFK.Zagustin"] = function(character)
    local bodyParts = character:getBodyDamage():getBodyParts()
    for i=0, bodyParts:size()-1 do
        local bodyPart = bodyParts:get(i)
        print(bodyPart:getHealth())
        if bodyPart:bleeding() then
            bodyPart:setBleedingTime(0)
        end
        if bodyPart:deepWounded() then
            bodyPart:setDeepWoundTime(0)
            bodyPart:setDeepWounded(false)
        end
    end
end

injectorAppliers["EFK.SJ1"] = function(character)
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

function EFKApplyInjector:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    self.character:getXp():AddXP(Perks.Doctor, 5)
    injectorAppliers[self.item:getFullType()](self.character)
    self.character:getInventory():Remove(self.item)
end

function EFKApplyInjector:new(character, item)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = 120
    return o
end
