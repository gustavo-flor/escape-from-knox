require "TimedActions/ISBaseTimedAction"
require "EFK/InjuryTreatments"

EFKUseSplint = ISBaseTimedAction:derive("EFKUseSplint")

function EFKUseSplint:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKUseSplint:waitToStart()
    return false
end

function EFKUseSplint:update()
    self.item:setJobDelta(self:getJobDelta())
    local jobType = getText("ContextMenu_Splint")
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, self, jobType, { bandage = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKUseSplint:start()
    self:setActionAnim(CharacterActionAnims.Bandage)
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart))
    self:setOverrideHandModels(nil, nil)
    self.item:setJobType(getText("ContextMenu_Use_Splint"))
    self.item:setJobDelta(0.0)
end

function EFKUseSplint:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function EFKUseSplint:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    if self.bodyPart:isGetSplintXp() then
        self.character:getXp():AddXP(Perks.Doctor, 15);
    end
    self.bodyPart:setFractureTime(0)
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

function EFKUseSplint:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.bodyPart = bodyPart
    o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin)
    o.stopOnRun = true
    o.maxTime = InjuryTreatments.splints[item:getFullType()].useTime
    return o
end
