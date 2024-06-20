require "TimedActions/ISBaseTimedAction"

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

local healthProportion = 4.4
local maxHealth = 100
local medkitMaxHealPerUse = {
    ["EFK.AI2Medkit"] = 50,
    ["EFK.CarFirstAidKit"] = 70,
    ["EFK.SalewaFirstAidKit"] = 85,
    ["EFK.IndividualFirstAidKit"] = 50,
    ["EFK.TacticalIndividualFirstAidKit"] = 60,
    ["EFK.GrizzlyMedicalKit"] = 175
}

function EFKUseMedkit:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50)
    end
    if self.bodyPart:isGetBandageXp() then
        self.character:getXp():AddXP(Perks.Doctor, 5)
    end
    local maxHealPerUse = medkitMaxHealPerUse[self.item:getFullType()]
    local regenAmount = math.min(maxHealPerUse / healthProportion, maxHealth - self.bodyPart:getHealth())
    print(regenAmount)
    self.bodyPart:AddHealth(regenAmount)
    local usedDelta = self.item:getUsedDelta() - (self.item:getUseDelta() * regenAmount * healthProportion)
    self.item:setUsedDelta(usedDelta)
    if usedDelta <= 0 then
        self.character:getInventory():Remove(self.item)
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.character, self.bodyPart, nil, nil, nil)
end

local ticksPerSecond = 60
local medkitMaxTimes = {
    ["EFK.AI2Medkit"] = 2 * ticksPerSecond,
    ["EFK.CarFirstAidKit"] = 3 * ticksPerSecond,
    ["EFK.SalewaFirstAidKit"] = 3 * ticksPerSecond,
    ["EFK.IndividualFirstAidKit"] = 3 * ticksPerSecond,
    ["EFK.TacticalIndividualFirstAidKit"] = 3 * ticksPerSecond,
    ["EFK.GrizzlyMedicalKit"] = 5 * ticksPerSecond
}

function EFKUseMedkit:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.bodyPart = bodyPart
    o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin)
    o.stopOnRun = true
    o.maxTime = medkitMaxTimes[item:getFullType()]
    return o
end
