require "TimedActions/ISBaseTimedAction"
require "EFKFirstAids/Medkits"

EFKUseMedkit = ISBaseTimedAction:derive("EFKUseMedkit")

function EFKUseMedkit:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKUseMedkit:waitToStart()
    return false
end

function EFKUseMedkit:update()
    self.item:setJobDelta(self:getJobDelta())
    local jobType = getText("ContextMenu_Medkit")
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, self, jobType, { bandage = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKUseMedkit:start()
    self:setActionAnim(CharacterActionAnims.Bandage)
    self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart))
    self:setOverrideHandModels(nil, nil)
    self.item:setJobType(getText("ContextMenu_Use_Medkit"))
    self.item:setJobDelta(0.0)
end

function EFKUseMedkit:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

local knoxHealth = 440
local zomboidHealth = 1700
local healthProportion = knoxHealth / zomboidHealth

function EFKUseMedkit:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50)
    end
    if self.bodyPart:isGetBandageXp() then
        self.character:getXp():AddXP(Perks.Doctor, 5)
    end
    local maxHealPerUse = self.medkit.maxHealPerUse / healthProportion
    local missingLife = 100 - self.bodyPart:getHealth()
    local regenAmount = math.min(maxHealPerUse, missingLife)
    self.bodyPart:AddHealth(regenAmount)
    local usedDelta = self.item:getUsedDelta() - (self.item:getUseDelta() * regenAmount * healthProportion)
    self.item:setUsedDelta(usedDelta)
    if usedDelta <= 0 then
        self.character:getInventory():Remove(self.item)
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
end

function EFKUseMedkit:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.medkit = Medkits.items[item:getFullType()]
    o.bodyPart = bodyPart
    o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin)
    o.stopOnRun = true
    o.maxTime = o.medkit.useTime
    return o
end
