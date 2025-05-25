require "TimedActions/ISBaseTimedAction"
require "EFK/InjuryTreatments"

EFKApplyHemostatic = ISBaseTimedAction:derive("EFKApplyHemostatic")

function EFKApplyHemostatic:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKApplyHemostatic:waitToStart()
    return false
end

function EFKApplyHemostatic:update()
    self.item:setJobDelta(self:getJobDelta())
    local jobType = getText("ContextMenu_Hemostatic")
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, self, jobType, { bandage = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKApplyHemostatic:start()
    self:setActionAnim(CharacterActionAnims.Bandage)
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart))
    self:setOverrideHandModels(nil, nil)
    self.item:setJobType(getText("ContextMenu_Apply_Hemostatic"))
    self.item:setJobDelta(0.0)
end

function EFKApplyHemostatic:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function EFKApplyHemostatic:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50)
    end
    if self.bodyPart:isGetBandageXp() then
        self.character:getXp():AddXP(Perks.Doctor, 5)
    end
    self.bodyPart:setDeepWoundTime(0)
    self.bodyPart:setDeepWounded(false)
    local usedDelta = 0
    if self.item:IsDrainable() then
        usedDelta = self.item:getUsedDelta() - self.item:getUseDelta()
        self.item:setUsedDelta(usedDelta)
    end
    if usedDelta <= 0 then
        self.character:getInventory():Remove(self.item)
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
end

function EFKApplyHemostatic:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.bodyPart = bodyPart
    o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin)
    o.stopOnRun = true
    o.maxTime = InjuryTreatments.hemostatics[item:getFullType()].useTime
    return o
end
