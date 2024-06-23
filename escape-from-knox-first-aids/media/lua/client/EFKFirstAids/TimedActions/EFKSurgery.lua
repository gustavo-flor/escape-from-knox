require "TimedActions/ISBaseTimedAction"
require "EFKFirstAids/InjuryTreatments"

EFKSurgery = ISBaseTimedAction:derive("EFKSurgery")

function EFKSurgery:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKSurgery:waitToStart()
    return false
end

function EFKSurgery:update()
    self.item:setJobDelta(self:getJobDelta())
    local jobType = getText("ContextMenu_Surgical_Kit")
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, self, jobType, { bandage = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKSurgery:start()
    self:setActionAnim(CharacterActionAnims.Bandage)
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart))
    self:setOverrideHandModels(nil, nil)
    self.item:setJobType(getText("ContextMenu_Surgery"))
    self.item:setJobDelta(0.0)
end

function EFKSurgery:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function EFKSurgery:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50)
    end
    if self.bodyPart:isGetBandageXp() then
        self.character:getXp():AddXP(Perks.Doctor, 5)
    end
    self.bodyPart:AddHealth(1)
    local usedDelta = self.item:getUsedDelta() - self.item:getUseDelta()
    self.item:setUsedDelta(usedDelta)
    if usedDelta <= 0 then
        self.character:getInventory():Remove(self.item)
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
end

function EFKSurgery:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.bodyPart = bodyPart
    o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin)
    o.stopOnRun = true
    o.maxTime = InjuryTreatments.surgicalKits[item:getFullType()].useTime
    return o
end
